import UIKit

public class ReceiptViewModel {
    
    private let transactionId: String
    private let service = ReceiptService()
    
    let type: GPReceiptType
    var bankSlip: GPBankSlipReceipt?
    
    public init(transactionId: String, type: GPReceiptType) {
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
