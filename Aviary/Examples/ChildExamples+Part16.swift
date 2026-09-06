//
//  ChildExamples+Part16.swift
//  Aviary
//
//  Compiled renderings for variant entries (part 16: gen-drawing).
//  One private C16_* struct per variant; every rendering exercises the exact
//  overload the variant names, so siblings can be compared side by side.
//

import SwiftUI
import AppKit
import CoreGraphics

enum ChildExamplesPart16 {
    static let entries: [ChildExampleEntry] = [

        // MARK: .border()

        ChildExampleEntry(parent: ".border()", child: ".border(_:)", code: """
        VStack(alignment: .leading) {
            Text("Row").border(.secondary)
            Label("Detail", systemImage: "info.circle").border(.secondary)
        }
        .padding(8)
        .border(.secondary)                     // width defaults to 1 point
        """) { AnyView(C16_BorderDefaultExample()) },

        ChildExampleEntry(parent: ".border()", child: ".border(_:width:)", code: """
        Text("DRAFT")
            .padding(6)
            .border(.red, width: width)          // 0.5 … 8 points
        Slider(value: $width, in: 0.5...8)
        """) { AnyView(C16_BorderWidthExample()) },

        // MARK: .strokeBorder()

        ChildExampleEntry(parent: ".strokeBorder()", child: ".strokeBorder(_:lineWidth:)", code: """
        Circle()
            .strokeBorder(.teal, lineWidth: 12)  // inset: the stroke stays inside the frame
            .frame(width: 100, height: 100)

        Circle()
            .stroke(.teal, lineWidth: 12)        // centered: half of it spills outside
            .frame(width: 100, height: 100)
        """) { AnyView(C16_StrokeBorderLineWidthExample()) },

        ChildExampleEntry(parent: ".strokeBorder()", child: ".strokeBorder(_:style:)", code: """
        RoundedRectangle(cornerRadius: 16)
            .strokeBorder(.orange, style: StrokeStyle(lineWidth: 4, dash: [10, 6]))
            .frame(width: 160, height: 80)

        RoundedRectangle(cornerRadius: 16)
            .strokeBorder(.orange, style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: [1, 10]))
            .frame(width: 160, height: 80)
        """) { AnyView(C16_StrokeBorderStyleExample()) },

        ChildExampleEntry(parent: ".strokeBorder()", child: ".strokeBorder(style:)", code: """
        Capsule()
            .strokeBorder(style: StrokeStyle(lineWidth: 3))
            .foregroundStyle(.tint)              // no explicit style → inherits the foreground
            .tint(tint)
        """) { AnyView(C16_StrokeBorderStyleOnlyExample()) },

        // MARK: .symbolVariant()

        ChildExampleEntry(parent: ".symbolVariant()", child: "SymbolVariants", code: """
        Image(systemName: "person")
            .symbolVariant(SymbolVariants.none)
        Image(systemName: "person")
            .symbolVariant(SymbolVariants.circle)
        Image(systemName: "person")
            .symbolVariant(SymbolVariants.circle.fill)   // chain properties to compose
        Image(systemName: "person")
            .symbolVariant(SymbolVariants.square.fill)
        """) { AnyView(C16_SymbolVariantsTypeExample()) },

        ChildExampleEntry(parent: ".symbolVariant()", child: "SymbolVariants.fill", code: """
        Image(systemName: "heart")
            .symbolVariant(isLiked ? .fill : .none)

        Label("Favorites", systemImage: "star")
            .symbolVariant(.fill)                // applies to every symbol underneath
        """) { AnyView(C16_SymbolVariantsFillExample()) },

        ChildExampleEntry(parent: ".symbolVariant()", child: "SymbolVariants.slash", code: """
        Image(systemName: "bell")
            .symbolVariant(isMuted ? .slash : .none)
        Image(systemName: "speaker.wave.2")
            .symbolVariant(isMuted ? .slash : .none)
        Toggle("Muted", isOn: $isMuted)
        """) { AnyView(C16_SymbolVariantsSlashExample()) },

        ChildExampleEntry(parent: ".symbolVariant()", child: "SymbolVariants.circle", code: """
        Image(systemName: "plus")
            .symbolVariant(.circle)              // outlined enclosure

        Image(systemName: "plus")
            .symbolVariant(.circle.fill)         // chained: solid badge
        """) { AnyView(C16_SymbolVariantsCircleExample()) },

        // MARK: Color

        ChildExampleEntry(parent: "Color", child: "Color(hue:saturation:brightness:opacity:)", code: """
        HStack(spacing: 4) {
            ForEach(0..<12) { i in
                Circle().fill(Color(hue: Double(i) / 12, saturation: saturation, brightness: 0.9))
            }
        }
        Slider(value: $saturation, in: 0...1)
        """) { AnyView(C16_ColorHSBExample()) },

        ChildExampleEntry(parent: "Color", child: "Color(uiColor:)", code: """
        // iOS · tvOS · watchOS
        let background = Color(uiColor: .secondarySystemBackground)
        let label = Color(uiColor: .label)      // stays dynamic: flips with dark mode

        RoundedRectangle(cornerRadius: 8)
            .fill(background)
            .overlay(Text("Label").foregroundStyle(label))
        """) { AnyView(C16_ColorUIColorExample()) },

        ChildExampleEntry(parent: "Color", child: "Color.accentColor", code: """
        HStack {
            Image(systemName: "checkmark.seal.fill").foregroundStyle(Color.accentColor)
            Button("Default") { }
        }
        HStack {                                 // the same pair inside .tint(.orange)
            Image(systemName: "checkmark.seal.fill").foregroundStyle(Color.accentColor)
            Button("Tinted") { }
        }
        .tint(.orange)
        """) { AnyView(C16_ColorAccentExample()) },

        ChildExampleEntry(parent: "Color", child: "Color(red:green:blue:opacity:)", code: """
        let brand = Color(red: red, green: green, blue: blue)   // sRGB components, 0…1
        Capsule()
            .fill(brand)
        Slider(value: $red, in: 0...1)
        Slider(value: $green, in: 0...1)
        Slider(value: $blue, in: 0...1)
        """) { AnyView(C16_ColorRGBExample()) },

        // MARK: Color.Resolved

        ChildExampleEntry(parent: "Color.Resolved", child: "Color.Resolved(red:green:blue:opacity:)", code: """
        let magenta = Color.Resolved(red: 0.9, green: 0.1, blue: 0.6, opacity: Float(opacity))
        Rectangle()
            .fill(Color(magenta))                // Color(_:) wraps the resolved value back up
        Text("R \\(magenta.red)  G \\(magenta.green)  B \\(magenta.blue)")
        """) { AnyView(C16_ColorResolvedInitExample()) },

        ChildExampleEntry(parent: "Color.Resolved", child: "Color.Resolved.cgColor", code: """
        @Environment(\\.self) private var environment

        Canvas { context, size in
            let resolved = Color.orange.resolve(in: environment)
            context.withCGContext { cg in
                cg.setFillColor(resolved.cgColor)        // Core Graphics wants a CGColor
                cg.fillEllipse(in: CGRect(origin: .zero, size: size))
            }
        }
        """) { AnyView(C16_ColorResolvedCGColorExample()) },

        ChildExampleEntry(parent: "Color.Resolved", child: "Color.Resolved.linearRed", code: """
        let resolved = swatch.resolve(in: environment)
        let luminance = 0.2126 * resolved.linearRed
                      + 0.7152 * resolved.linearGreen
                      + 0.0722 * resolved.linearBlue     // gamma removed → correct weighting
        Text(luminance > 0.35 ? "Dark label" : "Light label")
            .foregroundStyle(luminance > 0.35 ? .black : .white)
        """) { AnyView(C16_ColorResolvedLinearExample()) },

        // MARK: EllipticalGradient

        ChildExampleEntry(parent: "EllipticalGradient", child: "EllipticalGradient(colors:center:startRadiusFraction:endRadiusFraction:)", code: """
        Ellipse()
            .fill(EllipticalGradient(colors: [.yellow, .orange, .red],
                                     center: .center,
                                     startRadiusFraction: 0,
                                     endRadiusFraction: endRadius))
            .frame(width: 200, height: 100)
        Slider(value: $endRadius, in: 0.2...1)
        """) { AnyView(C16_EllipticalColorsExample()) },

        ChildExampleEntry(parent: "EllipticalGradient", child: "EllipticalGradient(stops:center:startRadiusFraction:endRadiusFraction:)", code: """
        Rectangle()
            .fill(EllipticalGradient(stops: [
                .init(color: .white, location: 0),
                .init(color: .blue, location: 0.8),     // long white core, short blue rim
                .init(color: .indigo, location: 1)
            ], center: .center, startRadiusFraction: 0, endRadiusFraction: 0.5))
            .frame(width: 200, height: 100)
        """) { AnyView(C16_EllipticalStopsExample()) },

        ChildExampleEntry(parent: "EllipticalGradient", child: "EllipticalGradient(gradient:center:startRadiusFraction:endRadiusFraction:)", code: """
        let g = Gradient(colors: [.pink, .purple])       // one reusable value

        Circle()
            .fill(EllipticalGradient(gradient: g, center: .topLeading, endRadiusFraction: 0.9))
        Capsule()
            .fill(EllipticalGradient(gradient: g, center: .center, endRadiusFraction: 0.6))
        """) { AnyView(C16_EllipticalGradientValueExample()) },

        // MARK: Gradient

        ChildExampleEntry(parent: "Gradient", child: "Gradient.Stop", code: """
        let stop = Gradient.Stop(color: .cyan, location: location)   // color + 0…1 position
        let g = Gradient(stops: [
            Gradient.Stop(color: .indigo, location: 0),
            stop,
            Gradient.Stop(color: .white, location: 1)
        ])
        Rectangle().fill(LinearGradient(gradient: g, startPoint: .leading, endPoint: .trailing))
        Slider(value: $location, in: 0...1)
        """) { AnyView(C16_GradientStopExample()) },

        ChildExampleEntry(parent: "Gradient", child: "Gradient(colors:)", code: """
        let g = Gradient(colors: [.blue, .cyan, .green])   // stops spaced evenly: 0, 0.5, 1

        Rectangle().fill(LinearGradient(gradient: g, startPoint: .leading, endPoint: .trailing))
        Circle().fill(RadialGradient(gradient: g, center: .center, startRadius: 0, endRadius: 36))
        Circle().fill(AngularGradient(gradient: g, center: .center))
        """) { AnyView(C16_GradientColorsExample()) },

        ChildExampleEntry(parent: "Gradient", child: "Gradient(stops:)", code: """
        let heat = Gradient(stops: [
            .init(color: .blue, location: 0),
            .init(color: .yellow, location: 0.65),       // uneven: yellow arrives late
            .init(color: .red, location: 1)
        ])
        Rectangle().fill(LinearGradient(gradient: heat, startPoint: .leading, endPoint: .trailing))
        """) { AnyView(C16_GradientStopsExample()) },

        // MARK: GraphicsContext

        ChildExampleEntry(parent: "GraphicsContext", child: "GraphicsContext.Shading", code: """
        Canvas { context, size in
            let disk = Path(ellipseIn: CGRect(origin: .zero, size: size))
            context.fill(disk, with: .conicGradient(
                Gradient(colors: [.purple, .blue, .purple]),
                center: CGPoint(x: size.width / 2, y: size.height / 2)
            ))
            context.stroke(disk, with: .color(.white), lineWidth: 3)
        }
        """) { AnyView(C16_GraphicsContextShadingExample()) },

        ChildExampleEntry(parent: "GraphicsContext", child: "GraphicsContext.Filter", code: """
        Canvas { context, size in
            context.addFilter(.shadow(radius: 4, y: 2))
            context.addFilter(.hueRotation(.degrees(hue)))   // both apply to everything drawn after
            context.fill(Path(roundedRect: box, cornerRadius: 12), with: .color(.orange))
            context.fill(Path(ellipseIn: dot), with: .color(.blue))
        }
        Slider(value: $hue, in: 0...360)
        """) { AnyView(C16_GraphicsContextFilterExample()) },

        ChildExampleEntry(parent: "GraphicsContext", child: "GraphicsContext.drawLayer(content:)", code: """
        Canvas { context, size in
            context.drawLayer { layer in
                layer.addFilter(.blur(radius: 3))        // fenced inside the layer
                layer.fill(circle, with: .color(.mint))
            }
            context.fill(square, with: .color(.pink))    // still sharp: the filter never leaked
        }
        """) { AnyView(C16_GraphicsContextDrawLayerExample()) },

        // MARK: HierarchicalShapeStyle

        ChildExampleEntry(parent: "HierarchicalShapeStyle", child: "HierarchicalShapeStyle.secondary", code: """
        VStack(alignment: .leading) {
            Text("Album").foregroundStyle(.primary)
            Text("Artist · 2024").foregroundStyle(.secondary)
        }

        VStack(alignment: .leading) {            // levels derive from the current foreground
            Text("Album").foregroundStyle(.primary)
            Text("Artist · 2024").foregroundStyle(.secondary)
        }
        .foregroundStyle(.blue)
        """) { AnyView(C16_HierarchicalSecondaryExample()) },

        ChildExampleEntry(parent: "HierarchicalShapeStyle", child: "HierarchicalShapeStyle.tertiary", code: """
        HStack {
            Text("Draft")
            Image(systemName: "circle.fill").font(.system(size: 5)).foregroundStyle(.tertiary)
            Text("Edited")
            Image(systemName: "circle.fill").font(.system(size: 5)).foregroundStyle(.tertiary)
            Text("Sent").foregroundStyle(.tertiary)
        }
        """) { AnyView(C16_HierarchicalTertiaryExample()) },

        ChildExampleEntry(parent: "HierarchicalShapeStyle", child: "HierarchicalShapeStyle.quinary", code: """
        Label("Search", systemImage: "magnifyingglass")
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 8).fill(.quinary))   // barely-there backing
        """) { AnyView(C16_HierarchicalQuinaryExample()) },

        // MARK: ImageRenderer

        ChildExampleEntry(parent: "ImageRenderer", child: "ImageRenderer(content:)", code: """
        @Environment(\\.displayScale) private var displayScale

        let renderer = ImageRenderer(content: BadgeView(score: 92))
        renderer.scale = displayScale            // match the screen's pixel density
        if let cg = renderer.cgImage {
            rendered = Image(decorative: cg, scale: displayScale)
        }
        """) { AnyView(C16_ImageRendererContentExample()) },

        ChildExampleEntry(parent: "ImageRenderer", child: "ImageRenderer.cgImage", code: """
        let renderer = ImageRenderer(content: card)
        renderer.scale = scale                   // 1, 2 or 3
        if let cg = renderer.cgImage {           // CGImage? — nil if rendering fails
            pixelSize = "\\(cg.width) × \\(cg.height) px"
            thumbnail = Image(decorative: cg, scale: scale)
        }
        """) { AnyView(C16_ImageRendererCGImageExample()) },

        ChildExampleEntry(parent: "ImageRenderer", child: "ImageRenderer.render(rasterizationScale:renderer:)", code: """
        renderer.render(rasterizationScale: 2) { size, drawInContext in
            guard let cg = CGContext(data: nil, width: Int(size.width * 2), height: Int(size.height * 2),
                                     bitsPerComponent: 8, bytesPerRow: 0,
                                     space: CGColorSpaceCreateDeviceRGB(),
                                     bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else { return }
            cg.scaleBy(x: 2, y: 2)
            drawInContext(cg)                    // same callback feeds CGContext(url:mediaBox:nil) for PDF
            bitmap = cg.makeImage()
        }
        """) { AnyView(C16_ImageRendererRenderExample()) },

        // MARK: Shader

        ChildExampleEntry(parent: "Shader", child: "Shader.Argument", code: """
        let shader = ShaderLibrary.tint(
            .color(.mint),                       // → half4 in Metal
            .float(strength),                    // → float
            .boundingRect                        // → float4 (x, y, width, height)
        )
        image.colorEffect(shader)
        """) { AnyView(C16_ShaderArgumentExample()) },

        ChildExampleEntry(parent: "Shader", child: "Shader.Argument.float(_:)", code: """
        TimelineView(.animation) { timeline in
            let elapsed = timeline.date.timeIntervalSince(start)
            Text("Making Waves")
                .distortionEffect(ShaderLibrary.wave(.float(elapsed)),   // one scalar, every frame
                                  maxSampleOffset: CGSize(width: 0, height: 12))
        }
        """) { AnyView(C16_ShaderArgumentFloatExample()) },

        ChildExampleEntry(parent: "Shader", child: "Shader.Argument.color(_:)", code: """
        let effect = ShaderLibrary.duotone(.color(dark), .color(light))   // each resolves to RGBA
        portrait.colorEffect(effect)
        """) { AnyView(C16_ShaderArgumentColorExample()) },

        ChildExampleEntry(parent: "Shader", child: "Shader.Argument.boundingRect", code: """
        let shader = ShaderLibrary.radialFade(.boundingRect)   // float4 → normalized UVs in Metal
        image.colorEffect(shader)
        """) { AnyView(C16_ShaderArgumentBoundingRectExample()) },

        // MARK: ShaderLibrary

        ChildExampleEntry(parent: "ShaderLibrary", child: "ShaderFunction", code: """
        let fn = ShaderFunction(library: .default, name: "wave")   // one named Metal entry point
        let shader = fn(.float(amplitude), .float(frequency))      // calling it binds arguments
        Slider(value: $amplitude, in: 0...20)
        Slider(value: $frequency, in: 1...6)
        """) { AnyView(C16_ShaderFunctionExample()) },

        ChildExampleEntry(parent: "ShaderLibrary", child: "ShaderLibrary.default", code: """
        let fn = ShaderFunction(library: .default, name: "ripple")   // main bundle's default.metallib
        let shader = fn(.float(time))
        content.layerEffect(shader, maxSampleOffset: CGSize(width: 20, height: 20))
        """) { AnyView(C16_ShaderLibraryDefaultExample()) },

        ChildExampleEntry(parent: "ShaderLibrary", child: "ShaderLibrary.bundle(_:)", code: """
        let library = ShaderLibrary.bundle(.main)          // .module for a package target
        let effect = library.pixellate(.float(strength))
        image.layerEffect(effect, maxSampleOffset: .zero)
        Slider(value: $strength, in: 4...24)
        """) { AnyView(C16_ShaderLibraryBundleExample()) },

        // MARK: ShadowStyle

        ChildExampleEntry(parent: "ShadowStyle", child: "ShadowStyle.drop(color:radius:x:y:)", code: """
        Circle()
            .fill(.blue.shadow(.drop(color: .black.opacity(0.3), radius: radius, y: 4)))
            .frame(width: 80, height: 80)
        Slider(value: $radius, in: 0...16)
        """) { AnyView(C16_ShadowDropExample()) },

        ChildExampleEntry(parent: "ShadowStyle", child: "ShadowStyle.inner(color:radius:x:y:)", code: """
        Circle()
            .fill(.blue.shadow(.inner(color: .black.opacity(0.5), radius: radius, y: 3)))
            .frame(width: 80, height: 80)
        Slider(value: $radius, in: 0...16)
        """) { AnyView(C16_ShadowInnerExample()) },

        // MARK: Shape.fill()

        ChildExampleEntry(parent: "Shape.fill()", child: ".fill(_:style:)", code: """
        Path { p in
            p.addEllipse(in: outer)
            p.addEllipse(in: inner)
        }
        .fill(.blue, style: FillStyle(eoFill: eoFill))   // even-odd punches the hole
        Toggle("eoFill", isOn: $eoFill)
        """) { AnyView(C16_FillStyleExample()) },

        ChildExampleEntry(parent: "Shape.fill()", child: ".fill(style:)", code: """
        ring                                     // two nested circles in one path
            .fill(style: FillStyle(eoFill: true))   // no style argument → inherits the foreground
            .foregroundStyle(.tint)
            .tint(tint)
        """) { AnyView(C16_FillStyleOnlyExample()) },

        // MARK: Shape.stroke()

        ChildExampleEntry(parent: "Shape.stroke()", child: ".stroke(_:lineWidth:)", code: """
        Circle()
            .stroke(.orange, lineWidth: lineWidth)
            .frame(width: 80, height: 80)
        Slider(value: $lineWidth, in: 1...16)
        """) { AnyView(C16_StrokeLineWidthExample()) },

        ChildExampleEntry(parent: "Shape.stroke()", child: ".stroke(_:style:)", code: """
        Path { p in
            p.move(to: CGPoint(x: 0, y: 40))
            p.addLine(to: CGPoint(x: 200, y: 0))
        }
        .stroke(.orange, style: StrokeStyle(lineWidth: 4, lineCap: .round,
                                            dash: [8, 6], dashPhase: phase))   // marching ants
        """) { AnyView(C16_StrokeStyleExample()) },

        ChildExampleEntry(parent: "Shape.stroke()", child: ".stroke(style:)", code: """
        Circle()
            .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round))   // still a Shape
            .foregroundStyle(.green)

        Circle()
            .stroke(style: StrokeStyle(lineWidth: 6, dash: [2, 10]))
            .fill(.purple.gradient)              // fill the outline shape itself
        """) { AnyView(C16_StrokeStyleOnlyExample()) },

        // MARK: Shape.union()

        ChildExampleEntry(parent: "Shape.union()", child: "Shape.intersection()", code: """
        Circle()
            .intersection(Rectangle().size(width: 100, height: 50))   // top half of the disk
            .fill(.blue)
            .frame(width: 100, height: 100)
        """) { AnyView(C16_ShapeIntersectionExample()) },

        ChildExampleEntry(parent: "Shape.union()", child: "Shape.subtracting()", code: """
        Rectangle()
            .subtracting(Circle().scale(0.5))    // punches a real hole
            .fill(.black)
            .frame(width: 100, height: 100)
        """) { AnyView(C16_ShapeSubtractingExample()) },

        ChildExampleEntry(parent: "Shape.union()", child: "Shape.symmetricDifference()", code: """
        Circle()
            .symmetricDifference(Circle().offset(x: offset))   // XOR: the overlap drops out
            .fill(.orange)
            .frame(width: 100, height: 100)
        Slider(value: $offset, in: 0...80)
        """) { AnyView(C16_ShapeSymmetricDifferenceExample()) },

        ChildExampleEntry(parent: "Shape.union()", child: ".intersection(_:eoFill:)", code: """
        ring                                     // two concentric circles, same winding
            .intersection(Rectangle().size(width: 100, height: 60), eoFill: true)    // keeps the hole
            .fill(.blue)

        ring
            .intersection(Rectangle().size(width: 100, height: 60), eoFill: false)   // nonzero: solid
            .fill(.blue)
        """) { AnyView(C16_ShapeIntersectionEOFillExample()) },
    ]
}

