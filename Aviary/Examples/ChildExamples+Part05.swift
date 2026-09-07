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

        // MARK: .accessibilityQuickAction()

        ChildExampleEntry(parent: ".accessibilityQuickAction()", child: ".accessibilityQuickAction(style:content:)", code: """
        WorkoutMetrics(session: session)
            .accessibilityQuickAction(style: .prompt) {
                Button("Pause workout") { session.pause() }
            }
        """) { AnyView(C05_QuickActionStyleExample()) },

        ChildExampleEntry(parent: ".accessibilityQuickAction()", child: ".accessibilityQuickAction(style:isActive:content:)", code: """
        TimerView(timer: timer)
            .accessibilityQuickAction(style: .outline, isActive: $showingQuickAction) {
                Button("Stop timer") { timer.stop() }
            }
        """) { AnyView(C05_QuickActionIsActiveExample()) },

        // MARK: .accessibilityRotor()

        ChildExampleEntry(parent: ".accessibilityRotor()", child: ".accessibilityRotor(.headings)", code: """
        ScrollView {
            ForEach(sections) { section in
                Text(section.title).font(.headline).id(section.id)   // .id matches the entry
                Text(section.body)
            }
        }
        .accessibilityRotor(.headings) {
            ForEach(sections) { section in
                AccessibilityRotorEntry(section.title, id: section.id)
            }
        }
        """) { AnyView(C05_RotorHeadingsExample()) },

        ChildExampleEntry(parent: ".accessibilityRotor()", child: ".accessibilityRotor(_:entries:)", code: """
        ScrollView {
            ForEach(quotes) { quote in
                Text(quote.excerpt).italic().id(quote.id)
            }
        }
        .accessibilityRotor("Quotes") {
            ForEach(quotes) { quote in
                AccessibilityRotorEntry(quote.excerpt, id: quote.id)
            }
        }
        """) { AnyView(C05_RotorCustomExample()) },

        ChildExampleEntry(parent: ".accessibilityRotor()", child: ".accessibilityRotor(_: AccessibilitySystemRotor, entries:)", code: """
        HStack {
            ForEach(links) { link in
                Text(link.title).underline().id(link.id)   // drawn by hand, not a Link
            }
        }
        .accessibilityRotor(.links) {
            ForEach(links) { link in
                AccessibilityRotorEntry(link.title, id: link.id)
            }
        }
        """) { AnyView(C05_RotorSystemLinksExample()) },

        ChildExampleEntry(parent: ".accessibilityRotor()", child: ".accessibilityRotor(_:entries:entryLabel:)", code: """
        List(messages) { message in
            MessageRow(message: message)
        }
        .accessibilityRotor("Unread", entries: messages.filter(\\.isUnread), entryLabel: \\.subject)
        """) { AnyView(C05_RotorEntryLabelExample()) },

        // MARK: .accessibilityShowsLargeContentViewer()

        ChildExampleEntry(parent: ".accessibilityShowsLargeContentViewer()", child: ".accessibilityShowsLargeContentViewer()", code: """
        Button { searches += 1 } label: {
            Label("Search", systemImage: "magnifyingglass")
        }
        .accessibilityShowsLargeContentViewer()      // HUD derived from the title and image
        """) { AnyView(C05_LargeContentViewerExample()) },

        ChildExampleEntry(parent: ".accessibilityShowsLargeContentViewer()", child: ".accessibilityShowsLargeContentViewer(_:)", code: """
        Button { searches += 1 } label: {
            Image(systemName: "magnifyingglass")       // a bare glyph: nothing to derive a title from
        }
        .accessibilityShowsLargeContentViewer {
            Label("Search", systemImage: "magnifyingglass")
        }
        """) { AnyView(C05_LargeContentViewerBuilderExample()) },

        // MARK: .accessibilityValue()

        ChildExampleEntry(parent: ".accessibilityValue()", child: ".accessibilityValue(_: Text)", code: """
        Slider(value: $volume, in: 0...1)
            .accessibilityLabel("Volume")
            .accessibilityValue(Text(volume, format: .percent))
        """) { AnyView(C05_ValueTextExample()) },

        ChildExampleEntry(parent: ".accessibilityValue()", child: ".accessibilityValue(_: String)", code: """
        let value = "\\(quantity) items"           // a String, not a LocalizedStringKey

        QuantityBadge(count: quantity)
            .accessibilityLabel("Cart")
            .accessibilityValue(value)
        """) { AnyView(C05_ValueStringExample()) },

        ChildExampleEntry(parent: ".accessibilityValue()", child: ".accessibilityValue(_:isEnabled:)", code: """
        DownloadRow(name: "Episode 12.mp3", percent: percent)
            .accessibilityValue("\\(percent) percent", isEnabled: isDownloading)
        Toggle("isDownloading", isOn: $isDownloading)
        """) { AnyView(C05_ValueEnabledExample()) },

        // MARK: @AccessibilityFocusState

        ChildExampleEntry(parent: "@AccessibilityFocusState", child: "init()", code: """
        @AccessibilityFocusState private var isBannerFocused: Bool

        if showsBanner {
            Banner("Saved to Drafts")
                .accessibilityFocused($isBannerFocused)
        }
        Button("Save draft") { showsBanner = true; isBannerFocused = true }
        """) { AnyView(C05_FocusStateBoolInitExample()) },

        ChildExampleEntry(parent: "@AccessibilityFocusState", child: "init<T>()", code: """
        enum Step: Hashable { case shipping, payment, review }
        @AccessibilityFocusState private var focusedStep: Step?     // nil → nothing focused

        HStack {
            StepChip("Shipping").accessibilityFocused($focusedStep, equals: .shipping)
            StepChip("Payment").accessibilityFocused($focusedStep, equals: .payment)
            StepChip("Review").accessibilityFocused($focusedStep, equals: .review)
        }
        """) { AnyView(C05_FocusStateOptionalInitExample()) },

        ChildExampleEntry(parent: "@AccessibilityFocusState", child: "init(for:)", code: """
        @AccessibilityFocusState(for: .voiceOver) private var isHeadingFocused: Bool
        @AccessibilityFocusState(for: [.voiceOver, .switchControl]) private var focusedStep: Step?

        Text("Checkout").font(.title2)
            .accessibilityFocused($isHeadingFocused)
        StepChip("Payment")
            .accessibilityFocused($focusedStep, equals: .payment)
        """) { AnyView(C05_FocusStateForExample()) },

        ChildExampleEntry(parent: "@AccessibilityFocusState", child: "AccessibilityFocusState.Binding", code: """
        struct StepHeader: View {
            let focus: AccessibilityFocusState<Bool>.Binding      // the projected ($) type

            var body: some View {
                Text("Step 2 · Payment").accessibilityFocused(focus)
            }
        }

        @AccessibilityFocusState private var isHeaderFocused: Bool
        StepHeader(focus: $isHeaderFocused)
        """) { AnyView(C05_FocusStateBindingExample()) },

        // MARK: AccessibilityActionCategory

        ChildExampleEntry(parent: "AccessibilityActionCategory", child: ".default", code: """
        MessageRow(sender: "Priya", preview: "Are we still on for 3?")
            .accessibilityActions(category: .default) {
                Button("Reply") { replies += 1 }
            }
        """) { AnyView(C05_CategoryDefaultExample()) },

        ChildExampleEntry(parent: "AccessibilityActionCategory", child: ".edit", code: """
        TextEditor(text: $draft)
            .accessibilityActions(category: .edit) {
                Button("Attach photo") { attachments += 1 }
            }
        """) { AnyView(C05_CategoryEditExample()) },

        ChildExampleEntry(parent: "AccessibilityActionCategory", child: "init(_:)", code: """
        extension AccessibilityActionCategory {
            static let sharing = AccessibilityActionCategory("Sharing")
        }

        PhotoCell()
            .accessibilityActions(category: .sharing) {
                Button("Copy link") { copied = true }
            }
        """) { AnyView(C05_CategoryCustomExample()) },

        // MARK: AccessibilityActionKind

        ChildExampleEntry(parent: "AccessibilityActionKind", child: ".default", code: """
        CardFace(isFlipped: isFlipped)
            .accessibilityAction(.default) { isFlipped.toggle() }   // same as omitting the kind
        """) { AnyView(C05_KindDefaultExample()) },

        ChildExampleEntry(parent: "AccessibilityActionKind", child: ".escape", code: """
        if showsPanel {
            OverlayPanel("Filters")
                .accessibilityAction(.escape) { showsPanel = false }   // two-finger scrub
        }
        """) { AnyView(C05_KindEscapeExample()) },

        ChildExampleEntry(parent: "AccessibilityActionKind", child: ".magicTap", code: """
        PlayerView(player: player)
            .accessibilityAction(.magicTap) { player.togglePlayback() }   // two-finger double tap
        """) { AnyView(C05_KindMagicTapExample()) },

        ChildExampleEntry(parent: "AccessibilityActionKind", child: ".showMenu", code: """
        FileTile(name: "Report.pdf")
            .accessibilityAction(.showMenu) { menuShown = true }   // macOS: mirrors “Show Menu”
        """) { AnyView(C05_KindShowMenuExample()) },

        // MARK: AccessibilityChildBehavior

        ChildExampleEntry(parent: "AccessibilityChildBehavior", child: ".ignore", code: """
        ProgressRing(progress: progress)                 // a trimmed Circle plus a Text
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Progress")
            .accessibilityValue("\\(Int(progress * 100)) percent")
        """) { AnyView(C05_ChildIgnoreExample()) },

        ChildExampleEntry(parent: "AccessibilityChildBehavior", child: ".combine", code: """
        VStack(alignment: .leading) {
            Text("Union Station")
            Text(arrival, style: .relative)
        }
        .accessibilityElement(children: .combine)
        """) { AnyView(C05_ChildCombineExample()) },

        ChildExampleEntry(parent: "AccessibilityChildBehavior", child: ".contain", code: """
        HStack {
            Button("Bold") { isBold.toggle() }
            Button("Italic") { isItalic.toggle() }
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Formatting")
        """) { AnyView(C05_ChildContainExample()) },

        // MARK: AccessibilityCustomContentKey

        ChildExampleEntry(parent: "AccessibilityCustomContentKey", child: "init(_:id:)", code: """
        extension AccessibilityCustomContentKey {
            static let servings = AccessibilityCustomContentKey("Servings", id: "servings")
        }

        RecipeCard(name: "Paella")
            .accessibilityCustomContent(.servings, "\\(servings)")
        """) { AnyView(C05_ContentKeyIDExample()) },

        ChildExampleEntry(parent: "AccessibilityCustomContentKey", child: "init(_:)", code: """
        extension AccessibilityCustomContentKey {
            static let prepTime = AccessibilityCustomContentKey("Prep time")   // id derived from the key
        }

        RecipeCard(name: "Shakshuka")
            .accessibilityCustomContent(.prepTime, "\\(minutes) minutes")
        """) { AnyView(C05_ContentKeyLabelOnlyExample()) },

        // MARK: AccessibilityNotification

        ChildExampleEntry(parent: "AccessibilityNotification", child: "AccessibilityNotification.Announcement", code: """
        Button("Download") {
            downloads += 1
            AccessibilityNotification.Announcement("Download complete: Episode \\(downloads)").post()
        }
        """) { AnyView(C05_NotificationAnnouncementExample()) },

        ChildExampleEntry(parent: "AccessibilityNotification", child: "AccessibilityNotification.ScreenChanged", code: """
        OnboardingStep(step: step)
            .onChange(of: step) {
                AccessibilityNotification.ScreenChanged().post()   // optional element argument moves focus
            }
        """) { AnyView(C05_NotificationScreenChangedExample()) },

        ChildExampleEntry(parent: "AccessibilityNotification", child: "AccessibilityNotification.LayoutChanged", code: """
        Button(isExpanded ? "Hide details" : "Show details") {
            withAnimation { isExpanded.toggle() }
            AccessibilityNotification.LayoutChanged().post()
        }
        """) { AnyView(C05_NotificationLayoutChangedExample()) },

        ChildExampleEntry(parent: "AccessibilityNotification", child: "AccessibilityNotification.PageScrolled", code: """
        func goToPage(_ index: Int) {
            currentPage = index
            AccessibilityNotification.PageScrolled("Page \\(index + 1) of \\(pages.count)").post()
        }
        """) { AnyView(C05_NotificationPageScrolledExample()) },

        // MARK: AccessibilityRotorEntry

        ChildExampleEntry(parent: "AccessibilityRotorEntry", child: "init(_:id:textRange:prepare:)", code: """
        ScrollViewReader { proxy in
            ScrollView { ForEach(bookmarks) { Text($0.title).id($0.id) } }
                .accessibilityRotor("Bookmarks") {
                    ForEach(bookmarks) { bookmark in
                        AccessibilityRotorEntry(bookmark.title, id: bookmark.id) {
                            proxy.scrollTo(bookmark.id)        // prepare: runs before focus moves
                        }
                    }
                }
        }
        """) { AnyView(C05_RotorEntryPrepareExample()) },

        ChildExampleEntry(parent: "AccessibilityRotorEntry", child: "init(_:id:in:textRange:prepare:)", code: """
        @Namespace private var headingSpace

        ForEach(sections) { section in
            Text(section.title)
                .accessibilityRotorEntry(id: section.id, in: headingSpace)   // tagged, not .id()
        }
        .accessibilityRotor("Sections") {
            ForEach(sections) { section in
                AccessibilityRotorEntry(section.title, section.id, in: headingSpace)
            }
        }
        """) { AnyView(C05_RotorEntryNamespaceExample()) },

        ChildExampleEntry(parent: "AccessibilityRotorEntry", child: "init(_:textRange:prepare:)", code: """
        Text(body)
            .accessibilityRotor("Definitions") {
                ForEach(terms) { term in
                    AccessibilityRotorEntry(term.word, textRange: term.range)   // a span of this Text
                }
            }
        """) { AnyView(C05_RotorEntryTextRangeExample()) },

        // MARK: AccessibilitySystemRotor

        ChildExampleEntry(parent: "AccessibilitySystemRotor", child: ".headings", code: """
        ArticleView(sections: sections)
            .accessibilityRotor(.headings, entries: sections, entryLabel: \\.title)
        """) { AnyView(C05_SystemRotorHeadingsExample()) },

        ChildExampleEntry(parent: "AccessibilitySystemRotor", child: ".headings(level:)", code: """
        OutlineView(chapters: chapters)
            .accessibilityRotor(.headings(level: .h2)) {
                ForEach(chapters.flatMap(\\.subsections)) { sub in
                    AccessibilityRotorEntry(sub.title, id: sub.id)
                }
            }
        """) { AnyView(C05_SystemRotorHeadingLevelExample()) },

        ChildExampleEntry(parent: "AccessibilitySystemRotor", child: ".links(visited:)", code: """
        ReaderView(links: links)
            .accessibilityRotor(.links(visited: true), entries: links.filter(\\.isVisited), entryLabel: \\.title)
        """) { AnyView(C05_SystemRotorVisitedLinksExample()) },

        ChildExampleEntry(parent: "AccessibilitySystemRotor", child: ".textFields", code: """
        CustomForm(fields: fields)                         // hand-built fields, not TextFields
            .accessibilityRotor(.textFields, entries: fields, entryLabel: \\.title)
        """) { AnyView(C05_SystemRotorTextFieldsExample()) },

        // MARK: AccessibilityTraits

        ChildExampleEntry(parent: "AccessibilityTraits", child: ".isButton", code: """
        Image(systemName: "play.circle.fill")
            .onTapGesture { plays += 1 }
            .accessibilityLabel("Play")
            .accessibilityAddTraits(.isButton)
        """) { AnyView(C05_TraitButtonExample()) },

        ChildExampleEntry(parent: "AccessibilityTraits", child: ".isHeader", code: """
        Text("Now Playing")
            .font(.headline)
            .accessibilityAddTraits(.isHeader)
        """) { AnyView(C05_TraitHeaderExample()) },

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

