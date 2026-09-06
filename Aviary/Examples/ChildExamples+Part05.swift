//
//  ChildExamples+Part05.swift
//  Aviary
//
//  Compiled renderings for variant entries (part 05: gen-accessibility, environment-values).
//
//  Most accessibility modifiers have no visible effect, so each example pairs the
//  real modifier with a small "inspector" readout that mirrors what VoiceOver
//  would announce, plus a button that runs the same handler where that helps.
//

import SwiftUI
import Accessibility

enum ChildExamplesPart05 {
    static let entries: [ChildExampleEntry] = [

        // MARK: .accessibilityAction()

        ChildExampleEntry(parent: ".accessibilityAction()", child: ".accessibilityAction(named:)", code: """
        RoundedRectangle(cornerRadius: 12)
            .fill(isFlipped ? Color.orange.gradient : Color.blue.gradient)
            .overlay(Text(isFlipped ? "Back" : "Front"))
            .accessibilityLabel("Card")
            .accessibilityAction(named: "Flip") { isFlipped.toggle() }
        """) { AnyView(C05_ActionNamedExample()) },

        ChildExampleEntry(parent: ".accessibilityAction()", child: ".accessibilityAction(action:label:)", code: """
        TrackRow(title: "Blue in Green", artist: "Miles Davis")
            .accessibilityElement(children: .combine)
            .accessibilityAction {
                queued += 1
            } label: {
                Label("Add to Queue", systemImage: "text.badge.plus")
            }
        """) { AnyView(C05_ActionLabelExample()) },

        ChildExampleEntry(parent: ".accessibilityAction()", child: ".accessibilityAction(_:_:)", code: """
        PlayerTile(isPlaying: isPlaying, showsOverlay: showsOverlay)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Player")
            .accessibilityAction { isPlaying.toggle() }           // kind defaults to .default
            .accessibilityAction(.escape) { showsOverlay = false }
        """) { AnyView(C05_ActionKindExample()) },

        ChildExampleEntry(parent: ".accessibilityAction()", child: ".accessibilityAction(named:_:)", code: """
        CardFace(isFlipped: isFlipped, archived: archived)
            .accessibilityLabel("Card")
            .accessibilityAction(named: "Flip") { isFlipped.toggle() }
            .accessibilityAction(named: Text("Archive")) { archived = true }
        """) { AnyView(C05_ActionNamedFormsExample()) },

        // MARK: .accessibilityActions()

        ChildExampleEntry(parent: ".accessibilityActions()", child: ".accessibilityActions(category:)", code: """
        TextEditor(text: $note)
            .accessibilityLabel("Note")
            .accessibilityActions(category: .edit) {
                Button("Insert checklist") { note += "\\n☐ " }
            }
        """) { AnyView(C05_ActionsCategoryExample()) },

        ChildExampleEntry(parent: ".accessibilityActions()", child: ".accessibilityActions(_:)", code: """
        NoteRow(title: "Call the plumber", pinned: pinned)
            .accessibilityElement(children: .combine)
            .accessibilityActions {
                Button("Pin") { pinned.toggle() }
                Button("Delete", role: .destructive) { deleted = true }
            }
        """) { AnyView(C05_ActionsBuilderExample()) },

        ChildExampleEntry(parent: ".accessibilityActions()", child: ".accessibilityActions(category:_:)", code: """
        TextEditor(text: $draft)
            .font(isBold ? .body.bold() : .body)
            .accessibilityActions(category: .edit) {
                Button("Insert checklist") { draft += "\\n☐ " }
                Button("Clear formatting") { isBold = false }
            }
        """) { AnyView(C05_ActionsCategoryBuilderExample()) },

        // MARK: .accessibilityActivationPoint()

        ChildExampleEntry(parent: ".accessibilityActivationPoint()", child: ".accessibilityActivationPoint(_: UnitPoint)", code: """
        HStack {
            Text("Notifications")
            Spacer()
            Toggle("Notifications", isOn: $notificationsOn).labelsHidden()
        }
        .accessibilityElement(children: .combine)
        .accessibilityActivationPoint(UnitPoint(x: 0.92, y: 0.5))
        """) { AnyView(C05_ActivationUnitPointExample()) },

        ChildExampleEntry(parent: ".accessibilityActivationPoint()", child: ".accessibilityActivationPoint(_: CGPoint)", code: """
        Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
            .padding(.horizontal, 14)
            .frame(height: 44)
            .background(.tint.opacity(0.15), in: .capsule)
            .accessibilityActivationPoint(CGPoint(x: 24, y: 22))
        """) { AnyView(C05_ActivationCGPointExample()) },

        ChildExampleEntry(parent: ".accessibilityActivationPoint()", child: ".accessibilityActivationPoint(_:isEnabled:)", code: """
        HStack {
            Text("Sync")
            Spacer()
            if showsToggle { Toggle("Sync", isOn: $syncOn).labelsHidden() }
        }
        .accessibilityElement(children: .combine)
        .accessibilityActivationPoint(.trailing, isEnabled: showsToggle)
        """) { AnyView(C05_ActivationEnabledExample()) },

        // MARK: .accessibilityCustomContent()

        ChildExampleEntry(parent: ".accessibilityCustomContent()", child: ".accessibilityCustomContent(_: LocalizedStringKey, _:importance:)", code: """
        RecipeCard(name: "Shakshuka", minutes: minutes, difficulty: difficulty)
            .accessibilityElement(children: .combine)
            .accessibilityCustomContent("Prep time", "\\(minutes) minutes")
            .accessibilityCustomContent("Difficulty", difficulty, importance: .high)
        """) { AnyView(C05_CustomContentKeyStringExample()) },

        ChildExampleEntry(parent: ".accessibilityCustomContent()", child: ".accessibilityCustomContent(_: Text, _: Text, importance:)", code: """
        StatCell(name: name, value: value)                      // name is a runtime String
            .accessibilityElement(children: .combine)
            .accessibilityCustomContent(Text(name), Text(value, format: .number))
            .accessibilityCustomContent(Text("Goal"), Text(goal, format: .number), importance: .high)
        """) { AnyView(C05_CustomContentTextExample()) },

        ChildExampleEntry(parent: ".accessibilityCustomContent()", child: ".accessibilityCustomContent(_: AccessibilityCustomContentKey, _:importance:)", code: """
        extension AccessibilityCustomContentKey {
            static let servings = AccessibilityCustomContentKey("Servings", id: "servings")
        }

        RecipeCard(name: "Paella")
            .accessibilityCustomContent(.servings, "4", importance: .high)
            .accessibilityCustomContent(.servings, "\\(servings)")   // same key → replaces "4"
        """) { AnyView(C05_CustomContentKeyedExample()) },

        // MARK: .accessibilityFocused()

        ChildExampleEntry(parent: ".accessibilityFocused()", child: ".accessibilityFocused(_:equals:)", code: """
        enum Field: Hashable { case email, password }
        @AccessibilityFocusState private var focusedField: Field?

        TextField("Email", text: $email)
            .accessibilityFocused($focusedField, equals: .email)
        SecureField("Password", text: $password)
            .accessibilityFocused($focusedField, equals: .password)
        Button("Focus password") { focusedField = .password }
        """) { AnyView(C05_FocusedEqualsExample()) },

        ChildExampleEntry(parent: ".accessibilityFocused()", child: ".accessibilityFocused(_:)", code: """
        @AccessibilityFocusState private var isErrorFocused: Bool

        if showsError {
            ErrorBanner("Couldn't save. Try again.")
                .accessibilityFocused($isErrorFocused)
        }
        Button("Save") { showsError = true; isErrorFocused = true }
        """) { AnyView(C05_FocusedBoolExample()) },

        // MARK: .accessibilityHint()

        ChildExampleEntry(parent: ".accessibilityHint()", child: ".accessibilityHint(_:)", code: """
        Button("Archive") { archived += 1 }
            .accessibilityHint("Moves the conversation out of your inbox")
        Button("Snooze") { }
            .accessibilityHint(Text("Hides it until tomorrow"))
        """) { AnyView(C05_HintExample()) },

        ChildExampleEntry(parent: ".accessibilityHint()", child: ".accessibilityHint(_:isEnabled:)", code: """
        Button("Send") { sent += 1 }
            .accessibilityHint("Attaches \\(attachments) files", isEnabled: attachments > 0)
        Stepper("Attachments: \\(attachments)", value: $attachments, in: 0...5)
        """) { AnyView(C05_HintEnabledExample()) },

        // MARK: .accessibilityLabel()

        ChildExampleEntry(parent: ".accessibilityLabel()", child: ".accessibilityLabel(content:)", code: """
        Text(comment)
            .accessibilityLabel { label in
                Text("Comment")
                label                 // the inferred label, kept after the prefix
            }
        """) { AnyView(C05_LabelContentExample()) },

        ChildExampleEntry(parent: ".accessibilityLabel()", child: ".accessibilityLabel(_:)", code: """
        Button {
            isFavorite.toggle()
        } label: {
            Image(systemName: isFavorite ? "star.fill" : "star")
        }
        .accessibilityLabel(isFavorite ? "Remove favorite" : "Add favorite")
        """) { AnyView(C05_LabelStringExample()) },

        ChildExampleEntry(parent: ".accessibilityLabel()", child: ".accessibilityLabel(_:isEnabled:)", code: """
        Circle()
            .fill(Color.teal.gradient)
            .overlay(Text(initials))
            .accessibilityLabel(displayName, isEnabled: !displayName.isEmpty)
        TextField("Display name", text: $displayName)
        """) { AnyView(C05_LabelEnabledExample()) },

        // C05_MORE_ENTRIES
    ]
}

