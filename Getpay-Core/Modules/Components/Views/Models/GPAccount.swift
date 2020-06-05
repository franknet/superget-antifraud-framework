//
//  GPAccountModel.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 21/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import Foundation

public struct GPAccount: Codable {
    
    public var id: Int?
    public var status: String?
    public var number: String?
    public var branchNumber: String?
    public var origin: String?
    public var userAlias: String?
    public var aliasAccountStatus: String?
    public var pictureUrl: String?
    public var bankingInstitution: GPBankingInstitution?
    public var balance: GPAccountBalance?
    
}
