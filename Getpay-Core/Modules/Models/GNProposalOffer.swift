import Foundation

public struct GNProposalOffer: Codable {
    public var productName: String
    public var minimumAvailableValue: Double
    public var maximumAvailableValue: Double
    public var maximumInstallments: Int
    public var minimumInstallments: Int
    public var interestRate: Int
}

