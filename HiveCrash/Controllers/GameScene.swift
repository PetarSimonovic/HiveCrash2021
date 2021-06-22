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
    
   var tileSet = loadTiles()
   var tiles = Tiles()
   var map = SKTileMapNode()
   var hive = Hive()
   var enemyHive = EnemyHive()
        
   var flowers: [Flower] = []
   var meadows: [Meadow] = []
   var gameInfo: [String] = []
   var infoPane = InfoPane()
   var moveHive: Bool = false
   var gameTimer: Timer?
   var appetite: Int =  5
   var beeCost: Int = 25
   var hiveCost: Int = 100
   var tileCounter: Int = 130
   var scouting: Bool = false
   var level: Int = 1
   var gamePlaying: Bool = false
   var migration: Bool = false
    
   var beeButton = SKSpriteNode()
   var moveHiveButton = SKSpriteNode()
   var pauseButton = SKSpriteNode()
   var playButton = SKSpriteNode()
   var endGameButton = SKSpriteNode()
   var commonCarderButton = SKSpriteNode()
   var redMasonButton = SKSpriteNode()
   var leafCutterButton = SKSpriteNode()
   var endGameConfirm = false
   var dimButton: CGFloat = 0.2

  
    override func didMove(to view: SKView) {
     startGame()
    }
    

    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gamePlaying == false {
            return
        }
        for touch in touches {
            let location = touch.location(in: map)
            let column = map.tileColumnIndex(fromPosition: location)
            let row = map.tileRowIndex(fromPosition: location)
            let tile = map.tileDefinition(atColumn: column, row: row)
            print("Tile", column, row)
            
            // scouting clause will prevent taps on bee sprites now
            if scouting == true || migration == true || tile?.name == nil || self.isPaused {
                checkButtonTap(touch)
                return
            }
            updateInfoPane(tile!, column, row)
            if tile?.name == "fog" && hive.isPlaced == false  {
                let hiveLocation = map.centerOfTile(atColumn: column, row: row)
                placeHive(hiveLocation, column, row)
                enemyHive.choosePosition(hive.column, hive.row, map)
                print("EnemyHive placed on: \(enemyHive.column)-\(enemyHive.row)")
            } else if tile!.name == "hive" {
                hive.pollen > hiveCost ? allowHiveMove() : refuseHiveMove()
            }
            else {
                let bee = hive.bees.first(where: {$0.inHive == true} )
                if moveHive == true && tile!.name == "meadow" || moveHive == true && tile!.name == "flowerMeadow" {
                    bee?.scout = true
                    infoPane.updateGameStatus("\(bee!.name) is scouting for a new hive")
                    scouting = true
                }
               switch bee {
               case nil:
                infoPane.updateGameStatus("No bees in hive")
               default:
                hive.pulse()
                self.releaseBee(bee!, column, row)
               }
            }
//            let beePosition = touch.location(in: self)
//            let node:SKNode = self.atPoint(beePosition)
//            if node.name != nil {
//                  let beeID = UUID(uuidString: node.name!)
//                  if let bee = bees.first(where: {$0.id == beeID}) {
//                  infoPane.updateBeeInfo(bee)
//                }
//            }
    }
    }
    
    



    

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

        // Initialize _lastUpdateTime if it has not already been
        if gamePlaying == true {
            if hive.bees.count <= 0 {gameOver()}
            if scouting == true { hive.pulse() }
            if migration == true {checkMigration()}
            checkHivePollen()
            timeFlowers()
            beeFlight()
            infoPane.updateHiveInfo(hive, hive.bees.count)
            infoPane.updateFlightInfo(hive.bees)
            checkStaleMate()
            controlEnemyHive()
        }


    }
}
