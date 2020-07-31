import UIKit

// MARK: - Class

public class GNCircleViewWithIcon: UIView {
    
    // MARK: - Private variables
    
    private let icon = UIImageView()
    
    // MARK: - Initializers
    
    public init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override methods
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.size.width/2
    }
    
    // MARK: - Public methods
    
    public func configure(icon: UIImage, backgroundColor: UIColor, tintColor: UIColor) {
        self.icon.image = icon
        self.icon.tintColor = tintColor
        self.backgroundColor = backgroundColor
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        addComponents()
        setupIcon()
    }
    
    private func addComponents() {
        addSubview(icon, constraints: true)
    }
    
    private func setupIcon(){
        icon.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        icon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        icon.width(size: 24.0)
        icon.height(size: 24.0)
    }
}
