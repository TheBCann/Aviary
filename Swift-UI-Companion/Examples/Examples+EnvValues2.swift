//
//  Examples+EnvValues2.swift
//  Swift-UI-Companion
//
//  Rendered usage examples for the entries in CatalogData/gen-envvalues.json.
//  This domain is environment-value heavy: read-only signals, optional actions,
//  and scene/widget context. Where a value cannot change from inside a view
//  (system accessibility switches, always-on dimming) the example previews the
//  effect with local state; where the value belongs to another runtime
//  (WidgetKit, StoreKit, Core Data, wheel pickers) it renders a faithful
//  illustration and the code string keeps the real API.
//

import SwiftUI

enum ExamplesEnvValues2 {
    static let entries: [ExampleEntry] = [
        ExampleEntry(topic: "accessibilityDifferentiateWithoutColor", code: """
        struct StatusDot: View {
            @Environment(\\.accessibilityDifferentiateWithoutColor)
            private var noColor
            let passed: Bool

            var body: some View {
                if noColor {
                    Image(systemName: passed ? "checkmark.circle.fill"
                                             : "xmark.octagon.fill")
                } else {
                    Circle().fill(passed ? .green : .red)
                }
            }
        }
        """) { AnyView(E2_DifferentiateWithoutColorExample()) },

        ExampleEntry(topic: "accessibilityDimFlashingLights", code: """
        struct TrailerSurface: View {
            @Environment(\\.accessibilityDimFlashingLights) private var dim
            var body: some View {
                CustomVideoSurface(item: trailer)
                    .preferredFlashMitigation(dim ? .enabled : .none)
            }
        }
        """) { AnyView(E2_DimFlashingLightsExample()) },

        ExampleEntry(topic: "accessibilityEnabled", code: """
        struct RevenueChart: View {
            @Environment(\\.accessibilityEnabled) private var assistive
            var body: some View {
                BarChart(data: data)
                    .overlay(alignment: .bottom) {
                        if assistive { AudioGraphHint() }
                    }
            }
        }
        """) { AnyView(E2_AccessibilityEnabledExample()) },

        ExampleEntry(topic: "accessibilityInvertColors", code: """
        struct CoverArt: View {
            @Environment(\\.accessibilityInvertColors) private var inverted
            var body: some View {
                AlbumArtwork(album: album)
                    .overlay(inverted ? Color.clear : scrimGradient)
            }
        }
        """) { AnyView(E2_InvertColorsExample()) },

        ExampleEntry(topic: "accessibilityPlayAnimatedImages", code: """
        struct GIFCell: View {
            @Environment(\\.accessibilityPlayAnimatedImages) private var autoplay
            var body: some View {
                AnimatedImageView(asset: asset, playing: autoplay)
                    .overlay { if !autoplay { PlayBadge() } }
            }
        }
        """) { AnyView(E2_PlayAnimatedImagesExample()) },

        ExampleEntry(topic: "accessibilityReduceTransparency", code: """
        struct HUD: View {
            @Environment(\\.accessibilityReduceTransparency) private var reduce
            var body: some View {
                RoundedRectangle(cornerRadius: 16)
                    .fill(reduce ? AnyShapeStyle(.background)
                                 : AnyShapeStyle(.ultraThinMaterial))
            }
        }
        """) { AnyView(E2_ReduceTransparencyExample()) },

        ExampleEntry(topic: "accessibilityShowButtonShapes", code: """
        struct QuietButtonStyle: ButtonStyle {
            @Environment(\\.accessibilityShowButtonShapes) private var showShapes
            func makeBody(configuration: Configuration) -> some View {
                configuration.label
                    .padding(.horizontal, 14).padding(.vertical, 6)
                    .background(showShapes ? AnyShapeStyle(.quaternary)
                                           : AnyShapeStyle(.clear), in: .capsule)
            }
        }
        """) { AnyView(E2_ShowButtonShapesExample()) },

        ExampleEntry(topic: "accessibilitySwitchControlEnabled", code: """
        struct EditorToolbar: View {
            @Environment(\\.accessibilitySwitchControlEnabled) private var switchControl
            var body: some View {
                if switchControl {
                    Menu("Format") { formatActions }
                } else {
                    HStack { formatActions }
                }
            }
        }
        """) { AnyView(E2_SwitchControlEnabledExample()) },

        ExampleEntry(topic: "accessibilityVoiceOverEnabled", code: """
        struct PromoCarousel: View {
            @Environment(\\.accessibilityVoiceOverEnabled) private var voiceOver
            var body: some View {
                CarouselView(items: promos, autoAdvances: !voiceOver)
            }
        }
        """) { AnyView(E2_VoiceOverEnabledExample()) },

        ExampleEntry(topic: "allowedDynamicRange", code: """
        Picker("Range", selection: $range) {
            Text(".standard").tag(Image.DynamicRange.standard)
            Text(".constrainedHigh").tag(Image.DynamicRange.constrainedHigh)
            Text(".high").tag(Image.DynamicRange.high)
        }

        HeroPhoto()
            .allowedDynamicRange(range)
        """) { AnyView(E2_AllowedDynamicRangeExample()) },

        ExampleEntry(topic: "allowsTightening", code: """
        Text("Estimated arrival in 12 minutes")
            .lineLimit(1)
            .allowsTightening(true)
            .truncationMode(.tail)
        """) { AnyView(E2_AllowsTighteningExample()) },

        ExampleEntry(topic: "appearsActive", code: """
        struct TitleBarLabel: View {
            @Environment(\\.appearsActive) private var appearsActive
            var body: some View {
                Label("Project", systemImage: "folder")
                    .foregroundStyle(appearsActive ? .primary : .secondary)
            }
        }
        """) { AnyView(E2_AppearsActiveExample()) },

        ExampleEntry(topic: "autocorrectionDisabled", code: """
        Form {
            TextField("License key", text: $key)
            TextField("Server slug", text: $slug)
        }
        .autocorrectionDisabled()
        """) { AnyView(E2_AutocorrectionDisabledExample()) },

        ExampleEntry(topic: "backgroundMaterial", code: """
        struct OverlayLabel: View {
            @Environment(\\.backgroundMaterial) private var material
            var body: some View {
                Text("Now Playing")
                    .foregroundStyle(material != nil ? .secondary : .primary)
            }
        }

        OverlayLabel()
            .padding()
            .background(.regularMaterial, in: .rect(cornerRadius: 10))
        """) { AnyView(E2_BackgroundMaterialExample()) },

        ExampleEntry(topic: "backgroundProminence", code: """
        struct PriorityBadge: View {
            @Environment(\\.backgroundProminence) private var prominence
            var body: some View {
                Text("Due today")
                    .foregroundStyle(prominence == .increased ? .white : .red)
            }
        }
        // .increased is reported inside a selected List row.
        """) { AnyView(E2_BackgroundProminenceExample()) },

        ExampleEntry(topic: "backgroundStyle", code: """
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.background)   // resolves to the backgroundStyle value

            Image(systemName: "cloud.sun.fill")
                .symbolRenderingMode(.palette)
                .foregroundStyle(.orange, .background)
        }
        .backgroundStyle(.teal.gradient)
        """) { AnyView(E2_BackgroundStyleExample()) },

        ExampleEntry(topic: "buttonRepeatBehavior", code: """
        HStack {
            Button("−") { volume -= 1 }
            Button("+") { volume += 1 }
        }
        .buttonRepeatBehavior(.enabled)   // press-and-hold repeats
        """) { AnyView(E2_ButtonRepeatBehaviorExample()) },

        ExampleEntry(topic: "controlActiveState", code: """
        struct InspectorHeader: View {
            @Environment(\\.controlActiveState) private var activeState
            var body: some View {
                Text("Layers")
                    .opacity(activeState == .inactive ? 0.5 : 1.0)
            }
        }
        // Deprecated — prefer the cross-platform appearsActive Bool.
        """) { AnyView(E2_ControlActiveStateExample()) },

        ExampleEntry(topic: "defaultWheelPickerItemHeight", code: """
        Picker("Minutes", selection: $minutes) {
            ForEach(1..<60) { Text("\\($0)") }
        }
        .pickerStyle(.wheel)
        .environment(\\.defaultWheelPickerItemHeight, 36)
        """) { AnyView(E2_DefaultWheelPickerItemHeightExample()) },

        ExampleEntry(topic: "documentConfiguration", code: """
        struct EditorFooter: View {
            @Environment(\\.documentConfiguration) private var config
            var body: some View {
                if let url = config?.fileURL {
                    Text(url.lastPathComponent).font(.caption)
                }
            }
        }
        """) { AnyView(E2_DocumentConfigurationExample()) },

        ExampleEntry(topic: "headerProminence", code: """
        List {
            Section("Today") {
                ForEach(todayItems) { Text($0.title) }
            }
            .headerProminence(.increased)
        }
        """) { AnyView(E2_HeaderProminenceExample()) },

        ExampleEntry(topic: "imageScale", code: """
        Label("Synced", systemImage: "checkmark.icloud")
            .imageScale(.large)   // .small / .medium / .large
        """) { AnyView(E2_ImageScaleExample()) },

        ExampleEntry(topic: "isLuminanceReduced", code: """
        struct WorkoutClock: View {
            @Environment(\\.isLuminanceReduced) private var dimmed
            var body: some View {
                Text(time, format: .dateTime.hour().minute())
                    .fontWeight(dimmed ? .thin : .bold)
                    .foregroundStyle(dimmed ? .secondary : .primary)
            }
        }
        """) { AnyView(E2_IsLuminanceReducedExample()) },

        ExampleEntry(topic: "isScrollEnabled", code: """
        ScrollView {
            ChartsPage()
        }
        .scrollDisabled(isReordering)
        """) { AnyView(E2_IsScrollEnabledExample()) },

        ExampleEntry(topic: "lineLimit", code: """
        struct SummaryCell: View {
            @Environment(\\.lineLimit) private var lineLimit
            var body: some View {
                Text(article.abstract)
                    .lineLimit(lineLimit ?? 3)
            }
        }
        """) { AnyView(E2_LineLimitExample()) },

        ExampleEntry(topic: "lineSpacing", code: """
        Text(chapterBody)
            .font(.body)
            .lineSpacing(6)
        """) { AnyView(E2_LineSpacingExample()) },

        ExampleEntry(topic: "managedObjectContext", code: """
        struct NotesList: View {
            @Environment(\\.managedObjectContext) private var context
            @FetchRequest(sortDescriptors: [SortDescriptor(\\Note.created)])
            private var notes: FetchedResults<Note>

            var body: some View {
                List(notes) { Text($0.title) }
            }
        }
        """) { AnyView(E2_ManagedObjectContextExample()) },

        ExampleEntry(topic: "materialActiveAppearance", code: """
        NowPlayingBar(track: track)
            .background(.regularMaterial)
            .materialActiveAppearance(.active)   // stay vivid in background windows
        """) { AnyView(E2_MaterialActiveAppearanceExample()) },

        ExampleEntry(topic: "menuOrder", code: """
        Menu("Playback Speed") {
            ForEach([0.5, 1.0, 1.5, 2.0], id: \\.self) { speed in
                Button("\\(speed.formatted())×") { rate = speed }
            }
        }
        .menuOrder(.fixed)
        """) { AnyView(E2_MenuOrderExample()) },

        ExampleEntry(topic: "minimumScaleFactor", code: """
        Text(total, format: .currency(code: "USD"))
            .font(.title.bold())
            .lineLimit(1)
            .minimumScaleFactor(0.6)
        """) { AnyView(E2_MinimumScaleFactorExample()) },

        ExampleEntry(topic: "multilineTextAlignment", code: """
        Text("Drop PDFs here to add them to your library.")
            .multilineTextAlignment(.center)
            .frame(width: 240)
        """) { AnyView(E2_MultilineTextAlignmentExample()) },

        ExampleEntry(topic: "openSettings", code: """
        struct SetupFooter: View {
            @Environment(\\.openSettings) private var openSettings
            var body: some View {
                Button("Configure Sync…") { openSettings() }
            }
        }
        """) { AnyView(E2_OpenSettingsExample()) },

        ExampleEntry(topic: "purchase", code: """
        struct BuyRow: View {
            @Environment(\\.purchase) private var purchase
            let product: Product
            var body: some View {
                Button("Unlock Pro — \\(product.displayPrice)") {
                    Task {
                        let result = try? await purchase(product)
                        if case .success(let v) = result { await handle(v) }
                    }
                }
            }
        }
        """) { AnyView(E2_PurchaseExample()) },

        ExampleEntry(topic: "rename", code: """
        struct SidebarRow: View {
            @Environment(\\.rename) private var rename
            var body: some View {
                Text(name)
                    .contextMenu {
                        Button("Rename") { rename?() }
                    }
            }
        }
        """) { AnyView(E2_RenameExample()) },

        ExampleEntry(topic: "searchSuggestionsPlacement", code: """
        struct SuggestionRow: View {
            @Environment(\\.searchSuggestionsPlacement) private var placement
            let term: String
            var body: some View {
                if placement == .menu {
                    Text(term)
                } else {
                    Label(term, systemImage: "magnifyingglass")
                }
            }
        }
        """) { AnyView(E2_SearchSuggestionsPlacementExample()) },

        ExampleEntry(topic: "showsWidgetContainerBackground", code: """
        struct WeatherWidgetView: View {
            @Environment(\\.showsWidgetContainerBackground) private var hasBackground
            var body: some View {
                TemperatureReadout(reading: reading)
                    .font(hasBackground ? .title2 : .largeTitle)
                    .containerBackground(.thinMaterial, for: .widget)
            }
        }
        """) { AnyView(E2_ShowsWidgetContainerBackgroundExample()) },

        ExampleEntry(topic: "showsWidgetLabel", code: """
        struct CornerGauge: View {
            @Environment(\\.showsWidgetLabel) private var hasLabel
            var body: some View {
                Gauge(value: hydration) { Image(systemName: "drop") }
                    .widgetLabel { Text("\\(Int(hydration * 100))%") }
            }
        }
        """) { AnyView(E2_ShowsWidgetLabelExample()) },

        ExampleEntry(topic: "sizeCategory", code: """
        struct LegacyCheck: View {
            @Environment(\\.sizeCategory) private var category
            var body: some View {
                Text(category.isAccessibilityCategory ? "XL layout" : "Standard")
            }
        }
        // Deprecated — prefer dynamicTypeSize, whose cases compare with < and >.
        """) { AnyView(E2_SizeCategoryExample()) },

        ExampleEntry(topic: "springLoadingBehavior", code: """
        NavigationLink("Projects", value: Folder.projects)
            .springLoadingBehavior(.enabled)
            .dropDestination(for: DocumentItem.self) { items, _ in
                move(items, to: .projects)
            }
        """) { AnyView(E2_SpringLoadingBehaviorExample()) },

        ExampleEntry(topic: "symbolRenderingMode (environment)", code: """
        Image(systemName: "cloud.sun.rain.fill")
            .symbolRenderingMode(.palette)   // monochrome / hierarchical / palette / multicolor
            .foregroundStyle(.blue, .teal)
        """) { AnyView(E2_SymbolRenderingModeExample()) },

        ExampleEntry(topic: "symbolVariants", code: """
        HStack {
            Image(systemName: "heart")
            Image(systemName: "star")
        }
        .symbolVariant(.fill)   // resolves heart → heart.fill
        """) { AnyView(E2_SymbolVariantsExample()) },

        ExampleEntry(topic: "tabViewBottomAccessoryPlacement", code: """
        struct MiniPlayer: View {
            @Environment(\\.tabViewBottomAccessoryPlacement) private var placement
            var body: some View {
                if placement == .inline {
                    HStack { Text(track.title); PlayPauseButton() }
                } else {
                    ExpandedPlayerBar(track: track)
                }
            }
        }
        """) { AnyView(E2_TabViewBottomAccessoryPlacementExample()) },

        ExampleEntry(topic: "textCase", code: """
        Text("Recently Added")
            .textCase(.uppercase)   // .uppercase / .lowercase / nil
        """) { AnyView(E2_TextCaseExample()) },

        ExampleEntry(topic: "truncationMode", code: """
        Text("/Users/dev/Projects/Companion/Sources/App.swift")
            .lineLimit(1)
            .truncationMode(.middle)
        """) { AnyView(E2_TruncationModeExample()) },

        ExampleEntry(topic: "widgetContentMargins", code: """
        struct MapWidgetView: View {
            @Environment(\\.widgetContentMargins) private var margins
            var body: some View {
                RouteMap(route: route)
                    .padding(-margins.leading)   // bleed to the true edge
            }
        }
        """) { AnyView(E2_WidgetContentMarginsExample()) },

        ExampleEntry(topic: "widgetFamily", code: """
        struct StatsWidgetView: View {
            @Environment(\\.widgetFamily) private var family
            var body: some View {
                switch family {
                case .systemSmall: CompactStats()
                case .accessoryCircular: GaugeStat()
                default: FullStats()
                }
            }
        }
        """) { AnyView(E2_WidgetFamilyExample()) },

        ExampleEntry(topic: "widgetRenderingMode", code: """
        struct RingView: View {
            @Environment(\\.widgetRenderingMode) private var mode
            var body: some View {
                ActivityRing(progress: progress)
                    .foregroundStyle(mode == .fullColor
                        ? AnyShapeStyle(.orange) : AnyShapeStyle(.primary))
            }
        }
        """) { AnyView(E2_WidgetRenderingModeExample()) },
    ]
}

