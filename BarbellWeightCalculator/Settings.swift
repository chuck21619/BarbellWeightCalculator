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
    
    init() {
        
        let inventoryDictionary = self.defaults.value(forKey: Constants.dictionaryDefaultsKey) as? [String:String]
        self.inventory = Inventory(with: inventoryDictionary)
    }
    
    func saveInventoryDictionary(_ dictionary: [String:String]) {
        
        self.defaults.set(dictionary, forKey: Constants.dictionaryDefaultsKey)
    }
}
