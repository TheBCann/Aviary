//
//  Examples+Accessibility.swift
//  Aviary
//
//  Rendered usage examples for the entries in CatalogData/gen-accessibility.json.
//
//  Accessibility APIs are overwhelmingly non-visual: most change what VoiceOver,
//  Switch Control, or Voice Control do rather than what appears on screen. Each
//  example therefore attaches the real API to a real, rendered view and adds a
//  short note explaining the assistive-technology effect. A handful of APIs are
//  iOS-/watchOS-only (they will not compile on macOS); those render a faithful
//  illustration while the code string keeps the true API.
//

import SwiftUI

enum ExamplesAccessibility {
    static let entries: [ExampleEntry] = [
        ExampleEntry(topic: ".accessibilityAction()", code: """
        MessageRow(subject: "Lunch tomorrow?")
            .accessibilityAction(named: "Reply") { last = "Reply" }
            .accessibilityAction(named: "Archive") { last = "Archive" }

        Text("Last action: \\(last)")
        """) { AnyView(Ax_AccessibilityActionExample()) },

        ExampleEntry(topic: ".accessibilityActions()", code: """
        NoteRow(title: "Groceries")
            .accessibilityActions {
                Button("Pin") { last = "Pin" }
                Button("Delete", role: .destructive) { last = "Delete" }
            }
        """) { AnyView(Ax_AccessibilityActionsExample()) },

        ExampleEntry(topic: ".accessibilityActivationPoint()", code: """
        SettingsRow(title: "Notifications", isOn: $on)
            // Aim VoiceOver's double-tap at the trailing toggle, not the center.
            .accessibilityActivationPoint(UnitPoint(x: 0.92, y: 0.5))
        """) { AnyView(Ax_AccessibilityActivationPointExample()) },

        ExampleEntry(topic: ".accessibilityAddTraits()", code: """
        Text("Now Playing")
            .font(.headline)
            .accessibilityAddTraits(.isHeader)
        """) { AnyView(Ax_AccessibilityAddTraitsExample()) },

        ExampleEntry(topic: ".accessibilityAdjustableAction()", code: """
        QuantityBadge(count: quantity)
            .accessibilityValue("\\(quantity)")
            .accessibilityAdjustableAction { direction in
                switch direction {
                case .increment: quantity += 1
                case .decrement: quantity = max(0, quantity - 1)
                @unknown default: break
                }
            }
        """) { AnyView(Ax_AdjustableActionExample()) },

        ExampleEntry(topic: ".accessibilityChartDescriptor()", code: """
        TemperatureSparkline(readings: readings)
            .accessibilityChartDescriptor(TemperatureAXDescriptor(readings: readings))
        """) { AnyView(Ax_ChartDescriptorExample()) },

        ExampleEntry(topic: ".accessibilityChildren()", code: """
        SparklineCanvas(points: sales)
            .accessibilityChildren {
                ForEach(sales) { point in
                    Text("\\(point.month): \\(point.total) units")
                }
            }
        """) { AnyView(Ax_ChildrenExample()) },

        ExampleEntry(topic: ".accessibilityCustomContent()", code: """
        RecipeCard(recipe: recipe)
            .accessibilityCustomContent("Prep time", "25 minutes")
            .accessibilityCustomContent("Difficulty", "Easy", importance: .high)
        """) { AnyView(Ax_CustomContentExample()) },

        ExampleEntry(topic: ".accessibilityDirectTouch()", code: """
        DrumPad(samples: kit)
            .accessibilityDirectTouch(options: .silentOnTouch)
        """) { AnyView(Ax_DirectTouchExample()) },

        ExampleEntry(topic: ".accessibilityDragPoint()", code: """
        TrimHandle(position: $trimStart)
            .accessibilityDragPoint(.center, description: "Adjust trim start")
        """) { AnyView(Ax_DragPointExample()) },

        ExampleEntry(topic: ".accessibilityDropPoint()", code: """
        SceneTile(scene: scene)
            .accessibilityDropPoint(.leading, description: "Run scene")
        """) { AnyView(Ax_DropPointExample()) },

        ExampleEntry(topic: ".accessibilityElement()", code: """
        VStack(alignment: .leading) {
            Text(stop.name)
            Text(stop.arrival, style: .relative)
        }
        .accessibilityElement(children: .combine)
        """) { AnyView(Ax_ElementExample()) },

        ExampleEntry(topic: ".accessibilityFocused()", code: """
        TextField("Email", text: $email)
            .accessibilityFocused($focused, equals: .email)
        SecureField("Password", text: $password)
            .accessibilityFocused($focused, equals: .password)

        Button("Focus password") { focused = .password }
        """) { AnyView(Ax_FocusedExample()) },

        ExampleEntry(topic: ".accessibilityHeading()", code: """
        Text("Today")
            .font(.title2.bold())
            .accessibilityHeading(.h2)
        """) { AnyView(Ax_HeadingExample()) },

        ExampleEntry(topic: ".accessibilityHidden()", code: """
        HStack(spacing: 6) {
            Image(systemName: "star.fill")
                .accessibilityHidden(true)
            Text("Featured")
        }
        """) { AnyView(Ax_HiddenExample()) },

        ExampleEntry(topic: ".accessibilityHint()", code: """
        Button("Archive", action: archive)
            .accessibilityHint("Moves the conversation out of your inbox")
        """) { AnyView(Ax_HintExample()) },

        ExampleEntry(topic: ".accessibilityIdentifier()", code: """
        TextField("Email", text: $email)
            .accessibilityIdentifier("signup.emailField")
        """) { AnyView(Ax_IdentifierExample()) },

        ExampleEntry(topic: ".accessibilityIgnoresInvertColors()", code: """
        PhotoGrid(photos: album.photos)
            .accessibilityIgnoresInvertColors()
        """) { AnyView(Ax_IgnoresInvertColorsExample()) },

        ExampleEntry(topic: ".accessibilityInputLabels()", code: """
        Button(action: compose) {
            Image(systemName: "square.and.pencil")
        }
        .accessibilityLabel("Compose message")
        .accessibilityInputLabels(["Compose", "New message", "Write"])
        """) { AnyView(Ax_InputLabelsExample()) },

        ExampleEntry(topic: ".accessibilityLabel()", code: """
        Button(action: toggleFavorite) {
            Image(systemName: isFavorite ? "star.fill" : "star")
        }
        .accessibilityLabel(isFavorite ? "Remove favorite" : "Add favorite")
        """) { AnyView(Ax_LabelExample()) },

        ExampleEntry(topic: ".accessibilityLabeledPair()", code: """
        @Namespace private var pairing

        HStack {
            Text("High")
                .accessibilityLabeledPair(role: .label, id: "high", in: pairing)
            Text("74°")
                .accessibilityLabeledPair(role: .content, id: "high", in: pairing)
        }
        """) { AnyView(Ax_LabeledPairExample()) },

        ExampleEntry(topic: ".accessibilityLinkedGroup()", code: """
        @Namespace private var storyLink

        HeadlineView(story: story)
            .accessibilityLinkedGroup(id: story.id, in: storyLink)
        Thumbnail(story: story)
            .accessibilityLinkedGroup(id: story.id, in: storyLink)
        """) { AnyView(Ax_LinkedGroupExample()) },

        ExampleEntry(topic: ".accessibilityQuickAction()", code: """
        WorkoutMetricsView(session: session)
            .accessibilityQuickAction(style: .prompt) {
                Button("Pause workout") { session.pause() }
            }
        """) { AnyView(Ax_QuickActionExample()) },

        ExampleEntry(topic: ".accessibilityRemoveTraits()", code: """
        Image(systemName: "play.fill")
            .onTapGesture(perform: play)
            .accessibilityLabel("Play")
            .accessibilityRemoveTraits(.isImage)
            .accessibilityAddTraits(.isButton)
        """) { AnyView(Ax_RemoveTraitsExample()) },

        ExampleEntry(topic: ".accessibilityRepresentation()", code: """
        WaveformScrubber(progress: $progress)
            .accessibilityRepresentation {
                Slider(value: $progress, in: 0...1) {
                    Text("Playback position")
                }
            }
        """) { AnyView(Ax_RepresentationExample()) },

        ExampleEntry(topic: ".accessibilityRespondsToUserInteraction()", code: """
        CardFace(card: card)
            .onTapGesture(perform: flip)
            .accessibilityRespondsToUserInteraction(true)
        """) { AnyView(Ax_RespondsToInteractionExample()) },

        ExampleEntry(topic: ".accessibilityRotor()", code: """
        List(messages) { message in
            Text(message.subject)
        }
        .accessibilityRotor("Unread",
                            entries: messages.filter(\\.isUnread),
                            entryLabel: \\.subject)
        """) { AnyView(Ax_RotorExample()) },

        ExampleEntry(topic: ".accessibilityRotorEntry()", code: """
        @Namespace private var headings

        ForEach(sections) { section in
            SectionHeader(title: section.title)
                .accessibilityRotorEntry(id: section.id, in: headings)
        }
        """) { AnyView(Ax_RotorEntryExample()) },

        ExampleEntry(topic: ".accessibilityScrollAction()", code: """
        PageCanvas(page: pages[index])
            .accessibilityScrollAction { edge in
                if edge == .trailing { index = min(index + 1, pages.count - 1) }
                if edge == .leading  { index = max(index - 1, 0) }
            }
        """) { AnyView(Ax_ScrollActionExample()) },

        ExampleEntry(topic: ".accessibilityShowsLargeContentViewer()", code: """
        TabGlyph(symbol: "magnifyingglass")
            .accessibilityShowsLargeContentViewer {
                Label("Search", systemImage: "magnifyingglass")
            }
        """) { AnyView(Ax_LargeContentViewerExample()) },

        ExampleEntry(topic: ".accessibilitySortPriority()", code: """
        HStack {
            CloseButton(action: dismiss)
                .accessibilitySortPriority(-1)
            Text(article.title)
                .accessibilitySortPriority(1)
        }
        """) { AnyView(Ax_SortPriorityExample()) },

        ExampleEntry(topic: ".accessibilityTextContentType()", code: """
        TextEditor(text: $source)
            .font(.system(.body, design: .monospaced))
            .accessibilityTextContentType(.sourceCode)
        """) { AnyView(Ax_TextContentTypeExample()) },

        ExampleEntry(topic: ".accessibilityValue()", code: """
        Slider(value: $volume, in: 0...100)
            .accessibilityLabel("Volume")
            .accessibilityValue("\\(Int(volume)) percent")
        """) { AnyView(Ax_ValueExample()) },

        ExampleEntry(topic: ".accessibilityZoomAction()", code: """
        FloorPlanView(scale: scale)
            .accessibilityZoomAction { action in
                switch action.direction {
                case .zoomIn:  scale *= 1.25
                case .zoomOut: scale /= 1.25
                @unknown default: break
                }
            }
        """) { AnyView(Ax_ZoomActionExample()) },

        ExampleEntry(topic: ".speechAdjustedPitch()", code: """
        Text("Strike three, you're out")
            .speechAdjustedPitch(-0.3)
        """) { AnyView(Ax_SpeechPitchExample()) },

        ExampleEntry(topic: ".speechAlwaysIncludesPunctuation()", code: """
        Text("let total = price * quantity")
            .font(.system(.body, design: .monospaced))
            .speechAlwaysIncludesPunctuation()
        """) { AnyView(Ax_SpeechPunctuationExample()) },

        ExampleEntry(topic: ".speechAnnouncementsQueued()", code: """
        ScoreTicker(text: latestUpdate)
            .speechAnnouncementsQueued()
        """) { AnyView(Ax_SpeechQueuedExample()) },

        ExampleEntry(topic: ".speechSpellsOutCharacters()", code: """
        Text(verificationCode)
            .speechSpellsOutCharacters()
        """) { AnyView(Ax_SpeechSpellsOutExample()) },

        ExampleEntry(topic: "@AccessibilityFocusState", code: """
        @AccessibilityFocusState private var isErrorFocused: Bool

        ErrorBanner(message: message)
            .accessibilityFocused($isErrorFocused)
            .onChange(of: message) { isErrorFocused = true }
        """) { AnyView(Ax_FocusStateExample()) },

        ExampleEntry(topic: "AccessibilityActionCategory", code: """
        MessageComposer(draft: $draft)
            .accessibilityActions(category: .edit) {
                Button("Attach photo") { last = "Attach photo" }
                Button("Insert checklist") { last = "Insert checklist" }
            }
        """) { AnyView(Ax_ActionCategoryExample()) },

        ExampleEntry(topic: "AccessibilityActionKind", code: """
        CardFace(card: card)
            // .default is plain activation; .escape/.showMenu are also standard.
            .accessibilityAction(.default) { activated.toggle() }
        """) { AnyView(Ax_ActionKindExample()) },

        ExampleEntry(topic: "AccessibilityAdjustmentDirection", code: """
        PreviewText(scale: fontScale)
            .accessibilityAdjustableAction { direction in
                switch direction {
                case .increment: fontScale += 0.1
                case .decrement: fontScale -= 0.1
                @unknown default: break
                }
            }
        """) { AnyView(Ax_AdjustmentDirectionExample()) },

        ExampleEntry(topic: "AccessibilityChildBehavior", code: """
        GaugeCluster(speed: speed, fuel: fuel)
            .accessibilityElement(children: behavior)
        // behavior is one of .ignore, .combine, .contain
        """) { AnyView(Ax_ChildBehaviorExample()) },

        ExampleEntry(topic: "AccessibilityCustomContentKey", code: """
        extension AccessibilityCustomContentKey {
            static let servings = AccessibilityCustomContentKey("Servings", id: "servings")
        }

        RecipeCard(recipe: recipe)
            .accessibilityCustomContent(.servings, "4", importance: .high)
        """) { AnyView(Ax_CustomContentKeyExample()) },

        ExampleEntry(topic: "AccessibilityDirectTouchOptions", code: """
        SynthKeyboard(voice: voice)
            .accessibilityDirectTouch(options: [.silentOnTouch, .requiresActivation])
        """) { AnyView(Ax_DirectTouchOptionsExample()) },

        ExampleEntry(topic: "AccessibilityHeadingLevel", code: """
        Text("Appendix")
            .accessibilityHeading(.h1)
        Text("A.1 Sources")
            .accessibilityHeading(.h2)
        """) { AnyView(Ax_HeadingLevelExample()) },

        ExampleEntry(topic: "AccessibilityLabeledPairRole", code: """
        Text("Wind")
            .accessibilityLabeledPair(role: .label, id: "wind", in: pairing)
        Text("12 mph")
            .accessibilityLabeledPair(role: .content, id: "wind", in: pairing)
        """) { AnyView(Ax_LabeledPairRoleExample()) },

        ExampleEntry(topic: "AccessibilityNotification", code: """
        Button("Finish download") {
            AccessibilityNotification.Announcement("Download complete").post()
            posted = true
        }
        """) { AnyView(Ax_NotificationExample()) },

        ExampleEntry(topic: "accessibilityQuickActionsEnabled", code: """
        @Environment(\\.accessibilityQuickActionsEnabled) private var quickActionsEnabled

        WorkoutControls(showsPauseHint: quickActionsEnabled)
        """) { AnyView(Ax_QuickActionsEnabledExample()) },

        ExampleEntry(topic: "AccessibilityRotorEntry", code: """
        TextView(article.body)
            .accessibilityRotor("Bookmarks") {
                ForEach(bookmarks) { bookmark in
                    AccessibilityRotorEntry(Text(bookmark.title), id: bookmark.id)
                }
            }
        """) { AnyView(Ax_RotorEntryTypeExample()) },

        ExampleEntry(topic: "AccessibilitySystemRotor", code: """
        DocumentView(sections: sections)
            .accessibilityRotor(.headings) {
                ForEach(sections) { section in
                    AccessibilityRotorEntry(Text(section.title), id: section.id)
                }
            }
        """) { AnyView(Ax_SystemRotorExample()) },

        ExampleEntry(topic: "AccessibilityTextContentType", code: """
        ConsoleView(log: buildLog)
            .font(.system(.callout, design: .monospaced))
            .accessibilityTextContentType(.console)
        """) { AnyView(Ax_TextContentTypeTypeExample()) },

        ExampleEntry(topic: "AccessibilityTraits", code: """
        let traits: AccessibilityTraits = [.isButton, .isSelected]

        Text("Inbox")
            .accessibilityAddTraits(traits)
        """) { AnyView(Ax_TraitsExample()) },

        ExampleEntry(topic: "AccessibilityZoomGestureAction", code: """
        FloorPlanView(scale: scale)
            .accessibilityZoomAction { action in
                anchor = action.location          // UnitPoint
                scale *= action.direction == .zoomIn ? 1.2 : 0.8
            }
        """) { AnyView(Ax_ZoomGestureActionExample()) },

        ExampleEntry(topic: "AXChartDescriptorRepresentable", code: """
        struct RainfallDescriptor: AXChartDescriptorRepresentable {
            let data: [RainReading]
            func makeChartDescriptor() -> AXChartDescriptor {
                AXChartDescriptor(title: "Rainfall", summary: "Daily totals",
                                  xAxis: dayAxis, yAxis: inchesAxis, series: [series])
            }
        }

        RainfallChart(data: readings)
            .accessibilityChartDescriptor(RainfallDescriptor(data: readings))
        """) { AnyView(Ax_ChartDescriptorRepresentableExample()) },
    ]
}

