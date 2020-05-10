//
//  InputCellCenter.swift
//  ReactiveSwiftCell
//
//  Created by Aleksandr Lis on 02.05.2020.
//  Copyright © 2020 Aleksandr Lis. All rights reserved.
//

import ReactiveSwift
import Result

public enum InputCellEvent {
    case becomeFirstResponder(indexPath: IndexPath)
    case didBeginEditing(indexPath: IndexPath)
    case didEndEditing(indexPath: IndexPath)
    case updateText(value: String, indexPath: IndexPath)
    case updateSwitch(value: Bool, indexPath: IndexPath)
    case updateSlider(value: Float, indexPath: IndexPath)
    case updateStepper(value: Double, indexPath: IndexPath)
    case updateSelectedIndex(value: Int, indexPath: IndexPath)
    case action(indexPath: IndexPath)
}

public typealias InputCellEventSignal = Signal<InputCellEvent, NoError>
public typealias InputCenter = UpdateCenterObserving & UpdateCenterBroadcasting

public protocol UpdateCenterObserving {
    var event: InputCellEventSignal { get }
}

public protocol UpdateCenterBroadcasting {
    func broadcast(event: InputCellEvent)
}

public class InputCellCenter: InputCenter {
    static public var shared = InputCellCenter()
    
    /// A Signal push-driven stream that sends Events over time
    public let event: InputCellEventSignal
    /// An Observer is a simple wrapper around a function which can receive Events (typically from a Signal)
    private let eventObserver: InputCellEventSignal.Observer
    
    private init() {
        (event, eventObserver) = Signal.pipe()
    }
    
    /// Send events for all subscribers
    public func broadcast(event: InputCellEvent) {
        eventObserver.send(value: event)
    }
}
