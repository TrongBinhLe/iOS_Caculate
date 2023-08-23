//
//  CaculateUITests.swift
//  CaculateUITests
//
//  Created by admin on 22/08/2023.
//

import XCTest

final class CaculateUITests: XCTestCase {
    
    private var app: XCUIApplication!
    private var screen: CalculatorScreen {
        CalculatorScreen(app: app)
    }
    
    override func setUp() {
        super.setUp()
        app = .init()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func testResultViewDefaultValues() {
        
        // Result View
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$0")
        XCTAssertEqual(screen.totalTipValueLabel.label, "$0")
        XCTAssertEqual(screen.totalBillValueLabel.label, "$0")
        
    }
    
    func testRegularTip() {
        //User enters a $100 bill
        screen.enterBill(amount: 100)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$100")
        XCTAssertEqual(screen.totalTipValueLabel.label, "$0")
        XCTAssertEqual(screen.totalBillValueLabel.label, "$100")
        
        //User selects 10%
        screen.selectedTip(tip: .tenPercent)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$110")
        XCTAssertEqual(screen.totalTipValueLabel.label, "$10")
        XCTAssertEqual(screen.totalBillValueLabel.label, "$110")
        
        //User selects 15%
        screen.selectedTip(tip: .fiftenPercent)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$115")
        XCTAssertEqual(screen.totalTipValueLabel.label, "$15")
        XCTAssertEqual(screen.totalBillValueLabel.label, "$115")
        
        //User selects 20%
        screen.selectedTip(tip: .twentyPercent)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$120")
        XCTAssertEqual(screen.totalTipValueLabel.label, "$20")
        XCTAssertEqual(screen.totalBillValueLabel.label, "$120")
        
        //User splits the bill by 4
        screen.selectIncrementButton(amountOfTaps: 3)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$30")
        XCTAssertEqual(screen.totalTipValueLabel.label, "$20")
        XCTAssertEqual(screen.totalBillValueLabel.label, "$120")
        
        //User splits the bill by 2
        screen.selectDecrementButton(amountOfTaps: 2)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$60")
        XCTAssertEqual(screen.totalTipValueLabel.label, "$20")
        XCTAssertEqual(screen.totalBillValueLabel.label, "$120")
    }
    
    func testCustomTipAndSplitBill2() {
        screen.enterBill(amount: 300)
        screen.selectedTip(tip: .custom(value: 200))
        screen.selectIncrementButton(amountOfTaps: 1)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$250")
        XCTAssertEqual(screen.totalTipValueLabel.label, "$200")
        XCTAssertEqual(screen.totalBillValueLabel.label, "$500")
    }
    
    func testResetButton() {
        screen.enterBill(amount: 300)
        screen.selectedTip(tip: .custom(value: 200))
        screen.selectIncrementButton(amountOfTaps: 1)
        screen.doubleTapLogoView()
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$0")
        XCTAssertEqual(screen.totalTipValueLabel.label, "$0")
        XCTAssertEqual(screen.totalBillValueLabel.label, "$0")
        
    }
    
}
