//
//  Examples+Shapes.swift
//  Aviary
//
//  Rendered usage examples for the entries in CatalogData/shapes.json.
//  Entries that already have an interactive demo (.addArc(), .addCurve(),
//  .addQuadCurve(), Circle, Path, RoundedRectangle, UnevenRoundedRectangle)
//  are not repeated here.
//

import SwiftUI

enum ExamplesShapes {
    static let entries: [ExampleEntry] = [
        ExampleEntry(topic: "AnyShape", code: """
        var badge: AnyShape {
            isRound ? AnyShape(Circle()) : AnyShape(Capsule())
        }
        let stored: [AnyShape] = [AnyShape(Circle()), AnyShape(Capsule()),
                                  AnyShape(RoundedRectangle(cornerRadius: 8))]

        LinearGradient(colors: [.pink, .orange], startPoint: .leading, endPoint: .trailing)
            .frame(width: 140, height: 60)
            .clipShape(badge)
        Toggle("Round", isOn: $isRound)
        ForEach(stored.indices, id: \\.self) { i in stored[i].fill(.teal).frame(width: 56, height: 36) }
        """) { AnyView(Sh_AnyShapeExample()) },

        ExampleEntry(topic: "ButtonBorderShape", code: """
        Button("Follow") { follow() }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)

        Button("Add to Cart") { addToCart() }
            .buttonStyle(.bordered)
            .buttonBorderShape(.roundedRectangle(radius: 6))

        Button { toggleMute() } label: { Image(systemName: "speaker.slash") }
            .buttonStyle(.bordered)
            .buttonBorderShape(.circle)
        """) { AnyView(Sh_ButtonBorderShapeExample()) },

        ExampleEntry(topic: "Capsule", code: """
        Text("NEW")
            .font(.caption.bold())
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(.pink, in: .capsule)
            .foregroundStyle(.white)

        Capsule(style: .continuous)
            .fill(.blue.gradient)
            .frame(width: 160, height: height)
        Slider(value: $height, in: 16...80) { Text("Height") }
        """) { AnyView(Sh_CapsuleExample()) },

        ExampleEntry(topic: "ContainerRelativeShape", code: """
        ZStack {
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(.blue.opacity(0.15))
            ZStack {
                ContainerRelativeShape()
                    .fill(.blue.opacity(0.35))
                Text("Concentric inset")
            }
            .padding(14)
        }
        .containerShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .frame(width: 240, height: 120)
        """) { AnyView(Sh_ContainerRelativeShapeExample()) },

        ExampleEntry(topic: "Ellipse", code: """
        HStack(spacing: 24) {
            Ellipse()
                .fill(.orange.opacity(0.6))
                .frame(width: 160, height: 90)
                .border(.secondary)
            Circle()
                .fill(.orange.opacity(0.6))
                .frame(width: 160, height: 90)
                .border(.secondary)
        }
        """) { AnyView(Sh_EllipseExample()) },

        ExampleEntry(topic: "Rectangle", code: """
        let values: [CGFloat] = [40, 90, 60, 110, 75]

        VStack(spacing: 0) {
            HStack(alignment: .bottom, spacing: 8) {
                ForEach(values, id: \\.self) { value in
                    Rectangle()
                        .fill(.teal.gradient)
                        .frame(width: 28, height: value)
                }
            }
            Rectangle().fill(.secondary).frame(width: 172, height: 1)
        }
        """) { AnyView(Sh_RectangleExample()) },

        ExampleEntry(topic: "RotatedShape", code: """
        ZStack {
            Rectangle()
                .stroke(.secondary, style: StrokeStyle(lineWidth: 1, dash: [4]))
            RotatedShape(shape: Rectangle(), angle: .degrees(angle))
                .fill(.orange.opacity(0.8))
        }
        .frame(width: 90, height: 90)

        Slider(value: $angle, in: 0...180) { Text("Angle") }
        """) { AnyView(Sh_RotatedShapeExample()) },
    ]
}

// MARK: - AnyShape

private struct Sh_AnyShapeExample: View {
    @State private var isRound = false

    private let stored: [AnyShape] = [
        AnyShape(Circle()), AnyShape(Capsule()),
        AnyShape(RoundedRectangle(cornerRadius: 8)),
    ]

    private var badge: AnyShape {
        isRound ? AnyShape(Circle()) : AnyShape(Capsule())
    }

