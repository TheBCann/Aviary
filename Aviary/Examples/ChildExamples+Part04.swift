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

        // MARK: .scrollEdgeEffectStyle()

        ChildExampleEntry(parent: ".scrollEdgeEffectStyle()", child: "ScrollEdgeEffectStyle.soft", code: """
        ScrollView { gallery }
            .safeAreaBar(edge: .top) { Text("Gallery").font(.headline) }
            .scrollEdgeEffectStyle(.soft, for: .top)
        """) { AnyView(C04_EdgeEffectSoftExample()) },

        ChildExampleEntry(parent: ".scrollEdgeEffectStyle()", child: "ScrollEdgeEffectStyle.hard", code: """
        ScrollView { gallery }
            .safeAreaBar(edge: .top) { Text("Gallery").font(.headline) }
            .scrollEdgeEffectStyle(.hard, for: .all)
        """) { AnyView(C04_EdgeEffectHardExample()) },

        ChildExampleEntry(parent: ".scrollEdgeEffectStyle()", child: "scrollEdgeEffectHidden(_:for:)", code: """
        ScrollView { gallery }
            .safeAreaBar(edge: .top) { Text("Gallery").font(.headline) }
            .scrollEdgeEffectHidden(isHidden, for: .top)
        Toggle("Hide edge effect", isOn: $isHidden)
        """) { AnyView(C04_EdgeEffectHiddenExample()) },

        // MARK: .scrollPosition()

        ChildExampleEntry(parent: ".scrollPosition()", child: "scrollPosition(_:anchor:)", code: """
        @State private var position = ScrollPosition(edge: .top)

        ScrollView { LazyVStack { rows }.scrollTargetLayout() }
            .scrollPosition($position)
        Button("Top") { position.scrollTo(edge: .top) }
        Button("Row 15") { position.scrollTo(id: 15, anchor: .center) }
        Button("Bottom") { position.scrollTo(edge: .bottom) }
        """) { AnyView(C04_ScrollPositionValueExample()) },

        ChildExampleEntry(parent: ".scrollPosition()", child: "scrollPosition(id:anchor:)", code: """
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) { pages }      // each page has an Int id
                .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollPosition(id: $pageID, anchor: .center)
        """) { AnyView(C04_ScrollPositionIDExample()) },

        // MARK: .scrollTargetBehavior()

        ChildExampleEntry(parent: ".scrollTargetBehavior()", child: "ScrollTargetBehavior.paging", code: """
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(slides) { SlideView($0).containerRelativeFrame(.horizontal) }
            }
        }
        .scrollTargetBehavior(.paging)
        """) { AnyView(C04_PagingBehaviorExample()) },

        ChildExampleEntry(parent: ".scrollTargetBehavior()", child: "ScrollTargetBehavior.viewAligned(limitBehavior:)", code: """
        ScrollView(.horizontal) {
            LazyHStack { cards }
                .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
        """) { AnyView(C04_ViewAlignedBehaviorExample()) },

        ChildExampleEntry(parent: ".scrollTargetBehavior()", child: "scrollTargetLayout(isEnabled:)", code: """
        ScrollView(.horizontal) {
            LazyHStack(spacing: 16) { cards }
                .scrollTargetLayout(isEnabled: snapsToCards)
        }
        .scrollTargetBehavior(.viewAligned)
        Toggle("Snap to cards", isOn: $snapsToCards)
        """) { AnyView(C04_ScrollTargetLayoutExample()) },

        // MARK: .searchable()

        ChildExampleEntry(parent: ".searchable()", child: "searchable(text:prompt:)", code: """
        List(filteredParks, id: \\.self) { Text($0) }
            .searchable(text: $query, prompt: "Park name")
        """) { AnyView(C04_SearchableTextPromptExample()) },

        ChildExampleEntry(parent: ".searchable()", child: "searchable(text:placement:prompt:)", code: """
        List(results, id: \\.self) { Text($0) }
            .searchable(
                text: $query,
                placement: .sidebar,
                prompt: "Filter notes"
            )
        """) { AnyView(C04_SearchablePlacementExample()) },

        ChildExampleEntry(parent: ".searchable()", child: "searchSuggestions(_:)", code: """
        List(results, id: \\.self) { Text($0) }
            .searchable(text: $query)
            .searchSuggestions {
                ForEach(recentQueries, id: \\.self) { term in
                    Label(term, systemImage: "clock")
                        .searchCompletion(term)
                }
            }
        """) { AnyView(C04_SearchSuggestionsExample()) },

        // MARK: .sensoryFeedback()

        ChildExampleEntry(parent: ".sensoryFeedback()", child: "sensoryFeedback(_:trigger:)", code: """
        Picker("Size", selection: $size) {
            ForEach(sizes, id: \\.self) { Text($0) }
        }
        .pickerStyle(.segmented)
        .sensoryFeedback(.selection, trigger: size)
        """) { AnyView(C04_SensoryFeedbackTriggerExample()) },

        ChildExampleEntry(parent: ".sensoryFeedback()", child: "sensoryFeedback(trigger:_:)", code: """
        Stepper("Count: \\(count)", value: $count)
            .sensoryFeedback(trigger: count) { old, new in
                new > old ? .increase : .decrease
            }
        """) { AnyView(C04_SensoryFeedbackClosureExample()) },

        ChildExampleEntry(parent: ".sensoryFeedback()", child: "SensoryFeedback.impact(weight:intensity:)", code: """
        dropZone                             // clicking it bumps `drops`
            .sensoryFeedback(.impact(weight: weight, intensity: intensity), trigger: drops)
        Picker("Weight", selection: $weightIndex) { … }   // .light / .medium / .heavy
        Slider(value: $intensity, in: 0...1)
        """) { AnyView(C04_ImpactFeedbackExample()) },

        // MARK: .shadow()

        ChildExampleEntry(parent: ".shadow()", child: "shadow(color:radius:x:y:)", code: """
        card
            .shadow(color: .black.opacity(0.15), radius: radius, x: 0, y: yOffset)
        Slider(value: $radius, in: 0...20)
        Slider(value: $yOffset, in: -10...10)
        """) { AnyView(C04_ShadowModifierExample()) },

        ChildExampleEntry(parent: ".shadow()", child: "ShapeStyle.shadow(_:)", code: """
        Circle()
            .fill(.blue.shadow(.inner(radius: 4, y: 2)))     // inset, pressed look
            .frame(width: 60, height: 60)
            .overlay(Text("9").foregroundStyle(.white))      // stays crisp

        Circle()
            .fill(.blue.shadow(.drop(radius: 4, y: 2)))      // shadows the fill only
        """) { AnyView(C04_ShapeStyleShadowExample()) },

        // MARK: .sheet()

        ChildExampleEntry(parent: ".sheet()", child: "sheet(isPresented:onDismiss:content:)", code: """
        Button("Settings") { showSettings = true }
            .sheet(isPresented: $showSettings, onDismiss: { dismissCount += 1 }) {
                SettingsView()
            }
        """) { AnyView(C04_SheetIsPresentedExample()) },

        ChildExampleEntry(parent: ".sheet()", child: "sheet(item:onDismiss:content:)", code: """
        recipeButtons                        // each sets selectedRecipe = recipe
            .sheet(item: $selectedRecipe, onDismiss: { refreshCount += 1 }) { recipe in
                RecipeDetail(recipe)
            }
        """) { AnyView(C04_SheetItemExample()) },

        // MARK: .swipeActions()

        ChildExampleEntry(parent: ".swipeActions()", child: "swipeActions(edge:allowsFullSwipe:content:)", code: """
        List(items) { item in
            ItemRow(item)
                .swipeActions(edge: .leading, allowsFullSwipe: false) {
                    Button("Read") { markRead(item) }.tint(.blue)
                }
        }
        """) { AnyView(C04_SwipeActionsExample()) },

        ChildExampleEntry(parent: ".swipeActions()", child: "HorizontalEdge", code: """
        MessageRow(message)
            .swipeActions(edge: .leading) {              // HorizontalEdge.leading
                Button("Flag") { flag(message) }.tint(.orange)
            }
            .swipeActions(edge: .trailing) {             // HorizontalEdge.trailing
                Button("Delete", role: .destructive) { delete(message) }
            }
        """) { AnyView(C04_HorizontalEdgeExample()) },

        // MARK: .symbolEffect()

        ChildExampleEntry(parent: ".symbolEffect()", child: "symbolEffect(_:options:isActive:)", code: """
        Image(systemName: "dot.radiowaves.left.and.right")
            .symbolEffect(.pulse, options: .speed(1.5), isActive: isBroadcasting)
        Toggle("Broadcasting", isOn: $isBroadcasting)
        """) { AnyView(C04_SymbolEffectIsActiveExample()) },

        ChildExampleEntry(parent: ".symbolEffect()", child: "symbolEffect(_:options:value:)", code: """
        Image(systemName: "envelope.fill")
            .symbolEffect(.bounce, options: .repeat(.periodic(2)), value: unreadCount)
        Button("New message") { unreadCount += 1 }
        """) { AnyView(C04_SymbolEffectValueExample()) },

        // MARK: .task()

        ChildExampleEntry(parent: ".task()", child: "task(priority:_:)", code: """
        if showGrid {
            thumbnailGrid
                .task(priority: .background) {          // prefetchThumbnails()
                    loaded = 0
                    for i in 1...6 {
                        guard (try? await Task.sleep(for: .milliseconds(350))) != nil else { return }
                        loaded = i
                    }
                }
        }
        """) { AnyView(C04_TaskPriorityExample()) },

        ChildExampleEntry(parent: ".task()", child: "task(id:priority:_:)", code: """
        TextField("Search parks", text: $query)
        resultsList
            .task(id: query) {                           // restarts on every change of `query`
                runs += 1
                guard (try? await Task.sleep(for: .milliseconds(400))) != nil else { return }
                results = await search(query)
            }
        """) { AnyView(C04_TaskIDExample()) },

        // MARK: .toolbar()

        ChildExampleEntry(parent: ".toolbar()", child: "toolbar(content:)", code: """
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") { save() }
            }
        }
        """) { AnyView(C04_ToolbarContentExample()) },

        ChildExampleEntry(parent: ".toolbar()", child: "toolbar(id:content:)", code: """
        .toolbar(id: "editor") {
            ToolbarItem(id: "bold", placement: .secondaryAction) {
                Button("Bold", systemImage: "bold") { toggleBold() }
            }
            ToolbarItem(id: "share", placement: .secondaryAction) {
                ShareLink(item: documentURL)
            }
        }
        """) { AnyView(C04_ToolbarIDExample()) },

        ChildExampleEntry(parent: ".toolbar()", child: "toolbar(_:for:)", code: """
        PhotoViewer(photo)
            .toolbar(isImmersed ? .hidden : .visible, for: .navigationBar)
        Toggle("Immersed", isOn: $isImmersed)
        """) { AnyView(C04_ToolbarVisibilityExample()) },

        // MARK: .toolbarBackground()

        ChildExampleEntry(parent: ".toolbarBackground()", child: "toolbarBackground(_:for:)", code: """
        content
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar, .tabBar)
        """) { AnyView(C04_ToolbarBackgroundExample()) },

        ChildExampleEntry(parent: ".toolbarBackground()", child: "toolbarBackgroundVisibility(_:for:)", code: """
        content
            .toolbarBackground(.indigo, for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
        """) { AnyView(C04_ToolbarBackgroundVisibilityExample()) },

        ChildExampleEntry(parent: ".toolbarBackground()", child: "toolbarColorScheme(_:for:)", code: """
        content
            .toolbarBackground(.indigo, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        """) { AnyView(C04_ToolbarColorSchemeExample()) },

        // MARK: .transition()

        ChildExampleEntry(parent: ".transition()", child: ".asymmetric(insertion:removal:)", code: """
        if showToast {
            ToastView()
                .transition(.asymmetric(
                    insertion: .move(edge: .bottom),   // slides up
                    removal: .opacity                  // fades away
                ))
        }
        Button("Toast") { withAnimation(.snappy) { showToast.toggle() } }
        """) { AnyView(C04_AsymmetricTransitionExample()) },

        ChildExampleEntry(parent: ".transition()", child: ".move(edge:)", code: """
        HStack(spacing: 0) {
            if showSidebar {
                Sidebar()
                    .transition(.move(edge: .leading))
            }
            Detail()
        }
        Toggle("Sidebar", isOn: $showSidebar.animation(.snappy))
        """) { AnyView(C04_MoveTransitionExample()) },

        ChildExampleEntry(parent: ".transition()", child: "combined(with:)", code: """
        if showBanner {
            BannerView()
                .transition(.scale(scale: 0.9).combined(with: .opacity))
        }
        Button("Banner") { withAnimation(.bouncy) { showBanner.toggle() } }
        """) { AnyView(C04_CombinedTransitionExample()) },

        ChildExampleEntry(parent: ".transition()", child: ".blurReplace", code: """
        if isDone {
            Image(systemName: "checkmark.circle.fill")
                .transition(.blurReplace)
        } else {
            Image(systemName: "circle.dotted")
                .transition(.blurReplace)
        }
        Button("Toggle") { withAnimation(.smooth) { isDone.toggle() } }
        """) { AnyView(C04_BlurReplaceTransitionExample()) },

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

