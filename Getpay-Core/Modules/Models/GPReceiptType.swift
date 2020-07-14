import UIKit

public enum GPReceiptType {
    case bankSlip, p2p, ted, sale, estorno
    
    var paramDescription: String {
        switch self {
        case .bankSlip:
            return GPTrasactionType.PAYMENT_ACCOUNTS_CTA.rawValue
        case .p2p:
            return ""
        case .ted:
            return ""
        case .sale:
            return ""
        case .estorno:
            return ""
        }
    }
    
    var view: UIView {
        switch self {
        case .bankSlip:
            return BankSlipView()
        default:
            return UIView()
        }
    }
}
