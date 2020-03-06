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
        
        static let defaultPlateSize: CGSize = CGSize(width: 10, height: 100)
        static let defaultBarbellWeight: Float = 45
        static let defaultUnit = Constants.Inventory.Unit.pounds
        
        enum Unit: String, CaseIterable {
            
            case pounds = "pounds"
            case kilograms = "kilograms"
        }
        
        static let defaultInventory: [String:[PlateData]] = [

            Unit.pounds.rawValue:[
                
                    PlateData(weight: 100, size: CGSize(width: 10, height: 100), numberOfPlates: 0),
                    PlateData(weight: 50, size: CGSize(width: 10, height: 100), numberOfPlates: 0),
                    PlateData(weight: 45, size: CGSize(width: 10, height: 100), numberOfPlates: 10),
                    PlateData(weight: 35, size: CGSize(width: 10, height: 100), numberOfPlates: 2),
                    PlateData(weight: 25, size: CGSize(width: 10, height: 100), numberOfPlates: 2),
                    PlateData(weight: 20, size: CGSize(width: 10, height: 100), numberOfPlates: 0),
                    PlateData(weight: 12.5, size: CGSize(width: 10, height: 100), numberOfPlates: 0),
                    PlateData(weight: 10, size: CGSize(width: 10, height: 100), numberOfPlates: 4),
                    PlateData(weight: 7.5, size: CGSize(width: 10, height: 100), numberOfPlates: 0),
                    PlateData(weight: 5, size: CGSize(width: 10, height: 100), numberOfPlates: 2),
                    PlateData(weight: 2.5, size: CGSize(width: 10, height: 100), numberOfPlates: 2),
                    PlateData(weight: 1.25, size: CGSize(width: 10, height: 100), numberOfPlates: 0),
                    PlateData(weight: 1, size: CGSize(width: 10, height: 100), numberOfPlates: 0),
                    PlateData(weight: 0.75, size: CGSize(width: 10, height: 100), numberOfPlates: 0),
                    PlateData(weight: 0.5, size: CGSize(width: 10, height: 100), numberOfPlates: 0),
                    PlateData(weight: 0.25, size: CGSize(width: 10, height: 100), numberOfPlates: 0)
            ],
            Unit.kilograms.rawValue:[

                PlateData(weight: 50, size: CGSize(width: 10, height: 100), numberOfPlates: 0),
                PlateData(weight: 25, size: CGSize(width: 10, height: 100), numberOfPlates: 10),
                PlateData(weight: 20, size: CGSize(width: 10, height: 100), numberOfPlates: 2),
                PlateData(weight: 15, size: CGSize(width: 10, height: 100), numberOfPlates: 2),
                PlateData(weight: 10, size: CGSize(width: 10, height: 100), numberOfPlates: 2),
                PlateData(weight: 5, size: CGSize(width: 10, height: 100), numberOfPlates: 2),
                PlateData(weight: 2.5, size: CGSize(width: 10, height: 100), numberOfPlates: 2),
                PlateData(weight: 1.25, size: CGSize(width: 10, height: 100), numberOfPlates: 2),
                PlateData(weight: 1, size: CGSize(width: 10, height: 100), numberOfPlates: 0),
                PlateData(weight: 0.75, size: CGSize(width: 10, height: 100), numberOfPlates: 0),
                PlateData(weight: 0.5, size: CGSize(width: 10, height: 100), numberOfPlates: 0),
                PlateData(weight: 0.25, size: CGSize(width: 10, height: 100), numberOfPlates: 0)
            ],
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
