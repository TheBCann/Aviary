//
//  ChildExamples+Part20.swift
//  Aviary
//
//  Compiled renderings for variant entries (part 20: protocols).
//  One private C20_* struct per variant; every rendering exercises the exact
//  requirement, member, or overload the variant names.
//

import SwiftUI
import AppKit
import CoreTransferable
import UniformTypeIdentifiers

enum ChildExamplesPart20 {
    static let entries: [ChildExampleEntry] = [

        // MARK: ProgressViewStyle

        ChildExampleEntry(parent: "ProgressViewStyle", child: "ProgressViewStyleConfiguration", code: """
        struct PercentStyle: ProgressViewStyle {
            func makeBody(configuration: Configuration) -> some View {
                HStack {
                    configuration.label
                    configuration.currentValueLabel
                    if let fraction = configuration.fractionCompleted {
                        Text(fraction, format: .percent.precision(.fractionLength(0)))
                    } else {
                        ProgressView()   // indeterminate: no fraction to show
                    }
                }
            }
        }
        """) { AnyView(C20_ProgressConfigurationExample()) },

        ChildExampleEntry(parent: "ProgressViewStyle", child: "ProgressViewStyle.circular", code: """
        ProgressView("Downloading", value: bytes, total: expected)
            .progressViewStyle(.linear)

        ProgressView()
            .progressViewStyle(.circular)
            .controlSize(.small)
        """) { AnyView(C20_ProgressSystemStylesExample()) },

        // MARK: Scene

        ChildExampleEntry(parent: "Scene", child: "body", code: """
        struct EditorScenes: Scene {
            var body: some Scene {
                WindowGroup("Editor", id: "editor") { EditorView() }
                Window("Palette", id: "palette") { PaletteView() }
            }
        }
        """) { AnyView(C20_SceneBodyExample()) },

        ChildExampleEntry(parent: "Scene", child: "commands(content:)", code: """
        WindowGroup { ContentView() }
            .commands {
                SortCommands()
                CommandGroup(replacing: .help) { }   // drop the Help menu entirely
            }
        """) { AnyView(C20_SceneCommandsExample()) },

        ChildExampleEntry(parent: "Scene", child: "defaultSize(width:height:)", code: """
        Window("Inspector", id: "inspector") { InspectorView() }
            .defaultSize(width: 320, height: 480)
            .defaultPosition(.trailing)
        """) { AnyView(C20_SceneDefaultSizeExample()) },

        ChildExampleEntry(parent: "Scene", child: "windowResizability(_:)", code: """
        Settings { SettingsView() }
            .windowResizability(.contentSize)   // window hugs the content's ideal size
        """) { AnyView(C20_SceneResizabilityExample()) },

        // MARK: ScrollTargetBehavior

        ChildExampleEntry(parent: "ScrollTargetBehavior", child: "updateTarget(_:context:)", code: """
        struct Paging: ScrollTargetBehavior {
            func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
                let width = context.containerSize.width
                let page = context.originalTarget.rect.minX / width
                let next = context.velocity.dx > 0 ? page.rounded(.up) : page.rounded(.down)
                target.rect.origin.x = next * width
            }
        }

        ScrollView(.horizontal) { LazyHStack(spacing: 0) { pages } }
            .scrollTargetBehavior(Paging())
        """) { AnyView(C20_UpdateTargetExample()) },

        ChildExampleEntry(parent: "ScrollTargetBehavior", child: "ScrollTarget", code: """
        func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
            target.rect.origin.y = max(0, target.rect.origin.y - 24)
            target.anchor = .top
        }
        """) { AnyView(C20_ScrollTargetExample()) },

        ChildExampleEntry(parent: "ScrollTargetBehavior", child: "ScrollTargetBehaviorContext", code: """
        func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
            guard context.axes.contains(.horizontal) else { return }
            let maxX = context.contentSize.width - context.containerSize.width
            if abs(context.velocity.dx) > 800 {          // a hard fling jumps to either end
                target.rect.origin.x = context.velocity.dx > 0 ? maxX : 0
            }
            target.rect.origin.x = min(maxX, target.rect.origin.x)
        }
        """) { AnyView(C20_BehaviorContextExample()) },

        ChildExampleEntry(parent: "ScrollTargetBehavior", child: ".viewAligned(limitBehavior:)", code: """
        ScrollView(.horizontal) {
            LazyHStack { cards }
                .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned(limitBehavior: .alwaysByOne))
        """) { AnyView(C20_ViewAlignedLimitExample()) },

        // MARK: Shape

        ChildExampleEntry(parent: "Shape", child: "path(in:)", code: """
        struct Arrow: Shape {
            func path(in rect: CGRect) -> Path {
                var p = Path()
                p.move(to: CGPoint(x: rect.minX, y: rect.midY))
                p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
                p.move(to: CGPoint(x: rect.maxX - 12, y: rect.midY - 8))
                p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
                p.addLine(to: CGPoint(x: rect.maxX - 12, y: rect.midY + 8))
                return p
            }
        }

        Arrow().stroke(.tint, lineWidth: 3)
        """) { AnyView(C20_ShapePathExample()) },

        ChildExampleEntry(parent: "Shape", child: "sizeThatFits(_:)", code: """
        struct Dot: Shape {
            func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
                CGSize(width: 12, height: 12)   // always a 12pt dot, whatever is proposed
            }
            func path(in rect: CGRect) -> Path { Path(ellipseIn: rect) }
        }

        HStack { Dot().fill(.green); Text("Online") }      // Dot stays 12×12
        HStack { Circle().fill(.green); Text("Online") }   // Circle grows to the row height
        """) { AnyView(C20_ShapeSizeThatFitsExample()) },

        ChildExampleEntry(parent: "Shape", child: "fill(_:style:)", code: """
        Star()   // a self-intersecting pentagram
            .fill(.orange.gradient, style: FillStyle(eoFill: true))

        Star()
            .fill(.orange.gradient, style: FillStyle(eoFill: false))
        """) { AnyView(C20_ShapeFillStyleExample()) },

        ChildExampleEntry(parent: "Shape", child: "intersection(_:eoFill:)", code: """
        Circle()
            .intersection(Rectangle().offset(x: 20), eoFill: false)
            .fill(.blue)

        Circle().union(Rectangle().offset(x: 20)).fill(.green)
        Circle().subtracting(Rectangle().offset(x: 20)).fill(.orange)
        """) { AnyView(C20_ShapeIntersectionExample()) },

        // MARK: ShapeStyle

        ChildExampleEntry(parent: "ShapeStyle", child: "resolve(in:)", code: """
        struct Accent: ShapeStyle {
            func resolve(in environment: EnvironmentValues) -> Color.Resolved {
                let base: Color = environment.colorScheme == .dark ? .cyan : .blue
                return base.resolve(in: environment)
            }
        }

        RoundedRectangle(cornerRadius: 8).fill(Accent())
            .environment(\\.colorScheme, .light)
        RoundedRectangle(cornerRadius: 8).fill(Accent())
            .environment(\\.colorScheme, .dark)
        """) { AnyView(C20_ShapeStyleResolveExample()) },

        ChildExampleEntry(parent: "ShapeStyle", child: "opacity(_:)", code: """
        Rectangle()
            .fill(.tint.opacity(0.3))
            .overlay(Text("Draft").foregroundStyle(.primary.opacity(0.6)))

        Rectangle().fill(.blue.gradient.opacity(0.3))   // gradients fade the same way
        """) { AnyView(C20_ShapeStyleOpacityExample()) },

        ChildExampleEntry(parent: "ShapeStyle", child: "shadow(_:)", code: """
        Text("Embossed")
            .font(.largeTitle.bold())
            .foregroundStyle(.white.shadow(.inner(color: .black.opacity(0.5), radius: 2, y: 1)))

        Text("Lifted")
            .font(.largeTitle.bold())
            .foregroundStyle(.white.shadow(.drop(color: .black.opacity(0.5), radius: 3, y: 2)))
        """) { AnyView(C20_ShapeStyleShadowExample()) },

        ChildExampleEntry(parent: "ShapeStyle", child: "image(_:sourceRect:scale:)", code: """
        let tile = Image(size: CGSize(width: 16, height: 16)) { ctx in … }   // a 2×2 checker

        RoundedRectangle(cornerRadius: 16)
            .fill(.image(tile, sourceRect: CGRect(x: 0, y: 0, width: 1, height: 1), scale: 0.5))

        RoundedRectangle(cornerRadius: 16)   // left half of the tile only, at full scale
            .fill(.image(tile, sourceRect: CGRect(x: 0, y: 0, width: 0.5, height: 1), scale: 1))
        """) { AnyView(C20_ShapeStyleImagePaintExample()) },

        // MARK: TextRenderer

        ChildExampleEntry(parent: "TextRenderer", child: "draw(layout:in:)", code: """
        struct Reveal: TextRenderer {
            var progress: Double
            var animatableData: Double { get { progress } set { progress = newValue } }

            func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
                let slices = layout.flatMap { $0 }.flatMap { $0 }   // lines → runs → slices
                let visibleCount = Int((Double(slices.count) * progress).rounded())
                for (index, slice) in slices.enumerated() {
                    var copy = ctx
                    copy.opacity = index < visibleCount ? 1 : 0
                    copy.draw(slice)
                }
            }
        }
        """) { AnyView(C20_TextRendererDrawExample()) },

        ChildExampleEntry(parent: "TextRenderer", child: "sizeThatFits(proposal:layout:)", code: """
        struct Tall: TextRenderer {
            func sizeThatFits(proposal: ProposedViewSize, layout: Text.Layout) -> CGSize {
                var size = layout.reduce(CGRect.null) { $0.union($1.typographicBounds.rect) }.size
                size.height += 16   // room for glyphs that bounce above the line
                return size
            }
            func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
                for line in layout { ctx.draw(line) }
            }
        }
        """) { AnyView(C20_TextRendererSizeExample()) },

        ChildExampleEntry(parent: "TextRenderer", child: "displayPadding", code: """
        struct Glow: TextRenderer {
            var padding: CGFloat
            var displayPadding: EdgeInsets {
                EdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
            }
            func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
                ctx.addFilter(.shadow(color: .yellow, radius: 6))
                for line in layout { ctx.draw(line) }
            }
        }

        Text("Glow").textRenderer(Glow(padding: 8))   // glow survives
        Text("Glow").textRenderer(Glow(padding: 0))   // glow is clipped
        """) { AnyView(C20_TextRendererPaddingExample()) },

        ChildExampleEntry(parent: "TextRenderer", child: ".textRenderer(_:)", code: """
        Text("Hello, world")
            .font(.largeTitle)
            .textRenderer(Jitter())

        struct Jitter: TextRenderer {
            func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
                for (index, slice) in layout.flatMap { $0 }.flatMap { $0 }.enumerated() {
                    var copy = ctx
                    copy.translateBy(x: 0, y: CGFloat(index % 3) * 3 - 3)
                    copy.draw(slice)
                }
            }
        }
        """) { AnyView(C20_TextRendererModifierExample()) },
        // MARK: ToggleStyle

        ChildExampleEntry(parent: "ToggleStyle", child: "makeBody(configuration:)", code: """
        struct CheckRow: ToggleStyle {
            func makeBody(configuration: Configuration) -> some View {
                HStack {
                    configuration.label
                    Spacer()
                    Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                }
                .contentShape(.rect)
                .onTapGesture { configuration.isOn.toggle() }
            }
        }

        Toggle("Wi-Fi", isOn: $wifi).toggleStyle(CheckRow())
        """) { AnyView(C20_ToggleMakeBodyExample()) },

        ChildExampleEntry(parent: "ToggleStyle", child: "ToggleStyleConfiguration.isMixed", code: """
        func makeBody(configuration: Configuration) -> some View {
            let symbol = configuration.isMixed ? "minus.square"
                       : configuration.isOn ? "checkmark.square" : "square"
            Button { configuration.isOn.toggle() } label: {
                Label { configuration.label } icon: { Image(systemName: symbol) }
            }
        }

        Toggle("Select all", sources: $items, isOn: \\.isOn)   // mixed while items disagree
        """) { AnyView(C20_ToggleIsMixedExample()) },

        ChildExampleEntry(parent: "ToggleStyle", child: "ToggleStyle.button", code: """
        Toggle("Bold", systemImage: "bold", isOn: $isBold)
            .toggleStyle(.button)

        Toggle("Wi-Fi", isOn: $wifiEnabled)
            .toggleStyle(.switch)

        Toggle("Remember me", isOn: $remember)
            .toggleStyle(.checkbox)          // macOS only
        """) { AnyView(C20_ToggleSystemStylesExample()) },

        // MARK: ToolbarContent

        ChildExampleEntry(parent: "ToolbarContent", child: "body", code: """
        struct ShareItems: ToolbarContent {
            var note: Note
            var body: some ToolbarContent {
                ToolbarItemGroup(placement: .primaryAction) {
                    ShareLink(item: note.url)
                    Button("Star", systemImage: "star") { star(note) }
                }
            }
        }
        """) { AnyView(C20_ToolbarBodyExample()) },

        ChildExampleEntry(parent: "ToolbarContent", child: "ToolbarItem(placement:content:)", code: """
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel", role: .cancel) { dismiss() }
        }
        ToolbarItem(placement: .confirmationAction) {
            Button("Save") { save() }
        }
        """) { AnyView(C20_ToolbarItemExample()) },

        ChildExampleEntry(parent: "ToolbarContent", child: "ToolbarItemGroup(placement:content:)", code: """
        ToolbarItemGroup(placement: .secondaryAction) {
            Button("Duplicate", systemImage: "plus.square.on.square") { duplicate() }
            Button("Archive", systemImage: "archivebox") { archive() }
        }
        """) { AnyView(C20_ToolbarItemGroupExample()) },

        ChildExampleEntry(parent: "ToolbarContent", child: "ToolbarSpacer(_:)", code: """
        ToolbarItem { Button("Edit", systemImage: "pencil") { edit() } }
        ToolbarSpacer(.fixed)
        ToolbarItem {
            Button("Delete", systemImage: "trash", role: .destructive) { delete() }
        }
        """) { AnyView(C20_ToolbarSpacerExample()) },

        // MARK: Transferable

        ChildExampleEntry(parent: "Transferable", child: "transferRepresentation", code: """
        struct Note: Codable, Transferable {
            var title: String
            static var transferRepresentation: some TransferRepresentation {
                CodableRepresentation(contentType: .json)          // full fidelity for our own app
                ProxyRepresentation(exporting: { $0.title })       // plain text for everyone else
            }
        }

        Text(note.title).draggable(note)
        dropZone.dropDestination(for: Note.self) { notes, _ in received = notes.first; return true }
        """) { AnyView(C20_TransferRepresentationExample()) },

        ChildExampleEntry(parent: "Transferable", child: "DataRepresentation(contentType:exporting:importing:)", code: """
        struct Sequence: Transferable {
            var letters: String
            static var transferRepresentation: some TransferRepresentation {
                DataRepresentation(contentType: .utf8PlainText) { sequence in
                    Data(sequence.letters.utf8)
                } importing: { data in
                    Sequence(letters: String(decoding: data, as: UTF8.self))
                }
            }
        }

        let data = try await sequence.exported(as: .utf8PlainText)          // runs `exporting`
        let copy = try await Sequence(importing: data, contentType: .utf8PlainText)   // runs `importing`
        """) { AnyView(C20_DataRepresentationExample()) },

        ChildExampleEntry(parent: "Transferable", child: "FileRepresentation(contentType:exporting:importing:)", code: """
        struct Clip: Transferable {
            var url: URL
            static var transferRepresentation: some TransferRepresentation {
                FileRepresentation(contentType: .mpeg4Movie) { clip in
                    SentTransferredFile(clip.url)
                } importing: { received in
                    Clip(url: received.file)   // copy it somewhere permanent before returning
                }
            }
        }
        """) { AnyView(C20_FileRepresentationExample()) },

        ChildExampleEntry(parent: "Transferable", child: "ProxyRepresentation(exporting:importing:)", code: """
        struct Tag: Transferable {
            var name: String
            static var transferRepresentation: some TransferRepresentation {
                ProxyRepresentation(exporting: { tag in tag.name },
                                    importing: { name in Tag(name: name) })
            }
        }

        chip.draggable(tag)                                   // lands as a String anywhere
        dropZone.dropDestination(for: String.self) { strings, _ in received = strings.first; return true }
        """) { AnyView(C20_ProxyRepresentationExample()) },
        // MARK: Transition

        ChildExampleEntry(parent: "Transition", child: "TransitionPhase", code: """
        struct Rise: Transition {
            func body(content: Content, phase: TransitionPhase) -> some View {
                content
                    .offset(y: phase.value * 40)      // -1 entering, 0 shown, +1 leaving
                    .blur(radius: phase.isIdentity ? 0 : 6)
            }
        }

        if isShown { banner.transition(Rise()) }
        """) { AnyView(C20_TransitionPhaseExample()) },

        ChildExampleEntry(parent: "Transition", child: "static properties", code: """
        struct Twirl: Transition {
            static var properties: TransitionProperties {
                TransitionProperties(hasMotion: true)
            }
            func body(content: Content, phase: TransitionPhase) -> some View {
                content
                    .rotationEffect(.degrees(phase.isIdentity ? 0 : 180))
                    .scaleEffect(phase.isIdentity ? 1 : 0.3)
            }
        }
        """) { AnyView(C20_TransitionPropertiesExample()) },

        ChildExampleEntry(parent: "Transition", child: "combined(with:)", code: """
        Text("Saved")
            .transition(Twirl().combined(with: .opacity))

        Text("Saved")
            .transition(Twirl())              // alone: spins and shrinks, never fades
        """) { AnyView(C20_TransitionCombinedExample()) },

        ChildExampleEntry(parent: "Transition", child: "animation(_:)", code: """
        Button("Toggle") { isShown.toggle() }   // no withAnimation anywhere

        if isShown {
            Text("Saved")
                .transition(.push(from: .bottom).animation(.bouncy))   // animates anyway
            Text("Saved")
                .transition(.push(from: .bottom))                      // snaps
        }
        """) { AnyView(C20_TransitionAnimationExample()) },

        // MARK: UIViewRepresentable

        ChildExampleEntry(parent: "UIViewRepresentable", child: "makeCoordinator()", code: """
        func makeCoordinator() -> Coordinator { Coordinator(onSearch: onSearch) }

        final class Coordinator: NSObject, UISearchBarDelegate {
            let onSearch: (String) -> Void
            init(onSearch: @escaping (String) -> Void) { self.onSearch = onSearch }
            func searchBarSearchButtonClicked(_ bar: UISearchBar) { onSearch(bar.text ?? "") }
        }
        """) { AnyView(C20_MakeCoordinatorExample()) },

        ChildExampleEntry(parent: "UIViewRepresentable", child: "sizeThatFits(_:uiView:context:)", code: """
        func sizeThatFits(_ proposal: ProposedViewSize,
                          uiView: UILabel, context: Context) -> CGSize? {
            let width = proposal.width ?? UIView.layoutFittingExpandedSize.width
            return uiView.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
        }
        """) { AnyView(C20_SizeThatFitsRepresentableExample()) },

        ChildExampleEntry(parent: "UIViewRepresentable", child: "dismantleUIView(_:coordinator:)", code: """
        static func dismantleUIView(_ view: PlayerView, coordinator: Coordinator) {
            view.player?.pause()
            coordinator.stopObserving()
        }
        """) { AnyView(C20_DismantleExample()) },

        ChildExampleEntry(parent: "UIViewRepresentable", child: "Context", code: """
        func updateUIView(_ view: UISwitch, context: Context) {
            view.isEnabled = context.environment.isEnabled
            view.setOn(isOn, animated: context.transaction.animation != nil)
            context.coordinator.binding = $isOn
        }
        """) { AnyView(C20_RepresentableContextExample()) },

        // MARK: ViewModifier

        ChildExampleEntry(parent: "ViewModifier", child: "body(content:)", code: """
        struct Pulse: ViewModifier {
            @State private var scale: CGFloat = 1
            func body(content: Content) -> some View {
                content
                    .scaleEffect(scale)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.8).repeatForever()) { scale = 1.1 }
                    }
            }
        }

        Label("Recording", systemImage: "record.circle").modifier(Pulse())
        """) { AnyView(C20_ModifierBodyExample()) },

        ChildExampleEntry(parent: "ViewModifier", child: "View.modifier(_:)", code: """
        Text("Hello")
            .modifier(CardStyle())

        extension View {
            func cardStyle() -> some View { modifier(CardStyle()) }
        }
        Text("Hello").cardStyle()   // same thing, fluent
        """) { AnyView(C20_ViewModifierCallExample()) },

        ChildExampleEntry(parent: "ViewModifier", child: "concat(_:)", code: """
        let cardAndPulse = CardStyle().concat(Pulse())   // ModifiedContent<CardStyle, Pulse>

        Text("Hello").modifier(cardAndPulse)
        """) { AnyView(C20_ModifierConcatExample()) },
    ]
}

