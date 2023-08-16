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
        
        let result = Result(amountPerPerson: 500, totalBill: 299, totalTip: 200)
        input.tipPublisher.sink{ tip in
            print("DEBUG: >> tip : \(tip)")
        }.store(in: &cancellables)
        
        return Output(updateViewPublisher: Just(result).eraseToAnyPublisher())
    }
}
