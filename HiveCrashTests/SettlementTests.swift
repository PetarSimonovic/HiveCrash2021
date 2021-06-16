//
//  SettlementTestws.swift
//  HiveCrashTests
//
//  Created by Petar Simonovic on 16/06/2021.
//

import XCTest
import Foundation
@testable import HiveCrash

class SettlementTests: XCTestCase {
    
    var sut: GameScene!
    var hive = Hive()

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

    
    func testHivePreventsMoveUnlessBeesAreAllInHive() {
        sut.hive.isPlaced = true
        sut.hive.bees.removeAll()
        5.times {
            let bee = CommonCarder()
            bee.inHive = false
            sut.hive.bees.append(bee)
        }
        sut.allowHiveMove()
        XCTAssert(sut.moveHive == false, "Hive allowed move even though bees are in flight")
    }
    
    func testHivePreventsMoveIfBeeAlreadyScoutingLocation() {
        sut.hive.isPlaced = true
        sut.hive.bees.removeAll()
        5.times {
            let bee = CommonCarder()
            bee.inHive = false
            sut.hive.bees.append(bee)
        }
        sut.hive.bees[0].scout = true
        sut.allowHiveMove()
        XCTAssert(sut.moveHive == false, "Hive allowed move even though bee is alrady scouting")
    }
    
    func testHiveAllowsMoveifBeesAreInHiveAndNoScouts() {
        sut.hive.isPlaced = true
        sut.hive.bees.removeAll()
        5.times {
            let bee = CommonCarder()
            bee.inHive = true
            bee.scout = false
            sut.hive.bees.append(bee)
        }
        print(hive.bees)
        sut.allowHiveMove()
        XCTAssert(sut.moveHive == true, "Hive should allow move if bees are in hive and there are no scouts")
    }

    
//    else if tile!.name == "hive" {
//       hive.pollen > hiveCost ? allowHiveMove() : refuseHiveMove()
//   }


    
//    func allowHiveMove() {
//        for bee in hive.bees {
//            if bee.inHive == false {
//                infoPane.updateGameStatus("All bees must be in hive to move")
//                return
//            } else if bee.scout == true {
//                infoPane.updateGameStatus("Already scouting new location")
//            } else {
//                infoPane.updateGameStatus("Select meadow for new hive")
//                moveHive = true
//            }
//        }
//    }
    
}
