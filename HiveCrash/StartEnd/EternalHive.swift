//
//  eternalHive.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 24/07/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func loadEternalHive() {
        
          
        if let data = UserDefaults.standard.data(forKey: "eternalHive") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                print("Loaded!")
                eternalHive = try decoder.decode([SavedBee].self, from: data)

            } catch {
                print("Unable to load Bees (\(error))")
            }
        }
    }

    func saveEternalHive() {
        
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(eternalHive)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "eternalHive")
            print("Bees Saved!")

        } catch {
            print("Unable to Encode Array of Bees (\(error))")
        }
     }
    
    
    func saveBee(_ bee: Bee) {
        let savedBee = SavedBee(bee.name, bee.type)
        eternalHive.append(savedBee)
        saveEternalHive()
        
    }
    
    func updateSavedBee(_ id: UUID, _ property: String, _ value: Int) {
        var savedBee = eternalHive.first(where: {$0.id == id})
        if savedBee != nil {
        switch property {
            case "pollen":
             savedBee!.pollen += value
            case "battles":
             savedBee!.battlesFought += 1
             savedBee!.battlesWon += value
            case "flower":
              savedBee!.flowersVisited += 1
            case "flights":
              savedBee!.flights += 1
          default:
            savedBee!.levelsCompleted += 1
        }
            saveEternalHive()
        }
    }
    
    func updateSavedBeeLevels() {
        for bee in hive.bees {
            updateSavedBee(bee.id, "level", 1)
        }
    }
}
