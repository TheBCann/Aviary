//
//  ChildExamples+Part09.swift
//  Aviary
//
//  Compiled renderings for variant entries (part 09: views).
//  One private C09_* struct per variant; every rendering exercises the exact
//  overload the variant names, so siblings can be compared side by side.
//

import SwiftUI
import Charts

enum ChildExamplesPart09 {
    static let entries: [ChildExampleEntry] = [

        // MARK: AnyView

        ChildExampleEntry(parent: "AnyView", child: "AnyView(_:)", code: """
        let cells: [AnyView] = [
            AnyView(Text("Name")),
            AnyView(Toggle("Enabled", isOn: $enabled)),
            AnyView(Image(systemName: "star"))
        ]
        ForEach(cells.indices, id: \\.self) { cells[$0] }
        """) { AnyView(C09_AnyViewInitExample()) },

        ChildExampleEntry(parent: "AnyView", child: "AnyView(erasing:)", code: """
        func erased<V: View>(_ view: V) -> AnyView {
            AnyView(erasing: view)          // explicit label reads better in generic helpers
        }

        let badge = isVerified
            ? erased(Image(systemName: "checkmark.seal.fill"))
            : erased(Text("—"))
        """) { AnyView(C09_AnyViewErasingExample()) },

        // MARK: AsyncImage

        ChildExampleEntry(parent: "AsyncImage", child: "AsyncImage(url:)", code: """
        AsyncImage(url: URL(string: "https://example.com/avatar.png"))
            .frame(width: 44, height: 44)
        """) { AnyView(C09_AsyncImageURLExample()) },

        ChildExampleEntry(parent: "AsyncImage", child: "AsyncImage(url:content:placeholder:)", code: """
        AsyncImage(url: photoURL) { image in
            image.resizable().scaledToFill()
        } placeholder: {
            Color.gray.opacity(0.2).overlay(ProgressView())
        }
        .frame(width: 140, height: 90)
        .clipShape(.rect(cornerRadius: 8))
        """) { AnyView(C09_AsyncImagePlaceholderExample()) },

        ChildExampleEntry(parent: "AsyncImage", child: "AsyncImage(url:scale:transaction:content:)", code: """
        AsyncImage(url: photoURL, transaction: Transaction(animation: .easeOut)) { phase in
            switch phase {
            case .success(let image): image.resizable().scaledToFit()
            case .failure: Image(systemName: "photo.badge.exclamationmark")
            case .empty: ProgressView()
            @unknown default: EmptyView()
            }
        }
        """) { AnyView(C09_AsyncImagePhaseExample()) },

        // MARK: Button

        ChildExampleEntry(parent: "Button", child: "Button(_:action:)", code: """
        Button("Save") {
            save()
        }
        """) { AnyView(C09_ButtonActionExample()) },

        ChildExampleEntry(parent: "Button", child: "Button(_:role:action:)", code: """
        Menu("Actions") {
            Button("Duplicate") { duplicate() }
            Button("Delete", role: .destructive) { deleteItem() }   // red in menus
        }
        Button("Cancel", role: .cancel) { dismiss() }
        """) { AnyView(C09_ButtonRoleExample()) },

        ChildExampleEntry(parent: "Button", child: "Button(_:systemImage:action:)", code: """
        Button("Compose", systemImage: "square.and.pencil") {
            startDraft()
        }
        .buttonStyle(.bordered)
        """) { AnyView(C09_ButtonSystemImageExample()) },

        // MARK: Canvas

        ChildExampleEntry(parent: "Canvas", child: "Canvas(opaque:colorMode:rendersAsynchronously:renderer:)", code: """
        let sunset = Gradient(colors: [.orange, .pink, .indigo])

        Canvas(opaque: true, colorMode: .linear, rendersAsynchronously: true) { context, size in
            context.fill(
                Path(CGRect(origin: .zero, size: size)),
                with: .linearGradient(sunset, startPoint: .zero, endPoint: CGPoint(x: 0, y: size.height))
            )
        }
        .frame(height: 120)
        """) { AnyView(C09_CanvasFlagsExample()) },

        ChildExampleEntry(parent: "Canvas", child: "Canvas(opaque:colorMode:rendersAsynchronously:renderer:symbols:)", code: """
        Canvas { context, size in
            guard let star = context.resolveSymbol(id: "star") else { return }
            for point in starPositions(in: size) {
                context.draw(star, at: point)
            }
        } symbols: {
            Image(systemName: "star.fill").foregroundStyle(.yellow).tag("star")
        }
        """) { AnyView(C09_CanvasSymbolsExample()) },

        // MARK: Chart

        ChildExampleEntry(parent: "Chart", child: "Chart(content:)", code: """
        Chart {
            LineMark(x: .value("Day", 1), y: .value("Steps", 4200))
            LineMark(x: .value("Day", 2), y: .value("Steps", 6800))
            LineMark(x: .value("Day", 3), y: .value("Steps", 5100))
            RuleMark(y: .value("Goal", 6000))
                .foregroundStyle(.red)
        }
        .frame(height: 140)
        """) { AnyView(C09_ChartContentExample()) },

        ChildExampleEntry(parent: "Chart", child: "Chart(_:content:)", code: """
        struct DailySteps: Identifiable { let id = UUID(); let date: Date; let count: Int }

        Chart(dailySteps) { day in
            BarMark(
                x: .value("Date", day.date, unit: .day),
                y: .value("Steps", day.count)
            )
        }
        """) { AnyView(C09_ChartDataExample()) },

        ChildExampleEntry(parent: "Chart", child: "Chart(_:id:content:)", code: """
        struct Reading { let timestamp: Date; let celsius: Double }   // not Identifiable

        Chart(readings, id: \\.timestamp) { reading in
            LineMark(
                x: .value("Time", reading.timestamp),
                y: .value("Temp", reading.celsius)
            )
        }
        """) { AnyView(C09_ChartIDExample()) },

        // MARK: Chart3D

        ChildExampleEntry(parent: "Chart3D", child: "Chart3D(content:)", code: """
        Chart3D {
            PointMark(x: .value("X", 1.0), y: .value("Y", 2.0), z: .value("Z", 0.5))
            PointMark(x: .value("X", 2.0), y: .value("Y", 1.0), z: .value("Z", 1.5))
            PointMark(x: .value("X", 0.5), y: .value("Y", 1.5), z: .value("Z", 2.0))
        }
        .frame(height: 180)
        """) { AnyView(C09_Chart3DContentExample()) },

        ChildExampleEntry(parent: "Chart3D", child: "Chart3D(_:content:)", code: """
        Chart3D(penguins) { penguin in
            PointMark(
                x: .value("Flipper", penguin.flipperLength),
                y: .value("Mass", penguin.bodyMass),
                z: .value("Bill", penguin.billLength)
            )
            .foregroundStyle(by: .value("Species", penguin.species))
        }
        """) { AnyView(C09_Chart3DDataExample()) },

        // MARK: ColorPicker

        ChildExampleEntry(parent: "ColorPicker", child: "ColorPicker(_:selection:supportsOpacity:)", code: """
        @State private var tint = Color.accentColor

        ColorPicker("Tint", selection: $tint, supportsOpacity: false)
        RoundedRectangle(cornerRadius: 8).fill(tint).frame(height: 40)
        """) { AnyView(C09_ColorPickerTitleExample()) },

        ChildExampleEntry(parent: "ColorPicker", child: "ColorPicker(selection:supportsOpacity:label:)", code: """
        ColorPicker(selection: $highlight, supportsOpacity: true) {
            Label("Highlight", systemImage: "highlighter")
        }
        Text("Highlighted passage").padding(6).background(highlight)
        """) { AnyView(C09_ColorPickerLabelExample()) },

        // MARK: ContentUnavailableView

        ChildExampleEntry(parent: "ContentUnavailableView", child: "ContentUnavailableView(_:systemImage:description:)", code: """
        ContentUnavailableView(
            "No Favorites",
            systemImage: "heart.slash",
            description: Text("Tap the heart on any item to save it here.")
        )
        """) { AnyView(C09_ContentUnavailableTitleExample()) },

        ChildExampleEntry(parent: "ContentUnavailableView", child: "ContentUnavailableView(label:description:actions:)", code: """
        ContentUnavailableView {
            Label("Offline", systemImage: "wifi.slash")
        } description: {
            Text("Reconnect to load your inbox.")
        } actions: {
            Button("Retry") { reload() }
        }
        """) { AnyView(C09_ContentUnavailableBuilderExample()) },

        ChildExampleEntry(parent: "ContentUnavailableView", child: "ContentUnavailableView.search", code: """
        if results.isEmpty {
            ContentUnavailableView.search
        } else {
            List(results, id: \\.self) { Text($0) }
        }
        """) { AnyView(C09_ContentUnavailableSearchExample()) },

        ChildExampleEntry(parent: "ContentUnavailableView", child: "ContentUnavailableView.search(text:)", code: """
        TextField("Search fruit", text: $query)

        if filtered.isEmpty, !query.isEmpty {
            ContentUnavailableView.search(text: query)
        } else {
            List(filtered, id: \\.self) { Text($0) }
        }
        """) { AnyView(C09_ContentUnavailableSearchTextExample()) },

        // MARK: ControlGroup

        ChildExampleEntry(parent: "ControlGroup", child: "ControlGroup(content:)", code: """
        ControlGroup {
            Button("Undo", systemImage: "arrow.uturn.backward") { undo() }
            Button("Redo", systemImage: "arrow.uturn.forward") { redo() }
        }
        """) { AnyView(C09_ControlGroupContentExample()) },

        ChildExampleEntry(parent: "ControlGroup", child: "ControlGroup(_:systemImage:content:)", code: """
        ControlGroup("Text Style", systemImage: "textformat") {
            Button("Bold", systemImage: "bold") { toggleBold() }
            Button("Italic", systemImage: "italic") { toggleItalic() }
        }
        .controlGroupStyle(.menu)      // menu-style groups show the title + symbol as the header
        """) { AnyView(C09_ControlGroupTitledExample()) },

        ChildExampleEntry(parent: "ControlGroup", child: "ControlGroup(content:label:)", code: """
        ControlGroup {
            Button("Zoom In", systemImage: "plus.magnifyingglass") { zoom(1.25) }
            Button("Zoom Out", systemImage: "minus.magnifyingglass") { zoom(0.8) }
        } label: {
            Label("Zoom", systemImage: "magnifyingglass")
        }
        .controlGroupStyle(.menu)
        """) { AnyView(C09_ControlGroupLabelExample()) },

        // MARK: DatePicker

        ChildExampleEntry(parent: "DatePicker", child: "DatePicker(_:selection:displayedComponents:)", code: """
        DatePicker(
            "Reminder",
            selection: $reminder,
            displayedComponents: .hourAndMinute
        )
        """) { AnyView(C09_DatePickerComponentsExample()) },

        ChildExampleEntry(parent: "DatePicker", child: "DatePicker(_:selection:in:displayedComponents:)", code: """
        DatePicker(
            "Check-in",
            selection: $checkIn,
            in: Date.now...,               // open-ended: no past dates, no future cap
            displayedComponents: .date
        )
        """) { AnyView(C09_DatePickerRangeExample()) },

        ChildExampleEntry(parent: "DatePicker", child: "DatePicker(selection:displayedComponents:label:)", code: """
        DatePicker(selection: $due, displayedComponents: .date) {
            Label("Due date", systemImage: "calendar.badge.clock")
        }
        """) { AnyView(C09_DatePickerLabelExample()) },

        // MARK: DisclosureGroup

        ChildExampleEntry(parent: "DisclosureGroup", child: "DisclosureGroup(_:content:)", code: """
        DisclosureGroup("Shipping options") {
            Picker("Speed", selection: $speed) {
                ForEach(Speed.allCases) { Text($0.label).tag($0) }
            }
        }
        """) { AnyView(C09_DisclosureGroupTitleExample()) },

        ChildExampleEntry(parent: "DisclosureGroup", child: "DisclosureGroup(_:isExpanded:content:)", code: """
        @State private var showAdvanced = false

        DisclosureGroup("Advanced", isExpanded: $showAdvanced) {
            Toggle("Verbose logging", isOn: $verbose)
        }
        Button(showAdvanced ? "Collapse from code" : "Expand from code") {
            showAdvanced.toggle()
        }
        """) { AnyView(C09_DisclosureGroupBindingExample()) },

        ChildExampleEntry(parent: "DisclosureGroup", child: "DisclosureGroup(isExpanded:content:label:)", code: """
        DisclosureGroup(isExpanded: $showDetails) {
            Text(order.notes)
        } label: {
            LabeledContent("Order #\\(order.number)") {
                Text(order.total, format: .currency(code: "USD"))
            }
        }
        """) { AnyView(C09_DisclosureGroupLabelExample()) },

        // MARK: ForEach

        ChildExampleEntry(parent: "ForEach", child: "ForEach(_:content:)", code: """
        ForEach(contacts) { contact in           // Identifiable elements
            Label(contact.name, systemImage: "person")
        }

        ForEach(0..<3) { index in                // or a constant integer range
            Text("Slot \\(index)")
        }
        """) { AnyView(C09_ForEachContentExample()) },

        ChildExampleEntry(parent: "ForEach", child: "ForEach(_:id:content:)", code: """
        ForEach(["Mon", "Tue", "Wed"], id: \\.self) { day in
            Text(day)
                .padding(.horizontal, 10).padding(.vertical, 4)
                .background(.blue.opacity(0.15), in: .capsule)
        }
        """) { AnyView(C09_ForEachIDExample()) },

        ChildExampleEntry(parent: "ForEach", child: "ForEach(_:editActions:content:)", code: """
        List {
            ForEach($tasks, editActions: .all) { $task in
                Toggle(task.title, isOn: $task.isDone)
            }
        }
        """) { AnyView(C09_ForEachEditActionsExample()) },

        ChildExampleEntry(parent: "ForEach", child: "ForEach(subviews:content:)", code: """
        struct Cards<Content: View>: View {
            let content: Content
            init(@ViewBuilder content: () -> Content) { self.content = content() }
            var body: some View {
                HStack {
                    ForEach(subviews: content) { subview in
                        subview.padding().background(.thinMaterial, in: .rect(cornerRadius: 12))
                    }
                }
            }
        }

        Cards { Text("One"); Text("Two"); Image(systemName: "star.fill") }
        """) { AnyView(C09_ForEachSubviewsExample()) },

        // MARK: Gauge

        ChildExampleEntry(parent: "Gauge", child: "Gauge(value:in:label:)", code: """
        Gauge(value: speed, in: 0...240) {
            Text("km/h")
        }
        Slider(value: $speed, in: 0...240)
        """) { AnyView(C09_GaugeBasicExample()) },

        ChildExampleEntry(parent: "Gauge", child: "Gauge(value:in:label:currentValueLabel:)", code: """
        Gauge(value: cpuLoad, in: 0...1) {
            Text("CPU")
        } currentValueLabel: {
            Text("\\(Int(cpuLoad * 100))%")
        }
        .gaugeStyle(.accessoryCircular)     // prints the current value inside the dial
        """) { AnyView(C09_GaugeCurrentValueExample()) },

        ChildExampleEntry(parent: "Gauge", child: "Gauge(value:in:label:currentValueLabel:minimumValueLabel:maximumValueLabel:)", code: """
        Gauge(value: 74, in: 0...100) {
            Text("Battery")
        } currentValueLabel: {
            Text("74%")
        } minimumValueLabel: {
            Text("0")
        } maximumValueLabel: {
            Text("100")
        }
        """) { AnyView(C09_GaugeMinMaxExample()) },

        // MARK: GeometryReader

        ChildExampleEntry(parent: "GeometryReader", child: "GeometryProxy.size", code: """
        GeometryReader { proxy in
            HStack(spacing: 0) {
                sidebar.frame(width: proxy.size.width * 0.3)
                detail
            }
        }
        """) { AnyView(C09_GeometryProxySizeExample()) },

        ChildExampleEntry(parent: "GeometryReader", child: "GeometryProxy.frame(in:)", code: """
        ScrollView {
            GeometryReader { proxy in
                let minY = proxy.frame(in: .scrollView).minY
                headerImage
                    .offset(y: minY < 0 ? -minY / 2 : 0)     // parallax as it scrolls away
            }
            .frame(height: 80)
            rows
        }
        """) { AnyView(C09_GeometryProxyFrameExample()) },

        ChildExampleEntry(parent: "GeometryReader", child: "GeometryProxy.safeAreaInsets", code: """
        GeometryReader { proxy in
            bottomBar
                .padding(.bottom, proxy.safeAreaInsets.bottom)
        }
        .ignoresSafeArea(edges: .bottom)
        """) { AnyView(C09_GeometryProxySafeAreaExample()) },

        // MARK: Grid

        ChildExampleEntry(parent: "Grid", child: "Grid(alignment:horizontalSpacing:verticalSpacing:content:)", code: """
        Grid(alignment: .leadingFirstTextBaseline, horizontalSpacing: 12, verticalSpacing: 6) {
            GridRow { Text("Name"); Text(name) }
            GridRow { Text("Email"); Text(email) }
            GridRow { Text("Role"); Text(role) }
        }
        """) { AnyView(C09_GridInitExample()) },

        ChildExampleEntry(parent: "Grid", child: "GridRow(alignment:content:)", code: """
        Grid {
            GridRow(alignment: .firstTextBaseline) {      // baselines line up
                Text("Label").font(.caption)
                Text("Value").font(.title)
            }
            GridRow(alignment: .center) {                 // centers line up
                Text("Label").font(.caption)
                Text("Value").font(.title)
            }
        }
        """) { AnyView(C09_GridRowAlignmentExample()) },

        ChildExampleEntry(parent: "Grid", child: ".gridCellColumns(_:)", code: """
        Grid(alignment: .leading) {
            GridRow { Text("Item"); Text("Qty"); Text("Price") }
            GridRow { Text("Coffee"); Text("2"); Text("$9.00") }
            GridRow {
                Text("Total")
                Text("$54.00").gridCellColumns(2)      // spans Qty + Price
            }
        }
        """) { AnyView(C09_GridCellColumnsExample()) },

        ChildExampleEntry(parent: "Grid", child: ".gridCellUnsizedAxes(_:)", code: """
        Grid {
            GridRow { Text("A"); Text("B") }
            Divider().gridCellUnsizedAxes(.horizontal)   // no longer stretches the grid
            GridRow { Text("C"); Text("D") }
        }
        """) { AnyView(C09_GridCellUnsizedAxesExample()) },

        // MARK: Group

        ChildExampleEntry(parent: "Group", child: "Group(content:)", code: """
        Group {
            if isLoading {
                ProgressView()
            } else {
                resultsList
            }
        }
        .frame(maxWidth: .infinity, minHeight: 80)     // applies to whichever branch is live
        .background(.quaternary, in: .rect(cornerRadius: 8))
        """) { AnyView(C09_GroupContentExample()) },

        ChildExampleEntry(parent: "Group", child: "Group(subviews:transform:)", code: """
        Group(subviews: content) { subviews in
            HStack { subviews.prefix(2) }
            if subviews.count > 2 {
                VStack { subviews.dropFirst(2) }
            }
        }
        """) { AnyView(C09_GroupSubviewsExample()) },

        ChildExampleEntry(parent: "Group", child: "Group(sections:transform:)", code: """
        Group(sections: content) { sections in
            ForEach(sections) { section in
                VStack(alignment: .leading) {
                    section.header.font(.headline)
                    section.content
                }
            }
        }
        """) { AnyView(C09_GroupSectionsExample()) },

        // MARK: GroupBox

        ChildExampleEntry(parent: "GroupBox", child: "GroupBox(content:)", code: """
        GroupBox {
            Text("Backups run nightly while charging.")
                .font(.callout)
        }
        """) { AnyView(C09_GroupBoxContentExample()) },

        ChildExampleEntry(parent: "GroupBox", child: "GroupBox(_:content:)", code: """
        GroupBox("Notifications") {
            Toggle("Email", isOn: $email)
            Toggle("Push", isOn: $push)
        }
        """) { AnyView(C09_GroupBoxTitleExample()) },

        ChildExampleEntry(parent: "GroupBox", child: "GroupBox(content:label:)", code: """
        GroupBox {
            storageBars
        } label: {
            Label("Storage", systemImage: "internaldrive")
        }
        """) { AnyView(C09_GroupBoxLabelExample()) },

        // MARK: HelpLink

        ChildExampleEntry(parent: "HelpLink", child: "HelpLink(destination:)", code: """
        Form {
            exportOptions
        }
        .toolbar {
            HelpLink(destination: URL(string: "https://example.com/help/export")!)
        }
        """) { AnyView(C09_HelpLinkDestinationExample()) },

        ChildExampleEntry(parent: "HelpLink", child: "HelpLink(anchor:)", code: """
        HStack {
            Spacer()
            HelpLink(anchor: "export-settings")     // anchor in the app's registered Help Book
        }
        """) { AnyView(C09_HelpLinkAnchorExample()) },

        ChildExampleEntry(parent: "HelpLink", child: "HelpLink(action:)", code: """
        HelpLink {
            showHelpPopover = true
        }
        .popover(isPresented: $showHelpPopover) {
            Text("Exports use the current page size.").padding()
        }
        """) { AnyView(C09_HelpLinkActionExample()) },

        // MARK: Image

        ChildExampleEntry(parent: "Image", child: "Image(_:)", code: """
        Image("beach")                 // named asset from the asset catalog
            .resizable()
            .scaledToFit()
            .frame(height: 100)
        """) { AnyView(C09_ImageNamedExample()) },

        ChildExampleEntry(parent: "Image", child: "Image(systemName:)", code: """
        Image(systemName: "cloud.sun.rain")
            .symbolRenderingMode(.multicolor)
            .font(.largeTitle)

        Image(systemName: "cloud.sun.rain")   // symbols track font + foregroundStyle like text
            .font(.body)
            .foregroundStyle(.blue)
        """) { AnyView(C09_ImageSystemNameExample()) },

        ChildExampleEntry(parent: "Image", child: "Image(decorative:)", code: """
        Image(decorative: "confetti-background")   // VoiceOver skips it entirely
            .resizable()
            .scaledToFill()
        """) { AnyView(C09_ImageDecorativeExample()) },

        // MARK: KeyframeAnimator

        ChildExampleEntry(parent: "KeyframeAnimator", child: "KeyframeAnimator(initialValue:repeating:content:keyframes:)", code: """
        KeyframeAnimator(initialValue: 0.0, repeating: true) { angle in
            Image(systemName: "gear")
                .rotationEffect(.degrees(angle))
        } keyframes: { _ in
            LinearKeyframe(360, duration: 2)
        }
        """) { AnyView(C09_KeyframeRepeatingExample()) },

        ChildExampleEntry(parent: "KeyframeAnimator", child: "KeyframeAnimator(initialValue:trigger:content:keyframes:)", code: """
        KeyframeAnimator(initialValue: 1.0, trigger: likeCount) { scale in
            Image(systemName: "heart.fill").scaleEffect(scale)
        } keyframes: { _ in
            CubicKeyframe(1.4, duration: 0.15)
            SpringKeyframe(1.0, duration: 0.5)
        }
        Button("Like") { likeCount += 1 }
        """) { AnyView(C09_KeyframeTriggerExample()) },

        ChildExampleEntry(parent: "KeyframeAnimator", child: "KeyframeTrack(_:content:)", code: """
        struct Bounce { var y = 0.0; var squash = 1.0 }

        KeyframeAnimator(initialValue: Bounce(), trigger: hops) { value in
            Circle().scaleEffect(x: 1, y: value.squash).offset(y: value.y)
        } keyframes: { _ in
            KeyframeTrack(\\.y) {
                CubicKeyframe(-80, duration: 0.3)
                SpringKeyframe(0, duration: 0.5)
            }
            KeyframeTrack(\\.squash) {
                LinearKeyframe(0.8, duration: 0.3)
                SpringKeyframe(1.0, duration: 0.5)
            }
        }
        """) { AnyView(C09_KeyframeTrackExample()) },

    ]
}