// MARK: - .accessibilityQuickAction()

private struct C05_QuickActionStyleExample: View {
    @State private var isPaused = false

    var body: some View {
        VStack(spacing: 10) {
            C05_WatchFrame {
                VStack(spacing: 6) {
                    Text("Pause workout")
                        .font(.caption2.bold())
                        .padding(.horizontal, 10)
                        .padding(.vertical, 3)
                        .background(.blue, in: .capsule)
                    Text(isPaused ? "Paused" : "12:34")
                        .font(.title2.monospacedDigit()).bold()
                    Text("Outdoor Run").font(.caption)
                }
                .foregroundStyle(.white)
            }
            HStack {
                Button("Simulate double pinch") { isPaused.toggle() }
                C05_Caption("Illustrative — watchOS only. `.prompt` shows a banner naming the action; AssistiveTouch's double pinch runs it.")
            }
        }
    }
}

private struct C05_QuickActionIsActiveExample: View {
    @State private var showingQuickAction = true
    @State private var isRunning = true

    var body: some View {
        VStack(spacing: 10) {
            C05_WatchFrame {
                VStack(spacing: 8) {
                    Text(isRunning ? "04:59" : "Stopped")
                        .font(.title2.monospacedDigit()).bold()
                    Text("Stop timer")
                        .font(.caption.bold())
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .overlay(Capsule().stroke(showingQuickAction ? Color.yellow : Color.clear, lineWidth: 2))
                }
                .foregroundStyle(.white)
            }
            HStack {
                Toggle("showingQuickAction", isOn: $showingQuickAction)
                Button("Simulate double pinch") { isRunning = false; showingQuickAction = false }
            }
            C05_AXPanel([("isActive", "\(showingQuickAction)")])
            C05_Caption("Illustrative — watchOS only. `.outline` rings the target; the binding reports whether the quick action UI is showing and lets you dismiss it.")
        }
    }
}

