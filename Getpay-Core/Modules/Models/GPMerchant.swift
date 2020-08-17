import Foundation

public class GPMerchant: Codable {
    
    public var id: Int = 0
    public var document: String = ""
    public var name: String = ""
    public var tradeName: String = ""
    public var email: String? = ""
    public var type: Type = .PF
    public var address: GPAddress?
    public var merchantStatus: String = ""
    
    public convenience init(id: Int,
                            document: String,
                            name: String,
                            tradeName: String,
                            email: String,
                            type: Type,
                            address: GPAddress? = nil,
                            merchantStatus: String) {
        self.init()
        self.id = id
        self.document = document
        self.name = name
        self.tradeName = tradeName
        self.email = email
        self.type = type
        self.address = address
        self.merchantStatus = merchantStatus
    }
    
    internal required init() {}
    
    private enum CodingKeys: String, CodingKey {
        case id
        case document
        case name
        case tradeName
        case email
        case type
        case address
        case merchantStatus
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            self.id = try container.decode(Int.self, forKey: .id)
            self.document = try container.decode(String.self, forKey: .document)
            self.name = try container.decode(String.self, forKey: .name)
            self.tradeName = try container.decode(String.self, forKey: .tradeName)
            self.email = try? container.decode(String.self, forKey: .email)
            self.type = try container.decode(Type.self, forKey: .type)
            self.address = try? container.decode(GPAddress.self, forKey: .address)
            self.merchantStatus = try container.decode(String.self, forKey: .merchantStatus)
        } catch let error {
            GPLogger.log(error.localizedDescription)
            fatalError(error.localizedDescription)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(id, forKey: .id)
            try container.encode(document, forKey: .document)
            try container.encode(name, forKey: .name)
            try container.encode(tradeName, forKey: .tradeName)
            try container.encode(email, forKey: .email)
            try container.encode(type, forKey: .type)
            try container.encode(address, forKey: .address)
            try container.encode(merchantStatus, forKey: .merchantStatus)
        } catch let error {
            GPLogger.log(error.localizedDescription)
            fatalError(error.localizedDescription)
        }
    }
}

public enum Type: String, Codable {
    case PJ
    case PF
}
