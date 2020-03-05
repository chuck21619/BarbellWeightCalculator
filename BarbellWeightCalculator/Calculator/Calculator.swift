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
    
    func calculate(_ weight: Float, atPercent: Float? = nil, unit: Constants.Inventory.Unit) -> [Float] {
        
        guard var plates = inventory.plateArrays[unit] else {
            return []
        }
        
        var platesForOneSide: [Float] = []
        
        let weightTimesPercentage = weight * ((atPercent ?? 100)/100)
        let roundedWeight: Float
        if let percentage = atPercent, percentage != 100 {
            
            roundedWeight = Float(5 * Int((weightTimesPercentage / 5.0).rounded()))
        }
        else {
            
            roundedWeight = (weightTimesPercentage * 100).rounded() / 100
        }
        var remainingWeight = weightWithoutBarbell(roundedWeight, unit: unit)
        remainingWeight /= 2
        
        while remainingWeight != 0, let nextPlate = plates.first {
            
            if nextPlate <= remainingWeight {
                
                platesForOneSide.append(nextPlate)
                remainingWeight -= nextPlate
            }
            
            plates.removeFirst()
        }
        
        self.delegate?.weightLoaded(total: roundedWeight, offset: remainingWeight*2)
        return platesForOneSide
    }
    
    
    func weightWithoutBarbell(_ weight: Float, unit: Constants.Inventory.Unit) -> Float {
        
        let barbellWeight: Float
        if unit == .pounds {
            
            barbellWeight = 45
        }
        else {
            
            barbellWeight = 20
        }
        
        return weight - barbellWeight
    }
}