// MARK: - .scrollEdgeEffectStyle()

private struct C04_Gallery: View {
    var body: some View {
        LazyVStack(spacing: 8) {
            ForEach(0..<12, id: \.self) { i in
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(hue: Double(i) / 12, saturation: 0.5, brightness: 0.9))
                    .frame(height: 44)
                    .overlay(Text("Photo \(i + 1)").font(.caption).foregroundStyle(.white))
            }
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 10)
    }
}

private struct C04_EdgeEffectSoftExample: View {
    var body: some View {
        VStack(spacing: 6) {
            ScrollView { C04_Gallery() }
                .safeAreaBar(edge: .top) {
                    Text("Gallery").font(.headline).padding(.vertical, 6)
                }
                .scrollEdgeEffectStyle(.soft, for: .top)
                .frame(width: 240, height: 150)
                .clipShape(.rect(cornerRadius: 10))
            Text("Scroll — .soft blurs content as it passes beneath the bar")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

private struct C04_EdgeEffectHardExample: View {
    var body: some View {
        VStack(spacing: 6) {
            ScrollView { C04_Gallery() }
                .safeAreaBar(edge: .top) {
                    Text("Gallery").font(.headline).padding(.vertical, 6)
                }
                .scrollEdgeEffectStyle(.hard, for: .all)
                .frame(width: 240, height: 150)
                .clipShape(.rect(cornerRadius: 10))
            Text("Scroll — .hard draws a crisp opaque edge behind the bar")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

private struct C04_EdgeEffectHiddenExample: View {
    @State private var isHidden = false
    var body: some View {
        VStack(spacing: 6) {
            ScrollView { C04_Gallery() }
                .safeAreaBar(edge: .top) {
                    Text("Gallery").font(.headline).padding(.vertical, 6)
                }
                .scrollEdgeEffectHidden(isHidden, for: .top)
                .frame(width: 240, height: 150)
                .clipShape(.rect(cornerRadius: 10))
            Toggle("Hide edge effect", isOn: $isHidden)
                .controlSize(.small)
            Text("Scroll with the effect hidden — content runs straight under the bar")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - .scrollPosition()

private struct C04_ScrollPositionValueExample: View {
    @State private var position = ScrollPosition(edge: .top)

    var body: some View {
        VStack(spacing: 8) {
            ScrollView {
                LazyVStack(spacing: 4) {
                    ForEach(1...30, id: \.self) { i in
                        Text("Row \(i)")
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(6)
                            .background(i == 15 ? AnyShapeStyle(.blue.opacity(0.2)) : AnyShapeStyle(.quaternary),
                                        in: .rect(cornerRadius: 6))
                    }
                }
                .scrollTargetLayout()
            }
            .scrollPosition($position)
            .frame(width: 220, height: 130)
            HStack {
                Button("Top") { withAnimation { position.scrollTo(edge: .top) } }
                Button("Row 15") { withAnimation { position.scrollTo(id: 15, anchor: .center) } }
                Button("Bottom") { withAnimation { position.scrollTo(edge: .bottom) } }
            }
            .controlSize(.small)
        }
    }
}

private struct C04_ScrollPositionIDExample: View {
    @State private var pageID: Int? = 0
    private let colors: [Color] = [.blue, .orange, .green, .purple, .pink]

    var body: some View {
        VStack(spacing: 8) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(colors.indices, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(colors[i].gradient)
                            .overlay(Text("Page \(i + 1)").font(.headline).foregroundStyle(.white))
                            .padding(6)
                            .containerRelativeFrame(.horizontal)
                            .id(i)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $pageID, anchor: .center)
            .frame(width: 240, height: 100)
            HStack(spacing: 6) {
                ForEach(colors.indices, id: \.self) { i in
                    Circle()
                        .fill(pageID == i ? Color.primary : Color.secondary.opacity(0.3))
                        .frame(width: 6, height: 6)
                        .onTapGesture { withAnimation { pageID = i } }
                }
            }
            Text("pageID = \(pageID.map(String.init) ?? "nil") — scroll, or tap a dot")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - .scrollTargetBehavior()

private struct C04_PagingBehaviorExample: View {
    private let slides = ["Welcome", "Browse", "Search", "Enjoy"]

    var body: some View {
        VStack(spacing: 6) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(slides.indices, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.indigo.opacity(0.15 + Double(i) * 0.2))
                            .overlay(Text(slides[i]).font(.headline))
                            .padding(6)
                            .containerRelativeFrame(.horizontal)
                    }
                }
            }
            .scrollTargetBehavior(.paging)
            .frame(width: 240, height: 100)
            Text("Swipe — each page is exactly one container width, so scrolling lands on a page")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

private struct C04_ViewAlignedBehaviorExample: View {
    var body: some View {
        VStack(spacing: 6) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 12) {
                    ForEach(1...8, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.teal.opacity(0.3))
                            .frame(width: 110, height: 80)
                            .overlay(Text("Card \(i)").font(.caption))
                    }
                }
                .scrollTargetLayout()
                .padding(.horizontal, 12)
            }
            .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
            .frame(width: 240, height: 96)
            Text("Swipe — .always limits each swipe to one card, however hard you flick")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

private struct C04_ScrollTargetLayoutExample: View {
    @State private var snapsToCards = true

    var body: some View {
        VStack(spacing: 6) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 16) {
                    ForEach(1...8, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.orange.opacity(0.3))
                            .frame(width: 100, height: 80)
                            .overlay(Text("Card \(i)").font(.caption))
                    }
                }
                .scrollTargetLayout(isEnabled: snapsToCards)
                .padding(.horizontal, 12)
            }
            .scrollTargetBehavior(.viewAligned)
            .frame(width: 240, height: 96)
            Toggle("Snap to cards", isOn: $snapsToCards)
                .controlSize(.small)
            Text(snapsToCards ? "Cards are scroll targets — swipes settle on one" : "Disabled — the view scrolls freely")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - .searchable()

private struct C04_SearchableTextPromptExample: View {
    @State private var query = ""
    private let parks = ["Acadia", "Arches", "Glacier", "Olympic", "Yosemite", "Zion"]
    private var filteredParks: [String] {
        query.isEmpty ? parks : parks.filter { $0.localizedCaseInsensitiveContains(query) }
    }

    var body: some View {
        VStack(spacing: 6) {
            HStack {
                Image(systemName: "magnifyingglass").foregroundStyle(.secondary)
                TextField("Park name", text: $query).textFieldStyle(.plain)
            }
            .padding(6)
            .background(.quaternary, in: .rect(cornerRadius: 8))
            List(filteredParks, id: \.self) { Text($0) }
                .frame(height: 100)
            Text("Illustrative — the prompt is the field's placeholder; on macOS the real field lives in the window toolbar")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(width: 260)
    }
}

private struct C04_SearchablePlacementExample: View {
    @State private var query = ""
    private let notes = ["Grocery list", "Meeting notes", "Reading list", "Trip ideas", "Recipes"]
    private var results: [String] {
        query.isEmpty ? notes : notes.filter { $0.localizedCaseInsensitiveContains(query) }
    }

    var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 0) {
                // Sidebar column: the search field sits at its top.
                VStack(spacing: 6) {
                    HStack {
                        Image(systemName: "magnifyingglass").foregroundStyle(.secondary)
                        TextField("Filter notes", text: $query).textFieldStyle(.plain)
                    }
                    .font(.caption)
                    .padding(5)
                    .background(.quaternary, in: .rect(cornerRadius: 6))
                    ForEach(results, id: \.self) { note in
                        Label(note, systemImage: "note.text")
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Spacer(minLength: 0)
                }
                .padding(8)
                .frame(width: 130)
                .background(.background.secondary)
                Divider()
                Text("Detail")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: 260, height: 130)
            .clipShape(.rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.quaternary))
            Text("Illustrative — .sidebar places the field at the top of the sidebar column instead of the toolbar")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

private struct C04_SearchSuggestionsExample: View {
    @State private var query = ""
    @FocusState private var isSearching: Bool
    private let recentQueries = ["swift concurrency", "swiftui layout", "sf symbols", "spring animation"]
    private let items = ["Swift Concurrency Guide", "SwiftUI Layout Cookbook", "SF Symbols 6", "Spring Animations", "Grid Layouts"]

    private var suggestions: [String] {
        recentQueries.filter { query.isEmpty || $0.localizedCaseInsensitiveContains(query) }
    }

    private var results: [String] {
        query.isEmpty ? items : items.filter { $0.localizedCaseInsensitiveContains(query) }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Image(systemName: "magnifyingglass").foregroundStyle(.secondary)
                TextField("Search", text: $query)
                    .textFieldStyle(.plain)
                    .focused($isSearching)
            }
            .padding(6)
            .background(.quaternary, in: .rect(cornerRadius: 8))
            if isSearching, !suggestions.isEmpty {
                VStack(alignment: .leading, spacing: 2) {
                    ForEach(suggestions, id: \.self) { term in
                        Label(term, systemImage: "clock")
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(4)
                            .contentShape(.rect)
                            .onTapGesture { query = term; isSearching = false }   // what .searchCompletion(term) does
                    }
                }
                .padding(4)
                .background(.background.secondary, in: .rect(cornerRadius: 8))
            } else {
                ForEach(results, id: \.self) { Text($0).font(.caption) }
            }
            Text("Illustrative — suggestions appear under the search field while it is active; a click fills the field via searchCompletion")
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .frame(width: 260)
    }
}

// MARK: - .sensoryFeedback()

private struct C04_SensoryFeedbackTriggerExample: View {
    @State private var size = "M"
    @State private var fired = 0
    private let sizes = ["S", "M", "L", "XL"]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Picker("Size", selection: $size) {
                ForEach(sizes, id: \.self) { Text($0) }
            }
            .pickerStyle(.segmented)
            .sensoryFeedback(.selection, trigger: size)
            .onChange(of: size) { fired += 1 }
            Text(".selection played \(fired)× — once per change of `size`")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
            Text("Felt on a Force Touch trackpad; iPhone plays a haptic")
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .frame(width: 260)
    }
}

private struct C04_SensoryFeedbackClosureExample: View {
    @State private var count = 0
    @State private var last = "—"

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Stepper("Count: \(count)", value: $count)
                .sensoryFeedback(trigger: count) { old, new in
                    new > old ? .increase : .decrease
                }
                .onChange(of: count) { old, new in
                    last = new > old ? ".increase" : ".decrease"
                }
            Text("closure returned \(last)")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
            Text("Return nil from the closure to stay silent for a change")
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .frame(width: 240)
    }
}

private struct C04_ImpactFeedbackExample: View {
    private let weights: [(String, SensoryFeedback.Weight)] = [(".light", .light), (".medium", .medium), (".heavy", .heavy)]
    @State private var weightIndex = 2
    @State private var intensity = 0.8
    @State private var drops = 0

    private var weight: SensoryFeedback.Weight { weights[weightIndex].1 }

    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.blue.opacity(0.12))
                .frame(width: 240, height: 54)
                .overlay {
                    Label("Drop here (\(drops))", systemImage: "arrow.down.to.line")
                        .font(.caption)
                }
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.blue, style: StrokeStyle(lineWidth: 1, dash: [4])))
                .contentShape(.rect)
                .onTapGesture { drops += 1 }
                .sensoryFeedback(.impact(weight: weight, intensity: intensity), trigger: drops)
            Picker("Weight", selection: $weightIndex) {
                ForEach(weights.indices, id: \.self) { Text(weights[$0].0).tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            HStack {
                Text("intensity").font(.caption)
                Slider(value: $intensity, in: 0...1)
                Text(String(format: "%.2f", intensity)).font(.caption.monospaced())
            }
        }
        .frame(width: 240)
    }
}

// MARK: - .shadow()

private struct C04_ShadowModifierExample: View {
    @State private var radius: CGFloat = 6
    @State private var yOffset: CGFloat = 3

    var body: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 12)
                .fill(.background)
                .frame(width: 160, height: 60)
                .overlay(Label("Card", systemImage: "creditcard").font(.caption))
                .shadow(color: .black.opacity(0.15), radius: radius, x: 0, y: yOffset)
            Grid(alignment: .leading, verticalSpacing: 4) {
                GridRow {
                    Text("radius").font(.caption)
                    Slider(value: $radius, in: 0...20)
                    Text(String(format: "%.0f", radius)).font(.caption.monospaced())
                }
                GridRow {
                    Text("y").font(.caption)
                    Slider(value: $yOffset, in: -10...10)
                    Text(String(format: "%.0f", yOffset)).font(.caption.monospaced())
                }
            }
        }
        .padding(.top, 8)
        .frame(width: 240)
    }
}

