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
    positionInGameButton(beeButton, 0)
}

func addMoveHiveButton() {
  moveHiveButton = createButton("moveHiveButton")
  self.addChild(moveHiveButton)
    positionInGameButton(moveHiveButton, -(self.frame.width/4))
}

func addPauseButton() {
  pauseButton = createButton("pauseButton")
  self.addChild(pauseButton)
    positionInGameButton(pauseButton, self.frame.width/4)
}

    func positionInGameButton(_ button: SKSpriteNode, _ xPos: CGFloat) {
        
        button.setScale(map.frame.width / (map.frame.height + map.frame.width + map.frame.midX + map.frame.midY))
        print(map.frame.width, map.frame.height)
        button.position = CGPoint(x: self.frame.midX + xPos, y: self.frame.minY + (self.frame.height/self.frame.midY*16) )
        button.alpha = dimButton
}
    
    func checkButtonTap(_ touch: UITouch ) {
        let position = touch.location(in: self)
        let node: SKNode = self.atPoint(position)
        if node.name == nil {
            return
        }
        getBee(node)
        print(node.name!)
        switch node.name {
        case "addBeeButton":
            if self.isPaused == false {
            pauseGame()
            presentBeeOptions()
            }
        case "moveHiveButton":
            return
//            bee = RedMason()
//            hatchBee(bee)

        case "pauseButton":
             pauseGame()
            createPlayButton()
           createEndGameButton()
        case "playButton":
             resumeGame()
            removePauseButtons()
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
        case "commoncarder":
            purchaseBee(CommonCarder())
        case "redmason":
            purchaseBee(RedMason())
         case "leafcutter":
            purchaseBee(LeafCutter())
        default:
            print("Here")
            return
        }

    }
    
    func purchaseBee(_ bee: Bee) {
        hive.pollen -= beeCost
        resumeGame()
        removeBeeButtons()
        addBee(bee, hive)
    }
    
    func pauseGame() {
        self.isPaused = true
        map.alpha = 0.2
         pauseButton.alpha = 0.2
       
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
    }
    
    func removePauseButtons() {
        map.alpha = 1.0
        playButton.removeFromParent()
        endGameButton.removeFromParent()
    }
    
    func removeBeeButtons() {
        map.alpha = 1.0
        commonCarderButton.removeFromParent()
        redMasonButton.removeFromParent()
        leafCutterButton.removeFromParent()
    }
    
    func getBee(_ node: SKNode) {
        print("Getting bee info for \(node.name!)")
        if  let beeID = UUID(uuidString: node.name!) {
        var bee = hive.bees.first(where: {$0.id == beeID})
        if bee == nil {
            bee = enemyHive.bees.first(where: {$0.id == beeID})!
        }
        }
    }
    
    func setButtonAlpha(_ alpha: CGFloat) {
        self.beeButton.alpha = alpha
        self.moveHiveButton.alpha = alpha
        self.pauseButton.alpha = 1.0
        
    }
    
   func presentBeeOptions() {
       var yPos = map.frame.midY
       commonCarderButton = createButton("commoncarder")
       placeBeeOptionButton(commonCarderButton, yPos)
      addBeeInfoNode(commonCarderButton, "Common Carder: all-rounder with steady speed and solid pollen capacity", yPos)
       yPos = map.frame.midY + map.frame.midY/4
       redMasonButton = createButton("redmason")
       placeBeeOptionButton(redMasonButton, yPos)
       addBeeInfoNode(redMasonButton, "Red Mason: methodical and strong - a pollen-collecting juggernaut", yPos)
       leafCutterButton = createButton("leafcutter")
       yPos = map.frame.midY - map.frame.midY/4
       placeBeeOptionButton(leafCutterButton, yPos)
       addBeeInfoNode(leafCutterButton, "Leaf Cutter: leaves pollen behind to focus on speed and attack", yPos)
    }
    
    func placeBeeOptionButton(_ button: SKSpriteNode, _ yPos: CGFloat) {
        self.addChild(button)
        print(button.size.height)
        button.setScale(0.5)
        print(button.size.height)
        button.position = CGPoint(x: map.frame.midX/2, y: yPos)
    }
    
    func addBeeInfoNode(_ button: SKSpriteNode, _ text: String, _ yPos: CGFloat) {
        let beeLabel = SKLabelNode(fontNamed: "Menlo-Regular")
        button.addChild(beeLabel)
        beeLabel.position = CGPoint(x: button.position.x + button.size.width, y: button.anchorPoint.y + button.size.height/2)
        beeLabel.text = text
        beeLabel.numberOfLines = 3
        beeLabel.preferredMaxLayoutWidth = map.frame.width
        beeLabel.fontColor = UIColor(red: 116, green: 120, blue: 128, alpha: 1)
        beeLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        beeLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        beeLabel.fontSize = 17    }

}
