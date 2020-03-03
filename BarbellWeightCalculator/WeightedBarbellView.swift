//
//  weightedBarbellImageView.swift
//  BarbellWeightCalculator
//
//  Created by charles johnston on 2/28/20.
//  Copyright © 2020 Zin Studio. All rights reserved.
//

import Foundation
import UIKit

class WeightedBarbellView: UIView {
    
    var barbellImageView: UIImageView?
    var numberFormatter: NumberFormatter?
    var delegate: NumberFormatterDelegate?
    var plateImageViews: [UIImageView] = []
    
    override func didMoveToWindow() {
        
        super.didMoveToWindow()
        self.addBarbell()
    }
    
    func addBarbell() {
        
        guard let barbellImage = UIImage(named: "barbell") else {
            return
        }
        
        self.barbellImageView = UIImageView(image: barbellImage)
        
        guard let barbellImageView = self.barbellImageView else {
            return
        }
        
        self.addSubview(barbellImageView)
    }
    
    func clearPlates() {
        
        for plateImageView in self.plateImageViews {
            
            plateImageView.removeFromSuperview()
        }
        
        self.plateImageViews = []
    }
    
    func setPlates(_ plates: [Float]) {
        
        self.clearPlates()
        
        guard let numberFormatter = self.delegate?.numberFormatter else {
            return
        }
        
        for plate in plates {
            
            guard let plateImageName = numberFormatter.string(from: plate as NSNumber),
                  let plateImage = UIImage(named: plateImageName) else {
                
                return
            }
            
            let plateImageView = UIImageView(image: plateImage)
            self.addSubview(plateImageView)
            self.plateImageViews.append(plateImageView)
        }
        
        self.computeFrames()
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
    
    func computeFrames() {
        
        guard let barbellImageView = self.barbellImageView else {
            return
        }
        
        let height = (self.frame.size.height * Constants.BarbellImage.barbellSleeveToPlateImageRatio)
        let width = (barbellImageView.frame.size.width/barbellImageView.frame.size.height) * height
        let distanceToSleeveCenter = width * Constants.BarbellImage.ratioToCenterOfBarbellSleeve
        let xCoordinate: CGFloat = (self.frame.size.width/2) - distanceToSleeveCenter
        let yCoordinate = (self.frame.size.height/2) - (height/2)
        barbellImageView.frame = CGRect(x: xCoordinate, y: yCoordinate, width: width, height: height)
        
        for plateImageView in self.plateImageViews {

            guard let plateImageSize = plateImageView.image?.size.height,
                  let biggestPlateImageSize = Constants.BarbellImage.biggestPlateImageSize?.height else {
                return
            }
            
            let ratioToBiggestPlate = plateImageSize / biggestPlateImageSize
            let height = self.frame.size.height * ratioToBiggestPlate
            let width = (plateImageView.frame.size.width/plateImageView.frame.size.height) * height
            let yCoordinate = (self.frame.size.height/2) - (height/2)
            var xCoordinate: CGFloat = 0
            
            if plateImageView == self.plateImageViews.first {
                
                xCoordinate = barbellImageView.frame.origin.x + (barbellImageView.frame.size.width * Constants.BarbellImage.ratioToEdgeOfBarbellSleeve)
                
            }
            else {
                
                guard let currentIndex = self.plateImageViews.firstIndex(of: plateImageView) else {
                    return
                }
                
                let previousPlateImageView = self.plateImageViews[currentIndex - 1]
                xCoordinate = previousPlateImageView.frame.origin.x + (previousPlateImageView.frame.size.width * Constants.BarbellImage.plateOverlapRatio)
            }

            plateImageView.frame = CGRect(x: xCoordinate, y: yCoordinate, width: width, height: height)
        }
    }
}