// MARK: - Shared helpers

private struct C16_Caption: View {
    let text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
    }
}

/// A rendering with a monospaced label underneath, for side-by-side comparisons.
private struct C16_Labeled<Content: View>: View {
    private let label: String
    private let content: Content
    init(_ label: String, @ViewBuilder content: () -> Content) {
        self.label = label
        self.content = content()
    }
    var body: some View {
        VStack(spacing: 6) {
            content
            Text(label).font(.caption2.monospaced()).foregroundStyle(.secondary)
        }
    }
}

private struct C16_DashedBounds: ViewModifier {
    func body(content: Content) -> some View {
        content.overlay(
            Rectangle().stroke(.secondary, style: StrokeStyle(lineWidth: 1, dash: [3, 3]))
        )
    }
}

private extension View {
    /// Draws the view's layout bounds so insets and overflow are legible.
    func c16Bounds() -> some View { modifier(C16_DashedBounds()) }
}

/// Two concentric circles drawn in the same direction: a ring under even-odd, a disk under nonzero.
private struct C16_RingShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addEllipse(in: rect)
        path.addEllipse(in: rect.insetBy(dx: rect.width * 0.28, dy: rect.height * 0.28))
        return path
    }
}

/// A gradient "photo" stand-in for examples that would otherwise need an image asset.
private struct C16_Photo: View {
    var body: some View {
        LinearGradient(colors: [.orange, .pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
            .overlay(Image(systemName: "mountain.2.fill").font(.system(size: 34)).foregroundStyle(.white.opacity(0.85)))
    }
}

/// A sine wave drawn from the same amplitude/frequency/phase a `wave` shader would receive.
private struct C16_WaveStandIn: View {
    let amplitude: Double
    let frequency: Double
    let phase: Double

    var body: some View {
        Canvas { context, size in
            var path = Path()
            let midY = size.height / 2
            path.move(to: CGPoint(x: 0, y: midY))
            for x in stride(from: 0.0, through: size.width, by: 2) {
                let t = x / size.width
                let y = midY + amplitude * sin(t * frequency * 2 * .pi + phase)
                path.addLine(to: CGPoint(x: x, y: y))
            }
            context.stroke(path, with: .color(.blue), style: StrokeStyle(lineWidth: 3, lineCap: .round))
        }
    }
}

// MARK: - .border() › .border(_:)

private struct C16_BorderDefaultExample: View {
    var body: some View {
        VStack(spacing: 12) {
            VStack(alignment: .leading) {
                Text("Row").border(.secondary)
                Label("Detail", systemImage: "info.circle").border(.secondary)
            }
            .padding(8)
            .border(.secondary)
            C16_Caption("Every frame outlined at the default 1 pt — a quick way to see where layout boundaries fall.")
        }
    }
}

// MARK: - .border() › .border(_:width:)

private struct C16_BorderWidthExample: View {
    @State private var width: CGFloat = 2

    var body: some View {
        VStack(spacing: 12) {
            Text("DRAFT")
                .font(.headline)
                .padding(6)
                .border(.red, width: width)
                .frame(height: 50)
            HStack {
                Slider(value: $width, in: 0.5...8)
                    .frame(width: 160)
                Text("width: \(width, format: .number.precision(.fractionLength(1)))")
                    .font(.caption.monospacedDigit())
            }
            C16_Caption("The border is drawn inside the frame, so thicker widths eat into the padding rather than growing the view.")
        }
    }
}

// MARK: - .strokeBorder() › .strokeBorder(_:lineWidth:)

private struct C16_StrokeBorderLineWidthExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 40) {
                C16_Labeled(".strokeBorder(.teal, lineWidth: 12)") {
                    Circle()
                        .strokeBorder(.teal, lineWidth: 12)
                        .frame(width: 100, height: 100)
                        .c16Bounds()
                }
                C16_Labeled(".stroke(.teal, lineWidth: 12)") {
                    Circle()
                        .stroke(.teal, lineWidth: 12)
                        .frame(width: 100, height: 100)
                        .c16Bounds()
                }
            }
            C16_Caption("The dashed box is the frame: strokeBorder insets the path by half the width, so nothing spills outside it.")
        }
    }
}

