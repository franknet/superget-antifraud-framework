import Foundation

// MARK: - Class

public class GPAccountService {
    
    // MARK: - Private Variables
    private var service = ServiceManager()
    private let merchantId = GPUtils.loadGPMerchantFromUD().id
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Public methods
    
    public func getAccount(completion: @escaping (Result<GPAccount, GPResponseError>) -> Void) {
        
        let request = AccountDataRequest(merchantId)
        service.performRequest(route: request, completion: completion)
    }
    
    public func postIndividualAccount(completion: @escaping (GPResponseError?) -> Void) -> Void {
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


// MARK: - Request

struct IndiviualAccountPostRequest: BaseRequestProtocol {
    var path: String
    var headers: Headers?
    
    init(_ merchantId: Int) {
        path = Urls.shared.baseURL + "/v1/merchant/\(merchantId)/alias-account"
        headers = [
            "merchant_id": "\(merchantId)",
            "Content-Type": "application/json",
            "x-api-version": "2",
            "scope": "APP"
        ]

    }
}