// MARK: - Shared helpers

/// A small inspector panel that mirrors what assistive technologies would read.
private struct C05_AXPanel: View {
    let pairs: [(String, String)]
    init(_ pairs: [(String, String)]) { self.pairs = pairs }

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            ForEach(Array(pairs.enumerated()), id: \.offset) { _, pair in
                HStack(alignment: .top, spacing: 6) {
                    Text(pair.0)
                        .foregroundStyle(.secondary)
                        .frame(width: 84, alignment: .trailing)
                    Text(pair.1)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .font(.caption.monospaced())
        .padding(8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 8))
    }
}

private struct C05_Caption: View {
    let text: String
    init(_ text: String) { self.text = text }

    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(.secondary)
            .fixedSize(horizontal: false, vertical: true)
    }
}

/// Marks where a synthesized activation lands.
private struct C05_Crosshair: View {
    var body: some View {
        ZStack {
            Circle().stroke(.red, lineWidth: 2).frame(width: 18, height: 18)
            Circle().fill(.red).frame(width: 4, height: 4)
        }
        .allowsHitTesting(false)
    }
}

/// Shows the entries a rotor would expose.
private struct C05_RotorPanel: View {
    let name: String
    let entries: [String]

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "dial.medium").foregroundStyle(.tint)
            VStack(alignment: .leading, spacing: 2) {
                Text("Rotor · \(name)").bold()
                Text(entries.joined(separator: "  ›  "))
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .font(.caption.monospaced())
        .padding(8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 8))
    }
}

