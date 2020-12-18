import UIKit

// MARK: - Class

final class PixView: UIStackView {
    
    // MARK: - Internal variables
    
    lazy var header = GPReceiptHeaderView()
    lazy var paymentDestination = TitleWithValueAndSubTitleV2()
    lazy var amount = TitleWithValueAndSubTitle()
    lazy var paymentDate = TitleWithValueAndSubTitle()
    lazy var paymentDescription = TitleWithValueAndSubTitle()
    lazy var idTransaction = TitleWithValueAndSubTitle()
    lazy var payer = TitleWithValueAndSubTitleV2()
    
    private let account = GPUtils.loadAccountPersistenceFromUD()
    private let merchant = GPUtils.loadGPMerchantFromUD()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        setupStackView()
        addComponents()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PixView {
    
    // MARK: - Private methods
    
    private func setupStackView() {
        self.backgroundColor = GPColors.apu.color
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fill
    }
    
    private func addComponents() {
        addArrangedSubview(header)
        addArrangedSubview(paymentDestination)
        addArrangedSubview(amount)
        addArrangedSubview(paymentDate)
        addArrangedSubview(paymentDescription)
        addArrangedSubview(idTransaction)
        addArrangedSubview(payer)
    }
    
    // MARK: - Public methods
    
    func populate(model: GPPixPaymentReceipt) {
        header.configureView(icon: GPAssets.gpCashOut.image,
                             iconTintColor: GPColors.burns.color,
                             status: "Pix enviado")
        
        paymentDestination.configure(title: "Pagamento para",
                                     value: model.receiverName,
                                     descriptionOne: model.receiverDocument.isValidCPF ? model.receiverDocument.maskedCPF : model.receiverDocument.formatedAsCpfOrCnpj,
                                     descriptionTwo: model.receiverBank)
        
        amount.configure(title: "Valor",
                         value: model.amount.formatedAsCurrency,
                         description: nil)
        
        paymentDate.configure(title: "Data do pagamento",
                              value: model.paymentDate.formatTransactionTime,
                              description: nil)
        
        paymentDescription.configure(title: "Descrição",
                                     value: model.description,
                                     description: nil)
        
        if model.description.isEmpty {
            paymentDescription.isHidden = true
        }
        
        idTransaction.configure(title: "ID da transação",
                                value: model.idTransaction,
                                description: nil)
        
        if let document = account.document {
            payer.configure(title: "Pagamento de",
                            value: merchant.tradeName,
                            descriptionOne: document.isValidCPF ? document.maskedCPF : document.formatedAsCNPJ,
                            descriptionTwo: account.institution.name)
        } else {
            payer.isHidden = true
        }
    }
}
