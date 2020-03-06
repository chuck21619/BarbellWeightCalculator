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
        
        var inventoryDictionary: Constants.Inventory.dictionaryType
        
        if let inventoryDictionaryData = self.defaults.data(forKey: Constants.Inventory.dictionaryDefaultsKey),
           let savedInventoryDictionary = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(inventoryDictionaryData) as? Constants.Inventory.dictionaryType {
        
            inventoryDictionary = savedInventoryDictionary
        }
        else {
        
            inventoryDictionary = Constants.Inventory.defaultDictionary
        }
        
        let savedSelectedUnitString = self.defaults.value(forKey: Constants.Inventory.selectedUnitDefaultsKey) as? String ?? ""
        let savedSelectedUnit = Constants.Inventory.Unit(rawValue: savedSelectedUnitString)
        
        self.selectedUnit = savedSelectedUnit ?? Constants.Inventory.defaultUnit
        self.inventory = Inventory(with: inventoryDictionary)
    }
    
    func saveInventoryDictionary(_ dictionary: Constants.Inventory.dictionaryType? = nil) {
        
        guard let dictionaryToSave = dictionary ?? self.inventory?.dictionary else {
        
            return
        }
        
        guard let encodedDictionary = try? NSKeyedArchiver.archivedData(withRootObject: dictionaryToSave, requiringSecureCoding: false) else {
        
            return
        }
        
        self.defaults.set(encodedDictionary, forKey: Constants.Inventory.dictionaryDefaultsKey)
    }
    
    func setSelectedUnit(_ unit: Constants.Inventory.Unit) {
    
        self.selectedUnit = unit
        self.saveSelectedUnit(unit)
    }
    
    func saveSelectedUnit(_ unit: Constants.Inventory.Unit) {
        
        self.defaults.set(unit.rawValue, forKey: Constants.Inventory.selectedUnitDefaultsKey)
    }
}