// MARK: - .strokeBorder() › .strokeBorder(_:style:)

private struct C16_StrokeBorderStyleExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 24) {
                C16_Labeled("dash: [10, 6]") {
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(.orange, style: StrokeStyle(lineWidth: 4, dash: [10, 6]))
                        .frame(width: 160, height: 80)
                }
                C16_Labeled("lineCap: .round, dash: [1, 10]") {
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(.orange, style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: [1, 10]))
                        .frame(width: 160, height: 80)
                }
            }
            C16_Caption("A full StrokeStyle unlocks dashes, caps and joins while the stroke still stays inside the frame.")
        }
    }
}

// MARK: - .strokeBorder() › .strokeBorder(style:)

private struct C16_StrokeBorderStyleOnlyExample: View {
    @State private var tint: Color = .blue

    var body: some View {
        VStack(spacing: 12) {
            Capsule()
                .strokeBorder(style: StrokeStyle(lineWidth: 3))
                .foregroundStyle(.tint)
                .tint(tint)
                .frame(width: 180, height: 44)
                .overlay(Text("Inherits the foreground").font(.caption))
            Picker("tint", selection: $tint) {
                Text(".blue").tag(Color.blue)
                Text(".pink").tag(Color.pink)
                Text(".green").tag(Color.green)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 220)
            C16_Caption("No ShapeStyle argument: the stroke takes whatever foreground style is in effect.")
        }
    }
}

