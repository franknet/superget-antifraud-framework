
import Foundation

public class GPUtils {
    
    private static let defaults = UserDefaults.shared
    private static let terminalKey = "terminalKey"
    private static let accountPersistenceKey = "accountPersistenceKey"
    private static let merchantKey = "merchantKey"
    
    public static func save(account: GPAccount) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(account) {
            defaults.set(encoded, forKey: accountPersistenceKey)
        }
    }
    
    public static func loadAccountPersistenceFromUD() -> GPAccount {
        if let account = defaults.object(forKey: accountPersistenceKey) as? Data {
            let decoder = JSONDecoder()
            if let loadedAccount = try? decoder.decode(GPAccount.self, from: account) {
                return loadedAccount
            }
        }
        return GPAccount(id: 0, status: "", number: "", branchNumber: "", aliasAccountStatus: "", origin: "", institution: GPBankingInstitution(number: 0, name: ""), balance: GPAccountBalance(id: 0, withdrawAvailableBalance: 0, globalAvailableBalance: 0), hasCard: false)
    }
    
    /// Called wehn user logout or change ec
    public static func removeAccountPersistenceFromUD() {
        defaults.removeObject(forKey: accountPersistenceKey)
    }
    
    public static func saveTerminalInUD(terminal: String) {
        defaults.set(terminal, forKey: terminalKey)
    }

    public static func loadTerminalFromUD() -> String {
        if let terminal = defaults.string(forKey: terminalKey) {
            return terminal
        }
        return ""
    }

    public static func saveGPMerchantInUD(merchant: GPMerchant) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(merchant) {
            defaults.set(encoded, forKey: merchantKey)
        }
    }

    public static func loadGPMerchantFromUD() -> GPMerchant {
        if let merchant = defaults.object(forKey: merchantKey) as? Data {
            let decoder = JSONDecoder()
            if let loadedMerchant = try? decoder.decode(GPMerchant.self, from: merchant) {
                return loadedMerchant
            }
        }
        return GPMerchant(id: 0, document: "", name: "", tradeName: "", email: "", type: "", merchantStatus: "")
    }
}
