//
//  Examples+EnvironmentValues.swift
//  Swift-UI-Companion
//
//  Rendered usage examples for the entries in CatalogData/environment-values.json.
//  Environment values are mostly non-visual, so each example reads the value with
//  @Environment and puts it on screen, drives a live control with it, or — where an
//  API only takes effect at the Scene / system level — renders a faithful
//  illustration with a caption while the code string shows the true API.
//
//  Entries that already carry a demoID (controlSize) are handled elsewhere.
//

import SwiftUI
import Observation

enum ExamplesEnvironmentValues {
    static let entries: [ExampleEntry] = [
        ExampleEntry(topic: "accessibilityReduceMotion", code: """
        @Environment(\\.accessibilityReduceMotion) private var reduceMotion

        Button("Toggle") {
            withAnimation(reduceMotion ? nil : .spring) {
                isExpanded.toggle()
            }
        }
        """) { AnyView(EV_ReduceMotionExample()) },

        ExampleEntry(topic: "calendar", code: """
        @Environment(\\.calendar) private var calendar

        // Reorder the weekday header by the injected calendar's first day.
        let start = calendar.firstWeekday - 1
        let days = (0..<7).map { calendar.veryShortWeekdaySymbols[($0 + start) % 7] }

        WeekStrip(days)
            .environment(\\.calendar, Calendar(identifier: .iso8601))
        """) { AnyView(EV_CalendarExample()) },

        ExampleEntry(topic: "colorScheme", code: """
        @Environment(\\.colorScheme) private var colorScheme

        Circle().fill(colorScheme == .dark ? .yellow : .orange)
        Text("Scheme: \\(colorScheme == .dark ? "dark" : "light")")
        """) { AnyView(EV_ColorSchemeExample()) },

        ExampleEntry(topic: "colorSchemeContrast", code: """
        @Environment(\\.colorSchemeContrast) private var contrast

        var borderColor: Color {
            contrast == .increased ? .black : .gray
        }
        """) { AnyView(EV_ColorSchemeContrastExample()) },

        ExampleEntry(topic: "dismiss", code: """
        @Environment(\\.dismiss) private var dismiss

        Button("Done") { dismiss() }
        """) { AnyView(EV_DismissExample()) },

        ExampleEntry(topic: "dismissSearch", code: """
        @Environment(\\.dismissSearch) private var dismissSearch

        Button(result.title) {
            open(result)
            dismissSearch()
        }
        """) { AnyView(EV_DismissSearchExample()) },

        ExampleEntry(topic: "displayScale", code: """
        @Environment(\\.displayScale) private var scale

        Rectangle()
            .frame(height: 1 / scale)   // a true hairline
        """) { AnyView(EV_DisplayScaleExample()) },

        ExampleEntry(topic: "dynamicTypeSize", code: """
        @Environment(\\.dynamicTypeSize) private var typeSize

        var body: some View {
            if typeSize.isAccessibilitySize {
                VStack { labels }
            } else {
                HStack { labels }
            }
        }
        """) { AnyView(EV_DynamicTypeSizeExample()) },

        ExampleEntry(topic: "editMode", code: """
        @Environment(\\.editMode) private var editMode

        if editMode?.wrappedValue.isEditing == true {
            ReorderHint()
        }
        """) { AnyView(EV_EditModeExample()) },

        ExampleEntry(topic: "horizontalSizeClass", code: """
        @Environment(\\.horizontalSizeClass) private var sizeClass

        var body: some View {
            sizeClass == .compact ? AnyView(list) : AnyView(splitView)
        }
        """) { AnyView(EV_HorizontalSizeClassExample()) },

        ExampleEntry(topic: "isEnabled", code: """
        struct FadedStyle: ButtonStyle {
            @Environment(\\.isEnabled) private var isEnabled

            func makeBody(configuration: Configuration) -> some View {
                configuration.label
                    .opacity(isEnabled ? 1 : 0.4)
            }
        }
        """) { AnyView(EV_IsEnabledExample()) },

        ExampleEntry(topic: "isSearching", code: """
        @Environment(\\.isSearching) private var isSearching

        if isSearching && query.isEmpty {
            RecentSearches()
        }
        """) { AnyView(EV_IsSearchingExample()) },

        ExampleEntry(topic: "locale", code: """
        @Environment(\\.locale) private var locale

        // Text resolves the format style with the environment locale.
        Text(1_234_567.89, format: .number)

        Row().environment(\\.locale, Locale(identifier: "fr_FR"))
        """) { AnyView(EV_LocaleExample()) },

        ExampleEntry(topic: "modelContext", code: """
        @Environment(\\.modelContext) private var context

        Button("Add Trip") {
            context.insert(Trip(name: "New Trip"))
        }
        """) { AnyView(EV_ModelContextExample()) },

        ExampleEntry(topic: "openURL", code: """
        @Environment(\\.openURL) private var openURL

        Button("Docs") {
            openURL(URL(string: "https://developer.apple.com")!)
        }

        // A custom action injected upstream intercepts the link:
        .environment(\\.openURL, OpenURLAction { url in
            lastOpened = url.absoluteString
            return .handled
        })
        """) { AnyView(EV_OpenURLExample()) },

        ExampleEntry(topic: "openWindow", code: """
        @Environment(\\.openWindow) private var openWindow

        Button("Show Activity") {
            openWindow(id: "activity")
        }
        """) { AnyView(EV_OpenWindowExample()) },

        ExampleEntry(topic: "requestReview", code: """
        import StoreKit

        @Environment(\\.requestReview) private var requestReview

        .onChange(of: completedLevels) {
            if completedLevels == 10 { requestReview() }
        }
        """) { AnyView(EV_RequestReviewExample()) },

        ExampleEntry(topic: "scenePhase", code: """
        @Environment(\\.scenePhase) private var scenePhase

        content.onChange(of: scenePhase) { _, phase in
            if phase == .background { save() }
        }
        """) { AnyView(EV_ScenePhaseExample()) },

        ExampleEntry(topic: "supportsMultipleWindows", code: """
        @Environment(\\.supportsMultipleWindows) private var supportsMultipleWindows

        if supportsMultipleWindows {
            Button("Open in New Window") { openWindow(id: "detail") }
        }
        """) { AnyView(EV_SupportsMultipleWindowsExample()) },

        ExampleEntry(topic: "timeZone", code: """
        @Environment(\\.timeZone) private var timeZone

        // Text renders the date in the environment's time zone.
        Text(date, format: .dateTime.hour().minute().timeZone())

        Clock().environment(\\.timeZone, TimeZone(identifier: "Asia/Tokyo")!)
        """) { AnyView(EV_TimeZoneExample()) },

        ExampleEntry(topic: "undoManager", code: """
        @Environment(\\.undoManager) private var undoManager

        func rename(_ item: Item, to newName: String) {
            let oldName = item.name
            item.name = newName
            undoManager?.registerUndo(withTarget: item) {
                $0.name = oldName
            }
        }
        """) { AnyView(EV_UndoManagerExample()) },
    ]
}

