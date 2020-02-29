//
//  Calculator.swift
//  BarbellWeightCalculator
//
//  Created by charles johnston on 2/28/20.
//  Copyright © 2020 Zin Studio. All rights reserved.
//

import Foundation
import UIKit

class Calculator {
    
    private let inventory: Inventory
    
    init(inventory: Inventory) {
        
        self.inventory = inventory
    }
    
    func calculate(_ weight: Float) -> [Plate] {
        
        var inventoryCopy = self.inventory.plates
        
        var platesForOneSide: [Plate] = []
        var remainingWeight = weightWithoutBarbell(weight)
        remainingWeight /= 2
        
        while remainingWeight != 0, let nextPlate = inventoryCopy.first {
            
            if nextPlate.weight <= remainingWeight {
                
                platesForOneSide.append(nextPlate)
                remainingWeight -= nextPlate.weight
            }

            inventoryCopy.removeFirst()
        }
        
        return platesForOneSide
    }
    
    
    func weightWithoutBarbell(_ weight: Float) -> Float {
        
        //TODO: get barbell weight from settings
        guard let settings = appDelegate()?.settings else {
            return 0
        }
        let barbellWeight = settings.barbellWeight()
        return weight - barbellWeight
    }
}