// MARK: - .accessibilityRotor()

private struct C05_Section: Identifiable {
    let id: Int
    let title: String
    let body: String
}

private struct C05_Message: Identifiable {
    let id: Int
    let subject: String
    var isUnread: Bool
}

private struct C05_RotorHeadingsExample: View {
    private let sections = [
        C05_Section(id: 1, title: "Overview", body: "Custom-drawn titles VoiceOver would not recognise."),
        C05_Section(id: 2, title: "Ingredients", body: "Each rotor entry jumps to the matching .id()."),
        C05_Section(id: 3, title: "Method", body: "Turn the rotor to Headings and flick down.")
    ]

    var body: some View {
        VStack(spacing: 10) {
            ScrollView {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(sections) { section in
                        Text(section.title).font(.headline).id(section.id)
                        Text(section.body).font(.caption).foregroundStyle(.secondary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(height: 78)
            .accessibilityRotor(.headings) {
                ForEach(sections) { section in
                    AccessibilityRotorEntry(section.title, id: section.id)
                }
            }
            C05_RotorPanel(name: "Headings (system)", entries: sections.map(\.title))
            C05_Caption("Replaces the automatic Headings rotor with exactly these entries.")
        }
    }
}

private struct C05_RotorCustomExample: View {
    private let quotes = [
        C05_Section(id: 1, title: "“Ship early, ship often.”", body: ""),
        C05_Section(id: 2, title: "“Measure twice, cut once.”", body: ""),
        C05_Section(id: 3, title: "“Less, but better.”", body: "")
    ]

    var body: some View {
        VStack(spacing: 10) {
            ScrollView {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Three sayings worth pinning above the desk:")
                        .font(.caption).foregroundStyle(.secondary)
                    ForEach(quotes) { quote in
                        Text(quote.title).italic().id(quote.id)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(height: 78)
            .accessibilityRotor("Quotes") {
                ForEach(quotes) { quote in
                    AccessibilityRotorEntry(quote.title, id: quote.id)
                }
            }
            C05_RotorPanel(name: "Quotes (custom)", entries: quotes.map(\.title))
            C05_Caption("A named rotor you compose yourself; VoiceOver lists it beside the system rotors.")
        }
    }
}

private struct C05_RotorSystemLinksExample: View {
    private let links = [
        C05_Section(id: 1, title: "Release notes", body: ""),
        C05_Section(id: 2, title: "Migration guide", body: ""),
        C05_Section(id: 3, title: "Forums", body: "")
    ]

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 14) {
                ForEach(links) { link in
                    Text(link.title)
                        .underline()
                        .foregroundStyle(.blue)
                        .id(link.id)
                }
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            .accessibilityRotor(.links) {
                ForEach(links) { link in
                    AccessibilityRotorEntry(link.title, id: link.id)
                }
            }
            C05_RotorPanel(name: "Links (system)", entries: links.map(\.title))
            C05_Caption("These are styled Text, not Link views, so the built-in Links rotor would be empty without this.")
        }
    }
}

private struct C05_RotorEntryLabelExample: View {
    @State private var messages = [
        C05_Message(id: 1, subject: "Invoice #4021", isUnread: true),
        C05_Message(id: 2, subject: "Lunch on Friday?", isUnread: false),
        C05_Message(id: 3, subject: "Build failed on main", isUnread: true)
    ]

    var body: some View {
        VStack(spacing: 10) {
            List(messages) { message in
                HStack {
                    Circle()
                        .fill(message.isUnread ? Color.blue : Color.clear)
                        .frame(width: 8, height: 8)
                    Text(message.subject).fontWeight(message.isUnread ? .semibold : .regular)
                }
            }
            .frame(height: 90)
            .accessibilityRotor("Unread", entries: messages.filter(\.isUnread), entryLabel: \.subject)
            HStack {
                Button("Mark all read") { for i in messages.indices { messages[i].isUnread = false } }
                Button("Reset") { messages[0].isUnread = true; messages[2].isUnread = true }
            }
            C05_RotorPanel(name: "Unread", entries: messages.filter(\.isUnread).map(\.subject))
        }
    }
}

// MARK: - .accessibilityShowsLargeContentViewer()

private struct C05_LargeContentViewerExample: View {
    @State private var searches = 0

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 16) {
                Button { searches += 1 } label: {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .accessibilityShowsLargeContentViewer()
                Spacer()
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass").font(.title2)
                    Text("Search").font(.title3)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(.ultraThinMaterial, in: .rect(cornerRadius: 14))
            }
            C05_AXPanel([("Large content", "title “Search” + magnifyingglass, derived from the label"), ("Searches", "\(searches)")])
            C05_Caption("Illustrative HUD — iOS shows it when a user with larger accessibility text sizes long-presses the control.")
        }
    }
}

private struct C05_LargeContentViewerBuilderExample: View {
    @State private var searches = 0

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 16) {
                Button { searches += 1 } label: {
                    Image(systemName: "magnifyingglass")
                }
                .accessibilityShowsLargeContentViewer {
                    Label("Search", systemImage: "magnifyingglass")
                }
                Spacer()
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass").font(.title2)
                    Text("Search").font(.title3)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(.ultraThinMaterial, in: .rect(cornerRadius: 14))
            }
            C05_AXPanel([("Large content", "supplied explicitly — the glyph alone has no title"), ("Searches", "\(searches)")])
            C05_Caption("Illustrative HUD — the builder decides what the magnified preview shows.")
        }
    }
}

