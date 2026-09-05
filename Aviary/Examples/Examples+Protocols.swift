//
//  Examples+Protocols.swift
//  Aviary
//
//  Rendered usage examples for the entries in CatalogData/protocols.json.
//  Entries that already have an interactive demo (demoID) are not here.
//
//  This domain leans non-visual (protocols, app/scene infrastructure, system
//  bridges). Where an API applies at the Scene/App level or is iOS-only, the
//  code string shows the real API and the view renders a faithful illustration
//  with a caption.
//

import SwiftUI
import Foundation
import AppKit
import UniformTypeIdentifiers

enum ExamplesProtocols {
    static let entries: [ExampleEntry] = [
        ExampleEntry(topic: "App", code: """
        @main
        struct CompanionApp: App {
            @State private var model = AppModel()

            var body: some Scene {
                WindowGroup {
                    ContentView()
                        .environment(model)
                }
            }
        }
        """) { AnyView(P_AppExample()) },

        ExampleEntry(topic: "ButtonStyle", code: """
        struct SquishyStyle: ButtonStyle {
            func makeBody(configuration: Configuration) -> some View {
                configuration.label
                    .padding(.horizontal, 14).padding(.vertical, 8)
                    .background(.blue, in: .capsule)
                    .foregroundStyle(.white)
                    .scaleEffect(configuration.isPressed ? 0.92 : 1)
            }
        }

        Button("Tap me") { taps += 1 }
            .buttonStyle(SquishyStyle())
        """) { AnyView(P_ButtonStyleExample()) },

        ExampleEntry(topic: "Commands", code: """
        struct SortCommands: Commands {
            var body: some Commands {
                CommandMenu("Sort") {
                    Button("By Name") { sort(.name) }
                        .keyboardShortcut("1")
                    Button("By Date") { sort(.date) }
                        .keyboardShortcut("2")
                }
            }
        }
        """) { AnyView(P_CommandsExample()) },

        ExampleEntry(topic: "CustomAnimation", code: """
        struct Linear2x: CustomAnimation {
            func animate<V: VectorArithmetic>(
                value: V, time: TimeInterval, context: inout AnimationContext<V>
            ) -> V? {
                time < 0.5 ? value.scaled(by: time * 2) : nil
            }
        }

        Circle()
            .offset(x: moved ? 90 : -90)
            .animation(Animation(Linear2x()), value: moved)
        """) { AnyView(P_CustomAnimationExample()) },

        ExampleEntry(topic: "DynamicProperty", code: """
        @propertyWrapper
        struct Counter: DynamicProperty {
            @State private var value = 0
            var wrappedValue: Int {
                get { value }
                nonmutating set { value = newValue }
            }
        }

        // In a View:
        @Counter private var count
        Button("Increment") { count += 1 }
        Text("Count: \\(count)")
        """) { AnyView(P_DynamicPropertyExample()) },

        ExampleEntry(topic: "EnvironmentKey", code: """
        private struct ThemeKey: EnvironmentKey {
            static let defaultValue = "Standard"
        }
        extension EnvironmentValues {
            var themeName: String {
                get { self[ThemeKey.self] }
                set { self[ThemeKey.self] = newValue }
            }
        }

        // Read it downstream, override it upstream:
        Text(themeName)              // @Environment(\\.themeName)
        child.environment(\\.themeName, "Midnight")
        """) { AnyView(P_EnvironmentKeyExample()) },

        ExampleEntry(topic: "GeometryEffect", code: """
        struct Shake: GeometryEffect {
            var phase: CGFloat
            var animatableData: CGFloat {
                get { phase } set { phase = newValue }
            }
            func effectValue(size: CGSize) -> ProjectionTransform {
                ProjectionTransform(CGAffineTransform(
                    translationX: 8 * sin(phase * .pi * 4), y: 0))
            }
        }

        field.modifier(Shake(phase: attempts))
            .animation(.default, value: attempts)
        """) { AnyView(P_GeometryEffectExample()) },

        ExampleEntry(topic: "Gesture", code: """
        DragGesture()
            .onChanged { value in offset = value.translation }
            .onEnded { _ in withAnimation { offset = .zero } }

        // attached to a view:
        Circle().offset(offset).gesture(drag)
        """) { AnyView(P_GestureExample()) },

        ExampleEntry(topic: "InsettableShape", code: """
        struct Triangle: InsettableShape {
            var insetAmount: CGFloat = 0
            func path(in rect: CGRect) -> Path {
                let r = rect.insetBy(dx: insetAmount, dy: insetAmount)
                return Path { p in
                    p.move(to: CGPoint(x: r.midX, y: r.minY))
                    p.addLine(to: CGPoint(x: r.maxX, y: r.maxY))
                    p.addLine(to: CGPoint(x: r.minX, y: r.maxY))
                    p.closeSubpath()
                }
            }
            func inset(by amount: CGFloat) -> some InsettableShape {
                var copy = self; copy.insetAmount += amount; return copy
            }
        }

        Triangle().strokeBorder(.blue, lineWidth: 10)
        """) { AnyView(P_InsettableShapeExample()) },

        ExampleEntry(topic: "LabelStyle", code: """
        struct VerticalLabel: LabelStyle {
            func makeBody(configuration: Configuration) -> some View {
                VStack(spacing: 4) {
                    configuration.icon.font(.title2)
                    configuration.title.font(.caption)
                }
            }
        }

        Label("Favorites", systemImage: "heart.fill")
            .labelStyle(VerticalLabel())
        """) { AnyView(P_LabelStyleExample()) },

        ExampleEntry(topic: "Layout", code: """
        struct RadialLayout: Layout {
            func sizeThatFits(proposal: ProposedViewSize,
                              subviews: Subviews, cache: inout ()) -> CGSize {
                proposal.replacingUnspecifiedDimensions()
            }
            func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize,
                               subviews: Subviews, cache: inout ()) {
                let radius = min(bounds.width, bounds.height) / 2 - 16
                let step = (2 * .pi) / Double(subviews.count)
                for (i, view) in subviews.enumerated() {
                    let a = step * Double(i) - .pi / 2
                    view.place(at: CGPoint(x: bounds.midX + cos(a) * radius,
                                           y: bounds.midY + sin(a) * radius),
                               anchor: .center, proposal: .unspecified)
                }
            }
        }
        """) { AnyView(P_LayoutExample()) },

        ExampleEntry(topic: "NSViewRepresentable", code: """
        struct AppKitLabel: NSViewRepresentable {
            var text: String
            func makeNSView(context: Context) -> NSTextField {
                let label = NSTextField(labelWithString: text)
                label.font = .boldSystemFont(ofSize: 15)
                return label
            }
            func updateNSView(_ view: NSTextField, context: Context) {
                view.stringValue = text
            }
        }

        AppKitLabel(text: "Rendered by an NSTextField")
        """) { AnyView(P_NSViewRepresentableExample()) },

        ExampleEntry(topic: "PreferenceKey", code: """
        struct WidthKey: PreferenceKey {
            static let defaultValue: CGFloat = 0
            static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
                value = max(value, nextValue())
            }
        }

        Text("Measure my width")
            .background { GeometryReader { proxy in
                Color.clear.preference(key: WidthKey.self, value: proxy.size.width)
            } }
            .onPreferenceChange(WidthKey.self) { width = $0 }
        """) { AnyView(P_PreferenceKeyExample()) },

        ExampleEntry(topic: "PrimitiveButtonStyle", code: """
        struct DoubleTapStyle: PrimitiveButtonStyle {
            func makeBody(configuration: Configuration) -> some View {
                configuration.label
                    .padding(8)
                    .background(.quaternary, in: .rect(cornerRadius: 8))
                    .contentShape(.rect)
                    .onTapGesture(count: 2) { configuration.trigger() }
            }
        }

        Button("Double-click me") { fired += 1 }
            .buttonStyle(DoubleTapStyle())
        """) { AnyView(P_PrimitiveButtonStyleExample()) },

        ExampleEntry(topic: "ProgressViewStyle", code: """
        struct RingStyle: ProgressViewStyle {
            func makeBody(configuration: Configuration) -> some View {
                Circle()
                    .trim(from: 0, to: configuration.fractionCompleted ?? 0)
                    .stroke(.blue, style: .init(lineWidth: 8, lineCap: .round))
                    .rotationEffect(.degrees(-90))
            }
        }

        ProgressView(value: progress)
            .progressViewStyle(RingStyle())
        """) { AnyView(P_ProgressViewStyleExample()) },

        ExampleEntry(topic: "Scene", code: """
        var body: some Scene {
            WindowGroup {
                ContentView()
            }
            Settings {
                SettingsView()
            }
        }
        """) { AnyView(P_SceneExample()) },

        ExampleEntry(topic: "ScrollTargetBehavior", code: """
        struct CardSnap: ScrollTargetBehavior {
            let width: CGFloat
            func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
                target.rect.origin.x =
                    (target.rect.origin.x / width).rounded() * width
            }
        }

        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) { cards.frame(width: 110) }
                .scrollTargetLayout()
        }
        .scrollTargetBehavior(CardSnap(width: 110))
        """) { AnyView(P_ScrollTargetBehaviorExample()) },

        ExampleEntry(topic: "Shape", code: """
        struct Triangle: Shape {
            func path(in rect: CGRect) -> Path {
                Path { p in
                    p.move(to: CGPoint(x: rect.midX, y: rect.minY))
                    p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
                    p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
                    p.closeSubpath()
                }
            }
        }

        Triangle().fill(.orange.gradient)
        """) { AnyView(P_ShapeExample()) },

        ExampleEntry(topic: "ShapeStyle", code: """
        Circle().fill(.blue)                     // Color
        Circle().fill(.blue.gradient)            // AnyGradient
        Circle().fill(.ultraThinMaterial)        // Material
        Circle().fill(.linearGradient(
            colors: [.red, .orange],
            startPoint: .top, endPoint: .bottom))
        """) { AnyView(P_ShapeStyleExample()) },

        ExampleEntry(topic: "TextRenderer", code: """
        struct Glow: TextRenderer {
            func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
                ctx.addFilter(.shadow(color: .yellow, radius: 6))
                for line in layout { ctx.draw(line) }
            }
        }

        Text("Glowing")
            .font(.largeTitle.bold())
            .textRenderer(Glow())
        """) { AnyView(P_TextRendererExample()) },

        ExampleEntry(topic: "ToggleStyle", code: """
        struct StarToggle: ToggleStyle {
            func makeBody(configuration: Configuration) -> some View {
                Button { configuration.isOn.toggle() } label: {
                    Label {
                        configuration.label
                    } icon: {
                        Image(systemName: configuration.isOn ? "star.fill" : "star")
                    }
                }
                .buttonStyle(.plain)
            }
        }

        Toggle("Favorite", isOn: $isOn)
            .toggleStyle(StarToggle())
        """) { AnyView(P_ToggleStyleExample()) },

        ExampleEntry(topic: "ToolbarContent", code: """
        struct EditorToolbar: ToolbarContent {
            var body: some ToolbarContent {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save", systemImage: "tray.and.arrow.down") { }
                }
            }
        }

        NavigationStack {
            Text("Editor")
                .toolbar { EditorToolbar() }
        }
        """) { AnyView(P_ToolbarContentExample()) },

        ExampleEntry(topic: "Transferable", code: """
        struct Recipe: Codable, Transferable {
            var title: String
            static var transferRepresentation: some TransferRepresentation {
                CodableRepresentation(contentType: .json)
            }
        }

        ShareLink(item: recipe, preview: SharePreview(recipe.title))
        """) { AnyView(P_TransferableExample()) },

        ExampleEntry(topic: "Transition", code: """
        struct Twirl: Transition {
            func body(content: Content, phase: TransitionPhase) -> some View {
                content
                    .rotationEffect(.degrees(phase.isIdentity ? 0 : 180))
                    .opacity(phase.isIdentity ? 1 : 0)
            }
        }

        if shown {
            Text("Saved").transition(Twirl())
        }
        """) { AnyView(P_TransitionExample()) },

        ExampleEntry(topic: "UIViewRepresentable", code: """
        struct ActivityRing: UIViewRepresentable {
            var progress: Double
            func makeUIView(context: Context) -> RingView { RingView() }
            func updateUIView(_ view: RingView, context: Context) {
                view.progress = progress
            }
        }
        """) { AnyView(P_UIViewRepresentableExample()) },

        ExampleEntry(topic: "View", code: """
        struct BadgeView: View {
            let count: Int
            var body: some View {
                Text("\\(count)")
                    .padding(6)
                    .background(.red, in: .circle)
                    .foregroundStyle(.white)
            }
        }

        BadgeView(count: 3)
        """) { AnyView(P_ViewExample()) },

        ExampleEntry(topic: "ViewModifier", code: """
        struct CardStyle: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .padding()
                    .background(.background, in: .rect(cornerRadius: 12))
                    .shadow(radius: 4)
            }
        }

        Text("Hello").modifier(CardStyle())
        """) { AnyView(P_ViewModifierExample()) },
    ]
}