// MARK: - .symbolVariant() › SymbolVariants

private struct C16_SymbolVariantsTypeExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 28) {
                C16_Labeled(".none") {
                    Image(systemName: "person").symbolVariant(SymbolVariants.none)
                }
                C16_Labeled(".circle") {
                    Image(systemName: "person").symbolVariant(SymbolVariants.circle)
                }
                C16_Labeled(".circle.fill") {
                    Image(systemName: "person").symbolVariant(SymbolVariants.circle.fill)
                }
                C16_Labeled(".square.fill") {
                    Image(systemName: "person").symbolVariant(SymbolVariants.square.fill)
                }
                C16_Labeled(".slash") {
                    Image(systemName: "person").symbolVariant(SymbolVariants.slash)
                }
            }
            .font(.system(size: 30))
            C16_Caption("One value type describes every variant; chaining properties like .circle.fill composes them.")
        }
    }
}

// MARK: - .symbolVariant() › SymbolVariants.fill

private struct C16_SymbolVariantsFillExample: View {
    @State private var isLiked = false

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 32) {
                Button {
                    isLiked.toggle()
                } label: {
                    Image(systemName: "heart")
                        .symbolVariant(isLiked ? .fill : .none)
                        .font(.system(size: 34))
                        .foregroundStyle(isLiked ? .red : .secondary)
                }
                .buttonStyle(.plain)
                Label("Favorites", systemImage: "star")
                    .symbolVariant(.fill)
                    .font(.title3)
            }
            C16_Caption("Click the heart. .fill requests the solid glyph; applied to a Label it reaches every symbol inside.")
        }
    }
}

// MARK: - .symbolVariant() › SymbolVariants.slash

private struct C16_SymbolVariantsSlashExample: View {
    @State private var isMuted = true

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 32) {
                Image(systemName: "bell")
                    .symbolVariant(isMuted ? .slash : .none)
                Image(systemName: "speaker.wave.2")
                    .symbolVariant(isMuted ? .slash : .none)
            }
            .font(.system(size: 34))
            .foregroundStyle(isMuted ? .secondary : .primary)
            Toggle("Muted", isOn: $isMuted)
                .toggleStyle(.switch)
                .controlSize(.small)
            C16_Caption(".slash swaps in the crossed-out form that signals a muted or disabled state.")
        }
    }
}

// MARK: - .symbolVariant() › SymbolVariants.circle

private struct C16_SymbolVariantsCircleExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 36) {
                C16_Labeled("plain") {
                    Image(systemName: "plus")
                }
                C16_Labeled(".circle") {
                    Image(systemName: "plus").symbolVariant(.circle)
                }
                C16_Labeled(".circle.fill") {
                    Image(systemName: "plus").symbolVariant(.circle.fill)
                }
            }
            .font(.system(size: 32))
            .foregroundStyle(.blue)
            C16_Caption(".circle encloses the glyph; chaining .fill turns the enclosure into a solid badge.")
        }
    }
}

// MARK: - Color › Color(hue:saturation:brightness:opacity:)

private struct C16_ColorHSBExample: View {
    @State private var saturation = 0.8

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 4) {
                ForEach(0..<12, id: \.self) { i in
                    Circle()
                        .fill(Color(hue: Double(i) / 12, saturation: saturation, brightness: 0.9))
                        .frame(width: 22, height: 22)
                }
            }
            HStack {
                Slider(value: $saturation, in: 0...1)
                    .frame(width: 160)
                Text("saturation \(saturation, format: .number.precision(.fractionLength(2)))")
                    .font(.caption.monospacedDigit())
            }
            C16_Caption("Hue sweeps the wheel in twelfths; a single saturation value fades the whole palette together.")
        }
    }
}

// MARK: - Color › Color(uiColor:)

private struct C16_ColorUIColorExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 16) {
                C16_Labeled(".windowBackgroundColor") {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(nsColor: .windowBackgroundColor))
                        .frame(width: 96, height: 50)
                        .overlay(Text("Label").foregroundStyle(Color(nsColor: .labelColor)))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.quaternary))
                }
                C16_Labeled(".controlAccentColor") {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(nsColor: .controlAccentColor))
                        .frame(width: 96, height: 50)
                }
                C16_Labeled(".secondaryLabelColor") {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(nsColor: .secondaryLabelColor))
                        .frame(width: 96, height: 50)
                }
            }
            C16_Caption("Illustrative — Color(uiColor:) is iOS, tvOS and watchOS only. macOS renders the twin Color(nsColor:), which bridges NSColor the same way and keeps light/dark resolution.")
        }
    }
}

// MARK: - Color › Color.accentColor

private struct C16_ColorAccentExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 40) {
                C16_Labeled("Color.accentColor") {
                    HStack {
                        Image(systemName: "checkmark.seal.fill").foregroundStyle(Color.accentColor)
                        Button("Default") { }
                    }
                    .font(.title3)
                }
                C16_Labeled("inside .tint(.orange)") {
                    HStack {
                        Image(systemName: "checkmark.seal.fill").foregroundStyle(Color.accentColor)
                        Button("Tinted") { }
                    }
                    .font(.title3)
                    .tint(.orange)
                }
            }
            C16_Caption("Left: Color.accentColor beside a default button — both follow the system accent. Right: the same pair inside .tint(.orange).")
        }
    }
}

// MARK: - Color › Color(red:green:blue:opacity:)

private struct C16_ColorRGBExample: View {
    @State private var red = 0.12
    @State private var green = 0.45
    @State private var blue = 0.95

    var body: some View {
        let brand = Color(red: red, green: green, blue: blue)
        HStack(spacing: 24) {
            Capsule()
                .fill(brand)
                .frame(width: 110, height: 44)
                .overlay(
                    Text("\(Int(red * 255)) · \(Int(green * 255)) · \(Int(blue * 255))")
                        .font(.caption.monospacedDigit())
                        .foregroundStyle(.white)
                )
            VStack(spacing: 4) {
                channel("red", $red, .red)
                channel("green", $green, .green)
                channel("blue", $blue, .blue)
            }
            .frame(width: 180)
        }
    }

    private func channel(_ name: String, _ value: Binding<Double>, _ tint: Color) -> some View {
        HStack {
            Text(name).font(.caption.monospaced()).frame(width: 40, alignment: .trailing)
            Slider(value: value, in: 0...1).tint(tint)
        }
    }
}

// MARK: - Color.Resolved › Color.Resolved(red:green:blue:opacity:)

private struct C16_ColorResolvedInitExample: View {
    @State private var opacity = 1.0

    var body: some View {
        let magenta = Color.Resolved(red: 0.9, green: 0.1, blue: 0.6, opacity: Float(opacity))
        VStack(spacing: 10) {
            Rectangle()
                .fill(Color(magenta))
                .frame(width: 200, height: 50)
                .background(C16_Checkerboard())
                .clipShape(.rect(cornerRadius: 8))
            Text("R \(magenta.red, format: .number.precision(.fractionLength(2)))  G \(magenta.green, format: .number.precision(.fractionLength(2)))  B \(magenta.blue, format: .number.precision(.fractionLength(2)))  A \(magenta.opacity, format: .number.precision(.fractionLength(2)))")
                .font(.caption.monospacedDigit())
            HStack {
                Slider(value: $opacity, in: 0...1).frame(width: 160)
                Text("opacity").font(.caption)
            }
            C16_Caption("Float components go straight in; Color(_:) wraps the resolved value so it can fill a shape.")
        }
    }
}

