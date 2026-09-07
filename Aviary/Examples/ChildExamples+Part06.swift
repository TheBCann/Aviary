//
//  ChildExamples+Part06.swift
//  Aviary
//
//  Compiled renderings for variant entries (part 06: gen-controls).
//  One private C06_* struct per variant; every rendering exercises the exact
//  overload the variant names, so siblings can be compared side by side.
//  Scene-level and watchOS/iOS-only variants render as captioned illustrations.
//

import SwiftUI
import AppKit
import UniformTypeIdentifiers
internal import Combine

enum ChildExamplesPart06 {
    static let entries: [ChildExampleEntry] = [

        // MARK: .buttonBorderShape()

        ChildExampleEntry(parent: ".buttonBorderShape()", child: ".buttonBorderShape(.capsule)", code: """
        Button("Add to Cart") { addToCart() }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        """) { AnyView(C06_BorderShapeCapsuleExample()) },

        ChildExampleEntry(parent: ".buttonBorderShape()", child: ".buttonBorderShape(.roundedRectangle(radius:))", code: """
        Button("Continue") { advance() }
            .buttonStyle(.bordered)
            .buttonBorderShape(.roundedRectangle(radius: radius))
            .controlSize(.large)

        Slider(value: $radius, in: 0...16)
        """) { AnyView(C06_BorderShapeRoundedRectExample()) },

        ChildExampleEntry(parent: ".buttonBorderShape()", child: ".buttonBorderShape(.circle)", code: """
        Button {
            isMuted.toggle()
        } label: {
            Image(systemName: isMuted ? "speaker.slash" : "speaker.wave.2")
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.circle)
        .controlSize(.large)
        """) { AnyView(C06_BorderShapeCircleExample()) },

        // MARK: .commandsRemoved()

        ChildExampleEntry(parent: ".commandsRemoved()", child: ".commandsReplaced()", code: """
        WindowGroup { EditorView() }
            .commandsReplaced {
                CommandMenu("Editor") {
                    Button("Export…") { export() }
                }
            }
        """) { AnyView(C06_CommandsReplacedExample()) },

        // MARK: .controlGroupStyle()

        ChildExampleEntry(parent: ".controlGroupStyle()", child: ".controlGroupStyle(.navigation)", code: """
        ControlGroup {
            Button(action: goBack) { Label("Back", systemImage: "chevron.left") }
            Button(action: goForward) { Label("Forward", systemImage: "chevron.right") }
        }
        .controlGroupStyle(.navigation)
        """) { AnyView(C06_ControlGroupNavigationExample()) },

        ChildExampleEntry(parent: ".controlGroupStyle()", child: ".controlGroupStyle(.menu)", code: """
        ControlGroup {
            Button("Cut") { cut() }
            Button("Copy") { copy() }
            Button("Paste") { paste() }
        } label: {
            Label("Edit", systemImage: "pencil")
        }
        .controlGroupStyle(.menu)
        """) { AnyView(C06_ControlGroupMenuExample()) },

        ChildExampleEntry(parent: ".controlGroupStyle()", child: ".controlGroupStyle(.compactMenu)", code: """
        ControlGroup {
            Button("Sort by Name") { sort(.name) }
            Button("Sort by Date") { sort(.date) }
        } label: {
            Label("Sort", systemImage: "arrow.up.arrow.down")
        }
        .controlGroupStyle(.compactMenu)
        """) { AnyView(C06_ControlGroupCompactMenuExample()) },

        ChildExampleEntry(parent: ".controlGroupStyle()", child: ".controlGroupStyle(.palette)", code: """
        Menu("Text Style") {
            ControlGroup {
                Toggle("Bold", systemImage: "bold", isOn: $isBold)
                Toggle("Italic", systemImage: "italic", isOn: $isItalic)
                Toggle("Underline", systemImage: "underline", isOn: $isUnderlined)
            }
            .controlGroupStyle(.palette)
        }
        """) { AnyView(C06_ControlGroupPaletteExample()) },

        // MARK: .digitalCrownRotation()

        ChildExampleEntry(parent: ".digitalCrownRotation()", child: ".digitalCrownRotation(_:)", code: """
        @State private var scrollOffset = 0.0

        TimelineStrip(offset: scrollOffset)
            .focusable()
            .digitalCrownRotation($scrollOffset)   // unbounded: no range, stride, or detents
        """) { AnyView(C06_CrownUnboundedExample()) },

        ChildExampleEntry(parent: ".digitalCrownRotation()", child: ".digitalCrownRotation(_:from:through:by:sensitivity:isContinuous:isHapticFeedbackEnabled:)", code: """
        Gauge(value: brightness, in: 0...100) { Text("Brightness") }
            .focusable()
            .digitalCrownRotation($brightness, from: 0, through: 100, by: 5,
                                  sensitivity: .low, isContinuous: false,
                                  isHapticFeedbackEnabled: true)
        """) { AnyView(C06_CrownRangedExample()) },

        ChildExampleEntry(parent: ".digitalCrownRotation()", child: ".digitalCrownRotation(detent:from:through:by:sensitivity:isContinuous:isHapticFeedbackEnabled:onChange:onIdle:)", code: """
        MapPreview(zoom: zoom)
            .focusable()
            .digitalCrownRotation(detent: $zoom, from: 1, through: 4, by: 0.5,
                                  sensitivity: .medium) { event in
                crownVelocity = event.velocity
            } onIdle: {
                crownVelocity = 0
            }
        """) { AnyView(C06_CrownDetentExample()) },

        ChildExampleEntry(parent: ".digitalCrownRotation()", child: "DigitalCrownRotationalSensitivity", code: """
        Dial(angle: angle)
            .focusable()
            .digitalCrownRotation($angle, from: 0, through: 360, by: 1,
                                  sensitivity: sensitivity,   // .low, .medium, or .high
                                  isContinuous: true,
                                  isHapticFeedbackEnabled: false)
        """) { AnyView(C06_CrownSensitivityExample()) },

        // MARK: .focusable()

        ChildExampleEntry(parent: ".focusable()", child: ".focusable(_:)", code: """
        StarRow(value: rating)
            .focusable(isEditable)          // false removes it from the focus system
            .focused($isFocused)
            .onMoveCommand { direction in
                if direction == .right { rating = min(rating + 1, 5) }
                if direction == .left { rating = max(rating - 1, 0) }
            }
        Toggle("isEditable", isOn: $isEditable)
        """) { AnyView(C06_FocusableBoolExample()) },

        ChildExampleEntry(parent: ".focusable()", child: ".focusable(_:interactions:)", code: """
        ColorWell(color: color)
            .focusable(interactions: .activate)
            .focused($isFocused)
            .onKeyPress(.return) {
                showsPicker = true
                return .handled
            }
            .popover(isPresented: $showsPicker) { Palette(selection: $color) }
        """) { AnyView(C06_FocusableInteractionsExample()) },

        ChildExampleEntry(parent: ".focusable()", child: "FocusInteractions", code: """
        let interactions: FocusInteractions = [.activate, .edit]   // or .activate, .edit, .automatic

        WaveformScrubber(position: position)
            .focusable(interactions: interactions)
            .onMoveCommand { direction in           // .edit: consumes ← →
                if direction == .left { position -= 0.05 }
                if direction == .right { position += 0.05 }
            }
            .onKeyPress(.space) { isPlaying.toggle(); return .handled }   // .activate: Space
        """) { AnyView(C06_FocusInteractionsExample()) },

        // MARK: .focusedObject()

        ChildExampleEntry(parent: ".focusedObject()", child: ".focusedObject(_ object: T?)", code: """
        CanvasView()
            .focusable()
            .focusedObject(isEditing ? editorModel : nil)   // nil withdraws the export

        // Reader anywhere in the scene:
        @FocusedObject private var editor: EditorModel?
        Text(editor?.title ?? "No editor focused")
        """) { AnyView(C06_FocusedObjectOptionalExample()) },

        ChildExampleEntry(parent: ".focusedObject()", child: ".focusedSceneObject(_:)", code: """
        NavigationSplitView { Sidebar() } detail: { Detail() }
            .focusedSceneObject(projectModel)     // window-wide, no focused view needed

        // Reader (e.g. a Commands type):
        @FocusedObject private var project: ProjectModel?
        Button("Build \\(project?.name ?? "")") { }.disabled(project == nil)
        """) { AnyView(C06_FocusedSceneObjectExample()) },

        // MARK: .focusedSceneValue()

        ChildExampleEntry(parent: ".focusedSceneValue()", child: ".focusedSceneValue(_:_:)", code: """
        extension FocusedValues {
            @Entry var canvasZoom: Binding<Double>?
        }

        CanvasWindow(zoom: $zoom)
            .focusedSceneValue(\\.canvasZoom, $zoom)

        // Reader:
        @FocusedValue(\\.canvasZoom) private var canvasZoom: Binding<Double>?
        Button("Zoom In") { canvasZoom?.wrappedValue += 0.25 }
        """) { AnyView(C06_FocusedSceneValueKeyPathExample()) },

        ChildExampleEntry(parent: ".focusedSceneValue()", child: ".focusedSceneValue(_:)", code: """
        @Observable final class ProjectModel { var name = "" }

        ProjectWindow(model: model)
            .focusedSceneValue(model)          // keyed by its type, no FocusedValues extension

        // In a Commands type:
        @FocusedValue(ProjectModel.self) private var project
        """) { AnyView(C06_FocusedSceneValueObservableExample()) },

        // MARK: .focusedValue()

        ChildExampleEntry(parent: ".focusedValue()", child: ".focusedValue(_:_:)", code: """
        ForEach(tracks) { track in
            TrackRow(track: track)
                .focusable()
                .focused($focusedTrack, equals: track)
                .focusedValue(\\.selectedTrack, track)
        }

        // Reader:
        @FocusedValue(\\.selectedTrack) private var selectedTrack: Track?
        """) { AnyView(C06_FocusedValueKeyPathExample()) },

        ChildExampleEntry(parent: ".focusedValue()", child: ".focusedValue(_:)", code: """
        @Observable final class Editor { var selection: Set<Int> = [] }

        EditorCanvas(editor: editor)
            .focusable()
            .focusedValue(editor)              // type is the key

        // Reader: @FocusedValue(Editor.self) private var editor
        """) { AnyView(C06_FocusedValueObservableExample()) },

        // MARK: .hoverEffect()

        ChildExampleEntry(parent: ".hoverEffect()", child: ".hoverEffect(_:)", code: """
        Button("Open") { open() }
            .buttonStyle(.plain)
            .hoverEffect(.highlight)      // .automatic when omitted
        """) { AnyView(C06_HoverEffectExample()) },

        ChildExampleEntry(parent: ".hoverEffect()", child: ".hoverEffect(_:isEnabled:)", code: """
        ForEach(cards) { card in
            CardView(card: card)
                .hoverEffect(.lift, isEnabled: card.isSelectable)
        }
        """) { AnyView(C06_HoverEffectEnabledExample()) },

        // MARK: .onContinuousHover()

        ChildExampleEntry(parent: ".onContinuousHover()", child: ".onContinuousHover(coordinateSpace:perform:)", code: """
        ZStack(alignment: .topLeading) {
            ImageCanvas()                       // inset inside the canvas
                .onContinuousHover(coordinateSpace: .named("canvas")) { phase in
                    if case .active(let point) = phase { reticle = point } else { reticle = nil }
                }
            Reticle(at: reticle)                // positioned in canvas space
        }
        .coordinateSpace(.named("canvas"))
        """) { AnyView(C06_ContinuousHoverCoordinateSpaceExample()) },

        ChildExampleEntry(parent: ".onContinuousHover()", child: "HoverPhase", code: """
        .onContinuousHover { phase in
            switch phase {
            case .active(let location): tooltip = sample(nearest: location)
            case .ended: tooltip = nil
            }
        }
        """) { AnyView(C06_HoverPhaseExample()) },

        // MARK: .onCopyCommand()

        ChildExampleEntry(parent: ".onCopyCommand()", child: ".onCutCommand()", code: """
        TagChips(tags: tags, selection: $selection)
            .focusable()
            .onCutCommand {
                let items = selection.map { NSItemProvider(object: $0 as NSString) }
                deleteSelection()
                return items
            }
        """) { AnyView(C06_CutCommandExample()) },

        // MARK: .onMoveCommand()

        ChildExampleEntry(parent: ".onMoveCommand()", child: "MoveCommandDirection", code: """
        SelectionGrid(row: row, column: column)
            .focusable()
            .onMoveCommand { direction in
                switch direction {
                case .up:    row = max(row - 1, 0)
                case .down:  row = min(row + 1, 2)
                case .left:  column = max(column - 1, 0)
                case .right: column = min(column + 1, 2)
                @unknown default: break
                }
            }
        """) { AnyView(C06_MoveCommandDirectionExample()) },

        // MARK: .onPasteCommand()

        ChildExampleEntry(parent: ".onPasteCommand()", child: ".onPasteCommand(of:perform:)", code: """
        NoteList(notes: notes)
            .focusable()
            .onPasteCommand(of: [.plainText, .utf8PlainText]) { providers in
                for provider in providers {
                    _ = provider.loadObject(ofClass: String.self) { text, _ in
                        guard let text else { return }
                        Task { @MainActor in notes.append(text) }
                    }
                }
            }
        """) { AnyView(C06_PasteCommandExample()) },

        ChildExampleEntry(parent: ".onPasteCommand()", child: ".onPasteCommand(of:validator:perform:)", code: """
        ArtworkWell(image: artwork)
            .focusable()
            .onPasteCommand(of: [.image], validator: { providers in
                providers.count == 1 ? providers[0] : nil      // nil keeps Paste disabled
            }) { provider in
                replaceArtwork(with: provider)
            }
        """) { AnyView(C06_PasteValidatorExample()) },

        // MARK: .paletteSelectionEffect()

        ChildExampleEntry(parent: ".paletteSelectionEffect()", child: ".paletteSelectionEffect(.symbolVariant(_:))", code: """
        Menu("Flag") {
            Picker("Flag", selection: $flag) {
                ForEach(Flag.allCases) { Label($0.name, systemImage: "flag").tint($0.color).tag($0) }
            }
            .pickerStyle(.palette)
            .paletteSelectionEffect(.symbolVariant(.fill))
        }
        """) { AnyView(C06_PaletteSymbolVariantExample()) },

        ChildExampleEntry(parent: ".paletteSelectionEffect()", child: ".paletteSelectionEffect(.custom)", code: """
        Menu("Priority") {
            Picker("Priority", selection: $priority) {
                ForEach(Priority.allCases) { level in
                    Label(level.name, systemImage: level == priority ? "checkmark.circle.fill" : "circle")
                        .tag(level)
                }
            }
            .pickerStyle(.palette)
            .paletteSelectionEffect(.custom)
        }
        """) { AnyView(C06_PaletteCustomExample()) },

        // MARK: .pointerStyle()

        ChildExampleEntry(parent: ".pointerStyle()", child: "PointerStyle.grabIdle", code: """
        StickerView(sticker: sticker)
            .pointerStyle(isDragging ? .grabActive : .grabIdle)
            .gesture(
                DragGesture()
                    .onChanged { _ in isDragging = true }
                    .onEnded { _ in isDragging = false }
            )
        """) { AnyView(C06_PointerGrabExample()) },

        ChildExampleEntry(parent: ".pointerStyle()", child: "PointerStyle.columnResize(directions:)", code: """
        Rectangle()
            .fill(.separator)
            .frame(width: 1)
            .pointerStyle(.columnResize(directions: canGrow ? .all : .trailing))
        """) { AnyView(C06_PointerColumnResizeExample()) },

        ChildExampleEntry(parent: ".pointerStyle()", child: "PointerStyle.frameResize(position:directions:)", code: """
        ResizeHandle()
            .pointerStyle(.frameResize(position: .bottomTrailing, directions: .outward))
        """) { AnyView(C06_PointerFrameResizeExample()) },

        ChildExampleEntry(parent: ".pointerStyle()", child: "PointerStyle.link", code: """
        Text(citation.title)
            .underline()
            .pointerStyle(.link)
            .onTapGesture { openURL(citation.url) }
        """) { AnyView(C06_PointerLinkExample()) },

        // MARK: .renameAction()

        ChildExampleEntry(parent: ".renameAction()", child: ".renameAction(_ action:)", code: """
        ForEach($albums) { $album in
            AlbumRow(album: album, isRenaming: renamingID == album.id)
                .contextMenu { RenameButton() }
                .renameAction {                       // RenameButton invokes this closure
                    draft = album.name
                    renamingID = album.id
                }
        }
        """) { AnyView(C06_RenameActionClosureExample()) },

        ChildExampleEntry(parent: ".renameAction()", child: ".renameAction(_ isFocused:)", code: """
        @FocusState private var isEditingTitle: Bool

        HStack {
            TextField("Title", text: $title)
                .focused($isEditingTitle)
            RenameButton()
        }
        .renameAction($isEditingTitle)            // RenameButton just sets the focus binding to true
        """) { AnyView(C06_RenameActionFocusExample()) },

        ChildExampleEntry(parent: ".renameAction()", child: "RenameAction", code: """
        struct RenameControl: View {
            @Environment(\\.rename) private var rename: RenameAction?
            var body: some View {
                Button("Rename…") { rename?() }
                    .disabled(rename == nil)          // nothing supplied an action above → nil
            }
        }

        RenameControl().renameAction { beginRename() }
        RenameControl()                               // outside any .renameAction → disabled
        """) { AnyView(C06_RenameActionTypeExample()) },

        // MARK: @FocusedBinding

        ChildExampleEntry(parent: "@FocusedBinding", child: "@FocusedBinding(_:)", code: """
        extension FocusedValues {
            @Entry var volume: Binding<Double>?
        }

        PlayerPanel(volume: $volume)                  // publishes while focused
            .focusable()
            .focusedValue(\\.volume, $volume)

        // Reader — the Binding<Double>? entry is flattened to Double?
        @FocusedBinding(\\.volume) private var volume: Double?
        Button("Mute") { volume = 0 }.disabled(volume == nil)
        """) { AnyView(C06_FocusedBindingExample()) },

        ChildExampleEntry(parent: "@FocusedBinding", child: "projectedValue", code: """
        @FocusedBinding(\\.isLooping) private var isLooping: Bool?

        // $isLooping is Binding<Bool?>; unwrap it for a control that needs Binding<Bool>
        Toggle("Loop", isOn: Binding($isLooping) ?? .constant(false))
            .disabled(isLooping == nil)
        """) { AnyView(C06_FocusedBindingProjectedExample()) },

        // MARK: ButtonRole

        ChildExampleEntry(parent: "ButtonRole", child: "ButtonRole.destructive", code: """
        List(messages) { message in
            Text(message.subject)
                .swipeActions(edge: .trailing) {
                    Button("Delete", role: .destructive) { delete(message) }
                }
                .contextMenu {
                    Button("Delete", role: .destructive) { delete(message) }
                }
        }
        """) { AnyView(C06_ButtonRoleDestructiveExample()) },

        ChildExampleEntry(parent: "ButtonRole", child: "ButtonRole.cancel", code: """
        Button("Discard…") { showsDiscard = true }
            .confirmationDialog("Discard this draft?", isPresented: $showsDiscard) {
                Button("Discard Draft", role: .destructive) { discard() }
                Button("Keep Editing", role: .cancel) { }      // placed last, bound to Escape
            }
        """) { AnyView(C06_ButtonRoleCancelExample()) },

        ChildExampleEntry(parent: "ButtonRole", child: "ButtonRole.confirm", code: """
        Button("Publish…") { showsPublish = true }
            .alert("Publish this post?", isPresented: $showsPublish) {
                Button("Publish", role: .confirm) { publish() }   // the affirmative choice
                Button("Not Yet", role: .cancel) { }
            }
        """) { AnyView(C06_ButtonRoleConfirmExample()) },

        ChildExampleEntry(parent: "ButtonRole", child: "ButtonRole.close", code: """
        Button("Settings…") { showsSettings = true }
            .sheet(isPresented: $showsSettings) {
                SettingsForm()
                    .toolbar {
                        Button("Close", role: .close) { showsSettings = false }   // close glyph in toolbars
                    }
            }
        """) { AnyView(C06_ButtonRoleCloseExample()) },

        // MARK: ButtonStyleConfiguration

        ChildExampleEntry(parent: "ButtonStyleConfiguration", child: "label", code: """
        struct PillStyle: ButtonStyle {
            func makeBody(configuration: Configuration) -> some View {
                configuration.label                   // whatever the button was created with
                    .foregroundStyle(.white)
                    .padding(.horizontal, 14).padding(.vertical, 8)
                    .background(.tint, in: Capsule())
            }
        }

        Button("Follow") { }.buttonStyle(PillStyle())
        Button { } label: { Label("Share", systemImage: "square.and.arrow.up") }.buttonStyle(PillStyle())
        """) { AnyView(C06_ButtonConfigLabelExample()) },

        ChildExampleEntry(parent: "ButtonStyleConfiguration", child: "isPressed", code: """
        struct PressStyle: ButtonStyle {
            func makeBody(configuration: Configuration) -> some View {
                configuration.label
                    .padding(.horizontal, 14).padding(.vertical, 8)
                    .background(.tint.opacity(configuration.isPressed ? 0.35 : 0.15), in: Capsule())
                    .opacity(configuration.isPressed ? 0.55 : 1)     // true only while held down
                    .offset(y: configuration.isPressed ? 1 : 0)
                    .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
            }
        }

        Button("Hold Me") { presses += 1 }.buttonStyle(PressStyle())
        """) { AnyView(C06_ButtonConfigPressedExample()) },

        ChildExampleEntry(parent: "ButtonStyleConfiguration", child: "role", code: """
        struct RoleAwareStyle: ButtonStyle {
            func makeBody(configuration: Configuration) -> some View {
                configuration.label
                    .foregroundStyle(configuration.role == .destructive ? Color.red : Color.primary)
                    .fontWeight(configuration.role == .cancel ? .regular : .semibold)
                    .padding(.horizontal, 12).padding(.vertical, 6)
                    .background(.quaternary, in: Capsule())
            }
        }

        Button("Save") { }.buttonStyle(RoleAwareStyle())                        // role == nil
        Button("Delete", role: .destructive) { }.buttonStyle(RoleAwareStyle())
        Button("Cancel", role: .cancel) { }.buttonStyle(RoleAwareStyle())
        """) { AnyView(C06_ButtonConfigRoleExample()) },

        // MARK: CommandGroup

        ChildExampleEntry(parent: "CommandGroup", child: "CommandGroupPlacement", code: """
        .commands {
            CommandGroup(replacing: .appInfo) {          // App menu: About…
                Button("About PixelForge") { showAbout = true }
            }
            CommandGroup(after: .newItem) {              // File menu, below New
                Button("New from Clipboard") { newFromClipboard() }
            }
            CommandGroup(before: .help) {                // Help menu, above the app's Help item
                Button("Release Notes") { openReleaseNotes() }
            }
        }
        """) { AnyView(C06_CommandGroupPlacementExample()) },

        ChildExampleEntry(parent: "CommandGroup", child: "CommandGroup(before:addition:)", code: """
        WindowGroup { EditorView() }
            .commands {
                CommandGroup(before: .help) {
                    Button("Release Notes") { openReleaseNotes() }
                }
            }
        """) { AnyView(C06_CommandGroupBeforeExample()) },

        ChildExampleEntry(parent: "CommandGroup", child: "CommandGroup(after:addition:)", code: """
        .commands {
            CommandGroup(after: .pasteboard) {
                Divider()
                Button("Paste as Plain Text") { pastePlainText() }
                    .keyboardShortcut("v", modifiers: [.command, .shift, .option])
            }
        }
        """) { AnyView(C06_CommandGroupAfterExample()) },

        ChildExampleEntry(parent: "CommandGroup", child: "CommandGroup(replacing:addition:)", code: """
        .commands {
            CommandGroup(replacing: .appSettings) {
                Button("Preferences…") { openWindow(id: "prefs") }
                    .keyboardShortcut(",")
            }
        }
        """) { AnyView(C06_CommandGroupReplacingExample()) },

        // MARK: FocusedValues

        ChildExampleEntry(parent: "FocusedValues", child: "FocusedValueKey", code: """
        struct SelectedSensorKey: FocusedValueKey {
            typealias Value = String
        }
        extension FocusedValues {
            var selectedSensor: String? {
                get { self[SelectedSensorKey.self] }
                set { self[SelectedSensorKey.self] = newValue }
            }
        }

        SensorChip(name: name).focusable().focusedValue(\\.selectedSensor, name)
        @FocusedValue(\\.selectedSensor) private var selectedSensor: String?     // reader
        """) { AnyView(C06_FocusedValueKeyExample()) },

        ChildExampleEntry(parent: "FocusedValues", child: "@Entry", code: """
        extension FocusedValues {
            @Entry var playbackRate: Binding<Double>?     // key type + accessor in one line
        }

        PlayerView(rate: $rate)
            .focusable()
            .focusedValue(\\.playbackRate, $rate)

        @FocusedBinding(\\.playbackRate) private var rate: Double?               // reader
        """) { AnyView(C06_FocusedValuesEntryExample()) },

        // MARK: HoverEffect

        ChildExampleEntry(parent: "HoverEffect", child: "HoverEffect.automatic", code: """
        Image(systemName: "gearshape")
            .padding(6)
            .hoverEffect(.automatic)      // the system picks .highlight or .lift for the view
        """) { AnyView(C06_HoverEffectAutomaticExample()) },

        ChildExampleEntry(parent: "HoverEffect", child: "HoverEffect.highlight", code: """
        Text(tag.name)
            .padding(.horizontal, 8)
            .contentShape(.hoverEffect, Capsule())
            .hoverEffect(.highlight)      // the pointer morphs into a platter behind the content
        """) { AnyView(C06_HoverEffectHighlightExample()) },

        ChildExampleEntry(parent: "HoverEffect", child: "HoverEffect.lift", code: """
        AppIcon(app: app)
            .hoverEffect(.lift)           // scales up slightly and hides the pointer beneath
        """) { AnyView(C06_HoverEffectLiftExample()) },

        // MARK: KeyboardShortcut

        ChildExampleEntry(parent: "KeyboardShortcut", child: "KeyboardShortcut(_:modifiers:)", code: """
        let toggleSidebar = KeyboardShortcut("s", modifiers: [.command, .control])   // ⌃⌘S

        Button("Toggle Sidebar") { showsSidebar.toggle() }
            .keyboardShortcut(toggleSidebar)
        """) { AnyView(C06_KeyboardShortcutInitExample()) },

        ChildExampleEntry(parent: "KeyboardShortcut", child: "KeyboardShortcut(_:modifiers:localization:)", code: """
        let previousTab = KeyboardShortcut("[", modifiers: .command, localization: .withoutMirroring)
        let nextTab     = KeyboardShortcut("]", modifiers: .command, localization: .withoutMirroring)

        Button("Previous Tab") { selectedTab = max(selectedTab - 1, 0) }
            .keyboardShortcut(previousTab)
        Button("Next Tab") { selectedTab = min(selectedTab + 1, tabs.count - 1) }
            .keyboardShortcut(nextTab)
        """) { AnyView(C06_KeyboardShortcutLocalizationExample()) },

        ChildExampleEntry(parent: "KeyboardShortcut", child: "KeyboardShortcut.defaultAction", code: """
        TextField("Account name", text: $name)
        HStack {
            Button("Cancel") { status = "Cancelled" }
                .keyboardShortcut(.cancelAction)
            Button("Sign In") { signIn() }
                .keyboardShortcut(.defaultAction)   // Return; drawn as the prominent default on macOS
        }
        """) { AnyView(C06_KeyboardShortcutDefaultExample()) },

        ChildExampleEntry(parent: "KeyboardShortcut", child: "KeyboardShortcut.cancelAction", code: """
        Button("Export…") { showsExport = true }
            .sheet(isPresented: $showsExport) {
                VStack {
                    ExportOptions(format: $format)
                    HStack {
                        Button("Cancel") { showsExport = false }
                            .keyboardShortcut(.cancelAction)   // Escape dismisses the sheet
                        Button("Export") { export(); showsExport = false }
                            .keyboardShortcut(.defaultAction)
                    }
                }
            }
        """) { AnyView(C06_KeyboardShortcutCancelExample()) },

        // MARK: LabeledContentStyle

        ChildExampleEntry(parent: "LabeledContentStyle", child: "makeBody(configuration:)", code: """
        struct InspectorRowStyle: LabeledContentStyle {
            func makeBody(configuration: Configuration) -> some View {
                HStack(alignment: .firstTextBaseline) {
                    configuration.label
                        .foregroundStyle(.secondary)
                        .frame(width: 90, alignment: .trailing)
                    configuration.content
                }
            }
        }

        LabeledContent("Name", value: "Hero Banner")
        LabeledContent("Opacity") { Slider(value: $opacity, in: 0...1) }
            .labeledContentStyle(InspectorRowStyle())
        """) { AnyView(C06_LabeledContentMakeBodyExample()) },

        ChildExampleEntry(parent: "LabeledContentStyle", child: "LabeledContentStyleConfiguration", code: """
        struct VerticalLabeledContentStyle: LabeledContentStyle {
            func makeBody(configuration: Configuration) -> some View {   // Configuration == LabeledContentStyleConfiguration
                VStack(alignment: .leading, spacing: 2) {
                    configuration.label.font(.caption.smallCaps()).foregroundStyle(.secondary)
                    configuration.content.font(.body.monospacedDigit())
                }
            }
        }

        LabeledContent("Pressure", value: "1013 hPa")
            .labeledContentStyle(VerticalLabeledContentStyle())
        """) { AnyView(C06_LabeledContentConfigurationExample()) },

        ChildExampleEntry(parent: "LabeledContentStyle", child: "LabeledContentStyle.automatic", code: """
        VStack(alignment: .leading) {
            LabeledContent("Sensor", value: "BME280")
            LabeledContent("Firmware", value: "2.4.1")
            GroupBox("Raw") {
                LabeledContent("Pressure", value: "1013 hPa")
                LabeledContent("Humidity", value: "41 %")
            }
            .labeledContentStyle(.automatic)          // restores the default inside this subtree
        }
        .labeledContentStyle(VerticalLabeledContentStyle())
        """) { AnyView(C06_LabeledContentAutomaticExample()) },

        // MARK: SidebarCommands

        ChildExampleEntry(parent: "SidebarCommands", child: "ToolbarCommands", code: """
        WindowGroup { MainView().toolbar { EditorToolbar() } }
            .commands {
                ToolbarCommands()        // View ▸ Show/Hide Toolbar, Customize Toolbar…
            }
        """) { AnyView(C06_ToolbarCommandsExample()) },

        ChildExampleEntry(parent: "SidebarCommands", child: "TextEditingCommands", code: """
        WindowGroup { NotesEditor() }
            .commands {
                TextEditingCommands()    // Edit ▸ Find, Spelling and Grammar, Substitutions, Transformations, Speech
            }
        """) { AnyView(C06_TextEditingCommandsExample()) },

        ChildExampleEntry(parent: "SidebarCommands", child: "TextFormattingCommands", code: """
        WindowGroup { RichTextEditor() }
            .commands {
                TextFormattingCommands() // adds a Format menu: Font ▸, Text ▸
            }
        """) { AnyView(C06_TextFormattingCommandsExample()) },

        ChildExampleEntry(parent: "SidebarCommands", child: "InspectorCommands", code: """
        NavigationSplitView { Sidebar() } detail: { Detail() }
            .inspector(isPresented: $showsInspector) { InspectorPane() }

        // In the scene:
        .commands { InspectorCommands() }   // View ▸ Show/Hide Inspector  ⌃⌘I
        """) { AnyView(C06_InspectorCommandsExample()) },

        // C06_ENTRIES_END
    ]
}

