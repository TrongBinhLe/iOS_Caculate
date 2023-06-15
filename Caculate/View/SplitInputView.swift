//
//  SplitInputView.swift
//  Caculate
//
//  Created by admin on 15/06/2023.
//

import Foundation
import UIKit


class SplitInputView: UIView {
    
    init() {
        super.init(frame: .zero)
        style()
        layout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        backgroundColor = .gray
    }
    
    private func layout() {
    }
}

