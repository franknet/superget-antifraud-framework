//
//  GPMerchant.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 21/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import Foundation

public struct GPMerchant {
    
    var id: Int
    var document: String
    var name: String
    var tradeName: String
    var email: String
    var address: GPAddress
    
    init(id: Int, document: String, name: String, tradeName: String, email: String, address: GPAddress) {
        self.id = id
        self.document = document
        self.name = name
        self.tradeName = tradeName
        self.email = email
        self.address = address
    }
    
}