/// Mock window chrome for scene-level illustrations.
private struct C05_MockWindow<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 6) {
                Circle().fill(.red).frame(width: 9, height: 9)
                Circle().fill(.yellow).frame(width: 9, height: 9)
                Circle().fill(.green).frame(width: 9, height: 9)
                Spacer()
                Text(title).font(.caption).foregroundStyle(.secondary)
                Spacer()
                Color.clear.frame(width: 39, height: 1)
            }
            .padding(.horizontal, 8)
            .frame(height: 24)
            .background(.quaternary.opacity(0.6))
            content
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(.background)
        .clipShape(.rect(cornerRadius: 8))
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.quaternary))
        .shadow(color: .black.opacity(0.18), radius: 6, y: 3)
    }
}

/// Mock Apple Watch bezel for watchOS-only illustrations.
private struct C05_WatchFrame<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        content
            .frame(width: 150, height: 120)
            .background(.black, in: .rect(cornerRadius: 26))
            .overlay(RoundedRectangle(cornerRadius: 26).stroke(.gray.opacity(0.7), lineWidth: 4))
    }
}

// MARK: - .accessibilityAction()

private struct C05_ActionNamedExample: View {
    @State private var isFlipped = false

    var body: some View {
        VStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 12)
                .fill(isFlipped ? Color.orange.gradient : Color.blue.gradient)
                .frame(width: 140, height: 64)
                .overlay(Text(isFlipped ? "Back" : "Front").bold().foregroundStyle(.white))
                .accessibilityLabel("Card")
                .accessibilityAction(named: "Flip") { isFlipped.toggle() }
            C05_AXPanel([("Label", "Card"), ("Actions", "Flip")])
            HStack {
                Button("Simulate “Flip”") { withAnimation { isFlipped.toggle() } }
                C05_Caption("Named actions appear in VoiceOver's actions menu.")
            }
        }
    }
}

