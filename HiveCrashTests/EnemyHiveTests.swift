//
//  EnemyHiveTests.swift
//  HiveCrashTests
//
//  Created by Petar Simonovic on 13/06/2021.
//

import Foundation
import SpriteKit


class EnemyHiveTests: XCTestCase {
    
    var sut: EnemyHive!


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = EnemyHive()

    }

    override func tearDownWithError() throws {
       
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        sut = nil
        try super.tearDownWithError()

    }
    
 

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
