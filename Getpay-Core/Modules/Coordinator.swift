import UIKit

public protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    var parent: Coordinator? { get set }
    func start()
}

public extension Coordinator {
    func add(_ child: Coordinator) {
        children.append(child)
        child.parent = self
    }

    func remove(_ child: Coordinator) {
        children.removeAll { $0 === child }
    }
}
