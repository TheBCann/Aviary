//
//  Catalog+Scenes.swift
//  Swift-UI-Companion
//

import Foundation

extension Catalog {
    static let scenes: [Topic] = [
        Topic(
            name: "WindowGroup",
            kind: .scene,
            summary: "The standard scene for an app's main windows.",
            discussion: "WindowGroup can instantiate any number of identical windows (macOS and iPadOS) from one declaration. Give it an id or a presented value type to open specific windows programmatically through the openWindow environment action.",
            wwdcYear: 2020,
            code: #"""
            WindowGroup(id: "main") {
                ContentView()
            }

            // elsewhere:
            @Environment(\.openWindow) private var openWindow
            openWindow(id: "main")
            """#,
            related: ["Window", "Scene", "openWindow"],
            children: [
                TopicChild(
                    name: "WindowGroup(_:content:)",
                    summary: "The basic form: a titled group of identical windows.",
                    code: #"""
                    WindowGroup("Library") {
                        LibraryView()
                    }
                    """#
                ),
                TopicChild(
                    name: "WindowGroup(id:content:)",
                    summary: "Adds a stable identifier so openWindow can target the group.",
                    code: #"""
                    WindowGroup(id: "main") {
                        ContentView()
                    }

                    // later:
                    openWindow(id: "main")
                    """#
                ),
                TopicChild(
                    name: "WindowGroup(for:content:)",
                    summary: "Presents a window per value — one editor per document id.",
                    discussion: "The system opens one window per distinct value and hands the content closure a binding to an optional — it is nil when a window opens without a presented value, as from the New Window menu command, so the content must handle that case. openWindow(value:) reuses an existing window when the value already has one, and the defaultValue: overload supplies a fallback that makes the binding non-optional.",
                    code: #"""
                    WindowGroup(for: Note.ID.self) { $noteID in
                        // noteID is Note.ID? — nil for a plain new window
                        NoteEditor(id: noteID)
                    }

                    // later:
                    openWindow(value: note.id)
                    """#
                ),
            ]
        ),
        Topic(
            name: "Window",
            kind: .scene,
            summary: "A single, unique window on macOS.",
            discussion: "Where WindowGroup multiplies, Window guarantees exactly one instance — right for dashboards, about panels, and utility windows. It joins the Windows menu automatically and opens via its id.",
            wwdcYear: 2022,
            platforms: [.macOS],
            code: #"""
            Window("Activity", id: "activity") {
                ActivityView()
            }
            .keyboardShortcut("0", modifiers: [.command, .option])
            """#,
            related: ["WindowGroup", "MenuBarExtra"]
        ),
        Topic(
            name: "Settings",
            kind: .scene,
            summary: "The macOS Settings window, wired to the app menu.",
            discussion: "Declaring a Settings scene gives the app the standard Settings menu item, ⌘, shortcut, and window. TabViews inside render as settings panes.",
            wwdcYear: 2020,
            platforms: [.macOS],
            code: #"""
            Settings {
                TabView {
                    GeneralPane()
                        .tabItem { Label("General", systemImage: "gear") }
                }
            }
            """#,
            related: ["WindowGroup", "@AppStorage"]
        ),
        Topic(
            name: "DocumentGroup",
            kind: .scene,
            summary: "Document-based app scenes with open/save for free.",
            discussion: "DocumentGroup binds a FileDocument or ReferenceFileDocument type to editor windows, inheriting the platform's new/open/save/rename machinery, recents, and iCloud integration.",
            wwdcYear: 2020,
            platforms: [.iOS, .macOS],
            code: #"""
            DocumentGroup(newDocument: TextFile()) { file in
                EditorView(document: file.$document)
            }
            """#,
            related: ["WindowGroup"]
        ),
        Topic(
            name: "MenuBarExtra",
            kind: .scene,
            summary: "Puts your app in the macOS menu bar.",
            discussion: "MenuBarExtra installs a status item with either a pull-down menu or, with the window style, a full SwiftUI popover panel. Apps can be menu-bar-only by making it their sole scene. This very app uses one for quick topic search.",
            wwdcYear: 2022,
            platforms: [.macOS],
            code: #"""
            MenuBarExtra("Companion", systemImage: "swift") {
                QuickSearchView()
            }
            .menuBarExtraStyle(.window)
            """#,
            related: ["Window", "Scene"]
        ),
    ]
}
