//
//  ChildExamples+Part15.swift
//  Aviary
//
//  Compiled renderings for variant entries (part 15: gen-envvalues, shapes).
//  One private C15_* struct per variant; every rendering exercises the exact
//  overload the variant names, so siblings can be compared side by side.
//

import SwiftUI
import WidgetKit

enum ChildExamplesPart15 {
    static let entries: [ChildExampleEntry] = [

        // MARK: allowedDynamicRange

        ChildExampleEntry(parent: "allowedDynamicRange", child: "Image.DynamicRange.standard", code: """
        VStack {
            thumbnailGrid                            // three HDR-photo stand-ins
            rangeReadout                             // reads @Environment(\\.allowedDynamicRange)
        }
        .allowedDynamicRange(.standard)              // every tile tone-maps down to SDR
        """) { AnyView(C15_DynamicRangeStandardExample()) },

        ChildExampleEntry(parent: "allowedDynamicRange", child: "Image.DynamicRange.constrainedHigh", code: """
        Image(systemName: "sun.horizon.fill")        // stands in for an HDR photo
            .resizable()
            .scaledToFit()
            .allowedDynamicRange(.constrainedHigh)   // some headroom, capped peak brightness
        """) { AnyView(C15_DynamicRangeConstrainedExample()) },

        ChildExampleEntry(parent: "allowedDynamicRange", child: "Image.DynamicRange.high", code: """
        struct HeroPhoto: View {
            @Environment(\\.allowedDynamicRange) private var range
            var body: some View {
                heroGradient                         // full-bleed photo stand-in
                    .allowedDynamicRange(range ?? .high)
            }
        }
        """) { AnyView(C15_DynamicRangeHighExample()) },

        // MARK: backgroundProminence

        ChildExampleEntry(parent: "backgroundProminence", child: "BackgroundProminence.standard", code: """
        struct DueBadge: View {
            @Environment(\\.backgroundProminence) private var prominence
            var body: some View {
                Text("Due today")
                    .foregroundStyle(prominence == .standard ? .red : .white)
            }
        }
        """) { AnyView(C15_ProminenceStandardExample()) },

        ChildExampleEntry(parent: "backgroundProminence", child: "BackgroundProminence.increased", code: """
        List(tasks, id: \\.self, selection: $selection) { task in
            HStack {
                Text(task)
                Spacer()
                DueBadge()   // switches to white when prominence == .increased
            }
        }
        """) { AnyView(C15_ProminenceIncreasedExample()) },

        // MARK: buttonRepeatBehavior

        ChildExampleEntry(parent: "buttonRepeatBehavior", child: "ButtonRepeatBehavior.automatic", code: """
        Button("Next Page", systemImage: "arrow.right") { page += 1 }
            .buttonRepeatBehavior(.automatic)
        """) { AnyView(C15_RepeatAutomaticExample()) },

        ChildExampleEntry(parent: "buttonRepeatBehavior", child: "ButtonRepeatBehavior.enabled", code: """
        HStack {
            Button("Decrease", systemImage: "minus") { brightness -= 0.05 }
            Button("Increase", systemImage: "plus") { brightness += 0.05 }
        }
        .buttonRepeatBehavior(.enabled)
        """) { AnyView(C15_RepeatEnabledExample()) },

        ChildExampleEntry(parent: "buttonRepeatBehavior", child: "ButtonRepeatBehavior.disabled", code: """
        HStack {
            Button("Increase", systemImage: "plus") { count += 1 }
            Button("Reset", systemImage: "arrow.counterclockwise") { count = 0 }
                .buttonRepeatBehavior(.disabled)
        }
        .buttonRepeatBehavior(.enabled)
        """) { AnyView(C15_RepeatDisabledExample()) },

        // MARK: documentConfiguration

        ChildExampleEntry(parent: "documentConfiguration", child: "DocumentConfiguration.fileURL", code: """
        struct ShareDocumentButton: View {
            @Environment(\\.documentConfiguration) private var config
            var body: some View {
                if let url = config?.fileURL {
                    ShareLink(item: url) { Label("Share File", systemImage: "square.and.arrow.up") }
                }
            }
        }
        """) { AnyView(C15_DocumentFileURLExample()) },

        ChildExampleEntry(parent: "documentConfiguration", child: "DocumentConfiguration.isEditable", code: """
        struct EditorPane: View {
            @Environment(\\.documentConfiguration) private var config
            @Binding var text: String
            var body: some View {
                TextEditor(text: $text)
                    .disabled(config?.isEditable == false)
            }
        }
        """) { AnyView(C15_DocumentEditableExample()) },

        // MARK: imageScale

        ChildExampleEntry(parent: "imageScale", child: "Image.Scale.small", code: """
        Label("Updated 2m ago", systemImage: "clock")
            .font(.caption)
            .imageScale(.small)
        """) { AnyView(C15_ImageScaleSmallExample()) },

        ChildExampleEntry(parent: "imageScale", child: "Image.Scale.medium", code: """
        HStack {
            Image(systemName: "paperclip")
            Text("3 attachments")
        }
        .imageScale(.medium)
        """) { AnyView(C15_ImageScaleMediumExample()) },

        ChildExampleEntry(parent: "imageScale", child: "Image.Scale.large", code: """
        ContentUnavailableView {
            Label("No Results", systemImage: "magnifyingglass")
                .imageScale(.large)
        } description: {
            Text("Try a different search term.")
        }
        """) { AnyView(C15_ImageScaleLargeExample()) },

        // MARK: materialActiveAppearance

        ChildExampleEntry(parent: "materialActiveAppearance", child: "MaterialActiveAppearance.automatic", code: """
        InspectorPanel()
            .background(.regularMaterial, in: .rect(cornerRadius: 8))
            .materialActiveAppearance(.automatic)   // vivid while the window is key, muted otherwise
        """) { AnyView(C15_MaterialAutomaticExample()) },

        ChildExampleEntry(parent: "materialActiveAppearance", child: "MaterialActiveAppearance.active", code: """
        NowPlayingBar()
            .background(.thinMaterial, in: .rect(cornerRadius: 8))
            .materialActiveAppearance(.active)      // full strength even in a background window
        """) { AnyView(C15_MaterialActiveExample()) },

        ChildExampleEntry(parent: "materialActiveAppearance", child: "MaterialActiveAppearance.inactive", code: """
        SidebarPanel()
            .background(.regularMaterial, in: .rect(cornerRadius: 8))
            .materialActiveAppearance(.inactive)    // always the dimmed form
        """) { AnyView(C15_MaterialInactiveExample()) },

        ChildExampleEntry(parent: "materialActiveAppearance", child: ".materialActiveAppearance(_:)", code: """
        @State private var vivid = true

        CardContent()
            .background(.ultraThinMaterial, in: .rect(cornerRadius: 12))
            .materialActiveAppearance(vivid ? .active : .inactive)
        Toggle("Active appearance", isOn: $vivid)
        """) { AnyView(C15_MaterialModifierExample()) },

        // MARK: menuOrder

        ChildExampleEntry(parent: "menuOrder", child: "MenuOrder.automatic", code: """
        Menu("Sort") {
            Button("Name") { sort = "Name" }
            Button("Date") { sort = "Date" }
            Button("Size") { sort = "Size" }
        }
        .menuOrder(.automatic)
        """) { AnyView(C15_MenuOrderAutomaticExample()) },

        ChildExampleEntry(parent: "menuOrder", child: "MenuOrder.fixed", code: """
        Menu("Playback Speed") {
            ForEach([0.5, 1.0, 1.5, 2.0], id: \\.self) { speed in
                Button(String(format: "%g×", speed)) { rate = speed }
            }
        }
        .menuOrder(.fixed)
        """) { AnyView(C15_MenuOrderFixedExample()) },

        ChildExampleEntry(parent: "menuOrder", child: "MenuOrder.priority", code: """
        Image(systemName: "photo")
            .contextMenu {
                Button("Save to Photos") { last = "Save to Photos" }
                Button("Copy") { last = "Copy" }
                Button("Delete", role: .destructive) { last = "Delete" }
            }
            .menuOrder(.priority)
        """) { AnyView(C15_MenuOrderPriorityExample()) },

        // MARK: purchase (StoreKit)

        ChildExampleEntry(parent: "purchase", child: "PurchaseAction.callAsFunction(_:options:)", code: """
        @Environment(\\.purchase) private var purchase

        func buy(_ product: Product) async throws {
            let result = try await purchase(product, options: [.quantity(3)])
            try await handle(result)
        }
        """) { AnyView(C15_PurchaseCallExample()) },

        ChildExampleEntry(parent: "purchase", child: "Product.PurchaseResult", code: """
        switch result {
        case .success(let verification):
            if case .verified(let transaction) = verification { await transaction.finish() }
        case .pending: showAwaitingApproval()
        case .userCancelled: break
        @unknown default: break
        }
        """) { AnyView(C15_PurchaseResultExample()) },

        ChildExampleEntry(parent: "purchase", child: "Product.PurchaseOption.appAccountToken(_:)", code: """
        let result = try await purchase(
            product,
            options: [.appAccountToken(account.storeToken)]   // a UUID from your own account system
        )
        """) { AnyView(C15_AppAccountTokenExample()) },

        // MARK: searchSuggestionsPlacement

        ChildExampleEntry(parent: "searchSuggestionsPlacement", child: "SearchSuggestionsPlacement.automatic", code: """
        NavigationStack {
            ResultsList()
                .searchable(text: $query)
                .searchSuggestions {
                    ForEach(matches) { Text($0.term).searchCompletion($0.term) }
                }
        }
        """) { AnyView(C15_SuggestionsAutomaticExample()) },

        ChildExampleEntry(parent: "searchSuggestionsPlacement", child: "SearchSuggestionsPlacement.menu", code: """
        struct SuggestionRow: View {
            @Environment(\\.searchSuggestionsPlacement) private var placement
            let term: String
            var body: some View {
                Text(term)
                    .padding(.vertical, placement == .menu ? 0 : 8)
            }
        }
        """) { AnyView(C15_SuggestionsMenuExample()) },

        ChildExampleEntry(parent: "searchSuggestionsPlacement", child: "SearchSuggestionsPlacement.content", code: """
        if placement == .content {
            Label(term, systemImage: "clock.arrow.circlepath")
                .searchCompletion(term)
        }
        """) { AnyView(C15_SuggestionsContentExample()) },

        ChildExampleEntry(parent: "searchSuggestionsPlacement", child: "SearchSuggestionsPlacement.Set", code: """
        ResultsList()
            .searchable(text: $query)
            .searchSuggestions { RecentSearches() }
            .searchSuggestions(.hidden, for: .content)   // menu keeps them, content area does not
        """) { AnyView(C15_SuggestionsSetExample()) },

        // MARK: springLoadingBehavior

        ChildExampleEntry(parent: "springLoadingBehavior", child: "SpringLoadingBehavior.automatic", code: """
        Button("Inbox", systemImage: "tray") { }
            .springLoadingBehavior(.automatic)
            .dropDestination(for: String.self) { items, _ in
                dropped += items.count
                return true
            }
        """) { AnyView(C15_SpringAutomaticExample()) },

        ChildExampleEntry(parent: "springLoadingBehavior", child: "SpringLoadingBehavior.enabled", code: """
        Button("Archive", systemImage: "archivebox") { activations += 1 }
            .springLoadingBehavior(.enabled)
            .dropDestination(for: String.self) { items, _ in
                archived += items
                return true
            }
        """) { AnyView(C15_SpringEnabledExample()) },

        ChildExampleEntry(parent: "springLoadingBehavior", child: "SpringLoadingBehavior.disabled", code: """
        ForEach(folders) { folder in
            Button(folder.name, systemImage: folder.isLocked ? "lock.fill" : "folder") { open(folder) }
                .springLoadingBehavior(folder.isLocked ? .disabled : .enabled)
                .dropDestination(for: String.self) { items, _ in file(items, in: folder) }
        }
        """) { AnyView(C15_SpringDisabledExample()) },

        // MARK: symbolRenderingMode (environment)

        ChildExampleEntry(parent: "symbolRenderingMode (environment)", child: "SymbolRenderingMode.monochrome", code: """
        Image(systemName: "cloud.sun.rain")
            .symbolRenderingMode(.monochrome)
            .foregroundStyle(.secondary)
        """) { AnyView(C15_SymbolMonochromeExample()) },

        ChildExampleEntry(parent: "symbolRenderingMode (environment)", child: "SymbolRenderingMode.hierarchical", code: """
        Label("Storage", systemImage: "externaldrive.badge.checkmark")
            .symbolRenderingMode(.hierarchical)
            .foregroundStyle(.blue)
        """) { AnyView(C15_SymbolHierarchicalExample()) },

        ChildExampleEntry(parent: "symbolRenderingMode (environment)", child: "SymbolRenderingMode.palette", code: """
        Image(systemName: "person.crop.circle.badge.plus")
            .symbolRenderingMode(.palette)
            .foregroundStyle(.white, .green)      // one style per layer, in order
        """) { AnyView(C15_SymbolPaletteExample()) },

        ChildExampleEntry(parent: "symbolRenderingMode (environment)", child: "SymbolRenderingMode.multicolor", code: """
        HStack(spacing: 20) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "cloud.bolt.rain.fill")
            Image(systemName: "thermometer.sun.fill")
        }
        .symbolRenderingMode(.multicolor)
        .font(.largeTitle)
        """) { AnyView(C15_SymbolMulticolorExample()) },

        // MARK: tabViewBottomAccessoryPlacement

        ChildExampleEntry(parent: "tabViewBottomAccessoryPlacement", child: "TabViewBottomAccessoryPlacement.inline", code: """
        @Environment(\\.tabViewBottomAccessoryPlacement) private var placement
        var body: some View {
            HStack {
                if placement != .inline { ArtworkThumb(track: track) }
                Text(track.title).lineLimit(1)
                PlayPauseButton()
            }
        }
        """) { AnyView(C15_AccessoryInlineExample()) },

        ChildExampleEntry(parent: "tabViewBottomAccessoryPlacement", child: "TabViewBottomAccessoryPlacement.expanded", code: """
        if placement == .expanded {
            ProgressView(value: track.progress)
                .progressViewStyle(.linear)
        }
        """) { AnyView(C15_AccessoryExpandedExample()) },

        ChildExampleEntry(parent: "tabViewBottomAccessoryPlacement", child: ".tabViewBottomAccessory(content:)", code: """
        TabView {
            Tab("Library", systemImage: "books.vertical") { LibraryView() }
            Tab("Search", systemImage: "magnifyingglass", role: .search) { SearchView() }
        }
        .tabViewBottomAccessory { MiniPlayer() }
        .tabBarMinimizeBehavior(.onScrollDown)
        """) { AnyView(C15_AccessoryModifierExample()) },

        // MARK: textCase

        ChildExampleEntry(parent: "textCase", child: "Text.Case.uppercase", code: """
        Text("Recently added")
            .font(.caption)
            .textCase(.uppercase)
        """) { AnyView(C15_TextCaseUpperExample()) },

        ChildExampleEntry(parent: "textCase", child: "Text.Case.lowercase", code: """
        struct HandleLabel: View {
            @Environment(\\.textCase) private var inherited
            let handle: String
            var body: some View {
                Text("@\\(handle)")
                    .textCase(inherited ?? .lowercase)
            }
        }
        """) { AnyView(C15_TextCaseLowerExample()) },

        // MARK: truncationMode

        ChildExampleEntry(parent: "truncationMode", child: "Text.TruncationMode.head", code: """
        Text("C02XL0GVJGH8-00417-B")          // a serial number
            .lineLimit(1)
            .truncationMode(.head)
            .frame(width: 120)
        """) { AnyView(C15_TruncateHeadExample()) },

        ChildExampleEntry(parent: "truncationMode", child: "Text.TruncationMode.middle", code: """
        Text("/Users/maya/Documents/Projects/Aviary/Sources/App.swift")
            .lineLimit(1)
            .truncationMode(.middle)
            .frame(width: 200)
        """) { AnyView(C15_TruncateMiddleExample()) },

        ChildExampleEntry(parent: "truncationMode", child: "Text.TruncationMode.tail", code: """
        struct TitleCell: View {
            @Environment(\\.truncationMode) private var mode   // defaults to .tail
            var body: some View {
                Text(article.headline)
                    .lineLimit(2)
                    .truncationMode(mode)
            }
        }
        """) { AnyView(C15_TruncateTailExample()) },

        // MARK: widgetFamily (WidgetKit)

        ChildExampleEntry(parent: "widgetFamily", child: "WidgetFamily.systemSmall", code: """
        @Environment(\\.widgetFamily) private var family

        switch family {
        case .systemSmall: CompactStats()
        case .systemMedium: WideStats()
        case .systemLarge: FullStats()
        default: FullStats()
        }
        """) { AnyView(C15_WidgetFamilySmallExample()) },

        ChildExampleEntry(parent: "widgetFamily", child: "WidgetFamily.systemExtraLarge", code: """
        StaticConfiguration(kind: "Stats", provider: Provider()) { entry in
            StatsWidgetView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge])
        """) { AnyView(C15_WidgetFamilyExtraLargeExample()) },

        ChildExampleEntry(parent: "widgetFamily", child: "WidgetFamily.accessoryRectangular", code: """
        case .accessoryRectangular:
            VStack(alignment: .leading) {
                Text(entry.title).font(.headline)
                Text(entry.detail).font(.caption)
            }
        case .accessoryCircular:
            Gauge(value: entry.progress) { Image(systemName: "drop") }
                .gaugeStyle(.accessoryCircular)
        """) { AnyView(C15_WidgetAccessoryRectExample()) },

        ChildExampleEntry(parent: "widgetFamily", child: "WidgetFamily.accessoryCorner", code: """
        #if os(watchOS)
        case .accessoryCorner:
            Image(systemName: "drop.fill")
                .widgetLabel { Text("\\(Int(entry.progress * 100))%") }
        #endif
        """) { AnyView(C15_WidgetAccessoryCornerExample()) },

        // MARK: widgetRenderingMode (WidgetKit)

        ChildExampleEntry(parent: "widgetRenderingMode", child: "WidgetRenderingMode.fullColor", code: """
        @Environment(\\.widgetRenderingMode) private var mode

        var ringStyle: AnyShapeStyle {
            mode == .fullColor ? AnyShapeStyle(.orange) : AnyShapeStyle(.primary)
        }
        """) { AnyView(C15_WidgetFullColorExample()) },

        ChildExampleEntry(parent: "widgetRenderingMode", child: "WidgetRenderingMode.vibrant", code: """
        if mode == .vibrant {
            Text(entry.temperature)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)   // hue is discarded; weight and opacity carry the design
        }
        """) { AnyView(C15_WidgetVibrantExample()) },

        ChildExampleEntry(parent: "widgetRenderingMode", child: "WidgetRenderingMode.accented", code: """
        HStack {
            Image(systemName: "figure.run")
                .widgetAccentable()
            Text("8,412")
        }
        .foregroundStyle(mode == .accented ? .primary : .secondary)
        """) { AnyView(C15_WidgetAccentedExample()) },

        ChildExampleEntry(parent: "widgetRenderingMode", child: ".widgetAccentable(_:)", code: """
        VStack {
            Text(entry.date, style: .time)
                .widgetAccentable()          // takes the accent tint in accented mode
            Text(entry.eventName)            // stays neutral
        }
        """) { AnyView(C15_WidgetAccentableExample()) },

        // MARK: .addArc()

        ChildExampleEntry(parent: ".addArc()", child: "addArc(center:radius:startAngle:endAngle:clockwise:transform:)", code: """
        Path { p in
            p.addArc(center: CGPoint(x: 60, y: 60), radius: 50,
                     startAngle: .degrees(0), endAngle: .degrees(270),
                     clockwise: clockwise)               // toggled below
        }
        .stroke(.teal, lineWidth: 4)
        .frame(width: 120, height: 120)
        """) { AnyView(C15_AddArcCenterExample()) },

        ChildExampleEntry(parent: ".addArc()", child: "addArc(tangent1End:tangent2End:radius:transform:)", code: """
        Path { p in
            p.move(to: CGPoint(x: 0, y: 80))
            p.addArc(tangent1End: CGPoint(x: 0, y: 0),
                     tangent2End: CGPoint(x: 120, y: 0),
                     radius: radius)                      // slider below
            p.addLine(to: CGPoint(x: 120, y: 0))
        }
        .stroke(.orange, lineWidth: 3)
        """) { AnyView(C15_AddArcTangentExample()) },

        ChildExampleEntry(parent: ".addArc()", child: "addRelativeArc(center:radius:startAngle:delta:transform:)", code: """
        Path { p in
            p.addRelativeArc(center: CGPoint(x: 50, y: 50), radius: 40,
                             startAngle: .degrees(-90),
                             delta: .degrees(progress * 360))
        }
        .stroke(.green, style: StrokeStyle(lineWidth: 6, lineCap: .round))
        """) { AnyView(C15_AddRelativeArcExample()) },

        // MARK: ButtonBorderShape

        ChildExampleEntry(parent: "ButtonBorderShape", child: ".automatic", code: """
        Button("Save", action: save)
            .buttonStyle(.bordered)
            .buttonBorderShape(.automatic)
        """) { AnyView(C15_BorderShapeAutomaticExample()) },

        ChildExampleEntry(parent: "ButtonBorderShape", child: ".capsule", code: """
        Button(following ? "Following" : "Follow") { following.toggle() }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
        """) { AnyView(C15_BorderShapeCapsuleExample()) },

        ChildExampleEntry(parent: "ButtonBorderShape", child: ".roundedRectangle(radius:)", code: """
        Button("Add to Cart", systemImage: "cart.badge.plus") { addToCart() }
            .buttonStyle(.bordered)
            .buttonBorderShape(.roundedRectangle(radius: radius))   // slider below
        """) { AnyView(C15_BorderShapeRoundedRectExample()) },

        ChildExampleEntry(parent: "ButtonBorderShape", child: ".circle", code: """
        Button {
            muted.toggle()
        } label: {
            Image(systemName: muted ? "speaker.slash" : "speaker.wave.2")
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.circle)
        """) { AnyView(C15_BorderShapeCircleExample()) },

        // MARK: Capsule

        ChildExampleEntry(parent: "Capsule", child: "Capsule(style:)", code: """
        Capsule(style: .circular)          // the default
            .fill(.blue.gradient)
            .frame(width: 120, height: 44)

        Capsule(style: .continuous)        // smoother join between ends and sides
            .fill(.blue.gradient)
            .frame(width: 120, height: 44)
        """) { AnyView(C15_CapsuleStyleExample()) },

        ChildExampleEntry(parent: "Capsule", child: ".capsule", code: """
        Text("Beta")
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(.yellow, in: .capsule)
        """) { AnyView(C15_CapsuleShorthandExample()) },

        ChildExampleEntry(parent: "Capsule", child: ".capsule(style:)", code: """
        LinearGradient(colors: [.orange, .pink, .purple],
                       startPoint: .leading, endPoint: .trailing)   // banner stand-in
            .frame(width: 200, height: 60)
            .clipShape(.capsule(style: .continuous))
        """) { AnyView(C15_CapsuleStyleShorthandExample()) },

        // MARK: Circle

        ChildExampleEntry(parent: "Circle", child: ".circle", code: """
        avatar                              // a 56×56 gradient stand-in
            .frame(width: 56, height: 56)
            .clipShape(.circle)
        """) { AnyView(C15_CircleShorthandExample()) },

        ChildExampleEntry(parent: "Circle", child: "inset(by:)", code: """
        Circle()
            .inset(by: 4)                   // half the line width
            .stroke(.blue, lineWidth: 8)
            .frame(width: 80, height: 80)
        """) { AnyView(C15_CircleInsetExample()) },

        // MARK: Path

        ChildExampleEntry(parent: "Path", child: "Path(_:)", code: """
        Path { p in
            p.move(to: CGPoint(x: 0, y: 40))
            p.addLine(to: CGPoint(x: 120, y: 0))
            p.addLine(to: CGPoint(x: 120, y: 80))
            p.closeSubpath()
        }
        .fill(.mint)
        """) { AnyView(C15_PathClosureExample()) },

        ChildExampleEntry(parent: "Path", child: "Path(ellipseIn:)", code: """
        Path(ellipseIn: CGRect(x: 0, y: 0, width: 120, height: 70))
            .stroke(.purple, lineWidth: 2)
        """) { AnyView(C15_PathEllipseExample()) },

        ChildExampleEntry(parent: "Path", child: "Path(roundedRect:cornerRadius:style:)", code: """
        Path(roundedRect: CGRect(x: 0, y: 0, width: 140, height: 80),
             cornerRadius: 14, style: .continuous)
            .fill(.teal.opacity(0.4))
        """) { AnyView(C15_PathRoundedRectExample()) },

        ChildExampleEntry(parent: "Path", child: "move(to:)", code: """
        Path { p in
            p.move(to: CGPoint(x: 20, y: 60))      // pen up: nothing drawn yet
            p.addLine(to: CGPoint(x: 100, y: 20))
            p.move(to: CGPoint(x: 20, y: 20))      // a second subpath
            p.addLine(to: CGPoint(x: 100, y: 60))
        }
        .stroke(.blue, lineWidth: 2)
        """) { AnyView(C15_PathMoveExample()) },

        ChildExampleEntry(parent: "Path", child: "addLine(to:)", code: """
        Path { p in
            p.move(to: .zero)
            p.addLine(to: CGPoint(x: 80, y: 0))
            p.addLine(to: CGPoint(x: 80, y: 80))
        }
        .stroke(.indigo, lineWidth: 2)
        """) { AnyView(C15_PathAddLineExample()) },

        // MARK: RotatedShape

        ChildExampleEntry(parent: "RotatedShape", child: "RotatedShape(shape:angle:anchor:)", code: """
        RotatedShape(shape: Capsule(), angle: .degrees(angle), anchor: .center)
            .fill(.pink.opacity(0.6))
            .frame(width: 140, height: 50)
        """) { AnyView(C15_RotatedShapeInitExample()) },

        ChildExampleEntry(parent: "RotatedShape", child: ".rotation(_:anchor:)", code: """
        Rectangle()
            .rotation(.degrees(45), anchor: .topLeading)
            .stroke(.indigo, lineWidth: 2)
            .frame(width: 80, height: 80)
        """) { AnyView(C15_RotationModifierExample()) },

        // MARK: RoundedRectangle

        ChildExampleEntry(parent: "RoundedRectangle", child: "RoundedRectangle(cornerRadius:style:)", code: """
        RoundedRectangle(cornerRadius: 12, style: .continuous)
            .fill(.blue.opacity(0.3))
            .frame(width: 140, height: 80)
        """) { AnyView(C15_RoundedRectRadiusExample()) },

        ChildExampleEntry(parent: "RoundedRectangle", child: "RoundedRectangle(cornerSize:style:)", code: """
        RoundedRectangle(cornerSize: CGSize(width: 30, height: 12))
            .stroke(.orange, lineWidth: 2)
            .frame(width: 140, height: 80)
        """) { AnyView(C15_RoundedRectSizeExample()) },

        // MARK: UnevenRoundedRectangle

        ChildExampleEntry(parent: "UnevenRoundedRectangle", child: "UnevenRoundedRectangle(topLeadingRadius:bottomLeadingRadius:bottomTrailingRadius:topTrailingRadius:style:)", code: """
        UnevenRoundedRectangle(
            topLeadingRadius: 24,
            bottomLeadingRadius: 4,
            bottomTrailingRadius: 4,
            topTrailingRadius: 24,
            style: .continuous
        )
        .fill(.mint)
        .frame(width: 160, height: 80)
        """) { AnyView(C15_UnevenRectRadiiArgsExample()) },

        ChildExampleEntry(parent: "UnevenRoundedRectangle", child: "UnevenRoundedRectangle(cornerRadii:style:)", code: """
        let radii = RectangleCornerRadii(topLeading: 16, topTrailing: 16)

        UnevenRoundedRectangle(cornerRadii: radii, style: .continuous)
            .fill(.indigo.opacity(0.4))
            .frame(width: 160, height: 80)
        """) { AnyView(C15_UnevenRectCornerRadiiExample()) },

        ChildExampleEntry(parent: "UnevenRoundedRectangle", child: "RectangleCornerRadii", code: """
        var radii: RectangleCornerRadii {
            isAttached
                ? RectangleCornerRadii(topLeading: 12, topTrailing: 12)
                : RectangleCornerRadii(topLeading: 12, bottomLeading: 12,
                                       bottomTrailing: 12, topTrailing: 12)
        }

        UnevenRoundedRectangle(cornerRadii: radii).fill(.teal)
        """) { AnyView(C15_RectangleCornerRadiiExample()) },

        ChildExampleEntry(parent: "UnevenRoundedRectangle", child: ".rect(topLeadingRadius:bottomLeadingRadius:bottomTrailingRadius:topTrailingRadius:style:)", code: """
        VStack {
            grabber
            Text("Now Playing")
        }
        .background(.thinMaterial, in: .rect(
            topLeadingRadius: 20, topTrailingRadius: 20   // bottom corners stay square
        ))
        """) { AnyView(C15_RectShorthandExample()) },
    ]
}

