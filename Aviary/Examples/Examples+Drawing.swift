//
//  Examples+Drawing.swift
//  Aviary
//
//  Rendered usage examples for the entries in CatalogData/gen-drawing.json.
//  Entries that already have an interactive demo (demoID) are not here.
//

import SwiftUI
import CoreGraphics

enum ExamplesDrawing {
    static let entries: [ExampleEntry] = [
        ExampleEntry(topic: ".allowedDynamicRange()", code: """
        Image("sunsetHDR")
            .resizable()
            .scaledToFit()
            .allowedDynamicRange(.high)
        """) { AnyView(D_AllowedDynamicRangeExample()) },

        ExampleEntry(topic: ".antialiased()", code: """
        // `pixels` is a 7×7 bitmap drawn with CoreGraphics
        pixels
            .resizable()
            .interpolation(.none)
            .antialiased(false)
            .rotationEffect(.degrees(14))
        """) { AnyView(D_AntialiasedExample()) },

        ExampleEntry(topic: ".backgroundStyle()", code: """
        GroupBox("Sleep") {
            Label("7 h 42 m", systemImage: "bed.double.fill")
        }
        .backgroundStyle(.blue.opacity(0.12))
        """) { AnyView(D_BackgroundStyleExample()) },

        ExampleEntry(topic: ".blendMode()", code: """
        ZStack {
            LinearGradient(colors: [.white, .blue],
                           startPoint: .top, endPoint: .bottom)
            Circle()
                .fill(.orange)
                .blendMode(.multiply)
                .padding(28)
        }
        .compositingGroup()
        """) { AnyView(D_BlendModeModifierExample()) },

        ExampleEntry(topic: ".border()", code: """
        VStack {
            Text("Row").padding(8).border(.secondary)
            Text("DRAFT").padding(6).border(.red, width: 2)
        }
        """) { AnyView(D_BorderExample()) },

        ExampleEntry(topic: ".brightness()", code: """
        Slider(value: $amount, in: -1...1)

        RoundedRectangle(cornerRadius: 10)
            .fill(.blue.gradient)
            .brightness(amount)
        """) { AnyView(D_BrightnessExample()) },

        ExampleEntry(topic: ".colorEffect()", code: """
        Image("portrait")
            .colorEffect(
                ShaderLibrary.duotone(.color(.indigo), .color(.orange))
            )
        """) { AnyView(D_ColorEffectExample()) },

        ExampleEntry(topic: ".colorInvert()", code: """
        let swatch = LinearGradient(colors: [.blue, .purple, .pink, .orange],
                                    startPoint: .topLeading, endPoint: .bottomTrailing)

        HStack {
            swatch
            swatch.colorInvert()
        }
        """) { AnyView(D_ColorInvertExample()) },

        ExampleEntry(topic: ".colorMultiply()", code: """
        Toggle("Dim", isOn: $dimmed)

        LinearGradient(colors: [.blue, .purple, .pink, .orange],
                       startPoint: .topLeading, endPoint: .bottomTrailing)
            .colorMultiply(dimmed ? .gray : .white)
            .animation(.easeOut(duration: 0.2), value: dimmed)
        """) { AnyView(D_ColorMultiplyExample()) },

        ExampleEntry(topic: ".compositingGroup()", code: """
        // Right stack adds .compositingGroup() before the opacity
        ZStack {
            Circle().fill(.red).offset(x: -18)
            Circle().fill(.red).offset(x: 18)
        }
        .compositingGroup()
        .opacity(0.5)
        """) { AnyView(D_CompositingGroupExample()) },

        ExampleEntry(topic: ".contrast()", code: """
        Slider(value: $amount, in: 0...2)

        LinearGradient(colors: [.red, .orange, .yellow, .green],
                       startPoint: .leading, endPoint: .trailing)
            .contrast(amount)
        """) { AnyView(D_ContrastExample()) },

        ExampleEntry(topic: ".cornerRadius()", code: """
        // Deprecated:
        thumbnail.cornerRadius(12)

        // Modern replacement:
        thumbnail.clipShape(.rect(cornerRadius: 12))
        """) { AnyView(D_CornerRadiusExample()) },

        ExampleEntry(topic: ".distortionEffect()", code: """
        Text("Making Waves")
            .font(.system(size: 44, weight: .black))
            .distortionEffect(
                ShaderLibrary.wave(.float(time)),
                maxSampleOffset: CGSize(width: 0, height: 12)
            )
        """) { AnyView(D_DistortionEffectExample()) },

        ExampleEntry(topic: ".drawingGroup()", code: """
        ZStack {
            ForEach(0..<5) { i in
                Circle()
                    .fill(palette[i])
                    .frame(width: 70, height: 70)
                    .offset(offsets[i])
                    .blendMode(.plusLighter)
            }
        }
        .drawingGroup()   // flatten to one Metal layer
        """) { AnyView(D_DrawingGroupExample()) },

        ExampleEntry(topic: ".foregroundColor()", code: """
        // Deprecated:
        Text("Hi").foregroundColor(.secondary)

        // Modern replacement:
        Text("Hi").foregroundStyle(.secondary)
        """) { AnyView(D_ForegroundColorExample()) },

        ExampleEntry(topic: ".glassEffectID()", code: """
        GlassEffectContainer {
            if expanded {
                toolbarRow
                    .glassEffect()
                    .glassEffectID("tools", in: ns)
            } else {
                compactButton
                    .glassEffect()
                    .glassEffectID("tools", in: ns)
            }
        }
        """) { AnyView(D_GlassEffectIDExample()) },

        ExampleEntry(topic: ".grayscale()", code: """
        Toggle("Sold out", isOn: $soldOut)

        LinearGradient(colors: [.blue, .purple, .pink, .orange],
                       startPoint: .topLeading, endPoint: .bottomTrailing)
            .grayscale(soldOut ? 1 : 0)
        """) { AnyView(D_GrayscaleExample()) },

        ExampleEntry(topic: ".hueRotation()", code: """
        Slider(value: $phase, in: 0...360)

        LinearGradient(colors: [.purple, .cyan],
                       startPoint: .leading, endPoint: .trailing)
            .hueRotation(.degrees(phase))
        """) { AnyView(D_HueRotationExample()) },

        ExampleEntry(topic: ".imageScale()", code: """
        HStack {
            Image(systemName: "bolt.fill").imageScale(.small)
            Image(systemName: "bolt.fill").imageScale(.medium)
            Image(systemName: "bolt.fill").imageScale(.large)
        }
        .font(.title)
        """) { AnyView(D_ImageScaleExample()) },

        ExampleEntry(topic: ".interpolation()", code: """
        // `pixels` is a 7×7 bitmap drawn with CoreGraphics
        pixels
            .resizable()
            .interpolation(.none)     // vs .high
            .frame(width: 110, height: 110)
        """) { AnyView(D_InterpolationExample()) },

        ExampleEntry(topic: ".layerEffect()", code: """
        cardView
            .layerEffect(
                ShaderLibrary.chromaticAberration(.float(strength)),
                maxSampleOffset: CGSize(width: 8, height: 0)
            )
        """) { AnyView(D_LayerEffectExample()) },

        ExampleEntry(topic: ".luminanceToAlpha()", code: """
        Rectangle()
            .fill(.blue.gradient)
            .mask {
                ZStack {
                    Color.black
                    Text("SALE").font(.system(size: 44, weight: .black))
                        .foregroundStyle(.white)
                }
                .luminanceToAlpha()
            }
        """) { AnyView(D_LuminanceToAlphaExample()) },

        ExampleEntry(topic: ".renderingMode()", code: """
        // `glyph` is a multicolor bitmap drawn with CoreGraphics
        HStack {
            glyph.renderingMode(.original)
            glyph.renderingMode(.template).foregroundStyle(.secondary)
        }
        """) { AnyView(D_RenderingModeExample()) },

        ExampleEntry(topic: ".resizable()", code: """
        // `glyph` is a 40×40 bitmap drawn with CoreGraphics
        HStack {
            glyph                                    // native size
            glyph.resizable()                        // fills the frame
        }
        .frame(height: 90)
        """) { AnyView(D_ResizableExample()) },

        ExampleEntry(topic: ".saturation()", code: """
        Slider(value: $amount, in: 0...2)

        LinearGradient(colors: [.red, .orange, .yellow, .green],
                       startPoint: .leading, endPoint: .trailing)
            .saturation(amount)
        """) { AnyView(D_SaturationExample()) },

        ExampleEntry(topic: ".strokeBorder()", code: """
        Circle()
            .strokeBorder(.teal, lineWidth: 12)

        RoundedRectangle(cornerRadius: 16)
            .strokeBorder(.orange, style: StrokeStyle(lineWidth: 4, dash: [10, 6]))
        """) { AnyView(D_StrokeBorderExample()) },

        ExampleEntry(topic: ".symbolVariant()", code: """
        HStack {
            Image(systemName: "heart")
            Image(systemName: "bell")
            Image(systemName: "person")
        }
        .symbolVariant(variant)   // .none / .fill / .slash / .circle
        """) { AnyView(D_SymbolVariantExample()) },

        ExampleEntry(topic: "AnyGradient", code: """
        HStack {
            RoundedRectangle(cornerRadius: 12).fill(Color.indigo.gradient)
            RoundedRectangle(cornerRadius: 12).fill(Color.teal.gradient)
            RoundedRectangle(cornerRadius: 12).fill(Color.pink.gradient)
        }
        """) { AnyView(D_AnyGradientExample()) },

        ExampleEntry(topic: "AnyShapeStyle", code: """
        var fillStyle: AnyShapeStyle {
            isCritical ? AnyShapeStyle(.red.gradient)
                       : AnyShapeStyle(.quaternary)
        }

        RoundedRectangle(cornerRadius: 12).fill(fillStyle)
        """) { AnyView(D_AnyShapeStyleExample()) },

        ExampleEntry(topic: "BlendMode", code: """
        ZStack {
            LinearGradient(colors: [.blue, .green, .yellow, .red],
                           startPoint: .leading, endPoint: .trailing)
            Circle().fill(.white).blendMode(mode)
        }
        """) { AnyView(D_BlendModeTypeExample()) },

        ExampleEntry(topic: "Color", code: """
        let brand = Color(red: 0.12, green: 0.45, blue: 0.95)
        let sunset = Color(hue: 0.05, saturation: 0.8, brightness: 0.95)

        HStack {
            Capsule().fill(brand)
            Capsule().fill(sunset)
            Capsule().fill(Color.accentColor)
        }
        """) { AnyView(D_ColorExample()) },

        ExampleEntry(topic: "Color.Resolved", code: """
        @Environment(\\.self) private var environment

        let resolved = Color.orange.resolve(in: environment)
        Text("R \\(resolved.red)  G \\(resolved.green)  B \\(resolved.blue)")
        RoundedRectangle(cornerRadius: 8).fill(Color(resolved))
        """) { AnyView(D_ColorResolvedExample()) },

        ExampleEntry(topic: "ColorMatrix", code: """
        var m = ColorMatrix()          // sepia weights
        m.r1 = 0.39; m.r2 = 0.77; m.r3 = 0.19
        m.g1 = 0.35; m.g2 = 0.69; m.g3 = 0.17
        m.b1 = 0.27; m.b2 = 0.53; m.b3 = 0.13
        context.addFilter(.colorMatrix(m))
        """) { AnyView(D_ColorMatrixExample()) },

        ExampleEntry(topic: "ConcentricRectangle", code: """
        ConcentricRectangle()
            .fill(.thinMaterial)
            .padding(14)
        """) { AnyView(D_ConcentricRectangleExample()) },

        ExampleEntry(topic: "EllipticalGradient", code: """
        Ellipse()
            .fill(EllipticalGradient(
                colors: [.yellow, .orange],
                center: .center,
                startRadiusFraction: 0,
                endRadiusFraction: 0.7
            ))
        """) { AnyView(D_EllipticalGradientExample()) },

        ExampleEntry(topic: "FillShapeView", code: """
        // fill(...) keeps the shape, so stroke chains onto it
        Circle()
            .fill(.yellow)
            .stroke(.orange, lineWidth: 3)
        """) { AnyView(D_FillShapeViewExample()) },

        ExampleEntry(topic: "FillStyle", code: """
        Path { p in
            p.addEllipse(in: CGRect(x: 0, y: 0, width: 100, height: 100))
            p.addEllipse(in: CGRect(x: 25, y: 25, width: 50, height: 50))
        }
        .fill(.blue, style: FillStyle(eoFill: true))
        """) { AnyView(D_FillStyleExample()) },

        ExampleEntry(topic: "ForegroundStyle", code: """
        Canvas { context, size in
            let dot = Path(ellipseIn: CGRect(origin: .zero, size: size))
            context.fill(dot, with: .style(ForegroundStyle()))
        }
        .foregroundStyle(tint)
        """) { AnyView(D_ForegroundStyleExample()) },

        ExampleEntry(topic: "Gradient", code: """
        let heat = Gradient(stops: [
            .init(color: .blue, location: 0),
            .init(color: .yellow, location: 0.65),
            .init(color: .red, location: 1)
        ])

        Rectangle().fill(LinearGradient(gradient: heat,
                                        startPoint: .leading, endPoint: .trailing))
        """) { AnyView(D_GradientExample()) },

        ExampleEntry(topic: "GraphicsContext", code: """
        Canvas { context, size in
            let rect = CGRect(origin: .zero, size: size)
            context.addFilter(.blur(radius: 2))
            context.fill(Path(ellipseIn: rect.insetBy(dx: 20, dy: 20)),
                         with: .color(.blue))
            context.stroke(
                Path(rect.insetBy(dx: 4, dy: 4)),
                with: .linearGradient(Gradient(colors: [.red, .yellow]),
                                      startPoint: .zero,
                                      endPoint: CGPoint(x: size.width, y: 0)),
                lineWidth: 3)
        }
        """) { AnyView(D_GraphicsContextExample()) },

        ExampleEntry(topic: "HierarchicalShapeStyle", code: """
        VStack(alignment: .leading) {
            Text("Now Playing").foregroundStyle(.primary)
            Text("Album — Artist").foregroundStyle(.secondary)
            Text("Lossless").foregroundStyle(.tertiary)
        }
        """) { AnyView(D_HierarchicalShapeStyleExample()) },

        ExampleEntry(topic: "ImageRenderer", code: """
        let renderer = ImageRenderer(content: card)
        renderer.scale = displayScale
        if let cg = renderer.cgImage {
            Image(decorative: cg, scale: displayScale)
        }
        """) { AnyView(D_ImageRendererExample()) },

        ExampleEntry(topic: "OffsetShape", code: """
        ZStack {
            OffsetShape(shape: Ellipse(), offset: CGSize(width: 0, height: 10))
                .fill(.black.opacity(0.25))
            Ellipse().fill(.yellow)
        }
        """) { AnyView(D_OffsetShapeExample()) },

        ExampleEntry(topic: "RectangleCornerRadii", code: """
        UnevenRoundedRectangle(
            cornerRadii: RectangleCornerRadii(
                topLeading: 28, bottomLeading: 0,
                bottomTrailing: 0, topTrailing: 28
            )
        )
        .fill(.teal.gradient)
        """) { AnyView(D_RectangleCornerRadiiExample()) },

        ExampleEntry(topic: "RoundedCornerStyle", code: """
        HStack {
            RoundedRectangle(cornerRadius: 22, style: .circular)
            RoundedRectangle(cornerRadius: 22, style: .continuous)
        }
        .fill(.indigo.gradient)
        """) { AnyView(D_RoundedCornerStyleExample()) },

        ExampleEntry(topic: "ScaledShape", code: """
        ZStack {
            Circle().stroke(.secondary, lineWidth: 1)
            ScaledShape(shape: Circle(),
                        scale: CGSize(width: 0.6, height: 0.6),
                        anchor: .center)
                .fill(.cyan)
        }
        """) { AnyView(D_ScaledShapeExample()) },

        ExampleEntry(topic: "Shader", code: """
        let shader = ShaderLibrary.ripple(
            .float2(touchPoint),
            .float(elapsedTime)
        )
        Rectangle()
            .fill(.blue)
            .layerEffect(shader, maxSampleOffset: CGSize(width: 20, height: 20))
        """) { AnyView(D_ShaderExample()) },

        ExampleEntry(topic: "ShaderLibrary", code: """
        let library = ShaderLibrary.bundle(.module)
        let effect = library.pixellate(.float(strength))
        image.distortionEffect(effect, maxSampleOffset: .zero)
        """) { AnyView(D_ShaderLibraryExample()) },

        ExampleEntry(topic: "ShadowStyle", code: """
        HStack {
            Circle().fill(.blue.shadow(.drop(color: .black.opacity(0.3), radius: 6, y: 4)))
            Circle().fill(.blue.shadow(.inner(color: .black.opacity(0.6), radius: 6, y: 3)))
        }
        """) { AnyView(D_ShadowStyleExample()) },

        ExampleEntry(topic: "Shape.fill()", code: """
        Circle()
            .fill(.blue.gradient)
            .frame(width: 120, height: 120)
        """) { AnyView(D_ShapeFillExample()) },

        ExampleEntry(topic: "Shape.offset()", code: """
        ZStack {
            Circle().offset(x: 6, y: 6).fill(.black.opacity(0.25))
            Circle().fill(.yellow)
        }
        """) { AnyView(D_ShapeOffsetExample()) },

        ExampleEntry(topic: "Shape.rotation()", code: """
        Rectangle()
            .rotation(.degrees(30))
            .fill(.indigo)
            .frame(width: 120, height: 60)
        """) { AnyView(D_ShapeRotationExample()) },

        ExampleEntry(topic: "Shape.scale()", code: """
        Circle()
            .scale(0.8)
            .stroke(.pink, lineWidth: 3)
        """) { AnyView(D_ShapeScaleExample()) },

        ExampleEntry(topic: "Shape.size()", code: """
        Rectangle()
            .size(width: 80, height: 40)
            .fill(.mint)
        """) { AnyView(D_ShapeSizeExample()) },

        ExampleEntry(topic: "Shape.stroke()", code: """
        Path { p in
            p.move(to: CGPoint(x: 0, y: 60))
            p.addLine(to: CGPoint(x: 220, y: 10))
        }
        .stroke(.orange, style: StrokeStyle(lineWidth: 4, dash: [8, 4]))
        """) { AnyView(D_ShapeStrokeExample()) },

        ExampleEntry(topic: "Shape.transform()", code: """
        Ellipse()
            .transform(CGAffineTransform(a: 1, b: 0, c: 0.4, d: 1, tx: 0, ty: 0))
            .fill(.purple)
        """) { AnyView(D_ShapeTransformExample()) },

        ExampleEntry(topic: "Shape.trim()", code: """
        Slider(value: $progress, in: 0...1)

        Circle()
            .trim(from: 0, to: progress)
            .stroke(.green, style: StrokeStyle(lineWidth: 8, lineCap: .round))
            .rotationEffect(.degrees(-90))
        """) { AnyView(D_ShapeTrimExample()) },

        ExampleEntry(topic: "Shape.union()", code: """
        Circle().union(Capsule().size(width: 150, height: 40)).fill(.red)
        Rectangle().subtracting(Circle().scale(0.5)).fill(.blue)
        Circle().intersection(Rectangle().size(width: 120, height: 60)).fill(.green)
        """) { AnyView(D_ShapeUnionExample()) },

        ExampleEntry(topic: "StrokeShapeView", code: """
        func ring(_ progress: Double) -> some View {
            Circle()
                .trim(from: 0, to: progress)
                .stroke(.tint, style: StrokeStyle(lineWidth: 6, lineCap: .round))
        }
        """) { AnyView(D_StrokeShapeViewExample()) },

        ExampleEntry(topic: "StrokeStyle", code: """
        let style = StrokeStyle(lineWidth: 6, lineCap: .round,
                                lineJoin: .round, dash: [14, 8], dashPhase: phase)

        RoundedRectangle(cornerRadius: 16).stroke(.orange, style: style)
        """) { AnyView(D_StrokeStyleExample()) },

        ExampleEntry(topic: "TransformedShape", code: """
        TransformedShape(
            shape: Rectangle(),
            transform: CGAffineTransform(rotationAngle: .pi / 8)
        )
        .stroke(.gray, lineWidth: 2)
        """) { AnyView(D_TransformedShapeExample()) },
    ]
}

