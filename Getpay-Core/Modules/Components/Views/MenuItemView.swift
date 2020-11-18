import UIKit
import SkeletonView

// MARK: - Class

final public class MenuItemView: UIView {
    
    // MARK: - Public variables
    
    public let title: GPLabel = {
        let title = GPLabel(alignment: .center,
                            textColor: GPColors.ralph.color)
        title.isSkeletonable = true
        return title
    }()
    
    public let iconView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "#FDE8E9")
        view.layer.cornerRadius = 16.0
        view.isSkeletonable = true
        return view
    }()
    
    public let icon: UIImageView = {
        let icon = UIImageView()
        icon.tintColor = GPColors.homer.color
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    // MARK: - Initializers
    
    public init() {
        super.init(frame: .zero)
        setupLayout()
        isSkeletonable = true
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuItemView {
    
    // MARK: - Public methods
    
    public func configure(title: String, icon: UIImage) {
        self.title.text = title
        self.icon.image = icon
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        addComponents()
        setupIconView()
        setupIcon()
        setupTitle()
    }
    
    private func addComponents() {
        addSubviews([iconView,
                     title], constraints: true)
        iconView.addSubview(icon, constraints: true)
    }
    
    private func setupIconView() {
        iconView.height(size: 48.0)
        iconView.width(size: 48.0)
        iconView.centerX(to: self)
        iconView.topAnchor.constraint(equalTo: topAnchor, constant: 16.0).isActive = true
    }
    
    private func setupIcon() {
        icon.width(size: 24.0)
        icon.height(size: 24.0)
        icon.centerX(to: iconView)
        icon.centerY(to: iconView)
    }
    
    private func setupTitle() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 12.0),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0)
        ])
    }
}
