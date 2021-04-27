import UIKit

// MARK: - Class

public class GPExpandView: UIView {
    
    // MARK: - Public variables
    
    public weak var parentViewToAnimate: UIView?
    
    public lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Calibri.regular.font(size: 16.0)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = GPColors.ralph.color
        return label
    }()
    
    // MARK: - Internal variables
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 4
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    
    lazy var titleContainerView = UIView()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Calibri.bold.font(size: 16.0)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = GPColors.edna.color
        return label
    }()
    
    lazy var expandButton = GPVerticalArrowButton()
    
    let descriptionContainerView = UIView()
    
    lazy var lineSeparatorView: UIView = {
        let view = UIView()
        view.height(size: 1)
        view.backgroundColor = GPColors.moe.color
        return view
    }()
    
    // MARK: - Private variables
    
    private var descriptionLabelHeightConstraint: NSLayoutConstraint?
    
    // MARK: - Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        backgroundColor = GPColors.maggie.color
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    public func configure(title: String, description: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5.0
        let attributedString = NSMutableAttributedString(string: description)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        descriptionLabel.attributedText = attributedString
        
        self.titleLabel.text = title
    }
    
    // MARK: - Internal methods
    
    func setupView() {
        addSubviews([stackView, lineSeparatorView], constraints: true)
        
        stackView.addArrangedSubview(titleContainerView)
        stackView.addArrangedSubview(descriptionContainerView)
        
        titleContainerView.addSubviews([titleLabel, expandButton], constraints: true)
        
        expandButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        expandButton.addTarget(self, action: #selector(expandAction), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(expandAction))
        addGestureRecognizer(tap)
        
        descriptionContainerView.layer.masksToBounds = true
        descriptionContainerView.addSubview(descriptionLabel, constraints: true)
        
        descriptionLabel.alpha = 0
    }
    
    func setupConstraints() {
        stackView.applyAnchors(ofType: [.top, .leading, .trailing, .bottom], to: self)
        lineSeparatorView.applyAnchors(ofType: [.leading, .trailing, .bottom], to: stackView)
        
        titleContainerView.bottomAnchor.constraint(greaterThanOrEqualTo: expandButton.bottomAnchor).isActive = true
        titleContainerView.bottomAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: 4.0).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor, constant: 16.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor, constant: 16.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: expandButton.leadingAnchor, constant: -24.0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor, constant: -16.0).isActive = true
        
        expandButton.centerY(to: titleLabel)
        expandButton.topAnchor.constraint(greaterThanOrEqualTo: titleContainerView.topAnchor, constant: 13.0).isActive = true
        expandButton.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor, constant: -16.0).isActive = true
        
        descriptionLabelHeightConstraint = descriptionLabel.bottomAnchor.constraint(equalTo: descriptionContainerView.bottomAnchor, constant: -16.0)
        descriptionLabelHeightConstraint?.isActive = false
        descriptionLabel.leadingAnchor.constraint(equalTo: descriptionContainerView.leadingAnchor, constant: 16.0).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: descriptionContainerView.trailingAnchor, constant: -16.0).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: descriptionContainerView.topAnchor).isActive = true
        descriptionLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        let descriptionContainerHeightConstraint = descriptionContainerView.height(size: 0)
        descriptionContainerHeightConstraint.priority = UILayoutPriority.defaultLow
    }
    
    // MARK: - Private methods
    
    @objc private func expandAction() {
        let hiddenAlpha = descriptionLabelHeightConstraint?.isActive ?? false
        
        descriptionLabelHeightConstraint?.isActive.toggle()
        self.descriptionLabel.accessibilityElementsHidden = hiddenAlpha
        
        UIView.animateWithDefaultDuration({
            self.descriptionLabel.alpha = hiddenAlpha ? 0 : 1
            (self.parentViewToAnimate ?? self.superview ?? self).layoutIfNeeded()
        })
        expandButton.isExpanded.toggle()
    }
}
