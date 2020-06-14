import UIKit

// MARK: - ButtonImages

fileprivate enum ButtonImages: String {
    case back = "gp_back"
    case close = "gp_close"
    case share = "gp_share"
}

// MARK: - Class

public class GPNavBarView: UIView {
    
    // MARK: - Enums
    
    public enum NavButtonType: Equatable {
        case back
        case close
        case none
        case backAndText(text: String)
        case closeAndText(text: String)
        case closeAndShare
    }
    
    // MARK: - Public variables
        
    public var title: String = "" {
        didSet {
            updateTitle()
        }
    }
    
    public var leftButton: UIButton?
    
    public var rightButton: UIButton?
    
    public var buttonType: NavButtonType { return _buttonType }
    
    // MARK: - Private variables
    
    private var titleView: UIView?
    
    private var titleLabel: UILabel?
    
    private var _buttonType: NavButtonType = .back
    
    private weak var bindedViewController: UIViewController?
    
    private var rightButtonContainsText: Bool {
        switch buttonType {
        case .closeAndText, .backAndText:
            return true
        default:
            return false
        }
    }
    
    // MARK: - Initializers
    
    public init(navButtonStyle: NavButtonType = .back,
                backgroundColor color: UIColor = GPColors.maggie.color,
                title: String = "") {
        
        super.init(frame: .zero)
        
        backgroundColor = color
        self.title = title
        refreshImages(navButtonStyle)
        createTitleLabel()
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GPNavBarView {
    
    // MARK: - Private methods
    
    private func setupLeftButton(image: ButtonImages) {
        let btn = leftButton ?? UIButton(type: .custom)
        btn.contentHorizontalAlignment = .left
        btn.setImage(UIImage(named: image.rawValue), for: .normal)
        btn.setTitle(nil, for: .normal)
        leftButton = btn
        if btn.superview == nil { addSubview(btn, constraints: true) }
    }
    
    private func setupRightButton(image: ButtonImages) {
        let btn = rightButton ?? UIButton(type: .custom)
        btn.contentHorizontalAlignment = .right
        btn.setImage(UIImage(named: image.rawValue), for: .normal)
        btn.setTitle(nil, for: .normal)
        rightButton = btn
        if btn.superview == nil { addSubview(btn, constraints: true) }
    }
    
    private func setupRightButton(title: String) {
        let btn = rightButton ?? UIButton(type: .custom)
        btn.titleLabel?.font = FontFamily.Calibri.regular.font(size: 14.0)
        btn.setImage(nil, for: .normal)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(GPColors.homer.color, for: .normal)
        btn.contentHorizontalAlignment = .center
        rightButton = btn
        if btn.superview == nil { addSubview(btn, constraints: true) }
    }
    
    private func createTitleLabel() {
        let lblTitle = UILabel()
        lblTitle.font = FontFamily.Calibri.regular.font(size: 20.0)
        lblTitle.textColor = GPColors.edna.color
        lblTitle.text = title
        lblTitle.textAlignment = .center
        lblTitle.numberOfLines = 1
        
        titleLabel = lblTitle
        addSubview(lblTitle, constraints: true)
    }
    
    private func createConstraints() {
        self.height(size: 56)
        
        if let titleLabel = titleLabel {
            titleLabel.centerX(to: self)
            if let leftButton = leftButton {
                 titleLabel.bottomAnchor.constraint(equalTo: leftButton.bottomAnchor).isActive = true
            }
            else {
                titleLabel.centerY(to: self)
            }
        }
        
        if let titleView = titleView {
            titleView.centerX(to: self)
            titleView.centerY(to: self)
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: 16.0).isActive = true
        }
        
        if let leftButton = leftButton {
            leftButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true
            leftButton.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
            leftButton.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        }
        
        if let rightButton = rightButton {
            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
            
            if rightButtonContainsText, let label = titleLabel {
                rightButton.lastBaselineAnchor.constraint(equalTo: label.lastBaselineAnchor).isActive = true
            } else {
                rightButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
                rightButton.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
                rightButton.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
            }
            if let label = titleLabel {
                rightButton.leadingAnchor.constraint(greaterThanOrEqualTo: label.trailingAnchor, constant: 8).isActive = true
            }
        }
    }
    
    private func updateTitle() {
        titleLabel?.text = title
    }
    
    @objc private func tappedLeftButton() {
        bindedViewController?.navigationController?.popViewController(animated: true)
    }
}

extension GPNavBarView {
    
    // MARK: - Public methods
    
    public func insert(`in` view: UIView, createBinds: Bool = false, viewController: UIViewController) {
        view.addSubview(self, constraints: true)
        applyAnchors(ofType: [.leading, .trailing], to: view)
        topAnchor.constraint(equalTo: viewController.topLayoutGuide.bottomAnchor).isActive = true
        
        clipsToBounds = true
        
        if createBinds {
            bindedViewController = viewController
            leftButton?.addTarget(self, action: #selector(tappedLeftButton), for: UIControl.Event.touchUpInside)
        }
    }
    
    public func refreshImages(_ type: NavButtonType) {
        _buttonType = type
        
        rightButton?.isHidden = false
        leftButton?.isHidden = false
        
        switch type {
            
        case .back:
            setupLeftButton(image: ButtonImages.back)
            rightButton?.isHidden = true
            
        case .close:
            setupLeftButton(image: ButtonImages.close)
            rightButton?.isHidden = true
            
        case .backAndText(let text):
            setupLeftButton(image: .back)
            setupRightButton(title: text)
            
        case .closeAndText(let text):
            setupLeftButton(image: .close)
            setupRightButton(title: text)
            
        case .closeAndShare:
            setupLeftButton(image: .close)
            setupRightButton(image: .share)
            
        case .none:
            rightButton?.isHidden = true
            leftButton?.isHidden = true
            
        }
        
        leftButton?.tintColor = GPColors.homer.color
        rightButton?.tintColor = GPColors.homer.color
    }
}
