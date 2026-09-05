//
//  Examples+Text.swift
//  Aviary
//
//  Rendered usage examples for the entries in CatalogData/gen-text.json.
//

import SwiftUI

enum ExamplesText {
    static let entries: [ExampleEntry] = [

        // MARK: Modifiers

        ExampleEntry(topic: ".allowsTightening()", code: """
        Text("Boarding closes in 5 minutes")
            .lineLimit(1)
            .allowsTightening(true)
            .frame(width: width)
        """) { AnyView(T_AllowsTighteningExample()) },

        ExampleEntry(topic: ".attributedTextFormattingDefinition()", code: """
        TextEditor(text: $note, selection: $selection)
            .attributedTextFormattingDefinition(NoteRules())

        // NoteRules constrains every foreground color to orange,
        // so a red or blue tint is corrected as soon as it lands.
        """) { AnyView(T_FormattingDefinitionModifierExample()) },

        ExampleEntry(topic: ".autocorrectionDisabled()", code: """
        TextField("Server address", text: $host)
            .autocorrectionDisabled()
        """) { AnyView(T_AutocorrectionDisabledExample()) },

        ExampleEntry(topic: ".baselineOffset()", code: """
        HStack(alignment: .firstTextBaseline, spacing: 2) {
            Text("E = mc")
            Text("2")
                .font(.footnote)
                .baselineOffset(6)
        }
        """) { AnyView(T_BaselineOffsetExample()) },

        ExampleEntry(topic: ".bold()", code: """
        Text("Total due")
            .bold()
        Text("Row title")
            .bold(isHighlighted)
        Toggle("Highlighted", isOn: $isHighlighted)
        """) { AnyView(T_BoldExample()) },

        ExampleEntry(topic: ".customAttribute()", code: """
        struct Highlight: TextAttribute {}

        (Text("Flash sale ") + Text("today").customAttribute(Highlight()))
            .font(.title2)
            .textRenderer(HighlightRenderer())

        // HighlightRenderer paints a box behind runs where
        // run[Highlight.self] != nil, then draws the run.
        """) { AnyView(T_CustomAttributeExample()) },

        ExampleEntry(topic: ".dynamicTypeSize()", code: """
        HStack(spacing: 16) {
            StatusBadge()                                  // follows the picker
            StatusBadge()
                .dynamicTypeSize(...DynamicTypeSize.large) // clamped
        }
        .dynamicTypeSize(size)
        """) { AnyView(T_DynamicTypeSizeExample()) },

        ExampleEntry(topic: ".findNavigator()", code: """
        @State private var showFind = false

        Button("Find") { showFind = true }
        TextEditor(text: $draft)
            .findNavigator(isPresented: $showFind)
        """) { AnyView(T_FindNavigatorExample()) },

        ExampleEntry(topic: ".fontDesign()", code: """
        VStack(alignment: .leading) {
            Text("Reading mode").font(.headline)
            Text("Long-form body text renders in the chosen design.")
        }
        .fontDesign(design)
        """) { AnyView(T_FontDesignExample()) },

        ExampleEntry(topic: ".fontWeight()", code: """
        Text("Kilograms")
            .fontWeight(weight)
        Label("Flag", systemImage: "flag")
            .font(.title)
            .fontWeight(weight)   // the symbol follows too
        """) { AnyView(T_FontWeightExample()) },

        ExampleEntry(topic: ".fontWidth()", code: """
        Text("DEPARTURES")
            .fontWidth(.expanded)
        Text("Extremely long station name")
            .fontWidth(.compressed)
        """) { AnyView(T_FontWidthExample()) },

        ExampleEntry(topic: ".italic()", code: """
        Text("The Swift Programming Language")
            .italic()
        Text("Quoted phrase")
            .italic(isQuote)
        Toggle("Quote", isOn: $isQuote)
        """) { AnyView(T_ItalicExample()) },

        ExampleEntry(topic: ".kerning()", code: """
        Text("ESTABLISHED 1962")
            .font(.title3.smallCaps())
            .kerning(kerning)
        Slider(value: $kerning, in: 0...8)
        """) { AnyView(T_KerningExample()) },

        ExampleEntry(topic: ".keyboardType()", code: """
        TextField("Amount", text: $amount)
            .keyboardType(.decimalPad)
        TextField("Email", text: $email)
            .keyboardType(.emailAddress)
        """) { AnyView(T_KeyboardTypeExample()) },

        ExampleEntry(topic: ".lineSpacing()", code: """
        Text(articleBody)
            .font(.body)
            .lineSpacing(spacing)
        Slider(value: $spacing, in: 0...16)
        """) { AnyView(T_LineSpacingExample()) },

        ExampleEntry(topic: ".minimumScaleFactor()", code: """
        Text("Extremely long station name")
            .font(.title)
            .lineLimit(1)
            .minimumScaleFactor(0.6)
            .frame(width: 220)
        """) { AnyView(T_MinimumScaleFactorExample()) },

        ExampleEntry(topic: ".monospaced()", code: """
        Text("a1b2-c3d4-e5f6")
            .monospaced()
        Text("let x = 42")
            .font(.callout.monospaced())
        """) { AnyView(T_MonospacedExample()) },

        ExampleEntry(topic: ".monospacedDigit()", code: """
        TimelineView(.periodic(from: .now, by: 0.1)) { context in
            let elapsed = context.date.timeIntervalSince(start)
            Text(elapsed, format: .number.precision(.fractionLength(1)))
                .monospacedDigit()
                .font(.largeTitle)
        }
        """) { AnyView(T_MonospacedDigitExample()) },

        ExampleEntry(topic: ".onKeyPress()", code: """
        PuzzleBoard(selected: selected)
            .focusable()
            .focused($isFocused)
            .onKeyPress(.escape) {
                selected.removeAll()
                return .handled
            }
        """) { AnyView(T_OnKeyPressExample()) },

        ExampleEntry(topic: ".privacySensitive()", code: """
        VStack {
            Text("Checking")
            Text(balance, format: .currency(code: "USD"))
                .privacySensitive()
        }
        .redacted(reason: simulatePrivacy ? .privacy : [])
        """) { AnyView(T_PrivacySensitiveExample()) },

        ExampleEntry(topic: ".scrollDismissesKeyboard()", code: """
        ScrollView {
            MessageThread(messages: messages)
            ComposerField(text: $draft)
        }
        .scrollDismissesKeyboard(.interactively)
        """) { AnyView(T_ScrollDismissesKeyboardExample()) },

        ExampleEntry(topic: ".strikethrough()", code: """
        HStack(spacing: 6) {
            Text("$59.99")
                .strikethrough(true, color: .secondary)
            Text("$39.99").bold()
        }
        """) { AnyView(T_StrikethroughExample()) },

        ExampleEntry(topic: ".submitLabel()", code: """
        TextField("City", text: $city)
            .submitLabel(.next)
        TextField("Notes", text: $notes)
            .submitLabel(.done)
        """) { AnyView(T_SubmitLabelModifierExample()) },

        ExampleEntry(topic: ".submitScope()", code: """
        VStack {
            TextField("Add tag", text: $draftTag)
                .onSubmit { tags.append(draftTag); draftTag = "" }
                .submitScope()          // stops here
            TextField("Title", text: $title)
        }
        .onSubmit { saves += 1 }        // only the title field reaches this
        """) { AnyView(T_SubmitScopeExample()) },

        ExampleEntry(topic: ".textCase()", code: """
        Text("Advanced Options").textCase(nil)         // keep original casing
        Text("Advanced Options").textCase(.uppercase)
        Text("Advanced Options").textCase(.lowercase)
        """) { AnyView(T_TextCaseExample()) },

        ExampleEntry(topic: ".textContentType()", code: """
        TextField("Email", text: $email)
            .textContentType(.emailAddress)
        SecureField("One-time code", text: $code)
            .textContentType(.oneTimeCode)
        """) { AnyView(T_TextContentTypeExample()) },

        ExampleEntry(topic: ".textEditorStyle()", code: """
        TextEditor(text: $draft)
            .textEditorStyle(.plain)
            .padding(12)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 12))
        """) { AnyView(T_TextEditorStyleExample()) },

        ExampleEntry(topic: ".textInputAutocapitalization()", code: """
        TextField("Tag", text: $tag)
            .textInputAutocapitalization(.never)
        TextField("Recipient name", text: $name)
            .textInputAutocapitalization(.words)
        """) { AnyView(T_TextInputAutocapitalizationModifierExample()) },

        ExampleEntry(topic: ".textRenderer()", code: """
        TimelineView(.animation) { context in
            let phase = context.date.timeIntervalSinceReferenceDate * 3
            Text("Sparkle")
                .font(.largeTitle.bold())
                .textRenderer(WaveRenderer(phase: phase))
        }
        """) { AnyView(T_TextRendererExample()) },

        ExampleEntry(topic: ".textScale()", code: """
        HStack(alignment: .firstTextBaseline, spacing: 2) {
            Text("84").font(.system(.largeTitle, design: .rounded))
            Text("bpm").textScale(.secondary)
        }
        """) { AnyView(T_TextScaleExample()) },

        ExampleEntry(topic: ".tracking()", code: """
        Text("HEADLINE")
            .font(.title2.weight(.semibold))
            .tracking(tracking)
        Slider(value: $tracking, in: -1...8)
        """) { AnyView(T_TrackingExample()) },

        ExampleEntry(topic: ".truncationMode()", code: """
        Text("/Users/dev/app/Sources/Feature/DetailView.swift")
            .lineLimit(1)
            .truncationMode(mode)   // .head, .middle, or .tail
            .frame(width: 220)
        """) { AnyView(T_TruncationModeExample()) },

        ExampleEntry(topic: ".typesettingLanguage()", code: """
        Text(verbatim: userComment)
            .typesettingLanguage(.init(languageCode: .thai))
            .frame(width: 200)
        """) { AnyView(T_TypesettingLanguageExample()) },

        ExampleEntry(topic: ".underline()", code: """
        Text("Terms of Service")
            .underline(true, color: .blue)
        Text("Subtle emphasis")
            .underline(pattern: .dot)
        """) { AnyView(T_UnderlineExample()) },

        ExampleEntry(topic: ".unredacted()", code: """
        VStack(alignment: .leading) {
            Text("Portfolio").font(.headline)
                .unredacted()
            HoldingsList()
        }
        .redacted(reason: .placeholder)
        """) { AnyView(T_UnredactedExample()) },

        ExampleEntry(topic: ".writingToolsBehavior()", code: """
        TextEditor(text: $essay)
            .writingToolsBehavior(.complete)
        TextField("Regex pattern", text: $pattern)
            .writingToolsBehavior(.disabled)
        """) { AnyView(T_WritingToolsBehaviorExample()) },

        // MARK: Types and protocols

        ExampleEntry(topic: "AttributeContainer", code: """
        var emphasis = AttributeContainer()
        emphasis.font = .headline
        emphasis.underlineStyle = Text.LineStyle.single

        var message = AttributedString("Due today")
        message.mergeAttributes(emphasis)
        Text(AttributedString("Renew passport — ") + message)
        """) { AnyView(T_AttributeContainerExample()) },

        ExampleEntry(topic: "AttributedString", code: """
        var text = AttributedString("Ship it today")
        if let range = text.range(of: "today") {
            text[range].foregroundColor = .orange
            text[range].font = .headline.bold()
        }
        Text(text)
        """) { AnyView(T_AttributedStringExample()) },

        ExampleEntry(topic: "AttributedTextFormattingDefinition", code: """
        struct NoteRules: AttributedTextFormattingDefinition {
            struct Scope: AttributeScope {
                let foregroundColor: AttributeScopes.SwiftUIAttributes.ForegroundColorAttribute
            }
            var body: some AttributedTextFormattingDefinition<Scope> {
                AccentOnly()   // an AttributedTextValueConstraint
            }
        }

        TextEditor(text: $note, selection: $selection)
            .attributedTextFormattingDefinition(NoteRules())
        """) { AnyView(T_FormattingDefinitionProtocolExample()) },

        ExampleEntry(topic: "AttributedTextSelection", code: """
        @State private var note = AttributedString("Mix bold and color")
        @State private var selection = AttributedTextSelection()

        TextEditor(text: $note, selection: $selection)

        switch selection.indices(in: note) {
        case .insertionPoint(let index): // caret offset
        case .ranges(let ranges):        // selected text
        }
        """) { AnyView(T_AttributedTextSelectionExample()) },

        ExampleEntry(topic: "EventModifiers", code: """
        Button("Duplicate") { duplicates += 1 }
            .keyboardShortcut("d", modifiers: [.command, .shift])

        // Live readout of the held modifier keys:
        .onModifierKeysChanged { _, new in held = new }
        held.contains(.command)
        """) { AnyView(T_EventModifiersExample()) },

        ExampleEntry(topic: "Font", code: """
        VStack(alignment: .leading) {
            Text("Headline").font(.largeTitle)
            Text("Body copy")
                .font(.system(size: 15, design: .serif))
            Text("Caption")
                .font(.custom("AvenirNext-Medium", size: 12))
        }
        """) { AnyView(T_FontExample()) },

        ExampleEntry(topic: "Font.Design", code: """
        Text("Rounded").font(.system(.body, design: .rounded))
        Text("Serif").font(.system(.body, design: .serif))
        Text("Mono").font(.system(.body, design: .monospaced))
        """) { AnyView(T_FontDesignTypeExample()) },

        ExampleEntry(topic: "Font.Leading", code: """
        Text(paragraph)
            .font(.body.leading(.tight))
        Text(paragraph)
            .font(.body.leading(.loose))
        """) { AnyView(T_FontLeadingExample()) },

        ExampleEntry(topic: "Font.TextStyle", code: """
        @ScaledMetric(relativeTo: .headline) private var iconSize = 20.0

        Image(systemName: "bolt.fill")
            .frame(width: iconSize)
        Text("Charging").font(.system(.headline))

        ForEach([Font.TextStyle.largeTitle, .title, .headline, .body, .caption], id: \\.self) {
            Text(String(describing: $0)).font(.system($0))
        }
        """) { AnyView(T_FontTextStyleExample()) },

        ExampleEntry(topic: "Font.Weight", code: """
        Text("Thin").fontWeight(.thin)
        Text("Black").fontWeight(.black)
        Text("Derived")
            .font(.system(size: 18).weight(.medium))
        """) { AnyView(T_FontWeightTypeExample()) },

        ExampleEntry(topic: "Font.Width", code: """
        Text("LIVE").fontWidth(.expanded)
        Text("Breaking headline ticker")
            .fontWidth(.compressed)
        Text("Derived")
            .font(.body.width(.condensed))
        """) { AnyView(T_FontWidthTypeExample()) },

        ExampleEntry(topic: "KeyEquivalent", code: """
        Button("Save") { saves += 1 }
            .keyboardShortcut(KeyEquivalent("s"), modifiers: .command)
        Button("Cancel") { cancels += 1 }
            .keyboardShortcut(.escape, modifiers: [])
        """) { AnyView(T_KeyEquivalentExample()) },

        ExampleEntry(topic: "KeyPress", code: """
        CanvasView()
            .focusable()
            .onKeyPress(phases: .down) { press in
                last = press   // press.key, press.characters, press.modifiers, press.phase
                return .handled
            }
        """) { AnyView(T_KeyPressExample()) },

        ExampleEntry(topic: "legibilityWeight", code: """
        @Environment(\\.legibilityWeight) private var weight

        var body: some View {
            Text("Custom face")
                .fontWeight(weight == .bold ? .heavy : .regular)
        }
        """) { AnyView(T_LegibilityWeightExample()) },

        ExampleEntry(topic: "LocalizedStringKey", code: """
        let key: LocalizedStringKey = "welcome.title"
        Text(key)                       // looked up in the string catalog
        Text(verbatim: "Raw string")   // never localized
        Text("**Bold** and _italic_ via Markdown")
        """) { AnyView(T_LocalizedStringKeyExample()) },

        ExampleEntry(topic: "LocalizedStringResource", code: """
        let title = LocalizedStringResource("inbox.title", defaultValue: "Inbox", table: "Mail")
        Text(title)
        Label(String(localized: title), systemImage: "tray")
        """) { AnyView(T_LocalizedStringResourceExample()) },

        ExampleEntry(topic: "RedactionReasons", code: """
        @Environment(\\.redactionReasons) private var reasons

        var body: some View {
            Text(reasons.contains(.placeholder) ? "•••• ••••" : account.number)
                .unredacted()
        }
        """) { AnyView(T_RedactionReasonsExample()) },

        ExampleEntry(topic: "SubmitLabel", code: """
        TextField("Search city", text: $query)
            .submitLabel(.search)
        SecureField("Password", text: $password)
            .submitLabel(.go)
        """) { AnyView(T_SubmitLabelTypeExample()) },

        ExampleEntry(topic: "SubmitTriggers", code: """
        TextField("Search city", text: $query)
            .onSubmit(of: .text) {
                textSubmits += 1
            }
        // .search for searchable fields, [.text, .search] for both
        """) { AnyView(T_SubmitTriggersExample()) },

        ExampleEntry(topic: "Text.DateStyle", code: """
        let launch = Date(timeIntervalSinceNow: 3600)
        Text(launch, style: .timer)     // 59:59 counting down
        Text(launch, style: .relative)  // 1 hour
        Text(launch, style: .offset)    // +1 hour
        Text(launch, style: .date)
        Text(launch, style: .time)
        """) { AnyView(T_TextDateStyleExample()) },

        ExampleEntry(topic: "Text.Layout", code: """
        struct RunOutlineRenderer: TextRenderer {
            func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
                for line in layout {
                    for run in line {
                        ctx.stroke(Path(run.typographicBounds.rect), with: .color(.blue))
                        ctx.draw(run)
                    }
                }
            }
        }
        """) { AnyView(T_TextLayoutExample()) },

        ExampleEntry(topic: "Text.LineStyle", code: """
        Text("Deprecated API")
            .strikethrough(pattern: .dash, color: .red)
        Text("Read the details")
            .underline(pattern: .dot)
        Text("Dash-dot-dot")
            .underline(pattern: .dashDotDot, color: .teal)
        """) { AnyView(T_TextLineStyleExample()) },

        ExampleEntry(topic: "TextAlignment", code: """
        Text(longQuote)
            .multilineTextAlignment(alignment)   // .leading, .center, .trailing
            .frame(width: 240)
        """) { AnyView(T_TextAlignmentExample()) },

        ExampleEntry(topic: "TextAttribute", code: """
        struct Emphasis: TextAttribute {}

        (Text("Fresh").customAttribute(Emphasis()) + Text(" from the oven"))
            .textRenderer(EmphasisRenderer())

        // Inside EmphasisRenderer.draw:
        // if run[Emphasis.self] != nil { /* draw an accent bar */ }
        """) { AnyView(T_TextAttributeExample()) },

        ExampleEntry(topic: "TextInputAutocapitalization", code: """
        TextField("Username", text: $username)
            .textInputAutocapitalization(.never)
        TextField("Full name", text: $name)
            .textInputAutocapitalization(.words)
        """) { AnyView(T_TextInputAutocapitalizationTypeExample()) },

        ExampleEntry(topic: "TextSelection", code: """
        @State private var text = "Hello, world"
        @State private var selection: TextSelection?

        TextEditor(text: $text, selection: $selection)

        switch selection?.indices {
        case .selection(let range):         text[range]
        case .multiSelection(let ranges):   ranges.ranges.count
        case nil:                           "No selection"
        }
        """) { AnyView(T_TextSelectionExample()) },
    ]
}

