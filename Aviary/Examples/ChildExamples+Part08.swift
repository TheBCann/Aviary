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

        // MARK: BadgeProminence

        ChildExampleEntry(parent: "BadgeProminence", child: "BadgeProminence.decreased", code: """
        List(folders) { folder in
            Label(folder.name, systemImage: "folder")
                .badge(folder.count)
        }
        .badgeProminence(.decreased)   // subdued secondary text that never competes with the title
        """) { AnyView(C08_BadgeProminenceDecreasedExample()) },

        ChildExampleEntry(parent: "BadgeProminence", child: "BadgeProminence.standard", code: """
        List {
            Label("Updates", systemImage: "arrow.down.circle")
                .badge(updates.count)
                .badgeProminence(.standard)   // the baseline: a plain secondary-color count
            Label("Purchased", systemImage: "bag")
                .badge(purchased.count)
        }
        """) { AnyView(C08_BadgeProminenceStandardExample()) },

        ChildExampleEntry(parent: "BadgeProminence", child: "BadgeProminence.increased", code: """
        List {
            Label("Inbox", systemImage: "tray")
                .badge(unreadCount)
                .badgeProminence(.increased)   // filled capsule so the count stands out
            Label("Sent", systemImage: "paperplane")
                .badge(sentCount)              // still .standard
        }
        """) { AnyView(C08_BadgeProminenceIncreasedExample()) },

        // MARK: EditActions

        ChildExampleEntry(parent: "EditActions", child: "EditActions.delete", code: """
        List($drafts, editActions: .delete, selection: $selection) { $draft in
            Text(draft.title)
        }
        // no onDelete closure — the list synthesizes removal itself
        """) { AnyView(C08_EditActionsDeleteExample()) },

        ChildExampleEntry(parent: "EditActions", child: "EditActions.move", code: """
        List {
            ForEach($steps, editActions: .move) { $step in
                TextField("Step", text: $step.title)   // drag rows to reorder — no onMove needed
            }
        }
        """) { AnyView(C08_EditActionsMoveExample()) },

        ChildExampleEntry(parent: "EditActions", child: "EditActions.all", code: """
        List($items, editActions: .all, selection: $selection) { $item in
            Toggle(item.name, isOn: $item.isDone)   // move and delete are both synthesized
        }
        """) { AnyView(C08_EditActionsAllExample()) },

        // MARK: ListItemTint

        ChildExampleEntry(parent: "ListItemTint", child: "ListItemTint.fixed(_:)", code: """
        List {
            Label("Battery", systemImage: "battery.100percent")
                .listItemTint(.fixed(.green))    // exactly green, whatever the list style prefers
            Label("Storage", systemImage: "internaldrive")
                .listItemTint(.fixed(.orange))
            Label("Default", systemImage: "gearshape")
        }
        .listStyle(.sidebar)
        """) { AnyView(C08_ListItemTintFixedExample()) },

        ChildExampleEntry(parent: "ListItemTint", child: "ListItemTint.preferred(_:)", code: """
        List {
            Label("Cellular", systemImage: "antenna.radiowaves.left.and.right")
                .listItemTint(.preferred(.teal))     // a suggestion — some list styles substitute their own
            Label("Bluetooth", systemImage: "wave.3.right")
                .listItemTint(.preferred(.indigo))
            Label("Default", systemImage: "gearshape")
        }
        .listStyle(.sidebar)
        """) { AnyView(C08_ListItemTintPreferredExample()) },

        ChildExampleEntry(parent: "ListItemTint", child: "ListItemTint.monochrome", code: """
        List {
            Label("Archive", systemImage: "archivebox")
                .listItemTint(.monochrome)           // neutral tone, no color at all
            Label("Trash", systemImage: "trash")
                .listItemTint(.monochrome)
            Label("Default", systemImage: "gearshape")
        }
        .listStyle(.sidebar)
        """) { AnyView(C08_ListItemTintMonochromeExample()) },

        // MARK: ListSectionSpacing

        ChildExampleEntry(parent: "ListSectionSpacing", child: "ListSectionSpacing.default", code: """
        List {
            Section("Now") { ForEach(current) { TaskRow($0) } }
            Section("Later") { ForEach(upcoming) { TaskRow($0) } }
        }
        .listSectionSpacing(.default)   // the platform's standard gap — iOS and watchOS only
        """) { AnyView(C08_ListSectionSpacingDefaultExample()) },

        ChildExampleEntry(parent: "ListSectionSpacing", child: "ListSectionSpacing.compact", code: """
        List {
            Section("Now") { ForEach(today) { EventRow($0) } }
            Section("Later") { ForEach(tomorrow) { EventRow($0) } }
        }
        .listSectionSpacing(.compact)   // the tightest gap the platform sanctions — iOS and watchOS only
        """) { AnyView(C08_ListSectionSpacingCompactExample()) },

        ChildExampleEntry(parent: "ListSectionSpacing", child: "ListSectionSpacing.custom(_:)", code: """
        List {
            Section("Now") { ForEach(inbox) { MailRow($0) } }
            Section("Later") { ForEach(drafts) { MailRow($0) } }
        }
        .listSectionSpacing(.custom(points))   // e.g. .custom(6) — iOS and watchOS only
        """) { AnyView(C08_ListSectionSpacingCustomExample()) },

        // MARK: ScrollAnchorRole

        ChildExampleEntry(parent: "ScrollAnchorRole", child: "ScrollAnchorRole.initialOffset", code: """
        ScrollView {
            LazyVStack { ForEach(days) { DayRow($0) } }
        }
        .defaultScrollAnchor(.center, for: .initialOffset)   // opens on today, then scrolls normally
        """) { AnyView(C08_ScrollAnchorRoleInitialOffsetExample()) },

        ChildExampleEntry(parent: "ScrollAnchorRole", child: "ScrollAnchorRole.sizeChanges", code: """
        ScrollView {
            LazyVStack { ForEach(transcript, id: \\.self) { Text($0) } }
        }
        .defaultScrollAnchor(.bottom, for: .sizeChanges)   // the bottom edge stays put as lines arrive

        Button("Add line") { transcript.append("Line \\(transcript.count + 1)") }
        """) { AnyView(C08_ScrollAnchorRoleSizeChangesExample()) },

        ChildExampleEntry(parent: "ScrollAnchorRole", child: "ScrollAnchorRole.alignment", code: """
        ScrollView {
            VStack { ForEach(recentItems) { ItemRow($0) } }
        }
        .defaultScrollAnchor(.bottom, for: .alignment)   // content shorter than the viewport sits at the bottom
        """) { AnyView(C08_ScrollAnchorRoleAlignmentExample()) },

        // MARK: ScrollBounceBehavior

        ChildExampleEntry(parent: "ScrollBounceBehavior", child: "ScrollBounceBehavior.automatic", code: """
        ScrollView {
            ProfileHeader()
            ProfileDetails()
        }
        .scrollBounceBehavior(.automatic)   // whatever the platform does for this container
        """) { AnyView(C08_ScrollBounceAutomaticExample()) },

        ChildExampleEntry(parent: "ScrollBounceBehavior", child: "ScrollBounceBehavior.always", code: """
        ScrollView(.horizontal) {
            ChipRow(tags)   // fits entirely in the viewport
        }
        .scrollBounceBehavior(.always, axes: .horizontal)   // rubber-bands anyway
        """) { AnyView(C08_ScrollBounceAlwaysExample()) },

        ChildExampleEntry(parent: "ScrollBounceBehavior", child: "ScrollBounceBehavior.basedOnSize", code: """
        ScrollView {
            SettingsSummary(rows: rowCount)
        }
        .scrollBounceBehavior(.basedOnSize)   // no jiggle while it fits; bounces once it overflows

        Stepper("Rows: \\(rowCount)", value: $rowCount, in: 1...12)
        """) { AnyView(C08_ScrollBounceBasedOnSizeExample()) },

        // MARK: ScrollDismissesKeyboardMode

        ChildExampleEntry(parent: "ScrollDismissesKeyboardMode", child: "ScrollDismissesKeyboardMode.automatic", code: """
        ScrollView {
            TextField("Search", text: $query)
            ResultsList(query: query)
        }
        .scrollDismissesKeyboard(.automatic)   // ScrollView dismisses eagerly; a Form keeps the keyboard up
        """) { AnyView(C08_ScrollDismissesKeyboardAutomaticExample()) },

        ChildExampleEntry(parent: "ScrollDismissesKeyboardMode", child: "ScrollDismissesKeyboardMode.immediately", code: """
        ScrollView {
            TextField("Search", text: $query)
            ResultsList(query: query)
        }
        .scrollDismissesKeyboard(.immediately)   // the keyboard hides the instant a drag begins
        """) { AnyView(C08_ScrollDismissesKeyboardImmediatelyExample()) },

        ChildExampleEntry(parent: "ScrollDismissesKeyboardMode", child: "ScrollDismissesKeyboardMode.interactively", code: """
        ScrollView {
            LazyVStack { ForEach(messages) { MessageRow($0) } }
        }
        .scrollDismissesKeyboard(.interactively)   // drag the keyboard down with the content, like Messages
        """) { AnyView(C08_ScrollDismissesKeyboardInteractivelyExample()) },

        ChildExampleEntry(parent: "ScrollDismissesKeyboardMode", child: "ScrollDismissesKeyboardMode.never", code: """
        Form {
            TextField("Name", text: $name)
            TextField("Email", text: $email)
        }
        .scrollDismissesKeyboard(.never)   // scrolling leaves the keyboard exactly where it is
        """) { AnyView(C08_ScrollDismissesKeyboardNeverExample()) },

        // MARK: ScrollEdgeEffectStyle

        ChildExampleEntry(parent: "ScrollEdgeEffectStyle", child: "ScrollEdgeEffectStyle.automatic", code: """
        ScrollView { feed }
            .safeAreaInset(edge: .top) { HeaderBar() }
            .scrollEdgeEffectStyle(.automatic, for: .all)   // the system picks the treatment for this container
        """) { AnyView(C08_ScrollEdgeEffectAutomaticExample()) },

        ChildExampleEntry(parent: "ScrollEdgeEffectStyle", child: "ScrollEdgeEffectStyle.soft", code: """
        ScrollView { feed }
            .safeAreaInset(edge: .top) { HeaderBar() }
            .scrollEdgeEffectStyle(.soft, for: .top)   // progressive blur under the bar — the Liquid Glass default
        """) { AnyView(C08_ScrollEdgeEffectSoftExample()) },

        ChildExampleEntry(parent: "ScrollEdgeEffectStyle", child: "ScrollEdgeEffectStyle.hard", code: """
        ScrollView { ledger }
            .safeAreaInset(edge: .top) { HeaderBar() }
            .safeAreaInset(edge: .bottom) { TotalsBar() }
            .scrollEdgeEffectStyle(.hard, for: [.top, .bottom])   // a crisp boundary, suited to dense tables
        """) { AnyView(C08_ScrollEdgeEffectHardExample()) },

        // MARK: ScrollIndicatorVisibility

        ChildExampleEntry(parent: "ScrollIndicatorVisibility", child: "ScrollIndicatorVisibility.visible", code: """
        ScrollView {
            LongFormArticle()
        }
        .scrollIndicators(.visible)   // shown according to platform convention
        """) { AnyView(C08_ScrollIndicatorsVisibleExample()) },

        ChildExampleEntry(parent: "ScrollIndicatorVisibility", child: "ScrollIndicatorVisibility.hidden", code: """
        ScrollView(.horizontal) {
            LazyHStack { ForEach(chips, id: \\.self) { ChipView($0) } }
        }
        .scrollIndicators(.hidden, axes: .horizontal)   // hidden, though the system may still surface them
        """) { AnyView(C08_ScrollIndicatorsHiddenExample()) },

        ChildExampleEntry(parent: "ScrollIndicatorVisibility", child: "ScrollIndicatorVisibility.never", code: """
        ScrollView {
            KioskSlides()
        }
        .scrollIndicators(.never)   // guaranteed never to draw
        """) { AnyView(C08_ScrollIndicatorsNeverExample()) },

        // MARK: ScrollPhase

        ChildExampleEntry(parent: "ScrollPhase", child: "ScrollPhase.isScrolling", code: """
        ScrollView { feed }
            .onScrollPhaseChange { _, newPhase in
                withAnimation { showsMiniPlayer = !newPhase.isScrolling }   // true in every phase but .idle
            }
        """) { AnyView(C08_ScrollPhaseIsScrollingExample()) },

        ChildExampleEntry(parent: "ScrollPhase", child: "ScrollPhase.idle", code: """
        ScrollView { feed }
            .onScrollPhaseChange { _, newPhase, context in
                if newPhase == .idle {   // nothing dragging or animating — a safe moment to persist
                    savedOffset = context.geometry.contentOffset.y
                    saveCount += 1
                }
            }
        """) { AnyView(C08_ScrollPhaseIdleExample()) },

        ChildExampleEntry(parent: "ScrollPhase", child: "ScrollPhase.interacting", code: """
        TextField("Search", text: $query).focused($isSearchFocused)

        ScrollView { feed }
            .onScrollPhaseChange { _, newPhase in
                phase = newPhase
                if newPhase == .interacting { isSearchFocused = false }   // the user is actively dragging
            }
        """) { AnyView(C08_ScrollPhaseInteractingExample()) },

        ChildExampleEntry(parent: "ScrollPhase", child: "ScrollPhase.decelerating", code: """
        ScrollView { feed }
            .onScrollPhaseChange { oldPhase, newPhase in
                phase = newPhase
                if oldPhase == .interacting && newPhase == .decelerating {
                    cancelledPrefetches += 1   // the finger lifted; content is coasting on momentum
                }
            }
        """) { AnyView(C08_ScrollPhaseDeceleratingExample()) },

        // MARK: ScrollPosition

        ChildExampleEntry(parent: "ScrollPosition", child: "ScrollPosition(edge:)", code: """
        @State private var position = ScrollPosition(edge: .bottom)

        ScrollView { feed }
            .scrollPosition($position)   // rests on the bottom edge until something scrolls
        Text("edge: \\(position.edge.map { "\\($0)" } ?? "nil")")
        """) { AnyView(C08_ScrollPositionEdgeExample()) },

        ChildExampleEntry(parent: "ScrollPosition", child: "ScrollPosition.scrollTo(id:anchor:)", code: """
        @State private var position = ScrollPosition(idType: Int.self)

        ScrollView {
            LazyVStack { ForEach(1...30, id: \\.self) { DayRow($0) } }
                .scrollTargetLayout()
        }
        .scrollPosition($position)

        Button("Today") {
            withAnimation { position.scrollTo(id: 15, anchor: .center) }
        }
        """) { AnyView(C08_ScrollPositionScrollToIDExample()) },

        // MARK: ScrollTransitionPhase

        ChildExampleEntry(parent: "ScrollTransitionPhase", child: "ScrollTransitionPhase.isIdentity", code: """
        ForEach(albums) { album in
            AlbumCard(album)
                .scrollTransition { content, phase in
                    content.opacity(phase.isIdentity ? 1 : 0.4)   // fully inside the visible region?
                }
        }
        """) { AnyView(C08_ScrollTransitionPhaseIsIdentityExample()) },

        ChildExampleEntry(parent: "ScrollTransitionPhase", child: "ScrollTransitionPhase.value", code: """
        MilestoneCard(milestone)
            .scrollTransition(.interactive) { content, phase in
                content
                    .offset(x: phase.value * 60)          // -1 at the top edge … 0 … 1 at the bottom edge
                    .blur(radius: abs(phase.value) * 4)
            }
        """) { AnyView(C08_ScrollTransitionPhaseValueExample()) },

        ChildExampleEntry(parent: "ScrollTransitionPhase", child: "ScrollTransitionPhase.topLeading", code: """
        SectionHeader(title)
            .scrollTransition { content, phase in
                content.opacity(phase == .topLeading ? 0 : 1)   // vanishes only while leaving through the top
            }
        """) { AnyView(C08_ScrollTransitionPhaseTopLeadingExample()) },

        ChildExampleEntry(parent: "ScrollTransitionPhase", child: "ScrollTransitionPhase.bottomTrailing", code: """
        StoryCard(story)
            .scrollTransition { content, phase in
                content.scaleEffect(phase == .bottomTrailing ? 0.8 : 1)   // shrinks only at the bottom edge
            }
        """) { AnyView(C08_ScrollTransitionPhaseBottomTrailingExample()) },

        // MARK: TableColumn

        ChildExampleEntry(parent: "TableColumn", child: "TableColumn(_:value:)", code: """
        @State private var sortOrder = [KeyPathComparator(\\Member.joinDate)]

        Table(members, sortOrder: $sortOrder) {
            TableColumn("Name", value: \\.name)
            TableColumn("Joined", value: \\.joinDate) {   // sortable via the Comparable key path
                Text($0.joinDate, style: .date)
            }
        }
        .onChange(of: sortOrder) { members.sort(using: sortOrder) }
        """) { AnyView(C08_TableColumnValueExample()) },

        ChildExampleEntry(parent: "TableColumn", child: "TableColumn.width()", code: """
        Table(members) {
            TableColumn("ID") { Text(String($0.id)) }
                .width(36)                               // fixed
            TableColumn("Name", value: \\.name)
                .width(min: 60, ideal: 100, max: 160)    // resizable within bounds
            TableColumn("Role", value: \\.role)           // takes whatever remains
        }
        """) { AnyView(C08_TableColumnWidthExample()) },

        // MARK: TableColumnAlignment

        ChildExampleEntry(parent: "TableColumnAlignment", child: "TableColumnAlignment.leading", code: """
        Table(members) {
            TableColumn("Title", value: \\.name)
                .alignment(.leading)                     // the usual choice for text
            TableColumn("Role", value: \\.role)
                .alignment(.center)                      // for contrast
        }
        """) { AnyView(C08_TableColumnAlignmentLeadingExample()) },

        ChildExampleEntry(parent: "TableColumnAlignment", child: "TableColumnAlignment.trailing", code: """
        Table(members) {
            TableColumn("Name", value: \\.name)
            TableColumn("Updated") { Text($0.joinDate, style: .relative) }
                .alignment(.trailing)                    // header and cells hug the trailing edge
        }
        """) { AnyView(C08_TableColumnAlignmentTrailingExample()) },

        ChildExampleEntry(parent: "TableColumnAlignment", child: "TableColumnAlignment.numeric", code: """
        Table(accounts) {
            TableColumn("Account", value: \\.name)
            TableColumn("Balance") { account in
                Text(account.balance, format: .currency(code: "EUR"))
            }
            .alignment(.numeric)                         // spreadsheet-style, flips with the locale
        }
        """) { AnyView(C08_TableColumnAlignmentNumericExample()) },

        // MARK: TableColumnCustomization

        ChildExampleEntry(parent: "TableColumnCustomization", child: "TableColumnCustomization()", code: """
        @State private var customization = TableColumnCustomization<Member>()   // usually @SceneStorage

        Table(members, columnCustomization: $customization) {
            TableColumn("Name", value: \\.name).customizationID("name")
            TableColumn("Role", value: \\.role).customizationID("role")
            TableColumn("ID") { Text(String($0.id)) }.customizationID("id")
        }
        """) { AnyView(C08_TableColumnCustomizationInitExample()) },

        ChildExampleEntry(parent: "TableColumnCustomization", child: "TableColumnCustomization.subscript(visibility:)", code: """
        Toggle("Show Role", isOn: Binding(
            get: { customization[visibility: "role"] != .hidden },
            set: { customization[visibility: "role"] = $0 ? .visible : .hidden }
        ))

        Table(members, columnCustomization: $customization) {
            TableColumn("Name", value: \\.name).customizationID("name")
            TableColumn("Role", value: \\.role).customizationID("role")
        }
        """) { AnyView(C08_TableColumnCustomizationSubscriptExample()) },

        ChildExampleEntry(parent: "TableColumnCustomization", child: "TableColumnCustomization.resetVisibility(for:)", code: """
        Button("Hide Role") { customization[visibility: "role"] = .hidden }
        Button("Reset Columns") {
            // The macOS 26 SDK has no resetVisibility(for:) — clear a column's user override by
            // writing .automatic through the visibility subscript; resetOrder() handles ordering.
            for id in ["name", "role", "id"] {
                customization[visibility: id] = .automatic
            }
            customization.resetOrder()
        }
        """) { AnyView(C08_TableColumnCustomizationResetExample()) },

        // MARK: TableRowContent

        ChildExampleEntry(parent: "TableRowContent", child: "TableRowContent.contextMenu(menuItems:)", code: """
        Table(of: Track.self) {
            TableColumn("Title", value: \\.title)
            TableColumn("Plays") { Text(String($0.plays)) }
        } rows: {
            ForEach(tracks) { track in
                TableRow(track)
                    .contextMenu {
                        Button("Play Next") { queue.append(track.title) }
                    }
            }
        }
        """) { AnyView(C08_TableRowContextMenuExample()) },

        ChildExampleEntry(parent: "TableRowContent", child: "TableRowContent.draggable(_:)", code: """
        Table(of: File.self) {
            TableColumn("File", value: \\.name)
        } rows: {
            ForEach(files) { file in
                TableRow(file)
                    .draggable(file.name)   // any Transferable payload — a String here
            }
        }
        """) { AnyView(C08_TableRowDraggableExample()) },

        ChildExampleEntry(parent: "TableRowContent", child: "TableRowContent.dropDestination(for:action:)", code: """
        Table(of: Folder.self) {
            TableColumn("Folder", value: \\.name)
            TableColumn("Items") { Text($0.items.joined(separator: ", ")) }
        } rows: {
            ForEach(folders) { folder in
                TableRow(folder)
                    .dropDestination(for: String.self) { names in
                        move(names, into: folder)
                    }
            }
        }
        """) { AnyView(C08_TableRowDropDestinationExample()) },

        // MARK: TableStyle

        ChildExampleEntry(parent: "TableStyle", child: "TableStyle.automatic", code: """
        Table(members) {
            TableColumn("Name", value: \\.name)
            TableColumn("Role", value: \\.role)
        }
        .tableStyle(.automatic)   // the platform's default appearance
        """) { AnyView(C08_TableStyleAutomaticExample()) },

        ChildExampleEntry(parent: "TableStyle", child: "TableStyle.inset", code: """
        Table(members) {
            TableColumn("Name", value: \\.name)
            TableColumn("Role", value: \\.role)
        }
        .tableStyle(.inset)   // padded, rounded — standard on iOS and modern macOS
        """) { AnyView(C08_TableStyleInsetExample()) },

        ChildExampleEntry(parent: "TableStyle", child: "TableStyle.bordered", code: """
        Table(members) {
            TableColumn("Name", value: \\.name)
            TableColumn("Role", value: \\.role)
        }
        .tableStyle(.bordered)   // the classic framed macOS table; unavailable on iOS
        """) { AnyView(C08_TableStyleBorderedExample()) },
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

