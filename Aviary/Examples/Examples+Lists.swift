//
//  Examples+Lists.swift
//  Aviary
//
//  Rendered usage examples for the entries in CatalogData/gen-lists.json.
//  Entries that already have an interactive demo (demoID) are not here.
//

import SwiftUI
import UniformTypeIdentifiers

enum ExamplesLists {
    static let entries: [ExampleEntry] = [
        ExampleEntry(topic: ".alternatingRowBackgrounds()", code: """
        Table(invoices) {
            TableColumn("Number", value: \\.number)
            TableColumn("Amount") {
                Text($0.amount, format: .currency(code: "USD"))
            }
        }
        .alternatingRowBackgrounds(.enabled)
        """) { AnyView(Li_AlternatingRowsExample()) },

        ExampleEntry(topic: ".badgeProminence()", code: """
        List {
            Label("Inbox", systemImage: "tray").badge(12)
            Label("Flagged", systemImage: "flag").badge(3)
        }
        .badgeProminence(prominence)   // .decreased / .standard / .increased
        """) { AnyView(Li_BadgeProminenceModifierExample()) },

        ExampleEntry(topic: ".defaultScrollAnchor()", code: """
        ScrollView {
            LazyVStack {
                ForEach(messages, id: \\.self) { MessageRow($0) }
            }
        }
        .defaultScrollAnchor(.bottom)   // opens resting at the newest message
        """) { AnyView(Li_DefaultScrollAnchorExample()) },

        ExampleEntry(topic: ".deleteDisabled()", code: """
        List {
            ForEach(accounts) { account in
                AccountRow(account)
                    .deleteDisabled(account.isDefault)
            }
            .onDelete { accounts.remove(atOffsets: $0) }
        }
        """) { AnyView(Li_DeleteDisabledExample()) },

        ExampleEntry(topic: ".headerProminence()", code: """
        List {
            Section("Today") {
                ForEach(tasks) { TaskRow($0) }
            }
            .headerProminence(.increased)
        }
        """) { AnyView(Li_HeaderProminenceExample()) },

        ExampleEntry(topic: ".listItemTint()", code: """
        List {
            Label("Wi-Fi", systemImage: "wifi").listItemTint(.blue)
            Label("Focus", systemImage: "moon.fill").listItemTint(.purple)
            Label("Archive", systemImage: "archivebox").listItemTint(.monochrome)
        }
        .listStyle(.sidebar)
        """) { AnyView(Li_ListItemTintExample()) },

        ExampleEntry(topic: ".listRowBackground()", code: """
        List(alerts) { alert in
            AlertRow(alert)
                .listRowBackground(
                    alert.isCritical ? Color.red.opacity(0.15) : Color.clear
                )
        }
        """) { AnyView(Li_ListRowBackgroundExample()) },

        ExampleEntry(topic: ".listRowInsets()", code: """
        List {
            Text("Default insets")
            Color.teal
                .frame(height: 28)
                .listRowInsets(EdgeInsets())   // edge-to-edge
        }
        """) { AnyView(Li_ListRowInsetsExample()) },

        ExampleEntry(topic: ".listRowSeparatorTint()", code: """
        List(steps) { step in
            StepRow(step)
                .listRowSeparatorTint(step.color)
        }
        """) { AnyView(Li_ListRowSeparatorTintExample()) },

        ExampleEntry(topic: ".listRowSpacing()", code: """
        List {
            ForEach(cards) { CardRow($0) }
        }
        .listRowSpacing(12)
        .listStyle(.insetGrouped)
        """) { AnyView(Li_ListRowSpacingExample()) },

        ExampleEntry(topic: ".listSectionSeparator()", code: """
        List {
            Section("Pinned") {
                ForEach(pinned) { NoteRow($0) }
            }
            .listSectionSeparator(.hidden, edges: .top)
        }
        """) { AnyView(Li_ListSectionSeparatorExample()) },

        ExampleEntry(topic: ".listSectionSeparatorTint()", code: """
        List {
            Section("Priority") {
                ForEach(urgent) { TicketRow($0) }
            }
            .listSectionSeparatorTint(.orange)
        }
        """) { AnyView(Li_ListSectionSeparatorTintExample()) },

        ExampleEntry(topic: ".listSectionSpacing()", code: """
        List {
            Section("Now")   { ForEach(current)  { TaskRow($0) } }
            Section("Later") { ForEach(upcoming) { TaskRow($0) } }
        }
        .listSectionSpacing(.compact)
        """) { AnyView(Li_ListSectionSpacingExample()) },

        ExampleEntry(topic: ".moveDisabled()", code: """
        List {
            ForEach(playlist) { track in
                TrackRow(track)
                    .moveDisabled(track.isLocked)
            }
            .onMove { playlist.move(fromOffsets: $0, toOffset: $1) }
        }
        """) { AnyView(Li_MoveDisabledExample()) },

        ExampleEntry(topic: ".onDelete()", code: """
        List {
            ForEach(contacts) { ContactRow($0) }
                .onDelete { offsets in
                    contacts.remove(atOffsets: offsets)
                }
        }
        """) { AnyView(Li_OnDeleteExample()) },

        ExampleEntry(topic: ".onInsert()", code: """
        List {
            ForEach(links, id: \\.self) { Text($0) }
                .onInsert(of: [.url]) { index, providers in
                    // load each provider and insert at `index`
                }
        }
        """) { AnyView(Li_OnInsertExample()) },

        ExampleEntry(topic: ".onMove()", code: """
        List {
            ForEach(chapters) { ChapterRow($0) }
                .onMove { source, destination in
                    chapters.move(fromOffsets: source, toOffset: destination)
                }
        }
        """) { AnyView(Li_OnMoveExample()) },

        ExampleEntry(topic: ".onScrollPhaseChange()", code: """
        ScrollView { Feed() }
            .onScrollPhaseChange { _, newPhase in
                phase = newPhase
            }

        Text("Phase: \\(phase)")
        """) { AnyView(Li_OnScrollPhaseChangeExample()) },

        ExampleEntry(topic: ".onScrollTargetVisibilityChange()", code: """
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(0..<12, id: \\.self) { StoryCard($0) }
            }
            .scrollTargetLayout()
        }
        .onScrollTargetVisibilityChange(idType: Int.self) { ids in
            visibleIDs = ids
        }
        """) { AnyView(Li_OnScrollTargetVisibilityChangeExample()) },

        ExampleEntry(topic: ".onScrollVisibilityChange()", code: """
        VideoCard(clip)
            .onScrollVisibilityChange(threshold: 0.6) { isVisible in
                self.isVisible = isVisible   // play / pause
            }
        """) { AnyView(Li_OnScrollVisibilityChangeExample()) },

        ExampleEntry(topic: ".scrollBounceBehavior()", code: """
        ScrollView {
            ShortSummaryView()
        }
        .scrollBounceBehavior(.basedOnSize)   // no jiggle when content fits
        """) { AnyView(Li_ScrollBounceBehaviorExample()) },

        ExampleEntry(topic: ".scrollClipDisabled()", code: """
        ScrollView(.horizontal) {
            LazyHStack(spacing: 16) {
                ForEach(covers) { CoverCard($0).shadow(radius: 8) }
            }
            .padding(.vertical, 20)
        }
        .scrollClipDisabled()
        """) { AnyView(Li_ScrollClipDisabledExample()) },

        ExampleEntry(topic: ".scrollContentBackground()", code: """
        List(recipes) { RecipeRow($0).listRowBackground(Color.clear) }
            .scrollContentBackground(.hidden)
            .background(
                LinearGradient(colors: [.indigo, .black],
                               startPoint: .top, endPoint: .bottom)
            )
        """) { AnyView(Li_ScrollContentBackgroundExample()) },

        ExampleEntry(topic: ".scrollDisabled()", code: """
        ScrollView {
            OnboardingPages()
        }
        .scrollDisabled(isLocked)
        """) { AnyView(Li_ScrollDisabledExample()) },

        ExampleEntry(topic: ".scrollIndicators()", code: """
        ScrollView {
            LongContent()
        }
        .scrollIndicators(visibility)   // .automatic / .visible / .hidden / .never
        """) { AnyView(Li_ScrollIndicatorsExample()) },

        ExampleEntry(topic: ".scrollIndicatorsFlash()", code: """
        ScrollView {
            LazyVStack { ForEach(results) { ResultRow($0) } }
        }
        .scrollIndicatorsFlash(trigger: results.count)
        """) { AnyView(Li_ScrollIndicatorsFlashExample()) },

        ExampleEntry(topic: ".scrollTargetLayout()", code: """
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(pages) { PageView($0) }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        """) { AnyView(Li_ScrollTargetLayoutExample()) },

        ExampleEntry(topic: ".scrollTransition()", code: """
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(albums) { album in
                    AlbumCard(album)
                        .scrollTransition { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1 : 0.4)
                                .scaleEffect(phase.isIdentity ? 1 : 0.85)
                        }
                }
            }
        }
        """) { AnyView(Li_ScrollTransitionExample()) },

        ExampleEntry(topic: ".selectionDisabled()", code: """
        List(selection: $selection) {
            ForEach(rows) { row in
                RowView(row)
                    .selectionDisabled(row.isPlaceholder)
            }
        }
        """) { AnyView(Li_SelectionDisabledExample()) },

        ExampleEntry(topic: ".tableColumnHeaders()", code: """
        Table(files) {
            TableColumn("Name", value: \\.name)
            TableColumn("Size") {
                Text($0.size, format: .byteCount(style: .file))
            }
        }
        .tableColumnHeaders(headers)   // .automatic / .hidden
        """) { AnyView(Li_TableColumnHeadersExample()) },

        ExampleEntry(topic: "BadgeProminence", code: """
        List {
            Label("Folders", systemImage: "folder").badge(8)
                .badgeProminence(.decreased)
            Label("Updates", systemImage: "arrow.down.circle").badge(2)
                .badgeProminence(.standard)
            Label("Inbox", systemImage: "tray").badge(12)
                .badgeProminence(.increased)
        }
        """) { AnyView(Li_BadgeProminenceTypeExample()) },

        ExampleEntry(topic: "defaultMinListHeaderHeight", code: """
        List {
            Section("Devices") { ForEach(devices) { DeviceRow($0) } }
            Section("Groups")  { ForEach(groups)  { GroupRow($0) } }
        }
        .environment(\\.defaultMinListHeaderHeight, 44)
        """) { AnyView(Li_DefaultMinListHeaderHeightExample()) },

        ExampleEntry(topic: "defaultMinListRowHeight", code: """
        List {
            ForEach(shortcuts) { ShortcutRow($0) }
        }
        .environment(\\.defaultMinListRowHeight, 24)   // dense rows
        """) { AnyView(Li_DefaultMinListRowHeightExample()) },

        ExampleEntry(topic: "DisclosureTableRow", code: """
        Table(of: Department.self) {
            TableColumn("Name", value: \\.name)
            TableColumn("Team") { Text($0.team) }
        } rows: {
            ForEach(departments) { dept in
                DisclosureTableRow(dept) {
                    ForEach(dept.subdepartments) { TableRow($0) }
                }
            }
        }
        """) { AnyView(Li_DisclosureTableRowExample()) },

        ExampleEntry(topic: "DynamicViewContent", code: """
        List {
            ForEach(items) { Text($0.name) }
                .onDelete { items.remove(atOffsets: $0) }
                .onMove   { items.move(fromOffsets: $0, toOffset: $1) }
        }
        """) { AnyView(Li_DynamicViewContentExample()) },

        ExampleEntry(topic: "EditActions", code: """
        struct Step: Identifiable { let id = UUID(); var text: String }
        @State private var steps = [Step(text: "Prep"), Step(text: "Cook")]

        List($steps, editActions: .all) { $step in
            TextField("Step", text: $step.text)
        }
        """) { AnyView(Li_EditActionsExample()) },

        ExampleEntry(topic: "ListItemTint", code: """
        List {
            Label("Battery", systemImage: "battery.100percent")
                .listItemTint(.fixed(.green))
            Label("Cellular", systemImage: "antenna.radiowaves.left.and.right")
                .listItemTint(.preferred(.teal))
            Label("Archive", systemImage: "archivebox")
                .listItemTint(.monochrome)
        }
        .listStyle(.sidebar)
        """) { AnyView(Li_ListItemTintTypeExample()) },

        ExampleEntry(topic: "ListSectionSpacing", code: """
        List {
            Section("Now")   { ForEach(current)  { TaskRow($0) } }
            Section("Later") { ForEach(upcoming) { TaskRow($0) } }
        }
        .listSectionSpacing(.compact)   // .default / .compact / .custom(_:)
        """) { AnyView(Li_ListSectionSpacingTypeExample()) },

        ExampleEntry(topic: "Prominence", code: """
        List {
            Section("Account") {
                LabeledContent("Plan", value: "Pro")
            }
            .headerProminence(Prominence.increased)
        }
        """) { AnyView(Li_ProminenceExample()) },

        ExampleEntry(topic: "refresh", code: """
        struct ReloadButton: View {
            @Environment(\\.refresh) private var refresh

            var body: some View {
                Button("Reload") { Task { await refresh?() } }
                    .disabled(refresh == nil)
            }
        }
        // ...installed by an ancestor's .refreshable { ... }
        """) { AnyView(Li_RefreshExample()) },

        ExampleEntry(topic: "ScrollAnchorRole", code: """
        ScrollView {
            LazyVStack {
                ForEach(lines, id: \\.self) { LogLine($0) }
            }
        }
        .defaultScrollAnchor(.bottom, for: .sizeChanges)   // stays pinned as lines append
        """) { AnyView(Li_ScrollAnchorRoleExample()) },

        ExampleEntry(topic: "ScrollBounceBehavior", code: """
        ScrollView(.horizontal) {
            ChipRow(tags)
        }
        .scrollBounceBehavior(behavior, axes: .horizontal)
        // .automatic / .always / .basedOnSize
        """) { AnyView(Li_ScrollBounceBehaviorTypeExample()) },

        ExampleEntry(topic: "ScrollDismissesKeyboardMode", code: """
        Form {
            TextField("Title", text: $title)
            TextEditor(text: $body)
        }
        .scrollDismissesKeyboard(.immediately)
        // .automatic / .immediately / .interactively / .never
        """) { AnyView(Li_ScrollDismissesKeyboardModeExample()) },

        ExampleEntry(topic: "ScrollEdgeEffectStyle", code: """
        ScrollView {
            TransactionsTable()
        }
        .scrollEdgeEffectStyle(.hard, for: .top)   // .automatic / .soft / .hard
        """) { AnyView(Li_ScrollEdgeEffectStyleExample()) },

        ExampleEntry(topic: "ScrollIndicatorVisibility", code: """
        ScrollView {
            LongFormArticle()
        }
        .scrollIndicators(visibility)
        // .automatic / .visible / .hidden / .never
        """) { AnyView(Li_ScrollIndicatorVisibilityExample()) },

        ExampleEntry(topic: "ScrollPhase", code: """
        ScrollView { feed }
            .onScrollPhaseChange { _, newPhase in
                phase = newPhase   // .idle / .tracking / .interacting
            }                      // .decelerating / .animating
        """) { AnyView(Li_ScrollPhaseTypeExample()) },

        ExampleEntry(topic: "ScrollPosition", code: """
        @State private var position = ScrollPosition(edge: .top)

        ScrollView {
            LazyVStack { ForEach(rows, id: \\.self) { RowView($0) } }
        }
        .scrollPosition($position)

        Button("Latest") { position.scrollTo(edge: .bottom) }
        """) { AnyView(Li_ScrollPositionExample()) },

        ExampleEntry(topic: "ScrollTransitionPhase", code: """
        MilestoneCard(milestone)
            .scrollTransition(.interactive) { content, phase in
                content
                    .rotationEffect(.degrees(phase.value * 4))
                    .opacity(phase.isIdentity ? 1 : 0.4)
            }
        """) { AnyView(Li_ScrollTransitionPhaseExample()) },

        ExampleEntry(topic: "ScrollViewProxy", code: """
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack {
                    ForEach(0..<40, id: \\.self) { i in
                        Text("Row \\(i)").id(i)
                    }
                }
            }
            Button("Jump to 39") {
                withAnimation { proxy.scrollTo(39, anchor: .bottom) }
            }
        }
        """) { AnyView(Li_ScrollViewProxyExample()) },

        ExampleEntry(topic: "TableColumn", code: """
        @State private var sortOrder = [KeyPathComparator(\\Person.name)]

        Table(people.sorted(using: sortOrder), sortOrder: $sortOrder) {
            TableColumn("Name", value: \\.name)
            TableColumn("Role") { RoleBadge($0.role) }
        }
        """) { AnyView(Li_TableColumnExample()) },

        ExampleEntry(topic: "TableColumnAlignment", code: """
        Table(transactions) {
            TableColumn("Payee", value: \\.payee)
            TableColumn("Amount") {
                Text($0.amount, format: .currency(code: "USD"))
            }
            .alignment(.numeric)
        }
        """) { AnyView(Li_TableColumnAlignmentExample()) },

        ExampleEntry(topic: "TableColumnContent", code: """
        @TableColumnBuilder<Person, Never>
        var nameColumns: some TableColumnContent<Person, Never> {
            TableColumn("First") { Text($0.firstName) }
            TableColumn("Last")  { Text($0.lastName) }
        }

        Table(people) { nameColumns }
        """) { AnyView(Li_TableColumnContentExample()) },

        ExampleEntry(topic: "TableColumnCustomization", code: """
        @State private var customization = TableColumnCustomization<Employee>()

        Table(employees, columnCustomization: $customization) {
            TableColumn("Name", value: \\.name).customizationID("name")
            TableColumn("Role", value: \\.role).customizationID("role")
        }

        // toggle a column: customization[visibility: "role"] = .hidden
        """) { AnyView(Li_TableColumnCustomizationExample()) },

        ExampleEntry(topic: "TableRow", code: """
        Table(of: Track.self) {
            TableColumn("Title", value: \\.title)
            TableColumn("Length") { Text($0.lengthLabel) }
        } rows: {
            TableRow(bonusTrack)
            ForEach(tracks) { TableRow($0) }
        }
        """) { AnyView(Li_TableRowExample()) },

        ExampleEntry(topic: "TableRowContent", code: """
        Table(of: FileItem.self) {
            TableColumn("Name", value: \\.name)
        } rows: {
            ForEach(files) { file in
                TableRow(file)
                    .contextMenu { Button("Reveal") { reveal(file) } }
            }
        }
        """) { AnyView(Li_TableRowContentExample()) },

        ExampleEntry(topic: "TableStyle", code: """
        Table(devices) {
            TableColumn("Device", value: \\.name)
            TableColumn("Status") { Text($0.status) }
        }
        .tableStyle(style)   // .automatic / .inset / .bordered
        """) { AnyView(Li_TableStyleExample()) },

        ExampleEntry(topic: "Visibility", code: """
        List {
            ForEach(tracks) { track in
                TrackRow(track)
                    .listRowSeparator(separator)   // .automatic / .visible / .hidden
            }
        }
        """) { AnyView(Li_VisibilityExample()) },
    ]
}

