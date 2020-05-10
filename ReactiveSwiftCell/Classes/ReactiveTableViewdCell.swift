//
//  ReactiveTableViewdCell.swift
//  ReactiveSwiftCell
//
//  Created by Aleksandr Lis on 02.05.2020.
//  Copyright © 2020 Aleksandr Lis. All rights reserved.
//

import ReactiveSwift

/// Use this protocol for cells wich are contains UITextField or UITextView, for handle keyboard return key
protocol KeyReturnable {
    /// Handle keyboard return key
    ///
    /// ````
    /// switch type {
    /// case .continue:
    ///    break
    /// case .default:
    ///    break
    /// case .done:
    ///    break
    /// case .emergencyCall:
    ///    break
    /// case .go:
    ///    break
    /// case .google:
    ///    break
    /// case .join:
    ///    break
    /// case .next:
    ///    break
    /// case .route:
    ///    break
    /// case .search:
    ///    break
    /// case .send:
    ///    break
    /// case .yahoo:
    ///    break
    /// }
    /// ````
    func keyboardReturnAction(type: UIReturnKeyType, indexPath: IndexPath)
}

public typealias Reactive = (lifetime: Lifetime, token: Lifetime.Token)

protocol ReactiveCell {
    /// Represents the lifetime of an object, and provides a hook to observe when the object deinitializes.
    var reactive: Reactive { get }
    
    var inputCenter: InputCenter { get }
    
    var indexPath: IndexPath? { get set }
    
    /// Setup cell
    ///
    /// If you inherit from ReactiveTableViewdCell just override to setup your cell
    func setup()
    
    /// Func for binding events
    ///
    /// A binding target that can be used with the `<~` operator.
    ///
    /// ````
    /// event <~ InputCellCenter.shared.event
    /// ````
    func bind()
    
    /// Event
    ///
    /// Handle evens in BindingTarget
    ///
    /// ````
    /// BindingTarget(lifetime: reactive.lifetime) { [ weak self] (event) in
    ///     switch event {
    ///     default:
    ///        break
    ///     }
    /// }
    /// ````
    var event: BindingTarget<InputCellEvent> { get }
}

/// Main cell class with reactive extentions
///
/// You can inherit from this class & just override func setup & var even
///
/// You also can create your own custom cell. You should implement protocol ReactiveCell
open class ReactiveTableViewdCell: UITableViewCell, ReactiveCell {
    open var reactive: Reactive = Lifetime.make()
    
    open var inputCenter: InputCenter = InputCellCenter.shared
    
    open var indexPath: IndexPath?
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        setup()
        bind()
    }
    
    open func setup() { }
    
    open func bind() {
        event <~ inputCenter.event
    }
    
    open var event: BindingTarget<InputCellEvent> {
        return BindingTarget(lifetime: reactive.lifetime) { _ in }
    }
    
    @IBAction open func didEndOnExit(_ sender: Any) { }
    
    @IBAction open func editingChanged(_ sender: Any) { }
    
    @IBAction open func editingDidBegin(_ sender: Any) { }
    
    @IBAction open func editingDidEnd(_ sender: Any) { }
    
    @IBAction open func primaryActionTriggered(_ sender: Any) { }
    
    @IBAction open func touchCancel(_ sender: Any) { }
    
    @IBAction open func touchDown(_ sender: Any) { }
    
    @IBAction open func touchDownRepeat(_ sender: Any) { }
    
    @IBAction open func touchDragEnter(_ sender: Any) { }
    
    @IBAction open func touchDragExit(_ sender: Any) { }
    
    @IBAction open func touchDragInside(_ sender: Any) { }
    
    @IBAction open func touchDragOutside(_ sender: Any) { }
    
    @IBAction open func touchUpInside(_ sender: Any) { }
    
    @IBAction open func touchUpOutside(_ sender: Any) { }
    
    @IBAction open func valueChanged(_ sender: Any) { }
}
