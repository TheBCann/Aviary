//
//  ChildExamples+Part11.swift
//  Aviary
//
//  Compiled renderings for variant entries (part 11: views).
//  One private C11_* struct per variant; every rendering exercises the exact
//  overload the variant names, so siblings can be compared side by side.
//

import SwiftUI

enum ChildExamplesPart11 {
    static let entries: [ChildExampleEntry] = [

        // MARK: ScrollView

        ChildExampleEntry(parent: "ScrollView", child: "ScrollView(_:showsIndicators:content:)", code: """
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(cards) { CardView($0) }
            }
            .padding(.horizontal)
        }

        ScrollView(.horizontal, showsIndicators: true) {   // sibling for comparison
            LazyHStack(spacing: 12) { ForEach(cards) { CardView($0) } }
        }
        """) { AnyView(C11_ScrollViewShowsIndicatorsExample()) },

        // MARK: ScrollViewReader

        ChildExampleEntry(parent: "ScrollViewReader", child: "ScrollViewReader(content:)", code: """
        ScrollViewReader { proxy in
            HStack {
                ForEach(chapters) { chapter in
                    Button(chapter.id) {
                        withAnimation { proxy.scrollTo(chapter.id, anchor: .top) }
                    }
                }
            }
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(chapters) { ChapterCard($0).id($0.id) }
                }
            }
        }
        """) { AnyView(C11_ScrollViewReaderExample()) },

        ChildExampleEntry(parent: "ScrollViewReader", child: "ScrollViewProxy.scrollTo(_:anchor:)", code: """
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack { ForEach(1...40, id: \\.self) { Text("Row \\($0)").id($0) } }
            }
            Button("Jump to top") {
                withAnimation { proxy.scrollTo(1, anchor: .top) }
            }
            Button("Row 20 → center") {
                withAnimation { proxy.scrollTo(20, anchor: .center) }
            }
        }
        """) { AnyView(C11_ScrollToAnchorExample()) },

        // MARK: Section

        ChildExampleEntry(parent: "Section", child: "Section(_:content:)", code: """
        Form {
            Section("Notifications") {
                Toggle("Sound", isOn: $sound)
                Toggle("Badge", isOn: $badge)
            }
        }
        .formStyle(.grouped)
        """) { AnyView(C11_SectionTitledExample()) },

        ChildExampleEntry(parent: "Section", child: "Section(content:header:)", code: """
        List {
            Section {
                ForEach(today, id: \\.self) { Label($0, systemImage: "calendar") }
            } header: {
                Label("Today", systemImage: "sun.max")
            }
        }
        """) { AnyView(C11_SectionHeaderExample()) },

        ChildExampleEntry(parent: "Section", child: "Section(content:header:footer:)", code: """
        Form {
            Section {
                TextField("Server", text: $host)
            } header: {
                Text("Connection")
            } footer: {
                Text("Changes apply after reconnecting.")
            }
        }
        .formStyle(.grouped)
        """) { AnyView(C11_SectionHeaderFooterExample()) },

        ChildExampleEntry(parent: "Section", child: "Section(isExpanded:content:header:)", code: """
        Toggle("Show archive", isOn: $showArchive)

        List {
            Section(isExpanded: $showArchive) {
                ForEach(archived, id: \\.self) { Text($0) }
            } header: {
                Text("Archive")
            }
        }
        .listStyle(.sidebar)
        """) { AnyView(C11_SectionExpandedExample()) },

        // MARK: SecureField

        ChildExampleEntry(parent: "SecureField", child: "SecureField(_:text:)", code: """
        SecureField("Password", text: $password)
            .textContentType(.password)
        Text("\\(password.count) characters entered")
        """) { AnyView(C11_SecureFieldBasicExample()) },

        ChildExampleEntry(parent: "SecureField", child: "SecureField(_:text:prompt:)", code: """
        SecureField("Passphrase", text: $passphrase, prompt: Text("At least 12 characters"))
        ProgressView(value: min(Double(passphrase.count), 12), total: 12)
        """) { AnyView(C11_SecureFieldPromptExample()) },

        ChildExampleEntry(parent: "SecureField", child: "SecureField(text:prompt:label:)", code: """
        Form {
            SecureField(text: $passcode, prompt: Text("6 digits")) {
                Label("Passcode", systemImage: "lock")
            }
        }
        .formStyle(.grouped)
        """) { AnyView(C11_SecureFieldLabelExample()) },

        // MARK: SettingsLink

        ChildExampleEntry(parent: "SettingsLink", child: "SettingsLink()", code: """
        // In the App's commands this replaces the standard "Settings…" item:
        CommandGroup(replacing: .appSettings) {
            SettingsLink()
                .keyboardShortcut(",", modifiers: .command)
        }

        // Rendered here as a plain view — the system supplies the title:
        SettingsLink()
        """) { AnyView(C11_SettingsLinkDefaultExample()) },

        ChildExampleEntry(parent: "SettingsLink", child: "SettingsLink(label:)", code: """
        SettingsLink {
            Label("Preferences", systemImage: "gearshape")
        }
        """) { AnyView(C11_SettingsLinkLabelExample()) },

        // MARK: ShareLink

        ChildExampleEntry(parent: "ShareLink", child: "ShareLink(item:subject:message:)", code: """
        let articleURL = URL(string: "https://developer.apple.com/swiftui/")!

        ShareLink(
            item: articleURL,
            subject: Text("Worth a read"),
            message: Text("Found this today.")
        )
        """) { AnyView(C11_ShareLinkItemExample()) },

        ChildExampleEntry(parent: "ShareLink", child: "ShareLink(item:subject:message:label:)", code: """
        ShareLink(item: pageURL, subject: Text("Look at this page"), message: Text("Check this out")) {
            Label("Share Page", systemImage: "square.and.arrow.up")
        }
        """) { AnyView(C11_ShareLinkLabelExample()) },

        ChildExampleEntry(parent: "ShareLink", child: "ShareLink(item:subject:message:preview:)", code: """
        struct Recipe: Transferable {
            var title: String, summary: String
            static var transferRepresentation: some TransferRepresentation {
                ProxyRepresentation(exporting: \\.summary)
            }
        }

        ShareLink(
            item: recipe,
            subject: Text("Recipe"),
            message: Text("Tonight's dinner"),
            preview: SharePreview(recipe.title, image: Image(systemName: "fork.knife"))
        )
        """) { AnyView(C11_ShareLinkPreviewExample()) },

        ChildExampleEntry(parent: "ShareLink", child: "ShareLink(items:subject:message:)", code: """
        let urls = bookmarks.map(\\.url)

        ShareLink(items: urls, subject: Text("Reading list"), message: Text("\\(urls.count) links"))
            .disabled(urls.isEmpty)
        """) { AnyView(C11_ShareLinkItemsExample()) },

        // MARK: SignInWithAppleButton

        ChildExampleEntry(parent: "SignInWithAppleButton", child: "SignInWithAppleButton(_:onRequest:onCompletion:)", code: """
        import AuthenticationServices

        SignInWithAppleButton(.signUp) { request in
            request.requestedScopes = [.fullName, .email]
        } onCompletion: { result in
            switch result {
            case .success(let auth): store(auth)
            case .failure(let error): report(error)
            }
        }
        .signInWithAppleButtonStyle(.black)
        .frame(height: 40)
        """) { AnyView(C11_SignInWithAppleExample()) },

        ChildExampleEntry(parent: "SignInWithAppleButton", child: "SignInWithAppleButton.Label", code: """
        SignInWithAppleButton(.signIn)   { _ in } onCompletion: { _ in }
        SignInWithAppleButton(.signUp)   { _ in } onCompletion: { _ in }
        SignInWithAppleButton(.continue) { _ in } onCompletion: { _ in }
        """) { AnyView(C11_SignInWithAppleLabelExample()) },

        // MARK: Slider

        ChildExampleEntry(parent: "Slider", child: "Slider(value:in:)", code: """
        @State private var brightness = 0.8

        Slider(value: $brightness, in: 0...1)
        Image(systemName: "sun.max.fill")
            .opacity(0.2 + brightness * 0.8)
        """) { AnyView(C11_SliderRangeExample()) },

        ChildExampleEntry(parent: "Slider", child: "Slider(value:in:step:)", code: """
        @State private var rating = 3.0

        Slider(value: $rating, in: 0...5, step: 0.5)   // thumb snaps to halves
        Text(String(format: "%.1f", rating))
        """) { AnyView(C11_SliderStepExample()) },

        ChildExampleEntry(parent: "Slider", child: "Slider(value:in:onEditingChanged:)", code: """
        Slider(value: $exposure, in: -2...2) { editing in
            isScrubbing = editing        // true on drag start, false on release
        }
        preview
            .blur(radius: isScrubbing ? 2 : 0)   // cheap while scrubbing, sharp when committed
        """) { AnyView(C11_SliderEditingChangedExample()) },

        // MARK: SpriteView

        ChildExampleEntry(parent: "SpriteView", child: "SpriteView(scene:)", code: """
        import SpriteKit

        SpriteView(scene: GameScene(size: CGSize(width: 320, height: 150)))
            .frame(height: 150)
        """) { AnyView(C11_SpriteViewSceneExample()) },

        ChildExampleEntry(parent: "SpriteView", child: "SpriteView(scene:transition:isPaused:preferredFramesPerSecond:options:)", code: """
        SpriteView(
            scene: level,
            transition: .crossFade(withDuration: 0.4),
            isPaused: isInMenu,
            preferredFramesPerSecond: 120,
            options: [.ignoresSiblingOrder]
        )
        Toggle("isPaused (isInMenu)", isOn: $isInMenu)
        """) { AnyView(C11_SpriteViewConfiguredExample()) },

        ChildExampleEntry(parent: "SpriteView", child: "SpriteView.Options", code: """
        SpriteView(
            scene: hudScene,   // a scene whose backgroundColor is .clear
            options: allowsTransparency ? [.allowsTransparency, .shouldCullNonVisibleNodes]
                                        : [.shouldCullNonVisibleNodes]
        )
        .background(LinearGradient(colors: [.indigo, .pink], startPoint: .leading, endPoint: .trailing))
        """) { AnyView(C11_SpriteViewOptionsExample()) },

        // MARK: Stepper

        ChildExampleEntry(parent: "Stepper", child: "Stepper(_:value:in:step:)", code: """
        @State private var volume = 50

        Stepper("Volume: \\(volume)%", value: $volume, in: 0...100, step: 10)
        """) { AnyView(C11_StepperRangeStepExample()) },

        ChildExampleEntry(parent: "Stepper", child: "Stepper(_:value:step:)", code: """
        @State private var offset = 0

        Stepper("Offset: \\(offset)", value: $offset, step: 5)   // no bounds — may go negative
        """) { AnyView(C11_StepperStepExample()) },

        ChildExampleEntry(parent: "Stepper", child: "Stepper(_:onIncrement:onDecrement:)", code: """
        Stepper("Font size") {
            fontSize += 2
        } onDecrement: {
            fontSize = max(8, fontSize - 2)
        }
        Text("Sample").font(.system(size: fontSize))
        """) { AnyView(C11_StepperClosuresExample()) },

        ChildExampleEntry(parent: "Stepper", child: "Stepper(value:in:step:label:)", code: """
        Stepper(value: $guests, in: 1...8, step: 1) {
            Label("\\(guests) guests", systemImage: "person.2")
        }
        """) { AnyView(C11_StepperLabelExample()) },

        // MARK: Table

        ChildExampleEntry(parent: "Table", child: "Table(_:columns:)", code: """
        Table(employees) {
            TableColumn("Name", value: \\.name)
            TableColumn("Team", value: \\.team)
            TableColumn("Role", value: \\.role)
        }
        """) { AnyView(C11_TableBasicExample()) },

        ChildExampleEntry(parent: "Table", child: "Table(_:selection:sortOrder:columns:)", code: """
        @State private var selection = Set<Person.ID>()
        @State private var order = [KeyPathComparator(\\Person.name)]

        Table(people.sorted(using: order), selection: $selection, sortOrder: $order) {
            TableColumn("Name", value: \\.name)
            TableColumn("Email", value: \\.email)
        }
        Text("\\(selection.count) selected")
        """) { AnyView(C11_TableSelectionSortExample()) },

        ChildExampleEntry(parent: "Table", child: "Table(_:children:columns:)", code: """
        struct Item: Identifiable {
            let id = UUID(), name: String, bytes: Int64
            var children: [Item]?          // nil → leaf row, non-nil → expandable
        }

        Table(folders, children: \\.children) {
            TableColumn("Name", value: \\.name)
            TableColumn("Size") { item in
                Text(item.bytes, format: .byteCount(style: .file))
            }
        }
        """) { AnyView(C11_TableChildrenExample()) },

        ChildExampleEntry(parent: "Table", child: "TableColumn(_:value:content:)", code: """
        Table(people.sorted(using: order), sortOrder: $order) {
            TableColumn("Name", value: \\.name)
            TableColumn("Joined", value: \\.joinDate) { person in   // sorts by Date, renders custom
                Text(person.joinDate, style: .date)
                    .foregroundStyle(.secondary)
            }
        }
        """) { AnyView(C11_TableColumnValueContentExample()) },

        // MARK: TabView

        ChildExampleEntry(parent: "TabView", child: "TabView(selection:content:)", code: """
        enum Page: Hashable { case library, search, settings }
        @State private var selection: Page = .library

        TabView(selection: $selection) {
            Tab("Library", systemImage: "books.vertical", value: Page.library) { LibraryView() }
            Tab("Search", systemImage: "magnifyingglass", value: Page.search) { SearchView() }
            Tab("Settings", systemImage: "gear", value: Page.settings) { SettingsView() }
        }
        Button("Deep-link to Search") { selection = .search }   // writing the binding switches tabs
        """) { AnyView(C11_TabViewSelectionExample()) },

        ChildExampleEntry(parent: "TabView", child: "Tab(_:systemImage:value:content:)", code: """
        TabView(selection: $selection) {
            Tab("Settings", systemImage: "gear", value: Page.settings) {
                SettingsView()
            }
            Tab("Account", systemImage: "person.crop.circle", value: Page.account) {
                AccountView()
            }
        }
        """) { AnyView(C11_TabDeclarationExample()) },

        // MARK: Text

        ChildExampleEntry(parent: "Text", child: "Text(_:)", code: """
        Text("Welcome back, **\\(username)**")      // literal → LocalizedStringKey, Markdown parsed
            .font(.headline)
        Text("Tap *Sync* to pull `\\(pending)` changes")
        """) { AnyView(C11_TextLiteralExample()) },

        ChildExampleEntry(parent: "Text", child: "Text(verbatim:)", code: """
        Text(verbatim: "v2.1.0-beta+build.417")      // no localization lookup
            .monospaced()
        Text(verbatim: "**not bold** — Markdown is left alone")
        Text("**bold** — the literal form parses it")
        """) { AnyView(C11_TextVerbatimExample()) },

        ChildExampleEntry(parent: "Text", child: "Text(_:style:)", code: """
        Text(start, style: .time)
        Text(start, style: .relative)   // "5 seconds" — keeps ticking on its own
        Text(start, style: .timer)      // "0:05"
        Text(start, style: .offset)     // "+5 seconds"
        """) { AnyView(C11_TextDateStyleExample()) },

        ChildExampleEntry(parent: "Text", child: "Text(_:format:)", code: """
        Text(price, format: .currency(code: "USD"))
        Text(distance, format: .number.precision(.fractionLength(1)))
        Text(ratio, format: .percent)
        Text(bytes, format: .byteCount(style: .file))
        """) { AnyView(C11_TextFormatExample()) },

        // MARK: TextEditor

        ChildExampleEntry(parent: "TextEditor", child: "TextEditor(text:)", code: """
        @State private var draft = ""

        TextEditor(text: $draft)
            .font(.body)
            .frame(height: 110)
        Text("\\(draft.count) characters")
        """) { AnyView(C11_TextEditorExample()) },

        ChildExampleEntry(parent: "TextEditor", child: "TextEditor(text:selection:)", code: """
        @State private var draft = "Select part of this text…"
        @State private var selection: TextSelection?

        TextEditor(text: $draft, selection: $selection)
        Button("Select all") {
            selection = TextSelection(range: draft.startIndex..<draft.endIndex)
        }
        Button("Caret to end") {
            selection = TextSelection(insertionPoint: draft.endIndex)
        }
        """) { AnyView(C11_TextEditorSelectionExample()) },

        // MARK: TextField

        ChildExampleEntry(parent: "TextField", child: "TextField(_:text:)", code: """
        @State private var name = ""

        TextField("Name", text: $name)
        Text(name.isEmpty ? "Hello, stranger" : "Hello, \\(name)")
        """) { AnyView(C11_TextFieldBasicExample()) },

        ChildExampleEntry(parent: "TextField", child: "TextField(_:text:prompt:)", code: """
        Form {
            // "Email" labels the row; the prompt shows inside the empty field.
            TextField("Email", text: $email, prompt: Text("name@example.com"))
        }
        .formStyle(.grouped)
        """) { AnyView(C11_TextFieldPromptExample()) },

        ChildExampleEntry(parent: "TextField", child: "TextField(_:value:format:)", code: """
        @State private var amount = 0.0

        TextField("Amount", value: $amount, format: .currency(code: "USD"))
        Text("Parsed value: " + String(format: "%.2f", amount))   // unchanged on invalid input
        """) { AnyView(C11_TextFieldValueFormatExample()) },

        ChildExampleEntry(parent: "TextField", child: "TextField(_:text:axis:)", code: """
        TextField("Comment", text: $comment, axis: .vertical)
            .lineLimit(1...5)     // grows from one line up to five as text wraps
        """) { AnyView(C11_TextFieldAxisExample()) },

        // MARK: TextFieldLink

        ChildExampleEntry(parent: "TextFieldLink", child: "TextFieldLink(_:prompt:onSubmit:)", code: """
        // watchOS
        TextFieldLink("Nickname", prompt: Text("What should we call you?")) { value in
            nickname = value
        }
        """) { AnyView(C11_TextFieldLinkTitledExample()) },

        ChildExampleEntry(parent: "TextFieldLink", child: "TextFieldLink(prompt:label:onSubmit:)", code: """
        // watchOS
        TextFieldLink(prompt: Text("City")) {
            Label("Set city", systemImage: "mappin")
        } onSubmit: { value in
            city = value
        }
        """) { AnyView(C11_TextFieldLinkLabelExample()) },

        // MARK: TimelineView

        ChildExampleEntry(parent: "TimelineView", child: "TimelineView(_:content:)", code: """
        TimelineView(.everyMinute) { context in
            Text(context.date, style: .time)      // re-rendered at each minute boundary
        }
        TimelineView(.periodic(from: .now, by: 1)) { context in
            Text(context.date, format: .dateTime.hour().minute().second())
        }
        """) { AnyView(C11_TimelineViewScheduleExample()) },

        ChildExampleEntry(parent: "TimelineView", child: "TimelineView.Context", code: """
        TimelineView(.periodic(from: .now, by: 1)) { context in
            let fine = context.cadence <= .seconds
            let format: Date.FormatStyle = fine ? .dateTime.hour().minute().second()
                                                : .dateTime.hour().minute()
            Text(context.date, format: format)
            Text("context.cadence = .\\(String(describing: context.cadence))")
        }
        """) { AnyView(C11_TimelineContextExample()) },

        ChildExampleEntry(parent: "TimelineView", child: ".periodic(from:by:)", code: """
        TimelineView(.periodic(from: startDate, by: 0.5)) { context in
            let tick = Int(context.date.timeIntervalSince(startDate) * 2)
            HStack(spacing: 2) {
                Text("Typing")
                Rectangle()                       // a blinking caret
                    .frame(width: 2, height: 22)
                    .opacity(tick.isMultiple(of: 2) ? 1 : 0)
            }
        }
        """) { AnyView(C11_TimelinePeriodicExample()) },

        ChildExampleEntry(parent: "TimelineView", child: ".animation(minimumInterval:paused:)", code: """
        TimelineView(.animation(minimumInterval: 1 / 30, paused: !isRunning)) { context in
            Canvas { ctx, size in
                drawOrbit(in: &ctx, size: size, at: context.date)
            }
        }
        Toggle("Running", isOn: $isRunning)
        """) { AnyView(C11_TimelineAnimationExample()) },

        // MARK: Toggle

        ChildExampleEntry(parent: "Toggle", child: "Toggle(_:isOn:)", code: """
        @State private var notificationsOn = true

        Toggle("Notifications", isOn: $notificationsOn)
        Toggle("Notifications", isOn: $notificationsOn)
            .toggleStyle(.switch)          // same binding, switch appearance
        """) { AnyView(C11_ToggleTitledExample()) },

        ChildExampleEntry(parent: "Toggle", child: "Toggle(_:systemImage:isOn:)", code: """
        Toggle("Airplane Mode", systemImage: "airplane", isOn: $airplane)
        Toggle("Wi-Fi", systemImage: "wifi", isOn: $wifi)
            .toggleStyle(.button)          // the symbol becomes the button's icon
        """) { AnyView(C11_ToggleSystemImageExample()) },

        ChildExampleEntry(parent: "Toggle", child: "Toggle(isOn:label:)", code: """
        Toggle(isOn: $backupEnabled) {
            VStack(alignment: .leading) {
                Text("iCloud Backup")
                Text("Runs nightly on Wi-Fi")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .toggleStyle(.switch)
        """) { AnyView(C11_ToggleLabelExample()) },

        // MARK: VideoPlayer

        ChildExampleEntry(parent: "VideoPlayer", child: "VideoPlayer(player:)", code: """
        import AVKit

        let player = AVPlayer(url: movieURL)

        VideoPlayer(player: player)
            .onAppear { player.play() }      // the view never starts playback itself
        """) { AnyView(C11_VideoPlayerExample()) },

        ChildExampleEntry(parent: "VideoPlayer", child: "VideoPlayer(player:videoOverlay:)", code: """
        VideoPlayer(player: player) {
            VStack {
                Text(caption)
                    .padding(6)
                    .background(.thinMaterial)
                Spacer()
            }
        }
        """) { AnyView(C11_VideoPlayerOverlayExample()) },

        // MARK: WebView

        ChildExampleEntry(parent: "WebView", child: "WebView(url:)", code: """
        import WebKit

        WebView(url: URL(string: "https://developer.apple.com"))
            .ignoresSafeArea(edges: .bottom)
        """) { AnyView(C11_WebViewURLExample()) },

        ChildExampleEntry(parent: "WebView", child: "WebView(_:)", code: """
        @State private var page = WebPage()

        WebView(page)
            .task { page.load(URLRequest(url: startURL)) }
            .navigationTitle(page.title)
        """) { AnyView(C11_WebViewPageExample()) },

        ChildExampleEntry(parent: "WebView", child: "WebPage.load(_:)", code: """
        page.load(URLRequest(url: url))

        if page.isLoading {
            ProgressView(value: page.estimatedProgress)
        }
        """) { AnyView(C11_WebPageLoadExample()) },
    ]
}

