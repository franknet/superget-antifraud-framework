import UIKit

// MARK: - Class

public class GNSelectedViewWithRadioButton: UIView {
    
    // MARK: - Private variables
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let title = GPLabel(fontSize: 20.0, textColor: GPColors.ralph.color, numberOfLines: 1)
    
    private let radiusButton = GNRadiusButton()
    
    // MARK: - Public variables
    
    public var isChecked: Bool = false {
        didSet {
            isChecked ? doCheck() : unCheck()
        }
    }
    
    // MARK: - Initializers
    
    public init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GNSelectedViewWithRadioButton {
    
    // MARK: - Public methods
    
    public func configureView(title: String, image: UIImage) {
        self.title.text = title
        self.imageView.image = image
    }
    
    
    // MARK: - Private methods
    
    private func setupLayout() {
        layer.cornerRadius = 10
        backgroundColor = GPColors.maggie.color
        
        unCheck()
        addComponents()
        setupImage()
        setupTitle()
        setupCornerButton()
    }
    
    private func addComponents() {
        addSubviews([imageView,
                     title,
                     radiusButton], constraints: true)
    }
    
    private func setupImage() {
        imageView.height(size: 64.0)
        imageView.width(size: 64.0)
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 16.0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0).isActive = true
    }
    
    private func setupTitle() {
        title.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16.0).isActive = true
        title.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: radiusButton.leadingAnchor, constant: -8.0).isActive = true
    }
    
    private func setupCornerButton() {
        radiusButton.isUserInteractionEnabled = false
        radiusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
        radiusButton.centerYAnchor.constraint(equalTo: title.centerYAnchor).isActive = true
    }
    
    private func doCheck() {
        radiusButton.isChecked = true
                
        layer.shadowRadius = 0
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOpacity = 0
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        layer.borderWidth = 2
        layer.borderColor = GPColors.homer.color.cgColor
        
        title.font = FontFamily.Calibri.bold.font(size: 20.0)
        title.textColor = GPColors.edna.color
        layoutIfNeeded()
    }
    
    private func unCheck() {
        radiusButton.isChecked = false
    
        layer.shadowRadius = 5
        layer.shadowColor = GPColors.flanders.color.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.borderWidth = 0
        
        title.font = FontFamily.Calibri.regular.font(size: 20.0)
        title.textColor = GPColors.ralph.color
        layoutIfNeeded()
    }
}
