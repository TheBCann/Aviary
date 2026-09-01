//
//  LayoutDemos.swift
//  Swift-UI-Companion
//
//  Interactive demos for stacks, gradients, and RoundedRectangle.
//

import SwiftUI

// MARK: - Stacks

struct StacksDemo: View {
    @State private var isVertical = false
    @State private var spacing = 12.0

    private var liveCode: String {
        let stack = isVertical ? "VStack" : "HStack"
        let alignment = isVertical ? "leading" : "center"
        return """
        \(stack)(alignment: .\(alignment), spacing: \(codeNumber(spacing, decimals: 0))) {
            Circle().frame(width: 24)
            Text("Item")
            Capsule().frame(width: 48, height: 16)
        }
        """
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            layout
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "Axis") {
                    Picker("", selection: $isVertical) {
                        Text("HStack").tag(false)
                        Text("VStack").tag(true)
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .fixedSize()
                }
                DemoControlRow(label: "Spacing") {
                    Slider(value: $spacing, in: 0...40)
                        .frame(maxWidth: 200)
                    Text(codeNumber(spacing, decimals: 0))
                        .monospacedDigit()
                        .foregroundStyle(.secondary)
                }
            }
        }
    }

    @ViewBuilder
    private var layout: some View {
        let items = Group {
            Circle().fill(.blue).frame(width: 24, height: 24)
            Text("Item")
            Capsule().fill(.orange).frame(width: 48, height: 16)
        }
        if isVertical {
            VStack(alignment: .leading, spacing: spacing) { items }
        } else {
            HStack(alignment: .center, spacing: spacing) { items }
        }
    }
}

// MARK: - Gradients

struct GradientDemo: View {
    private enum KindChoice: String, CaseIterable, Identifiable {
        case linear, radial, angular
        var id: String { rawValue }
    }

    @State private var kind = KindChoice.linear
    @State private var from = Color.purple
    @State private var to = Color.blue

    private var liveCode: String {
        switch kind {
        case .linear:
            """
            LinearGradient(
                colors: [.purple, .blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            """
        case .radial:
            """
            RadialGradient(
                colors: [.purple, .blue],
                center: .center,
                startRadius: 5,
                endRadius: 90
            )
            """
        case .angular:
            """
            AngularGradient(
                colors: [.purple, .blue, .purple],
                center: .center
            )
            """
        }
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            RoundedRectangle(cornerRadius: 12)
                .fill(gradientStyle)
                .frame(width: 220, height: 120)
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "Kind") {
                    Picker("", selection: $kind) {
                        ForEach(KindChoice.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .fixedSize()
                }
                DemoControlRow(label: "Colors") {
                    ColorPicker("", selection: $from, supportsOpacity: false)
                        .labelsHidden()
                    ColorPicker("", selection: $to, supportsOpacity: false)
                        .labelsHidden()
                }
            }
        }
    }

    private var gradientStyle: AnyShapeStyle {
        switch kind {
        case .linear:
            AnyShapeStyle(LinearGradient(
                colors: [from, to],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ))
        case .radial:
            AnyShapeStyle(RadialGradient(
                colors: [from, to],
                center: .center,
                startRadius: 5,
                endRadius: 90
            ))
        case .angular:
            AnyShapeStyle(AngularGradient(
                colors: [from, to, from],
                center: .center
            ))
        }
    }
}

// MARK: - RoundedRectangle

struct RoundedRectDemo: View {
    @State private var radius = 20.0
    @State private var isContinuous = true
    @State private var isStroked = false

    private var liveCode: String {
        let style = isContinuous ? "continuous" : "circular"
        let paint = isStroked
            ? ".strokeBorder(.teal, lineWidth: 4)"
            : ".fill(.teal.gradient)"
        return """
        RoundedRectangle(cornerRadius: \(codeNumber(radius, decimals: 0)), style: .\(style))
            \(paint)
            .frame(width: 200, height: 110)
        """
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            shape
                .frame(width: 200, height: 110)
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "Radius") {
                    Slider(value: $radius, in: 0...55)
                        .frame(maxWidth: 200)
                    Text(codeNumber(radius, decimals: 0))
                        .monospacedDigit()
                        .foregroundStyle(.secondary)
                }
                DemoControlRow(label: "Style") {
                    Toggle("Continuous corners", isOn: $isContinuous)
                    Toggle("Stroke", isOn: $isStroked)
                }
            }
        }
    }

    @ViewBuilder
    private var shape: some View {
        let rect = RoundedRectangle(
            cornerRadius: radius,
            style: isContinuous ? .continuous : .circular
        )
        if isStroked {
            rect.strokeBorder(.teal, lineWidth: 4)
        } else {
            rect.fill(.teal.gradient)
        }
    }
}
