import UIKit

// MARK: - Class

public class UserAliasView: UIView {
    
    // MARK: - Private variables
    
    private let title = GPLabel(text: "Nome do usuário",
                                font: FontFamily.Calibri.bold,
                                fontSize: 24.0,
                                alignment: .center)
    
    private let subTitle = GPLabel(text: "Escolha um nome de usuário para sua conta",
                                   fontSize: 16.0,
                                   textColor: GPColors.ralph.color)
    
    // MARK: - Internal variables
    
    let userAliasTextfield: UITextField = {
        let tf = UITextField()
        tf.textColor = GPColors.edna.color
        tf.textAlignment = .left
        tf.font = FontFamily.Calibri.bold.font(size: 20.0)
        tf.placeholder = "maria.gomes"
        return tf
    }()
    
    let proceed = GPButton(title: "FINALIZAR CADASTRO", style: .filled)
    
    let statusContainer = UIView()
    
    let statusTitle = GPLabel(text: "Apenas letras, números, pontos ou sublinhados são permitidos",
                              textColor: GPColors.flanders.color)
    
    let statusIcon: UIImageView = {
        let image = GPAssets.gpAlert.image
        let imageView = UIImageView()
        imageView.image = image
        imageView.tintColor = GPColors.milhouse.color
        return imageView
    }()
    
    let prefix = GPLabel(text: "@",
                         font: FontFamily.Calibri.bold,
                         fontSize: 20.0,
                         alignment: .center,
                         textColor:  UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0))
    
    let containerPrefix: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 1, width: 18, height: 20))
        view.backgroundColor = .clear
        return view
    }()
    
    // MARK: - Initializers
    
    public init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        super.init(frame: .zero)
    }
}

// MARK: - Private methos

extension UserAliasView {
    
    private func setupLayout() {
        addComponents()
        setupTitleConstraints()
        setupSubTitleConstraints()
        setupUserAliasTextfieldConstraints()
        setupStatusContainerConstraints()
        setupStatusIconConstraints()
        setupStatusTitleConstraints()
        setupPrefix()
        proceedConstraints()
        
        backgroundColor = GPColors.maggie.color
    }
    
    private func addComponents() {
        addSubviews([title,
                     subTitle,
                     userAliasTextfield,
                     proceed,
                     statusContainer], constraints: true)
        
        statusContainer.addSubviews([statusIcon,
                                     statusTitle], constraints: true)
        
        containerPrefix.addSubview(prefix, constraints: true)
    }
    
    private func setupTitleConstraints() {
        title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27.0).isActive = true
        title.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func setupSubTitleConstraints() {
        subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 40.0).isActive = true
        subTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true
        subTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
    }
    
    private func setupUserAliasTextfieldConstraints() {
        userAliasTextfield.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 40.0).isActive = true
        userAliasTextfield.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true
        userAliasTextfield.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
        
        userAliasTextfield.leftView = containerPrefix
        userAliasTextfield.leftViewMode = .always
    }
    
    private func setupStatusContainerConstraints() {
        statusContainer.topAnchor.constraint(equalTo: userAliasTextfield.bottomAnchor, constant: 20.0).isActive = true
        statusContainer.applyAnchors(ofType: [.leading, .trailing], to: self)
    }
    
    private func setupStatusIconConstraints() {
        statusIcon.widthAnchor.constraint(equalToConstant: 16.0).isActive = true
        statusIcon.heightAnchor.constraint(equalToConstant: 16.0).isActive = true
        statusIcon.leadingAnchor.constraint(equalTo: statusContainer.leadingAnchor, constant: 20.0).isActive = true
        statusIcon.topAnchor.constraint(equalTo: statusTitle.topAnchor).isActive = true
    }
    
    private func setupStatusTitleConstraints() {
        statusTitle.leadingAnchor.constraint(equalTo: statusIcon.trailingAnchor, constant: 10.0).isActive = true
        statusTitle.trailingAnchor.constraint(equalTo: statusContainer.trailingAnchor, constant: -10.0).isActive = true
        statusTitle.topAnchor.constraint(equalTo: statusContainer.topAnchor, constant: 5.0).isActive = true
        statusTitle.bottomAnchor.constraint(equalTo: statusContainer.bottomAnchor, constant: -5.0).isActive = true
    }
    
    private func proceedConstraints() {
        proceed.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        proceed.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true
        proceed.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
        proceed.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16.0).isActive = true
    }
    
    private func setupPrefix() {
        prefix.applyAnchors(ofType: [.top,
                                     .leading,
                                     .trailing,
                                     .bottom], to: containerPrefix)
        prefix.sizeToFit()
    }
}