// MARK: - Shared helpers

private struct C15_Caption: View {
    let text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
    }
}

private func C15_rangeName(_ range: Image.DynamicRange?) -> String {
    if range == .standard { return "standard" }
    if range == .constrainedHigh { return "constrainedHigh" }
    if range == .high { return "high" }
    return "nil (inherits)"
}

private struct C15_PhotoTiles: View {
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<3, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 8)
                    .fill(LinearGradient(colors: [.orange, .pink, .indigo],
                                         startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 60, height: 60)
                    .overlay(Image(systemName: "sun.max.fill").foregroundStyle(.yellow))
            }
        }
    }
}

private struct C15_RangeReadout: View {
    @Environment(\.allowedDynamicRange) private var range
    var body: some View {
        Text("allowedDynamicRange == \(C15_rangeName(range))")
            .font(.caption.monospaced())
    }
}

private struct C15_DueBadge: View {
    @Environment(\.backgroundProminence) private var prominence
    var body: some View {
        Text("Due today")
            .font(.caption.bold())
            .foregroundStyle(prominence == .standard ? .red : .white)
    }
}

private struct C15_ProminenceReadout: View {
    @Environment(\.backgroundProminence) private var prominence
    var body: some View {
        Text("backgroundProminence == \(prominence == .increased ? ".increased" : ".standard")")
            .font(.caption.monospaced())
    }
}