// MARK: - Shared mock chrome

private struct C20_MockWindow<Content: View>: View {
    var title: String
    var width: CGFloat
    var height: CGFloat
    var showsResizeHandle = true
    @ViewBuilder var content: Content

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 6) {
                ForEach([Color.red, .yellow, .green], id: \.self) { color in
                    Circle().fill(color).frame(width: 8, height: 8)
                }
                Spacer()
                Text(title).font(.caption2.weight(.medium)).foregroundStyle(.secondary)
                Spacer()
                Color.clear.frame(width: 36, height: 8)
            }
            .padding(.horizontal, 8)
            .frame(height: 22)
            .background(.quaternary)
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(width: width, height: height)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.secondary.opacity(0.4)))
        .overlay(alignment: .bottomTrailing) {
            if showsResizeHandle {
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                    .font(.system(size: 7))
                    .foregroundStyle(.tertiary)
                    .padding(3)
            }
        }
    }
}

private struct C20_Caption: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.caption2)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
    }
}

// MARK: - ProgressViewStyle

private struct C20_PercentStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            configuration.currentValueLabel
            if let fraction = configuration.fractionCompleted {
                Text(fraction, format: .percent.precision(.fractionLength(0)))
                    .monospacedDigit()
            } else {
                ProgressView()
                    .controlSize(.small)
            }
        }
    }
}

