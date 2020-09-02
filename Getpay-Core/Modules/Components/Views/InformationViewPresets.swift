import UIKit

// MARK: - InformationViewPreset Protocol

public protocol InformationViewPreset {
    
    var navigationTitle: String? { get set }
    var title: String { get }
    var subTitle: String { get }
    var errorCode: String? { get }
    var image: UIImage? { get }
    var buttonTitle: String? { get }
    var buttonAction: ActionVoid? { get set }
    var inView: UIView? { get set }
    var subTitleAttributedText: NSMutableAttributedString? { get }
}

public extension InformationViewPreset {
    var subTitleAttributedText: NSMutableAttributedString? {
       return nil
    }
}

// MARK: - PresetNewClient404

public struct PresetNewClient404: InformationViewPreset {
    
    public var subTitleAttributedText: NSMutableAttributedString?
        
    public var navigationTitle: String?
    
    public var title: String = "Abra sua conta para fazer transferências"
    
    public var subTitle: String = "Para utilizar essa funcionalidade, é necessário abrir uma conta SuperGet."
    
    public var errorCode: String?
    
    public var image: UIImage? = nil
    
    public var buttonTitle: String? = "ABRIR CONTA"
    
    public var buttonAction: ActionVoid?
    
    public var inView: UIView?
    
    public init() {}
    
}

// MARK: - PresetClient403

public struct PresetClient403: InformationViewPreset {
    
    public var subTitleAttributedText: NSMutableAttributedString?
    
    public var navigationTitle: String?
    
    public var title: String = "Você não tem permissão"
    
    public var subTitle: String = "Para acessar esta área, você precisa ser o administrador do negócio. Caso seja, entre em contato com a Central de Atendimento Getnet."
    
    public var errorCode: String? = "(Erro 403)"
    
    public var image: UIImage? = GPAssets.gpUserPermission.image
    
    public var buttonTitle: String?
    
    public var buttonAction: ActionVoid?
    
    public var inView: UIView?
    
    public init() {}
    
}

// MARK: - PresetWaitingDocumentsNewClient

public struct PresetWaitingDocumentsNewClient: InformationViewPreset {
    
    public var subTitleAttributedText: NSMutableAttributedString?
    
    public var navigationTitle: String?
    
    public var title: String = "Envio de documentos"
    
    public var subTitle: String = "Para utilizar essa funcionalidade, é necessário que você envie os documentos necessários."
    
    public var errorCode: String?
    
    public var image: UIImage? = GPAssets.gpError.image
    
    public var buttonTitle: String? = "ENVIAR DOCUMENTOS"
    
    public var buttonAction: ActionVoid?
    
    public var inView: UIView?
    
    public init() {
        self.subTitleAttributedText = configMessage()
        if let accountStatus = GPUtils.loadAccountPersistenceFromUD().requestStatus {
            if accountStatus == .waitingCorrections {
                title = "Reenvio de documentos"
            }
        }
    }
    
    private func configMessage() -> NSMutableAttributedString {
        let numbersOfDayes = GPUtils.remainingDaysToSendDocuments()
        
        let message = NSMutableAttributedString(string: "Precisamos que você envie seus documentos ")
        let messageComplementation = NSAttributedString(string: " ou sua conta será desativada e não será possível movimentar seu dinheiro através do app.")
        var dueDate = NSMutableAttributedString()
        
        if numbersOfDayes <= 1 {
            dueDate = "até hoje".makeBoldString(fontSize: 16.0, color: GPColors.edna.color)
        } else {
            let preposition = NSMutableAttributedString(string: " em até ")
            message.append(preposition)
            dueDate = "\(numbersOfDayes) dias".makeBoldString(fontSize: 16.0, color: GPColors.edna.color)
        }
        
        message.append(dueDate)
        message.append(messageComplementation)
        
        return message
    }
}

// MARK: - PresetGeneric

public struct PresetGeneric: InformationViewPreset {
    
    public var subTitleAttributedText: NSMutableAttributedString?
    
    public var navigationTitle: String?
    
    public var title: String = "Abra sua conta para fazer transferências"
    
    public var subTitle: String = "Para utilizar essa funcionalidade, é necessário abrir uma conta SuperGet."
    
    public var errorCode: String?
    
    public var image: UIImage? = nil
    
    public var buttonTitle: String? = "ABRIR CONTA"
    
    public var buttonAction: ActionVoid?
    
    public var inView: UIView?
    
    public init() {}
    
}

// MARK: - PresetLoading

public struct PresetLoading: InformationViewPreset {
    
    public var subTitleAttributedText: NSMutableAttributedString?
    
    public var navigationTitle: String?
    
    public var title: String = "Falha ao carregar as informações"
    
    public var subTitle: String = "Não foi possível carregar os dados da sua conta. Por favor, tente novamente."
    
    public var errorCode: String?
    
    public var image: UIImage? = GPAssets.gpError.image
    
    public var buttonTitle: String? = "TENTAR NOVAMENTE"
    
    public var buttonAction: ActionVoid?
    
    public var inView: UIView?
    
    public init() {}
    
}

// MARK: - Present Canceled Account

public struct PresetCanceledAccount: InformationViewPreset {
    public var navigationTitle: String?
    
    public var title: String = "Conta desativada"
    
    public var subTitle: String = "Devido ao não envio de documentos necessários, sua conta foi desativada. Entre em contato com a Central de Atendimento Getnet para alterar a conta onde você recebe suas vendas. Você ainda pode continuar vendendo normalmente."
    
    public var errorCode: String?
    
    public var image: UIImage? = GPAssets.gpDisabledAccount.image
    
    public var buttonTitle: String? = "OK, ENTENDI"
    
    public var buttonAction: ActionVoid?
    
    public var inView: UIView?
    
    public var subTitleAttributedText: NSMutableAttributedString?
    
    public init() {
        self.subTitleAttributedText = configMessage()
    }
    
    private func configMessage() -> NSMutableAttributedString {
        let message = NSMutableAttributedString(string: "Devido ao não envio de documentos necessários, sua conta foi desativada. Entre em contato com a ")
        let boldString = "Central de Atendimento Getnet".makeBoldString(fontSize: 16.0,
                                                                        color: GPColors.homer.color).underline(term: "Central de Atendimento Getnet")
        
        let finalPart = NSAttributedString(string: " para alterar a conta onde você recebe suas vendas. Você ainda pode continuar vendendo normalmente.")
        boldString.append(finalPart)
        message.append(boldString)
        
        return message
    }
}
