
// MARK: - Class

public class GNThreatMetrix {
    
    // MARK: - Public variables
    
    public var sessionID = ""
    public var appVersion = ""
    
    public static var shared = GNThreatMetrix()
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Public methods
    
    public func configure(sessionID: String) {
        self.sessionID = sessionID
    }
    
    public func configure(appVersion: String) {
        self.appVersion = appVersion
    }
}
