import UIKit

// MARK: - ModalAccountStatusViewControllerDelegate

public protocol ModalAccountStatusViewControllerDelegate: class {
    func modalAccountStatusDidTapCancel(_ viewController: ModalAccountStatusViewController)
    func modalAccountStatusDidTapActiveCard(_ viewController: ModalAccountStatusViewController)
}

// MARK: - Class

public final class ModalAccountStatusViewController: UIViewController {
    
    // MARK: - Public variables
    
    public weak var delegate: ModalAccountStatusViewControllerDelegate?
    
    // MARK: - Private variables
    
    private var viewModel: ModalAccountStatusViewModel
    
    private let notEligibleView = NotEligibleView()
    
    private var informationDisplay: GPInformationDisplayView?
    
    // MARK: - Initializers
    
    public init(viewModel: ModalAccountStatusViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        startViews()
    }
}

public extension ModalAccountStatusViewController {
    
    // MARK: - Private methods
    
    private func goTo(AccountInfo info: VerifyResult) {
        guard var preset = info.preset else { return }
        preset.inView = view
        
        informationDisplay = GPInformationDisplayView(preset: preset)
        informationDisplay?.cancelButton.isHidden = false
        informationDisplay?.cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
    }
    
    private func checkCard() {
        guard GPUtils.loadAccountPersistenceFromUD().hasCard else {
            var preset = PresentHasNoCard()
            preset.inView = view
            preset.buttonAction = { [weak self] in
                guard let self = self else { return }
                self.delegate?.modalAccountStatusDidTapActiveCard(self)
            }
            informationDisplay = GPInformationDisplayView(preset: preset)
            informationDisplay?.cancelButton.isHidden = false
            informationDisplay?.cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
            return
        }
    }
    
    private func startViews() {
        informationDisplay?.removeFromSuperview()
        notEligibleView.removeFromSuperview()
        checkCard()
        
        guard let pendencies = viewModel.checkAccount(), let status = pendencies.status else { return }
        
        guard status == .ACTIVE else {
            switch status {
            case .NOT_REQUESTED:
                self.addNotEligibleView()
            case .BLOCKED:
                self.addNotEligibleView()
            default:
                goTo(AccountInfo: pendencies)
            }
            return
        }
    }

    private func addNotEligibleView() {
        notEligibleView.configure(headerTitle: "Pagar",
                                  title: "Não é possível realizar pagamentos",
                                  subTitle: "No momento a área de pagamentos não está disponível para seu perfil.")
        view.addSubview(notEligibleView, constraints: true)
        notEligibleView.applyAnchors(ofType: [.top, .leading, .trailing, .bottom], to: view)
    }
    
    @objc private func didTapCancel() {
        self.dismiss(animated: true)
    }
}
