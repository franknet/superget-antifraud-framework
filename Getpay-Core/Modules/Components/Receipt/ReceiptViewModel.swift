import UIKit

public enum ReceiptType {
    case bankSlip, p2p, ted, sale, estorno
    
    var paramDescription: String {
        switch self {
        case .bankSlip:
            return "PAYMENT_ACCOUNTS_CTA"
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

public class ReceiptViewModel {
    
    private let transactionId: String
    private let service = ReceiptService()
    
    let type: ReceiptType
    var bankSlip: GPBankSlipReceipt?
    
    public init(transactionId: String, type: ReceiptType) {
        self.transactionId = transactionId
        self.type = type
    }
}

extension ReceiptViewModel {
    
    func fetch(completion: @escaping (Result<GPBankSlipReceipt, GPResponseError>) -> Void) {
        service.fetch(by: self.transactionId, type: self.type) { response in
            completion(response)
        }
    }
}
