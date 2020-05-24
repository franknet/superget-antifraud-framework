//
//  GPBankingInstitution.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 21/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import Foundation

public class GPBankingInstitution: Codable {
    
    public var number: Int = 0
    public var name: String = ""
    
    public convenience init(number: Int, name: String) {
        self.init()
        self.number = number
        self.name = name
    }
    
    required init() {}
    
}