// MARK: - Example views

private struct C09_AnyViewInitExample: View {
    @State private var enabled = true

    private var cells: [AnyView] {
        [
            AnyView(Text("Name")),
            AnyView(Toggle("Enabled", isOn: $enabled)),
            AnyView(Image(systemName: "star"))
        ]
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(cells.indices, id: \.self) { cells[$0] }
            Text("Text, Toggle and Image share one [AnyView] storage type")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_AnyViewErasingExample: View {
    @State private var isVerified = true

    private func erased<V: View>(_ view: V) -> AnyView {
        AnyView(erasing: view)
    }

    var body: some View {
        VStack(spacing: 12) {
            Toggle("Verified", isOn: $isVerified)
            let badge = isVerified
                ? erased(Image(systemName: "checkmark.seal.fill").foregroundStyle(.blue))
                : erased(Text("—"))
            badge.font(.largeTitle)
        }
        .padding()
    }
}

private struct C09_AsyncImageURLExample: View {
    var body: some View {
        VStack(spacing: 10) {
            AsyncImage(url: nil)
                .frame(width: 44, height: 44)
                .overlay(RoundedRectangle(cornerRadius: 6).strokeBorder(.secondary.opacity(0.4)))
            Text("Illustrative — no network in this preview; the built-in gray placeholder shows until the fetch finishes")
                .font(.caption).foregroundStyle(.secondary).multilineTextAlignment(.center)
        }
        .padding()
    }
}

private struct C09_AsyncImagePlaceholderExample: View {
    var body: some View {
        VStack(spacing: 10) {
            AsyncImage(url: nil) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.2).overlay(ProgressView())
            }
            .frame(width: 140, height: 90)
            .clipShape(.rect(cornerRadius: 8))
            Text("Illustrative — no network here, so the custom placeholder stays visible")
                .font(.caption).foregroundStyle(.secondary).multilineTextAlignment(.center)
        }
        .padding()
    }
}

