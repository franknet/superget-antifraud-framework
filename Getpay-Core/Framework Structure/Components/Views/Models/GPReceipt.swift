//
//  GPReceipt.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 21/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import Foundation

public struct GPReceipt {
    
    var data: [GPReceiptData]
    var message: String
    
    init(data: [GPReceiptData], message: String) {
        self.data = data
        self.message = message
    }
    
}