// MARK: - Shared helpers

private struct C06_Caption: View {
    let text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
    }
}

/// A mock menu-bar strip for Scene-level illustrations.
private struct C06_MenuBarMock: View {
    let title: String
    let menus: [String]
    var highlighted: Set<String> = []
    var appName = "Notes"

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title).font(.caption2).foregroundStyle(.secondary)
            HStack(spacing: 12) {
                Image(systemName: "apple.logo")
                ForEach([appName] + menus, id: \.self) { menu in
                    Text(menu)
                        .bold(menu == appName)
                        .padding(.horizontal, 6).padding(.vertical, 2)
                        .background(highlighted.contains(menu) ? Color.accentColor.opacity(0.25) : .clear,
                                    in: RoundedRectangle(cornerRadius: 4))
                }
            }
            .font(.callout)
            .padding(.horizontal, 10).padding(.vertical, 4)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.bar, in: RoundedRectangle(cornerRadius: 6))
        }
    }
}

/// A mock dropped-down menu for Scene-level illustrations. "-" renders a divider.
private struct C06_MenuMock: View {
    let title: String
    let items: [String]
    var highlighted: Set<String> = []

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.caption.bold())
                .padding(.horizontal, 10).padding(.vertical, 4)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.quaternary)
            ForEach(Array(items.enumerated()), id: \.offset) { _, item in
                if item == "-" {
                    Divider().padding(.vertical, 2)
                } else {
                    // "Title\t⌘S" renders the part after the tab as a trailing shortcut / submenu chevron.
                    let parts = item.split(separator: "\t", maxSplits: 1).map(String.init)
                    HStack(spacing: 8) {
                        Text(parts.first ?? item)
                        Spacer(minLength: 0)
                        if parts.count > 1 {
                            Text(parts[1]).foregroundStyle(.secondary)
                        }
                    }
                    .font(.callout)
                    .padding(.horizontal, 10).padding(.vertical, 3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(highlighted.contains(item) ? Color.accentColor.opacity(0.18) : .clear)
                }
            }
        }
        .frame(width: 190)
        .background(.background, in: RoundedRectangle(cornerRadius: 8))
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.separator))
    }
}

