//
//  DemoSection.swift
//  Swift-UI-Companion
//
//  Shared chrome for interactive demos: a live preview, the controls that
//  drive it, and the generated code — which always matches the controls.
//

import SwiftUI

struct DemoSection<Preview: View, Controls: View>: View {
    let liveCode: String
    @ViewBuilder var preview: Preview
    @ViewBuilder var controls: Controls

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Label("Interactive example", systemImage: "wand.and.stars")
                .font(.headline)
                .foregroundStyle(.secondary)

            VStack(spacing: 0) {
                preview
                    .frame(maxWidth: .infinity, minHeight: 150)
                    .padding(20)
                    .background(
                        LinearGradient(
                            colors: [Theme.accent.opacity(0.07), .clear],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .background(.quaternary.opacity(0.25))

                Divider()

                controls
                    .padding(14)
            }
            .background(.background.secondary)
            .clipShape(.rect(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(.quaternary, lineWidth: 1)
            }

            CodeBlockView(code: liveCode)
        }
    }
}

/// A labeled row used inside demo control panels.
struct DemoControlRow<Content: View>: View {
    let label: String
    @ViewBuilder var content: Content

    var body: some View {
        HStack(spacing: 12) {
            Text(label)
                .font(.callout)
                .foregroundStyle(.secondary)
                .frame(width: 90, alignment: .trailing)
            content
            Spacer(minLength: 0)
        }
    }
}
