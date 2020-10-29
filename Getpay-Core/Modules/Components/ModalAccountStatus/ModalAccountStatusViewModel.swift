import UIKit

// MARK: - VerifyResult

public typealias VerifyResult = (preset: InformationViewPreset?, status: GPAccountRequestStatus?)

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
    
    func verifyAccount() -> VerifyResult {
        var model: InformationViewPreset
        let accPersistence = GPUtils.loadAccountPersistenceFromUD()
        
        switch accPersistence.requestStatus {
        case .active403:
            model = PresetClient403()
            
        case .newClient404:
            model = PresetNewClient404()
            model.buttonAction = { [weak self] in
                GNAnalytics.track(event: .CreateNewAccountMenu)
                
                guard let self = self else { return }
                self.delegate?.modalAccountStatusViewModelDelegateDidTapActionButton(self)
            }
            
        case .waitingDocumentsNewClient, .waitingDocumentsLegacy, .waitingCorrections:
            model = PresetWaitingDocumentsNewClient()
            model.buttonAction = { [weak self] in
                guard let self = self else { return }
                self.delegate?.modalAccountStatusViewModelDelegateDidTapActionButton(self)
            }
            
        case .loading:
            model = PresetLoading()
            
        case .denied:
            model = PresetCanceledAccount()
            
        case .waitingAnalysis:
            model = PresetWaitingAnalysis()
            
        default:
            return (nil, accPersistence.requestStatus)
            
        }
        
        return (model, accPersistence.requestStatus)
    }
}
