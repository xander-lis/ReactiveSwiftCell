//
//  ReactiveTextFieldCell.swift
//  ReactiveSwiftCell
//
//  Created by Aleksandr Lis on 02.05.2020.
//  Copyright © 2020 Aleksandr Lis. All rights reserved.
//

import ReactiveSwift

open class ReactiveTextFieldCell: ReactiveTableViewdCell, KeyReturnable {
    @IBOutlet open weak var textField: UITextField!
    
    override open func setup() {
        textField.delegate = self
        textField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
    }
    
    override open var event: BindingTarget<InputCellEvent> {
        return BindingTarget(lifetime: reactive.lifetime) { [ weak self] (event) in
            guard let self = self else { return }
            switch event {
            case .becomeFirstResponder(let indexPath):
                DispatchQueue.main.async {
                    guard let currnetIndexPath = self.indexPath, currnetIndexPath == indexPath else {
                        self.textField.resignFirstResponder()
                        return
                    }
                    self.textField.becomeFirstResponder()
                }
            default:
                break
            }
        }
    }
    
    open func keyboardReturnAction(type: UIReturnKeyType, indexPath: IndexPath) {
        switch type {
        case .next:
            guard let nextIndexPath = self.nextIndexPathWithInputText(at: indexPath) else {
                self.textField.resignFirstResponder()
                return
            }
            inputCenter.broadcast(event: .becomeFirstResponder(indexPath: nextIndexPath))
        case .default,
             .done:
            self.textField.resignFirstResponder()
        default:
            break
        }
    }
    
    @objc override open func editingChanged(_ sender: Any) {
        guard
            let sender = sender as? UITextField,
            let text = sender.text,
            let indexPath = self.indexPath
        else { return }
        inputCenter.broadcast(event: .updateText(value: text, indexPath: indexPath))
    }
}

//MARK: UITextFieldDelegate
extension ReactiveTextFieldCell: UITextFieldDelegate {
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let indexPath = self.indexPath else { return true }
        keyboardReturnAction(type: textField.returnKeyType, indexPath: indexPath)
        return true
    }

    open func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let indexPath = self.indexPath else { return }
        inputCenter.broadcast(event: .didBeginEditing(indexPath: indexPath))
    }

    open func textFieldDidEndEditing(_ textField: UITextField) {
        guard let indexPath = self.indexPath else { return }
        inputCenter.broadcast(event: .didEndEditing(indexPath: indexPath))
    }
}
