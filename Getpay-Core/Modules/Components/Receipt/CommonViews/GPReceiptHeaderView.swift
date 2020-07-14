import UIKit

// MARK: - ViewModel

struct GPReceiptHeaderViewModel {
    let icon: UIImage
    let title: String
    let tintColor: UIColor?

    init(icon: UIImage, title: String, tintColor: UIColor? = nil) {
        self.icon = icon
        self.title = title
        self.tintColor = tintColor
    }
}

// MARK: - Class

class GPReceiptHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Private variables
    
    private lazy var iconView: UIView = {
        let view = UIView()
        view.backgroundColor = GPColors.maggie.color
        return view
    }()

    private lazy var icon: UIImageView = {
        let image = UIImageView(image: GPAssets.gpLogoSuperget.image)
        image.contentMode = .scaleAspectFill
        return image
    }()

    private lazy var statusView: UIView = {
        let view = UIView()
        view.backgroundColor = GPColors.duffman.color
        return view
    }()

    private lazy var iconStatus: UIImageView = {
        let image = UIImageView()
        return image
    }()

    private lazy var titleStatus: UILabel = {
        let label = UILabel()
        label.textColor = GPColors.edna.color
        label.font = FontFamily.Calibri.bold.font(size: 20.0)
        return label
    }()

    // MARK: - Initializers

    override init(reuseIdentifier _: String?) {
        super.init(reuseIdentifier: nil)
        addComponents()
        createConstraints()
        backgroundColor = GPColors.apu.color
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    public func configureView(icon: UIImage, iconTintColor: UIColor? = GPColors.homer.color, status: String) {
        iconStatus.image = icon
        iconStatus.tintColor = iconTintColor
        titleStatus.text = status
    }

    // MARK: - Private methods

    private func addComponents() {
        addSubviews([iconView, statusView], constraints: true)
        iconView.addSubviews([icon], constraints: true)
        statusView.addSubviews([iconStatus, titleStatus], constraints: true)
    }

    private func createConstraints() {
        iconView.applyAnchors(ofType: [.leading, .trailing, .top], to: self)

        statusView.topAnchor.constraint(equalTo: iconView.bottomAnchor).isActive = true
        statusView.applyAnchors(ofType: [.leading, .trailing, .bottom], to: self)

        icon.heightAnchor.constraint(equalToConstant: 32.0).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 140.0).isActive = true
        icon.topAnchor.constraint(equalTo: iconView.topAnchor, constant: 16.0).isActive = true
        icon.bottomAnchor.constraint(equalTo: iconView.bottomAnchor, constant: -16.0).isActive = true
        icon.centerXAnchor.constraint(equalTo: iconView.centerXAnchor).isActive = true

        iconStatus.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
        iconStatus.heightAnchor.constraint(equalToConstant: 22.0).isActive = true
        iconStatus.leadingAnchor.constraint(equalTo: statusView.leadingAnchor, constant: 16.0).isActive = true
        iconStatus.centerYAnchor.constraint(equalTo: titleStatus.centerYAnchor).isActive = true

        titleStatus.leadingAnchor.constraint(equalTo: iconStatus.trailingAnchor, constant: 16.0).isActive = true
        titleStatus.topAnchor.constraint(equalTo: statusView.topAnchor, constant: 16.0).isActive = true
        titleStatus.bottomAnchor.constraint(equalTo: statusView.bottomAnchor, constant: -16.0).isActive = true
    }
}