private struct C20_ProgressConfigurationExample: View {
    @State private var progress = 0.42

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            ProgressView(value: progress) {
                Text("Upload")
            } currentValueLabel: {
                Text("\(Int(progress * 4)) of 4 files")
                    .foregroundStyle(.secondary)
            }
            .progressViewStyle(C20_PercentStyle())

            ProgressView("Indexing")
                .progressViewStyle(C20_PercentStyle())

            Slider(value: $progress, in: 0...1) { Text("fractionCompleted") }
            C20_Caption(text: "Top: fractionCompleted, label and currentValueLabel. Bottom: nil fraction → indeterminate.")
        }
        .padding()
    }
}

private struct C20_ProgressSystemStylesExample: View {
    @State private var bytes = 3.2
    private let expected = 8.0

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ProgressView("Downloading", value: bytes, total: expected)
                .progressViewStyle(.linear)

            HStack(spacing: 20) {
                ProgressView()
                    .progressViewStyle(.circular)
                    .controlSize(.small)
                ProgressView()
                    .progressViewStyle(.circular)
                    .controlSize(.regular)
                ProgressView()
                    .progressViewStyle(.circular)
                    .controlSize(.large)
                Text(".circular at .small, .regular, .large")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Slider(value: $bytes, in: 0...expected) { Text("bytes") }
        }
        .padding()
    }
}

// MARK: - Scene

private struct C20_EditorScenes: Scene {
    var body: some Scene {
        WindowGroup("Editor", id: "editor") { Text("Editor") }
        Window("Palette", id: "palette") { Text("Palette") }
    }
}

private struct C20_SortCommands: Commands {
    var body: some Commands {
        CommandMenu("Sort") {
            Button("By Name") { }.keyboardShortcut("1")
            Button("By Date") { }.keyboardShortcut("2")
        }
    }
}

private struct C20_CommandedScene: Scene {
    var body: some Scene {
        WindowGroup { Text("Content") }
            .commands {
                C20_SortCommands()
                CommandGroup(replacing: .help) { }
            }
    }
}

private struct C20_InspectorScene: Scene {
    var body: some Scene {
        Window("Inspector", id: "inspector") { Text("Inspector") }
            .defaultSize(width: 320, height: 480)
            .defaultPosition(.trailing)
    }
}

private struct C20_SettingsScene: Scene {
    var body: some Scene {
        Settings { Text("Settings") }
            .windowResizability(.contentSize)
    }
}

private struct C20_SceneBodyExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .top, spacing: 16) {
                C20_MockWindow(title: "Editor", width: 170, height: 110) {
                    VStack(alignment: .leading, spacing: 4) {
                        ForEach(0..<5, id: \.self) { i in
                            Capsule().fill(.secondary.opacity(0.25))
                                .frame(width: CGFloat(140 - i * 18), height: 6)
                        }
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                C20_MockWindow(title: "Palette", width: 90, height: 110) {
                    LazyVGrid(columns: [GridItem(.fixed(18)), GridItem(.fixed(18)), GridItem(.fixed(18))], spacing: 6) {
                        ForEach([Color.red, .orange, .yellow, .green, .blue, .purple], id: \.self) { color in
                            RoundedRectangle(cornerRadius: 3).fill(color).frame(height: 18)
                        }
                    }
                    .padding(8)
                }
            }
            C20_Caption(text: "Illustrative — one Scene body opens both windows. Applies at the Scene level.")
        }
        .padding()
    }
}

