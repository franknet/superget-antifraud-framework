import UIKit

// MARK: - Class

public class GPButton: UIButton {
    
    // MARK: - Public variables
    
    public enum Style {
        case filled
        case outlined
        case text
    }
    
    public var buttonStyle: Style = Style.filled {
        didSet {
            updateLayout()
        }
    }
    
    override public var isEnabled: Bool {
        didSet {
            updateLayout()
        }
    }
    
    override open var isHighlighted: Bool {
        didSet {
            updateLayout()
        }
    }
    
    // MARK: - Initializers
    
    public init(title: String? = nil, fontSize: CGFloat? = 14.0, style: Style, horizontalAlignment: UIControl.ContentHorizontalAlignment = .center) {
        super.init(frame: .zero)
        
        setTitle(title, for: UIControl.State.normal)
        guard let size = fontSize else { return }
        titleLabel?.font = FontFamily.Calibri.regular.font(size: size)
        contentHorizontalAlignment = horizontalAlignment
        buttonStyle = style
        
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}

extension GPButton {
    
    // MARK: - Private variables
    
    private func commonInit() {
        layer.cornerRadius = 20.0
        titleLabel?.textAlignment = .center
        updateLayout()
    }
    
    private func updateLayout() {
        switch buttonStyle {
            
        case .filled:
            let color = isEnabled ? GPColors.maggie.color : GPColors.krusty.color
            setTitleColor(color, for: .normal)
            alpha = isHighlighted ? 0.6 : 1.0
            backgroundColor = isEnabled ? GPColors.homer.color : GPColors.maggie.color
            layer.borderWidth = isEnabled ? 0 : 1.0
            layer.borderColor = isEnabled ? UIColor.clear.cgColor : GPColors.krusty.color.cgColor
            
        case .outlined:
            let color = isEnabled ? GPColors.homer.color : GPColors.krusty.color
            setTitleColor(color, for: .normal)
            backgroundColor = isHighlighted ? UIColor.hexStringToUIColor(hex: "#FDE8E9") : GPColors.maggie.color
            layer.borderWidth = 1.0
            layer.borderColor = isEnabled ? GPColors.homer.color.cgColor : GPColors.krusty.color.cgColor
            
        case .text:
            let color = isEnabled ? GPColors.homer.color : GPColors.krusty.color
            setTitleColor(color, for: .normal)
            backgroundColor = isHighlighted ? UIColor.hexStringToUIColor(hex: "#FDE8E9") : UIColor.clear
            layer.borderWidth = 0
            layer.borderColor = UIColor.clear.cgColor
        }
    }
}
