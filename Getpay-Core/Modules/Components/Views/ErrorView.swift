import UIKit

public typealias ActionVoid = () -> Void

// MARK: - Class

public class ErrorView: UIView {
    
    // MARK: - Private variables
    
    private let icon: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let titleMessage: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = FontFamily.Calibri.bold.font(size: 24.0)
        label.textColor = GPColors.barney.color
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleMessage: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = FontFamily.Calibri.regular.font(size: 16.0)
        label.textColor = GPColors.ralph.color
        label.numberOfLines = 0
        return label
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    // MARK: - Public variables
    
    public let button: UIButton = {
        let button = UIButton()
        button.setTitle("TENTAR NOVAMENTE", for: .normal)
        button.titleLabel?.font = FontFamily.Calibri.light.font(size: 14.0)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = GPColors.homer.color
        button.layer.cornerRadius = 20.0
        button.layer.masksToBounds = true
        return button
    }()
    
    public var buttonAction: ActionVoid?
    
    // MARK: - Initializers
    
    @discardableResult public convenience init(title: String,
                                               subTitle: String,
                                               image: UIImage?,
                                               inView: UIView?,
                                               buttonAction: ActionVoid?) {
        self.init()
        
        titleMessage.text = title
        subtitleMessage.text = subTitle
        icon.image = image
        
        if let inView = inView {
            inView.addSubview(self, constraints: true)
            self.applyAnchors(ofType: [.leading, .trailing, .top, .bottom], to: inView)
        }
        
        self.buttonAction = buttonAction
        
        if buttonAction == nil {
            button.isHidden = true
        }
        
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
        createConstraints()
        createBinds()
    }
    
    public init() {
        super.init(frame: .zero)
        createSubviews()
        createConstraints()
        createBinds()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func createSubviews() {
        contentView.addSubviews([icon,
                     titleMessage,
                     subtitleMessage,
                     button], constraints: true)
        
        addSubview(contentView, constraints: true)
    }
    
    private func createConstraints() {
        icon.heightAnchor.constraint(equalToConstant: 140.0).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 140.0).isActive = true
        icon.centerXAnchor.constraint(equalTo: titleMessage.centerXAnchor).isActive = true
        icon.applyAnchors(ofType: [.top], to: contentView)
        
        titleMessage.applyAnchors(ofType: [.leading, .trailing], to: contentView)
        titleMessage.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 42.0).isActive = true
        
        subtitleMessage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21.0).isActive = true
        subtitleMessage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21.0).isActive = true
        subtitleMessage.topAnchor.constraint(equalTo: titleMessage.bottomAnchor, constant: 21.0).isActive = true
        
        button.topAnchor.constraint(equalTo: subtitleMessage.bottomAnchor, constant: 40.0).isActive = true
        button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        button.applyAnchors(ofType: [.bottom], to: contentView)
        button.widthAnchor.constraint(equalToConstant: 186.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        contentView.applyAnchors(ofType: [.centerY], to: self)
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28.0).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28.0).isActive = true
    }
    
    // MARK: - Internal methods
    
    func createBinds() {
        button.addTarget(self,
                         action: #selector(tappedButton),
                         for: .touchUpInside)
    }
    
    @objc func tappedButton() {
        if let buttonAction = buttonAction {
            buttonAction()
        }
        removeFromSuperview()
    }
}