private struct C04_ShapeStyleShadowExample: View {
    var body: some View {
        HStack(alignment: .top, spacing: 24) {
            VStack(spacing: 8) {
                badge(AnyShapeStyle(Color.blue.shadow(.inner(radius: 4, y: 2))))
                caption(".fill(.blue.shadow(.inner(…)))")
            }
            VStack(spacing: 8) {
                badge(AnyShapeStyle(Color.blue.shadow(.drop(radius: 4, y: 2))))
                caption(".fill(.blue.shadow(.drop(…)))")
            }
            VStack(spacing: 8) {
                badge(AnyShapeStyle(Color.blue))
                    .shadow(radius: 4, y: 2)
                caption("view .shadow — blurs the 9 too")
            }
        }
    }

    private func badge(_ style: AnyShapeStyle) -> some View {
        Circle()
            .fill(style)
            .frame(width: 60, height: 60)
            .overlay(Text("9").font(.title3.bold()).foregroundStyle(.white))
    }

    private func caption(_ text: String) -> some View {
        Text(text)
            .font(.caption2)
            .foregroundStyle(.tertiary)
            .multilineTextAlignment(.center)
            .frame(width: 90)
    }
}

// MARK: - .sheet()

private struct C04_SheetIsPresentedExample: View {
    @State private var showSettings = false
    @State private var dismissCount = 0
    @State private var notifications = true

