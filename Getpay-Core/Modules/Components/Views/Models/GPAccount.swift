//
//  GPAccountModel.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 21/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import Foundation

public class GPAccount: Codable {
    
    public var id: String = ""
    public var status: String = ""
    public var number: String = ""
    public var branchNumber: String = ""
    public var origin: String = ""
    public var userAlias: String = ""
    public var aliasAccountStatus: String = ""
    public var pictureUrl: String = ""
    public var bankingInstitution: GPBankingInstitution? = nil // not optional
    public var balance: GPAccountBalance? = nil // not optional
    
    public convenience init(
        id: String,
        status: String,
        number: String,
        branchNumber: String,
        origin: String,
        userAlias: String,
        aliasAccountStatus: String,
        pictureUrl: String,
        bankingInstitution: GPBankingInstitution,
        balance: GPAccountBalance)
    {
        self.init()
        self.id = id
        self.status = status
        self.number = number
        self.branchNumber = branchNumber
        self.origin = origin
        self.userAlias = userAlias
        self.aliasAccountStatus = aliasAccountStatus
        self.pictureUrl = pictureUrl
        self.bankingInstitution = bankingInstitution
        self.balance = balance
    }
    
    required init() {}
    
}