// MARK: - Shared helpers

private struct T_Note: View {
    let text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(.secondary)
            .fixedSize(horizontal: false, vertical: true)
    }
}

private let T_paragraph = "Typography is the craft of endowing human language with a durable visual form. Good spacing keeps long passages comfortable to read."

// MARK: - Rich text formatting definition (shared by two entries)

private struct T_NoteRules: AttributedTextFormattingDefinition {
    struct Scope: AttributeScope {
        let foregroundColor: AttributeScopes.SwiftUIAttributes.ForegroundColorAttribute
    }
    var body: some AttributedTextFormattingDefinition<Scope> {
        T_AccentOnly()
    }
}

private struct T_AccentOnly: AttributedTextValueConstraint {
    typealias Scope = T_NoteRules.Scope
    typealias AttributeKey = AttributeScopes.SwiftUIAttributes.ForegroundColorAttribute

    func constrain(_ container: inout Attributes) {
        if container.foregroundColor != nil {
            container.foregroundColor = .orange
        }
    }
}

// MARK: - Modifier examples

private struct T_AllowsTighteningExample: View {
    @State private var width: Double = 176

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Boarding closes in 5 minutes")
                .lineLimit(1)
                .allowsTightening(true)
                .frame(width: width, alignment: .leading)
                .border(.secondary.opacity(0.4))
            Text("Boarding closes in 5 minutes")
                .lineLimit(1)
                .frame(width: width, alignment: .leading)
                .border(.secondary.opacity(0.4))
            Slider(value: $width, in: 120...240) { Text("Width") }
                .frame(width: 240)
            T_Note("Top allows tightening, bottom does not. Drag the width down until only the bottom line truncates.")
        }
    }
}

