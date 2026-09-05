//
//  MotionDemos.swift
//  Aviary
//
//  Interactive demos for animation timing and layered visual effects.
//

import SwiftUI

// MARK: - Animation

struct AnimationDemo: View {
    private enum CurveChoice: String, CaseIterable, Identifiable {
        case spring, bouncy, snappy, easeInOut, linear
        var id: String { rawValue }

        func animation(duration: Double) -> Animation {
            switch self {
            case .spring: .spring(duration: duration)
            case .bouncy: .bouncy(duration: duration)
            case .snappy: .snappy(duration: duration)
            case .easeInOut: .easeInOut(duration: duration)
            case .linear: .linear(duration: duration)
            }
        }
    }

    @State private var curve = CurveChoice.spring
    @State private var duration = 0.5
    @State private var isFlipped = false

    private var liveCode: String {
        """
        RoundedRectangle(cornerRadius: isFlipped ? 40 : 8)
            .frame(width: isFlipped ? 180 : 90, height: 80)
            .rotationEffect(.degrees(isFlipped ? 180 : 0))
            .animation(
                .\(curve.rawValue)(duration: \(codeNumber(duration))),
                value: isFlipped
            )
        """
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            VStack(spacing: 16) {
                RoundedRectangle(cornerRadius: isFlipped ? 40 : 8)
                    .fill(.indigo.gradient)
                    .frame(width: isFlipped ? 180 : 90, height: 80)
                    .rotationEffect(.degrees(isFlipped ? 180 : 0))
                    .animation(curve.animation(duration: duration), value: isFlipped)

                Button("Animate") { isFlipped.toggle() }
                    .buttonStyle(.bordered)
            }
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "Curve") {
                    Picker("", selection: $curve) {
                        ForEach(CurveChoice.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .fixedSize()
                }
                DemoControlRow(label: "Duration") {
                    Slider(value: $duration, in: 0.1...2)
                        .frame(maxWidth: 200)
                    Text("\(codeNumber(duration))s")
                        .monospacedDigit()
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

// MARK: - Layered effects

struct EffectsDemo: View {
    @State private var opacity = 1.0
    @State private var shadowRadius = 6.0
    @State private var blurRadius = 0.0

    private var liveCode: String {
        var lines = ["RoundedRectangle(cornerRadius: 14)", "    .fill(.orange.gradient)"]
        if opacity < 1 {
            lines.append("    .opacity(\(codeNumber(opacity)))")
        }
        if shadowRadius > 0 {
            lines.append("    .shadow(radius: \(codeNumber(shadowRadius, decimals: 0)), y: 4)")
        }
        if blurRadius > 0 {
            lines.append("    .blur(radius: \(codeNumber(blurRadius, decimals: 0)))")
        }
        return lines.joined(separator: "\n")
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            RoundedRectangle(cornerRadius: 14)
                .fill(.orange.gradient)
                .frame(width: 160, height: 100)
                .opacity(opacity)
                .shadow(radius: shadowRadius, y: 4)
                .blur(radius: blurRadius)
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "Opacity") {
                    Slider(value: $opacity, in: 0...1)
                        .frame(maxWidth: 200)
                    Text(codeNumber(opacity))
                        .monospacedDigit()
                        .foregroundStyle(.secondary)
                }
                DemoControlRow(label: "Shadow") {
                    Slider(value: $shadowRadius, in: 0...24)
                        .frame(maxWidth: 200)
                    Text(codeNumber(shadowRadius, decimals: 0))
                        .monospacedDigit()
                        .foregroundStyle(.secondary)
                }
                DemoControlRow(label: "Blur") {
                    Slider(value: $blurRadius, in: 0...12)
                        .frame(maxWidth: 200)
                    Text(codeNumber(blurRadius, decimals: 0))
                        .monospacedDigit()
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}
