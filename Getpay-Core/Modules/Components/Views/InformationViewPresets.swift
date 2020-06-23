
import UIKit

// MARK: - Protocol
public protocol InformationViewPreset {
    
    var title: String { get }
    var subTitle: String { get }
    var errorCode: String? { get }
    var image: UIImage? { get }
    var buttonTitle: String? { get }
    var buttonAction: ActionVoid? { get set }
    var inView: UIView? { get set }
    
}

// MARK: - Struct
public struct PresetNewClient404: InformationViewPreset {
    
    public var title: String = "Abra sua conta para fazer transferências"
    
    public var subTitle: String = "Para utilizar essa funcionalidade, é necessário abrir uma conta SuperGet."
    
    public var errorCode: String?
    
    public var image: UIImage? = nil
    
    public var buttonTitle: String? = "ABRIR CONTA"
    
    public var buttonAction: ActionVoid?
    
    public var inView: UIView?
    
    public init() {}
    
}

// MARK: - Struct
public struct PresetClient403: InformationViewPreset {

    public var title: String = "Você não tem permissão"
    
    public var subTitle: String = "Para acessar esta área, você precisa ser o administrador do negócio. Caso seja, entre em contato com a Central de Atendimento Getnet."
    
    public var errorCode: String? = "(Erro 403)"
    
    public var image: UIImage? = GPAssets.gpUserPermission.image
    
    public var buttonTitle: String?
    
    public var buttonAction: ActionVoid?
    
    public var inView: UIView?
    
    public init() {}
    
}

// MARK: - Struct
public struct PresetWaitingDocumentsNewClient: InformationViewPreset {

    public var title: String = "Complete seu cadastro para fazer transferências"
    
    public var subTitle: String = "Para utilizar essa funcionalidade, é necessário que você envie os documentos necessários."
    
    public var errorCode: String?
    
    public var image: UIImage?
    
    public var buttonTitle: String? = "ABRIR CONTA"
    
    public var buttonAction: ActionVoid?
    
    public var inView: UIView?
    
    public init() {}
    
}

// MARK: - Struct
public struct PresetGeneric: InformationViewPreset {

    public var title: String = "Abra sua conta para fazer transferências"
    
    public var subTitle: String = "Para utilizar essa funcionalidade, é necessário abrir uma conta SuperGet."
    
    public var errorCode: String?
    
    public var image: UIImage? = nil
    
    public var buttonTitle: String? = "ABRIR CONTA"
    
    public var buttonAction: ActionVoid?
    
    public var inView: UIView?
    
    public init() {}
    
}

// MARK: - Struct
public struct PresetLoading: InformationViewPreset {

    public var title: String = "Falha ao carregar as informações"
    
    public var subTitle: String = "Não foi possível carregar os dados da sua conta. Por favor, tente novamente."
    
    public var errorCode: String?
    
    public var image: UIImage? = UIImage(named: "gp_error")
    
    public var buttonTitle: String? = "TENTAR NOVAMENTE"
    
    public var buttonAction: ActionVoid?
    
    public var inView: UIView?
    
    public init() {}
    
}
