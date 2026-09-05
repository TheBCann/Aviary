//
//  Examples+Controls.swift
//  Aviary
//
//  Rendered usage examples for the entries in CatalogData/gen-controls.json.
//
//  Scene-level command APIs (.commands(), CommandGroup, CommandMenu,
//  SidebarCommands, MenuBarExtra styling), iOS/tvOS pointer hover effects,
//  and watchOS crown / hand-gesture APIs cannot execute inside a macOS view,
//  so those entries render an illustrative stand-in with a caption while the
//  code string shows the real API.
//
//  FocusedValues keys are prefixed `c_` so they cannot collide with keys
//  declared by other example files; the code strings show the unprefixed
//  names a real app would use.
//

import SwiftUI
import AuthenticationServices
import UniformTypeIdentifiers
internal import Combine

// MARK: - Focused value keys used by the focus examples

extension FocusedValues {
    @Entry fileprivate var c_activeDocument: String?
    @Entry fileprivate var c_activeProject: String?
    @Entry fileprivate var c_selectedTrack: String?
    @Entry fileprivate var c_volume: Binding<Double>?
}

enum ExamplesControls {
    static let entries: [ExampleEntry] = [
        ExampleEntry(topic: ".buttonBorderShape()", code: """
        Button("Follow") { follow() }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)

        Button("Continue") { advance() }
            .buttonStyle(.bordered)
            .buttonBorderShape(.roundedRectangle(radius: 6))

        Button { isMuted.toggle() } label: {
            Image(systemName: isMuted ? "speaker.slash" : "speaker.wave.2")
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.circle)
        """) { AnyView(C_ButtonBorderShapeExample()) },

        ExampleEntry(topic: ".buttonRepeatBehavior()", code: """
        Button {
            volume = max(0, volume - 1)
        } label: {
            Image(systemName: "minus.circle")
        }
        .buttonRepeatBehavior(.enabled)

        ProgressView(value: Double(volume), total: 20)
        """) { AnyView(C_ButtonRepeatBehaviorExample()) },

        ExampleEntry(topic: ".commands()", code: """
        WindowGroup {
            ContentView()
        }
        .commands {
            CommandMenu("Notes") {
                Button("New Note") { createNote() }
                    .keyboardShortcut("n", modifiers: [.command, .shift])
            }
        }
        """) { AnyView(C_CommandsExample()) },

        ExampleEntry(topic: ".commandsRemoved()", code: """
        Window("Inspector", id: "inspector") {
            InspectorPanel()
        }
        .commandsRemoved()

        WindowGroup { EditorView() }
            .commandsReplaced {
                CommandMenu("Editor") { Button("Export…") { export() } }
            }
        """) { AnyView(C_CommandsRemovedExample()) },

        ExampleEntry(topic: ".controlGroupStyle()", code: """
        ControlGroup {
            Button(action: goBack) { Label("Back", systemImage: "chevron.left") }
            Button(action: goForward) { Label("Forward", systemImage: "chevron.right") }
        }
        .controlGroupStyle(.navigation)

        ControlGroup {
            Button("Cut") { cut() }; Button("Copy") { copy() }; Button("Paste") { paste() }
        } label: { Label("Edit", systemImage: "pencil") }
        .controlGroupStyle(.menu)

        Menu("Text Style") {
            ControlGroup {
                Toggle("Bold", systemImage: "bold", isOn: $isBold)
                Toggle("Italic", systemImage: "italic", isOn: $isItalic)
            }
            .controlGroupStyle(.palette)
        }
        """) { AnyView(C_ControlGroupStyleExample()) },

        ExampleEntry(topic: ".controlSize()", code: """
        Picker("Size", selection: $size) {
            ForEach(ControlSize.allCases, id: \\.self) { Text(String(describing: $0)) }
        }
        .pickerStyle(.segmented)

        HStack {
            Button("Cancel", role: .cancel) { dismiss() }
            Button("Import") { startImport() }
                .buttonStyle(.borderedProminent)
            Toggle("Verify", isOn: $verify)
        }
        .controlSize(size)
        """) { AnyView(C_ControlSizeExample()) },

        ExampleEntry(topic: ".defaultFocus()", code: """
        @FocusState private var focusedField: Field?

        VStack {
            TextField("Title", text: $title)
                .focused($focusedField, equals: .title)
            TextField("Notes", text: $notes)
                .focused($focusedField, equals: .notes)
        }
        .defaultFocus($focusedField, .title)
        """) { AnyView(C_DefaultFocusExample()) },

        ExampleEntry(topic: ".defaultHoverEffect()", code: """
        HStack {
            ForEach(tools) { tool in
                ToolButton(tool: tool)
                    .hoverEffect()
            }
        }
        .defaultHoverEffect(.lift)
        """) { AnyView(C_DefaultHoverEffectExample()) },

        ExampleEntry(topic: ".defaultWheelPickerItemHeight()", code: """
        Picker("Minutes", selection: $minutes) {
            ForEach(0..<60, id: \\.self) { Text("\\($0)") }
        }
        .pickerStyle(.wheel)
        .defaultWheelPickerItemHeight(28)
        """) { AnyView(C_WheelPickerItemHeightExample()) },

        ExampleEntry(topic: ".digitalCrownRotation()", code: """
        Gauge(value: brightness, in: 0...100) { Text("Brightness") }
            .focusable()
            .digitalCrownRotation($brightness, from: 0, through: 100, by: 5,
                                  sensitivity: .low, isContinuous: false,
                                  isHapticFeedbackEnabled: true)
        """) { AnyView(C_DigitalCrownRotationExample()) },

        ExampleEntry(topic: ".focusable()", code: """
        StarRow(rating: rating)
            .focusable()
            .focused($isFocused)
            .onKeyPress(.space) {
                rating = min(rating + 1, 5)
                return .handled
            }
            .onMoveCommand { direction in
                if direction == .right { rating = min(rating + 1, 5) }
                if direction == .left { rating = max(rating - 1, 0) }
            }
        """) { AnyView(C_FocusableExample()) },

        ExampleEntry(topic: ".focusedObject()", code: """
        StrokeCanvas(strokes: editor.strokes)
            .focusable()
            .focusedObject(editor)

        // Reader anywhere in the window (or in a Commands body):
        @FocusedObject private var editor: EditorModel?

        Button("Clear Canvas") { editor?.clear() }
            .disabled(editor == nil)
        """) { AnyView(C_FocusedObjectExample()) },

        ExampleEntry(topic: ".focusedSceneValue()", code: """
        extension FocusedValues {
            @Entry var activeProject: String?
        }

        Picker("Project", selection: $project) { … }
            .focusedSceneValue(\\.activeProject, project)

        // Reader: available while the window is key, even with nothing focused
        @FocusedValue(\\.activeProject) private var project
        """) { AnyView(C_FocusedSceneValueExample()) },

        ExampleEntry(topic: ".focusedValue()", code: """
        extension FocusedValues {
            @Entry var activeDocument: String?
        }

        TextField("Sketch", text: $sketch)
            .focusedValue(\\.activeDocument, sketch)
        TextField("Notes", text: $notes)
            .focusedValue(\\.activeDocument, notes)

        // Reader: @FocusedValue(\\.activeDocument) private var document
        """) { AnyView(C_FocusedValueExample()) },

        ExampleEntry(topic: ".focusEffectDisabled()", code: """
        RoundedRectangle(cornerRadius: 6)
            .fill(color)
            .frame(width: 40, height: 40)
            .focusable()
            .focused($focused, equals: index)
            .focusEffectDisabled()
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .strokeBorder(.tint, lineWidth: focused == index ? 3 : 0)
            }
        """) { AnyView(C_FocusEffectDisabledExample()) },

        ExampleEntry(topic: ".focusScope()", code: """
        @Namespace private var loginScope

        VStack {
            TextField("Account", text: $account)
                .prefersDefaultFocus(in: loginScope)
                .focused($field, equals: "account")
            SecureField("Password", text: $password)
                .focused($field, equals: "password")
        }
        .focusScope(loginScope)
        """) { AnyView(C_FocusScopeExample()) },

        ExampleEntry(topic: ".focusSection()", code: """
        HStack {
            VStack {
                ForEach(categories, id: \\.self) { CategoryTile($0).focusable() }
            }
            .focusSection()

            LazyVGrid(columns: columns) {
                ForEach(episodes, id: \\.self) { EpisodeTile($0).focusable() }
            }
            .focusSection()
        }
        """) { AnyView(C_FocusSectionExample()) },

        ExampleEntry(topic: ".handGestureShortcut()", code: """
        Button {
            logWater()
        } label: {
            Label("Log Water", systemImage: "drop.fill")
        }
        .handGestureShortcut(.primaryAction)
        """) { AnyView(C_HandGestureShortcutExample()) },

        ExampleEntry(topic: ".horizontalRadioGroupLayout()", code: """
        Picker("Alignment", selection: $alignment) {
            Text("Leading").tag(TextAlignment.leading)
            Text("Center").tag(TextAlignment.center)
            Text("Trailing").tag(TextAlignment.trailing)
        }
        .pickerStyle(.radioGroup)
        .horizontalRadioGroupLayout()

        Text("The quick brown fox\\njumps over the lazy dog")
            .multilineTextAlignment(alignment)
        """) { AnyView(C_HorizontalRadioGroupLayoutExample()) },

        ExampleEntry(topic: ".hoverEffect()", code: """
        Image(systemName: "square.and.arrow.up")
            .padding(8)
            .contentShape(.hoverEffect, RoundedRectangle(cornerRadius: 10))
            .hoverEffect(.lift)

        Button("Open") { open() }
            .buttonStyle(.plain)
            .hoverEffect(.highlight)
        """) { AnyView(C_HoverEffectExample()) },

        ExampleEntry(topic: ".hoverEffectDisabled()", code: """
        DrawingCanvas()
            .hoverEffect(.highlight)
            .hoverEffectDisabled(isDrawingMode)

        Toggle("Drawing mode", isOn: $isDrawingMode)
        """) { AnyView(C_HoverEffectDisabledExample()) },

        ExampleEntry(topic: ".labeledContentStyle()", code: """
        VStack(alignment: .leading) {
            LabeledContent("Altitude", value: "1,204 m")
            LabeledContent("Heading", value: "NW 310°")
        }
        .labeledContentStyle(VerticalLabeledContentStyle())
        """) { AnyView(C_LabeledContentStyleExample()) },

        ExampleEntry(topic: ".labelsHidden()", code: """
        HStack {
            Text("Notifications")
            Spacer()
            Toggle("Enable notifications", isOn: $notificationsOn)
                .toggleStyle(.switch)
                .labelsHidden()
        }
        """) { AnyView(C_LabelsHiddenExample()) },

        ExampleEntry(topic: ".labelsVisibility()", code: """
        Picker("Labels", selection: $visibility) {
            Text("automatic").tag(Visibility.automatic)
            Text("visible").tag(Visibility.visible)
            Text("hidden").tag(Visibility.hidden)
        }
        .pickerStyle(.segmented)

        DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            .labelsVisibility(visibility)
        """) { AnyView(C_LabelsVisibilityExample()) },

        ExampleEntry(topic: ".menuActionDismissBehavior()", code: """
        Menu("Zoom") {
            Button("Zoom In") { zoom *= 1.25 }
            Button("Zoom Out") { zoom *= 0.8 }
        }
        .menuActionDismissBehavior(.disabled)   // iOS, tvOS, visionOS
        """) { AnyView(C_MenuActionDismissBehaviorExample()) },

        ExampleEntry(topic: ".menuBarExtraStyle()", code: """
        MenuBarExtra("Uptime", systemImage: "clock") {
            UptimePanel()
                .frame(width: 280)
        }
        .menuBarExtraStyle(.window)
        """) { AnyView(C_MenuBarExtraStyleExample()) },

        ExampleEntry(topic: ".menuIndicator()", code: """
        Menu("Actions") {
            Button("Duplicate") { duplicate() }
            Button("Delete", role: .destructive) { remove() }
        }

        Menu {
            Button("Duplicate") { duplicate() }
            Button("Delete", role: .destructive) { remove() }
        } label: {
            Image(systemName: "ellipsis.circle")
        }
        .menuIndicator(.hidden)
        """) { AnyView(C_MenuIndicatorExample()) },

        ExampleEntry(topic: ".menuOrder()", code: """
        Menu("Actions") {
            Button("Rename") { beginRename() }
            Button("Duplicate") { duplicate() }
            Button("Delete", role: .destructive) { remove() }
        }
        .menuOrder(.fixed)
        """) { AnyView(C_MenuOrderExample()) },

        ExampleEntry(topic: ".modifierKeyAlternate()", code: """
        Menu("File") {
            Button("Save") { save() }
                .modifierKeyAlternate(.option) {
                    Button("Save All") { saveAll() }
                }
        }
        // Works the same on items inside CommandGroup and CommandMenu
        """) { AnyView(C_ModifierKeyAlternateExample()) },

        ExampleEntry(topic: ".onContinuousHover()", code: """
        ChartSurface(crosshair: crosshair)
            .frame(width: 260, height: 110)
            .onContinuousHover { phase in
                switch phase {
                case .active(let point): crosshair = point
                case .ended: crosshair = nil
                }
            }
        """) { AnyView(C_OnContinuousHoverExample()) },

        ExampleEntry(topic: ".onCopyCommand()", code: """
        Swatch(name: selection)
            .focusable()
            .onCopyCommand {
                status = "Copied “\\(selection)”"
                return [NSItemProvider(object: selection as NSString)]
            }
            .onCutCommand {
                status = "Cut “\\(selection)”"
                return [NSItemProvider(object: selection as NSString)]
            }
        """) { AnyView(C_OnCopyCommandExample()) },

        ExampleEntry(topic: ".onDeleteCommand()", code: """
        List(tags, id: \\.self, selection: $selected) { Text($0) }
            .onDeleteCommand {
                if let selected { tags.removeAll { $0 == selected } }
                selected = nil
            }
        """) { AnyView(C_OnDeleteCommandExample()) },

        ExampleEntry(topic: ".onExitCommand()", code: """
        if isSearchPresented {
            SearchOverlay(query: $query)
                .onExitCommand {
                    isSearchPresented = false
                }
        }
        """) { AnyView(C_OnExitCommandExample()) },

        ExampleEntry(topic: ".onModifierKeysChanged()", code: """
        MapCanvas(isDuplicating: isDuplicating)
            .onModifierKeysChanged(mask: .option) { _, current in
                isDuplicating = current.contains(.option)
            }
            .onModifierKeysChanged { _, current in
                held = current            // default mask: .all
            }
        """) { AnyView(C_OnModifierKeysChangedExample()) },

        ExampleEntry(topic: ".onMoveCommand()", code: """
        GameBoard(row: row, column: column)
            .focusable()
            .onMoveCommand { direction in
                switch direction {
                case .left: column = max(column - 1, 0)
                case .right: column = min(column + 1, 2)
                case .up: row = max(row - 1, 0)
                case .down: row = min(row + 1, 2)
                @unknown default: break
                }
            }
        """) { AnyView(C_OnMoveCommandExample()) },

        ExampleEntry(topic: ".onPasteCommand()", code: """
        PasteWell(text: pasted)
            .focusable()
            .onPasteCommand(of: [.plainText, .utf8PlainText]) { providers in
                guard let provider = providers.first else { return }
                _ = provider.loadObject(ofClass: String.self) { text, _ in
                    Task { @MainActor in pasted = text ?? "" }
                }
            }
        """) { AnyView(C_OnPasteCommandExample()) },

        ExampleEntry(topic: ".onPlayPauseCommand()", code: """
        PlayerSurface(isPlaying: isPlaying)
            .focusable()
            .onPlayPauseCommand {
                isPlaying.toggle()
            }
        """) { AnyView(C_OnPlayPauseCommandExample()) },

        ExampleEntry(topic: ".paletteSelectionEffect()", code: """
        Menu("Tag") {
            Picker("Color", selection: $tagColor) {
                ForEach(TagColor.allCases) { color in
                    Label(color.name, systemImage: "circle")
                        .tint(color.color)
                        .tag(color)
                }
            }
            .pickerStyle(.palette)
            .paletteSelectionEffect(.symbolVariant(.fill))
        }
        """) { AnyView(C_PaletteSelectionEffectExample()) },

        ExampleEntry(topic: ".pointerStyle()", code: """
        DragTile()
            .pointerStyle(isDragging ? .grabActive : .grabIdle)
            .gesture(DragGesture()
                .onChanged { _ in isDragging = true }
                .onEnded { _ in isDragging = false })

        Divider().pointerStyle(.columnResize(directions: .all))
        LinkTile().pointerStyle(.link)
        ResizeTile().pointerStyle(.frameResize(position: .bottomTrailing, directions: .outward))
        """) { AnyView(C_PointerStyleExample()) },

        ExampleEntry(topic: ".prefersDefaultFocus()", code: """
        @Namespace private var playbackScope

        HStack {
            PlayTile()
                .focusable()
                .prefersDefaultFocus(in: playbackScope)
            QueueTile().focusable()
            ShuffleTile().focusable()
        }
        .focusScope(playbackScope)

        Button("Reset Focus") { resetFocus(in: playbackScope) }
        """) { AnyView(C_PrefersDefaultFocusExample()) },

        ExampleEntry(topic: ".renameAction()", code: """
        @FocusState private var isRenaming: Bool

        HStack {
            TextField("Playlist Name", text: $name)
                .focused($isRenaming)
                .contextMenu { RenameButton() }
            RenameButton()
        }
        .renameAction($isRenaming)
        """) { AnyView(C_RenameActionExample()) },

        ExampleEntry(topic: ".signInWithAppleButtonStyle()", code: """
        SignInWithAppleButton(.signUp) { request in
            request.requestedScopes = [.email]
        } onCompletion: { result in
            handle(result)
        }
        .signInWithAppleButtonStyle(.whiteOutline)   // also .black, .white
        .frame(width: 150, height: 32)
        """) { AnyView(C_SignInWithAppleButtonStyleExample()) },

        ExampleEntry(topic: ".springLoadingBehavior()", code: """
        Label("Report.pdf", systemImage: "doc.fill")
            .draggable("Report.pdf")

        Button { isOpen.toggle() } label: {
            Label(isOpen ? "Projects (open)" : "Projects",
                  systemImage: isOpen ? "folder.fill" : "folder")
        }
        .dropDestination(for: String.self) { items, _ in
            dropped += items.count
            return true
        }
        .springLoadingBehavior(.enabled)
        """) { AnyView(C_SpringLoadingBehaviorExample()) },

        ExampleEntry(topic: ".typeSelectEquivalent()", code: """
        List(people, selection: $selectedID) { person in
            HStack {
                Image(systemName: "person.crop.circle.fill")
                Text(person.givenName)
                Text(person.familyName).foregroundStyle(.secondary)
            }
            .typeSelectEquivalent(person.familyName)
        }
        """) { AnyView(C_TypeSelectEquivalentExample()) },

        ExampleEntry(topic: "@FocusedBinding", code: """
        extension FocusedValues {
            @Entry var volume: Binding<Double>?
        }

        TrackCard(volume: $volume)
            .focusable()
            .focusedValue(\\.volume, $volume)

        // Reader:
        @FocusedBinding(\\.volume) private var volume: Double?

        Button("Mute") { volume = 0 }
            .disabled(volume == nil)
        """) { AnyView(C_FocusedBindingExample()) },

        ExampleEntry(topic: "@FocusedObject", code: """
        struct ClearCanvasButton: View {   // same wrapper works in a Commands body
            @FocusedObject private var editor: EditorModel?

            var body: some View {
                Button("Clear Canvas") { editor?.clear() }
                    .disabled(editor == nil)
            }
        }

        SketchCanvas().focusable().focusedObject(sketch)
        DiagramCanvas().focusable().focusedObject(diagram)
        """) { AnyView(C_FocusedObjectWrapperExample()) },

        ExampleEntry(topic: "ButtonRole", code: """
        HStack {
            Button("Discard Changes", role: .destructive) { discard() }
            Button("Keep Editing", role: .cancel) { }
            Button("Publish", role: .confirm) { publish() }
            Button("Close", role: .close) { dismiss() }
        }
        .buttonStyle(.bordered)

        Menu("Message") {
            Button("Reply") { reply() }
            Button("Delete", role: .destructive) { remove() }
        }
        """) { AnyView(C_ButtonRoleExample()) },

        ExampleEntry(topic: "ButtonStyleConfiguration", code: """
        struct SquishyStyle: ButtonStyle {
            func makeBody(configuration: Configuration) -> some View {
                configuration.label
                    .padding(.horizontal, 14).padding(.vertical, 8)
                    .foregroundStyle(configuration.role == .destructive ? .red : .primary)
                    .background(.tint.opacity(0.15), in: Capsule())
                    .scaleEffect(configuration.isPressed ? 0.92 : 1)
                    .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
            }
        }

        Button("Save") { save() }.buttonStyle(SquishyStyle())
        Button("Delete", role: .destructive) { remove() }.buttonStyle(SquishyStyle())
        """) { AnyView(C_ButtonStyleConfigurationExample()) },

        ExampleEntry(topic: "CommandGroup", code: """
        CommandGroup(after: .newItem) {
            Button("New From Template…") { showTemplates = true }
                .keyboardShortcut("n", modifiers: [.command, .option])
        }
        """) { AnyView(C_CommandGroupExample()) },

        ExampleEntry(topic: "CommandMenu", code: """
        CommandMenu("Simulation") {
            Button("Run") { runSimulation() }
                .keyboardShortcut("r")
            Divider()
            Toggle("Show Grid", isOn: $showsGrid)
        }
        """) { AnyView(C_CommandMenuExample()) },

        ExampleEntry(topic: "FocusedValues", code: """
        extension FocusedValues {
            @Entry var selectedTrack: String?
        }

        TrackRow(track)
            .focusable()
            .focusedValue(\\.selectedTrack, track)

        // Reader:
        @FocusedValue(\\.selectedTrack) private var track
        """) { AnyView(C_FocusedValuesExample()) },

        ExampleEntry(topic: "HoverEffect", code: """
        Image(systemName: "gearshape").padding(6)
            .hoverEffect(.automatic)

        Text(tag.name).padding(.horizontal, 8)
            .contentShape(.hoverEffect, Capsule())
            .hoverEffect(.highlight)

        AppIcon(app: app)
            .hoverEffect(.lift)
        """) { AnyView(C_HoverEffectTypeExample()) },

        ExampleEntry(topic: "isFocused", code: """
        struct PosterCard: View {
            @Environment(\\.isFocused) private var isFocused

            var body: some View {
                PosterArt()
                    .scaleEffect(isFocused ? 1.08 : 1.0)
                    .animation(.easeOut(duration: 0.2), value: isFocused)
            }
        }

        HStack { ForEach(posters) { PosterCard(poster: $0).focusable() } }
        """) { AnyView(C_IsFocusedExample()) },

        ExampleEntry(topic: "KeyboardShortcut", code: """
        let saveAll = KeyboardShortcut("s", modifiers: [.command, .shift])

        HStack {
            Button("Cancel") { last = "Cancel" }
                .keyboardShortcut(.cancelAction)
            Button("Save All") { last = "Save All" }
                .keyboardShortcut(saveAll)
            Button("Sign In") { last = "Sign In" }
                .keyboardShortcut(.defaultAction)
        }
        """) { AnyView(C_KeyboardShortcutExample()) },

        ExampleEntry(topic: "LabeledContentStyle", code: """
        struct VerticalLabeledContentStyle: LabeledContentStyle {
            func makeBody(configuration: Configuration) -> some View {
                VStack(alignment: .leading, spacing: 2) {
                    configuration.label.font(.caption).foregroundStyle(.secondary)
                    configuration.content
                }
            }
        }

        VStack(alignment: .leading, spacing: 8) {
            LabeledContent("Sensor", value: "BME280")
            LabeledContent("Pressure", value: "1013 hPa")
                .labeledContentStyle(.automatic)
        }
        .labeledContentStyle(VerticalLabeledContentStyle())
        """) { AnyView(C_LabeledContentStyleProtocolExample()) },

        ExampleEntry(topic: "menuIndicatorVisibility", code: """
        struct ChromeMenuStyle: MenuStyle {
            @Environment(\\.menuIndicatorVisibility) private var indicator

            func makeBody(configuration: Configuration) -> some View {
                HStack(spacing: 6) {
                    Menu(configuration).menuIndicator(.hidden)
                    if indicator != .hidden { Image(systemName: "chevron.down") }
                }
            }
        }

        Menu("Export") { … }.menuStyle(ChromeMenuStyle())
        Menu("Export") { … }.menuStyle(ChromeMenuStyle()).menuIndicator(.hidden)
        """) { AnyView(C_MenuIndicatorVisibilityExample()) },

        ExampleEntry(topic: "resetFocus", code: """
        @Namespace private var gameScope
        @Environment(\\.resetFocus) private var resetFocus

        HStack {
            PlayTile().focusable().prefersDefaultFocus(in: gameScope)
            LevelTile().focusable()
            QuitTile().focusable()
        }
        .focusScope(gameScope)

        Button("Start Over") {
            game.reset()
            resetFocus(in: gameScope)
        }
        """) { AnyView(C_ResetFocusExample()) },

        ExampleEntry(topic: "SidebarCommands", code: """
        .commands {
            SidebarCommands()
            ToolbarCommands()
            InspectorCommands()
        }
        """) { AnyView(C_SidebarCommandsExample()) },
    ]
}

