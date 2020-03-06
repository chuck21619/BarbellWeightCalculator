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
    
    override func didMoveToWindow() {
        
        self.adjustsFontSizeToFitWidth = true
    }
    
    func setWeights(_ plates: [Float]) {
        
        guard let numberFormatter = self.delegate?.numberFormatter else {
            return
        }
        
        var plateString = ""
        
        for plate in plates {
            
            let formattedPlateWeight = numberFormatter.string(from: plate as NSNumber) ?? ""
            plateString.append(formattedPlateWeight)
            plateString.append(Constants.PlatesPrintout.separator)
        }
        plateString = String(plateString.dropLast(Constants.PlatesPrintout.separator.count))
        
        self.text = plateString
    }
}
