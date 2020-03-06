//
//  UnitButton.swift
//  BarbellWeightCalculator
//
//  Created by charles johnston on 3/4/20.
//  Copyright © 2020 Zin Studio. All rights reserved.
//

import Foundation
import UIKit

class UnitButton: UIButton {
    
    func setTitleLabel(to unit:Constants.Inventory.Unit) {
    
        let capitalizedString = unit.rawValue.capitalized
        self.setTitle(capitalizedString, for: .normal)
    }
}