// MARK: - Shared models

private nonisolated struct C08_Folder: Identifiable {
    let id: Int
    let name: String
    let count: Int
}

private nonisolated struct C08_Row: Identifiable {
    let id: Int
    var title: String
}

private nonisolated struct C08_Task: Identifiable {
    let id: Int
    var name: String
    var isDone: Bool
}

// MARK: - BadgeProminence

private struct C08_BadgeProminenceDecreasedExample: View {
    private let folders = [
        C08_Folder(id: 1, name: "Inbox", count: 12),
        C08_Folder(id: 2, name: "Drafts", count: 3),
        C08_Folder(id: 3, name: "Archive", count: 148),
    ]

    var body: some View {
        List(folders) { folder in
            Label(folder.name, systemImage: "folder")
                .badge(folder.count)
        }
        .badgeProminence(.decreased)
        .listStyle(.sidebar)
        .frame(height: 120)
    }
}

private struct C08_BadgeProminenceStandardExample: View {
    var body: some View {
        List {
            Label("Updates", systemImage: "arrow.down.circle")
                .badge(7)
                .badgeProminence(.standard)
            Label("Purchased", systemImage: "bag")
                .badge(42)
        }
        .listStyle(.sidebar)
        .frame(height: 100)
    }
}

private struct C08_BadgeProminenceIncreasedExample: View {
    var body: some View {
        List {
            Label("Inbox", systemImage: "tray")
                .badge(23)
                .badgeProminence(.increased)
            Label("Sent", systemImage: "paperplane")
                .badge(5)
        }
        .listStyle(.sidebar)
        .frame(height: 100)
    }
}

