import UIKit
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
    
    public func getAccount(completion: @escaping (Bool) -> Void) {
        var persistedAccount = GPUtils.loadAccountPersistenceFromUD()
        persistedAccount.requestStatus = .loading
        GPUtils.save(account: persistedAccount)
        
        self.get { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let account):
                self.accountResponseHandler(response: account) {
                    completion(true)
                }

            case .failure(let error):
                self.accountResponseHandler(error: error, completion: completion)
            }
        }
    }
    
    public func get(completion: @escaping (Result<GPAccount, GPResponseError>) -> Void) {
        let request = AccountDataRequest(merchantId)
        service.performRequest(route: request, completion: completion)
    }
    
    func accountResponseHandler(response: GPAccount, completion: @escaping ActionVoid) {
        shouldSendAccountNotification(response: response)
        completion()
    }
    
    func accountResponseHandler(error: GPResponseError, completion: @escaping (Bool) -> Void) {
        var persistedAccount = GPUtils.loadAccountPersistenceFromUD()
        GPUtils.setNeedAccountUpdate(false)
        
        persistedAccount.requestStatus = .retry
        GPUtils.save(account: persistedAccount)
        completion(false)
    }
    
    // MARK: - Private methods
    
    private func shouldSendAccountNotification(response: GPAccount) {
        let persistedAccount = GPUtils.loadAccountPersistenceFromUD()
        let persistedValidation = (persistedAccount.aliasAccountStatus != response.aliasAccountStatus && persistedAccount.id != 0)
        if persistedValidation && response.aliasAccountStatus == .ACTIVE {
            GPLocalNotification.fireNotification(withModel: IndividualAccountNotification())
        }
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

struct IndividualAccountNotification: LocalNotificationModel {
    var title: String = "Sua conta SuperGet mudou."
    var subtitle: String = ""
    var body: String = "Agora, com a parceria com o Banco Votorantim, você realiza transferências para qualquer banco, faz pagamentos de contas e muito mais. Acesse o app SuperGet e aproveite todas as vantagens."
    var sound = UNNotificationSound.default
    var trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 3, repeats: false)
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