/// A mock Apple Watch bezel with a Digital Crown whose ridges shift with `crown`.
private struct C06_WatchMock<Content: View>: View {
    let crown: Double
    @ViewBuilder let content: () -> Content

    var body: some View {
        HStack(alignment: .top, spacing: 4) {
            content()
                .frame(width: 150, height: 110)
                .background(.black, in: RoundedRectangle(cornerRadius: 26))
                .overlay(RoundedRectangle(cornerRadius: 26).stroke(.gray.opacity(0.6), lineWidth: 3))
            RoundedRectangle(cornerRadius: 3)
                .fill(.gray.gradient)
                .frame(width: 9, height: 30)
                .overlay {
                    VStack(spacing: 4) {
                        ForEach(0..<7, id: \.self) { _ in
                            Rectangle().fill(.black.opacity(0.35)).frame(height: 1)
                        }
                    }
                    .offset(y: crown.truncatingRemainder(dividingBy: 5))
                }
                .clipShape(RoundedRectangle(cornerRadius: 3))
                .padding(.top, 18)
        }
    }
}

// MARK: - .buttonBorderShape()

private struct C06_BorderShapeCapsuleExample: View {
    @State private var count = 0

    var body: some View {
        VStack(spacing: 12) {
            Button("Add to Cart") { count += 1 }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
            Text(count == 0 ? "Cart is empty" : "\(count) in cart")
                .font(.callout)
                .foregroundStyle(.secondary)
            C06_Caption("Fully semicircular ends — compare .roundedRectangle(radius:) and .circle.")
        }
    }
}

private struct C06_BorderShapeRoundedRectExample: View {
    @State private var radius = 6.0
    @State private var step = 1

    var body: some View {
        VStack(spacing: 12) {
            Button("Continue") { step += 1 }
                .buttonStyle(.bordered)
                .buttonBorderShape(.roundedRectangle(radius: radius))
                .controlSize(.large)
            Slider(value: $radius, in: 0...16) { Text("Radius") }
                .frame(width: 200)
            Text("radius: \(radius, specifier: "%.0f") pt  •  step \(step)")
                .font(.callout.monospacedDigit())
                .foregroundStyle(.secondary)
            C06_Caption("You pick the corner radius instead of the platform default.")
        }
    }
}

private struct C06_BorderShapeCircleExample: View {
    @State private var isMuted = false

    var body: some View {
        VStack(spacing: 12) {
            Button {
                isMuted.toggle()
            } label: {
                Image(systemName: isMuted ? "speaker.slash" : "speaker.wave.2")
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.circle)
            .controlSize(.large)
            Text(isMuted ? "Muted" : "Sound on")
                .font(.callout)
                .foregroundStyle(.secondary)
            C06_Caption("A circular platter suits icon-only toggles.")
        }
    }
}

// MARK: - .commandsRemoved()

private struct C06_CommandsReplacedExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            C06_MenuBarMock(title: "WindowGroup by default", menus: ["File", "Edit", "View", "Window", "Help"])
            C06_MenuBarMock(title: "After .commandsReplaced { CommandMenu(\"Editor\") … }",
                            menus: ["Editor"], highlighted: ["Editor"])
            C06_MenuMock(title: "Editor", items: ["Export…"])
            C06_Caption("Illustrative — applies at the Scene level: the built-in menus are replaced, not just removed.")
        }
        .frame(maxWidth: 360)
    }
}

// MARK: - .controlGroupStyle()

private struct C06_ControlGroupNavigationExample: View {
    @State private var page = 3

    var body: some View {
        VStack(spacing: 12) {
            ControlGroup {
                Button(action: { page = max(page - 1, 1) }) { Label("Back", systemImage: "chevron.left") }
                    .disabled(page == 1)
                Button(action: { page = min(page + 1, 9) }) { Label("Forward", systemImage: "chevron.right") }
                    .disabled(page == 9)
            }
            .controlGroupStyle(.navigation)
            .fixedSize()
            Text("Page \(page) of 9")
                .font(.callout.monospacedDigit())
            C06_Caption("The joined back/forward chrome the system uses for history controls.")
        }
    }
}

private struct C06_ControlGroupMenuExample: View {
    @State private var last = "Nothing yet"

    var body: some View {
        VStack(spacing: 12) {
            ControlGroup {
                Button("Cut") { last = "Cut" }
                Button("Copy") { last = "Copy" }
                Button("Paste") { last = "Paste" }
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            .controlGroupStyle(.menu)
            .fixedSize()
            Text("Last action: \(last)")
                .font(.callout)
                .foregroundStyle(.secondary)
            C06_Caption("Every member collapses into one menu whose trigger is the label view.")
        }
    }
}

private struct C06_ControlGroupCompactMenuExample: View {
    @State private var sortKey = "Name"