private struct T_FormattingDefinitionModifierExample: View {
    @State private var note = AttributedString("Select a word, then tint it. Every color is corrected to orange.")
    @State private var selection = AttributedTextSelection()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextEditor(text: $note, selection: $selection)
                .attributedTextFormattingDefinition(T_NoteRules())
                .frame(height: 80)
            HStack {
                Button("Tint red") { tint(.red) }
                Button("Tint blue") { tint(.blue) }
            }
            T_Note("The attached definition only allows foreground color and forces it to orange; pasted bold or italic is stripped.")
        }
    }

    private func tint(_ color: Color) {
        guard case .ranges(let ranges) = selection.indices(in: note) else { return }
        note.transform(updating: &selection) { text in
            for range in ranges.ranges {
                text[range].foregroundColor = color
            }
        }
    }
}

private struct T_AutocorrectionDisabledExample: View {
    @State private var host = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Server address", text: $host)
                .autocorrectionDisabled()
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: 300)
            T_Note("Type a hostname such as api.internal — no autocorrect suggestions are offered.")
        }
    }
}

private struct T_BaselineOffsetExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text("E = mc")
                Text("2")
                    .font(.footnote)
                    .baselineOffset(6)
            }
            .font(.title)
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text("H")
                Text("2")
                    .font(.footnote)
                    .baselineOffset(-4)
                Text("O")
            }
            .font(.title)
            T_Note("Positive offsets raise text above the baseline; negative offsets sink it.")
        }
    }
}

