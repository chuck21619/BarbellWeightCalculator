//
//  ViewController.swift
//  BarbellWeightCalculator
//
//  Created by charles johnston on 2/27/20.
//  Copyright © 2020 Zin Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, InventoryCellDelegate {
    
    func didChangeInventory() {
        
        updateWeights()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let inventory = self.inventory else {
            return 0
        }
        
        return inventory.plateDictionary.count
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
        
        cell.delegate = self
        
        let weight = inventory.weightValues[indexPath.row]
        let plates = inventory.plateDictionary[weight] ?? []
        
        cell.stepper.value = Double(plates.count)
        cell.plateWeight.text = "\(weight)"
        cell.numberOfPlates.text = "\(plates.count)"
        
        return cell
    }
    

    @IBOutlet weak var inventoryTableView: UITableView!
    @IBOutlet weak var weightInputField: UITextField!
    @IBOutlet weak var weightedBarbellImageView: WeightedBarbellImageView!
    @IBOutlet weak var platesPrintout: PlatesPrintout!
    
    var calculator: Calculator?
    var deleteKeyPressed = false
    var inventory: Inventory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
    
    @objc func textFieldDidChange(_ textField: UITextField) {

        if deleteKeyPressed {

            self.weightedBarbellImageView.clearPlates()
            self.weightInputField.text = ""
            self.platesPrintout.addPlates([])
        }
        
        updateWeights()
    }
    
    func updateWeights() {
        
        guard let weight = Float(self.weightInputField.text ?? "0") else {
            return
        }
        
        guard let plates = self.calculator?.calculate(weight) else {
            return
        }

        self.weightedBarbellImageView.clearPlates()
        self.weightedBarbellImageView.addPlates(plates)
        self.platesPrintout.addPlates(plates)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.count  == 0 && range.length > 0 {
            
            self.deleteKeyPressed = true
        }
        else {

            self.deleteKeyPressed = false
        }
        
        return true
    }
}

