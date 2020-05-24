import UIKit

// MARK: - Class

public class CircleViewWithLabel: UIView {
    
    // MARK: - Public variables
    
    public let title: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Calibri.light.font(size: 16.0)
        label.textColor = GPColors.maggie.color
        label.textAlignment = .center
        return label
    }()
    
    public var color = UIColor()
    
    // MARK: - Initializers
    
    public init() {
        super.init(frame: .zero)
        addComponents()
        setupLayout()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.size.width/2
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        setupTitle()
    }
    
    private func addComponents() {
        addSubview(title, constraints: true)
    }
    
    private func setupTitle(){
        title.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
}