// MARK: - Shared helpers

/// A small caption explaining an effect that assistive technology produces but
/// that is not visible on screen.
private struct Ax_Note: View {
    let text: String
    var symbol: String = "accessibility"
    init(_ text: String, symbol: String = "accessibility") {
        self.text = text
        self.symbol = symbol
    }
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 6) {
            Image(systemName: symbol)
                .imageScale(.small)
                .foregroundStyle(.tint)
            Text(text)
                .font(.caption)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

/// A caption used when the demo is a stand-in for an API that cannot execute on macOS.
private struct Ax_IllustrativeNote: View {
    let text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 6) {
            Image(systemName: "info.circle")
                .imageScale(.small)
                .foregroundStyle(.orange)
            Text(text)
                .font(.caption)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct Ax_Message: Identifiable {
    let id: Int
    let subject: String
    let isUnread: Bool
}

private struct Ax_Section: Identifiable {
    let id: Int
    let title: String
}

private extension AccessibilityCustomContentKey {
    static let servings = AccessibilityCustomContentKey("Servings", id: "servings")
}

// MARK: - .accessibilityAction()

private struct Ax_AccessibilityActionExample: View {
    @State private var last = "none"

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.title)
                    .foregroundStyle(.blue)
                VStack(alignment: .leading) {
                    Text("Dana Wu").font(.subheadline.bold())
                    Text("Lunch tomorrow?").font(.caption).foregroundStyle(.secondary)
                }
                Spacer()
            }
            .padding(10)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            .accessibilityElement(children: .combine)
            .accessibilityAction(named: "Reply") { last = "Reply" }
            .accessibilityAction(named: "Archive") { last = "Archive" }

            Text("Last action: \(last)")
                .font(.callout)
            Ax_Note("Focus the row in VoiceOver, open the actions menu, and choose Reply or Archive.")
        }
    }
}

