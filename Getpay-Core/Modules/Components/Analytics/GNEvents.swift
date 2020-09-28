import Foundation

// MARK: - Firebase events

public enum GNEvent: String {
    case CreateNewAccountBanner
    case ConfirmNewAccount
    case NotElegible
    case CreateNewAccountMenu
    case shortcut_menu_pinpad_checkout
    case shortcut_menu_transfer
    case shortcut_menu_pix
    case shortcut_menu_qrcode_checkout
    case shortcut_menu_slip_deposit
    case shortcut_menu_slip_payment
    case shortcut_menu_expand_menu
    case shortcut_menu_cancel_checkout
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
