//
//  ChildExamples+Part04.swift
//  Aviary
//
//  Compiled renderings for variant entries (part 04: modifiers).
//  One private C04_* struct per variant; every rendering exercises the exact
//  overload the variant names, so siblings can be compared side by side.
//

import SwiftUI

enum ChildExamplesPart04 {
    static let entries: [ChildExampleEntry] = [

        // MARK: .onAppear()

        ChildExampleEntry(parent: ".onAppear()", child: "onAppear(perform:)", code: """
        Toggle("Show detail", isOn: $isShown)
        if isShown {
            DetailCard()
                .onAppear {
                    appearCount += 1          // analytics.track(.viewedDetail)
                }
        }
        """) { AnyView(C04_OnAppearExample()) },

        ChildExampleEntry(parent: ".onAppear()", child: "onDisappear(perform:)", code: """
        Toggle("Show live chart", isOn: $showChart)
        if showChart {
            LiveChart()
                .onAppear { log.append("ticker.start()") }
                .onDisappear { log.append("ticker.stop()") }
        }
        """) { AnyView(C04_OnDisappearExample()) },

        // MARK: .onChange()

        ChildExampleEntry(parent: ".onChange()", child: "onChange(of:initial:_:) (two-parameter)", code: """
        Slider(value: $volume)
            .onChange(of: volume) { oldValue, newValue in
                direction = newValue > oldValue ? "fadeUp()" : "fadeDown()"
                delta = newValue - oldValue
            }
        """) { AnyView(C04_OnChangeTwoParamExample()) },

        ChildExampleEntry(parent: ".onChange()", child: "onChange(of:initial:_:) (zero-parameter)", code: """
        Picker("Filter", selection: $filter) { … }
            .onChange(of: filter, initial: true) {
                reloadCount += 1              // reloadData()
            }
        """) { AnyView(C04_OnChangeZeroParamExample()) },

        // MARK: .onHover()

        ChildExampleEntry(parent: ".onHover()", child: "onHover(perform:)", code: """
        Text("Read the release notes")
            .underline(isHovering)
            .foregroundStyle(isHovering ? Color.blue : Color.primary)
            .onHover { isHovering = $0 }
        """) { AnyView(C04_OnHoverExample()) },

        ChildExampleEntry(parent: ".onHover()", child: "onContinuousHover(coordinateSpace:perform:)", code: """
        swatch
            .onContinuousHover(coordinateSpace: .local) { phase in
                switch phase {
                case .active(let point): hoverPoint = point
                case .ended: hoverPoint = nil
                }
            }
        """) { AnyView(C04_OnContinuousHoverExample()) },

        ChildExampleEntry(parent: ".onHover()", child: "HoverPhase", code: """
        .onContinuousHover { phase in
            if case .active(let location) = phase {
                crosshair = location          // HoverPhase.active(CGPoint)
            } else {
                crosshair = nil               // HoverPhase.ended
            }
        }
        """) { AnyView(C04_HoverPhaseExample()) },

        // MARK: .onScrollGeometryChange()

        ChildExampleEntry(parent: ".onScrollGeometryChange()", child: "onScrollGeometryChange(for:of:action:)", code: """
        ScrollView { feed }
            .onScrollGeometryChange(for: CGFloat.self) { geo in
                geo.contentOffset.y + geo.contentInsets.top
            } action: { _, offset in
                headerOpacity = max(0, 1 - offset / 120)
            }
        """) { AnyView(C04_OnScrollGeometryChangeExample()) },

        ChildExampleEntry(parent: ".onScrollGeometryChange()", child: "ScrollGeometry", code: """
        .onScrollGeometryChange(for: Bool.self) { geo in
            geo.contentOffset.y + geo.containerSize.height
                >= geo.contentSize.height - 40
        } action: { _, nearEnd in
            if nearEnd { loadMore() }
        }
        """) { AnyView(C04_ScrollGeometryExample()) },

        ChildExampleEntry(parent: ".onScrollGeometryChange()", child: "onScrollPhaseChange(_:)", code: """
        ScrollView { grid }
            .onScrollPhaseChange { _, newPhase in
                phase = newPhase
                isScrolling = newPhase != .idle
            }
        """) { AnyView(C04_OnScrollPhaseChangeExample()) },

        // MARK: .onSubmit()

        ChildExampleEntry(parent: ".onSubmit()", child: "onSubmit(of:_:)", code: """
        TextField("Search parks", text: $query)
            .onSubmit(of: .text) {          // .search would listen to a .searchable field
                submitted.append(query)     // runSearch()
            }
        """) { AnyView(C04_OnSubmitOfExample()) },

        ChildExampleEntry(parent: ".onSubmit()", child: "submitLabel(_:)", code: """
        TextField("Message", text: $draft)
            .submitLabel(.send)
            .onSubmit { send() }
        """) { AnyView(C04_SubmitLabelExample()) },

        ChildExampleEntry(parent: ".onSubmit()", child: "submitScope(_:)", code: """
        VStack {
            TextField("Filter", text: $filter)
                .submitScope()              // Return here stops at this field
            TextField("Name", text: $name)  // Return here bubbles up
        }
        .onSubmit { saveCount += 1 }
        """) { AnyView(C04_SubmitScopeExample()) },

        // MARK: .onTapGesture()

        ChildExampleEntry(parent: ".onTapGesture()", child: "onTapGesture(count:perform:)", code: """
        photo
            .scaleEffect(isZoomed ? 1.5 : 1)
            .onTapGesture(count: 2) {
                withAnimation(.snappy) { isZoomed.toggle() }   // zoomToFit()
            }
        """) { AnyView(C04_OnTapCountExample()) },

        ChildExampleEntry(parent: ".onTapGesture()", child: "onTapGesture(count:coordinateSpace:perform:)", code: """
        canvas
            .onTapGesture(coordinateSpace: .local) { point in
                pins.append(point)          // addPin(at: point)
            }
        """) { AnyView(C04_OnTapCoordinateSpaceExample()) },

        ChildExampleEntry(parent: ".onTapGesture()", child: "onLongPressGesture(minimumDuration:maximumDistance:perform:onPressingChanged:)", code: """
        tile
            .scaleEffect(isPressed ? 0.92 : 1)
            .onLongPressGesture(minimumDuration: 0.6) {
                isEditing.toggle()          // enterEditMode()
            } onPressingChanged: { pressing in
                isPressed = pressing
            }
        """) { AnyView(C04_OnLongPressExample()) },

        // MARK: .overlay()

        ChildExampleEntry(parent: ".overlay()", child: "overlay(_:in:)", code: """
        cover                                // plain, for comparison
        cover
            .overlay(.black.opacity(0.25), in: .rect(cornerRadius: 12))
        """) { AnyView(C04_OverlayStyleInShapeExample()) },

        ChildExampleEntry(parent: ".overlay()", child: "overlay(alignment:content:)", code: """
        thumbnail
            .overlay(alignment: .topTrailing) {
                Text("3")
                    .font(.caption2.bold())
                    .padding(5)
                    .background(.red, in: .circle)
                    .padding(4)
            }
        """) { AnyView(C04_OverlayAlignmentExample()) },

        // MARK: .padding()

        ChildExampleEntry(parent: ".padding()", child: "padding()", code: """
        Text("Tight")
            .border(.secondary)

        Text("Comfortable")
            .padding()
            .border(.secondary)
        """) { AnyView(C04_PaddingDefaultExample()) },

        ChildExampleEntry(parent: ".padding()", child: "padding(_:)", code: """
        Image(systemName: "star.fill")
            .padding(12)                     // also shown with 4 and 24
            .background(.quaternary, in: .circle)
        """) { AnyView(C04_PaddingLengthExample()) },

        ChildExampleEntry(parent: ".padding()", child: "padding(_:_:)", code: """
        Text("Wide sides")
            .padding(.horizontal, 24)
            .background(.blue.opacity(0.2))   // shows the horizontal inset
            .padding(.top, 4)
            .border(.secondary)
        """) { AnyView(C04_PaddingEdgesExample()) },

        // MARK: .popover()

        ChildExampleEntry(parent: ".popover()", child: "popover(isPresented:attachmentAnchor:arrowEdge:content:)", code: """
        Button("Legend") { showLegend = true }
            .popover(isPresented: $showLegend, arrowEdge: .top) {
                LegendView().padding()
            }
        """) { AnyView(C04_PopoverIsPresentedExample()) },

        ChildExampleEntry(parent: ".popover()", child: "popover(item:attachmentAnchor:arrowEdge:content:)", code: """
        tileRow                              // taps set inspectedTile = tile
            .popover(item: $inspectedTile) { tile in
                TileInspector(tile)
                    .frame(minWidth: 120)
            }
        """) { AnyView(C04_PopoverItemExample()) },

        // MARK: .position()

        ChildExampleEntry(parent: ".position()", child: "position(_:)", code: """
        Circle()
            .frame(width: 16, height: 16)
            .position(location)              // a CGPoint, updated by the drag
            .gesture(DragGesture().onChanged { location = $0.location })
        """) { AnyView(C04_PositionPointExample()) },

        ChildExampleEntry(parent: ".position()", child: "position(x:y:)", code: """
        GeometryReader { geo in
            Marker(.red)
                .position(x: geo.size.width * 0.25, y: geo.size.height / 2)
            Marker(.blue)
                .position(x: geo.size.width * 0.75, y: geo.size.height / 2)
        }
        """) { AnyView(C04_PositionXYExample()) },

        // MARK: .presentationDetents()

        ChildExampleEntry(parent: ".presentationDetents()", child: "presentationDetents(_:selection:)", code: """
        @State private var detent: PresentationDetent = .medium

        .sheet(isPresented: $showPanel) {
            Panel()
                .presentationDetents([.medium, .large], selection: $detent)
        }
        """) { AnyView(C04_PresentationDetentsSelectionExample()) },

        ChildExampleEntry(parent: ".presentationDetents()", child: "PresentationDetent.fraction(_:)", code: """
        Sheet()
            .presentationDetents([.fraction(0.3), .large])
            .presentationDragIndicator(.visible)
        """) { AnyView(C04_DetentFractionExample()) },

        ChildExampleEntry(parent: ".presentationDetents()", child: "PresentationDetent.height(_:)", code: """
        QuickActions()
            .presentationDetents([.height(220)])
        """) { AnyView(C04_DetentHeightExample()) },

        ChildExampleEntry(parent: ".presentationDetents()", child: "presentationBackgroundInteraction(_:)", code: """
        MapView()
            .sheet(isPresented: .constant(true)) {
                PlacesList()
                    .presentationDetents([.height(80), .medium, .large])
                    .presentationBackgroundInteraction(.enabled(upThrough: .medium))
            }
        """) { AnyView(C04_BackgroundInteractionExample()) },

        // MARK: .presentationSizing()

        ChildExampleEntry(parent: ".presentationSizing()", child: "PresentationSizing.form", code: """
        Button("Preferences…") { showPrefs = true }
            .sheet(isPresented: $showPrefs) {
                PreferencesForm()
                    .presentationSizing(.form)
            }
        """) { AnyView(C04_SizingFormExample()) },

        ChildExampleEntry(parent: ".presentationSizing()", child: "PresentationSizing.page", code: """
        Button("Open draft…") { draft = Draft(title: "Untitled") }
            .sheet(item: $draft) { draft in
                DraftEditor(draft)
                    .presentationSizing(.page)
            }
        """) { AnyView(C04_SizingPageExample()) },

        ChildExampleEntry(parent: ".presentationSizing()", child: "fitted(horizontal:vertical:)", code: """
        Button("Choose icon…") { showPicker = true }
            .sheet(isPresented: $showPicker) {
                IconPicker()
                    .presentationSizing(.form.fitted(horizontal: false, vertical: true))
            }
        """) { AnyView(C04_SizingFittedExample()) },

        // MARK: .redacted()

        ChildExampleEntry(parent: ".redacted()", child: "redacted(reason:)", code: """
        ProfileCard(profile)
            .redacted(reason: isLoaded ? [] : .placeholder)
        Toggle("Profile loaded", isOn: $isLoaded)
        """) { AnyView(C04_RedactedReasonExample()) },

        ChildExampleEntry(parent: ".redacted()", child: "unredacted()", code: """
        VStack(alignment: .leading) {
            Text("Latest").font(.headline).unredacted()
            ForEach(rows, id: \\.self) { Label($0, systemImage: "doc.text") }
        }
        .redacted(reason: .placeholder)
        """) { AnyView(C04_UnredactedExample()) },

        ChildExampleEntry(parent: ".redacted()", child: "RedactionReasons", code: """
        @Environment(\\.redactionReasons) private var reasons

        var body: some View {
            if reasons.contains(.placeholder) { SkeletonRow() } else { LiveRow(model) }
        }
        """) { AnyView(C04_RedactionReasonsExample()) },

        // MARK: .safeAreaInset()

        ChildExampleEntry(parent: ".safeAreaInset()", child: "safeAreaInset(edge:alignment:spacing:content:)", code: """
        ScrollView { messages }
            .safeAreaInset(edge: .bottom, spacing: 0) {
                ComposeBar()
                    .background(.bar)
            }
        """) { AnyView(C04_SafeAreaInsetExample()) },

        ChildExampleEntry(parent: ".safeAreaInset()", child: "safeAreaPadding(_:_:)", code: """
        ScrollView(.horizontal) {
            LazyHStack { cards }
        }
        .safeAreaPadding(.horizontal, 16)
        """) { AnyView(C04_SafeAreaPaddingExample()) },

        ChildExampleEntry(parent: ".safeAreaInset()", child: "safeAreaBar(edge:alignment:spacing:content:)", code: """
        ScrollView { tracks }
            .safeAreaBar(edge: .bottom) {
                PlaybackControls()
                    .padding(.horizontal)
            }
        """) { AnyView(C04_SafeAreaBarExample()) },

        // MARK: .scaleEffect()

        ChildExampleEntry(parent: ".scaleEffect()", child: "scaleEffect(_:anchor:)", code: """
        NotificationDot()
            .scaleEffect(isDimmed ? 0.6 : 1, anchor: .topTrailing)

        NotificationDot()                    // for comparison
            .scaleEffect(isDimmed ? 0.6 : 1, anchor: .center)
        """) { AnyView(C04_ScaleEffectAnchorExample()) },

        ChildExampleEntry(parent: ".scaleEffect()", child: "scaleEffect(x:y:anchor:)", code: """
        LevelBar()
            .scaleEffect(x: 1, y: level, anchor: .bottom)
            .animation(.easeOut(duration: 0.2), value: level)
        Slider(value: $level, in: 0.05...1)
        """) { AnyView(C04_ScaleEffectXYExample()) },

        // MARK: - end of entries
    ]
}

