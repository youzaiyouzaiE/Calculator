//
//  CalculaterBrain.swift
//  Calculator
//
//  Created by jiahui on 15/9/22.
//  Copyright © 2015年 YouZai. All rights reserved.
//

import Foundation

class CalculaterBrain {
    private enum Op {
        case Operand(Double)
        case UnaryOperation (String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
    }
    
    private var opStack = [Op]()// = Array<Op>()
    
    private var knowOps = [String : Op]()// Dictionary<String ,Op>()
    
    init () {
//        func learnOp(op: Op) {
//            knowOps[op.description] = op
//        }
//        learnOp(Op)
        knowOps["×"] = Op.BinaryOperation("×", *)  //{$0*$1}
        knowOps["÷"] = Op.BinaryOperation("÷") {$1/$0}
        knowOps["−"] = Op.BinaryOperation("−") {$1-$0}
        knowOps["+"] = Op.BinaryOperation("+", +)  //{$0*$1}
        knowOps["√"] = Op.UnaryOperation("√",sqrt)  //{sqrt($0)}
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainIngOps: [Op])  ////返回一个元组型（包含 double型的结果 和数组弄的剩余元素）
    {
        if  !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return(operand, remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand =  operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainIngOps)
                }
            case  .BinaryOperation(_, let operation) :
                let op1Evaluatio = evaluate(remainingOps)
                if let operand1 = op1Evaluatio.result {
                    let op2Evaluatio = evaluate(op1Evaluatio.remainIngOps)
                    if let operand2 = op2Evaluatio.result {
                        return (operation(operand1, operand2), op2Evaluatio.remainIngOps)
                    }
                }
            }
        }
        return (nil, ops)
    }
    
    func evaluate() -> Double? {
        let (result, remainder) = evaluate(opStack)
        print( remainder)
        return result
        
    }
    
    func pushOperan(operand: Double) {
        opStack.append(.Operand(operand))
    }
    
    func perforOperation(symbol: String) {
        if let opration = knowOps[symbol] {
            opStack.append(opration)
        }
    }
}