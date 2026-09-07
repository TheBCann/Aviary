//
//  ChildExamples+Part19.swift
//  Aviary
//
//  Compiled renderings for variant entries (part 19: protocols).
//  One private C19_* struct per variant; every rendering exercises the exact
//  requirement, member, or overload the variant names, so siblings can be
//  compared side by side.
//

import SwiftUI
import AppKit
import QuartzCore

enum ChildExamplesPart19 {
    static let entries: [ChildExampleEntry] = [

        // MARK: Animatable

        ChildExampleEntry(parent: "Animatable", child: "animatableData", code: """
        struct Counter: ViewModifier, Animatable {
            var value: Double
            var animatableData: Double {
                get { value } set { value = newValue }
            }
            func body(content: Content) -> some View { Text("\\(Int(value))") }
        }

        Text("").modifier(Counter(value: total))
            .animation(.easeOut(duration: 1), value: total)   // each frame gets an interpolated value
        """) { AnyView(C19_AnimatableDataExample()) },

        ChildExampleEntry(parent: "Animatable", child: "AnimatablePair<First, Second>", code: """
        struct Blob: Shape {
            var width: CGFloat, height: CGFloat
            var animatableData: AnimatablePair<CGFloat, CGFloat> {
                get { AnimatablePair(width, height) }
                set { width = newValue.first; height = newValue.second }
            }
            func path(in rect: CGRect) -> Path { blobPath(rect, width, height) }
        }

        Blob(width: isWide ? 0.9 : 0.35, height: isWide ? 0.35 : 0.9)
            .fill(.teal.gradient)
            .animation(.spring(duration: 0.6), value: isWide)
        """) { AnyView(C19_AnimatablePairExample()) },

        ChildExampleEntry(parent: "Animatable", child: "@Animatable macro", code: """
        @Animatable
        struct Wave: Shape {
            var amplitude: Double
            var phase: Double
            @AnimatableIgnored var samples = 64

            func path(in rect: CGRect) -> Path { wavePath(rect, amplitude, phase, samples) }
        }

        Wave(amplitude: isCalm ? 6 : 24, phase: isCalm ? 0 : .pi)
            .stroke(.blue, lineWidth: 3)
            .animation(.easeInOut(duration: 0.8), value: isCalm)
        """) { AnyView(C19_AnimatableMacroExample()) },

        // MARK: App

        ChildExampleEntry(parent: "App", child: "body", code: """
        var body: some Scene {
            WindowGroup { ContentView() }
            #if os(macOS)
            Settings { SettingsView() }
            MenuBarExtra("Status", systemImage: "circle.fill") { StatusMenu() }
            #endif
        }
        """) { AnyView(C19_AppBodyExample()) },

        ChildExampleEntry(parent: "App", child: "static main()", code: """
        // main.swift — no @main attribute on the App type
        if CommandLine.arguments.contains("--export-only") {
            Exporter.run()
        } else {
            CompanionApp.main()
        }
        """) { AnyView(C19_AppMainExample()) },

        // MARK: ButtonStyle

        ChildExampleEntry(parent: "ButtonStyle", child: "makeBody(configuration:)", code: """
        struct PressFade: ButtonStyle {
            func makeBody(configuration: Configuration) -> some View {
                configuration.label
                    .padding(.horizontal, 14).padding(.vertical, 8)
                    .background(Color.accentColor.opacity(0.15), in: Capsule())
                    .opacity(configuration.isPressed ? 0.6 : 1)
                    .scaleEffect(configuration.isPressed ? 0.96 : 1)
                    .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
            }
        }

        Button("Hold Me") { taps += 1 }.buttonStyle(PressFade())
        """) { AnyView(C19_ButtonStyleMakeBodyExample()) },

        ChildExampleEntry(parent: "ButtonStyle", child: "ButtonStyleConfiguration", code: """
        struct RoleAware: ButtonStyle {
            func makeBody(configuration: ButtonStyleConfiguration) -> some View {
                configuration.label
                    .foregroundStyle(configuration.role == .destructive ? Color.red : Color.primary)
                    .padding(8)
                    .background(.quaternary, in: .rect(cornerRadius: 8))
                    .opacity(configuration.isPressed ? 0.5 : 1)
            }
        }

        Button("Delete", role: .destructive) { }.buttonStyle(RoleAware())
        Button("Keep") { }.buttonStyle(RoleAware())
        """) { AnyView(C19_ButtonStyleConfigurationExample()) },

        ChildExampleEntry(parent: "ButtonStyle", child: "ButtonStyle.borderedProminent", code: """
        Button("Continue") { advance() }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)

        Button("Skip") { skip() }
            .buttonStyle(.borderless)
        """) { AnyView(C19_ButtonStyleBorderedProminentExample()) },

        ChildExampleEntry(parent: "ButtonStyle", child: "ButtonStyle.glass", code: """
        Button("Add", systemImage: "plus") { add() }
            .buttonStyle(.glass)

        Button("Buy Now") { checkout() }
            .buttonStyle(.glassProminent)
        """) { AnyView(C19_ButtonStyleGlassExample()) },

        // MARK: Commands

        ChildExampleEntry(parent: "Commands", child: "CommandMenu(_:content:)", code: """
        CommandMenu("Library") {
            Button("Import PDF…") { library.presentImporter() }
                .keyboardShortcut("i", modifiers: [.command, .shift])
            Divider()
            Button("Rebuild Index") { library.reindex() }
        }
        """) { AnyView(C19_CommandMenuExample()) },

        ChildExampleEntry(parent: "Commands", child: "CommandGroup(replacing:addition:)", code: """
        CommandGroup(replacing: .newItem) {
            Button("New Document") { newDocument() }
                .keyboardShortcut("n")
            Button("New From Clipboard") { newFromPasteboard() }
                .keyboardShortcut("n", modifiers: [.command, .option])
        }
        """) { AnyView(C19_CommandGroupReplacingExample()) },

        ChildExampleEntry(parent: "Commands", child: "CommandGroup(after:addition:)", code: """
        struct ViewCommands: Commands {
            var body: some Commands {
                CommandGroup(after: .sidebar) {
                    Button("Toggle Inspector") { showsInspector.toggle() }
                        .keyboardShortcut("i", modifiers: [.command, .option])
                }
            }
        }
        """) { AnyView(C19_CommandGroupAfterExample()) },

        // MARK: CustomAnimation

        ChildExampleEntry(parent: "CustomAnimation", child: "animate(value:time:context:)", code: """
        struct CubicOut: CustomAnimation {
            var duration: TimeInterval = 1
            func animate<V: VectorArithmetic>(
                value: V, time: TimeInterval, context: inout AnimationContext<V>
            ) -> V? {
                guard time < duration else { return nil }
                let eased = 1 - pow(1 - time / duration, 3)
                return value.scaled(by: eased)
            }
        }

        Circle().offset(x: isRight ? 200 : 0)
            .animation(Animation(CubicOut(duration: 1.2)), value: isRight)
        """) { AnyView(C19_CustomAnimationAnimateExample()) },

        ChildExampleEntry(parent: "CustomAnimation", child: "velocity(value:time:context:)", code: """
        struct LinearDrift: CustomAnimation {
            var duration: TimeInterval = 1.5
            func animate<V: VectorArithmetic>(value: V, time: TimeInterval,
                                              context: inout AnimationContext<V>) -> V? {
                time < duration ? value.scaled(by: time / duration) : nil
            }
            func velocity<V: VectorArithmetic>(
                value: V, time: TimeInterval, context: AnimationContext<V>
            ) -> V? {
                time < duration ? value.scaled(by: 1 / duration) : nil
            }
        }

        // An interrupting spring starts from the velocity LinearDrift reports
        withAnimation(.spring(duration: 0.8)) { isRight.toggle() }
        """) { AnyView(C19_CustomAnimationVelocityExample()) },

        ChildExampleEntry(parent: "CustomAnimation", child: "shouldMerge(previous:value:time:context:)", code: """
        struct Retarget: CustomAnimation {
            var merges: Bool
            func shouldMerge<V: VectorArithmetic>(
                previous: Animation, value: V, time: TimeInterval,
                context: inout AnimationContext<V>
            ) -> Bool {
                merges   // true: retarget in place; false: layer a second animation on top
            }
            func animate<V: VectorArithmetic>(value: V, time: TimeInterval,
                                              context: inout AnimationContext<V>) -> V? {
                time < 1 ? value.scaled(by: 1 - pow(1 - time, 3)) : nil
            }
        }
        """) { AnyView(C19_CustomAnimationShouldMergeExample()) },

        ChildExampleEntry(parent: "CustomAnimation", child: "Animation(_:)", code: """
        extension Animation {
            static var cubicOut: Animation { Animation(CubicOut()) }
        }

        withAnimation(.cubicOut) { isOpen.toggle() }
        """) { AnyView(C19_CustomAnimationWrapExample()) },

        // MARK: GeometryEffect

        ChildExampleEntry(parent: "GeometryEffect", child: "effectValue(size:)", code: """
        struct Skew: GeometryEffect {
            var amount: CGFloat
            var animatableData: CGFloat { get { amount } set { amount = newValue } }
            func effectValue(size: CGSize) -> ProjectionTransform {
                ProjectionTransform(
                    CGAffineTransform(a: 1, b: 0, c: amount, d: 1, tx: -amount * size.height / 2, ty: 0))
            }
        }

        card.modifier(Skew(amount: amount))
        """) { AnyView(C19_GeometryEffectValueExample()) },

        ChildExampleEntry(parent: "GeometryEffect", child: "ignoredByLayout()", code: """
        Text("Wrong password")
            .modifier(Shake(phase: attempts).ignoredByLayout())
            .animation(.default, value: attempts)
        """) { AnyView(C19_GeometryEffectIgnoredByLayoutExample()) },

        ChildExampleEntry(parent: "GeometryEffect", child: "ProjectionTransform", code: """
        func effectValue(size: CGSize) -> ProjectionTransform {
            var t = CATransform3DIdentity
            t.m34 = -1 / 400                            // perspective
            t = CATransform3DRotate(t, angle, 0, 1, 0)  // spin around the y axis
            let center = CGAffineTransform(translationX: size.width / 2, y: size.height / 2)
            return ProjectionTransform(center.inverted())
                .concatenating(ProjectionTransform(t))
                .concatenating(ProjectionTransform(center))
        }
        """) { AnyView(C19_ProjectionTransformExample()) },

        // MARK: Gesture

        ChildExampleEntry(parent: "Gesture", child: "onChanged(_:)", code: """
        DragGesture()
            .onChanged { value in
                offset = value.translation      // fires continuously while dragging
            }
            .onEnded { _ in offset = .zero }
        """) { AnyView(C19_GestureOnChangedExample()) },

        ChildExampleEntry(parent: "Gesture", child: "onEnded(_:)", code: """
        DragGesture(minimumDistance: 30)
            .onEnded { value in
                if value.predictedEndTranslation.width < -120 { dismiss() }
                offset = .zero
            }
        """) { AnyView(C19_GestureOnEndedExample()) },

        ChildExampleEntry(parent: "Gesture", child: "updating(_:body:)", code: """
        @GestureState private var isPressing = false

        LongPressGesture(minimumDuration: 0.4)
            .updating($isPressing) { current, state, _ in
                state = current      // reset to false automatically when the gesture ends
            }
        """) { AnyView(C19_GestureUpdatingExample()) },

        ChildExampleEntry(parent: "Gesture", child: "sequenced(before:)", code: """
        let pressThenDrag = LongPressGesture()
            .sequenced(before: DragGesture())
            .onEnded { value in
                if case .second(true, let drag?) = value { drop(at: drag.location) }
            }
        """) { AnyView(C19_GestureSequencedExample()) },

        // MARK: InsettableShape

        ChildExampleEntry(parent: "InsettableShape", child: "inset(by:)", code: """
        struct Ring: InsettableShape {
            var insetAmount: CGFloat = 0
            func path(in rect: CGRect) -> Path {
                Path(ellipseIn: rect.insetBy(dx: insetAmount, dy: insetAmount))
            }
            func inset(by amount: CGFloat) -> some InsettableShape {
                var ring = self; ring.insetAmount += amount; return ring
            }
        }

        Ring().inset(by: amount).fill(.teal.opacity(0.6))
        """) { AnyView(C19_InsetByExample()) },

        ChildExampleEntry(parent: "InsettableShape", child: "strokeBorder(_:lineWidth:antialiased:)", code: """
        Circle()
            .strokeBorder(.tint, lineWidth: 8, antialiased: true)
            .frame(width: 56, height: 56)   // all 8pt stay within the 56pt frame

        Circle()
            .stroke(.tint, lineWidth: 8)    // straddles the edge: 4pt spill outside
            .frame(width: 56, height: 56)
        """) { AnyView(C19_StrokeBorderLineWidthExample()) },

        ChildExampleEntry(parent: "InsettableShape", child: "strokeBorder(_:style:antialiased:)", code: """
        RoundedRectangle(cornerRadius: 12)
            .strokeBorder(.secondary,
                          style: StrokeStyle(lineWidth: 2, lineCap: .round, dash: [dash, 4]),
                          antialiased: true)
        """) { AnyView(C19_StrokeBorderStyleExample()) },

        // MARK: LabelStyle

        ChildExampleEntry(parent: "LabelStyle", child: "makeBody(configuration:)", code: """
        struct TrailingIcon: LabelStyle {
            func makeBody(configuration: Configuration) -> some View {
                HStack {
                    configuration.title
                    configuration.icon.foregroundStyle(.secondary)
                }
            }
        }

        Label("Favorites", systemImage: "heart").labelStyle(TrailingIcon())
        """) { AnyView(C19_LabelStyleMakeBodyExample()) },

        ChildExampleEntry(parent: "LabelStyle", child: "LabelStyleConfiguration", code: """
        func makeBody(configuration: LabelStyleConfiguration) -> some View {
            VStack(spacing: 2) {
                configuration.icon
                    .symbolVariant(.fill)
                    .font(.title2)
                configuration.title
                    .font(.caption2)
            }
        }
        """) { AnyView(C19_LabelStyleConfigurationExample()) },

        ChildExampleEntry(parent: "LabelStyle", child: "LabelStyle.iconOnly", code: """
        Label("Favorites", systemImage: "heart")
            .labelStyle(.iconOnly)

        Label("Favorites", systemImage: "heart")
            .labelStyle(.titleAndIcon)   // both, even where a toolbar would drop one
        """) { AnyView(C19_LabelStyleIconOnlyExample()) },

        // MARK: Layout

        ChildExampleEntry(parent: "Layout", child: "makeCache(subviews:)", code: """
        struct FlowLayout: Layout {
            struct Cache { var rows: [[Int]] = []; var size: CGSize = .zero }

            func makeCache(subviews: Subviews) -> Cache { Cache() }
            func updateCache(_ cache: inout Cache, subviews: Subviews) {
                cache = Cache()   // children changed; rows get recomputed on demand
            }
            // sizeThatFits / placeSubviews fill cache.rows once, then reuse them
        }
        """) { AnyView(C19_LayoutMakeCacheExample()) },

        ChildExampleEntry(parent: "Layout", child: "spacing(subviews:cache:)", code: """
        func spacing(subviews: Subviews, cache: inout Cache) -> ViewSpacing {
            if tight { return .zero }          // neighbours may sit flush against this container
            var spacing = ViewSpacing()
            for view in subviews { spacing.formUnion(view.spacing, edges: .all) }
            return spacing                     // otherwise merge the children's own preferences
        }

        VStack {        // no explicit spacing → the stack asks each child's ViewSpacing
            Strip(tight: tight) { chips }
            Strip(tight: tight) { chips }
        }
        """) { AnyView(C19_LayoutSpacingExample()) },

        ChildExampleEntry(parent: "Layout", child: "explicitAlignment(of:in:proposal:subviews:cache:)", code: """
        func explicitAlignment(of guide: VerticalAlignment, in bounds: CGRect,
                               proposal: ProposedViewSize, subviews: Subviews,
                               cache: inout ()) -> CGFloat? {
            guard guide == .firstTextBaseline, let first = subviews.first else { return nil }
            // Let siblings align to this container's first row rather than its box
            return bounds.minY + first.dimensions(in: .unspecified)[.firstTextBaseline]
        }

        HStack(alignment: .firstTextBaseline) {
            Text("Title:").bold()
            Column { Text("Sunrise").font(.title2); Text("6:41 AM") }
        }
        """) { AnyView(C19_LayoutExplicitAlignmentExample()) },

        ChildExampleEntry(parent: "Layout", child: "static layoutProperties", code: """
        struct VerticalFlow: Layout {
            static var layoutProperties: LayoutProperties {
                var properties = LayoutProperties()
                properties.stackOrientation = .vertical   // Spacers inside expand vertically
                return properties
            }
            // sizeThatFits / placeSubviews stack the children top to bottom
        }

        VerticalFlow { Text("Header"); Spacer(); Text("Footer") }
            .frame(height: 110)
        """) { AnyView(C19_LayoutPropertiesExample()) },

        // MARK: NSViewRepresentable

        ChildExampleEntry(parent: "NSViewRepresentable", child: "makeCoordinator()", code: """
        func makeCoordinator() -> Coordinator { Coordinator(text: $text) }

        final class Coordinator: NSObject, NSTextViewDelegate {
            var text: Binding<String>
            init(text: Binding<String>) { self.text = text }
            func textDidChange(_ note: Notification) {
                text.wrappedValue = (note.object as? NSTextView)?.string ?? ""
            }
        }
        """) { AnyView(C19_MakeCoordinatorExample()) },

        ChildExampleEntry(parent: "NSViewRepresentable", child: "sizeThatFits(_:nsView:context:)", code: """
        func sizeThatFits(_ proposal: ProposedViewSize,
                          nsView: NSTextField, context: Context) -> CGSize? {
            let width = proposal.width ?? nsView.intrinsicContentSize.width
            nsView.preferredMaxLayoutWidth = width
            return CGSize(width: width, height: nsView.intrinsicContentSize.height)
        }
        """) { AnyView(C19_SizeThatFitsExample()) },

        ChildExampleEntry(parent: "NSViewRepresentable", child: "dismantleNSView(_:coordinator:)", code: """
        static func dismantleNSView(_ spinner: NSProgressIndicator, coordinator: Coordinator) {
            spinner.stopAnimation(nil)
            coordinator.onDismantle()      // the last hook before AppKit discards the view
        }
        """) { AnyView(C19_DismantleExample()) },

        ChildExampleEntry(parent: "NSViewRepresentable", child: "Context", code: """
        func updateNSView(_ view: NSVisualEffectView, context: Context) {
            view.material = context.environment.colorScheme == .dark ? .hudWindow : .sidebar
            context.coordinator.animated = context.transaction.animation != nil
        }
        """) { AnyView(C19_ContextExample()) },

        // MARK: PreferenceKey

        ChildExampleEntry(parent: "PreferenceKey", child: "reduce(value:nextValue:)", code: """
        struct HeightsKey: PreferenceKey {
            static let defaultValue: [CGFloat] = []
            static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
                value.append(contentsOf: nextValue())
            }
        }

        row.background(GeometryReader { proxy in
            Color.clear.preference(key: HeightsKey.self, value: [proxy.size.height])
        })
        """) { AnyView(C19_PreferenceReduceExample()) },

        ChildExampleEntry(parent: "PreferenceKey", child: "onPreferenceChange(_:perform:)", code: """
        VStack { rows }
            .onPreferenceChange(WidthKey.self) { width in
                columnWidth = width
            }
        """) { AnyView(C19_OnPreferenceChangeExample()) },

        ChildExampleEntry(parent: "PreferenceKey", child: "anchorPreference(key:value:transform:)", code: """
        Text(item)
            .anchorPreference(key: SelectionKey.self, value: .bounds) { anchor in
                selected == item ? anchor : nil
            }
        """) { AnyView(C19_AnchorPreferenceExample()) },

        ChildExampleEntry(parent: "PreferenceKey", child: "overlayPreferenceValue(_:_:)", code: """
        tabs.overlayPreferenceValue(SelectionKey.self) { anchor in
            GeometryReader { proxy in
                if let anchor {
                    let rect = proxy[anchor]
                    RoundedRectangle(cornerRadius: 8).stroke(.tint, lineWidth: 2)
                        .frame(width: rect.width, height: rect.height)
                        .offset(x: rect.minX, y: rect.minY)
                }
            }
        }
        """) { AnyView(C19_OverlayPreferenceValueExample()) },

        // MARK: PrimitiveButtonStyle

        ChildExampleEntry(parent: "PrimitiveButtonStyle", child: "makeBody(configuration:)", code: """
        struct DoubleTap: PrimitiveButtonStyle {
            func makeBody(configuration: Configuration) -> some View {
                configuration.label
                    .contentShape(.rect)
                    .onTapGesture(count: 2) { configuration.trigger() }
            }
        }

        Button("Double-click me") { count += 1 }.buttonStyle(DoubleTap())
        """) { AnyView(C19_PrimitiveMakeBodyExample()) },

        ChildExampleEntry(parent: "PrimitiveButtonStyle", child: "PrimitiveButtonStyleConfiguration.trigger()", code: """
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .onLongPressGesture(minimumDuration: 1) {
                    configuration.trigger()    // nothing fires until the style calls this
                }
        }
        """) { AnyView(C19_PrimitiveTriggerExample()) },

        ChildExampleEntry(parent: "PrimitiveButtonStyle", child: "Button(_:) with a configuration", code: """
        struct RoleTinted: PrimitiveButtonStyle {
            func makeBody(configuration: Configuration) -> some View {
                Button(configuration)
                    .buttonStyle(.bordered)
                    .tint(configuration.role == .destructive ? .red : .accentColor)
            }
        }
        """) { AnyView(C19_PrimitiveButtonConfigurationExample()) },

        // MARK: ProgressViewStyle

        ChildExampleEntry(parent: "ProgressViewStyle", child: "makeBody(configuration:)", code: """
        struct LabeledBar: ProgressViewStyle {
            func makeBody(configuration: Configuration) -> some View {
                VStack(alignment: .leading) {
                    configuration.label
                    ProgressView(configuration).tint(.green)
                }
            }
        }

        ProgressView("Uploading", value: progress).progressViewStyle(LabeledBar())
        """) { AnyView(C19_ProgressViewStyleExample()) },
    ]
}

