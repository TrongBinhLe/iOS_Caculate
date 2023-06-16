//
//  ResultView.swift
//  Caculate
//
//  Created by admin on 15/06/2023.
//

import Foundation
import UIKit

class ResultView: UIView {
    
    private lazy var headerLabel: UILabel = {
        let label = LabelFactory.build(text: "Total p/person", font: ThemeFont.demibold(ofSize: 18))
        return label
    }()
    
    private lazy var amountPerPersonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let text = NSMutableAttributedString(string: "$0", attributes: [
            .font: ThemeFont.bold(ofSize: 48)
        ])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 24)], range: NSMakeRange(0, 1))
        label.attributedText = text
        
        return label
    }()
    
    private lazy var horizontalLineView: UIView = {
        let view  = UIView()
        view.backgroundColor =  ThemeColor.separator
        
        return view
    }()
    
    private func buildSpacerView(height: CGFloat) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        return view
    }
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            headerLabel,
            amountPerPersonLabel,
            horizontalLineView,
            buildSpacerView(height: 2),
            hStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
        AmountView(),
        UIView(),
        AmountView(),
        ])
        stackView.axis = .horizontal
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    
    init() {
        super.init(frame: .zero)
        style()
        layout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        backgroundColor = .white
        addShadow(offset: CGSize(width: 0, height: 3), color: .black, radius: 12.0, opacity: 0.1)
        
    }
    
    private func layout() {
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(24)
            make.leading.equalTo(snp.leading).offset(24)
            make.bottom.equalTo(snp.bottom).offset(-24)
            make.trailing.equalTo(snp.trailing).offset(-24)
        }
        
        horizontalLineView.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
    }
}


class AmountView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