private struct C05_ActionLabelExample: View {
    @State private var queued = 0

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "music.note").foregroundStyle(.pink)
                VStack(alignment: .leading) {
                    Text("Blue in Green").bold()
                    Text("Miles Davis").font(.caption).foregroundStyle(.secondary)
                }
                Spacer()
                Text("5:37").font(.caption.monospacedDigit()).foregroundStyle(.secondary)
            }
            .padding(10)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            .accessibilityElement(children: .combine)
            .accessibilityAction {
                queued += 1
            } label: {
                Label("Add to Queue", systemImage: "text.badge.plus")
            }
            C05_AXPanel([("Actions", "Add to Queue  (icon: text.badge.plus)"), ("Queued", "\(queued)")])
            HStack {
                Button("Simulate action") { queued += 1 }
                C05_Caption("The label view names the action; its image can appear in Switch Control menus.")
            }
        }
    }
}

private struct C05_ActionKindExample: View {
    @State private var isPlaying = false
    @State private var showsOverlay = true

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 12).fill(Color.indigo.gradient).frame(height: 70)
                HStack {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    Text(isPlaying ? "Playing" : "Paused")
                }
                .foregroundStyle(.white)
                .bold()
                if showsOverlay {
                    Text("Lyrics overlay")
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(.ultraThinMaterial, in: .capsule)
                        .offset(y: 24)
                }
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Player")
            .accessibilityAction { isPlaying.toggle() }
            .accessibilityAction(.escape) { showsOverlay = false }
            C05_AXPanel([("Actions", "activate (.default) → toggle playback\nescape → dismiss overlay")])
            HStack {
                Button("Simulate activate") { isPlaying.toggle() }
                Button("Simulate escape") { withAnimation { showsOverlay = false } }
                Button("Reset") { withAnimation { showsOverlay = true } }
            }
        }
    }
}

private struct C05_ActionNamedFormsExample: View {
    @State private var isFlipped = false
    @State private var archived = false

    var body: some View {
        VStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 12)
                .fill(archived ? Color.gray.gradient : (isFlipped ? Color.orange.gradient : Color.blue.gradient))
                .frame(width: 140, height: 60)
                .overlay(Text(archived ? "Archived" : (isFlipped ? "Back" : "Front")).bold().foregroundStyle(.white))
                .accessibilityLabel("Card")
                .accessibilityAction(named: "Flip") { isFlipped.toggle() }
                .accessibilityAction(named: Text("Archive")) { archived = true }
            C05_AXPanel([("Actions", "Flip (String), Archive (Text)")])
            HStack {
                Button("Flip") { withAnimation { isFlipped.toggle() } }
                Button("Archive") { withAnimation { archived = true } }
                Button("Reset") { withAnimation { archived = false; isFlipped = false } }
                C05_Caption("Simulates the named actions.")
            }
        }
    }
}

// MARK: - .accessibilityActions()

private struct C05_ActionsCategoryExample: View {
    @State private var note = "Groceries"

