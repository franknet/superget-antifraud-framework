import UIKit

// MARK: - Class

final class OnboardingStepView: UIView {
    
    // MARK: - Private variables
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let title = GPLabel(font: FontFamily.Calibri.bold,
                                fontSize: 24,
                                alignment: .center)
    
    private let subTitle = GPLabel(fontSize: 16,
                                   alignment: .center,
                                   textColor: GPColors.ralph.color)
    
    private let container = UIView()
    
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension OnboardingStepView {
    
    // MARK: - Internal methods
    
    func configure(image: UIImage,
                   title: String,
                   subTitle: String) {
        
        imageView.image = image
        self.title.text = title
        self.subTitle.text = subTitle
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        backgroundColor = .clear
        addComponents()
        setupImageView()
        setupContainer()
    }
    
    private func addComponents() {
        container.addSubviews([imageView,
                               title,
                               subTitle], constraints: true)
        addSubview(container, constraints: true)
    }
    
    private func setupImageView() {
        imageView.width(size: 262.0)
        imageView.height(size: 316.0)
        
        imageView.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        imageView.centerX(to: container)
    }
    
    private func setupContainer() {
        setupTitle()
        setupSubTitle()
        
        container.centerY(to: self)
        container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
        container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true
    }
    
    private func setupTitle() {
        title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16.0).isActive = true
        title.applyAnchors(ofType: [.trailing,
                                    .leading], to: container)
    }
    
    private func setupSubTitle() {
        subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16.0).isActive = true
        subTitle.applyAnchors(ofType: [.trailing,
                                       .bottom,
                                       .leading], to: container)
    }
}