// MARK: - Shared illustration chrome

/// A small mock window, drawn purely in SwiftUI, for scene/app illustrations.
private struct P_WindowChrome<Content: View>: View {
    var title: String
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 6) {
                Circle().fill(.red).frame(width: 8, height: 8)
                Circle().fill(.yellow).frame(width: 8, height: 8)
                Circle().fill(.green).frame(width: 8, height: 8)
                Text(title)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                    .padding(.trailing, 30)
            }
            .padding(.horizontal, 8)
            .frame(height: 22)
            .background(.quaternary)

            content()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.background)
        }
        .clipShape(.rect(cornerRadius: 8))
        .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(.quaternary))
    }
}

private struct P_IllustrativeCaption: View {
    var text: String
    var body: some View {
        Label(text, systemImage: "info.circle")
            .font(.caption2)
            .foregroundStyle(.secondary)
    }
}

// MARK: - App

private struct P_AppExample: View {
    var body: some View {
        VStack(spacing: 8) {
            P_WindowChrome(title: "Aviary") {
                VStack(spacing: 6) {
                    Image(systemName: "book.pages")
                        .font(.largeTitle)
                        .foregroundStyle(.tint)
                    Text("ContentView()")
                        .font(.caption.monospaced())
                        .foregroundStyle(.secondary)
                }
                .padding()
            }
            .frame(height: 120)

            P_IllustrativeCaption(text: "Illustrative — @main App presents its scenes at launch")
        }
    }
}

