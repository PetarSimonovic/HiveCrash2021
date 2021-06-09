//
//  HiveCrashTests.swift
//  HiveCrashTests
//
//  Created by Petar Simonovic on 24/05/2021.
//

import XCTest
import SpriteKit
@testable import HiveCrash

var sut: Bee!

class HiveCrashTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Bee()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
 

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    // ALL TESTS MUST start with testThenTheRestOfTheName

    func testDefaultBeeIsInitialisedCorrectly() {
      sut.createBee()
      XCTAssert(beeNames.contains(sut.name), "Default Bee didn't reveive a name")
      XCTAssert(sut.pollen == 0, "Default Bee didn't initialise with correct pollen")
      XCTAssert(sut.pollen == 0, "Default Bee didn't initialise with correct pollen")
      XCTAssert(sut.pollenCapacity == 10, "Default Bee didn't initialise with correct pollenCapacity")
      XCTAssert(sut.appetite == 5, "Default Bee didn't initialise with correct appetite")
      XCTAssert(sut.health == 5, "Default Bee didn't initialise with correct health")
      XCTAssert(sut.speed == 300, "Default Bee didn't initialise with correct speed")
      XCTAssert(sut.homewardBound == false, "Default Bee starts with homewardBound activated")
      XCTAssert(sut.pollenCollecting == false, "Default Bee starts with pollenCollecting activated")
      XCTAssert(sut.inHive == true, "Default Bee starts outside Hive")
        }


}

