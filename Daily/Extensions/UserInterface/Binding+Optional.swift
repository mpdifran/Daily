//
//  Binding+Optional.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import SwiftUI

extension Binding {

    init(_ source: Binding<Value?>, _ defaultValue: Value) {
        // Ensure a non-nil value in `source`.
        if source.wrappedValue == nil {
            source.wrappedValue = defaultValue
        }
        // Unsafe unwrap because *we* know it's non-nil now.
        self.init(source)!
    }

    init<T>(isNotNil source: Binding<T?>, defaultValue: T? = nil) where Value == Bool {
        self.init(get: { source.wrappedValue != nil },
                  set: { source.wrappedValue = $0 ? defaultValue : nil })
    }

    init?<U>(source: Binding<U>, convertedType: Value) {
        guard source.wrappedValue is Value else { return nil }

        self.init(get: { source.wrappedValue as! Value },
                  set: { source.wrappedValue = $0 as! U })
    }
}

extension Binding where Value: Equatable {

    init(_ source: Binding<Value?>, replacingNilWith nilValue: Value) {
        self.init(
            get: { source.wrappedValue ?? nilValue },
            set: { (newValue) in
                if newValue == nilValue {
                    source.wrappedValue = nil
                }
                else {
                    source.wrappedValue = newValue
                }
        })
    }
}