private struct C16_Checkerboard: View {
    var body: some View {
        Canvas { context, size in
            let cell: CGFloat = 8
            var y: CGFloat = 0
            var row = 0
            while y < size.height {
                var x: CGFloat = 0
                var col = 0
                while x < size.width {
                    if (row + col) % 2 == 0 {
                        context.fill(Path(CGRect(x: x, y: y, width: cell, height: cell)), with: .color(.gray.opacity(0.35)))
                    }
                    x += cell
                    col += 1
                }
                y += cell
                row += 1
            }
        }
    }
}

// MARK: - Color.Resolved › Color.Resolved.cgColor

private struct C16_ColorResolvedCGColorExample: View {
    @Environment(\.self) private var environment

    var body: some View {
        let resolved = Color.orange.resolve(in: environment)
        let components = (resolved.cgColor.components ?? [])
            .map { String(format: "%.2f", Double($0)) }
            .joined(separator: ", ")
        VStack(spacing: 10) {
            HStack(spacing: 24) {
                Canvas { context, size in
                    context.withCGContext { cg in
                        cg.setFillColor(resolved.cgColor)
                        cg.fillEllipse(in: CGRect(origin: .zero, size: size))
                    }
                }
                .frame(width: 72, height: 72)
                VStack(alignment: .leading, spacing: 4) {
                    Text("cgColor.numberOfComponents: \(resolved.cgColor.numberOfComponents)")
                    Text("components: [\(components)]")
                }
                .font(.caption.monospacedDigit())
            }
            C16_Caption("The disk is filled by Core Graphics inside withCGContext, using the CGColor bridged from the resolved orange.")
        }
    }
}

// MARK: - Color.Resolved › Color.Resolved.linearRed

private struct C16_ColorResolvedLinearExample: View {
    @Environment(\.self) private var environment
    private let swatches: [Color] = [.blue, .yellow, .pink, .mint, .indigo]

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 8) {
                ForEach(swatches.indices, id: \.self) { index in
                    let resolved = swatches[index].resolve(in: environment)
                    let luminance = 0.2126 * resolved.linearRed
                                  + 0.7152 * resolved.linearGreen
                                  + 0.0722 * resolved.linearBlue
                    VStack(spacing: 2) {
                        Text(luminance > 0.35 ? "Dark label" : "Light label")
                            .font(.caption2)
                        Text(luminance, format: .number.precision(.fractionLength(2)))
                            .font(.caption2.monospacedDigit())
                    }
                    .foregroundStyle(luminance > 0.35 ? .black : .white)
                    .frame(width: 70, height: 48)
                    .background(swatches[index], in: .rect(cornerRadius: 8))
                }
            }
            Text("orange: red \(Color.orange.resolve(in: environment).red, format: .number.precision(.fractionLength(2)))  →  linearRed \(Color.orange.resolve(in: environment).linearRed, format: .number.precision(.fractionLength(2)))")
                .font(.caption.monospacedDigit())
            C16_Caption("Relative luminance from the linear channels picks a readable label color; the gamma-encoded red is much larger than its linear counterpart.")
        }
    }
}

// MARK: - EllipticalGradient › EllipticalGradient(colors:…)

private struct C16_EllipticalColorsExample: View {
    @State private var endRadius: CGFloat = 0.6

    var body: some View {
        VStack(spacing: 10) {
            Ellipse()
                .fill(EllipticalGradient(colors: [.yellow, .orange, .red],
                                         center: .center,
                                         startRadiusFraction: 0,
                                         endRadiusFraction: endRadius))
                .frame(width: 200, height: 100)
            HStack {
                Slider(value: $endRadius, in: 0.2...1).frame(width: 160)
                Text("endRadiusFraction \(endRadius, format: .number.precision(.fractionLength(2)))")
                    .font(.caption.monospacedDigit())
            }
            C16_Caption("Colors are spaced evenly; the rings stretch to the shape's 2:1 aspect instead of staying circular.")
        }
    }
}

// MARK: - EllipticalGradient › EllipticalGradient(stops:…)

private struct C16_EllipticalStopsExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 24) {
                C16_Labeled("stops: 0 · 0.8 · 1") {
                    Rectangle()
                        .fill(EllipticalGradient(stops: [
                            .init(color: .white, location: 0),
                            .init(color: .blue, location: 0.8),
                            .init(color: .indigo, location: 1)
                        ], center: .center, startRadiusFraction: 0, endRadiusFraction: 0.5))
                        .frame(width: 160, height: 80)
                        .clipShape(.rect(cornerRadius: 10))
                }
                C16_Labeled("colors: evenly spaced") {
                    Rectangle()
                        .fill(EllipticalGradient(colors: [.white, .blue, .indigo],
                                                 center: .center, startRadiusFraction: 0, endRadiusFraction: 0.5))
                        .frame(width: 160, height: 80)
                        .clipShape(.rect(cornerRadius: 10))
                }
            }
            C16_Caption("Explicit stops hold the white core out to 80 % of the radius, then snap to blue and indigo.")
        }
    }
}

// MARK: - EllipticalGradient › EllipticalGradient(gradient:…)

private struct C16_EllipticalGradientValueExample: View {
    private let g = Gradient(colors: [.pink, .purple])

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 24) {
                C16_Labeled("center: .topLeading, end 0.9") {
                    Circle()
                        .fill(EllipticalGradient(gradient: g, center: .topLeading, endRadiusFraction: 0.9))
                        .frame(width: 80, height: 80)
                }
                C16_Labeled("center: .center, end 0.6") {
                    Capsule()
                        .fill(EllipticalGradient(gradient: g, center: .center, endRadiusFraction: 0.6))
                        .frame(width: 150, height: 60)
                }
            }
            C16_Caption("One Gradient value, reused in two elliptical geometries with different centers and radii.")
        }
    }
}

// MARK: - Gradient › Gradient.Stop

private struct C16_GradientStopExample: View {
    @State private var location: CGFloat = 0.3

    var body: some View {
        let stop = Gradient.Stop(color: .cyan, location: location)
        let g = Gradient(stops: [
            Gradient.Stop(color: .indigo, location: 0),
            stop,
            Gradient.Stop(color: .white, location: 1)
        ])
        VStack(spacing: 10) {
            Rectangle()
                .fill(LinearGradient(gradient: g, startPoint: .leading, endPoint: .trailing))
                .frame(width: 240, height: 40)
                .overlay(alignment: .leading) {
                    Rectangle().fill(.black).frame(width: 2, height: 48)
                        .offset(x: 240 * location - 1)
                }
                .clipShape(.rect(cornerRadius: 6))
            HStack {
                Slider(value: $location, in: 0...1).frame(width: 160)
                Text("stop.location \(location, format: .number.precision(.fractionLength(2)))")
                    .font(.caption.monospacedDigit())
            }
            C16_Caption("A Stop pairs a color with a 0…1 position; the marker shows where the cyan stop sits.")
        }
    }
}

// MARK: - Gradient › Gradient(colors:)

private struct C16_GradientColorsExample: View {
    private let g = Gradient(colors: [.blue, .cyan, .green])

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 20) {
                C16_Labeled("LinearGradient") {
                    Rectangle()
                        .fill(LinearGradient(gradient: g, startPoint: .leading, endPoint: .trailing))
                        .frame(width: 120, height: 72)
                        .clipShape(.rect(cornerRadius: 8))
                }
                C16_Labeled("RadialGradient") {
                    Circle()
                        .fill(RadialGradient(gradient: g, center: .center, startRadius: 0, endRadius: 36))
                        .frame(width: 72, height: 72)
                }
                C16_Labeled("AngularGradient") {
                    Circle()
                        .fill(AngularGradient(gradient: g, center: .center))
                        .frame(width: 72, height: 72)
                }
            }
            C16_Caption("Three colors become stops at 0, 0.5 and 1; the same Gradient feeds every geometry.")
        }
    }
}

// MARK: - Gradient › Gradient(stops:)

private struct C16_GradientStopsExample: View {
    private let heat = Gradient(stops: [
        .init(color: .blue, location: 0),
        .init(color: .yellow, location: 0.65),
        .init(color: .red, location: 1)
    ])
    private let even = Gradient(colors: [.blue, .yellow, .red])

    var body: some View {
        VStack(spacing: 8) {
            bar(heat, label: "Gradient(stops:) — yellow at 0.65")
            bar(even, label: "Gradient(colors:) — yellow at 0.5")
            C16_Caption("Explicit locations skew the transition; the tick marks sit where the middle stop lands.")
        }
    }

    private func bar(_ gradient: Gradient, label: String) -> some View {
        VStack(spacing: 3) {
            Rectangle()
                .fill(LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing))
                .frame(width: 240, height: 28)
                .overlay(alignment: .leading) {
                    Rectangle().fill(.black).frame(width: 2, height: 34)
                        .offset(x: 240 * (gradient.stops.count > 1 ? gradient.stops[1].location : 0.5) - 1)
                }
                .clipShape(.rect(cornerRadius: 6))
            Text(label).font(.caption2.monospaced()).foregroundStyle(.secondary)
        }
    }
}

