//
//  CurveMaterialDemos.swift
//  Aviary
//
//  Interactive demos for cubic Bézier curves, MeshGradient, Materials,
//  and trimmed circle rings.
//

import SwiftUI

// MARK: - Cubic Bézier curve

struct CubicCurveDemo: View {
    // Normalized (0...1) so the demo scales with its frame.
    @State private var start = CGPoint(x: 0.1, y: 0.8)
    @State private var end = CGPoint(x: 0.9, y: 0.8)
    @State private var control1 = CGPoint(x: 0.3, y: 0.08)
    @State private var control2 = CGPoint(x: 0.7, y: 0.08)

    private var liveCode: String {
        """
        Path { p in
            p.move(to: CGPoint(x: \(fmt(start.x)), y: \(fmt(start.y))))
            p.addCurve(
                to: CGPoint(x: \(fmt(end.x)), y: \(fmt(end.y))),
                control1: CGPoint(x: \(fmt(control1.x)), y: \(fmt(control1.y))),
                control2: CGPoint(x: \(fmt(control2.x)), y: \(fmt(control2.y)))
            )
        }
        .stroke(.blue, lineWidth: 3)
        """
    }

    private func fmt(_ value: CGFloat) -> String {
        codeNumber(Double(value))
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            GeometryReader { geo in
                let size = geo.size
                let s = denormalize(start, in: size)
                let e = denormalize(end, in: size)
                let c1 = denormalize(control1, in: size)
                let c2 = denormalize(control2, in: size)

                ZStack {
                    // Each endpoint connects to its own control point.
                    Path { p in
                        p.move(to: s)
                        p.addLine(to: c1)
                        p.move(to: e)
                        p.addLine(to: c2)
                    }
                    .stroke(
                        .secondary.opacity(0.5),
                        style: StrokeStyle(lineWidth: 1, dash: [4, 4])
                    )

                    Path { p in
                        p.move(to: s)
                        p.addCurve(to: e, control1: c1, control2: c2)
                    }
                    .stroke(.blue, lineWidth: 3)

                    handle(at: s, color: .green, point: $start, in: size)
                    handle(at: e, color: .green, point: $end, in: size)
                    handle(at: c1, color: .orange, point: $control1, in: size)
                    handle(at: c2, color: .orange, point: $control2, in: size)

                    Text("control1")
                        .font(.caption2)
                        .foregroundStyle(.orange)
                        .position(x: c1.x, y: max(c1.y - 18, 8))
                    Text("control2")
                        .font(.caption2)
                        .foregroundStyle(.orange)
                        .position(x: c2.x, y: max(c2.y - 18, 8))
                }
            }
            .frame(height: 230)
        } controls: {
            Label(
                "Two control points bend a cubic curve — drag all four handles.",
                systemImage: "hand.draw"
            )
            .font(.callout)
            .foregroundStyle(.secondary)
        }
    }

    private func denormalize(_ point: CGPoint, in size: CGSize) -> CGPoint {
        CGPoint(x: point.x * size.width, y: point.y * size.height)
    }

    private func handle(
        at location: CGPoint,
        color: Color,
        point: Binding<CGPoint>,
        in size: CGSize
    ) -> some View {
        Circle()
            .fill(color)
            .frame(width: 16, height: 16)
            .overlay { Circle().strokeBorder(.white, lineWidth: 2) }
            .shadow(radius: 2)
            .position(location)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        guard size.width > 0, size.height > 0 else { return }
                        point.wrappedValue = CGPoint(
                            x: min(max(value.location.x / size.width, 0), 1),
                            y: min(max(value.location.y / size.height, 0), 1)
                        )
                    }
            )
    }
}

// MARK: - MeshGradient

struct MeshGradientDemo: View {
    @State private var center = CGPoint(x: 0.5, y: 0.5)
    @State private var showPoints = false

    private var meshPoints: [SIMD2<Float>] {
        [
            [0, 0], [0.5, 0], [1, 0],
            [0, 0.5], SIMD2(Float(center.x), Float(center.y)), [1, 0.5],
            [0, 1], [0.5, 1], [1, 1],
        ]
    }

    private var liveCode: String {
        """
        MeshGradient(
            width: 3, height: 3,
            points: [
                [0, 0],   [0.5, 0], [1, 0],
                [0, 0.5], [\(codeNumber(center.x)), \(codeNumber(center.y))], [1, 0.5],
                [0, 1],   [0.5, 1], [1, 1]
            ],
            colors: [
                .purple, .indigo, .blue,
                .orange, .pink,   .teal,
                .red,    .yellow, .mint
            ]
        )
        """
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            GeometryReader { geo in
                let size = geo.size
                ZStack {
                    MeshGradient(
                        width: 3, height: 3,
                        points: meshPoints,
                        colors: [
                            .purple, .indigo, .blue,
                            .orange, .pink, .teal,
                            .red, .yellow, .mint,
                        ]
                    )
                    .clipShape(.rect(cornerRadius: 12))

                    if showPoints {
                        ForEach(0..<9, id: \.self) { index in
                            let p = meshPoints[index]
                            Circle()
                                .fill(.white)
                                .frame(width: 8, height: 8)
                                .overlay {
                                    Circle().strokeBorder(.black.opacity(0.6), lineWidth: 1)
                                }
                                .position(
                                    x: CGFloat(p.x) * size.width,
                                    y: CGFloat(p.y) * size.height
                                )
                                .allowsHitTesting(false)
                        }
                    }

                    // The draggable center vertex — the mesh warps around it.
                    Circle()
                        .fill(.white)
                        .frame(width: 16, height: 16)
                        .overlay { Circle().strokeBorder(.black.opacity(0.5), lineWidth: 2) }
                        .shadow(radius: 2)
                        .position(x: center.x * size.width, y: center.y * size.height)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    guard size.width > 0, size.height > 0 else { return }
                                    center = CGPoint(
                                        x: min(max(value.location.x / size.width, 0.15), 0.85),
                                        y: min(max(value.location.y / size.height, 0.15), 0.85)
                                    )
                                }
                        )
                }
            }
            .frame(height: 230)
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "Points") {
                    Toggle("Show mesh points", isOn: $showPoints)
                }
                Label(
                    "Drag the white handle to move the center vertex of the mesh.",
                    systemImage: "hand.draw"
                )
                .font(.callout)
                .foregroundStyle(.secondary)
            }
        }
    }
}