// MARK: - .accessibilityValue()

private struct C05_ValueTextExample: View {
    @State private var volume = 0.65

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "speaker.wave.2.fill").foregroundStyle(.secondary)
                Slider(value: $volume, in: 0...1)
                    .accessibilityLabel("Volume")
                    .accessibilityValue(Text(volume, format: .percent))
            }
            C05_AXPanel([("Label", "Volume"), ("Value", String(format: "%.0f%%  (Text, .percent format)", volume * 100))])
            C05_Caption("A Text value can carry a format style, so VoiceOver reads “65 percent” instead of “0.65”.")
        }
    }
}

private struct C05_ValueStringExample: View {
    @State private var quantity = 3

    var body: some View {
        let value = "\(quantity) items"
        VStack(spacing: 10) {
            HStack(spacing: 16) {
                Image(systemName: "cart")
                    .font(.title)
                    .overlay(alignment: .topTrailing) {
                        Text("\(quantity)")
                            .font(.caption2.bold())
                            .foregroundStyle(.white)
                            .padding(4)
                            .background(.red, in: .circle)
                            .offset(x: 8, y: -8)
                    }
                    .accessibilityLabel("Cart")
                    .accessibilityValue(value)
                Stepper("Quantity: \(quantity)", value: $quantity, in: 0...20)
            }
            C05_AXPanel([("Label", "Cart"), ("Value", "\(value)  (String)")])
        }
    }
}

