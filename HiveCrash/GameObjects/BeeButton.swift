//
//  BeeButton.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 07/06/2021.
//

import Foundation
import SpriteKit

extension GameScene {
        
func createButton(_ image: String) -> SKSpriteNode {
        let button = SKSpriteNode(imageNamed: "\(image)")
        button.name = "\(image)"
        button.zPosition = 1
        return button

   }
    
func addButtons() {
    addBeeButton()
    addMoveHiveButton()
    addPauseButton()
}

func addBeeButton() {
  beeButton = createButton("addBeeButton")
  self.addChild(beeButton)
    positionButton(beeButton, 0)
}

func addMoveHiveButton() {
  moveHiveButton = createButton("moveHiveButton")
  self.addChild(moveHiveButton)
    positionButton(moveHiveButton, -(self.frame.width/4))
}

func addPauseButton() {
  pauseButton = createButton("pauseButton")
  self.addChild(pauseButton)
    positionButton(pauseButton, self.frame.width/4)
}

    func positionButton(_ button: SKSpriteNode, _ xPos: CGFloat) {
        
        button.setScale(map.frame.width / (map.frame.height + map.frame.width + map.frame.midX + map.frame.midY))
        print(map.frame.width, map.frame.height)
        button.position = CGPoint(x: self.frame.midX + xPos, y: self.frame.minY + (self.frame.height/self.frame.midY*16) )
        button.alpha = dimButton
}
    
    func checkButtonTap(_ touch: UITouch ) {
        let position = touch.location(in: self)
        let node:SKNode = self.atPoint(position)
        if node.name == nil {
            return
        }
        var bee = Bee()
        print(node.name)
        switch node.name {
        case "addBeeButton":
            bee = CommonCarder()
            hatchBee(bee)
        case "moveHiveButton":
            return
//            bee = RedMason()
//            hatchBee(bee)

        case "pauseButton":
             pauseGame()
        case "playButton":
             resumeGame()
        case "endGameButton":
            if endGameConfirm == true {
                removePauseButtons()
                self.isPaused = false
                self.removeAllActions()
                self.removeAllChildren()
                gameOver()
            } else {
                endGameConfirm = true
            }
        default:
           return
        }

    }
    
    func pauseGame() {
        self.isPaused = true
        map.alpha = 0.5
         pauseButton.alpha = 0.5
         createPlayButton()
        createEndGameButton()
    }
    
    func createPlayButton() {
        playButton = createButton("playButton")
        self.addChild(playButton)
        playButton.position = CGPoint(x: map.frame.midX/2, y: map.frame.midY)
        playButton.zPosition = 5
    }
    
    func createEndGameButton() {
        endGameButton = createButton("endGameButton")
        self.addChild(endGameButton)
        endGameButton.position = CGPoint(x: (map.frame.midX/4 * 2) + map.frame.midX, y: map.frame.midY)
        endGameButton.zPosition = 5
    }
    
    func resumeGame() {
        endGameConfirm = false
        self.isPaused = false
        removePauseButtons()
    }
    
    func removePauseButtons() {
        map.alpha = 1.0
        playButton.removeFromParent()
        endGameButton.removeFromParent()
    }
    
//    func getBee(_ node: SKNode) {
//        print("Getting bee info for \(node.name!)")
//        let beeID = UUID(uuidString: node.name!)
//        var bee = hive.bees.first(where: {$0.id == beeID})
//        if bee == nil {
//            bee = enemyHive.bees.first(where: {$0.id == beeID})!
//        }
//        infoPane.updateBeeInfo(bee!)
//    }
    
    func setButtonAlpha(_ alpha: CGFloat) {
        self.beeButton.alpha = alpha
        self.moveHiveButton.alpha = alpha
        self.pauseButton.alpha = 1.0
        
    }

}