    var body: some View {
        VStack(spacing: 12) {
            ControlGroup {
                Button("Sort by Name") { sortKey = "Name" }
                Button("Sort by Date") { sortKey = "Date" }
            } label: {
                Label("Sort", systemImage: "arrow.up.arrow.down")
            }
            .controlGroupStyle(.compactMenu)
            .fixedSize()
            Text("Sorted by \(sortKey)")
                .font(.callout)
                .foregroundStyle(.secondary)
            C06_Caption("A condensed trigger; nested inside another menu it becomes a submenu.")
        }
    }
}

private struct C06_ControlGroupPaletteExample: View {
    @State private var isBold = false
    @State private var isItalic = false
    @State private var isUnderlined = false

    var body: some View {
        VStack(spacing: 12) {
            Menu("Text Style") {
                ControlGroup {
                    Toggle("Bold", systemImage: "bold", isOn: $isBold)
                    Toggle("Italic", systemImage: "italic", isOn: $isItalic)
                    Toggle("Underline", systemImage: "underline", isOn: $isUnderlined)
                }
                .controlGroupStyle(.palette)
            }
            .fixedSize()
            Text("The quick brown fox")
                .font(.title3)
                .bold(isBold)
                .italic(isItalic)
                .underline(isUnderlined)
            C06_Caption("Open the menu: the toggles appear as a horizontal icon strip.")
        }
    }
}

// MARK: - .digitalCrownRotation()

private struct C06_CrownUnboundedExample: View {
    @State private var scrollOffset = 0.0

    var body: some View {
        VStack(spacing: 10) {
            C06_WatchMock(crown: scrollOffset) {
                HStack(spacing: 14) {
                    ForEach(0..<24, id: \.self) { hour in
                        VStack(spacing: 2) {
                            Rectangle().fill(.white)
                                .frame(width: 1, height: hour % 3 == 0 ? 16 : 8)
                            if hour % 3 == 0 {
                                Text("\(hour)h").font(.system(size: 8)).foregroundStyle(.white)
                            }
                        }
                    }
                }
                .offset(x: 60 - scrollOffset)
                .frame(width: 140, alignment: .leading)
                .clipped()
            }
            Slider(value: $scrollOffset, in: -150...300) { Text("Crown") }
                .frame(width: 220)
            Text("scrollOffset = \(scrollOffset, specifier: "%.0f") — no bounds, keeps accumulating")
                .font(.caption.monospacedDigit())
            C06_Caption("Illustrative — watchOS only; the slider stands in for crown rotation.")
        }
    }
}

private struct C06_CrownRangedExample: View {
    @State private var brightness = 60.0

    var body: some View {
        VStack(spacing: 10) {
            C06_WatchMock(crown: brightness) {
                Gauge(value: brightness, in: 0...100) {
                    Text("Brightness")
                } currentValueLabel: {
                    Text("\(Int(brightness))%")
                }
                .gaugeStyle(.accessoryCircular)
                .tint(.yellow)
                .foregroundStyle(.white)
            }
            Slider(value: $brightness, in: 0...100, step: 5) { Text("Crown") }
                .frame(width: 220)
            Text("from 0 through 100, by 5 — value snaps to the stride")
                .font(.caption.monospacedDigit())
            C06_Caption("Illustrative — watchOS only; sensitivity .low, no wrap-around, haptic detents.")
        }
    }
}

private struct C06_CrownDetentExample: View {
    @State private var zoom = 2.0
    @State private var crownVelocity = 0.0

    var body: some View {
        VStack(spacing: 10) {
            C06_WatchMock(crown: zoom * 10) {
                Image(systemName: "map.fill")
                    .font(.system(size: 22))
                    .foregroundStyle(.green)
                    .scaleEffect(zoom)
                    .frame(width: 130, height: 100)
                    .clipped()
            }
            Slider(value: $zoom, in: 1...4, step: 0.5) { Text("Crown") }
                .frame(width: 220)
                .onChange(of: zoom) { oldValue, newValue in
                    crownVelocity = (newValue - oldValue) * 20
                }
            Text("detent \(zoom, specifier: "%.1f")×   velocity \(crownVelocity, specifier: "%+.0f")")
                .font(.caption.monospacedDigit())
            C06_Caption("Illustrative — watchOS 9+; onChange reports each event's velocity, onIdle fires when rotation stops.")
        }
    }
}

private struct C06_CrownSensitivityExample: View {
    @State private var sensitivity = "high"
    @State private var crownTravel = 0.0

    private var degreesPerUnit: Double {
        switch sensitivity {
        case "low": 3
        case "medium": 1.5
        default: 0.5
        }
    }
    private var angle: Double { (crownTravel * degreesPerUnit).truncatingRemainder(dividingBy: 360) }

    var body: some View {
        VStack(spacing: 10) {
            C06_WatchMock(crown: crownTravel) {
                ZStack {
                    Circle().stroke(.gray, lineWidth: 2).frame(width: 70, height: 70)
                    Capsule().fill(.orange).frame(width: 4, height: 32)
                        .offset(y: -16)
                        .rotationEffect(.degrees(angle))
                }
            }
            Picker("sensitivity", selection: $sensitivity) {
                Text(".low").tag("low")
                Text(".medium").tag("medium")
                Text(".high").tag("high")
            }
            .pickerStyle(.segmented)
            .frame(width: 220)
            Slider(value: $crownTravel, in: 0...120) { Text("Crown") }
                .frame(width: 220)
            Text("same crown travel → \(angle, specifier: "%.0f")° (.low sweeps coarsely, .high adjusts finely)")
                .font(.caption.monospacedDigit())
            C06_Caption("Illustrative — watchOS only; the slider stands in for crown rotation.")
        }
    }
}

// MARK: - Focus support types

private struct C06_Track: Hashable, Identifiable {
    let title: String
    let artist: String
    var id: String { title }
}

extension FocusedValues {
    @Entry fileprivate var selectedTrack: C06_Track?
    @Entry fileprivate var canvasZoom: Binding<Double>?
    @Entry fileprivate var volume: Binding<Double>?
    @Entry fileprivate var isLooping: Binding<Bool>?
    @Entry fileprivate var playbackRate: Binding<Double>?
}

private final class C06_EditorModel: ObservableObject {
    @Published var title: String
    init(title: String) { self.title = title }
}

private final class C06_ProjectModel: ObservableObject {
    @Published var name: String
    init(name: String) { self.name = name }
}

@Observable private final class C06_ObservableProject {
    var name: String
    init(name: String) { self.name = name }
}

@Observable private final class C06_Editor {
    var selection: Set<Int> = []
}

private struct C06_FocusRing: ViewModifier {
    let isFocused: Bool
    func body(content: Content) -> some View {
        content
            .background(isFocused ? Color.accentColor.opacity(0.12) : Color.clear,
                        in: RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8)
                .stroke(isFocused ? Color.accentColor : Color.secondary.opacity(0.35),
                        lineWidth: isFocused ? 2 : 1))
    }
}

extension View {
    fileprivate func c06FocusRing(_ isFocused: Bool) -> some View {
        modifier(C06_FocusRing(isFocused: isFocused))
    }
}

// MARK: - .focusable()

private struct C06_FocusableBoolExample: View {
    @State private var rating = 3
    @State private var isEditable = true
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 4) {
                ForEach(1...5, id: \.self) { star in
                    Image(systemName: star <= rating ? "star.fill" : "star")
                }
            }
            .font(.title2)
            .foregroundStyle(.yellow)
            .padding(8)
            .c06FocusRing(isFocused)
            .focusable(isEditable)
            .focused($isFocused)
            .onMoveCommand { direction in
                if direction == .right { rating = min(rating + 1, 5) }
                if direction == .left { rating = max(rating - 1, 0) }
            }
            .onTapGesture { isFocused = true }
            Toggle("isEditable", isOn: $isEditable)
                .toggleStyle(.switch)
            Text(statusText)
                .font(.callout)
                .foregroundStyle(.secondary)
            C06_Caption("Click the stars to focus them, then use ← → to change the rating.")
        }
    }

    private var statusText: String {
        if !isEditable { return "focusable(false): the row is out of the focus system" }
        return isFocused ? "Focused — arrow keys adjust the rating" : "Not focused"
    }
}

private struct C06_FocusableInteractionsExample: View {
    @State private var color = Color.teal
    @State private var showsPicker = false
    @FocusState private var isFocused: Bool
    private let palette: [Color] = [.red, .orange, .yellow, .green, .teal, .blue, .purple]

    var body: some View {
        VStack(spacing: 12) {
            Circle()
                .fill(color)
                .frame(width: 44, height: 44)
                .overlay(Circle().stroke(isFocused ? Color.accentColor : .clear, lineWidth: 3))
                .focusable(interactions: .activate)
                .focused($isFocused)
                .onKeyPress(.return) {
                    showsPicker = true
                    return .handled
                }
                .onTapGesture { isFocused = true }
                .popover(isPresented: $showsPicker) {
                    HStack(spacing: 8) {
                        ForEach(palette, id: \.self) { swatch in
                            Circle().fill(swatch).frame(width: 24, height: 24)
                                .onTapGesture {
                                    color = swatch
                                    showsPicker = false
                                }
                        }
                    }
                    .padding(12)
                }
            Text(isFocused ? "Focused — press Return to open the palette" : "Click the well to focus it")
                .font(.callout)
                .foregroundStyle(.secondary)
            C06_Caption("interactions: .activate — the well is triggered with Return/Space and leaves arrow keys to focus navigation.")
        }
    }
}

private struct C06_FocusInteractionsExample: View {
    @State private var mode = "both"
    @State private var position = 0.35
    @State private var isPlaying = false
    @FocusState private var isFocused: Bool

    private var interactions: FocusInteractions {
        switch mode {
        case "activate": .activate
        case "edit": .edit
        default: [.activate, .edit]
        }
    }

    var body: some View {
        VStack(spacing: 12) {
            Picker("interactions", selection: $mode) {
                Text(".activate").tag("activate")
                Text(".edit").tag("edit")
                Text("[.activate, .edit]").tag("both")
            }
            .pickerStyle(.segmented)
            .frame(width: 280)

            ZStack(alignment: .leading) {
                HStack(spacing: 2) {
                    ForEach(0..<40, id: \.self) { index in
                        Capsule().fill(.secondary)
                            .frame(width: 3, height: CGFloat(8 + (index * 7) % 26))
                    }
                }
                Rectangle().fill(Color.accentColor).frame(width: 2, height: 36)
                    .offset(x: position * 198)
            }
            .frame(width: 200, height: 40)
            .padding(6)
            .c06FocusRing(isFocused)
            .focusable(interactions: interactions)
            .focused($isFocused)
            .onMoveCommand { direction in
                if direction == .left { position = max(position - 0.05, 0) }
                if direction == .right { position = min(position + 0.05, 1) }
            }
            .onKeyPress(.space) {
                isPlaying.toggle()
                return .handled
            }
            .onTapGesture { isFocused = true }

            Text("\(isPlaying ? "Playing" : "Paused")  •  position \(position, specifier: "%.2f")")
                .font(.callout.monospacedDigit())
            C06_Caption("Click to focus. .edit declares the view consumes ← →; .activate declares it is triggered with Space/Return.")
        }
    }
}

// MARK: - .focusedObject()

private struct C06_FocusedObjectOptionalExample: View {
    @StateObject private var editorModel = C06_EditorModel(title: "Poster.sketch")
    @State private var isEditing = true
    @FocusState private var canvasFocused: Bool

    var body: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.blue.opacity(0.2))
                .frame(width: 220, height: 52)
                .overlay(Text("CanvasView").font(.callout))
                .c06FocusRing(canvasFocused)
                .focusable()
                .focused($canvasFocused)
                .focusedObject(isEditing ? editorModel : nil)
                .onTapGesture { canvasFocused = true }
            Toggle("isEditing (export the object)", isOn: $isEditing)
                .toggleStyle(.switch)
            C06_FocusedObjectReader()
            C06_Caption("Click the canvas to focus it; isEditing = false passes nil, withdrawing the export without removing the modifier.")
        }
    }
}

private struct C06_FocusedObjectReader: View {
    @FocusedObject private var editor: C06_EditorModel?

    var body: some View {
        Label(editor.map { "@FocusedObject → \($0.title)" } ?? "@FocusedObject → nil",
              systemImage: editor == nil ? "circle.dashed" : "checkmark.circle.fill")
            .font(.callout.monospaced())
    }
}

