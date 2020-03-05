//
//  Inventory.swift
//  BarbellWeightCalculator
//
//  Created by charles johnston on 2/28/20.
//  Copyright © 2020 Zin Studio. All rights reserved.
//

import Foundation
import UIKit

class Inventory: UnitAbbreviationDelegate {
    
    var delegate: InventoryDelegate?
    
    var dictionary: [String:[String:Int]] = [:]
    
    var plateArrays: [Constants.Inventory.Unit:[Float]] = [:]
    
    var barbellWeight: Float {
    
        didSet {
        
            UserDefaults.standard.set(barbellWeight, forKey: Constants.Inventory.barbellWeightDefaultsKey)
        }
    }
    
    init(with dictionary: [String:[String:Int]]?) {
        
        self.barbellWeight = UserDefaults.standard.value(forKey: Constants.Inventory.barbellWeightDefaultsKey) as? Float ?? Constants.Inventory.defaultBarbellWeight
        
        self.dictionary = dictionary ?? Constants.Inventory.defaultInventory
        
        for unit in Constants.Inventory.Unit.allCases {
            
            self.buildArray(for: unit)
        }
    }
    
    func set(numberOfPlates: Int, for weightValue: String, in unit: Constants.Inventory.Unit) {
        
        self.dictionary[unit.rawValue]?[weightValue] = numberOfPlates
        self.buildArray(for: unit)
        self.delegate?.didChangeInventory(for: unit)
    }
    
    func orderedPlateValues(for unit: Constants.Inventory.Unit) -> [String] {
        
        guard let unitDictionary = self.dictionary[unit.rawValue] else {
            
            return []
        }
        
        let  orderedPlateValues = unitDictionary.keys.sorted() { (firstValue, secondValue) in
            
            return Float(firstValue) ?? 0 > Float(secondValue) ?? 0
        }
        
        return orderedPlateValues
    }
    
    func buildArray(for unit: Constants.Inventory.Unit) {
        
        guard let unitInventory = self.dictionary[unit.rawValue] else {
            
            return
        }
        
        var plates: [Float] = []
        
        for (weight, numberOfPlates) in unitInventory {
            
            for _ in 0..<numberOfPlates/2 {
                
                guard let weightFloat = Float(weight) else {
                    continue
                }
                plates.append(weightFloat)
            }
        }
        
        let sortedPlates = plates.sorted { (firstValue, secondValue) in
            
            return firstValue > secondValue
        }
        
        self.plateArrays[unit] = sortedPlates
    }
    
    func weightAbbreviation(for unit: Constants.Inventory.Unit) -> String {
        
        switch unit {
            
        case .kilograms:
            return "kg"
            
        case .pounds:
            return "lb"
        }
    }
}