// MARK: - Shared CoreGraphics bitmap helpers (no assets)

/// Draws a 7×7 pixel-art bitmap so interpolation/antialiasing examples need no asset.
private func D_makePixelImage() -> Image {
    let side = 7
    let fallback = Image(systemName: "squareshape.split.3x3")
    guard let context = CGContext(
        data: nil, width: side, height: side, bitsPerComponent: 8, bytesPerRow: 0,
        space: CGColorSpaceCreateDeviceRGB(),
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    ) else { return fallback }

    context.setFillColor(CGColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 1))
    context.fill(CGRect(x: 0, y: 0, width: side, height: side))
    context.setFillColor(CGColor(red: 0.20, green: 0.42, blue: 0.95, alpha: 1))
    let on: [(Int, Int)] = [(1, 5), (5, 5), (1, 3), (5, 3), (2, 1), (3, 1), (4, 1)]
    for (x, y) in on { context.fill(CGRect(x: x, y: y, width: 1, height: 1)) }

    guard let image = context.makeImage() else { return fallback }
    return Image(image, scale: 1, label: Text("pixel art"))
}

/// Draws a 40×40 multicolor glyph on a transparent ground for rendering-mode/resizable examples.
private func D_makeGlyphImage() -> Image {
    let side = 40
    let fallback = Image(systemName: "seal.fill")
    guard let context = CGContext(
        data: nil, width: side, height: side, bitsPerComponent: 8, bytesPerRow: 0,
        space: CGColorSpaceCreateDeviceRGB(),
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    ) else { return fallback }

    context.clear(CGRect(x: 0, y: 0, width: side, height: side))
    context.setFillColor(CGColor(red: 0.95, green: 0.30, blue: 0.25, alpha: 1))
    context.fillEllipse(in: CGRect(x: 4, y: 4, width: 32, height: 32))
    context.setFillColor(CGColor(red: 0.20, green: 0.55, blue: 0.95, alpha: 1))
    context.beginPath()
    context.move(to: CGPoint(x: 20, y: 9))
    context.addLine(to: CGPoint(x: 31, y: 29))
    context.addLine(to: CGPoint(x: 9, y: 29))
    context.closePath()
    context.fillPath()

    guard let image = context.makeImage() else { return fallback }
    return Image(image, scale: 1, label: Text("glyph"))
}

