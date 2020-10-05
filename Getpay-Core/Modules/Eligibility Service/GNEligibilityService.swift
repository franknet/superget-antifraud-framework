import Foundation

// MARK: - Class

public class GNEligibilityService {
    
    // MARK: - Private Variables
    
    private let service = ServiceManager()
    private let merchant = GPUtils.loadGPMerchantFromUD()
    private var account = GPUtils.loadAccountPersistenceFromUD()
    
    // MARK: - Initializer
    
    public init() {}
}

public extension GNEligibilityService {
    
    // MARK: - Public methods
    
    func getStatus(completion: @escaping (Result<EligibilityResponse, GPResponseError>) -> Void) {
        let request = EligibilityRequest(merchantId: merchant.id)
        service.performRequest(route: request, completion: completion)
    }
    
    func shouldMakeEligibilityCall() -> Bool {
        if let savedDate = account.lastEligibilityCall {
            if let currentDate = getCurrentDateWithoutTime() {
                if currentDate <= savedDate {
                    return false
                }
            }
        }
        return true
    }
    
    func saveCurrentDate() {
        if let date = getCurrentDateWithoutTime() {
            account.lastEligibilityCall = date
            GPUtils.save(account: account)
        }
    }
    
    // MARK: - Private methods
    
    private func getCurrentDateWithoutTime() -> Date? {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        return Calendar.current.date(from: components)
    }
}

// MARK: - Request

struct EligibilityRequest: BaseRequestProtocol {
    var path: String
    
    init(merchantId: Int) {
        path = Urls.shared.baseURL + "/v1/merchant/\(merchantId)/eligibility?product=PRE_PAGO"
    }
}

// MARK: - Response

public struct EligibilityResponse: Codable {
    public let status: Eligibility
}
