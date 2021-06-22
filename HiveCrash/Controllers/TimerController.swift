//
//  TimerController.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 14/06/2021.
//
// NO LONGER BEING USED - PREFER SKACTION

import Foundation

extension GameScene {

func createTimer() -> Timer {
   return Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(updateGameEvents), userInfo: nil, repeats: true)
}
    
    @objc func updateGameEvents() {
       feedBees()
   }
    
   
    
}

