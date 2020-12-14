import Foundation
import UIKit

// MARK: - Class

public class GNNotificationService {
    
    // MARK: - Private Variables
    
    private let service = ServiceManager(isJsonBody: true)
    
    private var merchantId = GPUtils.loadGPMerchantFromUD().id
    
    // MARK: - Initializers
    
    public init() {}
}

extension GNNotificationService {
    
    // MARK: - Public methods
    
    public func update(deviceId: String, completion: @escaping (Bool) -> Void) {
        self.put(deviceId: deviceId) { error in
            if let _ = error {
                completion(false)
            }
            completion(true)
        }
    }
    
    // MARK: - Private methods
    
    private func put(deviceId: String, completion: @escaping (GPResponseError?) -> Void) -> Void {
        let request = NotificationRequest(merchantId: merchantId, deviceId: deviceId)
        service.performRequest(route: request, completion: completion)
    }
}

// MARK: - Struct NotificationRequest

struct NotificationRequest: BaseRequestProtocol {
    var path: String
    var method: GPHttpMethod
    var body: Parameters?
    
    init(merchantId: Int, deviceId: String) {
        path = Urls.shared.baseURL + "/v1/merchant/\(merchantId)/id-device"
        method = .put
        body = [
            "idDevice": deviceId
        ]
    }
}