private struct C20_SceneCommandsExample: View {
    var body: some View {
        VStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 14) {
                    Image(systemName: "apple.logo").font(.caption)
                    Text("Notes").bold()
                    Text("File")
                    Text("Edit")
                    Text("View")
                    Text("Sort")
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(.tint, in: RoundedRectangle(cornerRadius: 4))
                        .foregroundStyle(.white)
                    Text("Window")
                    Text("Help").strikethrough().foregroundStyle(.tertiary)
                }
                .font(.caption)
                .padding(.horizontal, 10)
                .frame(height: 24)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.regularMaterial)

                VStack(alignment: .leading, spacing: 2) {
                    HStack { Text("By Name"); Spacer(); Text("⌘1").foregroundStyle(.secondary) }
                    HStack { Text("By Date"); Spacer(); Text("⌘2").foregroundStyle(.secondary) }
                }
                .font(.caption)
                .padding(8)
                .frame(width: 150)
                .background(.background, in: RoundedRectangle(cornerRadius: 6))
                .overlay(RoundedRectangle(cornerRadius: 6).stroke(.secondary.opacity(0.4)))
                .padding(.leading, 172)
                .padding(.top, 2)
            }
            .frame(width: 320)
            C20_Caption(text: "Illustrative — SortCommands adds a Sort menu; CommandGroup(replacing: .help) removes Help. Applies at the Scene level.")
        }
        .padding()
    }
}

private struct C20_SceneDefaultSizeExample: View {
    var body: some View {
        VStack(spacing: 10) {
            ZStack(alignment: .trailing) {
                RoundedRectangle(cornerRadius: 6)
                    .fill(.secondary.opacity(0.12))
                    .frame(width: 300, height: 140)
                    .overlay(alignment: .topLeading) {
                        Text("Screen").font(.caption2).foregroundStyle(.tertiary).padding(6)
                    }
                C20_MockWindow(title: "Inspector", width: 80, height: 120) {
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(0..<4, id: \.self) { _ in
                            HStack(spacing: 4) {
                                Circle().fill(.tint).frame(width: 6, height: 6)
                                Capsule().fill(.secondary.opacity(0.3)).frame(height: 5)
                            }
                        }
                    }
                    .padding(8)
                }
                .overlay(alignment: .bottom) {
                    Text("320 × 480").font(.system(size: 8)).foregroundStyle(.secondary).padding(.bottom, 4)
                }
                .padding(.trailing, 8)
            }
            C20_Caption(text: "Illustrative — opens at 320×480 on the trailing edge the first time; later sizes are remembered. Applies at the Scene level.")
        }
        .padding()
    }
}

private struct C20_SceneResizabilityExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 20) {
                VStack(spacing: 6) {
                    C20_MockWindow(title: "Settings", width: 130, height: 90, showsResizeHandle: false) {
                        VStack(alignment: .leading, spacing: 6) {
                            Toggle("Sync", isOn: .constant(true)).controlSize(.mini)
                            Toggle("Sounds", isOn: .constant(false)).controlSize(.mini)
                        }
                        .padding(8)
                    }
                    Text(".contentSize").font(.caption2.monospaced())
                }
                VStack(spacing: 6) {
                    C20_MockWindow(title: "Settings", width: 130, height: 90) {
                        VStack(alignment: .leading, spacing: 6) {
                            Toggle("Sync", isOn: .constant(true)).controlSize(.mini)
                            Toggle("Sounds", isOn: .constant(false)).controlSize(.mini)
                        }
                        .padding(8)
                    }
                    Text(".contentMinSize / .automatic").font(.caption2.monospaced())
                }
            }
            C20_Caption(text: "Illustrative — .contentSize hugs the content and removes the resize affordance. Applies at the Scene level.")
        }
        .padding()
    }
}

// MARK: - ScrollTargetBehavior

private struct C20_PagingBehavior: ScrollTargetBehavior {
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        let width = context.containerSize.width
        guard width > 0 else { return }
        let page = context.originalTarget.rect.minX / width
        let next = context.velocity.dx > 0 ? page.rounded(.up) : page.rounded(.down)
        target.rect.origin.x = next * width
    }
}

private struct C20_NudgeUpBehavior: ScrollTargetBehavior {
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        target.rect.origin.y = max(0, target.rect.origin.y - 24)
        target.anchor = .top
    }
}

private struct C20_FlingToEndBehavior: ScrollTargetBehavior {
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        guard context.axes.contains(.horizontal) else { return }
        let maxX = context.contentSize.width - context.containerSize.width
        if abs(context.velocity.dx) > 800 {
            target.rect.origin.x = context.velocity.dx > 0 ? maxX : 0
        }
        target.rect.origin.x = min(maxX, target.rect.origin.x)
    }
}

private let c20_pageColors: [Color] = [.blue, .orange, .green, .purple, .pink]

private struct C20_UpdateTargetExample: View {
    var body: some View {
        VStack(spacing: 8) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(c20_pageColors.indices, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(c20_pageColors[index].gradient)
                            .overlay(Text("Page \(index + 1)").font(.title3.bold()).foregroundStyle(.white))
                            .padding(6)
                            .containerRelativeFrame(.horizontal)
                    }
                }
            }
            .scrollTargetBehavior(C20_PagingBehavior())
            .frame(width: 260, height: 120)
            .scrollIndicators(.hidden)
            C20_Caption(text: "Swipe: updateTarget rounds the rest position to a whole page in the fling direction.")
        }
        .padding()
    }
}

private struct C20_ScrollTargetExample: View {
    var body: some View {
        VStack(spacing: 8) {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(0..<24, id: \.self) { row in
                        HStack {
                            Text("Row \(row)")
                            Spacer()
                            Text("y = \(row * 28)").foregroundStyle(.secondary).monospacedDigit()
                        }
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .frame(height: 28)
                        .background(row.isMultiple(of: 2) ? Color.secondary.opacity(0.1) : .clear)
                    }
                }
            }
            .scrollTargetBehavior(C20_NudgeUpBehavior())
            .frame(width: 240, height: 120)
            .overlay(RoundedRectangle(cornerRadius: 6).stroke(.secondary.opacity(0.4)))
            C20_Caption(text: "Every fling settles 24 pt short of its natural stop, with the target's top edge as the anchor.")
        }
        .padding()
    }
}

private struct C20_BehaviorContextExample: View {
    var body: some View {
        VStack(spacing: 8) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 8) {
                    ForEach(0..<12, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(c20_pageColors[index % c20_pageColors.count].gradient)
                            .frame(width: 70, height: 80)
                            .overlay(Text("\(index)").font(.headline).foregroundStyle(.white))
                    }
                }
                .padding(.horizontal, 6)
            }
            .scrollTargetBehavior(C20_FlingToEndBehavior())
            .frame(width: 260, height: 96)
            .scrollIndicators(.hidden)
            C20_Caption(text: "Reads context.axes, contentSize, containerSize and velocity: a hard fling (> 800 pt/s) jumps to the end.")
        }
        .padding()
    }
}

private struct C20_ViewAlignedLimitExample: View {
    var body: some View {
        VStack(spacing: 8) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 10) {
                    ForEach(0..<10, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(c20_pageColors[index % c20_pageColors.count].gradient)
                            .frame(width: 120, height: 90)
                            .overlay(Text("Card \(index + 1)").font(.headline).foregroundStyle(.white))
                    }
                }
                .scrollTargetLayout()
                .padding(.horizontal, 6)
            }
            .scrollTargetBehavior(.viewAligned(limitBehavior: .alwaysByOne))
            .frame(width: 260, height: 104)
            .scrollIndicators(.hidden)
            C20_Caption(text: ".alwaysByOne: each swipe advances exactly one card, however hard the fling.")
        }
        .padding()
    }
}

// MARK: - Shape

private struct C20_Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.minX, y: rect.midY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        p.move(to: CGPoint(x: rect.maxX - 12, y: rect.midY - 8))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        p.addLine(to: CGPoint(x: rect.maxX - 12, y: rect.midY + 8))
        return p
    }
}

private struct C20_Dot: Shape {
    func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
        CGSize(width: 12, height: 12)
    }
    func path(in rect: CGRect) -> Path { Path(ellipseIn: rect) }
}

