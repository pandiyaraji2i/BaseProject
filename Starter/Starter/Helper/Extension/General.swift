//
//  General.swift
//  Ideas2itStarter
//
//  Created by Pandiyaraj on 11/09/17.
//  Copyright © 2017 Pandiyaraj. All rights reserved.
//

import UIKit

extension Data {
    /// Returns a hex string from the given data
    ///
    /// - Returns: String
    func hexString() -> String {
        return self.reduce("") { string, byte in
            string + String(format: "%02X", byte)
        }
    }
}


extension Optional {
    
    /// Attempts to unwrap the optional, and executes the closure if a value exists
    ///
    /// - Parameter block: The closure to execute if a value is found
    /// - Throws: throws (Apply catch)
    public func unwrap( block: (Wrapped) throws -> ()) rethrows {
        if let value = self {
            try block(value)
        }
    }
}


extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func rupeesFormatt() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}

extension Int {
    func rupeesFormatt() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}

