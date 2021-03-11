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
    
    func testCalculWithNumber_WhenAddNumberAfterOperator_ThenExpressionShouldUpdate() {
        calculous.expression = "1 + "
        let text = calculous.handleUserInput(input: "5", type: .number, completion: {(result,title,message)->() in })
        XCTAssert(text == "1 + 5")
    }
    
    func testCalculWithNumber_WhenAddNumberAfterOperatorMinus_ThenExpressionShouldUpdate() {
        calculous.expression = "1 - "
        let text = calculous.handleUserInput(input: "5", type: .number, completion: {(result,title,message)->() in })
        XCTAssert(text == "1 - 5")
    }
    
    func testCalcul_WhenAddEqual_ThenExpressionShouldUpdateWithResult() {
        calculous.expression = "1 - 5"
        let text = calculous.handleUserInput(input: "=", type: .equal, completion: {(result,title,message)->() in })
        XCTAssert(text == "1 - 5 = -4 ")
    }
    
    func testCalculWithOperator_WhenAddOperatorAfterNumber_ThenExpressionShouldUpdate() {
        calculous.expression = "1 + 5"
        let text = calculous.handleUserInput(input: "+", type: .op, completion: {(result,title,message)->() in })
        XCTAssert(text == "1 + 5 + ")
    }
    
    func testCalculWithOperator_WhenAddOperatorAfterOperator_ThenExpressionShouldNotUpdate() {
        calculous.expression = "1 + 5 + "
        let text = calculous.handleUserInput(input: "+", type: .op, completion: {(result,title,message)->() in })
        XCTAssert(text == "1 + 5 + ")
    }
    
    func testCalculWithOperatorMultiplication_WhenAddNegativeOperator_ThenExpressionShouldUpdate() {
        calculous.expression = "1 x "
        let text = calculous.handleUserInput(input: "-", type: .op, completion: {(result,title,message)->() in })
        XCTAssert(text == "1 x -")
    }
    
    func testCalculWithResult_WhenAddOperator_ThenExpressionShouldUseResult() {
        calculous.expression = "1 + 5 = 6"
        let text = calculous.handleUserInput(input: "*", type: .op, completion: {(result,title,message)->() in })
        XCTAssert(text == "6 * ")
    }
    
    func testCalculComplex_WhenMultiplicationExist_ThenMultiplicationShouldBeCaluledFirst() {
        calculous.expression = "1 + 5 x 2"
        let text = calculous.handleUserInput(input: "=", type: .equal, completion: {(result,title,message)->() in })
        XCTAssert(text == "1 + 5 x 2 = 11 ")
    }
    
    func testCalculWithFloat_WhenFloatIsNeeded_ThenResultShouldBeFloat() {
        calculous.expression = "7 ÷ 2"
        let text = calculous.handleUserInput(input: "=", type: .equal, completion: {(result,title,message)->() in })
        XCTAssert(text == "7 ÷ 2 = 3.5 ")
    }
    
    func testCalculWithFloat_WhenResultCanBeRounded_ThenResultShouldBeRounded() {
        calculous.expression = "5.5 + 1.25 x 2"
        let text = calculous.handleUserInput(input: "=", type: .equal, completion: {(result,title,message)->() in })
        XCTAssert(text == "5.5 + 1.25 x 2 = 8 ")
    }
    
    func testCalculWithFloat_WhenCommaAlreadyInUseBeforeAddition_ThenExpressionShouldUpdate() {
        calculous.expression = "5.5 + 1"
        let text = calculous.handleUserInput(input: ".", type: .comma, completion: {(result,title,message)->() in })
        XCTAssert(text == "5.5 + 1.")
    }
    
    func testCalculWithFloat_WhenCommaAlreadyInUseBeforeSoustraction_ThenExpressionShouldUpdate() {
        calculous.expression = "5.5 - 2.5 - 1"
        let text = calculous.handleUserInput(input: ".", type: .comma, completion: {(result,title,message)->() in })
        XCTAssert(text == "5.5 - 2.5 - 1.")
    }
    
    func testCalculWithFloat_WhenCommaAlreadyInUseBeforeMultiplication_ThenExpressionShouldUpdate() {
        calculous.expression = "5.5 x 2 - 1"
        let text = calculous.handleUserInput(input: ".", type: .comma, completion: {(result,title,message)->() in })
        XCTAssert(text == "5.5 x 2 - 1.")
    }
    func testCalculWithFloat_WhenCommaAlreadyInUseBeforeDivision_ThenExpressionShouldUpdate() {
        calculous.expression = "5.5 ÷ 2 - 1"
        let text = calculous.handleUserInput(input: ".", type: .comma, completion: {(result,title,message)->() in })
        XCTAssert(text == "5.5 ÷ 2 - 1.")
    }
    
    func testAddComma_WhenExpressionEndWithComma_ThenExpressionShouldNotUpdate() {
        calculous.expression = "5.5 + 5."
        let text = calculous.handleUserInput(input: ".", type: .comma, completion: {(result,title,message)->() in })
        XCTAssert(text == "5.5 + 5.")
    }
    
    func testCalculWithNoFloat_WhenAddComma_ThenExpressionShouldUpdate() {
        calculous.expression = "5 + 5"
        let text = calculous.handleUserInput(input: ".", type: .comma, completion: {(result,title,message)->() in })
        XCTAssert(text == "5 + 5.")
    }
    
    func testCalculWithFloat_WhenCommaAlreadyInUse_ThenExpressionShouldNotUpdate() {
        calculous.expression = "5.5 + 5."
        let text = calculous.handleUserInput(input: ".", type: .comma, completion: {(result,title,message)->() in })
        XCTAssert(text == "5.5 + 5.")
    }
    
    func testReset_WhenExpressionWithValues_ThenResetShouldClearExpression() {
        calculous.expression = "5.5 + 5 = 10.5"
        let text = calculous.handleUserInput(input: "", type: .reset, completion: {(result,title,message)->() in })
        XCTAssert(text == "")
    }
    
    func testAddNumber_WhenExpressionHasResult_ThenResetShouldClearExpressionAndStartWithNewNumber() {
        calculous.expression = "5.5 + 5 = 10.5"
        let text = calculous.handleUserInput(input: "5", type: .number, completion: {(result,title,message)->() in })
        XCTAssert(text == "5")
    }
    
    func testEqual_WhenExpressionHasNoEnoughElement_ThenExpressionShouldNotUpdate() {
        calculous.expression = "5"
        let text = calculous.handleUserInput(input: "=", type: .equal, completion: {(result,title,message)->() in })
        XCTAssert(text == "5")
    }
    
    func testEqual_WhenBadExpression_ThenExpressionShouldNotUpdate() {
        calculous.expression = "5.5 + 5 + "
        let text = calculous.handleUserInput(input: "=", type: .equal, completion: {(result,title,message)->() in })
        XCTAssert(text == "5.5 + 5 + ")
    }
    
    func testCalcul_WhenDivideByZero_ThenExpressionShouldReturnInfinity() {
        calculous.expression = "5.5 ÷ 0"
        let text = calculous.handleUserInput(input: "=", type: .equal, completion: {(result,title,message)->() in })
        XCTAssert(text == "5.5 ÷ 0 = inf ")
    }
    
    
   
}