    var body: some View {
        VStack(spacing: 8) {
            Button("Settings") { showSettings = true }
                .sheet(isPresented: $showSettings, onDismiss: { dismissCount += 1 }) {
                    VStack(spacing: 12) {
                        Text("Settings").font(.headline)
                        Toggle("Notifications", isOn: $notifications)
                        Button("Done") { showSettings = false }
                            .keyboardShortcut(.defaultAction)
                    }
                    .padding(20)
                    .frame(width: 220)
                }
            Text("isPresented: \(showSettings ? "true" : "false")   onDismiss ran \(dismissCount)×")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
    }
}

private struct C04_SheetItemExample: View {
    private struct Recipe: Identifiable {
        let id: Int
        let name: String
        let minutes: Int
    }

    private let recipes = [
        Recipe(id: 1, name: "Pesto", minutes: 10),
        Recipe(id: 2, name: "Ramen", minutes: 35),
        Recipe(id: 3, name: "Focaccia", minutes: 90),
    ]
    @State private var selectedRecipe: Recipe?
    @State private var refreshCount = 0

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                ForEach(recipes) { recipe in
                    Button(recipe.name) { selectedRecipe = recipe }
                }
            }
            .sheet(item: $selectedRecipe, onDismiss: { refreshCount += 1 }) { recipe in
                VStack(spacing: 10) {
                    Text(recipe.name).font(.title2.bold())
                    Label("\(recipe.minutes) min", systemImage: "clock")
                    Button("Close") { selectedRecipe = nil }
                        .keyboardShortcut(.cancelAction)
                }
                .padding(20)
                .frame(width: 200)
            }
            Text("refreshList() ran \(refreshCount)× — the sheet receives the tapped recipe, unwrapped")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(width: 280)
    }
}

