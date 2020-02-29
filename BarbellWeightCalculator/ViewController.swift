//
//  ViewController.swift
//  BarbellWeightCalculator
//
//  Created by charles johnston on 2/27/20.
//  Copyright © 2020 Zin Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, NumberFormatterDelegate, InventoryTableViewDelegate {
    

    @IBOutlet weak var inventoryTableView: InventoryTableView!
    @IBOutlet weak var weightInputField: UITextField!
    @IBOutlet weak var weightedBarbellImageView: WeightedBarbellImageView!
    @IBOutlet weak var platesPrintout: PlatesPrintout!
    
    var numberFormatter: NumberFormatter?
    var calculator: Calculator?
    var deleteKeyPressed = false
    var inventory: Inventory?
    
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
        
        let inventory = appDelegate()?.inventory ?? Inventory()
        self.calculator = Calculator(inventory: inventory)
        
        self.inventory = appDelegate()?.inventory
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.inventoryTableView.flashScrollIndicators()
    }
    
    func updateWeights() {
        
        guard let weight = Float(self.weightInputField.text ?? "0") else {
            return
        }
        
        guard let plates = self.calculator?.calculate(weight) else {
            return
        }

        self.weightedBarbellImageView.setPlates(plates)
        self.platesPrintout.setPlates(plates)
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

            self.weightedBarbellImageView.setPlates([])
            self.weightInputField.text = ""
            self.platesPrintout.setPlates([])
        }
        
        updateWeights()
    }
    
    //MARK: - InventoryTableViewDelegate
    func didChangeInventory() {
        
        updateWeights()
    }
    
    func getInventory() -> Inventory? {
        
        return self.inventory
    }
}