// MARK: - Shared helpers

private struct C_Caption: View {
    let text: String

    init(_ text: String) { self.text = text }

    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .frame(maxWidth: 380)
    }
}

private enum C_MenuRowStyle {
    case normal, highlighted, removed
}

private enum C_MenuRow {
    case item(String, shortcut: String? = nil, style: C_MenuRowStyle = .normal)
    case checked(String)
    case divider
}

/// A static drawing of a menu, used for scene-level command APIs that
/// cannot be rendered inside a view.
private struct C_MockMenu: View {
    let title: String
    let rows: [C_MenuRow]

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.callout.weight(.semibold))
                .padding(.horizontal, 10)
                .padding(.vertical, 3)
                .background(.tint, in: RoundedRectangle(cornerRadius: 5))
                .foregroundStyle(.white)
            VStack(alignment: .leading, spacing: 1) {
                ForEach(Array(rows.enumerated()), id: \.offset) { _, row in
                    rowView(row)
                }
            }
            .padding(5)
            .frame(width: 220, alignment: .leading)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(.separator))
        }
        .font(.callout)
    }

    @ViewBuilder
    private func rowView(_ row: C_MenuRow) -> some View {
        switch row {
        case .divider:
            Divider().padding(.vertical, 2)
        case .checked(let title):
            HStack(spacing: 6) {
                Image(systemName: "checkmark").font(.caption.bold()).frame(width: 12)
                Text(title)
            }
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
        case .item(let title, let shortcut, let style):
            HStack(spacing: 6) {
                Color.clear.frame(width: 12, height: 1)
                Text(title).strikethrough(style == .removed)
                Spacer()
                if let shortcut {
                    Text(shortcut).foregroundStyle(.secondary)
                }
            }
            .foregroundStyle(style == .removed ? Color.secondary : Color.primary)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(style == .highlighted ? Color.accentColor.opacity(0.2) : Color.clear,
                        in: RoundedRectangle(cornerRadius: 4))
        }
    }
}