// MARK: - GraphicsContext › GraphicsContext.Shading

private struct C16_GraphicsContextShadingExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 20) {
                C16_Labeled(".color(.mint)") {
                    Canvas { context, size in
                        let disk = Path(ellipseIn: CGRect(origin: .zero, size: size))
                        context.fill(disk, with: .color(.mint))
                    }
                    .frame(width: 72, height: 72)
                }
                C16_Labeled(".linearGradient(…)") {
                    Canvas { context, size in
                        let box = Path(roundedRect: CGRect(origin: .zero, size: size), cornerRadius: 12)
                        context.fill(box, with: .linearGradient(
                            Gradient(colors: [.orange, .pink]),
                            startPoint: .zero,
                            endPoint: CGPoint(x: size.width, y: size.height)
                        ))
                    }
                    .frame(width: 72, height: 72)
                }
                C16_Labeled(".conicGradient(…)") {
                    Canvas { context, size in
                        let disk = Path(ellipseIn: CGRect(origin: .zero, size: size))
                        context.fill(disk, with: .conicGradient(
                            Gradient(colors: [.purple, .blue, .purple]),
                            center: CGPoint(x: size.width / 2, y: size.height / 2)
                        ))
                        context.stroke(disk, with: .color(.white), lineWidth: 3)
                    }
                    .frame(width: 72, height: 72)
                }
            }
            C16_Caption("Shading is the paint for a fill or stroke — a color, a gradient in canvas coordinates, or any ShapeStyle via .style(_:).")
        }
    }
}

// MARK: - GraphicsContext › GraphicsContext.Filter

private struct C16_GraphicsContextFilterExample: View {
    @State private var hue = 45.0

    var body: some View {
        VStack(spacing: 10) {
            Canvas { context, size in
                context.addFilter(.shadow(radius: 4, y: 2))
                context.addFilter(.hueRotation(.degrees(hue)))
                let box = CGRect(x: 10, y: 10, width: size.width * 0.55, height: size.height - 20)
                let dot = CGRect(x: size.width * 0.66, y: 12, width: size.height - 24, height: size.height - 24)
                context.fill(Path(roundedRect: box, cornerRadius: 12), with: .color(.orange))
                context.fill(Path(ellipseIn: dot), with: .color(.blue))
            }
            .frame(width: 220, height: 70)
            HStack {
                Slider(value: $hue, in: 0...360).frame(width: 160)
                Text("hueRotation \(Int(hue))°").font(.caption.monospacedDigit())
            }
            C16_Caption("Filters accumulate on the context: the shadow and the hue rotation apply to both shapes drawn afterwards.")
        }
    }
}

// MARK: - GraphicsContext › GraphicsContext.drawLayer(content:)

private struct C16_GraphicsContextDrawLayerExample: View {
    var body: some View {
        VStack(spacing: 10) {
            Canvas { context, size in
                let circle = Path(ellipseIn: CGRect(x: 10, y: 8, width: size.height - 16, height: size.height - 16))
                let square = Path(roundedRect: CGRect(x: size.width - size.height + 6, y: 8,
                                                      width: size.height - 16, height: size.height - 16),
                                  cornerRadius: 10)
                context.drawLayer { layer in
                    layer.addFilter(.blur(radius: 3))
                    layer.fill(circle, with: .color(.mint))
                }
                context.fill(square, with: .color(.pink))
            }
            .frame(width: 200, height: 80)
            C16_Caption("The blur was added to the child layer only, so the pink square drawn on the outer context stays sharp.")
        }
    }
}

// MARK: - HierarchicalShapeStyle › HierarchicalShapeStyle.secondary

private struct C16_HierarchicalSecondaryExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 40) {
                C16_Labeled("default foreground") {
                    VStack(alignment: .leading) {
                        Text("Album").foregroundStyle(.primary)
                        Text("Artist · 2024").foregroundStyle(.secondary)
                    }
                }
                C16_Labeled("inside .foregroundStyle(.blue)") {
                    VStack(alignment: .leading) {
                        Text("Album").foregroundStyle(.primary)
                        Text("Artist · 2024").foregroundStyle(.secondary)
                    }
                    .foregroundStyle(.blue)
                }
            }
            .font(.title3)
            C16_Caption(".secondary is one step down from the current foreground — a muted blue on the right, not a fixed gray.")
        }
    }
}

// MARK: - HierarchicalShapeStyle › HierarchicalShapeStyle.tertiary

private struct C16_HierarchicalTertiaryExample: View {
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 8) {
                Text("Draft")
                Image(systemName: "circle.fill").font(.system(size: 5)).foregroundStyle(.tertiary)
                Text("Edited")
                Image(systemName: "circle.fill").font(.system(size: 5)).foregroundStyle(.tertiary)
                Text("Sent").foregroundStyle(.tertiary)
            }
            .font(.title3)
            HStack(spacing: 14) {
                C16_Labeled(".primary") { Circle().fill(.primary).frame(width: 24, height: 24) }
                C16_Labeled(".secondary") { Circle().fill(.secondary).frame(width: 24, height: 24) }
                C16_Labeled(".tertiary") { Circle().fill(.tertiary).frame(width: 24, height: 24) }
                C16_Labeled(".quaternary") { Circle().fill(.quaternary).frame(width: 24, height: 24) }
            }
            C16_Caption("The third level: faint enough for separator dots and de-emphasized glyphs, still derived from the foreground.")
        }
    }
}

// MARK: - HierarchicalShapeStyle › HierarchicalShapeStyle.quinary

private struct C16_HierarchicalQuinaryExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 24) {
                C16_Labeled(".fill(.quaternary)") {
                    Label("Search", systemImage: "magnifyingglass")
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).fill(.quaternary))
                }
                C16_Labeled(".fill(.quinary)") {
                    Label("Search", systemImage: "magnifyingglass")
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).fill(.quinary))
                }
            }
            C16_Caption("The fifth and faintest level, meant for barely-there backing fills behind content.")
        }
    }
}

// MARK: - ImageRenderer › ImageRenderer(content:)

private struct C16_BadgeView: View {
    let score: Int
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "checkmark.seal.fill")
                .font(.title2)
                .foregroundStyle(.green)
            VStack(alignment: .leading, spacing: 1) {
                Text("Verified").font(.headline)
                Text("Score \(score)").font(.caption).foregroundStyle(.secondary)
            }
        }
        .padding(10)
        .background(Color.white, in: .rect(cornerRadius: 10))
    }
}

private struct C16_ImageRendererContentExample: View {
    @Environment(\.displayScale) private var displayScale
    @State private var rendered: Image?

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 28) {
                C16_Labeled("live view") {
                    C16_BadgeView(score: 92)
                }
                C16_Labeled("ImageRenderer output") {
                    if let rendered {
                        rendered
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.quaternary))
                    } else {
                        RoundedRectangle(cornerRadius: 10).fill(.quaternary)
                            .frame(width: 130, height: 52)
                    }
                }
            }
            Button("Render again") { render() }
                .controlSize(.small)
            C16_Caption("The right side is a bitmap: the view hierarchy was rasterized off-screen at the display's scale.")
        }
        .onAppear { render() }
    }

    private func render() {
        let renderer = ImageRenderer(content: C16_BadgeView(score: 92))
        renderer.scale = displayScale
        if let cg = renderer.cgImage {
            rendered = Image(decorative: cg, scale: displayScale)
        }
    }
}

// MARK: - ImageRenderer › ImageRenderer.cgImage

private struct C16_ImageRendererCGImageExample: View {
    @State private var scale: CGFloat = 2
    @State private var pixelSize = "—"
    @State private var thumbnail: Image?

    private var card: some View {
        Label("Card", systemImage: "creditcard.fill")
            .font(.headline)
            .padding(10)
            .background(.blue.gradient, in: .rect(cornerRadius: 8))
            .foregroundStyle(.white)
    }

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 24) {
                if let thumbnail {
                    thumbnail
                } else {
                    RoundedRectangle(cornerRadius: 8).fill(.quaternary).frame(width: 90, height: 40)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("cgImage: \(pixelSize)").font(.caption.monospacedDigit())
                    Picker("scale", selection: $scale) {
                        Text("1×").tag(CGFloat(1))
                        Text("2×").tag(CGFloat(2))
                        Text("3×").tag(CGFloat(3))
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .frame(width: 140)
                }
            }
            C16_Caption("The same points render to more pixels as scale rises; cgImage is the bitmap those pixels land in.")
        }
        .onAppear { render() }
        .onChange(of: scale) { render() }
    }

    private func render() {
        let renderer = ImageRenderer(content: card)
        renderer.scale = scale
        if let cg = renderer.cgImage {
            pixelSize = "\(cg.width) × \(cg.height) px"
            thumbnail = Image(decorative: cg, scale: scale)
        }
    }
}