// MARK: - .onAppear()

private struct C04_OnAppearExample: View {
    @State private var isShown = true
    @State private var appearCount = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Toggle("Show detail", isOn: $isShown)
            if isShown {
                Label("Detail view", systemImage: "doc.text")
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.blue.opacity(0.12), in: .rect(cornerRadius: 8))
                    .onAppear { appearCount += 1 }
            }
            Text("onAppear ran \(appearCount)× — toggle off and on to run it again")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(width: 280)
    }
}

private struct C04_OnDisappearExample: View {
    @State private var showChart = true
    @State private var log: [String] = []

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Toggle("Show live chart", isOn: $showChart)
            if showChart {
                HStack(alignment: .bottom, spacing: 4) {
                    ForEach([0.4, 0.7, 0.5, 0.9, 0.6, 0.8], id: \.self) { h in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(.green)
                            .frame(width: 14, height: 40 * h)
                    }
                }
                .onAppear { log.append("ticker.start()") }
                .onDisappear { log.append("ticker.stop()") }
            }
            Text(log.isEmpty ? "—" : log.suffix(3).joined(separator: "  →  "))
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
        .frame(width: 280)
    }
}

// MARK: - .onChange()

private struct C04_OnChangeTwoParamExample: View {
    @State private var volume = 0.5
    @State private var direction = "—"
    @State private var delta = 0.0

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Slider(value: $volume)
                .onChange(of: volume) { oldValue, newValue in
                    direction = newValue > oldValue ? "fadeUp()" : "fadeDown()"
                    delta = newValue - oldValue
                }
            Text("\(direction)   Δ \(delta, format: .number.precision(.fractionLength(3)))")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
        .frame(width: 260)
    }
}