// MARK: - Shared caption

private struct E2_Caption: View {
    let text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        Text(text)
            .font(.caption2)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
    }
}

// MARK: - accessibilityDifferentiateWithoutColor

private struct E2_DifferentiateWithoutColorExample: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) private var systemNoColor
    @State private var preview = false

    var body: some View {
        let differentiate = systemNoColor || preview
        VStack(spacing: 14) {
            HStack(spacing: 32) {
                badge("Build", passed: true, differentiate: differentiate)
                badge("Tests", passed: false, differentiate: differentiate)
            }
            Toggle("Preview differentiated mode", isOn: $preview)
                .toggleStyle(.switch).fixedSize()
            Text("System setting: \(systemNoColor ? "on" : "off")")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }

    private func badge(_ title: String, passed: Bool, differentiate: Bool) -> some View {
        VStack(spacing: 6) {
            if differentiate {
                Image(systemName: passed ? "checkmark.circle.fill" : "xmark.octagon.fill")
                    .font(.title)
                    .foregroundStyle(passed ? .green : .red)
            } else {
                Circle().fill(passed ? .green : .red).frame(width: 22, height: 22)
            }
            Text(title).font(.caption)
        }
    }
}

// MARK: - accessibilityDimFlashingLights

private struct E2_DimFlashingLightsExample: View {
    @State private var preview = true

