//
//  Examples+Modifiers.swift
//  Aviary
//
//  Rendered usage examples for the entries in CatalogData/modifiers.json.
//

import SwiftUI

enum ExamplesModifiers {
    static let entries: [ExampleEntry] = [
        ExampleEntry(topic: ".alert()", code: """
        Button("Delete File", role: .destructive) { confirmDelete = true }
            .alert("Delete file?", isPresented: $confirmDelete) {
                Button("Delete", role: .destructive) { isDeleted = true }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("This cannot be undone.")
            }
        """) { AnyView(M_AlertExample()) },

        ExampleEntry(topic: ".allowsHitTesting()", code: """
        Button("Tap me") { taps += 1 }
            .padding(20)
            .overlay {
                vignetteGradient
                    .allowsHitTesting(overlayBlocksClicks) // false lets clicks through
            }
        """) { AnyView(M_AllowsHitTestingExample()) },

        ExampleEntry(topic: ".aspectRatio()", code: """
        RoundedRectangle(cornerRadius: 10)
            .fill(.indigo.gradient)
            .aspectRatio(2 / 3, contentMode: fits ? .fit : .fill)
            .frame(width: 200, height: 110)
            .clipped()
        """) { AnyView(M_AspectRatioExample()) },

        ExampleEntry(topic: ".background()", code: """
        Label("Pro", systemImage: "crown")
            .padding(8)
            .background(.purple.gradient, in: .capsule)

        Text("Now Playing")
            .padding(10)
            .background {
                RoundedRectangle(cornerRadius: 10).fill(.regularMaterial)
            }
        """) { AnyView(M_BackgroundExample()) },

        ExampleEntry(topic: ".backgroundExtensionEffect()", code: """
        ZStack {
            landscapeGradient
                .backgroundExtensionEffect()
        }
        .safeAreaInset(edge: .leading, spacing: 0) {
            Sidebar().background(.ultraThinMaterial)
        }
        """) { AnyView(M_BackgroundExtensionEffectExample()) },

        ExampleEntry(topic: ".badge()", code: """
        List {
            Label("Inbox", systemImage: "tray")
                .badge(unreadCount)
            Label("Drafts", systemImage: "doc")
                .badge("New")
            Label("Archive", systemImage: "archivebox")
        }
        """) { AnyView(M_BadgeExample()) },

        ExampleEntry(topic: ".blur()", code: """
        secretCard
            .blur(radius: isRevealed ? 0 : 12)

        Toggle("Reveal", isOn: $isRevealed)
        """) { AnyView(M_BlurExample()) },

        ExampleEntry(topic: ".confirmationDialog()", code: """
        Button("Export…") { choosing = true }
            .confirmationDialog("Export format?", isPresented: $choosing) {
                Button("PDF") { exported = "PDF" }
                Button("PNG") { exported = "PNG" }
                Button("Cancel", role: .cancel) { }
            }
        """) { AnyView(M_ConfirmationDialogExample()) },

        ExampleEntry(topic: ".containerRelativeFrame()", code: """
        ScrollView(.horizontal) {
            LazyHStack(spacing: 12) {
                ForEach(cards.indices, id: \\.self) { i in
                    CardView(i)
                        .containerRelativeFrame(.horizontal) { length, _ in
                            length * 0.8
                        }
                }
            }
        }
        """) { AnyView(M_ContainerRelativeFrameExample()) },

        ExampleEntry(topic: ".contextMenu()", code: """
        Label(fileName, systemImage: "doc.text")
            .contextMenu {
                Button("Rename") { fileName = "Notes (renamed).md" }
                Button("Delete", role: .destructive) { isDeleted = true }
            }
        """) { AnyView(M_ContextMenuExample()) },

        ExampleEntry(topic: ".disabled()", code: """
        Toggle("I accept the terms", isOn: $termsAccepted)

        Button("Purchase") { purchases += 1 }
            .disabled(!termsAccepted)
        """) { AnyView(M_DisabledExample()) },

        ExampleEntry(topic: ".draggable()", code: """
        Label("Golden Gate.jpg", systemImage: "photo")
            .padding(10)
            .background(.orange.gradient, in: .rect(cornerRadius: 10))
            .draggable("Golden Gate.jpg")   // String is Transferable

        TextField("Drop the file name here", text: $dropped)
        """) { AnyView(M_DraggableExample()) },

        ExampleEntry(topic: ".dropDestination()", code: """
        DropZone(photos)
            .dropDestination(for: String.self) { items, _ in
                photos.append(contentsOf: items)
                return true
            } isTargeted: { isTargeted = $0 }
        """) { AnyView(M_DropDestinationExample()) },

        ExampleEntry(topic: ".fixedSize()", code: """
        Text("Never truncate this label, even when the frame is short")
            .fixedSize(horizontal: false, vertical: refusesCompression)
            .frame(width: 180, height: 24, alignment: .top)
            .border(.secondary)
        """) { AnyView(M_FixedSizeExample()) },

        ExampleEntry(topic: ".focused()", code: """
        enum Field { case email, password }
        @FocusState private var focusedField: Field?

        TextField("Email", text: $email)
            .focused($focusedField, equals: .email)
        SecureField("Password", text: $password)
            .focused($focusedField, equals: .password)

        Button("Focus Email") { focusedField = .email }
        """) { AnyView(M_FocusedExample()) },

        ExampleEntry(topic: ".font()", code: """
        VStack(alignment: .leading) {
            Text("Headline").fontWeight(.semibold)
            Text("Details about this item")
        }
        .font(.system(.body, design: design))
        """) { AnyView(M_FontExample()) },

        ExampleEntry(topic: ".foregroundStyle()", code: """
        Image(systemName: "cloud.sun.rain.fill")
            .foregroundStyle(.gray, .yellow, .cyan)

        Text("Gradient text")
            .foregroundStyle(.linearGradient(
                colors: [.pink, .orange],
                startPoint: .leading, endPoint: .trailing))
        """) { AnyView(M_ForegroundStyleExample()) },

        ExampleEntry(topic: ".fullScreenCover()", code: """
        Button("Play") { showingPlayer = true }
            .fullScreenCover(isPresented: $showingPlayer) {
                PlayerView()
            }
        """) { AnyView(M_FullScreenCoverExample()) },

        ExampleEntry(topic: ".gesture()", code: """
        Circle()
            .frame(width: 56)
            .offset(dragOffset)
            .gesture(
                DragGesture()
                    .onChanged { dragOffset = $0.translation }
                    .onEnded { _ in withAnimation(.bouncy) { dragOffset = .zero } }
            )
        """) { AnyView(M_GestureExample()) },

        ExampleEntry(topic: ".glassEffect()", code: """
        Label("Now Playing", systemImage: "music.note")
            .padding()
            .glassEffect()

        Image(systemName: "plus")
            .frame(width: 56, height: 56)
            .glassEffect(.regular.tint(.blue).interactive(), in: .circle)
        """) { AnyView(M_GlassEffectExample()) },

        ExampleEntry(topic: ".help()", code: """
        Button {
            isLocked.toggle()
        } label: {
            Image(systemName: isLocked ? "lock.fill" : "lock.open")
        }
        .help(isLocked ? "Unlock the document" : "Lock the document")
        """) { AnyView(M_HelpExample()) },

        ExampleEntry(topic: ".ignoresSafeArea()", code: """
        ZStack {
            heroGradient
                .ignoresSafeArea(edges: ignoresTop ? .top : [])
            Text("Hero")
        }
        .safeAreaInset(edge: .top) { TopBar() }
        """) { AnyView(M_IgnoresSafeAreaExample()) },

        ExampleEntry(topic: ".interactiveDismissDisabled()", code: """
        Button("Open Editor") { editing = true }
            .sheet(isPresented: $editing) {
                EditorView()
                    .interactiveDismissDisabled(hasUnsavedChanges)
            }
        """) { AnyView(M_InteractiveDismissExample()) },

        ExampleEntry(topic: ".keyboardShortcut()", code: """
        Button("Save", action: save)
            .keyboardShortcut("s", modifiers: .command)
        """) { AnyView(M_KeyboardShortcutExample()) },

        ExampleEntry(topic: ".layoutPriority()", code: """
        HStack {
            Text(title)
                .lineLimit(1)
                .layoutPriority(titleWins ? 1 : 0)
            Text(subtitle)
                .lineLimit(1)
        }
        .frame(width: 280)
        """) { AnyView(M_LayoutPriorityExample()) },

        ExampleEntry(topic: ".lineLimit()", code: """
        Text(review)
            .lineLimit(limit)

        TextField("Notes", text: $notes, axis: .vertical)
            .lineLimit(2...5)
        """) { AnyView(M_LineLimitExample()) },

        ExampleEntry(topic: ".listRowSeparator()", code: """
        List(photos, id: \\.self) { photo in
            Label(photo, systemImage: "photo")
                .listRowSeparator(hideSeparators ? .hidden : .visible)
        }
        .listStyle(.inset)
        """) { AnyView(M_ListRowSeparatorExample()) },

        ExampleEntry(topic: ".matchedGeometryEffect()", code: """
        @Namespace private var hero

        if isExpanded {
            DetailCard()
                .matchedGeometryEffect(id: "card", in: hero)
        } else {
            ThumbCard()
                .matchedGeometryEffect(id: "card", in: hero)
        }
        """) { AnyView(M_MatchedGeometryEffectExample()) },

        ExampleEntry(topic: ".multilineTextAlignment()", code: """
        Text(quote)
            .multilineTextAlignment(alignment)
            .frame(maxWidth: 240)
        """) { AnyView(M_MultilineTextAlignmentExample()) },

        ExampleEntry(topic: ".navigationTitle()", code: """
        NavigationStack {
            TripList()
                .navigationTitle("Trip Details")
        }
        """) { AnyView(M_NavigationTitleExample()) },

        ExampleEntry(topic: ".navigationTransition()", code: """
        NavigationLink(value: photo) {
            PhotoThumb(photo)
                .matchedTransitionSource(id: photo.id, in: zoomNS)
        }
        .navigationDestination(for: Photo.self) { photo in
            PhotoDetail(photo)
                .navigationTransition(.zoom(sourceID: photo.id, in: zoomNS))
        }
        """) { AnyView(M_NavigationTransitionExample()) },

        ExampleEntry(topic: ".onAppear()", code: """
        if showDetail {
            Label("Detail", systemImage: "doc.text")
                .onAppear {
                    appearances += 1
                }
        }
        """) { AnyView(M_OnAppearExample()) },

        ExampleEntry(topic: ".onChange()", code: """
        Slider(value: $volume, in: 0...100, step: 5)
            .onChange(of: volume) { oldValue, newValue in
                lastChange = "\\(Int(oldValue)) → \\(Int(newValue))"
            }
        """) { AnyView(M_OnChangeExample()) },

        ExampleEntry(topic: ".onHover()", code: """
        Label("Quarterly Report.numbers", systemImage: "doc.richtext")
            .padding(10)
            .onHover { isHovering = $0 }
            .background(.quaternary.opacity(isHovering ? 1 : 0),
                        in: .rect(cornerRadius: 8))
        """) { AnyView(M_OnHoverExample()) },

        ExampleEntry(topic: ".onScrollGeometryChange()", code: """
        ScrollView { messages }
            .onScrollGeometryChange(for: Bool.self) { geometry in
                geometry.contentOffset.y > 100
            } action: { _, isPast in
                showCompactHeader = isPast
            }
        """) { AnyView(M_OnScrollGeometryChangeExample()) },

        ExampleEntry(topic: ".onSubmit()", code: """
        TextField("Search", text: $query)
            .onSubmit { lastSearch = query }
        """) { AnyView(M_OnSubmitExample()) },

        ExampleEntry(topic: ".onTapGesture()", code: """
        Image(systemName: isLiked ? "heart.fill" : "heart")
            .onTapGesture(count: 2) {
                isLiked.toggle()
            }
        """) { AnyView(M_OnTapGestureExample()) },

        ExampleEntry(topic: ".overlay()", code: """
        avatarCircle
            .overlay {
                Circle().strokeBorder(.white, lineWidth: 3)
            }
            .overlay(alignment: .bottomTrailing) {
                Circle().fill(.green).frame(width: 16)
            }
        """) { AnyView(M_OverlayExample()) },

        ExampleEntry(topic: ".popover()", code: """
        Button("Info") { showInfo = true }
            .popover(isPresented: $showInfo, arrowEdge: .bottom) {
                StoragePanel().padding()
            }
        """) { AnyView(M_PopoverExample()) },

        ExampleEntry(topic: ".position()", code: """
        Circle()
            .frame(width: 16)
            .position(x: x, y: y)
        """) { AnyView(M_PositionExample()) },

        ExampleEntry(topic: ".presentationDetents()", code: """
        .sheet(isPresented: $showMap) {
            MapSheet()
                .presentationDetents([.medium, .large])
        }
        """) { AnyView(M_PresentationDetentsExample()) },

        ExampleEntry(topic: ".presentationSizing()", code: """
        Button("Show Inspector") { showInspector = true }
            .sheet(isPresented: $showInspector) {
                InspectorView()
                    .presentationSizing(.form)   // or .page, .fitted
            }
        """) { AnyView(M_PresentationSizingExample()) },

        ExampleEntry(topic: ".redacted()", code: """
        ArticleRow()
            .redacted(reason: isLoading ? .placeholder : [])

        Toggle("Loading", isOn: $isLoading)
        """) { AnyView(M_RedactedExample()) },

        ExampleEntry(topic: ".refreshable()", code: """
        List { articles; RefreshRow() }
            .refreshable {
                try? await Task.sleep(for: .seconds(1))
                articles.insert("Update #\\(refreshCount)", at: 0)
            }

        // Inside RefreshRow:
        @Environment(\\.refresh) private var refresh
        Button("Refresh now") { Task { await refresh?() } }
        """) { AnyView(M_RefreshableExample()) },

        ExampleEntry(topic: ".rotation3DEffect()", code: """
        CardFront()
            .rotation3DEffect(
                .degrees(degrees),
                axis: (x: 0, y: 1, z: 0)
            )

        Slider(value: $degrees, in: 0...180)
        """) { AnyView(M_Rotation3DEffectExample()) },

        ExampleEntry(topic: ".safeAreaInset()", code: """
        ScrollView { messages }
            .safeAreaInset(edge: .bottom) {
                ComposeBar().background(.bar)
            }
        """) { AnyView(M_SafeAreaInsetExample()) },

        ExampleEntry(topic: ".scrollEdgeEffectStyle()", code: """
        ScrollView { rows }
            .safeAreaInset(edge: .top) { Header() }
            .scrollEdgeEffectStyle(style, for: .top)   // .soft, .hard, or nil
        """) { AnyView(M_ScrollEdgeEffectStyleExample()) },

        ExampleEntry(topic: ".scrollPosition()", code: """
        @State private var position = ScrollPosition(idType: Int.self)

        ScrollView {
            LazyVStack { messages }.scrollTargetLayout()
        }
        .scrollPosition($position)

        Button("Latest") { position.scrollTo(edge: .bottom) }
        Button("#15") { position.scrollTo(id: 15) }
        """) { AnyView(M_ScrollPositionExample()) },

        ExampleEntry(topic: ".scrollTargetBehavior()", code: """
        ScrollView(.horizontal) {
            LazyHStack(spacing: 12) { cards }
                .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        """) { AnyView(M_ScrollTargetBehaviorExample()) },

        ExampleEntry(topic: ".searchable()", code: """
        NavigationStack {
            List(results) { ResultRow($0) }
                .searchable(text: $query, prompt: "Search parks")
        }
        """) { AnyView(M_SearchableExample()) },

        ExampleEntry(topic: ".searchToolbarBehavior()", code: """
        NavigationStack { results }
            .searchable(text: $query)
            .searchToolbarBehavior(.minimize)
        """) { AnyView(M_SearchToolbarBehaviorExample()) },

        ExampleEntry(topic: ".sensoryFeedback()", code: """
        Toggle("Armed", isOn: $armed)
            .sensoryFeedback(.success, trigger: armed) { _, new in
                new == true
            }
        """) { AnyView(M_SensoryFeedbackExample()) },

        ExampleEntry(topic: ".sheet()", code: """
        ContactList()
            .sheet(item: $editingContact) { contact in
                ContactEditor(contact: contact)
            }
        """) { AnyView(M_SheetExample()) },

        ExampleEntry(topic: ".swipeActions()", code: """
        List(items, id: \\.self) { item in
            ItemRow(item)
                .swipeActions(edge: .trailing) {
                    Button("Delete", role: .destructive) { delete(item) }
                    Button("Pin", systemImage: "pin") { pin(item) }.tint(.yellow)
                }
        }
        """) { AnyView(M_SwipeActionsExample()) },

        ExampleEntry(topic: ".tabBarMinimizeBehavior()", code: """
        TabView {
            Tab("Home", systemImage: "house") { HomeView() }
            Tab("Search", systemImage: "magnifyingglass") { SearchView() }
        }
        .tabBarMinimizeBehavior(.onScrollDown)
        """) { AnyView(M_TabBarMinimizeBehaviorExample()) },

        ExampleEntry(topic: ".task()", code: """
        List(articles, id: \\.self) { Label($0, systemImage: "newspaper") }
            .task {
                articles = await loadArticles()
            }
        """) { AnyView(M_TaskExample()) },

        ExampleEntry(topic: ".textSelection()", code: """
        Text(serialNumber)
            .font(.system(.body, design: .monospaced))
            .textSelection(.enabled)
        """) { AnyView(M_TextSelectionExample()) },

        ExampleEntry(topic: ".tint()", code: """
        VStack {
            Toggle("Alarm", isOn: $armed)
            Slider(value: $level, in: 0...1)
            Button("Snooze") { }.buttonStyle(.borderedProminent)
        }
        .tint(tint)
        """) { AnyView(M_TintExample()) },

        ExampleEntry(topic: ".toolbar()", code: """
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Add", systemImage: "plus") { count += 1 }
            }
        }
        """) { AnyView(M_ToolbarExample()) },

        ExampleEntry(topic: ".toolbarBackground()", code: """
        content
            .toolbarBackground(.indigo, for: .navigationBar)
            .toolbarBackground(isVisible ? .visible : .hidden, for: .navigationBar)
        """) { AnyView(M_ToolbarBackgroundExample()) },

        ExampleEntry(topic: ".visualEffect()", code: """
        ForEach(rows) { row in
            RowCard(row)
                .visualEffect { effect, proxy in
                    effect.blur(radius: max(0, -proxy.frame(in: .scrollView).minY / 6))
                }
        }
        """) { AnyView(M_VisualEffectExample()) },

        ExampleEntry(topic: ".zIndex()", code: """
        ZStack {
            Toast()
                .zIndex(toastOnTop ? 1 : 0)
            Card()
        }
        """) { AnyView(M_ZIndexExample()) },
    ]
}

