import UIKit

public extension UICollectionViewCell {
    
    func setCornerRadiusAndShadow(cornerRadius: CGFloat = 8.0,
                                  shadowColor: UIColor = GPColors.moe.color) {
        layer.cornerRadius = 8.0
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowColor = shadowColor.cgColor
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 1.0
    }
}
