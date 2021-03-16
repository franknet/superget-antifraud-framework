import UIKit

// MARK: - Class

public final class TokenConfirmationWithResendButtonViewController: BaseViewController<TokenConfirmationWithResendButtonView> {
    
    // MARK: - Public variables
    
    public weak var delegate: TokenConfirmationWithResendSMSDelegate?
    
    // MARK: - Override methods
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
        setupResendButton()
    }
}

extension TokenConfirmationWithResendButtonViewController {
    
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
        
        customView.resendButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.didTapResendButton()
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
    
    private func setupResendButton() {
        customView.continueButton.isEnabled = false
        setupTimer()
    }
    
    private func setupTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { [weak self] in
            self?.customView.enableResendButton()
        }
    }
    
    private func didTapResendButton() {
        customView.disableResendButton()
        
        self.delegate?.resendToken { [weak self] error in
            
            guard let error = error else {
                self?.setupResendButton()
                return
            }
            
            self?.customView.enableResendButton()
            let message = error.description.isNotEmpty ? error.description : error.errorCode
            self?.presentToast(message: message)
        }
    }
}
