import Foundation

public protocol TokenConfirmationDelegate: AnyObject {
    func getToken(token: String)
}

public protocol TokenConfirmationWithResendSMSDelegate: AnyObject {
    func getToken(token: String)
    func resendToken(completion: @escaping (GPResponseError?) -> Void)
}