// MARK: - allowedDynamicRange

private struct C15_DynamicRangeStandardExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C15_PhotoTiles()
            C15_RangeReadout()
            C15_Caption("HDR photos tone-map down to SDR so they never outglow neighboring UI")
        }
        .allowedDynamicRange(.standard)
    }
}

private struct C15_DynamicRangeConstrainedExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 16) {
                Image(systemName: "sun.horizon.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 64)
                    .foregroundStyle(.orange.gradient)
                    .allowedDynamicRange(.constrainedHigh)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Golden Hour").font(.headline)
                    Text("Shown beside text and controls").font(.caption).foregroundStyle(.secondary)
                    Toggle("Favorite", isOn: .constant(true)).toggleStyle(.switch).controlSize(.mini)
                }
            }
            C15_RangeReadout()
                .allowedDynamicRange(.constrainedHigh)
            C15_Caption("Some HDR headroom, but peak brightness stays capped")
        }
    }
}

private struct C15_DynamicRangeHighExample: View {
    @Environment(\.allowedDynamicRange) private var range
    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(colors: [.black, .indigo, .orange, .white],
                                     startPoint: .bottom, endPoint: .top))
                .frame(height: 90)
                .overlay(alignment: .bottomLeading) {
                    Text("Full-screen hero").font(.caption).foregroundStyle(.white).padding(6)
                }
                .allowedDynamicRange(range ?? .high)
            Text("range ?? .high  →  \(C15_rangeName(range ?? .high))")
                .font(.caption.monospaced())
            C15_Caption("Full HDR headroom for a dedicated photo view")
        }
    }
}

