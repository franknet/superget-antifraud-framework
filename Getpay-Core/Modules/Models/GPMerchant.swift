import Foundation

public struct GPMerchant: Codable {
    
    public var id: Int
    public var document: String
    public var name: String
    public var tradeName: String
    public var email: String?
    public var type: Type
    public var address: GPAddress?
    public var merchantStatus: String
}

public enum Type: String, Codable {
    case PJ
    case PF
}
