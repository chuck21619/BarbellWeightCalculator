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
    
    var delegate: NumberFormatterDelegate?
    
    func setPlates(_ plates: [Float]) {
        
        guard let numberFormatter = self.delegate?.numberFormatter else {
            return
        }
        
        var plateString = ""
        
        for plate in plates {
            
            let formattedPlateWeight = numberFormatter.string(from: plate as NSNumber) ?? ""
            plateString.append(formattedPlateWeight)
            plateString.append("  ")
        }
        
        self.text = plateString
    }
}
