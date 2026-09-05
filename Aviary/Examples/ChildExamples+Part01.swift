//
//  ChildExamples+Part01.swift
//  Aviary
//
//  Compiled renderings for variant entries (part 01: modifiers).
//  One private C01_* struct per variant; every rendering exercises the exact
//  overload the variant names, so siblings can be compared side by side.
//

import SwiftUI

enum ChildExamplesPart01 {
    static let entries: [ChildExampleEntry] = [

        // MARK: .alert()

        ChildExampleEntry(parent: ".alert()", child: "alert(_:isPresented:actions:)", code: """
        Button("Sign Out…") { confirmSignOut = true }
            .alert("Sign out?", isPresented: $confirmSignOut) {
                Button("Sign Out", role: .destructive) { signOut() }
                Button("Stay", role: .cancel) { }
            }
        """) { AnyView(C01_AlertBasicExample()) },

        ChildExampleEntry(parent: ".alert()", child: "alert(_:isPresented:presenting:actions:message:)", code: """
        tagChips
            .alert("Remove tag?", isPresented: $confirmRemove, presenting: pendingTag) { tag in
                Button("Remove \\(tag.name)", role: .destructive) { remove(tag) }
                Button("Keep", role: .cancel) { }
            } message: { tag in
                Text("\\(tag.usageCount) items will lose this tag.")
            }
        """) { AnyView(C01_AlertPresentingExample()) },

        ChildExampleEntry(parent: ".alert()", child: "alert(isPresented:error:actions:message:)", code: """
        struct UploadError: LocalizedError {
            var errorDescription: String? { "Upload failed" }
            var recoverySuggestion: String? { "Check your connection, then retry." }
        }

        Button("Upload") { showError = true }
            .alert(isPresented: $showError, error: uploadError) { _ in
                Button("Retry") { retryUpload() }
                Button("Cancel", role: .cancel) { }
            } message: { error in
                Text(error.recoverySuggestion ?? "")
            }
        """) { AnyView(C01_AlertErrorExample()) },

        // MARK: .animation()

        ChildExampleEntry(parent: ".animation()", child: "animation(_:value:)", code: """
        Capsule()
            .fill(isOn ? .green : .gray)
            .frame(width: isOn ? 160 : 80, height: 32)
            .opacity(dimmed ? 0.35 : 1)          // not the `value` → changes instantly
            .animation(.easeInOut(duration: 0.25), value: isOn)
        """) { AnyView(C01_AnimationValueExample()) },

        ChildExampleEntry(parent: ".animation()", child: "animation(_:body:)", code: """
        Image(systemName: "star.fill")
            .animation(.bouncy) { content in
                content
                    .scaleEffect(isFavorite ? 1.3 : 1)
                    .opacity(isFavorite ? 1 : 0.6)
            }
            .foregroundStyle(isFavorite ? .yellow : .gray)   // outside the body → snaps
        """) { AnyView(C01_AnimationBodyExample()) },

        ChildExampleEntry(parent: ".animation()", child: "Animation.spring(duration:bounce:blendDuration:)", code: """
        Button(isExpanded ? "Collapse" : "Expand") {
            withAnimation(.spring(duration: 0.5, bounce: bounce, blendDuration: 0)) {
                isExpanded.toggle()
            }
        }
        Slider(value: $bounce, in: 0...0.8)
        """) { AnyView(C01_SpringDurationBounceExample()) },

        ChildExampleEntry(parent: ".animation()", child: "Animation.repeatForever(autoreverses:)", code: """
        Circle()
            .scaleEffect(isPulsing ? 1.4 : 1)
            .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: isPulsing)
            .onAppear { isPulsing = true }

        Circle()   // autoreverses: false snaps back to the start each cycle
            .scaleEffect(isPulsing ? 1.4 : 1)
            .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: false), value: isPulsing)
        """) { AnyView(C01_RepeatForeverExample()) },

        // MARK: .aspectRatio()

        ChildExampleEntry(parent: ".aspectRatio()", child: "aspectRatio(_:contentMode:)", code: """
        poster                                       // a 16:9 gradient stand-in
            .aspectRatio(16 / 9, contentMode: .fit)
            .frame(width: 120, height: 120)

        poster
            .aspectRatio(16 / 9, contentMode: .fill)
            .frame(width: 120, height: 120)
            .clipped()
        """) { AnyView(C01_AspectRatioExample()) },

        ChildExampleEntry(parent: ".aspectRatio()", child: "scaledToFit()", code: """
        Image(systemName: "swift")
            .resizable()
            .scaledToFit()
            .frame(height: 48)
        """) { AnyView(C01_ScaledToFitExample()) },

        ChildExampleEntry(parent: ".aspectRatio()", child: "scaledToFill()", code: """
        Image(systemName: "sun.horizon.fill")
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
            .clipShape(.circle)
        """) { AnyView(C01_ScaledToFillExample()) },

        // MARK: .background()

        ChildExampleEntry(parent: ".background()", child: "background(_:in:)", code: """
        Text("NEW")
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
            .background(.orange, in: .capsule)

        Text("v2.1")
            .padding(6)
            .background(.blue.gradient, in: .rect(cornerRadius: 6))

        Image(systemName: "star.fill")
            .padding(10)
            .background(.ultraThinMaterial, in: .circle)
        """) { AnyView(C01_BackgroundInShapeExample()) },

        ChildExampleEntry(parent: ".background()", child: "background(alignment:content:)", code: """
        Text("Score: 42")
            .font(.title3)
            .background(alignment: alignment) {
                Image(systemName: "seal.fill")
                    .font(.system(size: 44))
                    .foregroundStyle(.yellow.opacity(0.7))
            }
        """) { AnyView(C01_BackgroundAlignmentExample()) },

        ChildExampleEntry(parent: ".background()", child: "background(_:ignoresSafeAreaEdges:)", code: """
        ContentColumn()
            .background(.orange.gradient, ignoresSafeAreaEdges: .bottom)
            .safeAreaInset(edge: .bottom) { TabBar() }

        ContentColumn()                              // [] keeps it inside the safe area
            .background(.orange.gradient, ignoresSafeAreaEdges: [])
            .safeAreaInset(edge: .bottom) { TabBar() }
        """) { AnyView(C01_BackgroundSafeAreaExample()) },

        // MARK: .badge()

        ChildExampleEntry(parent: ".badge()", child: "badge(_ count: Int)", code: """
        List {
            Label("Inbox", systemImage: "tray")
                .badge(unreadCount)
            Label("Sent", systemImage: "paperplane")
                .badge(0)                              // zero hides the badge
        }
        Stepper("unreadCount: \\(unreadCount)", value: $unreadCount, in: 0...20)
        """) { AnyView(C01_BadgeCountExample()) },

        ChildExampleEntry(parent: ".badge()", child: "badge(_ label: Text?)", code: """
        List {
            Label("Updates", systemImage: "arrow.down.circle")
                .badge(Text("Beta").foregroundStyle(.orange))
            Label("Store", systemImage: "bag")
                .badge(showNew ? Text("New").bold() : nil)   // nil clears it
        }
        """) { AnyView(C01_BadgeTextExample()) },

        ChildExampleEntry(parent: ".badge()", child: "badgeProminence(_:)", code: """
        List {
            Label("Drafts", systemImage: "doc").badge(3)
            Label("Sent", systemImage: "paperplane").badge(12)
        }
        .badgeProminence(prominence)   // .increased / .standard / .decreased
        """) { AnyView(C01_BadgeProminenceExample()) },

        // MARK: .clipShape()

        ChildExampleEntry(parent: ".clipShape()", child: "clipShape(_:style:)", code: """
        let ring = RingShape()   // two concentric circles in one path

        map.clipShape(ring, style: FillStyle(eoFill: true))      // hole punched
        map.clipShape(ring, style: FillStyle(eoFill: false))     // solid disk
        map.clipShape(.circle, style: FillStyle(antialiased: false))
        """) { AnyView(C01_ClipShapeStyleExample()) },

        ChildExampleEntry(parent: ".clipShape()", child: "clipped(antialiased:)", code: """
        banner
            .resizable()
            .scaledToFill()
            .frame(width: 150, height: 60)
            .clipped(antialiased: true)   // without it the fill spills past the frame
        """) { AnyView(C01_ClippedExample()) },

        ChildExampleEntry(parent: ".clipShape()", child: ".rect(topLeadingRadius:bottomLeadingRadius:bottomTrailingRadius:topTrailingRadius:style:)", code: """
        Color.accentColor
            .frame(height: 70)
            .clipShape(.rect(
                topLeadingRadius: 20,
                topTrailingRadius: 20
            ))

        Color.teal
            .frame(height: 70)
            .clipShape(.rect(bottomTrailingRadius: 32, style: .continuous))
        """) { AnyView(C01_UnevenRectExample()) },

        // MARK: .confirmationDialog()

        ChildExampleEntry(parent: ".confirmationDialog()", child: "confirmationDialog(_:isPresented:titleVisibility:actions:)", code: """
        Button("Sort by…") { showSort = true }
            .confirmationDialog("Sort by", isPresented: $showSort,
                                titleVisibility: titleVisible ? .visible : .hidden) {
                Button("Name") { sort = "Name" }
                Button("Date") { sort = "Date" }
            }
        """) { AnyView(C01_ConfirmationDialogBasicExample()) },

        ChildExampleEntry(parent: ".confirmationDialog()", child: "confirmationDialog(_:isPresented:titleVisibility:actions:message:)", code: """
        Button("Discard Draft…") { confirmDiscard = true }
            .confirmationDialog("Discard draft?", isPresented: $confirmDiscard,
                                titleVisibility: .visible) {
                Button("Discard", role: .destructive) { discard() }
            } message: {
                Text("Your unsent changes will be lost.")
            }
        """) { AnyView(C01_ConfirmationDialogMessageExample()) },

        ChildExampleEntry(parent: ".confirmationDialog()", child: "confirmationDialog(_:isPresented:titleVisibility:presenting:actions:message:)", code: """
        fileRows
            .confirmationDialog("Delete?", isPresented: $confirmDelete,
                                titleVisibility: .visible, presenting: target) { file in
                Button("Delete \\(file.name)", role: .destructive) { delete(file) }
            } message: { file in
                Text("\\(file.sizeDescription) will be freed.")
            }
        """) { AnyView(C01_ConfirmationDialogPresentingExample()) },

        // MARK: .containerRelativeFrame()

        ChildExampleEntry(parent: ".containerRelativeFrame()", child: "containerRelativeFrame(_:alignment:)", code: """
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(pages) { page in
                    PageView(page)
                        .containerRelativeFrame(.horizontal)   // one full container width each
                }
            }
        }
        .scrollTargetBehavior(.paging)
        """) { AnyView(C01_ContainerRelativeFrameAxesExample()) },

        ChildExampleEntry(parent: ".containerRelativeFrame()", child: "containerRelativeFrame(_:count:span:spacing:alignment:)", code: """
        ScrollView(.horizontal) {
            LazyHStack(spacing: 12) {
                ForEach(cards) { card in
                    CardView(card)
                        .containerRelativeFrame(.horizontal, count: count, span: 1, spacing: 12)
                }
            }
        }
        """) { AnyView(C01_ContainerRelativeFrameCountExample()) },

        ChildExampleEntry(parent: ".containerRelativeFrame()", child: "containerRelativeFrame(_:alignment:_:)", code: """
        ScrollView {
            HeroImage()
                .containerRelativeFrame([.horizontal, .vertical]) { length, axis in
                    axis == .vertical ? length * 0.4 : length
                }
            Text("Body copy scrolls beneath the hero…")
        }
        """) { AnyView(C01_ContainerRelativeFrameClosureExample()) },

        // MARK: .contentTransition()

        ChildExampleEntry(parent: ".contentTransition()", child: "ContentTransition.numericText(countsDown:)", code: """
        Text("\\(remaining)")
            .font(.largeTitle.monospacedDigit())
            .contentTransition(.numericText(countsDown: countsDown))
            .animation(.default, value: remaining)

        Button("Tick") { remaining -= 1 }
        """) { AnyView(C01_NumericTextCountsDownExample()) },

        ChildExampleEntry(parent: ".contentTransition()", child: "ContentTransition.numericText(value:)", code: """
        Text(total, format: .number)
            .font(.largeTitle.monospacedDigit())
            .contentTransition(.numericText(value: total))   // direction inferred from value
            .animation(.snappy, value: total)

        Button("−10") { total -= 10 }
        Button("+10") { total += 10 }
        """) { AnyView(C01_NumericTextValueExample()) },

        ChildExampleEntry(parent: ".contentTransition()", child: "ContentTransition.symbolEffect(_:options:)", code: """
        Button { isPlaying.toggle() } label: {
            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                .contentTransition(.symbolEffect(.replace.downUp))
        }

        Image(systemName: isPlaying ? "speaker.wave.3.fill" : "speaker.slash.fill")
            .contentTransition(.symbolEffect(.replace.offUp, options: .speed(0.4)))
        """) { AnyView(C01_SymbolEffectTransitionExample()) },

        ChildExampleEntry(parent: ".contentTransition()", child: "ContentTransition.interpolate", code: """
        Text("Interpolate")
            .font(isLarge ? .largeTitle : .body)
            .fontWeight(isLarge ? .black : .regular)
            .contentTransition(.interpolate)
            .animation(.easeInOut(duration: 0.6), value: isLarge)
        """) { AnyView(C01_InterpolateTransitionExample()) },

        // MARK: .contextMenu()

        ChildExampleEntry(parent: ".contextMenu()", child: "contextMenu(menuItems:)", code: """
        NoteRow(note)
            .contextMenu {
                Button("Pin", systemImage: "pin") { pin(note) }
                Divider()
                Button("Delete", systemImage: "trash", role: .destructive) { delete(note) }
            }
        """) { AnyView(C01_ContextMenuExample()) },

        ChildExampleEntry(parent: ".contextMenu()", child: "contextMenu(menuItems:preview:)", code: """
        PhotoThumb(photo)
            .contextMenu {
                Button("Share", systemImage: "square.and.arrow.up") { share(photo) }
            } preview: {
                PhotoView(photo)
                    .frame(width: 220, height: 150)
            }
        """) { AnyView(C01_ContextMenuPreviewExample()) },

        ChildExampleEntry(parent: ".contextMenu()", child: "contextMenu(forSelectionType:menu:primaryAction:)", code: """
        List(files, selection: $selection) { FileRow($0) }
            .contextMenu(forSelectionType: File.ID.self) { ids in
                Button("Reveal in Finder") { reveal(ids) }
            } primaryAction: { ids in
                open(ids)                              // double-click
            }
        """) { AnyView(C01_ContextMenuSelectionExample()) },

        // MARK: .draggable()

        ChildExampleEntry(parent: ".draggable()", child: "draggable(_:)", code: """
        Text(link.title)
            .draggable(link.url)                 // URL is Transferable

        DropWell()
            .dropDestination(for: URL.self) { urls, _ in
                dropped = urls.first
                return true
            }
        """) { AnyView(C01_DraggableExample()) },

        ChildExampleEntry(parent: ".draggable()", child: "draggable(_:preview:)", code: """
        ContactRow(contact)
            .draggable(contact.name) {
                Label(contact.name, systemImage: "person.crop.circle")
                    .padding(8)
                    .background(.regularMaterial, in: .capsule)
            }
        """) { AnyView(C01_DraggablePreviewExample()) },

        // MARK: .fixedSize()

        ChildExampleEntry(parent: ".fixedSize()", child: "fixedSize()", code: """
        Button("Continue with Apple") { next() }
            .frame(width: 90)                      // squeezed → truncates

        Button("Continue with Apple") { next() }
            .fixedSize()                           // ideal size wins
            .frame(width: 90)
        """) { AnyView(C01_FixedSizeExample()) },

        ChildExampleEntry(parent: ".fixedSize()", child: "fixedSize(horizontal:vertical:)", code: """
        Text(longDescription)
            .frame(width: 200, height: 34)         // truncates

        Text(longDescription)
            .fixedSize(horizontal: false, vertical: true)   // wraps instead
            .frame(width: 200, height: 34, alignment: .top)
        """) { AnyView(C01_FixedSizeAxesExample()) },

        // MARK: .focused()

        ChildExampleEntry(parent: ".focused()", child: "focused(_:)", code: """
        @FocusState private var isSearchFocused: Bool

        TextField("Search", text: $query)
            .focused($isSearchFocused)
        Button("Focus Search") { isSearchFocused = true }
        Text("isSearchFocused: \\(isSearchFocused)")
        """) { AnyView(C01_FocusedBoolExample()) },

        ChildExampleEntry(parent: ".focused()", child: "focused(_:equals:)", code: """
        @FocusState private var field: Field?

        TextField("Username", text: $username)
            .focused($field, equals: .username)
            .onSubmit { field = .password }
        SecureField("Password", text: $password)
            .focused($field, equals: .password)
            .onSubmit { field = nil }
        """) { AnyView(C01_FocusedEqualsExample()) },

        // MARK: .font()

        ChildExampleEntry(parent: ".font()", child: "font(_:)", code: """
        Text("Section")
            .font(.headline)                       // semantic: scales with Dynamic Type

        Text("42")
            .font(.system(size: 48, weight: .bold))   // fixed: never scales
        """) { AnyView(C01_FontExample()) },

        ChildExampleEntry(parent: ".font()", child: "fontWeight(_:)", code: """
        Text("Emphasis without a new font")
            .fontWeight(.semibold)

        Text("Emphasis without a new font")
            .fontWeight(weight)                    // .ultraLight … .black
        """) { AnyView(C01_FontWeightExample()) },

        ChildExampleEntry(parent: ".font()", child: "fontDesign(_:)", code: """
        VStack {
            Text("Friendly title").font(.title2)
            Text("And its caption").foregroundStyle(.secondary)
        }
        .fontDesign(design)                        // .default / .rounded / .serif / .monospaced
        """) { AnyView(C01_FontDesignExample()) },

        // MARK: .foregroundStyle()

        ChildExampleEntry(parent: ".foregroundStyle()", child: "foregroundStyle(_:)", code: """
        Text("Subtitle")
            .foregroundStyle(.secondary)

        Image(systemName: "flame.fill")
            .foregroundStyle(.orange.gradient)

        Text("Aurora")
            .foregroundStyle(LinearGradient(colors: [.pink, .indigo],
                                            startPoint: .leading, endPoint: .trailing))
        """) { AnyView(C01_ForegroundStyleOneExample()) },

        ChildExampleEntry(parent: ".foregroundStyle()", child: "foregroundStyle(_:_:)", code: """
        Image(systemName: "person.crop.circle.badge.checkmark")
            .symbolRenderingMode(.palette)
            .foregroundStyle(.primary, .green)
        """) { AnyView(C01_ForegroundStyleTwoExample()) },

        ChildExampleEntry(parent: ".foregroundStyle()", child: "foregroundStyle(_:_:_:)", code: """
        Image(systemName: "cloud.sun.rain.fill")
            .symbolRenderingMode(.palette)
            .foregroundStyle(.gray, .yellow, .blue)
        """) { AnyView(C01_ForegroundStyleThreeExample()) },

        // MARK: .frame()

        ChildExampleEntry(parent: ".frame()", child: "frame(width:height:alignment:)", code: """
        Image(systemName: "photo")
            .frame(width: 44, height: 44)

        Image(systemName: "photo")
            .frame(width: 80, height: 44, alignment: .topLeading)

        Divider()
            .frame(height: 44)                     // width left flexible
        """) { AnyView(C01_FrameFixedExample()) },

        ChildExampleEntry(parent: ".frame()", child: "frame(minWidth:idealWidth:maxWidth:minHeight:idealHeight:maxHeight:alignment:)", code: """
        TextEditor(text: $notes)
            .frame(minHeight: 60, maxHeight: 110)

        Text("Chip")
            .frame(minWidth: 120, maxWidth: 200, alignment: .leading)
            .background(.quaternary)
        """) { AnyView(C01_FrameFlexibleExample()) },

        ChildExampleEntry(parent: ".frame()", child: "frame(maxWidth: .infinity) idiom", code: """
        Text("Left-aligned in a full-width row")
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.quinary)

        Button("Continue") { }
            .frame(maxWidth: .infinity)            // full-width control
        """) { AnyView(C01_FrameMaxWidthIdiomExample()) },

        // MARK: .fullScreenCover()

        ChildExampleEntry(parent: ".fullScreenCover()", child: "fullScreenCover(isPresented:onDismiss:content:)", code: """
        Button("Start") { showOnboarding = true }
            .fullScreenCover(isPresented: $showOnboarding, onDismiss: markOnboarded) {
                OnboardingFlow()
            }
        """) { AnyView(C01_FullScreenCoverBoolExample()) },

        ChildExampleEntry(parent: ".fullScreenCover()", child: "fullScreenCover(item:onDismiss:content:)", code: """
        videoButtons
            .fullScreenCover(item: $activeVideo) { video in
                PlayerView(video)                  // shown while activeVideo != nil
            }
        """) { AnyView(C01_FullScreenCoverItemExample()) },

        // MARK: .gesture()

        ChildExampleEntry(parent: ".gesture()", child: "gesture(_:including:)", code: """
        MapCanvas()                                // contains a tappable label
            .gesture(
                LongPressGesture(minimumDuration: 0.4)
                    .onEnded { _ in dropPin() },
                including: mask                    // .all or .gesture
            )
        """) { AnyView(C01_GestureIncludingExample()) },

        ChildExampleEntry(parent: ".gesture()", child: "simultaneousGesture(_:including:)", code: """
        ScrollView(.horizontal) { gallery }        // tiles have their own tap gestures
            .simultaneousGesture(
                TapGesture().onEnded { logImpression() },
                including: .all
            )
        """) { AnyView(C01_SimultaneousGestureExample()) },

        ChildExampleEntry(parent: ".gesture()", child: "highPriorityGesture(_:including:)", code: """
        CardStack()                                // cards carry their own DragGesture
            .highPriorityGesture(
                DragGesture(minimumDistance: 20)
                    .onEnded { swipe($0.translation) },
                including: .all
            )
        """) { AnyView(C01_HighPriorityGestureExample()) },

        // MARK: .glassEffect()

        ChildExampleEntry(parent: ".glassEffect()", child: "glassEffect()", code: """
        Text("Paused")
            .padding(.horizontal)
            .padding(.vertical, 8)
            .glassEffect()                         // regular glass in a capsule
        """) { AnyView(C01_GlassEffectDefaultExample()) },

        ChildExampleEntry(parent: ".glassEffect()", child: "glassEffect(_:in:)", code: """
        Image(systemName: "mic.fill")
            .frame(width: 52, height: 52)
            .glassEffect(.regular.tint(.red).interactive(), in: .circle)

        Text("Clear")
            .padding()
            .glassEffect(.clear, in: .rect(cornerRadius: 12))
        """) { AnyView(C01_GlassEffectShapeExample()) },

        ChildExampleEntry(parent: ".glassEffect()", child: "glassEffectID(_:in:)", code: """
        @Namespace private var glassSpace

        GlassEffectContainer(spacing: 20) {
            HStack(spacing: 20) {
                ForEach(visibleTools) { tool in
                    ToolButton(tool)
                        .glassEffect()
                        .glassEffectID(tool.id, in: glassSpace)
                }
            }
        }
        """) { AnyView(C01_GlassEffectIDExample()) },

        // MARK: .ignoresSafeArea()

        ChildExampleEntry(parent: ".ignoresSafeArea()", child: "ignoresSafeArea(_:edges:)", code: """
        ZStack {
            Color.indigo
                .ignoresSafeArea(.container, edges: .vertical)
            Text("Content")
        }
        .safeAreaInset(edge: .top) { StatusBar() }
        .safeAreaInset(edge: .bottom) { HomeIndicator() }
        """) { AnyView(C01_IgnoresSafeAreaExample()) },

        ChildExampleEntry(parent: ".ignoresSafeArea()", child: "SafeAreaRegions", code: """
        VStack {
            Spacer()
            ComposerBar()
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)   // .container · .keyboard · .all
        """) { AnyView(C01_SafeAreaRegionsExample()) },

        // MARK: .keyboardShortcut()

        ChildExampleEntry(parent: ".keyboardShortcut()", child: "keyboardShortcut(_:modifiers:)", code: """
        Button("Find", systemImage: "magnifyingglass") { finds += 1 }
            .keyboardShortcut("f", modifiers: [.command, .shift])

        Button("Save") { saves += 1 }
            .keyboardShortcut("s")                 // modifiers default to .command
        """) { AnyView(C01_KeyboardShortcutModifiersExample()) },

        ChildExampleEntry(parent: ".keyboardShortcut()", child: "keyboardShortcut(_:)", code: """
        HStack {
            Button("Cancel") { lastKey = "Cancel (Esc)" }
                .keyboardShortcut(.cancelAction)
            Button("Create") { lastKey = "Create (Return)" }
                .keyboardShortcut(.defaultAction)
        }
        """) { AnyView(C01_KeyboardShortcutPrebuiltExample()) },

        ChildExampleEntry(parent: ".keyboardShortcut()", child: "keyboardShortcut(_:modifiers:localization:)", code: """
        Button("Indent") { level += 1 }
            .keyboardShortcut("]", modifiers: .command, localization: .withoutMirroring)
        Button("Outdent") { level -= 1 }
            .keyboardShortcut("[", modifiers: .command, localization: .withoutMirroring)
        """) { AnyView(C01_KeyboardShortcutLocalizationExample()) },

        // MARK: .lineLimit()

        ChildExampleEntry(parent: ".lineLimit()", child: "lineLimit(_ number: Int?)", code: """
        Text(article.teaser)
            .lineLimit(limit)                      // nil · 1 · 2 · 3
        """) { AnyView(C01_LineLimitNumberExample()) },

        ChildExampleEntry(parent: ".lineLimit()", child: "lineLimit(_ limit: ClosedRange<Int>)", code: """
        TextField("Comment", text: $comment, axis: .vertical)
            .lineLimit(3...6)                      // reserves 3 lines, grows to 6
        """) { AnyView(C01_LineLimitRangeExample()) },

        ChildExampleEntry(parent: ".lineLimit()", child: "lineLimit(_:reservesSpace:)", code: """
        Text(item.summary)                         // one short line
            .lineLimit(3, reservesSpace: true)     // height stays at 3 lines

        Text(item.summary)
            .lineLimit(3, reservesSpace: false)
        """) { AnyView(C01_LineLimitReservesSpaceExample()) },

        // MARK: .listRowSeparator()

        ChildExampleEntry(parent: ".listRowSeparator()", child: "listRowSeparator(_:edges:)", code: """
        List {
            HeaderRow("Today")
                .listRowSeparator(.hidden, edges: .top)
            NoteRow("Standup notes")
            NoteRow("Plan the sprint")
                .listRowSeparator(hideLast ? .hidden : .visible, edges: .bottom)
        }
        """) { AnyView(C01_ListRowSeparatorExample()) },

        ChildExampleEntry(parent: ".listRowSeparator()", child: "listRowSeparatorTint(_:edges:)", code: """
        List(alerts) { alert in
            AlertRow(alert)
                .listRowSeparatorTint(alert.isCritical ? .red : nil, edges: .bottom)
        }
        """) { AnyView(C01_ListRowSeparatorTintExample()) },

        ChildExampleEntry(parent: ".listRowSeparator()", child: "listSectionSeparator(_:edges:)", code: """
        List {
            Section("Pinned") {
                ForEach(pinned, id: \\.self) { NoteRow($0) }
            }
            .listSectionSeparator(hidden ? .hidden : .visible, edges: .all)

            Section("Recent") {
                ForEach(recent, id: \\.self) { NoteRow($0) }
            }
        }
        """) { AnyView(C01_ListSectionSeparatorExample()) },

        // MARK: .navigationTitle()

        ChildExampleEntry(parent: ".navigationTitle()", child: "navigationTitle(_ titleKey: LocalizedStringKey)", code: """
        List(trips) { TripRow($0) }
            .navigationTitle("Trips")              // string literal → LocalizedStringKey
        """) { AnyView(C01_NavigationTitleKeyExample()) },

        ChildExampleEntry(parent: ".navigationTitle()", child: "navigationTitle(_ title: Binding<String>)", code: """
        DocumentEditor(document: $document)
            .navigationTitle($document.name)       // editable from the window title
        """) { AnyView(C01_NavigationTitleBindingExample()) },

        ChildExampleEntry(parent: ".navigationTitle()", child: "navigationSubtitle(_:)", code: """
        MailboxList(mailbox)
            .navigationTitle(mailbox.name)
            .navigationSubtitle("\\(mailbox.unreadCount) unread")
        """) { AnyView(C01_NavigationSubtitleExample()) },

        ChildExampleEntry(parent: ".navigationTitle()", child: "navigationBarTitleDisplayMode(_:)", code: """
        SettingsForm()
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(mode)   // .large / .inline / .automatic
        """) { AnyView(C01_NavigationBarTitleDisplayModeExample()) },

        // MARK: .navigationTransition()

        ChildExampleEntry(parent: ".navigationTransition()", child: "NavigationTransition.zoom(sourceID:in:)", code: """
        @Namespace private var zoom

        .navigationDestination(for: Album.self) { album in
            AlbumDetail(album)
                .navigationTransition(.zoom(sourceID: album.id, in: zoom))
        }
        """) { AnyView(C01_NavigationTransitionZoomExample()) },

        ChildExampleEntry(parent: ".navigationTransition()", child: "matchedTransitionSource(id:in:)", code: """
        NavigationLink(value: album) {
            AlbumCover(album)
                .matchedTransitionSource(id: album.id, in: zoom)
        }
        """) { AnyView(C01_MatchedTransitionSourceExample()) },

        ChildExampleEntry(parent: ".navigationTransition()", child: "matchedTransitionSource(id:in:configuration:)", code: """
        AlbumCover(album)
            .matchedTransitionSource(id: album.id, in: zoom) { source in
                source
                    .clipShape(.rect(cornerRadius: 12))
                    .shadow(radius: 8)
            }
        """) { AnyView(C01_MatchedTransitionSourceConfiguredExample()) },

        // MARK: .offset()

        ChildExampleEntry(parent: ".offset()", child: "offset(_:)", code: """
        Card()
            .offset(dragTranslation)               // CGSize straight from the drag
            .gesture(
                DragGesture()
                    .onChanged { dragTranslation = $0.translation }
                    .onEnded { _ in withAnimation(.bouncy) { dragTranslation = .zero } }
            )
        """) { AnyView(C01_OffsetSizeExample()) },

        ChildExampleEntry(parent: ".offset()", child: "offset(x:y:)", code: """
        Image(systemName: "arrow.down")
            .offset(y: isBouncing ? 6 : 0)         // x defaults to 0
            .animation(.easeInOut(duration: 0.4).repeatForever(), value: isBouncing)
            .onAppear { isBouncing = true }
        """) { AnyView(C01_OffsetXYExample()) },
    ]
}

