import UIKit

// MARK: - OnboardingStep

public struct OnboardingStep {
    public let title: String
    public let subtitle: String
    public let image: UIImage

    public init (title: String, subtitle: String, image: UIImage) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
}

// MARK: - Class

public final class OnboardingViewController: BaseViewController<OnboardingView> {

    // MARK: - Public variables
    
    public var callBack: ActionVoid?
    
    // MARK: - Private variables
    
    private var pages = [OnboardingStep]()
    
    // MARK: - Initializers
    
    public init(pages: [OnboardingStep]) {
        super.init()
        self.pages = pages
        configure()
    }
    
    // MARK: - Override methods
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        customView.nextButton.addTarget(self,
                                        action: #selector(nextWasTapped),
                                        for: .touchUpInside)
    }
}

extension OnboardingViewController {
    
    // MARK: - Private methods
    
    private func configure() {
        var content = [OnboardingStepViewController]()
        
        for page in pages {
            let vc = OnboardingStepViewController(image: page.image,
                                                  title: page.title,
                                                  subTitle: page.subtitle)
            content.append(vc)
        }
        
        customView.configurePageView(pages: content)
        customView.pageViewController.onboardingDelegate = self
    }
    
    @objc func nextWasTapped() {
        let index = customView.pageViewController.presentationIndex
        let pageViewCount = customView.pageViewController.contentViewControllers.count
        
        customView.pageViewController.onboardingDelegate?.onboardingPageViewController(didUpdatePageIndex: index + 1)
        
        if index < pageViewCount - 1 {
            customView.pageViewController.setViewControllers([customView.pageViewController.contentViewControllers[index + 1]],
                                                  direction: .forward,
                                                  animated: true,
                                                  completion: nil)
        } else {
            if let callBack = callBack {
                callBack()
            } else {
                dismiss(animated: true)
            }
        }
    }
}

extension OnboardingViewController: OnboardingPageViewControllerDelegate {
    func onboardingPageViewController(didUpdatePageIndex index: Int) {
        customView.pageControl.currentPage = index
        if index == pages.count - 1 {
            customView.nextButton.setTitle("OK, ENTENDI", for: .normal)
            
        } else {
            customView.nextButton.setTitle("CONTINUAR", for: .normal)
        }
    }
}