// MARK: - Shared helpers

private struct C19_Caption: View {
    var text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
    }
}

private struct C19_MockWindow<Content: View>: View {
    var title: String
    @ViewBuilder var content: Content

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 5) {
                ForEach([Color.red, .yellow, .green], id: \.self) { color in
                    Circle().fill(color).frame(width: 8, height: 8)
                }
                Spacer()
                Text(title).font(.caption2).foregroundStyle(.secondary)
                Spacer()
            }
            .padding(6)
            .background(.quaternary)
            content
                .frame(maxWidth: .infinity)
                .padding(10)
        }
        .background(.background, in: RoundedRectangle(cornerRadius: 8))
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.quaternary))
    }
}

private struct C19_MenuRow {
    var label: String
    var shortcut: String = ""
    var isDivider = false
    var isHighlighted = false
    static let divider = C19_MenuRow(label: "", isDivider: true)
}

private struct C19_MockMenuBar: View {
    var titles: [String]
    var openTitle: String
    var rows: [C19_MenuRow]

    private var dropdownOffset: CGFloat {
        CGFloat(titles.firstIndex(of: openTitle) ?? 0) * 46 + 30
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 14) {
                Image(systemName: "apple.logo")
                ForEach(titles, id: \.self) { title in
                    Text(title)
                        .fontWeight(title == openTitle ? .semibold : .regular)
                        .padding(.horizontal, 6).padding(.vertical, 2)
                        .background(title == openTitle ? Color.accentColor.opacity(0.25) : .clear,
                                    in: RoundedRectangle(cornerRadius: 4))
                }
                Spacer()
            }
            .font(.caption)
            .padding(.horizontal, 10).padding(.vertical, 4)
            .background(.quaternary)

