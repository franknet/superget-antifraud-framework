import Foundation

public struct GNProposalOffer: Codable {
    public var productName: String
    public var minimumAvailableValue: Decimal
    public var maximumAvailableValue: Decimal
    public var maximumInstallments: Int
    public var minimumInstallments: Int
}