// MARK: - EditActions

private struct C08_EditActionsDeleteExample: View {
    @State private var drafts = [
        C08_Row(id: 1, title: "Q3 planning notes"),
        C08_Row(id: 2, title: "Reply to Dana"),
        C08_Row(id: 3, title: "Release checklist"),
        C08_Row(id: 4, title: "Untitled"),
    ]
    @State private var selection = Set<Int>()

    var body: some View {
        VStack(spacing: 6) {
            List($drafts, editActions: .delete, selection: $selection) { $draft in
                Text(draft.title)
            }
            .frame(height: 120)
            C08_Caption("\(drafts.count) drafts · swipe to delete on iOS; on macOS select a row and press ⌫")
        }
    }
}

private struct C08_EditActionsMoveExample: View {
    @State private var steps = [
        C08_Row(id: 1, title: "Preheat the oven"),
        C08_Row(id: 2, title: "Mix the batter"),
        C08_Row(id: 3, title: "Bake for 25 minutes"),
    ]

    var body: some View {
        VStack(spacing: 6) {
            List {
                ForEach($steps, editActions: .move) { $step in
                    TextField("Step", text: $step.title)
                }
            }
            .frame(height: 110)
            C08_Caption("Order: " + steps.map { String($0.id) }.joined(separator: " → ") + " · drag a row to reorder")
        }
    }
}

