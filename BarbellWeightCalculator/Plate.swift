//
//  Plate.swift
//  BarbellWeightCalculator
//
//  Created by charles johnston on 2/28/20.
//  Copyright © 2020 Zin Studio. All rights reserved.
//

import Foundation
import UIKit

struct Plate {
    
    var weight: Float
    var image: UIImage
    
    init(weight: Float, image: UIImage) {
        self.weight = weight
        self.image = image
    }
}