// MARK: - Shared helpers

private struct C01_Caption: View {
    let text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(.secondary)
            .fixedSize(horizontal: false, vertical: true)
    }
}

/// A small iPhone-shaped frame for iOS-only illustrations.
private struct C01_PhoneFrame<Content: View>: View {
    private let content: Content
    init(@ViewBuilder content: () -> Content) { self.content = content() }

    var body: some View {
        content
            .frame(width: 124, height: 176)
            .background(.background)
            .clipShape(.rect(cornerRadius: 18))
            .overlay(RoundedRectangle(cornerRadius: 18).stroke(.secondary.opacity(0.5), lineWidth: 2))
    }
}

/// Mock macOS window chrome for scene-level illustrations.
private struct C01_WindowChrome<Content: View>: View {
    private let title: String
    private let subtitle: String?
    private let content: Content

    init(title: String, subtitle: String? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.subtitle = subtitle
        self.content = content()
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 6) {
                ForEach([Color.red, .yellow, .green], id: \.self) {
                    Circle().fill($0).frame(width: 9, height: 9)
                }
                Spacer()
                VStack(spacing: 1) {
                    Text(title).font(.caption.weight(.semibold))
                    if let subtitle {
                        Text(subtitle).font(.caption2).foregroundStyle(.secondary)
                    }
                }
                Spacer()
                Color.clear.frame(width: 39, height: 9)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(.bar)
            Divider()
            content
        }
        .frame(width: 250)
        .clipShape(.rect(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.secondary.opacity(0.4)))
    }
}

