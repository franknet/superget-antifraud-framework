import UIKit

public protocol PasswordDelegate: AnyObject {
    func getPassword(password: String)
}

// MARK: - Class

public final class PasswordViewController: BaseViewController<PasswordView> {
    
    // MARK: - Public variables
    
    public weak var delegate: PasswordDelegate?
    
    // MARK: - Override methods
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }
}

extension PasswordViewController {
    
    // MARK: - Public methods
    
    public func configure(title: String, buttonTitle: String) {
        customView.title.text = title
        customView.continueButton.setTitle(buttonTitle, for: .normal)
    }
    
    // MARK: - Private methods
    
    private func setupRx() {
        let passwordTextField = customView.passwordTextField
        
        passwordTextField.rx.text.orEmpty
            .map { $0.count > 3 }
            .bind(to: customView.continueButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        customView.continueButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.didTapContinue()
            })
            .disposed(by: disposeBag)
        
        customView.revealButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.didTapRevealPassword()
            })
            .disposed(by: disposeBag)
        
        passwordTextField.rx
            .controlEvent(.editingChanged)
            .subscribe(onNext: { _ in
                guard let string = passwordTextField.text else { return }
                passwordTextField.text = String(string.prefix(4))
            })
            .disposed(by: disposeBag)
    }
    
    private func didTapRevealPassword() {
        customView.passwordTextField.isSecureTextEntry.toggle()
        customView.revealButton.isSelected.toggle()
    }
    
    private func didTapContinue() {
        self.sheetViewController?.closeSheet { [weak self] in
            guard
                let self = self,
                let password = self.customView.passwordTextField.text
                else { return }
            self.delegate?.getPassword(password: password)
        }
    }
}
