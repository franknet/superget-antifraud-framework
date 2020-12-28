import UIKit

// MARK: - Class

public class GNMerchantService {
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Public methods
    
    public func getMerchant(merchantId: String, completion: @escaping (Result<GPMerchant, GPResponseError>) -> Void) {
        let service = ServiceManager()
        let request = MerchantRequest(merchantId: merchantId)
        return service.performRequest(route: request, completion: completion)
    }
}

// MARK: - Request

struct MerchantRequest: BaseRequestProtocol {
    var path: String
    
    init(merchantId: String) {
        path = Urls.shared.baseURL + "/v1/merchant/\(merchantId)"
    }
}

