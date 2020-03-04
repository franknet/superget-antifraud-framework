//
//  UIScreenExtension.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 14/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import UIKit

enum DeviceSizeCategory {
    case xsMax_xr_models // (414.0, 896.0)
    case x_xs_models // (375.0, 812.0)
    case plus_models // (414.0, 736.0)
    case regular_models // (375.0, 667.0)
    case compact_models // (320.0, 568.0)
}

extension UIScreen {
    static var size: CGSize {
        return UIScreen.main.bounds.size
    }

    static var deviceSizeCategory: DeviceSizeCategory {
        let screenSize = size
        if screenSize == CGSize(width: 414.0, height: 896.0) {
            return .xsMax_xr_models
        } else if screenSize == CGSize(width: 414.0, height: 812.0) {
            return .x_xs_models
        } else if screenSize == CGSize(width: 414.0, height: 736.0) {
            return .plus_models
        } else if screenSize == CGSize(width: 375.0, height: 667.0) {
            return .regular_models
        } else /*if screenSize == CGSize(width: 320.0, height: 568.0)*/ {
            return .compact_models
        }
    }
}

extension UILabel {
    func set(font: UIFont, for deviceSizeCategory: DeviceSizeCategory) {
        if UIScreen.deviceSizeCategory == deviceSizeCategory {
            self.font = font
        }
    }

    func set(fontSize: CGFloat, for deviceSizeCategory: DeviceSizeCategory) {
        if UIScreen.deviceSizeCategory == deviceSizeCategory {
            self.font = UIFont(name: font.fontName, size: fontSize)
        }
    }

    func set(fontSize: CGFloat) {
        self.font = UIFont(name: font.fontName, size: fontSize)
    }
}