// MARK: - .accessibilityActions()

private struct Ax_AccessibilityActionsExample: View {
    @State private var last = "none"

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("Groceries", systemImage: "note.text")
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
                .accessibilityActions {
                    Button("Pin") { last = "Pin" }
                    Button("Delete", role: .destructive) { last = "Delete" }
                }

            Text("Last action: \(last)").font(.callout)
            Ax_Note("Each Button in the closure becomes one custom action, keeping its title and role.")
        }
    }
}

// MARK: - .accessibilityActivationPoint()

private struct Ax_AccessibilityActivationPointExample: View {
    @State private var on = true

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Notifications")
                Spacer()
                Toggle("", isOn: $on).labelsHidden()
            }
            .padding(10)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            .accessibilityElement(children: .combine)
            .accessibilityActivationPoint(UnitPoint(x: 0.92, y: 0.5))

            Ax_Note("The synthesized double-tap is aimed at the trailing toggle instead of the row's center.")
        }
    }
}

// MARK: - .accessibilityAddTraits()

private struct Ax_AccessibilityAddTraitsExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Now Playing")
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            HStack(spacing: 10) {
                Image(systemName: "music.note")
                    .foregroundStyle(.pink)
                Text("Everywhere at Once").foregroundStyle(.secondary)
            }
            Ax_Note("The .isHeader trait makes this reachable through VoiceOver's headings rotor.")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - .accessibilityAdjustableAction()

