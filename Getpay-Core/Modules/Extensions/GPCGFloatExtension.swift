//
//  GPFloatExtension.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 21/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import UIKit

extension CGFloat {
    func convert(viewSize: CGFloat, viewIdealSize: CGFloat) -> CGFloat {
        let scale = viewSize / viewIdealSize
        return self * scale
    }
}
