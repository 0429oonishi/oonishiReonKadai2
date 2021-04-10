//
//  ViewController.swift
//  oonishiReonKadai2
//
//  Created by 大西玲音 on 2021/04/09.
//

import UIKit

private enum Calculation: Int {
    case addition
    case subtraction
    case multiplication
    case division
}

private enum ErrorMessage {
    static let invalidSegment = "予期しないセグメントが選択されました。"
    static let nonNumeric = "数値を入力してください。"
    static let divideBy0 = "割る数には0以外を選択してください。"
}

final class ViewController: UIViewController {
    
    @IBOutlet private weak var firstTextField: UITextField!
    @IBOutlet private weak var secondTextField: UITextField!
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!

    @IBAction private func calculateButtonDidTapped(_ sender: Any) {
        guard
            let firstText = firstTextField.text,
            let firstNum = Double(firstText),
            let secondText = secondTextField.text,
            let secondNum = Double(secondText)
        else {
            resultLabel.text = ErrorMessage.nonNumeric
            return
        }

        guard
            let calculatedNum = calculateNum(firstNum, secondNum)
        else {
            resultLabel.text = ErrorMessage.divideBy0
            return
        }

        resultLabel.text = String(calculatedNum)
    }
    
    private func calculateNum(_ firstNum: Double, _ secondNum: Double) -> Double? {
        guard let calculation = Calculation(rawValue: segmentedControl.selectedSegmentIndex) else {
            fatalError(ErrorMessage.invalidSegment)
        }

        switch calculation {
        case .addition: return firstNum + secondNum
        case .subtraction: return firstNum - secondNum
        case .multiplication: return firstNum * secondNum
        case .division:
            guard !secondNum.isZero else { return nil }
            return firstNum / secondNum
        }
    }
}
