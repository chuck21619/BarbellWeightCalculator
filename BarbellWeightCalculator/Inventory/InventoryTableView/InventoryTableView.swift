//
//  InventoryTableView.swift
//  BarbellWeightCalculator
//
//  Created by charles johnston on 2/29/20.
//  Copyright © 2020 Zin Studio. All rights reserved.
//

import Foundation
import UIKit

class InventoryTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var inventoryDelegate: InventoryTableViewDelegate?
    
    func loadInventory(for unit: Constants.Inventory.Unit) {
        
        self.orderedInventoryPlates = plateValues()
        self.reloadData()
    }
    
    lazy var orderedInventoryPlates: [Float] = {
        
        return self.plateValues()
    }()
    
    func plateValues() -> [Float] {
    
        guard let inventory = self.inventoryDelegate?.getInventory(),
              let selectedUnit = self.inventoryDelegate?.selectedUnit() else {
                return []
        }
        
        return inventory.orderedPlateValues(for: selectedUnit)
    }
    
    //MARK: - Tableview datasource and delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.orderedInventoryPlates.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "inventoryCell", for: indexPath) as? InventoryCell else {
            return tableView.dequeueReusableCell(withIdentifier: "inventoryCell", for: indexPath)
        }
        
        guard let inventory = self.inventoryDelegate?.getInventory() else {
            return cell
        }
        
        guard indexPath.row < self.orderedInventoryPlates.count else {
            return cell
        }
        
        guard let selectedUnit = self.inventoryDelegate?.selectedUnit() else {
            return cell
        }
        
        guard let unitDictionary = inventory.dictionary[selectedUnit.rawValue] else {
            return cell
        }
        
        let weight = self.orderedInventoryPlates[indexPath.row]
        
        guard let plateData = unitDictionary[weight] else {
            return cell
        }
        
        cell.delegate = self.inventoryDelegate
        
        let numberOfPlates = plateData.numberOfPlates
        
        cell.unitAbbreviatedLabel.unitAbbreviationDelegate = self.inventoryDelegate
        cell.unitAbbreviatedLabel.setWeightAbbreviation(for: selectedUnit)
        cell.stepper.value = Double(numberOfPlates)
        cell.plateWeight.text = self.inventoryDelegate?.numberFormatter?.string(from: weight as NSNumber) ?? ""
        cell.numberOfPlates.text = "\(numberOfPlates)"
        
        return cell
    }
}