private struct T_BoldExample: View {
    @State private var isHighlighted = true

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Total due")
                .bold()
            Text("Row title")
                .bold(isHighlighted)
            Toggle("Highlighted", isOn: $isHighlighted)
                .toggleStyle(.switch)
        }
    }
}

private struct T_Highlight: TextAttribute {}

private struct T_HighlightRenderer: TextRenderer {
    func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
        for line in layout {
            for run in line {
                if run[T_Highlight.self] != nil {
                    let rect = run.typographicBounds.rect.insetBy(dx: -3, dy: -1)
                    ctx.fill(Path(roundedRect: rect, cornerRadius: 4), with: .color(.yellow.opacity(0.55)))
                }
                ctx.draw(run)
            }
        }
    }
}

private struct T_CustomAttributeExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Use string interpolation to embed the attributed run
            Text("Flash sale \(Text("today").customAttribute(T_Highlight()))")
                .font(.title2)
                .textRenderer(T_HighlightRenderer())
            T_Note("Only the run tagged with the custom attribute gets the highlight box.")
        }
    }
}


private struct T_StatusBadge: View {
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        VStack(spacing: 4) {
            Label("Live", systemImage: "dot.radiowaves.left.and.right")
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(.green.opacity(0.2), in: Capsule())
            Text(String(describing: typeSize))
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }
}

private struct T_DynamicTypeSizeExample: View {
    @State private var size: DynamicTypeSize = .xxxLarge
    private let sizes: [DynamicTypeSize] = [.xSmall, .large, .xxxLarge, .accessibility2]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Picker("Size", selection: $size) {
                ForEach(sizes, id: \.self) { Text(String(describing: $0)).tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(maxWidth: 360)
            HStack(spacing: 24) {
                T_StatusBadge()
                T_StatusBadge()
                    .dynamicTypeSize(...DynamicTypeSize.large)
            }
            .dynamicTypeSize(size)
            T_Note("Left follows the picker; right is clamped to ...large. Each badge shows the environment value it sees. Glyph scaling applies where Dynamic Type is supported.")
        }
    }
}

private struct T_FindNavigatorExample: View {
    @State private var draft = "The quick brown fox jumps over the lazy dog.\nFind and replace operate on this text."
    @State private var showFind = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button("Find") { showFind = true }
            TextEditor(text: $draft)
                .findNavigator(isPresented: $showFind)
                .frame(height: 100)
            T_Note("The system find bar appears over the editor. iOS 16; macOS 26.")
        }
    }
}

private struct T_FontDesignExample: View {
    @State private var design: Font.Design = .serif
    private let designs: [(String, Font.Design)] = [
        ("Default", .default), ("Rounded", .rounded), ("Serif", .serif), ("Mono", .monospaced),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Picker("Design", selection: $design) {
                ForEach(designs, id: \.1) { Text($0.0).tag($0.1) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(maxWidth: 320)
            VStack(alignment: .leading) {
                Text("Reading mode").font(.headline)
                Text("Long-form body text renders in the chosen design.")
            }
            .fontDesign(design)
        }
    }
}

private struct T_FontWeightExample: View {
    @State private var weight: Font.Weight = .semibold
    private let weights: [(String, Font.Weight)] = [
        ("Light", .light), ("Regular", .regular), ("Semibold", .semibold), ("Black", .black),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Picker("Weight", selection: $weight) {
                ForEach(weights, id: \.1) { Text($0.0).tag($0.1) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(maxWidth: 320)
            Text("Kilograms")
                .fontWeight(weight)
            Label("Flag", systemImage: "flag")
                .font(.title)
                .fontWeight(weight)
            T_Note("The symbol's stroke weight follows the text weight.")
        }
    }
}

private struct T_FontWidthExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("DEPARTURES")
                .fontWidth(.expanded)
            Text("DEPARTURES")
                .fontWidth(.standard)
                .foregroundStyle(.secondary)
            Text("Extremely long station name")
                .fontWidth(.compressed)
            Text("Extremely long station name")
                .fontWidth(.standard)
                .foregroundStyle(.secondary)
        }
        .font(.title3)
    }
}

private struct T_ItalicExample: View {
    @State private var isQuote = true

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("The Swift Programming Language")
                .italic()
            Text("Quoted phrase")
                .italic(isQuote)
            Toggle("Quote", isOn: $isQuote)
                .toggleStyle(.switch)
        }
    }
}

private struct T_KerningExample: View {
    @State private var kerning: Double = 1.5

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("ESTABLISHED 1962")
                .font(.title3.smallCaps())
                .kerning(kerning)
            Slider(value: $kerning, in: 0...8) { Text("Kerning") }
                .frame(width: 240)
            T_Note("Kerning \(String(format: "%.1f", kerning)) pt between characters.")
        }
    }
}

private struct T_KeyboardTypeExample: View {
    @State private var amount = ""
    private let keys = ["1", "2", "3", "4", "5", "6", "7", "8", "9", ".", "0", "⌫"]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Amount", text: $amount)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: 200)
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(48), spacing: 4), count: 3), spacing: 4) {
                ForEach(keys, id: \.self) { key in
                    Text(key)
                        .font(.callout.monospacedDigit())
                        .frame(width: 48, height: 22)
                        .background(.quaternary, in: RoundedRectangle(cornerRadius: 4))
                }
            }
            .frame(width: 152)
            T_Note("Illustrative — iOS/tvOS only. .keyboardType(.decimalPad) selects this software keyboard; macOS has none.")
        }
    }
}

private struct T_LineSpacingExample: View {
    @State private var spacing: Double = 6

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(T_paragraph)
                .font(.body)
                .lineSpacing(spacing)
                .frame(width: 300, alignment: .leading)
            Slider(value: $spacing, in: 0...16) { Text("Line spacing") }
                .frame(width: 240)
            T_Note("\(Int(spacing)) pt added between lines.")
        }
    }
}

