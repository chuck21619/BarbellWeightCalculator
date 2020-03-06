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
        static let defaultUnit = Unit.pounds
        
        enum Unit: String, CaseIterable {
            
            case pounds = "pounds"
            case kilograms = "kilograms"
        }
        
        enum DictionaryKey: String {
        
            case size = "size"
            case numberOfPlates = "numberOfPlates"
        }
        
        typealias dictionaryType = [String: [Float: PlateData]]
        
        static let defaultDictionary: dictionaryType = [
        
            Unit.pounds.rawValue:[
                
                100: PlateData(size: CGSize(width: 2, height: 17.5), numberOfPlates: 0),
                50: PlateData(size: CGSize(width: 1.6, height: 17.5), numberOfPlates: 0),
                45: PlateData(size: CGSize(width: 1.3, height: 17.5), numberOfPlates: 10),
                35: PlateData(size: CGSize(width: 1.3, height: 14), numberOfPlates: 2),
                25: PlateData(size: CGSize(width: 1.4, height: 10.9), numberOfPlates: 2),
                20: PlateData(size: CGSize(width: 1.3, height: 10.9), numberOfPlates: 0),
                12.5: PlateData(size: CGSize(width: 1.2, height: 10.5), numberOfPlates: 0),
                10: PlateData(size: CGSize(width: 0.9, height: 8.9), numberOfPlates: 4),
                7.5: PlateData(size: CGSize(width: 0.8, height: 8.5), numberOfPlates: 0),
                5: PlateData(size: CGSize(width: 0.6, height: 7.75), numberOfPlates: 2),
                2.5: PlateData(size: CGSize(width: 0.5, height: 6.3), numberOfPlates: 2),
                1.25: PlateData(size: CGSize(width: 0.4, height: 5), numberOfPlates: 0),
                1: PlateData(size: CGSize(width: 0.3, height: 4), numberOfPlates: 0),
                0.75: PlateData(size: CGSize(width: 0.2, height: 4), numberOfPlates: 0),
                0.5: PlateData(size: CGSize(width: 0.2, height: 4), numberOfPlates: 0),
                0.25: PlateData(size: CGSize(width: 0.2, height: 4), numberOfPlates: 0)
            ],
            Unit.kilograms.rawValue:[
                
                50: PlateData(size: CGSize(width: 1, height: 1), numberOfPlates: 0),
//                25: PlateData(size: CGSize(width: 10, height: 100), numberOfPlates: 10),
//                20: PlateData(size: CGSize(width: 10, height: 100), numberOfPlates: 2),
//                15: PlateData(size: CGSize(width: 10, height: 100), numberOfPlates: 2),
//                10: PlateData(size: CGSize(width: 10, height: 100), numberOfPlates: 2),
//                5: PlateData(size: CGSize(width: 10, height: 100), numberOfPlates: 2),
//                2.5: PlateData(size: CGSize(width: 10, height: 100), numberOfPlates: 2),
//                1.25: PlateData(size: CGSize(width: 10, height: 100), numberOfPlates: 2),
//                1: PlateData(size: CGSize(width: 10, height: 100), numberOfPlates: 0),
//                0.75: PlateData(size: CGSize(width: 10, height: 100), numberOfPlates: 0),
//                0.5: PlateData(size: CGSize(width: 10, height: 100), numberOfPlates: 0),
//                0.25: PlateData(size: CGSize(width: 10, height: 100), numberOfPlates: 0)
            ]
        ]
    }
    
    enum PlatesPrintout {
        
        static let separator = ",  "
    }
    
    enum BarbellImage {
        
        static let barbellImageName = "barbell"
        static let barbellPlateImageName = "iron"
        static let ratioToCenterOfBarbellSleeve: CGFloat = 0.88
        static let ratioToEdgeOfBarbellSleeve: CGFloat = 0.79
        static let barbellSleeveToPlateImageRatio: CGFloat = 0.2
        static let plateOverlapRatio: CGFloat = 1
    }
}