private struct C06_FocusedSceneObjectExample: View {
    @StateObject private var projectModel = C06_ProjectModel(name: "Aviary")

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Sidebar").bold()
                    Text("Sources")
                    Text("Assets")
                }
                .font(.caption)
                .frame(width: 80, alignment: .leading)
                .padding(8)
                .background(.quaternary)
                VStack(spacing: 6) {
                    Text("Detail").font(.caption.bold())
                    TextField("Project name", text: $projectModel.name)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 140)
                }
                .padding(8)
            }
            .background(.background, in: RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(.separator))
            .focusedSceneObject(projectModel)
            C06_FocusedSceneObjectReader()
            C06_Caption("Exported window-wide: the reader sees the object even while no view inside has focus.")
        }
    }
}

private struct C06_FocusedSceneObjectReader: View {
    @FocusedObject private var project: C06_ProjectModel?

    var body: some View {
        HStack(spacing: 10) {
            Button("Build \(project?.name ?? "—")") { }
                .disabled(project == nil)
            Text(project == nil ? "@FocusedObject → nil" : "@FocusedObject → ProjectModel")
                .font(.callout.monospaced())
        }
    }
}

// MARK: - .focusedSceneValue()

private struct C06_FocusedSceneValueKeyPathExample: View {
    @State private var zoom = 1.0

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 8).fill(.quaternary)
                Image(systemName: "photo")
                    .font(.system(size: 22))
                    .scaleEffect(zoom)
            }
            .frame(width: 220, height: 64)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .focusedSceneValue(\.canvasZoom, $zoom)
            Text("zoom \(zoom, specifier: "%.2f")×")
                .font(.callout.monospacedDigit())
            C06_CanvasZoomReader()
            C06_Caption("The reader reaches the Binding published at window scope — how menu commands act on a document.")
        }
    }
}

private struct C06_CanvasZoomReader: View {
    @FocusedValue(\.canvasZoom) private var canvasZoom: Binding<Double>?

    var body: some View {
        HStack {
            Button("Zoom Out") { canvasZoom?.wrappedValue -= 0.25 }
            Button("Zoom In") { canvasZoom?.wrappedValue += 0.25 }
        }
        .disabled(canvasZoom == nil)
    }
}

private struct C06_FocusedSceneValueObservableExample: View {
    @State private var model = C06_ObservableProject(name: "Aviary")

    var body: some View {
        VStack(spacing: 12) {
            VStack(spacing: 6) {
                Text("ProjectWindow").font(.caption.bold())
                TextField("Project name", text: $model.name)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 160)
            }
            .padding(10)
            .background(.background, in: RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(.separator))
            .focusedSceneValue(model)
            C06_ObservableProjectReader()
            C06_Caption("The @Observable object's type is the key — no FocusedValues extension needed.")
        }
    }
}

private struct C06_ObservableProjectReader: View {
    @FocusedValue(C06_ObservableProject.self) private var project: C06_ObservableProject?

    var body: some View {
        Text(project.map { "@FocusedValue(ProjectModel.self) → \"\($0.name)\"" }
             ?? "@FocusedValue(ProjectModel.self) → nil")
            .font(.callout.monospaced())
    }
}

// MARK: - .focusedValue()

private struct C06_FocusedValueKeyPathExample: View {
    private let tracks = [
        C06_Track(title: "Overture", artist: "Ada"),
        C06_Track(title: "Interlude", artist: "Bo"),
        C06_Track(title: "Finale", artist: "Cy"),
    ]
    @FocusState private var focusedTrack: C06_Track?

    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 4) {
                ForEach(tracks) { track in
                    HStack {
                        Image(systemName: "music.note")
                        Text(track.title)
                        Spacer()
                        Text(track.artist).foregroundStyle(.secondary)
                    }
                    .padding(.horizontal, 10).padding(.vertical, 4)
                    .frame(width: 220)
                    .c06FocusRing(focusedTrack == track)
                    .focusable()
                    .focused($focusedTrack, equals: track)
                    .focusedValue(\.selectedTrack, track)
                    .onTapGesture { focusedTrack = track }
                }
            }
            C06_SelectedTrackReader()
            C06_Caption("Click a row to focus it; the value is published only while that row has focus.")
        }
    }
}

private struct C06_SelectedTrackReader: View {
    @FocusedValue(\.selectedTrack) private var selectedTrack: C06_Track?

    var body: some View {
        Text(selectedTrack.map { "@FocusedValue(\\.selectedTrack) → \($0.title)" }
             ?? "@FocusedValue(\\.selectedTrack) → nil")
            .font(.callout.monospaced())
    }
}

private struct C06_FocusedValueObservableExample: View {
    @State private var editor = C06_Editor()
    @FocusState private var canvasFocused: Bool

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 14) {
                ForEach(0..<4, id: \.self) { index in
                    Circle()
                        .fill(editor.selection.contains(index) ? Color.accentColor : Color.secondary.opacity(0.4))
                        .frame(width: 28, height: 28)
                        .onTapGesture {
                            canvasFocused = true
                            if editor.selection.contains(index) {
                                editor.selection.remove(index)
                            } else {
                                editor.selection.insert(index)
                            }
                        }
                }
            }
            .padding(12)
            .frame(width: 220)
            .c06FocusRing(canvasFocused)
            .focusable()
            .focused($canvasFocused)
            .focusedValue(editor)
            .onTapGesture { canvasFocused = true }
            C06_EditorReader()
            C06_Caption("Click shapes to select them; the reader keys on Editor.self while the canvas has focus.")
        }
    }
}

private struct C06_EditorReader: View {
    @FocusedValue(C06_Editor.self) private var editor: C06_Editor?

    var body: some View {
        Text(editor.map { "@FocusedValue(Editor.self) → \($0.selection.count) selected" }
             ?? "@FocusedValue(Editor.self) → nil")
            .font(.callout.monospaced())
    }
}

// MARK: - .hoverEffect()

private struct C06_HoverEffectExample: View {
    @State private var isHovering = false
    @State private var opened = 0

    var body: some View {
        VStack(spacing: 12) {
            Button("Open") { opened += 1 }
                .buttonStyle(.plain)
                .padding(.horizontal, 12).padding(.vertical, 6)
                .background(isHovering ? Color.primary.opacity(0.12) : Color.clear,
                            in: RoundedRectangle(cornerRadius: 8))
                .onHover { isHovering = $0 }
                .animation(.easeOut(duration: 0.15), value: isHovering)
            Text("opened \(opened)×")
                .font(.callout)
                .foregroundStyle(.secondary)
            C06_Caption("Illustrative — iOS/tvOS only: .highlight morphs the pointer into a platter behind the view. Simulated here with onHover.")
        }
    }
}

private struct C06_HoverEffectEnabledExample: View {
    private struct Card: Identifiable {
        let id: Int
        let title: String
        let isSelectable: Bool
    }
    private let cards = [
        Card(id: 0, title: "Draft", isSelectable: true),
        Card(id: 1, title: "Locked", isSelectable: false),
        Card(id: 2, title: "Final", isSelectable: true),
    ]
    @State private var hovered: Int? = nil

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 14) {
                ForEach(cards) { card in
                    VStack(spacing: 4) {
                        Image(systemName: card.isSelectable ? "doc.text" : "lock.doc")
                        Text(card.title).font(.caption)
                    }
                    .frame(width: 64, height: 56)
                    .background(.background, in: RoundedRectangle(cornerRadius: 8))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(.separator))
                    .scaleEffect(hovered == card.id && card.isSelectable ? 1.08 : 1)
                    .shadow(radius: hovered == card.id && card.isSelectable ? 6 : 0)
                    .onHover { hovered = $0 ? card.id : nil }
                    .animation(.easeOut(duration: 0.15), value: hovered)
                }
            }
            C06_Caption("Illustrative — iOS/tvOS only: .lift is attached to every card, but isEnabled: false keeps “Locked” flat. Simulated with onHover.")
        }
    }
}

// MARK: - .onContinuousHover()

private struct C06_ContinuousHoverCoordinateSpaceExample: View {
    @State private var reticle: CGPoint? = nil

    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(LinearGradient(colors: [.teal.opacity(0.6), .indigo.opacity(0.6)],
                                         startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 180, height: 100)
                    .padding(20)   // inset inside the canvas
                    .onContinuousHover(coordinateSpace: .named("canvas")) { phase in
                        if case .active(let point) = phase { reticle = point } else { reticle = nil }
                    }
                if let reticle {
                    Image(systemName: "plus.viewfinder")
                        .foregroundStyle(.white)
                        .position(reticle)   // positioned in canvas space
                        .allowsHitTesting(false)
                }
            }
            .coordinateSpace(.named("canvas"))
            .frame(width: 220, height: 140)
            .background(.quaternary, in: .rect(cornerRadius: 10))
            C06_Caption(reticle.map { String(format: "canvas (%.0f, %.0f) — includes the 20pt inset", $0.x, $0.y) }
                        ?? "Hover the image — points are reported in the named space")
        }
    }
}

private struct C06_HoverPhaseExample: View {
    @State private var tooltip: (index: Int, value: Int)? = nil
    private let samples = [4, 7, 3, 9, 6, 8, 5]

    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .bottom, spacing: 6) {
                ForEach(samples.indices, id: \.self) { i in
                    RoundedRectangle(cornerRadius: 3)
                        .fill(tooltip?.index == i ? Color.orange : Color.blue.opacity(0.6))
                        .frame(width: 22, height: CGFloat(samples[i]) * 8)
                }
            }
            .frame(width: 190, height: 80, alignment: .bottom)
            .contentShape(Rectangle())
            .onContinuousHover { phase in
                switch phase {
                case .active(let location):
                    let index = min(max(Int(location.x / 28), 0), samples.count - 1)
                    tooltip = (index, samples[index])
                case .ended:
                    tooltip = nil
                }
            }
            C06_Caption(tooltip.map { "Sample \($0.index + 1): \($0.value)" }
                        ?? "Hover the bars — .active carries the location, .ended clears the tooltip")
        }
    }
}

// MARK: - .onCutCommand()

private struct C06_CutCommandExample: View {
    private static let initialTags = ["swift", "ui", "macos", "docs"]
    @State private var tags = C06_CutCommandExample.initialTags
    @State private var selection: Set<String> = ["ui"]
    @State private var lastCut = ""

    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 6) {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(selection.contains(tag) ? AnyShapeStyle(.blue) : AnyShapeStyle(.quaternary),
                                    in: Capsule())
                        .foregroundStyle(selection.contains(tag) ? Color.white : Color.primary)
                        .onTapGesture {
                            if selection.contains(tag) { selection.remove(tag) } else { selection.insert(tag) }
                        }
                }
            }
            .padding(8)
            .focusable()
            .onCutCommand {
                let items = selection.map { NSItemProvider(object: $0 as NSString) }
                lastCut = selection.sorted().joined(separator: ", ")
                tags.removeAll { selection.contains($0) }
                selection.removeAll()
                return items
            }
            Button("Reset") {
                tags = Self.initialTags
                selection = ["ui"]
                lastCut = ""
            }
            .controlSize(.small)
            C06_Caption(lastCut.isEmpty
                        ? "Click the chips to focus, select some, then press ⌘X"
                        : "Cut to the pasteboard: \(lastCut)")
        }
    }
}

// MARK: - .onMoveCommand()

private struct C06_MoveCommandDirectionExample: View {
    @State private var row = 1
    @State private var column = 1

    var body: some View {
        VStack(spacing: 8) {
            Grid(horizontalSpacing: 4, verticalSpacing: 4) {
                ForEach(0..<3, id: \.self) { r in
                    GridRow {
                        ForEach(0..<3, id: \.self) { c in
                            RoundedRectangle(cornerRadius: 6)
                                .fill(r == row && c == column ? Color.accentColor : Color.secondary.opacity(0.2))
                                .frame(width: 36, height: 36)
                        }
                    }
                }
            }
            .padding(6)
            .focusable()
            .onMoveCommand { direction in
                switch direction {
                case .up:    row = max(row - 1, 0)
                case .down:  row = min(row + 1, 2)
                case .left:  column = max(column - 1, 0)
                case .right: column = min(column + 1, 2)
                @unknown default: break
                }
            }
            .animation(.easeInOut(duration: 0.12), value: row)
            .animation(.easeInOut(duration: 0.12), value: column)
            C06_Caption("Click the grid to focus, then use the arrow keys — row \(row), column \(column)")
        }
    }
}

// MARK: - .onPasteCommand()

private struct C06_PasteCommandExample: View {
    @State private var notes = ["Buy seed", "Fix the feeder"]

    var body: some View {
        VStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 4) {
                ForEach(Array(notes.enumerated()), id: \.offset) { _, note in
                    Label(note, systemImage: "note.text").font(.caption)
                }
            }
            .frame(width: 200, alignment: .leading)
            .padding(8)
            .background(.quaternary, in: .rect(cornerRadius: 8))
            .focusable()
            .onPasteCommand(of: [.plainText, .utf8PlainText]) { providers in
                for provider in providers {
                    _ = provider.loadObject(ofClass: String.self) { text, _ in
                        guard let text else { return }
                        Task { @MainActor in notes.append(text) }
                    }
                }
            }
            C06_Caption("Click the list to focus, copy some text anywhere, then press ⌘V to add a note")
        }
    }
}

