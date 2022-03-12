//
//  ViewController.swift
//  JimeKadai3
//
//  Created by kitano hajime on 2022/03/11.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet private weak var leftTextField: UITextField!
    @IBOutlet private weak var rightTextField: UITextField!
    @IBOutlet private weak var leftInputLabel: UILabel!
    @IBOutlet private weak var rightInputLabel: UILabel!
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var leftSwitch: UISwitch!
    @IBOutlet private weak var rightSwtich: UISwitch!

    private var leftValue: Int = 0
    private var rightValue: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        leftSwitch.isOn = false
        rightSwtich.isOn = false
        leftTextField.addTarget(self, action: #selector(leftTextFieldDidChange), for: .editingChanged)
        rightTextField.addTarget(self, action: #selector(rightTextFieldDidChange), for: .editingChanged)
    }

    @objc func leftTextFieldDidChange(textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        leftInputLabel.text = text
        leftValue = Int(text) ?? 0
    }
    @objc func textFieldDidChange(textField: UITextField, label: UILabel, value: Int) {
        guard let text = textField.text else {
            return
        }
        var value = value
        leftInputLabel.text = text
        value = Int(text) ?? 0
    }



    @objc func rightTextFieldDidChange(textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        rightInputLabel.text = text
        rightValue = Int(text) ?? 0
    }

    @IBAction func leftSwitchToggle(_ sender: UISwitch) {
        leftValue = sender.isOn ? leftValue * -1 : abs(leftValue)
        leftInputLabel.text = "\(leftValue)"
    }

    @IBAction func rightSwitchToggle(_ sender: UISwitch) {
        rightValue = sender.isOn ? rightValue * -1 : abs(rightValue)
        rightInputLabel.text = "\(rightValue)"
    }

    @IBAction func calcurateButtonTapped(_ sender: UIButton) {
        let result = rightValue + leftValue
        resultLabel.text = "\(result)"
    }
}

