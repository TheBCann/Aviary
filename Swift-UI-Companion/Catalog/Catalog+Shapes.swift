//
//  Catalog+Shapes.swift
//  Swift-UI-Companion
//

import Foundation

extension Catalog {
    static let shapes: [Topic] = [
        Topic(
            name: "Rectangle",
            kind: .shape,
            summary: "A rectangle filling its frame.",
            discussion: "Rectangle draws edge to edge in whatever space it is offered — a building block for backgrounds, bars, and custom controls. Like every shape it can be filled, stroked, or used as a clip mask.",
            wwdcYear: 2019,
            code: #"""
            Rectangle()
                .fill(.teal.gradient)
                .frame(width: 160, height: 60)
            """#,
            related: ["RoundedRectangle", "Circle", "Shape"]
        ),
        Topic(
            name: "RoundedRectangle",
            kind: .shape,
            summary: "A rectangle with uniformly rounded corners.",
            discussion: "RoundedRectangle takes a corner radius or size, and a style — .continuous produces the smooth Apple-squircle curvature. The static shorthand .rect(cornerRadius:) makes it concise at clipShape and background call sites.",
            wwdcYear: 2019,
            code: #"""
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(.blue, lineWidth: 3)
                .frame(width: 160, height: 90)
            """#,
            demoID: "roundedRect",
            related: ["UnevenRoundedRectangle", "Capsule", ".clipShape()"],
            children: [
                TopicChild(
                    name: "RoundedRectangle(cornerRadius:style:)",
                    summary: "One radius shared by all four corners.",
                    discussion: "The common form: a single CGFloat radius, with .continuous smoothing the transition where the curve meets the straight edge.",
                    code: #"""
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.blue.opacity(0.3))
                        .frame(width: 140, height: 80)
                    """#
                ),
                TopicChild(
                    name: "RoundedRectangle(cornerSize:style:)",
                    summary: "A CGSize radius, so corners can curve unequally per axis.",
                    discussion: "Giving the corner different width and height values produces elliptical corners — wider than they are tall, or the reverse.",
                    code: #"""
                    RoundedRectangle(cornerSize: CGSize(width: 30, height: 12))
                        .stroke(.orange, lineWidth: 2)
                        .frame(width: 140, height: 80)
                    """#
                ),
            ]
        ),
        Topic(
            name: "UnevenRoundedRectangle",
            kind: .shape,
            summary: "A rectangle with a different radius per corner.",
            discussion: "Added at WWDC '22, UnevenRoundedRectangle rounds each corner independently — handy for tab-like cards and attached panels where only the top edge curves.",
            wwdcYear: 2022,
            code: #"""
            UnevenRoundedRectangle(
                topLeadingRadius: 20,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 20
            )
            .fill(.indigo)
            .frame(width: 160, height: 80)
            """#,
            related: ["RoundedRectangle"]
        ),
        Topic(
            name: "Circle",
            kind: .shape,
            summary: "A circle inscribed in its frame.",
            discussion: "Circle sizes itself to the smaller of its offered dimensions, staying perfectly round. It is the standard avatar mask and the basis of ring-style progress indicators via trimmed strokes.",
            wwdcYear: 2019,
            code: #"""
            Circle()
                .trim(from: 0, to: 0.72)
                .stroke(.green, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .frame(width: 80, height: 80)
            """#,
            demoID: "trimRing",
            related: ["Ellipse", "Capsule", ".clipShape()"]
        ),
        Topic(
            name: "Ellipse",
            kind: .shape,
            summary: "An ellipse stretched to fill its frame.",
            discussion: "Ellipse is Circle without the aspect-ratio guarantee: it fills both offered dimensions, producing an oval whenever they differ.",
            wwdcYear: 2019,
            code: #"""
            Ellipse()
                .fill(.orange.opacity(0.6))
                .frame(width: 160, height: 90)
            """#,
            related: ["Circle"]
        ),
        Topic(
            name: "Capsule",
            kind: .shape,
            summary: "A rectangle whose short sides are full semicircles.",
            discussion: "Capsule rounds its corners to half of the shorter dimension, giving the classic pill silhouette used for tags, badges, and prominent buttons.",
            wwdcYear: 2019,
            code: #"""
            Text("NEW")
                .font(.caption.bold())
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(.pink, in: .capsule)
                .foregroundStyle(.white)
            """#,
            related: ["RoundedRectangle", "Circle"]
        ),
        Topic(
            name: "Path",
            kind: .shape,
            summary: "An arbitrary outline built from lines, arcs, and curves.",
            discussion: "Path is the raw geometry type behind every shape: move a point, add lines, arcs, and Bézier curves, then fill or stroke the result. Custom Shape types build their output in a Path so it can scale to any rect.",
            wwdcYear: 2019,
            code: #"""
            Path { p in
                p.move(to: CGPoint(x: 20, y: 80))
                p.addLine(to: CGPoint(x: 70, y: 20))
                p.addQuadCurve(
                    to: CGPoint(x: 180, y: 80),
                    control: CGPoint(x: 130, y: 120)
                )
            }
            .stroke(.blue, lineWidth: 3)
            """#,
            demoID: "quadCurve",
            related: [".addQuadCurve()", "Shape", "Canvas"],
            children: [
                TopicChild(
                    name: "Path(_:)",
                    summary: "Builds a path imperatively inside a closure.",
                    discussion: "The closure receives an inout Path to mutate — the usual way to sketch one-off geometry inline in a view body.",
                    code: #"""
                    Path { p in
                        p.move(to: CGPoint(x: 0, y: 40))
                        p.addLine(to: CGPoint(x: 120, y: 0))
                        p.addLine(to: CGPoint(x: 120, y: 80))
                        p.closeSubpath()
                    }
                    .fill(.mint)
                    """#
                ),
                TopicChild(
                    name: "Path(ellipseIn:)",
                    summary: "A ready-made ellipse path fitted to a rect.",
                    code: #"""
                    Path(ellipseIn: CGRect(x: 0, y: 0, width: 120, height: 70))
                        .stroke(.purple, lineWidth: 2)
                    """#
                ),
                TopicChild(
                    name: "Path(roundedRect:cornerRadius:style:)",
                    summary: "A rounded-rectangle path with one uniform radius.",
                    code: #"""
                    Path(roundedRect: CGRect(x: 0, y: 0, width: 140, height: 80),
                         cornerRadius: 14, style: .continuous)
                        .fill(.teal.opacity(0.4))
                    """#
                ),
                TopicChild(
                    name: "move(to:)",
                    summary: "Starts a new subpath at a point without drawing.",
                    discussion: "Think pen-up: nothing is stroked until a segment follows. Every subpath begins with a move.",
                    code: #"""
                    Path { p in
                        p.move(to: CGPoint(x: 20, y: 60))
                        p.addLine(to: CGPoint(x: 100, y: 20))
                    }
                    .stroke(.blue, lineWidth: 2)
                    """#
                ),
                TopicChild(
                    name: "addLine(to:)",
                    summary: "Draws a straight segment from the current point.",
                    code: #"""
                    Path { p in
                        p.move(to: .zero)
                        p.addLine(to: CGPoint(x: 80, y: 0))
                        p.addLine(to: CGPoint(x: 80, y: 80))
                    }
                    .stroke(.indigo, lineWidth: 2)
                    """#
                ),
            ]
        ),
        Topic(
            name: ".addQuadCurve()",
            kind: .shape,
            summary: "Appends a quadratic Bézier curve to a path.",
            discussion: "A quadratic curve bends from the current point to an end point, pulled toward a single control point — the curve touches neither the control point nor the straight line, but stays inside their triangle. Drag the points in the demo to feel how the control point steers the arc.",
            wwdcYear: 2019,
            code: #"""
            Path { p in
                p.move(to: start)
                p.addQuadCurve(to: end, control: control)
            }
            .stroke(.blue, lineWidth: 3)
            """#,
            demoID: "quadCurve",
            related: ["Path", "Shape"]
        ),
        Topic(
            name: "ContainerRelativeShape",
            kind: .shape,
            summary: "Echoes the containing shape, inset appropriately.",
            discussion: "Inside a container that defines a shape — most notably widgets — ContainerRelativeShape produces a concentric version of it, keeping nested corner radii optically correct without hardcoding values.",
            wwdcYear: 2020,
            code: #"""
            ZStack {
                ContainerRelativeShape()
                    .fill(.blue.opacity(0.2))
                Text("Widget content")
            }
            .padding(8)
            """#,
            related: ["RoundedRectangle"]
        ),
    ]
}