private struct Ax_AdjustableActionExample: View {
    @State private var quantity = 2

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 16) {
                Button { quantity = max(0, quantity - 1) } label: {
                    Image(systemName: "minus.circle.fill")
                }
                .buttonStyle(.plain)

                Text("\(quantity)")
                    .font(.title.monospacedDigit().bold())
                    .frame(minWidth: 44)
                    .accessibilityLabel("Quantity")
                    .accessibilityValue("\(quantity)")
                    .accessibilityAdjustableAction { direction in
                        switch direction {
                        case .increment: quantity += 1
                        case .decrement: quantity = max(0, quantity - 1)
                        @unknown default: break
                        }
                    }

                Button { quantity += 1 } label: {
                    Image(systemName: "plus.circle.fill")
                }
                .buttonStyle(.plain)
            }
            .font(.title2)
            .foregroundStyle(.blue)

            Ax_Note("VoiceOver swipes up/down on the number run the same increment and decrement.")
        }
    }
}

// MARK: - .accessibilityChartDescriptor()

private struct Ax_Sparkline: View {
    let values: [Double]
    var tint: Color = .blue
    var body: some View {
        GeometryReader { geo in
            let maxV = values.max() ?? 1
            let step = values.count > 1 ? geo.size.width / CGFloat(values.count - 1) : 0
            Path { p in
                for (i, v) in values.enumerated() {
                    let x = CGFloat(i) * step
                    let y = geo.size.height * (1 - CGFloat(v / maxV))
                    if i == 0 { p.move(to: CGPoint(x: x, y: y)) }
                    else { p.addLine(to: CGPoint(x: x, y: y)) }
                }
            }
            .stroke(tint.gradient, style: .init(lineWidth: 2.5, lineJoin: .round))
        }
    }
}

private struct Ax_ChartDescriptorExample: View {
    private let readings = [3.0, 5, 4, 7, 6, 9, 8, 11]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Ax_Sparkline(values: readings, tint: .orange)
                .frame(height: 80)
                .padding(.horizontal, 4)
            Ax_IllustrativeNote("The chart draws visually; .accessibilityChartDescriptor(_:) also lets VoiceOver play it as an Audio Graph you hear as pitch over time.")
        }
    }
}

// MARK: - .accessibilityChildren()

private struct Ax_ChildrenExample: View {
    private let sales = [("Jan", 12), ("Feb", 18), ("Mar", 9), ("Apr", 21)]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .bottom, spacing: 10) {
                ForEach(sales, id: \.0) { month, total in
                    VStack(spacing: 4) {
                        RoundedRectangle(cornerRadius: 3)
                            .fill(.teal.gradient)
                            .frame(width: 18, height: CGFloat(total) * 3.5)
                        Text(month).font(.caption2).foregroundStyle(.secondary)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .accessibilityChildren {
                ForEach(sales, id: \.0) { month, total in
                    Text("\(month): \(total) units")
                }
            }
            Ax_Note("The drawn bars are one canvas; the closure supplies a navigable child per bar for VoiceOver.")
        }
    }
}

// MARK: - .accessibilityCustomContent()

private struct Ax_RecipeCardMini: View {
    let title: String
    let subtitle: String
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "fork.knife.circle.fill")
                .font(.title)
                .foregroundStyle(.green)
            VStack(alignment: .leading) {
                Text(title).font(.subheadline.bold())
                Text(subtitle).font(.caption).foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(10)
        .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
    }
}

private struct Ax_CustomContentExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Ax_RecipeCardMini(title: "Lemon Pasta", subtitle: "Weeknight favorite")
                .accessibilityElement(children: .combine)
                .accessibilityCustomContent("Prep time", "25 minutes")
                .accessibilityCustomContent("Difficulty", "Easy", importance: .high)
            Ax_Note("The card's label stays short; prep time and difficulty are read through the 'more content' rotor.")
        }
    }
}

// MARK: - .accessibilityDirectTouch()

private struct Ax_DirectTouchExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3), spacing: 8) {
                ForEach(0..<6, id: \.self) { i in
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.purple.opacity(0.25))
                        .overlay(Image(systemName: "hand.tap.fill").foregroundStyle(.purple))
                        .frame(height: 40)
                }
            }
            Ax_IllustrativeNote("Illustrative — iOS/tvOS. On those platforms touches pass straight to the pads, bypassing VoiceOver's explore-by-touch.")
        }
    }
}

// MARK: - .accessibilityDragPoint()

private struct Ax_DragPointExample: View {
    @State private var trimStart = 0.25

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack(alignment: .leading) {
                Capsule().fill(.quaternary).frame(height: 12)
                Capsule().fill(.blue).frame(width: 120, height: 12)
                    .offset(x: trimStart * 60)
                Circle()
                    .fill(.white)
                    .frame(width: 22, height: 22)
                    .shadow(radius: 1)
                    .overlay(Circle().stroke(.blue, lineWidth: 2))
                    .offset(x: trimStart * 200)
                    .accessibilityLabel("Trim start")
                    .accessibilityDragPoint(.center, description: "Adjust trim start")
            }
            .frame(height: 24)

            Ax_Note("Naming the pickup point lets VoiceOver users start the drag from the actions menu.")
        }
    }
}

// MARK: - .accessibilityDropPoint()

private struct Ax_DropPointExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                ForEach(["Sunrise", "Away", "Movie"], id: \.self) { name in
                    VStack(spacing: 4) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.indigo.gradient)
                            .frame(width: 56, height: 44)
                            .overlay(Image(systemName: "wand.and.stars").foregroundStyle(.white))
                        Text(name).font(.caption2)
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityDropPoint(.leading, description: "Run \(name)")
                }
            }
            Ax_Note("Each tile becomes a named drop destination VoiceOver can offer when completing a drag.")
        }
    }
}

