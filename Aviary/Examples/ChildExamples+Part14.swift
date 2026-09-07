//
//  ChildExamples+Part14.swift
//  Aviary
//
//  Compiled renderings for variant entries (part 14: property-wrappers, scenes).
//  One private C14_* struct per variant; every rendering exercises the exact
//  overload the variant names, so siblings can be compared side by side.
//  Scene-level and iOS-only variants render as faithful illustrations.
//

import SwiftUI
internal import Combine

enum ChildExamplesPart14 {
    static let entries: [ChildExampleEntry] = [

        // MARK: @AppStorage

        ChildExampleEntry(parent: "@AppStorage", child: "init(wrappedValue:_:store:)", code: """
        @AppStorage("aviary.c14.showsSidebar") private var showsSidebar = true
        @AppStorage("aviary.c14.openCount", store: .standard) private var openCount = 0

        Toggle("Show Sidebar", isOn: $showsSidebar)
        Text("Opened \\(openCount) times")
            .onAppear { openCount += 1 }
        """) { AnyView(C14_AppStorageDefaultExample()) },

        ChildExampleEntry(parent: "@AppStorage", child: "init(_:store:)", code: """
        @AppStorage("aviary.c14.lastOpenedPath") private var lastOpenedPath: String?

        Text(lastOpenedPath ?? "Nothing opened yet")
        Button("Open Report.pdf") { lastOpenedPath = "~/Documents/Report.pdf" }
        Button("Forget") { lastOpenedPath = nil }
        """) { AnyView(C14_AppStorageOptionalExample()) },

        ChildExampleEntry(parent: "@AppStorage", child: "init(wrappedValue:_:store:) where Value: RawRepresentable", code: """
        enum Appearance: String, CaseIterable { case system, light, dark }

        @AppStorage("aviary.c14.appearance") private var appearance: Appearance = .system

        Picker("Appearance", selection: $appearance) {
            ForEach(Appearance.allCases, id: \\.self) { Text($0.rawValue.capitalized) }
        }
        .pickerStyle(.segmented)
        """) { AnyView(C14_AppStorageRawExample()) },

        ChildExampleEntry(parent: "@AppStorage", child: "init(wrappedValue:_:store:) — TableColumnCustomization", code: """
        @AppStorage("aviary.c14.PeopleTableLayout")
        private var customization = TableColumnCustomization<Person>()

        Table(people, columnCustomization: $customization) {
            TableColumn("Name", value: \\.name).customizationID("name")
            TableColumn("Role", value: \\.role).customizationID("role")
            TableColumn("Team", value: \\.team).customizationID("team")
        }
        """) { AnyView(C14_AppStorageTableExample()) },

        // MARK: @Bindable

        ChildExampleEntry(parent: "@Bindable", child: "init(wrappedValue:)", code: """
        @Environment(Library.self) private var library

        var body: some View {
            @Bindable var library = library
            TextField("Filter", text: $library.filter)
            ForEach(library.visibleBooks, id: \\.self) { Text($0) }
        }
        """) { AnyView(C14_BindableWrappedValueExample()) },

        ChildExampleEntry(parent: "@Bindable", child: "init(_:)", code: """
        let bindable = Bindable(settings)

        Toggle("Show Ruler", isOn: bindable.showsRuler)
        Slider(value: bindable.zoom, in: 0.5...4)
        """) { AnyView(C14_BindableInitExample()) },

        ChildExampleEntry(parent: "@Bindable", child: "subscript(dynamicMember:)", code: """
        @Bindable var book: Book

        TextField("Title", text: $book.title)
        Stepper("Pages: \\(book.pageCount)", value: $book.pageCount, in: 1...2000)
        Slider(value: $book.rating, in: 0...5)
        """) { AnyView(C14_BindableSubscriptExample()) },

        // MARK: @Binding

        ChildExampleEntry(parent: "@Binding", child: "init(get:set:)", code: """
        @State private var isHidden = false

        let isVisible = Binding(
            get: { !isHidden },
            set: { isHidden = !$0 }
        )
        Toggle("Visible", isOn: isVisible)
        """) { AnyView(C14_BindingGetSetExample()) },

        ChildExampleEntry(parent: "@Binding", child: "constant(_:)", code: """
        Toggle("Locked", isOn: .constant(true))
        Slider(value: .constant(0.3))
        """) { AnyView(C14_BindingConstantExample()) },

        ChildExampleEntry(parent: "@Binding", child: "init(_:)", code: """
        @State private var draft: String?

        if let text = Binding($draft) {
            TextField("Draft", text: text)
            Button("Discard Draft") { draft = nil }
        } else {
            Button("Start Draft") { draft = "" }
        }
        """) { AnyView(C14_BindingUnwrapExample()) },

        ChildExampleEntry(parent: "@Binding", child: "animation(_:)", code: """
        @State private var isExpanded = false

        Toggle("Details", isOn: $isExpanded.animation(.snappy))
        if isExpanded { DetailPanel() }
        """) { AnyView(C14_BindingAnimationExample()) },

        // MARK: @Entry

        ChildExampleEntry(parent: "@Entry", child: "@Entry in ContainerValues", code: """
        extension ContainerValues {
            @Entry var isPinned = false
        }

        // child: Text("Inbox").containerValue(\\.isPinned, true)
        ForEach(subviews: content) { subview in
            subview.bold(subview.containerValues.isPinned)
        }
        """) { AnyView(C14_EntryContainerExample()) },

        ChildExampleEntry(parent: "@Entry", child: "@Entry in FocusedValues", code: """
        extension FocusedValues {
            @Entry var selectedNote: String?
        }

        TextField("Note A", text: $meeting)
            .focusedValue(\\.selectedNote, meeting)
        // consumer: @FocusedValue(\\.selectedNote) var note
        """) { AnyView(C14_EntryFocusedExample()) },

        ChildExampleEntry(parent: "@Entry", child: "@Entry in Transaction", code: """
        extension Transaction {
            @Entry var isUndoing = false
        }

        Button("Undo") { withTransaction(\\.isUndoing, true) { offset = 0 } }
        // read it:
        .transaction { t in t.animation = t.isUndoing ? nil : .spring(duration: 0.6) }
        """) { AnyView(C14_EntryTransactionExample()) },

        // MARK: @Environment

        ChildExampleEntry(parent: "@Environment", child: "init(_:) — EnvironmentValues key path", code: """
        @Environment(\\.locale) private var locale
        @Environment(\\.colorScheme) private var colorScheme
        @Environment(\\.dismiss) private var dismiss

        Text(Date.now, format: .dateTime.locale(locale))
        Button("Done") { dismiss() }
        """) { AnyView(C14_EnvironmentKeyPathExample()) },

        ChildExampleEntry(parent: "@Environment", child: "init(_:) — Observable type", code: """
        @Environment(Library.self) private var library
        // injected upstream: LibraryShelf().environment(library)

        ForEach(library.books, id: \\.self) { Text($0) }
        Button("Add Book") { library.books.append("Book \\(library.books.count + 1)") }
        """) { AnyView(C14_EnvironmentObservableExample()) },

        ChildExampleEntry(parent: "@Environment", child: "init(_:) — optional Observable", code: """
        @Environment(Library.self) private var library: Library?

        if let library {
            Text("\\(library.books.count) books")
        } else {
            Text("No library injected")
        }
        """) { AnyView(C14_EnvironmentOptionalExample()) },

        // MARK: @FetchRequest

        ChildExampleEntry(parent: "@FetchRequest", child: "init(sortDescriptors:predicate:animation:)", code: """
        @FetchRequest(
            sortDescriptors: [SortDescriptor(\\.createdAt, order: .reverse)],
            predicate: NSPredicate(format: "isArchived == NO"),
            animation: .default
        )
        private var notes: FetchedResults<Note>
        """) { AnyView(C14_FetchRequestModernExample()) },

        ChildExampleEntry(parent: "@FetchRequest", child: "init(fetchRequest:animation:)", code: """
        extension Note {
            static var recent: NSFetchRequest<Note> {
                let request: NSFetchRequest<Note> = Note.fetchRequest()
                request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
                request.fetchLimit = 3
                return request
            }
        }
        @FetchRequest(fetchRequest: Note.recent, animation: .default) private var recentNotes: FetchedResults<Note>
        """) { AnyView(C14_FetchRequestPrebuiltExample()) },

        ChildExampleEntry(parent: "@FetchRequest", child: "init(entity:sortDescriptors:predicate:animation:)", code: """
        @FetchRequest(
            entity: Note.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \\Note.title, ascending: true)]
        )
        private var notes: FetchedResults<Note>
        """) { AnyView(C14_FetchRequestEntityExample()) },

        ChildExampleEntry(parent: "@FetchRequest", child: "projectedValue (Configuration)", code: """
        @FetchRequest(sortDescriptors: [SortDescriptor(\\.title)])
        private var notes: FetchedResults<Note>

        Table(notes, sortOrder: $notes.sortDescriptors) {
            TableColumn("Title", value: \\.title)
            TableColumn("Created", value: \\.createdLabel)
        }
        """) { AnyView(C14_FetchRequestProjectedExample()) },

        // MARK: @FocusedValue

        ChildExampleEntry(parent: "@FocusedValue", child: "init(_:) — FocusedValues key path", code: """
        @FocusedValue(\\.selectedNote) private var note

        Button("Duplicate") { duplicate(note) }
            .disabled(note == nil)
        """) { AnyView(C14_FocusedValueKeyPathExample()) },

        ChildExampleEntry(parent: "@FocusedValue", child: "init(_:) — Observable type", code: """
        // publisher: TextField("Title", text: $note.title).focusedValue(note)
        @FocusedValue(Note.self) private var note

        Button("Duplicate") { note?.title += " copy" }
            .disabled(note == nil)
        """) { AnyView(C14_FocusedValueObservableExample()) },

        ChildExampleEntry(parent: "@FocusedValue", child: "FocusedValueKey", code: """
        struct DocumentKey: FocusedValueKey { typealias Value = String }

        extension FocusedValues {
            var document: String? {
                get { self[DocumentKey.self] }
                set { self[DocumentKey.self] = newValue }
            }
        }
        // publisher: .focusedValue(\\.document, "Q3 Report")   consumer: @FocusedValue(\\.document) var document
        """) { AnyView(C14_FocusedValueKeyExample()) },

        // MARK: @FocusState

        ChildExampleEntry(parent: "@FocusState", child: "init() — Bool", code: """
        @State private var query = ""
        @FocusState private var isSearchFocused: Bool

        TextField("Search", text: $query)
            .focused($isSearchFocused)
        Button("Find") { isSearchFocused = true }
        """) { AnyView(C14_FocusStateBoolExample()) },

        ChildExampleEntry(parent: "@FocusState", child: "init() — Optional<Hashable>", code: """
        @State private var items: [Item] = []
        @FocusState private var focusedItemID: Item.ID?

        ForEach($items) { $item in
            TextField("Name", text: $item.name)
                .focused($focusedItemID, equals: item.id)
        }
        Button("Add") { let new = Item(); items.append(new); focusedItemID = new.id }
        """) { AnyView(C14_FocusStateOptionalExample()) },

        ChildExampleEntry(parent: "@FocusState", child: "projectedValue (FocusState.Binding)", code: """
        struct LoginFields: View {
            @Binding var user: String
            var focus: FocusState<Field?>.Binding
            var body: some View {
                TextField("User", text: $user).focused(focus, equals: .user)
            }
        }
        // parent: @FocusState private var focus: Field?  …  LoginFields(user: $user, focus: $focus)
        """) { AnyView(C14_FocusStateBindingExample()) },

        // MARK: @GestureState

        ChildExampleEntry(parent: "@GestureState", child: "init(wrappedValue:)", code: """
        @GestureState private var scale: CGFloat = 1

        RoundedRectangle(cornerRadius: 12)
            .scaleEffect(scale)
            .gesture(MagnifyGesture().updating($scale) { value, state, _ in
                state = value.magnification
            })
        """) { AnyView(C14_GestureStateDefaultExample()) },

        ChildExampleEntry(parent: "@GestureState", child: "init(wrappedValue:resetTransaction:)", code: """
        @GestureState(resetTransaction: Transaction(animation: .bouncy))
        private var offset = CGSize.zero

        Circle()
            .offset(offset)
            .gesture(DragGesture().updating($offset) { value, state, _ in
                state = value.translation
            })
        """) { AnyView(C14_GestureStateResetTransactionExample()) },

        ChildExampleEntry(parent: "@GestureState", child: "init(wrappedValue:reset:)", code: """
        @GestureState(reset: { value, transaction in
            transaction.animation = value.width > 100 ? .spring(duration: 0.4) : nil
        }) private var drag = CGSize.zero

        Circle()
            .offset(drag)
            .gesture(DragGesture().updating($drag) { value, state, _ in state = value.translation })
        """) { AnyView(C14_GestureStateResetClosureExample()) },

        ChildExampleEntry(parent: "@GestureState", child: "init()", code: """
        @GestureState private var pressedID: String?

        ForEach(["Inbox", "Drafts", "Sent"], id: \\.self) { item in
            Row(item)
                .scaleEffect(pressedID == item ? 0.95 : 1)
                .gesture(LongPressGesture(minimumDuration: 1.5)
                    .updating($pressedID) { _, state, _ in state = item })
        }
        """) { AnyView(C14_GestureStateOptionalExample()) },

        // MARK: @NSApplicationDelegateAdaptor

        ChildExampleEntry(parent: "@NSApplicationDelegateAdaptor", child: "init(_:)", code: """
        final class AppDelegate: NSObject, NSApplicationDelegate {
            func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
                true
            }
        }

        @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
        """) { AnyView(C14_NSAppDelegateMetatypeExample()) },

        ChildExampleEntry(parent: "@NSApplicationDelegateAdaptor", child: "init()", code: """
        @main
        struct CompanionApp: App {
            @NSApplicationDelegateAdaptor private var appDelegate: AppDelegate

            var body: some Scene { WindowGroup { ContentView() } }
        }
        """) { AnyView(C14_NSAppDelegateInferredExample()) },

        ChildExampleEntry(parent: "@NSApplicationDelegateAdaptor", child: "projectedValue — ObservableObject delegate", code: """
        final class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
            @Published var pendingPath = ""
        }

        // $appDelegate.pendingPath is a Binding; the instance is also injected, so any view can read:
        @EnvironmentObject private var appDelegate: AppDelegate
        """) { AnyView(C14_NSAppDelegateObservableExample()) },

        // MARK: @Observable

        ChildExampleEntry(parent: "@Observable", child: "@ObservationIgnored", code: """
        @Observable
        final class Downloader {
            var progress = 0.0
            @ObservationIgnored var ticks = 0     // plumbing: never triggers a re-render
        }

        ProgressView(value: downloader.progress)
        Text("ticks as of last render: \\(downloader.ticks)")
        """) { AnyView(C14_ObservationIgnoredExample()) },

        ChildExampleEntry(parent: "@Observable", child: "withObservationTracking(_:onChange:)", code: """
        withObservationTracking {
            _ = model.value                       // records which properties were read
        } onChange: {
            // fires once, before the mutation; call again to keep observing
            Task { @MainActor in model.log.append("onChange fired") }
        }
        """) { AnyView(C14_ObservationTrackingExample()) },

        ChildExampleEntry(parent: "@Observable", child: "Observations(_:)", code: """
        .task {
            let values = Observations { model.value }

            for await value in values {
                model.log.append("yielded \\(value)")
            }
        }
        """) { AnyView(C14_ObservationsExample()) },

        // MARK: @Published

        ChildExampleEntry(parent: "@Published", child: "init(wrappedValue:)", code: """
        final class Settings: ObservableObject {
            @Published var username = ""
            @Published private(set) var isSyncing = false
            func toggleSync() { isSyncing.toggle() }
        }

        TextField("Username", text: $settings.username)
        Button(settings.isSyncing ? "Stop Sync" : "Start Sync") { settings.toggleSync() }
        """) { AnyView(C14_PublishedExample()) },

        ChildExampleEntry(parent: "@Published", child: "projectedValue (Published.Publisher)", code: """
        $query
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in self?.search(text) }
            .store(in: &cancellables)
        """) { AnyView(C14_PublishedPublisherExample()) },

        // MARK: @Query

        ChildExampleEntry(parent: "@Query", child: "init(filter:sort:order:animation:)", code: """
        @Query(
            filter: #Predicate<Trip> { $0.isFavorite },
            sort: \\Trip.startDate,
            order: .reverse,
            animation: .default
        ) private var favorites: [Trip]
        """) { AnyView(C14_QueryFilterSortOrderExample()) },

        ChildExampleEntry(parent: "@Query", child: "init(filter:sort:animation:)", code: """
        @Query private var trips: [Trip]

        init(searchText: String) {
            _trips = Query(
                filter: #Predicate<Trip> { $0.name.localizedStandardContains(searchText) },
                sort: [SortDescriptor(\\Trip.startDate), SortDescriptor(\\Trip.name)],
                animation: .default
            )
        }
        """) { AnyView(C14_QueryFilterSortArrayExample()) },

        ChildExampleEntry(parent: "@Query", child: "init(_:animation:)", code: """
        private let upcoming: FetchDescriptor<Trip> = {
            var descriptor = FetchDescriptor<Trip>(sortBy: [SortDescriptor(\\.startDate)])
            descriptor.fetchLimit = 3
            return descriptor
        }()

        @Query(upcoming, animation: .smooth) private var upcomingTrips: [Trip]
        """) { AnyView(C14_QueryDescriptorExample()) },

        // MARK: @State

        ChildExampleEntry(parent: "@State", child: "init(wrappedValue:)", code: """
        @State private var query = ""
        @State private var selection = Set<String>()

        TextField("Filter", text: $query)
        List(items.filter { query.isEmpty || $0.localizedCaseInsensitiveContains(query) },
             id: \\.self, selection: $selection) { Text($0) }
        """) { AnyView(C14_StateWrappedValueExample()) },

        ChildExampleEntry(parent: "@State", child: "init()", code: """
        @State private var editingItem: Item?

        ForEach(items) { item in
            Button("Edit \\(item.name)") { editingItem = item }
        }
        .sheet(item: $editingItem) { item in EditSheet(item: item) }
        """) { AnyView(C14_StateOptionalExample()) },

        ChildExampleEntry(parent: "@State", child: "projectedValue", code: """
        @State private var profile = Profile()

        TextField("Name", text: $profile.name)
        Toggle("Public", isOn: $profile.isPublic)
        """) { AnyView(C14_StateProjectedExample()) },

        ChildExampleEntry(parent: "@State", child: "@State holding an @Observable object", code: """
        @Observable final class Cart { var items: [String] = [] }

        struct CartView: View {
            @State private var cart = Cart()
            var body: some View {
                Text("\\(cart.items.count) items")
                Button("Add") { cart.items.append("Item \\(cart.items.count + 1)") }
            }
        }
        """) { AnyView(C14_StateObservableExample()) },

        // MARK: @StateObject

        ChildExampleEntry(parent: "@StateObject", child: "init(wrappedValue:)", code: """
        @StateObject private var model: FeedModel

        init(feedID: String) {
            _model = StateObject(wrappedValue: FeedModel(feedID: feedID))
        }
        """) { AnyView(C14_StateObjectInitExample()) },

        ChildExampleEntry(parent: "@StateObject", child: "projectedValue (ObservedObject.Wrapper)", code: """
        @StateObject private var model = FeedModel(feedID: "news")

        TextField("Search", text: $model.query)
        Toggle("Unread only", isOn: $model.showsUnreadOnly)
        """) { AnyView(C14_StateObjectProjectedExample()) },

        // MARK: @UIApplicationDelegateAdaptor

        ChildExampleEntry(parent: "@UIApplicationDelegateAdaptor", child: "init(_:)", code: """
        final class AppDelegate: NSObject, UIApplicationDelegate {
            func application(_ application: UIApplication,
                             didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
                PushService.register(deviceToken)
            }
        }

        @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
        """) { AnyView(C14_UIAppDelegateMetatypeExample()) },

        ChildExampleEntry(parent: "@UIApplicationDelegateAdaptor", child: "init()", code: """
        @main
        struct CompanionApp: App {
            @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

            var body: some Scene { WindowGroup { ContentView() } }
        }
        """) { AnyView(C14_UIAppDelegateInferredExample()) },

        ChildExampleEntry(parent: "@UIApplicationDelegateAdaptor", child: "projectedValue — ObservableObject delegate", code: """
        final class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
            @Published var isRegisteredForPush = false
        }

        // $appDelegate.isRegisteredForPush is a Binding; the instance is injected, so any view can read:
        @EnvironmentObject private var appDelegate: AppDelegate
        """) { AnyView(C14_UIAppDelegateObservableExample()) },

        // MARK: DocumentGroup

        ChildExampleEntry(parent: "DocumentGroup", child: "DocumentGroup(newDocument:editor:)", code: """
        DocumentGroup(newDocument: MarkdownFile()) { config in
            MarkdownEditor(text: config.$document.text)
        }
        """) { AnyView(C14_DocumentGroupEditorExample()) },

        ChildExampleEntry(parent: "DocumentGroup", child: "DocumentGroup(viewing:viewer:)", code: """
        DocumentGroup(viewing: ReportFile.self) { config in
            ReportViewer(report: config.document)
        }
        """) { AnyView(C14_DocumentGroupViewerExample()) },

        ChildExampleEntry(parent: "DocumentGroup", child: "DocumentGroup(editing:contentType:editor:prepareDocument:)", code: """
        DocumentGroup(editing: Trip.self, contentType: .trip) {
            TripEditor()
        } prepareDocument: { context in
            context.insert(Trip(name: "Untitled Trip"))
        }
        """) { AnyView(C14_DocumentGroupSwiftDataExample()) },

        ChildExampleEntry(parent: "DocumentGroup", child: "FileDocumentConfiguration", code: """
        DocumentGroup(newDocument: TextFile()) { config in
            VStack {
                if !config.isEditable { Text("Read-only").font(.caption) }
                TextEditor(text: config.$document.text)
            }
            .navigationTitle(config.fileURL?.lastPathComponent ?? "Untitled")
        }
        """) { AnyView(C14_FileDocumentConfigurationExample()) },

        // MARK: DocumentGroupLaunchScene

        ChildExampleEntry(parent: "DocumentGroupLaunchScene", child: "DocumentGroupLaunchScene(_:actions:background:)", code: """
        DocumentGroupLaunchScene("Sketchpad") {
            NewDocumentButton("New Sketch")
            Button("Import…") { showImporter = true }
        } background: {
            LinearGradient(colors: [.indigo, .black],
                           startPoint: .top, endPoint: .bottom)
        }
        """) { AnyView(C14_LaunchSceneBasicExample()) },

        ChildExampleEntry(parent: "DocumentGroupLaunchScene", child: "DocumentGroupLaunchScene(_:actions:background:overlayAccessoryView:)", code: """
        DocumentGroupLaunchScene("Sketchpad") {
            NewDocumentButton()
        } background: {
            Color.indigo
        } overlayAccessoryView: { geo in
            Mascot().position(x: geo.titleViewFrame.maxX, y: geo.titleViewFrame.minY)
        }
        """) { AnyView(C14_LaunchSceneOverlayExample()) },

        ChildExampleEntry(parent: "DocumentGroupLaunchScene", child: "DocumentLaunchGeometryProxy", code: """
        } backgroundAccessoryView: { geo in
            Image(systemName: "cloud.fill")
                .resizable()
                .frame(width: geo.frame.width / 4)
                .offset(y: geo.titleViewFrame.minY - 80)
        }
        """) { AnyView(C14_LaunchGeometryProxyExample()) },

        ChildExampleEntry(parent: "DocumentGroupLaunchScene", child: "NewDocumentButton", code: """
        DocumentGroupLaunchScene("Sketchpad") {
            NewDocumentButton("New Sketch")     // custom title
            NewDocumentButton()                 // default label
        } background: {
            Color.indigo
        }
        """) { AnyView(C14_NewDocumentButtonExample()) },

        // MARK: MenuBarExtra

        ChildExampleEntry(parent: "MenuBarExtra", child: "MenuBarExtra(_:systemImage:content:)", code: """
        MenuBarExtra("Timer", systemImage: "timer") {
            Button("Start") { timer.start() }
            Button("Stop") { timer.stop() }
            Divider()
            Button("Quit") { NSApp.terminate(nil) }
        }
        """) { AnyView(C14_MenuBarExtraSymbolExample()) },

        ChildExampleEntry(parent: "MenuBarExtra", child: "MenuBarExtra(_:isInserted:content:)", code: """
        @AppStorage("aviary.c14.showMenuBarExtra") private var showMenuBarExtra = true

        MenuBarExtra("Companion", isInserted: $showMenuBarExtra) {
            QuickSearchView()
        }
        // preference UI: Toggle("Show in menu bar", isOn: $showMenuBarExtra)
        """) { AnyView(C14_MenuBarExtraInsertedExample()) },

        ChildExampleEntry(parent: "MenuBarExtra", child: "MenuBarExtra(content:label:)", code: """
        MenuBarExtra {
            StatusMenu()
        } label: {
            Image(systemName: cpuLoad > 0.8 ? "flame.fill" : "cpu")
            Text(String(format: "%.0f%%", cpuLoad * 100))
        }
        """) { AnyView(C14_MenuBarExtraLabelExample()) },

        ChildExampleEntry(parent: "MenuBarExtra", child: ".menuBarExtraStyle(_:)", code: """
        MenuBarExtra("Companion", systemImage: "swift") {
            QuickSearchView()
                .frame(width: 320, height: 400)
        }
        .menuBarExtraStyle(.window)      // .menu is the default pull-down
        """) { AnyView(C14_MenuBarExtraStyleExample()) },

        // MARK: Window

        ChildExampleEntry(parent: "Window", child: "Window(_:id:content:)", code: """
        Window("About Companion", id: "about") {
            AboutView()
        }

        // elsewhere:
        @Environment(\\.openWindow) private var openWindow
        openWindow(id: "about")
        """) { AnyView(C14_WindowSingleExample()) },

        ChildExampleEntry(parent: "Window", child: ".windowResizability(_:)", code: """
        Window("Inspector", id: "inspector") {
            InspectorView()
                .frame(minWidth: 280, minHeight: 400)
        }
        .windowResizability(.contentSize)
        """) { AnyView(C14_WindowResizabilityExample()) },

        ChildExampleEntry(parent: "Window", child: ".defaultPosition(_:)", code: """
        Window("Activity", id: "activity") {
            ActivityView()
        }
        .defaultSize(width: 480, height: 320)
        .defaultPosition(.topTrailing)
        """) { AnyView(C14_WindowDefaultPositionExample()) },

        ChildExampleEntry(parent: "Window", child: ".windowLevel(_:)", code: """
        Window("Now Playing", id: "now-playing") {
            NowPlayingView()
        }
        .windowLevel(.floating)
        """) { AnyView(C14_WindowLevelExample()) },

        // MARK: WindowGroup

        ChildExampleEntry(parent: "WindowGroup", child: "WindowGroup(_:content:)", code: """
        WindowGroup("Library") {
            LibraryView()
        }
        """) { AnyView(C14_WindowGroupTitledExample()) },

        ChildExampleEntry(parent: "WindowGroup", child: "WindowGroup(id:content:)", code: """
        WindowGroup(id: "main") {
            ContentView()
        }

        // later:
        openWindow(id: "main")
        """) { AnyView(C14_WindowGroupIDExample()) },

        ChildExampleEntry(parent: "WindowGroup", child: "WindowGroup(for:content:)", code: """
        WindowGroup(for: Note.ID.self) { $noteID in
            // noteID is Note.ID? — nil for a plain new window
            NoteEditor(id: noteID)
        }

        // later:
        openWindow(value: note.id)
        """) { AnyView(C14_WindowGroupForValueExample()) },
    ]
}

