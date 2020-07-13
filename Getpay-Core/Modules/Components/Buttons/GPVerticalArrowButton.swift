import UIKit

// MARK: - Class

public class GPVerticalArrowButton: UIButton {
    
    // MARK: - Public variables
    
    public var isExpanded: Bool = false {
        didSet {
            let transform = isExpanded ? CGAffineTransform(rotationAngle: (180.0 * .pi) / 180) : .identity
            rotateImage(with: transform)
        }
    }
    
    // MARK: - Initializers
    
    public init() {
        super.init(frame: .zero)
        self.common()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override methods
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layoutButtonImage()
    }
    
    // MARK: - Internal methods
    
    func common() {
        self.height(size: 24.0)
        self.width(size: 24.0)
        let imageView = UIImageView(image: GPAssets.gpDown.image)
        self.tintColor = GPColors.homer.color
        self.setImage(imageView.image, for: .normal)
    }
    
    // MARK: - Private methods
    
    private func layoutButtonImage() {
        if let imageView = self.imageView,
            let titleLabel = self.titleLabel {
            
            imageView.contentMode = .scaleAspectFit
            titleEdgeInsets = UIEdgeInsets(top: 0,
                                           left: -imageView.frame.width,
                                           bottom: 0,
                                           right: imageView.frame.size.width)
            imageEdgeInsets = UIEdgeInsets(top: 0,
                                           left: titleLabel.frame.size.width,
                                           bottom: 0,
                                           right: -titleLabel.frame.size.width)
        }
    }
    
    private func rotateImage(with transform: CGAffineTransform) {
        UIView.animateWithDefaultDuration( {
            self.imageView?.transform = transform
            self.layoutIfNeeded()
        })
    }
}
