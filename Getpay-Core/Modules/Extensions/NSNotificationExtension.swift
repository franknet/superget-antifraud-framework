import Foundation

public extension Notification.Name {
    
    static var rotateLandscape: Notification.Name {
        return .init("rotateLandscape")
    }
    
    static var rotatePortrait: Notification.Name {
        return .init("rotatePortrait")
    }
    
    static let welcomeButtonValidation = Notification.Name("WelcomeAuthButtonValidation")
    static let sellInputValue = Notification.Name("SellInputValue")
}