// MARK: - Shared helpers

private struct C14_Caption: View {
    let text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(.secondary)
            .fixedSize(horizontal: false, vertical: true)
    }
}

/// Mock macOS window chrome for scene-level illustrations.
private struct C14_MockWindow<Content: View>: View {
    var title: String
    var width: CGFloat = 260
    @ViewBuilder var content: Content

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 6) {
                Circle().fill(.red).frame(width: 9, height: 9)
                Circle().fill(.yellow).frame(width: 9, height: 9)
                Circle().fill(.green).frame(width: 9, height: 9)
                Spacer()
                Text(title).font(.caption).foregroundStyle(.secondary).lineLimit(1)
                Spacer()
                Color.clear.frame(width: 39, height: 9)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .background(.quaternary)
            content
                .frame(maxWidth: .infinity)
                .background(.background)
        }
        .frame(width: width)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.separator))
        .shadow(color: .black.opacity(0.15), radius: 6, y: 2)
    }
}

/// Mock macOS menu bar with a trailing slot for a status item.
private struct C14_MockMenuBar<Item: View>: View {
    @ViewBuilder var statusItem: Item

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "apple.logo")
            Text("Finder").bold()
            Text("File")
            Text("Edit")
            Spacer()
            statusItem
            Image(systemName: "wifi")
            Image(systemName: "battery.75percent")
            Text("Mon 9:41")
        }
        .font(.callout)
        .padding(.horizontal, 10)
        .frame(height: 24)
        .background(.regularMaterial)
    }
}

