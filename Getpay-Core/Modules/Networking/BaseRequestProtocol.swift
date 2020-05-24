import Alamofire

public typealias Parameters = [String: Any]

public typealias GPHttpMethod = HTTPMethod

public typealias Headers = HTTPHeaders

///Base request model
public protocol BaseRequestProtocol {
    var method: GPHttpMethod { get }
    /// Path  = baseUrl+ url
    var path: String { get }
    /// body =  [String: Any]
    var body: Parameters? { get }
    /// headers = [String: String]
    var headers: Headers? { get }
}

public extension BaseRequestProtocol {
    var method: GPHttpMethod {
        return .get
    }
    var body: Parameters? {
        return nil
    }
    var headers: Headers? {
        return nil
    }
}
