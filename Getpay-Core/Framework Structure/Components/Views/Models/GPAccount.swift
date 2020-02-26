//
//  GPAccountModel.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 21/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import Foundation

public struct GPAccount {
    
    var id: String
    var status: String
    var number: String
    var branchNumber: String
    var pictureUrl: String
    var bankingInstitution: GPBankingInstitution
    var balance: GPAccountBalance
    
    init(id: String, status: String, number: String, branchNumber: String, pictureUrl: String, bankingInstitution: GPBankingInstitution, balance: GPAccountBalance) {
        self.id = id
        self.status = status
        self.number = number
        self.branchNumber = branchNumber
        self.pictureUrl = pictureUrl
        self.bankingInstitution = bankingInstitution
        self.balance = balance
    }
    
}