// MARK: - Shared helpers

private struct M_Caption: View {
    let text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
    }
}

private struct M_PhoneMock<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) { self.content = content() }
    var body: some View {
        content
            .frame(width: 120, height: 170)
            .background(.background)
            .clipShape(.rect(cornerRadius: 18))
            .overlay {
                RoundedRectangle(cornerRadius: 18).strokeBorder(.secondary, lineWidth: 3)
            }
    }
}

private struct M_PlaceholderRows: View {
    var count = 4
    var body: some View {
        VStack(spacing: 6) {
            ForEach(0..<count, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 4)
                    .fill(.quaternary)
                    .frame(height: 12)
            }
        }
        .padding(.horizontal, 10)
    }
}

// MARK: - Examples

private struct M_AlertExample: View {
    @State private var confirmDelete = false
    @State private var isDeleted = false

    var body: some View {
        VStack(spacing: 12) {
            Label(isDeleted ? "Report.pdf — deleted" : "Report.pdf",
                  systemImage: isDeleted ? "trash" : "doc.richtext")
                .foregroundStyle(isDeleted ? Color.secondary : Color.primary)
            Button("Delete File", role: .destructive) { confirmDelete = true }
                .disabled(isDeleted)
                .alert("Delete file?", isPresented: $confirmDelete) {
                    Button("Delete", role: .destructive) { isDeleted = true }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("This cannot be undone.")
                }
            if isDeleted {
                Button("Restore") { isDeleted = false }
                    .buttonStyle(.borderless)
            }
        }
        .padding()
    }
}

