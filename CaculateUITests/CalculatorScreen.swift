//
//  CalculatorScreen.swift
//  CaculateUITests
//
//  Created by admin on 23/08/2023.
//

import Foundation
import XCTest

class CalculatorScreen {
    private var app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var logoView: XCUIElement {
        return app.otherElements[ScreenIdentifier.LogoView.logoView.rawValue]
    }
    
    var totalAmountPerPersonValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultView.totalAmountPerPersonValueLabel.rawValue]
    }
    
    var totalBillValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultView.totalBillValueLabel.rawValue]
    }
    
    var totalTipValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultView.totalTipValueLabel.rawValue]
    }
    // Bill Input View
    var billInputTextField: XCUIElement {
        return app.textFields[ScreenIdentifier.BillInputView.textField.rawValue]
    }
    
    //Tip Input View
    var tenPercentButton: XCUIElement {
        return app.buttons[ScreenIdentifier.TipInputView.tenPercentButton.rawValue]
    }
    var fifteenPercentButton: XCUIElement {
        return app.buttons[ScreenIdentifier.TipInputView.fifteenPercentButton.rawValue]
    }
    var twentyPercentButton: XCUIElement {
        return app.buttons[ScreenIdentifier.TipInputView.twentyPercentButton.rawValue]
    }
    var customeTipButton: XCUIElement {
        return app.buttons[ScreenIdentifier.TipInputView.customTipButton.rawValue]
    }
    var customAlertTextField: XCUIElement {
        return app.textFields[ScreenIdentifier.TipInputView.customTipAlertTextField.rawValue]
    }
    
    //Split Input View
    var increaseSplitButton: XCUIElement {
        return app.buttons[ScreenIdentifier.SplitInputView.incrementButton.rawValue]
    }
    
    var decreaseSplitButton: XCUIElement {
        return app.buttons[ScreenIdentifier.SplitInputView.decrementButon.rawValue]
    }
    
    var quantitySplitLable: XCUIElement {
        return app.staticTexts[ScreenIdentifier.SplitInputView.quantityValueLabel.rawValue]
    }
    
    //Actions
    
    func enterBill(amount:Double) {
        billInputTextField.tap()
        billInputTextField.typeText("\(amount)\n")
    }
    
    func selectedTip(tip: Tip) {
        switch tip {
        case .tenPercent:
            tenPercentButton.tap()
        case .fiftenPercent:
            fifteenPercentButton.tap()
        case .twentyPercent:
            twentyPercentButton.tap()
        case .custom(let value):
            customeTipButton.tap()
            XCTAssertTrue(customAlertTextField.waitForExistence(timeout: 1.0))
            customAlertTextField.typeText("\(value)\n")
        }
    }
    
    func selectIncrementButton(amountOfTaps: Int) {
        increaseSplitButton.tap(withNumberOfTaps: amountOfTaps, numberOfTouches: 1)
    }
    
    func selectDecrementButton(amountOfTaps: Int) {
        decreaseSplitButton.tap(withNumberOfTaps: amountOfTaps, numberOfTouches: 1)
    }
    
    func doubleTapLogoView() {
        logoView.tap(withNumberOfTaps: 2, numberOfTouches: 1)
    }
}


enum Tip {
    case tenPercent
    case fiftenPercent
    case twentyPercent
    case custom(value: Int)
}