private struct C14_MockRow: Identifiable {
    let id: Int
    let title: String
    let detail: String

    static func list(_ pairs: [(String, String)]) -> [C14_MockRow] {
        pairs.enumerated().map { C14_MockRow(id: $0.offset, title: $0.element.0, detail: $0.element.1) }
    }
}

/// A list standing in for live query results (Core Data / SwiftData).
private struct C14_MockResultList: View {
    var header: String
    var rows: [C14_MockRow]
    var icon = "note.text"

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(header).font(.caption.monospaced()).foregroundStyle(.secondary)
            ForEach(rows) { row in
                HStack {
                    Image(systemName: icon).foregroundStyle(.tint)
                    Text(row.title)
                    Spacer()
                    Text(row.detail).foregroundStyle(.secondary)
                }
                .font(.callout)
            }
        }
    }
}

// MARK: - @AppStorage

private struct C14_AppStorageDefaultExample: View {
    @AppStorage("aviary.c14.showsSidebar") private var showsSidebar = true
    @AppStorage("aviary.c14.openCount", store: .standard) private var openCount = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Toggle("Show Sidebar", isOn: $showsSidebar)
            Text("Opened \(openCount) times")
            C14_Caption("Both values live in UserDefaults, so they survive relaunch; the inline default is used until something writes the key.")
        }
        .onAppear { openCount += 1 }
        .padding()
    }
}

