
import Foundation

public struct GPAddress: Codable {
    public let street: String?
    public let number: String?
    public let complement: String?
    public let neighborhood: String?
    public let city: String?
    public let state: String?
    public let zip: String?
    public let country: String?
}
