//
//  ExampleEntry.swift
//  Swift-UI-Companion
//
//  One rendered usage example for a catalog topic: a compiled SwiftUI view
//  that shows the API in use, plus the code that view corresponds to.
//  This file has no project dependencies so example files can be
//  type-checked standalone against SwiftUI.
//

import SwiftUI

struct ExampleEntry {
    /// The catalog topic name this example belongs to (exact match).
    let topic: String
    /// The code the rendered view corresponds to.
    let code: String
    /// Builds the rendered example.
    let make: () -> AnyView

    init(topic: String, code: String, make: @escaping () -> AnyView) {
        self.topic = topic
        self.code = code
        self.make = make
    }
}
