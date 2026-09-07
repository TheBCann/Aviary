//
//  ChildExamples+Part08.swift
//  Aviary
//
//  Compiled renderings for variant entries (part 08: gen-lists).
//  One private C08_* struct per variant; every rendering exercises the exact
//  overload the variant names, so siblings can be compared side by side.
//

import SwiftUI

enum ChildExamplesPart08 {
    static let entries: [ChildExampleEntry] = [

        // MARK: .defaultScrollAnchor()

        ChildExampleEntry(parent: ".defaultScrollAnchor()", child: ".defaultScrollAnchor(_:)", code: """
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(messages) { MessageBubble($0) }
            }
        }
        .defaultScrollAnchor(.bottom)   // first display rests on the newest message
        """) { AnyView(C08_DefaultScrollAnchorExample()) },

        ChildExampleEntry(parent: ".defaultScrollAnchor()", child: ".defaultScrollAnchor(_:for:)", code: """
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(lines, id: \\.self) { Text($0) }
            }
        }
        .defaultScrollAnchor(.bottom, for: .sizeChanges)   // stay pinned as lines are appended
        .defaultScrollAnchor(.top, for: .alignment)        // …but short content still sits at the top

        Button("Append line") { lines.append("Log line \\(lines.count + 1)") }
        """) { AnyView(C08_DefaultScrollAnchorRoleExample()) },

        // MARK: .listItemTint()

        ChildExampleEntry(parent: ".listItemTint()", child: ".listItemTint(Color?)", code: """
        List {
            Label("Wi-Fi", systemImage: "wifi")
                .listItemTint(.blue)
            Label("Focus", systemImage: "moon.fill")
                .listItemTint(Color.purple)
            Label("Default", systemImage: "gearshape")   // inherits the list's tint
        }
        .listStyle(.sidebar)
        """) { AnyView(C08_ListItemTintColorExample()) },

        ChildExampleEntry(parent: ".listItemTint()", child: ".listItemTint(ListItemTint?)", code: """
        List {
            Label("Health", systemImage: "heart.fill")
                .listItemTint(.preferred(.pink))    // a list style may override it
            Label("Archive", systemImage: "archivebox")
                .listItemTint(.monochrome)          // no color at all
            Label("Battery", systemImage: "battery.100percent")
                .listItemTint(.fixed(.green))       // always exactly this color
        }
        .listStyle(.sidebar)
        """) { AnyView(C08_ListItemTintStyleExample()) },

        // MARK: .listSectionSpacing()

        ChildExampleEntry(parent: ".listSectionSpacing()", child: ".listSectionSpacing(ListSectionSpacing)", code: """
        List {
            Section("Now") { ForEach(current) { TaskRow($0) } }
            Section("Later") { ForEach(upcoming) { TaskRow($0) } }
        }
        .listSectionSpacing(.compact)   // semantic preset — iOS and watchOS only
        """) { AnyView(C08_ListSectionSpacingPresetExample()) },

        ChildExampleEntry(parent: ".listSectionSpacing()", child: ".listSectionSpacing(CGFloat)", code: """
        List {
            Section("Account") { AccountRows() }
            Section("Privacy") { PrivacyRows() }
        }
        .listSectionSpacing(spacing)   // exact points, e.g. 8 — iOS and watchOS only
        """) { AnyView(C08_ListSectionSpacingPointsExample()) },

        // MARK: .onScrollPhaseChange()

        ChildExampleEntry(parent: ".onScrollPhaseChange()", child: ".onScrollPhaseChange((ScrollPhase, ScrollPhase) -> Void)", code: """
        ScrollView { feed }
            .onScrollPhaseChange { oldPhase, newPhase in
                transition = "\\(name(oldPhase)) → \\(name(newPhase))"
                if oldPhase.isScrolling && newPhase == .idle { settledCount += 1 }
            }
        """) { AnyView(C08_ScrollPhaseChangeExample()) },

        ChildExampleEntry(parent: ".onScrollPhaseChange()", child: ".onScrollPhaseChange((ScrollPhase, ScrollPhase, ScrollPhaseChangeContext) -> Void)", code: """
        ScrollView { feed }
            .onScrollPhaseChange { _, newPhase, context in
                offset = context.geometry.contentOffset.y
                velocity = context.velocity?.dy ?? 0
                if newPhase == .idle { restingOffset = offset }
            }
        """) { AnyView(C08_ScrollPhaseChangeContextExample()) },

        // MARK: .scrollIndicatorsFlash()

        ChildExampleEntry(parent: ".scrollIndicatorsFlash()", child: ".scrollIndicatorsFlash(onAppear:)", code: """
        ScrollView {
            Text(termsOfService)
        }
        .scrollIndicatorsFlash(onAppear: true)   // one flash when the view first appears
        """) { AnyView(C08_ScrollIndicatorsFlashOnAppearExample()) },

        ChildExampleEntry(parent: ".scrollIndicatorsFlash()", child: ".scrollIndicatorsFlash(trigger:)", code: """
        Picker("Filter", selection: $activeFilter) { … }

        ScrollView {
            LazyVStack { ForEach(filtered, id: \\.self) { Text($0) } }
        }
        .scrollIndicatorsFlash(trigger: activeFilter)   // flashes each time the filter changes
        """) { AnyView(C08_ScrollIndicatorsFlashTriggerExample()) },

        // MARK: .scrollTransition()

        ChildExampleEntry(parent: ".scrollTransition()", child: ".scrollTransition(_:axis:transition:)", code: """
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(films) { film in
                    PosterCard(film)
                        .scrollTransition(.animated(.bouncy), axis: .horizontal) { content, phase in
                            content.scaleEffect(phase.isIdentity ? 1 : 0.85)
                        }
                }
            }
        }
        """) { AnyView(C08_ScrollTransitionAxisExample()) },

        ChildExampleEntry(parent: ".scrollTransition()", child: ".scrollTransition(topLeading:bottomTrailing:axis:transition:)", code: """
        ForEach(stories) { story in
            HeadlineRow(story)
                .scrollTransition(topLeading: .identity, bottomTrailing: .interactive) { content, phase in
                    content.opacity(phase.isIdentity ? 1 : 0.3)   // only the bottom edge fades
                }
        }
        """) { AnyView(C08_ScrollTransitionEdgesExample()) },
    ]
}