private struct C04_OnChangeZeroParamExample: View {
    @State private var filter = "All"
    @State private var reloadCount = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Picker("Filter", selection: $filter) {
                ForEach(["All", "Unread", "Flagged"], id: \.self) { Text($0) }
            }
            .pickerStyle(.segmented)
            .onChange(of: filter, initial: true) {
                reloadCount += 1
            }
            Text("reloadData() called \(reloadCount)× — the first came from initial: true")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(width: 280)
    }
}

// MARK: - .onHover()

private struct C04_OnHoverExample: View {
    @State private var isHovering = false

    var body: some View {
        VStack(spacing: 10) {
            Text("Read the release notes")
                .underline(isHovering)
                .foregroundStyle(isHovering ? Color.blue : Color.primary)
                .onHover { isHovering = $0 }
            Text(isHovering ? "onHover → true" : "onHover → false")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
    }
}

private struct C04_OnContinuousHoverExample: View {
    @State private var hoverPoint: CGPoint?

    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(colors: [.red, .yellow, .green, .blue], startPoint: .leading, endPoint: .trailing))
                .frame(width: 240, height: 90)
                .overlay {
                    if let p = hoverPoint {
                        Circle().stroke(.white, lineWidth: 2).frame(width: 14, height: 14).position(p)
                    }
                }
                .onContinuousHover(coordinateSpace: .local) { phase in
                    switch phase {
                    case .active(let point): hoverPoint = point
                    case .ended: hoverPoint = nil
                    }
                }
            Text(hoverPoint.map { "local: (\(Int($0.x)), \(Int($0.y)))" } ?? "move the pointer over the swatch")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
    }
}