private struct T_MinimumScaleFactorExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Extremely long station name")
                .font(.title)
                .lineLimit(1)
                .minimumScaleFactor(0.6)
                .frame(width: 220, alignment: .leading)
                .border(.secondary.opacity(0.4))
            Text("Extremely long station name")
                .font(.title)
                .lineLimit(1)
                .frame(width: 220, alignment: .leading)
                .border(.secondary.opacity(0.4))
            T_Note("Top shrinks to fit (down to 60%); bottom truncates at the same width.")
        }
    }
}

private struct T_MonospacedExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("a1b2-c3d4-e5f6")
                .monospaced()
            Text("a1b2-c3d4-e5f6")
                .foregroundStyle(.secondary)
            Text("let x = 42")
                .font(.callout.monospaced())
            T_Note("First line fixed-pitch, second proportional for comparison.")
        }
    }
}

private struct T_MonospacedDigitExample: View {
    @State private var start = Date()

    var body: some View {
        TimelineView(.periodic(from: .now, by: 0.1)) { context in
            let elapsed = context.date.timeIntervalSince(start)
            HStack(spacing: 32) {
                VStack {
                    Text(elapsed, format: .number.precision(.fractionLength(1)))
                        .monospacedDigit()
                        .font(.largeTitle)
                    T_Note("monospacedDigit")
                }
                VStack {
                    Text(elapsed, format: .number.precision(.fractionLength(1)))
                        .font(.largeTitle)
                    T_Note("proportional")
                }
            }
        }
    }
}

private struct T_OnKeyPressExample: View {
    @State private var selected: Set<Int> = [1, 4]
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                ForEach(0..<6, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 6)
                        .fill(selected.contains(index) ? Color.accentColor : Color.secondary.opacity(0.3))
                        .frame(width: 34, height: 34)
                        .onTapGesture {
                            if selected.contains(index) { selected.remove(index) } else { selected.insert(index) }
                            isFocused = true
                        }
                }
            }
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 10).stroke(isFocused ? Color.accentColor : Color.secondary.opacity(0.3)))
            .focusable()
            .focused($isFocused)
            .onKeyPress(.escape) {
                selected.removeAll()
                return .handled
            }
            T_Note(isFocused ? "Board focused — press Esc to deselect all tiles." : "Click a tile to select it and focus the board.")
        }
    }
}

private struct T_PrivacySensitiveExample: View {
    @State private var simulatePrivacy = true
    private let balance = 2_481.37

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading) {
                Text("Checking")
                Text(balance, format: .currency(code: "USD"))
                    .font(.title2)
                    .privacySensitive()
            }
            .redacted(reason: simulatePrivacy ? .privacy : [])
            Toggle("Simulate privacy context", isOn: $simulatePrivacy)
                .toggleStyle(.switch)
            T_Note("Only the privacy-sensitive balance is redacted; the label stays readable.")
        }
    }
}

private struct T_ScrollDismissesKeyboardExample: View {
    @State private var draft = ""
    private let messages = ["Landing at 9:40", "Grab a coffee first?", "Sure — the usual spot", "See you there"]

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ScrollView {
                VStack(alignment: .leading, spacing: 6) {
                    ForEach(messages, id: \.self) { message in
                        Text(message)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(.quaternary, in: Capsule())
                    }
                    TextField("Message", text: $draft)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(8)
            }
            .scrollDismissesKeyboard(.interactively)
            .frame(width: 260, height: 130)
            .background(.background.secondary, in: RoundedRectangle(cornerRadius: 10))
            T_Note("Compiles on macOS but only matters with a software keyboard: on iOS, dragging the thread down pulls the keyboard away interactively.")
        }
    }
}

private struct T_StrikethroughExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                Text("$59.99")
                    .strikethrough(true, color: .secondary)
                Text("$39.99").bold()
            }
            .font(.title3)
            Text("Completed task")
                .strikethrough(true, pattern: .dash, color: .green)
        }
    }
}

private struct T_SubmitLabelModifierExample: View {
    @State private var city = ""
    @State private var notes = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                TextField("City", text: $city)
                    .submitLabel(.next)
                T_ReturnKey("next")
            }
            HStack {
                TextField("Notes", text: $notes)
                    .submitLabel(.done)
                T_ReturnKey("done")
            }
            T_Note("The key previews show what the software keyboard's Return key would read on iOS; hardware keyboards are unaffected.")
        }
        .textFieldStyle(.roundedBorder)
        .frame(maxWidth: 320)
    }
}

private struct T_ReturnKey: View {
    let label: String
    init(_ label: String) { self.label = label }
    var body: some View {
        Text(label)
            .font(.caption.weight(.medium))
            .frame(width: 56, height: 22)
            .background(Color.accentColor.opacity(0.85), in: RoundedRectangle(cornerRadius: 5))
            .foregroundStyle(.white)
    }
}

private struct T_SubmitScopeExample: View {
    @State private var draftTag = ""
    @State private var tags = ["swift"]
    @State private var title = "Untitled"
    @State private var saves = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack {
                TextField("Add tag, press Return", text: $draftTag)
                    .onSubmit {
                        let tag = draftTag.trimmingCharacters(in: .whitespaces)
                        if !tag.isEmpty { tags.append(tag) }
                        draftTag = ""
                    }
                    .submitScope()
                TextField("Title, press Return", text: $title)
            }
            .textFieldStyle(.roundedBorder)
            .frame(maxWidth: 320)
            .onSubmit { saves += 1 }
            Text("Tags: \(tags.joined(separator: ", "))")
            T_Note("Document saved \(saves)× — only the title field's Return reaches the outer onSubmit.")
        }
    }
}

private struct T_TextCaseExample: View {
    var body: some View {
        Grid(alignment: .leading, horizontalSpacing: 16, verticalSpacing: 6) {
            GridRow {
                Text(".textCase(nil)").font(.caption.monospaced()).foregroundStyle(.secondary)
                Text("Advanced Options").textCase(nil)
            }
            GridRow {
                Text(".textCase(.uppercase)").font(.caption.monospaced()).foregroundStyle(.secondary)
                Text("Advanced Options").textCase(.uppercase)
            }
            GridRow {
                Text(".textCase(.lowercase)").font(.caption.monospaced()).foregroundStyle(.secondary)
                Text("Advanced Options").textCase(.lowercase)
            }
        }
    }
}

private struct T_TextContentTypeExample: View {
    @State private var email = ""
    @State private var code = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Email", text: $email)
                .textContentType(.emailAddress)
            SecureField("One-time code", text: $code)
                .textContentType(.oneTimeCode)
            T_Note("The semantic type lets AutoFill suggest saved addresses and received codes.")
        }
        .textFieldStyle(.roundedBorder)
        .frame(maxWidth: 300)
    }
}

private struct T_TextEditorStyleExample: View {
    @State private var draft = "A plain-styled editor drops its default backing so the surrounding background shows through."

    var body: some View {
        TextEditor(text: $draft)
            .textEditorStyle(.plain)
            .padding(12)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 12))
            .frame(width: 300, height: 110)
    }
}