// MARK: - Material

struct MaterialDemo: View {
    private enum MaterialChoice: String, CaseIterable, Identifiable {
        case ultraThin, thin, regular, thick, ultraThick
        var id: String { rawValue }

        var material: Material {
            switch self {
            case .ultraThin: .ultraThinMaterial
            case .thin: .thinMaterial
            case .regular: .regularMaterial
            case .thick: .thickMaterial
            case .ultraThick: .ultraThickMaterial
            }
        }
    }

    @State private var choice = MaterialChoice.ultraThin

    private let orbitColors: [Color] = [.yellow, .cyan, .white]

    private var liveCode: String {
        """
        Text("Frosted panel")
            .padding(24)
            .background(.\(choice.rawValue)Material, in: .rect(cornerRadius: 16))
        """
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            ZStack {
                LinearGradient(
                    colors: [.purple, .pink, .orange, .yellow, .teal],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                // Motion behind the panel makes the blur easy to judge.
                TimelineView(.animation) { context in
                    let t = context.date.timeIntervalSinceReferenceDate
                    ZStack {
                        ForEach(0..<3, id: \.self) { index in
                            Circle()
                                .fill(orbitColors[index].opacity(0.85))
                                .frame(width: 44, height: 44)
                                .offset(x: 78)
                                .rotationEffect(.degrees(t * 45 + Double(index) * 120))
                        }
                    }
                }

                VStack(spacing: 4) {
                    Text("Frosted panel")
                        .font(.headline)
                    Text("The moving scene blurs through the material.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(24)
                .background(choice.material, in: .rect(cornerRadius: 16))
            }
            .frame(height: 220)
            .clipShape(.rect(cornerRadius: 12))
        } controls: {
            DemoControlRow(label: "Material") {
                Picker("", selection: $choice) {
                    ForEach(MaterialChoice.allCases) { Text($0.rawValue).tag($0) }
                }
                .pickerStyle(.segmented)
                .labelsHidden()
            }
        }
    }
}

// MARK: - Trimmed ring

struct TrimRingDemo: View {
    private enum CapChoice: String, CaseIterable, Identifiable {
        case butt, round
        var id: String { rawValue }

        var cap: CGLineCap {
            self == .butt ? .butt : .round
        }
    }

    @State private var trimFrom = 0.0
    @State private var trimTo = 0.72
    @State private var cap = CapChoice.round
    @State private var lineWidth = 10.0

    private var liveCode: String {
        """
        Circle()
            .trim(from: \(codeNumber(trimFrom)), to: \(codeNumber(trimTo)))
            .stroke(.blue, style: StrokeStyle(
                lineWidth: \(codeNumber(lineWidth, decimals: 0)),
                lineCap: .\(cap.rawValue)
            ))
            .rotationEffect(.degrees(-90))
        """
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            ZStack {
                Circle()
                    .stroke(.quaternary, lineWidth: lineWidth)
                Circle()
                    .trim(from: trimFrom, to: trimTo)
                    .stroke(.blue, style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: cap.cap
                    ))
                    .rotationEffect(.degrees(-90))
            }
            .frame(width: 140, height: 140)
            .padding(lineWidth)
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "From") {
                    Slider(value: $trimFrom, in: 0...1)
                        .frame(width: 160)
                        .onChange(of: trimFrom) {
                            if trimTo < trimFrom { trimTo = trimFrom }
                        }
                    Text(codeNumber(trimFrom))
                        .font(.callout.monospaced())
                        .foregroundStyle(.secondary)
                }
                DemoControlRow(label: "To") {
                    Slider(value: $trimTo, in: 0...1)
                        .frame(width: 160)
                        .onChange(of: trimTo) {
                            if trimFrom > trimTo { trimFrom = trimTo }
                        }
                    Text(codeNumber(trimTo))
                        .font(.callout.monospaced())
                        .foregroundStyle(.secondary)
                }
                DemoControlRow(label: "Line cap") {
                    Picker("", selection: $cap) {
                        ForEach(CapChoice.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .fixedSize()
                }
                DemoControlRow(label: "Width") {
                    Slider(value: $lineWidth, in: 2...20, step: 1)
                        .frame(width: 160)
                    Text(codeNumber(lineWidth, decimals: 0))
                        .font(.callout.monospaced())
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}
