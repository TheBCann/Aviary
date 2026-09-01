//
//  Catalog+MoreEnvironment.swift
//  Swift-UI-Companion
//
//  Second wave of environment values: system context, search, and
//  data-framework integrations.
//

import Foundation

extension Catalog {
    static let moreEnvironmentValues: [Topic] = [
        Topic(
            name: "undoManager",
            kind: .environmentValue,
            summary: "The UndoManager serving the current window.",
            discussion: "Register undo blocks with the environment's undoManager and the standard Edit-menu items and gestures work without extra wiring. Document-based scenes supply one automatically.",
            wwdcYear: 2019,
            code: #"""
            @Environment(\.undoManager) private var undoManager

            func rename(_ item: Item, to newName: String) {
                let oldName = item.name
                item.name = newName
                undoManager?.registerUndo(withTarget: item) {
                    $0.name = oldName
                }
            }
            """#,
            related: ["DocumentGroup", "@Environment"]
        ),
        Topic(
            name: "modelContext",
            kind: .environmentValue,
            summary: "The SwiftData context for inserts, deletes, and saves.",
            discussion: "Apps that attach a modelContainer get a modelContext in the environment: insert and delete models there, and @Query views update automatically. Requires import SwiftData.",
            wwdcYear: 2023,
            framework: "SwiftData",
            code: #"""
            @Environment(\.modelContext) private var context

            Button("Add Trip") {
                context.insert(Trip(name: "New Trip"))
            }
            """#,
            related: ["@Query", "@Environment"]
        ),
        Topic(
            name: "displayScale",
            kind: .environmentValue,
            summary: "The screen's points-to-pixels scale factor.",
            discussion: "displayScale reports 1, 2, or 3× rendering density — what you need to draw true hairlines or rasterize images at native resolution. pixelLength gives the same fact as a point size.",
            wwdcYear: 2019,
            code: #"""
            @Environment(\.displayScale) private var scale

            Rectangle()
                .frame(height: 1 / scale)   // a true hairline
            """#,
            related: ["colorScheme", "@Environment"]
        ),
        Topic(
            name: "calendar",
            kind: .environmentValue,
            summary: "The calendar used for date computation and display.",
            discussion: "Views read the environment's calendar for week layouts and date math, so injecting one — say, ISO 8601 with Monday weeks — restyles every date view in a subtree consistently.",
            wwdcYear: 2019,
            code: #"""
            CalendarGrid()
                .environment(\.calendar, Calendar(identifier: .iso8601))
            """#,
            related: ["locale", "timeZone"]
        ),
        Topic(
            name: "timeZone",
            kind: .environmentValue,
            summary: "The time zone dates are rendered in.",
            discussion: "Override timeZone to preview schedules in another region or pin a departure board to airport local time regardless of the device setting.",
            wwdcYear: 2019,
            code: #"""
            FlightBoard(flights)
                .environment(\.timeZone, TimeZone(identifier: "Asia/Tokyo")!)
            """#,
            related: ["calendar", "locale"]
        ),
        Topic(
            name: "editMode",
            kind: .environmentValue,
            summary: "Whether the containing list is in edit mode.",
            discussion: "editMode carries the active/inactive editing state EditButton toggles. Read it to swap row content while editing, or write it to enter edit mode programmatically.",
            wwdcYear: 2019,
            platforms: [.iOS],
            code: #"""
            @Environment(\.editMode) private var editMode

            if editMode?.wrappedValue.isEditing == true {
                ReorderHint()
            }
            """#,
            related: ["EditButton", "List"]
        ),
        Topic(
            name: "isSearching",
            kind: .environmentValue,
            summary: "Whether the user is interacting with the search field.",
            discussion: "isSearching turns true while search is active, letting the searched content swap in suggestions or recents. It must be read from a view inside the searchable modifier's scope, not the one applying it.",
            wwdcYear: 2021,
            code: #"""
            @Environment(\.isSearching) private var isSearching

            if isSearching && query.isEmpty {
                RecentSearches()
            }
            """#,
            related: [".searchable()", "dismissSearch"]
        ),
        Topic(
            name: "dismissSearch",
            kind: .environmentValue,
            summary: "An action that ends the current search session.",
            discussion: "Call dismissSearch after the user picks a result to close the search UI and clear focus — the search counterpart of dismiss. Like isSearching, read it inside the searchable scope.",
            wwdcYear: 2021,
            code: #"""
            @Environment(\.dismissSearch) private var dismissSearch

            Button(result.title) {
                open(result)
                dismissSearch()
            }
            """#,
            related: ["isSearching", ".searchable()"]
        ),
        Topic(
            name: "requestReview",
            kind: .environmentValue,
            summary: "Asks StoreKit to show the rating prompt when appropriate.",
            discussion: "requestReview is a polite request, not a command — the system decides whether the prompt actually appears, capping frequency. Call it after a satisfying moment, never from a button promising a review. Requires import StoreKit.",
            wwdcYear: 2022,
            platforms: [.iOS, .macOS],
            framework: "StoreKit",
            code: #"""
            import StoreKit

            @Environment(\.requestReview) private var requestReview

            .onChange(of: completedLevels) {
                if completedLevels == 10 { requestReview() }
            }
            """#,
            related: ["ProductView", "@Environment"]
        ),
        Topic(
            name: "supportsMultipleWindows",
            kind: .environmentValue,
            summary: "Whether this platform and app can open extra windows.",
            discussion: "supportsMultipleWindows is true on macOS and multi-window iPad configurations, false on iPhone — the check that keeps 'Open in New Window' buttons from appearing where openWindow would do nothing.",
            wwdcYear: 2022,
            platforms: [.iOS, .macOS],
            code: #"""
            @Environment(\.supportsMultipleWindows) private var supportsMultipleWindows

            if supportsMultipleWindows {
                Button("Open in New Window") { openWindow(id: "detail") }
            }
            """#,
            related: ["openWindow", "WindowGroup"]
        ),
    ]
}