private struct T_TextInputAutocapitalizationModifierExample: View {
    @State private var tag = "swift ui"
    @State private var name = "ada lovelace"

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                TextField("Tag", text: $tag)
                Text(tag).foregroundStyle(.secondary)
            }
            HStack {
                TextField("Recipient name", text: $name)
                Text(name.capitalized).foregroundStyle(.secondary)
            }
            T_Note("Illustrative — software keyboard only (iOS). The trailing text shows how .never leaves input as typed and .words shifts each word.")
        }
        .textFieldStyle(.roundedBorder)
        .frame(maxWidth: 360)
    }
}

private struct T_WaveRenderer: TextRenderer {
    var phase: Double

    var animatableData: Double {
        get { phase }
        set { phase = newValue }
    }

    func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
        var index = 0
        for line in layout {
            for run in line {
                for slice in run {
                    var copy = ctx
                    copy.translateBy(x: 0, y: sin(phase + Double(index) * 0.6) * 4)
                    copy.draw(slice)
                    index += 1
                }
            }
        }
    }
}

private struct T_TextRendererExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TimelineView(.animation) { context in
                let phase = context.date.timeIntervalSinceReferenceDate * 3
                Text("Sparkle")
                    .font(.largeTitle.bold())
                    .textRenderer(T_WaveRenderer(phase: phase))
            }
            .padding(.vertical, 6)
            T_Note("The renderer offsets each glyph slice by a sine wave driven by the timeline.")
        }
    }
}

private struct T_TextScaleExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text("84").font(.system(.largeTitle, design: .rounded))
                Text("bpm").textScale(.secondary)
            }
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text("12.4").font(.system(.largeTitle, design: .rounded))
                Text("km").textScale(.secondary)
            }
            T_Note("Secondary scale renders proportionally smaller than the default scale beside it.")
        }
    }
}

private struct T_TrackingExample: View {
    @State private var tracking: Double = 3

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("HEADLINE")
                .font(.title2.weight(.semibold))
                .tracking(tracking)
            Slider(value: $tracking, in: -1...8) { Text("Tracking") }
                .frame(width: 240)
            T_Note("Tracking \(String(format: "%.1f", tracking)) pt after every character; ligatures are disabled.")
        }
    }
}

private struct T_TruncationModeExample: View {
    @State private var mode: Text.TruncationMode = .middle
    private let modes: [(String, Text.TruncationMode)] = [("head", .head), ("middle", .middle), ("tail", .tail)]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Picker("Mode", selection: $mode) {
                ForEach(modes, id: \.1) { Text($0.0).tag($0.1) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(maxWidth: 240)
            Text("/Users/dev/app/Sources/Feature/DetailView.swift")
                .lineLimit(1)
                .truncationMode(mode)
                .frame(width: 220, alignment: .leading)
                .border(.secondary.opacity(0.4))
        }
    }
}

private struct T_TypesettingLanguageExample: View {
    private let userComment = "สวัสดีครับ ยินดีต้อนรับสู่แอปพลิเคชันของเรา"

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(verbatim: userComment)
                .typesettingLanguage(.init(languageCode: .thai))
                .frame(width: 200, alignment: .leading)
                .border(.secondary.opacity(0.4))
            T_Note("Thai has no spaces between words; declaring the language lets the engine break lines at dictionary word boundaries.")
        }
    }
}

private struct T_UnderlineExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Terms of Service")
                .underline(true, color: .blue)
            Text("Subtle emphasis")
                .underline(pattern: .dot)
            Text("Not underlined")
                .underline(false)
        }
    }
}

private struct T_UnredactedExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Portfolio").font(.headline)
                .unredacted()
            ForEach(["Apple Inc.  ·  42 shares", "Index fund  ·  118 units", "Cash  ·  $1,240"], id: \.self) { holding in
                Text(holding)
            }
        }
        .redacted(reason: .placeholder)
    }
}

private struct T_WritingToolsBehaviorExample: View {
    @State private var essay = "Writing Tools can proofread and rewrite this paragraph inline."
    @State private var pattern = "^[a-z]+$"

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextEditor(text: $essay)
                .writingToolsBehavior(.complete)
                .frame(height: 70)
            TextField("Regex pattern", text: $pattern)
                .writingToolsBehavior(.disabled)
                .textFieldStyle(.roundedBorder)
            T_Note("Writing Tools appear in the editor's context menu on Apple Intelligence devices; the pattern field opts out.")
        }
        .frame(maxWidth: 320)
    }
}

// MARK: - Type and protocol examples

private struct T_AttributeContainerExample: View {
    private var reminder: AttributedString {
        var emphasis = AttributeContainer()
        emphasis.font = .headline
        emphasis.underlineStyle = Text.LineStyle.single

        var message = AttributedString("Due today")
        message.mergeAttributes(emphasis)
        return AttributedString("Renew passport — ") + message
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(reminder)
            T_Note("The container is built once and merged onto the run in a single call.")
        }
    }
}

private struct T_AttributedStringExample: View {
    private var text: AttributedString {
        var text = AttributedString("Ship it today")
        if let range = text.range(of: "today") {
            text[range].foregroundColor = .orange
            text[range].font = .headline.bold()
        }
        return text
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(text)
                .font(.title2)
            T_Note("Attributes live on typed runs; Text renders them directly.")
        }
    }
}

private struct T_FormattingDefinitionProtocolExample: View {
    @State private var note = AttributedString("Declared scope: foreground color. Rule: any color becomes orange.")
    @State private var selection = AttributedTextSelection()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Grid(alignment: .leading, horizontalSpacing: 12, verticalSpacing: 4) {
                GridRow {
                    Text("Scope").font(.caption.weight(.semibold))
                    Text("foregroundColor only").font(.caption)
                }
                GridRow {
                    Text("Constraint").font(.caption.weight(.semibold))
                    Text("AccentOnly — non-nil color → orange").font(.caption)
                }
            }
            TextEditor(text: $note, selection: $selection)
                .attributedTextFormattingDefinition(T_NoteRules())
                .frame(height: 64)
            Button("Tint selection green") { tint(.green) }
            T_Note("Select text and tint it: the definition rewrites the green to orange before it lands.")
        }
    }

    private func tint(_ color: Color) {
        guard case .ranges(let ranges) = selection.indices(in: note) else { return }
        note.transform(updating: &selection) { text in
            for range in ranges.ranges {
                text[range].foregroundColor = color
            }
        }
    }
}

private struct T_AttributedTextSelectionExample: View {
    @State private var note = AttributedString("Mix bold and color")
    @State private var selection = AttributedTextSelection()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextEditor(text: $note, selection: $selection)
                .frame(height: 60)
            Button("Bold selection") { embolden() }
            T_Note(summary)
        }
    }

    private var summary: String {
        switch selection.indices(in: note) {
        case .insertionPoint(let index):
            guard index >= note.startIndex, index <= note.endIndex else { return "Insertion point" }
            let offset = note.characters.distance(from: note.startIndex, to: index)
            return "Insertion point at character offset \(offset)"
        case .ranges(let ranges):
            let pieces = ranges.ranges.compactMap { range -> String? in
                guard range.lowerBound >= note.startIndex, range.upperBound <= note.endIndex else { return nil }
                return "“" + String(note[range].characters) + "”"
            }
            return "Selected: " + pieces.joined(separator: ", ")
        }
    }

    private func embolden() {
        guard case .ranges(let ranges) = selection.indices(in: note) else { return }
        note.transform(updating: &selection) { text in
            for range in ranges.ranges {
                text[range].font = .body.bold()
            }
        }
    }
}

