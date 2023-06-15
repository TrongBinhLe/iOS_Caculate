//
//  ViewController.swift
//  Caculate
//
//  Created by admin on 13/06/2023.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    private let logoView = LogoView()
    private let resultView = ResultView()
    private let billInputView = BillInputView()
    private let tipInputView = TipInputView()
    private let splitInputView = SplitInputView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}

