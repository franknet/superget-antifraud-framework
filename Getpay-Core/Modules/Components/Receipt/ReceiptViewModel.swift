import UIKit

// MARK: - Class

public class ReceiptViewModel {
    
    // MARK: - Internal variables
    
    let type: GPReceiptType
    var bankSlip: GPBankSlipReceipt?
    var pixPayment: GPPixPaymentReceipt?
    
    // MARK: - Private variables
    
    private var transactionId: String?
    private let service = ReceiptService()
    
    // MARK: - Initializers
    
    public init(transactionId: String, type: GPReceiptType) {
        self.transactionId = transactionId
        self.type = type
    }
    
    public init(bankSlip: GPBankSlipReceipt) {
        self.bankSlip = bankSlip
        self.type = .bankSlip
    }
    
    public init(pixPayment: GPPixPaymentReceipt) {
        self.pixPayment = pixPayment
        self.type = .pixPayment
    }
}

extension ReceiptViewModel {
    
    // MARK: - Public methods
    
    func fetch(completion: @escaping (Result<GPBankSlipReceipt, GPResponseError>) -> Void) {
        guard let transactionId = self.transactionId else { return }
        service.fetch(by: transactionId, type: self.type) { response in
            completion(response)
        }
    }
}