private struct M_AllowsHitTestingExample: View {
    @State private var overlayBlocksClicks = false
    @State private var taps = 0

    var body: some View {
        VStack(spacing: 12) {
            Button("Tap me — \(taps)") { taps += 1 }
                .buttonStyle(.borderedProminent)
                .padding(20)
                .overlay {
                    LinearGradient(colors: [.clear, .black.opacity(0.45)],
                                   startPoint: .top, endPoint: .bottom)
                        .allowsHitTesting(overlayBlocksClicks)
                }
                .clipShape(.rect(cornerRadius: 10))
            Toggle("Vignette blocks clicks", isOn: $overlayBlocksClicks)
                .toggleStyle(.switch)
        }
        .frame(maxWidth: 280)
    }
}

private struct M_AspectRatioExample: View {
    @State private var fits = true

    var body: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.indigo.gradient)
                .overlay {
                    Text("2 : 3").font(.caption.bold()).foregroundStyle(.white)
                }
                .aspectRatio(2 / 3, contentMode: fits ? .fit : .fill)
                .frame(width: 200, height: 110)
                .clipped()
                .background(.quaternary)
            Picker("Content mode", selection: $fits) {
                Text(".fit").tag(true)
                Text(".fill").tag(false)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 160)
        }
    }
}

private struct M_BackgroundExample: View {
    var body: some View {
        HStack(spacing: 16) {
            Label("Pro", systemImage: "crown")
                .padding(8)
                .background(.purple.gradient, in: .capsule)
                .foregroundStyle(.white)
            Text("Now Playing")
                .padding(10)
                .background {
                    RoundedRectangle(cornerRadius: 10).fill(.regularMaterial)
                }
        }
        .padding(24)
        .background(LinearGradient(colors: [.orange, .pink],
                                   startPoint: .topLeading, endPoint: .bottomTrailing))
        .clipShape(.rect(cornerRadius: 12))
    }
}

private struct M_BackgroundExtensionEffectExample: View {
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                ZStack(alignment: .topTrailing) {
                    LinearGradient(colors: [.cyan, .blue, .green],
                                   startPoint: .top, endPoint: .bottom)
                    Circle().fill(.yellow).frame(width: 34).padding(14)
                    Ellipse().fill(.green.opacity(0.9))
                        .frame(width: 300, height: 90)
                        .offset(x: -40, y: 100)
                }
                .backgroundExtensionEffect()
                Text("Landscape").foregroundStyle(.white).bold()
            }
            .safeAreaInset(edge: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Albums").font(.caption.bold())
                    M_PlaceholderRows(count: 3).padding(.horizontal, -10)
                    Spacer()
                }
                .padding(10)
                .frame(width: 84)
                .frame(maxHeight: .infinity)
                .background(.ultraThinMaterial)
            }
            .frame(height: 140)
            .clipShape(.rect(cornerRadius: 12))
            M_Caption("Mirrors and blurs the image into adjacent safe areas, e.g. under a translucent sidebar")
        }
    }
}

private struct M_BadgeExample: View {
    @State private var unreadCount = 12

