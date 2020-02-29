//
//  ViewController.swift
//  BarbellWeightCalculator
//
//  Created by charles johnston on 2/27/20.
//  Copyright © 2020 Zin Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, InventoryCellDelegate, NumberFormatterDelegate {

    @IBOutlet weak var inventoryTableView: UITableView!
    @IBOutlet weak var weightInputField: UITextField!
    @IBOutlet weak var weightedBarbellImageView: WeightedBarbellImageView!
    @IBOutlet weak var platesPrintout: PlatesPrintout!
    
    var numberFormatter: NumberFormatter?
    var calculator: Calculator?
    var deleteKeyPressed = false
    var inventory: Inventory?
    var orderedInventoryPlates: [String] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
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
        self.orderedInventoryPlates = self.inventory?.dictionary.keys.sorted() { (firstValue, secondValue) in
            
            return Float(firstValue) ?? 0 > Float(secondValue) ?? 0
        } ?? []
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
    
    //MARK: - Tableview datasource and delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.orderedInventoryPlates.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "inventoryCell", for: indexPath) as? InventoryCell else {
            return tableView.dequeueReusableCell(withIdentifier: "inventoryCell", for: indexPath)
        }
        
        guard let inventory = self.inventory else {
            return cell
        }
        
        guard indexPath.row < self.orderedInventoryPlates.count else {
            return cell
        }
        
        cell.delegate = self
        
        let weight = self.orderedInventoryPlates[indexPath.row]
        let numberOfPlates = Int(inventory.dictionary[weight] ?? "0") ?? 0
        
        cell.stepper.value = Double(numberOfPlates)
        cell.plateWeight.text = weight
        cell.numberOfPlates.text = "\(numberOfPlates)"
        
        return cell
    }
    
    //MARK: - InventoryCellDelegate
    func didChangeInventory() {
        
        updateWeights()
    }
}

