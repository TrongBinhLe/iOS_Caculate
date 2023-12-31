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
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.tenPercentButton.rawValue
        button.tapPublisher.flatMap({ Just(Tip.tenPercent)}).assign(to: \.value, on: tipValueSubject).store(in: &cancelables)
        return button
    }()
    
    private lazy var fiftenPercenTipButton: UIButton = {
        let button = buildTipButton(tip: .fiftenPercent)
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.fifteenPercentButton.rawValue
        button.tapPublisher.flatMap({ Just(Tip.fiftenPercent)}).assign(to: \.value, on: tipValueSubject).store(in: &cancelables)
        return button
    }()
    
    private lazy var twentyPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .twentyPercent)
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.twentyPercentButton.rawValue
        button.tapPublisher.flatMap({ Just(Tip.twentyPercent)}).assign(to: \.value, on: tipValueSubject).store(in: &cancelables)
        return button
    }()
    
    private lazy var customTopButton: UIButton = {
        let button = UIButton()
        button.setTitle("Custom tip", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.customTipButton.rawValue
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.addCornerRadius(radius: 8.0)
        button.tapPublisher.sink { [weak self] _ in
            self?.handleCustomTipButton()
        }.store(in: &cancelables)
        
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
        observe()
    }
    
    private func observe() {
//        tenPercentTipButton.tapPublisher.sink { [weak self] value in
//            guard let self = self else { return }
//            self.tipValueSubject.value = .tenPercent
//        }.store(in: &cancelables)
//
//        fiftenPercenTipButton.tapPublisher.sink {  [weak self] value in
//            guard let self = self else { return }
//            self.tipValueSubject.value = .fiftenPercent
//        }.store(in: &cancelables)
//
//        twentyPercentTipButton.tapPublisher.sink {  [weak self] value in
//            guard let self = self else { return }
//            self.tipValueSubject.value = .twentyPercent
//        }.store(in: &cancelables)
        tipValueSubject.sink { [weak self] tip in
            guard let `self` = self else { return }
            self.resetView()
            switch tip {
            case .tenPercent:
                self.tenPercentTipButton.backgroundColor = ThemeColor.secondary
            case .fiftenPercent:
                self.fiftenPercenTipButton.backgroundColor = ThemeColor.secondary
            case .twentyPercent:
                self.twentyPercentTipButton.backgroundColor = ThemeColor.secondary
            case .custom(let value):
                self.customTopButton.backgroundColor = ThemeColor.secondary
                let textAtributes = NSMutableAttributedString(string: "$\(value)", attributes: [NSAttributedString.Key.font: ThemeFont.bold(ofSize: 20)])
                textAtributes.addAttributes([NSAttributedString.Key.font : ThemeFont.bold(ofSize: 14)], range: NSMakeRange(0, 1))
                self.customTopButton.setAttributedTitle(textAtributes, for: .normal)
            case .none: break
            }
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
    
    private func resetView() {
        [tenPercentTipButton, fiftenPercenTipButton, twentyPercentTipButton, customTopButton].forEach {
            $0.backgroundColor = ThemeColor.primary
        }
        let textAtributes = NSMutableAttributedString(string: "Custome tip", attributes: [NSAttributedString.Key.font: ThemeFont.bold(ofSize: 20)])
        
        customTopButton.setAttributedTitle(textAtributes, for: .normal)
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
    
    func reset() {
        tipValueSubject.send(.none)
    }
}

// Mark: Actions
extension TipInputView {
    private func handleCustomTipButton() {
        let alertController: UIAlertController = {
            let controller = UIAlertController(
                title: "Enter custom tip",
                message: nil,
                preferredStyle: .alert)
            controller.addTextField { textField in
                textField.placeholder = "Make it generous!"
                textField.keyboardType = .numberPad
                textField.autocorrectionType = .no
                textField.accessibilityIdentifier = ScreenIdentifier.TipInputView.customTipAlertTextField.rawValue
            }
            let cancelAction = UIAlertAction(
                title: "Cancel",
                style: .cancel)
            let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                guard let text = controller.textFields?.first?.text,
                      let value = Int(text) else { return }
                self?.tipValueSubject.value = .custom(value: value)
            }
            [cancelAction, okAction].forEach(controller.addAction(_:))
            
            return controller
        }()
        
        parentViewController?.present(alertController, animated: true)
    }
}
