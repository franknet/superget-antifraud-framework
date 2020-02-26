//
//  GPReceiptData.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 21/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import Foundation

public struct GPReceiptData {
    
    var label: String
    var value: String
    var descriptionLabel: String? = nil
    var descriptionValue: String? = nil
    
    init(label: String, value: String) {
        self.label = label
        self.value = value
    }
    
    init(label: String, value: String, description: String) {
        self.label = label
        self.value = value
        self.descriptionValue = description
    }
    
    init(label: String, value: String, descriptionLabel: String, descriptionValue: String) {
        self.label = label
        self.value = value
        self.descriptionLabel = descriptionLabel
        self.descriptionValue = descriptionValue
    }
    
}