private struct T_EventModifiersExample: View {
    @State private var held: EventModifiers = []
    @State private var duplicates = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button("Duplicate") { duplicates += 1 }
                .keyboardShortcut("d", modifiers: [.command, .shift])
            HStack(spacing: 6) {
                chip("⌘", .command)
                chip("⇧", .shift)
                chip("⌥", .option)
                chip("⌃", .control)
            }
            T_Note("Duplicated \(duplicates)× — press ⇧⌘D. Chips light up for modifier keys currently held.")
        }
        .onModifierKeysChanged(mask: [.command, .shift, .option, .control]) { _, new in
            held = new
        }
    }

    private func chip(_ symbol: String, _ modifier: EventModifiers) -> some View {
        Text(symbol)
            .font(.title3)
            .frame(width: 36, height: 30)
            .background(held.contains(modifier) ? Color.accentColor : Color.secondary.opacity(0.2), in: RoundedRectangle(cornerRadius: 6))
            .foregroundStyle(held.contains(modifier) ? .white : .primary)
    }
}

private struct T_FontExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Headline").font(.largeTitle)
            Text("Body copy")
                .font(.system(size: 15, design: .serif))
            Text("Caption")
                .font(.custom("AvenirNext-Medium", size: 12))
        }
    }
}

private struct T_FontDesignTypeExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Default").font(.system(.body, design: .default))
            Text("Rounded").font(.system(.body, design: .rounded))
            Text("Serif").font(.system(.body, design: .serif))
            Text("Mono").font(.system(.body, design: .monospaced))
        }
        .font(.title3)
    }
}

private struct T_FontLeadingExample: View {
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            VStack(alignment: .leading, spacing: 4) {
                T_Note("leading(.tight)")
                Text(T_paragraph)
                    .font(.body.leading(.tight))
            }
            VStack(alignment: .leading, spacing: 4) {
                T_Note("leading(.loose)")
                Text(T_paragraph)
                    .font(.body.leading(.loose))
            }
        }
        .frame(maxWidth: 420)
    }
}

private struct T_FontTextStyleExample: View {
    @ScaledMetric(relativeTo: .headline) private var iconSize = 20.0
    private let styles: [Font.TextStyle] = [.largeTitle, .title, .headline, .body, .caption]

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(systemName: "bolt.fill")
                    .frame(width: iconSize)
                Text("Charging").font(.system(.headline))
            }
            Divider().frame(width: 200)
            ForEach(styles, id: \.self) { style in
                Text(String(describing: style)).font(.system(style))
            }
        }
    }
}

private struct T_FontWeightTypeExample: View {
    private let weights: [(String, Font.Weight)] = [
        ("ultraLight", .ultraLight), ("thin", .thin), ("light", .light), ("regular", .regular),
        ("medium", .medium), ("semibold", .semibold), ("bold", .bold), ("heavy", .heavy), ("black", .black),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 10) {
                ForEach(weights, id: \.0) { entry in
                    VStack(spacing: 2) {
                        Text("Aa").font(.title).fontWeight(entry.1)
                        Text(entry.0).font(.system(size: 8)).foregroundStyle(.secondary)
                    }
                }
            }
            Text("Derived")
                .font(.system(size: 18).weight(.medium))
        }
    }
}

private struct T_FontWidthTypeExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("LIVE").fontWidth(.expanded)
            Text("Breaking headline ticker")
                .fontWidth(.compressed)
            Text("Derived")
                .font(.body.width(.condensed))
            Text("Standard").fontWidth(.standard).foregroundStyle(.secondary)
        }
        .font(.title3)
    }
}

private struct T_KeyEquivalentExample: View {
    @State private var saves = 0
    @State private var cancels = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Button("Save") { saves += 1 }
                    .keyboardShortcut(KeyEquivalent("s"), modifiers: .command)
                Button("Cancel") { cancels += 1 }
                    .keyboardShortcut(.escape, modifiers: [])
            }
            T_Note("⌘S saved \(saves)×  ·  Esc cancelled \(cancels)×. Press the keys while this window is frontmost.")
        }
    }
}

private struct T_KeyPressExample: View {
    @State private var last: KeyPress?
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            RoundedRectangle(cornerRadius: 10)
                .fill(isFocused ? Color.accentColor.opacity(0.15) : Color.secondary.opacity(0.12))
                .overlay(Text(isFocused ? "Type a key" : "Click, then type").foregroundStyle(.secondary))
                .frame(width: 260, height: 56)
                .contentShape(Rectangle())
                .onTapGesture { isFocused = true }
                .focusable()
                .focused($isFocused)
                .onKeyPress(phases: .down) { press in
                    last = press
                    return .handled
                }
            Grid(alignment: .leading, horizontalSpacing: 12, verticalSpacing: 2) {
                GridRow { T_Note("key"); Text(keyName) }
                GridRow { T_Note("characters"); Text(last?.characters ?? "—") }
                GridRow { T_Note("modifiers"); Text(modifierNames) }
            }
            .font(.callout.monospaced())
        }
    }

    private var keyName: String {
        guard let last else { return "—" }
        switch last.key {
        case .escape: return "escape"
        case .return: return "return"
        case .space: return "space"
        case .tab: return "tab"
        case .delete: return "delete"
        case .upArrow: return "upArrow"
        case .downArrow: return "downArrow"
        case .leftArrow: return "leftArrow"
        case .rightArrow: return "rightArrow"
        default: return String(last.key.character)
        }
    }

    private var modifierNames: String {
        guard let last else { return "—" }
        let names: [(String, EventModifiers)] = [("command", .command), ("shift", .shift), ("option", .option), ("control", .control)]
        let held = names.filter { last.modifiers.contains($0.1) }.map(\.0)
        return held.isEmpty ? "[]" : held.joined(separator: " + ")
    }
}

private struct T_LegibilityReadout: View {
    @Environment(\.legibilityWeight) private var weight

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Custom face")
                .font(.title2)
                .fontWeight(weight == .bold ? .heavy : .regular)
            T_Note(weight == .bold ? "legibilityWeight = .bold → drawing at .heavy" : "legibilityWeight = regular → drawing at .regular")
        }
    }
}

private struct T_LegibilityWeightExample: View {
    @State private var simulateBold = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            T_LegibilityReadout()
                .transformEnvironment(\.legibilityWeight) { weight in
                    if simulateBold { weight = .bold }
                }
            Toggle("Simulate Bold Text setting", isOn: $simulateBold)
                .toggleStyle(.switch)
        }
    }
}

private struct T_LocalizedStringKeyExample: View {
    private let key: LocalizedStringKey = "welcome.title"

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(key)
            Text(verbatim: "Raw string")
            Text("**Bold** and _italic_ via Markdown")
            T_Note("The first line shows the key itself because no string catalog entry exists for it.")
        }
    }
}

private struct T_LocalizedStringResourceExample: View {
    private let title = LocalizedStringResource("inbox.title", defaultValue: "Inbox", table: "Mail")

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
            Label(String(localized: title), systemImage: "tray")
            T_Note("Resolved at display time; falls back to the default value without a Mail table.")
        }
    }
}

