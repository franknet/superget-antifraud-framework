import UIKit

// MARK: - Class

public final class TokenConfirmationViewController: BaseViewController<TokenConfirmationView> {
    
    // MARK: - Public variables
    
    public weak var delegate: TokenConfirmationDelegate?
    
    // MARK: - Override methods
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }
}

extension TokenConfirmationViewController {
    
    // MARK: - Public methods
    
    public func configure(title: String, buttonTitle: String) {
        customView.title.text = title
        customView.continueButton.setTitle(buttonTitle, for: .normal)
    }
    
    // MARK: - Private methods
    
    private func setupRx() {
        let tokenTextField = customView.tokenTextField
        
        tokenTextField.rx.text.orEmpty
            .map { $0.count > 3 }
            .bind(to: customView.continueButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        customView.continueButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.didTapContinue()
            })
            .disposed(by: disposeBag)
                
        tokenTextField.rx
            .controlEvent(.editingChanged)
            .subscribe(onNext: { _ in
                guard let string = tokenTextField.text else { return }
                tokenTextField.text = String(string.prefix(6))
            })
            .disposed(by: disposeBag)
    }
    
    private func didTapContinue() {
        self.sheetViewController?.closeSheet { [weak self] in
            guard
                let self = self,
                let token = self.customView.tokenTextField.text
                else { return }
            self.delegate?.getToken(token: token)
        }
    }
}
