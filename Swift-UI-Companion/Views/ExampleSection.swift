//
//  ExampleSection.swift
//  Swift-UI-Companion
//
//  A rendered usage example: the compiled view above the code it
//  corresponds to. The static counterpart of DemoSection.
//

import SwiftUI

struct ExampleSection: View {
    let entry: ExampleEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Label("Live example", systemImage: "eye")
                .font(.headline)
                .foregroundStyle(.secondary)

            entry.make()
                .frame(maxWidth: .infinity, minHeight: 120)
                .padding(20)
                .background(.quaternary.opacity(0.4))
                .background(.background.secondary)
                .clipShape(.rect(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(.quaternary, lineWidth: 1)
                }

            CodeBlockView(code: entry.code)
        }
    }
}
