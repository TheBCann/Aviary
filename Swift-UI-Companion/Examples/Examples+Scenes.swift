//
//  Examples+Scenes.swift
//  Swift-UI-Companion
//
//  Rendered usage examples for the entries in CatalogData/scenes.json.
//  Every topic here is a Scene — it cannot literally run inside a view, so
//  each example renders a faithful illustration with a caption while the
//  code string shows the true Scene-level API.
//

import SwiftUI

enum ExamplesScenes {
    static let entries: [ExampleEntry] = [
        ExampleEntry(topic: "DocumentGroup", code: """
        DocumentGroup(newDocument: TextFile()) { file in
            TextEditor(text: file.$document.text)
                .navigationTitle(file.fileURL?.lastPathComponent ?? "Untitled")
        }
        // New / Open / Save / rename / iCloud come from the system.
        """) { AnyView(Sc_DocumentGroupExample()) },

        ExampleEntry(topic: "DocumentGroupLaunchScene", code: """
        DocumentGroupLaunchScene("Sketchpad") {
            NewDocumentButton("New Sketch")
            Button("Import…") { showImporter = true }
        } background: {
            LinearGradient(colors: [.indigo, .black],
                           startPoint: .top, endPoint: .bottom)
        }
        """) { AnyView(Sc_DocumentGroupLaunchSceneExample()) },

        ExampleEntry(topic: "MenuBarExtra", code: """
        MenuBarExtra("Companion", systemImage: "swift") {
            QuickSearchView(query: $query)
                .frame(width: 240)
        }
        .menuBarExtraStyle(.window)
        """) { AnyView(Sc_MenuBarExtraExample()) },

        ExampleEntry(topic: "Settings", code: """
        Settings {
            TabView {
                Form {
                    Toggle("Launch at login", isOn: $launchAtLogin)
                    Toggle("Show in Dock", isOn: $showInDock)
                }
                .formStyle(.grouped)
                .tabItem { Label("General", systemImage: "gear") }
            }
        }
        """) { AnyView(Sc_SettingsExample()) },

        ExampleEntry(topic: "Window", code: """
        Window("About Companion", id: "about") {
            AboutView()
        }
        .windowResizability(.contentSize)

        // elsewhere:
        @Environment(\\.openWindow) private var openWindow
        Button("Open About") { openWindow(id: "about") }
        """) { AnyView(Sc_WindowExample()) },

        ExampleEntry(topic: "WindowGroup", code: """
        WindowGroup(for: Note.ID.self) { $noteID in
            NoteEditor(id: noteID)
        }

        // elsewhere:
        @Environment(\\.openWindow) private var openWindow
        Button("New Window") { openWindow(value: note.id) }
        """) { AnyView(Sc_WindowGroupExample()) },
    ]
}

// MARK: - Shared illustration helpers

/// Mock macOS window chrome — traffic lights and a title bar — so Scene-level
/// examples can show what their windows look like without opening real ones.
private struct Sc_WindowChrome<Content: View>: View {
    let title: String
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 6) {
                Circle().fill(.red).frame(width: 10, height: 10)
                Circle().fill(.yellow).frame(width: 10, height: 10)
                Circle().fill(.green).frame(width: 10, height: 10)
                Spacer()
                Text(title)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
                Spacer()
                Color.clear.frame(width: 42, height: 1)
            }
            .padding(.horizontal, 10)
            .frame(height: 26)
            .background(.regularMaterial)

            Divider()

            content()
        }
        .background(.background)
        .clipShape(.rect(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))
    }
}

private func Sc_caption(_ text: String) -> some View {
    Label(text, systemImage: "info.circle")
        .font(.caption2)
        .foregroundStyle(.secondary)
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity, alignment: .leading)
}

// MARK: - DocumentGroup

private struct Sc_DocumentGroupExample: View {
    @State private var text = "Meeting notes\n\n- Ship the beta\n- Review the TOC parser"

    var body: some View {
        VStack(spacing: 8) {
            Sc_WindowChrome(title: "Untitled.txt") {
                TextEditor(text: $text)
                    .font(.callout.monospaced())
                    .scrollContentBackground(.hidden)
                    .padding(6)
                    .frame(height: 120)
            }
            Sc_caption("Illustrative — DocumentGroup is a Scene; New, Open, Save and rename come from the system.")
        }
    }
}

// MARK: - DocumentGroupLaunchScene

private struct Sc_DocumentGroupLaunchSceneExample: View {
    @State private var sketches = 0

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                LinearGradient(colors: [.indigo, .black],
                               startPoint: .top, endPoint: .bottom)
                VStack(spacing: 14) {
                    Text("Sketchpad")
                        .font(.title.weight(.bold))
                        .foregroundStyle(.white)
                    HStack(spacing: 10) {
                        Button {
                            sketches += 1
                        } label: {
                            Label("New Sketch", systemImage: "plus")
                        }
                        .buttonStyle(.borderedProminent)
                        Button("Import…") { }
                            .buttonStyle(.bordered)
                            .tint(.white)
                    }
                    .controlSize(.large)

                    Text(sketches == 0
                         ? "Tap to create a document"
                         : "\(sketches) sketch\(sketches == 1 ? "" : "es") created")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.85))
                }
                .padding()
            }
            .frame(height: 150)
            .clipShape(.rect(cornerRadius: 10))

            Sc_caption("Illustrative — iOS only; the launch screen a document app shows first.")
        }
    }
}

