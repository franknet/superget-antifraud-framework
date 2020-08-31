import AppAuth

final public class GPNetworkService {
    
    // MARK: - Singleton
    
    public static let shared = GPNetworkService()
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Public methods
    
    public func auth(username: String,
                     password: String,
                     completionHandler: @escaping (String?) -> Void) {
        
        let authUrl = Urls.shared.issuer + "/auth/realms/external/protocol/openid-connect/auth"
        let tokenUrl = Urls.shared.issuer + "/auth/realms/external/protocol/openid-connect/token"
        
        guard let authorizationEndpoint = URL(string: authUrl) else { return }
        guard let tokenEndpoint = URL(string: tokenUrl) else { return }
        
        let configuration = OIDServiceConfiguration(authorizationEndpoint: authorizationEndpoint,
                                                    tokenEndpoint: tokenEndpoint)
        
        let request = OIDTokenRequest(configuration: configuration,
                                      grantType: "password",
                                      authorizationCode: nil,
                                      redirectURL: nil,
                                      clientID: "superget-mobile",
                                      clientSecret: nil,
                                      scope: "offline_access",
                                      refreshToken: nil,
                                      codeVerifier: nil,
                                      additionalParameters: ["username": username,
                                                             "password": password])
        
        guard let issuer = URL(string: Urls.shared.issuer) else { return }
        
        OIDAuthorizationService.perform(request) { response, error in
            
            if error != nil {
                debugPrint("Auth Error: " + String(describing: error))
            }
            
            let request = OIDAuthorizationRequest(configuration: configuration,
                                                  clientId: "superget-mobile",
                                                  clientSecret: nil,
                                                  scopes: [OIDScopeOpenID, OIDScopeProfile],
                                                  redirectURL: issuer,
                                                  responseType: OIDResponseTypeCode,
                                                  additionalParameters: nil)
            
            let authResponse = OIDAuthorizationResponse(request: request, parameters: [:])
            let authState = OIDAuthState(authorizationResponse: authResponse, tokenResponse: response)
            
            AuthStateManager.saveAuthStateInKeyChain(authState)
            
            completionHandler(response?.accessToken)
        }
    }
}