    var body: some View {
        VStack(spacing: 8) {
            List {
                Label("Inbox", systemImage: "tray")
                    .badge(unreadCount)
                Label("Drafts", systemImage: "doc")
                    .badge("New")
                Label("Archive", systemImage: "archivebox")
            }
            .frame(height: 100)
            Stepper("Unread: \(unreadCount)", value: $unreadCount, in: 0...99)
                .frame(maxWidth: 200)
        }
    }
}

private struct M_BlurExample: View {
    @State private var isRevealed = false

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 12).fill(.indigo.gradient)
                VStack(spacing: 4) {
                    Image(systemName: "key.fill")
                    Text("SECRET-4821").font(.title3.monospaced().bold())
                }
                .foregroundStyle(.white)
            }
            .frame(width: 220, height: 90)
            .blur(radius: isRevealed ? 0 : 12)
            Toggle("Reveal", isOn: $isRevealed)
                .toggleStyle(.switch)
        }
    }
}

private struct M_ConfirmationDialogExample: View {
    @State private var choosing = false
    @State private var exported: String?

    var body: some View {
        VStack(spacing: 12) {
            Button("Export…") { choosing = true }
                .confirmationDialog("Export format?", isPresented: $choosing) {
                    Button("PDF") { exported = "PDF" }
                    Button("PNG") { exported = "PNG" }
                    Button("Cancel", role: .cancel) { }
                }
            Text(exported.map { "Exported as \($0)" } ?? "Nothing exported yet")
                .foregroundStyle(.secondary)
        }
    }
}

private struct M_ContainerRelativeFrameExample: View {
    private let cards: [Color] = [.blue, .purple, .pink, .orange, .green]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 12) {
                ForEach(cards.indices, id: \.self) { i in
                    RoundedRectangle(cornerRadius: 12)
                        .fill(cards[i].gradient)
                        .overlay {
                            Text("Card \(i + 1) — 80% of the container")
                                .font(.caption.bold())
                                .foregroundStyle(.white)
                        }
                        .containerRelativeFrame(.horizontal) { length, _ in
                            length * 0.8
                        }
                }
            }
        }
        .frame(height: 110)
    }
}

private struct M_ContextMenuExample: View {
    @State private var fileName = "Notes.md"
    @State private var isDeleted = false

    var body: some View {
        VStack(spacing: 10) {
            Label(isDeleted ? "(deleted)" : fileName, systemImage: isDeleted ? "trash" : "doc.text")
                .padding(10)
                .frame(maxWidth: 240, alignment: .leading)
                .background(.quaternary, in: .rect(cornerRadius: 8))
                .contextMenu {
                    Button("Rename") { fileName = "Notes (renamed).md" }
                    Button("Delete", role: .destructive) { isDeleted = true }
                }
            if isDeleted {
                Button("Restore") { isDeleted = false; fileName = "Notes.md" }
                    .buttonStyle(.borderless)
            }
            M_Caption("Right-click (or Control-click) the row")
        }
    }
}

private struct M_DisabledExample: View {
    @State private var termsAccepted = false
    @State private var purchases = 0

    var body: some View {
        VStack(spacing: 12) {
            Toggle("I accept the terms", isOn: $termsAccepted)
                .toggleStyle(.checkbox)
            Button("Purchase") { purchases += 1 }
                .buttonStyle(.borderedProminent)
                .disabled(!termsAccepted)
            Text("Purchases: \(purchases)").foregroundStyle(.secondary)
        }
    }
}

private struct M_DraggableExample: View {
    @State private var dropped = ""

    var body: some View {
        VStack(spacing: 12) {
            Label("Golden Gate.jpg", systemImage: "photo")
                .padding(10)
                .background(.orange.gradient, in: .rect(cornerRadius: 10))
                .draggable("Golden Gate.jpg")
            TextField("Drop the file name here", text: $dropped)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: 240)
            M_Caption("Drag the tile into the field, or into another app")
        }
    }
}

private struct M_DropDestinationExample: View {
    @State private var photos: [String] = []
    @State private var isTargeted = false

    var body: some View {
        HStack(spacing: 16) {
            VStack(spacing: 8) {
                ForEach(["Sunset", "Harbor", "Peak"], id: \.self) { name in
                    Label(name, systemImage: "photo")
                        .padding(6)
                        .background(.quaternary, in: .rect(cornerRadius: 6))
                        .draggable(name)
                }
            }
            RoundedRectangle(cornerRadius: 12)
                .fill(.blue.opacity(isTargeted ? 0.25 : 0.07))
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [6]))
                        .foregroundStyle(isTargeted ? Color.blue : Color.secondary)
                }
                .overlay {
                    Text(photos.isEmpty ? "Drop photos here" : photos.joined(separator: ", "))
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .padding(8)
                }
                .frame(width: 160, height: 110)
                .dropDestination(for: String.self) { items, _ in
                    photos.append(contentsOf: items)
                    return true
                } isTargeted: { isTargeted = $0 }
        }
    }
}

private struct M_FixedSizeExample: View {
    @State private var refusesCompression = true

    var body: some View {
        VStack(spacing: 12) {
            Text("Never truncate this label, even when the frame is short")
                .fixedSize(horizontal: false, vertical: refusesCompression)
                .frame(width: 180, height: 24, alignment: .top)
                .border(.secondary)
                .frame(height: 64, alignment: .top)
            Toggle("fixedSize(horizontal: false, vertical: true)", isOn: $refusesCompression)
                .toggleStyle(.switch)
        }
    }
}

private struct M_FocusedExample: View {
    private enum Field: Hashable { case email, password }

    @FocusState private var focusedField: Field?
    @State private var email = ""
    @State private var password = ""

    private var focusLabel: String {
        switch focusedField {
        case .email: return "email"
        case .password: return "password"
        case nil: return "none"
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Email", text: $email)
                .focused($focusedField, equals: .email)
            SecureField("Password", text: $password)
                .focused($focusedField, equals: .password)
            HStack {
                Button("Focus Email") { focusedField = .email }
                Button("Focus Password") { focusedField = .password }
                Spacer()
                Text("Focused: \(focusLabel)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .textFieldStyle(.roundedBorder)
        .frame(maxWidth: 340)
    }
}

private struct M_FontExample: View {
    @State private var design: Font.Design = .rounded

    var body: some View {
        VStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Headline").fontWeight(.semibold)
                Text("Details about this item")
            }
            .font(.system(.body, design: design))
            Picker("Design", selection: $design) {
                Text("default").tag(Font.Design.default)
                Text("rounded").tag(Font.Design.rounded)
                Text("serif").tag(Font.Design.serif)
                Text("monospaced").tag(Font.Design.monospaced)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 300)
        }
    }
}

private struct M_ForegroundStyleExample: View {
    var body: some View {
        HStack(spacing: 28) {
            Image(systemName: "cloud.sun.rain.fill")
                .font(.system(size: 48))
                .foregroundStyle(.gray, .yellow, .cyan)
            Text("Gradient text")
                .font(.title.bold())
                .foregroundStyle(.linearGradient(
                    colors: [.pink, .orange],
                    startPoint: .leading, endPoint: .trailing))
        }
        .padding()
    }
}

private struct M_FullScreenCoverExample: View {
    @State private var showingPlayer = false

    var body: some View {
        VStack(spacing: 10) {
            M_PhoneMock {
                ZStack {
                    VStack(spacing: 8) {
                        Text("Library").font(.caption.bold())
                        M_PlaceholderRows(count: 5)
                        Spacer()
                    }
                    .padding(.top, 12)
                    if showingPlayer {
                        ZStack {
                            LinearGradient(colors: [.purple, .indigo],
                                           startPoint: .top, endPoint: .bottom)
                            VStack {
                                Image(systemName: "play.circle.fill").font(.largeTitle)
                                Text("Player").font(.caption)
                            }
                            .foregroundStyle(.white)
                        }
                        .transition(.move(edge: .bottom))
                    }
                }
            }
            Button(showingPlayer ? "Dismiss" : "Play") {
                withAnimation(.easeInOut) { showingPlayer.toggle() }
            }
            M_Caption("Illustrative — .fullScreenCover is iOS, tvOS and watchOS only")
        }
    }
}

private struct M_GestureExample: View {
    @State private var dragOffset: CGSize = .zero

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(.blue.gradient)
                    .frame(width: 56)
                    .offset(dragOffset)
                    .gesture(
                        DragGesture()
                            .onChanged { dragOffset = $0.translation }
                            .onEnded { _ in withAnimation(.bouncy) { dragOffset = .zero } }
                    )
            }
            .frame(width: 240, height: 110)
            .background(.quaternary, in: .rect(cornerRadius: 12))
            Text("translation: \(Int(dragOffset.width)), \(Int(dragOffset.height))")
                .font(.caption.monospacedDigit())
                .foregroundStyle(.secondary)
        }
    }
}