/// macOS stand-in for the iOS `.lift` hover effect.
private struct C_LiftOnHover: ViewModifier {
    @State private var isHovering = false

    func body(content: Content) -> some View {
        content
            .scaleEffect(isHovering ? 1.12 : 1)
            .shadow(color: .black.opacity(isHovering ? 0.25 : 0), radius: 6, y: 3)
            .animation(.easeOut(duration: 0.15), value: isHovering)
            .onHover { isHovering = $0 }
    }
}

/// macOS stand-in for the iOS `.highlight` hover effect.
private struct C_HighlightOnHover: ViewModifier {
    var isEnabled = true
    @State private var isHovering = false

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(.primary.opacity(isHovering && isEnabled ? 0.12 : 0))
            )
            .animation(.easeOut(duration: 0.15), value: isHovering)
            .onHover { isHovering = $0 }
    }
}

private struct C_FocusTile: View {
    let title: String
    var isFocused = false

    var body: some View {
        Text(title)
            .font(.caption)
            .frame(width: 64, height: 26)
            .background(isFocused ? AnyShapeStyle(.tint) : AnyShapeStyle(.quaternary),
                        in: RoundedRectangle(cornerRadius: 6))
            .foregroundStyle(isFocused ? Color.white : Color.primary)
    }
}