            VStack(alignment: .leading, spacing: 2) {
                ForEach(Array(rows.enumerated()), id: \.offset) { _, row in
                    if row.isDivider {
                        Divider()
                    } else {
                        HStack {
                            Text(row.label)
                            Spacer()
                            Text(row.shortcut).foregroundStyle(.secondary)
                        }
                        .padding(.horizontal, 8).padding(.vertical, 2)
                        .background(row.isHighlighted ? Color.accentColor.opacity(0.2) : .clear,
                                    in: RoundedRectangle(cornerRadius: 4))
                    }
                }
            }
            .font(.caption)
            .padding(6)
            .frame(width: 230)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(.quaternary))
            .padding(.leading, dropdownOffset)
        }
    }
}

// MARK: - Animatable

private nonisolated struct C19_CounterModifier: ViewModifier, Animatable {
    var value: Double
    var animatableData: Double {
        get { value }
        set { value = newValue }
    }
    func body(content: Content) -> some View {
        Text("\(Int(value))")
            .font(.system(size: 44, weight: .bold, design: .rounded))
            .monospacedDigit()
    }
}

private struct C19_AnimatableDataExample: View {
    @State private var total: Double = 0

    var body: some View {
        VStack(spacing: 12) {
            Text("").modifier(C19_CounterModifier(value: total))
                .animation(.easeOut(duration: 1), value: total)
            Button("Add 250") { total += 250 }
            C19_Caption("Without animatableData the number would jump straight to the target.")
        }
    }
}

private nonisolated struct C19_BlobShape: Shape {
    var width: CGFloat
    var height: CGFloat

    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(width, height) }
        set { width = newValue.first; height = newValue.second }
    }

    func path(in rect: CGRect) -> Path {
        let size = CGSize(width: rect.width * width, height: rect.height * height)
        let origin = CGPoint(x: rect.midX - size.width / 2, y: rect.midY - size.height / 2)
        return Path(roundedRect: CGRect(origin: origin, size: size),
                    cornerRadius: min(size.width, size.height) / 3)
    }
}

private struct C19_AnimatablePairExample: View {
    @State private var isWide = true

