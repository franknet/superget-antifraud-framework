import UIKit

public extension UIView {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    class func animateWithDefaultDuration(_ animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: TimeInterval(UINavigationController.hideShowBarDuration), animations: animations, completion: completion)
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static func instantiate(autolayout: Bool = true) -> Self {
        // generic helper function
        func instantiateUsingNib<T: UIView>(autolayout: Bool) -> T {
            let view = self.nib.instantiate() as! T
            view.translatesAutoresizingMaskIntoConstraints = !autolayout
            return view
        }
        return instantiateUsingNib(autolayout: autolayout)
    }
    
    class func loadFromNibNamed(nibNamed: String, bundle: Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
        ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
    func addSubview(_ subview: UIView, constraints: Bool) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = !constraints
    }
    
    func addSubviews(_ subviews: [UIView], constraints: Bool) {
        for subview in subviews {
            addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = !constraints
        }
    }
    
    // MARK: - Anchors extensions
    
    enum AnchorType {
        case top
        case bottom
        case leading
        case trailing
        case heigth
        case width
        case centerX
        case centerY
    }
    
    func applyAnchors(ofType: [AnchorType], to referenceView: UIView) {
        
        if ofType.contains(.bottom) {
            self.bottomAnchor.constraint(equalTo: referenceView.bottomAnchor).isActive = true
        }
        
        if ofType.contains(.top) {
            self.topAnchor.constraint(equalTo: referenceView.topAnchor).isActive = true
        }
        
        if ofType.contains(.trailing) {
            self.trailingAnchor.constraint(equalTo: referenceView.trailingAnchor).isActive = true
        }
        
        if ofType.contains(.leading) {
            self.leadingAnchor.constraint(equalTo: referenceView.leadingAnchor).isActive = true
        }
        
        if ofType.contains(.heigth) {
            self.heightAnchor.constraint(equalTo: referenceView.heightAnchor).isActive = true
        }
        
        if ofType.contains(.width) {
            self.widthAnchor.constraint(equalTo: referenceView.widthAnchor).isActive = true
        }
        
        if ofType.contains(.centerX) {
            self.centerXAnchor.constraint(equalTo: referenceView.centerXAnchor).isActive = true
        }
        if ofType.contains(.centerY) {
            self.centerYAnchor.constraint(equalTo: referenceView.centerYAnchor).isActive = true
        }
    }
    
    @discardableResult
    func height(size: CGFloat) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        constraint = heightAnchor.constraint(equalToConstant: size)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func height(min: CGFloat) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        constraint = heightAnchor.constraint(greaterThanOrEqualToConstant: min)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func width(size: CGFloat) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        constraint = widthAnchor.constraint(equalToConstant: size)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func width(min: CGFloat) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        constraint = widthAnchor.constraint(greaterThanOrEqualToConstant: min)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func centerX(to: UIView, padding: CGFloat? = 0) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        constraint = centerXAnchor.constraint(equalTo: to.centerXAnchor, constant: padding ?? 0)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func centerY(to: UIView, padding: CGFloat? = nil) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        constraint = centerYAnchor.constraint(equalTo: to.centerYAnchor, constant: padding ?? 0)
        constraint.isActive = true
        return constraint
    }
    
    func center(to view: UIView) {
        self.applyAnchors(ofType: [.centerX, .centerY], to: view)
    }
    
    func setGradient(colors: [CGColor], angle: Float = 0) {
        let gradientLayerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = gradientLayerView.bounds
        gradient.colors = colors
        
        let alpha: Float = angle / 360
        let startPointX = powf(
            sinf(2 * Float.pi * ((alpha + 0.75) / 2)),
            2
        )
        let startPointY = powf(
            sinf(2 * Float.pi * ((alpha + 0) / 2)),
            2
        )
        let endPointX = powf(
            sinf(2 * Float.pi * ((alpha + 0.25) / 2)),
            2
        )
        let endPointY = powf(
            sinf(2 * Float.pi * ((alpha + 0.5) / 2)),
            2
        )
        
        gradient.endPoint = CGPoint(x: CGFloat(endPointX), y: CGFloat(endPointY))
        gradient.startPoint = CGPoint(x: CGFloat(startPointX), y: CGFloat(startPointY))
        
        gradientLayerView.layer.insertSublayer(gradient, at: 0)
        layer.insertSublayer(gradientLayerView.layer, at: 0)
    }
    
    func snapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let viewCopy = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return viewCopy
    }
}