private struct C_PointerTile: View {
    let title: String
    let symbol: String

    init(_ title: String, _ symbol: String) {
        self.title = title
        self.symbol = symbol
    }

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: symbol).font(.title3)
            Text(title).font(.caption)
        }
        .frame(width: 70, height: 56)
        .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
    }
}

private final class C_EditorModel: ObservableObject {
    @Published var strokes: Int
    let name: String

    init(name: String, strokes: Int) {
        self.name = name
        self.strokes = strokes
    }

    func clear() { strokes = 0 }
}

private struct C_StrokeCanvas: View {
    let strokes: Int
    let tint: Color

    var body: some View {
        Canvas { context, size in
            for index in 0..<strokes {
                let t = CGFloat(index) / CGFloat(max(strokes, 1))
                var path = Path()
                path.move(to: CGPoint(x: size.width * 0.15, y: size.height * (0.2 + 0.6 * t)))
                path.addQuadCurve(to: CGPoint(x: size.width * 0.85, y: size.height * (0.8 - 0.6 * t)),
                                  control: CGPoint(x: size.width * 0.5, y: size.height * t))
                context.stroke(path, with: .color(tint), lineWidth: 3)
            }
        }
        .frame(width: 130, height: 80)
        .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
    }
}

private struct C_FocusedObjectReader: View {
    @FocusedObject private var editor: C_EditorModel?

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(editor.map { "\($0.name): \($0.strokes) strokes" } ?? "No focused canvas")
                .font(.callout)
            Button("Clear Canvas") { editor?.clear() }
                .disabled(editor == nil)
            C_Caption("Click a canvas to focus it")
        }
    }
}

private struct C_VerticalLabeledContentStyle: LabeledContentStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            configuration.label
                .font(.caption)
                .foregroundStyle(.secondary)
            configuration.content
        }
    }
}

// MARK: - .buttonBorderShape()

private struct C_ButtonBorderShapeExample: View {
    @State private var isMuted = false

    var body: some View {
        HStack(spacing: 16) {
            Button("Follow") { }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
            Button("Continue") { }
                .buttonStyle(.bordered)
                .buttonBorderShape(.roundedRectangle(radius: 6))
            Button { isMuted.toggle() } label: {
                Image(systemName: isMuted ? "speaker.slash" : "speaker.wave.2")
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.circle)
        }
        .controlSize(.large)
    }
}

// MARK: - .buttonRepeatBehavior()

private struct C_ButtonRepeatBehaviorExample: View {
    @State private var volume = 6

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 12) {
                Button {
                    volume = max(0, volume - 1)
                } label: {
                    Image(systemName: "minus.circle")
                }
                .buttonRepeatBehavior(.enabled)

                ProgressView(value: Double(volume), total: 20)
                    .frame(width: 140)

                Button {
                    volume = min(20, volume + 1)
                } label: {
                    Image(systemName: "plus.circle")
                }
                .buttonRepeatBehavior(.enabled)
            }
            C_Caption("Volume \(volume) — hold either button to auto-repeat")
        }
    }
}

// MARK: - .commands()

private struct C_CommandsExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C_MockMenu(title: "Notes", rows: [
                .item("New Note", shortcut: "⇧⌘N", style: .highlighted),
            ])
            C_Caption("Illustrative — .commands() is a scene modifier; the declared menu appears in the real menu bar")
        }
    }
}

// MARK: - .commandsRemoved()

private struct C_CommandsRemovedExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .top, spacing: 20) {
                VStack(spacing: 4) {
                    C_MockMenu(title: "File", rows: [
                        .item("New", shortcut: "⌘N", style: .removed),
                        .item("Open…", shortcut: "⌘O", style: .removed),
                        .item("Close", shortcut: "⌘W", style: .removed),
                    ])
                    Text(".commandsRemoved()").font(.caption2.monospaced())
                }
                VStack(spacing: 4) {
                    C_MockMenu(title: "Editor", rows: [
                        .item("Export…", style: .highlighted),
                    ])
                    Text(".commandsReplaced { … }").font(.caption2.monospaced())
                }
            }
            C_Caption("Illustrative — scene modifiers; the effect shows in the real menu bar")
        }
    }
}

// MARK: - .controlGroupStyle()

private struct C_ControlGroupStyleExample: View {
    @State private var log = "—"
    @State private var isBold = false
    @State private var isItalic = false

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 20) {
                ControlGroup {
                    Button { log = "Back" } label: { Label("Back", systemImage: "chevron.left") }
                    Button { log = "Forward" } label: { Label("Forward", systemImage: "chevron.right") }
                }
                .controlGroupStyle(.navigation)

                ControlGroup {
                    Button("Cut") { log = "Cut" }
                    Button("Copy") { log = "Copy" }
                    Button("Paste") { log = "Paste" }
                } label: {
                    Label("Edit", systemImage: "pencil")
                }
                .controlGroupStyle(.menu)

                Menu("Text Style") {
                    ControlGroup {
                        Toggle("Bold", systemImage: "bold", isOn: $isBold)
                        Toggle("Italic", systemImage: "italic", isOn: $isItalic)
                    }
                    .controlGroupStyle(.palette)
                }
                .fixedSize()
            }
            Text("Sample text")
                .bold(isBold)
                .italic(isItalic)
            C_Caption("Last action: \(log)")
        }
    }
}

// MARK: - .controlSize()

private struct C_ControlSizeExample: View {
    @State private var size: ControlSize = .large
    @State private var verify = true

    var body: some View {
        VStack(spacing: 14) {
            Picker("Size", selection: $size) {
                ForEach(ControlSize.allCases, id: \.self) { Text(String(describing: $0)) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 320)

            HStack {
                Button("Cancel", role: .cancel) { }
                Button("Import") { }
                    .buttonStyle(.borderedProminent)
                Toggle("Verify", isOn: $verify)
            }
            .controlSize(size)
        }
    }
}

// MARK: - .defaultFocus()

private struct C_DefaultFocusExample: View {
    private enum Field: Hashable { case title, notes }

    @FocusState private var focusedField: Field?
    @State private var title = ""
    @State private var notes = ""

    private var focusedName: String {
        switch focusedField {
        case .title: "title"
        case .notes: "notes"
        case nil: "none"
        }
    }

    var body: some View {
        VStack(spacing: 8) {
            VStack {
                TextField("Title", text: $title)
                    .focused($focusedField, equals: .title)
                TextField("Notes", text: $notes)
                    .focused($focusedField, equals: .notes)
            }
            .defaultFocus($focusedField, .title)
            .frame(width: 260)
            C_Caption("Focused field: \(focusedName)")
        }
    }
}

// MARK: - .defaultHoverEffect()

private struct C_DefaultHoverEffectExample: View {
    private let tools = ["pencil", "paintbrush", "eraser", "lasso", "eyedropper"]

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 18) {
                ForEach(tools, id: \.self) { tool in
                    Image(systemName: tool)
                        .font(.title2)
                        .frame(width: 40, height: 40)
                        .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
                        .modifier(C_LiftOnHover())
                }
            }
            C_Caption("Illustrative — hover effects are iOS/tvOS only; .onHover lifts the hovered tool here")
        }
    }
}

// MARK: - .defaultWheelPickerItemHeight()

private struct C_WheelPickerItemHeightExample: View {
    private let rowHeight: CGFloat = 28

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                VStack(spacing: 0) {
                    ForEach(13...17, id: \.self) { minute in
                        Text("\(minute)")
                            .font(minute == 15 ? .title3.weight(.semibold) : .body)
                            .opacity(minute == 15 ? 1 : 0.45)
                            .frame(width: 70, height: rowHeight)
                    }
                }
                .foregroundStyle(.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 6)
                        .strokeBorder(.green, lineWidth: 2)
                        .frame(height: rowHeight)
                }
                .padding(.vertical, 6)
                .background(.black, in: RoundedRectangle(cornerRadius: 14))

                HStack(spacing: 4) {
                    Rectangle().fill(.green).frame(width: 1, height: rowHeight)
                    Text("28 pt").font(.caption2.monospacedDigit())
                }
            }
            C_Caption("Illustrative — wheel pickers are watchOS only; rows drawn at the requested 28 pt")
        }
    }
}

// MARK: - .digitalCrownRotation()

private struct C_DigitalCrownRotationExample: View {
    @State private var brightness = 40.0

