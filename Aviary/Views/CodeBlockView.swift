//
//  CodeBlockView.swift
//  Aviary
//
//  Monospaced code display with lightweight Swift syntax highlighting and a
//  copy-to-clipboard button, so examples paste straight into Xcode.
//

import SwiftUI
import AppKit

struct CodeBlockView: View {
    let code: String
    @State private var justCopied = false

    var body: some View {
        ScrollView(.horizontal) {
            Text(SwiftHighlighter.highlight(code))
                .font(.system(.callout, design: .monospaced))
                .textSelection(.enabled)
                .padding(14)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(.black.opacity(0.04))
        .background(.background.secondary)
        .clipShape(.rect(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(.quaternary, lineWidth: 1)
        }
        .overlay(alignment: .topTrailing) {
            Button {
                copy()
            } label: {
                Label(
                    justCopied ? "Copied" : "Copy",
                    systemImage: justCopied ? "checkmark" : "doc.on.doc"
                )
                .font(.caption)
            }
            .buttonStyle(.bordered)
            .controlSize(.small)
            .padding(8)
        }
    }

    private func copy() {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(code, forType: .string)
        withAnimation { justCopied = true }
        Task {
            try? await Task.sleep(for: .seconds(1.5))
            withAnimation { justCopied = false }
        }
    }
}

/// Regex-based highlighter — deliberately simple, tuned for short examples.
enum SwiftHighlighter {
    private static let keywords: Set<String> = [
        "struct", "class", "enum", "protocol", "extension", "func", "var",
        "let", "if", "else", "guard", "return", "switch", "case", "default",
        "for", "in", "while", "import", "static", "private", "public",
        "some", "any", "self", "Self", "true", "false", "nil", "await",
        "async", "try", "throws", "init", "get", "set", "inout", "where",
    ]

    static func highlight(_ code: String) -> AttributedString {
        var result = AttributedString(code)
        result.foregroundColor = .primary

        // Order matters: later passes skip ranges already claimed.
        var claimed: [Range<AttributedString.Index>] = []

        applyPattern(#"//[^\n]*"#, color: Color(.systemGray), to: &result, claimed: &claimed)
        applyPattern(#""[^"\n]*""#, color: Color(.systemRed), to: &result, claimed: &claimed)
        applyPattern(#"(?<=[\s(\[{,:])\.[a-zA-Z][a-zA-Z0-9]*"#, color: Color(.systemPurple), to: &result, claimed: &claimed)
        applyPattern(#"@[A-Za-z][A-Za-z0-9]*"#, color: Color(.systemOrange), to: &result, claimed: &claimed)
        applyPattern(#"\b[0-9]+(\.[0-9]+)?\b"#, color: Color(.systemBlue), to: &result, claimed: &claimed)
        applyPattern(#"\b[A-Z][A-Za-z0-9]*\b"#, color: Color(.systemTeal), to: &result, claimed: &claimed)
        applyPattern(
            #"\b(\#(keywords.joined(separator: "|")))\b"#,
            color: Color(.systemPink),
            to: &result,
            claimed: &claimed
        )

        return result
    }

    private static func applyPattern(
        _ pattern: String,
        color: Color,
        to attributed: inout AttributedString,
        claimed: inout [Range<AttributedString.Index>]
    ) {
        let text = String(attributed.characters)
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return }
        let fullRange = NSRange(text.startIndex..., in: text)

        for match in regex.matches(in: text, range: fullRange) {
            guard
                let stringRange = Range(match.range, in: text),
                let range = Range(stringRange, in: attributed)
            else { continue }
            guard !claimed.contains(where: { $0.overlaps(range) }) else { continue }
            attributed[range].foregroundColor = color
            claimed.append(range)
        }
    }
}
