import UIKit
import RxSwift
import RxCocoa

// MARK: - Class

/// Required to call populate function
public class GPPageViewController: UIViewController {
    
    // MARK: - Private variables
    
    private var pages = [UIViewController]()
    
    private var buttonsView: GPTabButton?
    
    private var pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    private var current = BehaviorRelay<Int>(value: 0)
    
    // MARK: - Override methods
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        addComponents()
        createConstraints()
        setupPageViewController()
        view.gestureRecognizers = pageViewController.gestureRecognizers
    }
}

extension GPPageViewController {
    
    // MARK: - Private methods
    
    private func addComponents() {
        guard let buttons = buttonsView else { return }
        addChild(pageViewController)
        view.addSubviews([buttons, pageViewController.view], constraints: true)
    }
    
    private func createConstraints() {
        guard let buttons = buttonsView else { return }
        buttons.applyAnchors(ofType: [.top, .leading, .trailing], to: view)
        buttons.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        pageViewController.view.topAnchor.constraint(equalTo: buttons.bottomAnchor).isActive = true
        pageViewController.view.applyAnchors(ofType: [.leading, .trailing, .bottom], to: view)
    }
    
    private func go(toPage page: Int) {
        guard page < pages.count else { return }
        guard page != current.value else { return }
        
        let animationDirection: SwitchAnimationDirection = page < current.value ? .left : .right
        let controller = pages[page]
        current.accept(page)
        pageViewController.goTo(controller: controller, direction: animationDirection)
    }
    
    private func setupPageViewController() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.didMove(toParent: self)
    }
    
    private func setupRx() {
        guard let buttons = buttonsView else { return }
        buttons.currentButtonIndex.subscribe { [weak self] index in
            guard let indexValue = index.element else { return }
            self?.go(toPage: indexValue)
        }.disposed(by: disposeBag)
        
        current.subscribe { index in
            guard let indexValue = index.element else { return }
            buttons.setCurrent(buttonIndex: indexValue)
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Public methods
    
    public func populate(viewControllers: [UIViewController], buttonsTitles: [String]) {
        pages = viewControllers
        buttonsView = GPTabButton(titles: buttonsTitles)
        pageViewController.setViewControllers([pages[0]],
                                              direction: .forward,
                                              animated: true,
                                              completion: nil)
        setupRx()
    }
}


extension GPPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = pages.firstIndex(of: viewController) {
            if viewControllerIndex == 0 {
                return nil
            } else {
                return pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = pages.firstIndex(of: viewController) {
            if viewControllerIndex < pages.count - 1 {
                return pages[viewControllerIndex + 1]
            } else {
                return nil
            }
        }
        return nil
    }
    
    public func pageViewController(_: UIPageViewController, didFinishAnimating _: Bool, previousViewControllers _: [UIViewController], transitionCompleted _: Bool) {
        if let vc = pageViewController.viewControllers?.first {
            if let index = pages.firstIndex(of: vc) {
                current.accept(index)
            }
        }
    }
}

extension GPPageViewController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var direction: SwitchAnimationDirection
        if scrollView.panGestureRecognizer.velocity(in: scrollView.superview).x > 0 {
            direction = .left
        } else {
            direction = .right
        }
        
        let point = scrollView.contentOffset
        var percentComplete: CGFloat
        percentComplete = abs(point.x - view.frame.size.width) / view.frame.size.width
        
        didScroll(percentage: percentComplete, direction: direction)
    }
    
    private func didScroll(percentage: CGFloat, direction: SwitchAnimationDirection) {
        guard let buttons = buttonsView else { return }
        buttons.animateLine(direction: direction, percentage: percentage)
    }
}
