import UIKit

// MARK: - Class

public class NotEligibleView: UIView {
    
    // MARK: - Private variables
    
    private let navBar = GPNavBarView(navButtonStyle: .none)
    
    private let container = UIView()
    
    private let title = GPLabel(font: FontFamily.Calibri.bold, fontSize: 24.0, alignment: .center)
    
    private let subTitle = GPLabel(fontSize: 16.0, alignment: .center, textColor: GPColors.ralph.color)
    
    // MARK: - Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = GPColors.maggie.color
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NotEligibleView {
    
    // MARK: - Public methods
    
    public func configure(headerTitle: String, title: String, subTitle: String) {
        navBar.title.text = headerTitle
        self.title.text = title
        self.subTitle.text = subTitle
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        addComponents()
        setupNavBar()
        setupContainer()
        setupTitle()
        setupSubtitle()
    }
    
    private func addComponents() {
        addSubviews([navBar, container], constraints: true)
        container.addSubviews([title, subTitle], constraints: true)
    }
    
    private func setupNavBar() {
        navBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        navBar.applyAnchors(ofType: [.leading, .trailing], to: self)
    }
    
    private func setupContainer() {
        container.centerY(to: self)
        container.centerX(to: self)
        container.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16.0).isActive = true
        container.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16.0).isActive = true
    }
    
    private func setupTitle() {
        title.applyAnchors(ofType: [.leading, .trailing, .top], to: container)
    }
    
    private func setupSubtitle() {
        subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 29.0).isActive = true
        subTitle.applyAnchors(ofType: [.leading, .trailing, .bottom], to: container)
    }
}
