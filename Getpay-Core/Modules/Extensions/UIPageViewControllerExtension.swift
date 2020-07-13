import UIKit

public extension UIPageViewController {
    func goToNextPage() {
        guard let currentViewController = viewControllers?.first else { return }

        guard let nextViewController = dataSource?.pageViewController( self, viewControllerAfter: currentViewController ) else { return }

        setViewControllers([nextViewController], direction: .forward, animated: false, completion: nil)
    }

    func goToPreviousPage() {
        guard let currentViewController = viewControllers?.first else { return }

        guard let previousViewController = dataSource?.pageViewController( self, viewControllerBefore: currentViewController ) else { return }

        setViewControllers([previousViewController], direction: .reverse, animated: false, completion: nil)
    }

    func goTo(controller: UIViewController, direction: SwitchAnimationDirection) {
        let navDirection: NavigationDirection = direction == .right ? .forward : .reverse
        setViewControllers([controller],
                           direction: navDirection,
                           animated: true,
                           completion: nil)
    }
}
