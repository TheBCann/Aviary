//
//  CodeBlockView.swift
//  Swift-UI-Companion
//
//  Monospaced code display with lightweight Swift syntax highlighting and a
//  copy-to-clipboard button, so examples paste straight into Xcode. The
//  panel renders dark in both appearances, like an embedded editor.
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
        .background(Theme.Code.background)
        .clipShape(.rect(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(Theme.Code.border, lineWidth: 1)
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
                .foregroundStyle(justCopied ? Theme.availableTint : .white.opacity(0.75))
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(.white.opacity(0.1), in: .rect(cornerRadius: 6))
            }
            .buttonStyle(.plain)
            .padding(8)
        }
        .environment(\.colorScheme, .dark)
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
        result.foregroundColor = Theme.Code.plain

        // Order matters: later passes skip ranges already claimed.
        var claimed: [Range<AttributedString.Index>] = []

        applyPattern(#"//[^\n]*"#, color: Theme.Code.comment, to: &result, claimed: &claimed)
        applyPattern(#""[^"\n]*""#, color: Theme.Code.string, to: &result, claimed: &claimed)
        applyPattern(#"(?<=[\s(\[{,:])\.[a-zA-Z][a-zA-Z0-9]*"#, color: Theme.Code.dotAccess, to: &result, claimed: &claimed)
        applyPattern(#"@[A-Za-z][A-Za-z0-9]*"#, color: Theme.Code.attribute, to: &result, claimed: &claimed)
        applyPattern(#"\b[0-9]+(\.[0-9]+)?\b"#, color: Theme.Code.number, to: &result, claimed: &claimed)
        applyPattern(#"\b[A-Z][A-Za-z0-9]*\b"#, color: Theme.Code.type, to: &result, claimed: &claimed)
        applyPattern(
            #"\b(\#(keywords.joined(separator: "|")))\b"#,
            color: Theme.Code.keyword,
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
