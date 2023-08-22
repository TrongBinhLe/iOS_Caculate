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
    private var logoTabPublisher: PassthroughSubject<Void, Never>!
    private var audioPlayService: MockAudioPlayerService!
    
    override func setUp() {
        audioPlayService = .init()
        sut = .init(audioplayService: audioPlayService)
        logoTabPublisher = .init()
        cancelables = .init()
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        cancelables = nil
        audioPlayService = nil
        logoTabPublisher = nil
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

    func testResultWithoutTipFor2Person() {
        //get
        let bill: Double = 100
        let tip: Tip = .none
        let split: Int = 2
        let input = buildInput(bill: bill, tip: tip, split: split)
        //when
        let output = sut.transform(input: input)
        //then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 50)
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
        }.store(in: &cancelables)
    }
    
    func testResultWith10PercentTipFor2Person() {
        //get
        let bill: Double = 100
        let tip: Tip = .tenPercent
        let split: Int = 2
        let input = buildInput(bill: bill, tip: tip, split: split)
        //when
        let output = sut.transform(input: input)
        //then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 55)
            XCTAssertEqual(result.totalTip, 10)
            XCTAssertEqual(result.totalBill, 110)
        }.store(in: &cancelables)
    }
    
    func testResultWithCustomerTipFor4Person() {
        //get
        let bill: Double = 100
        let tip: Tip = .custom(value: 60)
        let split: Int = 4
        let input = buildInput(bill: bill, tip: tip, split: split)
        //when
        let ouput = sut.transform(input: input)
        //then
        ouput.updateViewPublisher.sink { result in
            XCTAssertEqual(result.totalBill, 160)
            XCTAssertEqual(result.totalTip, 60)
            XCTAssertEqual(result.amountPerPerson, 40)
        }.store(in: &cancelables)
    }
    
    func testSoundPlayerAndCalculatorResetOnLogoTab() {
        //give
        let input = buildInput(bill: 100, tip: .tenPercent, split: 2)
        let output = sut.transform(input: input)
        let expectation1 = XCTestExpectation(description: "reset calculator called")
        let expectation2 = audioPlayService.expectation
        //then
        output.resultCaculator.sink { _ in
            expectation1.fulfill()
        }.store(in: &cancelables)
        //when
        logoTabPublisher.send()
        wait(for: [expectation1, expectation2], timeout: 1.0)
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

class MockAudioPlayerService: AudioPlayerService {
    let expectation = XCTestExpectation(description: "playSound is called")
    func playSound() {
        expectation.fulfill()
    }
    
    
}