private struct C04_HoverPhaseExample: View {
    @State private var crosshair: CGPoint?

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(.quaternary)
                if let c = crosshair {
                    Rectangle().fill(.blue).frame(width: 1).position(x: c.x, y: 45)
                    Rectangle().fill(.blue).frame(height: 1).position(x: 120, y: c.y)
                }
            }
            .frame(width: 240, height: 90)
            .clipShape(.rect(cornerRadius: 10))
            .onContinuousHover { phase in
                if case .active(let location) = phase {
                    crosshair = location
                } else {
                    crosshair = nil
                }
            }
            Text(crosshair.map { ".active(x: \(Int($0.x)), y: \(Int($0.y)))" } ?? ".ended")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - .onScrollGeometryChange()

private struct C04_OnScrollGeometryChangeExample: View {
    @State private var headerOpacity: CGFloat = 1

    var body: some View {
        VStack(spacing: 0) {
            Text("Feed")
                .font(.headline)
                .opacity(headerOpacity)
                .padding(.bottom, 6)
            ScrollView {
                LazyVStack(spacing: 6) {
                    ForEach(1...20, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 6)
                            .fill(.blue.opacity(0.15))
                            .frame(height: 28)
                            .overlay(Text("Post \(i)").font(.caption))
                    }
                }
            }
            .frame(height: 120)
            .onScrollGeometryChange(for: CGFloat.self) { geo in
                geo.contentOffset.y + geo.contentInsets.top
            } action: { _, offset in
                headerOpacity = max(0, 1 - offset / 120)
            }
            Text("header opacity \(headerOpacity, format: .number.precision(.fractionLength(2))) — scroll to fade it")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
                .padding(.top, 6)
        }
        .frame(width: 260)
    }
}

private struct C04_ScrollGeometryExample: View {
    @State private var rowCount = 12
    @State private var loads = 0

    var body: some View {
        VStack(spacing: 6) {
            ScrollView {
                LazyVStack(spacing: 6) {
                    ForEach(1...rowCount, id: \.self) { i in
                        Text("Row \(i)")
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(6)
                            .background(.quaternary, in: .rect(cornerRadius: 6))
                    }
                }
            }
            .frame(height: 130)
            .onScrollGeometryChange(for: Bool.self) { geo in
                geo.contentOffset.y + geo.containerSize.height
                    >= geo.contentSize.height - 40
            } action: { _, nearEnd in
                if nearEnd, rowCount < 60 {
                    rowCount += 8
                    loads += 1
                }
            }
            Text("scroll to the end — loadMore() ran \(loads)×, \(rowCount) rows")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(width: 260)
    }
}

private struct C04_OnScrollPhaseChangeExample: View {
    @State private var phase: ScrollPhase = .idle