private struct C20_Star: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        var path = Path()
        for i in 0..<5 {
            let angle = (Double(i) * 144 - 90) * Double.pi / 180
            let point = CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
            if i == 0 { path.move(to: point) } else { path.addLine(to: point) }
        }
        path.closeSubpath()
        return path
    }
}

private struct C20_ShapePathExample: View {
    var body: some View {
        VStack(spacing: 12) {
            C20_Arrow()
                .stroke(.tint, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                .frame(width: 200, height: 24)
            C20_Arrow()
                .stroke(.orange, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                .frame(width: 120, height: 24)
            C20_Caption(text: "path(in:) is called with each frame's rect, so the same shape adapts to 200 pt and 120 pt.")
        }
        .padding()
    }
}

private struct C20_ShapeSizeThatFitsExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                C20_Dot().fill(.green)
                Text("Online")
                Spacer()
                Text("Dot: 12 × 12").font(.caption).foregroundStyle(.secondary)
            }
            .frame(height: 40)
            .padding(.horizontal, 10)
            .background(.secondary.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))

            HStack {
                Circle().fill(.green)
                Text("Online")
                Spacer()
                Text("Circle: 40 × 40").font(.caption).foregroundStyle(.secondary)
            }
            .frame(height: 40)
            .padding(.horizontal, 10)
            .background(.secondary.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))

            C20_Caption(text: "Both rows propose 40 pt of height; only the Dot answers with its own size.")
        }
        .frame(width: 260)
        .padding()
    }
}

private struct C20_ShapeFillStyleExample: View {
    var body: some View {
        HStack(spacing: 30) {
            VStack(spacing: 6) {
                C20_Star()
                    .fill(.orange.gradient, style: FillStyle(eoFill: true))
                    .frame(width: 90, height: 90)
                Text("eoFill: true").font(.caption2.monospaced())
            }
            VStack(spacing: 6) {
                C20_Star()
                    .fill(.orange.gradient, style: FillStyle(eoFill: false))
                    .frame(width: 90, height: 90)
                Text("eoFill: false").font(.caption2.monospaced())
            }
        }
        .padding()
    }
}

private struct C20_ShapeIntersectionExample: View {
    var body: some View {
        HStack(spacing: 24) {
            VStack(spacing: 6) {
                ZStack {
                    Circle().stroke(.secondary.opacity(0.4), style: StrokeStyle(lineWidth: 1, dash: [3]))
                    Rectangle().offset(x: 20).stroke(.secondary.opacity(0.4), style: StrokeStyle(lineWidth: 1, dash: [3]))
                    Circle()
                        .intersection(Rectangle().offset(x: 20), eoFill: false)
                        .fill(.blue)
                }
                .frame(width: 70, height: 70)
                .clipped()
                Text("intersection").font(.caption2.monospaced())
            }
            VStack(spacing: 6) {
                Circle().union(Rectangle().offset(x: 20)).fill(.green)
                    .frame(width: 70, height: 70)
                    .clipped()
                Text("union").font(.caption2.monospaced())
            }
            VStack(spacing: 6) {
                Circle().subtracting(Rectangle().offset(x: 20)).fill(.orange)
                    .frame(width: 70, height: 70)
                    .clipped()
                Text("subtracting").font(.caption2.monospaced())
            }
        }
        .padding()
    }
}

// MARK: - ShapeStyle

private struct C20_Accent: ShapeStyle {
    func resolve(in environment: EnvironmentValues) -> Color.Resolved {
        let base: Color = environment.colorScheme == .dark ? .cyan : .blue
        return base.resolve(in: environment)
    }
}

private struct C20_ShapeStyleResolveExample: View {
    var body: some View {
        HStack(spacing: 24) {
            VStack(spacing: 6) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(C20_Accent())
                    .frame(width: 100, height: 60)
                    .environment(\.colorScheme, .light)
                Text(".light → .blue").font(.caption2.monospaced())
            }
            VStack(spacing: 6) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(C20_Accent())
                    .frame(width: 100, height: 60)
                    .environment(\.colorScheme, .dark)
                Text(".dark → .cyan").font(.caption2.monospaced())
            }
        }
        .padding()
    }
}

private struct C20_ShapeStyleOpacityExample: View {
    var body: some View {
        HStack(spacing: 16) {
            VStack(spacing: 6) {
                Rectangle()
                    .fill(.tint)
                    .frame(width: 80, height: 60)
                Text(".tint").font(.caption2.monospaced())
            }
            VStack(spacing: 6) {
                Rectangle()
                    .fill(.tint.opacity(0.3))
                    .overlay(Text("Draft").foregroundStyle(.primary.opacity(0.6)))
                    .frame(width: 80, height: 60)
                Text(".tint.opacity(0.3)").font(.caption2.monospaced())
            }
            VStack(spacing: 6) {
                Rectangle()
                    .fill(.blue.gradient.opacity(0.3))
                    .frame(width: 80, height: 60)
                Text("gradient.opacity(0.3)").font(.caption2.monospaced())
            }
        }
        .padding()
    }
}

private struct C20_ShapeStyleShadowExample: View {
    var body: some View {
        HStack(spacing: 28) {
            VStack(spacing: 6) {
                Text("Embossed")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white.shadow(.inner(color: .black.opacity(0.5), radius: 2, y: 1)))
                Text(".inner").font(.caption2.monospaced()).foregroundStyle(.white.opacity(0.8))
            }
            VStack(spacing: 6) {
                Text("Lifted")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white.shadow(.drop(color: .black.opacity(0.5), radius: 3, y: 2)))
                Text(".drop").font(.caption2.monospaced()).foregroundStyle(.white.opacity(0.8))
            }
        }
        .padding(20)
        .background(Color(red: 0.35, green: 0.45, blue: 0.7), in: RoundedRectangle(cornerRadius: 12))
        .padding()
    }
}

private struct C20_ShapeStyleImagePaintExample: View {
    private var tile: Image {
        Image(size: CGSize(width: 16, height: 16)) { ctx in
            ctx.fill(Path(CGRect(x: 0, y: 0, width: 8, height: 8)), with: .color(.orange))
            ctx.fill(Path(CGRect(x: 8, y: 8, width: 8, height: 8)), with: .color(.orange))
            ctx.fill(Path(CGRect(x: 8, y: 0, width: 8, height: 8)), with: .color(.yellow))
            ctx.fill(Path(CGRect(x: 0, y: 8, width: 8, height: 8)), with: .color(.yellow))
        }
    }

    var body: some View {
        HStack(spacing: 20) {
            VStack(spacing: 6) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.image(tile, sourceRect: CGRect(x: 0, y: 0, width: 1, height: 1), scale: 0.5))
                    .frame(width: 120, height: 80)
                Text("whole tile, scale 0.5").font(.caption2.monospaced())
            }
            VStack(spacing: 6) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.image(tile, sourceRect: CGRect(x: 0, y: 0, width: 0.5, height: 1), scale: 1))
                    .frame(width: 120, height: 80)
                Text("left half, scale 1").font(.caption2.monospaced())
            }
        }
        .padding()
    }
}

// MARK: - TextRenderer

private struct C20_Reveal: TextRenderer {
    var progress: Double
    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }

    func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
        let slices = layout.flatMap { $0 }.flatMap { $0 }   // lines → runs → slices
        let visibleCount = Int((Double(slices.count) * progress).rounded())
        for (index, slice) in slices.enumerated() {
            var copy = ctx
            copy.opacity = index < visibleCount ? 1 : 0
            copy.draw(slice)
        }
    }
}

private struct C20_Tall: TextRenderer {
    func sizeThatFits(proposal: ProposedViewSize, layout: Text.Layout) -> CGSize {
        var size = layout.reduce(CGRect.null) { $0.union($1.typographicBounds.rect) }.size
        size.height += 16
        return size
    }
    func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
        for line in layout { ctx.draw(line) }
    }
}

private struct C20_Glow: TextRenderer {
    var padding: CGFloat
    var displayPadding: EdgeInsets {
        EdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
    }
    func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
        ctx.addFilter(.shadow(color: .yellow, radius: 6))
        for line in layout { ctx.draw(line) }
    }
}

private struct C20_Jitter: TextRenderer {
    func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
        for (index, slice) in layout.flatMap { $0 }.flatMap { $0 }.enumerated() {
            var copy = ctx
            copy.translateBy(x: 0, y: CGFloat(index % 3) * 3 - 3)
            copy.draw(slice)
        }
    }
}

private struct C20_TextRendererDrawExample: View {
    @State private var progress = 0.0

