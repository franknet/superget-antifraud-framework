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
    case shortcut_menu_sim_loan
    case onboarding_pix_finish
    case pix_qrcode_payment
    case pix_key_payment
    case getpay_value_return
    case getpay_value_next
    case getpay_sale_data_return
    case getpay_sale_data_next
    case getpay_payment_method_return
    case getpay_payment_method_next
    case getpay_summary_return
    case getpay_summary_create
    case getpay_copy_link
    case getpay_link_share
    case getpay_contract
    case getpay_new_link
    case getpay_link_detail
    case getpay_detail_edit
    case getpay_detail_edit_save
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