// MARK: - backgroundProminence

private struct C15_ProminenceStandardExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Renew passport")
                Spacer()
                C15_DueBadge()
            }
            .padding(10)
            .background(.quaternary, in: .rect(cornerRadius: 8))
            C15_ProminenceReadout()
            C15_Caption("On an ordinary background the red tint reads normally")
        }
    }
}

private struct C15_ProminenceIncreasedExample: View {
    @State private var selection: String? = "Renew passport"
    private let tasks = ["Renew passport", "Book flights", "Pack chargers"]
    var body: some View {
        VStack(spacing: 6) {
            List(tasks, id: \.self, selection: $selection) { task in
                HStack {
                    Text(task)
                    Spacer()
                    C15_DueBadge()
                }
            }
            .frame(height: 110)
            C15_Caption("The selected row reports .increased, so its badge turns white instead of vanishing into the highlight")
        }
    }
}

// MARK: - buttonRepeatBehavior

private struct C15_RepeatAutomaticExample: View {
    @State private var page = 1
    var body: some View {
        VStack(spacing: 8) {
            Text("Page \(page)").font(.title2.monospacedDigit())
            Button("Next Page", systemImage: "arrow.right") { page += 1 }
                .buttonRepeatBehavior(.automatic)
            C15_Caption("Press and hold: a plain button fires once — the platform repeats only controls that conventionally do")
        }
    }
}

private struct C15_RepeatEnabledExample: View {
    @State private var brightness = 0.5
    var body: some View {
        VStack(spacing: 8) {
            ProgressView(value: brightness)
                .progressViewStyle(.linear)
                .frame(width: 160)
            Text(String(format: "%.0f%%", brightness * 100))
                .font(.caption.monospacedDigit())
            HStack {
                Button("Decrease", systemImage: "minus") { brightness = max(0, brightness - 0.05) }
                Button("Increase", systemImage: "plus") { brightness = min(1, brightness + 0.05) }
            }
            .buttonRepeatBehavior(.enabled)
            C15_Caption("Hold either button: the action streams while pressed")
        }
    }
}

private struct C15_RepeatDisabledExample: View {
    @State private var count = 0
    var body: some View {
        VStack(spacing: 8) {
            Text("\(count)").font(.title.monospacedDigit())
            HStack {
                Button("Increase", systemImage: "plus") { count += 1 }
                Button("Reset", systemImage: "arrow.counterclockwise") { count = 0 }
                    .buttonRepeatBehavior(.disabled)
            }
            .buttonRepeatBehavior(.enabled)
            C15_Caption("Hold Increase to stream; Reset fires once despite the enabled ancestor")
        }
    }
}

// MARK: - documentConfiguration

private struct C15_DocumentFileURLExample: View {
    @Environment(\.documentConfiguration) private var config
    var body: some View {
        VStack(spacing: 8) {
            if let url = config?.fileURL {
                ShareLink(item: url) { Label("Share File", systemImage: "square.and.arrow.up") }
                Text(url.lastPathComponent).font(.caption.monospaced())
            } else {
                Label("Share File", systemImage: "square.and.arrow.up")
                    .foregroundStyle(.tertiary)
                Text("config?.fileURL == nil").font(.caption.monospaced())
            }
            C15_Caption("Populated only inside a DocumentGroup scene; nil here and for a never-saved document")
        }
    }
}

private struct C15_DocumentEditableExample: View {
    @Environment(\.documentConfiguration) private var config
    @State private var text = "Chapter 1\nIt was a bright cold day in April…"
    var body: some View {
        VStack(spacing: 6) {
            TextEditor(text: $text)
                .font(.body)
                .frame(height: 70)
                .disabled(config?.isEditable == false)
            Text("config?.isEditable == \(config.map { String(describing: $0.isEditable) } ?? "nil (no DocumentGroup)")")
                .font(.caption.monospaced())
            C15_Caption("Opened read-only → the editor locks instead of failing at save time")
        }
    }
}

// MARK: - imageScale

private struct C15_ImageScaleSmallExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("Updated 2m ago", systemImage: "clock")
                .font(.caption)
                .imageScale(.small)
            Label("Updated 2m ago  (medium, for comparison)", systemImage: "clock")
                .font(.caption)
                .imageScale(.medium)
                .foregroundStyle(.secondary)
            C15_Caption(".small shrinks the symbol below its text-relative default")
        }
    }
}

private struct C15_ImageScaleMediumExample: View {
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: "paperclip")
                Text("3 attachments")
            }
            .imageScale(.medium)
            .font(.title3)
            HStack(spacing: 18) {
                Label("small", systemImage: "paperclip").imageScale(.small)
                Label("medium", systemImage: "paperclip").imageScale(.medium)
                Label("large", systemImage: "paperclip").imageScale(.large)
            }
            .font(.caption)
            .foregroundStyle(.secondary)
            C15_Caption(".medium is the baseline: the symbol sits in proportion to the font's cap height")
        }
    }
}

private struct C15_ImageScaleLargeExample: View {
    var body: some View {
        ContentUnavailableView {
            Label("No Results", systemImage: "magnifyingglass")
                .imageScale(.large)
        } description: {
            Text("Try a different search term.")
        }
        .frame(height: 150)
    }
}

// MARK: - materialActiveAppearance

private struct C15_Backdrop<Content: View>: View {
    @ViewBuilder var content: Content
    var body: some View {
        ZStack {
            LinearGradient(colors: [.pink, .orange, .teal],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            content
        }
        .frame(height: 100)
        .clipShape(.rect(cornerRadius: 10))
    }
}

private struct C15_MaterialPanel: View {
    let title: String
    let detail: String
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title).font(.headline)
            Text(detail).font(.caption).foregroundStyle(.secondary)
        }
        .padding(12)
    }
}

private struct C15_AppearsActiveReadout: View {
    @Environment(\.appearsActive) private var appearsActive
    var body: some View {
        Text("appearsActive == \(appearsActive ? "true" : "false")")
            .font(.caption.monospaced())
    }
}

private struct C15_MaterialAutomaticExample: View {
    var body: some View {
        VStack(spacing: 6) {
            C15_Backdrop {
                C15_MaterialPanel(title: "Inspector", detail: "Opacity 80% · Blend Normal")
                    .background(.regularMaterial, in: .rect(cornerRadius: 8))
                    .materialActiveAppearance(.automatic)
            }
            C15_AppearsActiveReadout()
            C15_Caption("Click another window: the material dims with it and returns when the window is key again")
        }
    }
}

private struct C15_MaterialActiveExample: View {
    var body: some View {
        VStack(spacing: 6) {
            C15_Backdrop {
                HStack {
                    Image(systemName: "play.fill")
                    C15_MaterialPanel(title: "Midnight City", detail: "M83 · 2:41 / 4:03")
                }
                .padding(.leading, 12)
                .background(.thinMaterial, in: .rect(cornerRadius: 8))
                .materialActiveAppearance(.active)
            }
            C15_AppearsActiveReadout()
            C15_Caption("Stays at full strength even while the window is in the background")
        }
    }
}

private struct C15_MaterialInactiveExample: View {
    var body: some View {
        VStack(spacing: 6) {
            C15_Backdrop {
                C15_MaterialPanel(title: "Sidebar", detail: "Recents · Favorites · Tags")
                    .background(.regularMaterial, in: .rect(cornerRadius: 8))
                    .materialActiveAppearance(.inactive)
            }
            C15_AppearsActiveReadout()
            C15_Caption("Always the dimmed form, regardless of window state — handy for previews and recessed chrome")
        }
    }
}

private struct C15_MaterialModifierExample: View {
    @State private var vivid = true
    var body: some View {
        VStack(spacing: 6) {
            C15_Backdrop {
                C15_MaterialPanel(title: "Glass Card", detail: vivid ? "active appearance" : "inactive appearance")
                    .background(.ultraThinMaterial, in: .rect(cornerRadius: 12))
                    .materialActiveAppearance(vivid ? .active : .inactive)
            }
            Toggle("Active appearance", isOn: $vivid)
                .toggleStyle(.switch)
                .controlSize(.small)
            C15_Caption("The modifier writes the environment value for the subtree, decoupled from window activation")
        }
    }
}

// MARK: - menuOrder

