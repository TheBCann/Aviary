//
//  FlagshipDemos2.swift
//  Aviary
//
//  Second wave of draggable visual-learning demos: shadow light source,
//  per-corner radii, radial gradient geometry, and angular sweep.
//

import SwiftUI

// MARK: - Shadow light source

struct ShadowLightDemo: View {
    private static let area = CGSize(width: 260, height: 180)
    private static let cardCenter = CGPoint(x: 130, y: 95)

    @State private var light = CGPoint(x: 64, y: 38)
    @State private var radius = 8.0

    private var shadowOffset: CGSize {
        let scale = 0.22
        return CGSize(
            width: min(max((Self.cardCenter.x - light.x) * scale, -28), 28),
            height: min(max((Self.cardCenter.y - light.y) * scale, -28), 28)
        )
    }

    private var liveCode: String {
        """
        CardView()
            .shadow(
                color: .black.opacity(0.35),
                radius: \(codeNumber(radius, decimals: 0)),
                x: \(codeNumber(shadowOffset.width, decimals: 0)),
                y: \(codeNumber(shadowOffset.height, decimals: 0))
            )
        """
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            ZStack {
                Path { p in
                    p.move(to: light)
                    p.addLine(to: Self.cardCenter)
                }
                .stroke(
                    .yellow.opacity(0.5),
                    style: StrokeStyle(lineWidth: 1, dash: [4, 4])
                )

                RoundedRectangle(cornerRadius: 12)
                    .fill(.background)
                    .frame(width: 140, height: 90)
                    .position(Self.cardCenter)
                    .shadow(
                        color: .black.opacity(0.35),
                        radius: radius,
                        x: shadowOffset.width,
                        y: shadowOffset.height
                    )

                rawDragHandle(at: light, color: .yellow, systemImage: "sun.max.fill") { location in
                    light = CGPoint(
                        x: min(max(location.x, 12), Self.area.width - 12),
                        y: min(max(location.y, 12), Self.area.height - 12)
                    )
                }
            }
            .frame(width: Self.area.width, height: Self.area.height)
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "Radius") {
                    Slider(value: $radius, in: 0...24, step: 1)
                        .frame(maxWidth: 200)
                    Text(codeNumber(radius, decimals: 0))
                        .monospacedDigit()
                        .foregroundStyle(.secondary)
                }
                Label(
                    "Drag the sun — the shadow falls away from the light.",
                    systemImage: "hand.draw"
                )
                .font(.callout)
                .foregroundStyle(.secondary)
            }
        }
    }
}

// MARK: - Uneven corner radii

struct UnevenCornersDemo: View {
    private static let rect = CGSize(width: 220, height: 130)
    private static let maxRadius: CGFloat = 60

    @State private var topLeading: CGFloat = 28
    @State private var bottomLeading: CGFloat = 0
    @State private var bottomTrailing: CGFloat = 0
    @State private var topTrailing: CGFloat = 28

    private var liveCode: String {
        """
        UnevenRoundedRectangle(
            topLeadingRadius: \(codeNumber(topLeading, decimals: 0)),
            bottomLeadingRadius: \(codeNumber(bottomLeading, decimals: 0)),
            bottomTrailingRadius: \(codeNumber(bottomTrailing, decimals: 0)),
            topTrailingRadius: \(codeNumber(topTrailing, decimals: 0))
        )
        .fill(.indigo.gradient)
        """
    }

    private func clampedRadius(_ value: CGFloat) -> CGFloat {
        min(max(value, 0), Self.maxRadius)
    }

    var body: some View {
        let w = Self.rect.width
        let h = Self.rect.height

        DemoSection(liveCode: liveCode) {
            ZStack {
                UnevenRoundedRectangle(
                    topLeadingRadius: topLeading,
                    bottomLeadingRadius: bottomLeading,
                    bottomTrailingRadius: bottomTrailing,
                    topTrailingRadius: topTrailing
                )
                .fill(.indigo.gradient)

                rawDragHandle(at: CGPoint(x: topLeading, y: topLeading), color: .orange) { loc in
                    topLeading = clampedRadius((loc.x + loc.y) / 2)
                }
                rawDragHandle(at: CGPoint(x: w - topTrailing, y: topTrailing), color: .orange) { loc in
                    topTrailing = clampedRadius(((w - loc.x) + loc.y) / 2)
                }
                rawDragHandle(at: CGPoint(x: bottomLeading, y: h - bottomLeading), color: .orange) { loc in
                    bottomLeading = clampedRadius((loc.x + (h - loc.y)) / 2)
                }
                rawDragHandle(at: CGPoint(x: w - bottomTrailing, y: h - bottomTrailing), color: .orange) { loc in
                    bottomTrailing = clampedRadius(((w - loc.x) + (h - loc.y)) / 2)
                }
            }
            .frame(width: w, height: h)
        } controls: {
            HStack {
                Label(
                    "Drag each orange dot diagonally to round its corner.",
                    systemImage: "hand.draw"
                )
                .font(.callout)
                .foregroundStyle(.secondary)

                Spacer()

                Button("Reset") {
                    topLeading = 28
                    topTrailing = 28
                    bottomLeading = 0
                    bottomTrailing = 0
                }
                .controlSize(.small)
            }
        }
    }
}