// MARK: - ButtonStyle

private struct P_SquishyStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 14).padding(.vertical, 8)
            .background(.blue, in: .capsule)
            .foregroundStyle(.white)
            .scaleEffect(configuration.isPressed ? 0.92 : 1)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

private struct P_ButtonStyleExample: View {
    @State private var taps = 0
    var body: some View {
        VStack(spacing: 12) {
            Button("Tap me") { taps += 1 }
                .buttonStyle(P_SquishyStyle())
            Text("Pressed \(taps) time\(taps == 1 ? "" : "s")")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Commands

private struct P_CommandsExample: View {
    @State private var lastSort = "By Name"
    var body: some View {
        VStack(spacing: 10) {
            // A drawn stand-in for the "Sort" menu this Commands type installs.
            VStack(spacing: 0) {
                HStack {
                    Text("Sort").font(.caption.bold())
                    Spacer()
                }
                .padding(.horizontal, 10).padding(.vertical, 4)
                .background(.tint.opacity(0.18))
                Divider()
                ForEach(["By Name", "By Date"], id: \.self) { item in
                    Button { lastSort = item } label: {
                        HStack {
                            Text(item)
                            Spacer()
                            Text(item == "By Name" ? "⌘1" : "⌘2")
                                .foregroundStyle(.secondary)
                        }
                        .font(.caption)
                        .contentShape(.rect)
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, 10).padding(.vertical, 5)
                    .background(lastSort == item ? AnyShapeStyle(.tint.opacity(0.15)) : AnyShapeStyle(.clear))
                }
            }
            .frame(width: 190)
            .background(.background, in: .rect(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(.quaternary))

            P_IllustrativeCaption(text: "Illustrative — Commands populate the real menu bar")
        }
    }
}

// MARK: - CustomAnimation

private struct P_Linear2x: CustomAnimation {
    func animate<V: VectorArithmetic>(
        value: V, time: TimeInterval, context: inout AnimationContext<V>
    ) -> V? {
        time < 0.5 ? value.scaled(by: time * 2) : nil
    }
}

private struct P_CustomAnimationExample: View {
    @State private var moved = false
    var body: some View {
        VStack(spacing: 14) {
            Circle()
                .fill(.blue.gradient)
                .frame(width: 34, height: 34)
                .offset(x: moved ? 90 : -90)
                .animation(Animation(P_Linear2x()), value: moved)
                .frame(maxWidth: .infinity)
            Button("Run Linear2x") { moved.toggle() }
                .buttonStyle(.bordered)
        }
    }
}

// MARK: - DynamicProperty

@propertyWrapper
private struct P_Counter: DynamicProperty {
    @State private var value = 0
    var wrappedValue: Int {
        get { value }
        nonmutating set { value = newValue }
    }
}

private struct P_DynamicPropertyExample: View {
    @P_Counter private var count

    var body: some View {
        VStack(spacing: 12) {
            Text("Count: \(count)")
                .font(.title3.monospacedDigit())
            Button("Increment") { count += 1 }
                .buttonStyle(.bordered)
            Text("Counter is a custom @propertyWrapper: DynamicProperty")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - EnvironmentKey

private struct P_ThemeKey: EnvironmentKey {
    static let defaultValue = "Standard"
}

extension EnvironmentValues {
    fileprivate var p_themeName: String {
        get { self[P_ThemeKey.self] }
        set { self[P_ThemeKey.self] = newValue }
    }
}

private struct P_ThemeReader: View {
    @Environment(\.p_themeName) private var themeName
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: "paintpalette")
                .foregroundStyle(.tint)
            Text(themeName)
                .font(.caption.monospaced())
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 8))
    }
}

private struct P_EnvironmentKeyExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 12) {
                P_ThemeReader()                                  // default value
                P_ThemeReader().environment(\.p_themeName, "Midnight")
            }
            Text("Same view, different environment value")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - GeometryEffect

private struct P_Shake: GeometryEffect {
    var phase: CGFloat
    var animatableData: CGFloat {
        get { phase } set { phase = newValue }
    }
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(
            translationX: 8 * sin(phase * .pi * 4), y: 0))
    }
}

