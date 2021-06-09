//
//  Default Bee.swift
//  HiveCrashTests
//
//  Created by Petar Simonovic on 09/06/2021.
//

import XCTest
import SpriteKit
@testable import HiveCrash


class BeeTests: XCTestCase {
    
    var sut: Bee!
    // Bee initialisation variables
    let defaultBeeSpeed: Int = 300
    let defaultPollenCapacity: Int = 10
    let defaultPollen: Int = 0
    let defaultAppetite: Int = 5
    let defaultHealth: Int = 5


    // Bee testflight variables
    let testDestinationColumn: Int = 10
    let testDestinationRow: Int = 10
    let testHiveLocation: CGPoint = CGPoint(x: 100, y: 100)
    let testTileLocation: CGPoint = CGPoint(x: 50, y: 50)
    let flightTime: TimeInterval = 20

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

//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    func testDefaultBeeIsInitialisedCorrectly() {
      sut.createBee()
      XCTAssert(beeNames.contains(sut.name), "Default Bee didn't reveive a name")
      XCTAssert(sut.pollen == defaultPollen, "Default Bee didn't initialise with correct pollen")
      XCTAssert(sut.pollenCapacity == defaultPollenCapacity, "Default Bee didn't initialise with correct pollenCapacity")
      XCTAssert(sut.appetite == defaultAppetite, "Default Bee didn't initialise with correct appetite")
      XCTAssert(sut.health == defaultHealth, "Default Bee didn't initialise with correct health")
      XCTAssert(sut.speed == defaultBeeSpeed, "Default Bee didn't initialise with correct speed")
      XCTAssert(sut.homewardBound == false, "Default Bee starts with homewardBound activated")
      XCTAssert(sut.pollenCollecting == false, "Default Bee starts with pollenCollecting activated")
      XCTAssert(sut.inHive == true, "Default Bee starts outside Hive")
        }
    
    func testBeeSetsDestintionCorrectly () {
        sut.createBee()
        sut.setDestination(testTileLocation, testDestinationColumn, testDestinationRow)
        XCTAssert(sut.destination == testTileLocation, "Bee didn't receive correct destinatio CGPoint")
        XCTAssert(sut.destinationColumn == testDestinationColumn, "Bee didn't receive correct destination Column")
        XCTAssert(sut.destinationRow == testDestinationRow, "Bee didn't receive correct destination Row")


        
   //     NOT BEING USED!?
//        XCTAssert(sut.destinationRow == testDestinationRow, "Bee didn't receive correct destination row")
//        XCTAssert(sut.destinationColumn == testDestinationColumn, "Bee didn't receive correct destination column")




    }


}