// MARK: - .accessibilityElement()

private struct Ax_ElementExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Central Station")
                Text("arrives in 4 min").foregroundStyle(.secondary).font(.caption)
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            .accessibilityElement(children: .combine)

            Ax_Note("children: .combine merges both lines into one element — one swipe per row instead of two.")
        }
    }
}

// MARK: - .accessibilityFocused()

private struct Ax_FocusedExample: View {
    private enum Field { case email, password }
    @AccessibilityFocusState private var focused: Field?
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .accessibilityFocused($focused, equals: .email)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .accessibilityFocused($focused, equals: .password)

            Button("Focus password") { focused = .password }
                .buttonStyle(.bordered)

            Ax_Note("One enum-valued state ties both fields together; setting it moves the VoiceOver cursor.")
        }
    }
}

// MARK: - .accessibilityHeading()

private struct Ax_HeadingExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Today")
                .font(.title2.bold())
                .accessibilityHeading(.h2)
            Text("Sunny, light breeze. High of 74°, low of 58°.")
                .font(.callout)
                .foregroundStyle(.secondary)
            Ax_Note("An explicit level gives long content a real outline the headings rotor can walk.")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - .accessibilityHidden()

private struct Ax_HiddenExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 6) {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                    .accessibilityHidden(true)
                Text("Featured").font(.headline)
            }
            .padding(10)
            .background(.quaternary.opacity(0.5), in: .capsule)
            Ax_Note("The decorative star is dropped from the tree; VoiceOver still reads 'Featured'.")
        }
    }
}

// MARK: - .accessibilityHint()

private struct Ax_HintExample: View {
    @State private var archived = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button("Archive") { archived = true }
                .buttonStyle(.borderedProminent)
                .accessibilityHint("Moves the conversation out of your inbox")
            Text(archived ? "Archived." : "In your inbox")
                .font(.caption).foregroundStyle(.secondary)
            Ax_Note("VoiceOver speaks the hint after the label; write it as the result, not an instruction.")
        }
    }
}

// MARK: - .accessibilityIdentifier()

private struct Ax_IdentifierExample: View {
    @State private var email = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .accessibilityIdentifier("signup.emailField")
            Ax_Note("The identifier is never spoken; XCUITest queries locate the field by it, ignoring localized labels.", symbol: "checkmark.seal")
        }
    }
}

// MARK: - .accessibilityIgnoresInvertColors()

private struct Ax_IgnoresInvertColorsExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            RoundedRectangle(cornerRadius: 12)
                .fill(LinearGradient(colors: [.orange, .pink, .purple],
                                     startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(height: 80)
                .overlay(Image(systemName: "photo").font(.largeTitle).foregroundStyle(.white.opacity(0.8)))
            Ax_IllustrativeNote("Illustrative — iOS/iPadOS. Smart Invert would flip this artwork; the modifier marks media to keep its true colors.")
        }
    }
}

// MARK: - .accessibilityInputLabels()

private struct Ax_InputLabelsExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {}) {
                Image(systemName: "square.and.pencil")
                    .font(.title2)
            }
            .buttonStyle(.bordered)
            .accessibilityLabel("Compose message")
            .accessibilityInputLabels(["Compose", "New message", "Write"])
            Ax_Note("Voice Control accepts any of these short names — 'Compose' triggers a button labeled 'Compose message'.", symbol: "mic")
        }
    }
}

// MARK: - .accessibilityLabel()

private struct Ax_LabelExample: View {
    @State private var isFavorite = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button {
                isFavorite.toggle()
            } label: {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .font(.title2)
                    .foregroundStyle(isFavorite ? .yellow : .secondary)
            }
            .buttonStyle(.bordered)
            .accessibilityLabel(isFavorite ? "Remove favorite" : "Add favorite")
            Ax_Note("The label replaces the inferred name for this icon-only button and tracks its state.")
        }
    }
}

// MARK: - .accessibilityLabeledPair()

private struct Ax_LabeledPairExample: View {
    @Namespace private var pairing

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                Text("High")
                    .foregroundStyle(.secondary)
                    .accessibilityLabeledPair(role: .label, id: "high", in: pairing)
                Text("74°")
                    .font(.title3.bold())
                    .accessibilityLabeledPair(role: .content, id: "high", in: pairing)
            }
            .padding(10)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            Ax_Note("The shared id pairs label and value so VoiceOver reads them together and skips a stop.")
        }
    }
}

// MARK: - .accessibilityLinkedGroup()

private struct Ax_LinkedGroupExample: View {
    @Namespace private var storyLink

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 12) {
                Text("Mars sample returns to Earth")
                    .font(.subheadline.bold())
                    .accessibilityLinkedGroup(id: "story", in: storyLink)
                RoundedRectangle(cornerRadius: 8)
                    .fill(.red.gradient)
                    .frame(width: 52, height: 40)
                    .overlay(Image(systemName: "globe").foregroundStyle(.white))
                    .accessibilityLinkedGroup(id: "story", in: storyLink)
            }
            Ax_Note("Headline and thumbnail share an id, so VoiceOver reads them as parts of one story.")
        }
    }
}

// MARK: - .accessibilityQuickAction()

private struct Ax_QuickActionExample: View {
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle().fill(.black)
                VStack(spacing: 2) {
                    Text("12:04").font(.caption).foregroundStyle(.green)
                    Text("Running").font(.caption2).foregroundStyle(.white.opacity(0.7))
                    Image(systemName: "hand.pinch.fill").foregroundStyle(.white.opacity(0.8))
                }
            }
            .frame(width: 96, height: 96)
            Ax_IllustrativeNote("Illustrative — watchOS. A double-pinch triggers the registered quick action (Pause workout).")
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - .accessibilityRemoveTraits()

private struct Ax_RemoveTraitsExample: View {
    @State private var playing = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: playing ? "pause.fill" : "play.fill")
                .font(.title)
                .foregroundStyle(.blue)
                .padding(10)
                .background(.quaternary.opacity(0.5), in: .circle)
                .onTapGesture { playing.toggle() }
                .accessibilityLabel("Play")
                .accessibilityRemoveTraits(.isImage)
                .accessibilityAddTraits(.isButton)
            Ax_Note("This tappable glyph should read as a button, not an image — remove .isImage, add .isButton.")
        }
    }
}

// MARK: - .accessibilityRepresentation()

