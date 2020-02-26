//
//  GPOutlinedButton.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 11/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import UIKit

@IBDesignable
public class GPOutlinedButton: GPRoundedButton {
    
    // MARK: Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialColors()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialColors()
    }
    
    // MARK: Custom Methods
    
    private func initialColors() {
        // Default Background Color
        backgroundImageColor = GPConstants.Colors.Buttons.secondary
        
        // Default Text Color
        setTitleColor(GPConstants.Colors.Buttons.primary,
                      for: .normal)
        titleLabel?.textColor = GPConstants.Colors.Buttons.primary
        titleLabel?.font = GPConstants.Fonts.Buttons.defaultFont
        
        // Default Border Color
        borderSize = 1
        borderColor = GPConstants.Colors.Buttons.primary
        
        layoutSubviews()
    }
    
    private func disabledColor() {
        setTitleColor(GPConstants.Colors.Buttons.disabled,
                      for: .normal)
        titleLabel?.textColor = GPConstants.Colors.Buttons.disabled
        
        backgroundImageColor = GPConstants.Colors.Buttons.secondary

        borderColor = GPConstants.Colors.Buttons.disabled
        
        layoutSubviews()
    }

    
    
}