private struct C08_EditActionsAllExample: View {
    @State private var items = [
        C08_Task(id: 1, name: "Milk", isDone: false),
        C08_Task(id: 2, name: "Eggs", isDone: true),
        C08_Task(id: 3, name: "Bread", isDone: false),
    ]
    @State private var selection = Set<Int>()

    var body: some View {
        VStack(spacing: 6) {
            List($items, editActions: .all, selection: $selection) { $item in
                Toggle(item.name, isOn: $item.isDone)
            }
            .frame(height: 110)
            C08_Caption("\(items.count) items in order " + items.map { String($0.id) }.joined(separator: "-") + " · drag to move, ⌫ to delete")
        }
    }
}

// MARK: - ListItemTint

private struct C08_ListItemTintFixedExample: View {
    var body: some View {
        List {
            Label("Battery", systemImage: "battery.100percent")
                .listItemTint(.fixed(.green))
            Label("Storage", systemImage: "internaldrive")
                .listItemTint(.fixed(.orange))
            Label("Default", systemImage: "gearshape")
        }
        .listStyle(.sidebar)
        .frame(height: 120)
    }
}

private struct C08_ListItemTintPreferredExample: View {
    var body: some View {
        List {
            Label("Cellular", systemImage: "antenna.radiowaves.left.and.right")
                .listItemTint(.preferred(.teal))
            Label("Bluetooth", systemImage: "wave.3.right")
                .listItemTint(.preferred(.indigo))
            Label("Default", systemImage: "gearshape")
        }
        .listStyle(.sidebar)
        .frame(height: 120)
    }
}

private struct C08_ListItemTintMonochromeExample: View {
    var body: some View {
        List {
            Label("Archive", systemImage: "archivebox")
                .listItemTint(.monochrome)
            Label("Trash", systemImage: "trash")
                .listItemTint(.monochrome)
            Label("Default", systemImage: "gearshape")
        }
        .listStyle(.sidebar)
        .frame(height: 120)
    }
}

// MARK: - ListSectionSpacing

private struct C08_ListSectionSpacingDefaultExample: View {
    var body: some View {
        VStack(spacing: 8) {
            C08_MockSections(spacing: 24)
            C08_Caption("Illustrative — ListSectionSpacing.default restores the platform gap; iOS and watchOS only")
        }
    }
}

