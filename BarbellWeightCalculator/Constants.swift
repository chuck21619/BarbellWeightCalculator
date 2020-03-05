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
    
    enum Inventory {
        
        static let dictionaryDefaultsKey = "inventoryDictionary"
        static let selectedUnitDefaultsKey = "selectedUnit"
        static let barbellWeightDefaultsKey = "barbellWeight"
        
        static let defaultBarbellWeight: Float = 45
        static let defaultUnit = Constants.Inventory.Unit.pounds
        
        enum Unit: String, CaseIterable {
            
            case pounds = "pounds"
            case kilograms = "kilograms"
        }
        
        static var defaultInventory: [String:[String:Int]] = [
            
            Constants.Inventory.Unit.pounds.rawValue:[
                "100": 0,
                "50": 0,
                "45": 6,
                "35": 2,
                "25": 2,
                "20": 0,
                "12.5": 0,
                "10": 4,
                "7.5": 0,
                "5": 2,
                "2.5": 2,
                "1.25": 0,
                "1": 0,
                "0.75": 0,
                "0.5": 0,
                "0.25": 0
            ],
            Constants.Inventory.Unit.kilograms.rawValue:[
                "50": 0,
                "25": 6,
                "20": 2,
                "15": 2,
                "10": 2,
                "5": 2,
                "2.5": 2,
                "1.25": 2,
                "1": 0,
                "0.75": 0,
                "0.5": 0,
                "0.25": 0
            ]
        ]
    }
    
    enum PlatesPrintout {
        
        static let separator = ",  "
    }
    
    enum BarbellImage {
        
        static let ratioToCenterOfBarbellSleeve: CGFloat = 0.88
        static let ratioToEdgeOfBarbellSleeve: CGFloat = 0.79
        static let barbellSleeveToPlateImageRatio: CGFloat = 0.2
        static let biggestPlateImageSize = UIImage(named: "45")?.size
        static let plateOverlapRatio: CGFloat = 1
    }
}
