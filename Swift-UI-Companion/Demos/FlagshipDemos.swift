//
//  FlagshipDemos.swift
//  Swift-UI-Companion
//
//  Visual-learning flagships in the spirit of the quad-curve demo:
//  drag the thing the parameter describes and watch the code follow.
//

import SwiftUI

// MARK: - Shared unit-point helpers

private let namedUnitPoints: [(name: String, point: CGPoint)] = [
    ("topLeading", CGPoint(x: 0, y: 0)), ("top", CGPoint(x: 0.5, y: 0)),
    ("topTrailing", CGPoint(x: 1, y: 0)), ("leading", CGPoint(x: 0, y: 0.5)),
    ("center", CGPoint(x: 0.5, y: 0.5)), ("trailing", CGPoint(x: 1, y: 0.5)),
    ("bottomLeading", CGPoint(x: 0, y: 1)), ("bottom", CGPoint(x: 0.5, y: 1)),
    ("bottomTrailing", CGPoint(x: 1, y: 1)),
]

/// Snaps a unit point to the nearest named anchor when close enough.
private func snapped(_ point: CGPoint) -> CGPoint {
    for named in namedUnitPoints
    where abs(named.point.x - point.x) < 0.06 && abs(named.point.y - point.y) < 0.06 {
        return named.point
    }
    return point
}

/// ".topLeading" for named anchors, "UnitPoint(x:y:)" otherwise.
private func unitPointCode(_ point: CGPoint) -> String {
    for named in namedUnitPoints
    where named.point.x == point.x && named.point.y == point.y {
        return ".\(named.name)"
    }
    return "UnitPoint(x: \(codeNumber(Double(point.x))), y: \(codeNumber(Double(point.y))))"
}

private func dragHandle(
    at location: CGPoint,
    color: Color,
    size: CGSize,
    update: @escaping (CGPoint) -> Void,
    onEnded: @escaping () -> Void = {}
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
                    update(CGPoint(
                        x: min(max(value.location.x / size.width, 0), 1),
                        y: min(max(value.location.y / size.height, 0), 1)
                    ))
                }
                .onEnded { _ in onEnded() }
        )
}

// MARK: - Animation timing curve

struct TimingCurveDemo: View {
    // Control points in curve space: x = time, y = progress (y up).
    @State private var c1 = CGPoint(x: 0.42, y: 0.0)
    @State private var c2 = CGPoint(x: 0.58, y: 1.0)
    @State private var duration = 0.8
    @State private var isAtEnd = false

    private var liveCode: String {
        """
        Circle()
            .offset(x: isOn ? 110 : -110)
            .animation(
                .timingCurve(
                    \(codeNumber(Double(c1.x))), \(codeNumber(Double(c1.y))), \
        \(codeNumber(Double(c2.x))), \(codeNumber(Double(c2.y))),
                    duration: \(codeNumber(duration))
                ),
                value: isOn
            )
        """
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            VStack(spacing: 14) {
                curveEditor

                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(.quaternary)
                        .frame(width: 244, height: 6)
                    Circle()
                        .fill(.blue)
                        .frame(width: 20, height: 20)
                        .offset(x: isAtEnd ? 224 : 0)
                        .animation(
                            .timingCurve(c1.x, c1.y, c2.x, c2.y, duration: duration),
                            value: isAtEnd
                        )
                }

                Button {
                    isAtEnd.toggle()
                } label: {
                    Label("Play", systemImage: "play.fill")
                }
                .buttonStyle(.borderedProminent)
            }
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "Duration") {
                    Slider(value: $duration, in: 0.2...2) { editing in
                        if !editing { isAtEnd.toggle() }
                    }
                    .frame(maxWidth: 200)
                    Text("\(codeNumber(duration))s")
                        .monospacedDigit()
                        .foregroundStyle(.secondary)
                }
                Label(
                    "Drag the orange points to reshape the curve — releasing replays it.",
                    systemImage: "hand.draw"
                )
                .font(.callout)
                .foregroundStyle(.secondary)
            }
        }
    }

    // Curve space is y-up; the view is y-down.
    private func toView(_ p: CGPoint, in size: CGSize) -> CGPoint {
        CGPoint(x: p.x * size.width, y: (1 - p.y) * size.height)
    }

    private var curveEditor: some View {
        GeometryReader { geo in
            let size = geo.size
            let startCorner = toView(.zero, in: size)
            let endCorner = toView(CGPoint(x: 1, y: 1), in: size)
            let h1 = toView(c1, in: size)
            let h2 = toView(c2, in: size)

            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.background.secondary)
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(.quaternary, lineWidth: 1)

                Path { p in
                    p.move(to: startCorner)
                    p.addLine(to: h1)
                    p.move(to: endCorner)
                    p.addLine(to: h2)
                }
                .stroke(
                    .secondary.opacity(0.5),
                    style: StrokeStyle(lineWidth: 1, dash: [4, 4])
                )

                Path { p in
                    p.move(to: startCorner)
                    p.addCurve(to: endCorner, control1: h1, control2: h2)
                }
                .stroke(.blue, lineWidth: 3)

                dragHandle(at: h1, color: .orange, size: size) { unit in
                    c1 = CGPoint(x: unit.x, y: 1 - unit.y)
                } onEnded: {
                    isAtEnd.toggle()
                }
                dragHandle(at: h2, color: .orange, size: size) { unit in
                    c2 = CGPoint(x: unit.x, y: 1 - unit.y)
                } onEnded: {
                    isAtEnd.toggle()
                }
            }
        }
        .frame(width: 180, height: 160)
    }
}

