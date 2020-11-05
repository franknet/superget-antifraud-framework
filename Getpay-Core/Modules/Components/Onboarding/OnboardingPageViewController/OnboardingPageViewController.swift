import UIKit

// MARK: - OnboardingPageViewControllerDelegate

protocol OnboardingPageViewControllerDelegate: class {
    func onboardingPageViewController(didUpdatePageIndex index: Int)
}

// MARK: - Class

final class OnboardingPageViewController: UIPageViewController {
    
    // MARK: - Private variables
    
    weak var onboardingDelegate: OnboardingPageViewControllerDelegate?
    
    var contentViewControllers = [OnboardingStepViewController]()
    
    var presentationIndex: Int {
        if let uniqueViewController = viewControllers?.first,
           let index = contentViewControllers.firstIndex(of: uniqueViewController as! OnboardingStepViewController) {
            return index
        }
        return 0
    }
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
    }
}

// MARK: - DataSource and Delegate

extension OnboardingPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? OnboardingStepViewController {
            if let viewControllerIndex = contentViewControllers.firstIndex(of: viewController) {
                if viewControllerIndex == 0 {
                    return nil
                } else {
                    return contentViewControllers[viewControllerIndex - 1]
                }
            }
        }
        return nil
    }

    public func pageViewController(_ pageViewController: UIPageViewController,
                                   viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? OnboardingStepViewController {
            if let viewControllerIndex = contentViewControllers.firstIndex(of: viewController) {
                if viewControllerIndex < contentViewControllers.count - 1 {
                    return contentViewControllers[viewControllerIndex + 1]
                } else {
                    return nil
                }
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        
        onboardingDelegate?.onboardingPageViewController(didUpdatePageIndex: presentationIndex)
    }
}
