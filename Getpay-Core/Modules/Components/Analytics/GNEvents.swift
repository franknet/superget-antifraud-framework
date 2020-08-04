import Foundation

// MARK: - Firebase events

public enum GNEvent: String {
    case CreateNewAccountBanner
    case ConfirmNewAccount
    case NotElegible
    case CreateNewAccountMenu
    
    var name: String {
        switch self {
        case .ConfirmNewAccount,
             .CreateNewAccountBanner,
             .CreateNewAccountMenu,
             .NotElegible:
            return self.rawValue
        }
    }
}

public enum GNEventParameters: String {
    case MERCHANT_ID
    
    public var props: [String: Any] {
        switch self {
        case .MERCHANT_ID:
            let merchantId = "\(GPUtils.loadGPMerchantFromUD().id)"
            return [self.rawValue: merchantId]
        }
    }
}
