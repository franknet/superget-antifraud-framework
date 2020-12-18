import UIKit

public enum GPReceiptType {
    case bankSlip, p2p, ted, sale, estorno, pixPayment
    
    var paramDescription: String {
        switch self {
        case .bankSlip:
            return GPTrasactionType.PAYMENT_ACCOUNTS_CTA.rawValue
        default:
            return ""
        }
    }
    
    var view: UIView {
        switch self {
        case .bankSlip:
            return BankSlipView()
        case .pixPayment:
            return PixView()
        default:
            return UIView()
        }
    }
}