    var body: some View {
        VStack(spacing: 10) {
            TextEditor(text: $note)
                .font(.body)
                .frame(height: 64)
                .clipShape(.rect(cornerRadius: 8))
                .accessibilityLabel("Note")
                .accessibilityActions(category: .edit) {
                    Button("Insert checklist") { note += "\n☐ " }
                }
            C05_AXPanel([("Edit actions", "Insert checklist")])
            HStack {
                Button("Simulate “Insert checklist”") { note += "\n☐ " }
                C05_Caption("Edit-category actions sit in VoiceOver's editing section.")
            }
        }
    }
}

private struct C05_ActionsBuilderExample: View {
    @State private var pinned = false
    @State private var deleted = false

    var body: some View {
        VStack(spacing: 10) {
            if deleted {
                Text("Note deleted")
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
            } else {
                HStack {
                    Image(systemName: pinned ? "pin.fill" : "note.text")
                        .foregroundStyle(pinned ? Color.orange : Color.secondary)
                    Text("Call the plumber")
                    Spacer()
                }
                .padding(10)
                .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
                .accessibilityElement(children: .combine)
                .accessibilityActions {
                    Button("Pin") { pinned.toggle() }
                    Button("Delete", role: .destructive) { deleted = true }
                }
            }
            C05_AXPanel([("Actions", "Pin, Delete (destructive)")])
            HStack {
                Button("Simulate Pin") { pinned.toggle() }
                Button("Simulate Delete", role: .destructive) { deleted = true }
                Button("Reset") { deleted = false; pinned = false }
            }
        }
    }
}

private struct C05_ActionsCategoryBuilderExample: View {
    @State private var draft = "Meeting notes"
    @State private var isBold = true

    var body: some View {
        VStack(spacing: 10) {
            TextEditor(text: $draft)
                .font(isBold ? .body.bold() : .body)
                .frame(height: 64)
                .clipShape(.rect(cornerRadius: 8))
                .accessibilityLabel("Draft")
                .accessibilityActions(category: .edit) {
                    Button("Insert checklist") { draft += "\n☐ " }
                    Button("Clear formatting") { isBold = false }
                }
            C05_AXPanel([("Edit actions", "Insert checklist, Clear formatting"), ("Bold", "\(isBold)")])
            HStack {
                Button("Insert checklist") { draft += "\n☐ " }
                Button("Clear formatting") { isBold = false }
                Button("Reset") { isBold = true; draft = "Meeting notes" }
            }
        }
    }
}

// MARK: - .accessibilityActivationPoint()

private struct C05_ActivationUnitPointExample: View {
    @State private var notificationsOn = true
    private let point = UnitPoint(x: 0.92, y: 0.5)

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Notifications")
                Spacer()
                Toggle("Notifications", isOn: $notificationsOn)
                    .labelsHidden()
                    .toggleStyle(.switch)
            }
            .padding(.horizontal, 12)
            .frame(height: 44)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            .accessibilityElement(children: .combine)
            .accessibilityActivationPoint(point)
            .overlay {
                GeometryReader { geo in
                    C05_Crosshair()
                        .position(x: geo.size.width * point.x, y: geo.size.height * point.y)
                }
            }
            C05_AXPanel([("Activation", "UnitPoint(x: 0.92, y: 0.5) → lands on the switch")])
            C05_Caption("A VoiceOver double-tap is delivered at the crosshair, however wide the row becomes.")
        }
    }
}

private struct C05_ActivationCGPointExample: View {
    @State private var taps = 0

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                    .padding(.horizontal, 14)
                    .frame(height: 44)
                    .background(.tint.opacity(0.15), in: .capsule)
                    .onTapGesture { taps += 1 }
                    .accessibilityAddTraits(.isButton)
                    .accessibilityActivationPoint(CGPoint(x: 24, y: 22))
                    .overlay(alignment: .topLeading) {
                        C05_Crosshair().position(x: 24, y: 22)
                    }
                Spacer()
            }
            C05_AXPanel([("Activation", "CGPoint(x: 24, y: 22) — the icon, in local points"), ("Taps", "\(taps)")])
            C05_Caption("Absolute coordinates suit a control that keeps a fixed offset inside the element.")
        }
    }
}

