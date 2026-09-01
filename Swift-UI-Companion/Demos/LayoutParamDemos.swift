//
//  LayoutParamDemos.swift
//  Swift-UI-Companion
//
//  Interactive demos for layout parameters: padding, frame,
//  LazyVGrid adaptive columns, and Grid spacing/alignment.
//

import SwiftUI

// MARK: - Padding

struct PaddingDemo: View {
    private enum EdgeChoice: String, CaseIterable, Identifiable {
        case all, horizontal, vertical, leading, top
        var id: String { rawValue }

        var edges: Edge.Set {
            switch self {
            case .all: .all
            case .horizontal: .horizontal
            case .vertical: .vertical
            case .leading: .leading
            case .top: .top
            }
        }
    }

    @State private var edge = EdgeChoice.horizontal
    @State private var length: Double = 20

    private var liveCode: String {
        let amount = codeNumber(length, decimals: 0)
        let call = edge == .all
            ? ".padding(\(amount))"
            : ".padding(.\(edge.rawValue), \(amount))"
        return """
        Text("Padded content")
            \(call)
        """
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            VStack(spacing: 12) {
                Text("Padded content")
                    .border(.blue.opacity(0.7))
                    .padding(edge.edges, CGFloat(length))
                    .background(.blue.opacity(0.12))
                    .overlay {
                        Rectangle()
                            .strokeBorder(
                                .secondary,
                                style: StrokeStyle(lineWidth: 1, dash: [4, 4])
                            )
                    }
                Text("Solid line: the text's own bounds. Dashed line: after padding.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "Edges") {
                    Picker("", selection: $edge) {
                        ForEach(EdgeChoice.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .fixedSize()
                }
                DemoControlRow(label: "Length") {
                    Slider(value: $length, in: 0...40, step: 1)
                        .frame(maxWidth: 220)
                    Text(codeNumber(length, decimals: 0))
                        .font(.caption.monospacedDigit())
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

// MARK: - Frame

struct FrameDemo: View {
    private enum AlignChoice: String, CaseIterable, Identifiable {
        case leading, center, trailing
        var id: String { rawValue }

        var alignment: Alignment {
            switch self {
            case .leading: .leading
            case .center: .center
            case .trailing: .trailing
            }
        }
    }

    @State private var width: Double = 180
    @State private var height: Double = 80
    @State private var align = AlignChoice.center
    @State private var useMaxWidth = false

    private var liveCode: String {
        let h = codeNumber(height, decimals: 0)
        let frameCall = useMaxWidth
            ? ".frame(maxWidth: .infinity, minHeight: \(h), alignment: .\(align.rawValue))"
            : ".frame(width: \(codeNumber(width, decimals: 0)), height: \(h), alignment: .\(align.rawValue))"
        return """
        RoundedRectangle(cornerRadius: 8)
            .fill(.blue)
            .frame(width: 56, height: 32)  // the content itself
            \(frameCall)
        """
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            VStack(spacing: 12) {
                framedContent
                    .overlay {
                        RoundedRectangle(cornerRadius: 6)
                            .strokeBorder(
                                .secondary,
                                style: StrokeStyle(lineWidth: 1, dash: [5, 4])
                            )
                    }
                Text("Dashed line: the frame's bounds. The blue shape keeps its own fixed size inside it.")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "Width") {
                    Slider(value: $width, in: 40...280, step: 1)
                        .frame(maxWidth: 220)
                        .disabled(useMaxWidth)
                    Text(codeNumber(width, decimals: 0))
                        .font(.caption.monospacedDigit())
                        .foregroundStyle(.secondary)
                }
                DemoControlRow(label: "Height") {
                    Slider(value: $height, in: 30...140, step: 1)
                        .frame(maxWidth: 220)
                    Text(codeNumber(height, decimals: 0))
                        .font(.caption.monospacedDigit())
                        .foregroundStyle(.secondary)
                }
                DemoControlRow(label: "Alignment") {
                    Picker("", selection: $align) {
                        ForEach(AlignChoice.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .fixedSize()
                }
                DemoControlRow(label: "Max width") {
                    Toggle("maxWidth: .infinity", isOn: $useMaxWidth)
                }
            }
        }
    }

    @ViewBuilder
    private var framedContent: some View {
        let content = RoundedRectangle(cornerRadius: 8)
            .fill(.blue)
            .frame(width: 56, height: 32)
        if useMaxWidth {
            content.frame(
                maxWidth: .infinity,
                minHeight: CGFloat(height),
                alignment: align.alignment
            )
        } else {
            content.frame(
                width: CGFloat(width),
                height: CGFloat(height),
                alignment: align.alignment
            )
        }
    }
}

// MARK: - LazyVGrid

struct LazyGridDemo: View {
    @State private var minimum: Double = 70
    @State private var spacing: Double = 8

    private let colors: [Color] = [.blue, .teal, .indigo, .purple, .cyan, .mint]

    private var liveCode: String {
        let min = codeNumber(minimum, decimals: 0)
        let gap = codeNumber(spacing, decimals: 0)
        return """
        let colors: [Color] = [.blue, .teal, .indigo, .purple, .cyan, .mint]
        let columns = [
            GridItem(.adaptive(minimum: \(min)), spacing: \(gap))
        ]

        ScrollView {
            LazyVGrid(columns: columns, spacing: \(gap)) {
                ForEach(0..<24, id: \\.self) { index in
                    RoundedRectangle(cornerRadius: 8)
                        .fill(colors[index % colors.count])
                        .aspectRatio(1, contentMode: .fit)
                }
            }
        }
        """
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            ScrollView {
                LazyVGrid(
                    columns: [
                        GridItem(
                            .adaptive(minimum: CGFloat(minimum)),
                            spacing: CGFloat(spacing)
                        )
                    ],
                    spacing: CGFloat(spacing)
                ) {
                    ForEach(0..<24, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(colors[index % colors.count])
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
                .padding(4)
            }
            .frame(height: 200)
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "Minimum") {
                    Slider(value: $minimum, in: 40...120, step: 1)
                        .frame(maxWidth: 220)
                    Text(codeNumber(minimum, decimals: 0))
                        .font(.caption.monospacedDigit())
                        .foregroundStyle(.secondary)
                }
                DemoControlRow(label: "Spacing") {
                    Slider(value: $spacing, in: 2...20, step: 1)
                        .frame(maxWidth: 220)
                    Text(codeNumber(spacing, decimals: 0))
                        .font(.caption.monospacedDigit())
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

// MARK: - Grid

struct GridSpacingDemo: View {
    private enum AlignChoice: String, CaseIterable, Identifiable {
        case leading, center, trailing
        var id: String { rawValue }

        var alignment: Alignment {
            switch self {
            case .leading: .leading
            case .center: .center
            case .trailing: .trailing
            }
        }
    }

    @State private var hSpacing: Double = 10
    @State private var vSpacing: Double = 10
    @State private var align = AlignChoice.center

    // Deliberately uneven cell widths so the grid alignment has
    // something visible to do inside each column.
    private let widths: [CGFloat] = [64, 40, 84, 48, 76, 56, 88, 44, 68]

    private var liveCode: String {
        """
        Grid(
            alignment: .\(align.rawValue),
            horizontalSpacing: \(codeNumber(hSpacing, decimals: 0)),
            verticalSpacing: \(codeNumber(vSpacing, decimals: 0))
        ) {
            ForEach(0..<3, id: \\.self) { row in
                GridRow {
                    ForEach(0..<3, id: \\.self) { column in
                        cell(row: row, column: column)  // labeled cells of varying widths
                    }
                }
            }
        }
        """
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            Grid(
                alignment: align.alignment,
                horizontalSpacing: CGFloat(hSpacing),
                verticalSpacing: CGFloat(vSpacing)
            ) {
                ForEach(0..<3, id: \.self) { row in
                    GridRow {
                        ForEach(0..<3, id: \.self) { column in
                            cell(row: row, column: column)
                        }
                    }
                }
            }
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "H spacing") {
                    Slider(value: $hSpacing, in: 0...30, step: 1)
                        .frame(maxWidth: 220)
                    Text(codeNumber(hSpacing, decimals: 0))
                        .font(.caption.monospacedDigit())
                        .foregroundStyle(.secondary)
                }
                DemoControlRow(label: "V spacing") {
                    Slider(value: $vSpacing, in: 0...30, step: 1)
                        .frame(maxWidth: 220)
                    Text(codeNumber(vSpacing, decimals: 0))
                        .font(.caption.monospacedDigit())
                        .foregroundStyle(.secondary)
                }
                DemoControlRow(label: "Alignment") {
                    Picker("", selection: $align) {
                        ForEach(AlignChoice.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .fixedSize()
                }
            }
        }
    }

    private func cell(row: Int, column: Int) -> some View {
        Text("\(row).\(column)")
            .font(.caption.monospaced())
            .frame(width: widths[row * 3 + column], height: 30)
            .background(.indigo.opacity(0.25), in: RoundedRectangle(cornerRadius: 6))
    }
}