// MARK: - ScrollView

private struct C11_ScrollViewShowsIndicatorsExample: View {
    private let colors: [Color] = [.blue, .purple, .pink, .orange, .green, .teal, .indigo, .red]

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("showsIndicators: false").font(.caption).foregroundStyle(.secondary)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) { cards }
                    .padding(.horizontal)
            }
            .frame(height: 76)
            Text("showsIndicators: true").font(.caption).foregroundStyle(.secondary)
            ScrollView(.horizontal, showsIndicators: true) {
                LazyHStack(spacing: 12) { cards }
                    .padding(.horizontal)
            }
            .frame(height: 76)
        }
    }

    private var cards: some View {
        ForEach(Array(colors.enumerated()), id: \.offset) { index, color in
            RoundedRectangle(cornerRadius: 10)
                .fill(color.gradient)
                .frame(width: 110, height: 56)
                .overlay(Text("Card \(index + 1)").font(.caption.bold()).foregroundStyle(.white))
        }
    }
}

// MARK: - ScrollViewReader

private struct C11_ScrollViewReaderExample: View {
    private nonisolated struct Chapter: Identifiable {
        let id: String
        let color: Color
    }

    private let chapters = [
        Chapter(id: "Intro", color: .blue), Chapter(id: "Setup", color: .green),
        Chapter(id: "Usage", color: .orange), Chapter(id: "FAQ", color: .purple),
    ]

