//
//  Int+formatedAsCurrency.swift
//  SuperGetMobile
//
//  Created by eduardo fornari on 02/05/19.
//  Copyright © 2019 Getnet. All rights reserved.
//

import Foundation

public extension Int {
    var formatedAsDouble: Double {
        var numberAsDouble = Double(self)
        numberAsDouble *= 0.01
        return numberAsDouble
    }
}
