import Foundation

public class GPUtils {
    
    private static let terminalKey = "terminalKey"
    private static let accountKey = "accountKey"
    private static let merchantKey = "merchantKey"
    
    public static func save(accountInUD account: GPAccount) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(account) {
            let defaults = UserDefaults.shared
            defaults.set(encoded, forKey: accountKey)
        }
    }
    
    public static func loadAccountFromUD() -> GPAccount? {
        if let account = UserDefaults.shared.object(forKey: accountKey) as? Data {
            let decoder = JSONDecoder()
            if let loadedAccount = try? decoder.decode(GPAccount.self, from: account) {
                return loadedAccount
            }
        }
        
        return nil
    }
    
    public static func saveTerminalInUD(terminal: String) {
        UserDefaults.shared.set(terminal, forKey: terminalKey)
    }

    public static func loadTerminalFromUD() -> String {
        if let terminal = UserDefaults.shared.string(forKey: terminalKey) {
            return terminal
        }
        return ""
    }

    public static func saveGPMerchantInUD(merchant: GPMerchant) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(merchant) {
            let defaults = UserDefaults.shared
            defaults.set(encoded, forKey: merchantKey)
        }
    }

    public static func loadGPMerchantFromUD() -> GPMerchant {
        if let merchant = UserDefaults.shared.object(forKey: merchantKey) as? Data {
            let decoder = JSONDecoder()
            if let loadedMerchant = try? decoder.decode(GPMerchant.self, from: merchant) {
                return loadedMerchant
            }
        }
        return GPMerchant(id: 0, document: "", name: "", tradeName: "", email: "", type: "", merchantStatus: "")
    }
}