    var body: some View {
        ScrollViewReader { proxy in
            VStack(spacing: 8) {
                HStack {
                    ForEach(chapters) { chapter in
                        Button(chapter.id) {
                            withAnimation { proxy.scrollTo(chapter.id, anchor: .top) }
                        }
                    }
                }
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(chapters) { chapter in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(chapter.color.gradient)
                                .frame(height: 110)
                                .overlay(Text(chapter.id).font(.headline).foregroundStyle(.white))
                                .id(chapter.id)
                        }
                    }
                }
                .frame(height: 140)
            }
        }
    }
}

private struct C11_ScrollToAnchorExample: View {
    var body: some View {
        ScrollViewReader { proxy in
            VStack(spacing: 8) {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(1...40, id: \.self) { row in
                            Text("Row \(row)")
                                .padding(.vertical, 4)
                                .padding(.horizontal, 8)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(row == 20 ? Color.accentColor.opacity(0.2) : Color.clear)
                                .id(row)
                        }
                    }
                }
                .frame(height: 130)
                .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
                HStack {
                    Button("Jump to top") {
                        withAnimation { proxy.scrollTo(1, anchor: .top) }
                    }
                    Button("Row 20 → center") {
                        withAnimation { proxy.scrollTo(20, anchor: .center) }
                    }
                    Button("Bottom") {
                        withAnimation { proxy.scrollTo(40, anchor: .bottom) }
                    }
                }
            }
        }
    }
}