    var body: some View {
        VStack(spacing: 8) {
            Gauge(value: brightness, in: 0...100) {
                Text("Brightness")
            } currentValueLabel: {
                Text("\(Int(brightness))")
            }
            .gaugeStyle(.accessoryCircular)
            .tint(.yellow)

            HStack(spacing: 8) {
                Image(systemName: "digitalcrown.horizontal.arrow.clockwise")
                Slider(value: $brightness, in: 0...100, step: 5) { Text("Crown") }
                    .labelsHidden()
                    .frame(width: 150)
            }
            C_Caption("Illustrative — the Digital Crown is watchOS only; the slider stands in for rotation (0–100 by 5)")
        }
    }
}

// MARK: - .focusable()

private struct C_FocusableExample: View {
    @State private var rating = 3
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 4) {
                ForEach(1...5, id: \.self) { star in
                    Image(systemName: star <= rating ? "star.fill" : "star")
                }
            }
            .font(.title2)
            .foregroundStyle(.yellow)
            .padding(8)
            .focusable()
            .focused($isFocused)
            .onKeyPress(.space) {
                rating = min(rating + 1, 5)
                return .handled
            }
            .onMoveCommand { direction in
                if direction == .right { rating = min(rating + 1, 5) }
                if direction == .left { rating = max(rating - 1, 0) }
            }
            C_Caption(isFocused ? "Focused — press Space, ← or →" : "Click the stars to focus them")
        }
    }
}

// MARK: - .focusedObject()

private struct C_FocusedObjectExample: View {
    @StateObject private var editor = C_EditorModel(name: "Canvas", strokes: 5)

    var body: some View {
        HStack(spacing: 20) {
            VStack(spacing: 6) {
                C_StrokeCanvas(strokes: editor.strokes, tint: .blue)
                    .focusable()
                    .focusedObject(editor)
                Button("Draw") { editor.strokes += 1 }
                    .controlSize(.small)
            }
            C_FocusedObjectReader()
        }
    }
}

// MARK: - .focusedSceneValue()

private struct C_FocusedSceneValueExample: View {
    @State private var project = "Aurora"

    var body: some View {
        HStack(spacing: 20) {
            Picker("Project", selection: $project) {
                ForEach(["Aurora", "Basalt", "Cinder"], id: \.self) { Text($0) }
            }
            .frame(width: 170)
            .focusedSceneValue(\.c_activeProject, project)

            C_FocusedSceneValueReader()
        }
    }
}

private struct C_FocusedSceneValueReader: View {
    @FocusedValue(\.c_activeProject) private var project

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("@FocusedValue(\\.activeProject)")
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(project ?? "nil")
                .font(.title3.monospaced())
            C_Caption("Exported for the whole window — no control needs focus")
        }
    }
}

// MARK: - .focusedValue()

private struct C_FocusedValueExample: View {
    @State private var sketch = "Sketch A"
    @State private var notes = "Meeting notes"

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                TextField("Sketch", text: $sketch)
                    .focusedValue(\.c_activeDocument, sketch)
                TextField("Notes", text: $notes)
                    .focusedValue(\.c_activeDocument, notes)
            }
            .frame(width: 320)
            C_FocusedValueReader()
        }
    }
}

private struct C_FocusedValueReader: View {
    @FocusedValue(\.c_activeDocument) private var document

    var body: some View {
        VStack(spacing: 2) {
            Text("Focused document: \(document ?? "nil")")
                .font(.callout.monospaced())
            C_Caption("Click into either field — the reader follows focus")
        }
    }
}

// MARK: - .focusEffectDisabled()

private struct C_FocusEffectDisabledExample: View {
    @FocusState private var focused: Int?
    private let colors: [Color] = [.red, .orange, .green, .blue, .purple]

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 12) {
                ForEach(colors.indices, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 6)
                        .fill(colors[index])
                        .frame(width: 40, height: 40)
                        .focusable()
                        .focused($focused, equals: index)
                        .focusEffectDisabled()
                        .overlay {
                            RoundedRectangle(cornerRadius: 6)
                                .strokeBorder(.tint, lineWidth: focused == index ? 3 : 0)
                        }
                }
            }
            C_Caption("Click a swatch, then press Tab — a custom border replaces the system focus ring")
        }
    }
}

// MARK: - .focusScope()

private struct C_FocusScopeExample: View {
    @Namespace private var loginScope
    @FocusState private var field: String?
    @State private var account = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 8) {
            VStack {
                TextField("Account", text: $account)
                    .prefersDefaultFocus(in: loginScope)
                    .focused($field, equals: "account")
                SecureField("Password", text: $password)
                    .focused($field, equals: "password")
            }
            .focusScope(loginScope)
            .frame(width: 240)
            C_Caption("Focused: \(field ?? "none") — Account is the scope's default")
        }
    }
}

// MARK: - .focusSection()

private struct C_FocusSectionExample: View {
    @FocusState private var focused: String?
    private let categories = ["Drama", "Comedy", "Sci-Fi"]
    private let episodes = ["E1", "E2", "E3", "E4", "E5", "E6"]

    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .top, spacing: 28) {
                VStack(spacing: 6) {
                    ForEach(categories, id: \.self) { name in
                        C_FocusTile(title: name, isFocused: focused == name)
                            .focusable()
                            .focused($focused, equals: name)
                    }
                }
                .focusSection()

                LazyVGrid(columns: Array(repeating: GridItem(.fixed(64)), count: 3), spacing: 6) {
                    ForEach(episodes, id: \.self) { name in
                        C_FocusTile(title: name, isFocused: focused == name)
                            .focusable()
                            .focused($focused, equals: name)
                    }
                }
                .frame(width: 210)
                .focusSection()
            }
            C_Caption("Click a tile, then use ← → to jump between the two sections even though rows do not line up")
        }
    }
}

// MARK: - .handGestureShortcut()

private struct C_HandGestureShortcutExample: View {
    @State private var glasses = 0

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 12) {
                Button {
                    glasses += 1
                } label: {
                    Label("Log Water", systemImage: "drop.fill")
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                Image(systemName: "hand.tap")
                    .font(.title2)
                    .foregroundStyle(.secondary)
            }
            Text("Logged \(glasses) glasses")
            C_Caption("Illustrative — the double-tap hand gesture is watchOS only; .handGestureShortcut(.primaryAction) is not applied here")
        }
    }
}

// MARK: - .horizontalRadioGroupLayout()

private struct C_HorizontalRadioGroupLayoutExample: View {
    @State private var alignment: TextAlignment = .center

    var body: some View {
        VStack(spacing: 12) {
            Picker("Alignment", selection: $alignment) {
                Text("Leading").tag(TextAlignment.leading)
                Text("Center").tag(TextAlignment.center)
                Text("Trailing").tag(TextAlignment.trailing)
            }
            .pickerStyle(.radioGroup)
            .horizontalRadioGroupLayout()

            Text("The quick brown fox\njumps over the lazy dog")
                .multilineTextAlignment(alignment)
                .frame(width: 240)
                .padding(8)
                .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
        }
    }
}

// MARK: - .hoverEffect()

private struct C_HoverEffectExample: View {
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 32) {
                VStack(spacing: 4) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title2)
                        .padding(8)
                        .modifier(C_LiftOnHover())
                    Text(".lift").font(.caption2.monospaced())
                }
                VStack(spacing: 4) {
                    Text("Open")
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .modifier(C_HighlightOnHover())
                    Text(".highlight").font(.caption2.monospaced())
                }
            }
            C_Caption("Illustrative — .hoverEffect() is iOS/tvOS only; .onHover stand-ins mimic the two treatments")
        }
    }
}

// MARK: - .hoverEffectDisabled()

private struct C_HoverEffectDisabledExample: View {
    @State private var isDrawingMode = false

    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 4) {
                Image(systemName: isDrawingMode ? "pencil.tip" : "cursorarrow")
                Text("Drawing canvas")
            }
            .frame(width: 220, height: 60)
            .modifier(C_HighlightOnHover(isEnabled: !isDrawingMode))
            .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(.separator))

            Toggle("Drawing mode", isOn: $isDrawingMode)
                .toggleStyle(.switch)
            C_Caption("Illustrative — iOS/tvOS only; hover the canvas, then switch on drawing mode to suppress the effect")
        }
    }
}

// MARK: - .labeledContentStyle()

private struct C_LabeledContentStyleExample: View {
    var body: some View {
        HStack(alignment: .top, spacing: 32) {
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading) {
                    LabeledContent("Altitude", value: "1,204 m")
                    LabeledContent("Heading", value: "NW 310°")
                }
                .labeledContentStyle(C_VerticalLabeledContentStyle())
                Text("custom style").font(.caption2).foregroundStyle(.secondary)
            }
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading) {
                    LabeledContent("Altitude", value: "1,204 m")
                    LabeledContent("Heading", value: "NW 310°")
                }
                .frame(width: 150)
                Text(".automatic").font(.caption2).foregroundStyle(.secondary)
            }
        }
    }
}

// MARK: - .labelsHidden()

private struct C_LabelsHiddenExample: View {
    @State private var notificationsOn = true

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Notifications")
                Spacer()
                Toggle("Enable notifications", isOn: $notificationsOn)
                    .toggleStyle(.switch)
                    .labelsHidden()
            }
            .frame(width: 240)
            .padding(10)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
            C_Caption("The label is hidden visually; VoiceOver still reads “Enable notifications”")
        }
    }
}

// MARK: - .labelsVisibility()

private struct C_LabelsVisibilityExample: View {
    @State private var visibility: Visibility = .hidden
    @State private var dueDate = Date()

