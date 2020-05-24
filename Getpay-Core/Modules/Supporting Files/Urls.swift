
// MARK: - Urls

public class Urls {
    
    // MARK: - Public variables
    
    public var baseURL = ""
    public var issuer = ""
    public var transactionalURL = ""
    
    public static var shared = Urls()
        
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Public methods
    
    public func configure(environment: Environment) {
        self.baseURL = environment.url.baseURL
        self.issuer = environment.url.issuer
        self.transactionalURL = environment.url.transactionalURL
    }
}

// MARK: - Environment

public enum Environment: String {
    
    case prod
    case hti
    
    var url: AppUrls {
        switch self {
        case .prod:
            return AppUrls(baseURL: "https://terminal.getnet.com.br/getpay", issuer: "https://getsso-tns.getnet.com.br", transactionalURL: "")
        case .hti:
            return AppUrls(baseURL: "https://api-homologacao.getnet.com.br/getpay", issuer: "https://getsso-hom.getnet.com.br", transactionalURL: "")
        }
    }
}

// MARK: - AppUrls

public struct AppUrls {
    public let baseURL: String
    public let issuer: String
    public let transactionalURL: String
}

// MARK: - GPConstants

public enum GPConstants {}
