import UIKit

// MARK: - Class

public class UserAliasViewModel {
    
    // MARK: - Private variables
    
    private let service = UserAliasService()
    
    // MARK: - Initializers
    
    public init(){}
    
    // MARK: - Internal methods
    
    func loadUserAliasData(userAlias: String,
                           completion: @escaping (Result<UserAliasResponse, GPResponseError>) -> Void) {
        
        service.searchUserAlias(userAlias: userAlias) { response in
            completion(response)
        }
    }
    
    func sendUserAlias(userAlias: String,
                       completion: @escaping (GPResponseError?) -> Void) {
        
        service.updateUser(userAlias: userAlias) { response in
            completion(response)
        }
    }
}
