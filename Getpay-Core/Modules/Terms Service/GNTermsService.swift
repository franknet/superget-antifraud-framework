import Foundation

// MARK: - Class

public class GNTermsService {
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Public methods
    
    public func getTerms(completion: @escaping (Result<GNTermsResponse, GPResponseError>) -> Void) {
        let service = ServiceManager()
        let request = GNTermsGetRequest()
        service.performRequest(route: request, completion: completion)
    }
    
    public func sendTerms(secretAgent: String,
                          addr: String,
                          tokens: [String],
                          completion: @escaping (GPResponseError?) -> Void) {
        
        let service = ServiceManager(isJsonBody: true)
        let merchantId = GPUtils.loadGPMerchantFromUD().id
        let request = GNTermsPostRequest(merchantId: merchantId,
                                         secretAgent: secretAgent,
                                         addr: addr,
                                         tokens: tokens)
        service.performRequest(route: request, completion: completion)
    }
}

// MARK: - Request

struct GNTermsGetRequest: BaseRequestProtocol {
    var path: String
    
    init() {
        path = Urls.shared.baseURL + "/v1/account/terms?types=TERMS_OF_USE&types=PRIVACY_POLICY"
    }
}

struct GNTermsPostRequest: BaseRequestProtocol {
    var method: GPHttpMethod
    var path: String
    var body: Parameters?
    
    init(merchantId: Int, secretAgent: String, addr: String, tokens: [String]) {
        method = .post
        path = Urls.shared.baseURL + "/v1/merchant/\(merchantId)/terms"
        body = [
            "tokens": tokens,
            "fingerprint": "\(secretAgent)#\(addr)"
        ]
    }
}

// MARK: - Response

public struct GNTermsResponse: Codable {
    public let message: String
    public let result: GNTerms
}

public struct GNTerms: Codable {
    public let regulatoryDocuments: [GNRegulatoryDocuments]
}

public struct GNRegulatoryDocuments: Codable {
    public let type: String
    public let token: String
    public let regDocObj: String
}
