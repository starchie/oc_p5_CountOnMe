//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculousTestCase: XCTestCase {
    
    var calculous: Calculous!

    override func setUp() {
        super.setUp()
        calculous = Calculous()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCalculEndWithOperator_WhenAddOperator_ThenAddOperatorShouldBeFalse() {
        calculous.expression = "1 + "
        XCTAssert(calculous.canAddOperator == false)
    }
    
    func testCalculEndWithNumber_WhenAddOperator_ThenAddOperatorShouldBeTrue() {
        calculous.expression = "1 + 1 "
        XCTAssert(calculous.canAddOperator == true)
    }
    
    func testAskResult_WhenNoEnoughElements_ThenAddOperatorShouldBeFalse() {
        calculous.expression = "1 +  "
        XCTAssert(calculous.expressionIsCorrect == false)
    }
    
    func testAskResult_WhenEnoughElements_ThenAddOperatorShouldBeTrue() {
        calculous.expression = "1 + 1 "
        XCTAssert(calculous.expressionIsCorrect == true)
    }
    
    func testCalculHaveResult_WhenAddOperator_ThenUseThisResult() {
        calculous.expression = "1 + 1 = 2 "
        XCTAssert(calculous.expressionHaveResult == true)
        
        calculous.reduceExpressionToresult()
        XCTAssert(calculous.expression == "2")
        
        calculous.expression.append(" + 1")
        XCTAssert(calculous.result() == "3")
    }
    
    func testCalcul_WhenExpressionIsUpdated_ThenArrayShouldBeAlsoUpdated() {
        calculous.expression = "5 x 2 "
        XCTAssert(calculous.operationsToReduce.count == 3)
    }
    
    func testCalcul_WhenThereIsMultiplication_ThenMultiplicationShouldBeCaluledFirst() {
        calculous.expression = "5 + 5 x 2 - 2"
        XCTAssert(calculous.result() == "13")
    }
    
    func testCalcul_WhenThereIsDivision_ThenDivisionShouldBeCaluledFirst() {
        calculous.expression = "5 + 10 ÷ 2 - 2"
        XCTAssert(calculous.result() == "8")
    }
    
    func testCalcul_WhenComplexeOperation_ThenResultShouldBeOk() {
        calculous.expression = "5 + 20 x 3 + 10 ÷ 2 - 2"
        XCTAssert(calculous.result() == "68")
    }
    
    func testCalcul_WhenAnotherComplexeOperation_ThenResultShouldBeOkAgain() {
        calculous.expression = "5 + 20 x 3 x 10 ÷ 2 - 2"
        XCTAssert(calculous.result() == "303")
    }
}