// MARK: - Shared models

private struct Li_Invoice: Identifiable {
    let id: Int
    let number: String
    let amount: Double
}

private struct Li_Person: Identifiable {
    let id: Int
    let name: String
    let firstName: String
    let lastName: String
    let role: String
}

private struct Li_FileItem: Identifiable {
    let id: Int
    let name: String
    let size: Int64
}

private struct Li_Account: Identifiable {
    let id: Int
    let name: String
    let isDefault: Bool
}

private struct Li_Department: Identifiable {
    let id: Int
    let name: String
    let team: String
    let subdepartments: [Li_Department]
}

private struct Li_Card: View {
    let index: Int
    var color: Color = .blue
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(color.gradient)
            .frame(width: 84, height: 84)
            .overlay(Text("\(index)").font(.title3.bold()).foregroundStyle(.white))
    }
}

private func Li_caption(_ text: String) -> some View {
    Text(text)
        .font(.caption)
        .foregroundStyle(.secondary)
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
}

// ScrollIndicatorVisibility / ScrollBounceBehavior are not Hashable, so drive
// the demo pickers with small Identifiable choice enums and map to the value.

private enum Li_IndicatorChoice: String, CaseIterable, Identifiable {
    case visible, hidden, never
    var id: Self { self }
    var visibility: ScrollIndicatorVisibility {
        switch self {
        case .visible: .visible
        case .hidden: .hidden
        case .never: .never
        }
    }
}

