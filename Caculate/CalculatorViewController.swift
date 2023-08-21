//
//  ViewController.swift
//  Caculate
//
//  Created by admin on 13/06/2023.
//

import Foundation
import UIKit
import SnapKit
import Combine
import CombineCocoa

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
    
    private lazy var tapPublisher: AnyPublisher<Void, Never> = {
        let tabGesture = UITapGestureRecognizer()
        view.addGestureRecognizer(tabGesture)
        return tabGesture.tapPublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()
    
    private lazy var logoTapPublisher: AnyPublisher<Void, Never> = {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.numberOfTapsRequired = 2
        logoView.addGestureRecognizer(tapGesture)
        return tapGesture.tapPublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()
    
    private let vm = CalculatorVM()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
        bind()
        observe()
    }
    
    private func bind() {
        let input = CalculatorVM.Input(
            billPublisher: billInputView.billPublisher,
            tipPublisher: tipInputView.tipPublisher,
            splitPublisher: splitInputView.splitPulisher,
            logoPublisher: logoTapPublisher)
        let output = vm.transform(input: input)
        
        output.updateViewPublisher.sink { [weak self] result in
            guard let `self` = self else { return }
            self.resultView.configure(result: result)
        }.store(in: &cancellables)
        
        output.resultCaculator.sink { [weak self] result in
            guard let `self` = self else { return }
            self.splitInputView.reset()
            self.tipInputView.resetView()
            self.billInputView.reset()
        }.store(in: &cancellables)
        
    }
    
    private func observe() {
        tapPublisher.sink { [unowned self] _ in
            view.endEditing(true)
        }.store(in: &cancellables)
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