private struct P_GeometryEffectExample: View {
    @State private var attempts: CGFloat = 0
    var body: some View {
        VStack(spacing: 12) {
            Text("Wrong password")
                .font(.callout)
                .padding(8)
                .frame(maxWidth: .infinity)
                .background(.red.opacity(0.15), in: .rect(cornerRadius: 8))
                .modifier(P_Shake(phase: attempts))
                .animation(.default, value: attempts)
            Button("Shake") { attempts += 1 }
                .buttonStyle(.bordered)
        }
    }
}

// MARK: - Gesture

private struct P_GestureExample: View {
    @State private var offset: CGSize = .zero
    var body: some View {
        VStack(spacing: 10) {
            Circle()
                .fill(.blue.gradient)
                .frame(width: 54, height: 54)
                .offset(offset)
                .gesture(
                    DragGesture()
                        .onChanged { offset = $0.translation }
                        .onEnded { _ in withAnimation(.bouncy) { offset = .zero } }
                )
                .frame(height: 110)
            Text("Drag the circle — translation: \(Int(offset.width)), \(Int(offset.height))")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - InsettableShape

private struct P_Triangle: InsettableShape {
    var insetAmount: CGFloat = 0
    func path(in rect: CGRect) -> Path {
        let r = rect.insetBy(dx: insetAmount, dy: insetAmount)
        return Path { p in
            p.move(to: CGPoint(x: r.midX, y: r.minY))
            p.addLine(to: CGPoint(x: r.maxX, y: r.maxY))
            p.addLine(to: CGPoint(x: r.minX, y: r.maxY))
            p.closeSubpath()
        }
    }
    func inset(by amount: CGFloat) -> some InsettableShape {
        var copy = self
        copy.insetAmount += amount
        return copy
    }
}

private struct P_InsettableShapeExample: View {
    var body: some View {
        VStack(spacing: 8) {
            P_Triangle()
                .strokeBorder(.blue, lineWidth: 10)
                .frame(width: 120, height: 90)
            Text("strokeBorder keeps the 10pt line inside the bounds")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - LabelStyle

private struct P_VerticalLabel: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 4) {
            configuration.icon.font(.title2)
            configuration.title.font(.caption)
        }
    }
}

private struct P_LabelStyleExample: View {
    var body: some View {
        HStack(spacing: 24) {
            Label("Favorites", systemImage: "heart.fill")
                .labelStyle(.automatic)
            Label("Favorites", systemImage: "heart.fill")
                .labelStyle(P_VerticalLabel())
                .foregroundStyle(.pink)
        }
        .padding(8)
    }
}

// MARK: - Layout

private struct P_RadialLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize,
                      subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize,
                       subviews: Subviews, cache: inout ()) {
        guard !subviews.isEmpty else { return }
        let radius = min(bounds.width, bounds.height) / 2 - 16
        let step = (2 * Double.pi) / Double(subviews.count)
        for (i, view) in subviews.enumerated() {
            let a = step * Double(i) - .pi / 2
            view.place(
                at: CGPoint(x: bounds.midX + cos(a) * radius,
                            y: bounds.midY + sin(a) * radius),
                anchor: .center,
                proposal: .unspecified)
        }
    }
}

private struct P_LayoutExample: View {
    private let palette: [Color] = [.red, .orange, .yellow, .green, .teal, .blue, .indigo, .purple]
    var body: some View {
        VStack(spacing: 6) {
            P_RadialLayout {
                ForEach(0..<8, id: \.self) { i in
                    Circle()
                        .fill(palette[i].gradient)
                        .frame(width: 26, height: 26)
                }
            }
            .frame(height: 150)
            Text("A custom Layout arranging 8 real subviews in a ring")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - NSViewRepresentable

private struct P_AppKitLabel: NSViewRepresentable {
    var text: String
    func makeNSView(context: Context) -> NSTextField {
        let label = NSTextField(labelWithString: text)
        label.font = .boldSystemFont(ofSize: 15)
        label.alignment = .center
        return label
    }
    func updateNSView(_ view: NSTextField, context: Context) {
        view.stringValue = text
    }
}

private struct P_NSViewRepresentableExample: View {
    var body: some View {
        VStack(spacing: 8) {
            P_AppKitLabel(text: "Rendered by an NSTextField")
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 8))
            Text("A real AppKit view hosted inside SwiftUI")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - PreferenceKey

private struct P_WidthKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

private struct P_PreferenceKeyExample: View {
    @State private var width: CGFloat = 0
    var body: some View {
        VStack(spacing: 12) {
            Text("Measure my width")
                .padding(.horizontal, 12).padding(.vertical, 6)
                .background(.tint.opacity(0.2), in: .capsule)
                .background {
                    GeometryReader { proxy in
                        Color.clear.preference(key: P_WidthKey.self, value: proxy.size.width)
                    }
                }
            Text("Reported up the tree: \(Int(width)) pt")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
        .onPreferenceChange(P_WidthKey.self) { width = $0 }
    }
}

// MARK: - PrimitiveButtonStyle

private struct P_DoubleTapStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 12).padding(.vertical, 8)
            .background(.quaternary, in: .rect(cornerRadius: 8))
            .contentShape(.rect)
            .onTapGesture(count: 2) { configuration.trigger() }
    }
}

private struct P_PrimitiveButtonStyleExample: View {
    @State private var fired = 0
    var body: some View {
        VStack(spacing: 12) {
            Button("Double-click me") { fired += 1 }
                .buttonStyle(P_DoubleTapStyle())
            Text("Fired \(fired) time\(fired == 1 ? "" : "s") — a single click does nothing")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - ProgressViewStyle

private struct P_RingStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        Circle()
            .trim(from: 0, to: configuration.fractionCompleted ?? 0)
            .stroke(.blue, style: .init(lineWidth: 8, lineCap: .round))
            .rotationEffect(.degrees(-90))
    }
}

private struct P_ProgressViewStyleExample: View {
    @State private var progress = 0.4
    var body: some View {
        VStack(spacing: 12) {
            ProgressView(value: progress)
                .progressViewStyle(P_RingStyle())
                .frame(width: 70, height: 70)
            Slider(value: $progress, in: 0...1)
                .frame(maxWidth: 200)
            Text("\(progress, format: .percent.precision(.fractionLength(0)))")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Scene

private struct P_SceneExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 12) {
                P_WindowChrome(title: "Main Window") {
                    Image(systemName: "doc.text")
                        .font(.title)
                        .foregroundStyle(.tint)
                        .padding()
                }
                .frame(width: 130, height: 96)

                P_WindowChrome(title: "Settings") {
                    VStack(alignment: .leading, spacing: 5) {
                        Toggle("Sync", isOn: .constant(true))
                        Toggle("Sounds", isOn: .constant(false))
                    }
                    .toggleStyle(.switch)
                    .controlSize(.mini)
                    .font(.caption2)
                    .padding(8)
                }
                .frame(width: 130, height: 96)
            }
            P_IllustrativeCaption(text: "Illustrative — WindowGroup and Settings are Scenes")
        }
    }
}

// MARK: - ScrollTargetBehavior

private struct P_CardSnap: ScrollTargetBehavior {
    let width: CGFloat
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        target.rect.origin.x = (target.rect.origin.x / width).rounded() * width
    }
}

private struct P_ScrollTargetBehaviorExample: View {
    private let colors: [Color] = [.red, .orange, .green, .blue, .indigo, .purple, .pink, .teal]
    var body: some View {
        VStack(spacing: 8) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(0..<8, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(colors[i].gradient)
                            .frame(width: 110)
                            .overlay(Text("\(i + 1)").font(.title.bold()).foregroundStyle(.white))
                            .padding(4)
                    }
                }
                .scrollTargetLayout()
            }
            .frame(height: 90)
            .scrollTargetBehavior(P_CardSnap(width: 110))

