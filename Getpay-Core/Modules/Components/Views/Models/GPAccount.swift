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
    public var requestStatus: GPAccountRequestStatus?
    public var number: String?
    public var branchNumber: String?
    public var origin: String?
    public var userAlias: String?
    public var aliasAccountStatus: String?
    public var pictureUrl: String?
    public var institution: GPBankingInstitution?
    public var balance: GPAccountBalance?
    
    
    public lazy var isAliasAccountActive: Bool = {
        return self.aliasAccountStatus == "ACTIVE"
    }()
    
    static var loading: GPAccount {
        return GPAccount(requestStatus: .loading)
    }
    
}