    var body: some View {
        VStack(spacing: 6) {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 6) {
                    ForEach(0..<32, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 6)
                            .fill(phase == .idle ? Color.teal : Color.gray)
                            .frame(height: 30)
                    }
                }
            }
            .frame(height: 120)
            .onScrollPhaseChange { _, newPhase in
                phase = newPhase
            }
            Text("phase: .\(String(describing: phase))   isScrolling: \(phase != .idle ? "true" : "false")")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
        .frame(width: 260)
    }
}

// MARK: - .onSubmit()

private struct C04_OnSubmitOfExample: View {
    @State private var query = ""
    @State private var submitted: [String] = []

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Search parks", text: $query)
                .textFieldStyle(.roundedBorder)
                .onSubmit(of: .text) {
                    submitted.append(query)
                }
            Text("press Return — runSearch() ran for: " + (submitted.isEmpty ? "—" : submitted.joined(separator: ", ")))
                .font(.caption)
                .foregroundStyle(.secondary)
            Text("of: .search would listen to a .searchable field instead")
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .frame(width: 260)
    }
}

private struct C04_SubmitLabelExample: View {
    @State private var draft = ""
    @State private var sent: [String] = []

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Message", text: $draft)
                .textFieldStyle(.roundedBorder)
                .submitLabel(.send)
                .onSubmit {
                    guard !draft.isEmpty else { return }
                    sent.append(draft)
                    draft = ""
                }
            ForEach(Array(sent.suffix(2).enumerated()), id: \.offset) { _, message in
                Text("→ \(message)").font(.caption)
            }
            Text("Illustrative — the “Send” key label shows on iOS software keyboards")
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .frame(width: 260)
    }
}

private struct C04_SubmitScopeExample: View {
    @State private var filter = ""
    @State private var name = ""
    @State private var saveCount = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Filter (scoped — Return stops here)", text: $filter)
                .submitScope()
            TextField("Name (Return bubbles to onSubmit)", text: $name)
            Text("outer onSubmit ran \(saveCount)×")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .textFieldStyle(.roundedBorder)
        .onSubmit { saveCount += 1 }
        .frame(width: 280)
    }
}

// MARK: - .onTapGesture()

private struct C04_OnTapCountExample: View {
    @State private var isZoomed = false

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "photo.artframe")
                .font(.system(size: 40))
                .foregroundStyle(.indigo)
                .scaleEffect(isZoomed ? 1.5 : 1)
                .frame(width: 120, height: 90)
                .background(.quaternary, in: .rect(cornerRadius: 10))
                .onTapGesture(count: 2) {
                    withAnimation(.snappy) { isZoomed.toggle() }
                }
            Text("double-click — single clicks are ignored")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C04_OnTapCoordinateSpaceExample: View {
    @State private var pins: [CGPoint] = []

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(.green.opacity(0.15))
                ForEach(Array(pins.enumerated()), id: \.offset) { _, p in
                    Image(systemName: "mappin.circle.fill")
                        .foregroundStyle(.red)
                        .position(p)
                }
            }
            .frame(width: 240, height: 100)
            .contentShape(.rect)
            .onTapGesture(coordinateSpace: .local) { point in
                pins.append(point)
            }
            Text(pins.last.map { "last tap at (\(Int($0.x)), \(Int($0.y))) in .local" } ?? "click to drop a pin")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
    }
}

private struct C04_OnLongPressExample: View {
    @State private var isEditing = false
    @State private var isPressed = false

    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 12)
                .fill(isEditing ? Color.orange : Color.blue)
                .frame(width: 120, height: 70)
                .overlay(Text(isEditing ? "Editing" : "Tile").foregroundStyle(.white).bold())
                .scaleEffect(isPressed ? 0.92 : 1)
                .animation(.easeOut(duration: 0.15), value: isPressed)
                .onLongPressGesture(minimumDuration: 0.6) {
                    isEditing.toggle()
                } onPressingChanged: { pressing in
                    isPressed = pressing
                }
            Text(isPressed ? "pressing… (0.6 s to fire)" : "press and hold")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - .overlay()

private struct C04_OverlayStyleInShapeExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 16) {
                cover
                cover
                    .overlay(.black.opacity(0.25), in: .rect(cornerRadius: 12))
            }
            Text("plain vs. .overlay(.black.opacity(0.25), in: .rect(cornerRadius: 12))")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private var cover: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(LinearGradient(colors: [.pink, .orange], startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(width: 110, height: 76)
            .overlay(Image(systemName: "music.note").font(.title).foregroundStyle(.white))
    }
}

private struct C04_OverlayAlignmentExample: View {
    var body: some View {
        HStack(spacing: 24) {
            thumbnail
                .overlay(alignment: .topTrailing) {
                    Text("3")
                        .font(.caption2.bold())
                        .foregroundStyle(.white)
                        .padding(5)
                        .background(.red, in: .circle)
                        .padding(4)
                }
            thumbnail
                .overlay(alignment: .bottomLeading) {
                    Text("LIVE")
                        .font(.caption2.bold())
                        .foregroundStyle(.white)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                        .background(.red, in: .capsule)
                        .padding(4)
                }
        }
    }

    private var thumbnail: some View {
        RoundedRectangle(cornerRadius: 10).fill(.teal.gradient).frame(width: 90, height: 70)
    }
}

// MARK: - .padding()

