//
//  ViewController.swift
//  oonishiReonKadai2
//
//  Created by 大西玲音 on 2021/04/09.
//

import UIKit

private enum CalculationResult {
    case success(Double)
    case failure(String)
}

private enum Calculation: Int {
    case addition
    case subtraction
    case multiplication
    case division

    func calculate(_ num1: Double, _ num2: Double) -> CalculationResult {
        switch self {
        case .addition:
            return .success(num1 + num2)
        case .subtraction:
            return .success(num1 - num2)
        case .multiplication:
            return .success(num1 * num2)
        case .division:
            guard num2 != 0 else { return .failure(ErrorMessage.divideBy0) }
            return .success(num1 / num2)
        }
    }
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
        guard let firstNum = firstTextField.text.flatMap({ Double($0) }),
              let secondNum = secondTextField.text.flatMap({ Double($0) }) else {

            resultLabel.text = ErrorMessage.nonNumeric
            return
        }

        switch calculateNum(firstNum, secondNum) {
        case let .success(result):
            resultLabel.text = String(result)
        case let .failure(message):
            resultLabel.text = message
        }
    }
    
    private func calculateNum(_ firstNum: Double, _ secondNum: Double) -> CalculationResult {
        guard let calculation = Calculation(rawValue: segmentedControl.selectedSegmentIndex) else {
            fatalError(ErrorMessage.invalidSegment)
        }

        return calculation.calculate(firstNum, secondNum)
    }
}
