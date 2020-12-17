import UIKit
import FittedSheets

public extension SheetViewController {
    func defaultConfigs() {
        self.blurBottomSafeArea = false
        self.adjustForBottomSafeArea = true
        self.topCornersRadius = 16.0
        self.dismissOnBackgroundTap = true
        self.extendBackgroundBehindHandle = true
        self.overlayColor = GPColors.barney.color.withAlphaComponent(0.32)
    }
}