private struct C05_ValueEnabledExample: View {
    @State private var percent = 42.0
    @State private var isDownloading = true

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: isDownloading ? "arrow.down.circle" : "checkmark.circle")
                    .foregroundStyle(isDownloading ? Color.blue : Color.green)
                VStack(alignment: .leading, spacing: 3) {
                    Text("Episode 12.mp3")
                    ProgressView(value: isDownloading ? percent / 100 : 1)
                }
            }
            .padding(10)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            .accessibilityElement(children: .combine)
            .accessibilityValue("\(Int(percent)) percent", isEnabled: isDownloading)
            HStack {
                Toggle("isDownloading", isOn: $isDownloading)
                Slider(value: $percent, in: 0...100).disabled(!isDownloading)
            }
            C05_AXPanel([("Value", isDownloading ? "\(Int(percent)) percent" : "none — isEnabled is false")])
        }
    }
}

// MARK: - @AccessibilityFocusState

private struct C05_FocusStateBoolInitExample: View {
    @AccessibilityFocusState private var isBannerFocused: Bool
    @State private var showsBanner = false

    var body: some View {
        VStack(spacing: 10) {
            if showsBanner {
                Label("Saved to Drafts", systemImage: "checkmark.circle.fill")
                    .foregroundStyle(.green)
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.green.opacity(0.12), in: .rect(cornerRadius: 8))
                    .accessibilityFocused($isBannerFocused)
            } else {
                Color.clear.frame(height: 34)
            }
            HStack {
                Button("Save draft") { showsBanner = true; isBannerFocused = true }
                Button("Dismiss") { showsBanner = false }
            }
            C05_AXPanel([("Declared as", "Bool — one bound view"), ("isBannerFocused", "\(isBannerFocused)")])
            C05_Caption("Reads true only while the VoiceOver cursor rests on the banner.")
        }
    }
}

private struct C05_FocusStateOptionalInitExample: View {
    enum Step: Hashable, CaseIterable { case shipping, payment, review }
    @AccessibilityFocusState private var focusedStep: Step?

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 8) {
                ForEach(Step.allCases, id: \.self) { step in
                    Text("\(step)".capitalized)
                        .font(.caption.bold())
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(focusedStep == step ? Color.accentColor.opacity(0.25) : Color.gray.opacity(0.15), in: .capsule)
                        .accessibilityFocused($focusedStep, equals: step)
                }
            }
            HStack {
                ForEach(Step.allCases, id: \.self) { step in
                    Button("Focus \("\(step)")") { focusedStep = step }
                }
                Button("Clear") { focusedStep = nil }
            }
            C05_AXPanel([("Declared as", "Step? — nil means nothing focused"), ("focusedStep", focusedStep.map { "\($0)" } ?? "nil")])
        }
    }
}

private struct C05_FocusStateForExample: View {
    enum Step: Hashable { case shipping, payment, review }
    @AccessibilityFocusState(for: .voiceOver) private var isHeadingFocused: Bool
    @AccessibilityFocusState(for: [.voiceOver, .switchControl]) private var focusedStep: Step?

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Checkout").font(.title2).bold()
                    .accessibilityFocused($isHeadingFocused)
                Spacer()
                Text("Payment")
                    .font(.caption.bold())
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.gray.opacity(0.15), in: .capsule)
                    .accessibilityFocused($focusedStep, equals: .payment)
            }
            HStack {
                Button("Focus heading") { isHeadingFocused = true }
                Button("Focus payment") { focusedStep = .payment }
            }
            C05_AXPanel([
                ("isHeadingFocused", "\(isHeadingFocused)  (for: .voiceOver)"),
                ("focusedStep", (focusedStep.map { "\($0)" } ?? "nil") + "  (for: [.voiceOver, .switchControl])")
            ])
            C05_Caption("Each state only tracks and drives the technologies it was declared for.")
        }
    }
}

private struct C05_StepHeader: View {
    let focus: AccessibilityFocusState<Bool>.Binding

    var body: some View {
        Text("Step 2 · Payment")
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 8))
            .accessibilityFocused(focus)
    }
}

private struct C05_FocusStateBindingExample: View {
    @AccessibilityFocusState private var isHeaderFocused: Bool

    var body: some View {
        VStack(spacing: 10) {
            C05_StepHeader(focus: $isHeaderFocused)
            Button("Focus header from the parent") { isHeaderFocused = true }
            C05_AXPanel([("Passed down", "$isHeaderFocused → AccessibilityFocusState<Bool>.Binding"), ("isHeaderFocused", "\(isHeaderFocused)")])
            C05_Caption("The child binds its own content; the parent still owns the state.")
        }
    }
}

// MARK: - AccessibilityActionCategory

private extension AccessibilityActionCategory {
    static let sharing = AccessibilityActionCategory("Sharing")
}

private struct C05_CategoryDefaultExample: View {
    @State private var replies = 0

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Circle().fill(Color.purple.gradient).frame(width: 32, height: 32)
                    .overlay(Text("P").bold().foregroundStyle(.white))
                VStack(alignment: .leading) {
                    Text("Priya").bold()
                    Text("Are we still on for 3?").font(.caption).foregroundStyle(.secondary)
                }
                Spacer()
            }
            .padding(10)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            .accessibilityElement(children: .combine)
            .accessibilityActions(category: .default) {
                Button("Reply") { replies += 1 }
            }
            C05_AXPanel([("Actions", "Reply  (category: .default — the general bucket)"), ("Replies", "\(replies)")])
            HStack {
                Button("Simulate Reply") { replies += 1 }
                C05_Caption("Same placement as an uncategorised action; naming .default is only for clarity.")
            }
        }
    }
}

private struct C05_CategoryEditExample: View {
    @State private var draft = "Photos from the trip"
    @State private var attachments = 0

    var body: some View {
        VStack(spacing: 10) {
            TextEditor(text: $draft)
                .font(.body)
                .frame(height: 56)
                .clipShape(.rect(cornerRadius: 8))
                .accessibilityLabel("Message")
                .accessibilityActions(category: .edit) {
                    Button("Attach photo") { attachments += 1 }
                }
            C05_AXPanel([("Edit actions", "Attach photo"), ("Attachments", "\(attachments)")])
            HStack {
                Button("Simulate “Attach photo”") { attachments += 1 }
                C05_Caption("Listed in VoiceOver's editing section, apart from general actions.")
            }
        }
    }
}