    var body: some View {
        VStack(spacing: 12) {
            C19_BlobShape(width: isWide ? 0.9 : 0.35, height: isWide ? 0.35 : 0.9)
                .fill(.teal.gradient)
                .frame(width: 150, height: 100)
                .animation(.spring(duration: 0.6), value: isWide)
            Button(isWide ? "Make Tall" : "Make Wide") { isWide.toggle() }
            C19_Caption("width and height tween together through one AnimatablePair.")
        }
    }
}

@Animatable
private nonisolated struct C19_WaveShape: Shape {
    var amplitude: Double
    var phase: Double
    @AnimatableIgnored var samples = 64

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for index in 0...samples {
            let fraction = Double(index) / Double(samples)
            let point = CGPoint(x: rect.minX + rect.width * fraction,
                                y: rect.midY + sin(fraction * .pi * 2 + phase) * amplitude)
            if index == 0 { path.move(to: point) } else { path.addLine(to: point) }
        }
        return path
    }
}

private struct C19_AnimatableMacroExample: View {
    @State private var isCalm = true

    var body: some View {
        VStack(spacing: 12) {
            C19_WaveShape(amplitude: isCalm ? 6 : 24, phase: isCalm ? 0 : .pi)
                .stroke(.blue, lineWidth: 3)
                .frame(height: 70)
                .animation(.easeInOut(duration: 0.8), value: isCalm)
            Button(isCalm ? "Stir" : "Settle") { isCalm.toggle() }
            C19_Caption("amplitude and phase tween; samples is @AnimatableIgnored so it never interpolates.")
        }
    }
}

// MARK: - App

private struct C19_CompanionApp: App {
    var body: some Scene {
        WindowGroup { Text("ContentView") }
        #if os(macOS)
        Settings { Text("SettingsView") }
        MenuBarExtra("Status", systemImage: "circle.fill") { Text("StatusMenu") }
        #endif
    }
}

private struct C19_AppBodyExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 10) {
                Image(systemName: "apple.logo")
                Text("Companion").fontWeight(.semibold)
                Text("File   Edit   View")
                Spacer()
                Image(systemName: "circle.fill")
                    .foregroundStyle(.green)
                    .padding(.horizontal, 6).padding(.vertical, 2)
                    .background(Color.accentColor.opacity(0.25), in: RoundedRectangle(cornerRadius: 4))
                Text("MenuBarExtra").foregroundStyle(.secondary)
            }
            .font(.caption)
            .padding(.horizontal, 8).padding(.vertical, 4)
            .background(.quaternary)

            HStack(alignment: .top, spacing: 10) {
                C19_MockWindow(title: "WindowGroup") {
                    Text("ContentView()").font(.caption)
                }
                C19_MockWindow(title: "Settings") {
                    Text("SettingsView()").font(.caption)
                }
            }
            C19_Caption("Illustrative — applies at the App level: the scene list becomes the windows, the Settings pane, and the menu bar extra.")
        }
    }
}

private struct C19_AppMainExample: View {
    private var exportOnly: Bool { CommandLine.arguments.contains("--export-only") }

    var body: some View {
        VStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 4) {
                Text("$ Companion" + (exportOnly ? " --export-only" : ""))
                Text(exportOnly ? "→ Exporter.run()" : "→ CompanionApp.main()   // sets up the App, then runs its scenes")
                    .foregroundStyle(.green)
                Text("CommandLine.arguments.count == \(CommandLine.arguments.count)")
                    .foregroundStyle(.gray)
            }
            .font(.system(.caption, design: .monospaced))
            .foregroundStyle(.white)
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.black.opacity(0.85), in: RoundedRectangle(cornerRadius: 8))
            C19_Caption("Illustrative — main() runs once at launch from main.swift; the branch shown reflects this process's real arguments.")
        }
    }
}

// MARK: - ButtonStyle

private struct C19_PressFadeStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 14).padding(.vertical, 8)
            .background(Color.accentColor.opacity(0.15), in: Capsule())
            .opacity(configuration.isPressed ? 0.6 : 1)
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

private struct C19_ButtonStyleMakeBodyExample: View {
    @State private var taps = 0

    var body: some View {
        VStack(spacing: 12) {
            Button("Hold Me") { taps += 1 }
                .buttonStyle(C19_PressFadeStyle())
            Text("Triggered \(taps)×").font(.caption).monospacedDigit()
            C19_Caption("Press and hold: isPressed drives the fade and scale while the mouse is down.")
        }
    }
}

private struct C19_RoleAwareStyle: ButtonStyle {
    func makeBody(configuration: ButtonStyleConfiguration) -> some View {
        configuration.label
            .foregroundStyle(configuration.role == .destructive ? Color.red : Color.primary)
            .padding(8)
            .background(.quaternary, in: .rect(cornerRadius: 8))
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

private struct C19_ButtonStyleConfigurationExample: View {
    @State private var last = "—"

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                Button("Delete", role: .destructive) { last = "role: .destructive" }
                    .buttonStyle(C19_RoleAwareStyle())
                Button("Keep") { last = "role: nil" }
                    .buttonStyle(C19_RoleAwareStyle())
            }
            Text("Last press → \(last)").font(.caption).monospacedDigit()
            C19_Caption("The configuration carries label, role, and isPressed; the style reads role to tint the destructive one.")
        }
    }
}

private struct C19_ButtonStyleBorderedProminentExample: View {
    @State private var log = "Tap a button"

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                Button("Continue") { log = ".borderedProminent" }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                Button("Skip") { log = ".borderless" }
                    .buttonStyle(.borderless)
            }
            HStack(spacing: 12) {
                Button("Bordered") { log = ".bordered" }
                    .buttonStyle(.bordered)
                Button("Plain") { log = ".plain" }
                    .buttonStyle(.plain)
            }
            Text(log).font(.caption).foregroundStyle(.secondary)
        }
    }
}

private struct C19_ButtonStyleGlassExample: View {
    @State private var cart = 0

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                LinearGradient(colors: [.pink, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing)
                HStack(spacing: 16) {
                    Button("Add", systemImage: "plus") { cart += 1 }
                        .buttonStyle(.glass)
                    Button("Buy Now") { cart = 0 }
                        .buttonStyle(.glassProminent)
                }
            }
            .frame(height: 110)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            Text("Items in cart: \(cart)").font(.caption).monospacedDigit()
        }
    }
}

// MARK: - Commands

private struct C19_LibraryCommands: Commands {
    var body: some Commands {
        CommandMenu("Library") {
            Button("Import PDF…") { }
                .keyboardShortcut("i", modifiers: [.command, .shift])
            Divider()
            Button("Rebuild Index") { }
        }
    }
}

private struct C19_CommandMenuExample: View {
    var body: some View {
        VStack(spacing: 8) {
            C19_MockMenuBar(
                titles: ["File", "Edit", "View", "Library", "Window", "Help"],
                openTitle: "Library",
                rows: [
                    C19_MenuRow(label: "Import PDF…", shortcut: "⇧⌘I", isHighlighted: true),
                    .divider,
                    C19_MenuRow(label: "Rebuild Index", isHighlighted: true),
                ]
            )
            C19_Caption("Illustrative — Commands render in the app's menu bar; CommandMenu adds the whole \"Library\" menu.")
        }
    }
}

private struct C19_NewItemCommands: Commands {
    var body: some Commands {
        CommandGroup(replacing: .newItem) {
            Button("New Document") { }
                .keyboardShortcut("n")
            Button("New From Clipboard") { }
                .keyboardShortcut("n", modifiers: [.command, .option])
        }
    }
}

private struct C19_CommandGroupReplacingExample: View {
    var body: some View {
        VStack(spacing: 8) {
            C19_MockMenuBar(
                titles: ["File", "Edit", "View", "Window", "Help"],
                openTitle: "File",
                rows: [
                    C19_MenuRow(label: "New Document", shortcut: "⌘N", isHighlighted: true),
                    C19_MenuRow(label: "New From Clipboard", shortcut: "⌥⌘N", isHighlighted: true),
                    C19_MenuRow(label: "Open…", shortcut: "⌘O"),
                    .divider,
                    C19_MenuRow(label: "Close", shortcut: "⌘W"),
                    C19_MenuRow(label: "Save", shortcut: "⌘S"),
                ]
            )
            C19_Caption("Illustrative — the standard New group is replaced by the two highlighted items; Open, Close, and Save stay.")
        }
    }
}

private struct C19_ViewCommands: Commands {
    var body: some Commands {
        CommandGroup(after: .sidebar) {
            Button("Toggle Inspector") { }
                .keyboardShortcut("i", modifiers: [.command, .option])
        }
    }
}