private struct C14_AppStorageOptionalExample: View {
    @AppStorage("aviary.c14.lastOpenedPath") private var lastOpenedPath: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(lastOpenedPath ?? "Nothing opened yet")
                .font(.body.monospaced())
            HStack {
                Button("Open Report.pdf") { lastOpenedPath = "~/Documents/Report.pdf" }
                Button("Forget") { lastOpenedPath = nil }
                    .disabled(lastOpenedPath == nil)
            }
            C14_Caption("No default needed: the optional reads as nil until a value has been stored.")
        }
        .padding()
    }
}

private enum C14_Appearance: String, CaseIterable { case system, light, dark }

private struct C14_AppStorageRawExample: View {
    @AppStorage("aviary.c14.appearance") private var appearance: C14_Appearance = .system

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Picker("Appearance", selection: $appearance) {
                ForEach(C14_Appearance.allCases, id: \.self) { Text($0.rawValue.capitalized) }
            }
            .pickerStyle(.segmented)
            RoundedRectangle(cornerRadius: 8)
                .fill(swatch)
                .frame(height: 36)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(.separator))
            C14_Caption("Stored as the raw String \"\(appearance.rawValue)\"; the Picker binds straight to the typed preference.")
        }
        .padding()
    }

    private var swatch: Color {
        switch appearance {
        case .system: .gray
        case .light: .white
        case .dark: .black
        }
    }
}

private struct C14_Person: Identifiable {
    let id: Int
    let name: String
    let role: String
    let team: String
}

private struct C14_AppStorageTableExample: View {
    @AppStorage("aviary.c14.PeopleTableLayout")
    private var customization = TableColumnCustomization<C14_Person>()

    private let people = [
        C14_Person(id: 1, name: "Ada", role: "Engineer", team: "Compiler"),
        C14_Person(id: 2, name: "Grace", role: "Manager", team: "Platform"),
        C14_Person(id: 3, name: "Linus", role: "Engineer", team: "Kernel"),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Table(people, columnCustomization: $customization) {
                TableColumn("Name", value: \.name).customizationID("name")
                TableColumn("Role", value: \.role).customizationID("role")
                TableColumn("Team", value: \.team).customizationID("team")
            }
            .frame(height: 120)
            C14_Caption("Right-click the header to hide or reorder columns, drag to resize; the arrangement persists under the key.")
        }
        .padding()
    }
}

// MARK: - @Bindable

@Observable private final class C14_Library {
    var filter = ""
    var books = ["Dune", "Emma", "Neuromancer", "Ulysses"]
    var visibleBooks: [String] {
        filter.isEmpty ? books : books.filter { $0.localizedCaseInsensitiveContains(filter) }
    }
}

private struct C14_BindableWrappedValueExample: View {
    @State private var library = C14_Library()

    var body: some View {
        C14_BindableFilterPane()
            .environment(library)
            .padding()
    }
}

private struct C14_BindableFilterPane: View {
    @Environment(C14_Library.self) private var library

    var body: some View {
        @Bindable var library = library
        VStack(alignment: .leading, spacing: 8) {
            TextField("Filter", text: $library.filter)
            ForEach(library.visibleBooks, id: \.self) { Label($0, systemImage: "book") }
            C14_Caption("Declared as a local inside body because the object came from @Environment.")
        }
    }
}

@Observable private final class C14_Settings {
    var showsRuler = true
    var zoom = 1.0
}

private struct C14_BindableInitExample: View {
    @State private var settings = C14_Settings()

    var body: some View {
        let bindable = Bindable(settings)
        VStack(alignment: .leading, spacing: 8) {
            Toggle("Show Ruler", isOn: bindable.showsRuler)
            Slider(value: bindable.zoom, in: 0.5...4)
            HStack(spacing: 0) {
                if settings.showsRuler {
                    ForEach(0..<8, id: \.self) { i in
                        Rectangle().fill(.secondary).frame(width: 1, height: i % 4 == 0 ? 12 : 6)
                        Spacer()
                    }
                }
            }
            .frame(height: 12)
            RoundedRectangle(cornerRadius: 4)
                .fill(.blue.gradient)
                .frame(width: 40 * settings.zoom, height: 20)
            C14_Caption("Bindable(settings) built explicitly, then bindings pulled through dynamic member lookup.")
        }
        .padding()
    }
}

@Observable private final class C14_Book {
    var title = "Dune"
    var pageCount = 412
    var rating = 4.0
}

private struct C14_BookForm: View {
    @Bindable var book: C14_Book

    var body: some View {
        TextField("Title", text: $book.title)
        Stepper("Pages: \(book.pageCount)", value: $book.pageCount, in: 1...2000)
        Slider(value: $book.rating, in: 0...5)
    }
}

private struct C14_BindableSubscriptExample: View {
    @State private var book = C14_Book()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C14_BookForm(book: book)
            Text("\(book.title) · \(book.pageCount) pages · \(String(format: "%.1f", book.rating)) ★")
                .font(.caption.monospaced())
            C14_Caption("Each $book.property resolves through subscript(dynamicMember:) into a Binding.")
        }
        .padding()
    }
}

// MARK: - @Binding

private struct C14_BindingGetSetExample: View {
    @State private var isHidden = false

    var body: some View {
        let isVisible = Binding(
            get: { !isHidden },
            set: { isHidden = !$0 }
        )
        VStack(alignment: .leading, spacing: 8) {
            Toggle("Visible", isOn: isVisible)
            HStack {
                Image(systemName: isHidden ? "eye.slash" : "eye")
                Text("isHidden = \(isHidden ? "true" : "false")").font(.caption.monospaced())
            }
            C14_Caption("The getter and setter invert the stored value on its way to and from the control.")
        }
        .padding()
    }
}

private struct C14_BindingConstantExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Toggle("Locked", isOn: .constant(true))
            Slider(value: .constant(0.3))
            C14_Caption("Try them: writes are silently dropped, so nothing moves. Handy for previews and read-only demos.")
        }
        .padding()
    }
}

private struct C14_BindingUnwrapExample: View {
    @State private var draft: String?

    var body: some View {
        let label = draft.map { "\"\($0)\"" } ?? "nil"
        VStack(alignment: .leading, spacing: 8) {
            if let text = Binding($draft) {
                TextField("Draft", text: text)
                Button("Discard Draft") { draft = nil }
            } else {
                Button("Start Draft") { draft = "" }
            }
            Text("draft is \(label)").font(.caption.monospaced())
            C14_Caption("Binding($draft) is nil while the optional is nil, so the editor appears only once a draft exists.")
        }
        .padding()
    }
}

private struct C14_BindingAnimationExample: View {
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Toggle("Details", isOn: $isExpanded.animation(.snappy))
            if isExpanded {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.blue.gradient)
                    .frame(height: 56)
                    .overlay(Text("Detail panel").foregroundStyle(.white))
            }
            C14_Caption("No withAnimation at the call site: the binding's own writes run inside .snappy.")
        }
        .padding()
    }
}

// MARK: - @Entry

extension ContainerValues {
    @Entry var c14IsPinned = false
}

private struct C14_PinnedList<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ForEach(subviews: content) { subview in
                HStack {
                    subview.bold(subview.containerValues.c14IsPinned)
                    if subview.containerValues.c14IsPinned {
                        Image(systemName: "pin.fill").foregroundStyle(.orange)
                    }
                }
            }
        }
    }
}

private struct C14_EntryContainerExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C14_PinnedList {
                Text("Inbox").containerValue(\.c14IsPinned, true)
                Text("Drafts")
                Text("Archive")
            }
            C14_Caption("The child sets the value with containerValue; the container reads it back per subview.")
        }
        .padding()
    }
}

extension FocusedValues {
    @Entry var c14SelectedNote: String?
}

private struct C14_FocusedNoteReadout: View {
    @FocusedValue(\.c14SelectedNote) private var note

    var body: some View {
        Label(note.map { "Focused note: \($0)" } ?? "No note focused", systemImage: "scope")
            .font(.caption.monospaced())
    }
}

private struct C14_EntryFocusedExample: View {
    @State private var meeting = "Meeting notes"
    @State private var grocery = "Groceries"

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Note A", text: $meeting)
                .focusedValue(\.c14SelectedNote, meeting)
            TextField("Note B", text: $grocery)
                .focusedValue(\.c14SelectedNote, grocery)
            C14_FocusedNoteReadout()
            C14_Caption("Click a field: the focused view publishes its value; elsewhere the entry reads nil.")
        }
        .padding()
    }
}

extension Transaction {
    @Entry var c14IsUndoing = false
}

private struct C14_EntryTransactionExample: View {
    @State private var offset: CGFloat = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Circle()
                .fill(.orange)
                .frame(width: 32, height: 32)
                .offset(x: offset)
                .transaction { t in
                    t.animation = t.c14IsUndoing ? nil : .spring(duration: 0.6)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Button("Move") { offset = 160 }
                Button("Undo") { withTransaction(\.c14IsUndoing, true) { offset = 0 } }
            }
            C14_Caption("Move springs; Undo carries the custom flag, and the .transaction reader drops the animation.")
        }
        .padding()
    }
}

// MARK: - @Environment

private struct C14_EnvironmentKeyPathExample: View {
    @Environment(\.locale) private var locale
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Date.now, format: .dateTime.locale(locale))
            Text("locale \(locale.identifier) · colorScheme \(colorScheme == .dark ? "dark" : "light")")
                .font(.caption.monospaced())
            Button("Done") { dismiss() }
            C14_Caption("Plain values (locale) and actions (dismiss) share one key-path form. Nothing is presented here, so dismiss() is inert.")
        }
        .padding()
    }
}

private struct C14_LibraryShelf: View {
    @Environment(C14_Library.self) private var library

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 4) {
                ForEach(library.books, id: \.self) { book in
                    Text(book)
                        .font(.caption2)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 6)
                        .background(.blue.opacity(0.15), in: RoundedRectangle(cornerRadius: 4))
                }
            }
            Button("Add Book") { library.books.append("Book \(library.books.count + 1)") }
        }
    }
}

private struct C14_EnvironmentObservableExample: View {
    @State private var library = C14_Library()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C14_LibraryShelf()
                .environment(library)
            C14_Caption("Looked up by type; injected upstream with .environment(library). Mutations re-render the reader.")
        }
        .padding()
    }
}

private struct C14_LibraryCount: View {
    @Environment(C14_Library.self) private var library: C14_Library?

    var body: some View {
        if let library {
            Label("\(library.books.count) books", systemImage: "books.vertical")
        } else {
            Label("No library injected", systemImage: "questionmark.circle")
                .foregroundStyle(.secondary)
        }
    }
}

