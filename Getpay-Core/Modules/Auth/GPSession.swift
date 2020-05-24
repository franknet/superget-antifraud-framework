//
//  GPSession.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 22/03/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import Foundation

// MARK: Class

public class GPSession: Codable {
    
    // MARK: Internal Variables

    // User and Merchant are not optionals,
    // but for persistence in Realm we need
    // to set then as optionals
    var id = "0"
    var user: GPUser? // not optional
    var selectedMerchant: GPMerchant? //not optional
    var terminal: GPTerminal?
    var account: GPAccount?
    
    // MARK: Initializers
    
    convenience init(user: GPUser, merchant: GPMerchant, terminal: GPTerminal?, account: GPAccount?) {
        self.init()
        self.user = user
        self.selectedMerchant = merchant
        self.terminal = terminal
        self.account = account
    }
    
    required init() {}
    
}
