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
    var delegate: CalculatorDelegate?
    
    init(inventory: Inventory) {
        
        self.inventory = inventory
    }
    
    func calculate(_ weight: Float) -> [Float] {
        
        var plates = inventory.array
        
        var platesForOneSide: [Float] = []
        var remainingWeight = weightWithoutBarbell(weight)
        remainingWeight /= 2
        
        while remainingWeight != 0, let nextPlate = plates.first {
            
            if nextPlate <= remainingWeight {
                
                platesForOneSide.append(nextPlate)
                remainingWeight -= nextPlate
            }
            
            plates.removeFirst()
        }
        
        self.delegate?.weightLoaded(offset: remainingWeight*2)
        return platesForOneSide
    }
    
    
    func weightWithoutBarbell(_ weight: Float) -> Float {
        
        let barbellWeight = self.inventory.barbellWeight
        return weight - barbellWeight
    }
}
