//
//  ChildExamples+Part07.swift
//  Aviary
//
//  Compiled renderings for variant entries (part 07: gen-text).
//  One private C07_* struct per variant; every rendering exercises the exact
//  overload the variant names, so siblings can be compared side by side.
//

import SwiftUI

enum ChildExamplesPart07 {
    static let entries: [ChildExampleEntry] = [

        // MARK: .bold()

        ChildExampleEntry(parent: ".bold()", child: "Text.bold()", code: """
        Text("Due: ") + Text(dueDate, style: .date).bold()
        Text("Total: ") + Text(total, format: .currency(code: "USD")).bold()
        """) { AnyView(C07_TextBoldExample()) },

        ChildExampleEntry(parent: ".bold()", child: ".bold(_:)", code: """
        Label("Inbox", systemImage: "tray")
            .bold(unreadCount > 0)          // Bool form; also thickens the symbol
        Stepper("Unread: \\(unreadCount)", value: $unreadCount, in: 0...9)
        """) { AnyView(C07_BoldBoolExample()) },

        // MARK: .dynamicTypeSize()

        ChildExampleEntry(parent: ".dynamicTypeSize()", child: ".dynamicTypeSize(_: DynamicTypeSize)", code: """
        HStack {
            ScoreTile("Follows")                       // tracks the user's setting
            ScoreTile("Frozen")
                .dynamicTypeSize(.medium)              // pinned, ignores the setting
        }
        .dynamicTypeSize(size)                         // simulates the user's setting
        """) { AnyView(C07_DynamicTypeFixedExample()) },

        ChildExampleEntry(parent: ".dynamicTypeSize()", child: ".dynamicTypeSize(_: some RangeExpression)", code: """
        VStack {
            Text("Clamped to small…xxLarge")
                .dynamicTypeSize(DynamicTypeSize.small ... .xxLarge)
            Text("Capped at accessibility1")
                .dynamicTypeSize(...DynamicTypeSize.accessibility1)
            Text("Unclamped")
        }
        .dynamicTypeSize(size)                         // simulates the user's setting
        """) { AnyView(C07_DynamicTypeRangeExample()) },

        // MARK: .findNavigator()

        ChildExampleEntry(parent: ".findNavigator()", child: ".findDisabled()", code: """
        TextEditor(text: $notes)
            .findDisabled(isReadOnlyLocked)            // blocks ⌘F entirely
            .findNavigator(isPresented: $showFind)     // iOS presents the bar
        """) { AnyView(C07_FindDisabledExample()) },

        ChildExampleEntry(parent: ".findNavigator()", child: ".replaceDisabled()", code: """
        TextEditor(text: $contract)
            .replaceDisabled(true)                     // search yes, replace no
            .findNavigator(isPresented: $showFind)     // iOS presents the bar
        """) { AnyView(C07_ReplaceDisabledExample()) },

        // MARK: .italic()

        ChildExampleEntry(parent: ".italic()", child: "Text.italic()", code: """
        Text("Note: ").bold() + Text("draft saved locally").italic()
        Text("Source: ") + Text(citation).italic()
        """) { AnyView(C07_TextItalicExample()) },

        ChildExampleEntry(parent: ".italic()", child: ".italic(_:)", code: """
        Text(message.body)
            .italic(message.isSystemGenerated)
        Toggle("System-generated", isOn: $isSystemGenerated)
        """) { AnyView(C07_ItalicBoolExample()) },

        // MARK: .monospaced()

        ChildExampleEntry(parent: ".monospaced()", child: "Font.monospaced()", code: """
        HStack {
            Text(commit.hash.prefix(7))
                .font(.footnote.monospaced())          // fixed pitch, same size
            Text(commit.message)
                .font(.footnote)
        }
        """) { AnyView(C07_FontMonospacedExample()) },

        ChildExampleEntry(parent: ".monospaced()", child: ".monospaced(_:)", code: """
        Text(payload)
            .monospaced(showsRawJSON)                  // Bool follows state
            .textSelection(.enabled)
        Toggle("Raw JSON", isOn: $showsRawJSON)
        """) { AnyView(C07_MonospacedBoolExample()) },

        // MARK: .onKeyPress()

        ChildExampleEntry(parent: ".onKeyPress()", child: ".onKeyPress(keys:action:)", code: """
        rows
            .focusable()
            .onKeyPress(keys: [.upArrow, .downArrow]) { press in   // only these keys
                move(press.key == .upArrow ? -1 : 1)
                return .handled
            }
        """) { AnyView(C07_OnKeyPressKeysExample()) },

        ChildExampleEntry(parent: ".onKeyPress()", child: ".onKeyPress(phases:action:)", code: """
        viewport
            .focusable()
            .onKeyPress(phases: [.down, .repeat]) { press in       // fires while held
                nudge(by: press.key, phase: press.phase)
                return .handled
            }
        """) { AnyView(C07_OnKeyPressPhasesExample()) },

        // MARK: .strikethrough()

        ChildExampleEntry(parent: ".strikethrough()", child: ".strikethrough(_:color:)", code: """
        Toggle(isOn: $task.isDone) {
            Text(task.title)
                .strikethrough(task.isDone, color: .secondary)   // solid line, Bool-driven
        }
        """) { AnyView(C07_StrikethroughColorExample()) },

        ChildExampleEntry(parent: ".strikethrough()", child: ".strikethrough(_:pattern:color:)", code: """
        Text("Was $80")
            .strikethrough(pattern: .dashDot, color: .red)
        Text("Was $80")
            .strikethrough(pattern: .dot, color: .red)
        """) { AnyView(C07_StrikethroughPatternExample()) },

        // MARK: .typesettingLanguage()

        ChildExampleEntry(parent: ".typesettingLanguage()", child: ".typesettingLanguage(_: Locale.Language, isEnabled:)", code: """
        Text(verbatim: "骨海直")
            .typesettingLanguage(Locale.Language(identifier: "zh-Hans"))
        Text(verbatim: "骨海直")
            .typesettingLanguage(Locale.Language(identifier: "ja"))   // Japanese glyph forms
        """) { AnyView(C07_TypesettingLocaleLanguageExample()) },

        ChildExampleEntry(parent: ".typesettingLanguage()", child: ".typesettingLanguage(_: Locale.LanguageCode, isEnabled:)", code: """
        // Built from a bare language code; isEnabled falls back to automatic when false
        Text(verbatim: "骨海直")
            .typesettingLanguage(.explicit(Locale.Language(languageCode: .japanese)),
                                 isEnabled: useJapaneseForms)
        Toggle("Japanese forms", isOn: $useJapaneseForms)
        """) { AnyView(C07_TypesettingLanguageCodeExample()) },

        // MARK: .underline()

        ChildExampleEntry(parent: ".underline()", child: ".underline(_:color:)", code: """
        Text("Learn more")
            .underline(isHovering, color: .accentColor)   // solid line, Bool-driven
            .onHover { isHovering = $0 }
        """) { AnyView(C07_UnderlineColorExample()) },

        ChildExampleEntry(parent: ".underline()", child: ".underline(_:pattern:color:)", code: """
        Text("recieve")
            .underline(pattern: .dot, color: .red)        // spell-check style
        Text("pending review")
            .underline(pattern: .dash, color: .orange)    // tentative state
        """) { AnyView(C07_UnderlinePatternExample()) },

        // MARK: AttributeContainer

        ChildExampleEntry(parent: "AttributeContainer", child: "AttributeContainer()", code: """
        var warning = AttributeContainer()                 // starts empty
        warning.foregroundColor = .red
        warning.font = .callout.weight(.semibold)

        var text = AttributedString("Battery at 4% — plug in soon")
        if let range = text.range(of: "4%") { text[range].mergeAttributes(warning) }
        Text(text)
        """) { AnyView(C07_AttributeContainerInitExample()) },

        ChildExampleEntry(parent: "AttributeContainer", child: "merging(_:mergePolicy:)", code: """
        var theme = AttributeContainer();  theme.font = .body
        var accent = AttributeContainer(); accent.font = .title; accent.foregroundColor = .indigo

        // keepCurrent keeps theme's .body font but still gains .indigo
        let kept = theme.merging(accent, mergePolicy: .keepCurrent)
        let replaced = theme.merging(accent, mergePolicy: .keepNew)      // accent's .title wins
        Text(AttributedString("keepCurrent", attributes: kept))
        Text(AttributedString("keepNew", attributes: replaced))
        """) { AnyView(C07_AttributeContainerMergingExample()) },

        ChildExampleEntry(parent: "AttributeContainer", child: "subscript(_: K.Type)", code: """
        var attrs = AttributeContainer()
        attrs[AttributeScopes.SwiftUIAttributes.ForegroundColorAttribute.self] = .mint   // write by key type
        let color = attrs[AttributeScopes.SwiftUIAttributes.ForegroundColorAttribute.self] // read back: Color?
        Text(AttributedString("Minty fresh", attributes: attrs))
        Circle().fill(color ?? .gray)
        """) { AnyView(C07_AttributeContainerSubscriptExample()) },

        // MARK: AttributedString

        ChildExampleEntry(parent: "AttributedString", child: "AttributedString(localized:table:bundle:locale:comment:)", code: """
        let banner = AttributedString(
            localized: "You have **\\(unread)** unread messages",   // catalog key + Markdown
            comment: "Inbox header count"
        )
        Text(banner)
        """) { AnyView(C07_AttributedStringLocalizedExample()) },

        ChildExampleEntry(parent: "AttributedString", child: "AttributedString(markdown:options:baseURL:)", code: """
        let note = try AttributedString(
            markdown: "Shipped **today** — [track it](https://example.com/t/42)",
            options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace)
        )
        Text(note)
        """) { AnyView(C07_AttributedStringMarkdownExample()) },

        ChildExampleEntry(parent: "AttributedString", child: "runs", code: """
        ForEach(Array(text.runs.enumerated()), id: \\.offset) { _, run in
            Text(String(text[run.range].characters))            // one uniform stretch
                .foregroundStyle(run.link != nil ? .blue : .primary)
        }
        let fontRuns = text.runs[\\.font].count                  // project onto one attribute
        """) { AnyView(C07_AttributedStringRunsExample()) },

        ChildExampleEntry(parent: "AttributedString", child: "mergeAttributes(_:mergePolicy:)", code: """
        var highlight = AttributeContainer()
        highlight.backgroundColor = .yellow
        highlight.foregroundColor = .black

        var text = AttributedString("Meet at 10:30 in Room B")
        text.foregroundColor = .indigo
        text[timeRange].mergeAttributes(highlight)                             // incoming wins → black
        text[roomRange].mergeAttributes(highlight, mergePolicy: .keepCurrent)  // indigo stays, gains yellow
        """) { AnyView(C07_AttributedStringMergeAttributesExample()) },

        // MARK: AttributedTextFormattingDefinition

        ChildExampleEntry(parent: "AttributedTextFormattingDefinition", child: "Scope", code: """
        struct NoteRules: AttributedTextFormattingDefinition {
            struct Scope: AttributeScope {                       // exactly what the editor may keep
                let foregroundColor: AttributeScopes.SwiftUIAttributes.ForegroundColorAttribute
                let backgroundColor: AttributeScopes.SwiftUIAttributes.BackgroundColorAttribute
                let highlight: HighlightAttribute                // your own AttributedStringKey
            }
            var body: some AttributedTextFormattingDefinition<Scope> { … }
        }
        TextEditor(text: $note, selection: $selection)
            .attributedTextFormattingDefinition(NoteRules())
        """) { AnyView(C07_FormattingScopeExample()) },

        ChildExampleEntry(parent: "AttributedTextFormattingDefinition", child: "body", code: """
        var body: some AttributedTextFormattingDefinition<Scope> {
            HighlightsAreYellow()          // constraints, composed like views
            NoColorOutsideHighlights()
        }
        """) { AnyView(C07_FormattingBodyExample()) },

        ChildExampleEntry(parent: "AttributedTextFormattingDefinition", child: "AttributedTextValueConstraint.constrain(_:)", code: """
        struct HighlightsAreYellow: AttributedTextValueConstraint {
            typealias Scope = NoteRules.Scope
            typealias AttributeKey = AttributeScopes.SwiftUIAttributes.BackgroundColorAttribute

            func constrain(_ container: inout Attributes) {      // re-run on every edit
                container.backgroundColor = container.highlight != nil ? .yellow : nil
            }
        }
        """) { AnyView(C07_FormattingConstrainExample()) },

        // MARK: AttributedTextSelection

        ChildExampleEntry(parent: "AttributedTextSelection", child: "indices(in:)", code: """
        switch selection.indices(in: note) {
        case .insertionPoint(let index):
            status = "Caret at \\(note.characters.distance(from: note.startIndex, to: index))"
        case .ranges(let set):
            status = "\\(set.ranges.count) range(s) selected"
        }
        """) { AnyView(C07_SelectionIndicesInExample()) },

        ChildExampleEntry(parent: "AttributedTextSelection", child: "Indices", code: """
        var hasHighlight: Bool {
            if case .ranges(let set) = selection.indices(in: note) {   // Indices.ranges
                return !set.isEmpty
            }
            return false                                             // Indices.insertionPoint
        }
        Button("Copy Selection") { … }.disabled(!hasHighlight)
        """) { AnyView(C07_SelectionIndicesEnumExample()) },

        ChildExampleEntry(parent: "AttributedTextSelection", child: "AttributedString.transformAttributes(in:_:)", code: """
        Button("Bold") {
            note.transformAttributes(in: &selection) { attrs in   // selection stays valid
                attrs.font = .body.bold()
            }
        }
        """) { AnyView(C07_TransformAttributesExample()) },

        // MARK: Font

        ChildExampleEntry(parent: "Font", child: "Font.system()", code: """
        Text("Score")
            .font(.system(.title, design: .rounded, weight: .bold))   // text style → scales
        Text("Fixed size")
            .font(.system(size: 17, weight: .semibold))              // point size → fixed
        Text("Serif body")
            .font(.system(.body, design: .serif))
        """) { AnyView(C07_FontSystemExample()) },

        ChildExampleEntry(parent: "Font", child: "Font.custom()", code: """
        Text("Brand headline")
            .font(.custom("AmericanTypewriter", size: 24))                    // scales like .body
        Text("Relative to headline")
            .font(.custom("AmericanTypewriter", size: 20, relativeTo: .headline))
        Text("Never scales")
            .font(.custom("AmericanTypewriter", fixedSize: 24))
        """) { AnyView(C07_FontCustomExample()) },

        ChildExampleEntry(parent: "Font", child: "Font.largeTitle", code: """
        Text("Today").font(.largeTitle)
        Text("Section").font(.headline)
        Text("Body copy").font(.body)
        Text("Fine print").font(.footnote)
        """) { AnyView(C07_FontLargeTitleExample()) },

        // MARK: KeyEquivalent

        ChildExampleEntry(parent: "KeyEquivalent", child: "KeyEquivalent(_:)", code: """
        let key = KeyEquivalent(quickAddKey.first ?? "a")   // from data, not a literal
        Button("Quick Add") { added += 1 }
            .keyboardShortcut(key, modifiers: [.command, .option])
        """) { AnyView(C07_KeyEquivalentInitExample()) },

        ChildExampleEntry(parent: "KeyEquivalent", child: "KeyEquivalent.upArrow", code: """
        board
            .focusable()
            .onKeyPress(.upArrow) { moveSelection(-1); return .handled }
            .onKeyPress(.downArrow) { moveSelection(1); return .handled }
        """) { AnyView(C07_KeyEquivalentUpArrowExample()) },

        ChildExampleEntry(parent: "KeyEquivalent", child: "character", code: """
        let shortcut: KeyEquivalent = "n"
        Text("Press ⌘\\(shortcut.character.uppercased())")   // Character → display
        """) { AnyView(C07_KeyEquivalentCharacterExample()) },

        // MARK: KeyPress

        ChildExampleEntry(parent: "KeyPress", child: "KeyPress.Phases", code: """
        viewport
            .focusable()
            .onKeyPress(phases: [.down, .up]) { press in   // no .repeat → no autorepeat noise
                isPanning = press.phase == .down            // true while held
                return .handled
            }
        """) { AnyView(C07_KeyPressPhasesExample()) },

        ChildExampleEntry(parent: "KeyPress", child: "KeyPress.Result", code: """
        card
            .onKeyPress { press in
                guard press.characters == "j" else { return .ignored }   // travels to ancestors
                showNext()
                return .handled                                         // consumed here
            }
        """) { AnyView(C07_KeyPressResultExample()) },

        ChildExampleEntry(parent: "KeyPress", child: "key", code: """
        .onKeyPress(phases: .down) { press in
            if press.key == .escape { cancelEditing(); return .handled }   // layout-independent
            return .ignored
        }
        """) { AnyView(C07_KeyPressKeyExample()) },

        ChildExampleEntry(parent: "KeyPress", child: "characters", code: """
        .onKeyPress(characters: .decimalDigits) { press in
            enterDigit(press.characters)          // the text this press produced
            return .handled
        }
        """) { AnyView(C07_KeyPressCharactersExample()) },

        // MARK: LocalizedStringKey

        ChildExampleEntry(parent: "LocalizedStringKey", child: "LocalizedStringKey(_:)", code: """
        let titleKey = LocalizedStringKey(section.titleKey)   // e.g. "settings.privacy"
        Text(titleKey)                    // catalog lookup
        Text(verbatim: section.titleKey)  // a String is shown as-is, no lookup
        """) { AnyView(C07_LocalizedStringKeyInitExample()) },

        ChildExampleEntry(parent: "LocalizedStringKey", child: "StringInterpolation.appendInterpolation(_:specifier:)", code: """
        Text("Pace: \\(pace, specifier: "%.1f") min/km")     // printf-style, still one key
        Text("Lap \\(lapIndex + 1, specifier: "%02d")")
        """) { AnyView(C07_InterpolationSpecifierExample()) },

        ChildExampleEntry(parent: "LocalizedStringKey", child: "StringInterpolation.appendInterpolation(_:format:)", code: """
        Text("Total \\(total, format: .currency(code: "EUR"))")
        Text("Synced \\(lastSync, format: .relative(presentation: .named))")
        Text("Progress \\(progress, format: .percent.precision(.fractionLength(0)))")
        """) { AnyView(C07_InterpolationFormatExample()) },

        ChildExampleEntry(parent: "LocalizedStringKey", child: "StringInterpolation.appendInterpolation(_: Image)", code: """
        Text("Tap \\(Image(systemName: "plus.circle")) to add a stop")
        Text("Swipe \\(Image(systemName: "arrow.left")) to archive")
            .foregroundStyle(.secondary)
        """) { AnyView(C07_InterpolationImageExample()) },

        // MARK: LocalizedStringResource

        ChildExampleEntry(parent: "LocalizedStringResource", child: "LocalizedStringResource(_:table:locale:bundle:comment:)", code: """
        static let emptyState = LocalizedStringResource(
            "library.empty",                              // key doubles as the default value
            table: "Library",
            comment: "Shown when the user has no documents"
        )
        Text(emptyState)
        """) { AnyView(C07_ResourceKeyValueExample()) },

        ChildExampleEntry(parent: "LocalizedStringResource", child: "LocalizedStringResource(_:defaultValue:table:locale:bundle:comment:)", code: """
        let cta = LocalizedStringResource(
            "onboarding.cta",                 // stable identifier key
            defaultValue: "Get started"       // English fallback shown when no catalog entry exists
        )
        Text(cta)
        """) { AnyView(C07_ResourceDefaultValueExample()) },

        ChildExampleEntry(parent: "LocalizedStringResource", child: "BundleDescription", code: """
        let offline = LocalizedStringResource("error.offline", bundle: .main)
        let framework = LocalizedStringResource("error.offline", bundle: .forClass(NetworkKitMarker.self))
        let plugin = LocalizedStringResource("error.offline", bundle: .atURL(pluginBundleURL))
        """) { AnyView(C07_ResourceBundleDescriptionExample()) },

        ChildExampleEntry(parent: "LocalizedStringResource", child: "locale", code: """
        var total = LocalizedStringResource("Total \\(1234.5, format: .currency(code: "EUR"))")
        total.locale = Locale(identifier: "de_DE")       // re-target resolution
        let german = String(localized: total)
        """) { AnyView(C07_ResourceLocaleExample()) },

        // MARK: RedactionReasons

        ChildExampleEntry(parent: "RedactionReasons", child: ".placeholder", code: """
        ArticleCard(article: .sample)
            .redacted(reason: isLoading ? .placeholder : [])   // text/images → neutral shapes
        """) { AnyView(C07_RedactionPlaceholderExample()) },

        ChildExampleEntry(parent: "RedactionReasons", child: ".privacy", code: """
        @Environment(\\.redactionReasons) private var reasons

        var body: some View {
            Text(reasons.contains(.privacy) ? "••••" : account.last4)
                .privacySensitive()               // only these views respond to .privacy
        }
        """) { AnyView(C07_RedactionPrivacyExample()) },

        ChildExampleEntry(parent: "RedactionReasons", child: ".invalidated", code: """
        @Environment(\\.redactionReasons) private var reasons

        var body: some View {
            Text("\\(completed) done")
                .invalidatableContent()
                .opacity(reasons.contains(.invalidated) ? 0.5 : 1)
        }
        """) { AnyView(C07_RedactionInvalidatedExample()) },

        // MARK: Text.DateStyle

        ChildExampleEntry(parent: "Text.DateStyle", child: ".timer", code: """
        Text(quizEnds, style: .timer)    // counts down to the date, then up from it
            .monospacedDigit()
        """) { AnyView(C07_DateStyleTimerExample()) },

        ChildExampleEntry(parent: "Text.DateStyle", child: ".relative", code: """
        Text(message.sentAt, style: .relative)   // "2 minutes" — unsigned, ticks as time passes
            .font(.caption)
            .foregroundStyle(.secondary)
        """) { AnyView(C07_DateStyleRelativeExample()) },

        ChildExampleEntry(parent: "Text.DateStyle", child: ".offset", code: """
        Text(train.departure, style: .offset)    // "+12 minutes" ahead, "-3 minutes" behind
            .monospacedDigit()
        """) { AnyView(C07_DateStyleOffsetExample()) },

        ChildExampleEntry(parent: "Text.DateStyle", child: ".date", code: """
        HStack {
            Text(event.start, style: .date)      // calendar date only, formatted once
            Text(event.start, style: .time)      // the clock portion
        }
        """) { AnyView(C07_DateStyleDateExample()) },

        // MARK: Text.Layout

        ChildExampleEntry(parent: "Text.Layout", child: "Text.Layout.Line", code: """
        struct RevealLines: TextRenderer {
            var revealedLines: Int
            func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
                for (index, line) in layout.enumerated() {          // one typeset line each
                    var lineCtx = ctx
                    lineCtx.opacity = index < revealedLines ? 1 : 0.15
                    for run in line { lineCtx.draw(run) }
                }
            }
        }
        Text(paragraph).textRenderer(RevealLines(revealedLines: revealed))
        """) { AnyView(C07_TextLayoutLineExample()) },

        ChildExampleEntry(parent: "Text.Layout", child: "Text.Layout.Run", code: """
        for line in layout {
            for run in line {                                   // one attribute set per run
                let box = run.typographicBounds.rect
                ctx.fill(Path(box), with: .color(.yellow.opacity(0.3)))
                ctx.draw(run)
            }
        }
        """) { AnyView(C07_TextLayoutRunExample()) },

        ChildExampleEntry(parent: "Text.Layout", child: "Text.Layout.RunSlice", code: """
        for run in line {
            for (i, slice) in run.enumerated() {                // per-glyph slices
                var g = ctx
                g.translateBy(x: 0, y: sin(phase + Double(i) * 0.4) * 6)
                g.draw(slice)
            }
        }
        """) { AnyView(C07_TextLayoutRunSliceExample()) },

        ChildExampleEntry(parent: "Text.Layout", child: "Text.Layout.Run.subscript(_:)", code: """
        struct Sparkle: TextAttribute { }

        for run in line {
            guard run[Sparkle.self] != nil else { ctx.draw(run); continue }   // nil where never applied
            var glow = ctx
            glow.addFilter(.shadow(color: .yellow, radius: 6))
            glow.draw(run)
        }
        Text("Plain ") + Text("magic").customAttribute(Sparkle()) + Text(" plain")
        """) { AnyView(C07_TextLayoutRunSubscriptExample()) },

        // MARK: Text.LineStyle

        ChildExampleEntry(parent: "Text.LineStyle", child: "Text.LineStyle(pattern:color:)", code: """
        var text = AttributedString("obsolete API")
        text.strikethroughStyle = Text.LineStyle(pattern: .dash, color: .red)   // attributed decoration
        var note = AttributedString("needs review")
        note.underlineStyle = Text.LineStyle(pattern: .dot, color: .orange)
        Text(text)
        Text(note)
        """) { AnyView(C07_LineStyleInitExample()) },

        ChildExampleEntry(parent: "Text.LineStyle", child: "Text.LineStyle.Pattern", code: """
        Text("Tentative").underline(pattern: .solid)
        Text("Tentative").underline(pattern: .dot)
        Text("Tentative").underline(pattern: .dash)
        Text("Tentative").underline(pattern: .dashDot)
        Text("Tentative").underline(pattern: .dashDotDot)   // same vocabulary for strikethrough
        """) { AnyView(C07_LineStylePatternExample()) },

        ChildExampleEntry(parent: "Text.LineStyle", child: "Text.LineStyle.single", code: """
        var link = AttributedString("Read the docs")
        link.underlineStyle = .single                       // stock solid line, inherits the run's color
        link.link = URL(string: "https://developer.apple.com")
        Text(link)
        """) { AnyView(C07_LineStyleSingleExample()) },

        // MARK: TextSelection

        ChildExampleEntry(parent: "TextSelection", child: "TextSelection(range:)", code: """
        TextEditor(text: $text, selection: $selection)
        TextField("Find", text: $query)
        Button("Select Match") {
            if let found = text.range(of: query) {
                selection = TextSelection(range: found)     // one contiguous range
            }
        }
        """) { AnyView(C07_TextSelectionRangeExample()) },

        ChildExampleEntry(parent: "TextSelection", child: "TextSelection(insertionPoint:)", code: """
        TextEditor(text: $text, selection: $selection)
        Button("Append #tag") {
            text.append(" #tag")
            selection = TextSelection(insertionPoint: text.endIndex)   // caret parked after the insert
        }
        """) { AnyView(C07_TextSelectionInsertionPointExample()) },

        ChildExampleEntry(parent: "TextSelection", child: "indices", code: """
        switch selection?.indices {
        case .selection(let range):
            copied = String(text[range])
        case .multiSelection(let set):
            copied = set.ranges.map { String(text[$0]) }.joined(separator: "\\n")
        case nil:
            copied = ""
        @unknown default:
            copied = ""
        }
        """) { AnyView(C07_TextSelectionIndicesExample()) },

        ChildExampleEntry(parent: "TextSelection", child: "isInsertion", code: """
        TextEditor(text: $text, selection: $selection)
        Button("Uppercase") { uppercaseSelection() }
            .disabled(selection?.isInsertion ?? true)      // caret only → disabled
        """) { AnyView(C07_TextSelectionIsInsertionExample()) },

        // C07_END_ENTRIES
    ]
}