private struct C01_DashedBounds: ViewModifier {
    func body(content: Content) -> some View {
        content.overlay(
            Rectangle().stroke(.secondary, style: StrokeStyle(lineWidth: 1, dash: [3, 3]))
        )
    }
}

private extension View {
    /// Draws the view's layout bounds so offsets and backgrounds are legible.
    func c01Bounds() -> some View { modifier(C01_DashedBounds()) }
}

// MARK: - .alert() › alert(_:isPresented:actions:)

private struct C01_AlertBasicExample: View {
    @State private var confirmSignOut = false
    @State private var status = "Signed in"

    var body: some View {
        VStack(spacing: 12) {
            Label(status, systemImage: status == "Signed in"
                  ? "person.crop.circle.badge.checkmark" : "person.crop.circle.badge.xmark")
                .font(.title3)
            HStack {
                Button("Sign Out…") { confirmSignOut = true }
                    .alert("Sign out?", isPresented: $confirmSignOut) {
                        Button("Sign Out", role: .destructive) { signOut() }
                        Button("Stay", role: .cancel) { }
                    }
                Button("Sign In") { status = "Signed in" }
                    .disabled(status == "Signed in")
            }
            C01_Caption("Title and buttons only — no message closure in this overload.")
        }
    }

    private func signOut() { status = "Signed out" }
}

// MARK: - .alert() › alert(_:isPresented:presenting:actions:message:)

private struct C01_Tag: Identifiable {
    let id: Int
    let name: String
    let usageCount: Int
}

private struct C01_AlertPresentingExample: View {
    private static let allTags = [
        C01_Tag(id: 1, name: "Urgent", usageCount: 12),
        C01_Tag(id: 2, name: "Draft", usageCount: 3),
        C01_Tag(id: 3, name: "Archive", usageCount: 41),
    ]
    @State private var tags = C01_AlertPresentingExample.allTags
    @State private var pendingTag: C01_Tag?
    @State private var confirmRemove = false

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                ForEach(tags) { tag in
                    Button {
                        pendingTag = tag
                        confirmRemove = true
                    } label: {
                        Label(tag.name, systemImage: "xmark.circle.fill")
                    }
                    .buttonStyle(.bordered)
                }
                if tags.isEmpty {
                    Button("Reset tags") { tags = Self.allTags }
                }
            }
            .alert("Remove tag?", isPresented: $confirmRemove, presenting: pendingTag) { tag in
                Button("Remove \(tag.name)", role: .destructive) { remove(tag) }
                Button("Keep", role: .cancel) { }
            } message: { tag in
                Text("\(tag.usageCount) items will lose this tag.")
            }
            C01_Caption("Click a tag — presenting: hands it to both the buttons and the message.")
        }
    }

    private func remove(_ tag: C01_Tag) { tags.removeAll { $0.id == tag.id } }
}

// MARK: - .alert() › alert(isPresented:error:actions:message:)

private struct C01_UploadError: LocalizedError {
    var errorDescription: String? { "Upload failed" }
    var recoverySuggestion: String? { "Check your connection, then retry." }
}

private struct C01_AlertErrorExample: View {
    @State private var showError = false
    @State private var uploadError: C01_UploadError? = C01_UploadError()
    @State private var attempts = 0

    var body: some View {
        VStack(spacing: 12) {
            Button("Upload", systemImage: "icloud.and.arrow.up") {
                attempts += 1
                showError = true
            }
            .alert(isPresented: $showError, error: uploadError) { _ in
                Button("Retry") { retryUpload() }
                Button("Cancel", role: .cancel) { }
            } message: { error in
                Text(error.recoverySuggestion ?? "")
            }
            Text("Attempts: \(attempts)")
                .font(.callout.monospacedDigit())
            C01_Caption("The alert title is the error's errorDescription; the message closure receives the typed error.")
        }
    }

    private func retryUpload() { attempts += 1 }
}

// MARK: - .animation() › animation(_:value:)

private struct C01_AnimationValueExample: View {
    @State private var isOn = false
    @State private var dimmed = false

    var body: some View {
        VStack(spacing: 14) {
            Capsule()
                .fill(isOn ? .green : .gray)
                .frame(width: isOn ? 160 : 80, height: 32)
                .opacity(dimmed ? 0.35 : 1)
                .animation(.easeInOut(duration: 0.25), value: isOn)
            HStack(spacing: 20) {
                Toggle("isOn (animated)", isOn: $isOn)
                Toggle("dimmed (instant)", isOn: $dimmed)
            }
            .toggleStyle(.switch)
            .controlSize(.small)
            C01_Caption("Only changes to `value` animate — the opacity toggle snaps.")
        }
    }
}

// MARK: - .animation() › animation(_:body:)

private struct C01_AnimationBodyExample: View {
    @State private var isFavorite = false

    var body: some View {
        VStack(spacing: 14) {
            Image(systemName: "star.fill")
                .font(.system(size: 40))
                .animation(.bouncy) { content in
                    content
                        .scaleEffect(isFavorite ? 1.3 : 1)
                        .opacity(isFavorite ? 1 : 0.6)
                }
                .foregroundStyle(isFavorite ? .yellow : .gray)
                .frame(height: 60)
            Button(isFavorite ? "Unfavorite" : "Favorite") { isFavorite.toggle() }
            C01_Caption("Scale and opacity bounce; the color outside the body changes instantly.")
        }
    }
}

// MARK: - .animation() › Animation.spring(duration:bounce:blendDuration:)

private struct C01_SpringDurationBounceExample: View {
    @State private var isExpanded = false
    @State private var bounce = 0.3

    var body: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 12)
                .fill(.blue.gradient)
                .frame(width: isExpanded ? 240 : 90, height: 40)
            HStack(spacing: 12) {
                Button(isExpanded ? "Collapse" : "Expand") {
                    withAnimation(.spring(duration: 0.5, bounce: bounce, blendDuration: 0)) {
                        isExpanded.toggle()
                    }
                }
                Slider(value: $bounce, in: 0...0.8)
                    .frame(width: 120)
                Text("bounce \(bounce, format: .number.precision(.fractionLength(2)))")
                    .font(.caption.monospacedDigit())
            }
            C01_Caption("duration is perceptual; bounce 0 is critically damped, higher overshoots.")
        }
    }
}

