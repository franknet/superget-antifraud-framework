import UIKit

// MARK: - Class

class BankSlipView: UIStackView {
    
    // MARK: - Internal variables
    
    lazy var header = GPReceiptHeaderView()
    lazy var paymentDestination = TitleWithValueAndSubTitle()
    lazy var amount = TitleWithValueAndSubTitle()
    lazy var paymentDate = TitleWithValueAndSubTitle()
    lazy var dueDate = TitleWithValueAndSubTitle()
    lazy var codeBankSlip = TitleWithValueAndSubTitle()
    lazy var paymentOrigin = TitleWithValueAndSubTitle()
    lazy var codeAuthentication = TitleWithValueAndSubTitle()
    lazy var fine = TitleWithValueAndSubTitle()
    lazy var discount = TitleWithValueAndSubTitle()
    lazy var paymentDescription = TitleWithValueAndSubTitle()
    lazy var interest = TitleWithValueAndSubTitle()
    
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

extension BankSlipView {
    
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
        addArrangedSubview(fine)
        addArrangedSubview(interest)
        addArrangedSubview(discount)
        addArrangedSubview(paymentDate)
        addArrangedSubview(dueDate)
        addArrangedSubview(codeBankSlip)
        addArrangedSubview(paymentOrigin)
        addArrangedSubview(codeAuthentication)
    }
    
    // MARK: - Public methods
    
    func populate(model: GPBankSlipReceipt) {
        header.configureView(icon: GPAssets.gpPayBoleto.image, iconTintColor: GPColors.burns.color, status: "Pagamento realizado")
        
        paymentDestination.isHidden = true
        if let recipientName = model.recipientName, let recipientDocumentNumber = model.recipientDocumentNumber {
            if recipientName.isNotEmpty || recipientDocumentNumber.isNotEmpty {
                paymentDestination.isHidden = false
                paymentDestination.configure(title: "Pagamento para", value: recipientName, description: recipientDocumentNumber.formatedAsCpfOrCnpj)
            }
        }
        
        amount.configure(title: "Valor do boleto", value: model.amount.formatedAsCurrency, description: nil)
        
        fine.configure(title: "Multa", value: model.fine.formatedAsCurrency, description: nil)
        
        interest.configure(title: "Juros", value: model.discount.formatedAsCurrency, description: nil)
        
        discount.configure(title: "Desconto", value: model.discount.formatedAsCurrency, description: nil)
        
        paymentDescription.configure(title: "Descrição", value: model.description, description: nil)
        if model.description.isEmpty {
            paymentDescription.isHidden = true
        }
        
        paymentDate.configure(title: "Data do pagamento", value: model.transactionDate.formatTransactionTime, description: nil)
        
        dueDate.configure(title: "Vencimento do boleto", value: model.dueDate.formatTransactionDateWithoutTime, description: nil)
        
        codeBankSlip.configure(title: "Código do Boleto", value: model.barCodeNumber, description: nil)
        
        paymentOrigin.configure(title: "Pagamento de", value: merchant.name, description: account.userAlias)
        
        codeAuthentication.configure(title: "Código de autenticação", value: model.uid ?? "", description: nil)
    }
}
