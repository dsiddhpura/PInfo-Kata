//
//  KataTests.swift
//  KataTests
//
//  Created by Dharmesh Siddhpura on 1/12/17.
//  Copyright © 2017 Dharmesh Siddhpura. All rights reserved.
//

import XCTest
@testable import Kata

class KataTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample1()
    {
        let result = find(array: [ [3,4,1,2,8,6],
                          [6,1,8,2,7,4],
                          [5,9,3,9,9,5],
                          [8,4,1,3,2,6],
                          [3,7,2,1,2,3] ], entryPoint: Point(x: 0, y: Default_Column))
        
        XCTAssertTrue(result.0, "## Test Failed")
    }
    
    func testExample2()
    {
        let result = find(array: [ [19,10,19,10,19],
                                   [21,23,20,19,12],
                                   [20,12,20,11,10] ], entryPoint: Point(x: 0, y: Default_Column))
        
        
        XCTAssertTrue(result.0, "## Test Failed")
    }
    
    func testExample3()
    {
        let result = find(array: [ [3,4,1,2,8,6],
                                   [6,1,8,2,7,4],
                                   [5,9,3,9,9,5],
                                   [8,4,1,3,2,6],
                                   [3,7,2,8,6,4] ], entryPoint: Point(x: 0, y: Default_Column))
        
        
        XCTAssertTrue(result.0, "## Test Failed")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