private struct C08_ListSectionSpacingCompactExample: View {
    var body: some View {
        VStack(spacing: 8) {
            C08_MockSections(spacing: 8)
            C08_Caption("Illustrative — ListSectionSpacing.compact requests the tightest gap; iOS and watchOS only")
        }
    }
}

private struct C08_ListSectionSpacingCustomExample: View {
    @State private var points: CGFloat = 6

    var body: some View {
        VStack(spacing: 8) {
            C08_MockSections(spacing: points)
            Slider(value: $points, in: 0...40) { Text("Points") }
                .labelsHidden()
            C08_Caption(String(format: "Illustrative — .custom(%.0f) wraps an exact point value; iOS and watchOS only", points))
        }
    }
}

// MARK: - ScrollAnchorRole

private struct C08_ScrollAnchorRoleInitialOffsetExample: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 4) {
                ForEach(1...21, id: \.self) { day in
                    HStack {
                        Text(day == 11 ? "Today" : "Day \(day)")
                        Spacer()
                        if day == 11 { Image(systemName: "circle.fill").foregroundStyle(.blue).font(.caption2) }
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(day == 11 ? Color.blue.opacity(0.2) : Color.gray.opacity(0.12), in: RoundedRectangle(cornerRadius: 6))
                }
            }
            .padding(8)
        }
        .defaultScrollAnchor(.center, for: .initialOffset)
        .frame(height: 140)
    }
}

private struct C08_ScrollAnchorRoleSizeChangesExample: View {
    @State private var transcript = (1...8).map { "Line \($0)" }

    var body: some View {
        VStack(spacing: 8) {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 4) {
                    ForEach(transcript, id: \.self) { Text($0).font(.caption.monospaced()) }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
            }
            .defaultScrollAnchor(.bottom, for: .sizeChanges)
            .frame(height: 100)
            .background(Color.gray.opacity(0.12), in: RoundedRectangle(cornerRadius: 8))
            Button("Add line") { transcript.append("Line \(transcript.count + 1)") }
            C08_Caption("Scroll to the bottom, then add lines — the bottom edge stays anchored")
        }
    }
}

private struct C08_ScrollAnchorRoleAlignmentExample: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 4) {
                ForEach(["Receipt.pdf", "Notes.md", "Sketch.png"], id: \.self) { name in
                    Label(name, systemImage: "doc")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.gray.opacity(0.12), in: RoundedRectangle(cornerRadius: 6))
                }
            }
            .padding(8)
        }
        .defaultScrollAnchor(.bottom, for: .alignment)
        .frame(height: 150)
        .background(Color.blue.opacity(0.08), in: RoundedRectangle(cornerRadius: 8))
        .overlay(alignment: .top) {
            C08_Caption("Three rows, 150 pt viewport — .alignment pushes them to the bottom").padding(6)
        }
    }
}

// MARK: - ScrollBounceBehavior

private struct C08_ScrollBounceAutomaticExample: View {
    var body: some View {
        VStack(spacing: 6) {
            ScrollView {
                VStack(spacing: 8) {
                    HStack {
                        Circle().fill(Color.purple.gradient).frame(width: 36, height: 36)
                        VStack(alignment: .leading) {
                            Text("Ada Lovelace").bold()
                            Text("Analyst").font(.caption).foregroundStyle(.secondary)
                        }
                        Spacer()
                    }
                    Text("Joined 1843 · London")
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(10)
            }
            .scrollBounceBehavior(.automatic)
            .frame(height: 110)
            .background(Color.gray.opacity(0.12), in: RoundedRectangle(cornerRadius: 8))
            C08_Caption("Drag the short content: .automatic follows the platform default for a ScrollView")
        }
    }
}

private struct C08_ScrollBounceAlwaysExample: View {
    var body: some View {
        VStack(spacing: 6) {
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(["Swift", "UI", "macOS"], id: \.self) { tag in
                        Text(tag)
                            .font(.callout)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.blue.opacity(0.2), in: Capsule())
                    }
                }
                .padding(10)
            }
            .scrollBounceBehavior(.always, axes: .horizontal)
            .frame(height: 50)
            .background(Color.gray.opacity(0.12), in: RoundedRectangle(cornerRadius: 8))
            C08_Caption("The chips fit, yet a horizontal drag still rubber-bands")
        }
    }
}

private struct C08_ScrollBounceBasedOnSizeExample: View {
    @State private var rowCount = 3

    var body: some View {
        VStack(spacing: 6) {
            ScrollView {
                VStack(spacing: 4) {
                    ForEach(1...rowCount, id: \.self) { i in
                        Text("Setting \(i)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.gray.opacity(0.12), in: RoundedRectangle(cornerRadius: 6))
                    }
                }
                .padding(8)
            }
            .scrollBounceBehavior(.basedOnSize)
            .frame(height: 110)
            .background(Color.gray.opacity(0.08), in: RoundedRectangle(cornerRadius: 8))
            Stepper("Rows: \(rowCount)", value: $rowCount, in: 1...12)
            C08_Caption(rowCount <= 3 ? "Fits — no bounce" : "Overflows — bounces at the edges")
        }
    }
}

// MARK: - ScrollDismissesKeyboardMode

/// A software-keyboard stand-in, since macOS has none to dismiss.
private struct C08_KeyboardMock: View {
    let note: String
    var body: some View {
        VStack(spacing: 4) {
            ForEach(0..<3, id: \.self) { row in
                HStack(spacing: 3) {
                    ForEach(0..<(10 - row), id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 3)
                            .fill(.background)
                            .frame(width: 14, height: 11)
                    }
                }
            }
            Text(note)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding(6)
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.2), in: RoundedRectangle(cornerRadius: 8))
    }
}

