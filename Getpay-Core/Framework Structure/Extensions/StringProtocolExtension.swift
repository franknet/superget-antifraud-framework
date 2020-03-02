//
//  StringProtocolExtension.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 02/03/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import Foundation

public extension StringProtocol {
    var isValidCPF: Bool {
        let numbers = compactMap({ $0.wholeNumberValue })
        guard numbers.count == 11 && Set(numbers).count != 1 else { return false }
        func digitCalculator(_ slice: ArraySlice<Int>) -> Int {
            var number = slice.count + 2
            let digit = 11 - slice.reduce(into: 0) {
                number -= 1
                $0 += $1 * number
            } % 11
            return digit % 10
        }
        let dv1 = digitCalculator(numbers.prefix(9))
        let dv2 = digitCalculator(numbers.prefix(10))
        return dv1 == numbers[9] && dv2 == numbers[10]
    }
}

public extension StringProtocol {
    var isValidCNPJ: Bool {
        let numbers = compactMap({ $0.wholeNumberValue })
        guard numbers.count == 14 && Set(numbers).count != 1 else { return false }
        func digitCalculator(_ slice: ArraySlice<Int>) -> Int {
            var number = 1
            let digit = 11 - slice.reversed().reduce(into: 0) {
                number += 1
                $0 += $1 * number
                if number == 9 { number = 1 }
            } % 11
            return digit % 10
        }
        let dv1 = digitCalculator(numbers.prefix(12))
        let dv2 = digitCalculator(numbers.prefix(13))
        return dv1 == numbers[12] && dv2 == numbers[13]
    }
}
