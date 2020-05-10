//
//  ViewController.swift
//  ReactiveSwiftCell
//
//  Created by Aleksandr Lis on 05/11/2020.
//  Copyright (c) 2020 Aleksandr Lis. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveSwiftCell

class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var (lifetime, token) = Lifetime.make()
    
    private var notificationCenter: NotificationCenter {
        return NotificationCenter.default
    }
    
    private enum SectionType: Int, CaseIterable {
        case textView
        case segmentControl
        case `switch`
        case slider
        case stepper
        case button
        case textField
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        subscribeToKeyboardNotifications()
    }
    
    deinit {
        unsubscribeFromKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        addTap()
        bind()
    }

    private func setupTableView() {
        tableView.tableFooterView = UIView()
        
        tableView.register(UINib(nibName: String(describing: TextViewCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: TextViewCell.self))
        tableView.register(UINib(nibName: String(describing: SegmentControlCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: SegmentControlCell.self))
        tableView.register(UINib(nibName: String(describing: SwithCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: SwithCell.self))
        tableView.register(UINib(nibName: String(describing: SliderCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: SliderCell.self))
        tableView.register(UINib(nibName: String(describing: StepperCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: StepperCell.self))
        tableView.register(UINib(nibName: String(describing: ButtonCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: ButtonCell.self))
        tableView.register(UINib(nibName: String(describing: TextFieldCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: TextFieldCell.self))
    }

    private func bind() {
        inputCellEvent <~ InputCellCenter.shared.event
    }
}

//MARK: Reactive
private extension ViewController {
    var inputCellEvent: BindingTarget<InputCellEvent> {
        return BindingTarget(lifetime: lifetime) { (event) in
            switch event {
            case .updateText(let value, let indexPath):
                print("Text value = \(value) at = \(indexPath)")
            case .updateSelectedIndex(let value, let indexPath):
                print("Selected index value = \(value) at = \(indexPath)")
            case .updateSwitch(let value, let indexPath):
                print("Switch value = \(value) at = \(indexPath)")
            case .updateSlider(let value, let indexPath):
                print("Slider value = \(value) at = \(indexPath)")
            case .updateStepper(let value, let indexPath):
                print("Stepper value = \(value) at = \(indexPath)")
            case .action(let indexPath):
                print("Action at \(indexPath)")
            case .didBeginEditing(let indexPath):
                print("Begin editing = \(indexPath)")
            case .didEndEditing(let indexPath):
                print("End editing = \(indexPath)")
            default:
                break
            }
        }
    }
}

//MARK: Private
private extension ViewController {
    func subscribeToKeyboardNotifications() {
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillMove(_:)),
                                       name: .UIKeyboardWillShow,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillMove(_:)),
                                       name: .UIKeyboardWillHide,
                                       object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        notificationCenter.removeObserver(self,
                                          name: .UIKeyboardWillShow,
                                          object: nil)
        notificationCenter.removeObserver(self,
                                          name: .UIKeyboardWillHide,
                                          object: nil)
    }
    
    func addTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        tapGesture.cancelsTouchesInView = false
        tableView?.addGestureRecognizer(tapGesture)
    }
}

//MARK: Actions
private extension ViewController {
    @objc func keyboardWillMove(_ notification: Notification) {
        if notification.name == .UIKeyboardWillShow {
            if let userInfo = notification.userInfo {
                let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
                
                var bottomPadding: CGFloat = 0
                if #available(iOS 11.0, *) {
                    bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
                }
                
                tableView.contentInset.bottom = keyboardFrame.height - bottomPadding
            }
        }
        if notification.name == .UIKeyboardWillHide {
            tableView.contentInset = .zero
        }
    }
    
    @objc func viewTapped() {
        tableView.endEditing(true)
    }
}

//MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = SectionType(rawValue: section) else { fatalError() }
        switch sectionType {
        case .textView,
             .segmentControl,
             .switch,
             .slider,
             .stepper,
             .button:
            return 1
        case .textField:
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = SectionType(rawValue: indexPath.section) else { fatalError() }
        switch sectionType {
        case .textView:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TextViewCell.self), for: indexPath) as! TextViewCell
            cell.model = TextViewCell.Model(value: "", indexPath: indexPath)
            cell.textChanged { [weak tableView] newText in
                cell.syncText = newText
                DispatchQueue.main.async {
                    tableView?.beginUpdates()
                    tableView?.endUpdates()
                }
            }
            return cell
        case .segmentControl:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SegmentControlCell.self), for: indexPath) as! SegmentControlCell
            cell.model = SegmentControlCell.Model(value: Int.random(in: 0...2), indexPath: indexPath)
            return cell
        case .switch:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SwithCell.self), for: indexPath) as! SwithCell
            cell.model = SwithCell.Model(value: Bool.random(), indexPath: indexPath)
            return cell
        case .slider:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SliderCell.self), for: indexPath) as! SliderCell
            cell.model = SliderCell.Model(value: Float.random(in: 0...100), indexPath: indexPath)
            return cell
        case .stepper:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: StepperCell.self), for: indexPath) as! StepperCell
            cell.model = StepperCell.Model(value: Double.random(in: 0...100), indexPath: indexPath)
            return cell
        case .button:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ButtonCell.self), for: indexPath) as! ButtonCell
            cell.model = ButtonCell.Model(indexPath: indexPath)
            return cell
        case .textField:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TextFieldCell.self), for: indexPath) as! TextFieldCell
            cell.model = TextFieldCell.Model(value: "", indexPath: indexPath)
            return cell
        }
    }
}