private struct C09_AsyncImagePhaseExample: View {
    var body: some View {
        VStack(spacing: 10) {
            AsyncImage(url: nil, transaction: Transaction(animation: .easeOut)) { phase in
                switch phase {
                case .success(let image): image.resizable().scaledToFit()
                case .failure: Image(systemName: "photo.badge.exclamationmark").font(.largeTitle)
                case .empty: ProgressView()
                @unknown default: EmptyView()
                }
            }
            .frame(width: 140, height: 90)
            .background(.quaternary, in: .rect(cornerRadius: 8))
            Text("Illustrative — url is nil here; each phase branch renders with live data at runtime")
                .font(.caption).foregroundStyle(.secondary).multilineTextAlignment(.center)
        }
        .padding()
    }
}

private struct C09_ButtonActionExample: View {
    @State private var saveCount = 0

    var body: some View {
        VStack(spacing: 10) {
            Button("Save") {
                saveCount += 1
            }
            Text("save() ran \(saveCount) time\(saveCount == 1 ? "" : "s")")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_ButtonRoleExample: View {
    @State private var lastAction = "—"

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Menu("Actions") {
                    Button("Duplicate") { lastAction = "duplicate" }
                    Button("Delete", role: .destructive) { lastAction = "delete (destructive)" }
                }
                .fixedSize()
                Button("Cancel", role: .cancel) { lastAction = "cancel" }
            }
            Text("Last: \(lastAction)").font(.caption).foregroundStyle(.secondary)
            Text("The destructive role renders red inside the menu")
                .font(.caption2).foregroundStyle(.tertiary)
        }
        .padding()
    }
}

