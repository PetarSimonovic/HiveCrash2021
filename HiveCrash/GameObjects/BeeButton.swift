//
//  BeeButton.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 07/06/2021.
//

import Foundation
import SpriteKit

        
    func createBeeButton() -> SKSpriteNode {
        let button = SKSpriteNode(imageNamed: "bee")
        button.name = "beeButton"
        button.zPosition = 1
        return button

   }
    
