
// MARK: - Class

public class GNGeneralConfig {
    
    // MARK: - Public variables
    
    public var sessionIDTMX = ""
    public var appVersion = ""
    public var environment: Environment = .hti
    
    public static var shared = GNGeneralConfig()
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Public methods
    
    public func configure(sessionIDTMX: String) {
        self.sessionIDTMX = sessionIDTMX
    }
    
    public func configure(appVersion: String) {
        self.appVersion = appVersion
    }
    
    public func configure(environment: Environment) {
        self.environment = environment
    }
}
