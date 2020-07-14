import UIKit

public struct RequestReceiptBankSlip: BaseRequestProtocol {
    private let merchant = GPUtils.loadGPMerchantFromUD()
    public var path: String
    
    init(type: ReceiptType, transactionCode: String) {
        // path = Urls.shared.baseURL + "/v1/merchant/\(merchant.id)/receipt?type=\(type.paramDescription)&transactionCode=\(transactionCode)"
        path = "https://getpay-payment-getpay-hti.openshift-hml.getnet.com.br/api/v1/merchant/\(merchant.id)/receipt?transactionCode=\(transactionCode)&type=\(type.paramDescription)"
    }
}

public class ReceiptService {
    func fetch(by transactionId: String, type: ReceiptType, completion: @escaping (Result<GPBankSlipReceipt, GPResponseError>) -> Void) {
        let request = RequestReceiptBankSlip(type: type, transactionCode: transactionId)
        ServiceManager().performRequest(route: request, completion: completion)
    }
}

struct GPBankSlipReceipt: Codable {
    let barCodeNumber: String
    let description: String
    let dueDate: String
    let fine: String
    let recipientName: String
    let transactionCode: String
    let transactionDate: String
    let status: String
    let uid: String
    let recipientDocumentNumber: String
    let discount: Double
    let interest: Double
    let amount: Double
}
