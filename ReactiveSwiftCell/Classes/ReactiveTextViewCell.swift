//
//  ReactiveTextViewCell.swift
//  ReactiveSwiftCell
//
//  Created by Aleksandr Lis on 03.05.2020.
//  Copyright © 2020 Aleksandr Lis. All rights reserved.
//

import ReactiveSwift

open class ReactiveTextViewCell: ReactiveTableViewdCell, KeyReturnable {
    @IBOutlet open weak var textView: UITextView!
    @IBOutlet open weak var label: UILabel!
    
    open var placeHolder: String? = " " {
        willSet {
            guard let newValue = newValue else { return }
            label.text = !newValue.isEmpty ? newValue : placeHolder
            label.textColor = !textView.text.isEmpty ? .clear : .lightGray
        }
    }
    
    open var syncText: String? {
        willSet {
            textView.text = newValue
            label.text = !textView.text.isEmpty ? newValue : placeHolder
            label.textColor = !textView.text.isEmpty ? .clear : .lightGray
        }
    }
    
    open var textChanged: ((String) -> Void)?
    
    override open func setup() {
        textView.delegate = self
        textView.textContainerInset = UIEdgeInsets.zero
        textView.textContainer.lineFragmentPadding = 0
        label.font = textView.font
        label.textColor = .clear
        label.text = placeHolder
    }
    
    override open var event: BindingTarget<InputCellEvent> {
        return BindingTarget(lifetime: reactive.lifetime) { [ weak self] (event) in
            guard let self = self else { return }
            switch event {
            case .becomeFirstResponder(let indexPath):
                DispatchQueue.main.async {
                    guard let currnetIndexPath = self.indexPath, currnetIndexPath == indexPath else {
                        self.textView.resignFirstResponder()
                        return
                    }
                    self.textView.becomeFirstResponder()
                }
            default:
                break
            }
        }
    }
    
    override open func prepareForReuse() {
        super.prepareForReuse()
        textChanged = nil
    }
    
    open func textChanged(action: @escaping (String) -> Void) {
        self.textChanged = action
    }
    
    func keyboardReturnAction(type: UIReturnKeyType, indexPath: IndexPath) {
        switch type {
        case .next:
            guard let nextIndexPath = self.nextIndexPathWithInputText(at: indexPath) else {
                self.textView.resignFirstResponder()
                return
            }
            inputCenter.broadcast(event: .becomeFirstResponder(indexPath: nextIndexPath))
        case .default,
             .done:
            self.textView.resignFirstResponder()
        default:
            break
        }
    }
}

//MARK: UITextViewDelegate
extension ReactiveTextViewCell: UITextViewDelegate {
    open func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard text == "\n" else { return true }
        guard let indexPath = self.indexPath else { return true }
        keyboardReturnAction(type: textView.returnKeyType, indexPath: indexPath)
        return false
    }
    
    open func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
        guard let text = textView.text, let indexPath = self.indexPath else { return }
        inputCenter.broadcast(event: .updateText(value: text, indexPath: indexPath))
    }
    
    open func textViewDidBeginEditing(_ textView: UITextView) {
        guard let indexPath = self.indexPath else { return }
        inputCenter.broadcast(event: .didBeginEditing(indexPath: indexPath))
    }

    open func textViewDidEndEditing(_ textView: UITextView) {
        guard let indexPath = self.indexPath else { return }
        inputCenter.broadcast(event: .didEndEditing(indexPath: indexPath))
    }
    
    open func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        guard let tableView = superview as? UITableView else { return true }
        let pointInTable:CGPoint = convert(textView.frame.origin, to: tableView)
        var contentOffset:CGPoint = tableView.contentOffset
        contentOffset.y  = pointInTable.y
        if let accessoryView = textView.inputAccessoryView {
            contentOffset.y -= accessoryView.frame.size.height
        }
        tableView.contentOffset = contentOffset
        return true
    }
}
