import UIKit

class BankSlipView: UIStackView {
    
    lazy var header = GPReceiptHeaderView()
    lazy var paymentDestination = TitleWithValueAndSubTitle()
    lazy var amount = TitleWithValueAndSubTitle()
    lazy var paymentDate = TitleWithValueAndSubTitle()
    lazy var dueDate = TitleWithValueAndSubTitle()
    lazy var codeBankSlip = TitleWithValueAndSubTitle()
    lazy var paymentOrigin = TitleWithValueAndSubTitle()
    lazy var codeAuthentication = TitleWithValueAndSubTitle()
    
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
    
    private func setupStackView() {
        self.backgroundColor = GPColors.apu.color
        self.axis = .vertical
    }
    
    private func addComponents() {
        addArrangedSubview(header)
        addArrangedSubview(paymentDestination)
        addArrangedSubview(amount)
        addArrangedSubview(paymentDate)
        addArrangedSubview(dueDate)
        addArrangedSubview(codeBankSlip)
        addArrangedSubview(paymentOrigin)
        addArrangedSubview(codeAuthentication)
    }
    
    func populate(model: GPBankSlipReceipt) {
        header.configureView(icon: GPAssets.gpCheck.image, iconTintColor: GPColors.burns.color, status: "Pagamento concluído")
        paymentDestination.configure(title: "Pagamento para", value: "\(model.recipientName)", description: "40.432.544/0101-00")
        amount.configure(title: "Valor do boelto", value: "\(model.amount)", description: nil)
        paymentDate.configure(title: "Data do pagamento", value: "\(model.transactionDate)", description: nil)
        dueDate.configure(title: "Vencimento do boleto", value: "\(model.dueDate)", description: nil)
        codeBankSlip.configure(title: "Código do Boleto", value: "\(model.barCodeNumber)", description: nil)
        paymentOrigin.configure(title: "Pagamento de", value: "", description: "@fernanda.gomes - SuperGet")
        codeAuthentication.configure(title: "Código de autenticação", value: "\(model.transactionCode)", description: nil)
    }
}

