import Foundation

public protocol GPBasePageableList: Codable {
    var pageable: Pageable { get set }
    var totalPages: Int { get set }
    var totalElements: Int { get set }
    var last: Bool { get set }
    var sort: Sort { get set }
    var numberOfElements: Int { get set }
    var first: Bool { get set }
    var size: Int { get set }
    var number: Int { get set }
    var empty: Bool { get set }
}

public struct Pageable: Codable {
    public let sort: Sort
    public let pageNumber: Int
    public let pageSize: Int
    public let offset: Int
    public let paged: Bool
    public let unpaged: Bool
}

public struct Sort: Codable {
    public let sorted: Bool
    public let unsorted: Bool
    public let empty: Bool
}
