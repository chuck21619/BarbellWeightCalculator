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
    
    var plates: [Plate]
    var plateDictionary: [String:[Plate]]
    var weightValues: [String]
    
    init() {
        
        guard let image45 = UIImage(named: "45"),
              let image35 = UIImage(named: "35"),
              let image25 = UIImage(named: "25"),
              let image10 = UIImage(named: "10"),
              let image5 = UIImage(named: "5") else {
                
            self.plates = []
            self.plateDictionary = [:]
            self.weightValues = []
            return
        }
        
        self.plateDictionary = [
            "45": [Plate(weight: 45, image: image45), Plate(weight: 45, image: image45)],
            "35": [Plate(weight: 35, image: image35)],
            "25": [Plate(weight: 25, image: image25)],
            "10": [Plate(weight: 10, image: image10), Plate(weight: 10, image: image10)],
            "5": [Plate(weight: 5, image: image5)],
            "2.5": [Plate(weight: 2.5, image: image5)],
            "1.25": [Plate(weight: 1.25, image: image5)],
            "1": [Plate(weight: 1, image: image5)],
            "0.75": [Plate(weight: 0.75, image: image5)],
            "0.5": [Plate(weight: 0.5, image: image5)],
            "0.25": [Plate(weight: 0.25, image: image5)]
        ]
        
        self.weightValues = []
        self.plates = []
        self.populatePlates()
    }
    
    func set(numberOfPlates: Int, for weightValue: String) {
        
        guard let weight = Float(weightValue),
              let image = UIImage(named: weightValue) else {
            return
        }
        
        let plate = Plate(weight: weight, image: image)
        var plateArray: [Plate] = []
        for _ in 0..<numberOfPlates {
            plateArray.append(plate)
        }
        
        self.plateDictionary[weightValue] = plateArray
        self.populatePlates()
    }
    
    func populatePlates() {
        
        let weightValues = Array(self.plateDictionary.keys)
        let sortedWeightValues = weightValues.sorted {(firstValue, secondValue) -> Bool in
           
            return Float(firstValue) ?? 0 > Float(secondValue) ?? 0
        }
        self.weightValues = sortedWeightValues
        
        var plates: [Plate] = []
        for weight in self.weightValues {
            
            let platesForWeight = self.plateDictionary[weight] ?? []
            plates.append(contentsOf: platesForWeight)
        }
        self.plates = plates
    }
}