private struct C15_MenuOrderAutomaticExample: View {
    @State private var sort = "Name"
    var body: some View {
        VStack(spacing: 8) {
            Menu("Sort") {
                Button("Name") { sort = "Name" }
                Button("Date") { sort = "Date" }
                Button("Size") { sort = "Size" }
            }
            .menuOrder(.automatic)
            .fixedSize()
            Text("sorted by \(sort)").font(.caption.monospaced())
            C15_Caption("macOS keeps declaration order; iOS may flip the list so the first item lands nearest the control")
        }
    }
}

private struct C15_MenuOrderFixedExample: View {
    @State private var rate = 1.0
    var body: some View {
        VStack(spacing: 8) {
            Menu("Playback Speed") {
                ForEach([0.5, 1.0, 1.5, 2.0], id: \.self) { speed in
                    Button(String(format: "%g×", speed)) { rate = speed }
                }
            }
            .menuOrder(.fixed)
            .fixedSize()
            Text(String(format: "rate = %g×", rate)).font(.caption.monospaced())
            C15_Caption("Items always read top-to-bottom exactly as declared, so the ascending order survives")
        }
    }
}

private struct C15_MenuOrderPriorityExample: View {
    private let items = ["Save to Photos", "Copy", "Delete"]
    var body: some View {
        VStack(spacing: 4) {
            // Menu opens upward, so the FIRST declared item is drawn at the bottom, nearest the source.
            VStack(alignment: .leading, spacing: 0) {
                ForEach(Array(items.reversed().enumerated()), id: \.offset) { index, item in
                    HStack {
                        Text(item)
                            .foregroundStyle(item == "Delete" ? .red : .primary)
                        Spacer()
                        Text(index == items.count - 1 ? "nearest" : "").font(.caption2).foregroundStyle(.tertiary)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    if index < items.count - 1 { Divider() }
                }
            }
            .font(.caption)
            .frame(width: 160)
            .background(.regularMaterial, in: .rect(cornerRadius: 8))
            Image(systemName: "photo")
                .font(.system(size: 30))
                .foregroundStyle(.blue)
                .padding(8)
                .background(.quaternary, in: .rect(cornerRadius: 8))
            C15_Caption("Illustrative — .priority is iOS-only: the first declared item lands closest to the presenting view")
        }
    }
}

// MARK: - purchase (StoreKit)

private struct C15_PurchaseCallExample: View {
    @State private var presented = false
    var body: some View {
        VStack(spacing: 8) {
            Button("Buy 3 Credits", systemImage: "cart") { presented.toggle() }
                .buttonStyle(.borderedProminent)
            if presented {
                VStack(spacing: 6) {
                    Label("App Store", systemImage: "apple.logo").font(.caption.bold())
                    HStack { Text("Credits Pack"); Spacer(); Text("×3    $2.99") }.font(.caption)
                    HStack {
                        Button("Cancel") { presented = false }
                        Button("Buy") { presented = false }.buttonStyle(.borderedProminent)
                    }
                    .controlSize(.small)
                }
                .padding(10)
                .frame(width: 220)
                .background(.regularMaterial, in: .rect(cornerRadius: 10))
            }
            C15_Caption("Illustrative — StoreKit presents the real sheet; purchase(product, options:) suspends until it closes")
        }
    }
}

private struct C15_PurchaseResultExample: View {
    @State private var outcome = "success"
    var body: some View {
        VStack(spacing: 8) {
            Picker("Result", selection: $outcome) {
                Text(".success").tag("success")
                Text(".pending").tag("pending")
                Text(".userCancelled").tag("userCancelled")
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 300)
            switch outcome {
            case "success":
                Label("verified → transaction.finish()", systemImage: "checkmark.seal.fill")
                    .foregroundStyle(.green)
            case "pending":
                Label("Awaiting approval (Ask to Buy)", systemImage: "hourglass")
                    .foregroundStyle(.orange)
            default:
                Label("User backed out — nothing to do", systemImage: "xmark.circle")
                    .foregroundStyle(.secondary)
            }
            C15_Caption("Illustrative — how each Product.PurchaseResult case is handled")
        }
    }
}

private struct C15_AppAccountTokenExample: View {
    @State private var token = UUID()
    var body: some View {
        VStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Purchase options").font(.caption.bold())
                HStack(alignment: .top, spacing: 8) {
                    Text(".appAccountToken").font(.caption.monospaced())
                    Text(token.uuidString).font(.caption2.monospaced()).foregroundStyle(.secondary)
                }
            }
            .padding(10)
            .background(.quaternary, in: .rect(cornerRadius: 8))
            Button("Rotate account token") { token = UUID() }
                .controlSize(.small)
            C15_Caption("Illustrative — the UUID rides on the transaction so server-side receipts map back to the buyer")
        }
    }
}

// MARK: - searchSuggestionsPlacement

private func C15_placementName(_ placement: SearchSuggestionsPlacement) -> String {
    if placement == .menu { return ".menu" }
    if placement == .content { return ".content" }
    return ".automatic"
}

private struct C15_SearchFieldMock: View {
    var text: String
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "magnifyingglass").foregroundStyle(.secondary)
            Text(text)
            Spacer()
        }
        .font(.callout)
        .padding(.horizontal, 8)
        .padding(.vertical, 5)
        .background(.quaternary, in: .rect(cornerRadius: 7))
    }
}

private struct C15_PlacementReadout: View {
    @Environment(\.searchSuggestionsPlacement) private var placement
    var body: some View {
        Text("searchSuggestionsPlacement == \(C15_placementName(placement))")
            .font(.caption.monospaced())
    }
}

private struct C15_SuggestionsAutomaticExample: View {
    private let matches = ["swift concurrency", "swiftui layout", "swift charts"]
    var body: some View {
        VStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 4) {
                C15_SearchFieldMock(text: "swift")
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(matches, id: \.self) { term in
                        Text(term).padding(.horizontal, 10).padding(.vertical, 3)
                    }
                }
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.regularMaterial, in: .rect(cornerRadius: 6))
            }
            .frame(width: 220)
            C15_PlacementReadout()
            C15_Caption("Illustrative — .automatic resolves to a menu under a macOS toolbar field, or the content area on iOS")
        }
    }
}

private struct C15_SuggestionsMenuExample: View {
    private let matches = ["swift concurrency", "swiftui layout", "swift charts"]
    var body: some View {
        VStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 2) {
                C15_SearchFieldMock(text: "swift")
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(matches, id: \.self) { term in
                        Text(term)
                            .padding(.vertical, 0)          // placement == .menu → compact rows
                            .padding(.horizontal, 10)
                    }
                }
                .font(.caption)
                .padding(.vertical, 4)
                .frame(width: 160, alignment: .leading)
                .background(.regularMaterial, in: .rect(cornerRadius: 6))
                .shadow(radius: 4, y: 2)
            }
            .frame(width: 220)
            C15_Caption("Illustrative — a macOS toolbar search drops suggestions as a compact menu, so rows read .menu and skip the extra padding")
        }
    }
}

private struct C15_SuggestionsContentExample: View {
    private let recents = ["swift concurrency", "swiftui layout", "swift charts"]
    var body: some View {
        VStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 6) {
                C15_SearchFieldMock(text: "swift")
                ForEach(recents, id: \.self) { term in
                    Label(term, systemImage: "clock.arrow.circlepath")
                        .font(.caption)
                        .padding(.vertical, 6)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Divider()
                }
            }
            .frame(width: 220)
            C15_Caption("Illustrative — on iOS the results list gives way to a full-width suggestion list (placement == .content)")
        }
    }
}

private struct C15_SuggestionsSetExample: View {
    private let recents = ["swift concurrency", "swiftui layout"]
    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .top, spacing: 12) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("for: .menu").font(.caption2).foregroundStyle(.secondary)
                    C15_SearchFieldMock(text: "swift")
                    VStack(alignment: .leading, spacing: 2) {
                        ForEach(recents, id: \.self) { Text($0).padding(.horizontal, 8) }
                    }
                    .font(.caption)
                    .padding(.vertical, 4)
                    .background(.regularMaterial, in: .rect(cornerRadius: 6))
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("for: .content → .hidden").font(.caption2).foregroundStyle(.secondary)
                    C15_SearchFieldMock(text: "swift")
                    Text("Results list stays put")
                        .font(.caption)
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(.quaternary, in: .rect(cornerRadius: 6))
                }
            }
            .frame(width: 300)
            C15_Caption("Illustrative — an option set of placements: suggestions stay in the menu but are hidden from the content area")
        }
    }
}

// MARK: - springLoadingBehavior

private struct C15_DragChip: View {
    let title: String
    var body: some View {
        Label(title, systemImage: "envelope")
            .font(.caption)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(.blue.opacity(0.15), in: .capsule)
            .draggable(title)
    }
}

private struct C15_SpringAutomaticExample: View {
    @State private var dropped = 0
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 24) {
                C15_DragChip(title: "Quarterly report")
                Button("Inbox", systemImage: "tray") { }
                    .springLoadingBehavior(.automatic)
                    .dropDestination(for: String.self) { items, _ in
                        dropped += items.count
                        return true
                    }
            }
            Text("dropped: \(dropped)").font(.caption.monospaced())
            C15_Caption("Drag the chip and hover over Inbox: .automatic leaves spring loading to platform defaults, so a plain Button never fires — dropping still works")
        }
    }
}

private struct C15_SpringEnabledExample: View {
    @State private var archived: [String] = []
    @State private var activations = 0
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 24) {
                C15_DragChip(title: "Invoice #204")
                Button("Archive", systemImage: "archivebox") { activations += 1 }
                    .springLoadingBehavior(.enabled)
                    .dropDestination(for: String.self) { items, _ in
                        archived += items
                        return true
                    }
            }
            Text("spring-loaded ×\(activations) · archived \(archived.count)").font(.caption.monospaced())
            C15_Caption("Drag the chip and pause over Archive: the button flashes and its action fires mid-drag")
        }
    }
}

private struct C15_Folder: Identifiable {
    let name: String
    let isLocked: Bool
    var id: String { name }
}

