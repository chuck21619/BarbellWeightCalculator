//
//  PlateData.swift
//  BarbellWeightCalculator
//
//  Created by charles johnston on 3/5/20.
//  Copyright © 2020 Zin Studio. All rights reserved.
//

import Foundation
import UIKit

class PlateData: NSObject, NSCoding {
    
    
    let weight: Float
    let size: CGSize
    var numberOfPlates: Int
    
    init(weight: Float, size: CGSize, numberOfPlates: Int) {
        
        self.weight = weight
        self.size = size
        self.numberOfPlates = numberOfPlates
    }
    
    //MARK: - Archiving to User Defaults
    enum CodingKeys: String {
    
        case weight = "weight"
        case size = "size"
        case numberOfPlates = "numberOfPlates"
    }
    func encode(with coder: NSCoder) {
        
        coder.encode(weight, forKey: CodingKeys.weight.rawValue)
        coder.encode(size, forKey: CodingKeys.size.rawValue)
        coder.encode(numberOfPlates, forKey: CodingKeys.numberOfPlates.rawValue)
    }
    
    required init?(coder: NSCoder) {
        
        self.weight = coder.decodeFloat(forKey: CodingKeys.weight.rawValue)
        self.size = coder.decodeCGSize(forKey: CodingKeys.size.rawValue)
        self.numberOfPlates = coder.decodeInteger(forKey: CodingKeys.numberOfPlates.rawValue)
    }
}
