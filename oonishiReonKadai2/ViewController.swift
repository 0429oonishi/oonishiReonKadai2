//
//  ViewController.swift
//  oonishiReonKadai2
//
//  Created by 大西玲音 on 2021/04/09.
//

import UIKit

enum Calculation: Int {
    case addition
    case subtraction
    case multiplication
    case division
}

enum ErrorType {
    case invalidSegment
    case nonNumeric
    case divideBy0
    var text: String {
        switch self {
        case .invalidSegment: return "予期しないセグメントが選択されました。"
        case .nonNumeric: return "数値を入力してください。"
        case .divideBy0: return "割る数には0以外を選択してください。"
        }
    }
}

final class ViewController: UIViewController {
    
    @IBOutlet private weak var firstTextField: UITextField!
    @IBOutlet private weak var secondTextField: UITextField!
    @IBOutlet private weak var resultLabel: UILabel!
    private var calculation: Calculation = .addition
    
    @IBAction private func segmentedControlDidTapped(_ sender: UISegmentedControl) {
        if let calculation = Calculation(rawValue: sender.selectedSegmentIndex) {
            self.calculation = calculation
        } else {
            fatalError(ErrorType.invalidSegment.text)
        }
    }
    
    @IBAction private func calculateButtonDidTapped(_ sender: Any) {
        guard
            let firstText = firstTextField.text,
            let firstNum = Double(firstText),
            let secondText = secondTextField.text,
            let secondNum = Double(secondText)
        else {
            resultLabel.text = ErrorType.nonNumeric.text
            return
        }
        guard
            let calculatedNum = calculateNum(firstNum, secondNum)
        else {
            resultLabel.text = ErrorType.divideBy0.text
            return
        }
        resultLabel.text = String(calculatedNum)
    }
    
    private func calculateNum(_ firstNum: Double, _ secondNum: Double) -> Double? {
        switch calculation {
        case .addition: return firstNum + secondNum
        case .subtraction: return firstNum - secondNum
        case .multiplication: return firstNum * secondNum
        case .division:
            if secondNum.isZero {
                return nil
            } else {
                return firstNum / secondNum
            }
        }
    }
    
}