private struct C15_SpringDisabledExample: View {
    private let folders = [C15_Folder(name: "Drafts", isLocked: false),
                           C15_Folder(name: "Vault", isLocked: true),
                           C15_Folder(name: "Sent", isLocked: false)]
    @State private var log = "—"
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 10) {
                C15_DragChip(title: "Memo")
                ForEach(folders) { folder in
                    Button(folder.name, systemImage: folder.isLocked ? "lock.fill" : "folder") { log = "opened \(folder.name)" }
                        .springLoadingBehavior(folder.isLocked ? .disabled : .enabled)
                        .dropDestination(for: String.self) { items, _ in
                            log = "dropped \(items.count) into \(folder.name)"
                            return true
                        }
                }
            }
            Text(log).font(.caption.monospaced())
            C15_Caption("Hover the drag over Vault: the locked folder never spring-loads, while its siblings do")
        }
    }
}

// MARK: - symbolRenderingMode (environment)

private struct C15_SymbolMonochromeExample: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "cloud.sun.rain")
                .symbolRenderingMode(.monochrome)
                .foregroundStyle(.secondary)
                .font(.system(size: 56))
            C15_Caption("Every layer drawn in one foreground style — the flat default look")
        }
    }
}

private struct C15_SymbolHierarchicalExample: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "externaldrive.badge.checkmark")
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(.blue)
                .font(.system(size: 52))
            Label("Storage", systemImage: "externaldrive.badge.checkmark")
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(.blue)
                .font(.title3)
            C15_Caption("One color at graduated opacities per layer — the badge recedes behind the drive")
        }
    }
}

private struct C15_SymbolPaletteExample: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "person.crop.circle.badge.plus")
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, .green)
                .font(.system(size: 56))
                .padding(14)
                .background(.gray, in: .rect(cornerRadius: 14))
            C15_Caption("A distinct style per layer: white person, green badge")
        }
    }
}

private struct C15_SymbolMulticolorExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 20) {
                Image(systemName: "sun.max.fill")
                Image(systemName: "cloud.bolt.rain.fill")
                Image(systemName: "thermometer.sun.fill")
            }
            .symbolRenderingMode(.multicolor)
            .font(.largeTitle)
            C15_Caption("Colors baked into the symbol itself — yellow sun, blue rain, red mercury")
        }
    }
}

// MARK: - tabViewBottomAccessoryPlacement (iOS-only, illustrated)

private struct C15_MiniPlayerMock: View {
    let expanded: Bool
    var body: some View {
        HStack(spacing: 8) {
            if expanded {
                RoundedRectangle(cornerRadius: 4).fill(.purple.gradient).frame(width: 26, height: 26)
            }
            VStack(alignment: .leading, spacing: 3) {
                Text("Midnight City").font(.caption.bold()).lineLimit(1)
                if expanded {
                    ProgressView(value: 0.4).progressViewStyle(.linear)
                }
            }
            Spacer(minLength: 4)
            Image(systemName: "play.fill").font(.caption)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, expanded ? 8 : 5)
        .background(.regularMaterial, in: .capsule)
    }
}

private struct C15_TabBarMock: View {
    let expanded: Bool
    var body: some View {
        VStack(spacing: 6) {
            if expanded {
                C15_MiniPlayerMock(expanded: true)
                tabs(full: true)
            } else {
                HStack(spacing: 6) {
                    C15_MiniPlayerMock(expanded: false)
                    tabs(full: false)
                }
            }
        }
        .padding(8)
        .frame(width: 250)
        .background(LinearGradient(colors: [.indigo.opacity(0.35), .cyan.opacity(0.35)],
                                   startPoint: .top, endPoint: .bottom),
                    in: .rect(cornerRadius: 16))
    }
    private func tabs(full: Bool) -> some View {
        HStack(spacing: full ? 24 : 10) {
            tab("Library", "books.vertical", full: full)
            tab("Search", "magnifyingglass", full: full)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(.regularMaterial, in: .capsule)
    }
    private func tab(_ title: String, _ symbol: String, full: Bool) -> some View {
        VStack(spacing: 2) {
            Image(systemName: symbol)
            if full { Text(title).font(.caption2) }
        }
    }
}

private struct C15_AccessoryInlineExample: View {
    var body: some View {
        VStack(spacing: 8) {
            C15_TabBarMock(expanded: false)
            Text("placement == .inline → artwork hidden, single row").font(.caption.monospaced())
            C15_Caption("Illustrative — iOS 26 only: the accessory has collapsed into the tab bar strip")
        }
    }
}

private struct C15_AccessoryExpandedExample: View {
    var body: some View {
        VStack(spacing: 8) {
            C15_TabBarMock(expanded: true)
            Text("placement == .expanded → scrubber shown").font(.caption.monospaced())
            C15_Caption("Illustrative — iOS 26 only: the accessory floats above the full tab bar")
        }
    }
}

private struct C15_AccessoryModifierExample: View {
    @State private var expanded = true
    var body: some View {
        VStack(spacing: 8) {
            C15_TabBarMock(expanded: expanded)
            Toggle("Tab bar expanded (scroll up)", isOn: $expanded)
                .toggleStyle(.switch)
                .controlSize(.small)
            C15_Caption("Illustrative — iOS 26 only: MiniPlayer receives .expanded or .inline as the bar minimizes")
        }
    }
}

// MARK: - textCase

private struct C15_TextCaseUpperExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Recently added")
                .font(.caption)
                .textCase(.uppercase)
            Text("Recently added")
                .font(.caption)
                .foregroundStyle(.secondary)
            C15_Caption("Top: .uppercase applied at draw time. Bottom: the same string untransformed")
        }
    }
}

private struct C15_HandleLabel: View {
    @Environment(\.textCase) private var inherited
    let handle: String
    var body: some View {
        Text("@\(handle)")
            .textCase(inherited ?? .lowercase)
    }
}

private struct C15_TextCaseLowerExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 24) {
                VStack(spacing: 2) {
                    C15_HandleLabel(handle: "BCann_Dev")
                    Text("no inherited case → .lowercase").font(.caption2).foregroundStyle(.secondary)
                }
                VStack(spacing: 2) {
                    C15_HandleLabel(handle: "BCann_Dev")
                        .textCase(.uppercase)
                    Text("ancestor .uppercase wins").font(.caption2).foregroundStyle(.secondary)
                }
            }
            .font(.title3.monospaced())
            C15_Caption("Typed as BCann_Dev — lowercase normalizes the handle for display")
        }
    }
}

// MARK: - truncationMode

private struct C15_TruncateHeadExample: View {
    var body: some View {
        VStack(spacing: 6) {
            Text("C02XL0GVJGH8-00417-B")
                .lineLimit(1)
                .truncationMode(.head)
                .frame(width: 120)
                .padding(6)
                .border(.tertiary)
            Text("full: C02XL0GVJGH8-00417-B").font(.caption.monospaced()).foregroundStyle(.secondary)
            C15_Caption("Characters drop from the start so the identifying suffix stays visible")
        }
    }
}

private struct C15_TruncateMiddleExample: View {
    var body: some View {
        VStack(spacing: 6) {
            Text("/Users/maya/Documents/Projects/Aviary/Sources/App.swift")
                .lineLimit(1)
                .truncationMode(.middle)
                .frame(width: 200)
                .padding(6)
                .border(.tertiary)
            C15_Caption("The center of the path drops out so both the root and the file name survive")
        }
    }
}

private func C15_truncationName(_ mode: Text.TruncationMode) -> String {
    switch mode {
    case .head: return ".head"
    case .middle: return ".middle"
    case .tail: return ".tail"
    @unknown default: return "unknown"
    }
}

private struct C15_TitleCell: View {
    @Environment(\.truncationMode) private var mode
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Local council approves plan to convert the derelict riverside mill into affordable housing and a community library")
                .lineLimit(2)
                .truncationMode(mode)
            Text("truncationMode == \(C15_truncationName(mode))")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
    }
}

private struct C15_TruncateTailExample: View {
    var body: some View {
        VStack(spacing: 6) {
            C15_TitleCell()
                .frame(width: 220)
                .padding(6)
                .border(.tertiary)
            C15_Caption("The environment default is .tail: the headline is cut at the end and an ellipsis appended")
        }
    }
}

// MARK: - widgetFamily (WidgetKit)

private struct C15_WidgetMock: View {
    let label: String
    let width: CGFloat
    let height: CGFloat
    var highlighted = false
    var body: some View {
        VStack(spacing: 4) {
            RoundedRectangle(cornerRadius: 10)
                .fill(highlighted ? AnyShapeStyle(.blue.gradient) : AnyShapeStyle(.quaternary))
                .frame(width: width, height: height)
                .overlay(Image(systemName: "chart.bar.fill")
                    .foregroundStyle(highlighted ? Color.white : Color.secondary))
            Text(label).font(.caption2).foregroundStyle(.secondary)
        }
    }
}

private struct C15_WidgetFamilySmallExample: View {
    @Environment(\.widgetFamily) private var family
    private var layoutName: String {
        switch family {
        case .systemSmall: return "CompactStats()"
        case .systemMedium: return "WideStats()"
        case .systemLarge: return "FullStats()"
        default: return "FullStats()"
        }
    }
    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .bottom, spacing: 12) {
                C15_WidgetMock(label: "systemSmall", width: 44, height: 44, highlighted: family == .systemSmall)
                C15_WidgetMock(label: "systemMedium", width: 92, height: 44, highlighted: family == .systemMedium)
                C15_WidgetMock(label: "systemLarge", width: 92, height: 92, highlighted: family == .systemLarge)
            }
            Text("family == .\(String(describing: family)) → \(layoutName)")
                .font(.caption.monospaced())
            C15_Caption("Outside a widget the environment reports its default; inside one, each family gets its own layout")
        }
    }
}

private struct C15_WidgetFamilyExtraLargeExample: View {
    private let supported: [WidgetFamily] = [.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge]
    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .bottom, spacing: 10) {
                C15_WidgetMock(label: "small", width: 36, height: 36)
                C15_WidgetMock(label: "medium", width: 76, height: 36)
                C15_WidgetMock(label: "large", width: 76, height: 76)
                C15_WidgetMock(label: "extraLarge", width: 156, height: 76, highlighted: true)
            }
            Text("supportedFamilies: \(supported.map { String(describing: $0) }.joined(separator: ", "))")
                .font(.caption2.monospaced())
            C15_Caption("Illustrative — the oversized family is offered on iPad Home Screens, roomy enough for multi-column layouts")
        }
    }
}

