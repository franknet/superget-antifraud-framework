// MARK: - Class
import RxSwift

class ProposalOfferService {
  
    // MARK: - Initializers

    init() {}
    
    func fetchProposalOffer() -> Observable<ProposalOfferResponse> {
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
    
    private func fetchProposal(completion: @escaping (Result<ProposalOfferResponse, GPResponseError>) -> Void) {
        let service = ServiceManager()
        let merchantId = GPUtils.loadGPMerchantFromUD().id
        let request = ProposalOfferRequest(merchantId)
        service.performRequest(route: request, completion: completion)
    }
}