private struct C05_CategoryCustomExample: View {
    @State private var copied = false

    var body: some View {
        VStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(colors: [.orange, .pink], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 120, height: 64)
                .overlay(Image(systemName: "photo").font(.title).foregroundStyle(.white))
                .accessibilityLabel("Sunset photo")
                .accessibilityActions(category: .sharing) {
                    Button("Copy link") { copied = true }
                }
            C05_AXPanel([("Category", "“Sharing”  (custom, from init(_:))"), ("Actions", "Copy link"), ("Copied", "\(copied)")])
            HStack {
                Button("Simulate “Copy link”") { copied = true }
                Button("Reset") { copied = false }
            }
        }
    }
}

// MARK: - AccessibilityActionKind

private struct C05_KindDefaultExample: View {
    @State private var isFlipped = false

    var body: some View {
        VStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 12)
                .fill(isFlipped ? Color.green.gradient : Color.indigo.gradient)
                .frame(width: 140, height: 60)
                .overlay(Text(isFlipped ? "Back" : "Front").bold().foregroundStyle(.white))
                .accessibilityLabel("Card")
                .accessibilityAddTraits(.isButton)
                .accessibilityAction(.default) { isFlipped.toggle() }
            C05_AXPanel([("Kind", ".default — plain activation (double-tap)")])
            HStack {
                Button("Simulate activate") { withAnimation { isFlipped.toggle() } }
                C05_Caption("Identical to `.accessibilityAction { }` with the kind omitted.")
            }
        }
    }
}

private struct C05_KindEscapeExample: View {
    @State private var showsPanel = true

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.quaternary.opacity(0.5))
                    .frame(height: 70)
                    .overlay(Text("Content").foregroundStyle(.secondary))
                if showsPanel {
                    VStack(spacing: 4) {
                        Text("Filters").bold()
                        Text("Two-finger scrub to dismiss").font(.caption2)
                    }
                    .padding(10)
                    .background(.regularMaterial, in: .rect(cornerRadius: 10))
                    .shadow(radius: 4)
                    .accessibilityElement(children: .combine)
                    .accessibilityAction(.escape) { showsPanel = false }
                }
            }
            HStack {
                Button("Simulate escape") { withAnimation { showsPanel = false } }
                Button("Show panel") { withAnimation { showsPanel = true } }
            }
            C05_AXPanel([("Kind", ".escape — backs out of the current context"), ("showsPanel", "\(showsPanel)")])
        }
    }
}

private struct C05_KindMagicTapExample: View {
    @State private var isPlaying = false

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.pink.gradient)
                    .frame(width: 44, height: 44)
                    .overlay(Image(systemName: "music.note").foregroundStyle(.white))
                VStack(alignment: .leading) {
                    Text("Now Playing").bold()
                    Text(isPlaying ? "Playing" : "Paused").font(.caption).foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill").font(.title)
            }
            .padding(10)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            .accessibilityElement(children: .combine)
            C05_AXPanel([("Kind", ".magicTap — the app's one most important toggle")])
            HStack {
                Button("Simulate two-finger double tap") { isPlaying.toggle() }
                C05_Caption("Illustrative — .magicTap is unavailable on macOS; on iOS the handler runs from anywhere on screen.")
            }
        }
    }
}

private struct C05_KindShowMenuExample: View {
    @State private var menuShown = false

    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .top, spacing: 12) {
                VStack(spacing: 4) {
                    Image(systemName: "doc.richtext").font(.largeTitle).foregroundStyle(.red)
                    Text("Report.pdf").font(.caption)
                }
                .padding(8)
                .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 8))
                .accessibilityElement(children: .combine)
                .accessibilityAction(.showMenu) { menuShown = true }
                if menuShown {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Open")
                        Text("Get Info")
                        Text("Move to Trash")
                    }
                    .font(.caption)
                    .padding(8)
                    .background(.regularMaterial, in: .rect(cornerRadius: 8))
                    .shadow(radius: 3)
                }
                Spacer()
            }
            HStack {
                Button("Simulate Show Menu") { withAnimation { menuShown = true } }
                Button("Close") { withAnimation { menuShown = false } }
            }
            C05_AXPanel([("Kind", ".showMenu — macOS only, alongside .delete")])
        }
    }
}

// MARK: - AccessibilityChildBehavior

private struct C05_ChildIgnoreExample: View {
    @State private var progress = 0.72

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 16) {
                ZStack {
                    Circle().stroke(.quaternary, lineWidth: 8)
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(Color.blue, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    Text("\(Int(progress * 100))%").font(.caption.bold())
                }
                .frame(width: 64, height: 64)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Progress")
                .accessibilityValue("\(Int(progress * 100)) percent")
                Slider(value: $progress, in: 0...1)
            }
            C05_AXPanel([("Elements", "1 — “Progress, \(Int(progress * 100)) percent”"), ("Children", "hidden (the circle and inner text)")])
        }
    }
}

private struct C05_ChildCombineExample: View {
    private let arrival = Date().addingTimeInterval(9 * 60)

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "tram.fill").foregroundStyle(.orange)
                VStack(alignment: .leading) {
                    Text("Union Station")
                    Text(arrival, style: .relative).font(.caption).foregroundStyle(.secondary)
                }
                Spacer()
            }
            .padding(10)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            .accessibilityElement(children: .combine)
            C05_AXPanel([("Elements", "1 — “Union Station, 9 minutes”"), ("Without it", "2 separate stops for the cursor")])
        }
    }
}

private struct C05_ChildContainExample: View {
    @State private var isBold = false
    @State private var isItalic = false

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Button("Bold") { isBold.toggle() }
                Button("Italic") { isItalic.toggle() }
            }
            .accessibilityElement(children: .contain)
            .accessibilityLabel("Formatting")
            Text("The quick brown fox")
                .fontWeight(isBold ? .bold : .regular)
                .italic(isItalic)
            C05_AXPanel([("Container", "“Formatting”"), ("Children", "Bold (button), Italic (button) — each still focusable")])
        }
    }
}

// MARK: - AccessibilityCustomContentKey

