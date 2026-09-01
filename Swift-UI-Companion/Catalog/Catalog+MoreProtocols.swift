//
//  Catalog+MoreProtocols.swift
//  Swift-UI-Companion
//
//  Second wave of protocol entries: styling, layout, data flow, and
//  platform bridging.
//

import Foundation

extension Catalog {
    static let moreProtocols: [Topic] = [
        Topic(
            name: "Layout",
            kind: .protocolItem,
            summary: "A custom layout container with full placement control.",
            discussion: "Layout puts your code where HStack's is: report a size from sizeThatFits, then position children in placeSubviews using their proposals and priorities. Flow layouts and radial arrangements become first-class containers that animate like built-ins.",
            wwdcYear: 2022,
            code: #"""
            struct FlowLayout: Layout {
                func sizeThatFits(proposal: ProposedViewSize,
                                  subviews: Subviews, cache: inout ()) -> CGSize {
                    // measure rows against proposal.width …
                    .zero
                }
                func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize,
                                   subviews: Subviews, cache: inout ()) {
                    // wrap subviews into rows …
                }
            }
            """#,
            related: ["HStack", "Grid", "GeometryReader"]
        ),
        Topic(
            name: "ShapeStyle",
            kind: .protocolItem,
            summary: "Anything that can paint content — colors, gradients, materials.",
            discussion: "ShapeStyle unifies what fill, stroke, background, and foregroundStyle accept: Color, gradients, materials, hierarchical levels, and image paint all conform. Custom conformances can resolve differently per environment, like a color pair that adapts to dark mode.",
            wwdcYear: 2019,
            code: #"""
            Circle().fill(.blue)                    // Color
            Circle().fill(.blue.gradient)           // AnyGradient
            Circle().fill(.ultraThinMaterial)       // Material
            Circle().fill(.linearGradient(
                colors: [.red, .orange],
                startPoint: .top, endPoint: .bottom))
            """#,
            related: ["LinearGradient", "Material", ".foregroundStyle()"]
        ),
        Topic(
            name: "PrimitiveButtonStyle",
            kind: .protocolItem,
            summary: "A button style that also owns the trigger behavior.",
            discussion: "Where ButtonStyle only redraws, PrimitiveButtonStyle receives the trigger itself — you decide what gesture invokes configuration.trigger(). This is how long-press-to-confirm or double-tap buttons are built.",
            wwdcYear: 2019,
            code: #"""
            struct HoldToConfirm: PrimitiveButtonStyle {
                func makeBody(configuration: Configuration) -> some View {
                    configuration.label
                        .onLongPressGesture(minimumDuration: 1) {
                            configuration.trigger()
                        }
                }
            }
            """#,
            related: ["ButtonStyle", "Button"]
        ),
        Topic(
            name: "ToggleStyle",
            kind: .protocolItem,
            summary: "Custom rendering for toggles.",
            discussion: "ToggleStyle's makeBody receives the label and the isOn binding — draw anything that flips the binding and every Toggle using the style inherits the behavior. The demo's checkbox/switch/button variants are the built-in conformers.",
            wwdcYear: 2019,
            code: #"""
            struct StarToggle: ToggleStyle {
                func makeBody(configuration: Configuration) -> some View {
                    Button {
                        configuration.isOn.toggle()
                    } label: {
                        Image(systemName: configuration.isOn ? "star.fill" : "star")
                    }
                }
            }
            """#,
            related: ["Toggle", ".toggleStyle()", "ButtonStyle"]
        ),
        Topic(
            name: "LabelStyle",
            kind: .protocolItem,
            summary: "Custom arrangement of a label's icon and title.",
            discussion: "LabelStyle receives the icon and title as separate views, free to rearrange — icon above title, trailing icons, or badge-style compositions — applied anywhere via labelStyle.",
            wwdcYear: 2020,
            code: #"""
            struct VerticalLabel: LabelStyle {
                func makeBody(configuration: Configuration) -> some View {
                    VStack(spacing: 4) {
                        configuration.icon
                        configuration.title.font(.caption)
                    }
                }
            }
            """#,
            related: ["Label", ".labelStyle()"]
        ),
        Topic(
            name: "ProgressViewStyle",
            kind: .protocolItem,
            summary: "Custom progress rendering from fractionCompleted.",
            discussion: "ProgressViewStyle reads the configuration's optional fractionCompleted (nil while indeterminate) and draws anything — rings, waves, battery bars. This app type-erases between the built-in linear and circular styles in its ProgressView demo.",
            wwdcYear: 2020,
            code: #"""
            struct RingStyle: ProgressViewStyle {
                func makeBody(configuration: Configuration) -> some View {
                    Circle()
                        .trim(from: 0, to: configuration.fractionCompleted ?? 0)
                        .stroke(.blue, style: .init(lineWidth: 6, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                }
            }
            """#,
            related: ["ProgressView", ".progressViewStyle()"]
        ),
        Topic(
            name: "DynamicProperty",
            kind: .protocolItem,
            summary: "Lets a custom property wrapper participate in updates.",
            discussion: "Property wrappers conforming to DynamicProperty get an update() call before each body evaluation and may compose @State, @Environment, and friends inside — the machinery behind wrappers like @FetchRequest, and yours if you build one.",
            wwdcYear: 2019,
            code: #"""
            @propertyWrapper
            struct Stored: DynamicProperty {
                @State private var value = load()

                var wrappedValue: String {
                    get { value }
                    nonmutating set { value = newValue; save(newValue) }
                }
            }
            """#,
            related: ["@State", "@Environment"]
        ),
        Topic(
            name: "EnvironmentKey",
            kind: .protocolItem,
            summary: "The manual way to define an environment value.",
            discussion: "An EnvironmentKey supplies a defaultValue, and an EnvironmentValues extension exposes it as a property. Since WWDC '24 the @Entry macro generates all of this from one line — reach for EnvironmentKey when supporting older targets.",
            wwdcYear: 2019,
            code: #"""
            private struct ThemeKey: EnvironmentKey {
                static let defaultValue = Theme.standard
            }

            extension EnvironmentValues {
                var theme: Theme {
                    get { self[ThemeKey.self] }
                    set { self[ThemeKey.self] = newValue }
                }
            }
            """#,
            related: ["@Entry", "@Environment"]
        ),
        Topic(
            name: "PreferenceKey",
            kind: .protocolItem,
            summary: "Passes values up the view tree, child to ancestor.",
            discussion: "Preferences flow opposite to the environment: children set values, a reduce function merges siblings, and ancestors read the result with onPreferenceChange. It's how navigation titles reach the bar — and how children report sizes to parents.",
            wwdcYear: 2019,
            code: #"""
            struct WidthKey: PreferenceKey {
                static let defaultValue: CGFloat = 0
                static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
                    value = max(value, nextValue())
                }
            }

            child
                .preference(key: WidthKey.self, value: proxy.size.width)
            """#,
            related: ["EnvironmentKey", "GeometryReader"]
        ),
        Topic(
            name: "GeometryEffect",
            kind: .protocolItem,
            summary: "An animatable transform applied to a view's geometry.",
            discussion: "GeometryEffect returns a ProjectionTransform for a given size and animates via animatableData — the home of shake effects and skews. Layout is untouched; only rendering transforms.",
            wwdcYear: 2019,
            code: #"""
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
            """#,
            related: ["Animatable", ".offset()"]
        ),
        Topic(
            name: "Gesture",
            kind: .protocolItem,
            summary: "The protocol behind drags, taps, pinches, and combinations.",
            discussion: "DragGesture, TapGesture, MagnifyGesture and friends all conform to Gesture, which is what lets them compose: simultaneously, sequenced, and exclusively build multi-touch interactions from small parts.",
            wwdcYear: 2019,
            code: #"""
            let pinchAndRotate = MagnifyGesture()
                .simultaneously(with: RotateGesture())

            photo.gesture(pinchAndRotate)
            """#,
            related: [".gesture()", "@GestureState"]
        ),
        Topic(
            name: "NSViewRepresentable",
            kind: .protocolItem,
            summary: "Wraps an AppKit view for use in SwiftUI.",
            discussion: "Implement makeNSView and updateNSView to host any NSView, with a Coordinator bridging delegates back to SwiftUI. The escape hatch when macOS AppKit offers something SwiftUI doesn't yet.",
            wwdcYear: 2019,
            platforms: [.macOS],
            code: #"""
            struct BlurView: NSViewRepresentable {
                func makeNSView(context: Context) -> NSVisualEffectView {
                    let view = NSVisualEffectView()
                    view.material = .hudWindow
                    return view
                }
                func updateNSView(_ view: NSVisualEffectView, context: Context) { }
            }
            """#,
            related: ["UIViewRepresentable", "View"]
        ),
        Topic(
            name: "UIViewRepresentable",
            kind: .protocolItem,
            summary: "Wraps a UIKit view for use in SwiftUI.",
            discussion: "The iOS twin of NSViewRepresentable: makeUIView creates the UIView once, updateUIView syncs SwiftUI state into it, and a Coordinator handles delegate callbacks. Prefer native SwiftUI when an equivalent exists.",
            wwdcYear: 2019,
            platforms: [.iOS, .tvOS],
            code: #"""
            struct ActivityRing: UIViewRepresentable {
                var progress: Double

                func makeUIView(context: Context) -> RingView { RingView() }
                func updateUIView(_ view: RingView, context: Context) {
                    view.progress = progress
                }
            }
            """#,
            related: ["NSViewRepresentable", "View"]
        ),
        Topic(
            name: "ToolbarContent",
            kind: .protocolItem,
            summary: "Builds reusable groups of toolbar items.",
            discussion: "Conforming to ToolbarContent lets you factor ToolbarItem declarations into named types shared across screens, keeping placements consistent — the toolbar counterpart of extracting a subview.",
            wwdcYear: 2020,
            code: #"""
            struct EditorToolbar: ToolbarContent {
                var body: some ToolbarContent {
                    ToolbarItem(placement: .primaryAction) {
                        Button("Save", systemImage: "tray.and.arrow.down") { }
                    }
                }
            }

            content.toolbar { EditorToolbar() }
            """#,
            related: [".toolbar()"]
        ),
        Topic(
            name: "Commands",
            kind: .protocolItem,
            summary: "Declares menu bar commands for a scene.",
            discussion: "Commands populate the macOS menu bar (and iPad key-command HUD) declaratively: group replacements, new menus, and keyboard shortcuts, attached to a scene with the commands modifier. This app adds its tab shortcuts this way.",
            wwdcYear: 2020,
            platforms: [.iOS, .macOS],
            code: #"""
            struct SortCommands: Commands {
                var body: some Commands {
                    CommandMenu("Sort") {
                        Button("By Name") { sort(.name) }
                            .keyboardShortcut("1")
                    }
                }
            }
            """#,
            related: [".keyboardShortcut()", "Scene"]
        ),
        Topic(
            name: "Transition",
            kind: .protocolItem,
            summary: "Defines custom insertion and removal animations.",
            discussion: "The Transition protocol (2023) formalizes what AnyTransition compositions did: given content and a phase — willAppear, identity, didDisappear — return the modified view, and SwiftUI interpolates between phases.",
            wwdcYear: 2023,
            code: #"""
            struct Twirl: Transition {
                func body(content: Content, phase: TransitionPhase) -> some View {
                    content
                        .rotationEffect(.degrees(phase.isIdentity ? 0 : 180))
                        .opacity(phase.isIdentity ? 1 : 0)
                }
            }
            """#,
            related: [".transition()", "CustomAnimation"]
        ),
        Topic(
            name: "TextRenderer",
            kind: .protocolItem,
            summary: "Takes over how Text draws, line by line, glyph by glyph.",
            discussion: "TextRenderer (WWDC '24) hands you the resolved text layout and a GraphicsContext: draw runs and glyphs yourself for per-character animations and effects that were previously Core Text territory.",
            wwdcYear: 2024,
            platforms: [.iOS, .macOS],
            code: #"""
            struct Jitter: TextRenderer {
                func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
                    for line in layout {
                        for run in line {
                            ctx.translateBy(x: 0, y: .random(in: -1...1))
                            ctx.draw(run)
                        }
                    }
                }
            }
            """#,
            related: ["Text", "Canvas"]
        ),
        Topic(
            name: "ScrollTargetBehavior",
            kind: .protocolItem,
            summary: "Custom rules for where scrolling comes to rest.",
            discussion: "Adopt ScrollTargetBehavior to bend the end of a scroll gesture: updateTarget receives the proposed resting point and may move it — snap grids, magnetic sections, or paging variants beyond the built-ins.",
            wwdcYear: 2023,
            code: #"""
            struct SnapTo80: ScrollTargetBehavior {
                func updateTarget(_ target: inout ScrollTarget,
                                  context: TargetContext) {
                    target.rect.origin.y =
                        (target.rect.origin.y / 80).rounded() * 80
                }
            }
            """#,
            related: [".scrollTargetBehavior()", "ScrollView"]
        ),
        Topic(
            name: "InsettableShape",
            kind: .protocolItem,
            summary: "A shape that can inset itself, enabling strokeBorder.",
            discussion: "strokeBorder keeps a stroke fully inside a shape's bounds by first insetting it — which requires the shape to implement inset(by:). All built-ins conform; custom shapes need it to avoid clipped borders.",
            wwdcYear: 2019,
            code: #"""
            extension Triangle: InsettableShape {
                func inset(by amount: CGFloat) -> some InsettableShape {
                    var copy = self
                    copy.insetAmount += amount
                    return copy
                }
            }

            Triangle().strokeBorder(.blue, lineWidth: 4)
            """#,
            related: ["Shape", "RoundedRectangle"]
        ),
    ]
}
