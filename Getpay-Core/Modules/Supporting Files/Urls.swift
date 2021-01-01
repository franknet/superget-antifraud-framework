
// MARK: - Urls

public class Urls {
    
    // MARK: - Public variables
    
    public var baseURL = ""
    public var issuer = ""
    public var transactionalURL = ""
    public var portServicesURL = ""
    
    public static var shared = Urls()
        
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Public methods
    
    public func configure(environment: Environment) {
        self.baseURL = environment.url.baseURL
        self.issuer = environment.url.issuer
        self.transactionalURL = environment.url.transactionalURL
        self.portServicesURL = environment.url.portServicesURL
    }
}

// MARK: - Environment

public enum Environment: String {
    
    case prod
    case hti
    
    var url: AppUrls {
        switch self {
        case .prod:
            return AppUrls(baseURL: "https://terminal.getnet.com.br/getpay",
                           issuer: "https://getsso-tns.getnet.com.br",
                           transactionalURL: "",
                           portServicesURL: "https://servicosportais.getnet.com.br/")
        case .hti:
            return AppUrls(baseURL: "https://api-homologacao.getnet.com.br/getpay",
                           issuer: "https://getsso-hom.getnet.com.br",
                           transactionalURL: "",
                           portServicesURL: "https://servicosportais-hti.getnet.com.br/")
        }
    }
}

// MARK: - AppUrls

public struct AppUrls {
    public let baseURL: String
    public let issuer: String
    public let transactionalURL: String
    public let portServicesURL: String
}

// MARK: - GPConstants

public enum GPConstants {}
