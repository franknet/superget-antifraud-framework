import Foundation
import UIKit

// MARK: - Class

open class GPLabel: UILabel {
    
    // MARK: - Initializers
    
    /// - Parameters:
    ///   - font: FontFamily.Calibri.regular
    ///   - fontSize: 14.0
    ///   - alignment: .left
    ///   - textColor: GPColors.edna.color
    ///   - numberOfLines: 0
    public convenience init(text: String? = nil,
                            font: FontConvertible? = FontFamily.Calibri.regular,
                            fontSize: CGFloat? = 14.0,
                            alignment: NSTextAlignment? = .left,
                            textColor: UIColor? = GPColors.edna.color,
                            numberOfLines: Int? = 0,
                            adjustsFontToFitWidth: Bool? = false) {
        
        self.init()
        
        if let text = text {
            self.text = text
        }
        
        if let alignment = alignment {
            self.textAlignment = alignment
        }
        
        if let numberOfLines = numberOfLines {
            self.numberOfLines = numberOfLines
        }
        
        if let color = textColor {
            self.textColor = color
        }
        
        if let font = font {
            if let size = fontSize {
                self.font = font.font(size: size)
            }
        }
        
        if let adjustsFontToFitWidth = adjustsFontToFitWidth {
            self.adjustsFontSizeToFitWidth = adjustsFontToFitWidth
        }
    }
}