// MARK: - Shared support

private enum C08_Support {
    static let palette: [Color] = [.blue, .purple, .pink, .orange, .teal, .green]

    static func phaseName(_ phase: ScrollPhase) -> String {
        switch phase {
        case .idle: return "idle"
        case .tracking: return "tracking"
        case .interacting: return "interacting"
        case .decelerating: return "decelerating"
        case .animating: return "animating"
        @unknown default: return "unknown"
        }
    }
}

private struct C08_Caption: View {
    let text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        Text(text)
            .font(.caption2)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
    }
}

/// A stack of simple feed rows to give scroll views something to scroll.
private struct C08_Feed: View {
    var count = 25
    var body: some View {
        LazyVStack(spacing: 6) {
            ForEach(1...count, id: \.self) { i in
                Text("Post \(i)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.gray.opacity(0.12), in: RoundedRectangle(cornerRadius: 6))
            }
        }
        .padding(8)
    }
}

/// Illustrative stand-in for an iOS sectioned list, used where the real
/// section-spacing modifiers are unavailable on macOS.
private struct C08_MockSections: View {
    var spacing: CGFloat
    var body: some View {
        VStack(spacing: spacing) {
            section("Now", rows: ["Write outline", "Review pull request"])
            section("Later", rows: ["Ship build", "Plan sprint"])
        }
        .padding(10)
        .background(Color.gray.opacity(0.12), in: RoundedRectangle(cornerRadius: 10))
    }

    private func section(_ title: String, rows: [String]) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title.uppercased())
                .font(.caption2)
                .foregroundStyle(.secondary)
                .padding(.leading, 8)
            VStack(spacing: 0) {
                ForEach(Array(rows.enumerated()), id: \.offset) { index, row in
                    Text(row)
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                    if index < rows.count - 1 { Divider().padding(.leading, 10) }
                }
            }
            .background(.background, in: RoundedRectangle(cornerRadius: 8))
        }
    }
}

// MARK: - .defaultScrollAnchor()

private struct C08_DefaultScrollAnchorExample: View {
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 6) {
                ForEach(1...30, id: \.self) { i in
                    Text(i == 30 ? "Newest message" : "Message \(i)")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(i == 30 ? Color.blue.opacity(0.25) : Color.gray.opacity(0.15), in: Capsule())
                }
            }
            .padding(8)
        }
        .defaultScrollAnchor(.bottom)
        .frame(height: 150)
    }
}

private struct C08_DefaultScrollAnchorRoleExample: View {
    @State private var lines = (1...3).map { "Log line \($0)" }

    var body: some View {
        VStack(spacing: 8) {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 4) {
                    ForEach(lines, id: \.self) { Text($0).font(.caption.monospaced()) }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
            }
            .defaultScrollAnchor(.bottom, for: .sizeChanges)
            .defaultScrollAnchor(.top, for: .alignment)
            .frame(height: 110)
            .background(Color.gray.opacity(0.12), in: RoundedRectangle(cornerRadius: 8))
            Button("Append line") { lines.append("Log line \(lines.count + 1)") }
        }
    }
}

// MARK: - .listItemTint()

private struct C08_ListItemTintColorExample: View {
    var body: some View {
        List {
            Label("Wi-Fi", systemImage: "wifi")
                .listItemTint(.blue)
            Label("Focus", systemImage: "moon.fill")
                .listItemTint(Color.purple)
            Label("Default", systemImage: "gearshape")
        }
        .listStyle(.sidebar)
        .frame(height: 120)
    }
}