private struct C06_PasteValidatorExample: View {
    @State private var artwork: NSImage? = nil
    @State private var status = "Click to focus, copy an image, then press ⌘V"

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.quaternary)
                if let artwork {
                    Image(nsImage: artwork)
                        .resizable()
                        .scaledToFill()
                        .clipShape(.rect(cornerRadius: 10))
                } else {
                    Image(systemName: "photo.badge.plus")
                        .font(.title)
                        .foregroundStyle(.secondary)
                }
            }
            .frame(width: 140, height: 100)
            .focusable()
            .onPasteCommand(of: [.image], validator: { providers in
                providers.count == 1 ? providers[0] : nil      // nil keeps Paste disabled
            }) { provider in
                status = "Loading pasted image…"
                _ = provider.loadObject(ofClass: NSImage.self) { object, _ in
                    Task { @MainActor in
                        if let image = object as? NSImage {
                            artwork = image
                            status = "Artwork replaced"
                        } else {
                            status = "The pasteboard item was not an image"
                        }
                    }
                }
            }
            C06_Caption(status)
        }
    }
}

// MARK: - .paletteSelectionEffect()

private struct C06_PaletteSymbolVariantExample: View {
    enum Flag: String, CaseIterable, Identifiable {
        case red, orange, green, blue
        var id: Self { self }
        var name: String { rawValue.capitalized }
        var color: Color {
            switch self {
            case .red: .red
            case .orange: .orange
            case .green: .green
            case .blue: .blue
            }
        }
    }
    @State private var flag: Flag = .green

    var body: some View {
        VStack(spacing: 8) {
            Menu("Flag") {
                Picker("Flag", selection: $flag) {
                    ForEach(Flag.allCases) { Label($0.name, systemImage: "flag").tint($0.color).tag($0) }
                }
                .pickerStyle(.palette)
                .paletteSelectionEffect(.symbolVariant(.fill))
            }
            .frame(width: 120)
            Label("Flagged \(flag.name)", systemImage: "flag.fill")
                .font(.caption)
                .foregroundStyle(flag.color)
            C06_Caption("Open the menu — the chosen flag is drawn with its .fill variant")
        }
    }
}

private struct C06_PaletteCustomExample: View {
    enum Priority: String, CaseIterable, Identifiable {
        case low, medium, high
        var id: Self { self }
        var name: String { rawValue.capitalized }
    }
    @State private var priority: Priority = .medium

    var body: some View {
        VStack(spacing: 8) {
            Menu("Priority") {
                Picker("Priority", selection: $priority) {
                    ForEach(Priority.allCases) { level in
                        Label(level.name, systemImage: level == priority ? "checkmark.circle.fill" : "circle")
                            .tag(level)
                    }
                }
                .pickerStyle(.palette)
                .paletteSelectionEffect(.custom)
            }
            .frame(width: 120)
            Text("Priority: \(priority.name)")
                .font(.caption)
            C06_Caption("Open the menu — .custom suppresses the built-in effect, so the symbols show selection themselves")
        }
    }
}

// MARK: - .pointerStyle()

private struct C06_PointerGrabExample: View {
    @State private var isDragging = false
    @State private var offset: CGSize = .zero

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.quaternary)
                    .frame(width: 220, height: 110)
                Image(systemName: "bird.fill")
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding(12)
                    .background(.pink, in: Circle())
                    .offset(offset)
                    .pointerStyle(isDragging ? .grabActive : .grabIdle)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                isDragging = true
                                offset = value.translation
                            }
                            .onEnded { _ in
                                isDragging = false
                                withAnimation(.bouncy) { offset = .zero }
                            }
                    )
            }
            C06_Caption(isDragging ? "Closed hand while dragging (.grabActive)" : "Hover the sticker — an open hand (.grabIdle)")
        }
    }
}

private struct C06_PointerColumnResizeExample: View {
    @State private var canGrow = true
    @State private var width: CGFloat = 90
    @State private var startWidth: CGFloat = 90

    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 0) {
                Text("Name")
                    .font(.caption)
                    .frame(width: width, alignment: .leading)
                    .padding(.leading, 6)
                Rectangle()
                    .fill(.separator)
                    .frame(width: 1)
                    .padding(.vertical, 2)
                    .frame(width: 8)             // a wider hit area around the 1pt line
                    .contentShape(Rectangle())
                    .pointerStyle(.columnResize(directions: canGrow ? .all : .trailing))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let proposed = startWidth + value.translation.width
                                width = canGrow ? min(max(60, proposed), 150) : min(max(60, proposed), startWidth)
                            }
                            .onEnded { _ in startWidth = width }
                    )
                Text("Size")
                    .font(.caption)
                    .padding(.leading, 6)
                Spacer()
            }
            .frame(width: 220, height: 28)
            .background(.quaternary, in: .rect(cornerRadius: 6))
            Toggle("Column can grow (.all)", isOn: $canGrow)
                .controlSize(.small)
            C06_Caption("Hover the divider — the arrows show which way it may move")
        }
    }
}

private struct C06_PointerFrameResizeExample: View {
    @State private var size = CGSize(width: 120, height: 70)
    @State private var start = CGSize(width: 120, height: 70)

    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .bottomTrailing) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.teal.opacity(0.35))
                    .frame(width: size.width, height: size.height)
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                    .font(.system(size: 9))
                    .padding(4)
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 4))
                    .pointerStyle(.frameResize(position: .bottomTrailing, directions: .outward))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                size = CGSize(
                                    width: min(max(start.width, start.width + value.translation.width), 220),
                                    height: min(max(start.height, start.height + value.translation.height), 130)
                                )
                            }
                            .onEnded { _ in start = size }
                    )
            }
            .frame(width: 220, height: 130, alignment: .topLeading)
            C06_Caption("Drag the corner handle — .outward only lets the frame grow")
        }
    }
}

private struct C06_PointerLinkExample: View {
    @State private var tapped = false
    private let title = "Layout in SwiftUI: a field guide"

    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .underline()
                .foregroundStyle(.blue)
                .pointerStyle(.link)
                .onTapGesture { tapped = true }
            C06_Caption(tapped
                        ? "Tapped — a real citation would call openURL(citation.url) here"
                        : "Hover the title — the pointer becomes a pointing hand")
        }
    }
}

// MARK: - .renameAction()

private struct C06_RenameActionClosureExample: View {
    private struct Album: Identifiable {
        let id: Int
        var name: String
    }
    @State private var albums = [Album(id: 0, name: "Summer"), Album(id: 1, name: "Road Trip"), Album(id: 2, name: "Family")]
    @State private var renamingID: Int? = nil
    @State private var draft = ""

    var body: some View {
        VStack(spacing: 8) {
            VStack(spacing: 4) {
                ForEach($albums) { $album in
                    HStack(spacing: 8) {
                        Image(systemName: "photo.on.rectangle")
                        if renamingID == album.id {
                            TextField("Album name", text: $draft)
                                .textFieldStyle(.roundedBorder)
                                .onSubmit {
                                    album.name = draft
                                    renamingID = nil
                                }
                        } else {
                            Text(album.name)
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 10).padding(.vertical, 4)
                    .frame(width: 220)
                    .background(.quaternary, in: RoundedRectangle(cornerRadius: 6))
                    .contentShape(Rectangle())
                    .contextMenu { RenameButton() }
                    .renameAction {
                        draft = album.name
                        renamingID = album.id
                    }
                }
            }
            C06_Caption(renamingID == nil
                        ? "Right-click a row and choose Rename — the closure decides how editing begins"
                        : "Editing — press Return to commit the new name")
        }
    }
}

private struct C06_RenameActionFocusExample: View {
    @State private var title = "Untitled Sketch"
    @FocusState private var isEditingTitle: Bool

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 8) {
                TextField("Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                    .focused($isEditingTitle)
                    .frame(width: 170)
                RenameButton()
            }
            .renameAction($isEditingTitle)
            Text(isEditingTitle ? "isEditingTitle = true — the field has focus" : "isEditingTitle = false")
                .font(.callout.monospaced())
                .foregroundStyle(.secondary)
            C06_Caption("Click Rename: the FocusState binding flips to true and focus lands in the field.")
        }
    }
}

private struct C06_RenameActionTypeExample: View {
    @State private var invocations = 0

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 24) {
                VStack(spacing: 4) {
                    C06_RenameControl()
                        .renameAction { invocations += 1 }
                    Text("inside .renameAction").font(.caption2).foregroundStyle(.secondary)
                }
                VStack(spacing: 4) {
                    C06_RenameControl()
                    Text("no action in scope").font(.caption2).foregroundStyle(.secondary)
                }
            }
            Text("rename?() called \(invocations)×")
                .font(.callout.monospacedDigit())
            C06_Caption("RenameAction is the environment value RenameButton itself reads; it is nil until a .renameAction supplies one.")
        }
    }
}

private struct C06_RenameControl: View {
    @Environment(\.rename) private var rename: RenameAction?

    var body: some View {
        Button("Rename…") { rename?() }
            .disabled(rename == nil)
    }
}

// MARK: - @FocusedBinding

private struct C06_FocusedBindingExample: View {
    @State private var volume = 0.6
    @FocusState private var playerFocused: Bool

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                Image(systemName: volume == 0 ? "speaker.slash.fill" : "speaker.wave.2.fill")
                Slider(value: $volume, in: 0...1) { Text("Volume") }
                    .frame(width: 130)
            }
            .padding(10)
            .frame(width: 220)
            .c06FocusRing(playerFocused)
            .focusable()
            .focused($playerFocused)
            .focusedValue(\.volume, $volume)
            .onTapGesture { playerFocused = true }
            C06_VolumeReader()
            C06_Caption("Click the player to focus it; the reader receives the flattened Double? and writes back through the binding.")
        }
    }
}

private struct C06_VolumeReader: View {
    @FocusedBinding(\.volume) private var volume: Double?

    var body: some View {
        HStack(spacing: 10) {
            Button("Mute") { volume = 0 }
                .disabled(volume == nil)
            Text(volume.map { String(format: "@FocusedBinding → %.2f", $0) } ?? "@FocusedBinding → nil")
                .font(.callout.monospaced())
        }
    }
}

private struct C06_FocusedBindingProjectedExample: View {
    @State private var isLooping = true
    @FocusState private var trackFocused: Bool

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 8) {
                Image(systemName: "music.note.list")
                Text("Nocturne No. 2")
                Spacer()
                Image(systemName: "repeat")
                    .foregroundStyle(isLooping ? Color.accentColor : Color.secondary)
            }
            .padding(10)
            .frame(width: 220)
            .c06FocusRing(trackFocused)
            .focusable()
            .focused($trackFocused)
            .focusedValue(\.isLooping, $isLooping)
            .onTapGesture { trackFocused = true }
            C06_LoopReader()
            C06_Caption("Click the track to focus it; Binding($isLooping) unwraps the optional projection for the Toggle.")
        }
    }
}

private struct C06_LoopReader: View {
    @FocusedBinding(\.isLooping) private var isLooping: Bool?

    var body: some View {
        HStack(spacing: 10) {
            Toggle("Loop", isOn: Binding($isLooping) ?? .constant(false))
                .toggleStyle(.switch)
                .disabled(isLooping == nil)
            Text(verbatim: isLooping.map { "$isLooping → Binding<Bool?> (\($0))" } ?? "isLooping == nil")
                .font(.caption.monospaced())
        }
    }
}

// MARK: - ButtonRole

private struct C06_ButtonRoleDestructiveExample: View {
    private struct Message: Identifiable {
        let id: Int
        let subject: String
    }
    private static let inbox = [
        Message(id: 0, subject: "Welcome aboard"),
        Message(id: 1, subject: "Invoice #204"),
        Message(id: 2, subject: "Weekend plans"),
    ]
    @State private var messages = C06_ButtonRoleDestructiveExample.inbox

    var body: some View {
        VStack(spacing: 8) {
            List(messages) { message in
                Text(message.subject)
                    .swipeActions(edge: .trailing) {
                        Button("Delete", role: .destructive) { delete(message) }
                    }
                    .contextMenu {
                        Button("Delete", role: .destructive) { delete(message) }
                    }
            }
            .frame(width: 240, height: 96)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            HStack(spacing: 10) {
                Button("Reset") { messages = Self.inbox }
                    .controlSize(.small)
                Text("\(messages.count) messages").font(.caption).foregroundStyle(.secondary)
            }
            C06_Caption("Swipe a row with two fingers or right-click it — the destructive role draws Delete in red.")
        }
    }

    private func delete(_ message: Message) {
        messages.removeAll { $0.id == message.id }
    }
}

private struct C06_ButtonRoleCancelExample: View {
    @State private var showsDiscard = false
    @State private var outcome = "Draft: “Meeting notes…”"

