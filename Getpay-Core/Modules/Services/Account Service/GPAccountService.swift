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
//                    self.accountResponseHandler(response: account) {
//                        completion(true)
//                    }

                case .failure(let error):
                    observable.onError(error)
//                    self.accountResponseHandler(error: error, completion: completion)
                }
            }
            return Disposables.create()
            
        }
//        var persistedAccount = GPUtils.loadAccountPersistenceFromUD()
//        persistedAccount.requestStatus = .loading
//        GPUtils.save(account: persistedAccount)
        
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


// MARK: - Request

//struct IndividualAccountNotification: LocalNotificationModel {
//    var title: String = "Sua conta SuperGet mudou."
//    var subtitle: String = ""
//    var body: String = "Agora, com a parceria com o Banco Votorantim, você realiza transferências para qualquer banco, faz pagamentos de contas e muito mais. Acesse o app SuperGet e aproveite todas as vantagens."
//    var sound = UNNotificationSound.default
//    var trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 3, repeats: false)
//}

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