private struct C15_WidgetAccessoryRectExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .top, spacing: 16) {
                VStack(spacing: 4) {
                    VStack(alignment: .leading) {
                        Text("Hydration").font(.headline)
                        Text("1.2 L of 2 L").font(.caption)
                    }
                    .padding(10)
                    .frame(width: 150, alignment: .leading)
                    .background(.quaternary, in: .rect(cornerRadius: 12))
                    Text("accessoryRectangular").font(.caption2).foregroundStyle(.secondary)
                }
                VStack(spacing: 4) {
                    Gauge(value: 0.6) { Image(systemName: "drop") }
                        .gaugeStyle(.accessoryCircular)
                        .tint(.cyan)
                    Text("accessoryCircular").font(.caption2).foregroundStyle(.secondary)
                }
            }
            C15_Caption("Illustrative — the Lock Screen and watch slots render vibrant or accented; accessoryCircular is its companion")
        }
    }
}

private struct C15_WidgetAccessoryCornerExample: View {
    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 28)
                    .fill(.black)
                    .frame(width: 120, height: 120)
                Path { p in
                    p.addArc(center: CGPoint(x: 60, y: 60), radius: 50,
                             startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
                }
                .stroke(.cyan, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .frame(width: 120, height: 120)
                Image(systemName: "drop.fill")
                    .foregroundStyle(.cyan)
                    .padding(.top, 14)
                    .padding(.leading, 14)
                Text("60%")
                    .font(.caption2.bold())
                    .foregroundStyle(.white)
                    .padding(.top, 38)
                    .padding(.leading, 28)
            }
            Text(".widgetLabel { Text(\"60%\") }").font(.caption.monospaced())
            C15_Caption("Illustrative — watchOS only: the corner family curves around the face and carries a widgetLabel")
        }
    }
}

// MARK: - widgetRenderingMode (WidgetKit)

private func C15_renderingModeName(_ mode: WidgetRenderingMode) -> String {
    if mode == .fullColor { return ".fullColor" }
    if mode == .accented { return ".accented" }
    if mode == .vibrant { return ".vibrant" }
    return "unknown"
}

private struct C15_WidgetFullColorExample: View {
    @Environment(\.widgetRenderingMode) private var mode
    private var ringStyle: AnyShapeStyle {
        mode == .fullColor ? AnyShapeStyle(.orange) : AnyShapeStyle(.primary)
    }
    var body: some View {
        VStack(spacing: 8) {
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(ringStyle, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .frame(width: 60, height: 60)
                .overlay(Text("70%").font(.caption.bold()))
            Text("mode == \(C15_renderingModeName(mode)) → ring drawn \(mode == .fullColor ? "orange" : "primary")")
                .font(.caption.monospaced())
            C15_Caption("Outside a widget the environment reads .fullColor, so every color draws exactly as given")
        }
    }
}

private struct C15_WidgetVibrantExample: View {
    @Environment(\.widgetRenderingMode) private var mode
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                LinearGradient(colors: [.indigo, .purple, .black], startPoint: .top, endPoint: .bottom)
                VStack(spacing: 2) {
                    Text("72°").font(.title.bold())
                    Text("Partly cloudy").font(.caption)
                }
                .foregroundStyle(.white.opacity(0.85))
                .blendMode(.plusLighter)
            }
            .frame(width: 150, height: 80)
            .clipShape(.rect(cornerRadius: 14))
            Text("here mode == \(C15_renderingModeName(mode)); shown: the .vibrant treatment")
                .font(.caption.monospaced())
            C15_Caption("Illustrative — Lock Screen and StandBy desaturate and blend with the wallpaper, so hue carries no meaning")
        }
    }
}

private struct C15_WidgetAccentedExample: View {
    @Environment(\.widgetRenderingMode) private var mode
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 24) {
                HStack {
                    Image(systemName: "figure.run")
                        .widgetAccentable()
                    Text("8,412")
                }
                .font(.title3)
                .foregroundStyle(mode == .accented ? .primary : .secondary)
                HStack {
                    Image(systemName: "figure.run").foregroundStyle(.orange)
                    Text("8,412").foregroundStyle(.white)
                }
                .font(.title3)
                .padding(8)
                .background(.black, in: .rect(cornerRadius: 10))
            }
            Text("mode == \(C15_renderingModeName(mode))").font(.caption.monospaced())
            C15_Caption("Left: executed here. Right: illustrative accented render — accentable views take the tint, the rest go neutral")
        }
    }
}

private struct C15_WidgetAccentableExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 24) {
                VStack {
                    Text(Date.now, style: .time)
                        .widgetAccentable()
                    Text("Design review")
                }
                .font(.callout)
                VStack {
                    Text(Date.now, style: .time).foregroundStyle(.orange)
                    Text("Design review").foregroundStyle(.white)
                }
                .font(.callout)
                .padding(8)
                .background(.black, in: .rect(cornerRadius: 10))
            }
            C15_Caption("Left: executed here (no accent outside a widget). Right: illustrative — the time takes the accent tint, the title stays neutral")
        }
    }
}

// MARK: - .addArc()

private struct C15_AddArcCenterExample: View {
    @State private var clockwise = false
    var body: some View {
        VStack(spacing: 6) {
            Path { p in
                p.addArc(center: CGPoint(x: 60, y: 60), radius: 50,
                         startAngle: .degrees(0), endAngle: .degrees(270),
                         clockwise: clockwise)
            }
            .stroke(.teal, lineWidth: 4)
            .frame(width: 120, height: 120)
            Toggle("clockwise", isOn: $clockwise)
                .toggleStyle(.switch)
                .controlSize(.small)
            C15_Caption("Sweeps 0° → 270° around the center; flipping clockwise takes the other way round")
        }
    }
}

private struct C15_AddArcTangentExample: View {
    @State private var radius: CGFloat = 24
    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                Path { p in
                    p.move(to: CGPoint(x: 0, y: 80))
                    p.addLine(to: CGPoint(x: 0, y: 0))
                    p.addLine(to: CGPoint(x: 120, y: 0))
                }
                .stroke(.quaternary, style: StrokeStyle(lineWidth: 1, dash: [4]))
                Path { p in
                    p.move(to: CGPoint(x: 0, y: 80))
                    p.addArc(tangent1End: CGPoint(x: 0, y: 0),
                             tangent2End: CGPoint(x: 120, y: 0),
                             radius: radius)
                    p.addLine(to: CGPoint(x: 120, y: 0))
                }
                .stroke(.orange, lineWidth: 3)
            }
            .frame(width: 120, height: 80)
            .padding(4)
            Slider(value: $radius, in: 0...60).frame(width: 160)
            Text(String(format: "radius: %.0f", radius)).font(.caption.monospaced())
            C15_Caption("Rounds the corner where the two dashed tangent lines meet — no angles computed")
        }
    }
}

private struct C15_AddRelativeArcExample: View {
    @State private var progress = 0.65
    var body: some View {
        VStack(spacing: 6) {
            Path { p in
                p.addRelativeArc(center: CGPoint(x: 50, y: 50), radius: 40,
                                 startAngle: .degrees(-90),
                                 delta: .degrees(progress * 360))
            }
            .stroke(.green, style: StrokeStyle(lineWidth: 6, lineCap: .round))
            .frame(width: 100, height: 100)
            .overlay(Text(String(format: "%.0f%%", progress * 100)).font(.caption.bold().monospacedDigit()))
            Slider(value: $progress, in: 0...1).frame(width: 160)
            C15_Caption("A signed delta maps the fraction straight to arc length — no end angle or clockwise bookkeeping")
        }
    }
}

// MARK: - ButtonBorderShape

private struct C15_BorderShapeAutomaticExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 12) {
                Button("Save") { }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.automatic)
                Button("Save") { }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.automatic)
            }
            C15_Caption("The platform's own silhouette for each style — identical to never applying the modifier")
        }
    }
}

private struct C15_BorderShapeCapsuleExample: View {
    @State private var following = false
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 12) {
                Button(following ? "Following" : "Follow") { following.toggle() }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                Button("Follow") { }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.automatic)
                    .opacity(0.5)
            }
            C15_Caption("Left: .capsule gives the full pill outline. Right: .automatic for comparison")
        }
    }
}

private struct C15_BorderShapeRoundedRectExample: View {
    @State private var radius: CGFloat = 6
    var body: some View {
        VStack(spacing: 8) {
            Button("Add to Cart", systemImage: "cart.badge.plus") { }
                .buttonStyle(.bordered)
                .buttonBorderShape(.roundedRectangle(radius: radius))
                .controlSize(.large)
            Slider(value: $radius, in: 0...16).frame(width: 160)
            Text(String(format: "radius: %.0f", radius)).font(.caption.monospaced())
            C15_Caption("You pick the corner radius; the parameterless .roundedRectangle uses the system default")
        }
    }
}

private struct C15_BorderShapeCircleExample: View {
    @State private var muted = false
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 12) {
                Button {
                    muted.toggle()
                } label: {
                    Image(systemName: muted ? "speaker.slash" : "speaker.wave.2")
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.circle)
                .controlSize(.large)
                Button { } label: { Image(systemName: "gearshape") }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.circle)
                    .controlSize(.large)
            }
            C15_Caption("A round border for icon-only buttons (iOS 17 / macOS 14)")
        }
    }
}

// MARK: - Capsule

private struct C15_CapsuleStyleExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 16) {
                VStack(spacing: 4) {
                    Capsule(style: .circular)
                        .fill(.blue.gradient)
                        .frame(width: 120, height: 44)
                    Text(".circular").font(.caption2).foregroundStyle(.secondary)
                }
                VStack(spacing: 4) {
                    Capsule(style: .continuous)
                        .fill(.blue.gradient)
                        .frame(width: 120, height: 44)
                    Text(".continuous").font(.caption2).foregroundStyle(.secondary)
                }
            }
            C15_Caption("The only initializer; .continuous smooths where the semicircular ends meet the straight sides")
        }
    }
}

private struct C15_CapsuleShorthandExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                Text("Beta")
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(.yellow, in: .capsule)
                Text("New")
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .foregroundStyle(.white)
                    .background(.blue, in: .capsule)
                Text("Deprecated")
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(.orange.opacity(0.3), in: .capsule)
            }
            .font(.caption.bold())
            C15_Caption("Static shorthand wherever a Shape is expected — no Capsule() call at the site")
        }
    }
}