private struct C04_PaddingDefaultExample: View {
    var body: some View {
        HStack(alignment: .top, spacing: 24) {
            VStack(spacing: 6) {
                Text("Tight")
                    .border(.secondary)
                Text("no padding").font(.caption2).foregroundStyle(.tertiary)
            }
            VStack(spacing: 6) {
                Text("Comfortable")
                    .padding()
                    .border(.secondary)
                Text(".padding()").font(.caption2).foregroundStyle(.tertiary)
            }
        }
    }
}

private struct C04_PaddingLengthExample: View {
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            ForEach([4, 12, 24], id: \.self) { length in
                VStack(spacing: 6) {
                    Image(systemName: "star.fill")
                        .padding(CGFloat(length))
                        .background(.quaternary, in: .circle)
                    Text(".padding(\(length))").font(.caption2).foregroundStyle(.tertiary)
                }
            }
        }
    }
}

private struct C04_PaddingEdgesExample: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Wide sides")
                .padding(.horizontal, 24)
                .background(.blue.opacity(0.2))
                .padding(.top, 4)
                .border(.secondary)
            Text("blue = .padding(.horizontal, 24); the gap above it = .padding(.top, 4)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - .popover()

private struct C04_PopoverIsPresentedExample: View {
    @State private var showLegend = false

    var body: some View {
        VStack(spacing: 8) {
            Button("Legend") { showLegend = true }
                .popover(isPresented: $showLegend, arrowEdge: .top) {
                    VStack(alignment: .leading, spacing: 6) {
                        Label("Revenue", systemImage: "circle.fill").foregroundStyle(.blue)
                        Label("Costs", systemImage: "circle.fill").foregroundStyle(.red)
                    }
                    .padding()
                }
            Text(showLegend ? "isPresented: true" : "isPresented: false — click away to dismiss")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
    }
}

private struct C04_PopoverItemExample: View {
    private struct Tile: Identifiable {
        let id: Int
        let color: Color
        let name: String
    }

    private let tiles = [
        Tile(id: 1, color: .red, name: "Crimson"),
        Tile(id: 2, color: .green, name: "Mint"),
        Tile(id: 3, color: .blue, name: "Azure"),
    ]
    @State private var inspectedTile: Tile?

    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 12) {
                ForEach(tiles) { tile in
                    RoundedRectangle(cornerRadius: 8)
                        .fill(tile.color)
                        .frame(width: 44, height: 44)
                        .onTapGesture { inspectedTile = tile }
                }
            }
            .popover(item: $inspectedTile) { tile in
                VStack(spacing: 4) {
                    Text(tile.name).font(.headline)
                    Text("id \(tile.id)").font(.caption).foregroundStyle(.secondary)
                }
                .padding()
                .frame(minWidth: 120)
            }
            Text("click a tile — the popover receives that tile, unwrapped")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - .position()

private struct C04_PositionPointExample: View {
    @State private var location = CGPoint(x: 60, y: 40)

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).fill(.quaternary)
            Circle()
                .fill(.blue)
                .frame(width: 16, height: 16)
                .position(location)
                .gesture(DragGesture().onChanged { location = $0.location })
        }
        .frame(width: 240, height: 100)
        .overlay(alignment: .bottomTrailing) {
            Text("drag · (\(Int(location.x)), \(Int(location.y)))")
                .font(.caption2.monospaced())
                .foregroundStyle(.secondary)
                .padding(6)
        }
    }
}

private struct C04_PositionXYExample: View {
    var body: some View {
        GeometryReader { geo in
            Image(systemName: "mappin")
                .font(.title2)
                .foregroundStyle(.red)
                .position(x: geo.size.width * 0.25, y: geo.size.height / 2)
            Image(systemName: "mappin")
                .font(.title2)
                .foregroundStyle(.blue)
                .position(x: geo.size.width * 0.75, y: geo.size.height / 2)
        }
        .frame(width: 240, height: 90)
        .background(.quaternary, in: .rect(cornerRadius: 10))
    }
}

// MARK: - .presentationDetents()

/// A phone with a bottom sheet drawn at a given height — detents apply on iOS only.
private struct C04_PhoneSheetMock: View {
    var sheetHeight: CGFloat
    var label: String

    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 18).fill(.black)
            RoundedRectangle(cornerRadius: 14)
                .fill(LinearGradient(colors: [.blue.opacity(0.6), .indigo.opacity(0.8)], startPoint: .top, endPoint: .bottom))
                .padding(4)
            VStack(spacing: 4) {
                Capsule().fill(.secondary).frame(width: 24, height: 4).padding(.top, 6)
                Text(label).font(.caption2).foregroundStyle(.secondary)
                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity)
            .frame(height: sheetHeight)
            .background(.regularMaterial, in: .rect(topLeadingRadius: 12, bottomLeadingRadius: 14, bottomTrailingRadius: 14, topTrailingRadius: 12))
            .padding(4)
        }
        .frame(width: 96, height: 180)
    }
}

private struct C04_PresentationDetentsSelectionExample: View {
    @State private var detent: PresentationDetent = .medium