private struct C05_ContentKeyIDExample: View {
    @State private var servings = 6

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
            .accessibilityCustomContent(.servings, "\(servings)")
            Stepper("Servings: \(servings)", value: $servings, in: 1...12)
            C05_AXPanel([("Key label", "“Servings”"), ("Key id", "“servings” — explicit, stable across localisations"), ("More Content", "Servings: \(servings)")])
        }
    }
}

private struct C05_ContentKeyLabelOnlyExample: View {
    @State private var minutes = 25

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "fork.knife").foregroundStyle(.orange)
                Text("Shakshuka").bold()
                Spacer()
                Text("\(minutes) min").font(.caption).foregroundStyle(.secondary)
            }
            .padding(10)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            .accessibilityElement(children: .combine)
            .accessibilityCustomContent(.prepTime, "\(minutes) minutes")
            Stepper("Minutes: \(minutes)", value: $minutes, in: 5...90, step: 5)
            C05_AXPanel([("Key label", "“Prep time”"), ("Key id", "derived from the localized key itself"), ("More Content", "Prep time: \(minutes) minutes")])
        }
    }
}

// MARK: - AccessibilityNotification

private struct C05_NotificationAnnouncementExample: View {
    @State private var downloads = 0
    @State private var lastAnnouncement = "—"

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Button("Download") {
                    downloads += 1
                    let message = "Download complete: Episode \(downloads)"
                    AccessibilityNotification.Announcement(message).post()
                    lastAnnouncement = message
                }
                Image(systemName: "speaker.wave.3.fill").foregroundStyle(.secondary)
            }
            C05_AXPanel([("Spoken", lastAnnouncement), ("Focus", "unchanged — announcements never move the cursor")])
            C05_Caption("With VoiceOver running, the string is spoken as soon as post() is called.")
        }
    }
}

private struct C05_NotificationScreenChangedExample: View {
    @State private var step = 1
    @State private var posted = 0

    var body: some View {
        VStack(spacing: 10) {
            Picker("Step", selection: $step) {
                Text("Welcome").tag(1)
                Text("Permissions").tag(2)
                Text("Done").tag(3)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            Text(["Welcome aboard", "Grant a few permissions", "You're all set"][step - 1])
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
                .onChange(of: step) {
                    AccessibilityNotification.ScreenChanged().post()
                    posted += 1
                }
            C05_AXPanel([("Posted", "ScreenChanged × \(posted)"), ("Effect", "VoiceOver plays the new-screen tone and resets its cursor")])
        }
    }
}

private struct C05_NotificationLayoutChangedExample: View {
    @State private var isExpanded = false
    @State private var posted = 0

    var body: some View {
        VStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 6) {
                Button(isExpanded ? "Hide details" : "Show details") {
                    withAnimation { isExpanded.toggle() }
                    AccessibilityNotification.LayoutChanged().post()
                    posted += 1
                }
                if isExpanded {
                    Text("Order #4021 · 3 items · Ships tomorrow")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            C05_AXPanel([("Posted", "LayoutChanged × \(posted)"), ("Effect", "a smaller in-place change; no new-screen tone")])
        }
    }
}

private struct C05_NotificationPageScrolledExample: View {
    private let pages = ["Intro", "Setup", "Usage", "Tips"]
    @State private var currentPage = 0
    @State private var spoken = "—"

    private func goToPage(_ index: Int) {
        currentPage = index
        let message = "Page \(index + 1) of \(pages.count)"
        AccessibilityNotification.PageScrolled(message).post()
        spoken = message
    }

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Button { goToPage(max(0, currentPage - 1)) } label: { Image(systemName: "chevron.left") }
                    .disabled(currentPage == 0)
                Spacer()
                VStack(spacing: 6) {
                    Text(pages[currentPage]).font(.headline)
                    HStack(spacing: 6) {
                        ForEach(pages.indices, id: \.self) { i in
                            Circle().fill(i == currentPage ? Color.primary : Color.secondary.opacity(0.3)).frame(width: 6, height: 6)
                        }
                    }
                }
                Spacer()
                Button { goToPage(min(pages.count - 1, currentPage + 1)) } label: { Image(systemName: "chevron.right") }
                    .disabled(currentPage == pages.count - 1)
            }
            .padding(10)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            C05_AXPanel([("Spoken", spoken)])
        }
    }
}

// MARK: - AccessibilityRotorEntry

private struct C05_RotorEntryPrepareExample: View {
    private let bookmarks = (1...8).map { C05_Section(id: $0, title: "Bookmark \($0)", body: "") }
    @State private var lastPrepared = "—"

    var body: some View {
        VStack(spacing: 10) {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 6) {
                        ForEach(bookmarks) { bookmark in
                            Label(bookmark.title, systemImage: "bookmark").id(bookmark.id)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(height: 70)
                .accessibilityRotor("Bookmarks") {
                    ForEach(bookmarks) { bookmark in
                        AccessibilityRotorEntry(bookmark.title, id: bookmark.id) {
                            proxy.scrollTo(bookmark.id)
                        }
                    }
                }
                HStack {
                    Text("Simulate rotor →").font(.caption).foregroundStyle(.secondary)
                    ForEach([1, 4, 8], id: \.self) { n in
                        Button("\(n)") {
                            withAnimation { proxy.scrollTo(n, anchor: .top) }
                            lastPrepared = "Bookmark \(n)"
                        }
                    }
                }
            }
            C05_AXPanel([("prepare ran for", lastPrepared)])
            C05_Caption("The prepare closure scrolls lazy content into place so the entry's view exists when focus lands.")
        }
    }
}

private struct C05_RotorEntryNamespaceExample: View {
    @Namespace private var headingSpace
    private let sections = [
        C05_Section(id: 1, title: "Getting started", body: ""),
        C05_Section(id: 2, title: "Configuration", body: ""),
        C05_Section(id: 3, title: "Troubleshooting", body: "")
    ]

    var body: some View {
        VStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 4) {
                ForEach(sections) { section in
                    Text(section.title)
                        .font(.headline)
                        .accessibilityRotorEntry(id: section.id, in: headingSpace)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            .accessibilityRotor("Sections") {
                ForEach(sections) { section in
                    AccessibilityRotorEntry(section.title, section.id, in: headingSpace)
                }
            }
            C05_RotorPanel(name: "Sections", entries: sections.map(\.title))
            C05_Caption("The Namespace pairs each entry with a view tagged by .accessibilityRotorEntry(id:in:), leaving .id() free for other uses.")
        }
    }
}

