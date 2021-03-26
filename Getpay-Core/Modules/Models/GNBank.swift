import Foundation

// MARK: - Struct

public struct GNBank: Codable {
    public var status: GNAccountStatus
    public var creationDate: String?
    public var isCriticalToSendDocuments: Bool?
}
