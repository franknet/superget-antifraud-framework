//
//  GPErrorViewModel.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 21/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import UIKit

public protocol GetpayError {
    var code: String { get set }
    var developerMessage: String { get set }
}

enum SGTransactionErrorAction {
    case cancel
    case cancelTokenError
    case tryAgain
    case connError

    var title: String {
        switch self {
        case .cancel:
            return "CONTINUAR"
        case .cancelTokenError:
            return "CONTINUAR"
        case .tryAgain:
            return "TENTAR NOVAMENTE"
        case .connError:
            return "  BUSCAR MÁQUINAS  "
        }
    }
}

struct GPErrorViewModel {
    let image: UIImage
    let title: String?
    let message: String?
    let error: String
    let actions: [SGTransactionErrorAction]
    let showRemoveCard: Bool

    init(image: UIImage? = nil, title: String? = nil, message: String? = nil, error: String,
         showRemoveCard: Bool) {
        
        var actions: [SGTransactionErrorAction] = [.cancel]
        var image = #imageLiteral(resourceName: "gn_alert.pdf")
        if error == "SM-QR Time Out" {
            image = #imageLiteral(resourceName: "gn_alert.pdf")
        } else if error == "SM-QR Fail" {
            image = #imageLiteral(resourceName: "gn_alert.pdf")
        } else if error == "BC-GOC 42" {
            image = #imageLiteral(resourceName: "gn_erro_pin_online")
        } else if error == "SM-BT CON" {
            actions.append(.connError)
        } else if error == "SM-TOKEN 600" {
            image = #imageLiteral(resourceName: "gn_token_600")
        } else if error == "SM-TOKEN 610" {
            image = #imageLiteral(resourceName: "gn_token_610")
            actions = [.cancelTokenError]
        }
        
        self.image = image
        self.title = title
        self.message = message
        self.error = error
        self.actions = actions
        self.showRemoveCard = showRemoveCard
    }

    init(error: GetpayError, showRemoveCard: Bool) {
        let title: String
        let message: String
        var image = #imageLiteral(resourceName: "gn_alert.pdf")
        var actions: [SGTransactionErrorAction] = [.cancel]

        switch error.code {
        case "SM-TOKEN 600":
            title = "Falha de Conexão"
            message = "Não foi possível realizar a ação devido à problemas de conexão com o servidor. Por favor, tente novamente."
            image = #imageLiteral(resourceName: "gn_token_600")
        case "SM-TOKEN 610":
            title = "Acesso Expirado"
            message = "Não foi possível realizar a ação pois sua sessão expirou. Por favor, faça login novamente."
            image = #imageLiteral(resourceName: "gn_token_610")
            actions = [.cancelTokenError]
        case "SM-QR Fail":
            title = "Falha de Conexão"
            message = "Não foi possível realizar a transação devido à problemas de conexão com o servidor. Por favor, tente novamente."
            image = #imageLiteral(resourceName: "gn_alert.pdf")
        case "SM-QR Time Out":
            title = "Falha de Conexão"
            message = "Não foi possível realizar a transação devido à problemas de conexão com o servidor. Por favor, tente novamente."
            image = #imageLiteral(resourceName: "gn_alert.pdf")
        case "SM-QR 504":
            title = "QR Code Expirado"
            message = "O tempo para leitura do QR Code acabou."
        case "BC-GOC 42":
            title = "Máquina e cartão incompatíveis"
            message = "Não é possível realizar o pagamento com este cartão na máquina. Por favor, tente novamente com outro cartão ou adquira uma máquina SuperGet Mobile"
            image = #imageLiteral(resourceName: "gn_erro_pin_online")
        case "SM-BT CON":
            title = "Máquina não encontrada"
            message = "Não foi possível conectar a sua máquina. Verifique se a máquina e o Bluetooth estão ligados e funcionando corretamente. Se o erro persistir, desligue e ligue o celular e a máquina."
        default:
            title = "Operação Cancelada"
            message = "Tente novamente. Caso o erro persista, entre em contato com a Central de Atendimento Getnet."
        }
        
        self.image = image
        self.title = title
        self.message = message
        self.error = error.code
        self.actions = actions
        self.showRemoveCard = showRemoveCard
    }
}
