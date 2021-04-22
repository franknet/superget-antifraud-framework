import UIKit
import RxSwift
// MARK: - Class

public class GNBalanceService {
    
    // MARK: - Private Variables
    
    private let service = ServiceManager()
    
    // MARK: - Initializers
    
    public init() {}
}

extension GNBalanceService {
    
    // MARK: - Public methods
    
    public func fetchBalance() -> Observable<BalanceResponse> {
        return Observable.create { observable -> Disposable in
            self.fetch { response in
                switch response {
                case .success(let balance):
                    observable.onNext(balance)
                case .failure(let error):
                    observable.onError(error)
                }
            }
            return Disposables.create()
        }
        
    }
    
    // MARK: - Private methods
    
    public func fetch(completion: @escaping (Result<BalanceResponse, GPResponseError>) -> Void) {
        let merchantId = GPUtils.loadGPMerchantFromUD().id
        let request = FetchBalanceRequest(merchantId)
        service.performRequest(route: request, completion: completion)
    }
}

// MARK: - Fetch Balance Request

struct FetchBalanceRequest: BaseRequestProtocol {
    var path: String
    
    init(_ merchantId: Int) {
        path = Urls.shared.baseURL + "/v1/merchant/\(merchantId)/account/balance"
    }
}

// MARK: - Balance Response

public struct BalanceResponse: Codable {
    public var globalAvailableBalance: Double
}
