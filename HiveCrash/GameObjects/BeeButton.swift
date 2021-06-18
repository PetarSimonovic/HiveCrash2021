//
//  BeeButton.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 07/06/2021.
//

import Foundation
import SpriteKit

extension GameScene {
        
func createBeeButton(_ image: String) -> SKSpriteNode {
        let button = SKSpriteNode(imageNamed: "\(image)")
        button.name = "\(image)Button"
        button.zPosition = 1
        return button

   }
    
func addButtons() {
    addCommonCarderButton()
    addRedMasonButton()
    addLeafCutterButton()
}

func addCommonCarderButton() {
  commonCarderButton = createBeeButton("commoncarder")
  self.addChild(commonCarderButton)
  positionButton(commonCarderButton, 0)
}

func addRedMasonButton() {
  redMasonButton = createBeeButton("redmason")
  self.addChild(redMasonButton)
  positionButton(redMasonButton, 50)
}

func addLeafCutterButton() {
  leafCutterButton = createBeeButton("leafcutter")
  self.addChild(leafCutterButton)
  positionButton(leafCutterButton, -50)
}

    func positionButton(_ button: SKSpriteNode, _ xPos: CGFloat) {
        
        button.setScale(self.frame.width / 1300)
        button.position = CGPoint(x: self.frame.maxX/2 + xPos, y: self.frame.minY + 80 )
        button.alpha = dimButton
}
    
    func checkButtonTap(_ touch: UITouch ) {
        let position = touch.location(in: self)
        let node:SKNode = self.atPoint(position)
        if node.name == nil {
            return
        }
        var bee = Bee()
        switch node.name {
        case "commoncarderButton":
             bee = CommonCarder()
            hatchBee(bee)

        case "redmasonButton":
            bee = RedMason()
            hatchBee(bee)

        case "leafcutterButton":
            bee = LeafCutter()
            hatchBee(bee)

        default:
           return
        }

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
        self.commonCarderButton.alpha = alpha
        self.redMasonButton.alpha = alpha
        self.leafCutterButton.alpha = alpha
        
    }

}
