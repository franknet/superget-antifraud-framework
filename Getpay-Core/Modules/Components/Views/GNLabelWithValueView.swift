import UIKit

// MARK: - Class

public class GNLabelWithValueView: UIView {
    
    // MARK: - Public variables
    
    public let label = GPLabel(fontSize: 16.0,
                                alignment: .center,
                                textColor: GPColors.flanders.color,
                                numberOfLines: 1)
    
    public let value = GPLabel(font: FontFamily.Calibri.bold,
                                fontSize: 20.0,
                                alignment: .center)
    
    // MARK: - Initializers
    
    public init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    public func configure(label: String,
                          value: String,
                          backgroundColor: UIColor = GPColors.maggie.color) {
        self.label.text = label
        self.value.text = value
        self.backgroundColor = backgroundColor
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        addComponents()
        setupConstraints()
    }
    
    private func addComponents() {
        addSubviews([label, value], constraints: true)
    }
    
    private func setupConstraints() {
        label.applyAnchors(ofType: [.top,
                                    .leading,
                                    .trailing], to: self)
    
        value.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8.0).isActive = true
        value.applyAnchors(ofType: [.leading, .trailing, .bottom], to: self)
    }
}