// MARK: - .swipeActions()

private struct C04_SwipeActionsExample: View {
    private struct Item: Identifiable {
        let id: Int
        let title: String
    }

    private let items = [
        Item(id: 1, title: "Release notes"),
        Item(id: 2, title: "Design review"),
        Item(id: 3, title: "Weekly digest"),
    ]
    @State private var read: Set<Int> = []

    var body: some View {
        VStack(spacing: 6) {
            List(items) { item in
                Label(item.title, systemImage: read.contains(item.id) ? "envelope.open" : "envelope.badge")
                    .foregroundStyle(read.contains(item.id) ? Color.secondary : Color.primary)
                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                        Button("Read") { read.insert(item.id) }.tint(.blue)
                    }
            }
            .frame(width: 260, height: 110)
            Text("Swipe a row right with two fingers — a full swipe never auto-fires because allowsFullSwipe: false")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .frame(width: 260)
        }
    }
}

private struct C04_HorizontalEdgeExample: View {
    private struct Message: Identifiable {
        let id: Int
        let text: String
    }

    @State private var messages = [
        Message(id: 1, text: "Lunch tomorrow?"),
        Message(id: 2, text: "Build is green"),
        Message(id: 3, text: "Photos from the trip"),
    ]
    @State private var flagged: Set<Int> = []