private struct C14_EnvironmentOptionalExample: View {
    @State private var library = C14_Library()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C14_LibraryCount()
                .environment(library)
            C14_LibraryCount()      // nothing injected → reads nil instead of crashing
            C14_Caption("Same reader twice: with an injection it sees the object; without one the optional is nil.")
        }
        .padding()
    }
}

// MARK: - @FetchRequest (illustrative — needs a Core Data stack at runtime)

private struct C14_FetchRequestModernExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C14_MockResultList(
                header: "isArchived == NO · createdAt ↓",
                rows: C14_MockRow.list([("Standup", "day 5"), ("Roadmap", "day 3"), ("Budget", "day 2")])
            )
            C14_Caption("Illustrative — renders live Core Data results at runtime. Swift SortDescriptors, an optional NSPredicate, and .default animation on changes.")
        }
        .padding()
    }
}

private struct C14_FetchRequestPrebuiltExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                C14_MockResultList(
                    header: "NSFetchRequest · createdAt ↓",
                    rows: C14_MockRow.list([("Standup", "day 5"), ("Roadmap", "day 3"), ("Budget", "day 2")])
                )
                Text("fetchLimit = 3")
                    .font(.caption2.monospaced())
                    .padding(4)
                    .background(.quaternary, in: Capsule())
            }
            C14_Caption("Illustrative — renders live Core Data results at runtime. A prebuilt request is the only route to limits, batching, and prefetching.")
        }
        .padding()
    }
}

private struct C14_FetchRequestEntityExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C14_MockResultList(
                header: "entity: Note · title ↑",
                rows: C14_MockRow.list([("Budget", "day 2"), ("Retro", "day 1"), ("Roadmap", "day 3"), ("Standup", "day 5")])
            )
            C14_Caption("Illustrative — renders live Core Data results at runtime. The original form names the entity and uses NSSortDescriptor.")
        }
        .padding()
    }
}

private struct C14_MockNote: Identifiable {
    let id: Int
    let title: String
    let day: Int
    var createdLabel: String { "day \(day)" }
}

private struct C14_FetchRequestProjectedExample: View {
    @State private var sortOrder = [KeyPathComparator(\C14_MockNote.title)]

    private let notes = [
        C14_MockNote(id: 1, title: "Roadmap", day: 3),
        C14_MockNote(id: 2, title: "Standup", day: 5),
        C14_MockNote(id: 3, title: "Budget", day: 2),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Table(notes.sorted(using: sortOrder), sortOrder: $sortOrder) {
                TableColumn("Title", value: \.title)
                TableColumn("Created", value: \.createdLabel)
            }
            .frame(height: 110)
            C14_Caption("Illustrative — click a header to re-sort. With a real request, $notes.sortDescriptors rewrites the live fetch the same way.")
        }
        .padding()
    }
}

// MARK: - @FocusedValue

private struct C14_FocusedNoteToolbar: View {
    @FocusedValue(\.c14SelectedNote) private var note
    @State private var copies: [String] = []

    var body: some View {
        HStack {
            Button("Duplicate") { if let note { copies.append(note + " copy") } }
                .disabled(note == nil)
            Text(copies.isEmpty ? "no copies yet" : copies.joined(separator: ", "))
                .font(.caption.monospaced())
                .lineLimit(1)
        }
    }
}

private struct C14_FocusedValueKeyPathExample: View {
    @State private var meeting = "Meeting notes"
    @State private var grocery = "Groceries"

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C14_FocusedNoteToolbar()
            TextField("Note A", text: $meeting)
                .focusedValue(\.c14SelectedNote, meeting)
            TextField("Note B", text: $grocery)
                .focusedValue(\.c14SelectedNote, grocery)
            C14_Caption("Focus a field to enable Duplicate; the reader gets nil whenever nothing relevant has focus.")
        }
        .padding()
    }
}

@Observable private final class C14_Note {
    var title: String
    init(title: String) { self.title = title }
}

private struct C14_NoteEditor: View {
    @Bindable var note: C14_Note

    var body: some View {
        TextField("Title", text: $note.title)
            .focusedValue(note)
    }
}

private struct C14_NoteDuplicateButton: View {
    @FocusedValue(C14_Note.self) private var note

    var body: some View {
        HStack {
            Button("Duplicate") { note?.title += " copy" }
                .disabled(note == nil)
            Text(note.map { "focused: \($0.title)" } ?? "nothing focused")
                .font(.caption.monospaced())
                .lineLimit(1)
        }
    }
}

private struct C14_FocusedValueObservableExample: View {
    @State private var first = C14_Note(title: "Roadmap")
    @State private var second = C14_Note(title: "Retro")

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C14_NoteDuplicateButton()
            C14_NoteEditor(note: first)
            C14_NoteEditor(note: second)
            C14_Caption("Published with the object-taking focusedValue(_:) and looked up by type; the button mutates the focused object.")
        }
        .padding()
    }
}

private struct C14_DocumentKey: FocusedValueKey { typealias Value = String }

extension FocusedValues {
    var c14Document: String? {
        get { self[C14_DocumentKey.self] }
        set { self[C14_DocumentKey.self] = newValue }
    }
}

private struct C14_DocumentReadout: View {
    @FocusedValue(\.c14Document) private var document

    var body: some View {
        Label(document.map { "Focused document: \($0)" } ?? "No document focused", systemImage: "doc.text")
            .font(.caption.monospaced())
    }
}

private struct C14_FocusedValueKeyExample: View {
    @State private var q3 = "Revenue up 12%"
    @State private var q4 = "Forecast pending"

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Q3 Report", text: $q3)
                .focusedValue(\.c14Document, "Q3 Report")
            TextField("Q4 Report", text: $q4)
                .focusedValue(\.c14Document, "Q4 Report")
            C14_DocumentReadout()
            C14_Caption("The hand-written key plus a computed accessor on FocusedValues, doing what @Entry now generates.")
        }
        .padding()
    }
}

// MARK: - @FocusState

private struct C14_FocusStateBoolExample: View {
    @State private var query = ""
    @FocusState private var isSearchFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Search", text: $query)
                .focused($isSearchFocused)
            HStack {
                Button("Find") { isSearchFocused = true }
                Button("Blur") { isSearchFocused = false }
                Text(isSearchFocused ? "focused" : "not focused")
                    .font(.caption.monospaced())
            }
            C14_Caption("A Boolean tracks one field, pairing with the focused(_:) overload that takes no equals value.")
        }
        .padding()
    }
}

private struct C14_NamedItem: Identifiable {
    let id = UUID()
    var name: String
}

private struct C14_FocusStateOptionalExample: View {
    @State private var items = [C14_NamedItem(name: "Alpha"), C14_NamedItem(name: "Beta")]
    @FocusState private var focusedItemID: C14_NamedItem.ID?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach($items) { $item in
                TextField("Name", text: $item.name)
                    .focused($focusedItemID, equals: item.id)
            }
            HStack {
                Button("Add") {
                    let new = C14_NamedItem(name: "")
                    items.append(new)
                    focusedItemID = new.id
                }
                .disabled(items.count >= 4)
                Text("focused row: \(items.firstIndex { $0.id == focusedItemID }.map { "\($0 + 1)" } ?? "none")")
                    .font(.caption.monospaced())
            }
            C14_Caption("Any Hashable works as the tag — here a UUID — and Add moves focus to the new row.")
        }
        .padding()
    }
}

private enum C14_LoginField: Hashable { case user, password }

private struct C14_LoginFields: View {
    @Binding var user: String
    @Binding var password: String
    var focus: FocusState<C14_LoginField?>.Binding

    var body: some View {
        TextField("User", text: $user).focused(focus, equals: .user)
        SecureField("Password", text: $password).focused(focus, equals: .password)
    }
}

private struct C14_FocusStateBindingExample: View {
    @State private var user = ""
    @State private var password = ""
    @FocusState private var focus: C14_LoginField?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C14_LoginFields(user: $user, password: $password, focus: $focus)
            HStack {
                Button("Focus User") { focus = .user }
                Button("Focus Password") { focus = .password }
            }
            C14_Caption("The parent owns the focus state and passes $focus down; the child moves focus the parent owns.")
        }
        .padding()
    }
}

// MARK: - @GestureState

private struct C14_GestureStateDefaultExample: View {
    @GestureState private var scale: CGFloat = 1

    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 12)
                .fill(.teal.gradient)
                .frame(width: 90, height: 56)
                .scaleEffect(scale)
                .gesture(MagnifyGesture().updating($scale) { value, state, _ in
                    state = value.magnification
                })
            Text(String(format: "scale %.2f×", scale)).font(.caption.monospaced())
            C14_Caption("Pinch on the trackpad. The resting value 1 is restored the moment the gesture ends.")
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

private struct C14_GestureStateResetTransactionExample: View {
    @GestureState(resetTransaction: Transaction(animation: .bouncy))
    private var offset = CGSize.zero

    var body: some View {
        VStack(spacing: 8) {
            Circle()
                .fill(.indigo)
                .frame(width: 44, height: 44)
                .offset(offset)
                .gesture(DragGesture().updating($offset) { value, state, _ in
                    state = value.translation
                })
            C14_Caption("Drag, then release: the snap-back plays inside the .bouncy transaction supplied at declaration.")
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

private struct C14_GestureStateResetClosureExample: View {
    @GestureState(reset: { value, transaction in
        transaction.animation = value.width > 100 ? .spring(duration: 0.4) : nil
    }) private var drag = CGSize.zero

    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.secondary)
                    .frame(width: 1, height: 56)
                    .offset(x: 100)
                Circle()
                    .fill(.pink)
                    .frame(width: 44, height: 44)
                    .offset(drag)
                    .gesture(DragGesture().updating($drag) { value, state, _ in state = value.translation })
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            C14_Caption("Release past the 100 pt mark and it springs back; release before it and it snaps. The reset closure sees the final value.")
        }
        .padding()
    }
}

private struct C14_GestureStateOptionalExample: View {
    @GestureState private var pressedID: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ForEach(["Inbox", "Drafts", "Sent"], id: \.self) { item in
                Text(item)
                    .padding(6)
                    .frame(maxWidth: .infinity)
                    .background(
                        pressedID == item ? Color.blue.opacity(0.3) : Color.gray.opacity(0.15),
                        in: RoundedRectangle(cornerRadius: 6)
                    )
                    .scaleEffect(pressedID == item ? 0.95 : 1)
                    .gesture(LongPressGesture(minimumDuration: 1.5)
                        .updating($pressedID) { _, state, _ in state = item })
            }
            Text("pressedID: \(pressedID ?? "nil")").font(.caption.monospaced())
            C14_Caption("Press and hold a row. The optional starts at nil with no default and returns to nil after each gesture.")
        }
        .padding()
    }
}

