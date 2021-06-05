//
//  StartGame.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 24/05/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func startGame() {
        tiles.prepareTiles()
        map = tiles.startMap()
        self.addChild(map)
        map.position = CGPoint(x: self.frame.maxX/2, y: self.frame.maxY/2)
        map.setScale(self.frame.width / 3200)
        createInfoPane()
       
 
    }
    
    func createInfoPane() {
        addChild(infoPane.tileName)
        infoPane.tileName.position = CGPoint(x: frame.minX, y: frame.maxY)
    }
    
}
