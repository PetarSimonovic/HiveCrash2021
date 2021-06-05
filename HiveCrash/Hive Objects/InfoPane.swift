//
//  Info.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 05/06/2021.
//

import Foundation
import SpriteKit
class InfoPane {
    
    var tileName = SKLabelNode(fontNamed: "Futura-Medium")
    
    func updateTileInfo (_ name: String) {
        self.tileName.text = name
        self.tileName.fontColor = UIColor(red: 116, green: 120, blue: 128, alpha: 1)
        self.tileName.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.tileName.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        self.tileName.fontSize = 15
        self.tileName.zPosition = CGFloat(1.0)
        }

}
