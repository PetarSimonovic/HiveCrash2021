//
//  TutorialController.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 03/08/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func updateTutorialInfo() {
        switch tutorial.status {
        case "hive":
            infoPane.updateGameStatus("Tap a tile to place your hive")
        case "flight":
            infoPane.updateGameStatus("Tap on a tile to launch a bee")
        default:
            return
                }
    }

    
}
