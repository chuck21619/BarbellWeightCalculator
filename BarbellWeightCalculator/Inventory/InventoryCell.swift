//
//  InventoryCell.swift
//  BarbellWeightCalculator
//
//  Created by charles johnston on 2/29/20.
//  Copyright © 2020 Zin Studio. All rights reserved.
//

import Foundation
import UIKit

class InventoryCell: UITableViewCell {
    
    var delegate: InventoryCellDelegate?
    
    @IBOutlet weak var unitAbbreviatedLabel: UnitAbbreviatedLabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var plateWeight: UILabel!
    @IBOutlet weak var numberOfPlates: UILabel!
    
    @IBAction func stepperChanged(_ sender: Any) {
        
        guard let weightString = plateWeight.text,
              let weight = Float(weightString) else {
            return
        }
        
        let numberOfPlates = Int(self.stepper.value)
        self.numberOfPlates.text = "\(numberOfPlates)"
        
        self.delegate?.set(numberOfPlates: numberOfPlates, for: weight)
    }
}