    var body: some View {
        HStack(spacing: 20) {
            C04_PhoneSheetMock(sheetHeight: detent == .large ? 160 : 90, label: detent == .large ? ".large" : ".medium")
                .animation(.snappy, value: detent == .large)
            VStack(alignment: .leading, spacing: 8) {
                Picker("Detent", selection: $detent) {
                    Text("medium").tag(PresentationDetent.medium)
                    Text("large").tag(PresentationDetent.large)
                }
                .pickerStyle(.segmented)
                .frame(width: 160)
                Text("selection: $detent both drives and reads the current stop")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("Illustrative — iOS only")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
            .frame(width: 170)
        }
    }
}

private struct C04_DetentFractionExample: View {
    @State private var fraction = 0.3

    var body: some View {
        HStack(spacing: 20) {
            C04_PhoneSheetMock(sheetHeight: 172 * fraction, label: ".fraction(\(fraction.formatted(.number.precision(.fractionLength(2)))))")
            VStack(alignment: .leading, spacing: 8) {
                Slider(value: $fraction, in: 0.15...0.9, step: 0.05)
                    .frame(width: 160)
                Text("a stop at a share of the available height")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("Illustrative — iOS only")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
            .frame(width: 170)
        }
    }
}

private struct C04_DetentHeightExample: View {
    var body: some View {
        HStack(spacing: 20) {
            C04_PhoneSheetMock(sheetHeight: 220 * 0.21, label: ".height(220)")
            VStack(alignment: .leading, spacing: 8) {
                Text("a fixed 220 pt stop — the sheet hugs content of a known size")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("Illustrative — iOS only")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
            .frame(width: 170)
        }
    }
}

private struct C04_BackgroundInteractionExample: View {
    @State private var mapTaps = 0

    var body: some View {
        HStack(spacing: 20) {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 18).fill(.black)
                RoundedRectangle(cornerRadius: 14)
                    .fill(.green.opacity(0.5))
                    .overlay(Image(systemName: "map").font(.title).foregroundStyle(.white))
                    .padding(4)
                    .onTapGesture { mapTaps += 1 }
                VStack(spacing: 4) {
                    Capsule().fill(.secondary).frame(width: 24, height: 4).padding(.top, 6)
                    Text("Places").font(.caption2).foregroundStyle(.secondary)
                    Spacer(minLength: 0)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 90)
                .background(.regularMaterial, in: .rect(topLeadingRadius: 12, bottomLeadingRadius: 14, bottomTrailingRadius: 14, topTrailingRadius: 12))
                .padding(4)
                .allowsHitTesting(false)
            }
            .frame(width: 96, height: 180)
            VStack(alignment: .leading, spacing: 8) {
                Text("map taps behind the sheet: \(mapTaps)")
                    .font(.caption.monospaced())
                Text(".enabled(upThrough: .medium) keeps the map interactive at the small and medium stops")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("Illustrative — iOS only")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
            .frame(width: 170)
        }
    }
}

// MARK: - .presentationSizing()

private struct C04_SizingFormExample: View {
    @State private var showPrefs = false
    @State private var showPreviews = true

    var body: some View {
        VStack(spacing: 8) {
            Button("Preferences…") { showPrefs = true }
                .sheet(isPresented: $showPrefs) {
                    Form {
                        Toggle("Show previews", isOn: $showPreviews)
                        LabeledContent("Theme", value: "System")
                        Button("Done") { showPrefs = false }
                    }
                    .formStyle(.grouped)
                    .presentationSizing(.form)
                }
            Text(".form — a narrow, settings-style sheet")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C04_SizingPageExample: View {
    private struct Draft: Identifiable {
        let id: Int
        var title: String
    }

    @State private var draft: Draft?
    @State private var text = "Start writing…"

    var body: some View {
        VStack(spacing: 8) {
            Button("Open draft…") { draft = Draft(id: 1, title: "Untitled") }
                .sheet(item: $draft) { draft in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(draft.title).font(.title2.bold())
                        TextEditor(text: $text)
                        HStack {
                            Spacer()
                            Button("Close") { self.draft = nil }
                        }
                    }
                    .padding()
                    .presentationSizing(.page)
                }
            Text(".page — a document-sized sheet for editors and readers")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C04_SizingFittedExample: View {
    @State private var showPicker = false

    var body: some View {
        VStack(spacing: 8) {
            Button("Choose icon…") { showPicker = true }
                .sheet(isPresented: $showPicker) {
                    VStack(spacing: 12) {
                        HStack(spacing: 14) {
                            ForEach(["star", "heart", "bolt", "leaf"], id: \.self) {
                                Image(systemName: $0).font(.title)
                            }
                        }
                        Button("Done") { showPicker = false }
                    }
                    .padding()
                    .presentationSizing(.form.fitted(horizontal: false, vertical: true))
                }
            Text("form width, but the height hugs the content")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - .redacted()

private struct C04_RedactedReasonExample: View {
    @State private var isLoaded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                Circle().fill(.blue).frame(width: 36, height: 36)
                VStack(alignment: .leading) {
                    Text("Avery Chen").bold()
                    Text("Joined March 2024").font(.caption).foregroundStyle(.secondary)
                }
            }
            .redacted(reason: isLoaded ? [] : .placeholder)
            Toggle("Profile loaded", isOn: $isLoaded)
        }
        .frame(width: 240)
    }
}

private struct C04_UnredactedExample: View {
    private let rows = ["Quarterly numbers are in", "Design review at 3 pm", "New hire starts Monday"]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Latest").font(.headline).unredacted()
            ForEach(rows, id: \.self) { Label($0, systemImage: "doc.text") }
        }
        .redacted(reason: .placeholder)
        .frame(width: 240, alignment: .leading)
    }
}

private struct C04_RedactionReasonsExample: View {
    private let options: [(String, RedactionReasons)] = [
        ("none", []), (".placeholder", .placeholder), (".privacy", .privacy), (".invalidated", .invalidated),
    ]
    @State private var choice = 1

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Picker("Reason", selection: $choice) {
                ForEach(options.indices, id: \.self) { Text(options[$0].0).tag($0) }
            }
            .pickerStyle(.segmented)
            C04_ReasonAwareRow()
                .redacted(reason: options[choice].1)
        }
        .frame(width: 320)
    }
}

private struct C04_ReasonAwareRow: View {
    @Environment(\.redactionReasons) private var reasons

