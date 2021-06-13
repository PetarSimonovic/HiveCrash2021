//
//  EnemyHive.swift
//  HiveCrashTests
//
//  Created by Petar Simonovic on 13/06/2021.
//

import XCTest
import SpriteKit
@testable import HiveCrash

class EnemyHiveTests: XCTestCase {
    
    var sut: EnemyHive!
    
    let testColumn: Int = 5
    let testRow: Int = 5

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

//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    func testEnemyHiveHasLocationOnMap() {
        100.times  {
          sut.choosePosition(testColumn, testRow)
          XCTAssert(sut.column <= 11, "EnemyHive column is not in map")
          XCTAssert(sut.row <= 10, "EnemyHive column is not in map")
        }

    }
    
    func testEnemyHiveIsNotOnPlayerHiveTile() {
        100.times  {
          let playerHive = Hive()
          playerHive.column = testColumn
          playerHive.row = testRow
          sut.choosePosition(playerHive.column, playerHive.row)
          XCTAssert(sut.column != playerHive.column && sut.row != playerHive.row, "EnemyHive is in player's Hive position")
        }

    }


}