private struct C19_CommandGroupAfterExample: View {
    var body: some View {
        VStack(spacing: 8) {
            C19_MockMenuBar(
                titles: ["File", "Edit", "View", "Window", "Help"],
                openTitle: "View",
                rows: [
                    C19_MenuRow(label: "Show Toolbar", shortcut: "⌥⌘T"),
                    C19_MenuRow(label: "Hide Sidebar", shortcut: "^⌘S"),
                    C19_MenuRow(label: "Toggle Inspector", shortcut: "⌥⌘I", isHighlighted: true),
                    .divider,
                    C19_MenuRow(label: "Enter Full Screen", shortcut: "fn F"),
                ]
            )
            C19_Caption("Illustrative — the .sidebar group is left intact; the highlighted item is inserted directly after it.")
        }
    }
}

// MARK: - CustomAnimation

private nonisolated struct C19_CubicOutAnimation: CustomAnimation {
    var duration: TimeInterval = 1

    func animate<V: VectorArithmetic>(value: V, time: TimeInterval, context: inout AnimationContext<V>) -> V? {
        guard time < duration else { return nil }
        let eased = 1 - pow(1 - time / duration, 3)
        return value.scaled(by: eased)
    }
}

private struct C19_CustomAnimationAnimateExample: View {
    @State private var isRight = false

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Circle()
                    .fill(.orange.gradient)
                    .frame(width: 32, height: 32)
                    .offset(x: isRight ? 200 : 0)
                    .animation(Animation(C19_CubicOutAnimation(duration: 1.2)), value: isRight)
                Spacer()
            }
            .frame(width: 240, height: 40)
            Button(isRight ? "Slide Left" : "Slide Right") { isRight.toggle() }
            C19_Caption("animate(…) is called every frame with the elapsed time and returns the eased vector; nil ends it.")
        }
    }
}

private nonisolated struct C19_LinearDriftAnimation: CustomAnimation {
    var duration: TimeInterval = 1.5

    func animate<V: VectorArithmetic>(value: V, time: TimeInterval, context: inout AnimationContext<V>) -> V? {
        time < duration ? value.scaled(by: time / duration) : nil
    }

    func velocity<V: VectorArithmetic>(value: V, time: TimeInterval, context: AnimationContext<V>) -> V? {
        time < duration ? value.scaled(by: 1 / duration) : nil
    }
}

private struct C19_CustomAnimationVelocityExample: View {
    @State private var isRight = false

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Circle()
                    .fill(.purple.gradient)
                    .frame(width: 32, height: 32)
                    .offset(x: isRight ? 200 : 0)
                Spacer()
            }
            .frame(width: 240, height: 40)
            HStack(spacing: 12) {
                Button("Drift (1.5 s)") {
                    withAnimation(Animation(C19_LinearDriftAnimation())) { isRight.toggle() }
                }
                Button("Spring Back") {
                    withAnimation(.spring(duration: 0.8)) { isRight.toggle() }
                }
            }
            C19_Caption("Start a drift, then press Spring Back mid-flight: the spring inherits the velocity the drift reports.")
        }
    }
}

private nonisolated struct C19_RetargetAnimation: CustomAnimation {
    var merges: Bool

    func shouldMerge<V: VectorArithmetic>(previous: Animation, value: V, time: TimeInterval,
                                          context: inout AnimationContext<V>) -> Bool {
        merges
    }

    func animate<V: VectorArithmetic>(value: V, time: TimeInterval, context: inout AnimationContext<V>) -> V? {
        time < 1 ? value.scaled(by: 1 - pow(1 - time, 3)) : nil
    }
}

private struct C19_CustomAnimationShouldMergeExample: View {
    @State private var isRight = false

    var body: some View {
        VStack(spacing: 10) {
            ForEach([true, false] as [Bool], id: \.self) { (merges: Bool) in
                HStack(spacing: 8) {
                    Text(merges ? "merge: true" : "merge: false")
                        .font(.caption).monospacedDigit()
                        .frame(width: 84, alignment: .leading)
                    HStack {
                        Circle()
                            .fill(merges ? Color.green.gradient : Color.red.gradient)
                            .frame(width: 26, height: 26)
                            .offset(x: isRight ? 160 : 0)
                            .animation(Animation(C19_RetargetAnimation(merges: merges)), value: isRight)
                        Spacer()
                    }
                    .frame(width: 190)
                }
            }
            Button("Toggle Target (tap rapidly)") { isRight.toggle() }
            C19_Caption("Merging retargets the running animation in place; not merging stacks each new one additively.")
        }
    }
}

private extension Animation {
    static var c19CubicOut: Animation { Animation(C19_CubicOutAnimation()) }
}

private struct C19_CustomAnimationWrapExample: View {
    @State private var isOpen = false

    var body: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.blue.gradient)
                .frame(width: isOpen ? 220 : 80, height: 50)
                .overlay(Text(isOpen ? "Open" : "Closed").foregroundStyle(.white))
            Button(isOpen ? "Close" : "Open") {
                withAnimation(.c19CubicOut) { isOpen.toggle() }
            }
            C19_Caption("Animation(_:) wraps the CustomAnimation so withAnimation and .animation accept it like any built-in curve.")
        }
    }
}

// MARK: - GeometryEffect

private nonisolated struct C19_SkewEffect: GeometryEffect {
    var amount: CGFloat

    var animatableData: CGFloat {
        get { amount }
        set { amount = newValue }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(
            CGAffineTransform(a: 1, b: 0, c: amount, d: 1, tx: -amount * size.height / 2, ty: 0))
    }
}

private struct C19_GeometryEffectValueExample: View {
    @State private var amount: CGFloat = 0.3

    var body: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.indigo.gradient)
                .frame(width: 150, height: 60)
                .overlay(Text("Skewed").foregroundStyle(.white))
                .modifier(C19_SkewEffect(amount: amount))
            Slider(value: $amount, in: -0.7...0.7) { Text("amount") }
                .frame(width: 220)
            Text(String(format: "amount = %.2f", amount)).font(.caption).monospacedDigit()
        }
    }
}

private nonisolated struct C19_ShakeEffect: GeometryEffect {
    var phase: CGFloat

    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: 8 * sin(phase * .pi * 6), y: 0))
    }
}

private struct C19_GeometryEffectIgnoredByLayoutExample: View {
    @State private var attempts: CGFloat = 0

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                Image(systemName: "lock.fill")
                Text("Wrong password")
                    .padding(8)
                    .background(.red.opacity(0.15), in: RoundedRectangle(cornerRadius: 6))
                    .modifier(C19_ShakeEffect(phase: attempts).ignoredByLayout())
                    .animation(.default, value: attempts)
                Text("Forgot?").foregroundStyle(.secondary)
            }
            Button("Try Again") { attempts += 1 }
            C19_Caption("The shake is applied only while rendering, so the neighbours never see the offset and layout is not re-run.")
        }
    }
}

private nonisolated struct C19_FlipEffect: GeometryEffect {
    var angle: CGFloat

    var animatableData: CGFloat {
        get { angle }
        set { angle = newValue }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        var t = CATransform3DIdentity
        t.m34 = -1 / 400
        t = CATransform3DRotate(t, angle, 0, 1, 0)
        let center = CGAffineTransform(translationX: size.width / 2, y: size.height / 2)
        return ProjectionTransform(center.inverted())
            .concatenating(ProjectionTransform(t))
            .concatenating(ProjectionTransform(center))
    }
}

private struct C19_ProjectionTransformExample: View {
    @State private var angle: CGFloat = 0.6

    var body: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.mint.gradient)
                .frame(width: 150, height: 70)
                .overlay(Text("Card").foregroundStyle(.white))
                .modifier(C19_FlipEffect(angle: angle))
            Slider(value: $angle, in: -1.2...1.2) { Text("angle") }
                .frame(width: 220)
            Text(String(format: "angle = %.2f rad", angle)).font(.caption).monospacedDigit()
        }
    }
}

// MARK: - Gesture

private struct C19_GestureOnChangedExample: View {
    @State private var offset: CGSize = .zero

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 8).fill(.quaternary)
                Circle()
                    .fill(.blue.gradient)
                    .frame(width: 40, height: 40)
                    .offset(offset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                offset = value.translation
                            }
                            .onEnded { _ in offset = .zero }
                    )
            }
            .frame(width: 240, height: 100)
            Text(String(format: "translation = (%.0f, %.0f)", offset.width, offset.height))
                .font(.caption).monospacedDigit()
        }
    }
}

private struct C19_GestureOnEndedExample: View {
    @State private var isDismissed = false
    @State private var lastPrediction: CGFloat = 0

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 8).fill(.quaternary)
                if isDismissed {
                    Button("Reset") { isDismissed = false }
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.orange.gradient)
                        .frame(width: 160, height: 60)
                        .overlay(Text("Flick me left").foregroundStyle(.white))
                        .gesture(
                            DragGesture(minimumDistance: 30)
                                .onEnded { value in
                                    lastPrediction = value.predictedEndTranslation.width
                                    if value.predictedEndTranslation.width < -120 { isDismissed = true }
                                }
                        )
                }
            }
            .frame(width: 240, height: 90)
            Text(String(format: "last predictedEndTranslation.width = %.0f", lastPrediction))
                .font(.caption).monospacedDigit()
            C19_Caption("Nothing moves during the drag; the single onEnded call decides commit or cancel.")
        }
    }
}