    var body: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 12)
                .fill(preview
                      ? AnyShapeStyle(Color.gray.gradient)
                      : AnyShapeStyle(LinearGradient(colors: [.white, .yellow, .orange],
                                                     startPoint: .topLeading, endPoint: .bottomTrailing)))
                .frame(height: 84)
                .overlay {
                    Label(preview ? "Flash mitigation on" : "Strobe sequence",
                          systemImage: preview ? "sun.min" : "bolt.fill")
                        .font(.callout.weight(.semibold))
                        .foregroundStyle(preview ? AnyShapeStyle(.secondary) : AnyShapeStyle(.black))
                }
            Toggle("Dim flashing lights", isOn: $preview)
                .toggleStyle(.switch).fixedSize()
            E2_Caption("A custom playback pipeline reads the flag and applies its own mitigation.")
        }
        .padding()
    }
}

// MARK: - accessibilityEnabled

private struct E2_AccessibilityEnabledExample: View {
    @Environment(\.accessibilityEnabled) private var systemAssistive
    @State private var preview = true

    var body: some View {
        let assistive = systemAssistive || preview
        VStack(spacing: 12) {
            HStack(alignment: .bottom, spacing: 6) {
                ForEach([0.4, 0.7, 0.55, 0.9, 0.65], id: \.self) { h in
                    RoundedRectangle(cornerRadius: 3)
                        .fill(.blue.gradient)
                        .frame(width: 22, height: 70 * h)
                }
            }
            .frame(height: 70, alignment: .bottom)
            .overlay(alignment: .bottom) {
                if assistive {
                    Label("Audio Graph available", systemImage: "waveform")
                        .font(.caption2.weight(.semibold))
                        .padding(.horizontal, 8).padding(.vertical, 3)
                        .background(.thinMaterial, in: .capsule)
                        .offset(y: 14)
                }
            }
            .padding(.bottom, 10)

            Toggle("Assistive technology active", isOn: $preview)
                .toggleStyle(.switch).fixedSize()
            Text("Live value: \(systemAssistive ? "on" : "off")")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

// MARK: - accessibilityInvertColors

private struct E2_InvertColorsExample: View {
    @Environment(\.accessibilityInvertColors) private var systemInverted
    @State private var preview = false

    var body: some View {
        let inverted = systemInverted || preview
        VStack(spacing: 12) {
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(LinearGradient(colors: [.pink, .purple, .indigo],
                                         startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(height: 90)
                if !inverted {
                    LinearGradient(colors: [.black.opacity(0.6), .clear],
                                   startPoint: .bottom, endPoint: .center)
                        .frame(height: 90)
                        .clipShape(.rect(cornerRadius: 12))
                }
                Text("Nightscape")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(10)
            }
            Toggle("Invert colors", isOn: $preview)
                .toggleStyle(.switch).fixedSize()
            E2_Caption("Artwork drops its own scrim when inverted so Smart Invert doesn't over-darken it.")
        }
        .padding()
    }
}

// MARK: - accessibilityPlayAnimatedImages

private struct E2_PlayAnimatedImagesExample: View {
    @Environment(\.accessibilityPlayAnimatedImages) private var systemAutoplay
    @State private var preview = true

    var body: some View {
        let autoplay = systemAutoplay && preview
        VStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 12).fill(.quaternary).frame(width: 100, height: 80)
                if autoplay {
                    TimelineView(.animation) { context in
                        let t = context.date.timeIntervalSinceReferenceDate
                        Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                            .font(.system(size: 34))
                            .foregroundStyle(.orange)
                            .rotationEffect(.degrees(t.truncatingRemainder(dividingBy: 2) * 180))
                    }
                } else {
                    Image(systemName: "photo")
                        .font(.system(size: 34))
                        .foregroundStyle(.secondary)
                        .overlay(alignment: .bottomTrailing) {
                            Image(systemName: "play.circle.fill")
                                .foregroundStyle(.white, .black)
                                .offset(x: 6, y: 6)
                        }
                }
            }
            Toggle("Play animated images", isOn: $preview)
                .toggleStyle(.switch).fixedSize()
            E2_Caption("When off, show a still frame with an explicit play control.")
        }
        .padding()
    }
}

// MARK: - accessibilityReduceTransparency

private struct E2_ReduceTransparencyExample: View {
    @Environment(\.accessibilityReduceTransparency) private var systemReduce
    @State private var preview = false

