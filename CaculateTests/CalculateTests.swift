//
//  CaculateTests.swift
//  CaculateTests
//
//  Created by admin on 21/08/2023.
//

import XCTest
import Combine

@testable import Caculate

final class CalculateTests: XCTestCase {
    // sut -> System Under Test
    
    private var sut: CalculatorVM!
    private var cancelables: Set<AnyCancellable>!
    private var logoTabPublisher = PassthroughSubject<Void, Never>()
    
    override func setUp() {
        sut = .init()
        cancelables = .init()
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        cancelables = nil
        super.tearDown()
    }
    
    func testResultWithoutTipForOnePerson() {
        // given
        let bill: Double = 100
        let tip: Tip = .none
        let split: Int = 1
        let input = buildInput(bill: bill, tip: tip, split: split)
        // when
        let output = sut.transform(input: input)
        //then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 100.0)
            XCTAssertEqual(result.totalTip, 0.0)
            XCTAssertEqual(result.totalBill, 100.0)
        }.store(in: &cancelables)
        
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    private func buildInput(bill: Double, tip: Tip, split: Int) -> CalculatorVM.Input {
        return .init(billPublisher: Just(bill).eraseToAnyPublisher(), tipPublisher: Just(tip).eraseToAnyPublisher(), splitPublisher: Just(split).eraseToAnyPublisher(), logoPublisher: logoTabPublisher.eraseToAnyPublisher())
    }

}