private enum Li_BounceChoice: String, CaseIterable, Identifiable {
    case automatic, always, basedOnSize
    var id: Self { self }
    var behavior: ScrollBounceBehavior {
        switch self {
        case .automatic: .automatic
        case .always: .always
        case .basedOnSize: .basedOnSize
        }
    }
}

// MARK: - .alternatingRowBackgrounds()

private struct Li_AlternatingRowsExample: View {
    private let invoices = [
        Li_Invoice(id: 1, number: "INV-1001", amount: 240),
        Li_Invoice(id: 2, number: "INV-1002", amount: 89.5),
        Li_Invoice(id: 3, number: "INV-1003", amount: 1_320),
        Li_Invoice(id: 4, number: "INV-1004", amount: 47),
        Li_Invoice(id: 5, number: "INV-1005", amount: 610),
    ]

    var body: some View {
        Table(invoices) {
            TableColumn("Number", value: \.number)
            TableColumn("Amount") {
                Text($0.amount, format: .currency(code: "USD"))
            }
        }
        .alternatingRowBackgrounds(.enabled)
        .frame(height: 180)
    }
}

// MARK: - .badgeProminence()

private struct Li_BadgeProminenceModifierExample: View {
    @State private var prominence: BadgeProminence = .increased

    var body: some View {
        VStack(spacing: 8) {
            Picker("Prominence", selection: $prominence) {
                Text("decreased").tag(BadgeProminence.decreased)
                Text("standard").tag(BadgeProminence.standard)
                Text("increased").tag(BadgeProminence.increased)
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            List {
                Label("Inbox", systemImage: "tray").badge(12)
                Label("Flagged", systemImage: "flag").badge(3)
            }
            .badgeProminence(prominence)
            .listStyle(.sidebar)
            .frame(height: 110)
        }
    }
}

// MARK: - .defaultScrollAnchor()

private struct Li_DefaultScrollAnchorExample: View {
    var body: some View {
        VStack(spacing: 6) {
            ScrollView {
                LazyVStack(spacing: 5) {
                    ForEach(1...30, id: \.self) { i in
                        HStack {
                            Text("Message \(i)")
                            Spacer()
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 5)
                        .background(.blue.opacity(0.12), in: .rect(cornerRadius: 6))
                    }
                }
                .padding(.horizontal, 4)
            }
            .defaultScrollAnchor(.bottom)
            .frame(height: 150)

            Li_caption("Opens resting at message 30 — no scroll-on-appear needed.")
        }
    }
}

// MARK: - .deleteDisabled()

private struct Li_DeleteDisabledExample: View {
    @State private var accounts = [
        Li_Account(id: 1, name: "Personal", isDefault: true),
        Li_Account(id: 2, name: "Work", isDefault: false),
        Li_Account(id: 3, name: "Side project", isDefault: false),
    ]

