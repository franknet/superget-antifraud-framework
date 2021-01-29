import UIKit

// MARK: - Class

public final class TokenConfirmationView: UIView {
    
    // MARK: - Internal Variables
        
    lazy var title = GPLabel(text: "Digite o código de verificação.",
                             fontSize: 16.0,
                             alignment: .center,
                             textColor: GPColors.ralph.color)
    
    lazy var continueButton = GPButton(title: "CONTINUAR",
                                       style: .filled)
    
    // MARK: - Public Variables
    
    public lazy var tokenTextField: UITextField = {
        $0.placeholder = ""
        if #available(iOS 12.0, *) {
            $0.textContentType = .oneTimeCode
        }
        $0.textAlignment = .center
        $0.keyboardType = .default
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

extension TokenConfirmationView {
    
    // MARK: - Private methods
    
    private func setupLayout() {
        backgroundColor = GPColors.maggie.color
        addComponents()
        setupTitle()
        setupTokenTextField()
        setupContinueButton()
    }
    
    private func addComponents() {
        addSubviews([title,
                     tokenTextField,
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
    
    private func setupContinueButton() {
        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: tokenTextField.bottomAnchor, constant: 24.0),
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            continueButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16.0),
            continueButton.heightAnchor.constraint(equalToConstant: 40.0)
        ])
    }
}

