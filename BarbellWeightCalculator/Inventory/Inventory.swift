//
//  Inventory.swift
//  BarbellWeightCalculator
//
//  Created by charles johnston on 2/28/20.
//  Copyright © 2020 Zin Studio. All rights reserved.
//

import Foundation
import UIKit

class Inventory {
    
    var delegate: InventoryDelegate?
    
    var dictionary: [String:String] = [:] {
        
        didSet {
            
            self.buildArray()
            self.delegate?.didChangeInventory()
        }
    }
    
    var array: [Float] = []
    
    var barbellWeight: Float {
        
        get {
            
            return 45
        }
    }
    
    init(with dictionary: [String:String]?) {
        
        self.dictionary = dictionary ?? Constants.Inventory.defaultInventory
        self.buildArray()
    }
    
    func set(numberOfPlates: Int, for weightValue: String) {
        
        self.dictionary[weightValue] = "\(numberOfPlates)"
    }
    
    func buildArray() {
        
        var array: [Float] = []
        
        for (weight, numberOfPlates) in self.dictionary {
            
            guard let numberOfPlatesInt = Int(numberOfPlates) else {
                continue
            }
            
            for _ in 0..<numberOfPlatesInt/2 {
                
                guard let weightFloat = Float(weight) else {
                    continue
                }
                array.append(weightFloat)
            }
        }
        
        self.array = array.sorted { (firstValue, secondValue) in
            
            return firstValue > secondValue
        }
    }
}