    var body: some View {
        VStack(spacing: 6) {
            List {
                ForEach(accounts) { account in
                    HStack {
                        Text(account.name)
                        Spacer()
                        if account.isDefault {
                            Image(systemName: "lock.fill")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .deleteDisabled(account.isDefault)
                }
                .onDelete { accounts.remove(atOffsets: $0) }
            }
            .frame(height: 120)

            Li_caption("The default account is marked .deleteDisabled(true).")
        }
    }
}

// MARK: - .headerProminence()

private struct Li_HeaderProminenceExample: View {
    private let tasks = ["Draft the brief", "Review PRs", "Ship release"]

    var body: some View {
        List {
            Section("Today") {
                ForEach(tasks, id: \.self) { Text($0) }
            }
            .headerProminence(.increased)

            Section("Someday") {
                Text("Rewrite the docs")
            }
        }
        .frame(height: 190)
    }
}

// MARK: - .listItemTint()

private struct Li_ListItemTintExample: View {
    var body: some View {
        List {
            Label("Wi-Fi", systemImage: "wifi").listItemTint(.blue)
            Label("Focus", systemImage: "moon.fill").listItemTint(.purple)
            Label("Archive", systemImage: "archivebox").listItemTint(.monochrome)
        }
        .listStyle(.sidebar)
        .frame(height: 150)
    }
}

// MARK: - .listRowBackground()

private struct Li_ListRowBackgroundExample: View {
    private struct Alert: Identifiable {
        let id: Int
        let text: String
        let isCritical: Bool
    }
    private let alerts = [
        Alert(id: 1, text: "Disk almost full", isCritical: true),
        Alert(id: 2, text: "Backup finished", isCritical: false),
        Alert(id: 3, text: "Certificate expiring", isCritical: true),
        Alert(id: 4, text: "New login", isCritical: false),
    ]

    var body: some View {
        List(alerts) { alert in
            Label(alert.text, systemImage: alert.isCritical ? "exclamationmark.triangle.fill" : "checkmark.circle")
                .listRowBackground(
                    alert.isCritical ? Color.red.opacity(0.15) : Color.clear
                )
        }
        .frame(height: 190)
    }
}

// MARK: - .listRowInsets()

private struct Li_ListRowInsetsExample: View {
    var body: some View {
        List {
            Text("Default insets")
            LinearGradient(colors: [.teal, .blue], startPoint: .leading, endPoint: .trailing)
                .frame(height: 30)
                .overlay(Text("Zero insets — edge to edge").font(.caption).foregroundStyle(.white))
                .listRowInsets(EdgeInsets())
            Text("Default insets")
        }
        .frame(height: 160)
    }
}

// MARK: - .listRowSeparatorTint()

private struct Li_ListRowSeparatorTintExample: View {
    private struct Step: Identifiable {
        let id: Int
        let name: String
        let color: Color
    }
    private let steps = [
        Step(id: 1, name: "Mix", color: .mint),
        Step(id: 2, name: "Proof", color: .orange),
        Step(id: 3, name: "Bake", color: .red),
        Step(id: 4, name: "Cool", color: .blue),
    ]

    var body: some View {
        List(steps) { step in
            Text(step.name)
                .listRowSeparatorTint(step.color)
        }
        .frame(height: 180)
    }
}

// MARK: - .listRowSpacing()  (iOS only — illustrated on macOS)

private struct Li_ListRowSpacingExample: View {
    var body: some View {
        VStack(spacing: 6) {
            VStack(spacing: 12) {   // stands in for .listRowSpacing(12)
                ForEach(0..<3, id: \.self) { i in
                    HStack {
                        Label("Card \(i + 1)", systemImage: "rectangle.stack")
                        Spacer()
                    }
                    .padding(10)
                    .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
                }
            }
            Li_caption("Illustrative — .listRowSpacing() is iOS only; here rows sit 12 pt apart.")
        }
    }
}

// MARK: - .listSectionSeparator()

private struct Li_ListSectionSeparatorExample: View {
    var body: some View {
        List {
            Section("Pinned") {
                Text("Groceries")
                Text("Reading list")
            }
            .listSectionSeparator(.hidden, edges: .top)

            Section("Other") {
                Text("Archive")
            }
        }
        .frame(height: 190)
    }
}

// MARK: - .listSectionSeparatorTint()

private struct Li_ListSectionSeparatorTintExample: View {
    var body: some View {
        List {
            Section("Priority") {
                Text("Fix the crash")
                Text("Answer support")
            }
            .listSectionSeparatorTint(.orange)

            Section("Backlog") {
                Text("Polish icons")
            }
        }
        .frame(height: 190)
    }
}

// MARK: - .listSectionSpacing()  (iOS / watchOS — illustrated on macOS)

private struct Li_ListSectionSpacingExample: View {
    private func section(_ title: String, _ rows: [String]) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title).font(.caption.smallCaps()).foregroundStyle(.secondary)
            ForEach(rows, id: \.self) { row in
                Text(row)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(8)
                    .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 8))
            }
        }
    }

    var body: some View {
        VStack(spacing: 6) {
            VStack(spacing: 6) {   // .compact gap between sections
                section("Now", ["Standup", "Deploy"])
                section("Later", ["Retro"])
            }
            Li_caption("Illustrative — .listSectionSpacing(.compact) is iOS / watchOS only.")
        }
    }
}

// MARK: - .moveDisabled()

private struct Li_MoveDisabledExample: View {
    private struct Track: Identifiable {
        let id: Int
        let name: String
        let isLocked: Bool
    }
    @State private var playlist = [
        Track(id: 1, name: "Intro (pinned)", isLocked: true),
        Track(id: 2, name: "Verse", isLocked: false),
        Track(id: 3, name: "Chorus", isLocked: false),
        Track(id: 4, name: "Bridge", isLocked: false),
    ]

    var body: some View {
        VStack(spacing: 6) {
            List {
                ForEach(playlist) { track in
                    HStack {
                        Text(track.name)
                        Spacer()
                        if track.isLocked {
                            Image(systemName: "pin.fill").foregroundStyle(.secondary)
                        }
                    }
                    .moveDisabled(track.isLocked)
                }
                .onMove { playlist.move(fromOffsets: $0, toOffset: $1) }
            }
            .frame(height: 140)

            Li_caption("The pinned intro is .moveDisabled(true) and won't reorder.")
        }
    }
}

// MARK: - .onDelete()

private struct Li_OnDeleteExample: View {
    @State private var contacts = ["Ada", "Bram", "Chika", "Devi", "Enzo"]