// MARK: - ImageRenderer › ImageRenderer.render(rasterizationScale:renderer:)

private struct C16_ImageRendererRenderExample: View {
    @State private var bitmap: CGImage?
    @State private var reportedSize = CGSize.zero

    private var card: some View {
        HStack(spacing: 8) {
            Image(systemName: "doc.richtext").font(.title2).foregroundStyle(.indigo)
            Text("Export").font(.headline)
        }
        .padding(10)
        .background(Color.white, in: .rect(cornerRadius: 8))
    }

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 24) {
                if let bitmap {
                    Image(decorative: bitmap, scale: 2)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.quaternary))
                } else {
                    RoundedRectangle(cornerRadius: 8).fill(.quaternary).frame(width: 100, height: 44)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("size passed in: \(Int(reportedSize.width)) × \(Int(reportedSize.height)) pt")
                    Text("bitmap: \(bitmap?.width ?? 0) × \(bitmap?.height ?? 0) px")
                }
                .font(.caption.monospacedDigit())
            }
            C16_Caption("The closure receives the content size and a draw function; here it targets a bitmap CGContext, and a PDF context works the same way.")
        }
        .onAppear { render() }
    }

    private func render() {
        let renderer = ImageRenderer(content: card)
        renderer.render(rasterizationScale: 2) { size, drawInContext in
            reportedSize = size
            guard let cg = CGContext(data: nil, width: Int(size.width * 2), height: Int(size.height * 2),
                                     bitsPerComponent: 8, bytesPerRow: 0,
                                     space: CGColorSpaceCreateDeviceRGB(),
                                     bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else { return }
            cg.scaleBy(x: 2, y: 2)
            drawInContext(cg)
            bitmap = cg.makeImage()
        }
    }
}

// MARK: - Shader › Shader.Argument

private struct C16_ShaderArgumentExample: View {
    @State private var strength = 0.8

    var body: some View {
        let shader = ShaderLibrary.tint(
            .color(.mint),
            .float(strength),
            .boundingRect
        )
        VStack(spacing: 10) {
            HStack(spacing: 24) {
                C16_ShaderStandIn(shader: shader) {
                    C16_Photo()
                        .overlay(Color.mint.opacity(strength))
                        .frame(width: 120, height: 70)
                        .clipShape(.rect(cornerRadius: 10))
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(".color(.mint)      → half4").font(.caption.monospaced())
                    Text(".float(\(strength, format: .number.precision(.fractionLength(2))))        → float").font(.caption.monospaced())
                    Text(".boundingRect      → float4").font(.caption.monospaced())
                    Slider(value: $strength, in: 0...1).frame(width: 150)
                }
            }
            C16_Caption("Illustrative — the arguments are packed for the Metal function `tint`, which lives in a .metal file compiled into the app; a SwiftUI overlay stands in for its output.")
        }
    }
}

/// Holds a real `Shader` value next to the SwiftUI stand-in that approximates it.
private struct C16_ShaderStandIn<Content: View>: View {
    let shader: Shader
    private let content: Content
    init(shader: Shader, @ViewBuilder content: () -> Content) {
        self.shader = shader
        self.content = content()
    }
    var body: some View { content }
}

// MARK: - Shader › Shader.Argument.float(_:)

private struct C16_ShaderArgumentFloatExample: View {
    private let start = Date()

    var body: some View {
        VStack(spacing: 10) {
            TimelineView(.animation) { timeline in
                let elapsed = timeline.date.timeIntervalSince(start)
                C16_ShaderStandIn(shader: ShaderLibrary.wave(.float(elapsed))) {
                    VStack(spacing: 4) {
                        C16_WaveStandIn(amplitude: 10, frequency: 2, phase: elapsed * 3)
                            .frame(width: 220, height: 40)
                        Text("elapsed \(elapsed, format: .number.precision(.fractionLength(1))) s")
                            .font(.caption.monospacedDigit())
                    }
                }
            }
            C16_Caption("Illustrative — .float(elapsed) feeds one scalar into the Metal `wave` function each frame; the drawn wave advances with the same value.")
        }
    }
}

// MARK: - Shader › Shader.Argument.color(_:)

private struct C16_ShaderArgumentColorExample: View {
    @State private var dark: Color = .indigo
    @State private var light: Color = .orange

    var body: some View {
        let effect = ShaderLibrary.duotone(.color(dark), .color(light))
        VStack(spacing: 10) {
            HStack(spacing: 24) {
                C16_ShaderStandIn(shader: effect) {
                    Image(systemName: "person.crop.square.fill")
                        .font(.system(size: 64))
                        .foregroundStyle(LinearGradient(colors: [dark, light], startPoint: .top, endPoint: .bottom))
                }
                VStack(alignment: .leading, spacing: 6) {
                    Picker(".color(dark)", selection: $dark) {
                        Text("indigo").tag(Color.indigo)
                        Text("black").tag(Color.black)
                        Text("teal").tag(Color.teal)
                    }
                    Picker(".color(light)", selection: $light) {
                        Text("orange").tag(Color.orange)
                        Text("yellow").tag(Color.yellow)
                        Text("white").tag(Color.white)
                    }
                }
                .font(.caption)
                .frame(width: 180)
            }
            C16_Caption("Illustrative — each .color(_:) resolves to RGBA before reaching the Metal `duotone` function; the gradient portrait stands in for its remapped output.")
        }
    }
}

// MARK: - Shader › Shader.Argument.boundingRect

private struct C16_ShaderArgumentBoundingRectExample: View {
    private let shader = ShaderLibrary.radialFade(.boundingRect)

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 24) {
                C16_Labeled("120 × 70") {
                    fade(width: 120, height: 70)
                }
                C16_Labeled("70 × 70") {
                    fade(width: 70, height: 70)
                }
            }
            C16_Caption("Illustrative — .boundingRect hands the layer's rect to the Metal function so the fade centers itself in any size; a radial mask stands in for the shader.")
        }
    }

    private func fade(width: CGFloat, height: CGFloat) -> some View {
        C16_ShaderStandIn(shader: shader) {
            C16_Photo()
                .frame(width: width, height: height)
                .mask(RadialGradient(colors: [.black, .clear], center: .center, startRadius: 0, endRadius: max(width, height) * 0.55))
                .clipShape(.rect(cornerRadius: 10))
        }
    }
}

// MARK: - ShaderLibrary › ShaderFunction

private struct C16_ShaderFunctionExample: View {
    @State private var amplitude = 10.0
    @State private var frequency = 2.0

    var body: some View {
        let fn = ShaderFunction(library: .default, name: "wave")
        let shader = fn(.float(amplitude), .float(frequency))
        VStack(spacing: 10) {
            C16_ShaderStandIn(shader: shader) {
                C16_WaveStandIn(amplitude: amplitude, frequency: frequency, phase: 0)
                    .frame(width: 220, height: 44)
            }
            HStack(spacing: 12) {
                Slider(value: $amplitude, in: 0...20).frame(width: 110)
                Text("amplitude \(Int(amplitude))").font(.caption.monospacedDigit())
                Slider(value: $frequency, in: 1...6).frame(width: 110)
                Text("frequency \(frequency, format: .number.precision(.fractionLength(1)))").font(.caption.monospacedDigit())
            }
            C16_Caption("Illustrative — ShaderFunction names one Metal entry point; calling it binds the arguments into a Shader. The drawn wave uses the same two floats.")
        }
    }
}

// MARK: - ShaderLibrary › ShaderLibrary.default

private struct C16_ShaderLibraryDefaultExample: View {
    private let start = Date()

    var body: some View {
        VStack(spacing: 10) {
            TimelineView(.animation) { timeline in
                let time = timeline.date.timeIntervalSince(start)
                let fn = ShaderFunction(library: .default, name: "ripple")
                C16_ShaderStandIn(shader: fn(.float(time))) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10).fill(.blue.gradient)
                        ForEach(0..<3, id: \.self) { ring in
                            let progress = ((time * 0.5) + Double(ring) / 3).truncatingRemainder(dividingBy: 1)
                            Circle()
                                .stroke(.white.opacity(1 - progress), lineWidth: 2)
                                .frame(width: 10 + progress * 90, height: 10 + progress * 90)
                        }
                    }
                    .frame(width: 200, height: 80)
                    .clipShape(.rect(cornerRadius: 10))
                }
            }
            C16_Caption("Illustrative — .default is the main bundle's default.metallib, where a `ripple` function would be found; expanding rings stand in for the layer distortion.")
        }
    }
}

// MARK: - ShaderLibrary › ShaderLibrary.bundle(_:)

private struct C16_ShaderLibraryBundleExample: View {
    @State private var strength = 12.0

