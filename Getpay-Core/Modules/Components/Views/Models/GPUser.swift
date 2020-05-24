//
//  GPUser.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 21/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import Foundation

public class GPUser: Codable {
    
    public var username: String = ""
    public var email: String = ""
    public var name: String = ""
    public var cpf: String = ""
    public var urlPicture: String? = nil
    
    public convenience init(username: String, email: String, name: String) {
        self.init()
        self.username = username
        self.email = email
        self.name = name
        self.cpf = username
    }
    
    internal required init() {}
    
}
