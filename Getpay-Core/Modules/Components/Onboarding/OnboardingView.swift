import UIKit

// MARK: - Class

public final class OnboardingView: UIView {
    
    // MARK: - Internal variables
    
    let nextButton = GPButton(title: "CONTINUAR",
                              style: .outlined)
    
    let pageViewController: OnboardingPageViewController = {
        let pageView = OnboardingPageViewController(transitionStyle: .scroll,
                                                    navigationOrientation: .horizontal)
        return pageView
    }()
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = GPColors.moe.color
        pageControl.currentPageIndicatorTintColor = GPColors.homer.color
        return pageControl
    }()
    
    // MARK: - Initializers
    
    public init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension OnboardingView {
    
    // MARK: - Internal methods
    
    func configurePageView(pages: [OnboardingStepViewController]) {
        pageViewController.contentViewControllers = pages
        pageControl.numberOfPages = pages.count
        pageViewController.setViewControllers([pageViewController.contentViewControllers[0]],
                                              direction: .forward,
                                              animated: true,
                                              completion: nil)
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        backgroundColor = GPColors.maggie.color
        addComponents()
        setPageView()
        setupPageControl()
        setupNextButton()
    }
    
    private func addComponents() {
        addSubviews([pageViewController.view,
                     pageControl,
                     nextButton], constraints: true)
    }
    
    private func setPageView() {
        pageViewController.view.backgroundColor = .clear
        pageViewController.view.applyAnchors(ofType: [.trailing,
                                                      .leading], to: self)
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func setupPageControl() {
        pageControl.topAnchor.constraint(equalTo: pageViewController.view.bottomAnchor, constant: 8.0).isActive = true
        pageControl.applyAnchors(ofType: [.trailing,
                                          .leading], to: self)
    }
    
    private func setupNextButton() {
        nextButton.height(size: 40)
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 8.0),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            nextButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }
}
