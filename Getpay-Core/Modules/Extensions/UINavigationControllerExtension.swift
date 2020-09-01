import UIKit

public class GPNavigationController: UINavigationController, UINavigationControllerDelegate {
    public override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    public func navigationController(_: UINavigationController, willShow viewController: UIViewController, animated _: Bool) {
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }
}

public class GPNavBar: UINavigationBar {
    override init(frame: CGRect) { //for using custom view in code
        super.init(frame: frame)
        setupBackButtonNavBar()
        setBackGroundTransparent()
    }

    required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
        setupBackButtonNavBar()
        setBackGroundTransparent()
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        setupBackButtonNavBar()
        setBackGroundTransparent()
    }
}

public extension GPNavBar {
    func setupBackButtonNavBar() {
        let backButtonImage = #imageLiteral(resourceName: "gn_back")
        backIndicatorImage = backButtonImage
        backIndicatorTransitionMaskImage = backButtonImage
        tintColor = GPColors.homer.color
        barTintColor = GPColors.homer.color
    }

    func setBackGroundTransparent() {
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = true
        backgroundColor = GPColors.maggie.color
    }
}

public extension UINavigationBar {
//    func setupBackButtonNavBar() {
//        let backButtonImage = #imageLiteral(resourceName: "gn_back")
//        backIndicatorImage = backButtonImage
//        backIndicatorTransitionMaskImage = backButtonImage
//        tintColor = GPColors.homer.color
//        barTintColor = GPColors.homer.color
//    }
//
    func setTransparent() {
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = true
        backgroundColor = .clear
    }
}

public extension UINavigationController {
    func backTo(viewController: Any) {
        // iterate to find the type of vc
        for element in viewControllers as Array {
            if "\(type(of: element)).Type" == "\(type(of: viewController))" {
                self.popToViewController(element, animated: true)
                break
            }
        }
    }

    func hiddenNavBar() {
        self.navigationBar.isHidden = true
    }

    func showNavBar() {
        navigationBar.isHidden = false
    }
    
    var previousViewController: UIViewController? {
       viewControllers.count > 1 ? viewControllers[viewControllers.count - 2] : nil
    }
}

public extension GPNavigationController {
    convenience init(navigationBarClass: Swift.AnyClass?, toolbarClass: Swift.AnyClass?, rootViewController: UIViewController) {
        self.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
        self.viewControllers = [rootViewController]
    }
}
