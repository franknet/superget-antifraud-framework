import UIKit

// MARK: - Class

public class GNPendenciesService {
    
    // MARK: - Private variables
    
    private let service = ServiceManager()
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Public methods
    
    public func shouldResolvePendencies(completion: @escaping (Bool) -> Void) {
        self.fetch { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                GNGeneralConfig.shared.configure(pendencies: result)
                let isRequired = self.isRequiredResolvePendencies(pendencies: result)
                completion(isRequired)
                
            case .failure(_):
                completion(false)
            }
        }
    }
    
    // MARK: - Private methods
    
    private func isRequiredResolvePendencies(pendencies: Pendencies) -> Bool {
        if pendencies.status == .CREATED {
            return true
        }
        return false
    }
    
    private func fetch(completion: @escaping (Result<Pendencies, GPResponseError>) -> Void) {
        let merchantId = GPUtils.loadGPMerchantFromUD().id
        let request = PendencieseRequest(merchantId)
        service.performRequest(route: request, completion: completion)
    }
}

// MARK: - Pendencies Request

struct PendencieseRequest: BaseRequestProtocol {
    var path: String
    
    init(_ merchantId: Int) {
        path = Urls.shared.baseURL + "/v1/merchant/\(merchantId)/pendencies"
    }
}

// MARK: - Pendencies Response

public struct Pendencies: Codable {
    public let validations: [Validation]
    public let acceptances: [AcceptanceType]
    public let documents: [PendenciesDocumentType]
    public let dataGrid: [DataType]
    public let status: Status
    public let personType: PersonType
}

public struct Validation: Codable {
    public let type: ValidationType
    public let value: String?
}

public enum AcceptanceType: String, Codable {
    case ORDER_SUMMARY, TERMS_AND_CONDITIONS, PRIVACY_POLICY
}

public enum PendenciesDocumentType: String, Codable {
    case SELFIE, IDENTIFICATION_DOCUMENT, SOCIAL_CONTRACT,
         LETTER_OF_ATTORNEY, ID_CARD, DRIVER_LICENSE
}

public enum ValidationType: String, Codable {
    case PHONE, EMAIL
}

public enum DataType: String, Codable {
    case COUNTRY, LEGAL_REPRESENTATIVE_COUNTRY, MCC,
         CELL_PHONE, LEGAL_REPRESENTATIVE_CELL_PHONE, PHONE,
         EMAIL, LEGAL_REPRESENTATIVE_EMAIL, MONTHLY_INCOME,
         LEGAL_REPRESENTATIVE_MONTHLY_INCOME, ANNUAL_INCOME, NET_WORTH,
         LEGAL_REPRESENTATIVE_NET_WORTH, TRADE_NAME, RESIDENTIAL_ADDRESS,
         COMMERCIAL_ADDRESS, BUSINESS_ADDRESS, LEGAL_REPRESENTATIVE_RESIDENTIAL_ADDRESS
}

public enum Status: String, Codable {
    case CREATED, PENDING, OK, CANCELED
}

public enum PersonType: String, Codable {
    case PF, PJ
}

public enum FileType: String, Codable {
    case JPEG, JPG, PNG, PDF
}

public enum DocumentSide: String, Codable {
    case FRONT, BACK
}