private struct Ax_RepresentationExample: View {
    @State private var progress = 0.4

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // A hand-drawn "waveform scrubber".
            HStack(alignment: .center, spacing: 3) {
                ForEach(0..<28, id: \.self) { i in
                    let filled = Double(i) / 28.0 <= progress
                    Capsule()
                        .fill(filled ? Color.accentColor : Color.secondary.opacity(0.3))
                        .frame(width: 4, height: (i % 3 == 0 ? 28 : 16))
                }
            }
            .frame(maxWidth: .infinity)
            .accessibilityRepresentation {
                Slider(value: $progress, in: 0...1) {
                    Text("Playback position")
                }
            }

            Slider(value: $progress, in: 0...1)
                .controlSize(.small)
            Ax_Note("The custom scrubber borrows a real Slider's accessibility — value, traits, and adjust gesture.")
        }
    }
}

// MARK: - .accessibilityRespondsToUserInteraction()

private struct Ax_RespondsToInteractionExample: View {
    @State private var flipped = false

    var body: some View {
        VStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 12)
                .fill(flipped ? AnyShapeStyle(.blue.gradient) : AnyShapeStyle(.quaternary))
                .frame(height: 70)
                .overlay(Text(flipped ? "7 ♣" : "Tap to flip").foregroundStyle(flipped ? .white : .secondary))
                .onTapGesture { flipped.toggle() }
                .accessibilityRespondsToUserInteraction(true)
            Ax_Note("Tells Switch Control and Voice Control this gesture-driven card genuinely does something.")
        }
    }
}

// MARK: - .accessibilityRotor()

private struct Ax_RotorExample: View {
    private let messages = [
        Ax_Message(id: 1, subject: "Invoice #2231", isUnread: true),
        Ax_Message(id: 2, subject: "Re: standup notes", isUnread: false),
        Ax_Message(id: 3, subject: "Security alert", isUnread: true),
        Ax_Message(id: 4, subject: "Lunch?", isUnread: false),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            List(messages) { message in
                HStack {
                    Circle().fill(message.isUnread ? .blue : .clear).frame(width: 7)
                    Text(message.subject)
                        .fontWeight(message.isUnread ? .semibold : .regular)
                }
            }
            .frame(height: 120)
            .accessibilityRotor("Unread",
                                entries: messages.filter(\.isUnread),
                                entryLabel: \.subject)
            Ax_Note("Twist to the 'Unread' rotor, then flick to hop between just the unread subjects.")
        }
    }
}

// MARK: - .accessibilityRotorEntry()

private struct Ax_RotorEntryExample: View {
    @Namespace private var headings
    private let sections = [
        Ax_Section(id: 1, title: "Overview"),
        Ax_Section(id: 2, title: "Installation"),
        Ax_Section(id: 3, title: "Troubleshooting"),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 6) {
                ForEach(sections) { section in
                    Text(section.title)
                        .font(.subheadline.bold())
                        .accessibilityRotorEntry(id: section.id, in: headings)
                }
            }
            .accessibilityRotor("Sections") {
                ForEach(sections) { section in
                    AccessibilityRotorEntry(Text(section.title), id: section.id, in: headings)
                }
            }
            Ax_Note("The modifier marks which on-screen view each rotor entry's id resolves to.")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - .accessibilityScrollAction()

private struct Ax_ScrollActionExample: View {
    @State private var index = 0
    private let pages = ["Cover", "Chapter 1", "Chapter 2", "Index"]

    var body: some View {
        VStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 12)
                .fill(.blue.gradient)
                .frame(height: 70)
                .overlay(Text(pages[index]).font(.headline).foregroundStyle(.white))
                .accessibilityScrollAction { edge in
                    if edge == .trailing { index = min(index + 1, pages.count - 1) }
                    if edge == .leading  { index = max(index - 1, 0) }
                }

            HStack {
                Button("‹") { index = max(index - 1, 0) }
                Text("Page \(index + 1) of \(pages.count)").font(.caption).monospacedDigit()
                Button("›") { index = min(index + 1, pages.count - 1) }
            }
            .buttonStyle(.bordered)
            Ax_Note("A VoiceOver three-finger scroll drives the same paging on this non-ScrollView canvas.")
        }
    }
}

// MARK: - .accessibilityShowsLargeContentViewer()

private struct Ax_LargeContentViewerExample: View {
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 24) {
                Image(systemName: "magnifyingglass").font(.title3)
                // Mock enlarged HUD.
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass").font(.title)
                    Text("Search").font(.title3.bold())
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 16).padding(.vertical, 12)
                .background(.black.opacity(0.8), in: .rect(cornerRadius: 14))
            }
            Ax_IllustrativeNote("Illustrative — iOS/iPadOS. Long-pressing the compact glyph at large text sizes pops the HUD on the right.")
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - .accessibilitySortPriority()

private struct Ax_SortPriorityExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(.secondary)
                    .accessibilitySortPriority(-1)
                Spacer()
                Text("Quarterly Report")
                    .font(.headline)
                    .accessibilitySortPriority(1)
            }
            .padding(10)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            Ax_Note("Higher priority is visited first, so the title is read before the dismiss button.")
        }
    }
}

// MARK: - .accessibilityTextContentType()

private struct Ax_TextContentTypeExample: View {
    @State private var source = "func greet() {\n    print(\"Hello, world!\")\n}"

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextEditor(text: $source)
                .font(.system(.callout, design: .monospaced))
                .frame(height: 70)
                .padding(6)
                .background(.quaternary.opacity(0.4), in: .rect(cornerRadius: 8))
                .accessibilityTextContentType(.sourceCode)
            Ax_Note("Marking the text as source code gives VoiceOver line-oriented reading and literal symbols.")
        }
    }
}

// MARK: - .accessibilityValue()

private struct Ax_ValueExample: View {
    @State private var volume = 40.0

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Slider(value: $volume, in: 0...100)
                .accessibilityLabel("Volume")
                .accessibilityValue("\(Int(volume)) percent")
            Text("Volume: \(Int(volume))%")
                .font(.callout.monospacedDigit())
            Ax_Note("VoiceOver reads the value after the label and re-reads it whenever the slider changes.")
        }
    }
}

// MARK: - .accessibilityZoomAction()

private struct Ax_ZoomActionExample: View {
    @State private var scale = 1.0

    var body: some View {
        VStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.green.gradient)
                .frame(width: 80, height: 56)
                .overlay(Image(systemName: "map.fill").foregroundStyle(.white))
                .scaleEffect(scale)
                .frame(height: 90)
                .accessibilityLabel("Floor plan")
                .accessibilityZoomAction { action in
                    switch action.direction {
                    case .zoomIn:  scale *= 1.25
                    case .zoomOut: scale /= 1.25
                    @unknown default: break
                    }
                }

