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
    lazy var orderedInventoryPlates: [String] = {
        
        var  tmporderedInventoryPlates = self.inventoryDelegate?.getInventory()?.dictionary.keys.sorted() { (firstValue, secondValue) in

            return Float(firstValue) ?? 0 > Float(secondValue) ?? 0
            } ?? []

        return tmporderedInventoryPlates
    }()
    
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
        
        cell.delegate = self.inventoryDelegate
        
        let weight = self.orderedInventoryPlates[indexPath.row]
        let numberOfPlates = Int(inventory.dictionary[weight] ?? "0") ?? 0
        
        cell.stepper.value = Double(numberOfPlates)
        cell.plateWeight.text = weight
        cell.numberOfPlates.text = "\(numberOfPlates)"
        
        return cell
    }
}