    var body: some View {
        VStack(spacing: 14) {
            Picker("Labels", selection: $visibility) {
                Text("automatic").tag(Visibility.automatic)
                Text("visible").tag(Visibility.visible)
                Text("hidden").tag(Visibility.hidden)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 260)

            DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                .labelsVisibility(visibility)
        }
    }
}

// MARK: - .menuActionDismissBehavior()

private struct C_MenuActionDismissBehaviorExample: View {
    @State private var zoom = 1.0

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 24) {
                Menu("Zoom") {
                    Button("Zoom In") { zoom = min(zoom * 1.25, 2.2) }
                    Button("Zoom Out") { zoom = max(zoom * 0.8, 0.4) }
                }
                .menuActionDismissBehavior(.automatic)
                .fixedSize()

                RoundedRectangle(cornerRadius: 6)
                    .fill(.orange.gradient)
                    .frame(width: 36 * zoom, height: 36 * zoom)
                    .frame(width: 80, height: 80)
                    .animation(.easeOut(duration: 0.15), value: zoom)
            }
            C_Caption("Illustrative — .disabled is unavailable on macOS, where menus always dismiss; shown with .automatic")
        }
    }
}

// MARK: - .menuBarExtraStyle()

private struct C_MenuBarExtraStyleExample: View {
    var body: some View {
        VStack(spacing: 10) {
            VStack(alignment: .trailing, spacing: 6) {
                HStack(spacing: 14) {
                    Spacer()
                    Image(systemName: "wifi")
                    Image(systemName: "battery.75percent")
                    Image(systemName: "clock")
                        .padding(.horizontal, 6)
                        .padding(.vertical, 3)
                        .background(.quaternary, in: RoundedRectangle(cornerRadius: 4))
                    Text("Mon 9:41")
                }
                .font(.caption)
                .padding(.horizontal, 10)
                .frame(width: 300, height: 24)
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 6))

                VStack(alignment: .leading, spacing: 6) {
                    Text("Uptime").font(.headline)
                    Text("3 days, 4 hours").font(.caption)
                    ProgressView(value: 0.62)
                    Text("Load 62%").font(.caption2).foregroundStyle(.secondary)
                }
                .padding(10)
                .frame(width: 180)
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.separator))
                .padding(.trailing, 56)
            }
            C_Caption("Illustrative — a scene modifier; .window hosts arbitrary content under a real status item")
        }
    }
}

// MARK: - .menuIndicator()

private struct C_MenuIndicatorExample: View {
    @State private var last = "—"

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 24) {
                Menu("Actions") {
                    Button("Duplicate") { last = "Duplicate" }
                    Button("Delete", role: .destructive) { last = "Delete" }
                }
                .fixedSize()

                Menu {
                    Button("Duplicate") { last = "Duplicate" }
                    Button("Delete", role: .destructive) { last = "Delete" }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
                .menuIndicator(.hidden)
                .fixedSize()
            }
            C_Caption("Default indicator vs. .menuIndicator(.hidden) — last: \(last)")
        }
    }
}

// MARK: - .menuOrder()

private struct C_MenuOrderExample: View {
    @State private var last = "—"

    var body: some View {
        VStack(spacing: 10) {
            Menu("Actions") {
                Button("Rename") { last = "Rename" }
                Button("Duplicate") { last = "Duplicate" }
                Button("Delete", role: .destructive) { last = "Delete" }
            }
            .menuOrder(.fixed)
            .fixedSize()
            C_Caption("Items stay in declaration order — last: \(last). iOS may otherwise flip menus that open upward.")
        }
    }
}

// MARK: - .modifierKeyAlternate()

private struct C_ModifierKeyAlternateExample: View {
    @State private var last = "—"

    var body: some View {
        VStack(spacing: 10) {
            Menu("File") {
                Button("Save") { last = "Save" }
                    .modifierKeyAlternate(.option) {
                        Button("Save All") { last = "Save All" }
                    }
            }
            .fixedSize()
            Text("Last: \(last)")
            C_Caption("Open the menu, then hold ⌥ to swap Save for Save All")
        }
    }
}

// MARK: - .onContinuousHover()

private struct C_OnContinuousHoverExample: View {
    @State private var crosshair: CGPoint?
    private let size = CGSize(width: 260, height: 110)

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.teal.opacity(0.12))
                HStack(alignment: .bottom, spacing: 10) {
                    ForEach([30, 55, 40, 75, 60, 90, 50, 70], id: \.self) { height in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(.teal.opacity(0.35))
                            .frame(width: 14, height: CGFloat(height))
                    }
                }
                .padding(.bottom, 8)
                if let point = crosshair {
                    Path { path in
                        path.move(to: CGPoint(x: point.x, y: 0))
                        path.addLine(to: CGPoint(x: point.x, y: size.height))
                        path.move(to: CGPoint(x: 0, y: point.y))
                        path.addLine(to: CGPoint(x: size.width, y: point.y))
                    }
                    .stroke(.teal, lineWidth: 1)
                    Circle()
                        .fill(.teal)
                        .frame(width: 8, height: 8)
                        .position(point)
                }
            }
            .frame(width: size.width, height: size.height)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .onContinuousHover { phase in
                switch phase {
                case .active(let point): crosshair = point
                case .ended: crosshair = nil
                }
            }
            C_Caption(crosshair.map { "x \(Int($0.x)), y \(Int($0.y))" } ?? "Move the pointer over the surface")
        }
    }
}

// MARK: - .onCopyCommand()

private struct C_OnCopyCommandExample: View {
    @State private var selection = "Teal"
    @State private var status = "Click the swatch, then press ⌘C or ⌘X"

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 8) {
                Circle().fill(.teal).frame(width: 18, height: 18)
                Text("\(selection) swatch")
            }
            .padding(10)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
            .focusable()
            .onCopyCommand {
                status = "Copied “\(selection)” to the pasteboard"
                return [NSItemProvider(object: selection as NSString)]
            }
            .onCutCommand {
                status = "Cut “\(selection)” to the pasteboard"
                return [NSItemProvider(object: selection as NSString)]
            }
            C_Caption(status)
        }
    }
}

// MARK: - .onDeleteCommand()

private struct C_OnDeleteCommandExample: View {
    private static let allTags = ["Alpha", "Beta", "Gamma", "Delta"]

    @State private var tags = C_OnDeleteCommandExample.allTags
    @State private var selected: String?

    var body: some View {
        VStack(spacing: 8) {
            List(tags, id: \.self, selection: $selected) { Text($0) }
                .frame(width: 200, height: 100)
                .onDeleteCommand {
                    if let selected { tags.removeAll { $0 == selected } }
                    selected = nil
                }
            HStack(spacing: 12) {
                Button("Restore") { tags = Self.allTags }
                    .controlSize(.small)
                C_Caption("Select a row, then press ⌫")
            }
        }
    }
}

// MARK: - .onExitCommand()

private struct C_OnExitCommandExample: View {
    @State private var isSearchPresented = false
    @State private var query = ""
    @FocusState private var searchFocused: Bool

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.quaternary)
                Text("Document content")
                    .foregroundStyle(.secondary)
                if isSearchPresented {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search", text: $query)
                            .textFieldStyle(.plain)
                            .focused($searchFocused)
                    }
                    .padding(8)
                    .frame(width: 220)
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8))
                    .shadow(radius: 4, y: 2)
                    .onExitCommand {
                        isSearchPresented = false
                    }
                    .onAppear { searchFocused = true }
                }
            }
            .frame(width: 300, height: 80)
            Button(isSearchPresented ? "Press Esc to close" : "Show Search") {
                isSearchPresented = true
            }
            .disabled(isSearchPresented)
        }
    }
}

// MARK: - .onModifierKeysChanged()

private struct C_OnModifierKeysChangedExample: View {
    @State private var isDuplicating = false
    @State private var held: EventModifiers = []

    private var heldDescription: String {
        var parts: [String] = []
        if held.contains(.control) { parts.append("⌃") }
        if held.contains(.option) { parts.append("⌥") }
        if held.contains(.shift) { parts.append("⇧") }
        if held.contains(.command) { parts.append("⌘") }
        return parts.isEmpty ? "none" : parts.joined()
    }

    var body: some View {
        VStack(spacing: 8) {
            VStack(spacing: 6) {
                Image(systemName: isDuplicating ? "plus.square.on.square" : "arrow.up.and.down.and.arrow.left.and.right")
                    .font(.title)
                Text(isDuplicating ? "Option held — drag duplicates" : "Drag moves")
            }
            .frame(width: 260, height: 90)
            .background(isDuplicating ? Color.green.opacity(0.15) : Color.gray.opacity(0.12),
                        in: RoundedRectangle(cornerRadius: 8))
            .onModifierKeysChanged(mask: .option) { _, current in
                isDuplicating = current.contains(.option)
            }
            .onModifierKeysChanged { _, current in
                held = current
            }
            C_Caption("Held modifiers: \(heldDescription) — hold ⌥ with the pointer over the canvas")
        }
    }
}

// MARK: - .onMoveCommand()

private struct C_OnMoveCommandExample: View {
    @State private var row = 1
    @State private var column = 1
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(spacing: 8) {
            Grid(horizontalSpacing: 4, verticalSpacing: 4) {
                ForEach(0..<3, id: \.self) { r in
                    GridRow {
                        ForEach(0..<3, id: \.self) { c in
                            RoundedRectangle(cornerRadius: 4)
                                .fill(r == row && c == column ? AnyShapeStyle(.tint) : AnyShapeStyle(.quaternary))
                                .frame(width: 26, height: 26)
                        }
                    }
                }
            }
            .padding(6)
            .focusable()
            .focused($isFocused)
            .onMoveCommand { direction in
                switch direction {
                case .left: column = max(column - 1, 0)
                case .right: column = min(column + 1, 2)
                case .up: row = max(row - 1, 0)
                case .down: row = min(row + 1, 2)
                @unknown default: break
                }
            }
            C_Caption(isFocused ? "Use the arrow keys to move the token" : "Click the board to focus it")
        }
    }
}

