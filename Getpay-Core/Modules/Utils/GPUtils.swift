import Foundation
import UIKit

public class GPUtils {
    
    private static let defaults = UserDefaults.shared
    private static let terminalKey = "terminalKey"
    private static let accountPersistenceKey = "accountPersistenceKey"
    private static let merchantKey = "merchantKey"
    private static let didSendFeedback = "didSendFeedback"
    private static let dateFeedbackShowed = "dateFeedbackShowed"
    private static let showFeedback = "showFeedback"
    
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
        return UIImage(named: icon,
                       in: Bundle(for: self),
                       compatibleWith: nil)
    }
    
    public static func feedbackShouldBePresented() -> Bool {
        if appHasBeenRated() {
            return false
        } else {
            if feedbackShouldBeShown() && feedbackShouldBeShownByDate() {
                return true
            }
            return false
        }
    }
    
    private static func appHasBeenRated() -> Bool {
        return defaults.bool(forKey: didSendFeedback)
    }
    
    private static func remainingDaysToShowFeedback() -> Int? {
        if let date = defaults.object(forKey: dateFeedbackShowed) as? Date {
            let calendar = Calendar.current
            
            let date1 = calendar.startOfDay(for: date)
            let date2 = calendar.startOfDay(for: Date())
            
            let components = calendar.dateComponents([.day], from: date1, to: date2)
            
            if let days = components.day {
                return days
            }
        }
        
        return nil
    }
    
    private static func feedbackShouldBeShownByDate() -> Bool {
        if remainingDaysToShowFeedback() == nil {
            return true
        } else {
            if let remainingDays = remainingDaysToShowFeedback() {
                if remainingDays >= 15 {
                    return true
                }
            }
        }
        
        return false
    }
    
    public static func setFeedBackStatus(_ status: Bool) {
        defaults.set(status, forKey: didSendFeedback)
    }
    
    public static func setFeedBackDate(_ date: Date) {
        defaults.set(date, forKey: dateFeedbackShowed)
    }
    
    public static func setNeedShowFeedback(_ status: Bool) {
        defaults.set(status, forKey: showFeedback)
    }
    
    private static func feedbackShouldBeShown() -> Bool {
        return defaults.bool(forKey: showFeedback)
    }
}