private struct C08_SearchResults: View {
    let query: String
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 4) {
            ForEach(1...12, id: \.self) { i in
                Text(query.isEmpty ? "Result \(i)" : "\(query) · result \(i)")
                    .font(.callout)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct C08_ScrollDismissesKeyboardAutomaticExample: View {
    @State private var query = ""

    var body: some View {
        VStack(spacing: 6) {
            ScrollView {
                TextField("Search", text: $query)
                    .textFieldStyle(.roundedBorder)
                C08_SearchResults(query: query)
            }
            .scrollDismissesKeyboard(.automatic)
            .frame(height: 90)
            .padding(8)
            .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
            C08_KeyboardMock(note: "Illustrative — iOS: a ScrollView dismisses on drag, a Form does not")
        }
    }
}

private struct C08_ScrollDismissesKeyboardImmediatelyExample: View {
    @State private var query = ""

    var body: some View {
        VStack(spacing: 6) {
            ScrollView {
                TextField("Search", text: $query)
                    .textFieldStyle(.roundedBorder)
                C08_SearchResults(query: query)
            }
            .scrollDismissesKeyboard(.immediately)
            .frame(height: 90)
            .padding(8)
            .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
            C08_KeyboardMock(note: "Illustrative — iOS: hides the moment a drag begins")
        }
    }
}

private struct C08_ScrollDismissesKeyboardInteractivelyExample: View {
    var body: some View {
        VStack(spacing: 6) {
            ScrollView {
                LazyVStack(spacing: 6) {
                    ForEach(1...10, id: \.self) { i in
                        Text(i.isMultiple(of: 2) ? "Sounds good, see you at 6." : "Are we still on for tonight?")
                            .font(.callout)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(i.isMultiple(of: 2) ? Color.blue.opacity(0.25) : Color.gray.opacity(0.15), in: Capsule())
                            .frame(maxWidth: .infinity, alignment: i.isMultiple(of: 2) ? .trailing : .leading)
                    }
                }
                .padding(8)
            }
            .scrollDismissesKeyboard(.interactively)
            .frame(height: 100)
            .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
            C08_KeyboardMock(note: "Illustrative — iOS: the keyboard follows your finger down")
        }
    }
}

private struct C08_ScrollDismissesKeyboardNeverExample: View {
    @State private var name = ""
    @State private var email = ""

    var body: some View {
        VStack(spacing: 6) {
            Form {
                TextField("Name", text: $name)
                TextField("Email", text: $email)
            }
            .formStyle(.grouped)
            .scrollDismissesKeyboard(.never)
            .frame(height: 100)
            C08_KeyboardMock(note: "Illustrative — iOS: stays up no matter how the form scrolls")
        }
    }
}

// MARK: - ScrollEdgeEffectStyle

private struct C08_BarHeader: View {
    var title = "Ledger"
    var body: some View {
        HStack {
            Text(title).font(.headline)
            Spacer()
            Image(systemName: "line.3.horizontal.decrease.circle")
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
    }
}

private struct C08_ScrollEdgeEffectAutomaticExample: View {
    var body: some View {
        ScrollView { C08_Feed(count: 20) }
            .safeAreaInset(edge: .top, spacing: 0) { C08_BarHeader(title: "Feed") }
            .scrollEdgeEffectStyle(.automatic, for: .all)
            .frame(height: 160)
            .background(Color.gray.opacity(0.08), in: RoundedRectangle(cornerRadius: 10))
    }
}

private struct C08_ScrollEdgeEffectSoftExample: View {
    var body: some View {
        ScrollView { C08_Feed(count: 20) }
            .safeAreaInset(edge: .top, spacing: 0) { C08_BarHeader(title: "Article") }
            .scrollEdgeEffectStyle(.soft, for: .top)
            .frame(height: 160)
            .background(Color.gray.opacity(0.08), in: RoundedRectangle(cornerRadius: 10))
    }
}

private struct C08_ScrollEdgeEffectHardExample: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(1...20, id: \.self) { i in
                    HStack {
                        Text("Entry \(i)").font(.caption.monospaced())
                        Spacer()
                        Text(String(format: "%.2f", Double(i) * 12.5)).font(.caption.monospaced())
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 5)
                    if i < 20 { Divider() }
                }
            }
        }
        .safeAreaInset(edge: .top, spacing: 0) { C08_BarHeader(title: "Ledger") }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            HStack {
                Text("Total").font(.caption.bold())
                Spacer()
                Text("2,625.00").font(.caption.monospaced().bold())
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
        }
        .scrollEdgeEffectStyle(.hard, for: [.top, .bottom])
        .frame(height: 170)
        .background(Color.gray.opacity(0.08), in: RoundedRectangle(cornerRadius: 10))
    }
}

// MARK: - ScrollIndicatorVisibility

private struct C08_ScrollIndicatorsVisibleExample: View {
    var body: some View {
        ScrollView {
            Text(String(repeating: "Long-form articles benefit from a visible indicator so readers can gauge their progress. ", count: 12))
                .font(.caption)
                .padding(10)
        }
        .scrollIndicators(.visible)
        .frame(height: 120)
        .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
    }
}

private struct C08_ScrollIndicatorsHiddenExample: View {
    private let chips = ["Swift", "SwiftUI", "Concurrency", "Combine", "Charts", "Metal", "Accessibility", "Localization"]

    var body: some View {
        VStack(spacing: 6) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 8) {
                    ForEach(chips, id: \.self) { chip in
                        Text(chip)
                            .font(.callout)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.teal.opacity(0.2), in: Capsule())
                    }
                }
                .padding(10)
            }
            .scrollIndicators(.hidden, axes: .horizontal)
            .frame(height: 50)
            .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
            C08_Caption("Scroll sideways — no horizontal indicator draws")
        }
    }
}

private struct C08_ScrollIndicatorsNeverExample: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(0..<6, id: \.self) { i in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(C08_Support.palette[i % C08_Support.palette.count].gradient)
                        .frame(height: 70)
                        .overlay(Text("Slide \(i + 1)").font(.headline).foregroundStyle(.white))
                }
            }
            .padding(8)
        }
        .scrollIndicators(.never)
        .frame(height: 140)
    }
}

// MARK: - ScrollPhase

private struct C08_ScrollPhaseIsScrollingExample: View {
    @State private var showsMiniPlayer = true
    @State private var isScrolling = false

    var body: some View {
        VStack(spacing: 6) {
            ScrollView { C08_Feed() }
                .onScrollPhaseChange { _, newPhase in
                    isScrolling = newPhase.isScrolling
                    withAnimation { showsMiniPlayer = !newPhase.isScrolling }
                }
                .frame(height: 110)
            if showsMiniPlayer {
                HStack {
                    Image(systemName: "play.fill")
                    Text("Now Playing — Rhapsody")
                    Spacer()
                }
                .font(.caption)
                .padding(8)
                .background(Color.pink.opacity(0.2), in: RoundedRectangle(cornerRadius: 8))
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
            Text("isScrolling: \(isScrolling ? "true" : "false")")
                .font(.caption.monospaced())
        }
        .frame(height: 170, alignment: .top)
    }
}

private struct C08_ScrollPhaseIdleExample: View {
    @State private var savedOffset: CGFloat = 0
    @State private var saveCount = 0

    var body: some View {
        VStack(spacing: 6) {
            ScrollView { C08_Feed() }
                .onScrollPhaseChange { _, newPhase, context in
                    if newPhase == .idle {
                        savedOffset = context.geometry.contentOffset.y
                        saveCount += 1
                    }
                }
                .frame(height: 120)
            Text(String(format: "reached .idle %d× · saved offset %.0f pt", saveCount, savedOffset))
                .font(.caption.monospaced())
        }
    }
}

private struct C08_ScrollPhaseInteractingExample: View {
    @State private var query = ""
    @State private var phase: ScrollPhase = .idle
    @FocusState private var isSearchFocused: Bool

    var body: some View {
        VStack(spacing: 6) {
            TextField("Search", text: $query)
                .textFieldStyle(.roundedBorder)
                .focused($isSearchFocused)
            ScrollView { C08_Feed() }
                .onScrollPhaseChange { _, newPhase in
                    phase = newPhase
                    if newPhase == .interacting { isSearchFocused = false }
                }
                .frame(height: 100)
            Text("phase: \(C08_Support.phaseName(phase)) · search focused: \(isSearchFocused ? "yes" : "no")")
                .font(.caption.monospaced())
        }
    }
}

private struct C08_ScrollPhaseDeceleratingExample: View {
    @State private var phase: ScrollPhase = .idle
    @State private var cancelledPrefetches = 0

