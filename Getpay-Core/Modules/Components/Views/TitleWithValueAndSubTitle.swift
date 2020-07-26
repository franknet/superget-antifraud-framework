import UIKit

public class TitleWithValueAndSubTitle: UIView {
    
    // MARK: - Private variables
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillEqually
        stack.spacing = 4.0
        return stack
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = GPColors.flanders.color
        label.font = FontFamily.Calibri.regular.font(size: 16.0)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var value: UILabel = {
        let label = UILabel()
        label.textColor = GPColors.edna.color
        label.font = FontFamily.Calibri.bold.font(size: 20.0)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = GPColors.flanders.color
        label.font = FontFamily.Calibri.regular.font(size: 16.0)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Initializers
    
    public init() {
        super.init(frame: .zero)
        addComponents()
        setupConstraints()
        backgroundColor = GPColors.maggie.color
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    public func configure(title: String, value: String, description: String?) {
        self.title.text = title
        self.value.text = value
        if let description = description {
            descriptionLabel.text = description
            descriptionLabel.isHidden = false
        } else {
            descriptionLabel.isHidden = true
        }
    }
    
    // MARK: - Private methods
    
    private func addComponents() {
        addSubviews([title, stack], constraints: true)
        stack.addArrangedSubview(value)
        stack.addArrangedSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        title.topAnchor.constraint(equalTo: topAnchor, constant: 16.0).isActive = true
        title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
        
        stack.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8).isActive = true
        stack.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: title.trailingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0).isActive = true
    }
}
