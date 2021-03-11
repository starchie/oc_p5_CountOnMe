//
//  ViewController.swift
//  CountOnMe
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Edited by Gilles Sagot on 28/02/2021.
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
    
    
    // MARK: - ACTIONS
    
    // RESET CALCUL
    @IBAction func tappedResetButton(_ sender: Any) {
        textView.text =  calculous.handleUserInput(input: "", type: .reset, completion: {(result,title,message)->() in})
    }
    
    // NUMBER REQUEST
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        textView.text =  calculous.handleUserInput(input: numberText, type: .number, completion: {(result,title,message)->() in
            if result == false  { presentUIAlertController(title:title!, message:message!)} })
    }
    
    // COMMA REQUEST
    @IBAction func tappedCommaButton(_ sender: UIButton) {
        textView.text = calculous.handleUserInput(input: ".", type: .comma, completion: {(result,title,message)->() in
            if result == false { presentUIAlertController(title:title!, message:message!)} })
    }
    
    // OPERATOR REQUEST
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        guard let operatorText = sender.title(for: .normal) else {
            return
        }
        textView.text = calculous.handleUserInput(input: operatorText, type: .op, completion: {(result,title,message)->() in
            if result == false  { presentUIAlertController(title:title!, message:message!)} })
    }
    
    // CALCUL REQUEST
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        textView.text = calculous.handleUserInput(input: "=", type: .equal, completion: {(result,title,message)->() in
            if result == false  { presentUIAlertController(title:title!, message:message!)} })
    }
    
    
    
    
}

