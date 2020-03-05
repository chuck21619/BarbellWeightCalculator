//
//  UnitAbbreviatedLabel.swift
//  BarbellWeightCalculator
//
//  Created by charles johnston on 3/4/20.
//  Copyright © 2020 Zin Studio. All rights reserved.
//

import Foundation
import UIKit

class UnitAbbreviatedLabel: UILabel {

    var unitAbbreviationDelegate: UnitAbbreviationDelegate? = nil
    
    func setWeightAbbreviation(for unit:Constants.Inventory.Unit) {
    
        self.text = self.unitAbbreviationDelegate?.weightAbbreviation(for: unit) ?? ""
    }
}