    var body: some View {
        let reduce = systemReduce || preview
        VStack(spacing: 12) {
            ZStack {
                LinearGradient(colors: [.blue, .purple, .pink],
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                Text("Now Playing")
                    .font(.headline)
                    .foregroundStyle(reduce ? AnyShapeStyle(.white) : AnyShapeStyle(.primary))
                    .padding(.horizontal, 18).padding(.vertical, 12)
                    .background(reduce ? AnyShapeStyle(Color.black.opacity(0.8))
                                       : AnyShapeStyle(.ultraThinMaterial),
                                in: .rect(cornerRadius: 12))
            }
            .frame(height: 96)
            .clipShape(.rect(cornerRadius: 12))
            Toggle("Reduce transparency", isOn: $preview)
                .toggleStyle(.switch).fixedSize()
            E2_Caption("Hand-rolled glass swaps to a solid fill; system materials do this for free.")
        }
        .padding()
    }
}

// MARK: - accessibilityShowButtonShapes

private struct E2_ShowButtonShapesExample: View {
    @Environment(\.accessibilityShowButtonShapes) private var systemShapes

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 24) {
                sample("off", shapes: false)
                sample("on", shapes: true)
            }
            Text("System setting: \(systemShapes ? "on" : "off")")
                .font(.caption).foregroundStyle(.secondary)
            E2_Caption("Custom ButtonStyles read the flag and add a border so borderless buttons look tappable.")
        }
        .padding()
    }

    private func sample(_ label: String, shapes: Bool) -> some View {
        VStack(spacing: 6) {
            Button("Skip") {}
                .buttonStyle(E2_QuietButtonStyle(showShapes: shapes))
            Text(label).font(.caption2.monospaced()).foregroundStyle(.secondary)
        }
    }
}

private struct E2_QuietButtonStyle: ButtonStyle {
    let showShapes: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 14).padding(.vertical, 6)
            .background(showShapes ? AnyShapeStyle(.quaternary) : AnyShapeStyle(.clear), in: .capsule)
            .overlay { if showShapes { Capsule().stroke(.secondary) } }
            .opacity(configuration.isPressed ? 0.6 : 1)
    }
}

// MARK: - accessibilitySwitchControlEnabled

private struct E2_SwitchControlEnabledExample: View {
    @Environment(\.accessibilitySwitchControlEnabled) private var systemSwitch
    @State private var preview = true

    var body: some View {
        let switchControl = systemSwitch || preview
        VStack(spacing: 12) {
            Group {
                if switchControl {
                    Menu {
                        Button("Bold") {}
                        Button("Italic") {}
                        Button("Underline") {}
                    } label: {
                        Label("Format", systemImage: "textformat")
                    }
                    .menuStyle(.button)
                    .buttonStyle(.bordered)
                    .fixedSize()
                } else {
                    HStack(spacing: 8) {
                        ForEach(["bold", "italic", "underline"], id: \.self) { name in
                            Image(systemName: name)
                                .frame(width: 28, height: 28)
                                .background(.quaternary, in: .rect(cornerRadius: 6))
                        }
                    }
                }
            }
            .frame(height: 40)
            Toggle("Switch Control scanning", isOn: $preview)
                .toggleStyle(.switch).fixedSize()
            E2_Caption("Consolidate many small targets into one menu so sequential scanning stays quick.")
        }
        .padding()
    }
}

// MARK: - accessibilityVoiceOverEnabled

private struct E2_VoiceOverEnabledExample: View {
    @Environment(\.accessibilityVoiceOverEnabled) private var systemVoiceOver
    @State private var preview = true
    @State private var index = 0

    var body: some View {
        let voiceOver = systemVoiceOver || preview
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.teal.gradient)
                .frame(height: 64)
                .overlay {
                    Label(voiceOver ? "Auto-advance paused" : "Promo \(index + 1) of 3",
                          systemImage: voiceOver ? "pause.circle" : "sparkles")
                        .foregroundStyle(.white)
                        .font(.callout.weight(.semibold))
                }
            Toggle("VoiceOver running", isOn: $preview)
                .toggleStyle(.switch).fixedSize()
            E2_Caption("A legitimate behavioral swap: stop an auto-advancing carousel while the reader is on.")
        }
        .padding()
    }
}

// MARK: - allowedDynamicRange

private enum E2_DRChoice: String, CaseIterable, Identifiable {
    case standard, constrainedHigh, high
    var id: Self { self }
    var range: Image.DynamicRange {
        switch self {
        case .standard: .standard
        case .constrainedHigh: .constrainedHigh
        case .high: .high
        }
    }
}

private struct E2_AllowedDynamicRangeExample: View {
    @State private var choice: E2_DRChoice = .constrainedHigh

    var body: some View {
        VStack(spacing: 12) {
            Picker("Range", selection: $choice) {
                ForEach(E2_DRChoice.allCases) { Text(".\($0.rawValue)").tag($0) }
            }
            .pickerStyle(.segmented).labelsHidden()

            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(colors: [.orange, .yellow, .white],
                                     startPoint: .bottom, endPoint: .top))
                .frame(height: 82)
                .overlay(Image(systemName: "sun.max.fill").font(.largeTitle).foregroundStyle(.white))
                .allowedDynamicRange(choice.range)

            E2_Caption("Illustrative — HDR headroom is visible only with HDR content on an HDR display.")
        }
        .padding()
    }
}

// MARK: - allowsTightening

private struct E2_AllowsTighteningExample: View {
    @State private var tighten = true

