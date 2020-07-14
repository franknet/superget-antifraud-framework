
import Foundation

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
    
    case underAnalysis
    
    
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