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
    var plateImageViews: [(imageView: UIImageView, plateSize: CGSize)] = []
    var delegate: WeightedBarbellViewDelegate?
    lazy var biggestPlateImageSize: CGSize = {
        
        return self.delegate?.biggestPlateImageSize() ?? .zero
    }()
    
    override func didMoveToWindow() {
        
        super.didMoveToWindow()
        self.addBarbell()
    }
    
    func addBarbell() {
        
        guard let barbellImage = UIImage(named: Constants.BarbellImage.barbellImageName) else {
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
            
            plateImageView.imageView.removeFromSuperview()
        }
        
        self.plateImageViews = []
    }
    
    func setPlates(sizesAndImageNames: [(size: CGSize, imageName: Constants.BarbellImage.PlateImageName)]) {
        
        self.clearPlates()
        
        for (size, imageName) in sizesAndImageNames {
            
            guard let plateImage = UIImage(named: imageName.rawValue) else {
            
                continue
            }
            let plateImageView = UIImageView(image: plateImage)
            self.addSubview(plateImageView)
            self.plateImageViews.append((imageView: plateImageView, plateSize: size))
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
            
            let ratioToBiggestPlate = plateImageView.plateSize.height / biggestPlateImageSize.height
            let height = self.frame.size.height * ratioToBiggestPlate
            let width = (plateImageView.plateSize.width/plateImageView.plateSize.height) * height
            let yCoordinate = (self.frame.size.height/2) - (height/2)
            var xCoordinate: CGFloat = 0
            
            if plateImageView.imageView == self.plateImageViews.first?.imageView {
                
                xCoordinate = barbellImageView.frame.origin.x + (barbellImageView.frame.size.width * Constants.BarbellImage.ratioToEdgeOfBarbellSleeve)
                
            }
            else {
                
                guard let currentIndex = self.plateImageViews.firstIndex(where: { (iteratedPlateImageView) -> Bool in
                    
                    plateImageView.imageView == iteratedPlateImageView.imageView
                }) else {
                    continue
                }
                
                let previousPlateImageView = self.plateImageViews[currentIndex - 1]
                xCoordinate = previousPlateImageView.imageView.frame.origin.x + (previousPlateImageView.imageView.frame.size.width * Constants.BarbellImage.plateOverlapRatio)
            }

            plateImageView.imageView.frame = CGRect(x: xCoordinate, y: yCoordinate, width: width, height: height)
        }
    }
}
