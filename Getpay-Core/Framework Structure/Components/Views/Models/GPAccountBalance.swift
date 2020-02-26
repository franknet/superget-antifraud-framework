//
//  GPAccountBalance.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 21/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import Foundation

public struct GPAccountBalance {
    
    var withdrawAvailableBalance: String
    var globalAvailableBalance: String
    
    init(withdrawAvailableBalance: String, globalAvailableBalance: String) {
        self.withdrawAvailableBalance = withdrawAvailableBalance
        self.globalAvailableBalance = globalAvailableBalance
    }
    
}