    var body: some View {
        VStack(spacing: 12) {
            Text("Estimated arrival in 12 minutes")
                .lineLimit(1)
                .allowsTightening(tighten)
                .truncationMode(.tail)
                .frame(width: 188)
                .padding(8)
                .background(.quaternary, in: .rect(cornerRadius: 8))
            Toggle("allowsTightening", isOn: $tighten)
                .toggleStyle(.switch).fixedSize()
            Text(tighten ? "Letters compress slightly to rescue the line."
                         : "Overflow truncates with an ellipsis.")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

// MARK: - appearsActive

private struct E2_AppearsActiveExample: View {
    @Environment(\.appearsActive) private var appearsActive

    var body: some View {
        VStack(spacing: 12) {
            Label("Project", systemImage: "folder")
                .font(.title3)
                .foregroundStyle(appearsActive ? AnyShapeStyle(.primary) : AnyShapeStyle(.secondary))
            HStack(spacing: 6) {
                Circle().fill(appearsActive ? .green : .secondary).frame(width: 10, height: 10)
                Text(appearsActive ? "Window appears active" : "Window in background")
            }
            .font(.caption)
            E2_Caption("Click another window to watch the chrome dim — the value updates live.")
        }
        .padding()
    }
}

// MARK: - autocorrectionDisabled

private struct E2_AutocorrectionDisabledExample: View {
    @State private var key = "SN-8842-XJ"
    @State private var disabled = true

    var body: some View {
        VStack(spacing: 12) {
            E2_AutoField(key: $key)
                .autocorrectionDisabled(disabled)
            Toggle("autocorrectionDisabled", isOn: $disabled)
                .toggleStyle(.switch).fixedSize()
        }
        .padding()
    }
}

private struct E2_AutoField: View {
    @Binding var key: String
    @Environment(\.autocorrectionDisabled) private var isDisabled

    var body: some View {
        VStack(spacing: 6) {
            TextField("License key", text: $key)
                .textFieldStyle(.roundedBorder)
                .frame(width: 220)
            Text("Environment reads: correction \(isDisabled ? "off" : "on")")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

// MARK: - backgroundMaterial

private struct E2_BackgroundMaterialExample: View {
    var body: some View {
        HStack(spacing: 16) {
            panel("on material", material: true)
            panel("no material", material: false)
        }
        .padding()
    }

    private func panel(_ label: String, material: Bool) -> some View {
        ZStack {
            LinearGradient(colors: [.pink, .indigo], startPoint: .top, endPoint: .bottom)
            Group {
                if material {
                    E2_OverlayLabel().padding(10)
                        .background(.regularMaterial, in: .rect(cornerRadius: 10))
                } else {
                    E2_OverlayLabel().padding(10)
                }
            }
        }
        .frame(width: 150, height: 110)
        .clipShape(.rect(cornerRadius: 12))
        .overlay(alignment: .bottom) {
            Text(label).font(.caption2.monospaced())
                .padding(3).background(.black.opacity(0.4), in: .capsule)
                .foregroundStyle(.white).padding(4)
        }
    }
}

private struct E2_OverlayLabel: View {
    @Environment(\.backgroundMaterial) private var material
    var body: some View {
        VStack(spacing: 3) {
            Text("Now Playing")
                .font(.headline)
                .foregroundStyle(material != nil ? AnyShapeStyle(.secondary) : AnyShapeStyle(.white))
            Text("Midnight City")
                .font(.caption)
                .foregroundStyle(material != nil ? AnyShapeStyle(.tertiary) : AnyShapeStyle(.white.opacity(0.85)))
        }
    }
}

// MARK: - backgroundProminence

private struct E2_BackgroundProminenceExample: View {
    @State private var selected = true

    var body: some View {
        VStack(spacing: 10) {
            row("Ship v2.0", increased: false)
            row("Fix crash on launch", increased: selected)
            Toggle("Select the second row", isOn: $selected)
                .toggleStyle(.switch).fixedSize()
            E2_Caption("Illustrative — SwiftUI reports .increased inside a selected List row so accents switch to white.")
        }
        .padding()
    }

    private func row(_ title: String, increased: Bool) -> some View {
        HStack {
            Text(title).foregroundStyle(increased ? .white : .primary)
            Spacer()
            Text("Due today")
                .font(.caption.weight(.semibold))
                .foregroundStyle(increased ? AnyShapeStyle(.white) : AnyShapeStyle(.red))
        }
        .padding(.horizontal, 12).padding(.vertical, 9)
        .frame(width: 230)
        .background(increased ? AnyShapeStyle(Color.accentColor) : AnyShapeStyle(.quaternary),
                    in: .rect(cornerRadius: 8))
    }
}

// MARK: - backgroundStyle

private struct E2_BackgroundStyleExample: View {
    @State private var tinted = true

    var body: some View {
        VStack(spacing: 14) {
            HStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.background)
                    .frame(width: 90, height: 60)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(.secondary))
                Image(systemName: "cloud.sun.fill")
                    .font(.system(size: 40))
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.orange, .background)
            }
            .backgroundStyle(tinted ? AnyShapeStyle(Color.teal.gradient) : AnyShapeStyle(.quaternary))

            Toggle("Tinted backgroundStyle", isOn: $tinted)
                .toggleStyle(.switch).fixedSize()
            E2_Caption("The .background shape style — used by fills and the back layer of palette symbols — reads this value.")
        }
        .padding()
    }
}

// MARK: - buttonRepeatBehavior

private struct E2_ButtonRepeatBehaviorExample: View {
    @State private var volume = 6

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 16) {
                Button { volume = max(0, volume - 1) } label: {
                    Image(systemName: "minus").frame(width: 20)
                }
                Text("\(volume)")
                    .font(.title2.monospacedDigit())
                    .frame(width: 40)
                Button { volume = min(20, volume + 1) } label: {
                    Image(systemName: "plus").frame(width: 20)
                }
            }
            .buttonStyle(.bordered)
            .buttonRepeatBehavior(.enabled)

            E2_Caption("Press and hold a button to repeat the action at an accelerating cadence.")
        }
        .padding()
    }
}

// MARK: - controlActiveState (deprecated → appearsActive)

private struct E2_ControlActiveStateExample: View {
    @Environment(\.appearsActive) private var appearsActive

    var body: some View {
        VStack(spacing: 12) {
            Text("Layers")
                .font(.title3)
                .opacity(appearsActive ? 1.0 : 0.5)
            Text(appearsActive ? "Active" : "Inactive")
                .font(.caption).foregroundStyle(.secondary)
            E2_Caption("controlActiveState is deprecated — rendered here with the modern appearsActive Bool.")
        }
        .padding()
    }
}

// MARK: - defaultWheelPickerItemHeight (watchOS)

private struct E2_DefaultWheelPickerItemHeightExample: View {
    @State private var height: CGFloat = 34
    private let selection = 12

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 8).fill(.blue.opacity(0.18)).frame(height: height)
                VStack(spacing: 0) {
                    ForEach((selection - 1)...(selection + 1), id: \.self) { n in
                        Text("\(n)")
                            .frame(height: height)
                            .font(n == selection ? .title3.bold() : .body)
                            .foregroundStyle(n == selection ? AnyShapeStyle(.primary) : AnyShapeStyle(.secondary))
                    }
                }
            }
            .frame(width: 90)
            .clipShape(.rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.secondary))

            Slider(value: $height, in: 24...48) { Text("Height") }
                .frame(width: 220)
            E2_Caption("Illustrative — wheel pickers and this row-height metric are watchOS only.")
        }
        .padding()
    }
}

// MARK: - documentConfiguration (iOS, macOS)

private struct E2_DocumentConfigurationExample: View {
    @Environment(\.documentConfiguration) private var config

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "doc.text")
                Text(config?.fileURL?.lastPathComponent ?? "Report.md")
                Spacer()
                Text(config?.isEditable == false ? "Read-only" : "Editable")
                    .foregroundStyle(.secondary)
            }
            .font(.callout)
            .padding(10)
            .frame(width: 240)
            .background(.quaternary, in: .rect(cornerRadius: 8))

            Text(config == nil ? "Not in a document scene (config is nil here)."
                               : "Backed by \(config?.fileURL?.lastPathComponent ?? "a document").")
                .font(.caption).foregroundStyle(.secondary)
            E2_Caption("Illustrative — populated inside a DocumentGroup scene.")
        }
        .padding()
    }
}

// MARK: - headerProminence

private struct E2_HeaderProminenceExample: View {
    var body: some View {
        List {
            Section("Standard header") {
                Text("Inbox"); Text("Drafts")
            }
            Section("Increased header") {
                Text("Sent"); Text("Archive")
            }
            .headerProminence(.increased)
        }
        .frame(height: 210)
    }
}

// MARK: - imageScale

private enum E2_ScaleChoice: String, CaseIterable, Identifiable {
    case small, medium, large
    var id: Self { self }
    var scale: Image.Scale {
        switch self {
        case .small: .small
        case .medium: .medium
        case .large: .large
        }
    }
}

private struct E2_ImageScaleExample: View {
    @State private var choice: E2_ScaleChoice = .large

    var body: some View {
        VStack(spacing: 16) {
            Picker("Scale", selection: $choice) {
                ForEach(E2_ScaleChoice.allCases) { Text(".\($0.rawValue)").tag($0) }
            }
            .pickerStyle(.segmented).labelsHidden()

            Label("Synced", systemImage: "checkmark.icloud")
                .font(.title3)
                .imageScale(choice.scale)
        }
        .padding()
    }
}

// MARK: - isLuminanceReduced (iOS, watchOS)

private struct E2_IsLuminanceReducedExample: View {
    @Environment(\.isLuminanceReduced) private var systemReduced
    @State private var preview = false