    var body: some View {
        VStack(spacing: 6) {
            List(messages) { message in
                HStack {
                    Text(message.text)
                    Spacer()
                    if flagged.contains(message.id) {
                        Image(systemName: "flag.fill").foregroundStyle(.orange)
                    }
                }
                .swipeActions(edge: .leading) {
                    Button("Flag") { flagged.insert(message.id) }.tint(.orange)
                }
                .swipeActions(edge: .trailing) {
                    Button("Delete", role: .destructive) { messages.removeAll { $0.id == message.id } }
                }
            }
            .frame(width: 260, height: 110)
            Text(".leading reveals Flag (swipe right) · .trailing reveals Delete (swipe left)")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .frame(width: 260)
        }
    }
}

// MARK: - .symbolEffect()

private struct C04_SymbolEffectIsActiveExample: View {
    @State private var isBroadcasting = true

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "dot.radiowaves.left.and.right")
                .font(.system(size: 40))
                .foregroundStyle(isBroadcasting ? Color.blue : Color.secondary)
                .symbolEffect(.pulse, options: .speed(1.5), isActive: isBroadcasting)
            Toggle("Broadcasting", isOn: $isBroadcasting)
                .toggleStyle(.switch)
            Text(isBroadcasting ? "isActive: true — pulses until the flag drops" : "isActive: false — the effect winds down")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C04_SymbolEffectValueExample: View {
    @State private var unreadCount = 0

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "envelope.fill")
                .font(.system(size: 40))
                .foregroundStyle(.blue)
                .symbolEffect(.bounce, options: .repeat(.periodic(2)), value: unreadCount)
                .overlay(alignment: .topTrailing) {
                    if unreadCount > 0 {
                        Text("\(unreadCount)")
                            .font(.caption2.bold())
                            .foregroundStyle(.white)
                            .padding(4)
                            .background(.red, in: .circle)
                            .offset(x: 8, y: -8)
                    }
                }
            Button("New message") { unreadCount += 1 }
            Text("bounces twice per change of `unreadCount`")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - .task()

private struct C04_TaskPriorityExample: View {
    @State private var showGrid = true
    @State private var loaded = 0

    var body: some View {
        VStack(spacing: 8) {
            Toggle("Show grid", isOn: $showGrid).toggleStyle(.switch)
            if showGrid {
                HStack(spacing: 8) {
                    ForEach(1...6, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 6)
                            .fill(i <= loaded ? Color.teal : Color.gray.opacity(0.25))
                            .frame(width: 34, height: 34)
                            .overlay {
                                Image(systemName: i <= loaded ? "photo" : "ellipsis")
                                    .font(.caption)
                                    .foregroundStyle(.white)
                            }
                    }
                }
                .task(priority: .background) {
                    loaded = 0
                    for i in 1...6 {
                        guard (try? await Task.sleep(for: .milliseconds(350))) != nil else { return }
                        loaded = i
                    }
                }
            }
            Text("prefetched \(loaded)/6 at .background priority — hide the grid to cancel, show it to restart")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(width: 270)
    }
}

