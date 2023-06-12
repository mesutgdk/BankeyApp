//
//  AccountSummaryVCTests.swift
//  BankeyUnitTests
//
//  Created by Mesut Gedik on 12.06.2023.
//

import Foundation
import XCTest

@testable import BankeyApp

class AccountSummaryVCTests: XCTestCase {
    var vc: AccountSummaryViewController!
    
    override func setUp() {
        super.setUp()
        vc = AccountSummaryViewController()
//        vc.loadViewIfNeeded()
    }
    
    func testTitleAndMessageForServerError() throws {
        
        let titleAndMessage = vc.titleAndMessageForTesting(for: .serverError)
        XCTAssertEqual("Server Error", titleAndMessage.0)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again!", titleAndMessage.1)
    }
    func testTitleAndMessageForNetworkError() throws {
        
        let titleAndMessage = vc.titleAndMessageForTesting(for: .decodingError)
        XCTAssertEqual("Decoding Error", titleAndMessage.0)
        XCTAssertEqual("We could not process your request. Please try again.", titleAndMessage.1)
    }
    
    
}
