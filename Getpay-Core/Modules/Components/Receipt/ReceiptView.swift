import UIKit

// MARK: - Class

public class GPReceiptView: UIView {
    
    // MARK: - Internal variables
    
    lazy var nav = GPNavBarView(
        navButtonStyle: .closeAndShare,
        backgroundColor: GPColors.apu.color,
        title: "Comprovante"
    )
    
    lazy var outcomeView: UIView = {
        let view = UIView()
        view.backgroundColor = GPColors.maggie.color
        view.layer.borderWidth = 6
        view.layer.borderColor = UIColor.hexStringToUIColor(hex: "#383B3D").cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var gradientView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isScrollEnabled = true
        return scroll
    }()
    
    lazy var stackContentView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = GPColors.apu.color
        stack.axis = .vertical
        return stack
    }()
    
    lazy var contentReceiptView: UIView = {
        let view = UIView()
        view.backgroundColor = GPColors.maggie.color
        return view
    }()
    
    lazy var footerView = UIView()
    
    lazy var share = GPButton(title: "COMPARTILHAR", style: .outlined)
    
    lazy var drawImage: UIImageView = {
        let image = UIImageView(image: GPAssets.gpReceiptEnd.image)
        image.tintColor = GPColors.maggie.color
        return image
    }()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        addComponents()
        setupConstraints()
        backgroundColor = GPColors.apu.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: self.frame.width - 32.0, height: 8)
        let first = UIColor.hexStringToUIColor(hex: "#C4C8CC").cgColor
        let second = GPColors.maggie.color.cgColor
        gradient.colors = [first, second]
        gradientView.layer.addSublayer(gradient)
        
        drawImage.layer.shadowOffset = CGSize(width: 0, height: 3)
        drawImage.layer.shadowOpacity = 0.2
        drawImage.layer.shadowRadius = 1.5
        drawImage.layer.shadowColor = UIColor.hexStringToUIColor(hex: "#2947661F").cgColor
    }
}

extension GPReceiptView {
    
    // MARK: - Private methods
    
    private func addComponents() {
        let views = [nav, outcomeView, gradientView, scrollView]
        addSubviews(views, constraints: true)
        
        let footerSubviews = [drawImage, share]
        footerView.addSubviews(footerSubviews, constraints: true)
        
        scrollView.addSubview(stackContentView, constraints: true)
        stackContentView.addArrangedSubview(contentReceiptView)
        stackContentView.addArrangedSubview(footerView)
    }
    
    private func setupConstraints() {
        setupTopContainer()
        setupOutcomeView()
        setupScrollView()
        setupContentView()
        setupFooterView()
    }
    
    private func setupTopContainer() {
        nav.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        nav.applyAnchors(ofType: [.leading, .trailing], to: self)
        
        gradientView.heightAnchor.constraint(equalToConstant: 8.0).isActive = true
        gradientView.topAnchor.constraint(equalTo: outcomeView.centerYAnchor).isActive = true
        gradientView.applyAnchors(ofType: [.leading, .trailing], to: contentReceiptView)
    }
    
    private func setupOutcomeView() {
        outcomeView.topAnchor.constraint(equalTo: nav.bottomAnchor).isActive = true
        outcomeView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4.0).isActive = true
        outcomeView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4.0).isActive = true
        outcomeView.heightAnchor.constraint(equalToConstant: 16.0).isActive = true
    }
    
    private func setupScrollView() {
        scrollView.topAnchor.constraint(equalTo: gradientView.bottomAnchor).isActive = true
        scrollView.applyAnchors(ofType: [.trailing, .bottom, .leading], to: self)
    }
    
    private func setupContentView() {
        stackContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true
        stackContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
        stackContentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func setupFooterView() {
        drawImage.applyAnchors(ofType: [.leading, .trailing, .top], to: footerView)
        drawImage.heightAnchor.constraint(equalToConstant: 10.0).isActive = true
        
        share.topAnchor.constraint(equalTo: drawImage.bottomAnchor, constant: 24.0).isActive = true
        share.applyAnchors(ofType: [.leading, .trailing], to: footerView)
        share.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -24.0).isActive = true
        share.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
    }
}
