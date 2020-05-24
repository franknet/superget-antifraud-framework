import Foundation
import SwiftKeychainWrapper
import AppAuth

struct AuthStateManager {
    
    static private var keyForAuthState = "authState"
    
    static func loadStateFromKeychain() -> OIDAuthState {
        let archeivedAuthState = KeychainWrapper.standard.data(forKey: keyForAuthState)!
        return NSKeyedUnarchiver.unarchiveObject(with: archeivedAuthState) as! OIDAuthState
    }
    
    static func saveAuthStateInKeyChain(_ authState: OIDAuthState) {
        let authStateData = NSKeyedArchiver.archivedData(withRootObject: authState)
        KeychainWrapper.standard.set(authStateData, forKey: keyForAuthState)
    }
        
}
