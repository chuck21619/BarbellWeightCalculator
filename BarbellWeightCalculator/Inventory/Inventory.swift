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
    
    var dictionary: [String:[PlateData]] = [:]
    
    var plateArrays: [Constants.Inventory.Unit:[Float]] = [:]
    
    var barbellWeight: Float {
    
        didSet {
        
            UserDefaults.standard.set(barbellWeight, forKey: Constants.Inventory.barbellWeightDefaultsKey)
        }
    }
    
    init(with dictionary: [String:[PlateData]]?) {
        
        self.barbellWeight = UserDefaults.standard.value(forKey: Constants.Inventory.barbellWeightDefaultsKey) as? Float ?? Constants.Inventory.defaultBarbellWeight
        
        self.dictionary = dictionary ?? Constants.Inventory.defaultInventory
        
        for unit in Constants.Inventory.Unit.allCases {
            
            self.buildArray(for: unit)
        }
    }
    
    func set(numberOfPlates: Int, for weight: Float, in unit: Constants.Inventory.Unit) {
        
        guard let plateData = self.dictionary[unit.rawValue]?.first(where: { (plateData) -> Bool in
            plateData.weight == weight
        }) else {
            return
        }
        
        plateData.numberOfPlates = numberOfPlates
        
        self.buildArray(for: unit)
        self.delegate?.didChangeInventory(for: unit)
    }
    
    func orderedPlateValues(for unit: Constants.Inventory.Unit) -> [Float] {
        
        guard let plateDatas = self.dictionary[unit.rawValue] else {
        
            return []
        }
        
        let plateValues = plateDatas.map { (plateData) -> Float in
            return plateData.weight
        }
        
        let  orderedPlateValues = plateValues.sorted() { (firstValue, secondValue) in
            
            return firstValue > secondValue
        }
        
        return orderedPlateValues
    }
    
    func buildArray(for unit: Constants.Inventory.Unit) {
        
        guard let plateDatas = self.dictionary[unit.rawValue] else {
            
            return
        }
        
        var plates: [Float] = []
        
        for plateData in plateDatas {
            
            for _ in 0..<plateData.numberOfPlates/2 {
            
                plates.append(plateData.weight)
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
