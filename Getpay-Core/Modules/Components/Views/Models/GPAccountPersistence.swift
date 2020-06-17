
import Foundation

/// Object that save account info in UserDefaults
public struct GPAccountPersistence: Codable {
    
    public var status: GPAccountRequestStatus = .retry
    public var account: GPAccount?
    
}