private struct C15_CapsuleStyleShorthandExample: View {
    var body: some View {
        VStack(spacing: 10) {
            LinearGradient(colors: [.orange, .pink, .purple],
                           startPoint: .leading, endPoint: .trailing)
                .frame(width: 200, height: 60)
                .clipShape(.capsule(style: .continuous))
                .overlay(Text("Summer Sale").font(.headline).foregroundStyle(.white))
            C15_Caption("The shorthand with an explicit corner style, for clip and background sites")
        }
    }
}

// MARK: - Circle

private struct C15_Avatar: View {
    var body: some View {
        LinearGradient(colors: [.teal, .blue], startPoint: .top, endPoint: .bottom)
            .frame(width: 56, height: 56)
            .overlay(Image(systemName: "person.fill").font(.title).foregroundStyle(.white))
    }
}

private struct C15_CircleShorthandExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 24) {
                VStack(spacing: 4) {
                    C15_Avatar()
                        .clipShape(.circle)
                    Text(".clipShape(.circle)").font(.caption2).foregroundStyle(.secondary)
                }
                VStack(spacing: 4) {
                    C15_Avatar()
                    Text("unclipped").font(.caption2).foregroundStyle(.secondary)
                }
            }
            C15_Caption("Static shorthand for Circle() at any Shape-typed parameter")
        }
    }
}

private struct C15_CircleInsetExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 32) {
                VStack(spacing: 6) {
                    Circle()
                        .inset(by: 4)
                        .stroke(.blue, lineWidth: 8)
                        .frame(width: 80, height: 80)
                        .border(.tertiary)
                    Text(".inset(by: 4)").font(.caption2).foregroundStyle(.secondary)
                }
                VStack(spacing: 6) {
                    Circle()
                        .stroke(.blue, lineWidth: 8)
                        .frame(width: 80, height: 80)
                        .border(.tertiary)
                    Text("no inset — spills past the frame").font(.caption2).foregroundStyle(.secondary)
                }
            }
            C15_Caption("Insetting by half the line width keeps a thick outline inside the frame, as strokeBorder does")
        }
    }
}

// MARK: - Path

private struct C15_PathClosureExample: View {
    var body: some View {
        VStack(spacing: 8) {
            Path { p in
                p.move(to: CGPoint(x: 0, y: 40))
                p.addLine(to: CGPoint(x: 120, y: 0))
                p.addLine(to: CGPoint(x: 120, y: 80))
                p.closeSubpath()
            }
            .fill(.mint)
            .frame(width: 120, height: 80)
            C15_Caption("The closure receives an inout Path to mutate — one-off geometry sketched inline")
        }
    }
}

private struct C15_PathEllipseExample: View {
    var body: some View {
        VStack(spacing: 8) {
            Path(ellipseIn: CGRect(x: 0, y: 0, width: 120, height: 70))
                .stroke(.purple, lineWidth: 2)
                .frame(width: 120, height: 70)
                .padding(2)
            C15_Caption("A ready-made ellipse fitted to the rect")
        }
    }
}

private struct C15_PathRoundedRectExample: View {
    var body: some View {
        VStack(spacing: 8) {
            Path(roundedRect: CGRect(x: 0, y: 0, width: 140, height: 80),
                 cornerRadius: 14, style: .continuous)
                .fill(.teal.opacity(0.4))
                .frame(width: 140, height: 80)
            C15_Caption("One uniform radius, with .continuous corner smoothing")
        }
    }
}

private struct C15_PathMoveExample: View {
    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .topLeading) {
                Path { p in
                    p.move(to: CGPoint(x: 20, y: 60))
                    p.addLine(to: CGPoint(x: 100, y: 20))
                    p.move(to: CGPoint(x: 20, y: 20))
                    p.addLine(to: CGPoint(x: 100, y: 60))
                }
                .stroke(.blue, lineWidth: 2)
                Circle().fill(.blue).frame(width: 8, height: 8).position(x: 20, y: 60)
                Circle().fill(.blue).frame(width: 8, height: 8).position(x: 20, y: 20)
            }
            .frame(width: 120, height: 80)
            C15_Caption("Dots mark each move(to:) — pen up, nothing drawn until a segment follows")
        }
    }
}

private struct C15_PathAddLineExample: View {
    var body: some View {
        VStack(spacing: 8) {
            Path { p in
                p.move(to: .zero)
                p.addLine(to: CGPoint(x: 80, y: 0))
                p.addLine(to: CGPoint(x: 80, y: 80))
            }
            .stroke(.indigo, lineWidth: 2)
            .frame(width: 80, height: 80)
            .padding(2)
            C15_Caption("Each addLine draws a straight segment from the current point and moves it")
        }
    }
}

// MARK: - RotatedShape

private struct C15_RotatedShapeInitExample: View {
    @State private var angle: Double = -30
    var body: some View {
        VStack(spacing: 6) {
            RotatedShape(shape: Capsule(), angle: .degrees(angle), anchor: .center)
                .fill(.pink.opacity(0.6))
                .frame(width: 140, height: 50)
                .frame(height: 110)
            Slider(value: $angle, in: -90...90).frame(width: 160)
            Text(String(format: "angle: %.0f°", angle)).font(.caption.monospaced())
            C15_Caption("Wraps a shape with a rotation about a unit-point anchor (here the center)")
        }
    }
}

private struct C15_RotationModifierExample: View {
    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .stroke(.quaternary, style: StrokeStyle(lineWidth: 1, dash: [4]))
                Rectangle()
                    .rotation(.degrees(45), anchor: .topLeading)
                    .stroke(.indigo, lineWidth: 2)
                Circle().fill(.indigo).frame(width: 8, height: 8).position(x: 0, y: 0)
            }
            .frame(width: 80, height: 80)
            .padding(.leading, 60)
            .padding(.bottom, 36)
            C15_Caption("Dashed: the original. Solid: the same rectangle rotated 45° about its top-leading corner, still strokable")
        }
    }
}

// MARK: - RoundedRectangle

private struct C15_RoundedRectRadiusExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 16) {
                VStack(spacing: 4) {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.blue.opacity(0.3))
                        .frame(width: 140, height: 80)
                    Text(".continuous").font(.caption2).foregroundStyle(.secondary)
                }
                VStack(spacing: 4) {
                    RoundedRectangle(cornerRadius: 12, style: .circular)
                        .fill(.blue.opacity(0.3))
                        .frame(width: 140, height: 80)
                    Text(".circular").font(.caption2).foregroundStyle(.secondary)
                }
            }
            C15_Caption("One radius shared by all four corners; .continuous smooths where curve meets edge")
        }
    }
}

private struct C15_RoundedRectSizeExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 16) {
                VStack(spacing: 4) {
                    RoundedRectangle(cornerSize: CGSize(width: 30, height: 12))
                        .stroke(.orange, lineWidth: 2)
                        .frame(width: 140, height: 80)
                        .padding(1)
                    Text("30 × 12").font(.caption2).foregroundStyle(.secondary)
                }
                VStack(spacing: 4) {
                    RoundedRectangle(cornerSize: CGSize(width: 12, height: 30))
                        .stroke(.orange, lineWidth: 2)
                        .frame(width: 140, height: 80)
                        .padding(1)
                    Text("12 × 30").font(.caption2).foregroundStyle(.secondary)
                }
            }
            C15_Caption("A CGSize radius: unequal width and height give elliptical corners")
        }
    }
}

// MARK: - UnevenRoundedRectangle

private struct C15_UnevenRectRadiiArgsExample: View {
    var body: some View {
        VStack(spacing: 8) {
            UnevenRoundedRectangle(
                topLeadingRadius: 24,
                bottomLeadingRadius: 4,
                bottomTrailingRadius: 4,
                topTrailingRadius: 24,
                style: .continuous
            )
            .fill(.mint)
            .frame(width: 160, height: 80)
            C15_Caption("Each corner spelled out; every radius defaults to zero, so only the curved ones need mentioning")
        }
    }
}

private struct C15_UnevenRectCornerRadiiExample: View {
    private let radii = RectangleCornerRadii(topLeading: 16, topTrailing: 16)
    var body: some View {
        VStack(spacing: 8) {
            UnevenRoundedRectangle(cornerRadii: radii, style: .continuous)
                .fill(.indigo.opacity(0.4))
                .frame(width: 160, height: 80)
            C15_Caption("The four radii bundled in one RectangleCornerRadii value — easy to store or compute from state")
        }
    }
}

private struct C15_RectangleCornerRadiiExample: View {
    @State private var isAttached = true
    private var radii: RectangleCornerRadii {
        isAttached
            ? RectangleCornerRadii(topLeading: 12, topTrailing: 12)
            : RectangleCornerRadii(topLeading: 12, bottomLeading: 12,
                                   bottomTrailing: 12, topTrailing: 12)
    }
    var body: some View {
        VStack(spacing: 8) {
            VStack(spacing: 0) {
                UnevenRoundedRectangle(cornerRadii: radii)
                    .fill(.teal)
                    .frame(width: 160, height: 60)
                if isAttached {
                    Rectangle()
                        .fill(.teal.opacity(0.35))
                        .frame(width: 160, height: 22)
                }
            }
            Toggle("isAttached", isOn: $isAttached)
                .toggleStyle(.switch)
                .controlSize(.small)
            C15_Caption("One stored value drives all four corners: attached → only the top rounds, detached → all four")
        }
    }
}

private struct C15_RectShorthandExample: View {
    var body: some View {
        VStack(spacing: 8) {
            C15_Backdrop {
                VStack(spacing: 6) {
                    Capsule().fill(.secondary).frame(width: 36, height: 4)
                    Text("Now Playing").font(.headline)
                    Text("Only the top corners round").font(.caption).foregroundStyle(.secondary)
                }
                .padding(.top, 8)
                .padding(.bottom, 12)
                .frame(width: 220)
                .background(.thinMaterial, in: .rect(
                    topLeadingRadius: 20, topTrailingRadius: 20
                ))
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            C15_Caption("Static shorthand at Shape-typed sites; omitted corners default to square")
        }
    }
}
