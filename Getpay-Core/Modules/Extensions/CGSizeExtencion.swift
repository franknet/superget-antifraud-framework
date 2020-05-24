//
//  CGSizeExtencion.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 21/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import UIKit

public extension CGSize {
    func convert(currentSize: CGSize, idealSize: CGSize) -> CGSize {
        let newWidth = self.width.convert(viewSize: currentSize.width, viewIdealSize: idealSize.width)
        let newHeight = self.height.convert(viewSize: currentSize.height, viewIdealSize: idealSize.height)
        return CGSize(width: newWidth, height: newHeight)
    }
    
    static var screenIdealSize: CGSize {
//        return CGSize(width: 320, height: 568) // iPhone 5C screen size
        return CGSize(width: 416, height: 734) // Design screen size
    }

    static var screenSize: CGSize {
        return UIScreen.main.bounds.size
    }
}