private struct C19_GestureUpdatingExample: View {
    @GestureState private var isPressing = false

    var body: some View {
        VStack(spacing: 12) {
            Circle()
                .fill(isPressing ? Color.green.gradient : Color.gray.gradient)
                .frame(width: 60, height: 60)
                .scaleEffect(isPressing ? 1.25 : 1)
                .animation(.easeOut(duration: 0.15), value: isPressing)
                .gesture(
                    LongPressGesture(minimumDuration: 0.4)
                        .updating($isPressing) { current, state, _ in
                            state = current
                        }
                )
            Text("isPressing = \(isPressing ? "true" : "false")").font(.caption).monospacedDigit()
            C19_Caption("Hold for 0.4 s. The @GestureState resets to false by itself the moment the press ends.")
        }
    }
}

private struct C19_GestureSequencedExample: View {
    @State private var dropPoint = CGPoint(x: 40, y: 45)

    var body: some View {
        VStack(spacing: 12) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 8).fill(.quaternary)
                Circle()
                    .fill(.pink.gradient)
                    .frame(width: 28, height: 28)
                    .position(dropPoint)
            }
            .frame(width: 240, height: 90)
            .contentShape(Rectangle())
            .gesture(
                LongPressGesture()
                    .sequenced(before: DragGesture())
                    .onEnded { value in
                        if case .second(true, let drag?) = value { dropPoint = drag.location }
                    }
            )
            Text(String(format: "dropped at (%.0f, %.0f)", dropPoint.x, dropPoint.y))
                .font(.caption).monospacedDigit()
            C19_Caption("Press and hold, then drag and release: the drag only begins once the long press succeeds.")
        }
    }
}

// MARK: - InsettableShape

private nonisolated struct C19_RingShape: InsettableShape {
    var insetAmount: CGFloat = 0

    func path(in rect: CGRect) -> Path {
        Path(ellipseIn: rect.insetBy(dx: insetAmount, dy: insetAmount))
    }

    func inset(by amount: CGFloat) -> some InsettableShape {
        var ring = self
        ring.insetAmount += amount
        return ring
    }
}

private struct C19_InsetByExample: View {
    @State private var amount: CGFloat = 12

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                C19_RingShape()
                    .stroke(.secondary, style: StrokeStyle(lineWidth: 1, dash: [4, 3]))
                C19_RingShape()
                    .inset(by: amount)
                    .fill(.teal.opacity(0.6))
            }
            .frame(width: 130, height: 90)
            Slider(value: $amount, in: 0...40) { Text("inset") }
                .frame(width: 220)
            Text(String(format: "inset(by: %.0f) — dashed line is the un-inset shape", amount))
                .font(.caption).monospacedDigit()
        }
    }
}

private struct C19_StrokeBorderLineWidthExample: View {
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 40) {
                VStack(spacing: 6) {
                    Circle()
                        .strokeBorder(.tint, lineWidth: 8, antialiased: true)
                        .frame(width: 56, height: 56)
                        .border(.secondary)
                    Text("strokeBorder").font(.caption)
                }
                VStack(spacing: 6) {
                    Circle()
                        .stroke(.tint, lineWidth: 8)
                        .frame(width: 56, height: 56)
                        .border(.secondary)
                    Text("stroke").font(.caption)
                }
            }
            C19_Caption("The grey square is the 56 pt frame: strokeBorder keeps the whole line inside it; stroke spills 4 pt past.")
        }
    }
}

private struct C19_StrokeBorderStyleExample: View {
    @State private var dash: CGFloat = 6

    var body: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(.secondary,
                              style: StrokeStyle(lineWidth: 2, lineCap: .round, dash: [dash, 4]),
                              antialiased: true)
                .frame(width: 220, height: 70)
                .overlay(
                    Label("Drop files here", systemImage: "tray.and.arrow.down")
                        .foregroundStyle(.secondary)
                )
            Slider(value: $dash, in: 2...16) { Text("dash") }
                .frame(width: 220)
            Text(String(format: "dash: [%.0f, 4] — the dashes never leave the frame", dash))
                .font(.caption).monospacedDigit()
        }
    }
}

// MARK: - LabelStyle

private struct C19_TrailingIconStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon.foregroundStyle(.secondary)
        }
    }
}

private struct C19_LabelStyleMakeBodyExample: View {
    var body: some View {
        VStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                Label("Favorites", systemImage: "heart")
                Label("Downloads", systemImage: "arrow.down.circle")
            }
            .labelStyle(C19_TrailingIconStyle())
            .padding(10)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
            C19_Caption("makeBody receives the title and icon and returns any composition — here the icon trails the title.")
        }
    }
}

private struct C19_StackedLabelStyle: LabelStyle {
    func makeBody(configuration: LabelStyleConfiguration) -> some View {
        VStack(spacing: 2) {
            configuration.icon
                .symbolVariant(.fill)
                .font(.title2)
            configuration.title
                .font(.caption2)
        }
    }
}

private struct C19_LabelStyleConfigurationExample: View {
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 28) {
                Label("Library", systemImage: "books.vertical")
                Label("Search", systemImage: "magnifyingglass")
                Label("Account", systemImage: "person.crop.circle")
            }
            .labelStyle(C19_StackedLabelStyle())
            .padding(10)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
            C19_Caption("configuration.icon and configuration.title are separate views: each gets its own font and symbol variant.")
        }
    }
}

private struct C19_LabelStyleIconOnlyExample: View {
    var body: some View {
        VStack(spacing: 12) {
            Grid(alignment: .leading, horizontalSpacing: 16, verticalSpacing: 8) {
                GridRow {
                    Text(".iconOnly").font(.caption).foregroundStyle(.secondary)
                    Label("Favorites", systemImage: "heart").labelStyle(.iconOnly)
                }
                GridRow {
                    Text(".titleOnly").font(.caption).foregroundStyle(.secondary)
                    Label("Favorites", systemImage: "heart").labelStyle(.titleOnly)
                }
                GridRow {
                    Text(".titleAndIcon").font(.caption).foregroundStyle(.secondary)
                    Label("Favorites", systemImage: "heart").labelStyle(.titleAndIcon)
                }
                GridRow {
                    Text(".automatic").font(.caption).foregroundStyle(.secondary)
                    Label("Favorites", systemImage: "heart").labelStyle(.automatic)
                }
            }
            C19_Caption("Built-in styles picked by static member; automatic lets the surrounding context decide.")
        }
    }
}

// MARK: - Layout

private nonisolated struct C19_FlowLayout: Layout {
    struct Cache {
        var rows: [[Int]] = []
        var size: CGSize = .zero
        var width: CGFloat = -1
    }

    var spacing: CGFloat = 6

    func makeCache(subviews: Subviews) -> Cache { Cache() }

    func updateCache(_ cache: inout Cache, subviews: Subviews) {
        cache = Cache()
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) -> CGSize {
        arrange(in: proposal.width ?? .infinity, subviews: subviews, cache: &cache)
        return cache.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) {
        arrange(in: bounds.width, subviews: subviews, cache: &cache)
        var y = bounds.minY
        for row in cache.rows {
            var x = bounds.minX
            var rowHeight: CGFloat = 0
            for index in row {
                let size = subviews[index].sizeThatFits(.unspecified)
                subviews[index].place(at: CGPoint(x: x, y: y), proposal: .unspecified)
                x += size.width + spacing
                rowHeight = max(rowHeight, size.height)
            }
            y += rowHeight + spacing
        }
    }

    private func arrange(in width: CGFloat, subviews: Subviews, cache: inout Cache) {
        guard cache.width != width else { return }
        var rows: [[Int]] = [[]]
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0
        var maxX: CGFloat = 0
        for (index, subview) in subviews.enumerated() {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > width, !rows[rows.count - 1].isEmpty {
                y += rowHeight + spacing
                x = 0
                rowHeight = 0
                rows.append([])
            }
            rows[rows.count - 1].append(index)
            x += size.width + spacing
            maxX = max(maxX, x - spacing)
            rowHeight = max(rowHeight, size.height)
        }
        cache.rows = rows
        cache.size = CGSize(width: maxX, height: y + rowHeight)
        cache.width = width
    }
}

private struct C19_LayoutMakeCacheExample: View {
    @State private var tags = ["SwiftUI", "Layout", "Cache", "Subviews", "Flow"]

