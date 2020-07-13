import Foundation

// MARK: - Class

public class GPAccountService {
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Public methods
    
    public func getBalance(completion: @escaping (Result<GPAccount, GPResponseError>) -> Void) {
        let service = ServiceManager()
        let merchantId = GPUtils.loadGPMerchantFromUD().id
        let request = AccountDataRequest(merchantId)
        service.performRequest(route: request, completion: completion)
    }
}

// MARK: - Request

struct AccountDataRequest: BaseRequestProtocol {
    var path: String
    
    init(_ merchantId: Int) {
        path = Urls.shared.baseURL + "/v1/merchant/\(merchantId)/account"
    }
}
