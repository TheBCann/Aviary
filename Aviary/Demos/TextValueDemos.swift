//
//  TextValueDemos.swift
//  Aviary
//
//  Interactive demos for Text, Slider, and ProgressView.
//

import SwiftUI

// MARK: - Text

struct TextDemo: View {
    private enum StyleChoice: String, CaseIterable, Identifiable {
        case largeTitle, title, headline, body, caption
        var id: String { rawValue }

        var textStyle: Font.TextStyle {
            switch self {
            case .largeTitle: .largeTitle
            case .title: .title
            case .headline: .headline
            case .body: .body
            case .caption: .caption
            }
        }
    }

    private enum DesignChoice: String, CaseIterable, Identifiable {
        case `default`, rounded, serif, monospaced
        var id: String { rawValue }

        var design: Font.Design {
            switch self {
            case .default: .default
            case .rounded: .rounded
            case .serif: .serif
            case .monospaced: .monospaced
            }
        }
    }

    @State private var style = StyleChoice.title
    @State private var design = DesignChoice.default
    @State private var isBold = false
    @State private var isItalic = false

    private var liveCode: String {
        var lines = ["Text(\"The quick brown fox\")"]
        lines.append("    .font(.system(.\(style.rawValue), design: .\(design.rawValue)))")
        if isBold { lines.append("    .bold()") }
        if isItalic { lines.append("    .italic()") }
        return lines.joined(separator: "\n")
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            Text("The quick brown fox")
                .font(.system(style.textStyle, design: design.design))
                .bold(isBold)
                .italic(isItalic)
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "Text style") {
                    Picker("", selection: $style) {
                        ForEach(StyleChoice.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .labelsHidden()
                    .fixedSize()
                }
                DemoControlRow(label: "Design") {
                    Picker("", selection: $design) {
                        ForEach(DesignChoice.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .fixedSize()
                }
                DemoControlRow(label: "Weight") {
                    Toggle("Bold", isOn: $isBold)
                    Toggle("Italic", isOn: $isItalic)
                }
            }
        }
    }
}

// MARK: - Slider

struct SliderDemo: View {
    @State private var value = 0.5
    @State private var step = 0.0

    private var liveCode: String {
        if step > 0 {
            """
            Slider(value: $value, in: 0...1, step: \(codeNumber(step)))
            // value == \(codeNumber(value))
            """
        } else {
            """
            Slider(value: $value, in: 0...1)
            // value == \(codeNumber(value))
            """
        }
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            VStack(spacing: 12) {
                if step > 0 {
                    Slider(value: $value, in: 0...1, step: step) {
                        Text("Value")
                    } minimumValueLabel: {
                        Image(systemName: "tortoise")
                    } maximumValueLabel: {
                        Image(systemName: "hare")
                    }
                } else {
                    Slider(value: $value, in: 0...1) {
                        Text("Value")
                    } minimumValueLabel: {
                        Image(systemName: "tortoise")
                    } maximumValueLabel: {
                        Image(systemName: "hare")
                    }
                }
                Gauge(value: value) { EmptyView() }
                    .gaugeStyle(.accessoryLinearCapacity)
                    .tint(.blue)
            }
            .frame(maxWidth: 320)
        } controls: {
            DemoControlRow(label: "Step") {
                Picker("", selection: $step) {
                    Text("continuous").tag(0.0)
                    Text("0.1").tag(0.1)
                    Text("0.25").tag(0.25)
                }
                .pickerStyle(.segmented)
                .labelsHidden()
                .fixedSize()
            }
        }
    }
}

// MARK: - ProgressView

struct ProgressDemo: View {
    @State private var isCircular = false
    @State private var isIndeterminate = false
    @State private var progress = 0.6

    private var liveCode: String {
        let style = isCircular ? "circular" : "linear"
        if isIndeterminate {
            return """
            ProgressView("Working…")
                .progressViewStyle(.\(style))
            """
        }
        return """
        ProgressView("Working…", value: \(codeNumber(progress)), total: 1.0)
            .progressViewStyle(.\(style))
        """
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            Group {
                if isIndeterminate {
                    ProgressView("Working…")
                } else {
                    ProgressView("Working…", value: progress, total: 1.0)
                }
            }
            .progressViewStyle(progressStyle)
            .frame(maxWidth: 280)
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "Style") {
                    Picker("", selection: $isCircular) {
                        Text("linear").tag(false)
                        Text("circular").tag(true)
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .fixedSize()
                }
                DemoControlRow(label: "Mode") {
                    Toggle("Indeterminate", isOn: $isIndeterminate)
                }
                if !isIndeterminate {
                    DemoControlRow(label: "Progress") {
                        Slider(value: $progress, in: 0...1)
                            .frame(maxWidth: 200)
                    }
                }
            }
        }
    }

    private var progressStyle: AnyProgressViewStyle {
        isCircular
            ? AnyProgressViewStyle(.circular)
            : AnyProgressViewStyle(.linear)
    }
}

/// Type-erasing wrapper so the demo can switch styles at runtime.
struct AnyProgressViewStyle: ProgressViewStyle {
    private let make: (Configuration) -> AnyView

    init(_ style: some ProgressViewStyle) {
        make = { AnyView(style.makeBody(configuration: $0)) }
    }

    func makeBody(configuration: Configuration) -> some View {
        make(configuration)
    }
}
