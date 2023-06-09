//
//  AccountTests.swift
//  BankeyUnitTests
//
//  Created by Mesut Gedik on 9.06.2023.
//

import Foundation
import XCTest

@testable import BankeyApp

class AccountTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testCanParse() throws {
        let json = """
         [
           {
             "id": "1",
             "type": "Banking",
             "name": "Basic Savings",
             "amount": 929466.23,
             "createdDateTime" : "2010-06-21T15:29:32Z"
           },
           {
             "id": "2",
             "type": "Banking",
             "name": "No-Fee All-In Chequing",
             "amount": 17562.44,
             "createdDateTime" : "2011-06-21T15:29:32Z"
           },
          ]
        """

        // Game on here 🕹
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let result = try decoder.decode([Account].self, from: data)
        
        let account1 = result[0]
        let account2 = result[1]
        
        XCTAssertEqual(result.count, 2)
        
        XCTAssertEqual(account1.id, "1")
        XCTAssertEqual(account1.name, "Basic Savings")
        XCTAssertEqual(account1.type, .Banking)
        XCTAssertEqual(account1.amount, 929466.23)
        XCTAssertEqual(account1.createdDateTime.monthDayYearString, "Pazartesi, Haz 21, 2010")
        print(account2.createdDateTime.monthDayYearString)

        XCTAssertEqual(account2.id, "2")
        XCTAssertEqual(account2.type, .Banking)
        XCTAssertEqual(account2.name, "No-Fee All-In Chequing")
        XCTAssertEqual(account2.amount, 17562.44)
        XCTAssertEqual(account2.createdDateTime.monthDayYearString, "Salı, Haz 21, 2011")


        

    }
}
