//
//  GameScene.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 24/05/2021.
//

import SpriteKit
import GameplayKit
import SwiftUI

class GameScene: SKScene, SKPhysicsContactDelegate {
    
   var tiles = Tiles()
   var map = SKTileMapNode()
   var hive = Hive()
   var bees: [Bee] = []
   var flowers: [Flower] = []
   var meadows: [Meadow] = []
   var infoPane = InfoPane()
   var moveHive: Bool = false
   var gameTimer: Timer?
   var appetite: Int =  5
   var beeCost: Int = 25
   var hiveCost: Int = 100
   var tileCounter: Int = 130
   var button = createBeeButton()
  
    override func didMove(to view: SKView) {
     startGame()
    }
    

    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: map)
            let column = map.tileColumnIndex(fromPosition: location)
            let row = map.tileRowIndex(fromPosition: location)
            let tile = map.tileDefinition(atColumn: column, row: row)
            if tile?.name == nil {
                checkButtonTap(touch)
                return
            }
            updateInfoPane(tile!, column, row)
            if (tile?.name == "fog") && hive.isPlaced == false || (tile?.name == "meadow") && moveHive == true {
                let hiveLocation = map.centerOfTile(atColumn: column, row: row)
                placeHive(hiveLocation, column, row)
                moveHive = false
            } else if tile!.name == "hive" {
                hive.pollen > hiveCost ? allowHiveMove() : refuseHiveMove()
            } else {
               let bee = bees.first(where: {$0.inHive == true} )
               switch bee {
               case nil:
                infoPane.updateGameStatus("All bees are in flight")
               default:
                hive.pulse()
                self.releaseBee(bee!, location, column, row)
               }
            }
            let beePosition = touch.location(in: self)
            let node:SKNode = self.atPoint(beePosition)
            if node.name != nil {
                  let beeID = UUID(uuidString: node.name!)
                  if let bee = bees.first(where: {$0.id == beeID}) {
                  infoPane.updateBeeInfo(bee)
                }
            }
    }
    }
    
    func checkButtonTap(_ touch: UITouch ) {
        let position = touch.location(in: self)
        let node:SKNode = self.atPoint(position)
        if node.name != nil && node.name == "beeButton" {
            buyBee()
            }
    }

    

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

        // Initialize _lastUpdateTime if it has not already been
        if moveHive == true {
            hive.pulse()
            infoPane.updateGameStatus("Move the hive to a new meadow")
        }
        beeFlight()
        infoPane.updateHiveInfo(hive, bees.count)


    }
}
