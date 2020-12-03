import Foundation
import UIKit

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
        return GPAccount(id: 0,
                         status: .NONE,
                         number: "",
                         branchNumber: "",
                         aliasAccountStatus: .NOT_ACTIVE,
                         origin: .NONE,
                         institution: GPBankingInstitution(number: 0, name: ""),
                         balance: GPAccountBalance(id: 0, withdrawAvailableBalance: 0, globalAvailableBalance: 0),
                         hasCard: false,
                         creationDate: "",
                         isCriticalToSendDocuments: false,
                         name: "",
                         document: "")
    }
    
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
        return GPMerchant(id: 0,
                          document: "",
                          name: "",
                          tradeName: "",
                          email: "",
                          type: .PF,
                          merchantStatus: "")
    }
    
    public static func remainingDaysToSendDocuments() -> Int {
        let account = GPUtils.loadAccountPersistenceFromUD()
        if let numbersOfDays = account.creationDate?.toDate?.numberOfDaysFromToday {
            return 30 - numbersOfDays
        }
        return 30
    }
    
    public static func findTabBarIn(array: [UIViewController]) -> UIViewController? {
        for controller in array {
            if controller.isKind(of: UITabBarController.self) {
                return controller
            }
        }
        return nil
    }
    
    public static func isAccessAllowed(isCard: Bool = false) -> Bool {
        let account = GPUtils.loadAccountPersistenceFromUD()
        
        if isCard && (account.requestStatus == .active || account.requestStatus == .waitingDocumentsVizir) {
            return true
        }
        
        if !account.hasCard {
            return false
        }
        
        switch account.requestStatus {
        case .active403,
             .newClient404,
             .waitingDocumentsNewClient,
             .waitingDocumentsLegacy,
             .waitingCorrections,
             .loading,
             .denied,
             .waitingAnalysis,
             .waitingDocumentsVizir:
            return false
            
        default:
            return true
        }
    }
    
    public static func shouldUpdateAccount() -> Bool {
        let account = GPUtils.loadAccountPersistenceFromUD()
        if let status = account.needAccountUpdate {
            return status
        }
        return false
    }
    
    public static func setNeedAccountUpdate(_ status: Bool) {
        var account = GPUtils.loadAccountPersistenceFromUD()
        account.needAccountUpdate = status
        save(account: account)
    }
    
    public static func getImage(icon: String) -> UIImage? {
        return ImageAsset(name: icon).image
    }
}