private struct T_AccountRow: View {
    @Environment(\.redactionReasons) private var reasons

    var body: some View {
        HStack {
            Image(systemName: "creditcard")
            Text(reasons.contains(.placeholder) ? "•••• ••••" : "4421 8873")
                .unredacted()
            Spacer()
            T_Note(reasons.contains(.placeholder) ? "reasons: [.placeholder]" : "reasons: []")
                .unredacted()
        }
        .frame(width: 280)
    }
}

private struct T_RedactionReasonsExample: View {
    @State private var placeholder = true

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            T_AccountRow()
                .redacted(reason: placeholder ? .placeholder : [])
            Toggle("Placeholder", isOn: $placeholder)
                .toggleStyle(.switch)
            T_Note("The row reads the environment and swaps in its own dots instead of the system shape.")
        }
    }
}

private struct T_SubmitLabelTypeExample: View {
    @State private var query = ""
    @State private var password = ""
    @State private var index = 2
    private let labels: [(String, SubmitLabel)] = [
        ("done", .done), ("go", .go), ("search", .search), ("next", .next),
        ("send", .send), ("join", .join), ("route", .route), ("continue", .continue),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                TextField("Search city", text: $query)
                    .submitLabel(labels[index].1)
                T_ReturnKey(labels[index].0)
            }
            HStack {
                SecureField("Password", text: $password)
                    .submitLabel(.go)
                T_ReturnKey("go")
            }
            Picker("Label", selection: $index) {
                ForEach(labels.indices, id: \.self) { Text(labels[$0].0).tag($0) }
            }
            .frame(maxWidth: 200)
            T_Note("Return-key labels render on software keyboards (iOS); the previews mirror the chosen label.")
        }
        .textFieldStyle(.roundedBorder)
        .frame(maxWidth: 320)
    }
}

private struct T_SubmitTriggersExample: View {
    @State private var query = ""
    @State private var textSubmits = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Search city, press Return", text: $query)
                .textFieldStyle(.roundedBorder)
                .onSubmit(of: .text) {
                    textSubmits += 1
                }
                .frame(maxWidth: 280)
            T_Note("Text-field submits: \(textSubmits). Pass .search to respond only to a searchable field, or [.text, .search] for both.")
        }
    }
}

private struct T_TextDateStyleExample: View {
    @State private var launch = Date(timeIntervalSinceNow: 3600)

    var body: some View {
        Grid(alignment: .leading, horizontalSpacing: 16, verticalSpacing: 4) {
            GridRow { T_Note(".timer"); Text(launch, style: .timer) }
            GridRow { T_Note(".relative"); Text(launch, style: .relative) }
            GridRow { T_Note(".offset"); Text(launch, style: .offset) }
            GridRow { T_Note(".date"); Text(launch, style: .date) }
            GridRow { T_Note(".time"); Text(launch, style: .time) }
        }
        .monospacedDigit()
    }
}

private struct T_RunOutlineRenderer: TextRenderer {
    func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
        let colors: [Color] = [.blue, .orange, .green, .pink, .purple]
        var index = 0
        for line in layout {
            for run in line {
                let rect = run.typographicBounds.rect
                ctx.stroke(Path(rect), with: .color(colors[index % colors.count]), lineWidth: 1)
                ctx.draw(run)
                index += 1
            }
        }
    }
}

private struct T_TextLayoutExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            (Text("Each ") + Text("run").bold() + Text(" of every ") + Text("line").italic().foregroundStyle(.orange) + Text(" in the layout is outlined by the renderer."))
                .font(.title3)
                .textRenderer(T_RunOutlineRenderer())
                .frame(width: 280)
            T_Note("Attribute changes start new runs; wrapping starts new lines.")
        }
    }
}

private struct T_TextLineStyleExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Deprecated API")
                .strikethrough(pattern: .dash, color: .red)
            Text("Read the details")
                .underline(pattern: .dot)
            Text("Dash-dot-dot")
                .underline(pattern: .dashDotDot, color: .teal)
        }
        .font(.title3)
    }
}

private struct T_TextAlignmentExample: View {
    @State private var alignment: TextAlignment = .trailing
    private let longQuote = "Simplicity is the ultimate sophistication, and alignment is where a paragraph first shows it."

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Picker("Alignment", selection: $alignment) {
                ForEach(TextAlignment.allCases, id: \.self) { Text(String(describing: $0)).tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(maxWidth: 240)
            Text(longQuote)
                .multilineTextAlignment(alignment)
                .frame(width: 240)
                .border(.secondary.opacity(0.4))
        }
    }
}

private struct T_Emphasis: TextAttribute {}

private struct T_EmphasisRenderer: TextRenderer {
    func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
        for line in layout {
            for run in line {
                if run[T_Emphasis.self] != nil {
                    let bounds = run.typographicBounds
                    let bar = CGRect(x: bounds.rect.minX, y: bounds.origin.y + 2, width: bounds.width, height: 3)
                    ctx.fill(Path(roundedRect: bar, cornerRadius: 1.5), with: .color(.orange))
                }
                ctx.draw(run)
            }
        }
    }
}

private struct T_TextAttributeExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            (Text("Fresh").customAttribute(T_Emphasis()) + Text(" from the oven"))
                .font(.title2)
                .textRenderer(T_EmphasisRenderer())
            T_Note("The renderer checks run[Emphasis.self] and draws an accent bar under only that run.")
        }
    }
}

private struct T_TextInputAutocapitalizationTypeExample: View {
    @State private var sample = "hello wide world. see you soon"
    @State private var mode = 1
    private let modes = ["never", "words", "sentences", "characters"]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Typed text", text: $sample)
                .textFieldStyle(.roundedBorder)
            Picker("Mode", selection: $mode) {
                ForEach(modes.indices, id: \.self) { Text(modes[$0]).tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            Text(transformed)
                .font(.callout)
            T_Note("Illustrative — the software keyboard on iOS applies the chosen capitalization as you type; macOS has no software keyboard.")
        }
        .frame(maxWidth: 340)
    }

    private var transformed: String {
        switch mode {
        case 1: return sample.capitalized
        case 2: return sample.split(separator: ". ").map { $0.prefix(1).uppercased() + $0.dropFirst() }.joined(separator: ". ")
        case 3: return sample.uppercased()
        default: return sample
        }
    }
}

private struct T_TextSelectionExample: View {
    @State private var text = "Hello, world"
    @State private var selection: TextSelection?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextEditor(text: $text, selection: $selection)
                .frame(height: 56)
            Button("Select all") {
                selection = TextSelection(range: text.startIndex..<text.endIndex)
            }
            T_Note(summary)
        }
    }

    private var summary: String {
        guard let selection else { return "No selection" }
        switch selection.indices {
        case .selection(let range):
            guard range.lowerBound >= text.startIndex, range.upperBound <= text.endIndex else { return "Selection out of range" }
            if range.isEmpty {
                return "Insertion point at offset \(text.distance(from: text.startIndex, to: range.lowerBound))"
            }
            return "Selected “\(text[range])”"
        case .multiSelection(let ranges):
            return "\(ranges.ranges.count) selected ranges"
        }
    }
}
