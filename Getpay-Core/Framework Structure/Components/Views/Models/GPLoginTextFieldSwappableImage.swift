//
//  SGLoginTextFieldSwappableImage.swift
//  SuperGetMobile
//
//  Created by Leandro dos Santos Lopes on 05/02/19.
//  Copyright © 2019 Getnet. All rights reserved.
//

import Foundation

struct GPLoginTextFieldSwappableImage: GPSwappableImageModel {
    var enabled: String    
    var highlighted: String
    
    init(enabled: String, disabled: String) {
        self.enabled = enabled
        self.highlighted = disabled
    }
    
}
