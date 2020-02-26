//
//  StringExtension.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 14/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import UIKit
import CoreImage

extension String {
    var formatedAsCPF: String {
        var input = self.removeSeparators()
        while input.count > 11 {
            input.removeLast()
        }
        var result = ""
        for (index, char) in input.enumerated() {
            if index == 3 || index == 6 {
                result.append(".")
            } else if index == 9 {
                result.append("-")
            }
            result.append(char)
        }
        return result
    }

    var formatedAsCNPJ: String {
        var input = self.removeSeparators()
        while input.count > 14 {
            input.removeLast()
        }
        var result = ""
        for (index, char) in input.enumerated() {
            if index == 2 || index == 5 {
                result.append(".")
            } else if index == 8 {
                result.append("/")
            } else if index == 12 {
                result.append("-")
            }
            result.append(char)
        }
        return result
    }

    var formatedAsCpfOrCnpj: String {
        let input = self.removeSeparators()
        if input.count <= 11 {
            return input.formatedAsCPF
        }
        return input.formatedAsCNPJ
    }

    func removeSeparators() -> String {
        var result = self.replacingOccurrences(of: "-", with: "")
        result = result.replacingOccurrences(of: ".", with: "")
        result = result.replacingOccurrences(of: "/", with: "")
        return result
    }

    var generateQRCode: UIImage? {
        let data = self.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            var transform: CGAffineTransform
            if UIScreen.deviceSizeCategory == .compact_models || UIScreen.deviceSizeCategory == .regular_models  {
                transform = CGAffineTransform(scaleX: 35, y: 35)
            } else {
                transform = CGAffineTransform(scaleX: 75, y: 75)
            }

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
}

extension String {
    
    var withoutSpaces: String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    public func isValidEmail() -> Bool {
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
            "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
            "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
}

// Build your own String Extension for grabbing a character at a specific position
public extension String {
    
    func index(at position: Int, from start: Index? = nil) -> Index? {
        let startingIndex = start ?? startIndex
        return index(startingIndex, offsetBy: position, limitedBy: endIndex)
    }
    
    func character(at position: Int) -> Character? {
        guard position >= 0, let indexPosition = index(at: position) else {
            return nil
        }
        return self[indexPosition]
    }

    func substring(_ startAt: Int, _ endAt: Int) -> String {
        guard self.count >= endAt else { return "" }
        let start = self.index(startIndex, offsetBy: startAt)
        let end = self.index(startIndex, offsetBy: endAt)
        return String(self[start..<end])
    }

    func substring(_ startAt: Int) -> String {
        let start = self.index(startIndex, offsetBy: startAt)
        let end = self.index(startIndex, offsetBy: self.count)
        return String(self[start..<end])
    }
    
    var westernArabicNumeralsOnly: String {
        let pattern = UnicodeScalar("0")..."9"
        return String(unicodeScalars
            .compactMap { pattern ~= $0 ? Character($0) : nil })
    }

    var sgDateResponseFormated: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: self) else {
            return self
        }
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: date)
    }

    func firstMatch(regularExpression: String) -> String? {
        let string = self as NSString
        if let regex = try? NSRegularExpression(pattern: regularExpression, options: .caseInsensitive) {
            let range = NSRange(location: 0, length: string.length)
            return regex.matches(in: self, options: [], range: range).map {
                string.substring(with: $0.range)
                }.first
        }
        return nil
    }

}