// MARK: - @NSApplicationDelegateAdaptor (illustrative — applies at the App level)

private struct C14_AdaptorDiagram: View {
    var wrapperLine: String
    var delegateName: String
    var callbacks: [String]

    var body: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 4) {
                Text("@main struct CompanionApp: App").font(.caption.monospaced()).bold()
                Text(wrapperLine).font(.caption2.monospaced())
            }
            .padding(8)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 6))
            Image(systemName: "arrow.right")
            VStack(alignment: .leading, spacing: 4) {
                Label(delegateName, systemImage: "app.badge.checkmark").font(.caption).bold()
                ForEach(callbacks, id: \.self) { Text("• " + $0).font(.caption2.monospaced()) }
            }
            .padding(8)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 6))
        }
    }
}

private struct C14_NSAppDelegateMetatypeExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C14_AdaptorDiagram(
                wrapperLine: "@NSApplicationDelegateAdaptor(AppDelegate.self)",
                delegateName: "AppDelegate: NSApplicationDelegate",
                callbacks: ["applicationDidFinishLaunching(_:)", "…ShouldTerminateAfterLastWindowClosed → true"]
            )
            C14_Caption("Illustrative — applies at the App level. The metatype is instantiated and installed as NSApp.delegate before the scene body runs.")
        }
        .padding()
    }
}

private struct C14_NSAppDelegateInferredExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C14_AdaptorDiagram(
                wrapperLine: "@NSApplicationDelegateAdaptor var appDelegate: AppDelegate",
                delegateName: "AppDelegate (inferred from the type)",
                callbacks: ["no .self argument needed", "same lifecycle callbacks"]
            )
            C14_Caption("Illustrative — applies at the App level. The declared property type supplies the delegate class.")
        }
        .padding()
    }
}

private final class C14_MockAppDelegate: ObservableObject {
    @Published var pendingPath = ""
}

private struct C14_PendingPathBanner: View {
    @EnvironmentObject private var appDelegate: C14_MockAppDelegate

    var body: some View {
        Label(appDelegate.pendingPath.isEmpty ? "no pending path" : appDelegate.pendingPath, systemImage: "link")
            .font(.caption.monospaced())
    }
}

private struct C14_NSAppDelegateObservableExample: View {
    @StateObject private var appDelegate = C14_MockAppDelegate()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("$appDelegate.pendingPath", text: $appDelegate.pendingPath)
            C14_PendingPathBanner()
                .environmentObject(appDelegate)
            C14_Caption("Illustrative — with the real adaptor the injection is automatic. The binding above and the reader below share one published property.")
        }
        .padding()
    }
}

// MARK: - @Observable

@Observable private final class C14_Downloader {
    var progress = 0.0
    @ObservationIgnored var ticks = 0
}

private struct C14_ObservationIgnoredExample: View {
    @State private var downloader = C14_Downloader()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ProgressView(value: downloader.progress)
            Text("ticks as of last render: \(downloader.ticks)").font(.caption.monospaced())
            HStack {
                Button("progress += 0.1") { downloader.progress = min(1, downloader.progress + 0.1) }
                Button("ticks += 1") { downloader.ticks += 1 }
            }
            C14_Caption("Bumping ticks changes nothing on screen until a tracked property (progress) re-renders the view.")
        }
        .padding()
    }
}

@Observable private final class C14_TrackedModel {
    var value = 0
    var log: [String] = []
}

private struct C14_ObservationTrackingExample: View {
    @State private var model = C14_TrackedModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Button("Track once") { track() }
                Button("value += 1") { model.value += 1 }
                Text("value = \(model.value)").font(.caption.monospaced())
            }
            ForEach(model.log.suffix(3), id: \.self) { Text($0).font(.caption.monospaced()) }
            C14_Caption("Track, then mutate twice: onChange fires for the first mutation only.")
        }
        .padding()
    }

    private func track() {
        let model = model
        model.log.append("#\(model.log.count + 1) tracking value…")
        withObservationTracking {
            _ = model.value
        } onChange: {
            Task { @MainActor in
                model.log.append("#\(model.log.count + 1) onChange fired (once)")
            }
        }
    }
}

private struct C14_ObservationsExample: View {
    @State private var model = C14_TrackedModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Stepper("value: \(model.value)", value: $model.value)
            ForEach(model.log.suffix(3), id: \.self) { Text($0).font(.caption.monospaced()) }
            C14_Caption("The .task loop runs while the view is on screen; every change to a tracked property yields a fresh element.")
        }
        .padding()
        .task {
            let values = Observations { model.value }
            for await value in values {
                model.log.append("#\(model.log.count + 1) yielded \(value)")
            }
        }
    }
}

// MARK: - @Published

private final class C14_SyncSettings: ObservableObject {
    @Published var username = ""
    @Published private(set) var isSyncing = false
    func toggleSync() { isSyncing.toggle() }
}

private struct C14_PublishedExample: View {
    @StateObject private var settings = C14_SyncSettings()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Username", text: $settings.username)
            HStack {
                Button(settings.isSyncing ? "Stop Sync" : "Start Sync") { settings.toggleSync() }
                if settings.isSyncing { ProgressView().controlSize(.small) }
                Text(settings.username.isEmpty ? "" : "as \(settings.username)").font(.caption)
            }
            C14_Caption("private(set) keeps the flip inside the class; the view still re-renders because the property is @Published.")
        }
        .padding()
    }
}

private final class C14_SearchModel: ObservableObject {
    @Published var query = ""
    @Published private(set) var results: [String] = []
    private var cancellables = Set<AnyCancellable>()
    private let catalog = ["Apple", "Apricot", "Banana", "Blueberry", "Cherry", "Citron"]

    init() {
        $query
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in self?.search(text) }
            .store(in: &cancellables)
    }

    private func search(_ text: String) {
        results = text.isEmpty ? [] : catalog.filter { $0.localizedCaseInsensitiveContains(text) }
    }
}

private struct C14_PublishedPublisherExample: View {
    @StateObject private var model = C14_SearchModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Search fruit", text: $model.query)
            Text("results: \(model.results.isEmpty ? "—" : model.results.joined(separator: ", "))")
                .font(.caption.monospaced())
            C14_Caption("Type quickly: $query emits every keystroke, but the debounced sink searches only after a 300 ms pause.")
        }
        .padding()
    }
}

// MARK: - @Query (illustrative — needs a SwiftData container at runtime)

private struct C14_QueryFilterSortOrderExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C14_MockResultList(
                header: "#Predicate { $0.isFavorite } · startDate ↓",
                rows: C14_MockRow.list([("Kyoto", "Nov 2"), ("Lisbon", "Jun 14"), ("Oslo", "Feb 3")]),
                icon: "star.fill"
            )
            C14_Caption("Illustrative — renders live SwiftData results at runtime. One Comparable key path with an explicit order, animated on change.")
        }
        .padding()
    }
}

private struct C14_MockTrip: Identifiable {
    let id: Int
    let name: String
    let start: String     // ISO-ish so string order == date order
    let label: String
}

private let c14MockTrips = [
    C14_MockTrip(id: 1, name: "Oslo", start: "2026-02-03", label: "Feb 3"),
    C14_MockTrip(id: 2, name: "Lisbon", start: "2026-06-14", label: "Jun 14"),
    C14_MockTrip(id: 3, name: "Lima", start: "2026-06-14", label: "Jun 14"),
    C14_MockTrip(id: 4, name: "Kyoto", start: "2026-11-02", label: "Nov 2"),
    C14_MockTrip(id: 5, name: "Nairobi", start: "2026-12-20", label: "Dec 20"),
]

private struct C14_QueryFilterSortArrayExample: View {
    @State private var searchText = ""

    var body: some View {
        let matches = c14MockTrips
            .filter { searchText.isEmpty || $0.name.localizedStandardContains(searchText) }
            .sorted { ($0.start, $0.name) < ($1.start, $1.name) }
        VStack(alignment: .leading, spacing: 8) {
            TextField("searchText", text: $searchText)
            C14_MockResultList(
                header: "name contains \"\(searchText)\" · startDate ↑, name ↑",
                rows: C14_MockRow.list(matches.map { ($0.name, $0.label) }),
                icon: "airplane"
            )
            C14_Caption("Illustrative — renders live SwiftData results at runtime. Lisbon and Lima share a date, so the second descriptor orders them.")
        }
        .padding()
    }
}

private struct C14_QueryDescriptorExample: View {
    var body: some View {
        let upcoming = c14MockTrips.sorted { $0.start < $1.start }.prefix(3)
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                C14_MockResultList(
                    header: "FetchDescriptor · startDate ↑",
                    rows: C14_MockRow.list(upcoming.map { ($0.name, $0.label) }),
                    icon: "airplane"
                )
                Text("fetchLimit = 3")
                    .font(.caption2.monospaced())
                    .padding(4)
                    .background(.quaternary, in: Capsule())
            }
            C14_Caption("Illustrative — renders live SwiftData results at runtime. Only a prebuilt descriptor exposes limits, offsets, and prefetching.")
        }
        .padding()
    }
}

// MARK: - @State

private struct C14_StateWrappedValueExample: View {
    @State private var query = ""
    @State private var selection = Set<String>()

    private let items = ["Alpha", "Bravo", "Charlie", "Delta"]

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            TextField("Filter", text: $query)
            List(items.filter { query.isEmpty || $0.localizedCaseInsensitiveContains(query) },
                 id: \.self, selection: $selection) { Text($0) }
                .frame(height: 96)
            C14_Caption("\(selection.count) selected. Both inline defaults apply once, when the view's identity is created.")
        }
        .padding()
    }
}

private struct C14_EditItem: Identifiable {
    let id: Int
    let name: String
}

private struct C14_StateOptionalExample: View {
    @State private var editingItem: C14_EditItem?

    private let items = [C14_EditItem(id: 1, name: "Espresso"), C14_EditItem(id: 2, name: "Cortado")]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                ForEach(items) { item in
                    Button("Edit \(item.name)") { editingItem = item }
                }
            }
            Text("editingItem: \(editingItem?.name ?? "nil")").font(.caption.monospaced())
            C14_Caption("Optional state begins as nil with no assignment; setting it presents the sheet, nil dismisses it.")
        }
        .padding()
        .sheet(item: $editingItem) { item in
            VStack(spacing: 12) {
                Text("Editing \(item.name)").font(.headline)
                Button("Done") { editingItem = nil }
            }
            .padding(24)
        }
    }
}

