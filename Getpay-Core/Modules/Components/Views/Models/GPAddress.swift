//
//  GPAddress.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 21/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import Foundation

public struct GPAddress {
    
    var street: String
    var number: String
    var complement: String
    var neighborhood: String
    var city: String
    var state: String
    var zip: String
    var country: String

    init(street: String, number: String, complement: String, neighborhood: String, city: String, state: String, zip: String, country: String) {
        self.street = street
        self.number = number
        self.complement = complement
        self.neighborhood = neighborhood
        self.city = city
        self.state = state
        self.zip = zip
        self.country = country
    }
    
}