// MARK: - MenuBarExtra

private struct Sc_MenuBarExtraExample: View {
    @State private var query = ""
    private let topics = ["WindowGroup", "MenuBarExtra", "DocumentGroup",
                          "Settings", "Window", "openWindow"]

    private var matches: [String] {
        query.isEmpty
            ? topics
            : topics.filter { $0.localizedCaseInsensitiveContains(query) }
    }

    var body: some View {
        VStack(spacing: 8) {
            // The system menu bar, with the app's status item highlighted.
            HStack(spacing: 14) {
                Spacer()
                Image(systemName: "wifi")
                Image(systemName: "battery.100")
                Image(systemName: "swift")
                    .padding(3)
                    .background(.blue.opacity(0.25), in: .rect(cornerRadius: 4))
                Text("9:41")
            }
            .font(.caption)
            .padding(.horizontal, 10)
            .frame(height: 24)
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 6))

            // The .window-style panel hanging off the status item.
            VStack(alignment: .leading, spacing: 6) {
                TextField("Search topics", text: $query)
                    .textFieldStyle(.roundedBorder)
                if matches.isEmpty {
                    Text("No matches")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(matches.prefix(3), id: \.self) { topic in
                        HStack(spacing: 6) {
                            Image(systemName: "number")
                                .foregroundStyle(.secondary)
                            Text(topic)
                            Spacer()
                        }
                        .font(.callout)
                    }
                }
            }
            .padding(10)
            .frame(width: 240, alignment: .leading)
            .background(.quaternary, in: .rect(cornerRadius: 8))
            .overlay(alignment: .top) {
                Image(systemName: "arrowtriangle.up.fill")
                    .foregroundStyle(.quaternary)
                    .offset(y: -7)
            }

            Sc_caption("Illustrative — MenuBarExtra lives in the menu bar; .window gives it a full panel.")
        }
    }
}

// MARK: - Settings

private struct Sc_SettingsExample: View {
    @State private var launchAtLogin = true
    @State private var showInDock = true
    @State private var selection = 0

    var body: some View {
        VStack(spacing: 8) {
            Sc_WindowChrome(title: "Companion Settings") {
                TabView(selection: $selection) {
                    Form {
                        Toggle("Launch at login", isOn: $launchAtLogin)
                        Toggle("Show in Dock", isOn: $showInDock)
                    }
                    .formStyle(.grouped)
                    .tabItem { Label("General", systemImage: "gear") }
                    .tag(0)

                    Form {
                        LabeledContent("Cache", value: "128 MB")
                        Button("Clear Cache") { }
                    }
                    .formStyle(.grouped)
                    .tabItem { Label("Advanced", systemImage: "slider.horizontal.3") }
                    .tag(1)
                }
                .padding(6)
                .frame(height: 150)
            }
            Sc_caption("Illustrative — the Settings scene adds the app's Settings menu item and ⌘, window.")
        }
    }
}

// MARK: - Window

private struct Sc_WindowExample: View {
    @State private var isOpen = true

    var body: some View {
        VStack(spacing: 10) {
            Button {
                isOpen = true          // one instance — reopening just brings it forward
            } label: {
                Label("Open About", systemImage: "macwindow")
            }
            .buttonStyle(.bordered)

            if isOpen {
                Sc_WindowChrome(title: "About Companion") {
                    VStack(spacing: 6) {
                        Image(systemName: "swift")
                            .font(.system(size: 32))
                            .foregroundStyle(.orange)
                        Text("SwiftUI Companion").font(.headline)
                        Text("Version 1.0 (26)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Button("Close") { isOpen = false }
                            .buttonStyle(.borderless)
                            .padding(.top, 2)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(14)
                }
                .frame(width: 220)
                .transition(.scale.combined(with: .opacity))
            } else {
                Text("Window closed — tap Open About")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(height: 120)
            }

            Sc_caption("Illustrative — Window is a single unique instance, opened via openWindow(id:).")
        }
        .animation(.snappy, value: isOpen)
    }
}

// MARK: - WindowGroup

private struct Sc_WindowGroupExample: View {
    @State private var count = 2

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 8) {
                Button {
                    if count < 4 { count += 1 }
                } label: {
                    Label("New Window", systemImage: "plus.rectangle.on.rectangle")
                }
                .buttonStyle(.borderedProminent)
                .disabled(count == 4)

                Button("Close") { if count > 0 { count -= 1 } }
                    .buttonStyle(.bordered)
                    .disabled(count == 0)
            }
            .controlSize(.small)

            ZStack {
                if count == 0 {
                    Text("No windows open")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                ForEach(0..<count, id: \.self) { i in
                    Sc_WindowChrome(title: "Note \(i + 1)") {
                        HStack(spacing: 6) {
                            Image(systemName: "doc.text")
                                .foregroundStyle(.secondary)
                            Text("Editing note \(i + 1)")
                                .font(.caption)
                            Spacer()
                        }
                        .padding(8)
                    }
                    .frame(width: 170)
                    .offset(x: Double(i) * 18, y: Double(i) * 16)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 120)

            Sc_caption("Illustrative — WindowGroup makes many identical windows; openWindow(value:) opens one.")
        }
        .animation(.snappy, value: count)
    }
}
