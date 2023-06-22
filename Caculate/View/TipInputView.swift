//
//  TipInputView.swift
//  Caculate
//
//  Created by admin on 15/06/2023.
//

import Foundation
import UIKit
import Combine
import CombineCocoa

class TipInputView: UIView {
    private let headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.configure(topText: "Choose", bottomText: "your tip")
        return headerView
    }()
    
    private lazy var tenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .tenPercent)
        button.tapPublisher.flatMap({ Just(Tip.tenPercent)}).assign(to: \.value, on: tipValueSubject).store(in: &cancelables)
        return button
    }()
    
    private lazy var fiftenPercenTipButton: UIButton = {
        let button = buildTipButton(tip: .fiftenPercent)
        button.tapPublisher.flatMap({ Just(Tip.fiftenPercent)}).assign(to: \.value, on: tipValueSubject).store(in: &cancelables)
        return button
    }()
    
    private lazy var twentyPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .twentyPercent)
        button.tapPublisher.flatMap({ Just(Tip.twentyPercent)}).assign(to: \.value, on: tipValueSubject).store(in: &cancelables)
        return button
    }()
    
    private lazy var customTopButton: UIButton = {
        let button = UIButton()
        button.setTitle("Custom tip", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.addCornerRadius(radius: 8.0)
        
        return button
    }()
    
    private lazy var buttonHStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [
        tenPercentTipButton,
        fiftenPercenTipButton,
        twentyPercentTipButton
       ])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var buttonVStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
        buttonHStackView,
        customTopButton
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let tipValueSubject: CurrentValueSubject<Tip, Never> = .init(.none)
    var tipPublisher: AnyPublisher<Tip, Never> {
        return tipValueSubject.eraseToAnyPublisher()
    }
    
    private var cancelables = Set<AnyCancellable>()
    
    init() {
        super.init(frame: .zero)
        style()
        layout()
//        observe()
    }
    
    private func observe() {
        tenPercentTipButton.tapPublisher.sink { [weak self] value in
            guard let self = self else { return }
            self.tipValueSubject.value = .tenPercent
        }.store(in: &cancelables)
        
        fiftenPercenTipButton.tapPublisher.sink {  [weak self] value in
            guard let self = self else { return }
            self.tipValueSubject.value = .fiftenPercent
        }.store(in: &cancelables)
        
        twentyPercentTipButton.tapPublisher.sink {  [weak self] value in
            guard let self = self else { return }
            self.tipValueSubject.value = .twentyPercent
        }.store(in: &cancelables)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        backgroundColor = .systemBackground
    }
    
    private func layout() {
        
        [headerView, buttonVStackView].forEach(addSubview(_:))
        
        buttonVStackView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.width.equalTo(68)
            make.leading.equalToSuperview()
            make.trailing.equalTo(buttonVStackView.snp.leading).offset(-24)
            make.centerY.equalTo(buttonHStackView.snp.centerY)
        }
    }
    
    private func buildTipButton(tip: Tip) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.addCornerRadius(radius: 8.0)
        let text = NSMutableAttributedString(string: tip.stringValue, attributes: [
            .font: ThemeFont.bold(ofSize: 20),
            .foregroundColor: UIColor.white
        ])
        text.addAttributes([.font: ThemeFont.demibold(ofSize: 12)], range: NSMakeRange(2, 1))
        button.setAttributedTitle(text, for: .normal)
        
        return button
    }
}
