//
//  LogoView.swift
//  Caculate
//
//  Created by admin on 15/06/2023.
//

import Foundation
import UIKit

class LogoView: UIView {
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
        imageView,
        vStackView
        ])
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var vStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [
        topLabel,
        bottomLabel
       ])
        
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: .init(named: "icCalculatorBW"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    

    private lazy var topLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(
            string: "Mr TIP",
            attributes: [.font: ThemeFont.demibold(ofSize: 16)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 24)], range: NSMakeRange(3, 3))
        label.attributedText = text
        
        return label
    }()
    
    private lazy var bottomLabel: UILabel = {
        LabelFactory.build(text: "Caculator", font: ThemeFont.demibold(ofSize: 20), textAlignment: .left)
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
        backgroundColor = .systemBackground
    }
    
    private func layout() {
        
        addSubview(hStackView)
        
        hStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(imageView.snp.width)
        }
    }
}
