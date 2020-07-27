import UIKit

// MARK: - Class

public class GPNavBarView: UIView {
    
    // MARK: - Enums
    
    public enum NavButtonType: Equatable {
        /** < _ */
        case back
        /** x _ */
        case close
        /** _ _ */
        case none
        /** < _ Texto */
        case backAndText(text: String)
        /** x _  Texto */
        case closeAndText(text: String)
        /** x _  Share */
        case closeAndShare
        /** _ _  Text */
        case titleAndText(text: String)
        /** x _ Camera */
        case closeAndCamera
    }
    
    // MARK: - Private variables
    
    private var containerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 32.0
        stack.distribution = .fill
        stack.alignment = .center
        return stack
    }()
    
    private var _buttonType: NavButtonType = .back
    
    private var rightButtonContainsText: Bool {
        switch buttonType {
        case .closeAndText, .backAndText, .titleAndText:
            return true
        default:
            return false
        }
    }
    
    // MARK: - Public variables
    
    public let title = GPLabel(fontSize: 20.0, alignment: .left, textColor: GPColors.edna.color, numberOfLines: 1)
    
    public let leftButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = GPColors.homer.color
        return button
    }()
    
    public let rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = GPColors.homer.color
        return button
    }()
    
    public var buttonType: NavButtonType { return _buttonType }
    
    
    // MARK: - Initializers
    
    public init(navButtonStyle: NavButtonType = .back,
                backgroundColor color: UIColor = GPColors.maggie.color,
                title: String = "") {
        
        super.init(frame: .zero)
        self.title.text = title
        backgroundColor = color
        refreshImages(navButtonStyle)
        addComponents()
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GPNavBarView {
    
    // MARK: - Private methods
    
    private func addComponents() {
        addSubview(containerStack, constraints: true)
        containerStack.addArrangedSubview(leftButton)
        containerStack.addArrangedSubview(title)
        containerStack.addArrangedSubview(rightButton)
        
        containerStack.applyAnchors(ofType: [.top, .bottom], to: self)
        containerStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true
        containerStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
    }
    
    private func createConstraints() {
        self.height(size: 56)
        
        leftButton.leadingAnchor.constraint(equalTo: containerStack.leadingAnchor).isActive = true
        leftButton.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        
        if rightButtonContainsText {
            rightButton.widthAnchor.constraint(equalToConstant: 74.0).isActive = true
            rightButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        } else {
            rightButton.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
            rightButton.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        }
        rightButton.trailingAnchor.constraint(equalTo: containerStack.trailingAnchor).isActive = true
    }
    
    private func setupLeftButton(image: UIImage) {
        leftButton.contentHorizontalAlignment = .left
        leftButton.setImage(image, for: .normal)
        leftButton.setTitle(nil, for: .normal)
    }
    
    private func setupRightButton(image: UIImage) {
        rightButton.contentHorizontalAlignment = .right
        rightButton.setImage(image, for: .normal)
        rightButton.setTitle(nil, for: .normal)
    }
    
    private func setupRightButton(title: String) {
        rightButton.titleLabel?.font = FontFamily.Calibri.regular.font(size: 14.0)
        rightButton.setImage(nil, for: .normal)
        rightButton.setTitle(title, for: .normal)
        rightButton.setTitleColor(GPColors.homer.color, for: .normal)
        rightButton.contentHorizontalAlignment = .right
    }
    
    // MARK: - Public methods
    
    public func refreshImages(_ type: NavButtonType) {
        _buttonType = type
        
        rightButton.isHidden = false
        leftButton.isHidden = false
        
        switch type {
            
        case .back:
            setupLeftButton(image: GPAssets.gpBack.image)
            rightButton.isHidden = true
            
        case .close:
            setupLeftButton(image: GPAssets.gpClose.image)
            rightButton.isHidden = true
            
        case .backAndText(let text):
            setupLeftButton(image: GPAssets.gpBack.image)
            setupRightButton(title: text)
            
        case .closeAndText(let text):
            setupLeftButton(image: GPAssets.gpClose.image)
            setupRightButton(title: text)
            
        case .closeAndShare:
            setupLeftButton(image: GPAssets.gpClose.image)
            setupRightButton(image: GPAssets.gpShare.image)
            
        case .none:
            rightButton.isHidden = true
            leftButton.isHidden = true
            
        case .titleAndText(let text):
            leftButton.isHidden = true
            setupRightButton(title: text)
            
        case .closeAndCamera:
            setupLeftButton(image: GPAssets.gpClose.image)
            setupRightButton(image: GPAssets.gpCameraBoleto.image)
        }
    }
}
