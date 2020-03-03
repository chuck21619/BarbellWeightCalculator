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
    var biggestPlateHeight: CGFloat?
    var maxPlateHeight: CGFloat = 200
    
    override func didMoveToWindow() {
        
        super.didMoveToWindow()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.biggestPlateHeight = UIImage(named: "45")?.size.height
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
        
        let barbellImageViewHeight = barbellImageView.frame.size.height

        let y = (self.frame.height - barbellImageViewHeight)/2
        let barbellCoordinates = CGPoint(x: 0, y: y)
        
        barbellImageView.frame.origin = barbellCoordinates
        self.addSubview(barbellImageView)
        
        //center vertically
        barbellImageView.translatesAutoresizingMaskIntoConstraints = false
        let centerYConstraint = NSLayoutConstraint(item: barbellImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(centerYConstraint)
        
        //height
        let desiredHeightConstraint = NSLayoutConstraint(item: barbellImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.2, constant: 0)
        desiredHeightConstraint.priority = .defaultHigh
        self.addConstraint(desiredHeightConstraint)
        
        //aspect ratio
        let aspectRatio = barbellImage.size.width / barbellImage.size.height
        let aspectRatioConstraint = NSLayoutConstraint(item: barbellImageView, attribute: .width, relatedBy: .equal, toItem: barbellImageView, attribute: .height, multiplier: aspectRatio, constant: 0)
        barbellImageView.addConstraint(aspectRatioConstraint)
        
        //x axis
        let leadingContrainst = NSLayoutConstraint(item: barbellImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: self.frame.size.width/4.82)
        self.addConstraint(leadingContrainst)
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
                  let plateImage = UIImage(named: plateImageName) else {
                
                return
            }
            
            let plateImageView = UIImageView(image: plateImage)
            self.addSubview(plateImageView)
            
            plateImageView.translatesAutoresizingMaskIntoConstraints = false
            
            self.layoutIfNeeded()
            
            //width
            let aspectRatio = plateImage.size.width / plateImage.size.height
            let aspectRatioConstraint = NSLayoutConstraint(item: plateImageView, attribute: .width, relatedBy: .equal, toItem: plateImageView, attribute: .height, multiplier: aspectRatio, constant: 0)
            plateImageView.addConstraint(aspectRatioConstraint)
            
            //vertical
            let centerYConstraint = NSLayoutConstraint(item: plateImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
            self.addConstraint(centerYConstraint)
            
            //horizontal
            let xConstraint = nextXPlateConstraint(plateImageView: plateImageView)
            self.addConstraint(xConstraint)
            
            //height
            let heightRatio = plateImage.size.height / (self.biggestPlateHeight ?? maxPlateHeight)
            let desiredHeightIfLargestPlate = NSLayoutConstraint(item: plateImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: heightRatio, constant: 0)
            desiredHeightIfLargestPlate.priority = .defaultHigh
            self.addConstraint(desiredHeightIfLargestPlate)
        }
    }
    
    func nextXPlateConstraint(plateImageView: UIImageView) -> NSLayoutConstraint {

        if let rightMostPlateView = self.rightMostPlateView(), plateImageView != rightMostPlateView {
            
            let xConstraint = NSLayoutConstraint(item: plateImageView, attribute: .leading, relatedBy: .equal, toItem: rightMostPlateView, attribute: .trailing, multiplier: 1, constant: 0)
            return xConstraint
        }
        else {

            let xConstraint = NSLayoutConstraint(item: plateImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: self.frame.size.width/3)
            return xConstraint
        }
        
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
