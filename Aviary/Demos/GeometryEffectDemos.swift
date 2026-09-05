//
//  GeometryEffectDemos.swift
//  Aviary
//
//  Interactive demos for geometry effects: offset/scale/rotation
//  transforms, clip shapes, gradient masks, and arc paths.
//

import SwiftUI

// MARK: - Transform

struct TransformDemo: View {
    @State private var offsetX: Double = 30
    @State private var offsetY: Double = -20
    @State private var scale: Double = 1.2
    @State private var rotation: Double = 25

    private var liveCode: String {
        func display(_ value: Double, decimals: Int = 2) -> String {
            let text = codeNumber(value, decimals: decimals)
            return text == "-0" ? "0" : text
        }
        var lines = [
            "RoundedRectangle(cornerRadius: 12)",
            "    .fill(.blue.gradient)",
            "    .frame(width: 90, height: 60)",
        ]
        let x = display(offsetX, decimals: 0)
        let y = display(offsetY, decimals: 0)
        if x != "0" || y != "0" {
            lines.append("    .offset(x: \(x), y: \(y))")
        }
        let scaleText = display(scale)
        if scaleText != "1" {
            lines.append("    .scaleEffect(\(scaleText))")
        }
        let rotationText = display(rotation, decimals: 0)
        if rotationText != "0" {
            lines.append("    .rotationEffect(.degrees(\(rotationText)))")
        }
        return lines.joined(separator: "\n")
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            ZStack {
                // Ghost marks where the shape sits before any transform.
                RoundedRectangle(cornerRadius: 12)
                    .fill(.secondary.opacity(0.12))
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .strokeBorder(
                                .secondary.opacity(0.5),
                                style: StrokeStyle(lineWidth: 1, dash: [4, 4])
                            )
                    }
                    .frame(width: 90, height: 60)

                RoundedRectangle(cornerRadius: 12)
                    .fill(.blue.gradient)
                    .frame(width: 90, height: 60)
                    .offset(x: offsetX, y: offsetY)
                    .scaleEffect(scale)
                    .rotationEffect(.degrees(rotation))
            }
            .frame(height: 200)
            .clipped()
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "Offset X") {
                    Slider(value: $offsetX, in: -80...80)
                        .frame(maxWidth: 220)
                    Text(codeNumber(offsetX, decimals: 0))
                        .font(.caption.monospacedDigit())
                        .foregroundStyle(.secondary)
                }
                DemoControlRow(label: "Offset Y") {
                    Slider(value: $offsetY, in: -60...60)
                        .frame(maxWidth: 220)
                    Text(codeNumber(offsetY, decimals: 0))
                        .font(.caption.monospacedDigit())
                        .foregroundStyle(.secondary)
                }
                DemoControlRow(label: "Scale") {
                    Slider(value: $scale, in: 0.3...2)
                        .frame(maxWidth: 220)
                    Text(codeNumber(scale))
                        .font(.caption.monospacedDigit())
                        .foregroundStyle(.secondary)
                }
                DemoControlRow(label: "Rotation") {
                    Slider(value: $rotation, in: 0...360)
                        .frame(maxWidth: 220)
                    Text(codeNumber(rotation, decimals: 0) + "°")
                        .font(.caption.monospacedDigit())
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

// MARK: - Clip Shape

struct ClipShapeDemo: View {
    private enum ShapeChoice: String, CaseIterable, Identifiable {
        case rect, circle, capsule, ellipse
        var id: String { rawValue }
    }

    @State private var shape = ShapeChoice.rect
    @State private var cornerRadius: Double = 24

    private var clipCode: String {
        switch shape {
        case .rect: ".clipShape(.rect(cornerRadius: \(codeNumber(cornerRadius, decimals: 0))))"
        case .circle: ".clipShape(.circle)"
        case .capsule: ".clipShape(.capsule)"
        case .ellipse: ".clipShape(.ellipse)"
        }
    }

    private var liveCode: String {
        """
        LinearGradient(
            colors: [.pink, .orange, .yellow],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .frame(width: 220, height: 130)
        \(clipCode)
        """
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            clippedGradient
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "Shape") {
                    Picker("", selection: $shape) {
                        ForEach(ShapeChoice.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .fixedSize()
                }
                if shape == .rect {
                    DemoControlRow(label: "Radius") {
                        Slider(value: $cornerRadius, in: 0...64)
                            .frame(maxWidth: 220)
                        Text(codeNumber(cornerRadius, decimals: 0))
                            .font(.caption.monospacedDigit())
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private var clippedGradient: some View {
        let gradient = LinearGradient(
            colors: [.pink, .orange, .yellow],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .frame(width: 220, height: 130)

        switch shape {
        case .rect: gradient.clipShape(.rect(cornerRadius: cornerRadius))
        case .circle: gradient.clipShape(.circle)
        case .capsule: gradient.clipShape(.capsule)
        case .ellipse: gradient.clipShape(.ellipse)
        }
    }
}

// MARK: - Mask

struct MaskDemo: View {
    @State private var fade: Double = 0.75
    @State private var inverted = false

    private var stopLines: String {
        let position = codeNumber(fade)
        return inverted
            ? """
                        .init(color: .clear, location: 0),
                        .init(color: .white, location: \(position))
        """
            : """
                        .init(color: .white, location: 0),
                        .init(color: .clear, location: \(position))
        """
    }

    private var liveCode: String {
        """
        Text("MASK")
            .font(.system(size: 64, weight: .black))
            .foregroundStyle(.blue.gradient)
            .mask {
                LinearGradient(
                    stops: [
        \(stopLines)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            }
        """
    }

    private var maskStops: [Gradient.Stop] {
        inverted
            ? [.init(color: .clear, location: 0), .init(color: .white, location: fade)]
            : [.init(color: .white, location: 0), .init(color: .clear, location: fade)]
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            Text("MASK")
                .font(.system(size: 64, weight: .black))
                .foregroundStyle(.blue.gradient)
                .mask {
                    LinearGradient(
                        stops: maskStops,
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                }
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "Fade at") {
                    Slider(value: $fade, in: 0.05...1)
                        .frame(maxWidth: 220)
                    Text(codeNumber(fade))
                        .font(.caption.monospacedDigit())
                        .foregroundStyle(.secondary)
                }
                DemoControlRow(label: "Direction") {
                    Toggle("Invert stops", isOn: $inverted)
                }
            }
        }
    }
}

// MARK: - Arc

struct ArcDemo: View {
    @State private var startAngle: Double = 0
    @State private var endAngle: Double = 270
    @State private var clockwise = false

    private let center = CGPoint(x: 110, y: 100)
    private let radius: CGFloat = 75

    /// End angle used by both the preview path and the code sample, kept at
    /// least 1 degree away from the start so the arc never collapses to nothing.
    private var effectiveEndAngle: Double {
        guard abs(endAngle - startAngle) < 1 else { return endAngle }
        return startAngle + (endAngle < startAngle ? -1 : 1)
    }

    private var liveCode: String {
        """
        Path { p in
            p.addArc(
                center: CGPoint(x: \(codeNumber(center.x, decimals: 0)), y: \(codeNumber(center.y, decimals: 0))),
                radius: \(codeNumber(radius, decimals: 0)),
                startAngle: .degrees(\(codeNumber(startAngle, decimals: 0))),
                endAngle: .degrees(\(codeNumber(effectiveEndAngle, decimals: 0))),
                clockwise: \(clockwise)
            )
        }
        .stroke(.blue, lineWidth: 4)
        """
    }

    private var arcStart: CGPoint {
        let radians = startAngle * .pi / 180
        return CGPoint(
            x: center.x + radius * cos(radians),
            y: center.y + radius * sin(radians)
        )
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            ZStack {
                // Guide from the center out to where the arc begins.
                Path { p in
                    p.move(to: center)
                    p.addLine(to: arcStart)
                }
                .stroke(
                    .secondary.opacity(0.5),
                    style: StrokeStyle(lineWidth: 1, dash: [4, 4])
                )

                Path { p in
                    p.addArc(
                        center: center,
                        radius: radius,
                        startAngle: .degrees(startAngle),
                        endAngle: .degrees(effectiveEndAngle),
                        clockwise: clockwise
                    )
                }
                .stroke(.blue, lineWidth: 4)

                Circle()
                    .fill(.secondary)
                    .frame(width: 6, height: 6)
                    .position(center)

                Circle()
                    .fill(.orange)
                    .frame(width: 8, height: 8)
                    .position(arcStart)
            }
            .frame(width: 220, height: 200)
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "Start") {
                    Slider(value: $startAngle, in: 0...360)
                        .frame(maxWidth: 220)
                    Text(codeNumber(startAngle, decimals: 0) + "°")
                        .font(.caption.monospacedDigit())
                        .foregroundStyle(.secondary)
                }
                DemoControlRow(label: "End") {
                    Slider(value: $endAngle, in: 0...360)
                        .frame(maxWidth: 220)
                    Text(codeNumber(endAngle, decimals: 0) + "°")
                        .font(.caption.monospacedDigit())
                        .foregroundStyle(.secondary)
                }
                DemoControlRow(label: "Direction") {
                    Toggle("Clockwise", isOn: $clockwise)
                }
            }
        }
    }
}