private struct C04_TaskIDExample: View {
    private let catalog = ["Acadia", "Arches", "Badlands", "Big Bend", "Glacier", "Olympic", "Yosemite", "Zion"]
    @State private var query = ""
    @State private var results: [String] = []
    @State private var runs = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            TextField("Search parks", text: $query)
                .textFieldStyle(.roundedBorder)
            VStack(alignment: .leading, spacing: 2) {
                ForEach(results, id: \.self) { Text($0).font(.caption) }
            }
            .frame(maxWidth: .infinity, minHeight: 70, maxHeight: 70, alignment: .topLeading)
            .task(id: query) {
                runs += 1
                guard (try? await Task.sleep(for: .milliseconds(400))) != nil else { return }
                results = await search(query)
            }
            Text("task started \(runs)× — each keystroke cancels the previous run")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(width: 260)
    }

    private func search(_ term: String) async -> [String] {
        term.isEmpty ? catalog : catalog.filter { $0.localizedCaseInsensitiveContains(term) }
    }
}

// MARK: - .toolbar()

/// A miniature macOS window: traffic lights, a toolbar row, and a content area — toolbars need a real window.
private struct C04_WindowMock<Bar: View>: View {
    var content: String
    @ViewBuilder var bar: Bar

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                HStack(spacing: 5) {
                    Circle().fill(.red).frame(width: 9, height: 9)
                    Circle().fill(.yellow).frame(width: 9, height: 9)
                    Circle().fill(.green).frame(width: 9, height: 9)
                }
                bar
            }
            .padding(.horizontal, 10)
            .frame(height: 34)
            .background(.bar)
            Divider()
            Text(content)
                .font(.caption)
                .foregroundStyle(.tertiary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.background)
        }
        .frame(width: 270, height: 110)
        .clipShape(.rect(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.quaternary))
    }
}

private struct C04_ToolbarContentExample: View {
    @State private var last = "—"

    var body: some View {
        VStack(spacing: 6) {
            C04_WindowMock(content: "Edit Contact") {
                Button("Cancel") { last = "dismiss()" }          // .cancellationAction
                Spacer()
                Button("Save") { last = "save()" }               // .confirmationAction
                    .buttonStyle(.borderedProminent)
            }
            .controlSize(.small)
            Text("last action: \(last)")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
            Text("Illustrative — semantic placements land where each platform expects them")
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
    }
}

private struct C04_ToolbarIDExample: View {
    @State private var showsShare = true
    @State private var isBold = false

    var body: some View {
        VStack(spacing: 6) {
            C04_WindowMock(content: isBold ? "Bold body text" : "Body text") {
                Spacer()
                Button("Bold", systemImage: "bold") { isBold.toggle() }     // id: "bold"
                    .foregroundStyle(isBold ? Color.accentColor : Color.primary)
                if showsShare {
                    Button("Share", systemImage: "square.and.arrow.up") { }  // id: "share"
                }
            }
            .labelStyle(.iconOnly)
            .buttonStyle(.borderless)
            Toggle("User removed “share” via Customize Toolbar…", isOn: Binding(get: { !showsShare }, set: { showsShare = !$0 }))
                .controlSize(.small)
            Text("Illustrative — ids let macOS users add, remove, and rearrange items, persisted across launches")
                .font(.caption2)
                .foregroundStyle(.tertiary)
                .multilineTextAlignment(.center)
        }
        .frame(width: 280)
    }
}

/// A phone with a navigation bar (and optional tab bar) over colorful content — bar styling applies to iOS bars.
private struct C04_PhoneBarsMock: View {
    var showsNavBar: Bool
    var showsTabBar: Bool
    var barStyle: AnyShapeStyle
    var barColorScheme: ColorScheme?
    @Environment(\.colorScheme) private var inherited

    init(
        showsNavBar: Bool = true,
        showsTabBar: Bool = false,
        barStyle: AnyShapeStyle = AnyShapeStyle(Material.bar),
        barColorScheme: ColorScheme? = nil
    ) {
        self.showsNavBar = showsNavBar
        self.showsTabBar = showsTabBar
        self.barStyle = barStyle
        self.barColorScheme = barColorScheme
    }

    var body: some View {
        ZStack {
            LinearGradient(colors: [.orange, .pink, .purple], startPoint: .top, endPoint: .bottom)
            VStack(spacing: 0) {
                if showsNavBar {
                    HStack {
                        Image(systemName: "chevron.left")
                        Spacer()
                        Text("Photos").bold()
                        Spacer()
                        Image(systemName: "square.and.arrow.up")
                    }
                    .font(.caption2)
                    .padding(.horizontal, 8)
                    .frame(height: 28)
                    .background(barStyle)
                    .environment(\.colorScheme, barColorScheme ?? inherited)
                }
                Spacer()
                if showsTabBar {
                    HStack {
                        Image(systemName: "photo.on.rectangle")
                        Spacer()
                        Image(systemName: "heart")
                        Spacer()
                        Image(systemName: "magnifyingglass")
                    }
                    .font(.caption2)
                    .padding(.horizontal, 14)
                    .frame(height: 28)
                    .background(barStyle)
                    .environment(\.colorScheme, barColorScheme ?? inherited)
                }
            }
        }
        .frame(width: 100, height: 160)
        .clipShape(.rect(cornerRadius: 14))
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(.black, lineWidth: 3))
    }
}

