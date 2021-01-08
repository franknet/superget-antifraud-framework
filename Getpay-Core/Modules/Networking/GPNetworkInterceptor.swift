import Foundation
import Alamofire
import AppAuth

final public class GPNetworkInterceptor: RequestInterceptor {
    
    private var isBearerToken: Bool = true
    
    public init(isBearerToken: Bool?) {
        if let isBearerToken = isBearerToken {
            self.isBearerToken = isBearerToken
        }
    }
    
    // MARK: - RequestAdapter
    
    public func adapt(_ urlRequest: URLRequest,
                      for session: Session,
                      completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        if let authState = AuthStateManager.loadStateFromKeychain() {
            
            var adaptedRequest = urlRequest
            
            authState.performAction(freshTokens: { [weak self] accessToken, _, error in
                
                guard let self = self else { return }
                
                if let error = error {
                    completion(.failure(error))
                }
                if let token = accessToken {
                    
                    adaptedRequest.headers.add(name: "app-version", value: GNGeneralConfig.shared.appVersion)
                    adaptedRequest.headers.add(name: "device-id", value: GNGeneralConfig.shared.sessionIDTMX)
                    adaptedRequest.headers.add(name: "device-os", value: "iOS")
                    
                    if self.isBearerToken {
                       adaptedRequest.headers.add(.authorization(bearerToken: token))
                    }
                    else {
                        adaptedRequest.headers.add(name: "token", value: token)
                    }
                    AuthStateManager.saveAuthStateInKeyChain(authState)
                    
                    completion(.success(adaptedRequest))
                }
            })
        }
    }
}