// MARK: - .bold()

private struct C07_TextBoldExample: View {
    private let dueDate = Date(timeIntervalSinceReferenceDate: 800_000_000)
    private let total = 1_249.5

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Due: ") + Text(dueDate, style: .date).bold()
            Text("Total: ") + Text(total, format: .currency(code: "USD")).bold()
            Text("Text.bold() returns Text, so it can sit inside a + concatenation.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C07_BoldBoolExample: View {
    @State private var unreadCount = 2

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Inbox", systemImage: "tray")
                .font(.title3)
                .bold(unreadCount > 0)
            Stepper("Unread: \(unreadCount)", value: $unreadCount, in: 0...9)
                .frame(maxWidth: 220)
            Text(unreadCount > 0 ? "bold(true): text and symbol thicken" : "bold(false): regular weight")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

// MARK: - .dynamicTypeSize()

private struct C07_DynamicTypeFixedExample: View {
    @State private var size: DynamicTypeSize = .xxLarge

    private struct ScoreTile: View {
        let title: String
        var body: some View {
            VStack(spacing: 2) {
                Text("72%").font(.headline)
                Text(title).font(.caption)
            }
            .padding(8)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
        }
    }

    var body: some View {
        VStack(spacing: 12) {
            Picker("Simulated setting", selection: $size) {
                Text("small").tag(DynamicTypeSize.small)
                Text("large").tag(DynamicTypeSize.large)
                Text("xxLarge").tag(DynamicTypeSize.xxLarge)
                Text("xxxLarge").tag(DynamicTypeSize.xxxLarge)
            }
            .pickerStyle(.segmented)
            .frame(maxWidth: 320)
            HStack(spacing: 16) {
                ScoreTile(title: "Follows")
                ScoreTile(title: "Frozen")
                    .dynamicTypeSize(.medium)
            }
            .dynamicTypeSize(size)
        }
        .padding()
    }
}

private struct C07_DynamicTypeRangeExample: View {
    @State private var index = 6.0   // xxxLarge

    private var size: DynamicTypeSize {
        let all = DynamicTypeSize.allCases
        return all[min(max(Int(index), 0), all.count - 1)]
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Slider(value: $index, in: 0...8, step: 1)
                    .frame(maxWidth: 200)
                Text("\(String(describing: size))")
                    .font(.caption.monospaced())
                    .foregroundStyle(.secondary)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text("Clamped to small…xxLarge")
                    .dynamicTypeSize(DynamicTypeSize.small ... .xxLarge)
                Text("Capped at accessibility1")
                    .dynamicTypeSize(...DynamicTypeSize.accessibility1)
                Text("Unclamped")
            }
            .font(.footnote)
            .dynamicTypeSize(size)
        }
        .padding()
    }
}

