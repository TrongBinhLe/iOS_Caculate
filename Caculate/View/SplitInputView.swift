//
//  SplitInputView.swift
//  Caculate
//
//  Created by admin on 15/06/2023.
//

import Foundation
import UIKit
import Combine
import CombineCocoa

class SplitInputView: UIView {
    
    private let headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.configure(topText: "Split", bottomText: "the total")
        return headerView
    }()
    
    private lazy var decrementButton: UIButton = {
        let button = buildButton(text: "-", corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner])
        button.accessibilityIdentifier = ScreenIdentifier.SplitInputView.decrementButon.rawValue
        button.tapPublisher.flatMap { [unowned self] _ in
            Just(splitSubject.value == 1 ? 1 : splitSubject.value - 1)
        }.assign(to: \.value, on: splitSubject).store(in: &cancellable)
        return button
    }()
    
    private lazy var incrementButton: UIButton = {
        let button = buildButton(text: "+", corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        button.accessibilityIdentifier = ScreenIdentifier.SplitInputView.incrementButton.rawValue
        button.tapPublisher.flatMap { [unowned self] _ in
            Just(splitSubject.value + 1)
        }.assign(to: \.value, on: splitSubject).store(in: &cancellable)
        return button
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = LabelFactory.build(text: "1", font: ThemeFont.bold(ofSize: 20))
        label.accessibilityIdentifier = ScreenIdentifier.SplitInputView.quantityValueLabel.rawValue
        
        return label
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
        decrementButton,
        quantityLabel,
        incrementButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = UIStackView.spacingUseDefault
        return stackView
    }()
    
    private let splitSubject: CurrentValueSubject<Int, Never> = .init(1)
    var splitPulisher: AnyPublisher<Int, Never> {
        return splitSubject.removeDuplicates().eraseToAnyPublisher()
    }
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        super.init(frame: .zero)
        style()
        layout()
        obsever()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        backgroundColor = .systemBackground
    }
    
    private func layout() {
        [headerView, vStackView].forEach(addSubview(_:))
        
        vStackView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
        
        [incrementButton, decrementButton].forEach { button in
            button.snp.makeConstraints { make in
                make.width.equalTo(button.snp.height)
            }
        }
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(vStackView)
            make.trailing.equalTo(vStackView.snp.leading).offset(-24)
            make.width.equalTo(68)
        }
        
    }
    
    private func obsever() {
        splitSubject.sink { [unowned self] quantity in
            quantityLabel.text = quantity.stringValue
        }.store(in: &cancellable)
    }
    
    private func buildButton(text: String, corners: CACornerMask) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primary
        button.addRoundedCorners(corners: corners, radius: 8.0)
        return button
    }
    
    func reset() {
        splitSubject.send(1)
    }
}

