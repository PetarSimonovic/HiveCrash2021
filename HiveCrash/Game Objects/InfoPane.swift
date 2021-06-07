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
    var beeName = SKLabelNode(fontNamed: "Menlo-Regular")
    var beePollen = SKLabelNode(fontNamed: "Menlo-Regular")
    var beePopulation = SKLabelNode(fontNamed: "Menlo-Regular")
    var gameStatus = SKLabelNode(fontNamed: "Menlo-Regular")
    var beeStatus = SKLabelNode(fontNamed: "Menlo-Regular")
    
    func updateTileName (_ name: String) {
        self.tileName.text = name
        formatText(self.tileName)
        }
     
    func updateFlowerInfo(_ column: Int, _ row: Int, _ flower: Flower) {
        if flower.inBloom {
            self.pollenStatus.text = "Pollen count: \(flower.pollen)"
        } else {
          self.pollenStatus.text = "Dormant"
        }
        formatText(self.pollenStatus)
    }
    
    func updateHiveInfo(_ hive: Hive, _ bees: Int) {
        self.hivePollen.text = "Hive pollen count: \(hive.pollen) | \(hive.pollenCount)%"
        self.beePopulation.text = "Bee population: \(bees)"
        formatText(self.hivePollen)
        formatText(self.beePopulation)
    }
    
    func updateMeadowInfo(_ meadow: Meadow) {
        self.pollenStatus.text = "Pollination: \(meadow.pollen)%"
        formatText(self.pollenStatus)
    }
    
    func updateBeeInfo(_ bee: Bee) {
        self.beeName.text = "\(bee.name)"
        self.beePollen.text = "\(bee.pollen) | \(bee.health)"
        formatText(self.beeName)
        formatText(self.beePollen)

    }
    
    func updateGameStatus(_ gameText: String) {
        self.gameStatus.text = gameText
        formatText(self.beeStatus)
    }
    
    func updateBeeStatus(_ beeText: String) {
        self.beeStatus.text = beeText
        formatText(self.gameStatus)
    }
    
    func gameOver() {
        self.beeStatus.text = "HiveCrash"
        self.gameStatus.text = "Game Over"
    }
    
    private func formatText(_ text: SKLabelNode) {
        text.fontColor = UIColor(red: 116, green: 120, blue: 128, alpha: 1)
        text.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        text.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        text.fontSize = 12
        text.zPosition = CGFloat(1.0)
    }


}
