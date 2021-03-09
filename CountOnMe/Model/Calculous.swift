//
//  Count.swift
//  CountOnMe
//
//  Created by Gilles Sagot on 28/02/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculous {
    
    // MARK: - VARIABLES

    enum StringType {
        case number, comma, op, equal, reset
    }
    
    var expression:String = "1 + 1 = 2"{
        didSet{updateArray()}
    }
    
    private var operationsToReduce: [String] = ["1","+","1","=","2"]
    
    
    private var expressionHaveResult: Bool {
        return expression.firstIndex(of: "=") != nil
    }
    
    private var expressionIsCorrect: Bool {
        return operationsToReduce.last != "+" && operationsToReduce.last != "-"
            && operationsToReduce.last != "/" && operationsToReduce.last != "*"
    }
    
    private var expressionHaveEnoughElement: Bool {
        return operationsToReduce.count >= 3
    }
    
    private var canAddOperator: Bool {
        return operationsToReduce.last != "+" && operationsToReduce.last != "-"
            && operationsToReduce.last != "/" && operationsToReduce.last != "*"
    }
    
    private var canAddComma: Bool {
        var canAdd = false
        let lastComma = expression.lastIndex(of: ".") ?? nil

        if lastComma == nil{
            canAdd = true
        }
        else {
            let  EndOfString = String(expression[lastComma!...])
            if EndOfString.lastIndex(of: "+") != nil {
                    canAdd  = true
            }
            if EndOfString.lastIndex(of: "-") != nil {
                    canAdd  = true
            }
            if EndOfString.lastIndex(of: "÷") != nil {
                    canAdd  = true
            }
            if EndOfString.lastIndex(of: "x") != nil {
                    canAdd  = true
            }
        }
        return operationsToReduce.last != "." && canAdd == true
    }
    
    // MARK: - USEFUL METHODS
    
    private func updateArray(){
        operationsToReduce = expression.split(separator: " ").map { "\($0)" }
    }
 
    private func reduceExpressionToresult() {
        expression = operationsToReduce.last!
    }
    
    private func reset() {
        expression = ""
    }
    
    // MARK: - MULTIPLICATION
    
    private func multiplicationFirst() {
        var multiplicationIndex = operationsToReduce.firstIndex(of: "x") ?? 0
        while (multiplicationIndex != 0) {
            let left = Float(operationsToReduce[multiplicationIndex-1])!
            let right = Float(operationsToReduce[multiplicationIndex+1])!
            let result = left * right
            operationsToReduce[multiplicationIndex] = "\(result)"
            operationsToReduce.remove(at: multiplicationIndex+1)
            operationsToReduce.remove(at: multiplicationIndex-1)
            multiplicationIndex = operationsToReduce.firstIndex(of: "x") ?? 0
        }
    }
    
    // MARK: - DIVISION
    
    private func divisionFirst() {
        var divisionIndex = operationsToReduce.firstIndex(of: "÷") ?? 0
        while (divisionIndex != 0) {
            let left = Float(operationsToReduce[divisionIndex-1])!
            let right = Float(operationsToReduce[divisionIndex+1])!
            let result = left / right
            operationsToReduce[divisionIndex] = "\(result)"
            operationsToReduce.remove(at: divisionIndex+1)
            operationsToReduce.remove(at: divisionIndex-1)
            divisionIndex = operationsToReduce.firstIndex(of: "÷") ?? 0
        }
    }
    
    // MARK: - ADDITION AND SUBSTRACTION
    
    private func finishCalcul() {
        while operationsToReduce.count > 1 {
            let left = Float(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Float(operationsToReduce[2])!
            let result: Float
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: fatalError("Unknown operator !")
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
    }

    // MARK: - GET RESULT
    
    private func result()->String{
        multiplicationFirst()
        divisionFirst()
        finishCalcul()
        var result = operationsToReduce.first!
        let lastNumberInResult = result[result.index(before: result.endIndex)]
        let commaIndex = result.firstIndex(of: ".") ?? result.endIndex
        if lastNumberInResult == "0"{
            result.remove(at: result.index(after: commaIndex))
            result.remove(at: commaIndex)
        }
        return result
    }
    
    // MARK: - MANAGE INPUTS FROM CONTROLLER
    
    func HandleUserInput(input : String, type : StringType, completion: (Bool,String?,String?)->())->String{
        switch type {
        case .equal:
            guard expressionIsCorrect else {
                completion(false,"zero", "Not enough elements!")
                return (expression)
            }
            guard expressionHaveEnoughElement else {
               completion(false,"zero", "Not enough elements 2")
                return (expression)
            }
            expression.append(" = \(result())")
            completion(true,nil,nil)
        case .comma:
            guard canAddComma else {
                completion(false,"zero","Float can only be add after number")
                return (expression)
            }
            expression.append(".")
            completion(true,nil,nil)
        case .op:
            if expressionHaveResult {
                reduceExpressionToresult()
                expression.append(" \(input)")
                completion(true,nil,nil)
            }else if canAddOperator {
                expression.append(" \(input)")
                completion(true,nil,nil)
            }else {
                completion(false,"zero","Operator already in use")
            }
        case .reset:
            reset()
        default:
            if expressionHaveResult {
                reset()
            }
            expression.append(" \(input)")
           completion(true,nil,nil)
        }
        return (expression)
    }// End HandleUserInput
    
    
}// End Calculous