// MARK: - .allowedDynamicRange()

private struct D_AllowedDynamicRangeExample: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "sun.max.fill")
                .font(.system(size: 64))
                .foregroundStyle(.orange.gradient)
                .allowedDynamicRange(.high)

            Text("Illustrative — .high uses the display's HDR headroom for HDR images at runtime.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 6)
    }
}

// MARK: - .antialiased()

private struct D_AntialiasedExample: View {
    private let pixels = D_makePixelImage()

    var body: some View {
        HStack(spacing: 24) {
            cell("antialiased(true)") {
                pixels.resizable().interpolation(.none).antialiased(true)
                    .frame(width: 90, height: 90)
                    .rotationEffect(.degrees(14))
            }
            cell("antialiased(false)") {
                pixels.resizable().interpolation(.none).antialiased(false)
                    .frame(width: 90, height: 90)
                    .rotationEffect(.degrees(14))
            }
        }
        .padding(.vertical, 10)
    }

    private func cell<Content: View>(_ caption: String, @ViewBuilder _ content: () -> Content) -> some View {
        VStack(spacing: 8) {
            content()
            Text(caption).font(.caption.monospaced()).foregroundStyle(.secondary)
        }
    }
}

// MARK: - .backgroundStyle()

private struct D_BackgroundStyleExample: View {
    var body: some View {
        GroupBox("Sleep") {
            HStack {
                Label("7 h 42 m", systemImage: "bed.double.fill")
                Spacer()
                Text("Good").foregroundStyle(.secondary)
            }
            .font(.callout)
        }
        .backgroundStyle(.blue.opacity(0.12))
        .frame(maxWidth: 260)
    }
}