// MARK: - .animation() › Animation.repeatForever(autoreverses:)

private struct C01_RepeatForeverExample: View {
    @State private var isPulsing = false

    var body: some View {
        HStack(spacing: 48) {
            VStack(spacing: 14) {
                Circle()
                    .fill(.pink)
                    .frame(width: 36, height: 36)
                    .scaleEffect(isPulsing ? 1.4 : 1)
                    .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: isPulsing)
                    .frame(height: 56)
                Text("autoreverses: true").font(.caption.monospaced())
            }
            VStack(spacing: 14) {
                Circle()
                    .fill(.teal)
                    .frame(width: 36, height: 36)
                    .scaleEffect(isPulsing ? 1.4 : 1)
                    .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: false), value: isPulsing)
                    .frame(height: 56)
                Text("autoreverses: false").font(.caption.monospaced())
            }
        }
        .onAppear { isPulsing = true }
    }
}

// MARK: - .aspectRatio() › aspectRatio(_:contentMode:)

private struct C01_AspectRatioExample: View {
    private var poster: some View {
        LinearGradient(colors: [.orange, .pink, .purple], startPoint: .leading, endPoint: .trailing)
            .overlay(Image(systemName: "film").font(.title).foregroundStyle(.white))
    }

    var body: some View {
        HStack(spacing: 28) {
            VStack(spacing: 6) {
                poster
                    .aspectRatio(16 / 9, contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .c01Bounds()
                Text(".fit").font(.caption.monospaced())
            }
            VStack(spacing: 6) {
                poster
                    .aspectRatio(16 / 9, contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipped()
                    .c01Bounds()
                Text(".fill + .clipped()").font(.caption.monospaced())
            }
        }
    }
}

// MARK: - .aspectRatio() › scaledToFit()

private struct C01_ScaledToFitExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 24) {
                Image(systemName: "swift")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 48)
                    .foregroundStyle(.orange)
                    .c01Bounds()
                Image(systemName: "swift")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 48)
                    .foregroundStyle(.orange)
                    .c01Bounds()
            }
            C01_Caption("Same ratio in both frames: the symbol sits entirely inside, leaving slack where needed.")
        }
    }
}

// MARK: - .aspectRatio() › scaledToFill()

private struct C01_ScaledToFillExample: View {
    var body: some View {
        HStack(spacing: 28) {
            VStack(spacing: 6) {
                Image(systemName: "sun.horizon.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(.circle)
                    .foregroundStyle(.orange)
                    .background(.yellow.opacity(0.2), in: .circle)
                Text(".scaledToFill()").font(.caption.monospaced())
            }
            VStack(spacing: 6) {
                Image(systemName: "sun.horizon.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(.circle)
                    .foregroundStyle(.orange)
                    .background(.yellow.opacity(0.2), in: .circle)
                Text(".scaledToFit()").font(.caption.monospaced())
            }
        }
    }
}

// MARK: - .background() › background(_:in:)

private struct C01_BackgroundInShapeExample: View {
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 20) {
                Text("NEW")
                    .font(.caption.bold())
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(.orange, in: .capsule)
                Text("v2.1")
                    .font(.caption.monospaced())
                    .foregroundStyle(.white)
                    .padding(6)
                    .background(.blue.gradient, in: .rect(cornerRadius: 6))
                Image(systemName: "star.fill")
                    .padding(10)
                    .background(.ultraThinMaterial, in: .circle)
            }
            .font(.title3)
            C01_Caption("Style + shape in one call; the shape sizes itself to the modified view.")
        }
    }
}

// MARK: - .background() › background(alignment:content:)

private enum C01_AlignmentChoice: String, CaseIterable, Identifiable {
    case topLeading, center, bottomTrailing
    var id: Self { self }
    var alignment: Alignment {
        switch self {
        case .topLeading: .topLeading
        case .center: .center
        case .bottomTrailing: .bottomTrailing
        }
    }
}

private struct C01_BackgroundAlignmentExample: View {
    @State private var choice: C01_AlignmentChoice = .bottomTrailing

    var body: some View {
        VStack(spacing: 14) {
            Text("Score: 42")
                .font(.title3)
                .background(alignment: choice.alignment) {
                    Image(systemName: "seal.fill")
                        .font(.system(size: 44))
                        .foregroundStyle(.yellow.opacity(0.7))
                }
                .c01Bounds()
                .frame(height: 60)
            Picker("alignment", selection: $choice) {
                ForEach(C01_AlignmentChoice.allCases) { Text(".\($0.rawValue)").tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            C01_Caption("The dashed box is the text's layout; the background is aligned within it and can overflow.")
        }
    }
}

// MARK: - .background() › background(_:ignoresSafeAreaEdges:)

private struct C01_BackgroundSafeAreaExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 28) {
                phone(edges: .bottom, caption: "ignoresSafeAreaEdges: .bottom")
                phone(edges: [], caption: "ignoresSafeAreaEdges: []")
            }
            C01_Caption("A safeAreaInset tab bar creates the safe area; the orange background extends under it only on the left.")
        }
    }

    private func phone(edges: Edge.Set, caption: String) -> some View {
        VStack(spacing: 6) {
            VStack {
                Text("Content").font(.caption).foregroundStyle(.white)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 10)
            .background(.orange.gradient, ignoresSafeAreaEdges: edges)
            .safeAreaInset(edge: .bottom, spacing: 0) {
                Label("Tab bar", systemImage: "square.grid.2x2")
                    .font(.caption2)
                    .frame(maxWidth: .infinity)
                    .frame(height: 26)
                    .background(.ultraThinMaterial)
            }
            .frame(width: 120, height: 110)
            .background(.quaternary)
            .clipShape(.rect(cornerRadius: 12))
            Text(caption).font(.caption2.monospaced())
        }
    }
}

// MARK: - .badge() › badge(_ count: Int)

private struct C01_BadgeCountExample: View {
    @State private var unreadCount = 4

    var body: some View {
        VStack(spacing: 8) {
            List {
                Label("Inbox", systemImage: "tray")
                    .badge(unreadCount)
                Label("Sent", systemImage: "paperplane")
                    .badge(0)
            }
            .frame(height: 76)
            Stepper("unreadCount: \(unreadCount)", value: $unreadCount, in: 0...20)
                .font(.callout.monospacedDigit())
            C01_Caption("Step down to 0 — the badge disappears on its own.")
        }
    }
}

// MARK: - .badge() › badge(_ label: Text?)

private struct C01_BadgeTextExample: View {
    @State private var showNew = true

    var body: some View {
        VStack(spacing: 8) {
            List {
                Label("Updates", systemImage: "arrow.down.circle")
                    .badge(Text("Beta").foregroundStyle(.orange))
                Label("Store", systemImage: "bag")
                    .badge(showNew ? Text("New").bold() : nil)
            }
            .frame(height: 76)
            Toggle("Second badge (nil clears it)", isOn: $showNew)
                .toggleStyle(.switch)
                .controlSize(.small)
        }
    }
}

// MARK: - .badge() › badgeProminence(_:)

private struct C01_BadgeProminenceExample: View {
    @State private var prominence: BadgeProminence = .standard

    var body: some View {
        VStack(spacing: 8) {
            List {
                Label("Drafts", systemImage: "doc").badge(3)
                Label("Sent", systemImage: "paperplane").badge(12)
            }
            .badgeProminence(prominence)
            .frame(height: 76)
            Picker("prominence", selection: $prominence) {
                Text(".increased").tag(BadgeProminence.increased)
                Text(".standard").tag(BadgeProminence.standard)
                Text(".decreased").tag(BadgeProminence.decreased)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
        }
    }
}

// MARK: - .clipShape() › clipShape(_:style:)

private struct C01_RingShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addEllipse(in: rect)
        path.addEllipse(in: rect.insetBy(dx: rect.width * 0.28, dy: rect.height * 0.28))
        return path
    }
}

private struct C01_ClipShapeStyleExample: View {
    private var map: some View {
        LinearGradient(colors: [.green, .teal, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
            .overlay(Image(systemName: "map").font(.title).foregroundStyle(.white.opacity(0.8)))
            .frame(width: 84, height: 84)
    }

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 24) {
                VStack(spacing: 6) {
                    map.clipShape(C01_RingShape(), style: FillStyle(eoFill: true))
                    Text("eoFill: true").font(.caption2.monospaced())
                }
                VStack(spacing: 6) {
                    map.clipShape(C01_RingShape(), style: FillStyle(eoFill: false))
                    Text("eoFill: false").font(.caption2.monospaced())
                }
                VStack(spacing: 6) {
                    map.clipShape(.circle, style: FillStyle(antialiased: false))
                    Text("antialiased: false").font(.caption2.monospaced())
                }
            }
            C01_Caption("Even-odd filling turns the overlapping ring path into a hole; antialiasing controls the edge.")
        }
    }
}

// MARK: - .clipShape() › clipped(antialiased:)

private struct C01_ClippedExample: View {
    private var banner: Image { Image(systemName: "mountain.2.fill") }

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 40) {
                VStack(spacing: 6) {
                    banner
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 60)
                        .foregroundStyle(.indigo.gradient)
                        .c01Bounds()
                    Text("no clip").font(.caption2.monospaced())
                }
                VStack(spacing: 6) {
                    banner
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 60)
                        .clipped(antialiased: true)
                        .foregroundStyle(.indigo.gradient)
                        .c01Bounds()
                    Text(".clipped(antialiased: true)").font(.caption2.monospaced())
                }
            }
            .padding(.vertical, 20)
            C01_Caption("The dashed box is the frame; only the clipped copy stays inside it.")
        }
    }
}

// MARK: - .clipShape() › .rect(topLeadingRadius:…)

private struct C01_UnevenRectExample: View {
    var body: some View {
        HStack(spacing: 24) {
            VStack(spacing: 6) {
                Color.accentColor
                    .frame(height: 70)
                    .clipShape(.rect(
                        topLeadingRadius: 20,
                        topTrailingRadius: 20
                    ))
                Text("topLeading + topTrailing: 20").font(.caption2.monospaced())
            }
            VStack(spacing: 6) {
                Color.teal
                    .frame(height: 70)
                    .clipShape(.rect(bottomTrailingRadius: 32, style: .continuous))
                Text("bottomTrailing: 32, .continuous").font(.caption2.monospaced())
            }
        }
    }
}

// MARK: - .confirmationDialog() › confirmationDialog(_:isPresented:titleVisibility:actions:)

private struct C01_ConfirmationDialogBasicExample: View {
    @State private var showSort = false
    @State private var titleVisible = true
    @State private var sort = "Name"

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 16) {
                Button("Sort by…") { showSort = true }
                    .confirmationDialog("Sort by", isPresented: $showSort,
                                        titleVisibility: titleVisible ? .visible : .hidden) {
                        Button("Name") { sort = "Name" }
                        Button("Date") { sort = "Date" }
                    }
                Toggle("titleVisibility: .visible", isOn: $titleVisible)
                    .toggleStyle(.switch)
                    .controlSize(.small)
            }
            Text("Sorted by \(sort)")
                .font(.callout)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - .confirmationDialog() › confirmationDialog(_:isPresented:titleVisibility:actions:message:)

private struct C01_ConfirmationDialogMessageExample: View {
    @State private var confirmDiscard = false
    @State private var draft = "Dear team, here is the plan for…"

    var body: some View {
        VStack(spacing: 10) {
            TextField("Draft", text: $draft)
                .textFieldStyle(.roundedBorder)
                .frame(width: 260)
            Button("Discard Draft…") { confirmDiscard = true }
                .disabled(draft.isEmpty)
                .confirmationDialog("Discard draft?", isPresented: $confirmDiscard,
                                    titleVisibility: .visible) {
                    Button("Discard", role: .destructive) { discard() }
                } message: {
                    Text("Your unsent changes will be lost.")
                }
            C01_Caption("The message closure adds a line of explanation under the title.")
        }
    }

    private func discard() { draft = "" }
}

// MARK: - .confirmationDialog() › confirmationDialog(…presenting:actions:message:)

private struct C01_File: Identifiable, Hashable {
    let id: Int
    let name: String
    let sizeDescription: String
}