            HStack {
                Button("Zoom out") { scale /= 1.25 }
                Text(String(format: "%.0f%%", scale * 100)).font(.caption).monospacedDigit()
                Button("Zoom in") { scale *= 1.25 }
            }
            .buttonStyle(.bordered)
            Ax_Note("VoiceOver exposes zoom controls that call the handler — no pinch gesture required.")
        }
    }
}

// MARK: - .speechAdjustedPitch()

private struct Ax_SpeechPitchExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Strike three, you're out")
                .font(.title3.bold())
                .speechAdjustedPitch(-0.3)
            Ax_Note("Negative values deepen the synthesized voice; the visual text is unchanged.", symbol: "waveform")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - .speechAlwaysIncludesPunctuation()

private struct Ax_SpeechPunctuationExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("let total = price * quantity")
                .font(.system(.body, design: .monospaced))
                .padding(8)
                .background(.quaternary.opacity(0.4), in: .rect(cornerRadius: 8))
                .speechAlwaysIncludesPunctuation()
            Ax_Note("VoiceOver pronounces every symbol, so the '=' and '*' in this code are not swallowed.", symbol: "waveform")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - .speechAnnouncementsQueued()

private struct Ax_SpeechQueuedExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "sportscourt.fill").foregroundStyle(.green)
                Text("Home 2 — Away 1  ·  78'")
                    .font(.callout.monospacedDigit())
            }
            .padding(8)
            .background(.quaternary.opacity(0.4), in: .capsule)
            .speechAnnouncementsQueued()
            Ax_Note("Frequent score updates queue behind current speech instead of cutting it off.", symbol: "waveform")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - .speechSpellsOutCharacters()

private struct Ax_SpeechSpellsOutExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("4F9K2")
                .font(.system(.title2, design: .monospaced).bold())
                .tracking(4)
            .speechSpellsOutCharacters()
            Ax_Note("VoiceOver reads the verification code letter by letter rather than as a pseudo-word.", symbol: "waveform")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - @AccessibilityFocusState

private struct Ax_FocusStateExample: View {
    @AccessibilityFocusState private var isErrorFocused: Bool
    @State private var showError = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if showError {
                Label("Passwords don't match", systemImage: "exclamationmark.triangle.fill")
                    .font(.callout)
                    .foregroundStyle(.red)
                    .padding(8)
                    .background(.red.opacity(0.12), in: .rect(cornerRadius: 8))
                    .accessibilityFocused($isErrorFocused)
            }
            Button(showError ? "Clear error" : "Show error") {
                showError.toggle()
                if showError { isErrorFocused = true }
            }
            .buttonStyle(.bordered)
            Ax_Note("Setting the state pulls the VoiceOver cursor straight to the error banner when it appears.")
        }
    }
}

// MARK: - AccessibilityActionCategory

private struct Ax_ActionCategoryExample: View {
    @State private var last = "none"
    @State private var draft = "Meeting notes…"

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            TextEditor(text: $draft)
                .frame(height: 54)
                .padding(4)
                .background(.quaternary.opacity(0.4), in: .rect(cornerRadius: 8))
                .accessibilityActions(category: .edit) {
                    Button("Attach photo") { last = "Attach photo" }
                    Button("Insert checklist") { last = "Insert checklist" }
                }
            Text("Last action: \(last)").font(.caption).foregroundStyle(.secondary)
            Ax_Note("category: .edit files these under a separate 'Edit' section in VoiceOver's actions menu.")
        }
    }
}

// MARK: - AccessibilityActionKind

private struct Ax_ActionKindExample: View {
    @State private var activated = false

    var body: some View {
        VStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 12)
                .fill(activated ? AnyShapeStyle(.orange.gradient) : AnyShapeStyle(.quaternary))
                .frame(height: 64)
                .overlay(Text(activated ? "Activated" : "Card").foregroundStyle(activated ? .white : .primary))
                .accessibilityAction(.default) { activated.toggle() }
            Ax_Note(".default is plain activation; .escape maps to the scrub gesture and .showMenu/.delete are macOS-only kinds.")
        }
    }
}

// MARK: - AccessibilityAdjustmentDirection

private struct Ax_AdjustmentDirectionExample: View {
    @State private var fontScale = 1.0

    var body: some View {
        VStack(spacing: 10) {
            Text("Aa")
                .font(.system(size: 22 * fontScale, weight: .semibold))
                .frame(height: 44)
                .accessibilityLabel("Text size")
                .accessibilityValue(String(format: "%.0f percent", fontScale * 100))
                .accessibilityAdjustableAction { direction in
                    switch direction {
                    case .increment: fontScale += 0.1
                    case .decrement: fontScale = max(0.5, fontScale - 0.1)
                    @unknown default: break
                    }
                }
            HStack {
                Button("A−") { fontScale = max(0.5, fontScale - 0.1) }
                Button("A+") { fontScale += 0.1 }
            }
            .buttonStyle(.bordered)
            Ax_Note("The closure's direction is a two-case enum: swipe up increments, swipe down decrements.")
        }
    }
}

// MARK: - AccessibilityChildBehavior

private struct Ax_ChildBehaviorExample: View {
    private enum Choice: String, CaseIterable, Identifiable {
        case ignore, combine, contain
        var id: Self { self }
        var behavior: AccessibilityChildBehavior {
            switch self {
            case .ignore: .ignore
            case .combine: .combine
            case .contain: .contain
            }
        }
    }
    @State private var choice: Choice = .combine

    var body: some View {
        VStack(spacing: 10) {
            Picker("", selection: $choice) {
                ForEach(Choice.allCases) { Text(".\($0.rawValue)").tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            HStack {
                Label("128 bpm", systemImage: "speedometer")
                Spacer()
                Label("72%", systemImage: "fuelpump")
            }
            .font(.caption)
            .padding(10)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            .accessibilityElement(children: choice.behavior)

            Ax_Note(".ignore hides children, .combine merges them into one element, .contain keeps each focusable.")
        }
    }
}

// MARK: - AccessibilityCustomContentKey

private struct Ax_CustomContentKeyExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Ax_RecipeCardMini(title: "Sourdough Loaf", subtitle: "Weekend bake")
                .accessibilityElement(children: .combine)
                .accessibilityCustomContent(.servings, "4", importance: .high)
            Ax_Note("A reusable key defined once keeps the 'Servings' field consistent across every card that emits it.")
        }
    }
}

// MARK: - AccessibilityDirectTouchOptions

