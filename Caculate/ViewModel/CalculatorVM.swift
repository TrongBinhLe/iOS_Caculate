//
//  CalculatorVM.swift
//  Caculate
//
//  Created by admin on 20/06/2023.
//

import Foundation
import UIKit
import Combine

class CalculatorVM {
    private var cancellables = Set<AnyCancellable>()
    
    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher<Result, Never>
    }
    
    func transform(input: Input) -> Output {
        
        let updateViewPulisher = Publishers.CombineLatest3(
            input.billPublisher,
            input.tipPublisher,
            input.splitPublisher).flatMap {[unowned self] (bill, tip, split) in
            let totalTip = getTipAmount(bill: bill, tip: tip)
            let totalBill = bill + totalTip
            let amountPerPerson = totalTip / Double(split)
            let result = Result(amountPerPerson: amountPerPerson, totalBill: totalBill, totalTip: totalTip)
            return Just(result)
            }.eraseToAnyPublisher()
    
        input.tipPublisher.sink{ tip in
            print("DEBUG: >> tip : \(tip)")
        }.store(in: &cancellables)
        
        input.splitPublisher.sink{ tip in
            print("DEBUG: >> split : \(tip)")
        }.store(in: &cancellables)
        
        return Output(updateViewPublisher: updateViewPulisher)
    }
    
    private func getTipAmount(bill: Double, tip: Tip) -> Double {
        switch tip {
        case .none:
            return 0
        case .tenPercent:
            return bill * 0.1
        case .fiftenPercent:
            return bill * 0.15
        case .twentyPercent:
            return bill * 0.2
        case .custom(let value):
            return Double(value)
        }
    }
}
