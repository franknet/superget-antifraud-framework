import UIKit

// MARK: - Class

final public class GNCheckBoxWithDescription: UIView {
    
    // MARK: - Public variables
    
    public let checkbox = GNCheckboxButton()
    
    public let title = GPLabel(textColor: GPColors.ralph.color,
                               numberOfLines: 1)
    
    // MARK: - Initializers
    
    public init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GNCheckBoxWithDescription {
    
    // MARK: - Private methods
    
    private func setupLayout() {
        backgroundColor = GPColors.maggie.color
        addComponents()
        setupCheckbox()
        setupTitle()
    }
    
    private func addComponents() {
        addSubviews([checkbox,
                     title], constraints: true)
    }
    
    private func setupCheckbox() {
        checkbox.applyAnchors(ofType: [.top,
                                       .bottom,
                                       .leading], to: self)
    }
    
    private func setupTitle() {
        title.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor, constant: 8.0).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
        title.centerY(to: checkbox)
    }
}
