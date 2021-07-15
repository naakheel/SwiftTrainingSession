//
//  D2EnumTestTests.swift
//  D2EnumTestTests
//
//  Created by Nabeel Ahamed on 7/13/21.
//

import XCTest
@testable import D2EnumTest

class D2EnumTestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOne() {
        let dbl = Double("1") ?? 0
        XCTAssertEqual(dbl, 1, "should be 1")
    }
    
    func testTakeIntReturnCode() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let vc = ViewController()
        
        XCTAssertThrowsError(try vc.takeIntReturnCode(input: -1))
        XCTAssertThrowsError(try vc.takeIntReturnCode(input: 6))
        
        let returnValue = try? vc.takeIntReturnCode(input: 1)
        XCTAssertTrue(returnValue != nil, "Is not nil")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
