//
//  GP.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 21/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import UIKit

public struct GPErrorMessage {
    
    var title: String
    var description: String
    var image: UIImage
    var primaryButtonText: String
    var errorCode: String? = nil
    var secondaryButtonText: String? = nil
    var toastText: String? = nil
    
    init(title: String, description: String, image: UIImage, primaryButtonText: String) {
        self.title = title
        self.description = description
        self.image = image
        self.primaryButtonText = primaryButtonText
    }
    
}