private struct M_GlassEffectExample: View {
    @State private var taps = 0

    var body: some View {
        ZStack {
            LinearGradient(colors: [.pink, .purple, .blue],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            HStack(spacing: 24) {
                Label("Now Playing", systemImage: "music.note")
                    .padding()
                    .glassEffect()
                Image(systemName: "plus")
                    .font(.title2)
                    .frame(width: 56, height: 56)
                    .glassEffect(.regular.tint(.blue).interactive(), in: .circle)
                    .onTapGesture { taps += 1 }
            }
        }
        .frame(height: 140)
        .clipShape(.rect(cornerRadius: 12))
    }
}

private struct M_HelpExample: View {
    @State private var isLocked = false

    var body: some View {
        VStack(spacing: 10) {
            Button {
                isLocked.toggle()
            } label: {
                Image(systemName: isLocked ? "lock.fill" : "lock.open")
                    .font(.title2)
            }
            .help(isLocked ? "Unlock the document" : "Lock the document")
            Text(isLocked ? "Document locked" : "Document unlocked")
            M_Caption("Hover over the button to see the tooltip")
        }
    }
}

private struct M_IgnoresSafeAreaExample: View {
    @State private var ignoresTop = true

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                LinearGradient(colors: [.orange, .pink],
                               startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea(edges: ignoresTop ? .top : [])
                Text("Hero").font(.title.bold()).foregroundStyle(.white)
            }
            .safeAreaInset(edge: .top) {
                Text("Top Bar")
                    .font(.caption.bold())
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .background(.ultraThinMaterial)
            }
            .frame(height: 140)
            .clipShape(.rect(cornerRadius: 12))
            Toggle("ignoresSafeArea(edges: .top)", isOn: $ignoresTop)
                .toggleStyle(.switch)
        }
    }
}

private struct M_InteractiveDismissExample: View {
    @State private var editing = false
    @State private var hasUnsavedChanges = true

    var body: some View {
        VStack(spacing: 10) {
            Toggle("Has unsaved changes", isOn: $hasUnsavedChanges)
                .toggleStyle(.switch)
            Button("Open Editor") { editing = true }
                .sheet(isPresented: $editing) {
                    VStack(spacing: 12) {
                        Text("Editor").font(.headline)
                        Text(hasUnsavedChanges
                             ? "Esc and ⌘. are blocked — use Done"
                             : "Esc or ⌘. closes this sheet")
                        Button("Done") { editing = false }
                            .keyboardShortcut(.defaultAction)
                    }
                    .padding()
                    .frame(width: 300)
                    .interactiveDismissDisabled(hasUnsavedChanges)
                }
        }
    }
}

private struct M_KeyboardShortcutExample: View {
    @State private var saveCount = 0

    var body: some View {
        VStack(spacing: 10) {
            Button("Save", action: save)
                .keyboardShortcut("s", modifiers: .command)
            Text("Saved \(saveCount) time\(saveCount == 1 ? "" : "s")")
                .foregroundStyle(.secondary)
            M_Caption("Press ⌘S while this window is key")
        }
    }

    private func save() { saveCount += 1 }
}

private struct M_LayoutPriorityExample: View {
    @State private var titleWins = true

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("A long title that wants all the room")
                    .lineLimit(1)
                    .layoutPriority(titleWins ? 1 : 0)
                Text("Subtitle that also wants room")
                    .lineLimit(1)
                    .foregroundStyle(.secondary)
            }
            .frame(width: 280)
            .padding(8)
            .border(.secondary)
            Toggle("Title has layoutPriority(1)", isOn: $titleWins)
                .toggleStyle(.switch)
        }
    }
}

private struct M_LineLimitExample: View {
    @State private var limit = 2
    @State private var notes = ""
    private let review = "The rounded keycaps feel great, the battery lasts for weeks, and the backlight is even. Pairing with three devices at once is the feature I did not know I needed."

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(review)
                .lineLimit(limit)
            Stepper("lineLimit(\(limit))", value: $limit, in: 1...5)
            TextField("Notes", text: $notes, axis: .vertical)
                .lineLimit(2...5)
                .textFieldStyle(.roundedBorder)
        }
        .frame(maxWidth: 300)
    }
}

private struct M_ListRowSeparatorExample: View {
    @State private var hideSeparators = true
    private let photos = ["Sunrise", "Harbor", "Summit", "Meadow"]

    var body: some View {
        VStack(spacing: 8) {
            List(photos, id: \.self) { photo in
                Label(photo, systemImage: "photo")
                    .listRowSeparator(hideSeparators ? .hidden : .visible)
            }
            .listStyle(.inset)
            .frame(height: 120)
            Toggle("listRowSeparator(.hidden)", isOn: $hideSeparators)
                .toggleStyle(.switch)
        }
    }
}

private struct M_MatchedGeometryEffectExample: View {
    @Namespace private var hero
    @State private var isExpanded = false

    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .topLeading) {
                if isExpanded {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.teal.gradient)
                        .overlay { Text("Detail").foregroundStyle(.white).bold() }
                        .matchedGeometryEffect(id: "card", in: hero)
                        .frame(width: 240, height: 110)
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.teal.gradient)
                        .overlay { Image(systemName: "photo").foregroundStyle(.white) }
                        .matchedGeometryEffect(id: "card", in: hero)
                        .frame(width: 60, height: 60)
                }
            }
            .frame(width: 240, height: 110, alignment: .topLeading)
            .onTapGesture { withAnimation(.smooth) { isExpanded.toggle() } }
            M_Caption("Click the card to expand or collapse")
        }
    }
}

private struct M_MultilineTextAlignmentExample: View {
    @State private var alignment: TextAlignment = .center
    private let quote = "Simplicity is the ultimate sophistication, and good layout makes it visible."

    var body: some View {
        VStack(spacing: 12) {
            Text(quote)
                .multilineTextAlignment(alignment)
                .frame(maxWidth: 240)
            Picker("Alignment", selection: $alignment) {
                Text("leading").tag(TextAlignment.leading)
                Text("center").tag(TextAlignment.center)
                Text("trailing").tag(TextAlignment.trailing)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 240)
        }
    }
}

private struct M_NavigationTitleExample: View {
    @State private var title = "Trip Details"

    var body: some View {
        VStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .font(.title2.bold())
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                Divider()
                VStack(alignment: .leading, spacing: 6) {
                    Label("Lisbon → Porto", systemImage: "tram")
                    Label("3 nights", systemImage: "bed.double")
                }
                .padding(12)
            }
            .frame(maxWidth: 280, alignment: .leading)
            .background(.quaternary, in: .rect(cornerRadius: 10))
            TextField("Title", text: $title)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: 200)
            M_Caption("Illustrative — on macOS the title appears in the window's title bar")
        }
    }
}

private struct M_NavigationTransitionExample: View {
    @Namespace private var zoomNS
    @State private var isOpen = false

    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .leading) {
                if isOpen {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(.orange.gradient)
                        .overlay { Text("Photo Detail").foregroundStyle(.white).bold() }
                        .matchedGeometryEffect(id: "photo", in: zoomNS)
                        .frame(width: 240, height: 110)
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.orange.gradient)
                        .overlay { Image(systemName: "photo").foregroundStyle(.white) }
                        .matchedGeometryEffect(id: "photo", in: zoomNS)
                        .frame(width: 64, height: 64)
                }
            }
            .frame(width: 240, height: 110, alignment: .leading)
            .onTapGesture { withAnimation(.smooth) { isOpen.toggle() } }
            M_Caption("Illustrative — the .zoom navigation transition is iOS, tvOS and watchOS only")
        }
    }
}

