//
//  InventoryDelegate.swift
//  BarbellWeightCalculator
//
//  Created by charles johnston on 2/29/20.
//  Copyright © 2020 Zin Studio. All rights reserved.
//

import Foundation

protocol InventoryDelegate {
    
    func didChangeInventory(for: Constants.Inventory.Unit)
    func selectedUnit() -> Constants.Inventory.Unit?
}