    var body: some View {
        let dimmed = systemReduced || preview
        VStack(spacing: 12) {
            Text("9:41")
                .font(.system(size: 42, weight: dimmed ? .thin : .bold, design: .rounded))
                .foregroundStyle(dimmed ? AnyShapeStyle(.secondary) : AnyShapeStyle(.primary))
                .frame(maxWidth: .infinity)
                .padding()
                .background(dimmed ? AnyShapeStyle(Color.black)
                                   : AnyShapeStyle(Color.blue.gradient),
                            in: .rect(cornerRadius: 12))

            Toggle("Preview always-on dimming", isOn: $preview)
                .toggleStyle(.switch).fixedSize()
            E2_Caption("Illustrative — the display sets this in iPhone StandBy and the Apple Watch always-on state.")
        }
        .padding()
    }
}

// MARK: - isScrollEnabled

private struct E2_IsScrollEnabledExample: View {
    @State private var locked = false

    var body: some View {
        VStack(spacing: 10) {
            ScrollView {
                VStack(spacing: 6) {
                    ForEach(1...12, id: \.self) { n in
                        Text("Row \(n)")
                            .frame(maxWidth: .infinity)
                            .padding(6)
                            .background(.quaternary, in: .rect(cornerRadius: 6))
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 120)
            .scrollDisabled(locked)

            Toggle("scrollDisabled", isOn: $locked)
                .toggleStyle(.switch).fixedSize()
        }
        .padding()
    }
}

// MARK: - lineLimit

private struct E2_LineLimitExample: View {
    @State private var limit = 2
    private let abstract = "SwiftUI positions overlays with percentage frames, so nothing needs to know about zoom level or device pixel ratio."

    var body: some View {
        VStack(spacing: 12) {
            E2_Abstract(text: abstract)
                .lineLimit(limit)
            Stepper("lineLimit: \(limit)", value: $limit, in: 1...5)
                .fixedSize()
        }
        .padding()
    }
}

private struct E2_Abstract: View {
    let text: String
    @Environment(\.lineLimit) private var limit

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(text)
            Text("Environment lineLimit: \(limit.map(String.init) ?? "none")")
                .font(.caption).foregroundStyle(.secondary)
        }
        .frame(width: 260, alignment: .leading)
    }
}

// MARK: - lineSpacing

private struct E2_LineSpacingExample: View {
    @State private var spacing: CGFloat = 6

    var body: some View {
        VStack(spacing: 12) {
            Text("The quick brown fox jumps over the lazy dog while the sleepy cat watches from the warm windowsill.")
                .frame(width: 240, alignment: .leading)
                .lineSpacing(spacing)
                .padding(8)
                .background(.quaternary, in: .rect(cornerRadius: 8))
            Slider(value: $spacing, in: 0...16) { Text("Spacing") }
                .frame(width: 220)
            Text("lineSpacing: \(Int(spacing)) pt")
                .font(.caption.monospaced()).foregroundStyle(.secondary)
        }
        .padding()
    }
}

// MARK: - managedObjectContext (illustration)

private struct E2_ManagedObjectContextExample: View {
    private let notes = ["Buy milk", "Call dentist", "Ship the release"]

    var body: some View {
        VStack(spacing: 8) {
            ForEach(notes, id: \.self) { note in
                HStack {
                    Image(systemName: "note.text").foregroundStyle(.yellow)
                    Text(note)
                    Spacer()
                }
                .padding(.horizontal, 10).padding(.vertical, 6)
                .frame(width: 240)
                .background(.quaternary, in: .rect(cornerRadius: 6))
            }
            E2_Caption("Illustrative — @FetchRequest reads this Core Data context to run its query and save edits.")
        }
        .padding()
    }
}

// MARK: - materialActiveAppearance

private struct E2_MaterialActiveAppearanceExample: View {
    var body: some View {
        HStack(spacing: 16) {
            card(".active", appearance: .active)
            card(".inactive", appearance: .inactive)
        }
        .padding()
    }

    private func card(_ label: String, appearance: MaterialActiveAppearance) -> some View {
        ZStack {
            LinearGradient(colors: [.orange, .pink], startPoint: .top, endPoint: .bottom)
            VStack(spacing: 4) {
                Text("Now Playing").font(.subheadline.weight(.semibold))
                Text(label).font(.caption.monospaced())
            }
            .padding(12)
            .background(.regularMaterial, in: .rect(cornerRadius: 10))
            .materialActiveAppearance(appearance)
        }
        .frame(width: 150, height: 110)
        .clipShape(.rect(cornerRadius: 12))
    }
}

// MARK: - menuOrder

private struct E2_MenuOrderExample: View {
    @State private var last = "none"

    var body: some View {
        VStack(spacing: 12) {
            Menu("Playback Speed") {
                ForEach([0.5, 1.0, 1.5, 2.0], id: \.self) { speed in
                    Button("\(speed.formatted())×") { last = "\(speed.formatted())×" }
                }
            }
            .menuOrder(.fixed)
            .menuStyle(.button)
            .buttonStyle(.bordered)
            .fixedSize()

            Text("Selected: \(last)")
                .font(.caption).foregroundStyle(.secondary)
            E2_Caption(".fixed keeps the declared order; iOS may reverse .automatic toward the finger.")
        }
        .padding()
    }
}

// MARK: - minimumScaleFactor

private struct E2_MinimumScaleFactorExample: View {
    @State private var factor = 0.6

    var body: some View {
        VStack(spacing: 12) {
            Text("$1,284,569.00")
                .font(.title.bold())
                .lineLimit(1)
                .minimumScaleFactor(factor)
                .frame(width: 150)
                .padding(8)
                .background(.quaternary, in: .rect(cornerRadius: 8))
            Slider(value: $factor, in: 0.3...1) { Text("Factor") }
                .frame(width: 220)
            Text("minimumScaleFactor: \(factor, format: .number.precision(.fractionLength(2)))")
                .font(.caption.monospaced()).foregroundStyle(.secondary)
        }
        .padding()
    }
}

// MARK: - multilineTextAlignment

private enum E2_AlignChoice: String, CaseIterable, Identifiable {
    case leading, center, trailing
    var id: Self { self }
    var alignment: TextAlignment {
        switch self {
        case .leading: .leading
        case .center: .center
        case .trailing: .trailing
        }
    }
}

private struct E2_MultilineTextAlignmentExample: View {
    @State private var choice: E2_AlignChoice = .center

    var body: some View {
        VStack(spacing: 12) {
            Picker("Alignment", selection: $choice) {
                ForEach(E2_AlignChoice.allCases) { Text(".\($0.rawValue)").tag($0) }
            }
            .pickerStyle(.segmented).labelsHidden()

            Text("Drop PDFs here to add them to your library and generate a table of contents.")
                .multilineTextAlignment(choice.alignment)
                .frame(width: 240)
                .padding(10)
                .background(.quaternary, in: .rect(cornerRadius: 8))
        }
        .padding()
    }
}

// MARK: - openSettings (macOS)

private struct E2_OpenSettingsExample: View {
    @Environment(\.openSettings) private var openSettings

    var body: some View {
        VStack(spacing: 12) {
            Button {
                openSettings()
            } label: {
                Label("Configure Sync…", systemImage: "gearshape")
            }
            .buttonStyle(.borderedProminent)
            E2_Caption("Opens the app's Settings scene from any control — the macOS SettingsLink without a link.")
        }
        .padding()
    }
}

// MARK: - purchase (StoreKit, illustration)

private struct E2_PurchaseExample: View {
    @State private var status = "idle"

    var body: some View {
        VStack(spacing: 12) {
            Button {
                status = "presenting confirmation sheet…"
            } label: {
                Label("Unlock Pro — $4.99", systemImage: "cart.fill")
            }
            .buttonStyle(.borderedProminent)

            Text("Status: \(status)")
                .font(.caption).foregroundStyle(.secondary)
            E2_Caption("Illustrative — StoreKit's PurchaseAction presents the real system purchase sheet at runtime.")
        }
        .padding()
    }
}

// MARK: - rename

