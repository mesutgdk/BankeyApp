//
//  CurrencyFormatterTests.swift
//  BankeyUnitTests
//
//  Created by Mesut Gedik on 3.06.2023.
//

import Foundation

import XCTest

@testable import BankeyApp

class Test : XCTestCase{
    var formatter: CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
       formatter = CurrencyFormatter()
    }
    
    func testShouldBeVisible() throws {
        let result = formatter.breakIntoDollarsAndCents(929466.23)
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
        
    }
    
    func testDollarsFormatted() throws {
        let locale = Locale.current // u ant find right dolar symbol, so it is the best way
        let currentSymbol = locale.currencySymbol!
        
        let result = formatter.dollarsFormatted(5099207.99)
        XCTAssertEqual(result, "\(currentSymbol)5,099,207.99")
        
    }
    
    func testZeroDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(0)
        XCTAssertEqual(result, "$0.00")

    }
}