    var body: some View {
        VStack(spacing: 6) {
            List {
                ForEach(contacts, id: \.self) { Text($0) }
                    .onDelete { offsets in
                        contacts.remove(atOffsets: offsets)
                    }
            }
            .frame(height: 150)

            Li_caption("onDelete enables swipe-to-delete (iOS) and the Delete affordance.")
        }
    }
}

// MARK: - .onInsert()

private struct Li_OnInsertExample: View {
    @State private var links = ["apple.com", "swift.org"]

    var body: some View {
        VStack(spacing: 6) {
            List {
                ForEach(links, id: \.self) { link in
                    Label(link, systemImage: "link")
                }
                .onInsert(of: [.url]) { index, providers in
                    _ = (index, providers)   // load providers and insert at index
                }
            }
            .frame(height: 130)

            Li_caption("Rows accept dropped URLs between them, inserting at the target index.")
        }
    }
}

// MARK: - .onMove()

private struct Li_OnMoveExample: View {
    @State private var chapters = ["Prologue", "Rising action", "Climax", "Resolution"]

    var body: some View {
        VStack(spacing: 6) {
            List {
                ForEach(chapters, id: \.self) { Text($0) }
                    .onMove { source, destination in
                        chapters.move(fromOffsets: source, toOffset: destination)
                    }
            }
            .frame(height: 150)

            Li_caption("Drag rows to reorder; the handler reports source and destination.")
        }
    }
}

// MARK: - .onScrollPhaseChange()

private func Li_phaseName(_ phase: ScrollPhase) -> String {
    switch phase {
    case .idle: "idle"
    case .tracking: "tracking"
    case .interacting: "interacting"
    case .decelerating: "decelerating"
    case .animating: "animating"
    @unknown default: "—"
    }
}

private struct Li_OnScrollPhaseChangeExample: View {
    @State private var phase: ScrollPhase = .idle

    var body: some View {
        VStack(spacing: 6) {
            ScrollView {
                LazyVStack(spacing: 5) {
                    ForEach(0..<24, id: \.self) { i in
                        Text("Row \(i)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 8).padding(.vertical, 5)
                            .background(.blue.opacity(0.1), in: .rect(cornerRadius: 6))
                    }
                }
                .padding(.horizontal, 4)
            }
            .frame(height: 120)
            .onScrollPhaseChange { _, newPhase in phase = newPhase }

            Text("Phase: \(Li_phaseName(phase))")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - .onScrollTargetVisibilityChange()

private struct Li_OnScrollTargetVisibilityChangeExample: View {
    @State private var visibleIDs: [Int] = []

    var body: some View {
        VStack(spacing: 6) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 12) {
                    ForEach(0..<12, id: \.self) { i in
                        Li_Card(index: i, color: .indigo)
                    }
                }
                .scrollTargetLayout()
                .padding(.horizontal, 4)
            }
            .frame(height: 100)
            .onScrollTargetVisibilityChange(idType: Int.self) { ids in
                visibleIDs = ids
            }

            Text("Visible: \(visibleIDs.sorted().map(String.init).joined(separator: ", "))")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
    }
}

// MARK: - .onScrollVisibilityChange()

private struct Li_OnScrollVisibilityChangeExample: View {
    @State private var isVisible = false

    var body: some View {
        VStack(spacing: 6) {
            ScrollView {
                VStack(spacing: 8) {
                    Color.clear.frame(height: 120)
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isVisible ? Color.green.gradient : Color.gray.gradient)
                        .frame(height: 60)
                        .overlay(Text(isVisible ? "On screen" : "Scrolled away").foregroundStyle(.white))
                        .onScrollVisibilityChange(threshold: 0.6) { isVisible = $0 }
                    Color.clear.frame(height: 120)
                }
            }
            .frame(height: 120)

            Text("Card visible: \(isVisible ? "yes" : "no")")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - .scrollBounceBehavior()

private struct Li_ScrollBounceBehaviorExample: View {
    var body: some View {
        VStack(spacing: 6) {
            ScrollView {
                Text("This content is short and already fits.\nWith .basedOnSize it will not rubber-band.")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            }
            .scrollBounceBehavior(.basedOnSize)
            .frame(height: 110)

            Li_caption(".basedOnSize removes the pointless bounce when content fits.")
        }
    }
}

// MARK: - .scrollClipDisabled()

private struct Li_ScrollClipDisabledExample: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 18) {
                ForEach(0..<8, id: \.self) { i in
                    Li_Card(index: i, color: .pink)
                        .shadow(color: .black.opacity(0.35), radius: 8, y: 4)
                }
            }
            .padding(.vertical, 22)
            .padding(.horizontal, 12)
        }
        .scrollClipDisabled()
        .frame(height: 150)
    }
}

// MARK: - .scrollContentBackground()

private struct Li_ScrollContentBackgroundExample: View {
    private let recipes = ["Focaccia", "Ramen", "Tiramisu", "Paella"]

    var body: some View {
        List(recipes, id: \.self) { recipe in
            Label(recipe, systemImage: "fork.knife")
                .foregroundStyle(.white)
                .listRowBackground(Color.clear)
        }
        .scrollContentBackground(.hidden)
        .background(
            LinearGradient(colors: [.indigo, .black], startPoint: .top, endPoint: .bottom)
        )
        .frame(height: 190)
        .clipShape(.rect(cornerRadius: 10))
    }
}

// MARK: - .scrollDisabled()

private struct Li_ScrollDisabledExample: View {
    @State private var locked = true

    var body: some View {
        VStack(spacing: 6) {
            Toggle("Lock scrolling", isOn: $locked)
                .toggleStyle(.switch)

            ScrollView {
                LazyVStack(spacing: 5) {
                    ForEach(0..<30, id: \.self) { i in
                        Text("Line \(i)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 8).padding(.vertical, 4)
                            .background(.blue.opacity(0.1), in: .rect(cornerRadius: 6))
                    }
                }
                .padding(.horizontal, 4)
            }
            .scrollDisabled(locked)
            .frame(height: 120)
        }
    }
}

// MARK: - .scrollIndicators()

private struct Li_ScrollIndicatorsExample: View {
    @State private var choice: Li_IndicatorChoice = .visible

    var body: some View {
        VStack(spacing: 6) {
            Picker("Indicators", selection: $choice) {
                ForEach(Li_IndicatorChoice.allCases) { Text($0.rawValue).tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            ScrollView {
                LazyVStack(spacing: 5) {
                    ForEach(0..<30, id: \.self) { i in
                        Text("Row \(i)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 8).padding(.vertical, 4)
                            .background(.teal.opacity(0.12), in: .rect(cornerRadius: 6))
                    }
                }
                .padding(.horizontal, 4)
            }
            .scrollIndicators(choice.visibility)
            .frame(height: 120)
        }
    }
}

// MARK: - .scrollIndicatorsFlash()

private struct Li_ScrollIndicatorsFlashExample: View {
    @State private var count = 8

    var body: some View {
        VStack(spacing: 6) {
            Button("Add rows") { count += 4 }
                .buttonStyle(.bordered)

            ScrollView {
                LazyVStack(spacing: 5) {
                    ForEach(0..<count, id: \.self) { i in
                        Text("Result \(i)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 8).padding(.vertical, 4)
                            .background(.orange.opacity(0.12), in: .rect(cornerRadius: 6))
                    }
                }
                .padding(.horizontal, 4)
            }
            .scrollIndicatorsFlash(trigger: count)
            .frame(height: 110)

            Li_caption("Indicators flash each time the row count changes.")
        }
    }
}

// MARK: - .scrollTargetLayout()

private struct Li_ScrollTargetLayoutExample: View {
    var body: some View {
        VStack(spacing: 6) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 12) {
                    ForEach(0..<8, id: \.self) { i in
                        Li_Card(index: i, color: .blue)
                    }
                }
                .scrollTargetLayout()
                .padding(.horizontal, 4)
            }
            .scrollTargetBehavior(.viewAligned)
            .frame(height: 100)

            Li_caption("scrollTargetLayout marks the cards as snap targets for .viewAligned.")
        }
    }
}

// MARK: - .scrollTransition()

private struct Li_ScrollTransitionExample: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 14) {
                ForEach(0..<10, id: \.self) { i in
                    Li_Card(index: i, color: .purple)
                        .scrollTransition { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1 : 0.4)
                                .scaleEffect(phase.isIdentity ? 1 : 0.85)
                        }
                }
            }
            .padding(.horizontal, 12)
        }
        .frame(height: 120)
    }
}

