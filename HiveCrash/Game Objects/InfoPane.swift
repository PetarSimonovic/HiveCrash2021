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
    var flowerPollen = SKLabelNode(fontNamed: "Menlo-Regular")
    var hivePollen = SKLabelNode(fontNamed: "Menlo-Regular")
    var beeName = SKLabelNode(fontNamed: "Menlo-Regular")
    var beePollen = SKLabelNode(fontNamed: "Menlo-Regular")
    var beePopulation = SKLabelNode(fontNamed: "Menlo-Regular")

    
    func updateTileName (_ name: String) {
        self.tileName.text = name
        formatText(self.tileName)
        }
     
    func updateFlowerInfo(_ column: Int, _ row: Int, _ flower: Flower) {
        if flower.inBloom {
            self.flowerPollen.text = "Pollen count: \(flower.pollen)"
        } else {
          self.flowerPollen.text = "Dormant"
        }
        formatText(self.flowerPollen)
    }
    
    func updateHiveInfo(_ hive: Hive, _ bees: Int) {
        self.hivePollen.text = "Hive pollen count: \(hive.pollen)"
        self.beePopulation.text = "Bee population: \(bees)"
        formatText(self.hivePollen)
        formatText(self.beePopulation)
    }
    
    func updateBeeInfo(_ bee: Bee) {
        self.beeName.text = "\(bee.name)"
        self.beePollen.text = "\(bee.pollen)"
        formatText(self.beeName)
        formatText(self.beePollen)

    }
    
    private func formatText(_ text: SKLabelNode) {
        text.fontColor = UIColor(red: 116, green: 120, blue: 128, alpha: 1)
        text.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        text.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        text.fontSize = 12
        text.zPosition = CGFloat(1.0)
    }

}
