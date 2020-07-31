import UIKit

// MARK: - Class

public class GPReceiptPaymentStatusView: UIView {
    
    // MARK: - Private variables
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var title = GPLabel(fontSize: 12.0, alignment: .center, textColor: GPColors.milhouse.color)
    
    // MARK: - Initializers
    
    public init() {
        super.init(frame: .zero)
        
        addComponents()
        setupConstraints()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    public func configure(title: String) {
        self.title.text = title
        self.title.backgroundColor = GPColors.lenny.color
    }

    
    // MARK: - Private methods
    
    private func addComponents() {
        addSubviews([stack], constraints: true)
        stack.addArrangedSubview(title)
    }

    private func setupConstraints() {
        title.topAnchor.constraint(equalTo: topAnchor, constant: 8.0).isActive = true
        title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0).isActive = true
        title.heightAnchor.constraint(equalToConstant: 30).isActive = true
        title.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        stack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