private struct M_OnAppearExample: View {
    @State private var showDetail = false
    @State private var appearances = 0

    var body: some View {
        VStack(spacing: 10) {
            Toggle("Show detail", isOn: $showDetail)
                .toggleStyle(.switch)
            if showDetail {
                Label("Detail", systemImage: "doc.text")
                    .padding(8)
                    .background(.quaternary, in: .rect(cornerRadius: 8))
                    .onAppear {
                        appearances += 1
                    }
            }
            Text("Appeared \(appearances) time\(appearances == 1 ? "" : "s")")
                .foregroundStyle(.secondary)
        }
        .frame(height: 100)
    }
}

private struct M_OnChangeExample: View {
    @State private var volume = 40.0
    @State private var lastChange = "—"

    var body: some View {
        VStack(spacing: 10) {
            Slider(value: $volume, in: 0...100, step: 5)
                .onChange(of: volume) { oldValue, newValue in
                    lastChange = "\(Int(oldValue)) → \(Int(newValue))"
                }
            Text("Volume: \(Int(volume))")
            Text("Last change: \(lastChange)")
                .font(.caption.monospacedDigit())
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: 260)
    }
}

private struct M_OnHoverExample: View {
    @State private var isHovering = false

    var body: some View {
        VStack(spacing: 10) {
            Label("Quarterly Report.numbers", systemImage: "doc.richtext")
                .padding(10)
                .frame(maxWidth: 260, alignment: .leading)
                .onHover { isHovering = $0 }
                .background(.quaternary.opacity(isHovering ? 1 : 0),
                            in: .rect(cornerRadius: 8))
            Text(isHovering ? "Pointer inside" : "Pointer outside")
                .foregroundStyle(.secondary)
        }
    }
}

private struct M_OnScrollGeometryChangeExample: View {
    @State private var showCompactHeader = false

    var body: some View {
        VStack(spacing: 0) {
            Text("Inbox")
                .font(showCompactHeader ? .headline : .largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .animation(.snappy, value: showCompactHeader)
            Divider()
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 6) {
                    ForEach(1..<40) { i in
                        Text("Message \(i)").padding(.horizontal, 12)
                    }
                }
                .padding(.vertical, 6)
            }
            .onScrollGeometryChange(for: Bool.self) { geometry in
                geometry.contentOffset.y > 100
            } action: { _, isPast in
                showCompactHeader = isPast
            }
            Divider()
            Text(showCompactHeader ? "Scrolled past 100 pt — compact header" : "Near the top — large header")
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(4)
        }
        .frame(height: 180)
        .background(.quaternary.opacity(0.4), in: .rect(cornerRadius: 10))
    }
}

private struct M_OnSubmitExample: View {
    @State private var query = ""
    @State private var lastSearch = "—"

    var body: some View {
        VStack(spacing: 10) {
            TextField("Search", text: $query)
                .textFieldStyle(.roundedBorder)
                .onSubmit { lastSearch = query }
            Text("Last submitted: \(lastSearch)")
                .foregroundStyle(.secondary)
            M_Caption("Type, then press Return")
        }
        .frame(maxWidth: 260)
    }
}

private struct M_OnTapGestureExample: View {
    @State private var isLiked = false

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .font(.system(size: 44))
                .foregroundStyle(isLiked ? Color.pink : Color.secondary)
                .contentTransition(.symbolEffect(.replace))
                .onTapGesture(count: 2) {
                    isLiked.toggle()
                }
            Text(isLiked ? "Liked" : "Double-click to like")
                .foregroundStyle(.secondary)
        }
    }
}

private struct M_OverlayExample: View {
    var body: some View {
        Circle()
            .fill(.blue.gradient)
            .frame(width: 80)
            .overlay {
                Image(systemName: "person.fill")
                    .font(.system(size: 36))
                    .foregroundStyle(.white)
            }
            .overlay {
                Circle().strokeBorder(.white, lineWidth: 3)
            }
            .overlay(alignment: .bottomTrailing) {
                Circle().fill(.green).frame(width: 18)
                    .overlay { Circle().strokeBorder(.white, lineWidth: 2) }
            }
            .padding()
    }
}

private struct M_PopoverExample: View {
    @State private var showInfo = false

    var body: some View {
        VStack(spacing: 8) {
            Button("Info") { showInfo = true }
                .popover(isPresented: $showInfo, arrowEdge: .bottom) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Storage").font(.headline)
                        ProgressView(value: 0.62)
                        Text("12.4 GB of 20 GB used").font(.caption)
                    }
                    .padding()
                    .frame(width: 200)
                }
            M_Caption("The popover is anchored to the button")
        }
    }
}

private struct M_PositionExample: View {
    @State private var x: CGFloat = 120
    @State private var y: CGFloat = 50

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(.red)
                    .frame(width: 16)
                    .position(x: x, y: y)
            }
            .frame(width: 240, height: 100)
            .background(.quaternary, in: .rect(cornerRadius: 8))
            .clipped()
            HStack { Text("x").frame(width: 14); Slider(value: $x, in: 0...240) }
            HStack { Text("y").frame(width: 14); Slider(value: $y, in: 0...100) }
            Text("position(x: \(Int(x)), y: \(Int(y)))")
                .font(.caption.monospacedDigit())
                .foregroundStyle(.secondary)
        }
        .frame(width: 240)
    }
}

private struct M_PresentationDetentsExample: View {
    @State private var detent = 0

    var body: some View {
        VStack(spacing: 10) {
            M_PhoneMock {
                ZStack(alignment: .bottom) {
                    LinearGradient(colors: [.green.opacity(0.35), .mint.opacity(0.5)],
                                   startPoint: .top, endPoint: .bottom)
                    Image(systemName: "map")
                        .font(.title)
                        .foregroundStyle(.secondary)
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top, 22)
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.background)
                        .frame(height: detent == 0 ? 85 : 150)
                        .overlay(alignment: .top) {
                            Capsule().fill(.secondary).frame(width: 30, height: 4).padding(.top, 6)
                        }
                        .shadow(radius: 4)
                }
            }
            Picker("Detent", selection: $detent) {
                Text(".medium").tag(0)
                Text(".large").tag(1)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 180)
            M_Caption("Illustrative — detents resize sheets on iOS")
        }
        .animation(.smooth, value: detent)
    }
}

private struct M_PresentationSizingExample: View {
    @State private var sizingIndex = 0
    @State private var showInspector = false

    var body: some View {
        VStack(spacing: 10) {
            Picker("Sizing", selection: $sizingIndex) {
                Text(".form").tag(0)
                Text(".page").tag(1)
                Text(".fitted").tag(2)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 220)
            Button("Show Inspector") { showInspector = true }
                .sheet(isPresented: $showInspector) {
                    switch sizingIndex {
                    case 0: M_InspectorSheet().presentationSizing(.form)
                    case 1: M_InspectorSheet().presentationSizing(.page)
                    default: M_InspectorSheet().presentationSizing(.fitted)
                    }
                }
        }
    }
}

private struct M_InspectorSheet: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 12) {
            Text("Inspector").font(.headline)
            Text("This sheet's size comes from presentationSizing.")
            Button("Done") { dismiss() }
                .keyboardShortcut(.defaultAction)
        }
        .padding()
    }
}

private struct M_RedactedExample: View {
    @State private var isLoading = true

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                Circle().fill(.blue.gradient).frame(width: 40)
                VStack(alignment: .leading, spacing: 4) {
                    Text("SwiftUI on macOS 26").font(.headline)
                    Text("Nine minute read · Design").font(.caption)
                }
            }
            .frame(maxWidth: 260, alignment: .leading)
            .redacted(reason: isLoading ? .placeholder : [])
            Toggle("Loading", isOn: $isLoading)
                .toggleStyle(.switch)
        }
    }
}

