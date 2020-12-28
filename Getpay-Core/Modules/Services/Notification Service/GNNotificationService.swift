import Foundation
import UIKit

// MARK: - Class

public class GNNotificationService {
    
    // MARK: - Private Variables
    
    private let service = ServiceManager(isJsonBody: true)
    
    // MARK: - Initializers
    
    public init() {}
}

extension GNNotificationService {
    
    // MARK: - Public methods
    
    public func update(deviceId: String, completion: @escaping (Bool) -> Void) {
        put(deviceId: deviceId) { error in
            guard let _ = error else {
                completion(true)
                return
            }
            completion(false)
        }
    }
    
    // MARK: - Private methods
    
    private func put(deviceId: String, completion: @escaping (GPResponseError?) -> Void) -> Void {
        let merchantId = GPUtils.loadGPMerchantFromUD().id
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
