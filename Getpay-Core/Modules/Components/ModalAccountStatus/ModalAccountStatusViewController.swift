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
        if info.status == .loading {
            preset.buttonAction = { [weak self] in
                self?.informationDisplay?.removeFromSuperview()
                self?.startViews()
            }
        }
        informationDisplay = GPInformationDisplayView(preset: preset)
        informationDisplay?.cancelButton.isHidden = false
        informationDisplay?.cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
    }
    
    private func startViews() {
        informationDisplay?.removeFromSuperview()
        notEligibleView.removeFromSuperview()
        let information = viewModel.verifyAccount()

        if let _ = information.preset {
            if information.status == .newClient404 {
                let account = GPUtils.loadAccountPersistenceFromUD()
                if account.eligibility == .REPROVED {
                    self.addNotEligibleView()
                } else {
                    goTo(AccountInfo: information)
                }
            } else {
                goTo(AccountInfo: information)
            }
        } else {
            let account = GPUtils.loadAccountPersistenceFromUD()
            
            if !account.hasCard {
                var preset = PresentHasNoCard()
                preset.inView = view
                preset.buttonAction = { [weak self] in
                    guard let self = self else { return }
                    self.delegate?.modalAccountStatusDidTapActiveCard(self)
                }
                informationDisplay = GPInformationDisplayView(preset: preset)
                informationDisplay?.cancelButton.isHidden = false
                informationDisplay?.cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
            }
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