private struct M_RefreshableExample: View {
    @State private var articles = ["Morning briefing", "Markets open", "Weather"]
    @State private var refreshCount = 0

    var body: some View {
        VStack(spacing: 6) {
            List {
                ForEach(articles, id: \.self) { Label($0, systemImage: "newspaper") }
                M_RefreshRow()
            }
            .frame(height: 130)
            .refreshable {
                try? await Task.sleep(for: .seconds(1))
                refreshCount += 1
                articles.insert("Update #\(refreshCount)", at: 0)
            }
            M_Caption("Pull to refresh on iOS; the row's button calls the same action via @Environment(\\.refresh)")
        }
    }
}

private struct M_RefreshRow: View {
    @Environment(\.refresh) private var refresh
    @State private var isRefreshing = false

    var body: some View {
        Button {
            guard let refresh else { return }
            isRefreshing = true
            Task {
                await refresh()
                isRefreshing = false
            }
        } label: {
            if isRefreshing {
                ProgressView().controlSize(.small)
            } else {
                Label("Refresh now", systemImage: "arrow.clockwise")
            }
        }
        .buttonStyle(.borderless)
        .disabled(refresh == nil)
    }
}

private struct M_Rotation3DEffectExample: View {
    @State private var degrees = 30.0

    var body: some View {
        VStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 12)
                .fill(.indigo.gradient)
                .overlay {
                    VStack {
                        Image(systemName: "creditcard")
                        Text("Front").bold()
                    }
                    .foregroundStyle(.white)
                }
                .frame(width: 150, height: 90)
                .rotation3DEffect(
                    .degrees(degrees),
                    axis: (x: 0, y: 1, z: 0)
                )
            Slider(value: $degrees, in: 0...180)
                .frame(width: 200)
            Text("\(Int(degrees))° around the y axis")
                .font(.caption.monospacedDigit())
                .foregroundStyle(.secondary)
        }
    }
}

private struct M_SafeAreaInsetExample: View {
    @State private var draft = ""
    @State private var messages = ["Hey! Are we still on for lunch?", "Yes — noon works.", "Perfect, see you there."]

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 6) {
                ForEach(messages.indices, id: \.self) { i in
                    Text(messages[i])
                        .padding(8)
                        .background(i.isMultiple(of: 2) ? Color.blue.opacity(0.15) : Color.green.opacity(0.15),
                                    in: .rect(cornerRadius: 10))
                }
            }
            .padding(10)
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                TextField("Message", text: $draft)
                    .textFieldStyle(.roundedBorder)
                Button("Send", systemImage: "arrow.up.circle.fill") {
                    guard !draft.isEmpty else { return }
                    messages.append(draft)
                    draft = ""
                }
                .labelStyle(.iconOnly)
            }
            .padding(8)
            .background(.bar)
        }
        .frame(height: 170)
        .background(.quaternary.opacity(0.4), in: .rect(cornerRadius: 10))
    }
}

private struct M_ScrollEdgeEffectStyleExample: View {
    @State private var styleIndex = 0

    private var style: ScrollEdgeEffectStyle? {
        switch styleIndex {
        case 0: return .soft
        case 1: return .hard
        default: return nil
        }
    }

    var body: some View {
        VStack(spacing: 8) {
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(0..<16) { i in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(hue: Double(i) / 16, saturation: 0.6, brightness: 0.9))
                            .frame(height: 30)
                    }
                }
                .padding(10)
            }
            .safeAreaInset(edge: .top) {
                Text("Inbox")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(8)
            }
            .scrollEdgeEffectStyle(style, for: .top)
            .frame(height: 140)
            .clipShape(.rect(cornerRadius: 10))
            Picker("Style", selection: $styleIndex) {
                Text(".soft").tag(0)
                Text(".hard").tag(1)
                Text("nil").tag(2)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 220)
        }
    }
}

private struct M_ScrollPositionExample: View {
    @State private var position = ScrollPosition(idType: Int.self)

    var body: some View {
        VStack(spacing: 8) {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 4) {
                    ForEach(1..<31, id: \.self) { i in
                        Text("Message \(i)")
                            .padding(.horizontal, 10)
                            .padding(.vertical, 2)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollPosition($position)
            .frame(height: 110)
            .background(.quaternary.opacity(0.4), in: .rect(cornerRadius: 8))
            HStack {
                Button("Top") { withAnimation { position.scrollTo(edge: .top) } }
                Button("#15") { withAnimation { position.scrollTo(id: 15, anchor: .top) } }
                Button("Latest") { withAnimation { position.scrollTo(edge: .bottom) } }
            }
            Text("Top visible id: \(position.viewID(type: Int.self).map(String.init) ?? "—")")
                .font(.caption.monospacedDigit())
                .foregroundStyle(.secondary)
        }
        .frame(width: 260)
    }
}

private struct M_ScrollTargetBehaviorExample: View {
    private let cards: [Color] = [.blue, .purple, .pink, .orange, .green, .teal]

    var body: some View {
        VStack(spacing: 6) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 12) {
                    ForEach(cards.indices, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(cards[i].gradient)
                            .frame(width: 140, height: 90)
                            .overlay { Text("Card \(i + 1)").foregroundStyle(.white).bold() }
                    }
                }
                .scrollTargetLayout()
                .padding(.horizontal, 12)
            }
            .scrollTargetBehavior(.viewAligned)
            .frame(height: 100)
            M_Caption("Scroll horizontally — cards settle aligned to the leading edge")
        }
    }
}

private struct M_SearchableExample: View {
    @State private var query = ""
    private let parks = ["Yosemite", "Zion", "Acadia", "Olympic", "Glacier", "Arches"]

    private var results: [String] {
        query.isEmpty ? parks : parks.filter { $0.localizedCaseInsensitiveContains(query) }
    }

    var body: some View {
        VStack(spacing: 6) {
            HStack {
                Image(systemName: "magnifyingglass").foregroundStyle(.secondary)
                TextField("Search parks", text: $query).textFieldStyle(.plain)
            }
            .padding(6)
            .background(.quaternary, in: .rect(cornerRadius: 8))
            List(results, id: \.self) { Label($0, systemImage: "tree") }
                .frame(height: 100)
            M_Caption("Illustrative — on macOS the real search field lives in the window toolbar")
        }
        .frame(maxWidth: 280)
    }
}

private struct M_SearchToolbarBehaviorExample: View {
    @State private var minimized = true

    var body: some View {
        VStack(spacing: 10) {
            M_PhoneMock {
                VStack(spacing: 8) {
                    HStack {
                        Text("Parks").font(.caption.bold())
                        Spacer()
                        if minimized {
                            Image(systemName: "magnifyingglass")
                                .font(.caption)
                                .padding(6)
                                .background(.regularMaterial, in: .circle)
                        }
                    }
                    if !minimized {
                        HStack(spacing: 4) {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                            Spacer()
                        }
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(6)
                        .background(.regularMaterial, in: .capsule)
                    }
                    M_PlaceholderRows(count: 4).padding(.horizontal, -10)
                    Spacer()
                }
                .padding(10)
            }
            Toggle("Minimized", isOn: $minimized)
                .toggleStyle(.switch)
            M_Caption("Illustrative — iOS only")
        }
        .animation(.snappy, value: minimized)
    }
}

private struct M_SensoryFeedbackExample: View {
    @State private var armed = false

    var body: some View {
        VStack(spacing: 10) {
            Toggle("Armed", isOn: $armed)
                .toggleStyle(.switch)
                .sensoryFeedback(.success, trigger: armed) { _, new in
                    new == true
                }
            Label(armed ? "Armed" : "Disarmed", systemImage: armed ? "shield.checkered" : "shield.slash")
                .foregroundStyle(armed ? Color.green : Color.secondary)
            M_Caption("Plays .success haptics on Macs with a Force Touch trackpad when armed")
        }
    }
}

