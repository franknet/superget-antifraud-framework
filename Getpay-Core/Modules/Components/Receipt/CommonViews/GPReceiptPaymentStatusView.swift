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
    
    private lazy var borderTopView = UIView()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = GPColors.lenny.color
        return view
    }()
    
    private lazy var title = GPLabel(fontSize: 14.0, alignment: .left, textColor: GPColors.flanders.color)
    
    // MARK: - Initializers
    
    public init(borderTopViewColor: UIColor? = GPColors.lenny.color) {
        super.init(frame: .zero)
        
        addComponents()
        setupConstraints()
        borderTopView.backgroundColor = borderTopViewColor
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    public func configure(title: String) {
        self.title.text = title
    }

    
    // MARK: - Private methods
    
    private func addComponents() {
        addSubviews([stack], constraints: true)
        stack.addArrangedSubview(borderTopView)
        stack.addArrangedSubview(contentView)
        
        contentView.addSubview(title, constraints: true)
    }

    private func setupConstraints() {
        borderTopView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        borderTopView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        borderTopView.heightAnchor.constraint(equalToConstant: 12.0).isActive = true
        
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0).isActive = true
        title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0).isActive = true
        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0).isActive = true
        
        stack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