private struct C14_Profile {
    var name = "Ada"
    var isPublic = false
}

private struct C14_StateProjectedExample: View {
    @State private var profile = C14_Profile()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Name", text: $profile.name)
            Toggle("Public", isOn: $profile.isPublic)
            Label(profile.name.isEmpty ? "Anonymous" : profile.name, systemImage: profile.isPublic ? "globe" : "lock")
            C14_Caption("$profile is a Binding<Profile>; chaining .name and .isPublic reaches individual fields of the struct.")
        }
        .padding()
    }
}

@Observable private final class C14_Cart {
    var items: [String] = []
}

private struct C14_StateObservableExample: View {
    @State private var cart = C14_Cart()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("\(cart.items.count) items", systemImage: "cart")
            HStack {
                Button("Add") { cart.items.append("Item \(cart.items.count + 1)") }
                Button("Clear") { cart.items.removeAll() }.disabled(cart.items.isEmpty)
            }
            C14_Caption("The wrapper owns the reference type, creating it once per identity; body re-renders only for properties it reads.")
        }
        .padding()
    }
}

// MARK: - @StateObject

private final class C14_FeedModel: ObservableObject {
    let feedID: String
    let createdAt = Date()
    @Published var query = ""
    @Published var showsUnreadOnly = false
    init(feedID: String) { self.feedID = feedID }
}

private struct C14_FeedHeader: View {
    @StateObject private var model: C14_FeedModel

    init(feedID: String) {
        _model = StateObject(wrappedValue: C14_FeedModel(feedID: feedID))
    }

    var body: some View {
        Text("feed “\(model.feedID)” · model created \(model.createdAt, format: .dateTime.hour().minute().second())")
            .font(.caption.monospaced())
    }
}

private struct C14_StateObjectInitExample: View {
    @State private var renders = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C14_FeedHeader(feedID: "swift-forums")
            Button("Re-render parent (\(renders))") { renders += 1 }
            C14_Caption("Each parent render re-runs FeedHeader.init, yet the creation time never changes: the autoclosure is evaluated once per identity.")
        }
        .padding()
    }
}

private struct C14_StateObjectProjectedExample: View {
    @StateObject private var model = C14_FeedModel(feedID: "news")

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Search", text: $model.query)
            Toggle("Unread only", isOn: $model.showsUnreadOnly)
            Text("query \"\(model.query)\" · unreadOnly \(model.showsUnreadOnly ? "true" : "false")")
                .font(.caption.monospaced())
            C14_Caption("$model is an ObservedObject.Wrapper: dynamic member lookup turns each published property into a Binding.")
        }
        .padding()
    }
}

// MARK: - @UIApplicationDelegateAdaptor (illustrative — iOS only)

private struct C14_UIAppDelegateMetatypeExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C14_AdaptorDiagram(
                wrapperLine: "@UIApplicationDelegateAdaptor(AppDelegate.self)",
                delegateName: "AppDelegate: UIApplicationDelegate",
                callbacks: ["application(_:didFinishLaunchingWithOptions:)", "…didRegisterForRemoteNotificationsWithDeviceToken:"]
            )
            C14_Caption("Illustrative — iOS only. The metatype is instantiated and wired up as the shared application's delegate.")
        }
        .padding()
    }
}

private struct C14_UIAppDelegateInferredExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C14_AdaptorDiagram(
                wrapperLine: "@UIApplicationDelegateAdaptor var appDelegate: AppDelegate",
                delegateName: "AppDelegate (inferred from the type)",
                callbacks: ["no .self argument needed", "same lifecycle callbacks"]
            )
            C14_Caption("Illustrative — iOS only. The declared property type supplies the delegate class.")
        }
        .padding()
    }
}

private final class C14_MockUIAppDelegate: ObservableObject {
    @Published var isRegisteredForPush = false
}

private struct C14_PushStatusBanner: View {
    @EnvironmentObject private var appDelegate: C14_MockUIAppDelegate

    var body: some View {
        Label(appDelegate.isRegisteredForPush ? "device token received" : "not registered",
              systemImage: appDelegate.isRegisteredForPush ? "bell.badge.fill" : "bell.slash")
            .font(.caption.monospaced())
    }
}

private struct C14_UIAppDelegateObservableExample: View {
    @StateObject private var appDelegate = C14_MockUIAppDelegate()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Toggle("$appDelegate.isRegisteredForPush", isOn: $appDelegate.isRegisteredForPush)
            C14_PushStatusBanner()
                .environmentObject(appDelegate)
            C14_Caption("Illustrative — iOS only. With the real adaptor the injection is automatic; the binding and the reader share one published property.")
        }
        .padding()
    }
}

// MARK: - DocumentGroup (illustrative — applies at the Scene level)

private struct C14_DocumentGroupEditorExample: View {
    @State private var text = "# Notes\n\nStart typing…"

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C14_MockWindow(title: "Untitled.md — Edited") {
                TextEditor(text: $text)
                    .font(.body.monospaced())
                    .scrollContentBackground(.hidden)
                    .frame(height: 64)
                    .padding(6)
            }
            C14_Caption("Illustrative — applies at the Scene level. Every File ▸ New starts from the MarkdownFile() template; the editor binds to config.$document.text.")
        }
        .padding()
    }
}

private struct C14_DocumentGroupViewerExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C14_MockWindow(title: "Q3 Report.rpt") {
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Label("Viewer", systemImage: "eye").font(.caption).bold()
                        Spacer()
                        Text("no New · no Save · no editing").font(.caption2).foregroundStyle(.secondary)
                    }
                    Text("Revenue up 12% quarter over quarter; churn flat.")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }
                .padding(8)
            }
            C14_Caption("Illustrative — applies at the Scene level. Registers the app as a viewer for the type; config.document is read-only.")
        }
        .padding()
    }
}

private struct C14_DocumentGroupSwiftDataExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C14_MockWindow(title: "Untitled.trip") {
                VStack(alignment: .leading, spacing: 4) {
                    Label("Trip: Untitled Trip", systemImage: "airplane").font(.callout)
                    Text("inserted by prepareDocument before first display").font(.caption2).foregroundStyle(.secondary)
                    Text("ModelContainer · one store per file").font(.caption2.monospaced())
                }
                .padding(8)
            }
            C14_Caption("Illustrative — applies at the Scene level. Each document gets its own SwiftData store for the model type.")
        }
        .padding()
    }
}

private struct C14_FileDocumentConfigurationExample: View {
    @State private var isEditable = true
    @State private var hasFileURL = false
    @State private var text = "Meeting notes"

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C14_MockWindow(title: hasFileURL ? "Notes.txt" : "Untitled") {
                VStack(alignment: .leading, spacing: 4) {
                    if !isEditable { Text("Read-only").font(.caption).foregroundStyle(.orange) }
                    TextEditor(text: $text)
                        .disabled(!isEditable)
                        .scrollContentBackground(.hidden)
                        .frame(height: 40)
                }
                .padding(6)
            }
            HStack {
                Toggle("isEditable", isOn: $isEditable)
                Toggle("fileURL set", isOn: $hasFileURL)
            }
            C14_Caption("Illustrative — the configuration's isEditable and fileURL drive the banner and the title.")
        }
        .padding()
    }
}

// MARK: - DocumentGroupLaunchScene (illustrative — iOS only)

private struct C14_LaunchTitleCard<Actions: View>: View {
    var title: String
    @ViewBuilder var actions: Actions

    var body: some View {
        VStack(spacing: 8) {
            Text(title).font(.title3).bold()
            HStack { actions }
        }
        .padding(10)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
    }
}

private struct C14_LaunchSceneBasicExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                LinearGradient(colors: [.indigo, .black], startPoint: .top, endPoint: .bottom)
                C14_LaunchTitleCard(title: "Sketchpad") {
                    Button("New Sketch") { }.buttonStyle(.borderedProminent)
                    Button("Import…") { }.buttonStyle(.bordered)
                }
            }
            .frame(width: 240, height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            C14_Caption("Illustrative — iOS only. A title, a row of actions, and a full-bleed background behind everything.")
        }
        .padding()
    }
}

private struct C14_LaunchSceneOverlayExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                Color.indigo
                C14_LaunchTitleCard(title: "Sketchpad") {
                    Button("Create Document") { }.buttonStyle(.borderedProminent)
                }
                .overlay(alignment: .topTrailing) {
                    Image(systemName: "paintpalette.fill")
                        .font(.title)
                        .foregroundStyle(.yellow)
                        .offset(x: 14, y: -14)
                }
            }
            .frame(width: 240, height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            C14_Caption("Illustrative — iOS only. The accessory sits above the title card, positioned at titleViewFrame.maxX / minY.")
        }
        .padding()
    }
}

private struct C14_LaunchGeometryProxyExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [4]))
                    .foregroundStyle(.secondary)
                Text("geo.frame").font(.caption2.monospaced()).padding(6)
                VStack(spacing: 2) {
                    Image(systemName: "cloud.fill").foregroundStyle(.cyan)
                    Text("titleViewFrame.minY − 80").font(.caption2.monospaced()).foregroundStyle(.secondary)
                    RoundedRectangle(cornerRadius: 6)
                        .fill(.blue.opacity(0.15))
                        .frame(width: 130, height: 34)
                        .overlay(Text("geo.titleViewFrame").font(.caption2.monospaced()))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: 240, height: 120)
            C14_Caption("Illustrative — iOS only. The proxy exposes the scene's frame and the title view's frame for anchoring decorations.")
        }
        .padding()
    }
}

private struct C14_NewDocumentButtonExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                Color.indigo
                C14_LaunchTitleCard(title: "Sketchpad") {
                    Button("New Sketch") { }.buttonStyle(.borderedProminent)
                    Button("Create Document") { }.buttonStyle(.borderedProminent)
                }
            }
            .frame(width: 240, height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            C14_Caption("Illustrative — iOS only. Left: a custom title; right: the stock label. Both create a blank document and open it.")
        }
        .padding()
    }
}

// MARK: - MenuBarExtra (illustrative — applies at the Scene level)

