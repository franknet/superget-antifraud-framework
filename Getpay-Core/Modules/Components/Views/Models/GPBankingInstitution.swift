//
//  GPBankingInstitution.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 21/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import Foundation

public struct GPBankingInstitution {
    
    var number: Int
    var name: String
    
    init(number: Int, name: String) {
        self.number = number
        self.name = name
    }
    
}
