//
//  GPAccountBalance.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 21/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import Foundation

public struct GPAccountBalance: Codable {
    public var id: Int
    public var withdrawAvailableBalance: Double
    public var globalAvailableBalance: Double
}