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
            infoPane.updateGameStatus("")
            infoPane.updateGameStatus("")
            infoPane.updateGameStatus("Tap a tile to place your hive")
        case "flight":
            infoPane.updateGameStatus("Bees will return to the hive if they hit a rock")
            infoPane.updateGameStatus("Bees can fly over meadows and lakes")
            infoPane.updateGameStatus("Tap on a tile to launch a bee")
        case "flower":
            infoPane.updateGameStatus("Bees must collect pollen from flowers to survive")
            infoPane.updateGameStatus("Flowers bloom on meadows that pulse")
            infoPane.updateGameStatus("Use bees to explore the world")
        case "pollen":
            infoPane.updateGameStatus("Flowers will grow on fully pollinated meadows")
            infoPane.updateGameStatus("Bees shed pollen over lakes and unpollinated meadows")
            infoPane.updateGameStatus("Bees will return to hive after collecting pollen")
        case "consumption":
            infoPane.updateGameStatus("Use pollen to create more bees")
            infoPane.updateGameStatus("Use pollen to move the hive")
            infoPane.updateGameStatus("Bees eat pollen: without food they will lose health")
        case "conditions":
            infoPane.updateGameStatus("Pollinate meadows. Feed the hive. Explore the world.")
            infoPane.updateGameStatus("The hive will crash if all bees die")
            infoPane.updateGameStatus("Explore the whole world to complete the level")
        default:
            return
                }
    }

    
}