private struct C01_ConfirmationDialogPresentingExample: View {
    private static let allFiles = [
        C01_File(id: 1, name: "Render.mov", sizeDescription: "1.2 GB"),
        C01_File(id: 2, name: "Notes.md", sizeDescription: "4 KB"),
        C01_File(id: 3, name: "Backup.zip", sizeDescription: "310 MB"),
    ]
    @State private var files = C01_ConfirmationDialogPresentingExample.allFiles
    @State private var target: C01_File?
    @State private var confirmDelete = false

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                ForEach(files) { file in
                    Button {
                        target = file
                        confirmDelete = true
                    } label: {
                        Label(file.name, systemImage: "trash")
                    }
                }
                if files.isEmpty {
                    Button("Restore files") { files = Self.allFiles }
                }
            }
            .confirmationDialog("Delete?", isPresented: $confirmDelete,
                                titleVisibility: .visible, presenting: target) { file in
                Button("Delete \(file.name)", role: .destructive) { delete(file) }
            } message: { file in
                Text("\(file.sizeDescription) will be freed.")
            }
            C01_Caption("Each button hands its file in via presenting:, so the dialog names it.")
        }
    }

    private func delete(_ file: C01_File) { files.removeAll { $0.id == file.id } }
}

// MARK: - .containerRelativeFrame() › containerRelativeFrame(_:alignment:)

private struct C01_Page: Identifiable {
    let id: Int
    let title: String
    let color: Color
}

private struct C01_ContainerRelativeFrameAxesExample: View {
    private let pages = [
        C01_Page(id: 1, title: "Welcome", color: .blue),
        C01_Page(id: 2, title: "Sync", color: .purple),
        C01_Page(id: 3, title: "Done", color: .green),
    ]

    var body: some View {
        VStack(spacing: 8) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(pages) { page in
                        Rectangle()
                            .fill(page.color.gradient)
                            .overlay(Text(page.title).font(.headline).foregroundStyle(.white))
                            .containerRelativeFrame(.horizontal)
                    }
                }
            }
            .scrollTargetBehavior(.paging)
            .frame(height: 90)
            .clipShape(.rect(cornerRadius: 10))
            C01_Caption("Each page is exactly one container width — scroll to page through.")
        }
    }
}

// MARK: - .containerRelativeFrame() › containerRelativeFrame(_:count:span:spacing:alignment:)

private struct C01_ContainerRelativeFrameCountExample: View {
    @State private var count = 3
    private let colors: [Color] = [.red, .orange, .yellow, .green, .teal, .blue, .indigo]

    var body: some View {
        VStack(spacing: 8) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 12) {
                    ForEach(Array(colors.enumerated()), id: \.offset) { index, color in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(color.gradient)
                            .overlay(Text("\(index + 1)").font(.headline).foregroundStyle(.white))
                            .containerRelativeFrame(.horizontal, count: count, span: 1, spacing: 12)
                    }
                }
            }
            .frame(height: 70)
            Stepper("count: \(count) (span: 1, spacing: 12)", value: $count, in: 2...5)
                .font(.callout.monospacedDigit())
        }
    }
}

// MARK: - .containerRelativeFrame() › containerRelativeFrame(_:alignment:_:)

private struct C01_ContainerRelativeFrameClosureExample: View {
    var body: some View {
        VStack(spacing: 8) {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    LinearGradient(colors: [.mint, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .overlay(Text("Hero").font(.headline).foregroundStyle(.white))
                        .containerRelativeFrame([.horizontal, .vertical]) { length, axis in
                            axis == .vertical ? length * 0.4 : length
                        }
                    Text("Body copy scrolls beneath the hero, which stays 40% of the container's height and its full width.")
                        .font(.caption)
                        .padding(.horizontal, 8)
                }
            }
            .frame(height: 140)
            .background(.quaternary.opacity(0.4), in: .rect(cornerRadius: 10))
            C01_Caption("The closure gets the container length and the axis being sized.")
        }
    }
}

// MARK: - .contentTransition() › ContentTransition.numericText(countsDown:)

private struct C01_NumericTextCountsDownExample: View {
    @State private var remaining = 10
    @State private var countsDown = true

    var body: some View {
        VStack(spacing: 10) {
            Text("\(remaining)")
                .font(.largeTitle.monospacedDigit())
                .contentTransition(.numericText(countsDown: countsDown))
                .animation(.default, value: remaining)
            HStack(spacing: 14) {
                Button("Tick") { remaining = max(0, remaining - 1) }
                Button("Reset") { remaining = 10 }
                Toggle("countsDown", isOn: $countsDown)
                    .toggleStyle(.switch)
                    .controlSize(.small)
            }
            C01_Caption("countsDown flips the roll direction of the digits.")
        }
    }
}

// MARK: - .contentTransition() › ContentTransition.numericText(value:)

private struct C01_NumericTextValueExample: View {
    @State private var total = 120.0

    var body: some View {
        VStack(spacing: 10) {
            Text(total, format: .number)
                .font(.largeTitle.monospacedDigit())
                .contentTransition(.numericText(value: total))
                .animation(.snappy, value: total)
            HStack(spacing: 14) {
                Button("−10") { total -= 10 }
                Button("+10") { total += 10 }
            }
            C01_Caption("No direction flag — it compares old and new values to pick the roll.")
        }
    }
}

// MARK: - .contentTransition() › ContentTransition.symbolEffect(_:options:)

private struct C01_SymbolEffectTransitionExample: View {
    @State private var isPlaying = false

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 40) {
                Button { isPlaying.toggle() } label: {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 34))
                        .contentTransition(.symbolEffect(.replace.downUp))
                        .frame(width: 44, height: 44)
                }
                .buttonStyle(.plain)
                Image(systemName: isPlaying ? "speaker.wave.3.fill" : "speaker.slash.fill")
                    .font(.system(size: 34))
                    .contentTransition(.symbolEffect(.replace.offUp, options: .speed(0.4)))
                    .frame(width: 44, height: 44)
            }
            C01_Caption("Click play — the symbol swap plays a replace effect instead of a crossfade.")
        }
    }
}

// MARK: - .contentTransition() › ContentTransition.interpolate

private struct C01_InterpolateTransitionExample: View {
    @State private var isLarge = false

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 40) {
                VStack(spacing: 6) {
                    Text("Interpolate")
                        .font(isLarge ? .largeTitle : .body)
                        .fontWeight(isLarge ? .black : .regular)
                        .contentTransition(.interpolate)
                        .animation(.easeInOut(duration: 0.6), value: isLarge)
                        .frame(height: 50)
                    Text(".interpolate").font(.caption2.monospaced())
                }
                VStack(spacing: 6) {
                    Text("Interpolate")
                        .font(isLarge ? .largeTitle : .body)
                        .fontWeight(isLarge ? .black : .regular)
                        .contentTransition(.opacity)
                        .animation(.easeInOut(duration: 0.6), value: isLarge)
                        .frame(height: 50)
                    Text(".opacity").font(.caption2.monospaced())
                }
            }
            Button(isLarge ? "Shrink" : "Grow") { isLarge.toggle() }
        }
    }
}

// MARK: - .contextMenu() › contextMenu(menuItems:)

private struct C01_ContextMenuExample: View {
    @State private var pinned = false
    @State private var deleted = false

    var body: some View {
        VStack(spacing: 10) {
            if deleted {
                Button("Restore note") { deleted = false }
            } else {
                HStack {
                    Label("Meeting notes", systemImage: pinned ? "pin.fill" : "note.text")
                    Spacer()
                    Text("Right-click").font(.caption).foregroundStyle(.tertiary)
                }
                .padding(10)
                .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 8))
                .contextMenu {
                    Button(pinned ? "Unpin" : "Pin", systemImage: "pin") { pinned.toggle() }
                    Divider()
                    Button("Delete", systemImage: "trash", role: .destructive) { deleted = true }
                }
            }
            C01_Caption("Buttons, Dividers, Toggles and nested Menus go in the builder.")
        }
        .frame(width: 280)
    }
}

// MARK: - .contextMenu() › contextMenu(menuItems:preview:)

private struct C01_ContextMenuPreviewExample: View {
    @State private var shares = 0

    private var photo: some View {
        LinearGradient(colors: [.pink, .orange], startPoint: .top, endPoint: .bottom)
            .overlay(Image(systemName: "photo").font(.title).foregroundStyle(.white))
    }

    var body: some View {
        VStack(spacing: 10) {
            photo
                .frame(width: 80, height: 80)
                .clipShape(.rect(cornerRadius: 10))
                .contextMenu {
                    Button("Share", systemImage: "square.and.arrow.up") { shares += 1 }
                } preview: {
                    photo.frame(width: 220, height: 150)
                }
            Text("Shared \(shares)×").font(.callout.monospacedDigit())
            C01_Caption("Right-click for the menu. The preview view is shown on iOS and iPadOS; macOS shows the menu only.")
        }
    }
}

// MARK: - .contextMenu() › contextMenu(forSelectionType:menu:primaryAction:)

private struct C01_ContextMenuSelectionExample: View {
    private let files = [
        C01_File(id: 1, name: "Proposal.pages", sizeDescription: "2 MB"),
        C01_File(id: 2, name: "Budget.numbers", sizeDescription: "300 KB"),
        C01_File(id: 3, name: "Deck.key", sizeDescription: "48 MB"),
    ]
    @State private var selection: Set<Int> = [1]
    @State private var lastAction = "none"

    var body: some View {
        VStack(spacing: 8) {
            List(files, selection: $selection) { file in
                Label(file.name, systemImage: "doc")
            }
            .contextMenu(forSelectionType: C01_File.ID.self) { ids in
                Button("Reveal in Finder") { lastAction = "Reveal \(ids.count) item(s)" }
            } primaryAction: { ids in
                lastAction = "Open \(ids.count) item(s)"
            }
            .frame(height: 96)
            Text("Last action: \(lastAction)")
                .font(.callout)
                .foregroundStyle(.secondary)
            C01_Caption("Right-click rows for the menu; double-click runs primaryAction.")
        }
    }
}

// MARK: - .draggable() › draggable(_:)

private struct C01_DraggableExample: View {
    private let title = "SwiftUI Documentation"
    private let url = URL(string: "https://developer.apple.com/documentation/swiftui")
        ?? URL(filePath: "/")
    @State private var dropped: URL?
    @State private var targeted = false

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 24) {
                Label(title, systemImage: "link")
                    .padding(8)
                    .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 8))
                    .draggable(url)
                Image(systemName: "arrow.right").foregroundStyle(.secondary)
                Text(dropped?.host() ?? "Drop here")
                    .font(.caption)
                    .frame(width: 130, height: 40)
                    .background(targeted ? .blue.opacity(0.2) : .clear)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(.secondary, style: StrokeStyle(lineWidth: 1, dash: [4, 3])))
                    .dropDestination(for: URL.self) { urls, _ in
                        dropped = urls.first
                        return true
                    } isTargeted: { targeted = $0 }
            }
            C01_Caption("Drag the link — the view itself is the drag preview; the payload is the URL.")
        }
    }
}

// MARK: - .draggable() › draggable(_:preview:)

private struct C01_DraggablePreviewExample: View {
    private let contactName = "Maya Chen"
    @State private var dropped = "Drop here"
    @State private var targeted = false

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 24) {
                HStack {
                    Circle().fill(.purple.gradient).frame(width: 26, height: 26)
                        .overlay(Text("M").font(.caption.bold()).foregroundStyle(.white))
                    VStack(alignment: .leading) {
                        Text(contactName).font(.callout)
                        Text("Designer").font(.caption2).foregroundStyle(.secondary)
                    }
                }
                .padding(8)
                .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 8))
                .draggable(contactName) {
                    Label(contactName, systemImage: "person.crop.circle")
                        .padding(8)
                        .background(.regularMaterial, in: .capsule)
                }
                Image(systemName: "arrow.right").foregroundStyle(.secondary)
                Text(dropped)
                    .font(.caption)
                    .frame(width: 110, height: 40)
                    .background(targeted ? .purple.opacity(0.2) : .clear)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(.secondary, style: StrokeStyle(lineWidth: 1, dash: [4, 3])))
                    .dropDestination(for: String.self) { names, _ in
                        dropped = names.first ?? dropped
                        return true
                    } isTargeted: { targeted = $0 }
            }
            C01_Caption("Drag the row — the lifted image is the capsule label, not the row.")
        }
    }
}

// MARK: - .fixedSize() › fixedSize()

private struct C01_FixedSizeExample: View {
    @State private var taps = 0

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 60) {
                VStack(spacing: 6) {
                    Button("Continue with Apple") { taps += 1 }
                        .frame(width: 90)
                        .c01Bounds()
                    Text("squeezed").font(.caption2.monospaced())
                }
                VStack(spacing: 6) {
                    Button("Continue with Apple") { taps += 1 }
                        .fixedSize()
                        .frame(width: 90)
                        .c01Bounds()
                    Text(".fixedSize()").font(.caption2.monospaced())
                }
            }
            .padding(.vertical, 6)
            C01_Caption("Both frames are 90 pt wide; the fixed-size button keeps its ideal width and overflows.")
        }
    }
}

// MARK: - .fixedSize() › fixedSize(horizontal:vertical:)

