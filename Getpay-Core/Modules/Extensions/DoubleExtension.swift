//
//  DoubleExtension.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 19/03/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import Foundation

public extension Double {
    var formatedAsCurrency: String {
        let numberFormatter = NumberFormatter()
        // FIXME: puxar do perfil a localidade
        numberFormatter.locale = Locale.init(identifier: "pt_BR")
        numberFormatter.numberStyle = .currency
        var result = numberFormatter.string(from: self as NSNumber) ?? String(format: "%.2f", self)
        if !result.contains("R$") && result.contains("$") {
            result = result.replacingOccurrences(of: "$", with: "R$")
        }
        return result
    }
    
    var asIntCurrency: Int {
        if let number = parse(from: formatedAsCurrency) {
            return number
        }
        return Int(self*100)
    }
    
    private func parse(from string: String) -> Int? {
        return Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
    
    func truncate(places : Int)-> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
    
}
