import Foundation
import XCTest

@testable import BankeyApp

class AccountTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testCanParse() throws {
        let json = """
            {
             "id": "1",
             "first_name": "Kevin",
             "last_name": "Flynn"
            }
            """
        
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        let result = try decoder.decode(Profile.self, from: data)
        
        
        XCTAssertEqual(result.id, "1")
        XCTAssertEqual(result.firstName, "Kevin")
        XCTAssertEqual(result.lastName,"Flynn")
    }
}
