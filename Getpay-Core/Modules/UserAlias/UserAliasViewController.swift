import UIKit
import RxSwift
import RxCocoa
import RxGesture

// MARK: - Class

public class UserAliasViewController: BaseViewController<UserAliasView> {
    
    // MARK: - Public variables
    
    public var callback: ActionVoid?
    
    // MARK: - Private variables
    
    private let viewModel: UserAliasViewModel
    
    // MARK: - Initializers
    
    public init(viewModel: UserAliasViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - Override methods
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }
}

// MARK: - Private methods

extension UserAliasViewController {
    
    private func setupRx() {
        let userAliasValid = customView.userAliasTextfield
            .rx
            .text
            .orEmpty
            .map{ $0.isValidUserAlias }
            .share(replay: 1)
        
        userAliasValid
            .bind(to: customView.proceed.rx.isEnabled)
            .disposed(by: disposeBag)
        
        let notUserAliasValid = customView.userAliasTextfield
            .rx
            .text
            .orEmpty
            .map{ $0.isValidText }
            .share(replay: 1)
        
        notUserAliasValid
            .bind(to: customView.statusContainer.rx.isHidden)
            .disposed(by: disposeBag)
        
        customView.proceed.rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                self?.startRequest()
            })
            .disposed(by: disposeBag)
        
        customView.userAliasTextfield.rx
            .controlEvent(.editingChanged)
            .subscribe(onNext: { [weak self] in
                guard let string = self?.customView.userAliasTextfield.text else { return }
                self?.customView.userAliasTextfield.text = String(string.prefix(15))
                // cor aproximada do placeholder
                self?.customView.prefix.textColor = string.count > 0 ? GPColors.edna.color : UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0)
            })
            .disposed(by: disposeBag)
    }
    
    private func startRequest() {
        guard let userAliasTextField = customView.userAliasTextfield.text else { return }
        let userAlias = "@" + userAliasTextField
        
        GPLoadingOverlay.shared.showOverlay(view: customView)
        
        viewModel.loadUserAliasData(userAlias: userAlias) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
                
            case .success(let response):
                if response.content.count == 0 {
                    self.sendUserAlias(userAlias: userAlias)
                    
                } else {
                    GPLoadingOverlay.shared.hideOverlayView()
                    self.presentToast(message: "Esse nome de usuário não está disponível.")
                }
                
            case .failure(let error):
                GPLoadingOverlay.shared.hideOverlayView()
                let message = error.description.isNotEmpty ? error.description : error.errorCode
                self.presentToast(message: message)
            }
        }
    }
    
    private func sendUserAlias(userAlias: String) {
        viewModel.sendUserAlias(userAlias: userAlias) { [weak self ] result in
            
            guard let self = self else {return}
            GPLoadingOverlay.shared.hideOverlayView()
            
            if result == nil {
                self.callback?()
                
            } else {
                guard let error = result else { return }
                let message = error.description.isNotEmpty ? error.description : error.errorCode
                self.presentToast(message: message)
            }
        }
    }
}
