//
//  ViewController.swift
//  Calculator
//
//  Created by jiahui on 15/9/20.
//  Copyright © 2015年 YouZai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    
    var isInTheMiddleOfTypingNumber = false;
    
    var brain = CalculaterBrain()
    
    @IBAction func apendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if isInTheMiddleOfTypingNumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            isInTheMiddleOfTypingNumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        switch operation {
        case "×": performOperatin {$0 * $1}
        case "÷": performOperatin {$1 / $0}
        case "−": performOperatin {$1 - $0}
        case "+": performOperatin {$0 + $1}
        default :break
        }
    }
    
    func performOperatin(operation: (Double, Double) -> Double) {
        if operandStank.count >= 2 {
            displayValue = operation(operandStank.removeLast(), operandStank.removeLast())
        }
    }
    
//    func multiply (op1:Double, op2:Double) -> Double {
//        return op1 * op2;
//    }
    
    var operandStank = Array<Double>()

    @IBAction func enter(sender: UIButton) {
        isInTheMiddleOfTypingNumber = false
        operandStank.append(displayValue)
        print("operandStank = \(operandStank)")
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            isInTheMiddleOfTypingNumber = false
        }
    }
    
    


}

