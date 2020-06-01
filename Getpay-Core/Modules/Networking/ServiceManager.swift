import Alamofire
import RxSwift
import SwiftKeychainWrapper
import AppAuth

// MARK: Class

open class ServiceManager {
    
    // MARK: Private variables
    
    private let session : Session
    
    private let interceptor: GPNetworkInterceptor
    
    private var isRequiredAuthentication: Bool = true
    
    private var isJsonBody: Bool = false
    
    private var encoding: ParameterEncoding = URLEncoding.default
    
    // MARK: Init
    
    /**
     - `isRequiredAuthentication`: toke is not required on request
     - `isJsonBody`: required when request is a POST / PUT / PATCH
     */
    public init(isRequiredAuthentication: Bool? = nil, isJsonBody: Bool? = nil, isBearerToken: Bool? = nil) {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120
        configuration.httpShouldUsePipelining = true
        
        session = Session(configuration: configuration, startRequestsImmediately: true)
        
        if let isRequiredAuthentication = isRequiredAuthentication {
            self.isRequiredAuthentication = isRequiredAuthentication
        }
        
        if let isJsonBody = isJsonBody {
            self.isJsonBody = isJsonBody
            self.encoding = isJsonBody ? JSONEncoding.default : URLEncoding.default
        }
        
        self.interceptor = GPNetworkInterceptor(isBearerToken: isBearerToken)
    }
    
    // MARK: Private methods
    
    private func getGenericResponse() -> GPResponseError {
        return GPResponseError(status: "", description: "Ocorreu um erro inesperado.", errorCode: "")
    }
    
    // MARK: Public methods
    
    // TODO: Validar se está funcionando
    public func performRequest(route: BaseRequestProtocol, completion: @escaping(GPResponseError?) -> Void) {
        
        let request = session.request(route.path, method: route.method, parameters: route.body, encoding: encoding, headers: route.headers, interceptor: isRequiredAuthentication ? interceptor : nil).validate()
            .responseJSON { response in
                debugPrint(route.headers as Any)
                debugPrint(response)
                
                if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                    completion(nil)
                }
                else {
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
                }
        }
        debugPrint(request)
    }
    
    public func performRequest<T: Codable>(route:BaseRequestProtocol,
                                           completion:@escaping (Result<T, GPResponseError>)->Void){
        
        let request = session.request(route.path, method: route.method, parameters: route.body, encoding: encoding, headers: route.headers, interceptor: isRequiredAuthentication ? interceptor : nil).validate()
            .responseDecodable(completionHandler: { (response: DataResponse<T, AFError>) in
                
                debugPrint(response)
                
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(_):
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
                }
            })
        
        debugPrint( request)
    }
    
    public func performRequest<T:Decodable>(route: BaseRequestProtocol,
                                            decoder: JSONDecoder = JSONDecoder()) -> Observable<T> {
        
        return Observable<T>.create { [session, interceptor, isRequiredAuthentication, encoding] observer in
            
            let request = session.request(route.path, method: route.method, parameters: route.body, encoding: encoding, headers: route.headers, interceptor: isRequiredAuthentication ? interceptor : nil)
                .responseDecodable (decoder: decoder) { (response: AFDataResponse<T>) in
                    
                    debugPrint(response)
                    
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(_):
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
            
            debugPrint(request)
            
            return Disposables.create {
                request.cancel()
            }
            
        }
    }
}

// MARK: GPResponseError

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
        case status, status_code, description, message, error_code, errors, error, host_response_code
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