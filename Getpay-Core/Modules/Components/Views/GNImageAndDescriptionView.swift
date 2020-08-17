import UIKit

// MARK: - Class

public class GNImageAndDescriptionView: UIView {
    
    // MARK: - Private variables
    
    private let icon: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    private let descriptionLabel = GPLabel(fontSize: 16.0,
                                           textColor: GPColors.ralph.color)
    
    // MARK: - Initializers
    
    public init(image: UIImage, description: String, backgroundColor: UIColor? = GPColors.maggie.color) {
        super.init(frame: .zero)
        setupLayout()
        configure(image: image, description: description, backgroundColor: backgroundColor)
    }
    
    public init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    public func configure(image: UIImage, description: String, backgroundColor: UIColor? = GPColors.maggie.color) {
        icon.image = image
        descriptionLabel.text = description
        self.backgroundColor = backgroundColor
    }
}

// MARK: - Private methods

extension GNImageAndDescriptionView {
    
    private func setupLayout() {
        addComponents()
        setupIcon()
        setupDescription()
    }
    
    private func addComponents() {
        addSubviews([icon,
                     descriptionLabel], constraints: true)
    }
    
    private func setupIcon() {
        icon.height(size: 64.0)
        icon.width(size: 64.0)
        icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true
        icon.topAnchor.constraint(equalTo: topAnchor, constant: 16.0).isActive = true
        icon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0).isActive = true
    }
    
    private func setupDescription() {
        descriptionLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 16.0).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
        descriptionLabel.centerYAnchor.constraint(equalTo: icon.centerYAnchor).isActive = true
    }
    
}
