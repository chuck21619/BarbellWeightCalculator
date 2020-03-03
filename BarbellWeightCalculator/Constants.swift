//
//  Constants.swift
//  BarbellWeightCalculator
//
//  Created by charles johnston on 2/29/20.
//  Copyright © 2020 Zin Studio. All rights reserved.
//

import Foundation
import UIKit

class Constants {
    
    static let dictionaryDefaultsKey = "inventoryDictionary"
    
    enum BarbellImage {
        
        static let ratioToCenterOfBarbellSleeve: CGFloat = 0.61356
        static let ratioToEdgeOfBarbellSleeve: CGFloat = 0.48
        static let barbellSleeveToPlateImageRatio: CGFloat = 0.2
        static let biggestPlateImageSize = UIImage(named: "45")?.size
        static let plateOverlapRatio: CGFloat = 0.7
    }
}
