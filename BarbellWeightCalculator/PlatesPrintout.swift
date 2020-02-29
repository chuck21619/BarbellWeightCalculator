//
//  PlatesPrintout.swift
//  BarbellWeightCalculator
//
//  Created by charles johnston on 2/29/20.
//  Copyright © 2020 Zin Studio. All rights reserved.
//

import Foundation
import UIKit

class PlatesPrintout: UILabel {
    
    var numberFormatter: NumberFormatter?
    
    func addPlates(_ plates: [Plate]) {
        
        guard let numberFormatter = self.numberFormatter else {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.maximumFractionDigits = 2
            numberFormatter.minimumFractionDigits = 0
            self.numberFormatter = numberFormatter
            self.addPlates(plates)
            return
        }
        
        var plateString = ""
        
        for plate in plates {
            
            let formattedPlateWeight = numberFormatter.string(from: plate.weight as NSNumber) ?? ""
            plateString.append(formattedPlateWeight)
            plateString.append("  ")
        }
        
        self.text = plateString
    }
}
