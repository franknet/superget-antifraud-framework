import Foundation
import SwiftKeychainWrapper
import AppAuth

public struct AuthStateManager {
    
    static private var keyForAuthState = "authState"
    
    public static func loadStateFromKeychain() -> OIDAuthState? {
        if let archeivedAuthState = KeychainWrapper.standard.data(forKey: keyForAuthState) {
            return NSKeyedUnarchiver.unarchiveObject(with: archeivedAuthState) as? OIDAuthState
        }
        return nil
    }
    
    public static func saveAuthStateInKeyChain(_ authState: OIDAuthState) {
        let authStateData = NSKeyedArchiver.archivedData(withRootObject: authState)
        KeychainWrapper.standard.set(authStateData, forKey: keyForAuthState)
    }
    
    public static func clearAllKeys() {
        KeychainWrapper.standard.removeAllKeys()
    }
}
