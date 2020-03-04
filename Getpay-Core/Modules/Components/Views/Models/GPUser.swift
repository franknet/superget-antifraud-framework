//
//  GPUser.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 21/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import Foundation

public struct GPUser {
    
    var username: String
    var email: String
    var name: String
    var cpf: String
    var urlPicture: String? = nil
    
    init(username: String, email: String, name: String) {
        self.username = username
        self.email = email
        self.name = name
        self.cpf = username
    }
    
}
