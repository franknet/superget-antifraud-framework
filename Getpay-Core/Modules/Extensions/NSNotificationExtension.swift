import Foundation

public extension Notification.Name {
    
    static var rotateLandscape: Notification.Name {
        return .init("rotateLandscape")
    }
    
    static var rotatePortrait: Notification.Name {
        return .init("rotatePortrait")
    }
    
    static var offlineUserSession: Notification.Name {
        return .init("offlineUserSession")
    }
    
    static let welcomeButtonValidation = Notification.Name("WelcomeAuthButtonValidation")
    static let sellInputValue = Notification.Name("SellInputValue")
    static let trackEvent = Notification.Name("trackEvent")
    static let loadAccountData = Notification.Name("loadAccountData")
    static let didAccountUpdated = Notification.Name("didAccountUpdated")
}
