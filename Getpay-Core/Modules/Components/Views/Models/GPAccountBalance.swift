//
//  GPAccountBalance.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 21/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import Foundation

public class GPAccountBalance: Codable {
    
    public var withdrawAvailableBalance: String = ""
    public var globalAvailableBalance: String = ""
    
    public convenience init(withdrawAvailableBalance: String, globalAvailableBalance: String) {
        self.init()
        self.withdrawAvailableBalance = withdrawAvailableBalance
        self.globalAvailableBalance = globalAvailableBalance
    }
    
    required init() {}
    
}