// MARK: - .findNavigator()

private struct C07_FindDisabledExample: View {
    @State private var notes = "Meeting notes\n– ship the beta\n– update release notes"
    @State private var isReadOnlyLocked = true

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Toggle("Read-only lock", isOn: $isReadOnlyLocked)
            TextEditor(text: $notes)
                .font(.body)
                .frame(height: 90)
                .findDisabled(isReadOnlyLocked)
            Text(isReadOnlyLocked ? "⌘F is blocked for this editor" : "⌘F opens find as usual")
                .font(.caption)
                .foregroundStyle(.secondary)
            Text("findNavigator(isPresented:) is iOS-only; on macOS use Edit ▸ Find.")
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .padding()
    }
}

private struct C07_ReplaceDisabledExample: View {
    @State private var contract = "This agreement is binding.\nSigned copies are final."

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextEditor(text: $contract)
                .font(.body)
                .frame(height: 90)
                .replaceDisabled(true)
            Text("Find (⌘F) works; the replace field is removed.")
                .font(.caption)
                .foregroundStyle(.secondary)
            Text("findNavigator(isPresented:) is iOS-only; on macOS use Edit ▸ Find.")
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .padding()
    }
}

// MARK: - .italic()

private struct C07_TextItalicExample: View {
    private let citation = "Knuth, The Art of Computer Programming"

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Note: ").bold() + Text("draft saved locally").italic()
            Text("Source: ") + Text(citation).italic()
            Text("Text.italic() slants only its own segment of the concatenation.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C07_ItalicBoolExample: View {
    @State private var isSystemGenerated = true

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: isSystemGenerated ? "gearshape" : "person")
                    .foregroundStyle(.secondary)
                Text("Maya joined the conversation")
                    .italic(isSystemGenerated)
            }
            Toggle("System-generated", isOn: $isSystemGenerated)
                .frame(maxWidth: 220)
        }
        .padding()
    }
}