private struct C01_FixedSizeAxesExample: View {
    private let longDescription = "Ideal height wins on the vertical axis, so the text wraps onto as many lines as it needs."

    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .top, spacing: 40) {
                VStack(spacing: 6) {
                    Text(longDescription)
                        .font(.caption)
                        .frame(width: 200, height: 34)
                        .c01Bounds()
                    Text("plain").font(.caption2.monospaced())
                }
                .frame(height: 80, alignment: .top)
                VStack(spacing: 6) {
                    Text(longDescription)
                        .font(.caption)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(width: 200, height: 34, alignment: .top)
                        .c01Bounds()
                    Text("vertical: true").font(.caption2.monospaced())
                }
                .frame(height: 80, alignment: .top)
            }
            C01_Caption("Same 34 pt frame: the left truncates, the right wraps past it.")
        }
    }
}

// MARK: - .focused() › focused(_:)

private struct C01_FocusedBoolExample: View {
    @FocusState private var isSearchFocused: Bool
    @State private var query = ""

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                TextField("Search", text: $query)
                    .textFieldStyle(.roundedBorder)
                    .focused($isSearchFocused)
                    .frame(width: 200)
                Button("Focus Search") { isSearchFocused = true }
                Button("Blur") { isSearchFocused = false }
            }
            Text("isSearchFocused: \(isSearchFocused ? "true" : "false")")
                .font(.callout.monospaced())
                .foregroundStyle(isSearchFocused ? .green : .secondary)
            C01_Caption("A Bool binding: true only while this one field owns focus; setting it moves focus.")
        }
    }
}

// MARK: - .focused() › focused(_:equals:)

private enum C01_Field: Hashable { case username, password }

private struct C01_FocusedEqualsExample: View {
    @FocusState private var field: C01_Field?
    @State private var username = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 6) {
                TextField("Username", text: $username)
                    .focused($field, equals: .username)
                    .onSubmit { field = .password }
                SecureField("Password", text: $password)
                    .focused($field, equals: .password)
                    .onSubmit { field = nil }
            }
            .textFieldStyle(.roundedBorder)
            .frame(width: 220)
            HStack {
                Button("Username") { field = .username }
                Button("Password") { field = .password }
                Button("None") { field = nil }
            }
            .controlSize(.small)
            Text("field: \(field.map { ".\($0)" } ?? "nil")")
                .font(.callout.monospaced())
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - .font() › font(_:)

private struct C01_FontExample: View {
    var body: some View {
        HStack(spacing: 40) {
            VStack(spacing: 6) {
                Text("Section")
                    .font(.headline)
                    .frame(height: 56)
                Text(".headline").font(.caption2.monospaced())
            }
            VStack(spacing: 6) {
                Text("42")
                    .font(.system(size: 48, weight: .bold))
                    .frame(height: 56)
                Text(".system(size: 48, weight: .bold)").font(.caption2.monospaced())
            }
            VStack(spacing: 6) {
                Text("Note")
                    .font(.caption)
                    .frame(height: 56)
                Text(".caption").font(.caption2.monospaced())
            }
        }
    }
}

// MARK: - .font() › fontWeight(_:)

private struct C01_FontWeightExample: View {
    @State private var index = 6
    private let weights: [(String, Font.Weight)] = [
        ("ultraLight", .ultraLight), ("thin", .thin), ("light", .light), ("regular", .regular),
        ("medium", .medium), ("semibold", .semibold), ("bold", .bold), ("heavy", .heavy), ("black", .black),
    ]

    var body: some View {
        VStack(spacing: 10) {
            Text("Emphasis without a new font")
                .font(.title3)
                .fontWeight(.semibold)
            Text("Emphasis without a new font")
                .font(.title3)
                .fontWeight(weights[index].1)
            HStack {
                Slider(value: Binding(get: { Double(index) }, set: { index = Int($0.rounded()) }),
                       in: 0...Double(weights.count - 1), step: 1)
                    .frame(width: 180)
                Text(".\(weights[index].0)").font(.caption.monospaced())
            }
        }
    }
}

// MARK: - .font() › fontDesign(_:)

private enum C01_DesignChoice: String, CaseIterable, Identifiable {
    case `default`, rounded, serif, monospaced
    var id: Self { self }
    var design: Font.Design {
        switch self {
        case .default: .default
        case .rounded: .rounded
        case .serif: .serif
        case .monospaced: .monospaced
        }
    }
}

private struct C01_FontDesignExample: View {
    @State private var choice: C01_DesignChoice = .rounded

    var body: some View {
        VStack(spacing: 12) {
            VStack(spacing: 4) {
                Text("Friendly title").font(.title2)
                Text("And its caption 0123").foregroundStyle(.secondary)
            }
            .fontDesign(choice.design)
            .frame(height: 56)
            Picker("design", selection: $choice) {
                ForEach(C01_DesignChoice.allCases) { Text(".\($0.rawValue)").tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            C01_Caption("One call restyles the whole hierarchy while keeping each view's size and weight.")
        }
    }
}

// MARK: - .foregroundStyle() › foregroundStyle(_:)

private struct C01_ForegroundStyleOneExample: View {
    var body: some View {
        HStack(spacing: 36) {
            VStack(spacing: 6) {
                Text("Subtitle")
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .frame(height: 44)
                Text(".secondary").font(.caption2.monospaced())
            }
            VStack(spacing: 6) {
                Image(systemName: "flame.fill")
                    .font(.system(size: 36))
                    .foregroundStyle(.orange.gradient)
                    .frame(height: 44)
                Text(".orange.gradient").font(.caption2.monospaced())
            }
            VStack(spacing: 6) {
                Text("Aurora")
                    .font(.title.bold())
                    .foregroundStyle(LinearGradient(colors: [.pink, .indigo],
                                                    startPoint: .leading, endPoint: .trailing))
                    .frame(height: 44)
                Text("LinearGradient").font(.caption2.monospaced())
            }
        }
    }
}

// MARK: - .foregroundStyle() › foregroundStyle(_:_:)

private struct C01_ForegroundStyleTwoExample: View {
    var body: some View {
        HStack(spacing: 36) {
            VStack(spacing: 6) {
                Image(systemName: "person.crop.circle.badge.checkmark")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.primary, .green)
                    .font(.system(size: 44))
                Text("(.primary, .green)").font(.caption2.monospaced())
            }
            VStack(spacing: 6) {
                Image(systemName: "bell.badge.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.red, .secondary)
                    .font(.system(size: 44))
                Text("(.red, .secondary)").font(.caption2.monospaced())
            }
            C01_Caption("Palette rendering maps the first style to the symbol's primary layer and the second to its badge.")
                .frame(width: 150)
        }
    }
}

// MARK: - .foregroundStyle() › foregroundStyle(_:_:_:)

private struct C01_ForegroundStyleThreeExample: View {
    var body: some View {
        HStack(spacing: 36) {
            VStack(spacing: 6) {
                Image(systemName: "cloud.sun.rain.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.gray, .yellow, .blue)
                    .font(.system(size: 44))
                Text("(.gray, .yellow, .blue)").font(.caption2.monospaced())
            }
            VStack(spacing: 6) {
                Image(systemName: "cloud.sun.rain.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.blue, .orange, .cyan)
                    .font(.system(size: 44))
                Text("(.blue, .orange, .cyan)").font(.caption2.monospaced())
            }
            C01_Caption("Three layers: cloud, sun, rain — each takes one of the three styles in order.")
                .frame(width: 150)
        }
    }
}

// MARK: - .frame() › frame(width:height:alignment:)

private struct C01_FrameFixedExample: View {
    var body: some View {
        HStack(spacing: 36) {
            VStack(spacing: 6) {
                Image(systemName: "photo")
                    .frame(width: 44, height: 44)
                    .c01Bounds()
                Text("44 × 44").font(.caption2.monospaced())
            }
            VStack(spacing: 6) {
                Image(systemName: "photo")
                    .frame(width: 80, height: 44, alignment: .topLeading)
                    .c01Bounds()
                Text("80 × 44, .topLeading").font(.caption2.monospaced())
            }
            VStack(spacing: 6) {
                Divider()
                    .frame(height: 44)
                    .c01Bounds()
                Text("height: 44 only").font(.caption2.monospaced())
            }
        }
    }
}

// MARK: - .frame() › frame(minWidth:idealWidth:maxWidth:minHeight:idealHeight:maxHeight:alignment:)

private struct C01_FrameFlexibleExample: View {
    @State private var notes = "Resize the window: this editor clamps between 60 and 110 pt tall."

    var body: some View {
        VStack(spacing: 10) {
            TextEditor(text: $notes)
                .font(.callout)
                .frame(minHeight: 60, maxHeight: 110)
                .c01Bounds()
            Text("Chip")
                .frame(minWidth: 120, maxWidth: 200, alignment: .leading)
                .padding(.vertical, 4)
                .background(.quaternary)
                .c01Bounds()
            C01_Caption("Only the constraints you name are applied; the rest stay nil and negotiate normally.")
        }
    }
}

// MARK: - .frame() › frame(maxWidth: .infinity) idiom

private struct C01_FrameMaxWidthIdiomExample: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Left-aligned in a full-width row")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 4)
                .background(.quinary)
            Text("Trailing-aligned in a full-width row")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.vertical, 4)
                .background(.quinary)
            Button("Continue") { }
                .frame(maxWidth: .infinity)
                .c01Bounds()
            C01_Caption("Accept every point of width offered; alignment then places the content inside it.")
        }
    }
}

// MARK: - .fullScreenCover() › fullScreenCover(isPresented:onDismiss:content:)

private struct C01_FullScreenCoverBoolExample: View {
    @State private var showOnboarding = false
    @State private var onboardedCount = 0

    var body: some View {
        HStack(spacing: 24) {
            C01_PhoneFrame {
                ZStack {
                    VStack(spacing: 10) {
                        Text("Home").font(.caption.bold())
                        Button("Start") { withAnimation(.easeOut(duration: 0.3)) { showOnboarding = true } }
                            .controlSize(.small)
                    }
                    if showOnboarding {
                        VStack(spacing: 10) {
                            Image(systemName: "sparkles").font(.title)
                            Text("Onboarding").font(.caption.bold())
                            Button("Done") {
                                withAnimation(.easeIn(duration: 0.3)) { showOnboarding = false }
                                markOnboarded()
                            }
                            .controlSize(.small)
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.indigo.gradient)
                        .transition(.move(edge: .bottom))
                    }
                }
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("onDismiss ran \(onboardedCount)×").font(.callout.monospacedDigit())
                C01_Caption("Illustrative — fullScreenCover is iOS, tvOS and watchOS only. The cover slides over the whole screen; onDismiss runs after it goes away.")
            }
            .frame(width: 200)
        }
    }

    private func markOnboarded() { onboardedCount += 1 }
}

// MARK: - .fullScreenCover() › fullScreenCover(item:onDismiss:content:)

private struct C01_Video: Identifiable {
    let id: Int
    let title: String
    let color: Color
}

private struct C01_FullScreenCoverItemExample: View {
    private let videos = [
        C01_Video(id: 1, title: "Keynote", color: .blue),
        C01_Video(id: 2, title: "Session 10", color: .orange),
    ]
    @State private var activeVideo: C01_Video?

    var body: some View {
        HStack(spacing: 24) {
            C01_PhoneFrame {
                ZStack {
                    VStack(spacing: 8) {
                        Text("Videos").font(.caption.bold())
                        ForEach(videos) { video in
                            Button(video.title) {
                                withAnimation(.easeOut(duration: 0.3)) { activeVideo = video }
                            }
                            .controlSize(.small)
                        }
                    }
                    if let video = activeVideo {
                        VStack(spacing: 10) {
                            Image(systemName: "play.rectangle.fill").font(.title)
                            Text(video.title).font(.caption.bold())
                            Button("Close") { withAnimation(.easeIn(duration: 0.3)) { activeVideo = nil } }
                                .controlSize(.small)
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(video.color.gradient)
                        .transition(.move(edge: .bottom))
                    }
                }
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("activeVideo: \(activeVideo?.title ?? "nil")").font(.callout.monospaced())
                C01_Caption("Illustrative — iOS, tvOS and watchOS only. The cover is up while the Identifiable item is non-nil, and the content closure receives the unwrapped item.")
            }
            .frame(width: 200)
        }
    }
}

// MARK: - .gesture() › gesture(_:including:)

private enum C01_MaskChoice: String, CaseIterable, Identifiable {
    case all, gesture
    var id: Self { self }
    var mask: GestureMask { self == .all ? .all : .gesture }
}

private struct C01_GestureIncludingExample: View {
    @State private var pins = 0
    @State private var innerTaps = 0
    @State private var choice: C01_MaskChoice = .all

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(.green.opacity(0.18))
                VStack(spacing: 8) {
                    Label("Pins dropped: \(pins)", systemImage: "mappin.and.ellipse")
                        .font(.callout.monospacedDigit())
                    Text("Tap me: \(innerTaps)")
                        .font(.caption.monospacedDigit())
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(.yellow.opacity(0.5), in: .capsule)
                        .onTapGesture { innerTaps += 1 }
                }
            }
            .frame(height: 80)
            .gesture(
                LongPressGesture(minimumDuration: 0.4)
                    .onEnded { _ in dropPin() },
                including: choice.mask
            )
            Picker("including", selection: $choice) {
                ForEach(C01_MaskChoice.allCases) { Text("including: .\($0.rawValue)").tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            C01_Caption("Press and hold anywhere to drop a pin. With .gesture, the subview's tap gesture is masked out.")
        }
    }