    var body: some View {
        VStack(spacing: 14) {
            Text("Drawn one slice at a time")
                .font(.title2.bold())
                .textRenderer(C20_Reveal(progress: progress))
            HStack {
                Button("Reveal") { withAnimation(.easeInOut(duration: 1.2)) { progress = 1 } }
                Button("Reset") { progress = 0 }
                Text(String(format: "progress %.2f", progress))
                    .font(.caption.monospacedDigit())
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
    }
}

private struct C20_TextRendererSizeExample: View {
    var body: some View {
        VStack(spacing: 14) {
            HStack(alignment: .top, spacing: 24) {
                VStack(spacing: 6) {
                    Text("Bounce")
                        .font(.title.bold())
                        .border(.red)
                    Text("default size").font(.caption2)
                }
                VStack(spacing: 6) {
                    Text("Bounce")
                        .font(.title.bold())
                        .textRenderer(C20_Tall())
                        .border(.red)
                    Text("+16 pt tall").font(.caption2)
                }
            }
            C20_Caption(text: "The red border is the view's measured size; sizeThatFits(proposal:layout:) added 16 pt below the text.")
        }
        .padding()
    }
}

private struct C20_TextRendererPaddingExample: View {
    var body: some View {
        VStack(spacing: 14) {
            HStack(spacing: 30) {
                VStack(spacing: 8) {
                    Text("Glow")
                        .font(.largeTitle.bold())
                        .textRenderer(C20_Glow(padding: 8))
                    Text("padding 8").font(.caption2.monospaced())
                }
                VStack(spacing: 8) {
                    Text("Glow")
                        .font(.largeTitle.bold())
                        .textRenderer(C20_Glow(padding: 0))
                    Text("padding 0").font(.caption2.monospaced())
                }
            }
            .padding(.vertical, 8)
            C20_Caption(text: "Same shadow filter; without displayPadding the glow is clipped at the text bounds.")
        }
        .padding()
    }
}

private struct C20_TextRendererModifierExample: View {
    @State private var enabled = true

    var body: some View {
        VStack(spacing: 14) {
            if enabled {
                Text("Hello, world")
                    .font(.largeTitle)
                    .textRenderer(C20_Jitter())
            } else {
                Text("Hello, world")
                    .font(.largeTitle)
            }
            Toggle(".textRenderer(Jitter())", isOn: $enabled)
                .font(.caption.monospaced())
        }
        .padding()
    }
}

// MARK: - ToggleStyle

private struct C20_CheckRow: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(configuration.isOn ? Color.accentColor : Color.secondary)
        }
        .contentShape(.rect)
        .onTapGesture { configuration.isOn.toggle() }
    }
}

private struct C20_TriStateStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button { configuration.isOn.toggle() } label: {
            Label {
                configuration.label
            } icon: {
                Image(systemName: configuration.isMixed ? "minus.square"
                                  : configuration.isOn ? "checkmark.square" : "square")
                    .foregroundStyle(configuration.isMixed ? Color.orange : Color.accentColor)
            }
        }
        .buttonStyle(.plain)
    }
}

private struct C20_ToggleMakeBodyExample: View {
    @State private var wifi = true
    @State private var bluetooth = false

    var body: some View {
        VStack(spacing: 10) {
            Toggle("Wi-Fi", isOn: $wifi).toggleStyle(C20_CheckRow())
            Divider()
            Toggle("Bluetooth", isOn: $bluetooth).toggleStyle(C20_CheckRow())
            C20_Caption(text: "Tap anywhere on a row: makeBody wraps configuration.label and flips configuration.isOn.")
        }
        .frame(width: 240)
        .padding()
    }
}

private struct C20_Pick: Identifiable {
    var name: String
    var isOn: Bool
    var id: String { name }
}

private struct C20_ToggleIsMixedExample: View {
    @State private var items: [C20_Pick] = [
        C20_Pick(name: "Bold", isOn: true),
        C20_Pick(name: "Italic", isOn: false),
        C20_Pick(name: "Underline", isOn: true),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Toggle("Select all", sources: $items, isOn: \.isOn)
                .toggleStyle(C20_TriStateStyle())
                .font(.headline)
            Divider()
            ForEach($items) { $item in
                Toggle(item.name, isOn: $item.isOn)
                    .toggleStyle(C20_TriStateStyle())
                    .padding(.leading, 16)
            }
            C20_Caption(text: "isMixed is true (orange minus) while the children disagree.")
        }
        .frame(width: 220)
        .padding()
    }
}

private struct C20_ToggleSystemStylesExample: View {
    @State private var isBold = true
    @State private var wifiEnabled = true
    @State private var remember = false

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 20) {
                Toggle("Bold", systemImage: "bold", isOn: $isBold)
                    .toggleStyle(.button)
                Text(".button").font(.caption2.monospaced()).foregroundStyle(.secondary)
            }
            HStack(spacing: 20) {
                Toggle("Wi-Fi", isOn: $wifiEnabled)
                    .toggleStyle(.switch)
                Text(".switch").font(.caption2.monospaced()).foregroundStyle(.secondary)
            }
            HStack(spacing: 20) {
                Toggle("Remember me", isOn: $remember)
                    .toggleStyle(.checkbox)
                Text(".checkbox").font(.caption2.monospaced()).foregroundStyle(.secondary)
            }
        }
        .padding()
    }
}

// MARK: - ToolbarContent

private struct C20_ShareItems: ToolbarContent {
    var url: URL
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .primaryAction) {
            ShareLink(item: url)
            Button("Star", systemImage: "star") { }
        }
    }
}

private struct C20_SheetActions: ToolbarContent {
    var body: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel", role: .cancel) { }
        }
        ToolbarItem(placement: .confirmationAction) {
            Button("Save") { }
        }
    }
}

private struct C20_EditGroup: ToolbarContent {
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .secondaryAction) {
            Button("Duplicate", systemImage: "plus.square.on.square") { }
            Button("Archive", systemImage: "archivebox") { }
        }
    }
}

private struct C20_SpacedItems: ToolbarContent {
    var body: some ToolbarContent {
        ToolbarItem { Button("Edit", systemImage: "pencil") { } }
        ToolbarSpacer(.fixed)
        ToolbarItem {
            Button("Delete", systemImage: "trash", role: .destructive) { }
        }
    }
}

private struct C20_MockToolbarItem: View {
    var symbol: String
    var title: String
    var tint: Color = .primary
    var body: some View {
        VStack(spacing: 1) {
            Image(systemName: symbol).font(.system(size: 13))
            Text(title).font(.system(size: 8))
        }
        .foregroundStyle(tint)
        .frame(width: 46, height: 30)
    }
}

private struct C20_ToolbarBodyExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C20_MockWindow(title: "Note", width: 280, height: 96) {
                VStack(spacing: 0) {
                    HStack(spacing: 2) {
                        Spacer()
                        C20_MockToolbarItem(symbol: "square.and.arrow.up", title: "Share")
                        C20_MockToolbarItem(symbol: "star", title: "Star")
                    }
                    .padding(.horizontal, 6)
                    .frame(height: 36)
                    .background(.regularMaterial)
                    Rectangle().fill(.secondary.opacity(0.1))
                }
            }
            C20_Caption(text: "Illustrative — ShareItems(note:) contributes both items at .primaryAction, on the window's toolbar.")
        }
        .padding()
    }
}

private struct C20_ToolbarItemExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C20_MockWindow(title: "Edit Note", width: 280, height: 96, showsResizeHandle: false) {
                VStack(spacing: 0) {
                    HStack {
                        Button("Cancel") { }.controlSize(.small)
                        Spacer()
                        Button("Save") { }.controlSize(.small).buttonStyle(.borderedProminent)
                    }
                    .padding(.horizontal, 8)
                    .frame(height: 36)
                    .background(.regularMaterial)
                    Rectangle().fill(.secondary.opacity(0.1))
                }
            }
            C20_Caption(text: "Illustrative — .cancellationAction lands leading, .confirmationAction trailing; the system places each per platform.")
        }
        .padding()
    }
}

private struct C20_ToolbarItemGroupExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C20_MockWindow(title: "Library", width: 280, height: 96) {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Spacer()
                        HStack(spacing: 0) {
                            C20_MockToolbarItem(symbol: "plus.square.on.square", title: "Duplicate")
                            C20_MockToolbarItem(symbol: "archivebox", title: "Archive")
                        }
                        .background(.secondary.opacity(0.12), in: RoundedRectangle(cornerRadius: 6))
                    }
                    .padding(.horizontal, 6)
                    .frame(height: 36)
                    .background(.regularMaterial)
                    Rectangle().fill(.secondary.opacity(0.1))
                }
            }
            C20_Caption(text: "Illustrative — one ToolbarItemGroup at .secondaryAction keeps Duplicate and Archive together as a unit.")
        }
        .padding()
    }
}

