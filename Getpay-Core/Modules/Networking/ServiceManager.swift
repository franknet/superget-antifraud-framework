import Alamofire
import RxSwift
import SwiftKeychainWrapper
import AppAuth
import TrustKit

// MARK: - Class

open class ServiceManager: SessionDelegate {
    
    // MARK: - Private variables
    
    private var session : Session?
    
    private var interceptor: GPNetworkInterceptor?
    
    private var isRequiredAuthentication: Bool = true
    
    private var isJsonBody: Bool = false
    
    private var encoding: ParameterEncoding = URLEncoding.default
    
    private var environment = GNGeneralConfig.shared.environment
    
    // MARK: - Initializers
    
    /**
     - `isRequiredAuthentication`: toke is not required on request
     - `isJsonBody`: required when request is a POST / PUT / PATCH
     */
    public init(isRequiredAuthentication: Bool? = nil, isJsonBody: Bool? = nil, isBearerToken: Bool? = nil) {
        super.init()
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120
        configuration.httpShouldUsePipelining = true
        
        session = Session.init(configuration: configuration,
                               delegate: self,
                               startRequestsImmediately: true)
        
        if let isRequiredAuthentication = isRequiredAuthentication {
            self.isRequiredAuthentication = isRequiredAuthentication
        }
        
        if let isJsonBody = isJsonBody {
            self.isJsonBody = isJsonBody
            self.encoding = isJsonBody ? JSONEncoding.default : URLEncoding.default
        }
        
        interceptor = GPNetworkInterceptor(isBearerToken: isBearerToken)
        
        if environment == .prod {
            let pinnedDomains: [String: [String]] = [
                Urls.shared.baseURL: [
                    "F5qeWlRODHgf7yswYaG/K3L6Hj6GbMzJwoUjrSDCIkU=",
                    "RVPH5cXAfoy/PbRm46TZq2YOA9VP6gq/ozSIiriQfjE=",
                    "ceqykKitHuAY/32htwXK2GoUhWdb8AYOKIIKuOpm9/U=",
                    "7sa/hZaEzoUzc4cmAy6DAocsvjE6na9pCJvkQ3RPRNA=",
                    "dbazgBbDSniAzBgrcx2R1K+uLA+xL1DUAFB6iVE9fNI="],
                Urls.shared.issuer: [
                    "F5qeWlRODHgf7yswYaG/K3L6Hj6GbMzJwoUjrSDCIkU=",
                    "RVPH5cXAfoy/PbRm46TZq2YOA9VP6gq/ozSIiriQfjE=",
                    "ceqykKitHuAY/32htwXK2GoUhWdb8AYOKIIKuOpm9/U=",
                    "7sa/hZaEzoUzc4cmAy6DAocsvjE6na9pCJvkQ3RPRNA=",
                    "dbazgBbDSniAzBgrcx2R1K+uLA+xL1DUAFB6iVE9fNI="]]
            
            setupSSLPinning(pinnedDomains: pinnedDomains, errorCallback: {})
        }
    }
    
    // MARK: - Private methods
    
    private func getGenericResponse() -> GPResponseError {
        return GPResponseError(status: "",
                               description: "Ocorreu um erro inesperado.",
                               errorCode: "")
    }
    
    private func validateOfflineSession(error: AFError) -> Bool {
        if error.localizedDescription.contains("invalid_grant") {
            offlineUserSessionPost()
            return false
        }
        return true
    }
    
    private func offlineUserSessionPost() {
        NotificationCenter.default.post(name: .offlineUserSession, object: nil)
    }
    
    private func verifyAuthentication() {
        if isRequiredAuthentication && AuthStateManager.loadStateFromKeychain() == nil {
            offlineUserSessionPost()
        }
    }
    
    // MARK: - Public methods
    
    public func performRequest(route: BaseRequestProtocol,
                               completion: @escaping(GPResponseError?) -> Void) {
        
        verifyAuthentication()
        
        let request = session?.request(route.path,
                                       method: route.method,
                                       parameters: route.body,
                                       encoding: encoding,
                                       headers: route.headers,
                                       interceptor: isRequiredAuthentication ? interceptor : nil)
            .validate()
            .responseJSON { response in
                
                debugPrint(response)
                
                guard
                    let statusCode = response.response?.statusCode
                else {
                    completion(self.getGenericResponse())
                    return
                }
                
                if (200 ..< 300).contains(statusCode) {
                    completion(nil)
                    
                } else {
                    if let data = response.data {
                        do {
                            let genericError = try JSONDecoder().decode(GPGenericError.self, from: data)
                            let error = GPResponseError(data: genericError)
                            completion((error))
                        }
                        catch {
                            completion((self.getGenericResponse()))
                        }
                    }
                    else {
                        completion((self.getGenericResponse()))
                    }
                }
            }
        
        debugPrint(request as Any)
    }
    
