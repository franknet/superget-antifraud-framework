import Foundation
import UIKit

// MARK: - Class

public class GPAccountService {
    
    // MARK: - Private Variables
    
    private var service = ServiceManager()
    private var merchantId: Int {
        return GPUtils.loadGPMerchantFromUD().id
    }
    private let eligibilityService = GNEligibilityService()
    private(set) var persistedAccount: GPAccount {
        get {
            return GPUtils.loadAccountPersistenceFromUD()
        }
        set {
            GPUtils.save(account: newValue)
        }
    }
    
    // MARK: - Initializers
    
    public init() {}
}

extension GPAccountService {
    
    // MARK: - Public methods
    
    public func getAccount(completion: @escaping (Bool) -> Void) {
        self.get { [weak self] response in
            switch response {
            case .success(let account):
                self?.accountResponseHandler(response: account)
                completion(true)
                
            case .failure(let error):
                self?.accountResponseHandler(error: error)
                completion(false)
                
            }
        }
    }
    
    public func postIndividualAccount(completion: @escaping (GPResponseError?) -> Void) -> Void {
        let merchantId = GPUtils.loadGPMerchantFromUD().id
        let request = IndiviualAccountPostRequest(merchantId)
        service.performRequest(route: request, completion: completion)
    }
    
    public func get(completion: @escaping (Result<GPAccount, GPResponseError>) -> Void) {
        let request = AccountDataRequest(merchantId)
        service.performRequest(route: request, completion: completion)
    }
    
    func accountResponseHandler(response: GPAccount) {
        
        shouldSendAccountNotification(response: response)
        
        persistedAccount = response
        
        if response.aliasAccountStatus == .NOT_REQUESTED && response.status == .ACTIVE {
            postIndividualAccount { (error) in
                debugPrint(error as Any)
            }
        }
        
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
    }
    
    func accountResponseHandler(error: GPResponseError) {
        if error.status == "404" {
            persistedAccount.requestStatus = .newClient404
            
            if eligibilityService.shouldMakeEligibilityCall() {
                getEligibility()
            }
            
        } else if error.status == "403" {
            persistedAccount.requestStatus = .active403
            
        } else {
            persistedAccount.requestStatus = .retry
            
        }
    }
    
    // MARK: - Private methods
    
    private func getEligibility() {
        eligibilityService.getStatus { [weak self] response in
            switch response {
            case .success(let result):
                self?.persistedAccount.eligibility = result.status
                self?.eligibilityService.saveCurrentDate()
                
            case .failure(let error):
                debugPrint(error)
                
            }
        }
    }
    
    private func shouldSendAccountNotification(response: GPAccount) {
        let persistedValidation = (persistedAccount.aliasAccountStatus != response.aliasAccountStatus && self.persistedAccount.id != 0)
        if persistedValidation && response.aliasAccountStatus == .ACTIVE {
            GPLocalNotification.fireNotification(withModel: self.setupNotification(withAccount: response))
        }
    }
    
    func setupNotification(withAccount account: GPAccount) -> LocalNotificationModel {
        let bankingInstitution = account.institution
        let agency = account.branchNumber
        let cc = account.number

        var preset = IndividualAccountNotification()
        preset.body = String(
            format: preset.body, "\(bankingInstitution.number) - \(bankingInstitution.name)", "\(agency) / \(cc)"
        )
        return preset
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

struct IndiviualAccountPostRequest: BaseRequestProtocol {
    var path: String
    var headers: Headers?
    var method: GPHttpMethod
    
    init(_ merchantId: Int) {
        method = .post
        path = Urls.shared.baseURL + "/v1/merchant/\(merchantId)/alias-account"
        headers = [
            "merchant_id": "\(merchantId)",
            "Content-Type": "application/json",
            "x-api-version": "2",
            "scope": "APP"
        ]
        
    }
}

struct IndividualAccountNotification: LocalNotificationModel {
    var title: String = "Sua conta foi criada"
    var subtitle: String = ""
    var body: String = "Agora você pode aproveitar todos os benefícios do aplicativo. \n\nConfira os dados da sua conta Superget. \n\n Banco\n %@ \n\nAgência / Conta\n %@"
    var sound = UNNotificationSound.default
    var trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 3, repeats: false)
}
