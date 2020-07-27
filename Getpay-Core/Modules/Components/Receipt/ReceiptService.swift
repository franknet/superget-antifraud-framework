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
    
    public init(barCodeNumber: String,
                description: String,
                dueDate: String,
                fine: Double,
                transactionCode: String,
                transactionDate: String,
                status: String,
                uid: String?,
                recipientName: String?,
                recipientDocumentNumber: String?,
                discount: Double,
                interest: Double,
                amount: Double) {
        
        self.barCodeNumber = barCodeNumber
        self.description = description
        self.dueDate = dueDate
        self.fine = fine
        self.transactionCode = transactionCode
        self.transactionDate = transactionDate
        self.status = status
        self.uid = uid
        self.recipientName = recipientName
        self.recipientDocumentNumber = recipientDocumentNumber
        self.discount = discount
        self.interest = interest
        self.amount = amount
    }
    
    public var barCodeNumber: String
    public var description: String
    public var dueDate: String
    public var fine: Double
    public var transactionCode: String
    public var transactionDate: String
    public var status: String
    public var uid: String?
    public var recipientName: String?
    public var recipientDocumentNumber: String?
    public var discount: Double
    public var interest: Double
    public var amount: Double
}

