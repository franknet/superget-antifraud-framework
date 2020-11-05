import UIKit

// MARK: - Class

final class OnboardingStepViewController: BaseViewController<OnboardingStepView> {
    
    // MARK: - Initializers
    
    init(image: UIImage,
         title: String,
         subTitle: String) {
        super.init()
        customView.configure(image: image,
                             title: title,
                             subTitle: subTitle)
    }
}