// MARK: - Section

private struct C11_SectionTitledExample: View {
    @State private var sound = true
    @State private var badge = false

    var body: some View {
        Form {
            Section("Notifications") {
                Toggle("Sound", isOn: $sound)
                Toggle("Badge", isOn: $badge)
            }
        }
        .formStyle(.grouped)
        .frame(height: 150)
    }
}

private struct C11_SectionHeaderExample: View {
    private let today = ["Standup", "Design review", "1:1 with Sam"]

    var body: some View {
        List {
            Section {
                ForEach(today, id: \.self) { Label($0, systemImage: "calendar") }
            } header: {
                Label("Today", systemImage: "sun.max")
            }
        }
        .frame(height: 150)
    }
}

private struct C11_SectionHeaderFooterExample: View {
    @State private var host = "api.example.com"

    var body: some View {
        Form {
            Section {
                TextField("Server", text: $host)
            } header: {
                Text("Connection")
            } footer: {
                Text("Changes apply after reconnecting.")
            }
        }
        .formStyle(.grouped)
        .frame(height: 150)
    }
}

private struct C11_SectionExpandedExample: View {
    @State private var showArchive = true
    private let archived = ["2023 Q4 report", "Old roadmap", "Launch retro"]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Toggle("Show archive", isOn: $showArchive)
            List {
                Section(isExpanded: $showArchive) {
                    ForEach(archived, id: \.self) { Text($0) }
                } header: {
                    Text("Archive")
                }
            }
            .listStyle(.sidebar)
            .frame(height: 150)
        }
    }
}

// MARK: - SecureField

private struct C11_SecureFieldBasicExample: View {
    @State private var password = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            SecureField("Password", text: $password)
                .textContentType(.password)
            Text("\(password.count) characters entered")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(width: 260)
    }
}

private struct C11_SecureFieldPromptExample: View {
    @State private var passphrase = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            SecureField("Passphrase", text: $passphrase, prompt: Text("At least 12 characters"))
            ProgressView(value: min(Double(passphrase.count), 12), total: 12)
            Text(passphrase.count >= 12 ? "Strong enough" : "\(12 - passphrase.count) more to go")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(width: 260)
    }
}

private struct C11_SecureFieldLabelExample: View {
    @State private var passcode = ""