private struct C09_ButtonSystemImageExample: View {
    @State private var drafts = 0

    var body: some View {
        VStack(spacing: 12) {
            Button("Compose", systemImage: "square.and.pencil") {
                drafts += 1
            }
            .buttonStyle(.bordered)
            Button("Compose", systemImage: "square.and.pencil") {
                drafts += 1
            }
            .buttonStyle(.bordered)
            .labelStyle(.iconOnly)
            Text("Drafts started: \(drafts) — the same Label, icon-only below")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_CanvasFlagsExample: View {
    private let sunset = Gradient(colors: [.orange, .pink, .indigo])

    var body: some View {
        VStack(spacing: 8) {
            Canvas(opaque: true, colorMode: .linear, rendersAsynchronously: true) { context, size in
                context.fill(
                    Path(CGRect(origin: .zero, size: size)),
                    with: .linearGradient(sunset, startPoint: .zero, endPoint: CGPoint(x: 0, y: size.height))
                )
            }
            .frame(height: 120)
            .clipShape(.rect(cornerRadius: 8))
            Text("opaque: true skips alpha compositing; colorMode: .linear blends in linear space")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_CanvasSymbolsExample: View {
    private func starPositions(in size: CGSize) -> [CGPoint] {
        let fractions: [(CGFloat, CGFloat)] = [
            (0.12, 0.30), (0.30, 0.65), (0.48, 0.25), (0.62, 0.70), (0.80, 0.40), (0.92, 0.75)
        ]
        return fractions.map { CGPoint(x: size.width * $0.0, y: size.height * $0.1) }
    }

    var body: some View {
        VStack(spacing: 8) {
            Canvas { context, size in
                guard let star = context.resolveSymbol(id: "star") else { return }
                for point in starPositions(in: size) {
                    context.draw(star, at: point)
                }
            } symbols: {
                Image(systemName: "star.fill").font(.title).foregroundStyle(.yellow).tag("star")
            }
            .frame(height: 110)
            .background(.indigo.gradient, in: .rect(cornerRadius: 8))
            Text("One tagged symbol view, resolved once and stamped six times")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_ChartContentExample: View {
    var body: some View {
        VStack(spacing: 8) {
            Chart {
                LineMark(x: .value("Day", 1), y: .value("Steps", 4200))
                LineMark(x: .value("Day", 2), y: .value("Steps", 6800))
                LineMark(x: .value("Day", 3), y: .value("Steps", 5100))
                RuleMark(y: .value("Goal", 6000))
                    .foregroundStyle(.red)
            }
            .frame(height: 140)
            Text("Marks listed by hand in the builder; the red RuleMark is a fixed goal line")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_DailySteps: Identifiable {
    let id = UUID()
    let date: Date
    let count: Int
}

private struct C09_ChartDataExample: View {
    private var dailySteps: [C09_DailySteps] {
        let counts = [4200, 6800, 5100, 7300, 6100, 8900, 4700]
        let base = Date(timeIntervalSinceReferenceDate: 780_000_000)
        return counts.enumerated().map { offset, count in
            C09_DailySteps(date: base.addingTimeInterval(Double(offset) * 86_400), count: count)
        }
    }

    var body: some View {
        VStack(spacing: 8) {
            Chart(dailySteps) { day in
                BarMark(
                    x: .value("Date", day.date, unit: .day),
                    y: .value("Steps", day.count)
                )
            }
            .frame(height: 140)
            Text("One BarMark per Identifiable element of the collection")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_Reading {
    let timestamp: Date
    let celsius: Double
}

private struct C09_ChartIDExample: View {
    private var readings: [C09_Reading] {
        let temps = [18.2, 19.0, 21.4, 23.1, 22.6, 20.3, 18.9]
        let base = Date(timeIntervalSinceReferenceDate: 780_000_000)
        return temps.enumerated().map { offset, celsius in
            C09_Reading(timestamp: base.addingTimeInterval(Double(offset) * 3_600), celsius: celsius)
        }
    }

    var body: some View {
        VStack(spacing: 8) {
            Chart(readings, id: \.timestamp) { reading in
                LineMark(
                    x: .value("Time", reading.timestamp),
                    y: .value("Temp", reading.celsius)
                )
            }
            .frame(height: 140)
            Text("Reading is not Identifiable, so id: \\.timestamp supplies the identity")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_Chart3DContentExample: View {
    var body: some View {
        VStack(spacing: 8) {
            Chart3D {
                PointMark(x: .value("X", 1.0), y: .value("Y", 2.0), z: .value("Z", 0.5))
                PointMark(x: .value("X", 2.0), y: .value("Y", 1.0), z: .value("Z", 1.5))
                PointMark(x: .value("X", 0.5), y: .value("Y", 1.5), z: .value("Z", 2.0))
            }
            .frame(height: 180)
            Text("Three hand-written PointMarks with x, y and z values — drag to rotate")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_Penguin: Identifiable {
    let id = UUID()
    let species: String
    let flipperLength: Double
    let bodyMass: Double
    let billLength: Double
}

private struct C09_Chart3DDataExample: View {
    private let penguins: [C09_Penguin] = [
        C09_Penguin(species: "Adelie", flipperLength: 190, bodyMass: 3700, billLength: 38.8),
        C09_Penguin(species: "Adelie", flipperLength: 186, bodyMass: 3500, billLength: 39.2),
        C09_Penguin(species: "Gentoo", flipperLength: 217, bodyMass: 5000, billLength: 47.5),
        C09_Penguin(species: "Gentoo", flipperLength: 221, bodyMass: 5300, billLength: 48.1),
        C09_Penguin(species: "Chinstrap", flipperLength: 196, bodyMass: 3750, billLength: 48.8),
        C09_Penguin(species: "Chinstrap", flipperLength: 194, bodyMass: 3600, billLength: 46.9)
    ]

    var body: some View {
        VStack(spacing: 8) {
            Chart3D(penguins) { penguin in
                PointMark(
                    x: .value("Flipper", penguin.flipperLength),
                    y: .value("Mass", penguin.bodyMass),
                    z: .value("Bill", penguin.billLength)
                )
                .foregroundStyle(by: .value("Species", penguin.species))
            }
            .frame(height: 180)
            Text("One PointMark per Identifiable penguin, colored by species")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_ColorPickerTitleExample: View {
    @State private var tint = Color.accentColor

    var body: some View {
        VStack(spacing: 12) {
            ColorPicker("Tint", selection: $tint, supportsOpacity: false)
            RoundedRectangle(cornerRadius: 8).fill(tint).frame(height: 40)
            Text("supportsOpacity: false hides the alpha slider in the color panel")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_ColorPickerLabelExample: View {
    @State private var highlight = Color.yellow.opacity(0.6)

    var body: some View {
        VStack(spacing: 12) {
            ColorPicker(selection: $highlight, supportsOpacity: true) {
                Label("Highlight", systemImage: "highlighter")
            }
            Text("Highlighted passage").padding(6).background(highlight)
            Text("The label is a custom view; supportsOpacity: true keeps the alpha control")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_ContentUnavailableTitleExample: View {
    var body: some View {
        ContentUnavailableView(
            "No Favorites",
            systemImage: "heart.slash",
            description: Text("Tap the heart on any item to save it here.")
        )
        .frame(height: 180)
    }
}

private struct C09_ContentUnavailableBuilderExample: View {
    @State private var retries = 0

    var body: some View {
        ContentUnavailableView {
            Label("Offline", systemImage: "wifi.slash")
        } description: {
            Text(retries == 0 ? "Reconnect to load your inbox." : "Still offline after \(retries) retr\(retries == 1 ? "y" : "ies").")
        } actions: {
            Button("Retry") { retries += 1 }
        }
        .frame(height: 190)
    }
}

private struct C09_ContentUnavailableSearchExample: View {
    @State private var results: [String] = []

    var body: some View {
        VStack(spacing: 8) {
            Toggle("Has results", isOn: Binding(
                get: { !results.isEmpty },
                set: { results = $0 ? ["Apple", "Banana", "Cherry"] : [] }
            ))
            if results.isEmpty {
                ContentUnavailableView.search
            } else {
                List(results, id: \.self) { Text($0) }
            }
        }
        .frame(height: 190)
        .padding(.horizontal)
    }
}

private struct C09_ContentUnavailableSearchTextExample: View {
    @State private var query = "kiwi"
    private let fruit = ["Apple", "Banana", "Cherry", "Grape", "Mango"]

    private var filtered: [String] {
        query.isEmpty ? fruit : fruit.filter { $0.localizedCaseInsensitiveContains(query) }
    }

    var body: some View {
        VStack(spacing: 8) {
            TextField("Search fruit", text: $query)
                .textFieldStyle(.roundedBorder)
            if filtered.isEmpty, !query.isEmpty {
                ContentUnavailableView.search(text: query)
            } else {
                List(filtered, id: \.self) { Text($0) }
            }
        }
        .frame(height: 200)
        .padding(.horizontal)
    }
}

private struct C09_ControlGroupContentExample: View {
    @State private var position = 3
    private let history = ["Draft", "Edit 1", "Edit 2", "Edit 3", "Edit 4"]

    var body: some View {
        VStack(spacing: 12) {
            ControlGroup {
                Button("Undo", systemImage: "arrow.uturn.backward") { position = max(0, position - 1) }
                Button("Redo", systemImage: "arrow.uturn.forward") { position = min(history.count - 1, position + 1) }
            }
            .fixedSize()
            Text("Document state: \(history[position])")
                .font(.caption).foregroundStyle(.secondary)
            Text("Unlabeled cluster — the two buttons render as one bordered group")
                .font(.caption2).foregroundStyle(.tertiary)
        }
        .padding()
    }
}

private struct C09_ControlGroupTitledExample: View {
    @State private var isBold = false
    @State private var isItalic = false

    var body: some View {
        VStack(spacing: 12) {
            ControlGroup("Text Style", systemImage: "textformat") {
                Button("Bold", systemImage: "bold") { isBold.toggle() }
                Button("Italic", systemImage: "italic") { isItalic.toggle() }
            }
            .controlGroupStyle(.menu)
            .fixedSize()
            Text("The quick brown fox")
                .font(.title3)
                .bold(isBold)
                .italic(isItalic)
            Text("Title + systemImage become the menu's header")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_ControlGroupLabelExample: View {
    @State private var scale = 1.0

    var body: some View {
        VStack(spacing: 12) {
            ControlGroup {
                Button("Zoom In", systemImage: "plus.magnifyingglass") { scale = min(2.5, scale * 1.25) }
                Button("Zoom Out", systemImage: "minus.magnifyingglass") { scale = max(0.4, scale * 0.8) }
            } label: {
                Label("Zoom", systemImage: "magnifyingglass")
            }
            .controlGroupStyle(.menu)
            .fixedSize()
            Image(systemName: "swift")
                .font(.largeTitle)
                .foregroundStyle(.orange)
                .scaleEffect(scale)
                .frame(height: 70)
            Text("Scale \(String(format: "%.2f", scale))× — the label is an arbitrary view")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_DatePickerComponentsExample: View {
    @State private var reminder = Date(timeIntervalSinceReferenceDate: 780_030_600)

    var body: some View {
        VStack(spacing: 12) {
            DatePicker(
                "Reminder",
                selection: $reminder,
                displayedComponents: .hourAndMinute
            )
            .fixedSize()
            Text("Only the time components are editable: \(reminder, format: .dateTime.hour().minute())")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_DatePickerRangeExample: View {
    @State private var checkIn = Date.now

    var body: some View {
        VStack(spacing: 12) {
            DatePicker(
                "Check-in",
                selection: $checkIn,
                in: Date.now...,
                displayedComponents: .date
            )
            .fixedSize()
            Text("Stepping below today is refused — the range starts at Date.now")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_DatePickerLabelExample: View {
    @State private var due = Date(timeIntervalSinceReferenceDate: 780_000_000)

    var body: some View {
        VStack(spacing: 12) {
            DatePicker(selection: $due, displayedComponents: .date) {
                Label("Due date", systemImage: "calendar.badge.clock")
            }
            .fixedSize()
            Text("The label is a custom Label view instead of a plain title")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private enum C09_Speed: String, CaseIterable, Identifiable {
    case standard, express, overnight
    var id: String { rawValue }
    var label: String { rawValue.capitalized }
}

private struct C09_DisclosureGroupTitleExample: View {
    @State private var speed = C09_Speed.standard

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            DisclosureGroup("Shipping options") {
                Picker("Speed", selection: $speed) {
                    ForEach(C09_Speed.allCases) { Text($0.label).tag($0) }
                }
                .pickerStyle(.segmented)
            }
            Text("The group tracks its own expanded state — selected: \(speed.label)")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_DisclosureGroupBindingExample: View {
    @State private var showAdvanced = false
    @State private var verbose = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            DisclosureGroup("Advanced", isExpanded: $showAdvanced) {
                Toggle("Verbose logging", isOn: $verbose)
            }
            Button(showAdvanced ? "Collapse from code" : "Expand from code") {
                showAdvanced.toggle()
            }
            Text("The isExpanded binding lets code open or close the group")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_DisclosureGroupLabelExample: View {
    @State private var showDetails = true
    private let orderNumber = 4821
    private let orderTotal = 129.5
    private let orderNotes = "Leave at the side door. Signature not required."

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            DisclosureGroup(isExpanded: $showDetails) {
                Text(orderNotes)
                    .font(.callout)
                    .padding(.top, 4)
            } label: {
                LabeledContent("Order #\(orderNumber)") {
                    Text(orderTotal, format: .currency(code: "USD"))
                }
            }
            Text("Custom LabeledContent label plus an expansion binding")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_Contact: Identifiable {
    let id = UUID()
    let name: String
}

private struct C09_ForEachContentExample: View {
    private let contacts = [C09_Contact(name: "Ada"), C09_Contact(name: "Grace"), C09_Contact(name: "Linus")]

    var body: some View {
        HStack(alignment: .top, spacing: 24) {
            VStack(alignment: .leading, spacing: 6) {
                ForEach(contacts) { contact in
                    Label(contact.name, systemImage: "person")
                }
                Text("Identifiable collection").font(.caption).foregroundStyle(.secondary)
            }
            VStack(alignment: .leading, spacing: 6) {
                ForEach(0..<3) { index in
                    Text("Slot \(index)")
                }
                Text("Constant Range<Int>").font(.caption).foregroundStyle(.secondary)
            }
        }
        .padding()
    }
}

private struct C09_ForEachIDExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                ForEach(["Mon", "Tue", "Wed"], id: \.self) { day in
                    Text(day)
                        .padding(.horizontal, 10).padding(.vertical, 4)
                        .background(.blue.opacity(0.15), in: .capsule)
                }
            }
            Text("Plain Strings are not Identifiable, so id: \\.self supplies the identity")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_Todo: Identifiable {
    let id = UUID()
    var title: String
    var isDone: Bool
}

private struct C09_ForEachEditActionsExample: View {
    @State private var tasks = [
        C09_Todo(title: "Write tests", isDone: true),
        C09_Todo(title: "Review PR", isDone: false),
        C09_Todo(title: "Ship build", isDone: false)
    ]

    var body: some View {
        VStack(spacing: 6) {
            List {
                ForEach($tasks, editActions: .all) { $task in
                    Toggle(task.title, isOn: $task.isDone)
                }
            }
            .frame(height: 120)
            Text("Rows get a Binding; drag to reorder, press Delete to remove — \(tasks.filter(\.isDone).count)/\(tasks.count) done")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding(.horizontal)
    }
}

private struct C09_Cards<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) { self.content = content() }
    var body: some View {
        HStack {
            ForEach(subviews: content) { subview in
                subview.padding().background(.thinMaterial, in: .rect(cornerRadius: 12))
            }
        }
    }
}

private struct C09_ForEachSubviewsExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C09_Cards {
                Text("One")
                Text("Two")
                Image(systemName: "star.fill").foregroundStyle(.yellow)
            }
            Text("Each resolved child of `content` is wrapped in its own card")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_GaugeBasicExample: View {
    @State private var speed = 96.0

    var body: some View {
        VStack(spacing: 12) {
            Gauge(value: speed, in: 0...240) {
                Text("km/h")
            }
            Slider(value: $speed, in: 0...240)
            Text("Value, range and a label only — \(String(format: "%.0f", speed)) of 240")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_GaugeCurrentValueExample: View {
    @State private var cpuLoad = 0.42

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 24) {
                Gauge(value: cpuLoad, in: 0...1) {
                    Text("CPU")
                } currentValueLabel: {
                    Text("\(Int(cpuLoad * 100))%")
                }
                .gaugeStyle(.accessoryCircular)
                Gauge(value: cpuLoad, in: 0...1) {
                    Text("CPU")
                } currentValueLabel: {
                    Text("\(Int(cpuLoad * 100))%")
                }
            }
            Slider(value: $cpuLoad, in: 0...1)
            Text("Same gauge in accessoryCircular and the default linear style")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_GaugeMinMaxExample: View {
    @State private var battery = 74.0

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 24) {
                Gauge(value: battery, in: 0...100) {
                    Text("Battery")
                } currentValueLabel: {
                    Text("\(Int(battery))%")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("100")
                }
                .gaugeStyle(.accessoryCircular)
                Gauge(value: battery, in: 0...100) {
                    Text("Battery")
                } currentValueLabel: {
                    Text("\(Int(battery))%")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("100")
                }
            }
            Slider(value: $battery, in: 0...100)
            Text("Min and max labels flank the track (linear) or the dial ends (circular)")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_GeometryProxySizeExample: View {
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 0) {
                VStack {
                    Text("Sidebar").font(.caption.bold())
                    Text("30%").font(.caption2)
                }
                .frame(width: proxy.size.width * 0.3)
                .frame(maxHeight: .infinity)
                .background(.blue.opacity(0.2))
                VStack(spacing: 4) {
                    Text("Detail").font(.caption.bold())
                    Text("proxy.size = \(String(format: "%.0f", proxy.size.width)) × \(String(format: "%.0f", proxy.size.height))")
                        .font(.caption2).foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.gray.opacity(0.12))
            }
            .clipShape(.rect(cornerRadius: 8))
        }
        .frame(height: 120)
        .padding()
    }
}

private struct C09_GeometryProxyFrameExample: View {
    var body: some View {
        ScrollView {
            GeometryReader { proxy in
                let minY = proxy.frame(in: .scrollView).minY
                Rectangle()
                    .fill(LinearGradient(colors: [.teal, .blue], startPoint: .leading, endPoint: .trailing))
                    .overlay(
                        Text("frame(in: .scrollView).minY = \(String(format: "%.0f", minY))")
                            .font(.caption.monospacedDigit()).foregroundStyle(.white)
                    )
                    .offset(y: minY < 0 ? -minY / 2 : 0)
            }
            .frame(height: 80)
            ForEach(0..<8) { row in
                Text("Row \(row)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.vertical, 6)
            }
        }
        .frame(height: 180)
        .clipShape(.rect(cornerRadius: 8))
        .padding(.horizontal)
    }
}

private struct C09_GeometryProxySafeAreaExample: View {
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                Spacer()
                Text("proxy.safeAreaInsets.bottom = \(String(format: "%.0f", proxy.safeAreaInsets.bottom)) pt")
                    .font(.caption).foregroundStyle(.secondary)
                    .padding(.bottom, 6)
                HStack {
                    Image(systemName: "house"); Spacer()
                    Image(systemName: "magnifyingglass"); Spacer()
                    Image(systemName: "person")
                }
                .padding(.horizontal, 32).padding(.vertical, 10)
                .background(.blue.opacity(0.2))
                .padding(.bottom, proxy.safeAreaInsets.bottom)
            }
            .frame(maxWidth: .infinity)
        }
        .ignoresSafeArea(edges: .bottom)
        .safeAreaInset(edge: .bottom) {
            Rectangle().fill(.quaternary).frame(height: 28)
                .overlay(Text("simulated 28 pt bottom inset").font(.caption2).foregroundStyle(.secondary))
        }
        .frame(height: 160)
        .clipShape(.rect(cornerRadius: 8))
        .padding(.horizontal)
    }
}

private struct C09_GridInitExample: View {
    var body: some View {
        VStack(spacing: 10) {
            Grid(alignment: .leadingFirstTextBaseline, horizontalSpacing: 12, verticalSpacing: 6) {
                GridRow { Text("Name").foregroundStyle(.secondary); Text("Ada Lovelace") }
                GridRow { Text("Email").foregroundStyle(.secondary); Text("ada@example.com") }
                GridRow { Text("Role").foregroundStyle(.secondary); Text("Analyst").font(.title3) }
            }
            Text("Cells lead-align on the first text baseline; 12 pt between columns, 6 pt between rows")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_GridRowAlignmentExample: View {
    var body: some View {
        VStack(spacing: 10) {
            Grid(horizontalSpacing: 16, verticalSpacing: 10) {
                GridRow(alignment: .firstTextBaseline) {
                    Text("Label").font(.caption).background(.orange.opacity(0.25))
                    Text("Value").font(.title).background(.orange.opacity(0.25))
                    Text(".firstTextBaseline").font(.caption2).foregroundStyle(.secondary)
                }
                GridRow(alignment: .center) {
                    Text("Label").font(.caption).background(.blue.opacity(0.25))
                    Text("Value").font(.title).background(.blue.opacity(0.25))
                    Text(".center").font(.caption2).foregroundStyle(.secondary)
                }
            }
            Text("Per-row vertical alignment: baselines meet in the first row, centers in the second")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_GridCellColumnsExample: View {
    var body: some View {
        VStack(spacing: 10) {
            Grid(alignment: .leading, horizontalSpacing: 16, verticalSpacing: 6) {
                GridRow {
                    Text("Item").bold(); Text("Qty").bold(); Text("Price").bold()
                }
                GridRow { Text("Coffee"); Text("2"); Text("$9.00") }
                GridRow { Text("Beans"); Text("3"); Text("$45.00") }
                Divider().gridCellUnsizedAxes(.horizontal)
                GridRow {
                    Text("Total").bold()
                    Text("$54.00").bold()
                        .gridCellColumns(2)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .background(.green.opacity(0.2))
                }
            }
            Text("The highlighted cell spans the Qty and Price columns")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_GridCellUnsizedAxesExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .top, spacing: 24) {
                VStack(spacing: 4) {
                    Grid {
                        GridRow { Text("A"); Text("B") }
                        Divider()
                        GridRow { Text("C"); Text("D") }
                    }
                    .padding(6)
                    .background(.red.opacity(0.12))
                    Text("plain Divider").font(.caption2).foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                VStack(spacing: 4) {
                    Grid {
                        GridRow { Text("A"); Text("B") }
                        Divider().gridCellUnsizedAxes(.horizontal)
                        GridRow { Text("C"); Text("D") }
                    }
                    .padding(6)
                    .background(.green.opacity(0.12))
                    Text(".gridCellUnsizedAxes(.horizontal)").font(.caption2).foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
            }
            Text("Left: the Divider's flexible width stretches the grid. Right: it no longer contributes to sizing")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_GroupContentExample: View {
    @State private var isLoading = true

    var body: some View {
        VStack(spacing: 10) {
            Toggle("Loading", isOn: $isLoading)
            Group {
                if isLoading {
                    ProgressView()
                } else {
                    VStack(alignment: .leading, spacing: 4) {
                        Label("Result one", systemImage: "doc")
                        Label("Result two", systemImage: "doc")
                    }
                }
            }
            .frame(maxWidth: .infinity, minHeight: 80)
            .background(.quaternary, in: .rect(cornerRadius: 8))
            Text("One frame + background applied to both branches through the Group")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_SplitLayout<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) { self.content = content() }
    var body: some View {
        Group(subviews: content) { subviews in
            HStack { subviews.prefix(2) }
            if subviews.count > 2 {
                VStack { subviews.dropFirst(2) }
            }
        }
    }
}

private struct C09_GroupSubviewsExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C09_SplitLayout {
                Text("First").padding(6).background(.blue.opacity(0.2), in: .capsule)
                Text("Second").padding(6).background(.blue.opacity(0.2), in: .capsule)
                Text("Third").padding(6).background(.orange.opacity(0.2), in: .capsule)
                Text("Fourth").padding(6).background(.orange.opacity(0.2), in: .capsule)
            }
            Text("Four children: the first two go in an HStack, the rest are stacked vertically")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_SectionedColumns<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) { self.content = content() }
    var body: some View {
        HStack(alignment: .top, spacing: 24) {
            Group(sections: content) { sections in
                ForEach(sections) { section in
                    VStack(alignment: .leading) {
                        section.header.font(.headline)
                        section.content
                    }
                }
            }
        }
    }
}

private struct C09_GroupSectionsExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C09_SectionedColumns {
                Section("Fruit") {
                    Text("Apple")
                    Text("Pear")
                }
                Section("Vegetables") {
                    Text("Leek")
                    Text("Kale")
                }
            }
            Text("Section boundaries survive: each header sits above its own content")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_GroupBoxContentExample: View {
    var body: some View {
        VStack(spacing: 10) {
            GroupBox {
                Text("Backups run nightly while charging.")
                    .font(.callout)
            }
            Text("An untitled platter around the content")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_GroupBoxTitleExample: View {
    @State private var email = true
    @State private var push = false

    var body: some View {
        VStack(spacing: 10) {
            GroupBox("Notifications") {
                Toggle("Email", isOn: $email)
                Toggle("Push", isOn: $push)
            }
            Text("The string becomes the box's title")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_GroupBoxLabelExample: View {
    private let usage: [(String, Double, Color)] = [("Apps", 0.45, .blue), ("Photos", 0.30, .pink), ("Other", 0.10, .gray)]

    private var storageBars: some View {
        VStack(alignment: .leading, spacing: 6) {
            ForEach(usage, id: \.0) { name, fraction, color in
                HStack {
                    Text(name).font(.caption).frame(width: 50, alignment: .leading)
                    GeometryReader { proxy in
                        Capsule().fill(color).frame(width: proxy.size.width * fraction)
                    }
                    .frame(height: 8)
                }
            }
        }
    }

    var body: some View {
        VStack(spacing: 10) {
            GroupBox {
                storageBars
            } label: {
                Label("Storage", systemImage: "internaldrive")
            }
            Text("The label is a custom Label view")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_HelpLinkDestinationExample: View {
    @State private var includeMetadata = true
    private let destination = URL(string: "https://example.com/help/export")

    var body: some View {
        VStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Export").font(.headline)
                Toggle("Include metadata", isOn: $includeMetadata)
                HStack {
                    if let destination {
                        HelpLink(destination: destination)
                    }
                    Spacer()
                    Button("Cancel") { }
                    Button("Export") { }.buttonStyle(.borderedProminent)
                }
            }
            .padding()
            .background(.background, in: .rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))
            Text("Illustrative sheet — in a real window the link lives in the toolbar; clicking opens the URL in the default browser")
                .font(.caption).foregroundStyle(.secondary).multilineTextAlignment(.center)
        }
        .padding()
    }
}

private struct C09_HelpLinkAnchorExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Export settings").font(.headline)
                Spacer()
                HelpLink(anchor: "export-settings")
            }
            .padding()
            .background(.quaternary.opacity(0.4), in: .rect(cornerRadius: 10))
            Text("Illustrative — opens the \"export-settings\" anchor of the app's registered Help Book; this app registers none")
                .font(.caption).foregroundStyle(.secondary).multilineTextAlignment(.center)
        }
        .padding()
    }
}

private struct C09_HelpLinkActionExample: View {
    @State private var showHelpPopover = false

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Page size").font(.headline)
                Spacer()
                HelpLink {
                    showHelpPopover = true
                }
                .popover(isPresented: $showHelpPopover) {
                    Text("Exports use the current page size.").padding()
                }
            }
            .padding()
            .background(.quaternary.opacity(0.4), in: .rect(cornerRadius: 10))
            Text("The closure runs on click — here it presents an in-app popover")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_ImageNamedExample: View {
    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 8)
                .fill(LinearGradient(colors: [.cyan, .blue, .yellow], startPoint: .top, endPoint: .bottom))
                .aspectRatio(16 / 10, contentMode: .fit)
                .frame(height: 100)
                .overlay(
                    Label("\"beach\"", systemImage: "photo")
                        .font(.caption.bold()).foregroundStyle(.white)
                )
            Text("Illustrative stand-in — Image(\"beach\") loads the named asset from the catalog at runtime; this preview bundles no assets")
                .font(.caption).foregroundStyle(.secondary).multilineTextAlignment(.center)
        }
        .padding()
    }
}

private struct C09_ImageSystemNameExample: View {
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 24) {
                Image(systemName: "cloud.sun.rain")
                    .symbolRenderingMode(.multicolor)
                    .font(.largeTitle)
                Image(systemName: "cloud.sun.rain")
                    .font(.body)
                    .foregroundStyle(.blue)
                Image(systemName: "cloud.sun.rain")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .foregroundStyle(.secondary)
            }
            Text("One SF Symbol: multicolor at .largeTitle, blue at .body, secondary with .imageScale(.large)")
                .font(.caption).foregroundStyle(.secondary).multilineTextAlignment(.center)
        }
        .padding()
    }
}

private struct C09_ImageDecorativeExample: View {
    private let confetti: [(CGFloat, CGFloat, Color)] = [
        (0.08, 0.30, .pink), (0.20, 0.70, .yellow), (0.33, 0.20, .mint), (0.47, 0.60, .orange),
        (0.60, 0.25, .purple), (0.72, 0.75, .cyan), (0.85, 0.40, .green), (0.94, 0.65, .red)
    ]

    var body: some View {
        VStack(spacing: 8) {
            Canvas { context, size in
                for (fx, fy, color) in confetti {
                    let rect = CGRect(x: size.width * fx, y: size.height * fy, width: 10, height: 6)
                    context.fill(Path(roundedRect: rect, cornerRadius: 2), with: .color(color))
                }
            }
            .frame(height: 80)
            .background(.quaternary.opacity(0.3), in: .rect(cornerRadius: 8))
            .accessibilityHidden(true)
            Text("Illustrative stand-in — the real call loads \"confetti-background\" from the asset catalog with no accessibility label, so VoiceOver skips it")
                .font(.caption).foregroundStyle(.secondary).multilineTextAlignment(.center)
        }
        .padding()
    }
}

private struct C09_KeyframeRepeatingExample: View {
    var body: some View {
        VStack(spacing: 10) {
            KeyframeAnimator(initialValue: 0.0, repeating: true) { angle in
                Image(systemName: "gear")
                    .font(.system(size: 44))
                    .foregroundStyle(.secondary)
                    .rotationEffect(.degrees(angle))
            } keyframes: { _ in
                LinearKeyframe(360, duration: 2)
            }
            .frame(height: 60)
            Text("repeating: true — the 0→360° track restarts as soon as it finishes")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_KeyframeTriggerExample: View {
    @State private var likeCount = 0

    var body: some View {
        VStack(spacing: 10) {
            KeyframeAnimator(initialValue: 1.0, trigger: likeCount) { scale in
                Image(systemName: "heart.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(.pink)
                    .scaleEffect(scale)
            } keyframes: { _ in
                CubicKeyframe(1.4, duration: 0.15)
                SpringKeyframe(1.0, duration: 0.5)
            }
            .frame(height: 60)
            Button("Like") { likeCount += 1 }
            Text("Plays once per change of `trigger` — \(likeCount) like\(likeCount == 1 ? "" : "s")")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_Bounce {
    var y = 0.0
    var squash = 1.0
}

private struct C09_KeyframeTrackExample: View {
    @State private var hops = 0

    var body: some View {
        VStack(spacing: 10) {
            KeyframeAnimator(initialValue: C09_Bounce(), trigger: hops) { value in
                Circle()
                    .fill(.orange.gradient)
                    .frame(width: 40, height: 40)
                    .scaleEffect(x: 1, y: value.squash, anchor: .bottom)
                    .offset(y: value.y)
            } keyframes: { _ in
                KeyframeTrack(\.y) {
                    CubicKeyframe(-80, duration: 0.3)
                    SpringKeyframe(0, duration: 0.5)
                }
                KeyframeTrack(\.squash) {
                    LinearKeyframe(0.8, duration: 0.3)
                    SpringKeyframe(1.0, duration: 0.5)
                }
            }
            .frame(height: 130, alignment: .bottom)
            Button("Hop") { hops += 1 }
            Text("Two tracks on one value: \\.y and \\.squash each follow their own keyframe timeline")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}
