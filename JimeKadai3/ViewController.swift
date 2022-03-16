//
//  ViewController.swift
//  JimeKadai3
//
//  Created by kitano hajime on 2022/03/11.
//

import UIKit
import Combine
import CombineCocoa

class ViewController: UIViewController {
    private var subscriptions = Set<AnyCancellable>()

    @IBOutlet weak private var leftTextField: UITextField!
    @IBOutlet weak private var leftSwitch: UISwitch!
    @IBOutlet weak private var leftLabel: UILabel!
    @IBOutlet weak private var rightTextField: UITextField!
    @IBOutlet weak private var rightSwtich: UISwitch!
    @IBOutlet weak private var rightLabel: UILabel!
    @IBOutlet weak private var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSwitch()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTapView))
        view.addGestureRecognizer(tapGesture)
    }

    private func configureSwitch() {
        leftSwitch.isOn = false
        rightSwtich.isOn = false
    }

    @IBAction private func calcurateButton(_ sender: Any) {
        guard let leftNum = leftTextField.text.flatMap({ Double($0) }),
        let rightNum = rightTextField.text.flatMap({ Double($0)}) else {
            resultLabel.text = "入力が無効です"
            return
        }
        let leftNumWithSign = leftSwitch.isOn ? -leftNum : leftNum
        let rightNumWithSign = rightSwtich.isOn ? -rightNum : rightNum
        resultLabel.text = "\(leftNumWithSign + rightNumWithSign)"
    }

    @objc private func didTapView() {
        view.endEditing(true)
    }
}
