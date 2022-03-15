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
    @IBOutlet weak private var calcuratorButton: UIButton!
    @IBOutlet weak private var resultLabel: UILabel!

    private var leftNumberSubject = CurrentValueSubject<Int, Never>(0)
    private var leftSwitchSubject = CurrentValueSubject<Bool, Never>(false)
    private var leftNumberPublisher: AnyPublisher<Int, Never> {
        leftNumberSubject.combineLatest(leftSwitchSubject)
            .map { value, isOn in isOn ? value * -1 : abs(value) }
            .eraseToAnyPublisher()
    }

    private var rightNumberSubject = CurrentValueSubject<Int, Never>(0)
    private var rightSwitchSubject = CurrentValueSubject<Bool, Never>(false)
    private var rigthtNumberPublisher: AnyPublisher<Int, Never> {
        rightNumberSubject.combineLatest(rightSwitchSubject)
            .map { value, isOn in isOn ? value * -1 : abs(value) }
            .eraseToAnyPublisher()
    }

    private var resultPublisher: AnyPublisher<String, Never> {
        leftNumberPublisher.combineLatest(rigthtNumberPublisher)
            .map { String($0 + $1) }
            .eraseToAnyPublisher()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSwitch()
        // MARK: - Left
        leftTextField.textPublisher.map { Int($0 ?? "") ?? 0 }
        .sink { self.leftNumberSubject.send($0) }
        .store(in: &subscriptions)

        leftSwitch.isOnPublisher.sink { self.leftSwitchSubject.send($0) }
        .store(in: &subscriptions)

        leftNumberPublisher.map { String($0) }
        .assign(to: \.text, on: leftLabel).store(in: &subscriptions)

        // MARK: - Right
        rightTextField.textPublisher.map { Int($0 ?? "") ?? 0 }
        .sink { self.rightNumberSubject.send($0) }
        .store(in: &subscriptions)

        rightSwtich.isOnPublisher.sink { self.rightSwitchSubject.send($0) }
        .store(in: &subscriptions)

        rigthtNumberPublisher.compactMap { String($0) }
        .assign(to: \.text, on: rightLabel)
        .store(in: &subscriptions)

        // MARK: - Button

        // Ref: ios - Swift Combine operator with same functionality like `withLatestFrom` in the RxSwift Framework - Stack Overflow
        // https://stackoverflow.com/questions/61959647/swift-combine-operator-with-same-functionality-like-withlatestfrom-in-the-rxsw

        calcuratorButton.tapPublisher.map { _ in Date() }.combineLatest(resultPublisher)
            .removeDuplicates(by: { $0.0 == $1.0 })
            .map { $0.1 }
            .assign(to: \.text, on: resultLabel)
            .store(in: &subscriptions)
    }

    private func configureSwitch() {
        leftSwitch.isOn = false
        rightSwtich.isOn = false
    }
}
