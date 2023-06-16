//
//  ViewController.swift
//  Caculate
//
//  Created by admin on 13/06/2023.
//

import Foundation
import UIKit
import SnapKit

class CalculatorViewController: UIViewController {
    
    private let logoView = LogoView()
    private let resultView = ResultView()
    private let billInputView = BillInputView()
    private let tipInputView = TipInputView()
    private let splitInputView = SplitInputView()
    
    private lazy var vStacKView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [
        logoView,
        resultView,
        billInputView,
        tipInputView,
        splitInputView,
        UIView()
        ])
        stackview.axis = .vertical
        stackview.spacing = 36
        
        return stackview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
        
    }
    
    private func layout() {
        view.addSubview(vStacKView)
        
        vStacKView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leadingMargin).offset(16)
            make.trailing.equalTo(view.snp.trailingMargin).offset(-16)
            make.top.equalTo(view.snp.topMargin).offset(16)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-16)
        }
        
        logoView.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        resultView.snp.makeConstraints { make in
            make.height.equalTo(224)
        }
        
        billInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
        tipInputView.snp.makeConstraints { make in
            make.height.equalTo(56+56+16)
        }
        
        splitInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
    }
    
}

