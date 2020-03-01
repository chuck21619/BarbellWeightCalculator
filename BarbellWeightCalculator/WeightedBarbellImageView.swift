//
//  weightedBarbellImageView.swift
//  BarbellWeightCalculator
//
//  Created by charles johnston on 2/28/20.
//  Copyright © 2020 Zin Studio. All rights reserved.
//

import Foundation
import UIKit

class WeightedBarbellImageView: UIImageView {
    
    var barbellImageView: UIImageView?
    var numberFormatter: NumberFormatter?
    var delegate: NumberFormatterDelegate?
    
    override func didMoveToWindow() {
        
        super.didMoveToWindow()
        self.addBarbell()
    }
    
    func addBarbell() {
        
        let barbellImage = UIImage(named: "barbell")
        self.barbellImageView = UIImageView(image: barbellImage)
        
        guard let barbellImageView = self.barbellImageView else {
            return
        }
        let barbellImageViewHeight = barbellImageView.frame.size.height
        
        let y = (self.frame.height - barbellImageViewHeight)/2
        let barbellCoordinates = CGPoint(x: 0, y: y)
        
        self.barbellImageView?.frame.origin = barbellCoordinates
        self.addSubview(barbellImageView)
    }
    
    func clearPlates() {
        
        for subview in self.subviews {
            
            guard subview !== self.barbellImageView else {
                continue
            }
            
            subview.removeFromSuperview()
        }
    }
    
    func setPlates(_ plates: [Float]) {
        
        self.clearPlates()
        
        guard let numberFormatter = self.delegate?.numberFormatter else {
            return
        }
        
        for plate in plates {
            
            guard let plateImageName = numberFormatter.string(from: plate as NSNumber),
                  let plateImage = UIImage(named: "\(plateImageName)") else {
                
                return
            }
            
            let plateImageView = UIImageView(image: plateImage)
            let plateCoordinates = nextPlateImageCoordinates(plateImageSize: plateImage.size)
            plateImageView.frame.origin = plateCoordinates
            self.addSubview(plateImageView)
        }
    }
    
    func nextPlateImageCoordinates(plateImageSize: CGSize) -> CGPoint {

        
        let rightMostSubview = self.rightMostPlateView()
        var x: CGFloat = 145
        if let rightMostX =  rightMostSubview?.frame.maxX {
            x = rightMostX - ((rightMostSubview?.frame.size.width ?? 0) * 0.35)
        }
        let y = (self.frame.height - plateImageSize.height)/2
        let coordinates = CGPoint(x: x, y: y)
        
        
        return coordinates
    }
    
    func rightMostPlateView() -> UIView? {
        
        var rightMostSubview: UIView? = nil
        
        for subview in self.subviews {
            
            guard subview !== self.barbellImageView else {
                continue
            }
            
            if subview.frame.maxX > (rightMostSubview?.frame.maxX ?? 0) {
                rightMostSubview = subview
            }
        }
        
        return rightMostSubview
    }
}