private struct C20_ToolbarSpacerExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C20_MockWindow(title: "Draft", width: 280, height: 96) {
                VStack(spacing: 0) {
                    HStack(spacing: 8) {
                        Spacer()
                        C20_MockToolbarItem(symbol: "pencil", title: "Edit")
                            .glassEffect(.regular, in: Capsule())
                        Color.clear.frame(width: 8, height: 1)
                        C20_MockToolbarItem(symbol: "trash", title: "Delete", tint: .red)
                            .glassEffect(.regular, in: Capsule())
                    }
                    .padding(.horizontal, 6)
                    .frame(height: 40)
                    Rectangle().fill(.blue.gradient.opacity(0.35))
                }
                .background(.blue.gradient.opacity(0.35))
            }
            C20_Caption(text: "Illustrative — ToolbarSpacer(.fixed) splits Edit and Delete into separate Liquid Glass groups.")
        }
        .padding()
    }
}

// MARK: - Transferable

private struct C20_Note: Codable, Transferable {
    var title: String
    var bodyText: String

    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .json)
        ProxyRepresentation(exporting: { $0.title })
    }
}

private struct C20_Sequence: Transferable {
    var letters: String

    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(contentType: .utf8PlainText) { sequence in
            Data(sequence.letters.utf8)
        } importing: { data in
            C20_Sequence(letters: String(decoding: data, as: UTF8.self))
        }
    }
}

private struct C20_Clip: Transferable {
    var url: URL

    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .mpeg4Movie) { clip in
            SentTransferredFile(clip.url)
        } importing: { received in
            C20_Clip(url: received.file)
        }
    }
}

private struct C20_Tag: Transferable {
    var name: String

    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: { tag in tag.name },
                            importing: { name in C20_Tag(name: name) })
    }
}

private struct C20_DropZone: View {
    var text: String
    var isTargeted: Bool
    var body: some View {
        Text(text)
            .font(.caption)
            .multilineTextAlignment(.center)
            .frame(width: 130, height: 60)
            .background(isTargeted ? Color.accentColor.opacity(0.2) : Color.secondary.opacity(0.08),
                        in: RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(.secondary.opacity(0.4), style: StrokeStyle(lineWidth: 1, dash: [4])))
    }
}

private struct C20_TransferRepresentationExample: View {
    private let note = C20_Note(title: "Packing list", bodyText: "Passport, charger, tea")
    @State private var received = "Drop the note here"
    @State private var targeted = false

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 20) {
                Label(note.title, systemImage: "note.text")
                    .padding(8)
                    .background(.yellow.opacity(0.3), in: RoundedRectangle(cornerRadius: 8))
                    .draggable(note)
                Image(systemName: "arrow.right").foregroundStyle(.secondary)
                C20_DropZone(text: received, isTargeted: targeted)
                    .dropDestination(for: C20_Note.self) { notes, _ in
                        guard let first = notes.first else { return false }
                        received = "Note: \(first.title)\n\(first.bodyText)"
                        return true
                    } isTargeted: { targeted = $0 }
            }
            C20_Caption(text: "Drag the note. Our own drop zone takes the JSON; a text field would take the proxied title.")
        }
        .padding()
    }
}

private struct C20_DataRepresentationExample: View {
    private let sequence = C20_Sequence(letters: "ACGTTGCA")
    @State private var log = "Tap Round-trip"

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 12) {
                Text(sequence.letters)
                    .font(.title3.monospaced())
                    .padding(8)
                    .background(.green.opacity(0.2), in: RoundedRectangle(cornerRadius: 8))
                Button("Round-trip") {
                    let source = sequence
                    Task {
                        do {
                            let data = try await source.exported(as: .utf8PlainText)
                            let copy = try await C20_Sequence(importing: data, contentType: .utf8PlainText)
                            log = "exporting → \(data.count) bytes\nimporting → \"\(copy.letters)\""
                        } catch {
                            log = "failed: \(error.localizedDescription)"
                        }
                    }
                }
            }
            Text(log)
                .font(.caption.monospaced())
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            C20_Caption(text: "exported(as:) runs the exporting closure; init(importing:contentType:) runs importing.")
        }
        .padding()
    }
}

private struct C20_FileRepresentationExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 16) {
                VStack(spacing: 4) {
                    Image(systemName: "film.stack")
                        .font(.system(size: 30))
                        .foregroundStyle(.white)
                        .frame(width: 90, height: 60)
                        .background(.indigo.gradient, in: RoundedRectangle(cornerRadius: 8))
                    Text("clip.mp4 · 1.2 GB").font(.caption2).foregroundStyle(.secondary)
                }
                VStack(alignment: .leading, spacing: 6) {
                    Label("SentTransferredFile(clip.url)", systemImage: "arrow.up.doc")
                    Label("received.file → Clip(url:)", systemImage: "arrow.down.doc")
                }
                .font(.caption.monospaced())
            }
            C20_Caption(text: "Illustrative — the payload stays on disk; FileRepresentation hands over a URL instead of loading 1.2 GB into memory.")
        }
        .padding()
    }
}

private struct C20_ProxyRepresentationExample: View {
    private let tag = C20_Tag(name: "urgent")
    @State private var received = "Drop the tag here\n(accepts String)"
    @State private var targeted = false

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 20) {
                Text("#\(tag.name)")
                    .font(.callout.bold())
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.orange.opacity(0.3), in: Capsule())
                    .draggable(tag)
                Image(systemName: "arrow.right").foregroundStyle(.secondary)
                C20_DropZone(text: received, isTargeted: targeted)
                    .dropDestination(for: String.self) { strings, _ in
                        guard let first = strings.first else { return false }
                        received = "String: \"\(first)\""
                        return true
                    } isTargeted: { targeted = $0 }
            }
            C20_Caption(text: "Tag never defines its own bytes: the proxy exports tag.name as a String and imports one back.")
        }
        .padding()
    }
}

// MARK: - Transition

private struct C20_Rise: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .offset(y: phase.value * 40)
            .blur(radius: phase.isIdentity ? 0 : 6)
    }
}

private struct C20_Twirl: Transition {
    static var properties: TransitionProperties {
        TransitionProperties(hasMotion: true)
    }
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .rotationEffect(.degrees(phase.isIdentity ? 0 : 180))
            .scaleEffect(phase.isIdentity ? 1 : 0.3)
    }
}

private struct C20_Banner: View {
    var text: String
    var color: Color = .green
    var body: some View {
        Label(text, systemImage: "checkmark.circle.fill")
            .font(.headline)
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(color.gradient, in: Capsule())
            .foregroundStyle(.white)
    }
}

private struct C20_TransitionPhaseExample: View {
    @State private var isShown = false

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                if isShown {
                    C20_Banner(text: "Saved").transition(C20_Rise())
                }
            }
            .frame(height: 70)
            Button(isShown ? "Hide (phase → +1, didDisappear)" : "Show (phase −1 → 0, identity)") {
                withAnimation(.easeInOut(duration: 0.7)) { isShown.toggle() }
            }
            C20_Caption(text: "phase.value drives the offset: rises in from below (−1), rests at 0, sinks out (+1). Blur clears only at isIdentity.")
        }
        .padding()
    }
}

private struct C20_TransitionPropertiesExample: View {
    @State private var isShown = true
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                if isShown {
                    C20_Banner(text: "Twirl", color: .purple).transition(C20_Twirl())
                }
            }
            .frame(height: 70)
            Button(isShown ? "Remove" : "Insert") {
                withAnimation(.easeInOut(duration: 0.7)) { isShown.toggle() }
            }
            C20_Caption(text: "properties.hasMotion == true tells SwiftUI this transition moves content. Reduce Motion here: \(reduceMotion ? "on" : "off").")
        }
        .padding()
    }
}

private struct C20_TransitionCombinedExample: View {
    @State private var isShown = true

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 30) {
                VStack(spacing: 6) {
                    ZStack {
                        if isShown {
                            C20_Banner(text: "Saved").transition(C20_Twirl().combined(with: .opacity))
                        }
                    }
                    .frame(width: 130, height: 60)
                    Text("Twirl().combined(with: .opacity)").font(.caption2.monospaced())
                }
                VStack(spacing: 6) {
                    ZStack {
                        if isShown {
                            C20_Banner(text: "Saved", color: .gray).transition(C20_Twirl())
                        }
                    }
                    .frame(width: 130, height: 60)
                    Text("Twirl() alone").font(.caption2.monospaced())
                }
            }
            Button(isShown ? "Remove both" : "Insert both") {
                withAnimation(.easeInOut(duration: 0.9)) { isShown.toggle() }
            }
        }
        .padding()
    }
}

