import Foundation

public struct GPAccount: Codable {
    public var id: Int
    public var status: AccountStatus
    public var number: String
    public var branchNumber: String
    public var aliasAccountStatus: AliasAccountStatus
    public var origin: AccountOrigin?
    public var institution: GPBankingInstitution
    public var balance: GPAccountBalance
    public var hasCard: Bool
    public var requestStatus: GPAccountRequestStatus? = .loading
    public var userAlias: String?
    public var pictureUrl: String?
    public var eligibility: Eligibility?
    public var lastEligibilityCall: Date?
    public var creationDate: String?
    public var isCriticalToSendDocuments: Bool
    
    public lazy var isAliasAccountActive: Bool = {
        return self.aliasAccountStatus == .ACTIVE
    }()
}

// MARK: - Enum

public enum Eligibility: String, Codable {
    case REPROVED
    case APPROVED
    case PENDING
}

public enum AccountStatus: String, Codable {
    case WAITING_DOCUMENTS
    case ACTIVE
    case DENIED
    case NONE
    case WAITING_CORRECTIONS
    case WAITING_ANALYSIS
}

public enum AccountOrigin: String, Codable {
    case VIZIR
    case NEW_CLIENT
    case LEGACY
    case NONE
}


public enum AliasAccountStatus: String, Codable {
    case PENDING
    case ACTIVE
    case LOCKED
    case CLOSED
    case NOT_REQUESTED
    case NOT_ACTIVE
}