// MARK: - .selectionDisabled()

private struct Li_SelectionDisabledExample: View {
    private struct Row: Identifiable {
        let id: Int
        let name: String
        let isPlaceholder: Bool
    }
    private let rows = [
        Row(id: 1, name: "Loading…", isPlaceholder: true),
        Row(id: 2, name: "Aurora", isPlaceholder: false),
        Row(id: 3, name: "Basalt", isPlaceholder: false),
        Row(id: 4, name: "Cinder", isPlaceholder: false),
    ]
    @State private var selection: Int?

    var body: some View {
        VStack(spacing: 6) {
            List(selection: $selection) {
                ForEach(rows) { row in
                    Text(row.name)
                        .foregroundStyle(row.isPlaceholder ? .secondary : .primary)
                        .selectionDisabled(row.isPlaceholder)
                }
            }
            .frame(height: 140)

            Text("Selected id: \(selection.map(String.init) ?? "none")")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - .tableColumnHeaders()

private struct Li_TableColumnHeadersExample: View {
    @State private var headers: Visibility = .hidden
    private let files = [
        Li_FileItem(id: 1, name: "Notes.md", size: 4_096),
        Li_FileItem(id: 2, name: "Sketch.png", size: 1_260_000),
        Li_FileItem(id: 3, name: "Budget.numbers", size: 225_000),
    ]

    var body: some View {
        VStack(spacing: 6) {
            Picker("Headers", selection: $headers) {
                Text("automatic").tag(Visibility.automatic)
                Text("hidden").tag(Visibility.hidden)
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            Table(files) {
                TableColumn("Name", value: \.name)
                TableColumn("Size") {
                    Text($0.size, format: .byteCount(style: .file))
                }
            }
            .tableColumnHeaders(headers)
            .frame(height: 140)
        }
    }
}

// MARK: - BadgeProminence

private struct Li_BadgeProminenceTypeExample: View {
    var body: some View {
        List {
            Label("Folders", systemImage: "folder").badge(8)
                .badgeProminence(.decreased)
            Label("Updates", systemImage: "arrow.down.circle").badge(2)
                .badgeProminence(.standard)
            Label("Inbox", systemImage: "tray").badge(12)
                .badgeProminence(.increased)
        }
        .listStyle(.sidebar)
        .frame(height: 150)
    }
}

// MARK: - defaultMinListHeaderHeight

private struct Li_DefaultMinListHeaderHeightExample: View {
    var body: some View {
        VStack(spacing: 6) {
            List {
                Section("Devices") {
                    Text("MacBook Pro")
                    Text("Studio Display")
                }
                Section("Groups") {
                    Text("Home")
                }
            }
            .environment(\.defaultMinListHeaderHeight, 44)
            .frame(height: 170)

            Li_caption("Section headers reserve at least 44 pt of height.")
        }
    }
}

// MARK: - defaultMinListRowHeight

private struct Li_DefaultMinListRowHeightExample: View {
    private let shortcuts = ["⌘N New", "⌘O Open", "⌘S Save", "⌘W Close", "⌘Q Quit"]

    var body: some View {
        VStack(spacing: 6) {
            List {
                ForEach(shortcuts, id: \.self) { Text($0).font(.caption) }
            }
            .environment(\.defaultMinListRowHeight, 22)
            .frame(height: 150)

            Li_caption("Row floor lowered to 22 pt for a dense utility list.")
        }
    }
}

// MARK: - DisclosureTableRow

private struct Li_DisclosureTableRowExample: View {
    private let departments = [
        Li_Department(id: 1, name: "Engineering", team: "48", subdepartments: [
            Li_Department(id: 2, name: "iOS", team: "12", subdepartments: []),
            Li_Department(id: 3, name: "Backend", team: "20", subdepartments: []),
        ]),
        Li_Department(id: 4, name: "Design", team: "9", subdepartments: [
            Li_Department(id: 5, name: "Product", team: "6", subdepartments: []),
        ]),
    ]

    var body: some View {
        Table(of: Li_Department.self) {
            TableColumn("Name", value: \.name)
            TableColumn("Team") { Text($0.team) }
        } rows: {
            ForEach(departments) { dept in
                DisclosureTableRow(dept) {
                    ForEach(dept.subdepartments) { TableRow($0) }
                }
            }
        }
        .frame(height: 200)
    }
}

// MARK: - DynamicViewContent

private struct Li_DynamicViewContentExample: View {
    @State private var items = ["Alpha", "Bravo", "Charlie", "Delta"]

    var body: some View {
        VStack(spacing: 6) {
            List {
                ForEach(items, id: \.self) { Text($0) }
                    .onDelete { items.remove(atOffsets: $0) }
                    .onMove { items.move(fromOffsets: $0, toOffset: $1) }
            }
            .frame(height: 140)

            Li_caption("ForEach conforms to DynamicViewContent — home of onDelete / onMove.")
        }
    }
}

// MARK: - EditActions

private struct Li_Step: Identifiable {
    let id = UUID()
    var text: String
}

private struct Li_EditActionsExample: View {
    @State private var steps = [
        Li_Step(text: "Prep"),
        Li_Step(text: "Cook"),
        Li_Step(text: "Plate"),
    ]

    var body: some View {
        VStack(spacing: 6) {
            List($steps, editActions: .all) { $step in
                TextField("Step", text: $step.text)
            }
            .frame(height: 140)

            Li_caption("A binding-based list synthesizes move + delete from .all — no closures.")
        }
    }
}

// MARK: - ListItemTint

private struct Li_ListItemTintTypeExample: View {
    var body: some View {
        List {
            Label("Battery", systemImage: "battery.100percent")
                .listItemTint(.fixed(.green))
            Label("Cellular", systemImage: "antenna.radiowaves.left.and.right")
                .listItemTint(.preferred(.teal))
            Label("Archive", systemImage: "archivebox")
                .listItemTint(.monochrome)
        }
        .listStyle(.sidebar)
        .frame(height: 150)
    }
}

// MARK: - ListSectionSpacing  (iOS / watchOS — illustrated on macOS)

private struct Li_ListSectionSpacingTypeExample: View {
    private func section(_ title: String, _ rows: [String]) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title).font(.caption.smallCaps()).foregroundStyle(.secondary)
            ForEach(rows, id: \.self) { row in
                Text(row)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(8)
                    .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 8))
            }
        }
    }

    var body: some View {
        VStack(spacing: 6) {
            VStack(spacing: 6) {   // .compact preset
                section("General", ["Appearance", "Language"])
                section("Advanced", ["Reset"])
            }
            Li_caption("Illustrative — .default / .compact / .custom(_:) are iOS / watchOS only.")
        }
    }
}

// MARK: - Prominence