    var body: some View {
        VStack(spacing: 12) {
            C19_FlowLayout(spacing: 6) {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(.horizontal, 8).padding(.vertical, 4)
                        .background(Color.accentColor.opacity(0.15), in: Capsule())
                }
            }
            .frame(width: 240, alignment: .leading)
            HStack {
                Button("Add Tag") { tags.append("Tag \(tags.count + 1)") }
                Button("Reset") { tags = Array(tags.prefix(5)) }
            }
            C19_Caption("Rows are computed once into the cache per width; adding a tag triggers updateCache and a fresh arrangement.")
        }
    }
}

private nonisolated struct C19_StripLayout: Layout {
    var tight: Bool

    func spacing(subviews: Subviews, cache: inout ()) -> ViewSpacing {
        if tight { return .zero }
        var spacing = ViewSpacing()
        for view in subviews { spacing.formUnion(view.spacing, edges: .all) }
        return spacing
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let width = sizes.map(\.width).reduce(0, +) + CGFloat(max(subviews.count - 1, 0)) * 4
        return CGSize(width: width, height: sizes.map(\.height).max() ?? 0)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            subview.place(at: CGPoint(x: x, y: bounds.midY), anchor: .leading, proposal: .unspecified)
            x += size.width + 4
        }
    }
}

private struct C19_LayoutSpacingExample: View {
    @State private var tight = false

    private var chips: some View {
        ForEach(["A", "B", "C"], id: \.self) { name in
            Text(name)
                .font(.caption)
                .frame(width: 28, height: 22)
                .background(Color.accentColor.opacity(0.2), in: RoundedRectangle(cornerRadius: 5))
        }
    }

    var body: some View {
        VStack(spacing: 12) {
            VStack {
                C19_StripLayout(tight: tight) { chips }
                C19_StripLayout(tight: tight) { chips }
                C19_StripLayout(tight: tight) { chips }
            }
            .padding(6)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
            Toggle("spacing(subviews:cache:) returns .zero", isOn: $tight)
                .toggleStyle(.switch)
                .font(.caption)
            C19_Caption("The VStack has no explicit spacing, so the gap between the strips comes from the layout's spacing method.")
        }
    }
}

private nonisolated struct C19_ColumnLayout: Layout {
    var alignsToFirstRow: Bool
    var spacing: CGFloat = 4

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let height = sizes.map(\.height).reduce(0, +) + spacing * CGFloat(max(subviews.count - 1, 0))
        return CGSize(width: sizes.map(\.width).max() ?? 0, height: height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var y = bounds.minY
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            subview.place(at: CGPoint(x: bounds.minX, y: y), proposal: .unspecified)
            y += size.height + spacing
        }
    }

    func explicitAlignment(of guide: VerticalAlignment, in bounds: CGRect, proposal: ProposedViewSize,
                           subviews: Subviews, cache: inout ()) -> CGFloat? {
        guard alignsToFirstRow, guide == .firstTextBaseline, let first = subviews.first else { return nil }
        return bounds.minY + first.dimensions(in: .unspecified)[.firstTextBaseline]
    }
}

private struct C19_LayoutExplicitAlignmentExample: View {
    @State private var overrides = true

    var body: some View {
        VStack(spacing: 12) {
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Text("Title:").bold()
                C19_ColumnLayout(alignsToFirstRow: overrides) {
                    Text("Sunrise").font(.title2)
                    Text("6:41 AM").foregroundStyle(.secondary)
                }
                .border(.quaternary)
            }
            .padding(8)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
            Toggle("Override .firstTextBaseline", isOn: $overrides)
                .toggleStyle(.switch)
                .font(.caption)
            C19_Caption("On: the label sits on Sunrise's baseline. Off (nil): SwiftUI uses the container's default edge instead.")
        }
    }
}

private nonisolated struct C19_VerticalFlowLayout: Layout {
    static var layoutProperties: LayoutProperties {
        var properties = LayoutProperties()
        properties.stackOrientation = .vertical
        return properties
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        return CGSize(width: sizes.map(\.width).max() ?? 0,
                      height: proposal.height ?? sizes.map(\.height).reduce(0, +))
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let ideal = subviews.map { $0.sizeThatFits(.unspecified) }
        let flexible = subviews.indices.filter { subviews[$0].sizeThatFits(.infinity).height > bounds.height }
        let fixedHeight = subviews.indices.filter { !flexible.contains($0) }.map { ideal[$0].height }.reduce(0, +)
        let share = flexible.isEmpty ? 0 : max(0, bounds.height - fixedHeight) / CGFloat(flexible.count)
        var y = bounds.minY
        for index in subviews.indices {
            let height = flexible.contains(index) ? share : ideal[index].height
            subviews[index].place(at: CGPoint(x: bounds.midX, y: y), anchor: .top,
                                  proposal: ProposedViewSize(width: bounds.width, height: height))
            y += height
        }
    }
}

private struct C19_LayoutPropertiesExample: View {
    var body: some View {
        VStack(spacing: 12) {
            C19_VerticalFlowLayout {
                Text("Header").bold()
                Spacer()
                Text("Footer").foregroundStyle(.secondary)
            }
            .frame(width: 200, height: 110)
            .padding(8)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
            C19_Caption("layoutProperties.stackOrientation = .vertical tells the Spacer which axis to grow along inside this container.")
        }
    }
}

// MARK: - NSViewRepresentable

private struct C19_PlainTextView: NSViewRepresentable {
    @Binding var text: String

    func makeCoordinator() -> Coordinator { Coordinator(text: $text) }

    func makeNSView(context: Context) -> NSTextView {
        let view = NSTextView()
        view.isRichText = false
        view.font = .systemFont(ofSize: 13)
        view.string = text
        view.delegate = context.coordinator
        return view
    }

    func updateNSView(_ view: NSTextView, context: Context) {
        if view.string != text { view.string = text }
    }

    final class Coordinator: NSObject, NSTextViewDelegate {
        var text: Binding<String>
        init(text: Binding<String>) { self.text = text }
        func textDidChange(_ note: Notification) {
            text.wrappedValue = (note.object as? NSTextView)?.string ?? ""
        }
    }
}

private struct C19_MakeCoordinatorExample: View {
    @State private var text = "Type here…"

    var body: some View {
        VStack(spacing: 10) {
            C19_PlainTextView(text: $text)
                .frame(height: 56)
                .border(.quaternary)
            Text("SwiftUI state: \(text.count) characters").font(.caption).monospacedDigit()
            C19_Caption("The coordinator is the NSTextViewDelegate; every edit flows back through the binding it holds.")
        }
    }
}

private struct C19_WrappingLabel: NSViewRepresentable {
    var text: String

    func makeNSView(context: Context) -> NSTextField {
        let field = NSTextField(wrappingLabelWithString: text)
        field.isSelectable = false
        return field
    }

    func updateNSView(_ field: NSTextField, context: Context) {
        field.stringValue = text
    }

    func sizeThatFits(_ proposal: ProposedViewSize, nsView: NSTextField, context: Context) -> CGSize? {
        let width = proposal.width ?? nsView.intrinsicContentSize.width
        nsView.preferredMaxLayoutWidth = width
        return CGSize(width: width, height: nsView.intrinsicContentSize.height)
    }
}

private struct C19_SizeThatFitsExample: View {
    @State private var width: CGFloat = 200
    private let sample = "sizeThatFits lets the wrapped AppKit label answer SwiftUI's proposal with the height its text needs at that width."

    var body: some View {
        VStack(spacing: 10) {
            C19_WrappingLabel(text: sample)
                .frame(width: width)
                .border(Color.accentColor)
            Slider(value: $width, in: 120...300) { Text("width") }
                .frame(width: 220)
            Text(String(format: "proposed width = %.0f — height follows the wrapped text", width))
                .font(.caption).monospacedDigit()
        }
    }
}

private struct C19_SpinnerView: NSViewRepresentable {
    var onDismantle: () -> Void

    func makeCoordinator() -> Coordinator { Coordinator(onDismantle: onDismantle) }

    func makeNSView(context: Context) -> NSProgressIndicator {
        let spinner = NSProgressIndicator()
        spinner.style = .spinning
        spinner.controlSize = .regular
        spinner.startAnimation(nil)
        return spinner
    }

    func updateNSView(_ spinner: NSProgressIndicator, context: Context) { }

    static func dismantleNSView(_ spinner: NSProgressIndicator, coordinator: Coordinator) {
        spinner.stopAnimation(nil)
        coordinator.onDismantle()
    }

    final class Coordinator {
        let onDismantle: () -> Void
        init(onDismantle: @escaping () -> Void) { self.onDismantle = onDismantle }
    }
}

private struct C19_DismantleExample: View {
    @State private var showsSpinner = true
    @State private var teardowns = 0

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 8).fill(.quaternary)
                if showsSpinner {
                    C19_SpinnerView {
                        Task { @MainActor in teardowns += 1 }
                    }
                    .frame(width: 32, height: 32)
                } else {
                    Text("Spinner removed").font(.caption).foregroundStyle(.secondary)
                }
            }
            .frame(width: 200, height: 60)
            Button(showsSpinner ? "Remove Spinner" : "Add Spinner") { showsSpinner.toggle() }
            Text("dismantleNSView called \(teardowns)×").font(.caption).monospacedDigit()
        }
    }
}

