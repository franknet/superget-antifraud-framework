//
//  GPOutlinedButton.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 11/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import UIKit

public class GPTextButton: GPRoundedButton {
    
    // MARK: Properties
    
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
        backgroundImageColor = GPColors.maggie.color
        
        
        // Default Text Color
        setTitleColor(GPColors.homer.color,
                      for: .normal)
        titleLabel?.textColor = GPColors.homer.color
        titleLabel?.font = FontFamily.Calibri.light.font(size: 16.0)
        
        // Default Border Color
        borderColor = UIColor.clear
        
        layoutSubviews()
    }
    
    private func disabledColor() {
        setTitleColor(GPColors.krusty.color,
                      for: .normal)
        titleLabel?.textColor = GPColors.krusty.color
        
        backgroundImageColor = GPColors.maggie.color

        borderColor = UIColor.clear
        
        layoutSubviews()
    }
    
    
}