    private func dropPin() { pins += 1 }
}

// MARK: - .gesture() › simultaneousGesture(_:including:)

private struct C01_SimultaneousGestureExample: View {
    @State private var impressions = 0
    @State private var lastTile = "none"
    private let colors: [Color] = [.red, .orange, .yellow, .green, .teal, .blue, .indigo, .purple]

    var body: some View {
        VStack(spacing: 8) {
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(Array(colors.enumerated()), id: \.offset) { index, color in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(color.gradient)
                            .frame(width: 70, height: 60)
                            .overlay(Text("\(index + 1)").foregroundStyle(.white).bold())
                            .onTapGesture { lastTile = "\(index + 1)" }
                    }
                }
                .padding(.horizontal, 4)
            }
            .simultaneousGesture(
                TapGesture().onEnded { logImpression() },
                including: .all
            )
            .frame(height: 70)
            Text("Impressions: \(impressions) · last tile tapped: \(lastTile)")
                .font(.callout.monospacedDigit())
                .foregroundStyle(.secondary)
            C01_Caption("Tapping a tile fires both the tile's own tap and the outer tap; scrolling still works.")
        }
    }

    private func logImpression() { impressions += 1 }
}

// MARK: - .gesture() › highPriorityGesture(_:including:)

private struct C01_HighPriorityGestureExample: View {
    @State private var outerSwipes = 0
    @State private var innerSwipes = 0
    @State private var direction = "—"

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 12).fill(.gray.opacity(0.25)).offset(x: 8, y: 6)
                RoundedRectangle(cornerRadius: 12)
                    .fill(.blue.gradient)
                    .overlay(
                        Text("Card — swipe me")
                            .foregroundStyle(.white)
                            .bold()
                    )
                    .gesture(
                        DragGesture(minimumDistance: 20)
                            .onEnded { _ in innerSwipes += 1 }
                    )
            }
            .frame(width: 220, height: 80)
            .highPriorityGesture(
                DragGesture(minimumDistance: 20)
                    .onEnded { swipe($0.translation) },
                including: .all
            )
            Text("Outer swipes: \(outerSwipes) (\(direction)) · card's own drag: \(innerSwipes)")
                .font(.callout.monospacedDigit())
                .foregroundStyle(.secondary)
            C01_Caption("The card has its own DragGesture, but the high-priority outer drag always wins.")
        }
    }

    private func swipe(_ translation: CGSize) {
        outerSwipes += 1
        direction = translation.width > 0 ? "right" : "left"
    }
}

// MARK: - .glassEffect() › glassEffect()

private struct C01_GlassBackdrop: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.purple, .orange, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing)
            Circle().fill(.white.opacity(0.35)).frame(width: 90).offset(x: -70, y: -20)
            Circle().fill(.black.opacity(0.25)).frame(width: 70).offset(x: 80, y: 25)
        }
    }
}

private struct C01_GlassEffectDefaultExample: View {
    var body: some View {
        ZStack {
            C01_GlassBackdrop()
            VStack(spacing: 12) {
                Text("Paused")
                    .font(.headline)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .glassEffect()
                Text("Regular glass, capsule shape — the defaults.")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.85))
            }
        }
        .frame(height: 140)
        .clipShape(.rect(cornerRadius: 12))
    }
}

// MARK: - .glassEffect() › glassEffect(_:in:)

private struct C01_GlassEffectShapeExample: View {
    @State private var taps = 0

    var body: some View {
        ZStack {
            C01_GlassBackdrop()
            HStack(spacing: 28) {
                Button { taps += 1 } label: {
                    Image(systemName: "mic.fill")
                        .font(.title2)
                        .frame(width: 52, height: 52)
                }
                .buttonStyle(.plain)
                .glassEffect(.regular.tint(.red).interactive(), in: .circle)
                Text("Clear")
                    .font(.headline)
                    .padding()
                    .glassEffect(.clear, in: .rect(cornerRadius: 12))
                VStack(alignment: .leading, spacing: 4) {
                    Text("Mic pressed \(taps)×").font(.caption.monospacedDigit())
                    Text(".regular.tint(.red).interactive() in .circle").font(.caption2.monospaced())
                    Text(".clear in .rect(cornerRadius: 12)").font(.caption2.monospaced())
                }
                .foregroundStyle(.white.opacity(0.9))
            }
        }
        .frame(height: 140)
        .clipShape(.rect(cornerRadius: 12))
    }
}

// MARK: - .glassEffect() › glassEffectID(_:in:)

private struct C01_Tool: Identifiable {
    let id: Int
    let symbol: String
}

private struct C01_GlassEffectIDExample: View {
    @Namespace private var glassSpace
    @State private var expanded = true
    private let tools = [
        C01_Tool(id: 1, symbol: "pencil"),
        C01_Tool(id: 2, symbol: "eraser"),
        C01_Tool(id: 3, symbol: "lasso"),
        C01_Tool(id: 4, symbol: "paintbrush"),
    ]

    private var visibleTools: [C01_Tool] { expanded ? tools : Array(tools.prefix(1)) }

    var body: some View {
        ZStack {
            C01_GlassBackdrop()
            VStack(spacing: 14) {
                GlassEffectContainer(spacing: 20) {
                    HStack(spacing: 20) {
                        ForEach(visibleTools) { tool in
                            Image(systemName: tool.symbol)
                                .font(.title3)
                                .frame(width: 44, height: 44)
                                .glassEffect()
                                .glassEffectID(tool.id, in: glassSpace)
                        }
                    }
                }
                Button(expanded ? "Collapse" : "Expand") {
                    withAnimation(.bouncy) { expanded.toggle() }
                }
                .buttonStyle(.glass)
                Text("Shapes with ids in the same namespace morph in and out of each other.")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.85))
            }
        }
        .frame(height: 170)
        .clipShape(.rect(cornerRadius: 12))
    }
}

// MARK: - .ignoresSafeArea() › ignoresSafeArea(_:edges:)

private struct C01_IgnoresSafeAreaExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 28) {
                phone(ignores: true, caption: ".ignoresSafeArea(.container, edges: .vertical)")
                phone(ignores: false, caption: "respects safe area")
            }
            C01_Caption("Top and bottom insets come from safeAreaInset; only the left color extends under them.")
        }
    }

    private func phone(ignores: Bool, caption: String) -> some View {
        VStack(spacing: 6) {
            ZStack {
                if ignores {
                    Color.indigo
                        .ignoresSafeArea(.container, edges: .vertical)
                } else {
                    Color.indigo
                }
                Text("Content").font(.caption).foregroundStyle(.white)
            }
            .safeAreaInset(edge: .top, spacing: 0) {
                Text("9:41")
                    .font(.caption2.bold())
                    .frame(maxWidth: .infinity)
                    .frame(height: 20)
                    .background(.ultraThinMaterial)
            }
            .safeAreaInset(edge: .bottom, spacing: 0) {
                Capsule()
                    .fill(.secondary)
                    .frame(width: 40, height: 4)
                    .frame(maxWidth: .infinity)
                    .frame(height: 18)
                    .background(.ultraThinMaterial)
            }
            .frame(width: 120, height: 120)
            .background(.quaternary)
            .clipShape(.rect(cornerRadius: 14))
            Text(caption).font(.caption2.monospaced())
        }
    }
}

// MARK: - .ignoresSafeArea() › SafeAreaRegions

private struct C01_SafeAreaRegionsExample: View {
    @State private var message = ""

    var body: some View {
        HStack(spacing: 24) {
            C01_PhoneFrame {
                VStack {
                    Spacer()
                    HStack(spacing: 6) {
                        TextField("Message", text: $message)
                            .textFieldStyle(.roundedBorder)
                            .font(.caption)
                        Image(systemName: "arrow.up.circle.fill").foregroundStyle(.blue)
                    }
                    .padding(6)
                    .background(.bar)
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
            }
            VStack(alignment: .leading, spacing: 6) {
                ForEach([(".container", "bars, notches, the home indicator"),
                         (".keyboard", "the software keyboard"),
                         (".all", "both (the default)")], id: \.0) { region, meaning in
                    HStack(alignment: .firstTextBaseline, spacing: 6) {
                        Text(region).font(.caption.monospaced()).frame(width: 74, alignment: .leading)
                        Text(meaning).font(.caption).foregroundStyle(.secondary)
                    }
                }
                C01_Caption("Illustrative — the composer ignores only the keyboard region, so it stays put when a keyboard rises on iOS.")
            }
            .frame(width: 230)
        }
    }
}

// MARK: - .keyboardShortcut() › keyboardShortcut(_:modifiers:)

private struct C01_KeyboardShortcutModifiersExample: View {
    @State private var finds = 0
    @State private var saves = 0

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 16) {
                Button("Find", systemImage: "magnifyingglass") { finds += 1 }
                    .keyboardShortcut("f", modifiers: [.command, .shift])
                Button("Save") { saves += 1 }
                    .keyboardShortcut("s")
            }
            Text("⇧⌘F pressed \(finds)× · ⌘S pressed \(saves)×")
                .font(.callout.monospacedDigit())
                .foregroundStyle(.secondary)
            C01_Caption("Press the shortcut while this window is key; modifiers default to ⌘.")
        }
    }
}

// MARK: - .keyboardShortcut() › keyboardShortcut(_:)

private struct C01_KeyboardShortcutPrebuiltExample: View {
    @State private var lastKey = "—"

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Button("Cancel") { lastKey = "Cancel (Esc)" }
                    .keyboardShortcut(.cancelAction)
                Button("Create") { lastKey = "Create (Return)" }
                    .keyboardShortcut(.defaultAction)
            }
            Text("Last: \(lastKey)")
                .font(.callout)
                .foregroundStyle(.secondary)
            C01_Caption(".defaultAction binds Return and draws the button as the default; .cancelAction binds Escape.")
        }
    }
}

// MARK: - .keyboardShortcut() › keyboardShortcut(_:modifiers:localization:)

private struct C01_KeyboardShortcutLocalizationExample: View {
    @State private var level = 1

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 12) {
                Button("Outdent") { level = max(0, level - 1) }
                    .keyboardShortcut("[", modifiers: .command, localization: .withoutMirroring)
                Button("Indent") { level = min(6, level + 1) }
                    .keyboardShortcut("]", modifiers: .command, localization: .withoutMirroring)
            }
            HStack(spacing: 0) {
                Color.clear.frame(width: CGFloat(level) * 18, height: 1)
                Text("• Indented \(level) level\(level == 1 ? "" : "s")")
                    .font(.callout.monospacedDigit())
                Spacer()
            }
            .frame(width: 240)
            C01_Caption("⌘[ / ⌘]. .withoutMirroring keeps the bracket keys unswapped in right-to-left layouts.")
        }
    }
}

// MARK: - .lineLimit() › lineLimit(_ number: Int?)

private struct C01_LineLimitNumberExample: View {
    @State private var limit: Int? = 2
    private let options: [Int?] = [nil, 1, 2, 3]
    private let teaser = "A hard cap on line count keeps teasers tidy: everything past the limit is truncated with an ellipsis, and passing nil lifts any limit inherited from an ancestor."

    var body: some View {
        VStack(spacing: 10) {
            Text(teaser)
                .lineLimit(limit)
                .frame(width: 320, height: 64, alignment: .top)
            Picker("lineLimit", selection: $limit) {
                ForEach(options, id: \.self) { option in
                    Text(option.map { "\($0)" } ?? "nil").tag(option)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 240)
        }
    }
}

// MARK: - .lineLimit() › lineLimit(_ limit: ClosedRange<Int>)

private struct C01_LineLimitRangeExample: View {
    @State private var comment = ""

    var body: some View {
        VStack(spacing: 10) {
            TextField("Comment", text: $comment, axis: .vertical)
                .lineLimit(3...6)
                .textFieldStyle(.roundedBorder)
                .frame(width: 320)
            C01_Caption("Empty, it still reserves three lines; keep typing and it grows to six, then scrolls.")
        }
    }
}

// MARK: - .lineLimit() › lineLimit(_:reservesSpace:)

private struct C01_LineLimitReservesSpaceExample: View {
    private let summary = "One short line."