private struct M_Contact: Identifiable {
    let id = UUID()
    let name: String
    let phone: String
}

private struct M_SheetExample: View {
    @State private var editingContact: M_Contact?
    private let contacts = [
        M_Contact(name: "Ada Lovelace", phone: "555-0101"),
        M_Contact(name: "Grace Hopper", phone: "555-0142"),
        M_Contact(name: "Alan Turing", phone: "555-0187"),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ForEach(contacts) { contact in
                Button {
                    editingContact = contact
                } label: {
                    Label(contact.name, systemImage: "person.crop.circle")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .buttonStyle(.bordered)
            }
        }
        .frame(maxWidth: 240)
        .sheet(item: $editingContact) { contact in
            M_ContactEditor(contact: contact)
        }
    }
}

private struct M_ContactEditor: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name: String
    let contact: M_Contact

    init(contact: M_Contact) {
        self.contact = contact
        _name = State(initialValue: contact.name)
    }

    var body: some View {
        Form {
            TextField("Name", text: $name)
            LabeledContent("Phone", value: contact.phone)
            Button("Done") { dismiss() }
                .keyboardShortcut(.defaultAction)
        }
        .padding()
        .frame(width: 280)
    }
}

private struct M_SwipeActionsExample: View {
    @State private var items = ["Groceries", "Call the bank", "Book flights", "Renew passport"]
    @State private var pinned: Set<String> = []

    var body: some View {
        VStack(spacing: 6) {
            List(items, id: \.self) { item in
                Label(item, systemImage: pinned.contains(item) ? "pin.fill" : "checklist")
                    .swipeActions(edge: .trailing) {
                        Button("Delete", role: .destructive) {
                            items.removeAll { $0 == item }
                        }
                        Button("Pin", systemImage: "pin") { pinned.insert(item) }
                            .tint(.yellow)
                    }
            }
            .frame(height: 120)
            M_Caption("Swipe a row to the left with the trackpad")
        }
    }
}

private struct M_TabBarMinimizeBehaviorExample: View {
    @State private var scrolledDown = false

    var body: some View {
        VStack(spacing: 10) {
            M_PhoneMock {
                VStack(spacing: 8) {
                    Text("Home").font(.caption.bold()).padding(.top, 10)
                    M_PlaceholderRows(count: scrolledDown ? 7 : 5)
                    Spacer()
                    HStack(spacing: 18) {
                        Image(systemName: "house.fill")
                        if !scrolledDown {
                            Image(systemName: "magnifyingglass")
                        }
                    }
                    .font(scrolledDown ? .caption : .body)
                    .padding(scrolledDown ? 6 : 10)
                    .background(.regularMaterial, in: .capsule)
                    .frame(maxWidth: .infinity, alignment: scrolledDown ? .trailing : .center)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 8)
                }
            }
            Toggle("Scrolled down", isOn: $scrolledDown)
                .toggleStyle(.switch)
            M_Caption("Illustrative — iOS only")
        }
        .animation(.snappy, value: scrolledDown)
    }
}

private struct M_TaskExample: View {
    @State private var articles: [String] = []
    @State private var reloadToken = 0

    var body: some View {
        VStack(spacing: 8) {
            Group {
                if articles.isEmpty {
                    ProgressView("Loading articles…")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(articles, id: \.self) { Label($0, systemImage: "newspaper") }
                }
            }
            .frame(height: 110)
            .task {
                articles = await loadArticles()
            }
            .id(reloadToken)
            Button("Reload") {
                articles = []
                reloadToken += 1
            }
        }
    }

    private func loadArticles() async -> [String] {
        try? await Task.sleep(for: .seconds(1))
        return ["SwiftUI on macOS 26", "Liquid Glass in practice", "Async work in views"]
    }
}

private struct M_TextSelectionExample: View {
    private let serialNumber = "C02XK1ZQJG5H-7F3A"

    var body: some View {
        VStack(spacing: 8) {
            Text(serialNumber)
                .font(.system(.body, design: .monospaced))
                .padding(8)
                .background(.quaternary, in: .rect(cornerRadius: 6))
                .textSelection(.enabled)
            M_Caption("Drag to select, then ⌘C to copy")
        }
    }
}

private enum M_TintChoice: String, CaseIterable, Identifiable {
    case red, blue, green, orange
    var id: String { rawValue }
    var color: Color {
        switch self {
        case .red: return .red
        case .blue: return .blue
        case .green: return .green
        case .orange: return .orange
        }
    }
}

private struct M_TintExample: View {
    @State private var armed = true
    @State private var level = 0.6
    @State private var choice: M_TintChoice = .red

    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 8) {
                Toggle("Alarm", isOn: $armed).toggleStyle(.switch)
                Slider(value: $level, in: 0...1)
                Button("Snooze") { }.buttonStyle(.borderedProminent)
            }
            .tint(choice.color)
            Picker("Tint", selection: $choice) {
                ForEach(M_TintChoice.allCases) { Text($0.rawValue).tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
        }
        .frame(width: 240)
    }
}

private struct M_ToolbarExample: View {
    @State private var count = 3

    var body: some View {
        VStack(spacing: 8) {
            VStack(spacing: 0) {
                HStack {
                    Text("Notes").font(.headline)
                    Spacer()
                    Button("Add", systemImage: "plus") { count += 1 }
                        .labelStyle(.iconOnly)
                }
                .padding(8)
                .background(.bar)
                Divider()
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(0..<count, id: \.self) { i in
                        Label("Note \(i + 1)", systemImage: "note.text")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
            }
            .frame(maxWidth: 280)
            .background(.quaternary.opacity(0.4), in: .rect(cornerRadius: 10))
            M_Caption("Illustrative — on macOS, .primaryAction items render in the window toolbar")
        }
    }
}

private struct M_ToolbarBackgroundExample: View {
    @State private var isVisible = true

    var body: some View {
        VStack(spacing: 8) {
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Settings").font(.headline)
                    Spacer()
                }
                .foregroundStyle(isVisible ? Color.white : Color.primary)
                .padding(10)
                .background(isVisible ? AnyShapeStyle(.indigo) : AnyShapeStyle(.bar))
                VStack(alignment: .leading, spacing: 6) {
                    Label("Notifications", systemImage: "bell")
                    Label("Appearance", systemImage: "paintbrush")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
            }
            .frame(maxWidth: 280)
            .background(.quaternary.opacity(0.4), in: .rect(cornerRadius: 10))
            .clipShape(.rect(cornerRadius: 10))
            Toggle("toolbarBackground(.visible)", isOn: $isVisible)
                .toggleStyle(.switch)
            M_Caption("Illustrative — .navigationBar is an iOS placement; macOS uses .windowToolbar")
        }
    }
}

private struct M_VisualEffectExample: View {
    var body: some View {
        VStack(spacing: 6) {
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(0..<14) { i in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.mint.gradient)
                            .frame(height: 34)
                            .overlay { Text("Row \(i + 1)").font(.caption.bold()) }
                            .visualEffect { effect, proxy in
                                effect.blur(radius: max(0, -proxy.frame(in: .scrollView).minY / 6))
                            }
                    }
                }
                .padding(.horizontal, 12)
            }
            .frame(height: 140)
            .background(.quaternary.opacity(0.4), in: .rect(cornerRadius: 10))
            M_Caption("Scroll — rows blur as they leave through the top edge")
        }
        .frame(width: 260)
    }
}

private struct M_ZIndexExample: View {
    @State private var toastOnTop = true

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Text("Saved ✓")
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(.orange, in: .capsule)
                    .foregroundStyle(.white)
                    .zIndex(toastOnTop ? 1 : 0)
                RoundedRectangle(cornerRadius: 12)
                    .fill(.blue.gradient)
                    .frame(width: 160, height: 80)
                    .offset(x: 30, y: 12)
            }
            .frame(height: 110)
            Toggle("Toast has zIndex(1)", isOn: $toastOnTop)
                .toggleStyle(.switch)
        }
    }
}
