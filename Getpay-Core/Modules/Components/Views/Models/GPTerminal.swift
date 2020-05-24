//
//  File.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 21/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import Foundation

public class GPTerminal: Codable {
    
    public var number: String = ""
    
    internal required init() {}

    convenience public init(number: String) {
        self.init()
        self.number = number
    }
    
    public func getTerminal() -> String {
        return number
    }

}

public struct Terminal: Codable {
    public let number: String
}
