
import Foundation

// MARK: - Enum

public enum GNAccountStatus: String, Codable {
    /// Não houve qualquer tipo de solicitação de abertura de conta.
    case NOT_REQUESTED
    /// o app não deve exibir o banner de abertura de conta pois o usuário não é administrador do estabelecimento. Exibir a home sem as operações de conta. 
    case UNAUTHORIZED
    /// A solicitação da abertura de conta será feita pelo backend.
    case PROCESSING
    /// Há pendências a serem resolvidas. Equivalente aos atuais status [WAITING_DOCUMENTS].
    case PENDING
    case WAITING_CORRECTIONS
    /// Abertura de conta em analise.
    case WAITING_ANALYSIS
    /// Aguardando a individualização da conta.
    case ALIAS_ACCOUNT_PENDING
    /// Status final. Conta individualizada ok.
    case ACTIVE
    case BLOCKED
}

// MARK: - Enum

public enum GPAccountRequestStatus: Int, Codable {
    
    /// this state reflact the unknow status,
    /// where we dont have the information yet
    case loading
    
    /// this state accur when account status
    /// is an error not equal to 404 or 403
    /// (error != 404 && error != 403)
    case retry
    
    /// this state reflects the new client, that will
    /// need create account
    /// (error code = 404 && description = "not found")
    case newClient404
    
    /// this state is a user that have an account,
    /// who didn't send the documents
    /// (status = "WAITING_DOCUMENTS" && origin="VIZIR")
    case waitingDocumentsVizir
    
    /// this state is a user that have an account,
    /// who didn't send the documents
    /// (status = "WAITING_DOCUMENTS" && origin="NEW_CLIENT")
    case waitingDocumentsNewClient
    
    /// this state is a user that have an account,
    /// who didn't send the documents
    /// (status = "WAITING_DOCUMENTS" && origin="LEGACY")
    case waitingDocumentsLegacy
    
    case waitingAnalysis
    
    case denied
    
    case waitingCorrections
    
    case disapproved

    /// this state erpresentas an user with an
    /// active account status
    /// (status = "ACTIVE")
    case active
    
    /// this state representas an user with an
    /// account, but that returns an "error" 403
    /// (error code = 403)
    case active403

}
