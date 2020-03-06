//
//  WeightedBarbellViewDelegate.swift
//  BarbellWeightCalculator
//
//  Created by charles johnston on 3/6/20.
//  Copyright © 2020 Zin Studio. All rights reserved.
//

import Foundation
import UIKit

protocol WeightedBarbellViewDelegate: NumberFormatterDelegate {
    
    func biggestPlateImageSize() -> CGSize
}