    var body: some View {
        VStack(spacing: 10) {
            Button("Discard…") { showsDiscard = true }
                .confirmationDialog("Discard this draft?", isPresented: $showsDiscard) {
                    Button("Discard Draft", role: .destructive) { outcome = "Draft discarded" }
                    Button("Keep Editing", role: .cancel) { outcome = "Kept editing" }
                }
            Text(outcome).font(.callout).foregroundStyle(.secondary)
            C06_Caption("The .cancel button is placed last and Escape triggers it.")
        }
    }
}

private struct C06_ButtonRoleConfirmExample: View {
    @State private var showsPublish = false
    @State private var status = "Draft"

    var body: some View {
        VStack(spacing: 10) {
            Button("Publish…") { showsPublish = true }
                .alert("Publish this post?", isPresented: $showsPublish) {
                    Button("Publish", role: .confirm) { status = "Published" }
                    Button("Not Yet", role: .cancel) { status = "Still a draft" }
                }
            Label(status, systemImage: status == "Published" ? "checkmark.seal.fill" : "doc")
                .font(.callout)
                .foregroundStyle(status == "Published" ? Color.green : Color.secondary)
            C06_Caption("New in the 2025 releases: .confirm marks the affirmative choice so the system can place and style it.")
        }
    }
}

private struct C06_ButtonRoleCloseExample: View {
    @State private var showsSettings = false
    @State private var notifications = true

    var body: some View {
        VStack(spacing: 10) {
            Button("Settings…") { showsSettings = true }
                .sheet(isPresented: $showsSettings) {
                    VStack(spacing: 12) {
                        Text("Settings").font(.headline)
                        Toggle("Notifications", isOn: $notifications)
                            .toggleStyle(.switch)
                        Button("Close", role: .close) { showsSettings = false }
                            .keyboardShortcut(.cancelAction)
                    }
                    .padding(20)
                    .frame(width: 240)
                    .toolbar {
                        Button("Close", role: .close) { showsSettings = false }
                    }
                }
            Text(notifications ? "Notifications on" : "Notifications off")
                .font(.callout).foregroundStyle(.secondary)
            C06_Caption("Also new in 2025: .close marks the dismiss button; in a toolbar the system draws the standard close glyph.")
        }
    }
}

// MARK: - ButtonStyleConfiguration

private struct C06_PillStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .padding(.horizontal, 14).padding(.vertical, 8)
            .background(.tint, in: Capsule())
    }
}

private struct C06_ButtonConfigLabelExample: View {
    @State private var last = "—"

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 12) {
                Button("Follow") { last = "Follow" }
                    .buttonStyle(C06_PillStyle())
                Button { last = "Share" } label: { Label("Share", systemImage: "square.and.arrow.up") }
                    .buttonStyle(C06_PillStyle())
                Button { last = "Star" } label: { Image(systemName: "star.fill") }
                    .buttonStyle(C06_PillStyle())
                    .tint(.orange)
            }
            Text("Last tapped: \(last)").font(.callout).foregroundStyle(.secondary)
            C06_Caption("configuration.label is the button's own content, type-erased — text, a Label, or an image.")
        }
    }
}

private struct C06_PressStyle: ButtonStyle {
    var onPress: (Bool) -> Void = { _ in }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 14).padding(.vertical, 8)
            .background(.tint.opacity(configuration.isPressed ? 0.35 : 0.15), in: Capsule())
            .opacity(configuration.isPressed ? 0.55 : 1)
            .offset(y: configuration.isPressed ? 1 : 0)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { _, pressed in onPress(pressed) }
    }
}

private struct C06_ButtonConfigPressedExample: View {
    @State private var isPressed = false
    @State private var presses = 0

    var body: some View {
        VStack(spacing: 10) {
            Button("Hold Me") { presses += 1 }
                .buttonStyle(C06_PressStyle(onPress: { isPressed = $0 }))
            Text(isPressed ? "configuration.isPressed == true" : "configuration.isPressed == false")
                .font(.callout.monospaced())
                .foregroundStyle(isPressed ? Color.accentColor : Color.secondary)
            Text("released \(presses)×").font(.caption).foregroundStyle(.secondary)
            C06_Caption("Press and hold — isPressed is true only while the pointer is down on the button.")
        }
    }
}

private struct C06_RoleAwareStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(configuration.role == .destructive ? Color.red : Color.primary)
            .fontWeight(configuration.role == .cancel ? .regular : .semibold)
            .padding(.horizontal, 12).padding(.vertical, 6)
            .background(.quaternary, in: Capsule())
    }
}

private struct C06_ButtonConfigRoleExample: View {
    @State private var last = "—"

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 12) {
                Button("Save") { last = "Save (role: nil)" }
                    .buttonStyle(C06_RoleAwareStyle())
                Button("Delete", role: .destructive) { last = "Delete (role: .destructive)" }
                    .buttonStyle(C06_RoleAwareStyle())
                Button("Cancel", role: .cancel) { last = "Cancel (role: .cancel)" }
                    .buttonStyle(C06_RoleAwareStyle())
            }
            Text("Last tapped: \(last)").font(.callout).foregroundStyle(.secondary)
            C06_Caption("One style reads configuration.role — red for destructive, lighter weight for cancel, default otherwise.")
        }
    }
}

// MARK: - CommandGroup

private struct C06_CommandGroupPlacementExample: View {
    private let placements: [(placement: String, region: String)] = [
        (".appInfo", "PixelForge ▸ About PixelForge"),
        (".appSettings", "PixelForge ▸ Settings…"),
        (".newItem", "File ▸ New"),
        (".saveItem", "File ▸ Save, Save As…"),
        (".pasteboard", "Edit ▸ Cut, Copy, Paste"),
        (".help", "Help ▸ PixelForge Help"),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C06_MenuBarMock(title: "Standard regions a CommandGroup can anchor to",
                            menus: ["File", "Edit", "View", "Window", "Help"],
                            highlighted: ["PixelForge", "File", "Edit", "Help"],
                            appName: "PixelForge")
            Grid(alignment: .leading, horizontalSpacing: 14, verticalSpacing: 3) {
                ForEach(Array(placements.enumerated()), id: \.offset) { _, row in
                    GridRow {
                        Text(row.placement).font(.caption.monospaced())
                        Text(row.region).font(.caption).foregroundStyle(.secondary)
                    }
                }
            }
            C06_Caption("Illustrative — applies at the Scene level: each placement names a standard group to insert before, after, or replace.")
        }
        .frame(maxWidth: 360)
    }
}

private struct C06_CommandGroupBeforeExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            C06_MenuBarMock(title: "CommandGroup(before: .help) { Button(\"Release Notes\") … }",
                            menus: ["File", "Edit", "View", "Window", "Help"],
                            highlighted: ["Help"], appName: "PixelForge")
            HStack(alignment: .top, spacing: 16) {
                C06_MenuMock(title: "Help — default", items: ["Search", "-", "PixelForge Help"])
                C06_MenuMock(title: "Help — with the addition",
                             items: ["Search", "-", "Release Notes", "PixelForge Help"],
                             highlighted: ["Release Notes"])
            }
            C06_Caption("Illustrative — applies at the Scene level: your items land immediately ahead of the standard group; the system items stay.")
        }
        .frame(maxWidth: 400)
    }
}

private struct C06_CommandGroupAfterExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            C06_MenuBarMock(title: "CommandGroup(after: .pasteboard) { Divider(); Button(\"Paste as Plain Text\") … }",
                            menus: ["File", "Edit", "View", "Window", "Help"],
                            highlighted: ["Edit"], appName: "PixelForge")
            HStack(alignment: .top, spacing: 16) {
                C06_MenuMock(title: "Edit — default",
                             items: ["Cut\t⌘X", "Copy\t⌘C", "Paste\t⌘V", "Select All\t⌘A"])
                C06_MenuMock(title: "Edit — with the addition",
                             items: ["Cut\t⌘X", "Copy\t⌘C", "Paste\t⌘V", "Select All\t⌘A", "-", "Paste as Plain Text\t⌥⇧⌘V"],
                             highlighted: ["Paste as Plain Text\t⌥⇧⌘V"])
            }
            C06_Caption("Illustrative — applies at the Scene level: the addition is appended just below the standard pasteboard group.")
        }
        .frame(maxWidth: 400)
    }
}

private struct C06_CommandGroupReplacingExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            C06_MenuBarMock(title: "CommandGroup(replacing: .appSettings) { Button(\"Preferences…\") … }",
                            menus: ["File", "Edit", "View", "Window", "Help"],
                            highlighted: ["PixelForge"], appName: "PixelForge")
            HStack(alignment: .top, spacing: 16) {
                C06_MenuMock(title: "PixelForge — default",
                             items: ["About PixelForge", "-", "Settings…\t⌘,", "-", "Quit PixelForge\t⌘Q"])
                C06_MenuMock(title: "PixelForge — replaced",
                             items: ["About PixelForge", "-", "Preferences…\t⌘,", "-", "Quit PixelForge\t⌘Q"],
                             highlighted: ["Preferences…\t⌘,"])
            }
            C06_Caption("Illustrative — applies at the Scene level: the system's Settings… item is swapped out for yours entirely.")
        }
        .frame(maxWidth: 400)
    }
}

// MARK: - FocusedValues

private struct C06_SelectedSensorKey {}

nonisolated extension C06_SelectedSensorKey: FocusedValueKey {
    typealias Value = String
}

extension FocusedValues {
    fileprivate nonisolated var selectedSensor: String? {
        get { self[C06_SelectedSensorKey.self] }
        set { self[C06_SelectedSensorKey.self] = newValue }
    }
}

private struct C06_FocusedValueKeyExample: View {
    private let sensors = ["BME280", "SHT31", "MPU6050"]
    @FocusState private var focusedSensor: String?

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 8) {
                ForEach(sensors, id: \.self) { name in
                    Label(name, systemImage: "dot.radiowaves.left.and.right")
                        .font(.caption)
                        .padding(.horizontal, 8).padding(.vertical, 5)
                        .c06FocusRing(focusedSensor == name)
                        .focusable()
                        .focused($focusedSensor, equals: name)
                        .focusedValue(\.selectedSensor, name)
                        .onTapGesture { focusedSensor = name }
                }
            }
            C06_SelectedSensorReader()
            C06_Caption("Click a sensor to focus it. The key type's Value fixes the entry's type; the computed property reads and writes through the subscript.")
        }
    }
}

private struct C06_SelectedSensorReader: View {
    @FocusedValue(\.selectedSensor) private var selectedSensor: String?

    var body: some View {
        Text(selectedSensor.map { "self[SelectedSensorKey.self] → \"\($0)\"" }
             ?? "self[SelectedSensorKey.self] → nil")
            .font(.callout.monospaced())
    }
}

private struct C06_FocusedValuesEntryExample: View {
    @State private var rate = 1.0
    @FocusState private var playerFocused: Bool

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                Image(systemName: "play.fill")
                Slider(value: $rate, in: 0.5...2, step: 0.25) { Text("Rate") }
                    .frame(width: 120)
                Text(String(format: "%.2f×", rate)).font(.caption.monospacedDigit())
            }
            .padding(10)
            .frame(width: 230)
            .c06FocusRing(playerFocused)
            .focusable()
            .focused($playerFocused)
            .focusedValue(\.playbackRate, $rate)
            .onTapGesture { playerFocused = true }
            C06_PlaybackRateReader()
            C06_Caption("Click the player to focus it. One @Entry line replaces the key type + accessor pair; because the entry holds a Binding, @FocusedBinding can read it.")
        }
    }
}

private struct C06_PlaybackRateReader: View {
    @FocusedBinding(\.playbackRate) private var rate: Double?

    var body: some View {
        HStack(spacing: 10) {
            Button("Faster") { rate = min((rate ?? 1) + 0.25, 2) }
            Button("Reset") { rate = 1 }
            Text(rate.map { String(format: "@FocusedBinding → %.2f", $0) } ?? "@FocusedBinding → nil")
                .font(.callout.monospaced())
        }
        .disabled(rate == nil)
    }
}

// MARK: - HoverEffect

private struct C06_HoverEffectAutomaticExample: View {
    @State private var hoveringGear = false
    @State private var hoveringCard = false

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 28) {
                VStack(spacing: 6) {
                    Image(systemName: "gearshape")
                        .font(.title3)
                        .padding(6)
                        .background(hoveringGear ? Color.primary.opacity(0.12) : Color.clear,
                                    in: RoundedRectangle(cornerRadius: 8))
                        .onHover { hoveringGear = $0 }
                        .animation(.easeOut(duration: 0.15), value: hoveringGear)
                    Text("small view → highlight").font(.caption2).foregroundStyle(.secondary)
                }
                VStack(spacing: 6) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.teal.gradient)
                        .frame(width: 70, height: 44)
                        .scaleEffect(hoveringCard ? 1.06 : 1)
                        .shadow(radius: hoveringCard ? 6 : 0)
                        .onHover { hoveringCard = $0 }
                        .animation(.easeOut(duration: 0.15), value: hoveringCard)
                    Text("large view → lift").font(.caption2).foregroundStyle(.secondary)
                }
            }
            C06_Caption("Illustrative — iOS/tvOS only: .automatic lets the system choose highlight or lift from the view's size and context. Simulated with onHover.")
        }
    }
}

