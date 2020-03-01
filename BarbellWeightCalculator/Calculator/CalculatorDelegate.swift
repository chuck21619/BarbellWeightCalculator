//
//  CalculatorDelegate.swift
//  BarbellWeightCalculator
//
//  Created by charles johnston on 2/29/20.
//  Copyright © 2020 Zin Studio. All rights reserved.
//

import Foundation

protocol CalculatorDelegate {
    
    func weightLoaded(total: Float, offset: Float)
}