private struct C19_EffectBackdrop: NSViewRepresentable {
    func makeCoordinator() -> Coordinator { Coordinator() }

    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.blendingMode = .withinWindow
        view.state = .active
        return view
    }

    func updateNSView(_ view: NSVisualEffectView, context: Context) {
        view.material = context.environment.colorScheme == .dark ? .hudWindow : .sidebar
        context.coordinator.animated = context.transaction.animation != nil
    }

    final class Coordinator {
        var animated = false
    }
}

private struct C19_ContextExample: View {
    @State private var isDark = false

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                LinearGradient(colors: [.orange, .purple], startPoint: .leading, endPoint: .trailing)
                C19_EffectBackdrop()
                    .frame(width: 200, height: 56)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(
                        Text(isDark ? "colorScheme == .dark → .hudWindow" : "colorScheme == .light → .sidebar")
                            .font(.caption).monospacedDigit()
                    )
                    .environment(\.colorScheme, isDark ? .dark : .light)
            }
            .frame(width: 240, height: 80)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            Toggle("Dark environment", isOn: $isDark).toggleStyle(.switch).font(.caption)
            C19_Caption("updateNSView reads context.environment to pick the material; context.coordinator and context.transaction ride along.")
        }
    }
}

// MARK: - PreferenceKey

private nonisolated struct C19_HeightsKey: PreferenceKey {
    static let defaultValue: [CGFloat] = []
    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
}

private struct C19_PreferenceReduceExample: View {
    @State private var heights: [CGFloat] = []

    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 4) {
                ForEach([28, 44, 36] as [CGFloat], id: \.self) { height in
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.accentColor.opacity(0.25))
                        .frame(height: height)
                        .background(GeometryReader { proxy in
                            Color.clear.preference(key: C19_HeightsKey.self, value: [proxy.size.height])
                        })
                }
            }
            .frame(width: 200)
            .onPreferenceChange(C19_HeightsKey.self) { heights = $0 }
            Text("reduced value: [" + heights.map { String(format: "%.0f", $0) }.joined(separator: ", ") + "]")
                .font(.caption).monospacedDigit()
            C19_Caption("Each row publishes its own height; reduce appends instead of overwriting, so all three survive.")
        }
    }
}

private nonisolated struct C19_WidthKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

private struct C19_OnPreferenceChangeExample: View {
    @State private var columnWidth: CGFloat = 0
    private let rows = [("Name", "Aviary"), ("Framework", "SwiftUI"), ("Minimum OS", "macOS 26")]

    var body: some View {
        VStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 6) {
                ForEach(rows, id: \.0) { label, value in
                    HStack {
                        Text(label).bold()
                            .background(GeometryReader { proxy in
                                Color.clear.preference(key: C19_WidthKey.self, value: proxy.size.width)
                            })
                            .frame(width: columnWidth > 0 ? columnWidth : nil, alignment: .leading)
                        Text(value)
                    }
                }
            }
            .onPreferenceChange(C19_WidthKey.self) { width in
                columnWidth = width
            }
            Text(String(format: "columnWidth = %.0f", columnWidth)).font(.caption).monospacedDigit()
            C19_Caption("The widest label wins the reduce; onPreferenceChange copies it into state so every label gets that width.")
        }
    }
}

private nonisolated struct C19_SelectionKey: PreferenceKey {
    static var defaultValue: Anchor<CGRect>? { nil }
    static func reduce(value: inout Anchor<CGRect>?, nextValue: () -> Anchor<CGRect>?) {
        value = nextValue() ?? value
    }
}

private struct C19_AnchorPreferenceExample: View {
    @State private var selected = "Inbox"
    private let items = ["Inbox", "Drafts", "Sent", "Archive"]

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 12) {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .padding(.horizontal, 8).padding(.vertical, 4)
                        .contentShape(Rectangle())
                        .onTapGesture { selected = item }
                        .anchorPreference(key: C19_SelectionKey.self, value: .bounds) { anchor in
                            selected == item ? anchor : nil
                        }
                }
            }
            .backgroundPreferenceValue(C19_SelectionKey.self) { anchor in
                GeometryReader { proxy in
                    if let anchor {
                        let rect = proxy[anchor]
                        Text(String(format: "resolved bounds: x %.0f  width %.0f", rect.minX, rect.width))
                            .font(.caption2).monospacedDigit().foregroundStyle(.secondary)
                            .fixedSize()
                            .position(x: proxy.size.width / 2, y: proxy.size.height + 14)
                    }
                }
            }
            .padding(.bottom, 22)
            C19_Caption("Tap an item: it publishes an Anchor<CGRect>, which the ancestor resolves in its own space via proxy[anchor].")
        }
    }
}

private struct C19_OverlayPreferenceValueExample: View {
    @State private var selected = "Inbox"
    private let items = ["Inbox", "Drafts", "Sent", "Archive"]

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 12) {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .padding(.horizontal, 10).padding(.vertical, 6)
                        .contentShape(Rectangle())
                        .onTapGesture { withAnimation(.snappy) { selected = item } }
                        .anchorPreference(key: C19_SelectionKey.self, value: .bounds) { anchor in
                            selected == item ? anchor : nil
                        }
                }
            }
            .overlayPreferenceValue(C19_SelectionKey.self) { anchor in
                GeometryReader { proxy in
                    if let anchor {
                        let rect = proxy[anchor]
                        RoundedRectangle(cornerRadius: 8).stroke(.tint, lineWidth: 2)
                            .frame(width: rect.width, height: rect.height)
                            .offset(x: rect.minX, y: rect.minY)
                    }
                }
            }
            C19_Caption("Tap an item: the overlay is rebuilt from the reduced preference, so the highlight follows the selected child's bounds.")
        }
    }
}

// MARK: - PrimitiveButtonStyle

private struct C19_DoubleTapStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 12).padding(.vertical, 6)
            .background(.quaternary, in: Capsule())
            .contentShape(.rect)
            .onTapGesture(count: 2) { configuration.trigger() }
    }
}

private struct C19_PrimitiveMakeBodyExample: View {
    @State private var count = 0

    var body: some View {
        VStack(spacing: 12) {
            Button("Double-click me") { count += 1 }
                .buttonStyle(C19_DoubleTapStyle())
            Text("Action ran \(count)×").font(.caption).monospacedDigit()
            C19_Caption("A primitive style owns the interaction: a single click does nothing, only the double-tap gesture triggers the action.")
        }
    }
}

private struct C19_LongPressStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 12).padding(.vertical, 6)
            .background(Color.accentColor.opacity(0.15), in: Capsule())
            .onLongPressGesture(minimumDuration: 1) {
                configuration.trigger()
            }
    }
}

private struct C19_PrimitiveTriggerExample: View {
    @State private var count = 0

    var body: some View {
        VStack(spacing: 12) {
            Button("Hold 1 s to Confirm") { count += 1 }
                .buttonStyle(C19_LongPressStyle())
            Text("trigger() called \(count)×").font(.caption).monospacedDigit()
            C19_Caption("The button's action runs only when the style calls configuration.trigger(), here after a one-second press.")
        }
    }
}

private struct C19_RoleTintedStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(configuration)
            .buttonStyle(.bordered)
            .tint(configuration.role == .destructive ? .red : .accentColor)
    }
}

private struct C19_PrimitiveButtonConfigurationExample: View {
    @State private var last = "—"

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                Button("Delete", role: .destructive) { last = "Delete (role: .destructive)" }
                Button("Save") { last = "Save (role: nil)" }
            }
            .buttonStyle(C19_RoleTintedStyle())
            Text("Last: \(last)").font(.caption).monospacedDigit()
            C19_Caption("Button(configuration) rebuilds a standard button, so clicks and keyboard activation keep working; the style only adds a tint.")
        }
    }
}

// MARK: - ProgressViewStyle

private struct C19_LabeledBarStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                configuration.label
                Spacer()
                if let fraction = configuration.fractionCompleted {
                    Text(String(format: "%.0f%%", fraction * 100)).font(.caption).monospacedDigit()
                }
            }
            ProgressView(configuration).tint(.green)
        }
    }
}

private struct C19_ProgressViewStyleExample: View {
    @State private var progress = 0.45

    var body: some View {
        VStack(spacing: 12) {
            ProgressView("Uploading", value: progress)
                .progressViewStyle(C19_LabeledBarStyle())
                .frame(width: 220)
            Slider(value: $progress, in: 0...1) { Text("progress") }
                .frame(width: 220)
            C19_Caption("The style wraps the default bar via ProgressView(configuration) inside its own label and percentage chrome.")
        }
    }
}
