// MARK: - Urls

public class Urls {
    
    // MARK: - Public variables
    
    public var baseURL = GNGeneralConfig.shared.environment.url.baseURL
    public var issuer = GNGeneralConfig.shared.environment.url.issuer
    public var transactionalURL = GNGeneralConfig.shared.environment.url.transactionalURL
    public var portServicesURL = GNGeneralConfig.shared.environment.url.portServicesURL
    
    public static var shared = Urls()
        
    // MARK: - Initializers
    
    public init() {}
    
}

// MARK: - Environment

public enum Environment: String {
    
    case prod
    case hti
    case mock
    
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
        case .mock:
            return AppUrls(baseURL: "http://testedosguri.mockable.io",
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
