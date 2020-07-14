import UIKit

// MARK: - Class

public class ReceiptViewModel {
    
    // MARK: - Internal variables
    
    private let transactionId: String
    private let service = ReceiptService()
    
    let type: GPReceiptType
    var bankSlip: GPBankSlipReceipt?
    
    // MARK: - Initializers
    
    public init(transactionId: String, type: GPReceiptType) {
        self.transactionId = transactionId
        self.type = type
    }
}

extension ReceiptViewModel {
    
    // MARK: - Public methods
    
    func fetch(completion: @escaping (Result<GPBankSlipReceipt, GPResponseError>) -> Void) {
        service.fetch(by: self.transactionId, type: self.type) { response in
            completion(response)
        }
    }
}
