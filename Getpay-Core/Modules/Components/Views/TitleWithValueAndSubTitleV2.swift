import UIKit

// MARK: - Class

public final class TitleWithValueAndSubTitleV2: UIView {
    
    // MARK: - Private variables
    
    private lazy var stack: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fillEqually
        $0.spacing = 4.0
        return $0
    }(UIStackView())
    
    private lazy var title = GPLabel(fontSize: 16.0,
                                     textColor: GPColors.flanders.color)
    
    private lazy var value = GPLabel(font: FontFamily.Calibri.bold,
                                     fontSize: 20.0)
    
    private lazy var descriptionOne = GPLabel(fontSize: 16.0,
                                              textColor: GPColors.flanders.color)
    
    private lazy var descriptionTwo = GPLabel(fontSize: 16.0,
                                              textColor: GPColors.flanders.color)
    
    // MARK: - Initializers
    
    public init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    public func configure(title: String,
                          value: String,
                          descriptionOne: String? = nil,
                          descriptionTwo: String? = nil) {
        self.title.text = title
        self.value.text = value
        
        if let descriptionOne = descriptionOne {
            self.descriptionOne.text = descriptionOne
            self.descriptionOne.isHidden = false
        } else {
            self.descriptionOne.isHidden = true
        }
        
        if let descriptionTwo = descriptionTwo {
            self.descriptionTwo.text = descriptionTwo
            self.descriptionTwo.isHidden = false
        } else {
            self.descriptionTwo.isHidden = true
        }
    }
}

extension TitleWithValueAndSubTitleV2 {
    
    // MARK: - Private methods
    
    private func setupLayout() {
        addComponents()
        setupConstraints()
        backgroundColor = GPColors.maggie.color
    }
    
    private func addComponents() {
        addSubviews([title,
                     stack], constraints: true)
        stack.addArrangedSubview(value)
        stack.addArrangedSubview(descriptionOne)
        stack.addArrangedSubview(descriptionTwo)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            stack.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            
            stack.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0)
        ])
    }
}