    var body: some View {
        Form {
            SecureField(text: $passcode, prompt: Text("6 digits")) {
                Label("Passcode", systemImage: "lock")
            }
            Text(passcode.count == 6 ? "Ready" : "\(passcode.count)/6 digits")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .formStyle(.grouped)
        .frame(height: 120)
    }
}

// MARK: - SettingsLink

private struct C11_SettingsLinkDefaultExample: View {
    var body: some View {
        VStack(spacing: 10) {
            SettingsLink()
            Text("System-provided title; opens the app's Settings scene when one is declared.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C11_SettingsLinkLabelExample: View {
    var body: some View {
        VStack(spacing: 10) {
            SettingsLink {
                Label("Preferences", systemImage: "gearshape")
            }
            SettingsLink {
                Label("Preferences", systemImage: "gearshape")
            }
            .buttonStyle(.borderedProminent)
            Text("Any label view; the action is still the Settings scene.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - ShareLink

private struct C11_ShareLinkItemExample: View {
    private let articleURL = URL(string: "https://developer.apple.com/swiftui/") ?? URL(fileURLWithPath: "/")

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ShareLink(
                item: articleURL,
                subject: Text("Worth a read"),
                message: Text("Found this today.")
            )
            Text("Default label; subject and message pre-fill Mail and Messages.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C11_ShareLinkLabelExample: View {
    private let pageURL = URL(string: "https://developer.apple.com/documentation/swiftui/sharelink") ?? URL(fileURLWithPath: "/")

    var body: some View {
        HStack(spacing: 16) {
            ShareLink(item: pageURL, subject: Text("Look at this page"), message: Text("Check this out")) {
                Label("Share Page", systemImage: "square.and.arrow.up")
            }
            ShareLink(item: pageURL, subject: Text("Look at this page"), message: Text("Check this out")) {
                Image(systemName: "square.and.arrow.up.circle.fill")
                    .font(.title)
            }
            .buttonStyle(.plain)
        }
    }
}

private nonisolated struct C11_Recipe: Transferable {
    var title: String
    var summary: String

    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.summary)
    }
}

private struct C11_ShareLinkPreviewExample: View {
    private let recipe = C11_Recipe(title: "Lemon Pasta", summary: "Pasta, lemon zest, parmesan, black pepper.")

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "fork.knife")
                    .font(.title2)
                    .foregroundStyle(.orange)
                VStack(alignment: .leading) {
                    Text(recipe.title).font(.headline)
                    Text(recipe.summary).font(.caption).foregroundStyle(.secondary)
                }
            }
            ShareLink(
                item: recipe,
                subject: Text("Recipe"),
                message: Text("Tonight's dinner"),
                preview: SharePreview(recipe.title, image: Image(systemName: "fork.knife"))
            )
        }
    }
}

private struct C11_ShareLinkItemsExample: View {
    private nonisolated struct Bookmark: Identifiable {
        let id: String
        let url: URL
    }

    private let bookmarks: [Bookmark] = [
        "https://developer.apple.com/swiftui/",
        "https://developer.apple.com/xcode/",
        "https://developer.apple.com/design/",
    ].compactMap { string in
        URL(string: string).map { Bookmark(id: string, url: $0) }
    }

    var body: some View {
        let urls = bookmarks.map(\.url)
        VStack(alignment: .leading, spacing: 8) {
            ForEach(bookmarks) { bookmark in
                Label(bookmark.url.absoluteString, systemImage: "bookmark")
                    .font(.caption)
            }
            ShareLink(items: urls, subject: Text("Reading list"), message: Text("\(urls.count) links"))
                .disabled(urls.isEmpty)
        }
    }
}

// MARK: - SignInWithAppleButton (illustrative — needs the Sign in with Apple capability)

private struct C11_AppleButtonMock: View {
    let title: String

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "apple.logo")
            Text(title).fontWeight(.medium)
        }
        .foregroundStyle(.white)
        .frame(width: 220, height: 40)
        .background(.black, in: RoundedRectangle(cornerRadius: 8))
    }
}

private struct C11_SignInWithAppleExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C11_AppleButtonMock(title: "Sign up with Apple")
            Text("Illustrative — the real button needs the Sign in with Apple capability. onRequest sets the scopes; onCompletion receives the Result.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 320)
        }
    }
}

private struct C11_SignInWithAppleLabelExample: View {
    var body: some View {
        VStack(spacing: 8) {
            labelRow(".signIn", title: "Sign in with Apple")
            labelRow(".signUp", title: "Sign up with Apple")
            labelRow(".continue", title: "Continue with Apple")
            Text("Illustrative — the system localizes these three titles.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private func labelRow(_ label: String, title: String) -> some View {
        HStack(spacing: 12) {
            Text(label)
                .font(.caption.monospaced())
                .frame(width: 72, alignment: .trailing)
            C11_AppleButtonMock(title: title)
        }
    }
}

// MARK: - Slider

private struct C11_SliderRangeExample: View {
    @State private var brightness = 0.8

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: "sun.min")
                Slider(value: $brightness, in: 0...1)
                Image(systemName: "sun.max")
            }
            Image(systemName: "sun.max.fill")
                .font(.system(size: 40))
                .foregroundStyle(.yellow)
                .opacity(0.2 + brightness * 0.8)
            Text(String(format: "%.0f%%", brightness * 100))
                .font(.caption.monospacedDigit())
                .foregroundStyle(.secondary)
        }
        .frame(width: 260)
    }
}

private struct C11_SliderStepExample: View {
    @State private var rating = 3.0

    var body: some View {
        VStack(spacing: 12) {
            Slider(value: $rating, in: 0...5, step: 0.5)
            HStack(spacing: 4) {
                ForEach(1...5, id: \.self) { star in
                    Image(systemName: symbol(for: star))
                        .foregroundStyle(.yellow)
                }
            }
            .font(.title2)
            Text(String(format: "%.1f — snaps to halves", rating))
                .font(.caption.monospacedDigit())
                .foregroundStyle(.secondary)
        }
        .frame(width: 260)
    }

    private func symbol(for star: Int) -> String {
        let value = Double(star)
        if rating >= value { return "star.fill" }
        if rating >= value - 0.5 { return "star.leadinghalf.filled" }
        return "star"
    }
}

private struct C11_SliderEditingChangedExample: View {
    @State private var exposure = 0.0
    @State private var isScrubbing = false

    var body: some View {
        VStack(spacing: 12) {
            Slider(value: $exposure, in: -2...2) { editing in
                isScrubbing = editing
            }
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.orange.gradient)
                .frame(height: 50)
                .brightness(exposure * 0.25)
                .blur(radius: isScrubbing ? 2 : 0)
                .overlay(
                    Text(isScrubbing ? "Scrubbing — cheap preview" : "Idle — full-quality render")
                        .font(.caption.bold())
                        .foregroundStyle(.white)
                )
            Text(String(format: "exposure %+.2f EV", exposure))
                .font(.caption.monospacedDigit())
                .foregroundStyle(.secondary)
        }
        .frame(width: 260)
    }
}

// MARK: - SpriteView (illustrative — a SpriteKit scene renders at runtime)

private struct C11_MockSpriteScene: View {
    var isPaused = false
    var transparent = false

    var body: some View {
        TimelineView(.animation(paused: isPaused)) { context in
            let t = context.date.timeIntervalSinceReferenceDate
            Canvas { ctx, size in
                if !transparent {
                    ctx.fill(Path(CGRect(origin: .zero, size: size)),
                             with: .color(Color(red: 0.08, green: 0.1, blue: 0.2)))
                }
                ctx.fill(Path(CGRect(x: 0, y: size.height - 14, width: size.width, height: 14)),
                         with: .color(.green.opacity(0.85)))
                let bounce = abs(sin(t * 3))
                let ballX = size.width * 0.3 + sin(t * 0.7) * size.width * 0.2
                let ballY = size.height - 14 - 12 - bounce * (size.height - 60)
                ctx.fill(Path(ellipseIn: CGRect(x: ballX - 12, y: ballY - 12, width: 24, height: 24)),
                         with: .color(.orange))
                var spinner = ctx
                spinner.translateBy(x: size.width * 0.75, y: size.height * 0.4)
                spinner.rotate(by: .radians(t))
                spinner.fill(Path(CGRect(x: -14, y: -14, width: 28, height: 28)), with: .color(.yellow))
            }
        }
    }
}

