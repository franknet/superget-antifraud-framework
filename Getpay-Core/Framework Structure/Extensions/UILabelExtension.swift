//
//  UILabelExtension.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 21/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import UIKit

extension UILabel {
    func autoLayoutFont(viewHeight: CGFloat, viewIdealHeight: CGFloat) {
        guard let font = self.font else { return }

        let newFontSize = font.pointSize.convert(viewSize: viewHeight,
                                                 viewIdealSize: viewIdealHeight)
        self.font = UIFont(name: font.fontName, size: newFontSize)
    }
}
// descobrir tamanho da fonte do design
// converter fonte para o tamanho da fonte do design antes de aplicar a proporcao
