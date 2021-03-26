
// MARK: - Class

public class GNGeneralConfig {
    
    // MARK: - Public variables
    
    public var sessionIDTMX = ""
    public var appVersion = ""
    public var environment: Environment = .hti
    
    // MARK: - Private variables
    
    private var pendencies: Pendencies?
    private var pendenciesAccount: PendenciesAccount?
    
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
    
    public func configure(pendencies: Pendencies) {
        self.pendencies = pendencies
    }
    
    public func configure(pendenciesAccount: PendenciesAccount) {
        self.pendenciesAccount = pendenciesAccount
    }
    
    public func getPendencies() -> Pendencies? {
        guard
            let pendencies = self.pendencies
        else { return nil }
        
        return pendencies
    }
    
    public func getPendenciesAccount() -> PendenciesAccount? {
        guard
            let pendenciesAccount = self.pendenciesAccount
        else { return nil }
        
        return pendenciesAccount
    }
}