private struct C20_TransitionAnimationExample: View {
    @State private var isShown = true

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 30) {
                VStack(spacing: 6) {
                    ZStack {
                        if isShown {
                            C20_Banner(text: "Saved").transition(.push(from: .bottom).animation(.bouncy))
                        }
                    }
                    .frame(width: 130, height: 60)
                    .clipped()
                    Text(".animation(.bouncy)").font(.caption2.monospaced())
                }
                VStack(spacing: 6) {
                    ZStack {
                        if isShown {
                            C20_Banner(text: "Saved", color: .gray).transition(.push(from: .bottom))
                        }
                    }
                    .frame(width: 130, height: 60)
                    .clipped()
                    Text("no animation bound").font(.caption2.monospaced())
                }
            }
            Button(isShown ? "Remove both" : "Insert both") {
                isShown.toggle()   // deliberately no withAnimation
            }
            C20_Caption(text: "The toggle uses no withAnimation: only the transition that carries its own animation animates.")
        }
        .padding()
    }
}

// MARK: - UIViewRepresentable (rendered via the NSViewRepresentable equivalent)

private struct C20_SearchFieldView: NSViewRepresentable {
    var onSearch: (String) -> Void

    func makeCoordinator() -> Coordinator { Coordinator(onSearch: onSearch) }

    func makeNSView(context: Context) -> NSSearchField {
        let field = NSSearchField()
        field.placeholderString = "Search"
        field.delegate = context.coordinator
        return field
    }

    func updateNSView(_ field: NSSearchField, context: Context) {
        context.coordinator.onSearch = onSearch
    }

    final class Coordinator: NSObject, NSSearchFieldDelegate {
        var onSearch: (String) -> Void
        init(onSearch: @escaping (String) -> Void) { self.onSearch = onSearch }
        func controlTextDidChange(_ notification: Notification) {
            guard let field = notification.object as? NSSearchField else { return }
            onSearch(field.stringValue)
        }
    }
}

private struct C20_MakeCoordinatorExample: View {
    @State private var query = ""

    var body: some View {
        VStack(spacing: 10) {
            C20_SearchFieldView { query = $0 }
                .frame(width: 220)
            Text(query.isEmpty ? "Coordinator has forwarded nothing yet" : "Coordinator forwarded: \"\(query)\"")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
            C20_Caption(text: "Illustrative — UIViewRepresentable is iOS/tvOS only; this is the NSViewRepresentable twin: makeCoordinator() builds the delegate that calls back into SwiftUI.")
        }
        .padding()
    }
}

private struct C20_WrappingLabelView: NSViewRepresentable {
    var text: String

    func makeNSView(context: Context) -> NSTextField {
        let label = NSTextField(wrappingLabelWithString: text)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }

    func updateNSView(_ label: NSTextField, context: Context) {
        label.stringValue = text
    }

    func sizeThatFits(_ proposal: ProposedViewSize, nsView: NSTextField, context: Context) -> CGSize? {
        let width = proposal.width ?? 240
        return nsView.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
    }
}

private struct C20_SizeThatFitsRepresentableExample: View {
    @State private var width: CGFloat = 200

    var body: some View {
        VStack(spacing: 10) {
            C20_WrappingLabelView(text: "A wrapped AppKit label that answers SwiftUI's width proposal with exactly the height it needs.")
                .frame(width: width)
                .border(.red)
            Slider(value: $width, in: 120...260) { Text("proposed width") }
                .frame(width: 220)
            C20_Caption(text: "Illustrative — UIKit is iOS-only; the NSViewRepresentable twin sizeThatFits(_:nsView:context:) keeps the label from claiming all the space.")
        }
        .padding()
    }
}

private struct C20_SpinnerView: NSViewRepresentable {
    var onDismantle: () -> Void

    func makeCoordinator() -> Coordinator { Coordinator(onDismantle: onDismantle) }

    func makeNSView(context: Context) -> NSProgressIndicator {
        let spinner = NSProgressIndicator()
        spinner.style = .spinning
        spinner.controlSize = .regular
        spinner.startAnimation(nil)
        return spinner
    }

    func updateNSView(_ spinner: NSProgressIndicator, context: Context) {
        context.coordinator.onDismantle = onDismantle
    }

    static func dismantleNSView(_ spinner: NSProgressIndicator, coordinator: Coordinator) {
        spinner.stopAnimation(nil)
        coordinator.stopObserving()
    }

    final class Coordinator {
        var onDismantle: () -> Void
        init(onDismantle: @escaping () -> Void) { self.onDismantle = onDismantle }
        func stopObserving() {
            let callback = onDismantle
            Task { @MainActor in callback() }
        }
    }
}

private struct C20_DismantleExample: View {
    @State private var isMounted = true
    @State private var log = "view is mounted and spinning"

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                if isMounted {
                    C20_SpinnerView { log = "dismantleNSView ran: stopAnimation(nil) + coordinator.stopObserving()" }
                } else {
                    Image(systemName: "stop.circle").font(.title).foregroundStyle(.secondary)
                }
            }
            .frame(height: 40)
            Button(isMounted ? "Remove the view" : "Mount again") { isMounted.toggle() }
            Text(log)
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            C20_Caption(text: "Illustrative — UIKit is iOS-only; the NSViewRepresentable twin dismantleNSView(_:coordinator:) does the same static cleanup.")
        }
        .padding()
    }
}

private struct C20_SwitchView: NSViewRepresentable {
    @Binding var isOn: Bool

    func makeCoordinator() -> Coordinator { Coordinator(binding: $isOn) }

    func makeNSView(context: Context) -> NSSwitch {
        let control = NSSwitch()
        control.target = context.coordinator
        control.action = #selector(Coordinator.toggled(_:))
        return control
    }

    func updateNSView(_ view: NSSwitch, context: Context) {
        view.isEnabled = context.environment.isEnabled
        view.state = isOn ? .on : .off
        context.coordinator.binding = $isOn
    }

    final class Coordinator: NSObject {
        var binding: Binding<Bool>
        init(binding: Binding<Bool>) { self.binding = binding }
        @objc func toggled(_ sender: NSSwitch) { binding.wrappedValue = sender.state == .on }
    }
}

private struct C20_RepresentableContextExample: View {
    @State private var isOn = true
    @State private var enabled = true

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 16) {
                C20_SwitchView(isOn: $isOn)
                    .disabled(!enabled)
                Text("isOn = \(isOn ? "true" : "false")")
                    .font(.caption.monospaced())
            }
            Toggle("Enabled (read via context.environment.isEnabled)", isOn: $enabled)
                .font(.caption)
            C20_Caption(text: "Illustrative — UIKit is iOS-only; the NSViewRepresentable twin's Context carries the same coordinator, environment and transaction.")
        }
        .padding()
    }
}

// MARK: - ViewModifier

private struct C20_Pulse: ViewModifier {
    @State private var scale: CGFloat = 1
    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.8).repeatForever()) { scale = 1.1 }
            }
    }
}

private struct C20_CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(12)
            .background(.background, in: RoundedRectangle(cornerRadius: 10))
            .shadow(color: .black.opacity(0.15), radius: 4, y: 2)
    }
}

private extension View {
    func c20CardStyle() -> some View { modifier(C20_CardStyle()) }
}

private struct C20_ModifierBodyExample: View {
    var body: some View {
        VStack(spacing: 14) {
            Label("Recording", systemImage: "record.circle")
                .font(.title3)
                .foregroundStyle(.red)
                .modifier(C20_Pulse())
            C20_Caption(text: "body(content:) receives the label as Content; the modifier's own @State drives the pulse.")
        }
        .padding()
    }
}

private struct C20_ViewModifierCallExample: View {
    var body: some View {
        VStack(spacing: 14) {
            HStack(spacing: 24) {
                VStack(spacing: 8) {
                    Text("Hello").modifier(C20_CardStyle())
                    Text(".modifier(CardStyle())").font(.caption2.monospaced())
                }
                VStack(spacing: 8) {
                    Text("Hello").c20CardStyle()
                    Text(".cardStyle()").font(.caption2.monospaced())
                }
            }
        }
        .padding()
    }
}

private struct C20_ModifierConcatExample: View {
    private let cardAndPulse = C20_CardStyle().concat(C20_Pulse())

    var body: some View {
        VStack(spacing: 14) {
            Text("Hello").modifier(cardAndPulse)
            C20_Caption(text: "One ModifiedContent<CardStyle, Pulse> value applies the card and the pulse together.")
        }
        .padding()
    }
}