private struct Ax_DirectTouchOptionsExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 2) {
                ForEach(0..<10, id: \.self) { i in
                    Rectangle()
                        .fill(i % 2 == 0 ? Color.white : Color.black)
                        .frame(width: 16, height: 48)
                        .overlay(alignment: .bottom) {
                            if i % 2 == 0 {
                                Rectangle().fill(.black).frame(width: 8, height: 28)
                                    .offset(x: 8)
                            }
                        }
                }
            }
            .clipShape(.rect(cornerRadius: 6))
            .overlay(RoundedRectangle(cornerRadius: 6).stroke(.quaternary))
            Ax_IllustrativeNote("Illustrative — iOS/tvOS. [.silentOnTouch, .requiresActivation] silence VoiceOver and gate touches behind activation.")
        }
    }
}

// MARK: - AccessibilityHeadingLevel

private struct Ax_HeadingLevelExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Appendix")
                .font(.title3.bold())
                .accessibilityHeading(.h1)
            Text("A.1 Sources")
                .font(.headline)
                .padding(.leading, 12)
                .accessibilityHeading(.h2)
            Text("A.1.1 Primary")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.leading, 24)
                .accessibilityHeading(.h3)
            Ax_Note("Levels h1–h6 build an outline the headings rotor walks hierarchically — set them by structure, not font size.")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - AccessibilityLabeledPairRole

private struct Ax_LabeledPairRoleExample: View {
    @Namespace private var pairing

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Wind")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .accessibilityLabeledPair(role: .label, id: "wind", in: pairing)
                Text("12 mph")
                    .font(.title3.bold())
                    .accessibilityLabeledPair(role: .content, id: "wind", in: pairing)
            }
            .padding(10)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
            Ax_Note("role: .label marks the name and role: .content the value, so the dashboard cell reads as one unit.")
        }
    }
}

// MARK: - AccessibilityNotification

private struct Ax_NotificationExample: View {
    @State private var posted = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button("Finish download") {
                AccessibilityNotification.Announcement("Download complete").post()
                posted = true
            }
            .buttonStyle(.borderedProminent)

            if posted {
                Label("Posted 'Download complete' announcement", systemImage: "speaker.wave.2.fill")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Ax_Note("Announcement().post() speaks a message without moving focus — one API across all Apple platforms.", symbol: "speaker.wave.2")
        }
    }
}

// MARK: - accessibilityQuickActionsEnabled

private struct Ax_QuickActionsEnabledExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                Image(systemName: "hand.pinch.fill").foregroundStyle(.teal)
                Text("Quick actions: enabled").font(.callout.monospaced())
            }
            .padding(10)
            .background(.quaternary.opacity(0.5), in: .capsule)
            Ax_IllustrativeNote("Illustrative — watchOS. The environment value reports whether the double-pinch quick-action path is active.")
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - AccessibilityRotorEntry

private struct Ax_RotorEntryTypeExample: View {
    private let bookmarks = [
        Ax_Section(id: 1, title: "Getting started"),
        Ax_Section(id: 2, title: "API reference"),
        Ax_Section(id: 3, title: "Changelog"),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 6) {
                ForEach(bookmarks) { b in
                    Label(b.title, systemImage: "bookmark.fill")
                        .font(.subheadline)
                        .id(b.id)
                }
            }
            .accessibilityRotor("Bookmarks") {
                ForEach(bookmarks) { bookmark in
                    AccessibilityRotorEntry(Text(bookmark.title), id: bookmark.id)
                }
            }
            Ax_Note("Each AccessibilityRotorEntry carries a spoken label plus the id of the view focus should land on.")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - AccessibilitySystemRotor

private struct Ax_SystemRotorExample: View {
    private let sections = [
        Ax_Section(id: 1, title: "Introduction"),
        Ax_Section(id: 2, title: "Methods"),
        Ax_Section(id: 3, title: "Results"),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 6) {
                ForEach(sections) { section in
                    Text(section.title)
                        .font(.headline)
                        .id(section.id)
                }
            }
            .accessibilityRotor(.headings) {
                ForEach(sections) { section in
                    AccessibilityRotorEntry(Text(section.title), id: section.id)
                }
            }
            Ax_Note("Feeding the built-in .headings rotor restores structure a custom rendering would otherwise hide.")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - AccessibilityTextContentType

private struct Ax_TextContentTypeTypeExample: View {
    private let log = "› build started\n✓ compiled 128 files\n✗ 1 warning"

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(log)
                .font(.system(.callout, design: .monospaced))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .background(.black.opacity(0.85), in: .rect(cornerRadius: 8))
                .foregroundStyle(.green)
                .accessibilityTextContentType(.console)
            Ax_Note("Values like .console, .sourceCode, and .spreadsheet tune whitespace, punctuation, and navigation.")
        }
    }
}

// MARK: - AccessibilityTraits

private struct Ax_TraitsExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            let traits: AccessibilityTraits = [.isButton, .isSelected]
            Text("Inbox")
                .font(.callout.bold())
                .padding(.horizontal, 14).padding(.vertical, 8)
                .background(.blue, in: .capsule)
                .foregroundStyle(.white)
                .accessibilityAddTraits(traits)
            Ax_Note("AccessibilityTraits is a SetAlgebra, so trait sets compose with array literals before you apply them.")
        }
    }
}

// MARK: - AccessibilityZoomGestureAction

private struct Ax_ZoomGestureActionExample: View {
    @State private var scale = 1.0
    @State private var anchor = UnitPoint.center

    var body: some View {
        VStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.indigo.gradient)
                .frame(width: 78, height: 54)
                .overlay(Image(systemName: "map").foregroundStyle(.white))
                .scaleEffect(scale, anchor: anchor)
                .frame(height: 84)
                .accessibilityLabel("Map")
                .accessibilityZoomAction { action in
                    anchor = action.location
                    scale *= action.direction == .zoomIn ? 1.2 : 0.8
                }

            Text(String(format: "scale %.0f%%  ·  anchor (%.2f, %.2f)", scale * 100, anchor.x, anchor.y))
                .font(.caption2.monospaced())
                .foregroundStyle(.secondary)
            Ax_Note("The action reports .direction plus an anchor as location (UnitPoint) and point (CGPoint).")
        }
    }
}

// MARK: - AXChartDescriptorRepresentable

private struct Ax_ChartDescriptorRepresentableExample: View {
    private let readings = [1.2, 0.4, 2.1, 3.6, 1.9, 0.8, 2.7]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .bottom, spacing: 8) {
                ForEach(Array(readings.enumerated()), id: \.offset) { _, value in
                    RoundedRectangle(cornerRadius: 3)
                        .fill(.cyan.gradient)
                        .frame(width: 16, height: CGFloat(value) * 18 + 4)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Ax_IllustrativeNote("The conformer's makeChartDescriptor() builds axes and series so VoiceOver can play this chart as an Audio Graph.")
        }
    }
}
