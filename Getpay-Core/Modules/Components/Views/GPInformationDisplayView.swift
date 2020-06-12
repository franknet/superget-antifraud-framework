
import UIKit

// MARK: - Class
public class GPInformationDisplayView: UIView {
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
    private let errorCode: UILabel = {
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
    private let button: GPRoundedButton = {
        let button = GPRoundedButton()
        button.titleLabel?.font = FontFamily.Calibri.light.font(size: 14.0)
        button.setTitleColor(.white, for: .normal)
        button.backgroundImageColor = GPColors.homer.color
        button.cornerRadius = 20.0
        return button
    }()
    // MARK: - Public variables
    public var buttonAction: ActionVoid?
    // MARK: - Initializers
    
    @discardableResult public convenience init(preset: InformationViewPreset) {
        self.init()
        backgroundColor = .white
        self.titleMessage.text = preset.title
        self.subtitleMessage.text = preset.subTitle
        self.errorCode.text = preset.errorCode
        self.icon.image = preset.image
        self.buttonAction = preset.buttonAction
        self.button.isHidden = buttonAction == nil
        self.button.setTitle(preset.buttonTitle, for: .normal)
        if let inView = preset.inView {
            inView.addSubview(self, constraints: true)
            self.applyAnchors(ofType: [.leading, .trailing, .top, .bottom], to: inView)
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
}
extension GPInformationDisplayView {
    // MARK: - Private methods
    private func createSubviews() {
        contentView.addSubviews(
            [icon,
             titleMessage,
             subtitleMessage,
             errorCode,
             button], constraints: true)
        addSubview(contentView, constraints: true)
    }
    private func createConstraints() {
        icon.heightAnchor.constraint(greaterThanOrEqualToConstant: 100.0).isActive = true
        icon.heightAnchor.constraint(lessThanOrEqualToConstant: 140).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 140.0).isActive = true
        icon.centerXAnchor.constraint(equalTo: titleMessage.centerXAnchor).isActive = true
        icon.applyAnchors(ofType: [.top], to: contentView)
        titleMessage.applyAnchors(ofType: [.leading, .trailing], to: contentView)
        titleMessage.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 42.0).isActive = true
        subtitleMessage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21.0).isActive = true
        subtitleMessage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21.0).isActive = true
        subtitleMessage.topAnchor.constraint(equalTo: titleMessage.bottomAnchor, constant: 21.0).isActive = true
        errorCode.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21.0).isActive = true
        errorCode.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21.0).isActive = true
        errorCode.topAnchor.constraint(equalTo: subtitleMessage.bottomAnchor, constant: 10).isActive = true
        button.topAnchor.constraint(equalTo: subtitleMessage.bottomAnchor, constant: 40.0).isActive = true
        button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        button.applyAnchors(ofType: [.bottom], to: contentView)
        button.widthAnchor.constraint(equalToConstant: 132.0).isActive = true
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
    }

}