            Text("Scroll horizontally — the custom behavior snaps to each card")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Shape

private struct P_ShapeTriangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: CGPoint(x: rect.midX, y: rect.minY))
            p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            p.closeSubpath()
        }
    }
}

private struct P_ShapeExample: View {
    var body: some View {
        VStack(spacing: 8) {
            P_ShapeTriangle()
                .fill(.orange.gradient)
                .frame(width: 120, height: 90)
            Text("A Shape draws a Path into whatever rect it is given")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - ShapeStyle

private struct P_ShapeStyleExample: View {
    private func swatch<S: ShapeStyle>(_ style: S, _ caption: String) -> some View {
        VStack(spacing: 4) {
            Circle().fill(style).frame(width: 44, height: 44)
            Text(caption).font(.caption2.monospaced()).foregroundStyle(.secondary)
        }
    }
    var body: some View {
        ZStack {
            LinearGradient(colors: [.gray.opacity(0.3), .gray.opacity(0.05)],
                           startPoint: .top, endPoint: .bottom)
            HStack(spacing: 14) {
                swatch(Color.blue, ".blue")
                swatch(Color.blue.gradient, ".gradient")
                swatch(.ultraThinMaterial, ".material")
                swatch(LinearGradient(colors: [.red, .orange],
                                      startPoint: .top, endPoint: .bottom), ".linear")
            }
            .padding(12)
        }
        .frame(height: 90)
        .clipShape(.rect(cornerRadius: 10))
    }
}

// MARK: - TextRenderer

private struct P_Glow: TextRenderer {
    func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
        ctx.addFilter(.shadow(color: .yellow, radius: 6))
        for line in layout { ctx.draw(line) }
    }
}

private struct P_TextRendererExample: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Glowing")
                .font(.largeTitle.bold())
                .foregroundStyle(.orange)
                .textRenderer(P_Glow())
                .padding(8)
            Text("A TextRenderer draws the resolved layout itself")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - ToggleStyle

private struct P_StarToggle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Label {
                configuration.label
            } icon: {
                Image(systemName: configuration.isOn ? "star.fill" : "star")
                    .foregroundStyle(configuration.isOn ? .yellow : .secondary)
            }
        }
        .buttonStyle(.plain)
    }
}