private struct C04_ToolbarVisibilityExample: View {
    @State private var isImmersed = false

    var body: some View {
        HStack(spacing: 20) {
            C04_PhoneBarsMock(showsNavBar: !isImmersed)
                .animation(.easeInOut(duration: 0.2), value: isImmersed)
            VStack(alignment: .leading, spacing: 8) {
                Toggle("Immersed", isOn: $isImmersed).toggleStyle(.switch)
                Text(isImmersed ? ".hidden — the bar is gone and the photo fills the screen" : ".visible — the navigation bar is shown")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("Illustrative — .navigationBar is an iOS bar; on macOS use .windowToolbar")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
            .frame(width: 170)
        }
    }
}

// MARK: - .toolbarBackground()

private struct C04_ToolbarBackgroundExample: View {
    var body: some View {
        HStack(spacing: 20) {
            C04_PhoneBarsMock(showsNavBar: true, showsTabBar: true, barStyle: AnyShapeStyle(Material.ultraThinMaterial))
            VStack(alignment: .leading, spacing: 8) {
                Text(".ultraThinMaterial painted behind both the navigation bar and the tab bar — the photo shows through")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("Illustrative — iOS bars")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
            .frame(width: 170)
        }
    }
}

private struct C04_ToolbarBackgroundVisibilityExample: View {
    @State private var forceVisible = true

    var body: some View {
        HStack(spacing: 20) {
            C04_PhoneBarsMock(barStyle: AnyShapeStyle(forceVisible ? Color.indigo : Color.clear), barColorScheme: .dark)
            VStack(alignment: .leading, spacing: 8) {
                Picker("Visibility", selection: $forceVisible) {
                    Text(".visible").tag(true)
                    Text(".automatic").tag(false)
                }
                .pickerStyle(.segmented)
                .labelsHidden()
                Text(forceVisible ? "the indigo background shows even at the top of the scroll" : "automatic hides the background until content scrolls beneath the bar")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("Illustrative — iOS bars")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
            .frame(width: 170)
        }
    }
}

private struct C04_ToolbarColorSchemeExample: View {
    @State private var isDark = true

    var body: some View {
        HStack(spacing: 20) {
            C04_PhoneBarsMock(barStyle: AnyShapeStyle(Color.indigo), barColorScheme: isDark ? .dark : .light)
            VStack(alignment: .leading, spacing: 8) {
                Picker("Scheme", selection: $isDark) {
                    Text(".dark").tag(true)
                    Text(".light").tag(false)
                }
                .pickerStyle(.segmented)
                .labelsHidden()
                Text(isDark ? "white title and items stay legible on indigo" : "dark title and items on indigo are hard to read")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("Illustrative — iOS bars")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
            .frame(width: 170)
        }
    }
}

// MARK: - .transition()

private struct C04_AsymmetricTransitionExample: View {
    @State private var showToast = false

    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 10).fill(.quaternary)
                if showToast {
                    Label("Saved", systemImage: "checkmark.circle.fill")
                        .font(.caption.bold())
                        .foregroundStyle(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(.green, in: .capsule)
                        .padding(.bottom, 10)
                        .transition(.asymmetric(
                            insertion: .move(edge: .bottom),
                            removal: .opacity
                        ))
                }
            }
            .frame(width: 240, height: 90)
            .clipShape(.rect(cornerRadius: 10))
            Button(showToast ? "Dismiss toast" : "Show toast") { withAnimation(.snappy) { showToast.toggle() } }
            Text("in: slides up from the bottom · out: fades")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C04_MoveTransitionExample: View {
    @State private var showSidebar = true

    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 0) {
                if showSidebar {
                    VStack(alignment: .leading, spacing: 6) {
                        ForEach(["Inbox", "Drafts", "Sent"], id: \.self) {
                            Label($0, systemImage: "tray").font(.caption)
                        }
                        Spacer(minLength: 0)
                    }
                    .padding(8)
                    .frame(width: 90)
                    .background(.background.secondary)
                    .transition(.move(edge: .leading))
                }
                Text("Detail")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: 240, height: 90)
            .clipShape(.rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.quaternary))
            Toggle("Sidebar", isOn: $showSidebar.animation(.snappy))
                .toggleStyle(.switch)
        }
    }
}

private struct C04_CombinedTransitionExample: View {
    @State private var showBanner = false

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(.quaternary)
                if showBanner {
                    Label("New version available", systemImage: "arrow.down.circle")
                        .font(.caption)
                        .padding(10)
                        .background(.blue.opacity(0.15), in: .rect(cornerRadius: 8))
                        .transition(.scale(scale: 0.9).combined(with: .opacity))
                }
            }
            .frame(width: 240, height: 80)
            Button(showBanner ? "Hide banner" : "Show banner") { withAnimation(.bouncy) { showBanner.toggle() } }
            Text("scale from 90 % and fade, played together")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C04_BlurReplaceTransitionExample: View {
    @State private var isDone = false

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                if isDone {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                        .transition(.blurReplace)
                } else {
                    Image(systemName: "circle.dotted")
                        .foregroundStyle(.secondary)
                        .transition(.blurReplace)
                }
            }
            .font(.system(size: 44))
            .frame(height: 60)
            Button(isDone ? "Reset" : "Complete") { withAnimation(.smooth) { isDone.toggle() } }
            Text("the old symbol blurs out as the new one blurs in")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - end of examples
