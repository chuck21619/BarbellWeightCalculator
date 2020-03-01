//
//  ViewController.swift
//  BarbellWeightCalculator
//
//  Created by charles johnston on 2/27/20.
//  Copyright © 2020 Zin Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, NumberFormatterDelegate, InventoryTableViewDelegate, CalculatorDelegate, InventoryDelegate {

    @IBOutlet weak var inventoryTableView: InventoryTableView!
    @IBOutlet weak var weightInputField: UITextField!
    @IBOutlet weak var weightedBarbellImageView: WeightedBarbellImageView!
    @IBOutlet weak var platesPrintout: PlatesPrintout!
    @IBOutlet weak var offsetLabel: UILabel!
    
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var percentageSlider: UISlider!
    @IBOutlet weak var adjustedLabel: UILabel!
    
    var numberFormatter: NumberFormatter?
    var calculator: Calculator?
    var deleteKeyPressed = false
    var settings: Settings? = nil
    var previousSliderValue: Int = 100
    
    @IBAction func percentageChanged(_ sender: Any) {

        let sliderValue = self.percentageSlider.value
        let roundedValue = 5 * Int((sliderValue / 5.0).rounded())
        self.percentageSlider.setValue(Float(roundedValue), animated: false)
        
        guard roundedValue != self.previousSliderValue else {
            return
        }
        
        self.percentageLabel.text = "\(roundedValue)%"
        self.previousSliderValue = roundedValue
        self.percentageSlider.value = Float(roundedValue)
        
        updateWeights()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.inventoryTableView.delegate = self.inventoryTableView
        self.inventoryTableView.dataSource = self.inventoryTableView
        self.inventoryTableView.inventoryDelegate = self
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 0
        self.numberFormatter = numberFormatter
        
        self.platesPrintout.delegate = self
        self.weightedBarbellImageView.delegate = self
        
        self.weightInputField.becomeFirstResponder()
        weightInputField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        let inventory = appDelegate()?.settings.inventory ?? Inventory(with: nil)
        inventory.delegate = self
        self.calculator = Calculator(inventory: inventory)
        self.calculator?.delegate = self
        self.settings = appDelegate()?.settings
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.inventoryTableView.flashScrollIndicators()
    }
    
    func updateWeights() {
        
        guard let weight = Float(self.weightInputField.text ?? "0") else {
            return
        }
        
        let sliderValue = self.percentageSlider.value
        let roundedSliderValue = 5 * Int((sliderValue / 5.0).rounded())
        guard let plates = self.calculator?.calculate(weight, atPercent: Float(roundedSliderValue)) else {
            return
        }

        self.weightedBarbellImageView.setPlates(plates)
        self.platesPrintout.setPlates(plates)
    }
    
    //MARK: - CalculatorDelegate
    func weightLoaded(total: Float, offset: Float) {
        
        guard let offsetString = self.numberFormatter?.string(from: offset as NSNumber) else {
            self.offsetLabel.text = ""
            return
        }
        
        if offset != 0 {
            
            self.offsetLabel.text = "\(offsetString)"
        }
        else {
            
            self.offsetLabel.text = ""
        }
        
        if self.percentageSlider.value != 100 {
            
            let formattedTotal = self.numberFormatter?.string(from: total as NSNumber) ?? "\(total)"
            self.adjustedLabel.text = formattedTotal
        }
        else {
            
            self.adjustedLabel.text = ""
        }
    }
    
    //MARK: - TextField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.count  == 0 && range.length > 0 {
            
            self.deleteKeyPressed = true
        }
        else {

            self.deleteKeyPressed = false
        }
        
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {

        if deleteKeyPressed {

            self.percentageSlider.value = 100
            self.percentageLabel.text = "100%"
            self.weightedBarbellImageView.setPlates([])
            self.weightInputField.text = ""
            self.platesPrintout.setPlates([])
            self.offsetLabel.text = ""
            self.adjustedLabel.text = ""
        }
        else {
            
            updateWeights()
        }
    }
    
    //MARK: - InventoryDelegate
    func didChangeInventory() {
        
        updateWeights()
        
        guard let inventoryDictionary = self.settings?.inventory?.dictionary else {
            return
        }
        
        appDelegate()?.settings.saveInventoryDictionary(inventoryDictionary)
    }
    
    //MARK: - InventoryTableViewDelegate
    func getInventory() -> Inventory? {
        
        return self.settings?.inventory
    }
    
    //MARK: - InventoryCellDelegate
    func set(numberOfPlates: Int, for weightValue: String) {
    
        self.settings?.inventory?.set(numberOfPlates: numberOfPlates, for: weightValue)
    }
}
