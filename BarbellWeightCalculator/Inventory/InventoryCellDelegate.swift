//
//  InventoryCellDelegate.swift
//  BarbellWeightCalculator
//
//  Created by charles johnston on 2/29/20.
//  Copyright © 2020 Zin Studio. All rights reserved.
//

import Foundation

protocol InventoryCellDelegate: UnitAbbreviationDelegate {
    
    func set(numberOfPlates: Int, for weight: Float)
}
