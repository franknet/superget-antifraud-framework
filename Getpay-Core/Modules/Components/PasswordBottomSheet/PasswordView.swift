import UIKit

// MARK: - Class

public final class PasswordView: UIView {
    
    // MARK: - Internal variables
        
    lazy var title = GPLabel(text: "Digite a senha do seu cartão SuperGet",
                             fontSize: 16.0,
                             alignment: .center,
                             textColor: GPColors.ralph.color)

    lazy var passwordTextField: UITextField = {
        $0.placeholder = "● ● ● ●"
        $0.isSecureTextEntry = true
        $0.textAlignment = .center
        $0.keyboardType = .numberPad
        $0.font = FontFamily.Calibri.bold.font(size: 24.0)
        $0.textColor = GPColors.edna.color
        return $0
    }(UITextField())

    lazy var revealButton: UIButton = {
        let normalImage = GPAssets.gpShowPass.image.withRenderingMode(.alwaysTemplate)
        let selectedImage = GPAssets.gpHidePass.image.withRenderingMode(.alwaysTemplate)
        $0.setImage(normalImage, for: .normal)
        $0.setImage(selectedImage, for: .selected)
        $0.tintColor = GPColors.heyman.color
        return $0
    }(UIButton())
    
    lazy var continueButton = GPButton(title: "CONTINUAR",
                                       style: .filled)
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PasswordView {
    
    // MARK: - Private methods
    
    private func setupLayout() {
        backgroundColor = GPColors.maggie.color
        addComponents()
        setupTitle()
        setupPasswordTextField()
        setupRevealButton()
        setupContinueButton()
    }
    
    private func addComponents() {
        addSubviews([title,
                     passwordTextField,
                     revealButton,
                     continueButton], constraints: true)
    }
  
    private func setupTitle() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    private func setupPasswordTextField() {
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 24),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40.0)
        ])
    }
    
    private func setupRevealButton() {
        NSLayoutConstraint.activate([
            revealButton.heightAnchor.constraint(equalToConstant: 24.0),
            revealButton.widthAnchor.constraint(equalToConstant: 24.0),
            revealButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor, constant: -2.0),
            revealButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor)
        ])
    }
    
    private func setupContinueButton() {
        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24.0),
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            continueButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16.0),
            continueButton.heightAnchor.constraint(equalToConstant: 40.0)
        ])
    }
}

