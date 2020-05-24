import Foundation

public class GPTerminalService {
    
    public init(){}
    
    private func requestTerminal(merchantId: Int, completion: @escaping (Result<TerminalResponse, GPResponseError>) -> Void) {
        let service = ServiceManager(isJsonBody: true)
        let request = TerminalRequest(merchantId)
        service.performRequest(route: request, completion: completion)
    }
    
    /// If response is success, than the address and terminal number are saved in UserDefaults.
    public func getTerminal(merchantId: Int, completion: @escaping (GPResponseError?) -> Void) {
        requestTerminal(merchantId: merchantId) { [update, save] response in
            switch response {
            case let .success(data):
                update(data.address)
                save(data.terminal.number)
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    private func update(_ address: GPAddress) {
        let merchant = GPUtils.loadGPMerchantFromUD()
        merchant.address = address
        GPUtils.saveGPMerchantInUD(merchant: merchant)
    }
    
    private func save(_ terminal: String) {
        GPUtils.saveTerminalInUD(terminal: terminal)
    }
}

// MARK: Request

struct TerminalRequest: BaseRequestProtocol {
    var path: String
    var method: GPHttpMethod
    var body: Parameters?
    
    init(_ merchantId: Int) {
        path = Urls.shared.baseURL + "/v1/merchant/\(merchantId)/terminal"
        method = .post
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            body = ["number" : appVersion]
        }
        
    }
}

// MARK: Response

public struct TerminalResponse: Codable {
    public let terminal: Terminal
    public let address: GPAddress
}
