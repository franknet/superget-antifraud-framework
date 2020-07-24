import UIKit

// MARK: - Class

public class ReceiptService {
    func fetch(by transactionId: String, type: GPReceiptType, completion: @escaping (Result<GPBankSlipReceipt, GPResponseError>) -> Void) {
        let request = RequestReceiptBankSlip(type: type, transactionCode: transactionId)
        ServiceManager().performRequest(route: request, completion: completion)
    }
}

public struct RequestReceiptBankSlip: BaseRequestProtocol {
    private let merchant = GPUtils.loadGPMerchantFromUD()
    public var path: String
    
    init(type: GPReceiptType, transactionCode: String) {
        path = Urls.shared.baseURL + "/v1/merchant/\(merchant.id)/receipt?type=\(type.paramDescription)&transactionCode=\(transactionCode)"
    }
}

public struct GPBankSlipReceipt: Codable {
    
    public let barCodeNumber: String
    public let description: String
    public let dueDate: String
    public let fine: Double
    public let recipientName: String
    public let transactionCode: String
    public let transactionDate: String
    public let status: String
    public let uid: String
    public let recipientDocumentNumber: String
    public let discount: Double
    public let interest: Double
    public let amount: Double
    
    // TODO: Remove later
    public static func mock() -> GPBankSlipReceipt {
        return GPBankSlipReceipt(
            barCodeNumber: "836900000016836800060003001012020424125934707410",
            description: "Boleto teste",
            dueDate: "17/10/2020",
            fine: 0.0,
            recipientName: "Leandro Lopes",
            transactionCode: "123DB12N3KJN12N3KUB",
            transactionDate: "17/07/2020",
            status: "CONFIRMED",
            uid: "1293JD912J",
            recipientDocumentNumber: "123456789",
            discount: 0.0,
            interest: 0.0,
            amount: 120.5)
    }
    
}