private struct C05_ActivationEnabledExample: View {
    @State private var syncOn = true
    @State private var showsToggle = true

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Sync")
                Spacer()
                if showsToggle {
                    Toggle("Sync", isOn: $syncOn)
                        .labelsHidden()
                        .toggleStyle(.switch)
                }
            }
            .padding(.horizontal, 12)
            .frame(height: 44)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            .accessibilityElement(children: .combine)
            .accessibilityActivationPoint(.trailing, isEnabled: showsToggle)
            .overlay(alignment: .trailing) {
                if showsToggle { C05_Crosshair() }
            }
            .padding(.trailing, 8)
            Toggle("showsToggle", isOn: $showsToggle)
            C05_AXPanel([("Activation", showsToggle ? ".trailing (enabled)" : "default — centre of the element")])
        }
    }
}

// MARK: - .accessibilityCustomContent()

private extension AccessibilityCustomContentKey {
    static let servings = AccessibilityCustomContentKey("Servings", id: "servings")
    static let prepTime = AccessibilityCustomContentKey("Prep time")
}

private struct C05_CustomContentKeyStringExample: View {
    @State private var minutes = 25
    private let difficulty = "Easy"

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "fork.knife").foregroundStyle(.orange)
                VStack(alignment: .leading) {
                    Text("Shakshuka").bold()
                    Text("\(minutes) min · \(difficulty)").font(.caption).foregroundStyle(.secondary)
                }
                Spacer()
            }
            .padding(10)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            .accessibilityElement(children: .combine)
            .accessibilityCustomContent("Prep time", "\(minutes) minutes")
            .accessibilityCustomContent("Difficulty", difficulty, importance: .high)
            Stepper("Prep minutes: \(minutes)", value: $minutes, in: 5...90, step: 5)
            C05_AXPanel([
                ("Read up front", "Difficulty: \(difficulty)  (importance: .high)"),
                ("More Content", "Prep time: \(minutes) minutes  (.default)")
            ])
        }
    }
}

private struct C05_CustomContentTextExample: View {
    @State private var name = "Steps"
    @State private var value = 8_412
    private let goal = 10_000

    var body: some View {
        VStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 2) {
                Text(name).font(.caption).foregroundStyle(.secondary)
                Text(value, format: .number).font(.title2.monospacedDigit()).bold()
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            .accessibilityElement(children: .combine)
            .accessibilityCustomContent(Text(name), Text(value, format: .number))
            .accessibilityCustomContent(Text("Goal"), Text(goal, format: .number), importance: .high)
            HStack {
                Picker("Label", selection: $name) {
                    Text("Steps").tag("Steps")
                    Text("Calories").tag("Calories")
                }
                .pickerStyle(.segmented)
                .labelsHidden()
                Button("+500") { value += 500 }
            }
            C05_AXPanel([("More Content", "\(name): \(value)"), ("Up front", "Goal: \(goal)")])
            C05_Caption("Both halves are Text, so a runtime label like “\(name)” needs no LocalizedStringKey.")
        }
    }
}

private struct C05_CustomContentKeyedExample: View {
    @State private var servings = 4

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "fork.knife").foregroundStyle(.orange)
                Text("Paella").bold()
                Spacer()
                Text("\(servings) servings").font(.caption).foregroundStyle(.secondary)
            }
            .padding(10)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            .accessibilityElement(children: .combine)
            .accessibilityCustomContent(.servings, "4", importance: .high)
            .accessibilityCustomContent(.servings, "\(servings)")
            Stepper("Servings: \(servings)", value: $servings, in: 1...12)
            C05_AXPanel([("Key", "servings  (label “Servings”)"), ("Value", "\(servings) — the later call replaced “4”")])
        }
    }
}

// MARK: - .accessibilityFocused()

private struct C05_FocusedEqualsExample: View {
    enum Field: Hashable { case email, password }
    @AccessibilityFocusState private var focusedField: Field?
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 10) {
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .accessibilityFocused($focusedField, equals: .email)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .accessibilityFocused($focusedField, equals: .password)
            HStack {
                Button("Focus email") { focusedField = .email }
                Button("Focus password") { focusedField = .password }
            }
            C05_AXPanel([("focusedField", focusedField.map { "\($0)" } ?? "nil")])
            C05_Caption("Holds the focused case only while VoiceOver's cursor is on a field; setting it moves the cursor.")
        }
    }
}

