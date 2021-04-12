import UIKit
// MARK: - Class

public typealias VerifyResult = (preset: InformationViewPreset?, status: GNAccountStatus?)

public class GPAccountService {
    
    // MARK: - Private Variables
    
    private var service = ServiceManager()
    private var merchantId: Int {
        return GPUtils.loadGPMerchantFromUD().id
    }
    private let eligibilityService = GNEligibilityService()
    
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
                self.accountResponseHandler(response: account)
                completion(true)
                
            case .failure(let error):
                self.accountResponseHandler(error: error, completion: completion)
            }
        }
    }
    
    public func get(completion: @escaping (Result<GPAccount, GPResponseError>) -> Void) {
        let request = AccountDataRequest(merchantId)
        service.performRequest(route: request, completion: completion)
    }
    
    func accountResponseHandler(response: GPAccount) {
        shouldSendAccountNotification(response: response)
        
        let merchant = GPUtils.loadGPMerchantFromUD()
        
        if merchant.banking.status == .NOT_REQUESTED && eligibilityService.shouldMakeEligibilityCall() {
            getEligibility(completion: { _ in })
        }
        
        var persistedAccount = response
        if response.status == .WAITING_ANALYSIS {
            persistedAccount.requestStatus = .waitingAnalysis
            
        } else if response.status == .WAITING_DOCUMENTS {
            if response.origin == .VIZIR {
                persistedAccount.requestStatus = .waitingDocumentsVizir
                
            } else if response.origin == .NEW_CLIENT {
                persistedAccount.requestStatus = .waitingDocumentsNewClient
                
            } else if response.origin == .LEGACY {
                persistedAccount.requestStatus = .waitingDocumentsLegacy
                
            }
            
        } else if response.status == .DENIED {
            persistedAccount.requestStatus = .denied
            
        } else if response.status == .WAITING_CORRECTIONS {
            persistedAccount.requestStatus = .waitingCorrections
            
        } else {
            persistedAccount.requestStatus = .active
        }
        GPUtils.save(account: persistedAccount)
    }
    
    func accountResponseHandler(error: GPResponseError, completion: @escaping (Bool) -> Void) {
        var persistedAccount = GPUtils.loadAccountPersistenceFromUD()
        GPUtils.setNeedAccountUpdate(false)
        
        switch error.status {
        case "403":
            persistedAccount.requestStatus = .active403
            GPUtils.save(account: persistedAccount)
            completion(false)

        default:
            persistedAccount.requestStatus = .retry
            GPUtils.save(account: persistedAccount)
            completion(false)
        }
    }
    
    // MARK: - Private methods
    
    private func getEligibility(completion: @escaping (Bool) -> Void) {
        var persistedAccount = GPUtils.loadAccountPersistenceFromUD()
        eligibilityService.getStatus { [weak self] response in
            switch response {
            case .success(let result):
                persistedAccount.eligibility = result.status
                GPUtils.save(account: persistedAccount)
                self?.eligibilityService.saveCurrentDate()
                
            case .failure(let error):
                debugPrint(error)
                
            }
            completion(false)
        }
    }
    
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

