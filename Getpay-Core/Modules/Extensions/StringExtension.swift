//
//  StringExtension.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 14/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import UIKit
import CoreImage

public extension String {
    
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
    
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
    
    var isValidCPF: Bool {
        let cpf = self.numbers
        guard cpf.count == 11 else { return false }
        
        if cpf == "11111111111" {
            return false
        } else if cpf == "22222222222" {
            return false
        } else if cpf == "33333333333" {
            return false
        } else if cpf == "44444444444" {
            return false
        } else if cpf == "55555555555" {
            return false
        } else if cpf == "66666666666" {
            return false
        } else if cpf == "77777777777" {
            return false
        } else if cpf == "88888888888" {
            return false
        } else if cpf == "99999999999" {
            return false
        } else if cpf == "00000000000" {
            return false
        }
        
        
        let i1 = cpf.index(cpf.startIndex, offsetBy: 9)
        let i2 = cpf.index(cpf.startIndex, offsetBy: 10)
        let i3 = cpf.index(cpf.startIndex, offsetBy: 11)
        let d1 = Int(cpf[i1..<i2])
        let d2 = Int(cpf[i2..<i3])
        
        var temp1 = 0, temp2 = 0
        
        for i in 0...8 {
            let start = cpf.index(cpf.startIndex, offsetBy: i)
            let end = cpf.index(cpf.startIndex, offsetBy: i+1)
            let char = Int(cpf[start..<end])
            
            temp1 += char! * (10 - i)
            temp2 += char! * (11 - i)
        }
        
        temp1 %= 11
        temp1 = temp1 < 2 ? 0 : 11-temp1
        
        temp2 += temp1 * 2
        temp2 %= 11
        temp2 = temp2 < 2 ? 0 : 11-temp2
        
        return temp1 == d1 && temp2 == d2
    }
    
    var numbers: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    var formatedPhone: String {
        let cleanPhoneNumber = components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        let mask = "(XX) XXXXX-XXXX"
        
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    var isValidPhoneNumber: Bool {
        let regex = "^[1-9]{2}[9-9][0-9]{3,4}[0-9]{4}$"
        let mobileTest = NSPredicate(format: "SELF MATCHES %@", regex)
        return mobileTest.evaluate(with: self)
    }
    
    var onlyCharacters: String {
        return self.components(separatedBy: CharacterSet.decimalDigits).joined()
    }
}

public extension String {
    
    var withoutSpaces: String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    func isValidEmail() -> Bool {
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
    
    /// Receives a string and returns the first letter of the first and last word
    var generateAbbreviationName: String {
        var str = ""
        
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmed.isEmpty || trimmed == " " {
            return str
        }
        
        let array = trimmed.components(separatedBy: " ")
        
        guard let first = array.first else { return ""}
        guard let char1 = first.character(at: 0) else { return "" }
        str.append(char1.uppercased())
        
        if array.count > 1 {
            guard let last = array.last else { return str}
            guard let char2 = last.character(at: 0) else { return "" }
            str.append(char2.uppercased())
        }
        
        return str
    }
    
}

public extension String {
    var hexaBytes: [UInt8] {
        var position = startIndex
        return (0..<count/2).compactMap { _ in    // for Swift 4.1 or later use compactMap instead of flatMap
            defer { position = index(position, offsetBy: 2) }
            return UInt8(self[position...index(after: position)], radix: 16)
        }
    }
    var hexaData: Data { return hexaBytes.data }
}

public extension Collection where Element == UInt8 {
    var data: Data {
        return Data(self)
    }
    var hexa: String {
        return map{ String(format: "%02X", $0) }.joined()
    }
}

public extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}

public extension String {
    /**
     * Completa uma string � esquerda ou � direita com um determinado
     * caractere at� um tamanho especificado. Caso a string indicada tenha
     * comprimento maior do que o tamanho especificado, a string retornada
     * ser� igual � passada como par�metro.
     *
     * param str a string a ser completada com espa�os.
     * @param tamanho o tamanho da string com o complemento.
     * @param complemento o caractere a ser usado para completar a string.
     * @param esquerda <code>true</code> indica que o complemento ser� feito �
     *        esquerda. <code>false</code> indica que o complemento ser� feito �
     *        direita.
     *
     * @return a string com complemento.
     */
    static func completaString(texto: String, tamanho: Int, complemento: String, esquerda: Bool) -> String {
        var temp: String = texto
        while (temp.count < tamanho) {
            if (esquerda) {
                temp = complemento + temp
            } else {
                temp = temp + complemento
            }
        }
        return temp
    }
    
    var formatTransactionTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "dd/MM/yyy - HH:mm"
            let formatedDate = dateFormatter.string(from: date)
            return formatedDate
        }
        return ""
    }
    
    var formatTransactionDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let formatedDate = dateFormatter.string(from: date)
            return formatedDate
        }
        return ""
    }
    
    var formatTransactionDateWithoutTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let formatedDate = dateFormatter.string(from: date)
            return formatedDate
        }
        return ""
    }
}

public extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst() }
}
