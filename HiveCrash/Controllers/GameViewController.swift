//
//  GameViewController.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 24/05/2021.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
       

        override func viewDidLoad() {
            super.viewDidLoad()
            // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
            // including entities and graphs.
            let scene = GameScene(size: view.bounds.size)
            let skView = view as! SKView
            skView.preferredFramesPerSecond = 60
            skView.showsFPS = false
            skView.showsPhysics = false // Shows collision mask
            skView.showsNodeCount = false
            skView.ignoresSiblingOrder = false
            scene.scaleMode = .aspectFit
       //     let glow = CIFilter(name: "CIBloom", parameters: ["inputRadius": 1, "inputIntensity": 1])
//             let gloom = CIFilter(name: "CIGloom", parameters: ["inputRadius": 1, "inputIntensity": 5])

         //   let crystalise = CIFilter(name: "CICrystallize", parameters: ["inputRadius": 4])
         //   scene.filter = glow
//            let sunbeams = CIFilter(name: "CIGaussianGradient")//, parameters: ["inputIntensity": 20])

//            scene.filter = glow
            scene.shouldRasterize = true
            scene.shouldEnableEffects = true
            skView.presentScene(scene)
            
      }
}
