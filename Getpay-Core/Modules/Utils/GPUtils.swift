import Foundation

public class GPUtils {
    
    private static let defaults = UserDefaults.shared
    private static let terminalKey = "terminalKey"
    private static let accountStatusKey = "accountStatusKey"
    private static let merchantKey = "merchantKey"
    
    public static func save(accountStatusInUD status: GPAccountRequestStatus) {
        defaults.set(status.rawValue, forKey: accountStatusKey)
    }
    
    /// Try to get the last account status, if none, return .loading so
    ///  execute request again
    /// - Returns: An GPAccountRequestStatus that reflect the business rules
    /// using payload "status" and "origin". If there is no data, return .loading
    public static func loadAccountStatusFromUD() -> GPAccountRequestStatus {
        if let value = defaults.object(forKey: accountStatusKey) as? Int {
            if let status = GPAccountRequestStatus(rawValue: value) {
                return status
            }
        }
        return .loading
    }
    
    /// Called wehn user logout or change ec
    public static func removeAccountStatusFromUD() {
        defaults.removeObject(forKey: accountStatusKey)
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
