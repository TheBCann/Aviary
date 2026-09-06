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

// C05_MORE_STRUCTS
