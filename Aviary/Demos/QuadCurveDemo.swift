//
//  QuadCurveDemo.swift
//  Aviary
//
//  The flagship demo: drag the start, end, and control points of a
//  quadratic Bézier curve and watch the Path code update live.
//

import SwiftUI

struct QuadCurveDemo: View {
    // Points are stored normalized (0...1) so the demo scales with its frame.
    @State private var start = CGPoint(x: 0.12, y: 0.78)
    @State private var end = CGPoint(x: 0.88, y: 0.78)
    @State private var control = CGPoint(x: 0.5, y: 0.08)

    private var liveCode: String {
        """
        Path { p in
            p.move(to: CGPoint(x: \(fmt(start.x)), y: \(fmt(start.y))))
            p.addQuadCurve(
                to: CGPoint(x: \(fmt(end.x)), y: \(fmt(end.y))),
                control: CGPoint(x: \(fmt(control.x)), y: \(fmt(control.y)))
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
                let c = denormalize(control, in: size)

                ZStack {
                    // Guide lines from the endpoints to the control point.
                    Path { p in
                        p.move(to: s)
                        p.addLine(to: c)
                        p.addLine(to: e)
                    }
                    .stroke(
                        .secondary.opacity(0.5),
                        style: StrokeStyle(lineWidth: 1, dash: [4, 4])
                    )

                    // The curve itself.
                    Path { p in
                        p.move(to: s)
                        p.addQuadCurve(to: e, control: c)
                    }
                    .stroke(.blue, lineWidth: 3)

                    handle(at: s, color: .green, point: $start, in: size)
                    handle(at: e, color: .green, point: $end, in: size)
                    handle(at: c, color: .orange, point: $control, in: size)

                    Text("control")
                        .font(.caption2)
                        .foregroundStyle(.orange)
                        .position(x: c.x, y: max(c.y - 18, 8))
                }
            }
            .frame(height: 230)
        } controls: {
            Label(
                "Drag the green end points and the orange control point.",
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
