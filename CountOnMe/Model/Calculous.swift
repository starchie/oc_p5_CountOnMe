//
//  Count.swift
//  CountOnMe
//
//  Created by Gilles Sagot on 28/02/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculous {

    
    var expression:String = "1 + 1 = 2"{
        didSet{updateArray()}
    }
    
    var operationsToReduce: [String] = ["1","+","1","=","2"]
    
    
    var expressionHaveResult: Bool {
        return expression.firstIndex(of: "=") != nil
    }
    
    var expressionIsCorrect: Bool {
        return operationsToReduce.last != "+" && operationsToReduce.last != "-"
            && operationsToReduce.last != "/" && operationsToReduce.last != "*"
    }
    
    var expressionHaveEnoughElement: Bool {
        return operationsToReduce.count >= 3
    }
    
    var canAddOperator: Bool {
        return operationsToReduce.last != "+" && operationsToReduce.last != "-"
            && operationsToReduce.last != "/" && operationsToReduce.last != "*"
    }
    
    private func updateArray(){
        operationsToReduce = expression.split(separator: " ").map { "\($0)" }
    }
 
    func reduceExpressionToresult() {
        expression = operationsToReduce.last!
         
    }
    
    func result()->String{
        
        multiplicationFirst()
        divisionFirst()
        finishCalcul()
        return operationsToReduce.first!
    }
    
    
    private func multiplicationFirst() {
        var multiplicationIndex = operationsToReduce.firstIndex(of: "x") ?? 0
        
        while (multiplicationIndex != 0) {
            let left = Int(operationsToReduce[multiplicationIndex-1])!
            let right = Int(operationsToReduce[multiplicationIndex+1])!
            let result = left * right
    
            operationsToReduce[multiplicationIndex] = "\(result)"
            operationsToReduce.remove(at: multiplicationIndex+1)
            operationsToReduce.remove(at: multiplicationIndex-1)
            
            multiplicationIndex = operationsToReduce.firstIndex(of: "x") ?? 0
        }
    }
    
    private func divisionFirst() {
        var divisionIndex = operationsToReduce.firstIndex(of: "÷") ?? 0
        
        while (divisionIndex != 0) {
            let left = Int(operationsToReduce[divisionIndex-1])!
            let right = Int(operationsToReduce[divisionIndex+1])!
            let result = left / right
    
            operationsToReduce[divisionIndex] = "\(result)"
            operationsToReduce.remove(at: divisionIndex+1)
            operationsToReduce.remove(at: divisionIndex-1)
            
            divisionIndex = operationsToReduce.firstIndex(of: "÷") ?? 0
        }
    }
    
    private func finishCalcul() {
        while operationsToReduce.count > 1 {
 
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!

            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: fatalError("Unknown operator !")
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
    }
    

    
    
    
    
}