private struct P_ToggleStyleExample: View {
    @State private var isOn = true
    var body: some View {
        VStack(spacing: 12) {
            Toggle("Favorite", isOn: $isOn)
                .toggleStyle(P_StarToggle())
                .fixedSize()
            Text(isOn ? "On" : "Off")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - ToolbarContent

private struct P_EditorToolbar: ToolbarContent {
    var onSave: () -> Void
    var body: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button("Save", systemImage: "tray.and.arrow.down", action: onSave)
        }
    }
}

private struct P_ToolbarContentExample: View {
    @State private var saves = 0
    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                Text("Editor")
                    .font(.title3)
                Text("Saved \(saves) time\(saves == 1 ? "" : "s")")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .toolbar { P_EditorToolbar { saves += 1 } }
        }
        .frame(height: 150)
        .clipShape(.rect(cornerRadius: 8))
    }
}

// MARK: - Transferable

private struct P_Recipe: Codable, Transferable {
    var title: String
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .json)
    }
}

private struct P_TransferableExample: View {
    private let recipe = P_Recipe(title: "Sourdough Loaf")
    var body: some View {
        VStack(spacing: 10) {
            ShareLink(item: recipe, preview: SharePreview(recipe.title)) {
                Label("Share “\(recipe.title)”", systemImage: "square.and.arrow.up")
            }
            .buttonStyle(.bordered)
            Text("The Transferable Recipe moves via the share sheet, drag, or copy")
                .font(.caption2)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - Transition

private struct P_Twirl: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .rotationEffect(.degrees(phase.isIdentity ? 0 : 180))
            .opacity(phase.isIdentity ? 1 : 0)
    }
}

private struct P_TransitionExample: View {
    @State private var shown = true
    var body: some View {
        VStack(spacing: 14) {
            ZStack {
                if shown {
                    Text("Saved")
                        .font(.title3.bold())
                        .padding(.horizontal, 18).padding(.vertical, 10)
                        .background(.green.opacity(0.2), in: .capsule)
                        .transition(P_Twirl())
                }
            }
            .frame(height: 54)

            Button(shown ? "Remove" : "Insert") {
                withAnimation(.bouncy) { shown.toggle() }
            }
            .buttonStyle(.bordered)
        }
    }
}

// MARK: - UIViewRepresentable

private struct P_UIViewRepresentableExample: View {
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .stroke(.quaternary, lineWidth: 10)
                Circle()
                    .trim(from: 0, to: 0.72)
                    .stroke(.pink.gradient, style: .init(lineWidth: 10, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                Text("72%").font(.caption.bold())
            }
            .frame(width: 70, height: 70)

            P_IllustrativeCaption(text: "Illustrative — UIViewRepresentable is iOS / tvOS only")
        }
    }
}

// MARK: - View

private struct P_BadgeView: View {
    let count: Int
    var body: some View {
        Text("\(count)")
            .padding(6)
            .background(.red, in: .circle)
            .foregroundStyle(.white)
    }
}

private struct P_ViewExample: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "bell.fill")
                .font(.system(size: 40))
                .foregroundStyle(.secondary)
                .overlay(alignment: .topTrailing) {
                    P_BadgeView(count: 3).offset(x: 6, y: -4)
                }
            Text("BadgeView is a value conforming to View")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - ViewModifier

private struct P_CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.background, in: .rect(cornerRadius: 12))
            .shadow(radius: 4)
    }
}

private struct P_ViewModifierExample: View {
    var body: some View {
        VStack(spacing: 10) {
            Label("Hello", systemImage: "hand.wave")
                .modifier(P_CardStyle())
            Text("CardStyle bundles padding, background, and shadow into one modifier")
                .font(.caption2)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(6)
    }
}