// MARK: - Shared caption helper

/// A small, muted, centered caption used under several examples.
private func EV_caption(_ text: String) -> some View {
    Text(text)
        .font(.caption2)
        .foregroundStyle(.secondary)
        .multilineTextAlignment(.center)
}

// MARK: - accessibilityReduceMotion

private struct EV_ReduceMotionExample: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var isExpanded = false

    var body: some View {
        VStack(spacing: 12) {
            Text("accessibilityReduceMotion: \(reduceMotion ? "on" : "off")")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)

            RoundedRectangle(cornerRadius: 12)
                .fill(.blue.gradient)
                .frame(width: isExpanded ? 220 : 96, height: 54)
                .overlay(
                    Text(isExpanded ? "Expanded" : "Tap toggle")
                        .font(.callout).foregroundStyle(.white)
                )

            Button("Toggle") {
                withAnimation(reduceMotion ? nil : .spring(duration: 0.5)) {
                    isExpanded.toggle()
                }
            }
            .buttonStyle(.bordered)

            EV_caption("When on, the spring is dropped and the change is instant.")
        }
    }
}

// MARK: - calendar

private struct EV_WeekStrip: View {
    @Environment(\.calendar) private var calendar

    var body: some View {
        let symbols = calendar.veryShortWeekdaySymbols          // index 0 == Sunday
        let start = calendar.firstWeekday - 1                   // firstWeekday is 1-based
        let ordered = (0..<7).map { symbols[($0 + start) % symbols.count] }

        HStack(spacing: 5) {
            ForEach(Array(ordered.enumerated()), id: \.offset) { pair in
                Text(pair.element)
                    .font(.caption2)
                    .frame(width: 22, height: 22)
                    .background(.quaternary, in: Circle())
            }
        }
    }
}

