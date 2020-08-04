import Foundation

// MARK: - Firebase events

public enum GNEvent: String {
    case CreateNewAccountBanner
    case ConfirmNewAccount
    case NotElegible
    case CreateNewAccountMenu
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

// MARK: - Class

public class GNAnalytics {
    
    // MARK: Public methods
    
    public static func track(event: GNEvent) {
        let event: [String: Any] = ["event": event,
                                    "props": GNEventParameters.MERCHANT_ID]
        NotificationCenter.default.post(name: .trackEvent, object: nil, userInfo: event)
    }
}
