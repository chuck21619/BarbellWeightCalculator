//
//  BarbellWeightCalculatorTests.swift
//  BarbellWeightCalculatorTests
//
//  Created by charles johnston on 2/27/20.
//  Copyright © 2020 Zin Studio. All rights reserved.
//

import XCTest
@testable import BarbellWeightCalculator

class BarbellWeightCalculatorTests: XCTestCase {
    
    var calculator: Calculator!
    override func setUp() {

        super.setUp()

        let inventory = Inventory()
        self.calculator = Calculator(inventory: inventory)
    }
    
    func testCalculator_135() {
        
        let plates = self.calculator.calculate(135)

        XCTAssert(plates.count == 1)
        XCTAssert(plates[0] == 45)
    }
    
    func testCalculator_225() {

        let plates = self.calculator.calculate(225)

        XCTAssert(plates.count == 2)
        XCTAssert(plates[0] == 45)
        XCTAssert(plates[1] == 45)
    }

    func testCalculator_185() {

        let plates = self.calculator.calculate(185)

        XCTAssert(plates.count == 2)
        XCTAssert(plates[0] == 45)
        XCTAssert(plates[1] == 25)
    }
    
    func testCalculator_195() {

        let plates = self.calculator.calculate(195)

        XCTAssert(plates.count == 3)
        XCTAssert(plates[0] == 45)
        XCTAssert(plates[1] == 25)
        XCTAssert(plates[2] == 5)
    }
    
    func testCalculator_316() {

        let plates = self.calculator.calculate(316)

        XCTAssert(plates.count == 5)
        XCTAssert(plates[0] == 45)
        XCTAssert(plates[1] == 45)
        XCTAssert(plates[2] == 35)
        XCTAssert(plates[3] == 10)
        XCTAssert(plates[4] == 0.5)
    }
    
    func testCalculator_95p5() {

        let plates = self.calculator.calculate(95.5)

        XCTAssert(plates.count == 2)
        XCTAssert(plates[0] == 25)
        XCTAssert(plates[1] == 0.25)
    }
    
    func testCalculator_95p6() {

        let plates = self.calculator.calculate(95.6)

        XCTAssert(plates.count == 2)
        XCTAssert(plates[0] == 25)
        XCTAssert(plates[1] == 0.25)
    }
}