private struct Li_ProminenceExample: View {
    var body: some View {
        List {
            Section("Account") {
                LabeledContent("Plan", value: "Pro")
            }
            .headerProminence(Prominence.increased)

            Section("Billing") {
                LabeledContent("Next charge", value: "Oct 1")
            }
            .headerProminence(Prominence.standard)
        }
        .frame(height: 190)
    }
}

// MARK: - refresh

private struct Li_ReloadButton: View {
    @Environment(\.refresh) private var refresh

    var body: some View {
        Button("Reload") { Task { await refresh?() } }
            .buttonStyle(.borderedProminent)
            .disabled(refresh == nil)
    }
}

private struct Li_RefreshExample: View {
    @State private var reloads = 0

    var body: some View {
        VStack(spacing: 10) {
            Text("Reloads: \(reloads)")
                .font(.title3.monospacedDigit())
            Li_ReloadButton()
            Li_caption("ReloadButton reads @Environment(\\.refresh), installed by .refreshable.")
        }
        .padding()
        .refreshable {
            try? await Task.sleep(for: .milliseconds(400))
            reloads += 1
        }
    }
}

// MARK: - ScrollAnchorRole

private struct Li_ScrollAnchorRoleExample: View {
    @State private var lines = Array(1...8)

    var body: some View {
        VStack(spacing: 6) {
            Button("Append line") { lines.append((lines.last ?? 0) + 1) }
                .buttonStyle(.bordered)

            ScrollView {
                LazyVStack(spacing: 4) {
                    ForEach(lines, id: \.self) { n in
                        Text("Line \(n)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 8).padding(.vertical, 4)
                            .background(.green.opacity(0.12), in: .rect(cornerRadius: 6))
                    }
                }
                .padding(.horizontal, 4)
            }
            .defaultScrollAnchor(.bottom, for: .sizeChanges)
            .frame(height: 110)

            Li_caption("New lines stay pinned to the bottom as content grows.")
        }
    }
}

// MARK: - ScrollBounceBehavior

private struct Li_ScrollBounceBehaviorTypeExample: View {
    @State private var choice: Li_BounceChoice = .basedOnSize