    var body: some View {
        VStack(spacing: 6) {
            ScrollView { C08_Feed() }
                .onScrollPhaseChange { oldPhase, newPhase in
                    phase = newPhase
                    if oldPhase == .interacting && newPhase == .decelerating {
                        cancelledPrefetches += 1
                    }
                }
                .frame(height: 120)
            HStack {
                Text("phase: \(C08_Support.phaseName(phase))")
                    .foregroundStyle(phase == .decelerating ? .orange : .primary)
                Spacer()
                Text("prefetch cancelled \(cancelledPrefetches)×")
            }
            .font(.caption.monospaced())
        }
    }
}

// MARK: - ScrollPosition

private struct C08_ScrollPositionEdgeExample: View {
    @State private var position = ScrollPosition(edge: .bottom)

    var body: some View {
        VStack(spacing: 6) {
            ScrollView { C08_Feed() }
                .scrollPosition($position)
                .frame(height: 120)
            Text("edge: \(position.edge.map { "\($0)" } ?? "nil") · scroll to see it clear")
                .font(.caption.monospaced())
        }
    }
}

private struct C08_ScrollPositionScrollToIDExample: View {
    @State private var position = ScrollPosition(idType: Int.self)

    var body: some View {
        VStack(spacing: 6) {
            ScrollView {
                LazyVStack(spacing: 4) {
                    ForEach(1...30, id: \.self) { day in
                        Text(day == 15 ? "Today" : "Day \(day)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(day == 15 ? Color.blue.opacity(0.2) : Color.gray.opacity(0.12), in: RoundedRectangle(cornerRadius: 6))
                    }
                }
                .scrollTargetLayout()
                .padding(8)
            }
            .scrollPosition($position)
            .frame(height: 120)
            HStack {
                Button("Today") {
                    withAnimation { position.scrollTo(id: 15, anchor: .center) }
                }
                Button("Day 30") {
                    withAnimation { position.scrollTo(id: 30, anchor: .bottom) }
                }
                Spacer()
                Text("viewID: \(position.viewID(type: Int.self).map(String.init) ?? "nil")")
                    .font(.caption.monospaced())
            }
        }
    }
}

// MARK: - ScrollTransitionPhase

private struct C08_ScrollTransitionPhaseIsIdentityExample: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 12) {
                ForEach(0..<10, id: \.self) { i in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(C08_Support.palette[i % C08_Support.palette.count].gradient)
                        .frame(width: 90, height: 90)
                        .overlay(Text("Album \(i + 1)").font(.caption.bold()).foregroundStyle(.white))
                        .scrollTransition { content, phase in
                            content.opacity(phase.isIdentity ? 1 : 0.4)
                        }
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 110)
    }
}

private struct C08_ScrollTransitionPhaseValueExample: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(1...15, id: \.self) { i in
                    Label("Milestone \(i)", systemImage: "flag.fill")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                        .background(Color.orange.opacity(0.18), in: RoundedRectangle(cornerRadius: 8))
                        .scrollTransition(.interactive) { content, phase in
                            content
                                .offset(x: phase.value * 60)
                                .blur(radius: abs(phase.value) * 4)
                        }
                }
            }
            .padding(8)
        }
        .frame(height: 150)
    }
}

private struct C08_ScrollTransitionPhaseTopLeadingExample: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 6) {
                ForEach(1...15, id: \.self) { i in
                    Text("Section \(i)")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                        .background(Color.gray.opacity(0.12), in: RoundedRectangle(cornerRadius: 8))
                        .scrollTransition { content, phase in
                            content.opacity(phase == .topLeading ? 0 : 1)
                        }
                }
            }
            .padding(8)
        }
        .frame(height: 150)
        .overlay(alignment: .bottom) {
            C08_Caption("Bottom edge unaffected; rows fade only as they leave through the top").padding(4)
        }
    }
}

private struct C08_ScrollTransitionPhaseBottomTrailingExample: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(0..<15, id: \.self) { i in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(C08_Support.palette[i % C08_Support.palette.count].gradient)
                        .frame(height: 44)
                        .overlay(Text("Story \(i + 1)").font(.caption.bold()).foregroundStyle(.white))
                        .scrollTransition { content, phase in
                            content.scaleEffect(phase == .bottomTrailing ? 0.8 : 1)
                        }
                }
            }
            .padding(8)
        }
        .frame(height: 150)
    }
}

// MARK: - TableColumn

private nonisolated struct C08_Member: Identifiable {
    let id: Int
    let name: String
    let role: String
    let joinDate: Date
}

private enum C08_Members {
    static let sample: [C08_Member] = [
        C08_Member(id: 1, name: "Ada", role: "Engineer", joinDate: Date(timeIntervalSince1970: 1_700_000_000)),
        C08_Member(id: 2, name: "Grace", role: "Manager", joinDate: Date(timeIntervalSince1970: 1_650_000_000)),
        C08_Member(id: 3, name: "Linus", role: "Engineer", joinDate: Date(timeIntervalSince1970: 1_720_000_000)),
        C08_Member(id: 4, name: "Margaret", role: "Designer", joinDate: Date(timeIntervalSince1970: 1_600_000_000)),
    ]
}

private struct C08_TableColumnValueExample: View {
    @State private var members = C08_Members.sample
    @State private var sortOrder = [KeyPathComparator(\C08_Member.joinDate)]

    var body: some View {
        VStack(spacing: 4) {
            Table(members, sortOrder: $sortOrder) {
                TableColumn("Name", value: \.name)
                TableColumn("Joined", value: \.joinDate) {
                    Text($0.joinDate, style: .date)
                }
            }
            .onChange(of: sortOrder) { members.sort(using: sortOrder) }
            .frame(height: 140)
            C08_Caption("Click a header to sort — the key path drives the comparator")
        }
    }
}

private struct C08_TableColumnWidthExample: View {
    var body: some View {
        Table(C08_Members.sample) {
            TableColumn("ID") { Text(String($0.id)) }
                .width(36)
            TableColumn("Name", value: \.name)
                .width(min: 60, ideal: 100, max: 160)
            TableColumn("Role", value: \.role)
        }
        .frame(height: 140)
    }
}

// MARK: - TableColumnAlignment

private nonisolated struct C08_Account: Identifiable {
    let id: Int
    let name: String
    let balance: Double
}

private struct C08_TableColumnAlignmentLeadingExample: View {
    var body: some View {
        Table(C08_Members.sample) {
            TableColumn("Title", value: \.name)
                .alignment(.leading)
            TableColumn("Role", value: \.role)
                .alignment(.center)
        }
        .frame(height: 140)
    }
}

private struct C08_TableColumnAlignmentTrailingExample: View {
    var body: some View {
        Table(C08_Members.sample) {
            TableColumn("Name", value: \.name)
            TableColumn("Updated") { Text($0.joinDate, style: .relative) }
                .alignment(.trailing)
        }
        .frame(height: 140)
    }
}