// MARK: - Radial gradient geometry

struct RadialCenterDemo: View {
    @State private var center = CGPoint(x: 0.5, y: 0.5)
    @State private var startRadius = 5.0
    @State private var endRadius = 90.0

    private var liveCode: String {
        """
        RadialGradient(
            colors: [.yellow, .orange, .indigo],
            center: \(unitPointCode(center)),
            startRadius: \(codeNumber(startRadius, decimals: 0)),
            endRadius: \(codeNumber(endRadius, decimals: 0))
        )
        """
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            GeometryReader { geo in
                let size = geo.size
                let centerView = CGPoint(x: center.x * size.width, y: center.y * size.height)
                let ringHandle = CGPoint(x: centerView.x + endRadius, y: centerView.y)

                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(RadialGradient(
                            colors: [.yellow, .orange, .indigo],
                            center: UnitPoint(x: center.x, y: center.y),
                            startRadius: startRadius,
                            endRadius: endRadius
                        ))

                    Circle()
                        .stroke(
                            .white.opacity(0.5),
                            style: StrokeStyle(lineWidth: 1, dash: [4, 4])
                        )
                        .frame(width: endRadius * 2, height: endRadius * 2)
                        .position(centerView)

                    dragHandle(at: centerView, color: .green, size: size) { unit in
                        center = snapped(unit)
                    }
                    rawDragHandle(at: ringHandle, color: .orange) { location in
                        let distance = hypot(location.x - centerView.x, location.y - centerView.y)
                        endRadius = min(max(distance, 20), 220)
                    }
                }
                .clipShape(.rect(cornerRadius: 12))
            }
            .frame(width: 250, height: 150)
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "Start radius") {
                    Slider(value: $startRadius, in: 0...50, step: 1)
                        .frame(maxWidth: 200)
                    Text(codeNumber(startRadius, decimals: 0))
                        .monospacedDigit()
                        .foregroundStyle(.secondary)
                }
                Label(
                    "Drag the green center (snaps to named UnitPoints) and the orange dot on the end-radius ring.",
                    systemImage: "hand.draw"
                )
                .font(.callout)
                .foregroundStyle(.secondary)
            }
        }
    }
}

// MARK: - Angular sweep

struct AngularSweepDemo: View {
    private static let diameter: CGFloat = 150
    private static let handleRadius: CGFloat = 62

    @State private var startDegrees = 0.0
    @State private var endDegrees = 300.0

    private var liveCode: String {
        """
        AngularGradient(
            colors: [.blue, .purple, .pink, .orange],
            center: .center,
            startAngle: .degrees(\(codeNumber(startDegrees, decimals: 0))),
            endAngle: .degrees(\(codeNumber(endDegrees, decimals: 0)))
        )
        """
    }

    private func handlePosition(degrees: Double, center: CGPoint) -> CGPoint {
        let radians = degrees * .pi / 180
        return CGPoint(
            x: center.x + cos(radians) * Self.handleRadius,
            y: center.y + sin(radians) * Self.handleRadius
        )
    }

    private func degrees(of location: CGPoint, around center: CGPoint) -> Double {
        var value = atan2(location.y - center.y, location.x - center.x) * 180 / .pi
        if value < 0 { value += 360 }
        return value
    }

    var body: some View {
        let center = CGPoint(x: Self.diameter / 2, y: Self.diameter / 2)

        DemoSection(liveCode: liveCode) {
            ZStack {
                Circle()
                    .fill(AngularGradient(
                        colors: [.blue, .purple, .pink, .orange],
                        center: .center,
                        startAngle: .degrees(startDegrees),
                        endAngle: .degrees(endDegrees)
                    ))

                Path { p in
                    p.move(to: center)
                    p.addLine(to: handlePosition(degrees: startDegrees, center: center))
                    p.move(to: center)
                    p.addLine(to: handlePosition(degrees: endDegrees, center: center))
                }
                .stroke(
                    .white.opacity(0.6),
                    style: StrokeStyle(lineWidth: 1, dash: [3, 3])
                )

                rawDragHandle(
                    at: handlePosition(degrees: startDegrees, center: center),
                    color: .green
                ) { location in
                    startDegrees = degrees(of: location, around: center)
                    if endDegrees < startDegrees { endDegrees += 360 }
                    if endDegrees - startDegrees > 360 { endDegrees -= 360 }
                }
                rawDragHandle(
                    at: handlePosition(degrees: endDegrees.truncatingRemainder(dividingBy: 360), center: center),
                    color: .orange
                ) { location in
                    var value = degrees(of: location, around: center)
                    if value < startDegrees { value += 360 }
                    endDegrees = value
                }
            }
            .frame(width: Self.diameter, height: Self.diameter)
        } controls: {
            Label(
                "Drag the green start and orange end handles to sweep the gradient — the end angle continues past 360° when it wraps.",
                systemImage: "hand.draw"
            )
            .font(.callout)
            .foregroundStyle(.secondary)
        }
    }
}