private struct C06_HoverEffectHighlightExample: View {
    private let tags = ["swiftui", "focus", "pointer"]
    @State private var hovered: String? = nil

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .font(.callout)
                        .padding(.horizontal, 10).padding(.vertical, 5)
                        .background(hovered == tag ? Color.primary.opacity(0.14) : Color.clear, in: Capsule())
                        .contentShape(Capsule())
                        .onHover { hovered = $0 ? tag : nil }
                        .animation(.easeOut(duration: 0.15), value: hovered)
                }
            }
            C06_Caption("Illustrative — iOS/tvOS only: .highlight morphs the pointer into a rounded platter behind the content, the treatment bar buttons use. Simulated with onHover.")
        }
    }
}

private struct C06_HoverEffectLiftExample: View {
    private struct App: Identifiable {
        let id: Int
        let name: String
        let symbol: String
        let color: Color
    }
    private let apps = [
        App(id: 0, name: "Mail", symbol: "envelope.fill", color: .blue),
        App(id: 1, name: "Photos", symbol: "photo.fill", color: .orange),
        App(id: 2, name: "Notes", symbol: "note.text", color: .yellow),
    ]
    @State private var hovered: Int? = nil

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 22) {
                ForEach(apps) { app in
                    VStack(spacing: 6) {
                        Image(systemName: app.symbol)
                            .font(.title2)
                            .foregroundStyle(.white)
                            .frame(width: 48, height: 48)
                            .background(app.color.gradient, in: RoundedRectangle(cornerRadius: 12))
                            .scaleEffect(hovered == app.id ? 1.12 : 1)
                            .shadow(color: .black.opacity(hovered == app.id ? 0.25 : 0), radius: 8, y: 4)
                        Text(app.name).font(.caption2)
                    }
                    .onHover { hovered = $0 ? app.id : nil }
                    .animation(.easeOut(duration: 0.15), value: hovered)
                }
            }
            C06_Caption("Illustrative — iOS/tvOS only: .lift scales the view up and hides the pointer beneath it, suiting app icons and cards. Simulated with onHover.")
        }
    }
}

// MARK: - KeyboardShortcut

private struct C06_KeyboardShortcutInitExample: View {
    private let toggleSidebar = KeyboardShortcut("s", modifiers: [.command, .control])
    @State private var showsSidebar = true

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 0) {
                if showsSidebar {
                    VStack(alignment: .leading, spacing: 4) {
                        Label("Inbox", systemImage: "tray")
                        Label("Sent", systemImage: "paperplane")
                    }
                    .font(.caption)
                    .padding(8)
                    .frame(width: 80, alignment: .leading)
                    .frame(maxHeight: .infinity)
                    .background(.quaternary)
                }
                Text("Content")
                    .font(.caption)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: 220, height: 60)
            .background(.background, in: RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(.separator))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .animation(.easeInOut(duration: 0.2), value: showsSidebar)
            Button("Toggle Sidebar") { showsSidebar.toggle() }
                .keyboardShortcut(toggleSidebar)
            C06_Caption("Press ⌃⌘S or click. The stored shortcut pairs a KeyEquivalent with a modifier set; leave modifiers out and Command is assumed.")
        }
    }
}

private struct C06_KeyboardShortcutLocalizationExample: View {
    private let tabs = ["Overview", "Layers", "Export"]
    private let previousTab = KeyboardShortcut("[", modifiers: .command, localization: .withoutMirroring)
    private let nextTab = KeyboardShortcut("]", modifiers: .command, localization: .withoutMirroring)
    @State private var selectedTab = 0

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 4) {
                ForEach(Array(tabs.enumerated()), id: \.offset) { index, tab in
                    Text(tab)
                        .font(.callout)
                        .padding(.horizontal, 10).padding(.vertical, 4)
                        .background(index == selectedTab ? Color.accentColor.opacity(0.2) : Color.clear,
                                    in: RoundedRectangle(cornerRadius: 6))
                        .onTapGesture { selectedTab = index }
                }
            }
            .padding(4)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
            HStack(spacing: 10) {
                Button("Previous Tab") { selectedTab = max(selectedTab - 1, 0) }
                    .keyboardShortcut(previousTab)
                Button("Next Tab") { selectedTab = min(selectedTab + 1, tabs.count - 1) }
                    .keyboardShortcut(nextTab)
            }
            C06_Caption("⌘[ and ⌘] — .withoutMirroring keeps the brackets as typed in right-to-left layouts, where .automatic would swap them.")
        }
    }
}

private struct C06_KeyboardShortcutDefaultExample: View {
    @State private var name = ""
    @State private var status = "Not signed in"

    var body: some View {
        VStack(spacing: 10) {
            TextField("Account name", text: $name)
                .textFieldStyle(.roundedBorder)
                .frame(width: 200)
            HStack {
                Button("Cancel") { status = "Cancelled" }
                    .keyboardShortcut(.cancelAction)
                Button("Sign In") { status = name.isEmpty ? "Signed in as guest" : "Signed in as \(name)" }
                    .keyboardShortcut(.defaultAction)
            }
            Text(status).font(.callout).foregroundStyle(.secondary)
            C06_Caption("Press Return — .defaultAction binds it and, on macOS, draws the button with the prominent default style.")
        }
    }
}

private struct C06_KeyboardShortcutCancelExample: View {
    @State private var showsExport = false
    @State private var format = "PNG"
    @State private var outcome = "No export yet"

    var body: some View {
        VStack(spacing: 10) {
            Button("Export…") { showsExport = true }
                .sheet(isPresented: $showsExport) {
                    VStack(spacing: 14) {
                        Text("Export").font(.headline)
                        Picker("Format", selection: $format) {
                            Text("PNG").tag("PNG")
                            Text("JPEG").tag("JPEG")
                            Text("PDF").tag("PDF")
                        }
                        .pickerStyle(.segmented)
                        .labelsHidden()
                        HStack {
                            Button("Cancel") {
                                outcome = "Cancelled (Escape or click)"
                                showsExport = false
                            }
                            .keyboardShortcut(.cancelAction)
                            Button("Export") {
                                outcome = "Exported as \(format)"
                                showsExport = false
                            }
                            .keyboardShortcut(.defaultAction)
                        }
                    }
                    .padding(20)
                    .frame(width: 260)
                }
            Text(outcome).font(.callout).foregroundStyle(.secondary)
            C06_Caption("Open the sheet and press Escape — .cancelAction fires the Cancel button and the sheet goes away.")
        }
    }
}

// MARK: - LabeledContentStyle

private struct C06_InspectorRowStyle: LabeledContentStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .firstTextBaseline) {
            configuration.label
                .foregroundStyle(.secondary)
                .frame(width: 90, alignment: .trailing)
            configuration.content
        }
    }
}

private struct C06_VerticalLabeledContentStyle: LabeledContentStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            configuration.label.font(.caption.smallCaps()).foregroundStyle(.secondary)
            configuration.content.font(.body.monospacedDigit())
        }
    }
}

private struct C06_LabeledContentMakeBodyExample: View {
    @State private var opacity = 0.8

    var body: some View {
        VStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 6) {
                LabeledContent("Name", value: "Hero Banner")
                LabeledContent("Size", value: "1200 × 630")
                LabeledContent("Opacity") {
                    Slider(value: $opacity, in: 0...1).frame(width: 110)
                }
            }
            .labeledContentStyle(C06_InspectorRowStyle())
            .padding(10)
            .frame(width: 260)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
            C06_Caption("makeBody(configuration:) decides the arrangement — here labels sit right-aligned in a 90pt column, inspector style.")
        }
    }
}

private struct C06_LabeledContentConfigurationExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .top, spacing: 24) {
                LabeledContent("Pressure", value: "1013 hPa")
                LabeledContent("Humidity", value: "41 %")
                LabeledContent("Temperature", value: "22.4 °C")
            }
            .labeledContentStyle(C06_VerticalLabeledContentStyle())
            .padding(10)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
            C06_Caption("configuration.label and configuration.content are the two halves, type-erased, so each can be styled on its own.")
        }
    }
}

private struct C06_LabeledContentAutomaticExample: View {
    var body: some View {
        VStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 8) {
                LabeledContent("Sensor", value: "BME280")
                LabeledContent("Firmware", value: "2.4.1")
                GroupBox("Raw") {
                    LabeledContent("Pressure", value: "1013 hPa")
                    LabeledContent("Humidity", value: "41 %")
                }
                .labeledContentStyle(.automatic)
            }
            .labeledContentStyle(C06_VerticalLabeledContentStyle())
            .frame(width: 240)
            C06_Caption("The outer rows use the custom vertical style; inside the group box .automatic restores label-leading, content-trailing.")
        }
    }
}

// MARK: - SidebarCommands siblings

private struct C06_ToolbarCommandsExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            C06_MenuBarMock(title: ".commands { ToolbarCommands() }",
                            menus: ["File", "Edit", "View", "Window", "Help"], highlighted: ["View"])
            C06_MenuMock(title: "View",
                         items: ["Hide Toolbar\t⌥⌘T", "Customize Toolbar…", "-", "Enter Full Screen\t⌃⌘F"],
                         highlighted: ["Hide Toolbar\t⌥⌘T", "Customize Toolbar…"])
            C06_Caption("Illustrative — applies at the Scene level: adds Show/Hide Toolbar and Customize Toolbar… to the View menu for windows with a customizable toolbar.")
        }
        .frame(maxWidth: 360)
    }
}

private struct C06_TextEditingCommandsExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            C06_MenuBarMock(title: ".commands { TextEditingCommands() }",
                            menus: ["File", "Edit", "View", "Window", "Help"], highlighted: ["Edit"])
            C06_MenuMock(title: "Edit",
                         items: ["Paste\t⌘V", "Select All\t⌘A", "-",
                                 "Find\t▸", "Spelling and Grammar\t▸", "Substitutions\t▸", "Transformations\t▸", "Speech\t▸"],
                         highlighted: ["Find\t▸", "Spelling and Grammar\t▸", "Substitutions\t▸", "Transformations\t▸", "Speech\t▸"])
            C06_Caption("Illustrative — applies at the Scene level: installs the standard text-editing submenus in the Edit menu.")
        }
        .frame(maxWidth: 360)
    }
}

private struct C06_TextFormattingCommandsExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            C06_MenuBarMock(title: ".commands { TextFormattingCommands() }",
                            menus: ["File", "Edit", "Format", "View", "Window", "Help"], highlighted: ["Format"])
            HStack(alignment: .top, spacing: 16) {
                C06_MenuMock(title: "Format", items: ["Font\t▸", "Text\t▸"], highlighted: ["Font\t▸", "Text\t▸"])
                C06_MenuMock(title: "Text ▸",
                             items: ["Align Left\t⌘{", "Center\t⌘|", "Justify", "Align Right\t⌘}", "-", "Writing Direction\t▸"])
            }
            C06_Caption("Illustrative — applies at the Scene level: supplies a whole Format menu with font, text, and alignment commands.")
        }
        .frame(maxWidth: 400)
    }
}

private struct C06_InspectorCommandsExample: View {
    @State private var showsInspector = true

    private var menuItem: String { "\(showsInspector ? "Hide" : "Show") Inspector\t⌃⌘I" }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top, spacing: 14) {
                C06_MenuMock(title: "View",
                             items: ["Hide Toolbar\t⌥⌘T", "-", menuItem, "-", "Enter Full Screen\t⌃⌘F"],
                             highlighted: [menuItem])
                VStack(spacing: 8) {
                    HStack(spacing: 0) {
                        Text("Sidebar")
                            .frame(width: 46)
                            .frame(maxHeight: .infinity)
                            .background(.quaternary)
                        Text("Detail")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        if showsInspector {
                            Text("Inspector")
                                .frame(width: 60)
                                .frame(maxHeight: .infinity)
                                .background(Color.accentColor.opacity(0.15))
                        }
                    }
                    .font(.caption2)
                    .frame(width: 170, height: 64)
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(.separator))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .animation(.easeInOut(duration: 0.2), value: showsInspector)
                    Button(showsInspector ? "Hide Inspector" : "Show Inspector") { showsInspector.toggle() }
                        .keyboardShortcut("i", modifiers: [.control, .command])
                        .controlSize(.small)
                }
            }
            C06_Caption("Illustrative — the menu item is added at the Scene level and toggles the .inspector(isPresented:) presentation; ⌃⌘I works on the mock too.")
        }
        .frame(maxWidth: 400)
    }
}

// C06_STRUCTS_END
