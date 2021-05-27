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
   var moveHive: Bool = false

  
    override func didMove(to view: SKView) {
     startGame()
    }
    

    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            print(moveHive)
            let location = touch.location(in: map)
            let column = map.tileColumnIndex(fromPosition: location)
            let row = map.tileRowIndex(fromPosition: location)
            let tile = map.tileDefinition(atColumn: column, row: row)
            if (tile?.userData?.value(forKey: "fog") != nil) && hive.isPlaced == false || (tile?.userData?.value(forKey: "meadow") != nil) && moveHive == true {
                print("Moving Hive")
                let hiveLocation = map.centerOfTile(atColumn: column, row: row)
                placeHive(hiveLocation, column, row)
                moveHive = false
            } else if let _ = tile?.userData?.value(forKey: "hive") {
                moveHive = true
            } else {
              addBee(location, column, row)
              }
            }
         }
    

  
    
   
    

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

        // Initialize _lastUpdateTime if it has not already been
        beeFlight()


    }
}
