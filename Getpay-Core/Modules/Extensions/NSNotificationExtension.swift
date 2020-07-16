import Foundation

public extension Notification.Name {
    
    static var rotateLandscape: Notification.Name {
        return .init("rotateLandscape")
    }
    
    static var rotatePortrait: Notification.Name {
        return .init("rotatePortrait")
    }
    
}