    var body: some View {
        let library = ShaderLibrary.bundle(.main)
        let effect = library.pixellate(.float(strength))
        VStack(spacing: 10) {
            C16_ShaderStandIn(shader: effect) {
                Canvas { context, size in
                    let block = CGFloat(strength)
                    var y: CGFloat = 0
                    while y < size.height {
                        var x: CGFloat = 0
                        while x < size.width {
                            let hue = Double((x + size.width / 2) / (size.width * 1.5))
                            let brightness = 0.55 + 0.4 * Double(y / size.height)
                            context.fill(Path(CGRect(x: x, y: y, width: block - 1, height: block - 1)),
                                         with: .color(Color(hue: hue, saturation: 0.7, brightness: brightness)))
                            x += block
                        }
                        y += block
                    }
                }
                .frame(width: 220, height: 72)
                .clipShape(.rect(cornerRadius: 10))
            }
            HStack {
                Slider(value: $strength, in: 4...24).frame(width: 160)
                Text("strength \(Int(strength))").font(.caption.monospacedDigit())
            }
            C16_Caption("Illustrative — bundle(_:) scopes lookup to that bundle's default Metal library (use .module inside a package); the block grid stands in for the pixellate output.")
        }
    }
}

// MARK: - ShadowStyle › ShadowStyle.drop(color:radius:x:y:)

private struct C16_ShadowDropExample: View {
    @State private var radius: CGFloat = 6

    var body: some View {
        VStack(spacing: 12) {
            Circle()
                .fill(.blue.shadow(.drop(color: .black.opacity(0.3), radius: radius, y: 4)))
                .frame(width: 80, height: 80)
                .padding(.bottom, 8)
            HStack {
                Slider(value: $radius, in: 0...16).frame(width: 160)
                Text("radius \(Int(radius))").font(.caption.monospacedDigit())
            }
            C16_Caption("The shadow belongs to the ShapeStyle, cast outside the fill's edge and offset 4 pt downward.")
        }
    }
}

// MARK: - ShadowStyle › ShadowStyle.inner(color:radius:x:y:)

private struct C16_ShadowInnerExample: View {
    @State private var radius: CGFloat = 6

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 28) {
                C16_Labeled(".inner(…)") {
                    Circle()
                        .fill(.blue.shadow(.inner(color: .black.opacity(0.5), radius: radius, y: 3)))
                        .frame(width: 80, height: 80)
                }
                C16_Labeled(".drop(…) for comparison") {
                    Circle()
                        .fill(.blue.shadow(.drop(color: .black.opacity(0.5), radius: radius, y: 3)))
                        .frame(width: 80, height: 80)
                }
            }
            HStack {
                Slider(value: $radius, in: 0...16).frame(width: 160)
                Text("radius \(Int(radius))").font(.caption.monospacedDigit())
            }
            C16_Caption("Inner shadows darken inward from the top edge, so the disk reads as recessed instead of raised.")
        }
    }
}

// MARK: - Shape.fill() › .fill(_:style:)

private struct C16_FillStyleExample: View {
    @State private var eoFill = true

    var body: some View {
        VStack(spacing: 12) {
            Path { p in
                p.addEllipse(in: CGRect(x: 0, y: 0, width: 90, height: 90))
                p.addEllipse(in: CGRect(x: 25, y: 25, width: 40, height: 40))
            }
            .fill(.blue, style: FillStyle(eoFill: eoFill))
            .frame(width: 90, height: 90)
            Toggle("FillStyle(eoFill: \(eoFill ? "true" : "false"))", isOn: $eoFill)
                .toggleStyle(.switch)
                .controlSize(.small)
                .font(.caption.monospaced())
            C16_Caption("Both circles wind the same way, so only the even-odd rule leaves the inner one as a hole.")
        }
    }
}

// MARK: - Shape.fill() › .fill(style:)

private struct C16_FillStyleOnlyExample: View {
    @State private var tint: Color = .pink

    var body: some View {
        VStack(spacing: 12) {
            C16_RingShape()
                .fill(style: FillStyle(eoFill: true))
                .foregroundStyle(.tint)
                .tint(tint)
                .frame(width: 90, height: 90)
            Picker("tint", selection: $tint) {
                Text(".pink").tag(Color.pink)
                Text(".teal").tag(Color.teal)
                Text(".orange").tag(Color.orange)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 220)
            C16_Caption("No ShapeStyle argument: the ring takes the inherited foreground, here .tint, while the FillStyle still controls the winding rule.")
        }
    }
}

// MARK: - Shape.stroke() › .stroke(_:lineWidth:)

private struct C16_StrokeLineWidthExample: View {
    @State private var lineWidth: CGFloat = 4

    var body: some View {
        VStack(spacing: 12) {
            Circle()
                .stroke(.orange, lineWidth: lineWidth)
                .frame(width: 80, height: 80)
                .c16Bounds()
                .padding(8)
            HStack {
                Slider(value: $lineWidth, in: 1...16).frame(width: 160)
                Text("lineWidth \(Int(lineWidth))").font(.caption.monospacedDigit())
            }
            C16_Caption("The stroke is centered on the path, so half of it grows outside the dashed frame as the width rises.")
        }
    }
}

// MARK: - Shape.stroke() › .stroke(_:style:)

private struct C16_StrokeStyleExample: View {
    private let start = Date()

    var body: some View {
        VStack(spacing: 12) {
            TimelineView(.animation) { timeline in
                let phase = CGFloat(timeline.date.timeIntervalSince(start) * 30)
                Path { p in
                    p.move(to: CGPoint(x: 0, y: 40))
                    p.addLine(to: CGPoint(x: 200, y: 0))
                }
                .stroke(.orange, style: StrokeStyle(lineWidth: 4, lineCap: .round,
                                                    dash: [8, 6], dashPhase: phase))
                .frame(width: 200, height: 40)
                .padding(8)
            }
            C16_Caption("StrokeStyle adds caps, joins and dashes; animating dashPhase makes the dashes march along the path.")
        }
    }
}

// MARK: - Shape.stroke() › .stroke(style:)

private struct C16_StrokeStyleOnlyExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 36) {
                C16_Labeled(".foregroundStyle(.green)") {
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round))
                        .foregroundStyle(.green)
                        .frame(width: 80, height: 80)
                }
                C16_Labeled(".fill(.purple.gradient)") {
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 6, dash: [2, 10]))
                        .fill(.purple.gradient)
                        .frame(width: 80, height: 80)
                }
            }
            C16_Caption("Without a style argument the result is still a Shape: paint it with the foreground, or fill the outline itself.")
        }
    }
}

// MARK: - Shape.union() › Shape.intersection()

private struct C16_ShapeIntersectionExample: View {
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .stroke(.secondary, style: StrokeStyle(lineWidth: 1, dash: [3, 3]))
                Rectangle().size(width: 100, height: 50)
                    .stroke(.secondary, style: StrokeStyle(lineWidth: 1, dash: [3, 3]))
                Circle()
                    .intersection(Rectangle().size(width: 100, height: 50))
                    .fill(.blue)
            }
            .frame(width: 100, height: 100)
            C16_Caption("Only the region inside both outlines survives: the circle's top half, where the 100 × 50 rectangle overlaps it.")
        }
    }
}

// MARK: - Shape.union() › Shape.subtracting()

private struct C16_ShapeSubtractingExample: View {
    var body: some View {
        VStack(spacing: 10) {
            Rectangle()
                .subtracting(Circle().scale(0.5))
                .fill(.black)
                .frame(width: 100, height: 100)
                .background(LinearGradient(colors: [.orange, .pink], startPoint: .topLeading, endPoint: .bottomTrailing))
            C16_Caption("The gradient behind shows through: subtracting removes the scaled circle's area instead of painting over it.")
        }
    }
}

// MARK: - Shape.union() › Shape.symmetricDifference()

private struct C16_ShapeSymmetricDifferenceExample: View {
    @State private var offset: CGFloat = 40

    var body: some View {
        VStack(spacing: 10) {
            Circle()
                .symmetricDifference(Circle().offset(x: offset))
                .fill(.orange)
                .frame(width: 100, height: 100)
                .frame(width: 180, alignment: .leading)
            HStack {
                Slider(value: $offset, in: 0...80).frame(width: 160)
                Text("offset \(Int(offset))").font(.caption.monospacedDigit())
            }
            C16_Caption("Exclusive-or: the lens where the two circles overlap is cut away, leaving two crescents.")
        }
    }
}

// MARK: - Shape.union() › .intersection(_:eoFill:)

private struct C16_ShapeIntersectionEOFillExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 36) {
                C16_Labeled("eoFill: true") {
                    C16_RingShape()
                        .intersection(Rectangle().size(width: 100, height: 60), eoFill: true)
                        .fill(.blue)
                        .frame(width: 100, height: 100)
                }
                C16_Labeled("eoFill: false") {
                    C16_RingShape()
                        .intersection(Rectangle().size(width: 100, height: 60), eoFill: false)
                        .fill(.blue)
                        .frame(width: 100, height: 100)
                }
            }
            C16_Caption("Same clip rectangle, different winding rule: even-odd keeps the ring's hole, nonzero treats it as a solid disk.")
        }
    }
}