// MARK: - .monospaced()

private struct C07_FontMonospacedExample: View {
    private let commits = [
        ("3f9a2c1d", "Fix layout regression"),
        ("b17e0f44", "Bump PDF.js"),
        ("0cd9e6a7", "Add billing UI"),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ForEach(commits, id: \.0) { commit in
                HStack(spacing: 12) {
                    Text(commit.0.prefix(7))
                        .font(.footnote.monospaced())
                        .foregroundStyle(.secondary)
                    Text(commit.1)
                        .font(.footnote)
                }
            }
            Text("Hashes line up because .footnote.monospaced() keeps the footnote size.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C07_MonospacedBoolExample: View {
    @State private var showsRawJSON = true
    private let payload = "{ \"id\": 42, \"status\": \"paid\" }"

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(payload)
                .monospaced(showsRawJSON)
                .textSelection(.enabled)
                .padding(8)
                .background(.quaternary, in: RoundedRectangle(cornerRadius: 6))
            Toggle("Raw JSON", isOn: $showsRawJSON)
                .frame(maxWidth: 220)
        }
        .padding()
    }
}

// MARK: - .onKeyPress()

private struct C07_OnKeyPressKeysExample: View {
    private let rows = ["Inbox", "Drafts", "Sent", "Archive"]
    @State private var selected = 1
    @State private var lastKey = "—"

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(spacing: 2) {
                ForEach(rows.indices, id: \.self) { i in
                    Text(rows[i])
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(i == selected ? Color.accentColor.opacity(0.25) : .clear,
                                    in: RoundedRectangle(cornerRadius: 4))
                }
            }
            .frame(width: 200)
            .padding(4)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
            .focusable()
            .onKeyPress(keys: [.upArrow, .downArrow]) { press in
                let delta = press.key == .upArrow ? -1 : 1
                selected = min(max(selected + delta, 0), rows.count - 1)
                lastKey = press.key == .upArrow ? "↑" : "↓"
                return .handled
            }
            Text("Click to focus, then press ↑ / ↓ — last: \(lastKey). Other keys pass through.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C07_OnKeyPressPhasesExample: View {
    @State private var x: CGFloat = 0
    @State private var downCount = 0
    @State private var repeatCount = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 8).fill(.quaternary)
                Circle()
                    .fill(.teal)
                    .frame(width: 20, height: 20)
                    .offset(x: x)
            }
            .frame(width: 240, height: 60)
            .focusable()
            .onKeyPress(phases: [.down, .repeat]) { press in
                if press.phase == .down { downCount += 1 } else { repeatCount += 1 }
                if press.key == .leftArrow { x = max(x - 8, -100) }
                if press.key == .rightArrow { x = min(x + 8, 100) }
                return .handled
            }
            Text("Click to focus, hold ← / → — down: \(downCount), repeat: \(repeatCount)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

// MARK: - .strikethrough()

private struct C07_StrikethroughColorExample: View {
    @State private var doneA = true
    @State private var doneB = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Toggle(isOn: $doneA) {
                Text("Renew domain").strikethrough(doneA, color: .secondary)
            }
            Toggle(isOn: $doneB) {
                Text("Rotate API keys").strikethrough(doneB, color: .secondary)
            }
        }
        .toggleStyle(.checkbox)
        .padding()
    }
}

