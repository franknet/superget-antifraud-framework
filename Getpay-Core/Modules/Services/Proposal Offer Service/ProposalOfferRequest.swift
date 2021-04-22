
struct ProposalOfferRequest: BaseRequestProtocol {
    var path: String
    
    init(_ merchantId: Int) {
        path = Urls.shared.baseURL + "/api/v1/merchant/\(merchantId)/scd/proposal/offer"
    }
}

// MARK: - Transaction Response

struct ProposalOfferResponse: Codable {
    var productName: String
    var minimumAvailableValue: Decimal?
    var maximumAvailableValue: Decimal
    var maximumInstallments: Int?
    var minimumInstallments: Int?
    var interestRate: Int? // -Taxa de Juros
}