    public func performRequest<T: Codable>(route:BaseRequestProtocol,
                                           completion:@escaping (Result<T, GPResponseError>) -> Void) {
        
        verifyAuthentication()
        
        let request = session?.request(route.path,
                                       method: route.method,
                                       parameters: route.body,
                                       encoding: encoding,
                                       headers: route.headers,
                                       interceptor: isRequiredAuthentication ? interceptor : nil)
            .validate()
            .responseDecodable(completionHandler: { (response: DataResponse<T, AFError>) in
                
                debugPrint(response)
                
                switch response.result {
                
                case .success(let response):
                    completion(.success(response))
                    
                case .failure(let error):
                    guard self.validateOfflineSession(error: error) == true else { break }
                    
                    if let data = response.data {
                        do {
                            let genericError = try JSONDecoder().decode(GPGenericError.self, from: data)
                            let error = GPResponseError(data: genericError)
                            completion(.failure(error))
                        }
                        catch {
                            completion(.failure(self.getGenericResponse()))
                        }
                    }
                    else {
                        completion(.failure(self.getGenericResponse()))
                    }
                }
            })
        
        debugPrint(request as Any)
    }
    
    public func performRequest<T:Decodable>(route: BaseRequestProtocol,
                                            decoder: JSONDecoder = JSONDecoder()) -> Observable<T> {
        
        verifyAuthentication()
        
        return Observable<T>.create { [session, interceptor, isRequiredAuthentication, encoding] observer in
            
            let request = session?.request(route.path,
                                           method: route.method,
                                           parameters: route.body,
                                           encoding: encoding,
                                           headers: route.headers,
                                           interceptor: isRequiredAuthentication ? interceptor : nil)
                .responseDecodable (decoder: decoder) { (response: AFDataResponse<T>) in
                    
                    debugPrint(response)
                    
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        guard self.validateOfflineSession(error: error) == true else { break }
                        
                        if let data = response.data {
                            do {
                                let genericError = try JSONDecoder().decode(GPGenericError.self, from: data)
                                let error = GPResponseError(data: genericError)
                                observer.onError(error)
                            }
                            catch {
                                observer.onError(self.getGenericResponse())
                            }
                        }
                        observer.onError(self.getGenericResponse())
                    }
                }
            
            debugPrint(request as Any)
            
            return Disposables.create {
                request?.cancel()
            }
        }
    }
}

extension ServiceManager {
    
    // MARK: - Setup SSL
    
    func setupSSLPinning(pinnedDomains: [String: [String]], errorCallback: @escaping () -> Void) {
        
        var domainDict: [String: Any] = [:]
        
        for domain in pinnedDomains.keys {
            
            let url = URL(string: domain)
            let domainUrlString = url?.host ?? ""
            
            if let keyHashes = pinnedDomains[domain] {
                
                domainDict[domainUrlString] = [kTSKPublicKeyHashes: keyHashes,
                                               kTSKIncludeSubdomains: true]
            }
        }
        
        let trustKitConfig = [
            kTSKSwizzleNetworkDelegates: false,
            kTSKEnforcePinning: true,
            kTSKPinnedDomains: domainDict
        ] as [String : Any]
        
        TrustKit.initSharedInstance(withConfiguration:trustKitConfig)
        
        TrustKit.sharedInstance().pinningValidatorCallback = { (result, _, _) in
            
            if result.evaluationResult != .success {
                errorCallback()
            }
        }
    }
    
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        if environment == .prod {
            if TrustKit.sharedInstance().pinningValidator.handle(challenge, completionHandler: completionHandler) == false {
                completionHandler(.performDefaultHandling, nil)
            }
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }
}

// MARK: - GPGenericError

public struct GPGenericError: Decodable, Error {
    public var status: String?
    public var status_code: String?
    public var description: String?
    public var message: String?
    public var host_response_code: String?
    public var error_code: String?
    public var errors: [String]?
    public var error: String?
    
    enum CodingKeys: String, CodingKey {
        case status
        case status_code
        case description
        case message
        case error_code
        case errors
        case error
        case host_response_code
    }
    
    public init(from decoder: Decoder) {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            if let statusInt = try? container.decode(Int.self, forKey: .status) {
                status = String(statusInt)
            }
            else if let statusStr = try? container.decode(String.self, forKey: .status) {
                status = statusStr
            }
            
            status_code = try? container.decode(String.self, forKey: .status_code)
            
            description = try? container.decode(String.self, forKey: .description)
            
            message = try? container.decode(String.self, forKey: .message)
            
            error_code = try? container.decode(String.self, forKey: .error_code)
            
            errors = try? container.decode([String].self, forKey: .errors)
            
            error = try? container.decode(String.self, forKey: .error)
            
            host_response_code = try? container.decode(String.self, forKey: .host_response_code)
            
        } catch {
            return
        }
    }
}

// MARK: - GPResponseError

public struct GPResponseError: Decodable, Error {
    public var status: String = ""
    public var description: String = ""
    public var errorCode: String = ""
    
    public init(data: GPGenericError) {
        
        if let status = data.status {
            self.status = status
        }
        
        if let status = data.status_code {
            self.status = status
        }
        
        if let description = data.description {
            self.description = description
        }
        
        if let description = data.message {
            self.description = description
        }
        
        if let errorCode = data.error_code {
            self.errorCode = errorCode
        }
        
        if let error = data.errors?.first {
            self.errorCode = error
        }
        
        if let error = data.error {
            self.errorCode = error
        }
        
        if let error = data.host_response_code {
            self.errorCode = error
        }
    }
    
    public init(status: String, description: String, errorCode: String) {
        self.status = status
        self.description = description
        self.errorCode = errorCode
    }
}
