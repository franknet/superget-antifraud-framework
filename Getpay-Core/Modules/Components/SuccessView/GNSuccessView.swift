import UIKit

// MARK: - Class

public class GNSuccessView: UIView {
    
    // MARK: - Private variables
    
    private let container = UIView()
    
    private let title = GPLabel(font: FontFamily.Calibri.bold,
                                fontSize: 24.0,
                                alignment: .center)
    
    private let subTitle = GPLabel(fontSize: 16.0,
                                   alignment: .center,
                                   textColor: GPColors.ralph.color)
    
    private lazy var stackTitle: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 24.0
        stack.alignment = .center
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let successContainer = UIView()
    
    // MARK: - Internal variables
    
    lazy var successImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = GPAssets.gpSucsess.image
        return imageView
    }()
    
    // MARK: - Initializers
    
    public init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder _: NSCoder) {
        super.init(frame: .zero)
        setupLayout()
    }
}

extension GNSuccessView {
    
    // MARK: - Public methods
    
    public func configure(title: String, subTitle: String? = nil) {
        self.title.text = title
        
        if let subTitle = subTitle {
            self.subTitle.text = subTitle
            self.subTitle.isHidden = false
        } else {
            self.subTitle.isHidden = true
        }
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        addComponents()
        setupConstraints()
        backgroundColor = GPColors.maggie.color
    }
    
    private func addComponents() {
        container.addSubviews([title,
                               successContainer,
                               stackTitle], constraints: true)
        
        stackTitle.addArrangedSubview(title)
        stackTitle.addArrangedSubview(subTitle)
        
        successContainer.addSubview(successImageView, constraints: true)
        
        addSubview(container, constraints: true)
    }
    
    private func setupConstraints() {
        container.applyAnchors(ofType: [.centerY, .leading, .trailing], to: self)
        
        successContainer.applyAnchors(ofType: [.centerX, .top], to: container)
        successContainer.height(size: 214.0)
        successContainer.width(size: 214.0)
        
        stackTitle.topAnchor.constraint(equalTo: successContainer.bottomAnchor).isActive = true
        stackTitle.applyAnchors(ofType: [.bottom, .centerX], to: container)
        stackTitle.leadingAnchor.constraint(greaterThanOrEqualTo: container.leadingAnchor, constant: 16.0).isActive = true
        stackTitle.trailingAnchor.constraint(lessThanOrEqualTo: container.trailingAnchor, constant: -16.0).isActive = true
        
        successImageView.applyAnchors(ofType: [.centerY, .centerX], to: successContainer)
        successImageView.height(size: 55.0)
        successImageView.width(size: 55.0)
    }
}
