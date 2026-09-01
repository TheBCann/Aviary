//
//  Catalog+MoreViews.swift
//  Swift-UI-Companion
//
//  Second wave of view entries: structure, navigation, controls, animation
//  containers, and legacy APIs kept for reference.
//

import Foundation

extension Catalog {
    static let moreViews: [Topic] = [
        Topic(
            name: "Group",
            kind: .view,
            summary: "Bundles views without adding any layout of its own.",
            discussion: "Group exists purely to treat several views as one — apply a shared modifier, sidestep the child-count limit of a builder, or return mixed branches from a helper. Layout comes entirely from the container the group sits in.",
            wwdcYear: 2019,
            code: #"""
            Group {
                Text("One")
                Text("Two")
            }
            .font(.headline)
            """#,
            related: ["ForEach", "Section"]
        ),
        Topic(
            name: "AnyView",
            kind: .view,
            summary: "Type-erases a view behind one concrete wrapper.",
            discussion: "AnyView hides the underlying view type, useful when branches must produce a single type outside a ViewBuilder. It costs SwiftUI diffing information, so prefer @ViewBuilder or Group where possible.",
            wwdcYear: 2019,
            code: #"""
            var icon: AnyView {
                isLocked
                    ? AnyView(Image(systemName: "lock"))
                    : AnyView(ProgressView())
            }
            """#,
            related: ["Group", "View"]
        ),
        Topic(
            name: "EmptyView",
            kind: .view,
            summary: "A view that draws nothing and takes no space.",
            discussion: "EmptyView is the explicit 'nothing here' — the default for optional generic slots like section headers. Returning it from a branch removes that branch from layout entirely.",
            wwdcYear: 2019,
            code: #"""
            Section {
                rows
            } header: {
                EmptyView()
            }
            """#,
            related: ["Group", "Spacer"]
        ),
        Topic(
            name: "GeometryReader",
            kind: .view,
            summary: "Gives its content the size and frame it was offered.",
            discussion: "GeometryReader hands you a GeometryProxy with the proposed size and coordinate-space frames, enabling proportional layouts and measurements. It greedily fills its offered space, so use it sparingly — containerRelativeFrame and onGeometryChange cover many former uses.",
            wwdcYear: 2019,
            code: #"""
            GeometryReader { proxy in
                Rectangle()
                    .frame(width: proxy.size.width / 2)
            }
            """#,
            related: [".containerRelativeFrame()", ".frame()"]
        ),
        Topic(
            name: "LazyVStack",
            kind: .view,
            summary: "A vertical stack that creates children only when visible.",
            discussion: "Inside a ScrollView, LazyVStack instantiates rows as they approach the viewport instead of all at once — the difference between smooth and unusable for long feeds. Pinned section headers are supported via pinnedViews.",
            wwdcYear: 2020,
            code: #"""
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 8) {
                    ForEach(messages) { MessageRow($0) }
                }
            }
            """#,
            related: ["VStack", "LazyHStack", "ScrollView"]
        ),
        Topic(
            name: "LazyHStack",
            kind: .view,
            summary: "A horizontal stack that creates children on demand.",
            discussion: "The horizontal twin of LazyVStack, built for carousels and shelves inside a horizontal ScrollView. Pair with scrollTargetBehavior for paging or view-aligned snapping.",
            wwdcYear: 2020,
            code: #"""
            ScrollView(.horizontal) {
                LazyHStack(spacing: 12) {
                    ForEach(albums) { AlbumCard($0) }
                }
            }
            """#,
            related: ["HStack", "LazyVStack", ".scrollTargetBehavior()"]
        ),
        Topic(
            name: "LazyHGrid",
            kind: .view,
            summary: "A horizontally growing grid with on-demand items.",
            discussion: "LazyHGrid fills fixed rows described by GridItem values and grows sideways as you scroll — the shape of tag clouds and horizontally scrolling galleries.",
            wwdcYear: 2020,
            code: #"""
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.fixed(44)), GridItem(.fixed(44))]) {
                    ForEach(tags) { TagChip($0) }
                }
            }
            """#,
            related: ["LazyVGrid", "Grid"]
        ),
        Topic(
            name: "NavigationLink",
            kind: .view,
            summary: "A control that pushes a destination onto the navigation stack.",
            discussion: "In modern code NavigationLink carries a value; the enclosing NavigationStack's navigationDestination decides what view that value becomes. The older destination-closure form still works for simple static pushes.",
            wwdcYear: 2019,
            code: #"""
            NavigationLink(value: park) {
                Label(park.name, systemImage: "tree")
            }
            """#,
            related: ["NavigationStack", "NavigationSplitView"],
            children: [
                TopicChild(
                    name: "NavigationLink(value:label:)",
                    summary: "Pushes a Hashable value; navigationDestination maps it to a view.",
                    discussion: "Because the link only carries data, the same row works in any stack whose navigationDestination understands the value type — and deep links can push the identical value programmatically.",
                    code: #"""
                    NavigationLink(value: recipe) {
                        Label(recipe.title, systemImage: "fork.knife")
                    }

                    // resolved elsewhere:
                    .navigationDestination(for: Recipe.self) { RecipeDetail($0) }
                    """#
                ),
                TopicChild(
                    name: "NavigationLink(_:value:)",
                    summary: "Title-string shorthand for a value-presenting link.",
                    code: #"""
                    NavigationLink("Statistics", value: Route.stats)
                    """#
                ),
                TopicChild(
                    name: "NavigationLink(destination:label:)",
                    summary: "Builds the destination view directly — no value type involved.",
                    discussion: "Fine for simple static pushes, but the destination is baked into the link, so state restoration and programmatic navigation can't reach it the way value-based links allow.",
                    code: #"""
                    NavigationLink {
                        AboutView()
                    } label: {
                        Label("About", systemImage: "info.circle")
                    }
                    """#
                ),
            ]
        ),
        Topic(
            name: "NavigationView",
            kind: .view,
            summary: "The original navigation container, replaced in 2022.",
            discussion: "NavigationView wrapped push navigation and split layouts in one type with stringly-typed links. It is deprecated: NavigationStack covers push-and-pop and NavigationSplitView covers columns, both driven by data instead of view identity.",
            wwdcYear: 2019,
            deprecated: true,
            code: #"""
            // Legacy:
            NavigationView {
                List(items) { ItemRow($0) }
            }

            // Modern replacement:
            NavigationStack {
                List(items) { ItemRow($0) }
            }
            """#,
            related: ["NavigationStack", "NavigationSplitView"]
        ),
        Topic(
            name: "MenuButton",
            kind: .view,
            summary: "The original macOS pull-down button, replaced by Menu.",
            discussion: "MenuButton shipped with the first macOS SwiftUI release and was deprecated once Menu unified pull-down menus across platforms. Kept here for reading older code.",
            wwdcYear: 2019,
            platforms: [.macOS],
            deprecated: true,
            code: #"""
            // Legacy:
            MenuButton("Actions") {
                Button("Duplicate") { duplicate() }
            }

            // Modern replacement:
            Menu("Actions") {
                Button("Duplicate") { duplicate() }
            }
            """#,
            related: ["Menu", "Button"]
        ),
        Topic(
            name: "ModifiedContent",
            kind: .view,
            summary: "The type produced by applying a modifier to a view.",
            discussion: "Every modifier call really returns ModifiedContent<Content, Modifier> — the nested generic you see in compiler errors and type signatures. You rarely write it directly, but recognizing it demystifies 'some View' diagnostics.",
            wwdcYear: 2019,
            code: #"""
            // These are the same type:
            let a = Text("Hi").padding()
            let b = ModifiedContent(
                content: Text("Hi"),
                modifier: _PaddingLayout(insets: nil)
            )
            """#,
            related: ["ViewModifier", "View"]
        ),
        Topic(
            name: "OutlineGroup",
            kind: .view,
            summary: "Renders a tree of data as expandable disclosure rows.",
            discussion: "OutlineGroup walks recursive data through a children key path and produces nested DisclosureGroups automatically. Inside a List you usually get the same effect from the List(_:children:) initializer.",
            wwdcYear: 2020,
            platforms: [.iOS, .macOS],
            code: #"""
            OutlineGroup(fileTree, children: \.children) { node in
                Label(node.name, systemImage: node.icon)
            }
            """#,
            related: ["DisclosureGroup", "List"],
            children: [
                TopicChild(
                    name: "OutlineGroup(_:children:content:)",
                    summary: "Walks Identifiable data through a recursive children key path.",
                    discussion: "The key path points at an optional array of the same element type; nil marks a leaf, an empty array an expandable-but-empty branch.",
                    code: #"""
                    OutlineGroup(fileTree, children: \.children) { node in
                        Label(node.name, systemImage: node.icon)
                    }
                    """#
                ),
                TopicChild(
                    name: "OutlineGroup(_:id:children:content:)",
                    summary: "The same traversal for data that isn't Identifiable.",
                    code: #"""
                    OutlineGroup(chapters, id: \.title, children: \.subsections) { chapter in
                        Text(chapter.title)
                    }
                    """#
                ),
            ]
        ),
        Topic(
            name: "PasteButton",
            kind: .view,
            summary: "A system button that pastes matching pasteboard content.",
            discussion: "PasteButton reads Transferable types from the pasteboard without prompting the paste-permission alert, because the user's tap is the consent. It enables itself only when compatible content is present. macOS had an earlier form since 10.15; the Transferable version arrived in 2022.",
            wwdcYear: 2022,
            platforms: [.iOS, .macOS],
            code: #"""
            PasteButton(payloadType: String.self) { strings in
                notes.append(contentsOf: strings)
            }
            """#,
            related: ["Transferable", "ShareLink"],
            children: [
                TopicChild(
                    name: "PasteButton(payloadType:onPaste:)",
                    summary: "The Transferable form: name a type, receive decoded values.",
                    discussion: "Any Transferable type works — String, Image, URL, or your own — and the closure receives every matching item the pasteboard held.",
                    code: #"""
                    PasteButton(payloadType: String.self) { strings in
                        notes.append(contentsOf: strings)
                    }
                    """#
                ),
                TopicChild(
                    name: "PasteButton(supportedContentTypes:payloadAction:)",
                    summary: "The UTType form: hands you raw NSItemProviders to load.",
                    discussion: "Reach for this when the content type matters more than a concrete Swift type — the providers arrive unloaded, so fetch their data asynchronously.",
                    code: #"""
                    PasteButton(supportedContentTypes: [.fileURL]) { providers in
                        importFiles(from: providers)
                    }
                    """#
                ),
            ]
        ),
        Topic(
            name: "ScrollViewReader",
            kind: .view,
            summary: "Scrolls programmatically to a child with a given id.",
            discussion: "ScrollViewReader's proxy jumps the enclosing ScrollView to any child tagged with id, optionally anchored and animated. Newer code can often use the scrollPosition modifier instead, which also reads the position back.",
            wwdcYear: 2020,
            code: #"""
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack { ForEach(messages) { MessageRow($0) } }
                }
                .onChange(of: messages.count) {
                    proxy.scrollTo(messages.last?.id, anchor: .bottom)
                }
            }
            """#,
            related: ["ScrollView", ".scrollPosition()"]
        ),
        Topic(
            name: "ControlGroup",
            kind: .view,
            summary: "Visually groups related controls, toolbar-style.",
            discussion: "ControlGroup renders its buttons as one segmented cluster — back/forward pairs, formatting sets — and adapts inside toolbars and menus. Styles include navigation and palette renderings.",
            wwdcYear: 2021,
            platforms: [.iOS, .macOS],
            code: #"""
            ControlGroup {
                Button("Back", systemImage: "chevron.backward") { back() }
                Button("Forward", systemImage: "chevron.forward") { forward() }
            }
            """#,
            related: [".toolbar()", "Menu"]
        ),
        Topic(
            name: "LabeledContent",
            kind: .view,
            summary: "A label-and-value pair with standard form alignment.",
            discussion: "LabeledContent lays out a title against any value view the way Form expects — trailing gray text on iOS, aligned columns on macOS — replacing ad-hoc HStack+Spacer rows. The string-value initializer covers the common read-only case.",
            wwdcYear: 2022,
            code: #"""
            Form {
                LabeledContent("Version", value: "2.4.1")
                LabeledContent("Storage") {
                    Text("82%") + Text(" used").foregroundStyle(.secondary)
                }
            }
            """#,
            related: ["Form", "Section"],
            children: [
                TopicChild(
                    name: "LabeledContent(_:value:)",
                    summary: "Read-only title and string value — the settings-row workhorse.",
                    code: #"""
                    LabeledContent("Build", value: "1024")
                    """#
                ),
                TopicChild(
                    name: "LabeledContent(_:value:format:)",
                    summary: "Formats a non-string value through a FormatStyle.",
                    code: #"""
                    LabeledContent("Distance", value: meters, format: .number.precision(.fractionLength(1)))
                    LabeledContent("Updated", value: lastSync, format: .dateTime.hour().minute())
                    """#
                ),
                TopicChild(
                    name: "LabeledContent(_:content:)",
                    summary: "Puts any view on the value side of the row.",
                    code: #"""
                    LabeledContent("Status") {
                        StatusBadge(state: server.state)
                    }
                    """#
                ),
                TopicChild(
                    name: "LabeledContent(content:label:)",
                    summary: "Both sides as builders, for multi-line labels.",
                    discussion: "Extra Text lines in the label render as smaller secondary text beneath the title inside a Form, matching the system settings look.",
                    code: #"""
                    LabeledContent {
                        Text(user.handle)
                    } label: {
                        Text("Handle")
                        Text("Visible on your public profile")
                    }
                    """#
                ),
            ]
        ),
        Topic(
            name: "MultiDatePicker",
            kind: .view,
            summary: "Selects multiple, non-contiguous calendar dates.",
            discussion: "MultiDatePicker binds a Set<DateComponents> to a calendar grid where each tap toggles a date — built for booking and scheduling flows that a single-date picker can't express.",
            wwdcYear: 2022,
            platforms: [.iOS],
            code: #"""
            @State private var dates: Set<DateComponents> = []

            MultiDatePicker("Days off", selection: $dates)
            """#,
            related: ["DatePicker"]
        ),
        Topic(
            name: "EditButton",
            kind: .view,
            summary: "Toggles a list's edit mode on iOS.",
            discussion: "EditButton flips the environment's editMode, switching the enclosing List into the mode where onDelete and onMove affordances appear. Its title tracks the state automatically.",
            wwdcYear: 2019,
            platforms: [.iOS],
            code: #"""
            List { ForEach(items) { ItemRow($0) }.onDelete(perform: remove) }
                .toolbar { EditButton() }
            """#,
            related: ["List", "editMode"]
        ),
        Topic(
            name: "RenameButton",
            kind: .view,
            summary: "Triggers the standard rename action of its context.",
            discussion: "RenameButton fires whatever rename behavior the surrounding context registered via the renameAction modifier — commonly focusing the editable navigation title. It stays disabled until an action exists.",
            wwdcYear: 2022,
            code: #"""
            TextField("Name", text: $name)
                .focused($isRenaming)
                .contextMenu { RenameButton() }
                .renameAction { isRenaming = true }
            """#,
            related: [".navigationTitle()", ".contextMenu()"]
        ),
        Topic(
            name: "HelpLink",
            kind: .view,
            summary: "The round macOS help button, wired to a destination.",
            discussion: "HelpLink renders the standard question-mark button that macOS users expect in alerts and settings panes, opening a URL or running an action. Certain containers place it automatically in the platform-correct corner.",
            wwdcYear: 2023,
            platforms: [.macOS],
            code: #"""
            HelpLink(destination: URL(string: "https://example.com/help")!)
            """#,
            related: ["Link", "Settings"]
        ),
        Topic(
            name: "SettingsLink",
            kind: .view,
            summary: "A button that opens the app's Settings scene.",
            discussion: "SettingsLink replaces the old showSettingsWindow selector hack on macOS: a plain button, custom label allowed, that opens the Settings scene directly.",
            wwdcYear: 2023,
            platforms: [.macOS],
            code: #"""
            SettingsLink {
                Label("Preferences…", systemImage: "gearshape")
            }
            """#,
            related: ["Settings", "openWindow"]
        ),
        Topic(
            name: "TextFieldLink",
            kind: .view,
            summary: "watchOS text entry behind a tappable link.",
            discussion: "TextFieldLink opens the watch's system text input — dictation, scribble, or keyboard — and returns the result, since inline editable fields don't fit the wrist.",
            wwdcYear: 2022,
            platforms: [.watchOS],
            code: #"""
            TextFieldLink(prompt: Text("Name")) {
                Label("Add name", systemImage: "pencil")
            } onSubmit: { value in
                name = value
            }
            """#,
            related: ["TextField"]
        ),
        Topic(
            name: "PhaseAnimator",
            kind: .view,
            summary: "Cycles content through a sequence of animation phases.",
            discussion: "PhaseAnimator steps through the phases you list — continuously, or once per trigger change — re-rendering its content for each phase with an animation between steps. It turns multi-step effects like a shake-and-settle into declarative code.",
            wwdcYear: 2023,
            code: #"""
            PhaseAnimator([1.0, 1.3, 0.9, 1.0], trigger: taps) { scale in
                Image(systemName: "heart.fill")
                    .scaleEffect(scale)
            }
            """#,
            related: ["KeyframeAnimator", ".animation()"]
        ),
        Topic(
            name: "KeyframeAnimator",
            kind: .view,
            summary: "Animates multiple properties along keyframe tracks.",
            discussion: "KeyframeAnimator drives a value type through per-property tracks — linear, cubic, spring keyframes with independent timing — for choreography that phase-based animation can't express. The content closure renders each interpolated frame.",
            wwdcYear: 2023,
            code: #"""
            KeyframeAnimator(initialValue: Pose(), trigger: bounce) { pose in
                Ball().offset(y: pose.y).scaleEffect(pose.squash)
            } keyframes: { _ in
                KeyframeTrack(\.y) {
                    CubicKeyframe(-80, duration: 0.3)
                    SpringKeyframe(0, duration: 0.5)
                }
            }
            """#,
            related: ["PhaseAnimator", "CustomAnimation"]
        ),
        Topic(
            name: "GlassEffectContainer",
            kind: .view,
            summary: "Groups Liquid Glass shapes so they blend and morph together.",
            discussion: "Introduced with the Liquid Glass design language at WWDC '25, GlassEffectContainer lets nearby glassEffect views merge their shapes and share sampled background content, and enables morphing transitions between them via glassEffectID.",
            wwdcYear: 2025,
            code: #"""
            GlassEffectContainer(spacing: 20) {
                HStack(spacing: 20) {
                    Image(systemName: "sun.max.fill")
                        .frame(width: 60, height: 60)
                        .glassEffect()
                    Image(systemName: "moon.fill")
                        .frame(width: 60, height: 60)
                        .glassEffect()
                }
            }
            """#,
            related: [".glassEffect()", ".buttonStyle(.glass)"]
        ),
    ]

    static let moreScenes: [Topic] = [
        Topic(
            name: "DocumentGroupLaunchScene",
            kind: .scene,
            summary: "A designed launch experience for document-based iOS apps.",
            discussion: "Added at WWDC '24, DocumentGroupLaunchScene gives document apps the title-screen treatment — hero background, title, and action buttons for creating or opening documents — replacing the bare document browser as the first screen.",
            wwdcYear: 2024,
            platforms: [.iOS],
            code: #"""
            DocumentGroupLaunchScene("Sketchpad") {
                NewDocumentButton("New Sketch")
            } background: {
                Image("launch-hero").resizable().scaledToFill()
            }
            """#,
            related: ["DocumentGroup"]
        ),
    ]
}