private struct C08_ListItemTintStyleExample: View {
    var body: some View {
        List {
            Label("Health", systemImage: "heart.fill")
                .listItemTint(.preferred(.pink))
            Label("Archive", systemImage: "archivebox")
                .listItemTint(.monochrome)
            Label("Battery", systemImage: "battery.100percent")
                .listItemTint(.fixed(.green))
        }
        .listStyle(.sidebar)
        .frame(height: 120)
    }
}

// MARK: - .listSectionSpacing()

private struct C08_ListSectionSpacingPresetExample: View {
    var body: some View {
        VStack(spacing: 8) {
            C08_MockSections(spacing: 8)
            C08_Caption("Illustrative — .listSectionSpacing(.compact) is iOS and watchOS only")
        }
    }
}

private struct C08_ListSectionSpacingPointsExample: View {
    @State private var spacing: CGFloat = 8

    var body: some View {
        VStack(spacing: 8) {
            C08_MockSections(spacing: spacing)
            Slider(value: $spacing, in: 0...40) { Text("Spacing") }
                .labelsHidden()
            C08_Caption(String(format: "Illustrative — .listSectionSpacing(%.0f); iOS and watchOS only", spacing))
        }
    }
}

// MARK: - .onScrollPhaseChange()

private struct C08_ScrollPhaseChangeExample: View {
    @State private var transition = "— → idle"
    @State private var settledCount = 0

    var body: some View {
        VStack(spacing: 6) {
            ScrollView { C08_Feed() }
                .onScrollPhaseChange { oldPhase, newPhase in
                    transition = "\(C08_Support.phaseName(oldPhase)) → \(C08_Support.phaseName(newPhase))"
                    if oldPhase.isScrolling && newPhase == .idle { settledCount += 1 }
                }
                .frame(height: 120)
            HStack {
                Text(transition)
                Spacer()
                Text("settled \(settledCount)×")
            }
            .font(.caption.monospaced())
        }
    }
}

private struct C08_ScrollPhaseChangeContextExample: View {
    @State private var offset: CGFloat = 0
    @State private var velocity: CGFloat = 0
    @State private var restingOffset: CGFloat = 0

    var body: some View {
        VStack(spacing: 6) {
            ScrollView { C08_Feed() }
                .onScrollPhaseChange { _, newPhase, context in
                    offset = context.geometry.contentOffset.y
                    velocity = context.velocity?.dy ?? 0
                    if newPhase == .idle { restingOffset = offset }
                }
                .frame(height: 120)
            Text(String(format: "offset %.0f pt   velocity %.0f pt/s   resting %.0f pt", offset, velocity, restingOffset))
                .font(.caption.monospaced())
        }
    }
}

// MARK: - .scrollIndicatorsFlash()

private struct C08_ScrollIndicatorsFlashOnAppearExample: View {
    var body: some View {
        ScrollView {
            Text(String(repeating: "By continuing you agree to the terms of service and the privacy policy. ", count: 14))
                .font(.caption)
                .padding(10)
        }
        .scrollIndicatorsFlash(onAppear: true)
        .frame(height: 120)
        .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
    }
}

private struct C08_ScrollIndicatorsFlashTriggerExample: View {
    @State private var activeFilter = "All"
    private let filters = ["All", "Open", "Done"]

    private var filtered: [String] {
        switch activeFilter {
        case "Open": return (1...12).map { "Open task \($0)" }
        case "Done": return (1...20).map { "Done task \($0)" }
        default: return (1...30).map { "Task \($0)" }
        }
    }

    var body: some View {
        VStack(spacing: 8) {
            Picker("Filter", selection: $activeFilter) {
                ForEach(filters, id: \.self) { Text($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 4) {
                    ForEach(filtered, id: \.self) { Text($0).font(.callout) }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
            }
            .scrollIndicatorsFlash(trigger: activeFilter)
            .frame(height: 110)
            .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
        }
    }
}

// MARK: - .scrollTransition()

private struct C08_ScrollTransitionAxisExample: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 12) {
                ForEach(0..<8, id: \.self) { i in
                    RoundedRectangle(cornerRadius: 12)
                        .fill(C08_Support.palette[i % C08_Support.palette.count].gradient)
                        .frame(width: 90, height: 120)
                        .overlay(Text("Film \(i + 1)").font(.caption.bold()).foregroundStyle(.white))
                        .scrollTransition(.animated(.bouncy), axis: .horizontal) { content, phase in
                            content.scaleEffect(phase.isIdentity ? 1 : 0.85)
                        }
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 140)
    }
}

private struct C08_ScrollTransitionEdgesExample: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(1...20, id: \.self) { i in
                    Text("Headline \(i)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                        .background(Color.gray.opacity(0.12), in: RoundedRectangle(cornerRadius: 8))
                        .scrollTransition(topLeading: .identity, bottomTrailing: .interactive) { content, phase in
                            content.opacity(phase.isIdentity ? 1 : 0.3)
                        }
                }
            }
            .padding(8)
        }
        .frame(height: 150)
    }
}
