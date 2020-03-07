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
    
    let size: CGSize
    let imageName: Constants.BarbellImage.PlateImageName
    var numberOfPlates: Int
    
    init(size: CGSize, imageName: Constants.BarbellImage.PlateImageName, numberOfPlates: Int) {
        
        self.size = size
        self.imageName = imageName
        self.numberOfPlates = numberOfPlates
    }
    
    //MARK: - Archiving to User Defaults
    enum CodingKeys: String {
    
        case size = "size"
        case imageName = "imageName"
        case numberOfPlates = "numberOfPlates"
    }
    func encode(with coder: NSCoder) {
        
        coder.encode(size, forKey: CodingKeys.size.rawValue)
        coder.encode(imageName.rawValue, forKey: CodingKeys.imageName.rawValue)
        coder.encode(numberOfPlates, forKey: CodingKeys.numberOfPlates.rawValue)
    }
    
    required init?(coder: NSCoder) {
        
        self.size = coder.decodeCGSize(forKey: CodingKeys.size.rawValue)
        self.imageName = Constants.BarbellImage.PlateImageName(rawValue: coder.decodeObject(forKey: CodingKeys.imageName.rawValue) as? String ?? "") ?? .ironBlack
        self.numberOfPlates = coder.decodeInteger(forKey: CodingKeys.numberOfPlates.rawValue)
    }
}
