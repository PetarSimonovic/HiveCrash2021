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
    var enemyHives: [EnemyHive] = []
        
   var flowers: [Flower] = []
   var meadows: [Meadow] = []
   var gameInfo: [String] = []
        
   var infoPane = InfoPane()
   var tutorial = Tutorial()
   var moveHive: Bool = false
   var gameTimer: Timer?
   var introTimer: Timer?
   var appetite: Int =  5
   var beeCost: Int = 25
   var tileCounter: Int = 130
   var scouting: Bool = false
   var level: Int = 0
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
   var beeShopDisplayed: Bool = false

    
    
   var eternalHive: [SavedBee] = []
    var intro: Bool = true
    var enemies: Bool = true



  
    override func didMove(to view: SKView) {
     loadEternalHive()
     startGame()
     
    }
    

    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !gamePlaying { return }

       
        
        for touch in touches {
            if intro {
                removeBees()
                gameOver()
                return
                
            }
            let location = touch.location(in: map)
            let column = map.tileColumnIndex(fromPosition: location)
            let row = map.tileRowIndex(fromPosition: location)
            print("Column \(column); Row \(row);")
            let tile = map.tileDefinition(atColumn: column, row: row)
            let node: SKNode = self.atPoint(location)
            getBeeInfo(column, row)
            if let name = node.name {
              print(name)
              getBee(node)
            }
            
            // scouting clause will prevent taps on bee sprites now
            if scouting == true || migration == true || tile?.name == nil || self.isPaused {
                checkButtonTap(touch)
                return
            }
           // updateInfoPane(tile!, column, row)
            if tile?.name == "fog" && hive.isPlaced == false  {
                let hiveLocation = map.centerOfTile(atColumn: column, row: row)
                placeHive(hiveLocation, column, row)
                } else if tile!.name == "hive" {
                hive.pollen > hive.moveCost && allowHiveMove() ? moveHive = true : refuseHiveMove()
            }
            else {
                let bee = hive.bees.first(where: {$0.inHive == true} )
                if moveHive == true && tile!.name == "meadow" || moveHive == true && tile!.name == "flowerMeadow" {
                    bee?.scout = true
                    infoPane.updateGameStatus("\(String(describing: bee?.name)) is scouting for a new hive")
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
    
    func getBeeInfo(_ column: Int, _ row: Int) {
        if let bee = hive.bees.first(where: {$0.currentColumn == column && $0.currentRow == row}) {
            if bee.displayInfo {
                print("not displaying info")
                bee.displayInfo = false
                bee.infoPane.text = bee.name
            } else {
                print("Now displaying info", bee.infoPane.position)
                bee.displayInfo = true
                bee.infoPane.text = ""
            }
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
            if tutorial.on { updateTutorialInfo() }
            updateGameInfo()
            checkStaleMate()
            controlEnemyHives()
            updateBeeInfoPanes()
        } else {
            return
        }
        
        func updateGameInfo() {
            infoPane.updateHiveInfo(hive, moveHive)
            infoPane.updateFlightInfo(hive.bees)
        }

    }
}
