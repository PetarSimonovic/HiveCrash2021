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
        gameTimer = Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(updateHive), userInfo: nil, repeats: true)
        tiles.prepareTiles()
        map = tiles.startMap()
        self.addChild(map)
        map.position = CGPoint(x: self.frame.maxX/2, y: self.frame.maxY/2)
        map.setScale(self.frame.width / 3200)
        createInfoPane()
        5.times {
            addBee()
        }
        print(bees)
       
 
    }
    
    

}
