//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - INTERFACE BUILDER REFERENCES
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    // MARK: - VARIABLES
    
    var calculous = Calculous()
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - CONTROLLER POPUP
    
    // Alert Controller
    private func presentUIAlertController(title:String, message:String) {
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(ac, animated: true, completion: nil)
        
    }
    
    // MARK: - RESET
    
    private func reset() {
        textView.text = ""
        calculous.expression = ""
    }
    
    // MARK: - ACTIONS
    
    // Reset Calcul
    @IBAction func tappedResetButton(_ sender: Any) {
        reset()
    }
    
    // Add Number
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        if calculous.expressionHaveResult {
            reset()
        }
        calculous.expression.append(numberText)
        
        textView.text = calculous.expression
    }
    @IBAction func tappedCommaButton(_ sender: UIButton) {
        
        calculous.expression.append(".")
        textView.text = calculous.expression
        
    }
    
    // Add Operator
    @IBAction func tappedOperatorButton(_ sender: UIButton) {

        guard let operatorText = sender.title(for: .normal) else {
            return
        }
        
        if calculous.expressionHaveResult {
            calculous.reduceExpressionToresult()
            calculous.expression.append(" \(operatorText) ")

        }else if calculous.canAddOperator {
            calculous.expression.append(" \(operatorText) ")
             
        }else {
            presentUIAlertController(title: "Operator", message: "Operator already in use !")
        }
    
        textView.text = calculous.expression
        
    }
    
    // Ask Result
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calculous.expressionIsCorrect else {
            return presentUIAlertController(title: "Zéro!", message: "Not enough elements!")
        }
        
        guard calculous.expressionHaveEnoughElement else {
            return presentUIAlertController(title: "Expression", message: "Not enough elements!")
        }
        
        // MARK: - CALCUL REQUEST
        calculous.expression.append(" = \( calculous.result())")
        
        textView.text = calculous.expression
    }

}