private struct C05_Term: Identifiable {
    let word: String
    let range: Range<String.Index>
    var id: String { word }
}

private struct C05_RotorEntryTextRangeExample: View {
    private let body_ = "A closure captures state. A protocol declares requirements. An actor isolates it."
    private var terms: [C05_Term] {
        ["closure", "protocol", "actor"].compactMap { word in
            body_.range(of: word).map { C05_Term(word: word, range: $0) }
        }
    }

    var body: some View {
        VStack(spacing: 10) {
            Text(body_)
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
                .accessibilityRotor("Definitions") {
                    ForEach(terms) { term in
                        AccessibilityRotorEntry(term.word, textRange: term.range)
                    }
                }
            C05_RotorPanel(name: "Definitions", entries: terms.map { term in
                let start = body_.distance(from: body_.startIndex, to: term.range.lowerBound)
                return "\(term.word) @ \(start)"
            })
            C05_Caption("Each entry targets a character range inside the same Text, so VoiceOver moves within the string.")
        }
    }
}

// MARK: - AccessibilitySystemRotor

private struct C05_SystemRotorHeadingsExample: View {
    private let sections = [
        C05_Section(id: 1, title: "Summary", body: "Two lines of copy under a custom heading."),
        C05_Section(id: 2, title: "Details", body: "Headings drawn as styled Text, not real headers."),
        C05_Section(id: 3, title: "Next steps", body: "The rotor still lists them.")
    ]

    var body: some View {
        VStack(spacing: 10) {
            ScrollView {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(sections) { section in
                        Text(section.title.uppercased()).font(.caption.bold()).foregroundStyle(.secondary).id(section.id)
                        Text(section.body).font(.caption)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(height: 78)
            .accessibilityRotor(.headings, entries: sections, entryLabel: \.title)
            C05_RotorPanel(name: "Headings", entries: sections.map(\.title))
        }
    }
}

private struct C05_SystemRotorHeadingLevelExample: View {
    private let chapter = "1. Foundations"
    private let subsections = [
        C05_Section(id: 11, title: "1.1 Values", body: ""),
        C05_Section(id: 12, title: "1.2 Types", body: ""),
        C05_Section(id: 13, title: "1.3 Protocols", body: "")
    ]

    var body: some View {
        VStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 4) {
                Text(chapter).font(.headline).accessibilityHeading(.h1)
                ForEach(subsections) { sub in
                    Text(sub.title)
                        .font(.subheadline)
                        .padding(.leading, 12)
                        .accessibilityHeading(.h2)
                        .id(sub.id)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            .accessibilityRotor(.headings(level: .h2)) {
                ForEach(subsections) { sub in
                    AccessibilityRotorEntry(sub.title, id: sub.id)
                }
            }
            C05_RotorPanel(name: "Headings · level 2", entries: subsections.map(\.title))
            C05_Caption("Only the H2 rotor is replaced; the H1 chapter title stays in the general Headings rotor.")
        }
    }
}

private struct C05_Link: Identifiable {
    let id: Int
    let title: String
    var isVisited: Bool
}

private struct C05_SystemRotorVisitedLinksExample: View {
    @State private var links = [
        C05_Link(id: 1, title: "Overview", isVisited: true),
        C05_Link(id: 2, title: "API reference", isVisited: false),
        C05_Link(id: 3, title: "Changelog", isVisited: true)
    ]

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 14) {
                ForEach(links) { link in
                    Text(link.title)
                        .underline()
                        .foregroundStyle(link.isVisited ? Color.purple : Color.blue)
                        .id(link.id)
                        .onTapGesture {
                            if let i = links.firstIndex(where: { $0.id == link.id }) { links[i].isVisited.toggle() }
                        }
                }
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            .accessibilityRotor(.links(visited: true), entries: links.filter(\.isVisited), entryLabel: \.title)
            C05_RotorPanel(name: "Visited Links", entries: links.filter(\.isVisited).map(\.title))
            C05_Caption("Click a link to toggle visited. `.links(visited: true)` is a separate rotor from plain `.links`.")
        }
    }
}

private struct C05_SystemRotorTextFieldsExample: View {
    private let fields = [
        C05_Section(id: 1, title: "Full name", body: "Ada Lovelace"),
        C05_Section(id: 2, title: "Email", body: "ada@example.com")
    ]

    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 6) {
                ForEach(fields) { field in
                    HStack {
                        Text(field.title).font(.caption).foregroundStyle(.secondary).frame(width: 70, alignment: .trailing)
                        Text(field.body)
                            .padding(.horizontal, 8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 24)
                            .background(.background, in: .rect(cornerRadius: 6))
                            .overlay(RoundedRectangle(cornerRadius: 6).stroke(.quaternary))
                    }
                    .id(field.id)
                }
            }
            .accessibilityRotor(.textFields, entries: fields, entryLabel: \.title)
            C05_RotorPanel(name: "Text Fields", entries: fields.map(\.title))
            C05_Caption("These rows are custom-drawn, so the built-in Text Fields rotor needs to be told about them.")
        }
    }
}

// MARK: - AccessibilityTraits

private struct C05_TraitButtonExample: View {
    @State private var plays = 0

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 16) {
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 36))
                    .foregroundStyle(.green)
                    .onTapGesture { plays += 1 }
                    .accessibilityLabel("Play")
                    .accessibilityAddTraits(.isButton)
                Text("Plays: \(plays)").monospacedDigit()
            }
            C05_AXPanel([("Spoken", "“Play, button”"), ("Without it", "“Play, image” — and VoiceOver won't offer to activate it")])
        }
    }
}

private struct C05_TraitHeaderExample: View {
    var body: some View {
        VStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Now Playing")
                    .font(.headline)
                    .accessibilityAddTraits(.isHeader)
                Text("Blue in Green · Miles Davis").font(.caption)
                Text("So What · Miles Davis").font(.caption)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            C05_AXPanel([("Spoken", "“Now Playing, heading”"), ("Rotor", "listed under Headings for quick navigation")])
        }
    }
}

// C05_MORE_STRUCTS