private struct EV_CalendarExample: View {
    var body: some View {
        VStack(spacing: 12) {
            VStack(spacing: 4) {
                EV_WeekStrip().environment(\.calendar, Self.gregorian)
                EV_caption("Gregorian — week starts Sunday")
            }
            VStack(spacing: 4) {
                EV_WeekStrip().environment(\.calendar, Self.iso)
                EV_caption("ISO 8601 — week starts Monday")
            }
        }
    }

    private static var gregorian: Calendar {
        var c = Calendar(identifier: .gregorian)
        c.firstWeekday = 1
        return c
    }

    private static var iso: Calendar {
        var c = Calendar(identifier: .iso8601)
        c.firstWeekday = 2
        return c
    }
}

// MARK: - colorScheme

private struct EV_ColorSchemeCard: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: 8) {
            Circle()
                .fill(colorScheme == .dark ? .yellow : .orange)
                .frame(width: 30, height: 30)
                .overlay(
                    Image(systemName: colorScheme == .dark ? "moon.fill" : "sun.max.fill")
                        .font(.caption)
                        .foregroundStyle(colorScheme == .dark ? .black : .white)
                )
            Text("Scheme: \(colorScheme == .dark ? "dark" : "light")")
                .font(.caption.monospaced())
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(colorScheme == .dark ? Color.black : Color.white,
                    in: .rect(cornerRadius: 12))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(.quaternary))
    }
}

private struct EV_ColorSchemeExample: View {
    @State private var dark = false

    var body: some View {
        VStack(spacing: 12) {
            Toggle("Force dark on the card below", isOn: $dark)
                .toggleStyle(.switch)

            EV_ColorSchemeCard()
                .environment(\.colorScheme, dark ? .dark : .light)
        }
    }
}

// MARK: - colorSchemeContrast

private struct EV_ColorSchemeContrastExample: View {
    @Environment(\.colorSchemeContrast) private var contrast

    private var increased: Bool { contrast == .increased }

    var body: some View {
        VStack(spacing: 12) {
            Text("colorSchemeContrast: \(increased ? ".increased" : ".standard")")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)

            Text("Bordered")
                .padding(.horizontal, 22)
                .padding(.vertical, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(increased ? Color.primary : Color.gray,
                                lineWidth: increased ? 2 : 1)
                )

            EV_caption("Reflects the system Increase Contrast setting; custom colors should follow suit.")
        }
    }
}

// MARK: - dismiss

private struct EV_DismissSheet: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "checkmark.seal.fill")
                .font(.largeTitle)
                .foregroundStyle(.green)
            Text("A presented sheet").font(.headline)
            Button("Done") { dismiss() }
                .buttonStyle(.borderedProminent)
        }
        .padding(30)
        .frame(minWidth: 240, minHeight: 160)
    }
}

private struct EV_DismissExample: View {
    @State private var showSheet = false

    var body: some View {
        VStack(spacing: 10) {
            Button("Present Sheet") { showSheet = true }
                .buttonStyle(.bordered)
            EV_caption("The sheet's Done button calls dismiss() to close whatever presented it.")
        }
        .sheet(isPresented: $showSheet) { EV_DismissSheet() }
    }
}

// MARK: - dismissSearch

private struct EV_DismissSearchExample: View {
    @State private var query = "annual report"

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass").foregroundStyle(.secondary)
                Text(query.isEmpty ? "Search" : query)
                    .foregroundStyle(query.isEmpty ? .secondary : .primary)
                Spacer()
                if !query.isEmpty {
                    Button {
                        query = ""            // stands in for dismissSearch()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(8)
            .background(.quaternary, in: .capsule)

            EV_caption("Illustrative — dismissSearch() ends the live .searchable session at runtime.")
        }
        .padding(.horizontal, 8)
    }
}

// MARK: - displayScale

private struct EV_DisplayScaleExample: View {
    @Environment(\.displayScale) private var scale