private struct E2_RenameExample: View {
    @State private var name = "Untitled Playlist"
    @State private var editing = false

    var body: some View {
        VStack(spacing: 12) {
            Group {
                if editing {
                    TextField("Name", text: $name)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 220)
                        .onSubmit { editing = false }
                } else {
                    E2_RenameRow(name: name)
                }
            }
            .renameAction { editing = true }

            E2_Caption("Right-click the row or tap Rename — both call the rename action from the environment.")
        }
        .padding()
    }
}

private struct E2_RenameRow: View {
    let name: String
    @Environment(\.rename) private var rename

    var body: some View {
        HStack {
            Image(systemName: "music.note.list").foregroundStyle(.pink)
            Text(name)
            Spacer()
            Button("Rename") { rename?() }
                .buttonStyle(.bordered)
                .controlSize(.small)
        }
        .frame(width: 240)
        .contextMenu { Button("Rename") { rename?() } }
    }
}

// MARK: - searchSuggestionsPlacement

private struct E2_SearchSuggestionsPlacementExample: View {
    @Environment(\.searchSuggestionsPlacement) private var placement

    var body: some View {
        VStack(spacing: 12) {
            HStack(alignment: .top, spacing: 16) {
                mock(".menu", asMenu: true)
                mock(".content", asMenu: false)
            }
            Text("Live value: \(placement == .menu ? ".menu" : placement == .content ? ".content" : ".automatic")")
                .font(.caption).foregroundStyle(.secondary)
            E2_Caption("Illustrative — read the placement inside .searchSuggestions to fit menu rows or richer content cells.")
        }
        .padding()
    }

    private func mock(_ label: String, asMenu: Bool) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label).font(.caption.monospaced()).foregroundStyle(.secondary)
            VStack(alignment: .leading, spacing: 3) {
                ForEach(["swift", "swiftui", "swift charts"], id: \.self) { term in
                    if asMenu {
                        Text(term).font(.caption)
                    } else {
                        Label(term, systemImage: "magnifyingglass").font(.caption)
                    }
                }
            }
            .padding(8)
            .frame(width: 150, alignment: .leading)
            .background(.quaternary, in: .rect(cornerRadius: 8))
        }
    }
}

// MARK: - showsWidgetContainerBackground (WidgetKit, illustration)

private struct E2_ShowsWidgetContainerBackgroundExample: View {
    @State private var hasBackground = true

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                LinearGradient(colors: [.teal, .indigo], startPoint: .top, endPoint: .bottom)
                    .opacity(0.5)
                VStack(alignment: .leading, spacing: 4) {
                    Label("72°", systemImage: "sun.max.fill")
                        .font(hasBackground ? .title3 : .largeTitle)
                        .foregroundStyle(.orange)
                    Text("Cupertino").font(.caption).foregroundStyle(.secondary)
                    Spacer()
                }
                .padding(12)
                .frame(width: 150, height: 100, alignment: .topLeading)
                .background(hasBackground ? AnyShapeStyle(.thinMaterial) : AnyShapeStyle(.clear),
                            in: .rect(cornerRadius: 16))
            }
            .frame(width: 150, height: 100)
            .clipShape(.rect(cornerRadius: 16))

            Toggle("Container background visible", isOn: $hasBackground)
                .toggleStyle(.switch).fixedSize()
            E2_Caption("Illustrative — the host sets this; when false, expand into the reclaimed padding.")
        }
        .padding()
    }
}

// MARK: - showsWidgetLabel (WidgetKit, watchOS, illustration)

private struct E2_ShowsWidgetLabelExample: View {
    @State private var hasLabel = true

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle().stroke(.blue.opacity(0.25), lineWidth: 8)
                    .frame(width: 66, height: 66)
                Circle().trim(from: 0, to: 0.65)
                    .stroke(.blue, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .frame(width: 66, height: 66)
                Image(systemName: "drop.fill").foregroundStyle(.blue)
                if hasLabel {
                    Text("65%").font(.caption2.weight(.semibold)).offset(y: 46)
                }
            }
            .frame(height: 100)

            Toggle("Corner label shown", isOn: $hasLabel)
                .toggleStyle(.switch).fixedSize()
            E2_Caption("Illustrative — watchOS corner complications supply a curved widgetLabel; drop duplicate text when it shows.")
        }
        .padding()
    }
}

// MARK: - sizeCategory (deprecated → dynamicTypeSize)

private struct E2_SizeCategoryExample: View {
    @State private var size: DynamicTypeSize = .large

    var body: some View {
        VStack(spacing: 12) {
            Picker("Size", selection: $size) {
                Text("S").tag(DynamicTypeSize.small)
                Text("L").tag(DynamicTypeSize.large)
                Text("XL").tag(DynamicTypeSize.xLarge)
                Text("AX3").tag(DynamicTypeSize.accessibility3)
            }
            .pickerStyle(.segmented).labelsHidden()

            E2_TypeSample()
                .dynamicTypeSize(size)

            E2_Caption("sizeCategory is deprecated — dynamicTypeSize replaces it and compares with < and >.")
        }
        .padding()
    }
}

private struct E2_TypeSample: View {
    @Environment(\.dynamicTypeSize) private var size

    var body: some View {
        VStack(spacing: 4) {
            Text("Reader mode").font(.headline)
            Text(size.isAccessibilitySize ? "Accessibility layout" : "Standard layout")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding(10)
        .frame(width: 220)
        .background(.quaternary, in: .rect(cornerRadius: 8))
    }
}

// MARK: - springLoadingBehavior (iOS, macOS)

private struct E2_SpringLoadingBehaviorExample: View {
    @State private var enabled = true

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: "folder.fill").foregroundStyle(.blue)
                Text("Projects")
                Spacer()
                Image(systemName: enabled ? "bolt.fill" : "bolt.slash")
                    .foregroundStyle(enabled ? .yellow : .secondary)
            }
            .padding(10)
            .frame(width: 220)
            .background(.quaternary, in: .rect(cornerRadius: 8))
            .springLoadingBehavior(enabled ? .enabled : .disabled)

            Toggle("springLoadingBehavior", isOn: $enabled)
                .toggleStyle(.switch).fixedSize()
            E2_Caption("Pause a dragged item over the target to spring-load it open mid-drag.")
        }
        .padding()
    }
}

// MARK: - symbolRenderingMode (environment)

private enum E2_SymbolModeChoice: String, CaseIterable, Identifiable {
    case monochrome, hierarchical, palette, multicolor
    var id: Self { self }
    var mode: SymbolRenderingMode {
        switch self {
        case .monochrome: .monochrome
        case .hierarchical: .hierarchical
        case .palette: .palette
        case .multicolor: .multicolor
        }
    }
}

private struct E2_SymbolRenderingModeExample: View {
    @State private var choice: E2_SymbolModeChoice = .hierarchical

    var body: some View {
        VStack(spacing: 14) {
            Picker("Mode", selection: $choice) {
                ForEach(E2_SymbolModeChoice.allCases) { Text($0.rawValue).tag($0) }
            }
            .pickerStyle(.segmented).labelsHidden()

            Image(systemName: "cloud.sun.rain.fill")
                .font(.system(size: 48))
                .symbolRenderingMode(choice.mode)
                .foregroundStyle(.blue, .teal)
        }
        .padding()
    }
}

// MARK: - symbolVariants

private enum E2_VariantChoice: String, CaseIterable, Identifiable {
    case none, fill, circle, slash
    var id: Self { self }
    var variant: SymbolVariants {
        switch self {
        case .none: .none
        case .fill: .fill
        case .circle: .circle
        case .slash: .slash
        }
    }
}

private struct E2_SymbolVariantsExample: View {
    @State private var choice: E2_VariantChoice = .fill

