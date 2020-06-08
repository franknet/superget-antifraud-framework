
import Foundation

// MARK: - Protocol
protocol PendingViewPreset {
    
    var title: String { get }
    var subTitle: String { get }
    var image: String? { get }
    var buttonTitle: String { get }
    
}

// MARK: - Struct
struct PresetNewClient404: PendingViewPreset {
    
    var title: String = "Abra sua conta para fazer transferências"
    
    var subTitle: String = "Para utilizar essa funcionalidade, é necessário abrir uma conta SuperGet."
    
    var image: String? = nil
    
    var buttonTitle: String = "ABRIR CONTA"
    
}

// MARK: - Struct
struct PresetClient403: PendingViewPreset {

    var title: String = "Falha ao carregar as informações"
    
    var subTitle: String = "Não foi possível carregar os dados da sua conta. Por favor, tente novamente."
    
    var image: String? = "gp_error"
    
    var buttonTitle: String = "TENTAR NOVAMENTE"
    
}

// MARK: - Struct
struct PresetWaitingDocumentsNewClient: PendingViewPreset {

    var title: String = "Complete seu cadastro para fazer transferências"
    
    var subTitle: String = "Para utilizar essa funcionalidade, é necessário que você envie os documentos necessários."
    
    var image: String? = nil
    
    var buttonTitle: String = "Abrir Conta"
    
}

// MARK: - Struct
struct PresetGeneric: PendingViewPreset {

    var title: String = "Abra sua conta para fazer transferências"
    
    var subTitle: String = "Para utilizar essa funcionalidade, é necessário abrir uma conta SuperGet."
    
    var image: String? = nil
    
    var buttonTitle: String = "Abrir Conta"
    
}