    var body: some View {
        VStack(spacing: 12) {
            Text("displayScale: \(scale, format: .number.precision(.fractionLength(1)))×")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)

            VStack(spacing: 6) {
                Rectangle().fill(.primary).frame(height: 1)
                Text("1 pt line").font(.caption2).foregroundStyle(.secondary)

                Rectangle().fill(.primary).frame(height: 1 / scale)
                Text("hairline: 1 / scale").font(.caption2).foregroundStyle(.secondary)
            }
            .padding(.horizontal, 24)
        }
    }
}

// MARK: - dynamicTypeSize

private struct EV_DynamicTypeLabels: View {
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        let content = Group {
            Label("Home", systemImage: "house")
            Label("Files", systemImage: "folder")
            Label("Alerts", systemImage: "bell")
        }
        .labelStyle(.titleAndIcon)

        Group {
            if typeSize.isAccessibilitySize {
                VStack(alignment: .leading, spacing: 6) { content }
            } else {
                HStack(spacing: 14) { content }
            }
        }
    }
}

private struct EV_DynamicTypeSizeExample: View {
    @State private var big = false

    var body: some View {
        VStack(spacing: 12) {
            Toggle("Accessibility size", isOn: $big)
                .toggleStyle(.switch)

            EV_DynamicTypeLabels()
                .dynamicTypeSize(big ? .accessibility3 : .large)
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(.quaternary.opacity(0.4), in: .rect(cornerRadius: 8))

            EV_caption("isAccessibilitySize flips the row from horizontal to vertical.")
        }
    }
}

// MARK: - editMode

private struct EV_EditModeExample: View {
    @State private var editing = false
    private let rows = ["Inbox", "Drafts", "Archive"]

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Mailboxes").font(.headline)
                Spacer()
                Button(editing ? "Done" : "Edit") { editing.toggle() }
                    .buttonStyle(.bordered)
                    .controlSize(.small)
            }

            VStack(spacing: 0) {
                ForEach(Array(rows.enumerated()), id: \.offset) { pair in
                    HStack(spacing: 8) {
                        if editing {
                            Image(systemName: "minus.circle.fill").foregroundStyle(.red)
                        }
                        Text(pair.element)
                        Spacer()
                        if editing {
                            Image(systemName: "line.3.horizontal").foregroundStyle(.secondary)
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    if pair.offset < rows.count - 1 { Divider() }
                }
            }
            .background(.quaternary.opacity(0.3), in: .rect(cornerRadius: 8))

            EV_caption("Illustrative — editMode is iOS-only; EditButton toggles it there.")
        }
    }
}

// MARK: - horizontalSizeClass

private struct EV_HorizontalSizeClassExample: View {
    @State private var regular = true

    var body: some View {
        VStack(spacing: 10) {
            Picker("", selection: $regular) {
                Text(".compact").tag(false)
                Text(".regular").tag(true)
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            if regular {
                HStack(spacing: 8) {
                    pane("Sidebar", width: 78)
                    pane("Detail", width: 152)
                }
            } else {
                pane("Navigation stack", width: 238)
            }

            EV_caption("Illustrative — horizontalSizeClass is iOS-only; branch on it to pick a layout.")
        }
    }

    private func pane(_ title: String, width: CGFloat) -> some View {
        Text(title)
            .font(.caption)
            .frame(width: width, height: 66)
            .frame(maxWidth: .infinity)
            .background(.quaternary.opacity(0.4), in: .rect(cornerRadius: 8))
    }
}

// MARK: - isEnabled

private struct EV_FadedStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 18)
            .padding(.vertical, 8)
            .background(.tint, in: .capsule)
            .foregroundStyle(.white)
            .opacity(isEnabled ? (configuration.isPressed ? 0.7 : 1) : 0.4)
    }
}

private struct EV_IsEnabledExample: View {
    @State private var enabled = true

    var body: some View {
        VStack(spacing: 14) {
            Toggle("Enabled", isOn: $enabled)
                .toggleStyle(.switch)

            Button("Purchase") { }
                .buttonStyle(EV_FadedStyle())
                .disabled(!enabled)

            EV_caption("The custom style reads @Environment(\\.isEnabled) to fade itself out.")
        }
        .tint(.blue)
    }
}

// MARK: - isSearching

private struct EV_IsSearchingExample: View {
    @FocusState private var focused: Bool
    @State private var query = ""