// MARK: - Gradient anchors

struct GradientAnchorsDemo: View {
    // UnitPoint coordinates: y down, matching the view.
    @State private var start = CGPoint(x: 0, y: 0)
    @State private var end = CGPoint(x: 1, y: 1)

    private var liveCode: String {
        """
        LinearGradient(
            colors: [.purple, .blue],
            startPoint: \(unitPointCode(start)),
            endPoint: \(unitPointCode(end))
        )
        """
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            GeometryReader { geo in
                let size = geo.size
                let startLocation = CGPoint(x: start.x * size.width, y: start.y * size.height)
                let endLocation = CGPoint(x: end.x * size.width, y: end.y * size.height)

                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(LinearGradient(
                            colors: [.purple, .blue],
                            startPoint: UnitPoint(x: start.x, y: start.y),
                            endPoint: UnitPoint(x: end.x, y: end.y)
                        ))

                    Path { p in
                        p.move(to: startLocation)
                        p.addLine(to: endLocation)
                    }
                    .stroke(
                        .white.opacity(0.6),
                        style: StrokeStyle(lineWidth: 1, dash: [4, 4])
                    )

                    dragHandle(at: startLocation, color: .green, size: size) { unit in
                        start = snapped(unit)
                    }
                    dragHandle(at: endLocation, color: .orange, size: size) { unit in
                        end = snapped(unit)
                    }
                }
            }
            .frame(width: 250, height: 150)
        } controls: {
            Label(
                "Drag the start (green) and end (orange) anchors — they snap to named UnitPoints like .topLeading.",
                systemImage: "hand.draw"
            )
            .font(.callout)
            .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Rotation anchor

struct RotationAnchorDemo: View {
    @State private var anchor = CGPoint(x: 0.5, y: 0.5)
    @State private var angle = 30.0

    private var liveCode: String {
        """
        RoundedRectangle(cornerRadius: 10)
            .fill(.teal.gradient)
            .rotationEffect(
                .degrees(\(codeNumber(angle, decimals: 0))),
                anchor: \(unitPointCode(anchor))
            )
        """
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(
                        .secondary.opacity(0.6),
                        style: StrokeStyle(lineWidth: 1, dash: [5, 4])
                    )

                RoundedRectangle(cornerRadius: 10)
                    .fill(.teal.gradient)
                    .opacity(0.85)
                    .rotationEffect(
                        .degrees(angle),
                        anchor: UnitPoint(x: anchor.x, y: anchor.y)
                    )

                GeometryReader { geo in
                    let size = geo.size
                    let location = CGPoint(x: anchor.x * size.width, y: anchor.y * size.height)
                    dragHandle(at: location, color: .orange, size: size) { unit in
                        anchor = snapped(unit)
                    }
                }
            }
            .frame(width: 180, height: 110)
            .frame(maxWidth: .infinity)
            .frame(height: 210)
            .clipped()
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "Angle") {
                    Slider(value: $angle, in: 0...360, step: 1)
                        .frame(maxWidth: 200)
                    Text("\(codeNumber(angle, decimals: 0))°")
                        .monospacedDigit()
                        .foregroundStyle(.secondary)
                }
                Label(
                    "Drag the orange anchor — the dashed outline is the unrotated frame.",
                    systemImage: "hand.draw"
                )
                .font(.callout)
                .foregroundStyle(.secondary)
            }
        }
    }
}
