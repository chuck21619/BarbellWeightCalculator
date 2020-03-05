//
//  Settings.swift
//  BarbellWeightCalculator
//
//  Created by charles johnston on 2/29/20.
//  Copyright © 2020 Zin Studio. All rights reserved.
//

import Foundation

class Settings {
    
    let defaults = UserDefaults.standard
    let inventory: Inventory?
    var selectedUnit: Constants.Inventory.Unit
    
    init() {
        
        let inventoryDictionary = self.defaults.value(forKey: Constants.Inventory.dictionaryDefaultsKey) as? [String:[String:Int]]
        let savedSelectedUnitString = self.defaults.value(forKey: Constants.Inventory.selectedUnitDefaultsKey) as? String ?? ""
        let savedSelectedUnit = Constants.Inventory.Unit(rawValue: savedSelectedUnitString)
        
        self.selectedUnit = savedSelectedUnit ?? Constants.Inventory.defaultUnit
        self.inventory = Inventory(with: inventoryDictionary)
    }
    
    func saveInventoryDictionary(_ dictionary: [String:[String:Int]]) {
        
        self.defaults.set(dictionary, forKey: Constants.Inventory.dictionaryDefaultsKey)
    }
    
    func setSelectedUnit(_ unit: Constants.Inventory.Unit) {
    
        self.selectedUnit = unit
        self.saveSelectedUnit(unit)
    }
    
    func saveSelectedUnit(_ unit: Constants.Inventory.Unit) {
        
        self.defaults.set(unit.rawValue, forKey: Constants.Inventory.selectedUnitDefaultsKey)
    }
}
