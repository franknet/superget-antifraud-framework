//
//  GPOutlinedButton.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 11/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import UIKit

public class GPContainedButton: GPRoundedButton {
    
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
        backgroundImageColor = GPColors.homer.color
        
        // Default Text Color
        setTitleColor(GPColors.maggie.color,
                      for: .normal)
        titleLabel?.textColor = GPColors.maggie.color
        titleLabel?.font = FontFamily.Calibri.light.font(size: 16.0)
        
        // Default Border Color
        borderSize = 0
        borderColor = UIColor.clear
        
        layoutSubviews()
    }
    
    private func disabledColor() {
        setTitleColor(GPColors.krusty.color,
                      for: .normal)
        titleLabel?.textColor = GPColors.krusty.color
        
        backgroundImageColor = GPColors.maggie.color

        borderColor = GPColors.krusty.color
        
        layoutSubviews()
    }

    
    
}
