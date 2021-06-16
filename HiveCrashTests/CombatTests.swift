//
//  HiveCrashTests.swift
//  HiveCrashTests
//
//  Created by Petar Simonovic on 24/05/2021.
//

import XCTest
import SpriteKit
@testable import HiveCrash






class CombatTests: XCTestCase {
    
    var sut: GameScene!
    
    let beeTestColumn: Int = 10
    let beeTestRow: Int = 10
    let enemyBeeTestColumn: Int = 5
    let enemyBeeTestRow: Int = 5
    let hiveLocation = CGPoint(x: 100, y: 100)
    let testSpeed: TimeInterval = 100

    



    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = GameScene()
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
    
    func testBeesKnowIfTheyAreInConflict() {
        let bee = Bee()
        bee.currentRow = beeTestRow
        bee.currentColumn = beeTestColumn
        let enemyBee = VestalCuckoo()
        sut.enemyHive.bees.removeAll()
        sut.enemyHive.bees.append(enemyBee)
        enemyBee.inHive = false
        sut.checkCombat(bee)
        XCTAssert(bee.inCombat == false, "Bee should not be in combat")
        XCTAssert(enemyBee.inCombat == false, "Enemy Bee should not be in combat")
        bee.currentRow = beeTestRow
        bee.currentColumn = beeTestColumn
        enemyBee.currentRow = bee.currentRow
        enemyBee.currentColumn = bee.currentColumn
        sut.checkCombat(bee)
        XCTAssert(bee.inCombat == true, "Bee should be in combat")
        XCTAssert(enemyBee.inCombat == true, "Enemy Bee should be in combat")
        
        
    }
    
    
    
    
    
    
}


