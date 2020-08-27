import Foundation

public struct GPAccount: Codable {
    public var id: Int
    public var status: String
    public var number: String
    public var branchNumber: String
    public var aliasAccountStatus: String
    public var origin: String
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
        return self.aliasAccountStatus == "ACTIVE"
    }()
}

// MARK: - Enum

public enum Eligibility: String, Codable {
    case REPROVED
    case APPROVED
    case PENDING
}