// MARK: - .onPasteCommand()

private struct C_OnPasteCommandExample: View {
    @State private var pasted = ""
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(spacing: 8) {
            VStack(spacing: 6) {
                Image(systemName: "doc.on.clipboard")
                    .font(.title2)
                Text(pasted.isEmpty ? "Nothing pasted yet" : pasted)
                    .lineLimit(2)
                    .font(.callout)
            }
            .frame(width: 260, height: 70)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
            .focusable()
            .focused($isFocused)
            .onPasteCommand(of: [.plainText, .utf8PlainText]) { providers in
                guard let provider = providers.first else { return }
                _ = provider.loadObject(ofClass: String.self) { text, _ in
                    Task { @MainActor in pasted = text ?? "" }
                }
            }
            C_Caption(isFocused ? "Copy some text anywhere, then press ⌘V" : "Click the well to focus it")
        }
    }
}

// MARK: - .onPlayPauseCommand()

private struct C_OnPlayPauseCommandExample: View {
    @State private var isPlaying = false
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.black.gradient)
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
            }
            .frame(width: 200, height: 80)
            .focusable()
            .focused($isFocused)
            .onKeyPress(.space) {
                isPlaying.toggle()
                return .handled
            }
            C_Caption("Illustrative — the Siri Remote play/pause button is tvOS only; click the surface and press Space here")
        }
    }
}

// MARK: - .paletteSelectionEffect()

private enum C_TagColor: String, CaseIterable, Identifiable {
    case red, orange, yellow, green, blue, purple

    var id: Self { self }
    var name: String { rawValue.capitalized }

    var color: Color {
        switch self {
        case .red: .red
        case .orange: .orange
        case .yellow: .yellow
        case .green: .green
        case .blue: .blue
        case .purple: .purple
        }
    }
}

private struct C_PaletteSelectionEffectExample: View {
    @State private var tagColor: C_TagColor = .blue

    var body: some View {
        HStack(spacing: 20) {
            Menu("Tag") {
                Picker("Color", selection: $tagColor) {
                    ForEach(C_TagColor.allCases) { color in
                        Label(color.name, systemImage: "circle")
                            .tint(color.color)
                            .tag(color)
                    }
                }
                .pickerStyle(.palette)
                .paletteSelectionEffect(.symbolVariant(.fill))
            }
            .fixedSize()

            Label(tagColor.name, systemImage: "tag.fill")
                .foregroundStyle(tagColor.color)
            C_Caption("The chosen swatch shows as a filled circle")
        }
    }
}

// MARK: - .pointerStyle()

private struct C_PointerStyleExample: View {
    @State private var isDragging = false

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 16) {
                C_PointerTile(isDragging ? "Dragging" : "Drag", "hand.raised")
                    .pointerStyle(isDragging ? .grabActive : .grabIdle)
                    .gesture(DragGesture()
                        .onChanged { _ in isDragging = true }
                        .onEnded { _ in isDragging = false })

                Rectangle()
                    .fill(.separator)
                    .frame(width: 3, height: 56)
                    .pointerStyle(.columnResize(directions: .all))

                C_PointerTile("Link", "link")
                    .pointerStyle(.link)

                C_PointerTile("Resize", "arrow.up.left.and.arrow.down.right")
                    .pointerStyle(.frameResize(position: .bottomTrailing, directions: .outward))
            }
            C_Caption("Move the pointer over each item — the cursor takes the declared shape")
        }
    }
}

// MARK: - .prefersDefaultFocus()

private struct C_PrefersDefaultFocusExample: View {
    @Namespace private var playbackScope
    @Environment(\.resetFocus) private var resetFocus
    @FocusState private var focused: String?

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                C_FocusTile(title: "Play", isFocused: focused == "Play")
                    .focusable()
                    .focused($focused, equals: "Play")
                    .prefersDefaultFocus(in: playbackScope)
                C_FocusTile(title: "Queue", isFocused: focused == "Queue")
                    .focusable()
                    .focused($focused, equals: "Queue")
                C_FocusTile(title: "Shuffle", isFocused: focused == "Shuffle")
                    .focusable()
                    .focused($focused, equals: "Shuffle")
            }
            .focusScope(playbackScope)

            Button("Reset Focus") { resetFocus(in: playbackScope) }
                .controlSize(.small)
            C_Caption("Focused: \(focused ?? "none") — Reset Focus returns to Play, the scope's preferred default")
        }
    }
}

// MARK: - .renameAction()

private struct C_RenameActionExample: View {
    @State private var name = "Road Trip Mix"
    @FocusState private var isRenaming: Bool

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                TextField("Playlist Name", text: $name)
                    .focused($isRenaming)
                    .contextMenu { RenameButton() }
                RenameButton()
            }
            .renameAction($isRenaming)
            .frame(width: 300)
            C_Caption(isRenaming ? "Renaming — the field has focus" : "Click Rename (or right-click the field) to start editing")
        }
    }
}

// MARK: - .signInWithAppleButtonStyle()

private struct C_SignInWithAppleButtonStyleExample: View {
    @State private var status = "Completes only with the Sign in with Apple entitlement"

    private let styles: [(name: String, style: SignInWithAppleButton.Style)] = [
        ("black", .black), ("white", .white), ("whiteOutline", .whiteOutline),
    ]

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 14) {
                ForEach(styles, id: \.name) { entry in
                    VStack(spacing: 4) {
                        SignInWithAppleButton(.signUp) { request in
                            request.requestedScopes = [.email]
                        } onCompletion: { result in
                            switch result {
                            case .success: status = "Signed in"
                            case .failure(let error): status = error.localizedDescription
                            }
                        }
                        .signInWithAppleButtonStyle(entry.style)
                        .frame(width: 150, height: 32)
                        Text(".\(entry.name)").font(.caption2.monospaced())
                    }
                }
            }
            .padding(12)
            .background(Color.gray.opacity(0.25), in: RoundedRectangle(cornerRadius: 10))
            C_Caption(status)
        }
    }
}

// MARK: - .springLoadingBehavior()

private struct C_SpringLoadingBehaviorExample: View {
    @State private var isOpen = false
    @State private var dropped = 0

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 36) {
                Label("Report.pdf", systemImage: "doc.fill")
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(.blue.opacity(0.15), in: Capsule())
                    .draggable("Report.pdf")

                Button {
                    isOpen.toggle()
                } label: {
                    Label(isOpen ? "Projects (open)" : "Projects",
                          systemImage: isOpen ? "folder.fill" : "folder")
                }
                .dropDestination(for: String.self) { items, _ in
                    dropped += items.count
                    return true
                }
                .springLoadingBehavior(.enabled)
            }
            C_Caption("Drag the file over the folder and hover — spring loading activates the button (\(dropped) dropped)")
        }
    }
}

// MARK: - .typeSelectEquivalent()

private struct C_Person: Identifiable {
    let id: Int
    let givenName: String
    let familyName: String
}

private struct C_TypeSelectEquivalentExample: View {
    @State private var selectedID: Int?

    private let people = [
        C_Person(id: 1, givenName: "Ada", familyName: "Lovelace"),
        C_Person(id: 2, givenName: "Grace", familyName: "Hopper"),
        C_Person(id: 3, givenName: "Alan", familyName: "Turing"),
        C_Person(id: 4, givenName: "Katherine", familyName: "Johnson"),
    ]

    var body: some View {
        VStack(spacing: 8) {
            List(people, selection: $selectedID) { person in
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .foregroundStyle(.tint)
                    Text(person.givenName)
                    Text(person.familyName).foregroundStyle(.secondary)
                }
                .typeSelectEquivalent(person.familyName)
            }
            .frame(width: 240, height: 110)
            C_Caption("Click the list, then type “Ho” — rows match on the family name, not the leading given name")
        }
    }
}

// MARK: - @FocusedBinding

private struct C_FocusedBindingExample: View {
    @State private var volume = 0.6

    var body: some View {
        HStack(spacing: 20) {
            VStack(spacing: 6) {
                Label("Track 3", systemImage: "music.note")
                Slider(value: $volume) { Text("Volume") }
                    .labelsHidden()
                    .frame(width: 140)
            }
            .padding(10)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
            .focusable()
            .focusedValue(\.c_volume, $volume)

            C_FocusedBindingReader()
        }
    }
}

private struct C_FocusedBindingReader: View {
    @FocusedBinding(\.c_volume) private var volume: Double?

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(volume.map { "Volume \(Int($0 * 100))%" } ?? "No focused track")
                .font(.callout.monospacedDigit())
            Button("Mute") { volume = 0 }
                .disabled(volume == nil)
            C_Caption("Click the card to focus it; Mute writes through the binding")
        }
    }
}

// MARK: - @FocusedObject

private struct C_FocusedObjectWrapperExample: View {
    @StateObject private var sketch = C_EditorModel(name: "Sketch", strokes: 3)
    @StateObject private var diagram = C_EditorModel(name: "Diagram", strokes: 6)

