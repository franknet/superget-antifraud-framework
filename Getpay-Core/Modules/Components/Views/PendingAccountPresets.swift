
import Foundation

// MARK: - Protocol
public protocol PendingViewPreset {
    
    var title: String { get }
    var subTitle: String { get }
    var image: String? { get }
    var buttonTitle: String { get }
    
}

// MARK: - Struct
public struct PresetNewClient404: PendingViewPreset {
    
    public var title: String = "Abra sua conta para fazer transferências"
    
    public var subTitle: String = "Para utilizar essa funcionalidade, é necessário abrir uma conta SuperGet."
    
    public var image: String? = nil
    
    public var buttonTitle: String = "ABRIR CONTA"
    
}

// MARK: - Struct
public struct PresetClient403: PendingViewPreset {

    public var title: String = "Falha ao carregar as informações"
    
    public var subTitle: String = "Não foi possível carregar os dados da sua conta. Por favor, tente novamente."
    
    public var image: String? = "gp_error"
    
    public var buttonTitle: String = "TENTAR NOVAMENTE"
    
}

// MARK: - Struct
public struct PresetWaitingDocumentsNewClient: PendingViewPreset {

    public var title: String = "Complete seu cadastro para fazer transferências"
    
    public var subTitle: String = "Para utilizar essa funcionalidade, é necessário que você envie os documentos necessários."
    
    public var image: String? = nil
    
    public var buttonTitle: String = "Abrir Conta"
    
}

// MARK: - Struct
public struct PresetGeneric: PendingViewPreset {

    public var title: String = "Abra sua conta para fazer transferências"
    
    public var subTitle: String = "Para utilizar essa funcionalidade, é necessário abrir uma conta SuperGet."
    
    public var image: String? = nil
    
    public var buttonTitle: String = "Abrir Conta"
    
}
