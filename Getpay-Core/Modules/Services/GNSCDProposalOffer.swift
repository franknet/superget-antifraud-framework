import UIKit

// MARK: - Class

public class GNSCDProposalOffer {
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Public methods
    
    public func getProposalOffer(merchantId: String, completion: @escaping (Result<GNProposalOffer, GPResponseError>) -> Void) {
        let service = ServiceManager()
        let request = GNSCDProposalOfferRequest(merchantId: merchantId)
        return service.performRequest(route: request, completion: completion)
    }
}

// MARK: - Request

struct GNSCDProposalOfferRequest: BaseRequestProtocol {
    var path: String
    
    init(merchantId: String) {
        path = Urls.shared.baseURL + "/api/v1/merchant/\(merchantId)/scd/proposal/offer"
    }
}

