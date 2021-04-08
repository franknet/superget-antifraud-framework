import UIKit

// MARK: - VerifyResult

// MARK: - ModalAccountStatusViewModelDelegate

public protocol ModalAccountStatusViewModelDelegate: class {
    func modalAccountStatusViewModelDelegateDidTapActionButton(_ viewmodel: ModalAccountStatusViewModel)
}

// MARK: - Class

public final class ModalAccountStatusViewModel {
    
    // MARK: - Public variables
    public weak var delegate: ModalAccountStatusViewModelDelegate?
    
    // MARK: - Initializers
    
    public init() { }
    
}

public extension ModalAccountStatusViewModel {
    
    // MARK: - Internal methods
    
    func checkAccount() -> VerifyResult? {
        var accountService = GPAccountService().checkAccount()
        
        switch accountService?.status {
        case .PENDING, .WAITING_CORRECTIONS, .ALIAS_ACCOUNT_PENDING:
            accountService?.preset?.buttonAction = { [weak self] in
                guard let self = self else { return }
                self.delegate?.modalAccountStatusViewModelDelegateDidTapActionButton(self)
            }
            return accountService
        default:
            return accountService
        }
    }
}
