import UIKit

// MARK: - Class

public class ReceiptViewController: BaseViewController<GPReceiptView> {
    
    // MARK: - Internal variables
    
    let viewModel: ReceiptViewModel
    
    var clousure: (() -> Void)?
    
    // MARK: - Initializers
    
    public init(viewModel: ReceiptViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension ReceiptViewController {
    
    // MARK: - Private methods
    
    private func setup() {
        setupButtons()
        
        if let window = UIApplication.shared.windows.first {
            GPLoadingOverlay.shared.showOverlay(view: window)
        }
        
        viewModel.fetch { [weak self] response in
            guard let self = self else { return }
        
            GPLoadingOverlay.shared.hideOverlayView()
            
            switch response {
            case let .success(result):
                self.viewModel.bankSlip = result
                let receiptType = self.viewModel.type
                self.setup(receiptType: receiptType)
            case let .failure(error):
                let message = error.description.isNotEmpty ? error.description : error.errorCode
                self.presentToast(
                    message: message,
                    showDismissButton: true,
                    color: GPColors.milhouse.color,
                    extraMargin: 0
                )
                break
            }
        }
    }
    
    private func setupButtons() {
        customView.nav.leftButton?.addTarget(self, action: #selector(dismissReceipt), for: .touchUpInside)
        customView.nav.rightButton?.addTarget(self, action: #selector(shareButtonDidTap), for: .touchUpInside)
    }
    
    private func setup(receiptType: GPReceiptType) {
        switch receiptType {
        case .bankSlip:
            guard
                let model = viewModel.bankSlip,
                let view = viewModel.type.view as? BankSlipView
            else { return }
            view.populate(model: model)
            view.addArrangedSubview(customView.footerView)
            setConstraints(view: view)
            break
        default:
            break
        }
    }
    
    private func setConstraints(view: UIView) {
        customView.contentReceiptView.addSubview(view, constraints: true)
        view.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 16.0).isActive = true
        view.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -16.0).isActive = true
        view.applyAnchors(ofType: [.top, .bottom], to: customView.scrollView)
    }
    
    @objc private func dismissReceipt() {
        dismiss(animated: true) {
            self.clousure?()
        }
    }
    
    @objc private func shareButtonDidTap() {
        if let image = customView.scrollView.snapshot() {
            let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            present(activityViewController, animated: true)
        }
    }
}
