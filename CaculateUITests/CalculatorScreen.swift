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
    
    var totalAmountPerPersonValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultView.totalAmountPerPersonValueLabel.rawValue]
    }
    
    var totalBillValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultView.totalBillValueLabel.rawValue]
    }
    
    var totalTipValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultView.totalTipValueLabel.rawValue]
    }
}
