//
//  Decimal+Utilities.swift
//  BankeyApp
//
//  Created by Mesut Gedik on 1.06.2023.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
