// MARK: - Class

import RxSwift

public class GPProposalOfferService {
  
    // MARK: - Initializers

    public init() {}
    
    // MARK: - Internal methods
    
   public func fetchProposalOffer() -> Observable<GPProposalOfferResponse> {
        return Observable.create { observable -> Disposable in
            self.fetchProposal { response in
                switch response {
                case .success(let proposalOfferResponse):
                    observable.onNext(proposalOfferResponse)
                case .failure(let error):
                    observable.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    // MARK: - Private methods
    
    private func fetchProposal(completion: @escaping (Result<GPProposalOfferResponse, GPResponseError>) -> Void) {
        let service = ServiceManager()
        let merchantId = GPUtils.loadGPMerchantFromUD().id
        let request = GPProposalOfferRequest(merchantId)
        service.performRequest(route: request, completion: completion)
    }
}