    var body: some View {
        VStack(spacing: 14) {
            Picker("Variant", selection: $choice) {
                ForEach(E2_VariantChoice.allCases) { Text(".\($0.rawValue)").tag($0) }
            }
            .pickerStyle(.segmented).labelsHidden()

            HStack(spacing: 22) {
                Image(systemName: "heart")
                Image(systemName: "star")
                Image(systemName: "bell")
            }
            .font(.system(size: 34))
            .foregroundStyle(.pink)
            .symbolVariant(choice.variant)
        }
        .padding()
    }
}

// MARK: - tabViewBottomAccessoryPlacement (iOS, illustration)

private struct E2_TabViewBottomAccessoryPlacementExample: View {
    @State private var expanded = false

    var body: some View {
        VStack(spacing: 12) {
            Group {
                if expanded {
                    VStack(spacing: 6) {
                        HStack {
                            RoundedRectangle(cornerRadius: 6).fill(.pink.gradient)
                                .frame(width: 34, height: 34)
                            VStack(alignment: .leading) {
                                Text("Midnight City").font(.callout.weight(.semibold)).lineLimit(1)
                                Text("M83").font(.caption).foregroundStyle(.secondary)
                            }
                            Spacer()
                            Image(systemName: "pause.fill")
                        }
                        ProgressView(value: 0.4)
                    }
                } else {
                    HStack {
                        Text("Midnight City").font(.callout).lineLimit(1)
                        Spacer()
                        Image(systemName: "pause.fill")
                    }
                }
            }
            .padding(10)
            .frame(width: 240)
            .background(.regularMaterial, in: .rect(cornerRadius: 12))

            Toggle("Expanded placement", isOn: $expanded)
                .toggleStyle(.switch).fixedSize()
            E2_Caption("Illustrative — an iOS TabView bottom accessory reads its placement as the bar collapses.")
        }
        .padding()
    }
}

// MARK: - textCase

private enum E2_TextCaseChoice: String, CaseIterable, Identifiable {
    case none, uppercase, lowercase
    var id: Self { self }
    var value: Text.Case? {
        switch self {
        case .none: nil
        case .uppercase: .uppercase
        case .lowercase: .lowercase
        }
    }
}

private struct E2_TextCaseExample: View {
    @State private var choice: E2_TextCaseChoice = .uppercase

    var body: some View {
        VStack(spacing: 14) {
            Picker("Case", selection: $choice) {
                ForEach(E2_TextCaseChoice.allCases) { Text($0.rawValue).tag($0) }
            }
            .pickerStyle(.segmented).labelsHidden()

            Text("Recently Added")
                .font(.headline)
                .textCase(choice.value)
                .padding(10)
                .background(.quaternary, in: .rect(cornerRadius: 8))
        }
        .padding()
    }
}

// MARK: - truncationMode

private enum E2_TruncChoice: String, CaseIterable, Identifiable {
    case head, middle, tail
    var id: Self { self }
    var mode: Text.TruncationMode {
        switch self {
        case .head: .head
        case .middle: .middle
        case .tail: .tail
        }
    }
}

private struct E2_TruncationModeExample: View {
    @State private var choice: E2_TruncChoice = .middle

    var body: some View {
        VStack(spacing: 14) {
            Picker("Mode", selection: $choice) {
                ForEach(E2_TruncChoice.allCases) { Text(".\($0.rawValue)").tag($0) }
            }
            .pickerStyle(.segmented).labelsHidden()

            Text("/Users/dev/Projects/Companion/Sources/App.swift")
                .lineLimit(1)
                .truncationMode(choice.mode)
                .frame(width: 230)
                .padding(8)
                .background(.quaternary, in: .rect(cornerRadius: 8))
        }
        .padding()
    }
}

// MARK: - widgetContentMargins (WidgetKit, illustration)

private struct E2_WidgetContentMarginsExample: View {
    @State private var margin: CGFloat = 14

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 16).fill(.green.gradient)
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(.white.opacity(0.8), style: StrokeStyle(lineWidth: 1, dash: [4]))
                    .padding(margin)
                Text("Map").font(.headline).foregroundStyle(.white)
            }
            .frame(width: 160, height: 104)

            Slider(value: $margin, in: 0...24) { Text("Margin") }
                .frame(width: 220)
            E2_Caption("Illustrative — the system sets default margins; read them to bleed a map to the true edge.")
        }
        .padding()
    }
}

// MARK: - widgetFamily (WidgetKit, illustration)

private enum E2_FamilyChoice: String, CaseIterable, Identifiable {
    case small, medium, large
    var id: Self { self }
    var label: String {
        switch self {
        case .small: "S"
        case .medium: "M"
        case .large: "L"
        }
    }
    var size: CGSize {
        switch self {
        case .small: CGSize(width: 92, height: 92)
        case .medium: CGSize(width: 176, height: 92)
        case .large: CGSize(width: 176, height: 140)
        }
    }
}

private struct E2_WidgetFamilyExample: View {
    @State private var family: E2_FamilyChoice = .medium

    var body: some View {
        VStack(spacing: 12) {
            Picker("Family", selection: $family) {
                ForEach(E2_FamilyChoice.allCases) { Text($0.label).tag($0) }
            }
            .pickerStyle(.segmented).labelsHidden()
            .frame(width: 150)

            widget
                .frame(width: family.size.width, height: family.size.height)
                .background(.blue.gradient, in: .rect(cornerRadius: 16))
                .foregroundStyle(.white)

            E2_Caption("Illustrative — one widget view branches on widgetFamily to fit each slot.")
        }
        .padding()
    }

    @ViewBuilder private var widget: some View {
        switch family {
        case .small:
            VStack(spacing: 4) {
                Image(systemName: "chart.bar.fill").font(.title2)
                Text("42").font(.title3.bold())
            }
        case .medium:
            HStack(spacing: 10) {
                Image(systemName: "chart.bar.fill").font(.title)
                VStack(alignment: .leading) {
                    Text("42 sales").font(.callout.weight(.semibold))
                    Text("+12% today").font(.caption)
                }
            }
        case .large:
            VStack(alignment: .leading, spacing: 4) {
                Text("Sales").font(.headline)
                ForEach(["Mon  12", "Tue  20", "Wed  10"], id: \.self) { row in
                    Text(row).font(.caption.monospaced())
                }
            }
            .padding(.horizontal, 8)
        }
    }
}

// MARK: - widgetRenderingMode (WidgetKit, illustration)

private enum E2_RenderModeChoice: String, CaseIterable, Identifiable {
    case fullColor, vibrant, accented
    var id: Self { self }
}

private struct E2_WidgetRenderingModeExample: View {
    @State private var mode: E2_RenderModeChoice = .fullColor

    var body: some View {
        VStack(spacing: 12) {
            Picker("Mode", selection: $mode) {
                ForEach(E2_RenderModeChoice.allCases) { Text($0.rawValue).tag($0) }
            }
            .pickerStyle(.segmented).labelsHidden()

            ZStack {
                if mode != .fullColor {
                    LinearGradient(colors: [.purple, .blue],
                                   startPoint: .topLeading, endPoint: .bottomTrailing)
                }
                VStack(spacing: 6) {
                    Image(systemName: "figure.run").font(.title)
                    Text("6,204 steps").font(.callout.weight(.semibold))
                }
                .foregroundStyle(foreground)
                .padding()
            }
            .frame(width: 160, height: 96)
            .clipShape(.rect(cornerRadius: 16))

            E2_Caption("Illustrative — the Lock Screen renders vibrant and watch faces can render accented, flattening color.")
        }
        .padding()
    }

    private var foreground: AnyShapeStyle {
        switch mode {
        case .fullColor: AnyShapeStyle(.green)
        case .vibrant: AnyShapeStyle(.white.opacity(0.85))
        case .accented: AnyShapeStyle(.yellow)
        }
    }
}
