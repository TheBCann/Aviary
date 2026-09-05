//
//  ChildExampleEntry.swift
//  Aviary
//
//  One compiled rendering for a variant (child) entry: a SwiftUI view that
//  demonstrates that specific initializer/overload/member, plus the code the
//  view corresponds to. No project dependencies, so ChildExamples+*.swift
//  files can be type-checked standalone against SwiftUI.
//

import SwiftUI

struct ChildExampleEntry {
    /// Exact parent topic name, e.g. "Text".
    let parent: String
    /// Exact child (variant) name, e.g. "Text(verbatim:)".
    let child: String
    /// The code the rendered view corresponds to.
    let code: String
    /// Builds the rendered example.
    let make: () -> AnyView

    /// Matches TopicChild.id: "<parent> › <child>".
    var id: String { "\(parent) › \(child)" }

    init(parent: String, child: String, code: String, make: @escaping () -> AnyView) {
        self.parent = parent
        self.child = child
        self.code = code
        self.make = make
    }
}
