//
//  String.swift
//  Ideas2itStarter
//
//  Created by Pandiyaraj on 11/09/17.
//  Copyright © 2017 Pandiyaraj. All rights reserved.
//

import Foundation
public extension String {
    /// Return string decoded from base64.
    public var base64Decoded: String? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        guard let decodedData = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: decodedData, encoding: .utf8)
    }
    
    /// Return string encoded in base64.
    public var base64Encoded: String? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        let plainData = self.data(using: .utf8)
        return plainData?.base64EncodedString()
    }
    
    /// Returns CamelCase of string.
    public var camelCased: String {
        let source = lowercased()
        if source.characters.contains(" ") {
            let first = source.substring(to: source.index(after: source.startIndex))
            let camel = source.capitalized.replace(" ", with: "").replace("\n", with: "")
            let rest = String(camel.characters.dropFirst())
            return "\(first)\(rest)"
        } else {
            let first = source.lowercased().substring(to: source.index(after: source.startIndex))
            let rest = String(source.characters.dropFirst())
            return "\(first)\(rest)"
            
        }
    }
    
    /// Converts string format to CamelCase.
    public mutating func camelize() {
        self = camelCased
    }
    
    /// Return true if string contains one or more instance of substring.
    public func contain(_ string: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return range(of: string, options: .caseInsensitive) != nil
        }
        return range(of: string) != nil
    }
    
    public func notcontain(_ string: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return !(range(of: string, options: .caseInsensitive) != nil)
        }
        return range(of: string) != nil
    }
    
    /// Return true if string contains one or more emojis.
    public var containEmoji: Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x3030, 0x00AE, 0x00A9, // Special Characters
            0x1D000...0x1F77F, // Emoticons
            0x2100...0x27BF, // Misc symbols and Dingbats
            0xFE00...0xFE0F, // Variation Selectors
            0x1F900...0x1F9FF: // Supplemental Symbols and Pictographs
                return true
            default:
                continue
            }
        }
        return false
    }
    
    /// Return count of substring in string.
    public func count(of string: String, caseSensitive: Bool = true) -> Int {
        if !caseSensitive {
            return lowercased().components(separatedBy: string).count - 1
        }
        return components(separatedBy: string).count - 1
    }
    
    
    /// Return true if string ends with substring.
    public func end(with suffix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasSuffix(suffix.lowercased())
        }
        return hasSuffix(suffix)
    }
    
    /// Return first character of string.
    public var firstCharacter: String? {
        return Array(characters).map({String($0)}).first
    }
    
    /// Return first index of substring in string.
    public func firstIndex(of string: String) -> Int? {
        return Array(self.characters).map({String($0)}).index(of: string)
    }
    
    /// Return true if string contains one or more letters.
    public var hasLetters: Bool {
        return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    
    /// Return true if string contains one or more numbers.
    public var hasNumbers: Bool {
        return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
    }
    
    /// Return true if string contains only letters.
    public var isAlphabetic: Bool {
        return  hasLetters && !hasNumbers
    }
    
    /// Return true if string contains at least one letter and one number.
    public var isAlphaNumeric: Bool {
        return components(separatedBy: CharacterSet.alphanumerics).joined(separator: "").characters.count == 0 && hasLetters && hasNumbers
    }
    
    /// Return true if string is valid email format.
    public var isEmail: Bool {
        // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    
    /// Return true if string is https URL.
    public var isHttpsUrl: Bool {
        guard start(with: "https://".lowercased()) else {
            return false
        }
        return URL(string: self) != nil
    }
    
    /// Return true if string is http URL.
    public var isHttpUrl: Bool {
        guard start(with: "http://".lowercased()) else {
            return false
        }
        return URL(string: self) != nil
    }
    
    /// Return true if string contains only numbers.
    public var isNumeric: Bool {
        return  !hasLetters && hasNumbers
    }
    
    /// Return last character of string.
    public var lastCharacter: String? {
        return Array(characters).map({String($0)}).last
    }
    
    /// Latinize string.
    public mutating func latinize() {
        self = latinized
    }
    
    /// Return latinized string.
    public var latinized: String {
        return folding(options: .diacriticInsensitive, locale: Locale.current)
    }
    
    /// Returns array of strings separated by new lines.
    public var lines: [String] {
        var result:[String] = []
        enumerateLines { (line, stop) -> () in
            result.append(line)
        }
        return result
    }
    
    /// Return most common character in string.
    public var mostCommonCharacter: String {
        var mostCommon = ""
        let charSet = Set(withoutSpacesAndNewLines.characters.map{String($0)})
        var count = 0
        for string in charSet {
            if self.count(of: string) > count {
                count = self.count(of: string)
                mostCommon = string
            }
        }
        return mostCommon
    }
    
    /// Return random string of given length.
    public static func random(ofLength: Int) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var string = ""
        for _ in 0..<ofLength {
            let randomIndex = arc4random_uniform(UInt32(base.characters.count))
            string += "\(base[base.index(base.startIndex, offsetBy: IndexDistance(randomIndex))])"
        }
        return string
    }
    
    /// Replace part of string with another string.
    public func replace(_ substring: String, with: String) -> String {
        return replacingOccurrences(of: substring, with: with)
    }
    
    /// Reverse string.
    public mutating func reverse() {
        self = String(characters.reversed())
    }
    
    /// Return reversed string.
    public var reversed: String {
        return String(characters.reversed())
    }
    
    /// Return an array of strings separated by given string.
    public func split(by separator: Character) -> [String] {
        return characters.split{$0 == separator}.map(String.init)
    }
    
    /// Return true if string starts with substring.
    public func start(with prefix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasPrefix(prefix.lowercased())
        }
        return hasPrefix(prefix)
    }
    
    
    public func splitWithFormat(format: String = "_-_") -> (String, String){
        let tempArray = self.components(separatedBy: format)
        return (tempArray[0], tempArray[1])
    }
}

