import UIKit

// MARK: - Class

class UserAliasService {
    
    // MARK: - Public methods
    
    func searchUserAlias(userAlias: String,
                         completion: @escaping (Result<UserAliasResponse,GPResponseError>) -> Void) {
        
        let service = ServiceManager()
        let request = UserAliasRequest(userAlias: userAlias)
        service.performRequest(route: request, completion: completion)
    }
    
    func updateUser(userAlias: String,
                    completion: @escaping (GPResponseError?) -> Void) {
        
        let service = ServiceManager(isJsonBody: true)
        let merchantId = "\(GPUtils.loadGPMerchantFromUD().id)"
        let request = UpdateUserRequest(merchantId: merchantId, userAlias: userAlias)
        service.performRequest(route: request,completion: completion)
    }
}

// MARK: - Request

struct UserAliasRequest: BaseRequestProtocol {
    var path: String

    init(userAlias: String) {
        path = Urls.shared.baseURL + "/v1/account?userAlias=\(userAlias)"
    }
}

struct UpdateUserRequest: BaseRequestProtocol {
    var path: String
    var method: GPHttpMethod
    var body: Parameters?
    
    init(merchantId: String,
         userAlias: String) {
        path = Urls.shared.baseURL + "/v1/merchant/\(merchantId)/account"
        method = .put
        body = ["userAlias": userAlias]
    }
}

// MARK: - Response

struct UserAliasResponse: Codable {
    var content: [UserAlias?]
}

struct UserAlias: Codable {
    var useralias: String?
    var name: String
    var pictureUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case useralias
        case name
        case pictureUrl = "picture_url"
    }
}
