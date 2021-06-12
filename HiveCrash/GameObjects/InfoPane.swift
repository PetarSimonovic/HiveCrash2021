//
//  Info.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 05/06/2021.
//

import Foundation
import SpriteKit
class InfoPane {
    
    var tileName = SKLabelNode(fontNamed: "Menlo-Regular")
    var pollenStatus = SKLabelNode(fontNamed: "Menlo-Regular")
    var hivePollen = SKLabelNode(fontNamed: "Menlo-Regular")
    var beeName = SKLabelNode(fontNamed: "Menlo-Bold")
    var beeType = SKLabelNode(fontNamed: "Menlo-Regular")
    var beeRange = SKLabelNode(fontNamed: "Menlo-Regular")
    var beeHealth = SKLabelNode(fontNamed: "Menlo-Regular")
    var beePollen = SKLabelNode(fontNamed: "Menlo-Regular")
    var beePopulation = SKLabelNode(fontNamed: "Menlo-Regular")
    var gameStatus_1 = SKLabelNode(fontNamed: "Menlo-Regular")
    var gameStatus_2 = SKLabelNode(fontNamed: "Menlo-Regular")
    var gameStatus_3 = SKLabelNode(fontNamed: "Menlo-Regular")
    var beeStatus = SKLabelNode(fontNamed: "Menlo-Regular")
    var gameInfo: [String] = ["Pollinate meadows", "Feed the hive", "Explore the world"]
    
    init() {
        formatText(self.tileName)
        formatText(self.pollenStatus)
        formatText(self.hivePollen)
        formatText(self.beeName)
        formatText(self.beeType)
        formatText(self.beeRange)
        formatText(self.beeHealth)
        formatText(self.beePollen)
        formatText(self.beePopulation)
        formatText(self.gameStatus_1)
        formatText(self.gameStatus_2)
        formatText(self.gameStatus_3)
        formatText(self.beeStatus)
    }
    
    func updateTileName (_ name: String) {
        self.tileName.text = name
        }
     
    func updateFlowerInfo(_ column: Int, _ row: Int, _ flower: Flower) {
        if flower.inBloom {
            self.pollenStatus.text = "Pollen count: \(flower.pollen)"
        } else {
          self.pollenStatus.text = "Dormant"
        }
    }
    
    func updateHiveInfo(_ hive: Hive, _ bees: Int) {
        self.hivePollen.text = "Hive pollen count: \(hive.pollen)"
        self.beePopulation.text = "Bee population: \(bees)"
    }
    
    func updateMeadowInfo(_ meadow: Meadow) {
        self.pollenStatus.text = "Pollination: \(meadow.pollen)%"
    }
    
    func updateBeeInfo(_ bees: [Bee]) {
        if bees.count != 0 {
          let bee = bees[0]
          self.beeName.text = "\(bee.name)"
          self.beeType.text = "\(bee.type)"
          self.beeHealth.text = "Health: \(bee.health)"
          self.beePollen.text = "Pollen capacity: \(bee.pollenCapacity)"
          self.beeRange.text = "Range: \(bee.maxRange)"
        }

    }
 
    
    func updateGameStatus(_ text: String) {
      self.gameInfo.insert(text, at: 0)
      updateDisplay()
    }
    
    func updateDisplay() {
        self.gameStatus_1.text = self.gameInfo[0]
        self.gameStatus_2.text = self.gameInfo[1]
        self.gameStatus_3.text = self.gameInfo[2]
    }
    
    func gameOver() {
        self.gameStatus_1.text = "HiveCrash"
        self.gameStatus_2.text = "All bees have died"
        self.gameStatus_3.text = "Game over"
    }
    
    func levelComplete() {
        self.gameStatus_1.text = "Level Complete"
        self.gameStatus_2.text = "All Meadows found"
        self.gameStatus_3.text = "Bees have survived"
        self.pollenStatus.text = ""
        self.hivePollen.text = ""
        self.beeName.text = ""
        self.beePollen.text = ""
        self.beePopulation.text = ""
    }
    
    func reset() {
        self.tileName.text = ""
        self.pollenStatus.text = ""
        self.hivePollen.text = ""
        self.beeName.text = ""
        self.beePollen.text = ""
        self.beePopulation.text = ""
        self.gameStatus_1.text = ""
        self.gameStatus_2.text = ""
        self.gameStatus_3.text = ""
        self.beeStatus.text = ""
 
        
    }
    
    private func formatText(_ text: SKLabelNode) {
        text.fontColor = UIColor(red: 116, green: 120, blue: 128, alpha: 1)
        text.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        text.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        text.fontSize = 10
        text.zPosition = CGFloat(1.0)
    }


}