private struct C07_StrikethroughPatternExample: View {
    var body: some View {
        HStack(spacing: 24) {
            VStack(alignment: .leading) {
                Text("Was $80").strikethrough(pattern: .dashDot, color: .red)
                Text(".dashDot").font(.caption2).foregroundStyle(.secondary)
            }
            VStack(alignment: .leading) {
                Text("Was $80").strikethrough(pattern: .dot, color: .red)
                Text(".dot").font(.caption2).foregroundStyle(.secondary)
            }
            VStack(alignment: .leading) {
                Text("Was $80").strikethrough(pattern: .dash, color: .red)
                Text(".dash").font(.caption2).foregroundStyle(.secondary)
            }
            Text("$64").bold()
        }
        .padding()
    }
}

// MARK: - .typesettingLanguage()

private struct C07_TypesettingLocaleLanguageExample: View {
    var body: some View {
        HStack(spacing: 32) {
            VStack {
                Text(verbatim: "骨海直")
                    .font(.largeTitle)
                    .typesettingLanguage(Locale.Language(identifier: "zh-Hans"))
                Text("zh-Hans").font(.caption).foregroundStyle(.secondary)
            }
            VStack {
                Text(verbatim: "骨海直")
                    .font(.largeTitle)
                    .typesettingLanguage(Locale.Language(identifier: "ja"))
                Text("ja").font(.caption).foregroundStyle(.secondary)
            }
        }
        .padding()
    }
}

private struct C07_TypesettingLanguageCodeExample: View {
    @State private var useJapaneseForms = true

