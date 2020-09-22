import Foundation

// MARK: - Class

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
    
    public func getAccount(completion: @escaping (Result<GPAccount, GPResponseError>) -> Void) {
        
        let request = AccountDataRequest(merchantId)
        service.performRequest(route: request, completion: completion)
    }
    
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
    
    func accountResponseHandler(response: GPAccount) {
        persistedAccount = response
        
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
    
    private func get(completion: @escaping (Result<GPAccount, GPResponseError>) -> Void) {
        let request = AccountDataRequest(merchantId)
        service.performRequest(route: request, completion: completion)
    }
    
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