    var body: some View {
        VStack(spacing: 6) {
            Picker("Behavior", selection: $choice) {
                ForEach(Li_BounceChoice.allCases) { Text($0.rawValue).tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            ScrollView {
                Text("Short content.\nTry dragging past the edge under each behavior.")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            }
            .scrollBounceBehavior(choice.behavior)
            .frame(height: 100)
        }
    }
}

// MARK: - ScrollDismissesKeyboardMode  (iOS / watchOS — illustrated on macOS)

private struct Li_ScrollDismissesKeyboardModeExample: View {
    @State private var title = "Draft"
    @State private var note = "Type here, then scroll…"

    var body: some View {
        VStack(spacing: 6) {
            Form {
                TextField("Title", text: $title)
                TextField("Note", text: $note)
            }
            .frame(height: 110)
            .clipShape(.rect(cornerRadius: 8))

            Li_caption("Illustrative — .scrollDismissesKeyboard governs the software keyboard on iOS / watchOS.")
        }
    }
}

// MARK: - ScrollEdgeEffectStyle

private struct Li_ScrollEdgeEffectStyleExample: View {
    var body: some View {
        VStack(spacing: 6) {
            ScrollView {
                LazyVStack(spacing: 5) {
                    ForEach(0..<24, id: \.self) { i in
                        Text("Transaction \(i)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 10).padding(.vertical, 5)
                            .background(.blue.opacity(0.1), in: .rect(cornerRadius: 6))
                    }
                }
                .padding(8)
            }
            .scrollEdgeEffectStyle(.hard, for: .top)
            .frame(height: 150)

            Li_caption(".hard draws a crisp boundary under a bar; .soft blends with a blur.")
        }
    }
}

// MARK: - ScrollIndicatorVisibility

private struct Li_ScrollIndicatorVisibilityExample: View {
    @State private var choice: Li_IndicatorChoice = .visible

    var body: some View {
        VStack(spacing: 6) {
            Picker("Visibility", selection: $choice) {
                ForEach(Li_IndicatorChoice.allCases) { Text($0.rawValue).tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            ScrollView {
                LazyVStack(spacing: 5) {
                    ForEach(0..<30, id: \.self) { i in
                        Text("Line \(i)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 8).padding(.vertical, 4)
                            .background(.purple.opacity(0.12), in: .rect(cornerRadius: 6))
                    }
                }
                .padding(.horizontal, 4)
            }
            .scrollIndicators(choice.visibility)
            .frame(height: 110)
        }
    }
}

// MARK: - ScrollPhase

private struct Li_ScrollPhaseTypeExample: View {
    @State private var phase: ScrollPhase = .idle

    var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 6) {
                ForEach(["idle", "tracking", "interacting", "decelerating"], id: \.self) { name in
                    Text(name)
                        .font(.caption2)
                        .padding(.horizontal, 6).padding(.vertical, 3)
                        .background(
                            Li_phaseName(phase) == name ? Color.accentColor : Color.gray.opacity(0.2),
                            in: .capsule
                        )
                        .foregroundStyle(Li_phaseName(phase) == name ? .white : .secondary)
                }
            }

            ScrollView {
                LazyVStack(spacing: 5) {
                    ForEach(0..<24, id: \.self) { i in
                        Text("Item \(i)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 8).padding(.vertical, 4)
                            .background(.teal.opacity(0.12), in: .rect(cornerRadius: 6))
                    }
                }
                .padding(.horizontal, 4)
            }
            .frame(height: 110)
            .onScrollPhaseChange { _, newPhase in phase = newPhase }
        }
    }
}

// MARK: - ScrollPosition

private struct Li_ScrollPositionExample: View {
    @State private var position = ScrollPosition(edge: .top)

    var body: some View {
        VStack(spacing: 6) {
            HStack {
                Button("Top") { withAnimation { position.scrollTo(edge: .top) } }
                Button("Bottom") { withAnimation { position.scrollTo(edge: .bottom) } }
            }
            .buttonStyle(.bordered)
            .controlSize(.small)

            ScrollView {
                LazyVStack(spacing: 4) {
                    ForEach(0..<40, id: \.self) { i in
                        Text("Row \(i)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 8).padding(.vertical, 4)
                            .background(.indigo.opacity(0.12), in: .rect(cornerRadius: 6))
                    }
                }
                .padding(.horizontal, 4)
            }
            .scrollPosition($position)
            .frame(height: 120)
        }
    }
}

// MARK: - ScrollTransitionPhase

private struct Li_ScrollTransitionPhaseExample: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 14) {
                ForEach(0..<10, id: \.self) { i in
                    Li_Card(index: i, color: .orange)
                        .scrollTransition(.interactive) { content, phase in
                            content
                                .rotationEffect(.degrees(phase.value * 6))
                                .opacity(phase.isIdentity ? 1 : 0.4)
                        }
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 120)
    }
}

// MARK: - ScrollViewProxy

private struct Li_ScrollViewProxyExample: View {
    var body: some View {
        ScrollViewReader { proxy in
            VStack(spacing: 6) {
                HStack {
                    Button("Top") { withAnimation { proxy.scrollTo(0, anchor: .top) } }
                    Button("End") { withAnimation { proxy.scrollTo(39, anchor: .bottom) } }
                }
                .buttonStyle(.bordered)
                .controlSize(.small)

                ScrollView {
                    LazyVStack(spacing: 4) {
                        ForEach(0..<40, id: \.self) { i in
                            Text("Row \(i)").id(i)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 8).padding(.vertical, 4)
                                .background(.blue.opacity(0.1), in: .rect(cornerRadius: 6))
                        }
                    }
                    .padding(.horizontal, 4)
                }
                .frame(height: 120)
            }
        }
    }
}

// MARK: - TableColumn

private struct Li_TableColumnExample: View {
    private let people = [
        Li_Person(id: 1, name: "Ada Lovelace", firstName: "Ada", lastName: "Lovelace", role: "Lead"),
        Li_Person(id: 2, name: "Grace Hopper", firstName: "Grace", lastName: "Hopper", role: "Admiral"),
        Li_Person(id: 3, name: "Alan Turing", firstName: "Alan", lastName: "Turing", role: "Founder"),
        Li_Person(id: 4, name: "Katherine Johnson", firstName: "Katherine", lastName: "Johnson", role: "Analyst"),
    ]
    @State private var sortOrder = [KeyPathComparator(\Li_Person.name)]

    var body: some View {
        Table(people.sorted(using: sortOrder), sortOrder: $sortOrder) {
            TableColumn("Name", value: \.name)
            TableColumn("Role") { person in
                Text(person.role)
                    .font(.caption)
                    .padding(.horizontal, 6).padding(.vertical, 2)
                    .background(.tint.opacity(0.2), in: .capsule)
            }
        }
        .frame(height: 180)
    }
}

// MARK: - TableColumnAlignment

private struct Li_TableColumnAlignmentExample: View {
    private struct Txn: Identifiable {
        let id: Int
        let payee: String
        let amount: Double
    }
    private let transactions = [
        Txn(id: 1, payee: "Coffee", amount: 4.5),
        Txn(id: 2, payee: "Rent", amount: 1_850),
        Txn(id: 3, payee: "Groceries", amount: 72.3),
        Txn(id: 4, payee: "Refund", amount: -20),
    ]

    var body: some View {
        Table(transactions) {
            TableColumn("Payee", value: \.payee)
            TableColumn("Amount") {
                Text($0.amount, format: .currency(code: "USD"))
            }
            .alignment(.numeric)
        }
        .frame(height: 170)
    }
}

// MARK: - TableColumnContent

private struct Li_TableColumnContentExample: View {
    private let people = [
        Li_Person(id: 1, name: "Ada Lovelace", firstName: "Ada", lastName: "Lovelace", role: "Lead"),
        Li_Person(id: 2, name: "Grace Hopper", firstName: "Grace", lastName: "Hopper", role: "Admiral"),
        Li_Person(id: 3, name: "Alan Turing", firstName: "Alan", lastName: "Turing", role: "Founder"),
    ]

    @TableColumnBuilder<Li_Person, Never>
    private var nameColumns: some TableColumnContent<Li_Person, Never> {
        TableColumn("First") { Text($0.firstName) }
        TableColumn("Last") { Text($0.lastName) }
    }

    var body: some View {
        VStack(spacing: 6) {
            Table(people) { nameColumns }
                .frame(height: 150)
            Li_caption("The two columns are a reusable `some TableColumnContent` property.")
        }
    }
}

// MARK: - TableColumnCustomization

private struct Li_Employee: Identifiable {
    let id: Int
    let name: String
    let role: String
    let team: String
}

private struct Li_TableColumnCustomizationExample: View {
    @State private var customization = TableColumnCustomization<Li_Employee>()
    private let employees = [
        Li_Employee(id: 1, name: "Ada", role: "Lead", team: "iOS"),
        Li_Employee(id: 2, name: "Grace", role: "Admiral", team: "Backend"),
        Li_Employee(id: 3, name: "Alan", role: "Founder", team: "Research"),
    ]

    private var showRole: Bool {
        customization[visibility: "role"] != .hidden
    }

    var body: some View {
        VStack(spacing: 6) {
            Toggle("Show Role column", isOn: Binding(
                get: { showRole },
                set: { customization[visibility: "role"] = $0 ? .visible : .hidden }
            ))
            .toggleStyle(.switch)

            Table(employees, columnCustomization: $customization) {
                TableColumn("Name", value: \.name).customizationID("name")
                TableColumn("Role", value: \.role).customizationID("role")
                TableColumn("Team", value: \.team).customizationID("team")
            }
            .frame(height: 140)
        }
    }
}

// MARK: - TableRow

private struct Li_Track: Identifiable {
    let id: Int
    let title: String
    let lengthLabel: String
}

private struct Li_TableRowExample: View {
    private let bonus = Li_Track(id: 0, title: "Hidden Track", lengthLabel: "0:42")
    private let tracks = [
        Li_Track(id: 1, title: "Opening", lengthLabel: "3:12"),
        Li_Track(id: 2, title: "Interlude", lengthLabel: "1:48"),
        Li_Track(id: 3, title: "Finale", lengthLabel: "5:03"),
    ]

    var body: some View {
        Table(of: Li_Track.self) {
            TableColumn("Title", value: \.title)
            TableColumn("Length") { Text($0.lengthLabel) }
        } rows: {
            TableRow(bonus)
            ForEach(tracks) { TableRow($0) }
        }
        .frame(height: 170)
    }
}

// MARK: - TableRowContent

private struct Li_TableRowContentExample: View {
    @State private var revealed = "—"
    private let files = [
        Li_FileItem(id: 1, name: "Report.pdf", size: 240_000),
        Li_FileItem(id: 2, name: "Photo.heic", size: 3_100_000),
        Li_FileItem(id: 3, name: "Data.csv", size: 18_000),
    ]

    var body: some View {
        VStack(spacing: 6) {
            Table(of: Li_FileItem.self) {
                TableColumn("Name", value: \.name)
                TableColumn("Size") {
                    Text($0.size, format: .byteCount(style: .file))
                }
            } rows: {
                ForEach(files) { file in
                    TableRow(file)
                        .contextMenu {
                            Button("Reveal") { revealed = file.name }
                        }
                }
            }
            .frame(height: 130)

            Text("Revealed: \(revealed)")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - TableStyle

private enum Li_TableStyleChoice: String, CaseIterable, Identifiable {
    case automatic, inset, bordered
    var id: Self { self }
}

private struct Li_TableStyleExample: View {
    @State private var choice: Li_TableStyleChoice = .bordered
    private struct Device: Identifiable {
        let id: Int
        let name: String
        let status: String
    }
    private let devices = [
        Device(id: 1, name: "Router", status: "Online"),
        Device(id: 2, name: "Printer", status: "Idle"),
        Device(id: 3, name: "NAS", status: "Syncing"),
    ]

    var body: some View {
        VStack(spacing: 6) {
            Picker("Style", selection: $choice) {
                ForEach(Li_TableStyleChoice.allCases) { Text(".\($0.rawValue)").tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            let table = Table(devices) {
                TableColumn("Device", value: \.name)
                TableColumn("Status") { Text($0.status) }
            }

            Group {
                switch choice {
                case .automatic: table.tableStyle(.automatic)
                case .inset:     table.tableStyle(.inset)
                case .bordered:  table.tableStyle(.bordered)
                }
            }
            .frame(height: 130)
        }
    }
}

// MARK: - Visibility

private struct Li_VisibilityExample: View {
    @State private var separator: Visibility = .visible

    var body: some View {
        VStack(spacing: 6) {
            Picker("Separator", selection: $separator) {
                Text("automatic").tag(Visibility.automatic)
                Text("visible").tag(Visibility.visible)
                Text("hidden").tag(Visibility.hidden)
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            List {
                ForEach(0..<5, id: \.self) { i in
                    Text("Track \(i + 1)")
                        .listRowSeparator(separator)
                }
            }
            .frame(height: 130)
        }
    }
}
