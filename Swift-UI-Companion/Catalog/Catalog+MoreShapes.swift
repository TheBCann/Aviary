//
//  Catalog+MoreShapes.swift
//  Swift-UI-Companion
//
//  Second wave of shape entries.
//

import Foundation

extension Catalog {
    static let moreShapes: [Topic] = [
        Topic(
            name: "AnyShape",
            kind: .shape,
            summary: "Type-erases a shape for heterogeneous storage.",
            discussion: "AnyShape wraps any Shape behind one concrete type, so a property or collection can hold circles and rectangles interchangeably. The trade-off mirrors AnyView: flexibility for diffing detail.",
            wwdcYear: 2022,
            code: #"""
            var badge: AnyShape {
                isRound ? AnyShape(Circle()) : AnyShape(Capsule())
            }

            content.clipShape(badge)
            """#,
            related: ["Shape", "AnyView"]
        ),
        Topic(
            name: "ButtonBorderShape",
            kind: .shape,
            summary: "The border silhouette bordered buttons use.",
            discussion: "ButtonBorderShape feeds the buttonBorderShape modifier to round bordered-style buttons as capsules, rounded rectangles, or circles — restyling system buttons without a custom ButtonStyle.",
            wwdcYear: 2021,
            code: #"""
            Button("Continue") { next() }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
            """#,
            related: ["Button", ".buttonStyle()", "Capsule"]
        ),
        Topic(
            name: "RotatedShape",
            kind: .shape,
            summary: "A shape rotated by a fixed angle.",
            discussion: "RotatedShape wraps another shape and rotates its path around an anchor — unlike rotationEffect, the result is still a Shape, so it can be filled, stroked, or used as a clip.",
            wwdcYear: 2019,
            code: #"""
            RotatedShape(shape: Rectangle(), angle: .degrees(45))
                .fill(.orange)
                .frame(width: 100, height: 100)
            """#,
            related: ["Shape", ".rotationEffect()"]
        ),
        Topic(
            name: ".addArc()",
            kind: .shape,
            summary: "Appends a circular arc to a path.",
            discussion: "addArc sweeps from a start to an end angle around a center and radius — pie slices, ring segments, and rounded corners built by hand. Mind the clockwise flag: SwiftUI's flipped y-axis makes it read backwards.",
            wwdcYear: 2019,
            code: #"""
            Path { p in
                p.move(to: center)
                p.addArc(center: center, radius: 60,
                         startAngle: .degrees(0),
                         endAngle: .degrees(120),
                         clockwise: false)
                p.closeSubpath()
            }
            .fill(.teal)
            """#,
            demoID: "arc",
            related: ["Path", ".addQuadCurve()", ".addCurve()"]
        ),
        Topic(
            name: ".addCurve()",
            kind: .shape,
            summary: "Appends a cubic Bézier curve with two control points.",
            discussion: "Where a quadratic curve bends around one control point, addCurve uses two — enough freedom for S-curves and smooth waveforms in a single segment. Chain segments and match tangents for continuous curves.",
            wwdcYear: 2019,
            code: #"""
            Path { p in
                p.move(to: CGPoint(x: 20, y: 100))
                p.addCurve(
                    to: CGPoint(x: 220, y: 100),
                    control1: CGPoint(x: 80, y: 20),
                    control2: CGPoint(x: 160, y: 180)
                )
            }
            .stroke(.purple, lineWidth: 3)
            """#,
            demoID: "cubicCurve",
            related: [".addQuadCurve()", "Path"]
        ),
    ]
}
