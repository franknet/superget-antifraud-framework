import UIKit
import RxSwift

// MARK: - Class

public class GNProposalOfferService {
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Public methods
    
    public func fetchProposalOffer() -> Observable<GNProposalOffer> {
        return Observable.create { obervable -> Disposable in
            let merchantId = GPUtils.loadGPMerchantFromUD().id
            self.fetchProposalOffer(merchantId) { response in
                switch response {
                case .success(let proposalOffer):
                    obervable.onNext(proposalOffer)
                case .failure(let error):
                    obervable.onError(error)
                }
            }
            return Disposables.create()
        }
        
    }
    
    public func fetchProposalOffer(_ merchantId: Int, completion: @escaping (Result<GNProposalOffer, GPResponseError>) -> Void) {
        let service = ServiceManager()
        let request = GNSCDProposalOfferRequest(merchantId: merchantId)
        return service.performRequest(route: request, completion: completion)
    }
}

// MARK: - Request

struct GNSCDProposalOfferRequest: BaseRequestProtocol {
    var path: String
    
    init(merchantId: Int) {
        path = Urls.shared.baseURL + "/api/v1/merchant/\(merchantId)/scd/proposal/offer"
    }
}