    var body: some View {
        let searching = focused

        VStack(spacing: 10) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass").foregroundStyle(.secondary)
                TextField("Search", text: $query)
                    .textFieldStyle(.plain)
                    .focused($focused)
            }
            .padding(8)
            .background(.quaternary, in: .capsule)

            if searching && query.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Recent").font(.caption).foregroundStyle(.secondary)
                    Label("Quarterly figures", systemImage: "clock").font(.caption)
                    Label("Design review", systemImage: "clock").font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            EV_caption("Illustrative — isSearching mirrors the live .searchable session; focus stands in here.")
        }
    }
}

// MARK: - locale

private struct EV_LocaleRow: View {
    @Environment(\.locale) private var locale
    private let sample = Date(timeIntervalSince1970: 1_710_000_000)

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(locale.identifier)
                .font(.caption2.monospaced())
                .foregroundStyle(.secondary)
            Text(1_234_567.89, format: .number)
            Text(sample, format: .dateTime.day().month().year())
        }
        .font(.callout)
    }
}

private struct EV_LocaleExample: View {
    var body: some View {
        HStack(alignment: .top, spacing: 28) {
            EV_LocaleRow().environment(\.locale, Locale(identifier: "en_US"))
            EV_LocaleRow().environment(\.locale, Locale(identifier: "fr_FR"))
        }
    }
}

// MARK: - modelContext

private struct EV_Trip: Identifiable {
    let id = UUID()
    var name: String
}

private struct EV_ModelContextExample: View {
    @State private var trips = [EV_Trip(name: "Kyoto"), EV_Trip(name: "Oslo")]

    var body: some View {
        VStack(spacing: 8) {
            ForEach(trips) { trip in
                HStack(spacing: 8) {
                    Image(systemName: "suitcase.fill").foregroundStyle(.tint)
                    Text(trip.name)
                    Spacer()
                }
                .font(.callout)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(.quaternary.opacity(0.3), in: .rect(cornerRadius: 6))
            }

            Button("Add Trip") {
                trips.append(EV_Trip(name: "Trip \(trips.count + 1)"))
            }
            .buttonStyle(.bordered)

            EV_caption("Illustrative — at runtime context.insert(Trip(...)) persists via SwiftData and @Query updates.")
        }
        .tint(.blue)
    }
}

// MARK: - openURL

private struct EV_OpenURLButton: View {
    @Environment(\.openURL) private var openURL

    var body: some View {
        Button {
            openURL(URL(string: "https://developer.apple.com")!)
        } label: {
            Label("Open Docs", systemImage: "safari")
        }
        .buttonStyle(.bordered)
    }
}

private struct EV_OpenURLExample: View {
    @State private var lastOpened = "none"

    var body: some View {
        VStack(spacing: 12) {
            EV_OpenURLButton()
                .environment(\.openURL, OpenURLAction { url in
                    lastOpened = url.absoluteString
                    return .handled
                })

            Text("Routed to: \(lastOpened)")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)

            EV_caption("A custom OpenURLAction injected upstream intercepts the link instead of launching a browser.")
        }
    }
}

// MARK: - openWindow

private struct EV_OpenWindowExample: View {
    @State private var opened = false

    var body: some View {
        VStack(spacing: 12) {
            Button("Show Activity") {
                withAnimation { opened.toggle() }
            }
            .buttonStyle(.bordered)

            VStack(spacing: 0) {
                HStack(spacing: 6) {
                    Circle().fill(.red).frame(width: 8, height: 8)
                    Circle().fill(.yellow).frame(width: 8, height: 8)
                    Circle().fill(.green).frame(width: 8, height: 8)
                    Spacer()
                    Text("Activity").font(.caption2)
                    Spacer()
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(.quaternary)
                Divider()
                Text(opened ? "Window content" : "closed")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 42)
            }
            .frame(width: 176)
            .clipShape(.rect(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(.quaternary))
            .opacity(opened ? 1 : 0.45)

            EV_caption("Illustrative — openWindow(id:) opens a WindowGroup / Window scene at runtime.")
        }
    }
}

// MARK: - requestReview

private struct EV_RequestReviewExample: View {
    @State private var show = false

