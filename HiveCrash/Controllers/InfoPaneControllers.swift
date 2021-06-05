//
//  infoPaneController.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 05/06/2021.
//

import Foundation
import SpriteKit

extension GameScene {

    func createInfoPane() {
        addChild(infoPane.tileName)
        infoPane.tileName.position = CGPoint(x: frame.minX, y: frame.maxY)
    }
    
    func updateInfoPane(_ tile: SKTileDefinition, _ column: Int, _ row: Int) {
        switch tile.name {
        case "fog":
            infoPane.updateTileInfo("Fog")
        case "meadow":
            infoPane.updateTileInfo("Meadow")
        case "flowerMeadow":
            infoPane.updateTileInfo("Flower Meadow")
        case "rock":
            infoPane.updateTileInfo("Rock")
        case "lake":
            infoPane.updateTileInfo("Lake")
        case "hive":
            infoPane.updateTileInfo("Hive")
        default:
            return
        }
    }
    
}