/// Return string repeated n times.
public func * (left: String, right: Int) -> String {
    var newString = ""
    for _ in 0 ..< right {
        newString += left
    }
    return newString
}

public extension String {
    /// Return Bool value from string (if applicable.)
    public var toBool: Bool? {
        let selfLowercased = self.trimmed.lowercased()
        if selfLowercased == "true" || selfLowercased == "1" {
            return true
        } else if selfLowercased == "false" || selfLowercased == "0" {
            return false
        } else {
            return nil
        }
    }
    
    // Return date object from "yyyy-MM-dd" formatted string
    public var toDate: Date? {
        let selfLowercased = self.trimmed.lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: selfLowercased)
    }
    
    // Return date object from "yyyy-MM-dd HH:mm:ss" formatted string.
    public var toDateTime: Date? {
        let selfLowercased = self.trimmed.lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: selfLowercased)
    }
    
    /// Return Double value from string (if applicable.)
    public var toDouble: Double? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Double
    }
    
    /// Return Float value from string (if applicable.)
    public var toFloat: Float? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Float
    }
    
    /// Return Float32 value from string (if applicable.)
    public var toFloat32: Float32? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Float32
    }
    
    /// Return Float64 value from string (if applicable.)
    public var toFloat64: Float64? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Float64
    }
    
    /// Return Int value from string (if applicable.)
    public var toInt: Int? {
        return Int(self)
    }
    
    /// Return Int16 value from string (if applicable.)
    public var toInt16: Int16? {
        return Int16(self)
    }
    
    /// Return Int32 value from string (if applicable.)
    public var toInt32: Int32? {
        return Int32(self)
    }
    
    /// Return Int64 value from string (if applicable.)
    public var toInt64: Int64? {
        return Int64(self)
    }
    
    /// Return Int8 value from string (if applicable.)
    public var toInt8: Int8? {
        return Int8(self)
    }
    
    /// Return URL from string (if applicable.)
    public var toURL: URL? {
        return URL(string: self)
    }
    
    /// Return Date value from string of date format (if applicable.)
    public func toDate(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
    /// Removes spaces and new lines in beginning and end of string.
    public mutating func trim() {
        self = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /// Return string with no spaces or new lines in beginning and end.
    public var trimmed: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /// Truncate string (cut it to a given number of characters).
    public mutating func truncate(toLength: Int, trailing: String? = "...") {
        if self.characters.count > toLength {
            self = self.substring(to: self.index(startIndex, offsetBy: toLength)) + (trailing ?? "")
        }
    }
    
    /// Return truncated string (limited to a given number of characters).
    public func truncated(toLength: Int, trailing: String? = "...") -> String {
        guard self.characters.count > toLength else {
            return self
        }
        return self.substring(to: self.index(startIndex, offsetBy: toLength)) + (trailing ?? "")
    }
    
    /// Return an array with unicodes for all characters in a string.
    public var unicodeArray: [Int] {
        return unicodeScalars.map({$0.hashValue})
    }
    
    /// Return readable string from URL string.
    public mutating func urlDecode() {
        self = removingPercentEncoding ?? self
    }
    
    /// Convert URL string into readable string.
    public var urlDecoded: String {
        return removingPercentEncoding ?? self
    }
    
    /// Return URL-escaped string.
    public mutating func urlEncode() {
        self = addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
    
    /// Escape string.
    public var urlEncoded: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
    
    /// Return string without spaces and new lines.
    public var withoutSpacesAndNewLines: String {
        return replace(" ", with: "").replace("\n", with: "")
    }
    
    
    func insert(string:String,ind:Int) -> String {
        return  String(self.characters.prefix(ind)) + string + String(self.characters.suffix(self.characters.count-ind))
    }
    
    // Return date string from date string With different Format
    
    func dateStringFromString(fromFormat:String, toFormat:String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat// "yyyy-MM-dd HH:mm:ss.A"
        let myDate = dateFormatter.date(from: self)!
        
        dateFormatter.dateFormat = toFormat//"MMM dd, YYYY"
        let convertedDateStr = dateFormatter.string(from: myDate)
        return convertedDateStr
    }
    
    public var isPhoneNumber: Bool {
        // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        let numberRegEx = "[0-9]{10}"
        let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        return numberTest.evaluate(with: self)
    }
    
    public var isContainsEmailStr :Bool{
        if (self.range(of: "@") != nil) {
            return true
        }
        return false
    }
    /// Removes spaces and new lines in beginning and end of string.
    public mutating func trim() -> String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
        //        self = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /// Removes spaces and new lines in beginning and end of string and returns length.
    public mutating func trimmedLength() -> Int{
        //        self = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return  self.trimmingCharacters(in: .whitespacesAndNewlines).characters.count
        
    }
    
    public func containsIgnoringCase(_ find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
    public func isEqualToString(findString : String) -> Bool{
        if self.containsIgnoringCase(findString) || self.replace(" ", with: "").lowercased() == findString.replace(" ", with: "").lowercased(){
            return true
        }else{
            return false
        }
    }
    
    // Check for valid password
    
    public func isValidPassword() -> Bool {
        //        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()-_=+{}|?>.<,:;~`’]{8,}$"
        
        //        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
        
        let passwordRegex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
}


public extension Character{
    
    /// Return true if character is a uppercase
    public var isUppercase: Bool {
        
        
        let alphaUpperCharacters = ["A", "B" , "C" , "D" , "E" , "F" , "G" , "H" , "I" , "J" , "K" , "L" , "M" , "N" , "O" , "P" , "Q" , "R" , "S" , "T" , "U" , "V" , "W" , "X" , "Y" , "Z"]
        
        return alphaUpperCharacters.contains(String(self))
    }
    
    /// Return true if character is a uppercase
    public var isLowercase: Bool {
        
        
        let alphaLowerCharacters = ["a", "b" , "c" , "d" , "e" , "f" , "g" , "h" , "i" , "j" , "k" , "l" , "m" , "n" , "o" , "p" , "q" , "r" , "s" , "t" , "u" , "v" , "w" , "x" , "y" , "z"]
        
        return alphaLowerCharacters.contains(String(self))
    }
    
    /// Return true if character is a uppercase
    public var isNumber: Bool {
        
        let numbers = ["0" , "1" ,"2", "3" , "4" , "5" , "6" , "7" , "8" , "9" ]
        
        return numbers.contains(String(self))
    }
    
    
    /// Return true if character is a Special character
    public var isSpecialCharacter: Bool {
        
           let specialcharacters = ["!" ,"#" ,"$" ,"%" , "&" ,"'" ,"(" ,")" , "*" ,"+" ,"," ,"-" ,"." ,"/" ,":" ,";" ,"<" ,"=" ,">" ,"?" ,"@" ,"[" ,"." ,"\\" , "\"" ,"." ,"]" ,"^" ,"2","_" ,"`" ,"." ,"{" ,"|" ,"}" ,"~"]
        
        return specialcharacters.contains(String(self))
    }
    
    
}
