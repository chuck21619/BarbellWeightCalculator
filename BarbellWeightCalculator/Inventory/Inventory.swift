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
    
    lazy var defaultInventory: [String:String] = {
       
        return [
            "45": "2",
            "35":"1",
            "25":"1",
            "10":"2",
            "5":"1",
            "2.5":"1",
            "1.25":"1",
            "1":"1",
            "0.75":"1",
            "0.5":"1",
            "0.25":"1"
        ]
    }()
    
    init(with dictionary: [String:String]?) {
        
        self.dictionary = dictionary ?? defaultInventory
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
            
            for _ in 0..<numberOfPlatesInt {
                
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