    var body: some View {
        HStack(alignment: .top, spacing: 36) {
            VStack(spacing: 6) {
                Text(summary)
                    .lineLimit(3, reservesSpace: true)
                    .frame(width: 150)
                    .c01Bounds()
                Text("reservesSpace: true").font(.caption2.monospaced())
            }
            VStack(spacing: 6) {
                Text(summary)
                    .lineLimit(3, reservesSpace: false)
                    .frame(width: 150)
                    .c01Bounds()
                Text("reservesSpace: false").font(.caption2.monospaced())
            }
        }
    }
}

// MARK: - .listRowSeparator() › listRowSeparator(_:edges:)

private struct C01_ListRowSeparatorExample: View {
    @State private var hideLast = true

    var body: some View {
        VStack(spacing: 8) {
            List {
                Text("Today")
                    .font(.headline)
                    .listRowSeparator(.hidden, edges: .top)
                Label("Standup notes", systemImage: "note.text")
                Label("Plan the sprint", systemImage: "calendar")
                    .listRowSeparator(hideLast ? .hidden : .visible, edges: .bottom)
            }
            .listStyle(.inset)
            .frame(height: 100)
            Toggle("Hide the last row's bottom separator", isOn: $hideLast)
                .toggleStyle(.switch)
                .controlSize(.small)
        }
    }
}

// MARK: - .listRowSeparator() › listRowSeparatorTint(_:edges:)

private struct C01_AlertItem: Identifiable {
    let id: Int
    let title: String
    let isCritical: Bool
}

private struct C01_ListRowSeparatorTintExample: View {
    private let alerts = [
        C01_AlertItem(id: 1, title: "Disk almost full", isCritical: true),
        C01_AlertItem(id: 2, title: "Backup finished", isCritical: false),
        C01_AlertItem(id: 3, title: "Certificate expired", isCritical: true),
        C01_AlertItem(id: 4, title: "Update available", isCritical: false),
    ]

    var body: some View {
        VStack(spacing: 8) {
            List(alerts) { alert in
                Label(alert.title, systemImage: alert.isCritical ? "exclamationmark.triangle" : "checkmark.circle")
                    .listRowSeparatorTint(alert.isCritical ? .red : nil, edges: .bottom)
            }
            .listStyle(.inset)
            .frame(height: 118)
            C01_Caption("Critical rows get a red bottom separator; nil restores the default tint.")
        }
    }
}

// MARK: - .listRowSeparator() › listSectionSeparator(_:edges:)

private struct C01_ListSectionSeparatorExample: View {
    @State private var hidden = true
    private let pinned = ["Roadmap", "Launch checklist"]
    private let recent = ["Grocery list", "Book notes"]

    var body: some View {
        VStack(spacing: 8) {
            List {
                Section("Pinned") {
                    ForEach(pinned, id: \.self) { Label($0, systemImage: "pin") }
                }
                .listSectionSeparator(hidden ? .hidden : .visible, edges: .all)
                Section("Recent") {
                    ForEach(recent, id: \.self) { Label($0, systemImage: "note.text") }
                }
            }
            .listStyle(.inset)
            .frame(height: 150)
            Toggle("Hide the Pinned section's separators", isOn: $hidden)
                .toggleStyle(.switch)
                .controlSize(.small)
        }
    }
}

// MARK: - .navigationTitle() › navigationTitle(_ titleKey: LocalizedStringKey)

private struct C01_NavigationTitleKeyExample: View {
    private let trips = ["Kyoto", "Lisbon", "Reykjavík"]

    var body: some View {
        HStack(spacing: 20) {
            C01_WindowChrome(title: "Trips") {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(trips, id: \.self) { trip in
                        Label(trip, systemImage: "airplane")
                            .font(.caption)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                        Divider()
                    }
                }
                .padding(.bottom, 4)
            }
            C01_Caption("Illustrative — on macOS the title lands in the window's title bar. A string literal becomes a LocalizedStringKey and is looked up in your strings catalog.")
                .frame(width: 190)
        }
    }
}

// MARK: - .navigationTitle() › navigationTitle(_ title: Binding<String>)

private struct C01_NavigationTitleBindingExample: View {
    @State private var documentName = "Untitled Draft"

    var body: some View {
        HStack(spacing: 20) {
            C01_WindowChrome(title: documentName) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("document.name").font(.caption2.monospaced()).foregroundStyle(.secondary)
                    TextField("Name", text: $documentName)
                        .textFieldStyle(.roundedBorder)
                        .font(.caption)
                }
                .padding(10)
            }
            C01_Caption("Illustrative — type to rename: the same binding drives the title. With the real modifier the window title itself becomes editable on macOS, and the title menu does on iOS.")
                .frame(width: 190)
        }
    }
}

// MARK: - .navigationTitle() › navigationSubtitle(_:)

private struct C01_NavigationSubtitleExample: View {
    @State private var unreadCount = 3
    private let messages = ["Weekly digest", "Invoice #204", "Re: Design review"]

    var body: some View {
        HStack(spacing: 20) {
            C01_WindowChrome(title: "Inbox", subtitle: "\(unreadCount) unread") {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(Array(messages.enumerated()), id: \.offset) { index, message in
                        HStack {
                            Circle().fill(index < unreadCount ? .blue : .clear).frame(width: 6, height: 6)
                            Text(message).font(.caption)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        Divider()
                    }
                    Stepper("unread: \(unreadCount)", value: $unreadCount, in: 0...3)
                        .font(.caption)
                        .padding(8)
                }
            }
            C01_Caption("Illustrative — the subtitle sits under the title in the macOS title bar, and in the iOS 26 navigation bar.")
                .frame(width: 190)
        }
    }
}

// MARK: - .navigationTitle() › navigationBarTitleDisplayMode(_:)

private struct C01_NavigationBarTitleDisplayModeExample: View {
    @State private var inline = false

    var body: some View {
        HStack(spacing: 24) {
            C01_PhoneFrame {
                VStack(alignment: .leading, spacing: 0) {
                    if inline {
                        Text("Settings")
                            .font(.caption.bold())
                            .frame(maxWidth: .infinity)
                            .frame(height: 30)
                            .background(.bar)
                    } else {
                        VStack(alignment: .leading, spacing: 4) {
                            Color.clear.frame(height: 14)
                            Text("Settings").font(.title3.bold())
                        }
                        .padding(.horizontal, 10)
                        .padding(.bottom, 6)
                    }
                    Divider()
                    ForEach(["Wi-Fi", "Bluetooth", "Display"], id: \.self) { row in
                        Text(row).font(.caption).padding(.horizontal, 10).padding(.vertical, 5)
                        Divider()
                    }
                    Spacer()
                }
            }
            VStack(alignment: .leading, spacing: 8) {
                Picker("mode", selection: $inline) {
                    Text(".large").tag(false)
                    Text(".inline").tag(true)
                }
                .pickerStyle(.segmented)
                .labelsHidden()
                C01_Caption("Illustrative — iOS and watchOS only. .automatic is large at the root and inline for pushed screens; macOS ignores it.")
            }
            .frame(width: 200)
        }
    }
}

// MARK: - .navigationTransition() › zoom / matchedTransitionSource

private struct C01_Album: Identifiable {
    let id: Int
    let name: String
    let color: Color
}

private enum C01_ZoomVariant { case zoom, source, configured }

/// A phone mock that animates a grid thumbnail into a detail view with
/// matchedGeometryEffect, standing in for the iOS zoom navigation transition.
private struct C01_ZoomMock: View {
    let variant: C01_ZoomVariant
    let caption: String
    @Namespace private var zoom
    @Namespace private var geometry
    @State private var selected: C01_Album?
    private let albums = [
        C01_Album(id: 1, name: "Dawn", color: .orange),
        C01_Album(id: 2, name: "Tide", color: .teal),
        C01_Album(id: 3, name: "Dusk", color: .purple),
    ]

    var body: some View {
        HStack(spacing: 24) {
            C01_PhoneFrame {
                ZStack {
                    if let album = selected {
                        detail(album)
                    } else {
                        grid
                    }
                }
            }
            C01_Caption(caption)
                .frame(width: 210)
        }
    }

    private var grid: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Albums").font(.caption.bold())
            HStack(spacing: 8) {
                ForEach(albums) { album in
                    source(album)
                        .onTapGesture {
                            withAnimation(.spring(duration: 0.45)) { selected = album }
                        }
                }
            }
            Spacer()
        }
        .padding(10)
    }

    @ViewBuilder
    private func source(_ album: C01_Album) -> some View {
        let cover = RoundedRectangle(cornerRadius: 6)
            .fill(album.color.gradient)
            .frame(width: 30, height: 30)
            .matchedGeometryEffect(id: album.id, in: geometry)
        switch variant {
        case .zoom:
            cover
        case .source:
            cover
                .matchedTransitionSource(id: album.id, in: zoom)
                .overlay(RoundedRectangle(cornerRadius: 6).stroke(.blue, lineWidth: 1.5))
        case .configured:
            cover
                .matchedTransitionSource(id: album.id, in: zoom) { source in
                    source
                        .clipShape(.rect(cornerRadius: 12))
                        .shadow(radius: 8)
                }
                .shadow(radius: 3)
        }
    }

    private func detail(_ album: C01_Album) -> some View {
        VStack(spacing: 8) {
            HStack {
                Button("‹ Back") { withAnimation(.spring(duration: 0.45)) { selected = nil } }
                    .buttonStyle(.plain)
                    .font(.caption)
                    .foregroundStyle(.blue)
                Spacer()
            }
            RoundedRectangle(cornerRadius: variant == .configured ? 12 : 6)
                .fill(album.color.gradient)
                .frame(width: 88, height: 88)
                .matchedGeometryEffect(id: album.id, in: geometry)
                .shadow(radius: variant == .configured ? 8 : 0)
            Text(album.name).font(.caption.bold())
            Spacer()
        }
        .padding(10)
    }
}

private struct C01_NavigationTransitionZoomExample: View {
    var body: some View {
        C01_ZoomMock(variant: .zoom,
                     caption: "Illustrative — .zoom is iOS, tvOS and watchOS only. Tap a cover: the destination grows out of the view that shares its sourceID and namespace, and shrinks back on return.")
    }
}

private struct C01_MatchedTransitionSourceExample: View {
    var body: some View {
        C01_ZoomMock(variant: .source,
                     caption: "The outlined covers carry matchedTransitionSource(id:in:). Tap one — on iOS the zoom transition starts from and returns to that view; this mock stands in for it on macOS.")
    }
}

private struct C01_MatchedTransitionSourceConfiguredExample: View {
    var body: some View {
        C01_ZoomMock(variant: .configured,
                     caption: "The configuration closure shapes the outgoing snapshot: rounded to 12 pt with a shadow. Tap a cover to see the styled snapshot grow; the zoom itself runs on iOS.")
    }
}

// MARK: - .offset() › offset(_:)

private struct C01_OffsetSizeExample: View {
    @State private var dragTranslation: CGSize = .zero

    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 12)
                .fill(.orange.gradient)
                .frame(width: 120, height: 60)
                .overlay(Text("Drag me").foregroundStyle(.white).bold())
                .c01Bounds()
                .offset(dragTranslation)
                .gesture(
                    DragGesture()
                        .onChanged { dragTranslation = $0.translation }
                        .onEnded { _ in withAnimation(.bouncy) { dragTranslation = .zero } }
                )
                .frame(height: 90)
            Text("translation: (\(Int(dragTranslation.width)), \(Int(dragTranslation.height)))")
                .font(.callout.monospacedDigit())
                .foregroundStyle(.secondary)
            C01_Caption("The CGSize goes straight in; the card's layout slot never moves, only its rendering.")
        }
    }
}

// MARK: - .offset() › offset(x:y:)

private struct C01_OffsetXYExample: View {
    @State private var isBouncing = false

    var body: some View {
        HStack(spacing: 40) {
            VStack(spacing: 6) {
                Image(systemName: "arrow.down")
                    .font(.title)
                    .c01Bounds()
                    .offset(y: isBouncing ? 6 : 0)
                    .animation(.easeInOut(duration: 0.4).repeatForever(), value: isBouncing)
                    .frame(height: 50)
                Text("offset(y:)").font(.caption2.monospaced())
            }
            VStack(spacing: 6) {
                Image(systemName: "arrow.right")
                    .font(.title)
                    .c01Bounds()
                    .offset(x: isBouncing ? 8 : 0)
                    .animation(.easeInOut(duration: 0.4).repeatForever(), value: isBouncing)
                    .frame(height: 50)
                Text("offset(x:)").font(.caption2.monospaced())
            }
            VStack(spacing: 6) {
                Image(systemName: "arrow.down.right")
                    .font(.title)
                    .c01Bounds()
                    .offset(x: isBouncing ? 6 : 0, y: isBouncing ? 6 : 0)
                    .animation(.easeInOut(duration: 0.4).repeatForever(), value: isBouncing)
                    .frame(height: 50)
                Text("offset(x:y:)").font(.caption2.monospaced())
            }
        }
        .onAppear { isBouncing = true }
    }
}