private struct C11_SpriteViewSceneExample: View {
    var body: some View {
        VStack(spacing: 6) {
            C11_MockSpriteScene()
                .frame(height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            Text("Illustrative — a SpriteKit scene renders here at runtime (default frame rate, opaque, running).")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

private struct C11_SpriteViewConfiguredExample: View {
    @State private var isInMenu = false

    var body: some View {
        VStack(spacing: 6) {
            C11_MockSpriteScene(isPaused: isInMenu)
                .frame(height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay {
                    if isInMenu {
                        Text("PAUSED")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding(8)
                            .background(.black.opacity(0.6), in: Capsule())
                    }
                }
            Toggle("isPaused (isInMenu)", isOn: $isInMenu)
            Text("Illustrative — isPaused freezes the update loop; the transition plays when the scene object changes.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

private struct C11_SpriteViewOptionsExample: View {
    @State private var allowsTransparency = true

    var body: some View {
        VStack(spacing: 6) {
            C11_MockSpriteScene(transparent: allowsTransparency)
                .frame(height: 110)
                .background(LinearGradient(colors: [.indigo, .pink], startPoint: .leading, endPoint: .trailing))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            Toggle(".allowsTransparency", isOn: $allowsTransparency)
                .font(.caption.monospaced())
            Text("Illustrative — with allowsTransparency the SwiftUI gradient shows through the scene's clear background.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - Stepper

private struct C11_StepperRangeStepExample: View {
    @State private var volume = 50

    var body: some View {
        VStack(spacing: 10) {
            Stepper("Volume: \(volume)%", value: $volume, in: 0...100, step: 10)
            ProgressView(value: Double(volume), total: 100)
            Text("Clamped to 0...100, moves by 10")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(width: 240)
    }
}

private struct C11_StepperStepExample: View {
    @State private var offset = 0

    var body: some View {
        VStack(spacing: 10) {
            Stepper("Offset: \(offset)", value: $offset, step: 5)
            Circle()
                .fill(Color.accentColor)
                .frame(width: 20, height: 20)
                .offset(x: CGFloat(offset))
                .frame(maxWidth: .infinity)
            Text("No range — negative values allowed")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(width: 240)
    }
}

private struct C11_StepperClosuresExample: View {
    @State private var fontSize: CGFloat = 17

    var body: some View {
        VStack(spacing: 10) {
            Stepper("Font size") {
                fontSize += 2
            } onDecrement: {
                fontSize = max(8, fontSize - 2)
            }
            Text("Sample")
                .font(.system(size: fontSize))
                .frame(height: 50)
            Text(String(format: "%.0f pt", fontSize))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(width: 240)
    }
}

private struct C11_StepperLabelExample: View {
    @State private var guests = 2

    var body: some View {
        VStack(spacing: 10) {
            Stepper(value: $guests, in: 1...8, step: 1) {
                Label("\(guests) guests", systemImage: "person.2")
            }
            HStack(spacing: 4) {
                ForEach(0..<guests, id: \.self) { _ in
                    Image(systemName: "person.fill")
                }
            }
            .foregroundStyle(.tint)
        }
        .frame(width: 240)
    }
}

// MARK: - Table

private nonisolated struct C11_Employee: Identifiable {
    let id = UUID()
    let name: String
    let team: String
    let role: String
    let email: String
    let joinDate: Date

    static let sample: [C11_Employee] = [
        C11_Employee(name: "Ava Chen", team: "Platform", role: "Engineer", email: "ava@example.com", joinDate: Date(timeIntervalSince1970: 1_600_000_000)),
        C11_Employee(name: "Noah Patel", team: "Design", role: "Lead", email: "noah@example.com", joinDate: Date(timeIntervalSince1970: 1_650_000_000)),
        C11_Employee(name: "Mia Rossi", team: "Platform", role: "Manager", email: "mia@example.com", joinDate: Date(timeIntervalSince1970: 1_580_000_000)),
        C11_Employee(name: "Leo Schmidt", team: "Growth", role: "Analyst", email: "leo@example.com", joinDate: Date(timeIntervalSince1970: 1_700_000_000)),
    ]
}

private struct C11_TableBasicExample: View {
    var body: some View {
        Table(C11_Employee.sample) {
            TableColumn("Name", value: \.name)
            TableColumn("Team", value: \.team)
            TableColumn("Role", value: \.role)
        }
        .frame(height: 160)
    }
}

private struct C11_TableSelectionSortExample: View {
    @State private var selection = Set<C11_Employee.ID>()
    @State private var order = [KeyPathComparator(\C11_Employee.name)]

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Table(C11_Employee.sample.sorted(using: order), selection: $selection, sortOrder: $order) {
                TableColumn("Name", value: \.name)
                TableColumn("Email", value: \.email)
            }
            .frame(height: 150)
            Text("\(selection.count) selected · click a header to re-sort")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private nonisolated struct C11_FileItem: Identifiable {
    let id = UUID()
    let name: String
    let bytes: Int64
    var children: [C11_FileItem]?

    static let sample: [C11_FileItem] = [
        C11_FileItem(name: "Documents", bytes: 5_300_000, children: [
            C11_FileItem(name: "Report.pdf", bytes: 4_100_000, children: nil),
            C11_FileItem(name: "Notes.md", bytes: 1_200_000, children: nil),
        ]),
        C11_FileItem(name: "Pictures", bytes: 42_000_000, children: [
            C11_FileItem(name: "Trip", bytes: 42_000_000, children: [
                C11_FileItem(name: "IMG_0001.heic", bytes: 21_000_000, children: nil),
                C11_FileItem(name: "IMG_0002.heic", bytes: 21_000_000, children: nil),
            ]),
        ]),
        C11_FileItem(name: "README.txt", bytes: 1_800, children: nil),
    ]
}

private struct C11_TableChildrenExample: View {
    var body: some View {
        Table(C11_FileItem.sample, children: \.children) {
            TableColumn("Name", value: \.name)
            TableColumn("Size") { item in
                Text(item.bytes, format: .byteCount(style: .file))
            }
        }
        .frame(height: 170)
    }
}

private struct C11_TableColumnValueContentExample: View {
    @State private var order = [KeyPathComparator(\C11_Employee.joinDate)]

    var body: some View {
        Table(C11_Employee.sample.sorted(using: order), sortOrder: $order) {
            TableColumn("Name", value: \.name)
            TableColumn("Joined", value: \.joinDate) { person in
                Text(person.joinDate, style: .date)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(height: 160)
    }
}

// MARK: - TabView

private nonisolated enum C11_Page: Hashable {
    case library, search, settings, account
}

private struct C11_TabPage: View {
    let symbol: String
    let title: String
    let color: Color

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: symbol)
                .font(.largeTitle)
                .foregroundStyle(color)
            Text(title)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

private struct C11_TabViewSelectionExample: View {
    @State private var selection: C11_Page = .library

    var body: some View {
        VStack(spacing: 8) {
            TabView(selection: $selection) {
                Tab("Library", systemImage: "books.vertical", value: C11_Page.library) {
                    C11_TabPage(symbol: "books.vertical", title: "Library", color: .blue)
                }
                Tab("Search", systemImage: "magnifyingglass", value: C11_Page.search) {
                    C11_TabPage(symbol: "magnifyingglass", title: "Search", color: .green)
                }
                Tab("Settings", systemImage: "gear", value: C11_Page.settings) {
                    C11_TabPage(symbol: "gear", title: "Settings", color: .gray)
                }
            }
            .frame(height: 140)
            Button("Deep-link to Search") { selection = .search }
        }
    }
}

private struct C11_TabDeclarationExample: View {
    @State private var selection: C11_Page = .settings

    var body: some View {
        VStack(spacing: 8) {
            TabView(selection: $selection) {
                Tab("Settings", systemImage: "gear", value: C11_Page.settings) {
                    C11_TabPage(symbol: "gear", title: "Settings", color: .gray)
                }
                Tab("Account", systemImage: "person.crop.circle", value: C11_Page.account) {
                    C11_TabPage(symbol: "person.crop.circle", title: "Account", color: .indigo)
                }
            }
            .frame(height: 140)
            Text("Title, icon, selection value, and content declared together — no tabItem needed.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Text

private struct C11_TextLiteralExample: View {
    private let username = "Ada"
    private let pending = 3

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Welcome back, **\(username)**")
                .font(.headline)
            Text("Tap *Sync* to pull `\(pending)` changes")
            Text("Literal → LocalizedStringKey: Markdown is styled and the string is looked up in the bundle.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C11_TextVerbatimExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(verbatim: "v2.1.0-beta+build.417")
                .monospaced()
            Text(verbatim: "**not bold** — Markdown is left alone")
            Text("**bold** — the literal form parses it")
        }
    }
}

private struct C11_TextDateStyleExample: View {
    @State private var start = Date()

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Grid(alignment: .leading, horizontalSpacing: 16, verticalSpacing: 6) {
                GridRow {
                    Text(".time").font(.caption.monospaced())
                    Text(start, style: .time)
                }
                GridRow {
                    Text(".relative").font(.caption.monospaced())
                    Text(start, style: .relative)
                }
                GridRow {
                    Text(".timer").font(.caption.monospaced())
                    Text(start, style: .timer)
                }
                GridRow {
                    Text(".offset").font(.caption.monospaced())
                    Text(start, style: .offset)
                }
            }
            .monospacedDigit()
            Button("Reset start date") { start = Date() }
        }
    }
}

private struct C11_TextFormatExample: View {
    private let price = 1299.5
    private let distance = 12.3456
    private let ratio = 0.375
    private let bytes: Int64 = 48_300_000

    var body: some View {
        Grid(alignment: .leading, horizontalSpacing: 16, verticalSpacing: 6) {
            GridRow {
                Text(verbatim: ".currency(code: \"USD\")").font(.caption.monospaced())
                Text(price, format: .currency(code: "USD"))
            }
            GridRow {
                Text(verbatim: ".number.precision(.fractionLength(1))").font(.caption.monospaced())
                Text(distance, format: .number.precision(.fractionLength(1)))
            }
            GridRow {
                Text(verbatim: ".percent").font(.caption.monospaced())
                Text(ratio, format: .percent)
            }
            GridRow {
                Text(verbatim: ".byteCount(style: .file)").font(.caption.monospaced())
                Text(bytes, format: .byteCount(style: .file))
            }
        }
    }
}

// MARK: - TextEditor

private struct C11_TextEditorExample: View {
    @State private var draft = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            TextEditor(text: $draft)
                .font(.body)
                .frame(height: 110)
                .overlay(alignment: .topLeading) {
                    if draft.isEmpty {
                        Text("Start typing…")
                            .foregroundStyle(.tertiary)
                            .padding(.top, 1)
                            .padding(.leading, 5)
                            .allowsHitTesting(false)
                    }
                }
            Text("\(draft.count) characters · \(draft.split(whereSeparator: \.isWhitespace).count) words")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C11_TextEditorSelectionExample: View {
    @State private var draft = "Select part of this text, or drive the selection from code with the buttons below."
    @State private var selection: TextSelection?

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            TextEditor(text: $draft, selection: $selection)
                .font(.body)
                .frame(height: 90)
            HStack {
                Button("Select all") {
                    selection = TextSelection(range: draft.startIndex..<draft.endIndex)
                }
                Button("Caret to end") {
                    selection = TextSelection(insertionPoint: draft.endIndex)
                }
                Spacer()
                Text(status)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private var status: String {
        guard let selection else { return "no selection" }
        return selection.isInsertion ? "caret only" : "range selected"
    }
}

// MARK: - TextField

private struct C11_TextFieldBasicExample: View {
    @State private var name = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Name", text: $name)
            Text(name.isEmpty ? "Hello, stranger" : "Hello, \(name)")
                .font(.headline)
        }
        .frame(width: 260)
    }
}

private struct C11_TextFieldPromptExample: View {
    @State private var email = ""

    var body: some View {
        Form {
            TextField("Email", text: $email, prompt: Text("name@example.com"))
            Text(email.contains("@") ? "Looks like an address" : "The title labels the row; the prompt fills the empty field")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .formStyle(.grouped)
        .frame(height: 120)
    }
}

private struct C11_TextFieldValueFormatExample: View {
    @State private var amount = 0.0

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Amount", value: $amount, format: .currency(code: "USD"))
            Text("Parsed value: " + String(format: "%.2f", amount))
                .font(.caption.monospacedDigit())
                .foregroundStyle(.secondary)
            Text("Press Return to commit; invalid input leaves the binding untouched.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(width: 280)
    }
}

private struct C11_TextFieldAxisExample: View {
    @State private var comment = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Comment", text: $comment, axis: .vertical)
                .lineLimit(1...5)
            Text("\(comment.count) characters — keep typing to watch the field grow")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(width: 280)
    }
}

// MARK: - TextFieldLink (illustrative — watchOS only)

private struct C11_WatchLinkMock: View {
    let title: String
    var systemImage: String? = nil
    let prompt: String
    let onSubmit: (String) -> Void
    @State var isEntering = false
    @State var typed = ""

    var body: some View {
        VStack(spacing: 8) {
            Button {
                isEntering.toggle()
            } label: {
                HStack {
                    if let systemImage { Image(systemName: systemImage) }
                    Text(title)
                    Spacer()
                    Image(systemName: "chevron.right").foregroundStyle(.secondary)
                }
                .padding(.horizontal, 12)
                .frame(width: 190, height: 40)
                .background(Color(white: 0.2), in: RoundedRectangle(cornerRadius: 12))
                .foregroundStyle(.white)
            }
            .buttonStyle(.plain)
            if isEntering {
                HStack {
                    TextField(prompt, text: $typed)
                        .onSubmit {
                            onSubmit(typed)
                            isEntering = false
                        }
                    Button("Done") {
                        onSubmit(typed)
                        isEntering = false
                    }
                }
                .frame(width: 240)
            }
        }
    }
}

private struct C11_TextFieldLinkTitledExample: View {
    @State private var nickname = "—"

    var body: some View {
        VStack(spacing: 8) {
            C11_WatchLinkMock(title: "Nickname", prompt: "What should we call you?") { nickname = $0 }
            Text("nickname = \"\(nickname)\"")
                .font(.caption.monospaced())
            Text("Illustrative — watchOS only: the link opens system text entry and hands back the typed string.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

private struct C11_TextFieldLinkLabelExample: View {
    @State private var city = "—"

    var body: some View {
        VStack(spacing: 8) {
            C11_WatchLinkMock(title: "Set city", systemImage: "mappin", prompt: "City") { city = $0 }
            Text("city = \"\(city)\"")
                .font(.caption.monospaced())
            Text("Illustrative — watchOS only; the label is your own view.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - TimelineView

private struct C11_TimelineViewScheduleExample: View {
    var body: some View {
        Grid(alignment: .leading, horizontalSpacing: 16, verticalSpacing: 8) {
            GridRow {
                Text(verbatim: ".everyMinute").font(.caption.monospaced())
                TimelineView(.everyMinute) { context in
                    Text(context.date, style: .time)
                }
            }
            GridRow {
                Text(verbatim: ".periodic(from: .now, by: 1)").font(.caption.monospaced())
                TimelineView(.periodic(from: .now, by: 1)) { context in
                    Text(context.date, format: .dateTime.hour().minute().second())
                }
            }
        }
        .monospacedDigit()
    }
}

private struct C11_TimelineContextExample: View {
    var body: some View {
        TimelineView(.periodic(from: .now, by: 1)) { context in
            let fine = context.cadence <= .seconds
            let format: Date.FormatStyle = fine ? .dateTime.hour().minute().second()
                                                : .dateTime.hour().minute()
            VStack(spacing: 6) {
                Text(context.date, format: format)
                    .font(.system(size: 34, weight: .medium, design: .rounded))
                    .monospacedDigit()
                Text("context.cadence = .\(String(describing: context.cadence))")
                    .font(.caption.monospaced())
                    .foregroundStyle(.secondary)
                Text("On an always-on display the cadence drops to .minutes and the seconds are dropped.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

private struct C11_TimelinePeriodicExample: View {
    @State private var startDate = Date()

    var body: some View {
        TimelineView(.periodic(from: startDate, by: 0.5)) { context in
            let tick = Int(context.date.timeIntervalSince(startDate) * 2)
            VStack(spacing: 8) {
                HStack(spacing: 2) {
                    Text("Typing")
                        .font(.title2)
                    Rectangle()
                        .fill(Color.accentColor)
                        .frame(width: 2, height: 22)
                        .opacity(tick.isMultiple(of: 2) ? 1 : 0)
                }
                Text("tick \(tick) · fires every 0.5 s from startDate")
                    .font(.caption.monospacedDigit())
                    .foregroundStyle(.secondary)
            }
        }
    }
}

private struct C11_TimelineAnimationExample: View {
    @State private var isRunning = true

    var body: some View {
        VStack(spacing: 8) {
            TimelineView(.animation(minimumInterval: 1 / 30, paused: !isRunning)) { context in
                Canvas { ctx, size in
                    let center = CGPoint(x: size.width / 2, y: size.height / 2)
                    let radius = min(size.width, size.height) / 2 - 12
                    let orbit = CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2)
                    ctx.stroke(Path(ellipseIn: orbit), with: .color(.secondary), lineWidth: 1)
                    let seconds: Double = context.date.timeIntervalSinceReferenceDate.truncatingRemainder(dividingBy: 4)
                    let angle: Double = seconds / 4 * 2 * .pi
                    let dot = CGPoint(x: center.x + CGFloat(cos(angle)) * radius,
                                      y: center.y + CGFloat(sin(angle)) * radius)
                    ctx.fill(Path(ellipseIn: CGRect(x: dot.x - 8, y: dot.y - 8, width: 16, height: 16)),
                             with: .color(.orange))
                }
            }
            .frame(height: 120)
            Toggle("Running (paused: !isRunning)", isOn: $isRunning)
            Text("minimumInterval: 1 / 30 caps redraws at about 30 fps")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Toggle

private struct C11_ToggleTitledExample: View {
    @State private var notificationsOn = true

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Toggle("Notifications", isOn: $notificationsOn)
            Toggle("Notifications", isOn: $notificationsOn)
                .toggleStyle(.switch)
            Label(notificationsOn ? "Alerts on" : "Alerts off",
                  systemImage: notificationsOn ? "bell.fill" : "bell.slash")
                .foregroundStyle(.secondary)
        }
        .frame(width: 220)
    }
}

private struct C11_ToggleSystemImageExample: View {
    @State private var airplane = false
    @State private var wifi = true

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Toggle("Airplane Mode", systemImage: "airplane", isOn: $airplane)
            Toggle("Wi-Fi", systemImage: "wifi", isOn: $wifi)
                .toggleStyle(.button)
            Text(airplane ? "Radios off" : (wifi ? "Connected" : "Wi-Fi off"))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(width: 220)
    }
}

private struct C11_ToggleLabelExample: View {
    @State private var backupEnabled = true

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Toggle(isOn: $backupEnabled) {
                VStack(alignment: .leading) {
                    Text("iCloud Backup")
                    Text("Runs nightly on Wi-Fi")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .toggleStyle(.switch)
            Text(backupEnabled ? "Next backup: tonight" : "Backups paused")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(width: 260)
    }
}

// MARK: - VideoPlayer (illustrative — plays live media at runtime)

private struct C11_VideoSurfaceMock<Overlay: View>: View {
    private let overlay: Overlay
    @State private var isPlaying = true

    init(@ViewBuilder overlay: () -> Overlay) {
        self.overlay = overlay()
    }

    var body: some View {
        ZStack {
            LinearGradient(colors: [.black, Color(red: 0.1, green: 0.15, blue: 0.3)],
                           startPoint: .top, endPoint: .bottom)
            Image(systemName: "film")
                .font(.system(size: 40))
                .foregroundStyle(.white.opacity(0.25))
            overlay
            VStack {
                Spacer()
                HStack(spacing: 10) {
                    Button {
                        isPlaying.toggle()
                    } label: {
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    }
                    .buttonStyle(.plain)
                    Capsule()
                        .fill(Color.white.opacity(0.3))
                        .frame(height: 4)
                        .overlay(alignment: .leading) {
                            Capsule().fill(Color.white).frame(width: 60, height: 4)
                        }
                    Text("0:42 / 2:10")
                        .font(.caption2.monospacedDigit())
                }
                .foregroundStyle(.white)
                .padding(8)
                .background(.ultraThinMaterial)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

private struct C11_VideoPlayerExample: View {
    var body: some View {
        VStack(spacing: 6) {
            C11_VideoSurfaceMock { EmptyView() }
                .frame(height: 140)
            Text("Illustrative — AVKit's transport controls around the AVPlayer you own; call play() yourself.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

private struct C11_VideoPlayerOverlayExample: View {
    private let caption = "Chapter 2 — The Harbor"

    var body: some View {
        VStack(spacing: 6) {
            C11_VideoSurfaceMock {
                VStack {
                    Text(caption)
                        .padding(6)
                        .background(.thinMaterial)
                    Spacer()
                }
                .padding(8)
            }
            .frame(height: 140)
            Text("Illustrative — the videoOverlay sits on the video surface, beneath the system controls.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - WebView (illustrative — loads live web content at runtime)

private struct C11_BrowserMock: View {
    let address: String
    let title: String
    var progress: Double? = nil

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 8) {
                Image(systemName: "chevron.left").foregroundStyle(.tertiary)
                Image(systemName: "chevron.right").foregroundStyle(.tertiary)
                HStack {
                    Image(systemName: "lock.fill").font(.caption2)
                    Text(address).font(.caption).lineLimit(1)
                    Spacer()
                }
                .padding(.horizontal, 8)
                .frame(height: 24)
                .background(.quaternary, in: RoundedRectangle(cornerRadius: 6))
            }
            .padding(8)
            if let progress {
                ProgressView(value: progress)
                    .progressViewStyle(.linear)
                    .padding(.horizontal, 8)
                    .padding(.bottom, 4)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text(title).font(.headline)
                ForEach(0..<3, id: \.self) { line in
                    Capsule()
                        .fill(.quaternary)
                        .frame(width: line == 2 ? 120 : 200, height: 8)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(12)
            .background(Color(white: 0.98))
        }
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.quaternary))
    }
}

private struct C11_WebViewURLExample: View {
    var body: some View {
        VStack(spacing: 6) {
            C11_BrowserMock(address: "developer.apple.com", title: "Apple Developer")
                .frame(height: 150)
            Text("Illustrative — WebView(url:) loads live web content at runtime.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C11_WebViewPageExample: View {
    var body: some View {
        VStack(spacing: 6) {
            C11_BrowserMock(address: "developer.apple.com/documentation", title: "page.title → \"Documentation\"")
                .frame(height: 150)
            Text("Illustrative — WebView(_:) renders a WebPage you own; its observable title, URL and progress drive your chrome.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

private struct C11_WebPageLoadExample: View {
    @State private var progress = 0.4

    private var isLoading: Bool { progress < 1 }

    var body: some View {
        VStack(spacing: 6) {
            C11_BrowserMock(address: "developer.apple.com/swiftui",
                            title: isLoading ? "Loading…" : "SwiftUI",
                            progress: isLoading ? progress : nil)
                .frame(height: 120)
            Slider(value: $progress, in: 0...1)
                .frame(width: 220)
            Text(isLoading ? String(format: "isLoading · estimatedProgress %.0f%%", progress * 100) : "loaded")
                .font(.caption.monospacedDigit())
                .foregroundStyle(.secondary)
            Text("Illustrative — drag to simulate the progress a real WebPage reports after load(_:).")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
