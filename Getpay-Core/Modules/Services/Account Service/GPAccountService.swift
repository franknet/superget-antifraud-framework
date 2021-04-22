import UIKit
import RxSwift
// MARK: - Class

public typealias VerifyResult = (preset: InformationViewPreset?, status: GNAccountStatus?)

public class GPAccountService {
    
    // MARK: - Private Variables
    
    private var service = ServiceManager()
    private var merchantId: Int {
        return GPUtils.loadGPMerchantFromUD().id
    }
    
    // MARK: - Initializers
    
    public init() {}
}

extension GPAccountService {
    
    // MARK: - Public methods
    
    public func getAccount() -> Observable<GPAccount> {
        return Observable.create { observable -> Disposable in
            
            self.get { response in
                switch response {
                case .success(let account):
                    observable.onNext(account)

                case .failure(let error):
                    observable.onError(error)
                }
            }
            return Disposables.create()
            
        }
    }
    
    public func get(completion: @escaping (Result<GPAccount, GPResponseError>) -> Void) {
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


//MARK: Verify Account
extension GPAccountService {
    public func checkAccount(navigationTitle: String? = "") -> VerifyResult? {
        var model: InformationViewPreset
        let merchant = GPUtils.loadGPMerchantFromUD()
        
        switch merchant.banking?.status {
        case .NOT_REQUESTED:
            return (PresetClient403(), merchant.banking?.status)
            
        case .PENDING, .WAITING_CORRECTIONS, .ALIAS_ACCOUNT_PENDING:
            model = PresetWaitingDocumentsNewClient()
            model.navigationTitle = navigationTitle
            return (model, merchant.banking?.status)
            
        case .WAITING_ANALYSIS:
            model = PresetWaitingAnalysis()
            model.navigationTitle = navigationTitle
            return (model, merchant.banking?.status)
            
        case .BLOCKED:
            model = PresetCanceledAccount()
            model.navigationTitle = navigationTitle
            return (model, merchant.banking?.status)
            
        default:
            return (nil, merchant.banking?.status)
        }
    }
}

