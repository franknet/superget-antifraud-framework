import UIKit

// MARK: - Class

public final class TokenConfirmationWithResendButtonView: UIView {
    
    // MARK: - Internal Variables
        
    lazy var title = GPLabel(text: "Digite o código de verificação.",
                             fontSize: 16.0,
                             alignment: .center,
                             textColor: GPColors.ralph.color)
    
    lazy var continueButton = GPButton(title: "CONTINUAR",
                                       style: .filled)
    
    lazy var resendButton: GPButton = {
        $0.isEnabled = false
        return $0
    }(GPButton(title: "REENVIAR CÓDIGO", style: .text))
    
    // MARK: - Public Variables
    
    public lazy var tokenTextField: UITextField = {
        $0.placeholder = ""
        if #available(iOS 12.0, *) {
            $0.textContentType = .oneTimeCode
        }
        $0.textAlignment = .center
        $0.keyboardType = .numberPad
        $0.font = FontFamily.Calibri.bold.font(size: 24.0)
        $0.textColor = GPColors.edna.color
        $0.tintColor = GPColors.homer.color
        return $0
    }(UITextField())
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TokenConfirmationWithResendButtonView {
    
    // MARK: - Internal methods
    
    func enableResendButton() {
        resendButton.isEnabled = true
    }
    
    func disableResendButton() {
        resendButton.isEnabled = false
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        backgroundColor = GPColors.maggie.color
        addComponents()
        setupTitle()
        setupTokenTextField()
        setupResendButton()
        setupContinueButton()
    }
    
    private func addComponents() {
        addSubviews([title,
                     tokenTextField,
                     resendButton,
                     continueButton], constraints: true)
    }
  
    private func setupTitle() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    private func setupTokenTextField() {
        NSLayoutConstraint.activate([
            tokenTextField.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 24),
            tokenTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tokenTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            tokenTextField.heightAnchor.constraint(equalToConstant: 56.0)
        ])
    }
    
    private func setupResendButton() {
        NSLayoutConstraint.activate([
            resendButton.topAnchor.constraint(equalTo: tokenTextField.bottomAnchor, constant: 24.0),
            resendButton.leadingAnchor.constraint(equalTo: continueButton.leadingAnchor),
            resendButton.trailingAnchor.constraint(equalTo: continueButton.trailingAnchor),
            resendButton.heightAnchor.constraint(equalToConstant: 40.0)
        ])
    }
    
    private func setupContinueButton() {
        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: resendButton.bottomAnchor, constant: 16.0),
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            continueButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16.0),
            continueButton.heightAnchor.constraint(equalToConstant: 40.0)
        ])
    }
}

