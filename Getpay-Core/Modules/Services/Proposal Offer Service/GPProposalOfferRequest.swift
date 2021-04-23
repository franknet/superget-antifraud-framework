
public struct GPProposalOfferRequest: BaseRequestProtocol {
    public var path: String
    
    init(_ merchantId: Int) {
        path = Urls.shared.baseURL + "/v1/merchant/\(merchantId)/scd/proposal/offer"
    }
}

// MARK: - Transaction Response

public struct GPProposalOfferResponse: Codable {
    public var productName: String
    public var minimumAvailableValue: Double
    public var maximumAvailableValue: Double
    public var maximumInstallments: Int
    public var minimumInstallments: Int
    public var interestRate: Int
}
