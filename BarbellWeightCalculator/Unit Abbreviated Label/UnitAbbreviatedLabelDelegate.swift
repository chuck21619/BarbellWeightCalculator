//
//  UnitAbbreviatedLabelDelegate.swift
//  BarbellWeightCalculator
//
//  Created by charles johnston on 3/4/20.
//  Copyright © 2020 Zin Studio. All rights reserved.
//

import Foundation

protocol UnitAbbreviationDelegate {
    
    func weightAbbreviation(for unit: Constants.Inventory.Unit) -> String
}