// MARK: - .blendMode()

private struct D_BlendModeModifierExample: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.white, .blue],
                           startPoint: .top, endPoint: .bottom)
            Circle()
                .fill(.orange)
                .blendMode(.multiply)
                .padding(28)
        }
        .compositingGroup()
        .frame(height: 150)
        .clipShape(.rect(cornerRadius: 12))
    }
}

// MARK: - .border()

private struct D_BorderExample: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Row")
                .padding(8)
                .border(.secondary)
            Text("DRAFT")
                .font(.headline)
                .padding(6)
                .border(.red, width: 2)
        }
        .padding(.vertical, 8)
    }
}

// MARK: - .brightness()

private struct D_BrightnessExample: View {
    @State private var amount = 0.0

    var body: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.blue.gradient)
                .brightness(amount)
                .frame(height: 70)
            Slider(value: $amount, in: -1...1)
            Text("brightness: \(amount, format: .number.precision(.fractionLength(2)))")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - .colorEffect()

private struct D_ColorEffectExample: View {
    var body: some View {
        VStack(spacing: 10) {
            LinearGradient(colors: [.indigo, .orange],
                           startPoint: .leading, endPoint: .trailing)
                .frame(height: 80)
                .clipShape(.rect(cornerRadius: 10))
                .overlay {
                    Image(systemName: "person.fill")
                        .font(.system(size: 46))
                        .foregroundStyle(.white.opacity(0.25))
                }

            Text("Illustrative — a Metal color shader remaps each pixel at runtime.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - .colorInvert()

private struct D_ColorInvertExample: View {
    private var swatch: some View {
        LinearGradient(colors: [.blue, .purple, .pink, .orange],
                       startPoint: .topLeading, endPoint: .bottomTrailing)
    }

    var body: some View {
        HStack(spacing: 12) {
            labeled("original") { swatch }
            labeled("colorInvert()") { swatch.colorInvert() }
        }
    }

    private func labeled<Content: View>(_ caption: String, @ViewBuilder _ content: () -> Content) -> some View {
        VStack(spacing: 6) {
            content()
                .frame(height: 80)
                .clipShape(.rect(cornerRadius: 10))
            Text(caption).font(.caption.monospaced()).foregroundStyle(.secondary)
        }
    }
}

// MARK: - .colorMultiply()

private struct D_ColorMultiplyExample: View {
    @State private var dimmed = false

    var body: some View {
        VStack(spacing: 12) {
            LinearGradient(colors: [.blue, .purple, .pink, .orange],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .colorMultiply(dimmed ? .gray : .white)
                .animation(.easeOut(duration: 0.2), value: dimmed)
                .frame(height: 80)
                .clipShape(.rect(cornerRadius: 10))
            Toggle("Dim", isOn: $dimmed)
                .toggleStyle(.switch)
                .fixedSize()
        }
    }
}

// MARK: - .compositingGroup()

private struct D_CompositingGroupExample: View {
    var body: some View {
        HStack(spacing: 28) {
            labeled("no group") {
                overlappingCircles
                    .opacity(0.5)
            }
            labeled("compositingGroup()") {
                overlappingCircles
                    .compositingGroup()
                    .opacity(0.5)
            }
        }
        .padding(.vertical, 8)
    }

    private var overlappingCircles: some View {
        ZStack {
            Circle().fill(.red).frame(width: 54, height: 54).offset(x: -18)
            Circle().fill(.red).frame(width: 54, height: 54).offset(x: 18)
        }
        .frame(width: 100, height: 60)
    }

    private func labeled<Content: View>(_ caption: String, @ViewBuilder _ content: () -> Content) -> some View {
        VStack(spacing: 8) {
            content()
            Text(caption).font(.caption.monospaced()).foregroundStyle(.secondary)
        }
    }
}

// MARK: - .contrast()

private struct D_ContrastExample: View {
    @State private var amount = 1.0

    var body: some View {
        VStack(spacing: 12) {
            LinearGradient(colors: [.red, .orange, .yellow, .green],
                           startPoint: .leading, endPoint: .trailing)
                .contrast(amount)
                .frame(height: 70)
                .clipShape(.rect(cornerRadius: 10))
            Slider(value: $amount, in: 0...2)
            Text("contrast: \(amount, format: .number.precision(.fractionLength(2)))")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - .cornerRadius()

private struct D_CornerRadiusExample: View {
    var body: some View {
        VStack(spacing: 10) {
            LinearGradient(colors: [.teal, .blue],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 160, height: 90)
                .clipShape(.rect(cornerRadius: 12))

            Text("cornerRadius(_:) is deprecated — rendered with clipShape(.rect(cornerRadius:)).")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - .distortionEffect()

private struct D_DistortionEffectExample: View {
    private let letters = Array("Making Waves")

    var body: some View {
        VStack(spacing: 10) {
            TimelineView(.animation) { timeline in
                let t = timeline.date.timeIntervalSinceReferenceDate
                HStack(spacing: 1) {
                    ForEach(Array(letters.enumerated()), id: \.offset) { index, char in
                        Text(String(char))
                            .font(.system(size: 30, weight: .black))
                            .offset(y: char == " " ? 0 : sin(t * 3 + Double(index) * 0.5) * 6)
                    }
                }
                .foregroundStyle(.indigo.gradient)
            }
            .frame(height: 46)

            Text("Illustrative — the Metal distortion shader warps geometry at runtime.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - .drawingGroup()

private struct D_DrawingGroupExample: View {
    private let palette: [Color] = [.red, .green, .blue, .yellow, .cyan]
    private let offsets: [CGSize] = [
        CGSize(width: 0, height: -14), CGSize(width: 26, height: 6),
        CGSize(width: 16, height: 22), CGSize(width: -16, height: 22),
        CGSize(width: -26, height: 6),
    ]

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Color.black
                ZStack {
                    ForEach(0..<5, id: \.self) { i in
                        Circle()
                            .fill(palette[i])
                            .frame(width: 60, height: 60)
                            .offset(offsets[i])
                            .blendMode(.plusLighter)
                    }
                }
                .drawingGroup()
            }
            .frame(height: 120)
            .clipShape(.rect(cornerRadius: 12))

            Text("The additive blend is flattened into one Metal-rendered layer.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - .foregroundColor()

private struct D_ForegroundColorExample: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Hi")
                .font(.largeTitle.bold())
                .foregroundStyle(.secondary)

            Text("foregroundColor(_:) is deprecated — rendered with foregroundStyle(_:).")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 6)
    }
}

// MARK: - .glassEffectID()

private struct D_GlassEffectIDExample: View {
    @Namespace private var ns
    @State private var expanded = false

    var body: some View {
        ZStack {
            LinearGradient(colors: [.indigo, .pink, .orange],
                           startPoint: .topLeading, endPoint: .bottomTrailing)

            GlassEffectContainer {
                if expanded {
                    HStack(spacing: 18) {
                        Image(systemName: "bold")
                        Image(systemName: "italic")
                        Image(systemName: "underline")
                    }
                    .font(.title3)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 12)
                    .glassEffect()
                    .glassEffectID("tools", in: ns)
                } else {
                    Image(systemName: "textformat")
                        .font(.title3)
                        .padding(14)
                        .glassEffect()
                        .glassEffectID("tools", in: ns)
                }
            }
            .foregroundStyle(.white)
        }
        .frame(height: 150)
        .clipShape(.rect(cornerRadius: 12))
        .onTapGesture { withAnimation(.bouncy) { expanded.toggle() } }
        .overlay(alignment: .bottom) {
            Text("Tap to morph the shared glass element")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.85))
                .padding(6)
        }
    }
}

// MARK: - .grayscale()

private struct D_GrayscaleExample: View {
    @State private var soldOut = false

    var body: some View {
        VStack(spacing: 12) {
            LinearGradient(colors: [.blue, .purple, .pink, .orange],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .grayscale(soldOut ? 1 : 0)
                .animation(.easeInOut, value: soldOut)
                .frame(height: 80)
                .clipShape(.rect(cornerRadius: 10))
            Toggle("Sold out", isOn: $soldOut)
                .toggleStyle(.switch)
                .fixedSize()
        }
    }
}

// MARK: - .hueRotation()

private struct D_HueRotationExample: View {
    @State private var phase = 0.0

    var body: some View {
        VStack(spacing: 12) {
            LinearGradient(colors: [.purple, .cyan],
                           startPoint: .leading, endPoint: .trailing)
                .hueRotation(.degrees(phase))
                .frame(height: 70)
                .clipShape(.rect(cornerRadius: 10))
            Slider(value: $phase, in: 0...360)
            Text("hueRotation: \(Int(phase))°")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - .imageScale()

private struct D_ImageScaleExample: View {
    var body: some View {
        HStack(spacing: 28) {
            cell(".small", .small)
            cell(".medium", .medium)
            cell(".large", .large)
        }
        .font(.title)
        .padding(.vertical, 8)
    }

    private func cell(_ caption: String, _ scale: Image.Scale) -> some View {
        VStack(spacing: 8) {
            Image(systemName: "bolt.fill")
                .imageScale(scale)
                .foregroundStyle(.yellow)
            Text(caption).font(.caption.monospaced()).foregroundStyle(.secondary)
        }
    }
}

// MARK: - .interpolation()

private struct D_InterpolationExample: View {
    private let pixels = D_makePixelImage()

    var body: some View {
        HStack(spacing: 24) {
            cell(".none") {
                pixels.resizable().interpolation(.none)
                    .frame(width: 100, height: 100)
            }
            cell(".high") {
                pixels.resizable().interpolation(.high)
                    .frame(width: 100, height: 100)
            }
        }
        .padding(.vertical, 6)
    }

    private func cell<Content: View>(_ caption: String, @ViewBuilder _ content: () -> Content) -> some View {
        VStack(spacing: 8) {
            content().clipShape(.rect(cornerRadius: 8))
            Text(caption).font(.caption.monospaced()).foregroundStyle(.secondary)
        }
    }
}

// MARK: - .layerEffect()

private struct D_LayerEffectExample: View {
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Color.black
                ZStack {
                    label(.red).offset(x: -3)
                    label(.green)
                    label(.blue).offset(x: 3)
                }
                .blendMode(.plusLighter)
            }
            .frame(height: 80)
            .clipShape(.rect(cornerRadius: 10))

            Text("Illustrative — a Metal layer shader samples neighboring pixels at runtime.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }

    private func label(_ color: Color) -> some View {
        Text("GLITCH")
            .font(.system(size: 34, weight: .black))
            .foregroundStyle(color)
    }
}

// MARK: - .luminanceToAlpha()

private struct D_LuminanceToAlphaExample: View {
    var body: some View {
        Rectangle()
            .fill(.blue.gradient)
            .frame(height: 90)
            .mask {
                ZStack {
                    Color.black
                    Text("SALE")
                        .font(.system(size: 46, weight: .black))
                        .foregroundStyle(.white)
                }
                .luminanceToAlpha()
            }
    }
}

// MARK: - .renderingMode()

private struct D_RenderingModeExample: View {
    private let glyph = D_makeGlyphImage()

    var body: some View {
        HStack(spacing: 32) {
            cell(".original") {
                glyph.renderingMode(.original)
            }
            cell(".template") {
                glyph.renderingMode(.template)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 8)
    }

    private func cell<Content: View>(_ caption: String, @ViewBuilder _ content: () -> Content) -> some View {
        VStack(spacing: 8) {
            content()
            Text(caption).font(.caption.monospaced()).foregroundStyle(.secondary)
        }
    }
}

// MARK: - .resizable()

private struct D_ResizableExample: View {
    private let glyph = D_makeGlyphImage()

    var body: some View {
        HStack(spacing: 32) {
            cell("native size") {
                glyph
                    .frame(width: 90, height: 90)
            }
            cell("resizable()") {
                glyph.resizable()
                    .frame(width: 90, height: 90)
            }
        }
        .padding(.vertical, 6)
    }

    private func cell<Content: View>(_ caption: String, @ViewBuilder _ content: () -> Content) -> some View {
        VStack(spacing: 8) {
            content()
            Text(caption).font(.caption.monospaced()).foregroundStyle(.secondary)
        }
    }
}

// MARK: - .saturation()

private struct D_SaturationExample: View {
    @State private var amount = 1.0

    var body: some View {
        VStack(spacing: 12) {
            LinearGradient(colors: [.red, .orange, .yellow, .green],
                           startPoint: .leading, endPoint: .trailing)
                .saturation(amount)
                .frame(height: 70)
                .clipShape(.rect(cornerRadius: 10))
            Slider(value: $amount, in: 0...2)
            Text("saturation: \(amount, format: .number.precision(.fractionLength(2)))")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - .strokeBorder()

private struct D_StrokeBorderExample: View {
    var body: some View {
        HStack(spacing: 20) {
            Circle()
                .strokeBorder(.teal, lineWidth: 12)
                .frame(width: 80, height: 80)
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(.orange, style: StrokeStyle(lineWidth: 4, dash: [10, 6]))
                .frame(width: 90, height: 80)
            Capsule()
                .strokeBorder(style: StrokeStyle(lineWidth: 3))
                .foregroundStyle(.tint)
                .frame(width: 90, height: 44)
        }
        .padding(.vertical, 8)
    }
}

// MARK: - .symbolVariant()

private enum D_VariantChoice: String, CaseIterable, Identifiable {
    case none, fill, slash, circle
    var id: Self { self }
    var variant: SymbolVariants {
        switch self {
        case .none: .none
        case .fill: .fill
        case .slash: .slash
        case .circle: .circle
        }
    }
}

private struct D_SymbolVariantExample: View {
    @State private var choice: D_VariantChoice = .fill

    var body: some View {
        VStack(spacing: 14) {
            HStack(spacing: 22) {
                Image(systemName: "heart")
                Image(systemName: "bell")
                Image(systemName: "person")
            }
            .font(.largeTitle)
            .foregroundStyle(.pink)
            .symbolVariant(choice.variant)

            Picker("Variant", selection: $choice) {
                ForEach(D_VariantChoice.allCases) { Text(".\($0.rawValue)").tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
        }
    }
}

// MARK: - AnyGradient

private struct D_AnyGradientExample: View {
    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 12).fill(Color.indigo.gradient)
            RoundedRectangle(cornerRadius: 12).fill(Color.teal.gradient)
            RoundedRectangle(cornerRadius: 12).fill(Color.pink.gradient)
        }
        .frame(height: 90)
    }
}

// MARK: - AnyShapeStyle

private struct D_AnyShapeStyleExample: View {
    @State private var isCritical = false

    private var fillStyle: AnyShapeStyle {
        isCritical ? AnyShapeStyle(.red.gradient) : AnyShapeStyle(.quaternary)
    }

    var body: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 12)
                .fill(fillStyle)
                .frame(height: 80)
                .overlay {
                    Label(isCritical ? "Critical" : "Normal",
                          systemImage: isCritical ? "exclamationmark.triangle.fill" : "checkmark")
                        .font(.headline)
                }
            Toggle("Critical", isOn: $isCritical)
                .toggleStyle(.switch)
                .fixedSize()
        }
    }
}

// MARK: - BlendMode

private enum D_BlendChoice: String, CaseIterable, Identifiable {
    case normal, multiply, screen, overlay, plusLighter, difference
    var id: Self { self }
    var mode: BlendMode {
        switch self {
        case .normal: .normal
        case .multiply: .multiply
        case .screen: .screen
        case .overlay: .overlay
        case .plusLighter: .plusLighter
        case .difference: .difference
        }
    }
}

private struct D_BlendModeTypeExample: View {
    @State private var choice: D_BlendChoice = .multiply

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                LinearGradient(colors: [.blue, .green, .yellow, .red],
                               startPoint: .leading, endPoint: .trailing)
                Circle()
                    .fill(.white)
                    .frame(width: 70, height: 70)
                    .blendMode(choice.mode)
            }
            .compositingGroup()
            .frame(height: 90)
            .clipShape(.rect(cornerRadius: 10))

            Picker("Mode", selection: $choice) {
                ForEach(D_BlendChoice.allCases) { Text($0.rawValue).tag($0) }
            }
            .pickerStyle(.menu)
            .fixedSize()
        }
    }
}

// MARK: - Color

private struct D_ColorExample: View {
    private let brand = Color(red: 0.12, green: 0.45, blue: 0.95)
    private let sunset = Color(hue: 0.05, saturation: 0.8, brightness: 0.95)

    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 12) {
                cell("brand", brand)
                cell("sunset", sunset)
                cell("accent", Color.accentColor)
            }
        }
        .padding(.vertical, 6)
    }

    private func cell(_ caption: String, _ color: Color) -> some View {
        VStack(spacing: 6) {
            Capsule().fill(color).frame(height: 56)
            Text(caption).font(.caption.monospaced()).foregroundStyle(.secondary)
        }
    }
}

// MARK: - Color.Resolved

private struct D_ColorResolvedExample: View {
    @Environment(\.self) private var environment

    var body: some View {
        let resolved = Color.orange.resolve(in: environment)
        return VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(resolved))
                .frame(height: 44)
                .overlay(alignment: .leading) {
                    Text("Color(resolved)")
                        .font(.caption.monospaced())
                        .padding(.leading, 10)
                        .foregroundStyle(.white)
                }

            HStack(spacing: 10) {
                channel("R", Double(resolved.red), .red)
                channel("G", Double(resolved.green), .green)
                channel("B", Double(resolved.blue), .blue)
            }
        }
    }

    private func channel(_ name: String, _ value: Double, _ color: Color) -> some View {
        VStack(spacing: 4) {
            Text(name).font(.caption2.monospaced()).foregroundStyle(.secondary)
            ProgressView(value: value).tint(color)
            Text(value, format: .number.precision(.fractionLength(2)))
                .font(.caption2.monospaced())
        }
    }
}

// MARK: - ColorMatrix

private struct D_ColorMatrixExample: View {
    var body: some View {
        VStack(spacing: 10) {
            Canvas { context, size in
                let half = size.width / 2
                let gradient = Gradient(colors: [.red, .yellow, .green, .blue])

                let left = CGRect(x: 0, y: 0, width: half - 3, height: size.height)
                context.fill(
                    Path(ellipseIn: left.insetBy(dx: 10, dy: 10)),
                    with: .linearGradient(gradient, startPoint: .zero,
                                          endPoint: CGPoint(x: half, y: size.height)))

                var m = ColorMatrix()
                m.r1 = 0.39; m.r2 = 0.77; m.r3 = 0.19
                m.g1 = 0.35; m.g2 = 0.69; m.g3 = 0.17
                m.b1 = 0.27; m.b2 = 0.53; m.b3 = 0.13
                context.addFilter(.colorMatrix(m))

                let right = CGRect(x: half + 3, y: 0, width: half - 3, height: size.height)
                context.fill(
                    Path(ellipseIn: right.insetBy(dx: 10, dy: 10)),
                    with: .linearGradient(gradient, startPoint: CGPoint(x: half, y: 0),
                                          endPoint: CGPoint(x: size.width, y: size.height)))
            }
            .frame(height: 100)

            Text("Left: original · Right: sepia ColorMatrix filter")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - ConcentricRectangle

private struct D_ConcentricRectangleExample: View {
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                ConcentricRectangle()
                    .fill(.blue.gradient)
                ConcentricRectangle()
                    .fill(.thinMaterial)
                    .padding(14)
            }
            .frame(width: 200, height: 110)
            .containerShape(.rect(cornerRadius: 28))
            .clipShape(.rect(cornerRadius: 28))

            Text("Corner radii derive from the enclosing container so rounding stays concentric.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - EllipticalGradient

private struct D_EllipticalGradientExample: View {
    var body: some View {
        Ellipse()
            .fill(EllipticalGradient(
                colors: [.yellow, .orange],
                center: .center,
                startRadiusFraction: 0,
                endRadiusFraction: 0.7
            ))
            .frame(height: 110)
    }
}

// MARK: - FillShapeView

private struct D_FillShapeViewExample: View {
    var body: some View {
        Circle()
            .fill(.yellow)
            .stroke(.orange, lineWidth: 3)
            .frame(width: 100, height: 100)
    }
}

// MARK: - FillStyle

private struct D_FillStyleExample: View {
    var body: some View {
        VStack(spacing: 10) {
            Path { p in
                p.addEllipse(in: CGRect(x: 0, y: 0, width: 100, height: 100))
                p.addEllipse(in: CGRect(x: 25, y: 25, width: 50, height: 50))
            }
            .fill(.blue, style: FillStyle(eoFill: true))
            .frame(width: 100, height: 100)

            Text("eoFill: true — the inner subpath punches a hole.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - ForegroundStyle

private enum D_TintChoice: String, CaseIterable, Identifiable {
    case blue, pink, green
    var id: Self { self }
    var color: Color {
        switch self {
        case .blue: .blue
        case .pink: .pink
        case .green: .green
        }
    }
}

private struct D_ForegroundStyleExample: View {
    @State private var tint: D_TintChoice = .blue

    var body: some View {
        VStack(spacing: 12) {
            Canvas { context, size in
                let d = min(size.width / 3, size.height) - 10
                for i in 0..<3 {
                    let x = (size.width / 3) * CGFloat(i) + (size.width / 3 - d) / 2
                    let rect = CGRect(x: x, y: (size.height - d) / 2, width: d, height: d)
                    context.fill(Path(ellipseIn: rect), with: .style(ForegroundStyle()))
                }
            }
            .foregroundStyle(tint.color)
            .frame(height: 70)

            Picker("Foreground", selection: $tint) {
                ForEach(D_TintChoice.allCases) { Text($0.rawValue).tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
        }
    }
}

// MARK: - Gradient

private struct D_GradientExample: View {
    private let heat = Gradient(stops: [
        .init(color: .blue, location: 0),
        .init(color: .yellow, location: 0.65),
        .init(color: .red, location: 1),
    ])

    var body: some View {
        Rectangle()
            .fill(LinearGradient(gradient: heat, startPoint: .leading, endPoint: .trailing))
            .frame(height: 80)
            .clipShape(.rect(cornerRadius: 10))
    }
}

// MARK: - GraphicsContext

private struct D_GraphicsContextExample: View {
    var body: some View {
        Canvas { context, size in
            let rect = CGRect(origin: .zero, size: size)
            context.addFilter(.blur(radius: 2))
            context.fill(Path(ellipseIn: rect.insetBy(dx: 24, dy: 24)),
                         with: .color(.blue))
            context.stroke(
                Path(rect.insetBy(dx: 4, dy: 4)),
                with: .linearGradient(Gradient(colors: [.red, .yellow]),
                                      startPoint: .zero,
                                      endPoint: CGPoint(x: size.width, y: 0)),
                lineWidth: 3)
        }
        .frame(height: 110)
    }
}

// MARK: - HierarchicalShapeStyle

private struct D_HierarchicalShapeStyleExample: View {
    var body: some View {
        HStack(spacing: 24) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Now Playing").foregroundStyle(.primary)
                Text("Album — Artist").foregroundStyle(.secondary)
                Text("Lossless").foregroundStyle(.tertiary)
                Text("24-bit / 192 kHz").foregroundStyle(.quaternary)
            }
            .font(.callout.weight(.medium))

            VStack(spacing: 6) {
                ForEach(0..<4, id: \.self) { i in
                    RoundedRectangle(cornerRadius: 4)
                        .fill([AnyShapeStyle(.primary), AnyShapeStyle(.secondary),
                               AnyShapeStyle(.tertiary), AnyShapeStyle(.quaternary)][i])
                        .frame(width: 60, height: 12)
                }
            }
        }
        .padding(.vertical, 6)
    }
}

// MARK: - ImageRenderer

private struct D_ImageRendererExample: View {
    @State private var output: CGImage?

    var body: some View {
        VStack(spacing: 10) {
            Group {
                if let output {
                    Image(decorative: output, scale: 2)
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.quaternary))
                } else {
                    RoundedRectangle(cornerRadius: 10).fill(.quaternary)
                        .frame(width: 170, height: 66)
                }
            }

            Text("The card above was rasterized off-screen by ImageRenderer, then shown as its CGImage.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .onAppear {
            let renderer = ImageRenderer(content: card)
            renderer.scale = 2
            output = renderer.cgImage
        }
    }

    private var card: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark.seal.fill")
                .font(.title)
                .foregroundStyle(.green)
            VStack(alignment: .leading, spacing: 2) {
                Text("Verified").font(.headline)
                Text("Score 92").font(.caption).foregroundStyle(.secondary)
            }
        }
        .padding(12)
        .background(Color.white, in: .rect(cornerRadius: 10))
    }
}

// MARK: - OffsetShape

private struct D_OffsetShapeExample: View {
    var body: some View {
        ZStack {
            OffsetShape(shape: Ellipse(), offset: CGSize(width: 0, height: 10))
                .fill(.black.opacity(0.25))
            Ellipse()
                .fill(.yellow)
        }
        .frame(width: 140, height: 90)
    }
}

// MARK: - RectangleCornerRadii

private struct D_RectangleCornerRadiiExample: View {
    var body: some View {
        UnevenRoundedRectangle(
            cornerRadii: RectangleCornerRadii(
                topLeading: 28, bottomLeading: 0,
                bottomTrailing: 0, topTrailing: 28
            )
        )
        .fill(.teal.gradient)
        .frame(width: 180, height: 90)
    }
}

// MARK: - RoundedCornerStyle

private struct D_RoundedCornerStyleExample: View {
    var body: some View {
        HStack(spacing: 24) {
            labeled(".circular") {
                RoundedRectangle(cornerRadius: 26, style: .circular)
                    .fill(.indigo.gradient)
                    .frame(width: 100, height: 100)
            }
            labeled(".continuous") {
                RoundedRectangle(cornerRadius: 26, style: .continuous)
                    .fill(.indigo.gradient)
                    .frame(width: 100, height: 100)
            }
        }
        .padding(.vertical, 6)
    }

    private func labeled<Content: View>(_ caption: String, @ViewBuilder _ content: () -> Content) -> some View {
        VStack(spacing: 8) {
            content()
            Text(caption).font(.caption.monospaced()).foregroundStyle(.secondary)
        }
    }
}

// MARK: - ScaledShape

private struct D_ScaledShapeExample: View {
    var body: some View {
        ZStack {
            Circle().stroke(.secondary, style: StrokeStyle(lineWidth: 1, dash: [4, 4]))
            ScaledShape(shape: Circle(),
                        scale: CGSize(width: 0.6, height: 0.6),
                        anchor: .center)
                .fill(.cyan)
        }
        .frame(width: 110, height: 110)
    }
}

// MARK: - Shader

private struct D_ShaderExample: View {
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                ForEach(0..<6, id: \.self) { i in
                    Circle()
                        .stroke(.blue.opacity(1 - Double(i) / 6), lineWidth: 3)
                        .frame(width: CGFloat(18 + i * 20), height: CGFloat(18 + i * 20))
                }
            }
            .frame(height: 100)

            Text("Illustrative — the ripple Shader distorts the layer around a point at runtime.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - ShaderLibrary

private struct D_ShaderLibraryExample: View {
    private let cols = 8
    private let rows = 4

    var body: some View {
        VStack(spacing: 10) {
            Canvas { context, size in
                let cw = size.width / CGFloat(cols)
                let ch = size.height / CGFloat(rows)
                for r in 0..<rows {
                    for c in 0..<cols {
                        let hue = Double(c) / Double(cols)
                        let brightness = 0.55 + 0.4 * Double(r) / Double(rows)
                        let rect = CGRect(x: CGFloat(c) * cw, y: CGFloat(r) * ch,
                                          width: cw - 1, height: ch - 1)
                        context.fill(Path(rect),
                                     with: .color(Color(hue: hue, saturation: 0.7, brightness: brightness)))
                    }
                }
            }
            .frame(height: 90)
            .clipShape(.rect(cornerRadius: 10))

            Text("Illustrative — ShaderLibrary.pixellate runs as a Metal function at runtime.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - ShadowStyle

private struct D_ShadowStyleExample: View {
    var body: some View {
        HStack(spacing: 28) {
            labeled(".drop") {
                Circle()
                    .fill(.blue.shadow(.drop(color: .black.opacity(0.35), radius: 6, y: 4)))
                    .frame(width: 80, height: 80)
            }
            labeled(".inner") {
                Circle()
                    .fill(.blue.shadow(.inner(color: .black.opacity(0.6), radius: 6, y: 3)))
                    .frame(width: 80, height: 80)
            }
        }
        .padding(.vertical, 10)
    }

    private func labeled<Content: View>(_ caption: String, @ViewBuilder _ content: () -> Content) -> some View {
        VStack(spacing: 8) {
            content()
            Text(caption).font(.caption.monospaced()).foregroundStyle(.secondary)
        }
    }
}

// MARK: - Shape.fill()

private struct D_ShapeFillExample: View {
    var body: some View {
        Circle()
            .fill(.blue.gradient)
            .frame(width: 110, height: 110)
    }
}

// MARK: - Shape.offset()

private struct D_ShapeOffsetExample: View {
    var body: some View {
        ZStack {
            Circle().offset(x: 6, y: 6).fill(.black.opacity(0.25))
            Circle().fill(.yellow)
        }
        .frame(width: 100, height: 100)
    }
}

// MARK: - Shape.rotation()

private struct D_ShapeRotationExample: View {
    var body: some View {
        Rectangle()
            .rotation(.degrees(30))
            .fill(.indigo)
            .frame(width: 120, height: 60)
            .padding(.vertical, 24)
    }
}

// MARK: - Shape.scale()

private struct D_ShapeScaleExample: View {
    var body: some View {
        ZStack {
            Circle().stroke(.secondary.opacity(0.4), lineWidth: 1)
            Circle()
                .scale(0.8)
                .stroke(.pink, lineWidth: 3)
        }
        .frame(width: 110, height: 110)
    }
}

// MARK: - Shape.size()

private struct D_ShapeSizeExample: View {
    var body: some View {
        Rectangle()
            .size(width: 80, height: 40)
            .fill(.mint)
            .frame(width: 140, height: 90)
            .border(.secondary.opacity(0.4))
    }
}

// MARK: - Shape.stroke()

private struct D_ShapeStrokeExample: View {
    var body: some View {
        Path { p in
            p.move(to: CGPoint(x: 0, y: 60))
            p.addLine(to: CGPoint(x: 220, y: 10))
        }
        .stroke(.orange, style: StrokeStyle(lineWidth: 4, dash: [8, 4]))
        .frame(width: 220, height: 70)
    }
}

// MARK: - Shape.transform()

private struct D_ShapeTransformExample: View {
    var body: some View {
        Ellipse()
            .transform(CGAffineTransform(a: 1, b: 0, c: 0.4, d: 1, tx: 0, ty: 0))
            .fill(.purple)
            .frame(width: 110, height: 80)
    }
}

// MARK: - Shape.trim()

private struct D_ShapeTrimExample: View {
    @State private var progress = 0.65

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle().stroke(.quaternary, lineWidth: 8)
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(.green, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                Text("\(Int(progress * 100))%").font(.headline)
            }
            .frame(width: 90, height: 90)

            Slider(value: $progress, in: 0...1)
        }
    }
}

// MARK: - Shape.union()

private struct D_ShapeUnionExample: View {
    var body: some View {
        HStack(spacing: 18) {
            labeled("union") {
                Circle().union(Capsule().size(width: 150, height: 40))
                    .fill(.red)
                    .frame(width: 90, height: 70)
            }
            labeled("subtracting") {
                Rectangle().subtracting(Circle().scale(0.55))
                    .fill(.blue)
                    .frame(width: 70, height: 70)
            }
            labeled("intersection") {
                Circle().intersection(Rectangle().size(width: 120, height: 60))
                    .fill(.green)
                    .frame(width: 70, height: 70)
            }
        }
        .padding(.vertical, 6)
    }

    private func labeled<Content: View>(_ caption: String, @ViewBuilder _ content: () -> Content) -> some View {
        VStack(spacing: 6) {
            content()
            Text(caption).font(.caption2.monospaced()).foregroundStyle(.secondary)
        }
    }
}

// MARK: - StrokeShapeView

private struct D_StrokeShapeViewExample: View {
    @State private var progress = 0.7

    var body: some View {
        VStack(spacing: 12) {
            ring(progress)
                .frame(width: 90, height: 90)
            Slider(value: $progress, in: 0...1)
            Text("stroke(...) returns a StrokeShapeView, reusable from a helper.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .tint(.orange)
    }

    private func ring(_ progress: Double) -> some View {
        Circle()
            .trim(from: 0, to: progress)
            .stroke(.tint, style: StrokeStyle(lineWidth: 6, lineCap: .round))
            .rotationEffect(.degrees(-90))
    }
}

// MARK: - StrokeStyle

private struct D_StrokeStyleExample: View {
    var body: some View {
        TimelineView(.animation) { timeline in
            let phase = timeline.date.timeIntervalSinceReferenceDate.truncatingRemainder(dividingBy: 2) * 11
            RoundedRectangle(cornerRadius: 16)
                .stroke(.orange, style: StrokeStyle(lineWidth: 6, lineCap: .round,
                                                    lineJoin: .round, dash: [14, 8], dashPhase: phase))
                .frame(height: 90)
                .padding(.horizontal, 8)
        }
    }
}

// MARK: - TransformedShape

private struct D_TransformedShapeExample: View {
    var body: some View {
        TransformedShape(
            shape: Rectangle(),
            transform: CGAffineTransform(rotationAngle: .pi / 8)
        )
        .stroke(.gray, lineWidth: 2)
        .frame(width: 110, height: 90)
    }
}