private struct C14_MockMenuList: View {
    var items: [String]     // "—" renders a divider

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(Array(items.enumerated()), id: \.offset) { _, item in
                if item == "—" { Divider() } else { Text(item) }
            }
        }
        .font(.callout)
        .padding(8)
        .frame(width: 120, alignment: .leading)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 6))
        .overlay(RoundedRectangle(cornerRadius: 6).stroke(.separator))
    }
}

private struct C14_MenuBarExtraSymbolExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .trailing, spacing: 2) {
                C14_MockMenuBar {
                    Image(systemName: "timer")
                        .padding(.horizontal, 4)
                        .background(.selection, in: RoundedRectangle(cornerRadius: 4))
                        .accessibilityLabel("Timer")
                }
                C14_MockMenuList(items: ["Start", "Stop", "—", "Quit"])
                    .padding(.trailing, 118)
            }
            C14_Caption("Illustrative — applies at the Scene level. The symbol is the status item, the title is its accessibility label, and the content is the pull-down.")
        }
        .padding()
    }
}

private struct C14_MenuBarExtraInsertedExample: View {
    @AppStorage("aviary.c14.showMenuBarExtra") private var showMenuBarExtra = true

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C14_MockMenuBar {
                if showMenuBarExtra {
                    Image(systemName: "swift")
                        .padding(.horizontal, 4)
                        .accessibilityLabel("Companion")
                }
            }
            Toggle("Show in menu bar", isOn: $showMenuBarExtra)
            C14_Caption("Illustrative — applies at the Scene level. The binding adds or removes the status item while the app runs.")
        }
        .padding()
    }
}

private struct C14_MenuBarExtraLabelExample: View {
    @State private var cpuLoad = 0.42

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C14_MockMenuBar {
                HStack(spacing: 3) {
                    Image(systemName: cpuLoad > 0.8 ? "flame.fill" : "cpu")
                    Text(String(format: "%.0f%%", cpuLoad * 100))
                }
                .padding(.horizontal, 4)
            }
            HStack {
                Text("cpuLoad").font(.caption)
                Slider(value: $cpuLoad, in: 0...1)
            }
            C14_Caption("Illustrative — applies at the Scene level. An arbitrary label view can show live text and a symbol that changes with state.")
        }
        .padding()
    }
}

private enum C14_ExtraStyle: String, CaseIterable { case menu, window }

private struct C14_MenuBarExtraStyleExample: View {
    @State private var style: C14_ExtraStyle = .menu

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Picker("Style", selection: $style) {
                ForEach(C14_ExtraStyle.allCases, id: \.self) { Text(".\($0.rawValue)") }
            }
            .pickerStyle(.segmented)
            VStack(alignment: .trailing, spacing: 2) {
                C14_MockMenuBar {
                    Image(systemName: "swift")
                        .padding(.horizontal, 4)
                        .background(.selection, in: RoundedRectangle(cornerRadius: 4))
                }
                switch style {
                case .menu:
                    C14_MockMenuList(items: ["Search…", "Recent", "—", "Quit"])
                        .padding(.trailing, 118)
                case .window:
                    VStack(alignment: .leading, spacing: 6) {
                        TextField("Quick Search", text: .constant(""))
                            .textFieldStyle(.roundedBorder)
                        Text("any SwiftUI hierarchy, 320 × 400").font(.caption2).foregroundStyle(.secondary)
                    }
                    .padding(8)
                    .frame(width: 180)
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(.separator))
                    .padding(.trailing, 88)
                }
            }
            C14_Caption("Illustrative — applies at the Scene level. .menu is a pull-down of menu items; .window is a floating panel hosting any view.")
        }
        .padding()
    }
}

// MARK: - Window (illustrative — applies at the Scene level)

private struct C14_WindowSingleExample: View {
    @State private var isAboutOpen = false
    @State private var openCalls = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 12) {
                VStack(alignment: .leading, spacing: 6) {
                    Button("openWindow(id: \"about\")") {
                        isAboutOpen = true
                        openCalls += 1
                    }
                    Text("calls \(openCalls) · instances \(isAboutOpen ? 1 : 0)").font(.caption.monospaced())
                }
                if isAboutOpen {
                    C14_MockWindow(title: "About Companion", width: 150) {
                        VStack(spacing: 4) {
                            Image(systemName: "swift").font(.title)
                            Text("Companion 1.0").font(.caption)
                        }
                        .padding(8)
                    }
                }
            }
            C14_Caption("Illustrative — applies at the Scene level. Repeated calls bring the single instance forward instead of opening another.")
        }
        .padding()
    }
}

private enum C14_Resizability: String, CaseIterable {
    case contentSize, contentMinSize, automatic

    var note: String {
        switch self {
        case .contentSize: "fixed at the content's size"
        case .contentMinSize: "at least 280 × 400, grows freely"
        case .automatic: "system default"
        }
    }
}

private struct C14_WindowResizabilityExample: View {
    @State private var resizability: C14_Resizability = .contentSize

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Picker("windowResizability", selection: $resizability) {
                ForEach(C14_Resizability.allCases, id: \.self) { Text(".\($0.rawValue)") }
            }
            .pickerStyle(.segmented)
            C14_MockWindow(title: "Inspector", width: 200) {
                ZStack(alignment: .bottomTrailing) {
                    Text(resizability.note).font(.caption).padding(8).frame(maxWidth: .infinity, alignment: .leading)
                    Image(systemName: resizability == .contentSize ? "lock.fill" : "arrow.up.left.and.arrow.down.right")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .padding(4)
                }
                .frame(height: 44)
            }
            C14_Caption("Illustrative — applies at the Scene level. The content's frame(minWidth:minHeight:) becomes the window's limit.")
        }
        .padding()
    }
}

private enum C14_ScreenCorner: String, CaseIterable {
    case topLeading, topTrailing, center, bottomTrailing

    var alignment: Alignment {
        switch self {
        case .topLeading: .topLeading
        case .topTrailing: .topTrailing
        case .center: .center
        case .bottomTrailing: .bottomTrailing
        }
    }
}

private struct C14_WindowDefaultPositionExample: View {
    @State private var position: C14_ScreenCorner = .topTrailing

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: position.alignment) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.blue.opacity(0.08))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(.separator))
                C14_MockWindow(title: "Activity", width: 90) {
                    Color.clear.frame(height: 28)
                }
                .padding(8)
            }
            .frame(width: 240, height: 110)
            .animation(.snappy, value: position)
            Picker("defaultPosition", selection: $position) {
                ForEach(C14_ScreenCorner.allCases, id: \.self) { Text(".\($0.rawValue)") }
            }
            C14_Caption("Illustrative — applies at the Scene level. The UnitPoint places the first launch; the user's own placement is restored afterwards.")
        }
        .padding()
    }
}

private enum C14_WindowLevel: String, CaseIterable {
    case floating, normal, desktop

    var zIndex: Double {
        switch self {
        case .floating: 3
        case .normal: 1.5
        case .desktop: 0
        }
    }
}

private struct C14_WindowLevelExample: View {
    @State private var level: C14_WindowLevel = .floating

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.green.opacity(0.08))
                    .overlay(alignment: .bottomLeading) { Text("Desktop").font(.caption2).foregroundStyle(.secondary).padding(4) }
                    .zIndex(0.5)
                C14_MockWindow(title: "Finder", width: 150) { Color.clear.frame(height: 44) }
                    .offset(x: -30, y: 6)
                    .zIndex(1)
                C14_MockWindow(title: "Now Playing", width: 120) {
                    Label("Track 3", systemImage: "music.note").font(.caption).padding(6)
                }
                .offset(x: 40, y: -10)
                .zIndex(level.zIndex)
            }
            .frame(width: 240, height: 100)
            Picker("windowLevel", selection: $level) {
                ForEach(C14_WindowLevel.allCases, id: \.self) { Text(".\($0.rawValue)") }
            }
            .pickerStyle(.segmented)
            C14_Caption("Illustrative — applies at the Scene level. .floating stays above ordinary windows; .desktop sits beneath them.")
        }
        .padding()
    }
}

// MARK: - WindowGroup (illustrative — applies at the Scene level)

private struct C14_WindowGroupTitledExample: View {
    @State private var windowCount = 1

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topLeading) {
                ForEach(0..<windowCount, id: \.self) { i in
                    C14_MockWindow(title: "Library", width: 170) {
                        Label("Library", systemImage: "books.vertical").font(.caption).padding(6)
                    }
                    .offset(x: CGFloat(i) * 22, y: CGFloat(i) * 14)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 84)
            Button("File ▸ New Window") { windowCount = min(3, windowCount + 1) }
                .disabled(windowCount >= 3)
            C14_Caption("Illustrative — applies at the Scene level. Every window in the group is identical, and the title names the group in the Window menu.")
        }
        .padding()
    }
}

private struct C14_WindowGroupIDExample: View {
    @State private var windowCount = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topLeading) {
                ForEach(0..<windowCount, id: \.self) { i in
                    C14_MockWindow(title: "main", width: 150) {
                        Text("ContentView").font(.caption).padding(6)
                    }
                    .offset(x: CGFloat(i) * 22, y: CGFloat(i) * 14)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 76)
            Button("openWindow(id: \"main\")") { windowCount = min(3, windowCount + 1) }
                .disabled(windowCount >= 3)
            C14_Caption("Illustrative — applies at the Scene level. The id lets openWindow target this group; each call opens a fresh window.")
        }
        .padding()
    }
}

private struct C14_WindowGroupForValueExample: View {
    @State private var openNoteIDs: [Int?] = []

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topLeading) {
                ForEach(Array(openNoteIDs.enumerated()), id: \.offset) { i, id in
                    C14_MockWindow(title: id.map { "Note \($0)" } ?? "Untitled", width: 130) {
                        Text(id.map { "noteID = \($0)" } ?? "noteID = nil")
                            .font(.caption.monospaced())
                            .padding(6)
                    }
                    .offset(x: CGFloat(i) * 22, y: CGFloat(i) * 14)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 80)
            HStack {
                Button("openWindow(value: 1)") { open(1) }
                Button("openWindow(value: 2)") { open(2) }
                Button("New Window") { open(nil) }
            }
            .disabled(openNoteIDs.count >= 4)
            C14_Caption("Illustrative — applies at the Scene level. One window per distinct value; an existing value is reused, and a plain New Window gets nil.")
        }
        .padding()
    }

    private func open(_ id: Int?) {
        if let id, openNoteIDs.contains(id) { return }
        openNoteIDs.append(id)
    }
}