private struct C08_TableColumnAlignmentNumericExample: View {
    private let accounts = [
        C08_Account(id: 1, name: "Checking", balance: 1_240.5),
        C08_Account(id: 2, name: "Savings", balance: 18_900),
        C08_Account(id: 3, name: "Travel", balance: 72.25),
    ]

    var body: some View {
        Table(accounts) {
            TableColumn("Account", value: \.name)
            TableColumn("Balance") { account in
                Text(account.balance, format: .currency(code: "EUR"))
            }
            .alignment(.numeric)
        }
        .frame(height: 120)
    }
}

// MARK: - TableColumnCustomization

private struct C08_TableColumnCustomizationInitExample: View {
    @State private var customization = TableColumnCustomization<C08_Member>()

    var body: some View {
        VStack(spacing: 4) {
            Table(C08_Members.sample, columnCustomization: $customization) {
                TableColumn("Name", value: \.name).customizationID("name")
                TableColumn("Role", value: \.role).customizationID("role")
                TableColumn("ID") { Text(String($0.id)) }.customizationID("id")
            }
            .frame(height: 140)
            C08_Caption("Empty customization — right-click a header to hide, show, or reorder columns")
        }
    }
}

private struct C08_TableColumnCustomizationSubscriptExample: View {
    @State private var customization = TableColumnCustomization<C08_Member>()

    var body: some View {
        VStack(spacing: 4) {
            Toggle("Show Role", isOn: Binding(
                get: { customization[visibility: "role"] != .hidden },
                set: { customization[visibility: "role"] = $0 ? .visible : .hidden }
            ))
            .toggleStyle(.switch)
            Table(C08_Members.sample, columnCustomization: $customization) {
                TableColumn("Name", value: \.name).customizationID("name")
                TableColumn("Role", value: \.role).customizationID("role")
            }
            .frame(height: 120)
        }
    }
}

private struct C08_TableColumnCustomizationResetExample: View {
    @State private var customization = TableColumnCustomization<C08_Member>()

    private func label(_ visibility: Visibility) -> String {
        switch visibility {
        case .automatic: return "automatic"
        case .visible: return "visible"
        case .hidden: return "hidden"
        @unknown default: return "unknown"
        }
    }

    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Button("Hide Role") { customization[visibility: "role"] = .hidden }
                Button("Reset Columns") {
                    for id in ["name", "role", "id"] {
                        customization[visibility: id] = .automatic
                    }
                    customization.resetOrder()
                }
                Spacer()
                Text("role: \(label(customization[visibility: "role"]))")
                    .font(.caption.monospaced())
            }
            Table(C08_Members.sample, columnCustomization: $customization) {
                TableColumn("Name", value: \.name).customizationID("name")
                TableColumn("Role", value: \.role).customizationID("role")
                TableColumn("ID") { Text(String($0.id)) }.customizationID("id")
            }
            .frame(height: 120)
            C08_Caption("No resetVisibility(for:) in this SDK — .automatic via the subscript restores each default")
        }
    }
}

// MARK: - TableRowContent

private nonisolated struct C08_Track: Identifiable {
    let id: Int
    let title: String
    let plays: Int
}

private nonisolated struct C08_File: Identifiable {
    let id: Int
    let name: String
}

private nonisolated struct C08_DropFolder: Identifiable {
    let id: Int
    let name: String
    var items: [String]
}

private struct C08_TableRowContextMenuExample: View {
    private let tracks = [
        C08_Track(id: 1, title: "Rhapsody", plays: 412),
        C08_Track(id: 2, title: "Nocturne", plays: 98),
        C08_Track(id: 3, title: "Overture", plays: 251),
    ]
    @State private var queue: [String] = []

    var body: some View {
        VStack(spacing: 4) {
            Table(of: C08_Track.self) {
                TableColumn("Title", value: \.title)
                TableColumn("Plays") { Text(String($0.plays)) }
            } rows: {
                ForEach(tracks) { track in
                    TableRow(track)
                        .contextMenu {
                            Button("Play Next") { queue.append(track.title) }
                        }
                }
            }
            .frame(height: 120)
            C08_Caption(queue.isEmpty ? "Right-click a row for its menu" : "Up next: " + queue.joined(separator: ", "))
        }
    }
}

private struct C08_TableRowDraggableExample: View {
    private let files = [
        C08_File(id: 1, name: "Receipt.pdf"),
        C08_File(id: 2, name: "Notes.md"),
        C08_File(id: 3, name: "Sketch.png"),
    ]
    @State private var dropped: [String] = []

    var body: some View {
        VStack(spacing: 6) {
            Table(of: C08_File.self) {
                TableColumn("File", value: \.name)
            } rows: {
                ForEach(files) { file in
                    TableRow(file)
                        .draggable(file.name)
                }
            }
            .frame(height: 110)
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
                .foregroundStyle(.secondary)
                .frame(height: 34)
                .overlay {
                    Text(dropped.isEmpty ? "Drag a row here" : "Received: " + dropped.joined(separator: ", "))
                        .font(.caption)
                }
                .dropDestination(for: String.self) { items, _ in
                    dropped = items
                    return true
                }
        }
    }
}

private struct C08_TableRowDropDestinationExample: View {
    @State private var folders = [
        C08_DropFolder(id: 1, name: "Work", items: []),
        C08_DropFolder(id: 2, name: "Personal", items: []),
    ]
    private let loose = ["Receipt.pdf", "Notes.md", "Sketch.png"]

    private func move(_ names: [String], into folder: C08_DropFolder) {
        guard let index = folders.firstIndex(where: { $0.id == folder.id }) else { return }
        folders[index].items.append(contentsOf: names)
    }

    var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 8) {
                ForEach(loose, id: \.self) { name in
                    Label(name, systemImage: "doc")
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.15), in: Capsule())
                        .draggable(name)
                }
                Spacer()
            }
            Table(of: C08_DropFolder.self) {
                TableColumn("Folder", value: \.name)
                TableColumn("Items") { Text($0.items.joined(separator: ", ")) }
            } rows: {
                ForEach(folders) { folder in
                    TableRow(folder)
                        .dropDestination(for: String.self) { names in
                            move(names, into: folder)
                        }
                }
            }
            .frame(height: 100)
            C08_Caption("Drag a chip onto a row")
        }
    }
}

// MARK: - TableStyle

private struct C08_TableStyleAutomaticExample: View {
    var body: some View {
        Table(C08_Members.sample) {
            TableColumn("Name", value: \.name)
            TableColumn("Role", value: \.role)
        }
        .tableStyle(.automatic)
        .frame(height: 140)
    }
}

private struct C08_TableStyleInsetExample: View {
    var body: some View {
        Table(C08_Members.sample) {
            TableColumn("Name", value: \.name)
            TableColumn("Role", value: \.role)
        }
        .tableStyle(.inset)
        .frame(height: 140)
    }
}

private struct C08_TableStyleBorderedExample: View {
    var body: some View {
        Table(C08_Members.sample) {
            TableColumn("Name", value: \.name)
            TableColumn("Role", value: \.role)
        }
        .tableStyle(.bordered)
        .frame(height: 140)
    }
}