private struct C05_FocusedBoolExample: View {
    @AccessibilityFocusState private var isErrorFocused: Bool
    @State private var showsError = false

    var body: some View {
        VStack(spacing: 10) {
            if showsError {
                Label("Couldn't save. Try again.", systemImage: "exclamationmark.triangle.fill")
                    .foregroundStyle(.red)
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.red.opacity(0.12), in: .rect(cornerRadius: 8))
                    .accessibilityFocused($isErrorFocused)
            }
            HStack {
                Button("Save") {
                    showsError = true
                    isErrorFocused = true
                }
                Button("Dismiss") { showsError = false }
            }
            C05_AXPanel([("isErrorFocused", "\(isErrorFocused)")])
            C05_Caption("Setting the Bool pulls the VoiceOver cursor to the banner; it reads true only while the cursor rests there.")
        }
    }
}

// MARK: - .accessibilityHint()

private struct C05_HintExample: View {
    @State private var archived = 0

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Button("Archive") { archived += 1 }
                    .accessibilityHint("Moves the conversation out of your inbox")
                Button("Snooze") { }
                    .accessibilityHint(Text("Hides it until tomorrow"))
            }
            C05_AXPanel([
                ("Archive", "“Archive, button. Moves the conversation out of your inbox.”"),
                ("Snooze", "“Snooze, button. Hides it until tomorrow.”"),
                ("Archived", "\(archived)")
            ])
        }
    }
}

private struct C05_HintEnabledExample: View {
    @State private var attachments = 2
    @State private var sent = 0

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Button("Send") { sent += 1 }
                    .accessibilityHint("Attaches \(attachments) files", isEnabled: attachments > 0)
                Stepper("Attachments: \(attachments)", value: $attachments, in: 0...5)
            }
            C05_AXPanel([
                ("Hint", attachments > 0 ? "“Attaches \(attachments) files”" : "none — isEnabled is false"),
                ("Sent", "\(sent)")
            ])
        }
    }
}

// MARK: - .accessibilityLabel()

private struct C05_LabelContentExample: View {
    @State private var comment = "Looks great, ship it!"

    var body: some View {
        VStack(spacing: 10) {
            Text(comment)
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
                .accessibilityLabel { label in
                    Text("Comment")
                    label
                }
            TextField("Comment", text: $comment).textFieldStyle(.roundedBorder)
            C05_AXPanel([("Label", "Comment, \(comment)")])
            C05_Caption("The closure receives the inferred label so you can prefix it instead of retyping it.")
        }
    }
}

private struct C05_LabelStringExample: View {
    @State private var isFavorite = false

    var body: some View {
        VStack(spacing: 10) {
            Button {
                isFavorite.toggle()
            } label: {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .font(.title)
                    .foregroundStyle(isFavorite ? Color.yellow : Color.secondary)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(isFavorite ? "Remove favorite" : "Add favorite")
            C05_AXPanel([("Label", isFavorite ? "Remove favorite" : "Add favorite"), ("Without it", isFavorite ? "“star fill”" : "“star”")])
        }
    }
}

private struct C05_LabelEnabledExample: View {
    @State private var displayName = "Ada Lovelace"

    private var initials: String {
        displayName.split(separator: " ").compactMap { $0.first }.map(String.init).joined()
    }

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 12) {
                Circle()
                    .fill(Color.teal.gradient)
                    .frame(width: 44, height: 44)
                    .overlay(Text(initials.isEmpty ? "?" : initials).bold().foregroundStyle(.white))
                    .accessibilityLabel(displayName, isEnabled: !displayName.isEmpty)
                TextField("Display name", text: $displayName).textFieldStyle(.roundedBorder)
            }
            C05_AXPanel([("Label", displayName.isEmpty ? "inferred (none) — isEnabled is false" : displayName)])
        }
    }
}

// C05_MORE_STRUCTS