    var body: some View {
        VStack(spacing: 14) {
            HStack(spacing: 24) {
                LinearGradient(colors: [.pink, .orange], startPoint: .leading, endPoint: .trailing)
                    .frame(width: 140, height: 60)
                    .clipShape(badge)

                Toggle("Round", isOn: $isRound)
                    .toggleStyle(.switch)
                    .fixedSize()
            }

            HStack(spacing: 12) {
                ForEach(stored.indices, id: \.self) { i in
                    stored[i].fill(.teal).frame(width: 56, height: 36)
                }
            }

            Text("One property switches shapes; one array holds three shape types")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - ButtonBorderShape

private struct Sh_ButtonBorderShapeExample: View {
    var body: some View {
        HStack(alignment: .top, spacing: 28) {
            VStack(spacing: 8) {
                Button("Follow") {}
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                caption(".capsule")
            }

            VStack(spacing: 8) {
                Button("Add to Cart") {}
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle(radius: 6))
                caption(".roundedRectangle(radius: 6)")
            }

            VStack(spacing: 8) {
                Button {} label: {
                    Image(systemName: "speaker.slash")
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.circle)
                caption(".circle")
            }
        }
        .controlSize(.large)
    }

    private func caption(_ text: String) -> some View {
        Text(text)
            .font(.caption2.monospaced())
            .foregroundStyle(.secondary)
    }
}

// MARK: - Capsule

private struct Sh_CapsuleExample: View {
    @State private var height: CGFloat = 44

    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 10) {
                Text("NEW")
                    .font(.caption.bold())
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(.pink, in: .capsule)
                    .foregroundStyle(.white)

                Text("Beta")
                    .font(.caption.bold())
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(.yellow, in: .capsule)
            }

            Capsule(style: .continuous)
                .fill(.blue.gradient)
                .frame(width: 160, height: height)

            Slider(value: $height, in: 16...80) { Text("Height") }
                .frame(width: 220)

            Text("The corner radius is always half the shorter side")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - ContainerRelativeShape

private struct Sh_ContainerRelativeShapeExample: View {
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .fill(.blue.opacity(0.15))
                ZStack {
                    ContainerRelativeShape()
                        .fill(.blue.opacity(0.35))
                    Text("Concentric inset")
                        .font(.callout.weight(.medium))
                }
                .padding(14)
            }
            .containerShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
            .frame(width: 240, height: 120)

            Text("Here .containerShape() defines the outer shape; widgets supply it automatically")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Ellipse

private struct Sh_EllipseExample: View {
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 24) {
                Ellipse()
                    .fill(.orange.opacity(0.6))
                    .frame(width: 160, height: 90)
                    .border(.secondary)
                Circle()
                    .fill(.orange.opacity(0.6))
                    .frame(width: 160, height: 90)
                    .border(.secondary)
            }

            HStack(spacing: 24) {
                caption("Ellipse fills the 160 x 90 frame")
                caption("Circle in the same frame stays 90 x 90")
            }
        }
    }

    private func caption(_ text: String) -> some View {
        Text(text)
            .font(.caption2)
            .foregroundStyle(.secondary)
            .frame(width: 160)
    }
}

// MARK: - Rectangle

private struct Sh_RectangleExample: View {
    private let values: [CGFloat] = [40, 90, 60, 110, 75]

    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 0) {
                HStack(alignment: .bottom, spacing: 8) {
                    ForEach(values, id: \.self) { value in
                        Rectangle()
                            .fill(.teal.gradient)
                            .frame(width: 28, height: value)
                    }
                }
                Rectangle().fill(.secondary).frame(width: 172, height: 1)
            }

            Text("Bars and the baseline are all plain Rectangles")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - RotatedShape

private struct Sh_RotatedShapeExample: View {
    @State private var angle: Double = 45

    var body: some View {
        VStack(spacing: 14) {
            ZStack {
                Rectangle()
                    .stroke(.secondary, style: StrokeStyle(lineWidth: 1, dash: [4]))
                RotatedShape(shape: Rectangle(), angle: .degrees(angle))
                    .fill(.orange.opacity(0.8))
            }
            .frame(width: 90, height: 90)

            Slider(value: $angle, in: 0...180) { Text("Angle") }
                .frame(width: 220)

            Text("\(Int(angle.rounded()))° — the dashed square is the unrotated frame")
                .font(.caption2)
                .foregroundStyle(.secondary)
                .monospacedDigit()
        }
    }
}