    var body: some View {
        VStack(spacing: 12) {
            Button("Reach a satisfying moment") {
                withAnimation { show = true }
            }
            .buttonStyle(.bordered)

            if show {
                VStack(spacing: 8) {
                    Text("Enjoying the app?").font(.headline)
                    HStack(spacing: 4) {
                        ForEach(0..<5) { _ in
                            Image(systemName: "star.fill").foregroundStyle(.yellow)
                        }
                    }
                    Text("Not Now").font(.caption).foregroundStyle(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.quaternary.opacity(0.3), in: .rect(cornerRadius: 12))
                .transition(.scale.combined(with: .opacity))
            }

            EV_caption("Illustrative — StoreKit decides whether the real prompt appears, and caps how often.")
        }
    }
}

// MARK: - scenePhase

private struct EV_ScenePhaseExample: View {
    @Environment(\.scenePhase) private var scenePhase
    @State private var lastBackgrounded = "—"

    private var phaseText: String {
        switch scenePhase {
        case .active: "active"
        case .inactive: "inactive"
        case .background: "background"
        @unknown default: "unknown"
        }
    }

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 8) {
                Circle()
                    .fill(scenePhase == .active ? .green : .orange)
                    .frame(width: 10, height: 10)
                Text("scenePhase: \(phaseText)")
                    .font(.caption.monospaced())
            }

            Text("Saved when last backgrounded: \(lastBackgrounded)")
                .font(.caption2)
                .foregroundStyle(.secondary)

            EV_caption("onChange(of: scenePhase) is where apps save state as they move to the background.")
        }
        .onChange(of: scenePhase) { _, phase in
            if phase == .background { lastBackgrounded = "yes" }
        }
    }
}

// MARK: - supportsMultipleWindows

private struct EV_SupportsMultipleWindowsExample: View {
    @Environment(\.supportsMultipleWindows) private var supportsMultipleWindows

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: supportsMultipleWindows ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundStyle(supportsMultipleWindows ? .green : .red)
                Text("supportsMultipleWindows: \(supportsMultipleWindows ? "true" : "false")")
                    .font(.caption.monospaced())
            }

            if supportsMultipleWindows {
                Button("Open in New Window") { }
                    .buttonStyle(.bordered)
            }

            EV_caption("True on macOS, so the button shows; on iPhone it is false and the button is hidden.")
        }
    }
}

// MARK: - timeZone

private struct EV_ClockLabel: View {
    @Environment(\.timeZone) private var timeZone
    let title: String
    let date: Date

    var body: some View {
        VStack(spacing: 3) {
            Text(title).font(.caption2).foregroundStyle(.secondary)
            Text(date, format: .dateTime.hour().minute().timeZone())
                .font(.title3.monospacedDigit())
        }
    }
}

private struct EV_TimeZoneExample: View {
    private let now = Date(timeIntervalSince1970: 1_710_000_000)

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 28) {
                EV_ClockLabel(title: "Cupertino", date: now)
                    .environment(\.timeZone, TimeZone(identifier: "America/Los_Angeles")!)
                EV_ClockLabel(title: "Tokyo", date: now)
                    .environment(\.timeZone, TimeZone(identifier: "Asia/Tokyo")!)
            }
            EV_caption("The same Date renders at each region's local time.")
        }
    }
}

// MARK: - undoManager

@Observable private final class EV_Counter {
    var value = 1

    /// Sets the value and registers the inverse so undo — and redo — both work.
    func set(_ new: Int, undo: UndoManager?) {
        let old = value
        guard old != new else { return }
        value = new
        undo?.registerUndo(withTarget: self) { target in
            target.set(old, undo: undo)
        }
    }
}

private struct EV_UndoManagerExample: View {
    @State private var counter = EV_Counter()
    @State private var undo = UndoManager()

    var body: some View {
        VStack(spacing: 12) {
            Text("v\(counter.value)")
                .font(.title2.monospacedDigit())
                .frame(width: 60)

            HStack(spacing: 10) {
                Button("Bump") { counter.set(counter.value + 1, undo: undo) }
                    .buttonStyle(.borderedProminent)
                Button("Undo") { undo.undo() }
                    .disabled(!undo.canUndo)
                Button("Redo") { undo.redo() }
                    .disabled(!undo.canRedo)
            }
            .buttonStyle(.bordered)

            EV_caption("Document scenes supply the environment's undoManager; a local one drives the buttons here.")
        }
    }
}