    var body: some View {
        HStack(spacing: 16) {
            C_StrokeCanvas(strokes: sketch.strokes, tint: .purple)
                .focusable()
                .focusedObject(sketch)
            C_StrokeCanvas(strokes: diagram.strokes, tint: .orange)
                .focusable()
                .focusedObject(diagram)
            C_FocusedObjectReader()
        }
    }
}

// MARK: - ButtonRole

private struct C_ButtonRoleExample: View {
    @State private var last = "—"

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Button("Discard Changes", role: .destructive) { last = ".destructive" }
                Button("Keep Editing", role: .cancel) { last = ".cancel" }
                Button("Publish", role: .confirm) { last = ".confirm" }
                Button("Close", role: .close) { last = ".close" }
            }
            .buttonStyle(.bordered)

            Menu("Message") {
                Button("Reply") { last = "Reply (no role)" }
                Button("Delete", role: .destructive) { last = "Delete (.destructive)" }
            }
            .fixedSize()
            C_Caption("Last: \(last) — destructive items tint red inside the menu")
        }
    }
}

// MARK: - ButtonStyleConfiguration

private struct C_SquishyStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 14).padding(.vertical, 8)
            .foregroundStyle(configuration.role == .destructive ? .red : .primary)
            .background(.tint.opacity(0.15), in: Capsule())
            .scaleEffect(configuration.isPressed ? 0.92 : 1)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}

private struct C_ButtonStyleConfigurationExample: View {
    @State private var last = "—"

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 16) {
                Button("Save") { last = "Save" }
                    .buttonStyle(C_SquishyStyle())
                Button("Delete", role: .destructive) { last = "Delete" }
                    .buttonStyle(C_SquishyStyle())
            }
            C_Caption("Hold a button to see isPressed shrink it — last: \(last)")
        }
    }
}

// MARK: - CommandGroup

private struct C_CommandGroupExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C_MockMenu(title: "File", rows: [
                .item("New", shortcut: "⌘N"),
                .item("New From Template…", shortcut: "⌥⌘N", style: .highlighted),
                .item("Open…", shortcut: "⌘O"),
                .divider,
                .item("Close", shortcut: "⌘W"),
                .item("Save", shortcut: "⌘S"),
            ])
            C_Caption("Illustrative — CommandGroup(after: .newItem) inserts the highlighted item into the real File menu")
        }
    }
}

// MARK: - CommandMenu

private struct C_CommandMenuExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C_MockMenu(title: "Simulation", rows: [
                .item("Run", shortcut: "⌘R"),
                .divider,
                .checked("Show Grid"),
            ])
            C_Caption("Illustrative — a CommandMenu becomes a top-level menu between View and Window")
        }
    }
}

// MARK: - FocusedValues

private struct C_FocusedValuesExample: View {
    private let tracks = ["Overture", "Nocturne", "Finale"]

    var body: some View {
        HStack(spacing: 24) {
            VStack(spacing: 4) {
                ForEach(tracks, id: \.self) { track in
                    Label(track, systemImage: "music.note")
                        .frame(width: 120, alignment: .leading)
                        .padding(6)
                        .background(.quaternary, in: RoundedRectangle(cornerRadius: 6))
                        .focusable()
                        .focusedValue(\.c_selectedTrack, track)
                }
            }
            C_FocusedValuesReader()
        }
    }
}

private struct C_FocusedValuesReader: View {
    @FocusedValue(\.c_selectedTrack) private var track

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("FocusedValues.selectedTrack")
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(track ?? "nil")
                .font(.title3.monospaced())
            C_Caption("Click a track row to focus it")
        }
    }
}

// MARK: - HoverEffect

private struct C_HoverEffectTypeExample: View {
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 32) {
                VStack(spacing: 4) {
                    Image(systemName: "gearshape")
                        .padding(6)
                        .modifier(C_HighlightOnHover())
                    Text(".automatic").font(.caption2.monospaced())
                }
                VStack(spacing: 4) {
                    Text("Urgent")
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .modifier(C_HighlightOnHover())
                    Text(".highlight").font(.caption2.monospaced())
                }
                VStack(spacing: 4) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.indigo.gradient)
                        .frame(width: 44, height: 44)
                        .modifier(C_LiftOnHover())
                    Text(".lift").font(.caption2.monospaced())
                }
            }
            C_Caption("Illustrative — HoverEffect is iOS/tvOS only; .onHover stand-ins mimic each treatment")
        }
    }
}

// MARK: - isFocused

private struct C_PosterCard: View {
    @Environment(\.isFocused) private var isFocused
    let title: String
    let color: Color

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(color.gradient)
            .frame(width: 70, height: 90)
            .overlay {
                Text(title)
                    .font(.caption.bold())
                    .foregroundStyle(.white)
            }
            .scaleEffect(isFocused ? 1.08 : 1.0)
            .shadow(color: .black.opacity(isFocused ? 0.3 : 0), radius: 8, y: 4)
            .animation(.easeOut(duration: 0.2), value: isFocused)
    }
}

private struct C_IsFocusedExample: View {
    private let posters: [(title: String, color: Color)] = [
        ("Dune", .orange), ("Alien", .green), ("Heat", .blue),
    ]

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 20) {
                ForEach(posters, id: \.title) { poster in
                    C_PosterCard(title: poster.title, color: poster.color)
                        .focusable()
                }
            }
            .padding(.vertical, 6)
            C_Caption("Click a poster, then press Tab — each card reads isFocused from its own environment")
        }
    }
}

// MARK: - KeyboardShortcut

private struct C_KeyboardShortcutExample: View {
    @State private var last = "—"
    private let saveAll = KeyboardShortcut("s", modifiers: [.command, .shift])

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Button("Cancel") { last = "Cancel (Esc)" }
                    .keyboardShortcut(.cancelAction)
                Button("Save All") { last = "Save All (⇧⌘S)" }
                    .keyboardShortcut(saveAll)
                Button("Sign In") { last = "Sign In (Return)" }
                    .keyboardShortcut(.defaultAction)
            }
            C_Caption("Press Esc, ⇧⌘S, or Return while this window is key — last: \(last)")
        }
    }
}

// MARK: - LabeledContentStyle

private struct C_LabeledContentStyleProtocolExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            LabeledContent("Sensor", value: "BME280")
            LabeledContent("Pressure", value: "1013 hPa")
                .labeledContentStyle(.automatic)
        }
        .labeledContentStyle(C_VerticalLabeledContentStyle())
        .frame(width: 200)
        .padding(10)
        .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
    }
}

// MARK: - menuIndicatorVisibility

private struct C_ChromeMenuStyle: MenuStyle {
    @Environment(\.menuIndicatorVisibility) private var indicator

    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 6) {
            Menu(configuration).menuIndicator(.hidden)
            if indicator != .hidden {
                Image(systemName: "chevron.down")
                    .font(.caption.bold())
                    .foregroundStyle(.tint)
            }
        }
    }
}

private struct C_MenuIndicatorReadout: View {
    @Environment(\.menuIndicatorVisibility) private var visibility

    var body: some View {
        Text(".\(String(describing: visibility))")
            .font(.caption2.monospaced())
            .foregroundStyle(.secondary)
    }
}

private struct C_MenuIndicatorVisibilityExample: View {
    @State private var last = "—"

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 28) {
                VStack(spacing: 4) {
                    exportMenu
                    C_MenuIndicatorReadout()
                }
                VStack(spacing: 4) {
                    exportMenu
                    C_MenuIndicatorReadout()
                }
                .menuIndicator(.hidden)
            }
            .menuStyle(C_ChromeMenuStyle())
            C_Caption("The custom style reads the environment value to decide whether to draw its chevron — last: \(last)")
        }
    }

    private var exportMenu: some View {
        Menu("Export") {
            Button("PNG") { last = "PNG" }
            Button("PDF") { last = "PDF" }
        }
        .fixedSize()
    }
}

// MARK: - resetFocus

private struct C_ResetFocusExample: View {
    @Namespace private var gameScope
    @Environment(\.resetFocus) private var resetFocus
    @FocusState private var focused: String?
    @State private var score = 0

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                C_FocusTile(title: "Play", isFocused: focused == "Play")
                    .focusable()
                    .focused($focused, equals: "Play")
                    .prefersDefaultFocus(in: gameScope)
                C_FocusTile(title: "Level", isFocused: focused == "Level")
                    .focusable()
                    .focused($focused, equals: "Level")
                C_FocusTile(title: "Quit", isFocused: focused == "Quit")
                    .focusable()
                    .focused($focused, equals: "Quit")
            }
            .focusScope(gameScope)

            HStack(spacing: 12) {
                Button("Score +1") { score += 1 }
                Button("Start Over") {
                    score = 0
                    resetFocus(in: gameScope)
                }
            }
            .controlSize(.small)
            C_Caption("Score \(score) · focused: \(focused ?? "none") — Start Over sends focus back to Play")
        }
    }
}

// MARK: - SidebarCommands

private struct C_SidebarCommandsExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C_MockMenu(title: "View", rows: [
                .item("Show Sidebar", shortcut: "⌃⌘S", style: .highlighted),
                .item("Show Toolbar", shortcut: "⌥⌘T"),
                .item("Customize Toolbar…"),
                .divider,
                .item("Show Inspector", shortcut: "⌃⌘I"),
            ])
            C_Caption("Illustrative — SidebarCommands adds the highlighted item; ToolbarCommands and InspectorCommands add the rest")
        }
    }
}