    private var label: String {
        if reasons.isEmpty { return "[]" }
        if reasons.contains(.privacy) { return ".privacy" }
        if reasons.contains(.invalidated) { return ".invalidated" }
        return ".placeholder"
    }

    var body: some View {
        HStack {
            if reasons.contains(.placeholder) {
                RoundedRectangle(cornerRadius: 4).fill(.quaternary).frame(width: 120, height: 14)
                Text("SkeletonRow").font(.caption).foregroundStyle(.tertiary)
            } else {
                Label("Balance: $4,210.55", systemImage: "creditcard")
            }
            Spacer()
            Text("env: \(label)")
                .font(.caption2.monospaced())
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - .safeAreaInset()

private struct C04_SafeAreaInsetExample: View {
    @State private var draft = ""

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 6) {
                ForEach(1...12, id: \.self) { i in
                    Text("Message \(i)")
                        .font(.caption)
                        .padding(6)
                        .background(.blue.opacity(0.12), in: .rect(cornerRadius: 8))
                }
            }
            .padding(8)
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            HStack {
                TextField("Message", text: $draft).textFieldStyle(.roundedBorder)
                Button("Send", systemImage: "paperplane.fill") { draft = "" }
                    .labelStyle(.iconOnly)
            }
            .padding(8)
            .background(.bar)
        }
        .frame(width: 260, height: 170)
        .clipShape(.rect(cornerRadius: 10))
    }
}

private struct C04_SafeAreaPaddingExample: View {
    var body: some View {
        VStack(spacing: 6) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 10) {
                    ForEach(1...8, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.orange.gradient)
                            .frame(width: 90, height: 66)
                            .overlay(Text("Card \(i)").foregroundStyle(.white))
                    }
                }
            }
            .safeAreaPadding(.horizontal, 16)
            .frame(width: 280, height: 80)
            .background(.quaternary)
            Text("the first card starts 16 pt in, yet content scrolls edge to edge")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C04_SafeAreaBarExample: View {
    @State private var isPlaying = false

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 4) {
                ForEach(1...14, id: \.self) { i in
                    HStack {
                        Image(systemName: "music.note")
                        Text("Track \(i)")
                        Spacer()
                    }
                    .font(.caption)
                    .padding(6)
                }
            }
            .padding(.horizontal, 8)
        }
        .safeAreaBar(edge: .bottom) {
            HStack(spacing: 16) {
                Button("Previous", systemImage: "backward.fill") { }
                Button(isPlaying ? "Pause" : "Play", systemImage: isPlaying ? "pause.fill" : "play.fill") { isPlaying.toggle() }
                Button("Next", systemImage: "forward.fill") { }
            }
            .labelStyle(.iconOnly)
            .buttonStyle(.borderless)
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
        .frame(width: 260, height: 170)
        .background(.quaternary.opacity(0.3), in: .rect(cornerRadius: 10))
    }
}

// MARK: - .scaleEffect()

private struct C04_ScaleEffectAnchorExample: View {
    @State private var isDimmed = false

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 48) {
                VStack(spacing: 6) {
                    ZStack {
                        outline
                        dot.scaleEffect(isDimmed ? 0.6 : 1, anchor: .topTrailing)
                    }
                    Text(".topTrailing").font(.caption2).foregroundStyle(.tertiary)
                }
                VStack(spacing: 6) {
                    ZStack {
                        outline
                        dot.scaleEffect(isDimmed ? 0.6 : 1, anchor: .center)
                    }
                    Text(".center").font(.caption2).foregroundStyle(.tertiary)
                }
            }
            .animation(.snappy, value: isDimmed)
            Toggle("Dimmed", isOn: $isDimmed).toggleStyle(.switch)
        }
    }

    private var outline: some View {
        Circle().stroke(.secondary, style: StrokeStyle(lineWidth: 1, dash: [3])).frame(width: 40, height: 40)
    }

    private var dot: some View {
        Circle().fill(.red).frame(width: 40, height: 40)
            .overlay(Text("9").foregroundStyle(.white).bold())
    }
}

private struct C04_ScaleEffectXYExample: View {
    @State private var level = 0.7

    var body: some View {
        VStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 4)
                .fill(.green.gradient)
                .frame(width: 40, height: 80)
                .scaleEffect(x: 1, y: level, anchor: .bottom)
                .animation(.easeOut(duration: 0.2), value: level)
            Slider(value: $level, in: 0.05...1).frame(width: 160)
            Text("y scales from the bottom edge; x stays 1")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - end of examples
