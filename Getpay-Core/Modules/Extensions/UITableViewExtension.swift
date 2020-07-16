import UIKit

public extension UITableView {
    func snapshotForCompletePage() -> UIImage {
        showsVerticalScrollIndicator = false
        let tmpFrame: CGRect = frame
        
        var fullSizeFrame: CGRect = frame
        fullSizeFrame.size.height = contentSize.height
        
        frame = fullSizeFrame
        
        UIGraphicsBeginImageContextWithOptions(fullSizeFrame.size, false, UIScreen.main.scale)
        let resizedContext: CGContext = UIGraphicsGetCurrentContext()!
        layer.render(in: resizedContext)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        frame = tmpFrame
        return image
    }
}