    var body: some View {
        VStack(spacing: 12) {
            Text(verbatim: "骨海直")
                .font(.largeTitle)
                .typesettingLanguage(.explicit(Locale.Language(languageCode: .japanese)),
                                     isEnabled: useJapaneseForms)
            Toggle("Japanese forms", isOn: $useJapaneseForms)
                .frame(maxWidth: 200)
            Text(useJapaneseForms ? "isEnabled: true — Japanese shaping" : "isEnabled: false — automatic")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

// MARK: - .underline()

private struct C07_UnderlineColorExample: View {
    @State private var isHovering = false

    var body: some View {
        VStack(spacing: 8) {
            Text("Learn more")
                .foregroundStyle(Color.accentColor)
                .underline(isHovering, color: .accentColor)
                .onHover { isHovering = $0 }
            Text(isHovering ? "underline(true)" : "Hover to underline")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C07_UnderlinePatternExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Please ") + Text("recieve").underline(pattern: .dot, color: .red) + Text(" the parcel")
            Text("pending review").underline(pattern: .dash, color: .orange)
            Text("solid default").underline()
        }
        .padding()
    }
}

// MARK: - AttributeContainer

private struct C07_AttributeContainerInitExample: View {
    private var text: AttributedString {
        var warning = AttributeContainer()
        warning.foregroundColor = .red
        warning.font = .callout.weight(.semibold)

        var text = AttributedString("Battery at 4% — plug in soon")
        if let range = text.range(of: "4%") { text[range].mergeAttributes(warning) }
        return text
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(text)
            Text("An empty container filled via typed properties, merged onto one range.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C07_AttributeContainerMergingExample: View {
    var body: some View {
        var theme = AttributeContainer()
        theme.font = .body
        var accent = AttributeContainer()
        accent.font = .title
        accent.foregroundColor = .indigo

        let kept = theme.merging(accent, mergePolicy: .keepCurrent)
        let replaced = theme.merging(accent, mergePolicy: .keepNew)

        return VStack(alignment: .leading, spacing: 8) {
            Text(AttributedString("keepCurrent — .body stays, gains .indigo", attributes: kept))
            Text(AttributedString("keepNew — .title wins", attributes: replaced))
        }
        .padding()
    }
}

private struct C07_AttributeContainerSubscriptExample: View {
    var body: some View {
        var attrs = AttributeContainer()
        attrs[AttributeScopes.SwiftUIAttributes.ForegroundColorAttribute.self] = .mint
        attrs[AttributeScopes.SwiftUIAttributes.FontAttribute.self] = .title3.bold()
        let color = attrs[AttributeScopes.SwiftUIAttributes.ForegroundColorAttribute.self]

        return HStack(spacing: 12) {
            Text(AttributedString("Minty fresh", attributes: attrs))
            Circle()
                .fill(color ?? .gray)
                .frame(width: 18, height: 18)
            Text("read back via the same key type")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

// MARK: - AttributedString

private struct C07_AttributedStringLocalizedExample: View {
    @State private var unread = 3

    var body: some View {
        let banner = AttributedString(
            localized: "You have **\(unread)** unread messages",
            comment: "Inbox header count"
        )
        return VStack(alignment: .leading, spacing: 10) {
            Text(banner)
            Stepper("Unread: \(unread)", value: $unread, in: 0...99)
                .frame(maxWidth: 220)
            Text("The value is looked up in the string catalog, then parsed as Markdown.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C07_AttributedStringMarkdownExample: View {
    private var note: AttributedString {
        (try? AttributedString(
            markdown: "Shipped **today** — [track it](https://example.com/t/42)",
            options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace)
        )) ?? AttributedString("Shipped today")
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(note)
            Text("inlineOnlyPreservingWhitespace keeps the text a single paragraph; the link is live.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C07_AttributedStringRunsExample: View {
    private var text: AttributedString {
        var text = (try? AttributedString(markdown: "Read the **docs** at [apple.com](https://apple.com) first"))
            ?? AttributedString("Read the docs")
        if let range = text.range(of: "docs") { text[range].font = .body.bold() }
        return text
    }

    var body: some View {
        let text = text
        let runs = Array(text.runs)
        return VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 4) {
                ForEach(runs.indices, id: \.self) { i in
                    Text(String(text[runs[i].range].characters))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 3)
                        .background(runs[i].link != nil ? Color.blue.opacity(0.2) : Color.gray.opacity(0.15),
                                    in: RoundedRectangle(cornerRadius: 4))
                }
            }
            Text("\(runs.count) runs · runs[\\.font] projects \(text.runs[\.font].count) slices · blue = link")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C07_AttributedStringMergeAttributesExample: View {
    private var text: AttributedString {
        var highlight = AttributeContainer()
        highlight.backgroundColor = .yellow
        highlight.foregroundColor = .black

        var text = AttributedString("Meet at 10:30 in Room B")
        text.foregroundColor = .indigo
        if let timeRange = text.range(of: "10:30") {
            text[timeRange].mergeAttributes(highlight)
        }
        if let roomRange = text.range(of: "Room B") {
            text[roomRange].mergeAttributes(highlight, mergePolicy: .keepCurrent)
        }
        return text
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(text).font(.title3)
            Text("10:30 — keepNew (default): black on yellow.  Room B — keepCurrent: indigo kept, yellow added.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

// MARK: - Rich-text formatting (shared by the definition and selection examples)

private struct C07_HighlightAttribute: CodableAttributedStringKey {
    typealias Value = Bool
    static let name = "aviary.c07.highlight"
}

extension AttributeScopes {
    fileprivate struct C07_NoteAttributes: AttributeScope {
        let highlight: C07_HighlightAttribute
    }
}

extension AttributeDynamicLookup {
    fileprivate subscript<T: AttributedStringKey>(dynamicMember keyPath: KeyPath<AttributeScopes.C07_NoteAttributes, T>) -> T {
        self[T.self]
    }
}

private struct C07_NoteRules: AttributedTextFormattingDefinition {
    struct Scope: AttributeScope {
        let foregroundColor: AttributeScopes.SwiftUIAttributes.ForegroundColorAttribute
        let backgroundColor: AttributeScopes.SwiftUIAttributes.BackgroundColorAttribute
        let highlight: C07_HighlightAttribute
    }

    var body: some AttributedTextFormattingDefinition<Scope> {
        C07_HighlightsAreYellow()
        C07_NoColorOutsideHighlights()
    }
}

private struct C07_HighlightsAreYellow: AttributedTextValueConstraint {
    typealias Scope = C07_NoteRules.Scope
    typealias AttributeKey = AttributeScopes.SwiftUIAttributes.BackgroundColorAttribute

    func constrain(_ container: inout Attributes) {
        container.backgroundColor = container.highlight != nil ? .yellow : nil
    }
}

private struct C07_NoColorOutsideHighlights: AttributedTextValueConstraint {
    typealias Scope = C07_NoteRules.Scope
    typealias AttributeKey = AttributeScopes.SwiftUIAttributes.ForegroundColorAttribute

    func constrain(_ container: inout Attributes) {
        container.foregroundColor = container.highlight != nil ? .black : nil
    }
}

private struct C07_NoteEditorDemo: View {
    let caption: String
    @State private var note: AttributedString = {
        var text = AttributedString("Bring the signed contract and two forms of ID.")
        if let range = text.range(of: "signed contract") { text[range].highlight = true }
        return text
    }()
    @State private var selection = AttributedTextSelection()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextEditor(text: $note, selection: $selection)
                .attributedTextFormattingDefinition(C07_NoteRules())
                .frame(height: 60)
            HStack {
                Button("Toggle Highlight") {
                    note.transformAttributes(in: &selection) { attrs in
                        attrs.highlight = attrs.highlight == nil ? true : nil
                    }
                }
                Button("Try Red Text") {
                    note.transformAttributes(in: &selection) { attrs in
                        attrs.foregroundColor = .red
                    }
                }
            }
            .controlSize(.small)
            Text(caption)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C07_FormattingScopeExample: View {
    var body: some View {
        C07_NoteEditorDemo(caption: "Scope lists foregroundColor, backgroundColor and highlight — any other attribute (font, underline) is stripped from typed or pasted text.")
    }
}

private struct C07_FormattingBodyExample: View {
    var body: some View {
        C07_NoteEditorDemo(caption: "body composes two constraints: highlights turn yellow, and red text outside a highlight is reset on the next change.")
    }
}

private struct C07_FormattingConstrainExample: View {
    var body: some View {
        C07_NoteEditorDemo(caption: "constrain(_:) rewrites backgroundColor from the highlight key on every edit — select text and toggle the highlight.")
    }
}

// MARK: - AttributedTextSelection

private struct C07_SelectionIndicesInExample: View {
    @State private var note = AttributedString("Select some of this text, or just click to place the caret.")
    @State private var selection = AttributedTextSelection()

    private var status: String {
        switch selection.indices(in: note) {
        case .insertionPoint(let index):
            return "Caret at \(note.characters.distance(from: note.startIndex, to: index))"
        case .ranges(let set):
            return "\(set.ranges.count) range(s) selected"
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextEditor(text: $note, selection: $selection)
                .frame(height: 60)
            Text(status)
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C07_SelectionIndicesEnumExample: View {
    @State private var note = AttributedString("Highlight a word to enable the button.")
    @State private var selection = AttributedTextSelection()
    @State private var copied = "—"

    private var hasHighlight: Bool {
        if case .ranges(let set) = selection.indices(in: note) {
            return !set.isEmpty
        }
        return false
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextEditor(text: $note, selection: $selection)
                .frame(height: 60)
            HStack {
                Button("Copy Selection") {
                    if case .ranges(let set) = selection.indices(in: note), let range = set.ranges.first {
                        copied = String(note[range].characters)
                    }
                }
                .disabled(!hasHighlight)
                Text(hasHighlight ? ".ranges" : ".insertionPoint")
                    .font(.caption.monospaced())
                    .foregroundStyle(.secondary)
                Text("copied: \(copied)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
    }
}

private struct C07_TransformAttributesExample: View {
    @State private var note = AttributedString("Select a phrase, then press Bold or Italic.")
    @State private var selection = AttributedTextSelection()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextEditor(text: $note, selection: $selection)
                .frame(height: 60)
            HStack {
                Button("Bold") {
                    note.transformAttributes(in: &selection) { attrs in
                        attrs.font = .body.bold()
                    }
                }
                Button("Italic") {
                    note.transformAttributes(in: &selection) { attrs in
                        attrs.font = .body.italic()
                    }
                }
                Button("Clear") {
                    note.transformAttributes(in: &selection) { attrs in
                        attrs.font = nil
                    }
                }
            }
            .controlSize(.small)
        }
        .padding()
    }
}

// MARK: - Font

private struct C07_FontSystemExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Score").font(.system(.title, design: .rounded, weight: .bold))
            Text("Fixed size").font(.system(size: 17, weight: .semibold))
            Text("Serif body").font(.system(.body, design: .serif))
            Text("Monospaced caption").font(.system(.caption, design: .monospaced))
        }
        .padding()
    }
}

private struct C07_FontCustomExample: View {
    @State private var simulateLarge = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Brand headline")
                    .font(.custom("AmericanTypewriter", size: 24))
                Text("Relative to headline")
                    .font(.custom("AmericanTypewriter", size: 20, relativeTo: .headline))
                Text("Never scales")
                    .font(.custom("AmericanTypewriter", fixedSize: 24))
            }
            .dynamicTypeSize(simulateLarge ? .xxxLarge : .large)
            Toggle("Simulate a larger text setting", isOn: $simulateLarge)
                .font(.caption)
        }
        .padding()
    }
}

private struct C07_FontLargeTitleExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Today").font(.largeTitle)
            Text("Section").font(.headline)
            Text("Body copy").font(.body)
            Text("Fine print").font(.footnote)
            Text("All four follow the user's Dynamic Type setting.")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

// MARK: - KeyEquivalent

private struct C07_KeyEquivalentInitExample: View {
    @State private var quickAddKey = "k"
    @State private var added = 0

    var body: some View {
        let key = KeyEquivalent(quickAddKey.first ?? "a")
        return VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Shortcut letter")
                TextField("key", text: $quickAddKey)
                    .frame(width: 40)
                    .onChange(of: quickAddKey) { _, new in quickAddKey = String(new.lowercased().prefix(1)) }
            }
            Button("Quick Add") { added += 1 }
                .keyboardShortcut(key, modifiers: [.command, .option])
            Text("⌥⌘\(quickAddKey.uppercased()) adds — added \(added) time(s)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C07_KeyEquivalentUpArrowExample: View {
    private let rows = ["Queen", "Rook", "Bishop"]
    @State private var selected = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(spacing: 2) {
                ForEach(rows.indices, id: \.self) { i in
                    Text(rows[i])
                        .frame(width: 140, alignment: .leading)
                        .padding(6)
                        .background(i == selected ? Color.accentColor.opacity(0.25) : .clear,
                                    in: RoundedRectangle(cornerRadius: 4))
                }
            }
            .padding(4)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
            .focusable()
            .onKeyPress(.upArrow) { selected = max(selected - 1, 0); return .handled }
            .onKeyPress(.downArrow) { selected = min(selected + 1, rows.count - 1); return .handled }
            Text("Click to focus, then ↑ / ↓")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C07_KeyEquivalentCharacterExample: View {
    private let shortcuts: [(String, KeyEquivalent)] = [("New", "n"), ("Open", "o"), ("Save", "s")]

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ForEach(shortcuts, id: \.0) { item in
                HStack {
                    Text(item.0)
                    Spacer()
                    Text("Press ⌘\(item.1.character.uppercased())")
                        .font(.caption.monospaced())
                        .foregroundStyle(.secondary)
                }
                .frame(width: 180)
            }
        }
        .padding()
    }
}

// MARK: - KeyPress

private struct C07_KeyPressPhasesExample: View {
    @State private var isPanning = false
    @State private var events = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            RoundedRectangle(cornerRadius: 8)
                .fill(isPanning ? Color.orange : Color.gray.opacity(0.3))
                .frame(width: 220, height: 50)
                .overlay(Text(isPanning ? "panning (key down)" : "idle").font(.caption))
                .focusable()
                .onKeyPress(phases: [.down, .up]) { press in
                    isPanning = press.phase == .down
                    events += 1
                    return .handled
                }
            Text("Click to focus, hold any key — \(events) events; .repeat is not subscribed")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C07_KeyPressResultExample: View {
    private let slides = ["Intro", "Plan", "Demo", "Q&A"]
    @State private var index = 0
    @State private var reachedParent = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(slides[index])
                .font(.title3)
                .frame(width: 200, height: 44)
                .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
                .focusable()
                .onKeyPress { press in
                    guard press.characters == "j" else { return .ignored }
                    index = (index + 1) % slides.count
                    return .handled
                }
            Text("j → .handled advances; other keys → .ignored reached the parent \(reachedParent)×")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .onKeyPress { _ in
            reachedParent += 1
            return .handled
        }
    }
}

private struct C07_KeyPressKeyExample: View {
    @State private var isEditing = true
    @State private var lastKey = "—"

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(isEditing ? "Editing… press ⎋ to cancel" : "Cancelled")
                .frame(width: 220, height: 40)
                .background(isEditing ? Color.accentColor.opacity(0.2) : Color.gray.opacity(0.2),
                            in: RoundedRectangle(cornerRadius: 8))
                .focusable()
                .onKeyPress(phases: .down) { press in
                    lastKey = press.key == .escape ? "escape" : String(press.key.character)
                    if press.key == .escape { isEditing = false; return .handled }
                    return .ignored
                }
            HStack {
                Button("Edit again") { isEditing = true }.controlSize(.small)
                Text("press.key: \(lastKey)")
                    .font(.caption.monospaced())
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
    }
}

private struct C07_KeyPressCharactersExample: View {
    @State private var pin = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                ForEach(0..<4, id: \.self) { i in
                    RoundedRectangle(cornerRadius: 6)
                        .fill(.quaternary)
                        .frame(width: 32, height: 40)
                        .overlay(Text(i < pin.count ? "•" : "").font(.title))
                }
            }
            .focusable()
            .onKeyPress(characters: .decimalDigits) { press in
                if pin.count < 4 { pin += press.characters }
                return .handled
            }
            .onKeyPress(.delete) { pin = String(pin.dropLast()); return .handled }
            Text("Click to focus, type digits — entered: \(pin.isEmpty ? "—" : pin)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

// MARK: - LocalizedStringKey

private struct C07_LocalizedStringKeyInitExample: View {
    private let keys = ["settings.privacy", "settings.storage", "settings.about"]
    @State private var titleKey = "settings.privacy"

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Picker("Section", selection: $titleKey) {
                ForEach(keys, id: \.self) { Text(verbatim: $0).tag($0) }
            }
            .frame(maxWidth: 260)
            HStack(spacing: 16) {
                VStack(alignment: .leading) {
                    Text(LocalizedStringKey(titleKey))
                    Text("LocalizedStringKey(_:) → catalog lookup").font(.caption2).foregroundStyle(.secondary)
                }
                VStack(alignment: .leading) {
                    Text(verbatim: titleKey)
                    Text("String → shown verbatim").font(.caption2).foregroundStyle(.secondary)
                }
            }
            Text("Identical here because this app has no catalog entry; only the left one would translate.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C07_InterpolationSpecifierExample: View {
    @State private var pace = 5.25
    @State private var lapIndex = 2

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Pace: \(pace, specifier: "%.1f") min/km")
            Text("Lap \(lapIndex + 1, specifier: "%02d")")
            HStack {
                Slider(value: $pace, in: 3...8).frame(width: 140)
                Stepper("Lap", value: $lapIndex, in: 0...20).labelsHidden()
            }
            .controlSize(.small)
        }
        .padding()
    }
}

private struct C07_InterpolationFormatExample: View {
    private let total = 1_249.5
    private let lastSync = Date().addingTimeInterval(-3_600 * 2)
    private let progress = 0.42

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Total \(total, format: .currency(code: "EUR"))")
            Text("Synced \(lastSync, format: .relative(presentation: .named))")
            Text("Progress \(progress, format: .percent.precision(.fractionLength(0)))")
            Text("FormatStyle output localizes with the surrounding sentence.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C07_InterpolationImageExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Tap \(Image(systemName: "plus.circle")) to add a stop")
            Text("Swipe \(Image(systemName: "arrow.left")) to archive")
                .foregroundStyle(.secondary)
            Text("Rated \(Image(systemName: "star.fill")) 4.8")
                .foregroundStyle(.orange)
        }
        .padding()
    }
}

// MARK: - LocalizedStringResource

private struct C07_ResourceKeyValueExample: View {
    private static let emptyState = LocalizedStringResource(
        "library.empty",
        table: "Library",
        comment: "Shown when the user has no documents"
    )

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(Self.emptyState).font(.headline)
            Text("key: \(Self.emptyState.key) · table: \(Self.emptyState.table ?? "Localizable")")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
            Text("No catalog entry, so the key itself is displayed.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C07_ResourceDefaultValueExample: View {
    private let cta = LocalizedStringResource(
        "onboarding.cta",
        defaultValue: "Get started"
    )

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button { } label: { Text(cta).padding(.horizontal, 8) }
                .buttonStyle(.borderedProminent)
            Text("key: \(cta.key) — the defaultValue renders, not the key")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private final class C07_BundleMarker { }

private struct C07_ResourceBundleDescriptionExample: View {
    var body: some View {
        let main = LocalizedStringResource("error.offline", bundle: .main)
        let framework = LocalizedStringResource("error.offline", bundle: .forClass(C07_BundleMarker.self))
        let plugin = LocalizedStringResource("error.offline", bundle: .atURL(Bundle.main.bundleURL))
        return VStack(alignment: .leading, spacing: 6) {
            Text(main)
                .font(.headline)
            ForEach([(".main", main), (".forClass(Marker.self)", framework), (".atURL(url)", plugin)], id: \.0) { item in
                HStack {
                    Text(item.0).font(.caption.monospaced())
                    Spacer()
                    Text(String(describing: item.1.bundle).prefix(40))
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
            .frame(maxWidth: 360)
        }
        .padding()
    }
}

private struct C07_ResourceLocaleExample: View {
    @State private var identifier = "de_DE"

    var body: some View {
        var total = LocalizedStringResource("Total \(1234.5, format: .currency(code: "EUR"))")
        total.locale = Locale(identifier: identifier)
        let resolved = String(localized: total)

        return VStack(alignment: .leading, spacing: 8) {
            Picker("locale", selection: $identifier) {
                Text("de_DE").tag("de_DE")
                Text("en_US").tag("en_US")
                Text("fr_FR").tag("fr_FR")
            }
            .pickerStyle(.segmented)
            .frame(maxWidth: 240)
            Text(resolved).font(.title3)
            Text("String(localized:) resolves with the resource's own locale.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

// MARK: - RedactionReasons

private struct C07_RedactionPlaceholderExample: View {
    @State private var isLoading = true

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top, spacing: 10) {
                Image(systemName: "photo")
                    .font(.title)
                    .frame(width: 44, height: 44)
                    .background(.quaternary, in: RoundedRectangle(cornerRadius: 6))
                VStack(alignment: .leading, spacing: 4) {
                    Text("Ferries return to the harbor").font(.headline)
                    Text("Service resumes Monday after the seawall repair.").font(.caption)
                }
            }
            .frame(width: 280, alignment: .leading)
            .redacted(reason: isLoading ? .placeholder : [])
            Toggle("Loading", isOn: $isLoading).frame(maxWidth: 140)
        }
        .padding()
    }
}

private struct C07_RedactionPrivacyExample: View {
    @State private var locked = true

    private struct AccountRow: View {
        @Environment(\.redactionReasons) private var reasons
        var body: some View {
            HStack {
                Text("Checking")
                Spacer()
                Text(reasons.contains(.privacy) ? "••••" : "4421")
                    .privacySensitive()
                Text("$2,310.40")
                    .privacySensitive()
            }
            .frame(width: 240)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            AccountRow()
                .redacted(reason: locked ? .privacy : [])
            Toggle("Simulate locked device", isOn: $locked).frame(maxWidth: 200)
            Text("The system supplies .privacy (e.g. locked-screen widgets); only privacySensitive() views react.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C07_RedactionInvalidatedExample: View {
    @State private var awaitingRefresh = true

    private struct CountTile: View {
        @Environment(\.redactionReasons) private var reasons
        let completed: Int
        var body: some View {
            Text("\(completed) done")
                .font(.title2.bold())
                .invalidatableContent()
                .opacity(reasons.contains(.invalidated) ? 0.5 : 1)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            CountTile(completed: 7)
                .redacted(reason: awaitingRefresh ? .invalidated : [])
            Toggle("Simulate pending widget refresh", isOn: $awaitingRefresh).frame(maxWidth: 260)
            Text("Illustrative — WidgetKit supplies .invalidated after an interaction until the timeline reloads.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

// MARK: - Text.DateStyle

private struct C07_DateStyleTimerExample: View {
    @State private var quizEnds = Date().addingTimeInterval(90)

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(quizEnds, style: .timer)
                .font(.system(.largeTitle, design: .rounded, weight: .semibold))
                .monospacedDigit()
            HStack {
                Button("Restart 90 s") { quizEnds = Date().addingTimeInterval(90) }.controlSize(.small)
                Text("Ticks on its own — no state or TimelineView needed.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
    }
}

private struct C07_DateStyleRelativeExample: View {
    private let sentAt = Date().addingTimeInterval(-125)
    private let dueAt = Date().addingTimeInterval(3_600 * 5 + 60)

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Can you review the deck?")
                Text(sentAt, style: .relative)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            HStack {
                Text("Due in")
                Text(dueAt, style: .relative)
            }
            Text("Unsigned in both directions; compare .offset.")
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .padding()
    }
}

private struct C07_DateStyleOffsetExample: View {
    private let departure = Date().addingTimeInterval(12 * 60)
    private let lastStop = Date().addingTimeInterval(-3 * 60)

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("Departs").frame(width: 70, alignment: .leading)
                Text(departure, style: .offset).monospacedDigit()
            }
            HStack {
                Text("Last stop").frame(width: 70, alignment: .leading)
                Text(lastStop, style: .offset).monospacedDigit()
            }
            Text("Future reads +N, past reads -N, and both keep ticking.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C07_DateStyleDateExample: View {
    private let start = Date(timeIntervalSinceReferenceDate: 812_000_000)

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Design review").font(.headline)
            HStack(spacing: 12) {
                Text(start, style: .date)
                Text(start, style: .time)
            }
            Text(".date and .time format once in the current locale; they do not tick.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

// MARK: - Text.Layout

private struct C07_RevealLinesRenderer: TextRenderer {
    var revealedLines: Int

    func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
        for (index, line) in layout.enumerated() {
            var lineCtx = ctx
            lineCtx.opacity = index < revealedLines ? 1 : 0.15
            for run in line { lineCtx.draw(run) }
        }
    }
}

private struct C07_TextLayoutLineExample: View {
    @State private var revealed = 2

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("The harbor lights came on one by one, and the last ferry of the evening slipped out past the breakwater while the town settled into its quiet.")
                .frame(width: 280, alignment: .leading)
                .textRenderer(C07_RevealLinesRenderer(revealedLines: revealed))
            Stepper("Revealed lines: \(revealed)", value: $revealed, in: 0...6)
                .frame(maxWidth: 200)
                .controlSize(.small)
        }
        .padding()
    }
}

private struct C07_RunBoxesRenderer: TextRenderer {
    func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
        for line in layout {
            for run in line {
                let box = run.typographicBounds.rect
                ctx.fill(Path(box), with: .color(.yellow.opacity(0.3)))
                ctx.stroke(Path(box), with: .color(.orange), lineWidth: 0.5)
                ctx.draw(run)
            }
        }
    }
}

private struct C07_TextLayoutRunExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            (Text("Bold start, ").bold() + Text("plain middle, ") + Text("italic end").italic())
                .font(.title3)
                .textRenderer(C07_RunBoxesRenderer())
            Text("Each box is one Run — a stretch sharing a single attribute set.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C07_WaveRenderer: TextRenderer {
    var phase: Double

    func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
        for line in layout {
            for run in line {
                for (i, slice) in run.enumerated() {
                    var g = ctx
                    g.translateBy(x: 0, y: sin(phase + Double(i) * 0.4) * 6)
                    g.draw(slice)
                }
            }
        }
    }
}

private struct C07_TextLayoutRunSliceExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TimelineView(.animation) { timeline in
                Text("Riding the wave")
                    .font(.system(.largeTitle, design: .rounded, weight: .bold))
                    .textRenderer(C07_WaveRenderer(phase: timeline.date.timeIntervalSinceReferenceDate * 4))
            }
            .frame(height: 60)
            Text("Every glyph is its own RunSlice, so each gets its own offset.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C07_Sparkle: TextAttribute { }

private struct C07_SparkleRenderer: TextRenderer {
    func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
        for line in layout {
            for run in line {
                guard run[C07_Sparkle.self] != nil else { ctx.draw(run); continue }
                var glow = ctx
                glow.addFilter(.shadow(color: .yellow, radius: 6))
                glow.draw(run)
            }
        }
    }
}

private struct C07_TextLayoutRunSubscriptExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            (Text("Plain ") + Text("magic").customAttribute(C07_Sparkle()).foregroundStyle(.orange) + Text(" plain"))
                .font(.title2.bold())
                .textRenderer(C07_SparkleRenderer())
            Text("run[Sparkle.self] is nil for the plain runs, so only the tagged one glows.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

// MARK: - Text.LineStyle

private struct C07_LineStyleInitExample: View {
    private var obsolete: AttributedString {
        var text = AttributedString("obsolete API")
        text.strikethroughStyle = Text.LineStyle(pattern: .dash, color: .red)
        return text
    }

    private var note: AttributedString {
        var text = AttributedString("needs review")
        text.underlineStyle = Text.LineStyle(pattern: .dot, color: .orange)
        return text
    }

    private var inherited: AttributedString {
        var text = AttributedString("color nil → inherits the foreground")
        text.underlineStyle = Text.LineStyle(pattern: .dashDotDot)
        return text
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(obsolete)
            Text(note)
            Text(inherited).foregroundStyle(.teal)
            Text("A LineStyle value drives the strikethroughStyle / underlineStyle attributes.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C07_LineStylePatternExample: View {
    private let patterns: [(String, Text.LineStyle.Pattern)] = [
        (".solid", .solid), (".dot", .dot), (".dash", .dash), (".dashDot", .dashDot), (".dashDotDot", .dashDotDot),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ForEach(patterns, id: \.0) { item in
                HStack(spacing: 16) {
                    Text("Tentative")
                        .underline(pattern: item.1)
                        .frame(width: 80, alignment: .leading)
                    Text("Was $80")
                        .strikethrough(pattern: item.1, color: .red)
                        .frame(width: 70, alignment: .leading)
                    Text(item.0)
                        .font(.caption.monospaced())
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding()
    }
}

private struct C07_LineStyleSingleExample: View {
    private var link: AttributedString {
        var link = AttributedString("Read the docs")
        link.underlineStyle = .single
        link.link = URL(string: "https://developer.apple.com")
        return link
    }

    private var struck: AttributedString {
        var text = AttributedString("Regular price $80")
        text.strikethroughStyle = .single
        return text
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(link)
            Text(struck).foregroundStyle(.secondary)
            Text(".single is the stock solid line with no color, so it takes the run's foreground (link blue above).")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

// MARK: - TextSelection

private struct C07_TextSelectionRangeExample: View {
    @State private var text = "The quick brown fox jumps over the lazy dog."
    @State private var selection: TextSelection?
    @State private var query = "fox"

    private var status: String {
        guard let selection, case .selection(let range) = selection.indices, !range.isEmpty,
              range.upperBound <= text.endIndex else { return "no range selected" }
        let lower = text.distance(from: text.startIndex, to: range.lowerBound)
        let upper = text.distance(from: text.startIndex, to: range.upperBound)
        return "selected \(lower)..<\(upper): \"\(text[range])\""
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextEditor(text: $text, selection: $selection)
                .frame(height: 50)
            HStack {
                TextField("Find", text: $query)
                    .frame(width: 100)
                Button("Select Match") {
                    if let found = text.range(of: query) {
                        selection = TextSelection(range: found)
                    }
                }
                .disabled(query.isEmpty || text.range(of: query) == nil)
            }
            .controlSize(.small)
            Text(status)
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C07_TextSelectionInsertionPointExample: View {
    @State private var text = "Ship the release notes"
    @State private var selection: TextSelection?

    private var caretOffset: String {
        guard let selection, selection.isInsertion, case .selection(let range) = selection.indices,
              range.lowerBound <= text.endIndex else { return "—" }
        return "\(text.distance(from: text.startIndex, to: range.lowerBound))"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextEditor(text: $text, selection: $selection)
                .frame(height: 50)
            HStack {
                Button("Append #tag") {
                    text.append(" #tag")
                    selection = TextSelection(insertionPoint: text.endIndex)
                }
                Button("Caret to Start") {
                    selection = TextSelection(insertionPoint: text.startIndex)
                }
            }
            .controlSize(.small)
            Text("caret at character \(caretOffset) of \(text.count)")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C07_TextSelectionIndicesExample: View {
    @State private var text = "Select one word, or several, then copy."
    @State private var selection: TextSelection?
    @State private var copied = "—"

    private var caseName: String {
        switch selection?.indices {
        case .selection(let range): return range.isEmpty ? ".selection (empty caret)" : ".selection"
        case .multiSelection: return ".multiSelection"
        case nil: return "nil"
        @unknown default: return "unknown"
        }
    }

    private func copy() {
        switch selection?.indices {
        case .selection(let range):
            copied = range.upperBound <= text.endIndex ? String(text[range]) : ""
        case .multiSelection(let set):
            copied = set.ranges
                .filter { $0.upperBound <= text.endIndex }
                .map { String(text[$0]) }
                .joined(separator: "\n")
        case nil:
            copied = ""
        @unknown default:
            copied = ""
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextEditor(text: $text, selection: $selection)
                .frame(height: 50)
            HStack {
                Button("Copy Selection") { copy() }.controlSize(.small)
                Text("indices: \(caseName)")
                    .font(.caption.monospaced())
                    .foregroundStyle(.secondary)
            }
            Text("copied: \(copied.isEmpty ? "(nothing)" : copied)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C07_TextSelectionIsInsertionExample: View {
    @State private var text = "Highlight a word, then press Uppercase."
    @State private var selection: TextSelection?

    private var isInsertion: Bool { selection?.isInsertion ?? true }

    private func uppercaseSelection() {
        guard let selection, case .selection(let range) = selection.indices,
              range.upperBound <= text.endIndex else { return }
        let lower = text.distance(from: text.startIndex, to: range.lowerBound)
        let upper = text.distance(from: text.startIndex, to: range.upperBound)
        text.replaceSubrange(range, with: text[range].uppercased())
        let start = text.index(text.startIndex, offsetBy: lower, limitedBy: text.endIndex) ?? text.endIndex
        let end = text.index(text.startIndex, offsetBy: upper, limitedBy: text.endIndex) ?? text.endIndex
        self.selection = TextSelection(range: start..<end)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextEditor(text: $text, selection: $selection)
                .frame(height: 50)
            HStack {
                Button("Uppercase") { uppercaseSelection() }
                    .disabled(selection?.isInsertion ?? true)
                    .controlSize(.small)
                Text(isInsertion ? "isInsertion: true — caret only, button disabled" : "isInsertion: false — range selected")
                    .font(.caption.monospaced())
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
    }
}

// C07_END_STRUCTS
