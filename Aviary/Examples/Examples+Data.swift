//
//  Examples+Data.swift
//  Aviary
//
//  Rendered usage examples for the entries in CatalogData/gen-data.json.
//  Entries that already have an interactive demo (demoID) are not here.
//
//  This domain leans non-visual (app/scene infrastructure, property wrappers,
//  environment values, protocols). Every entry still gets a rendered demo:
//  where an API only applies at the Scene level or needs live Core Data /
//  focus state, the view is a faithful illustration with a caption and the
//  true API is preserved in the code string.
//

import SwiftUI
import SwiftData
import Observation
internal import Combine
import AppKit

enum ExamplesData {
    static let entries: [ExampleEntry] = [
        ExampleEntry(topic: ".backgroundTask()", code: """
        WindowGroup { ContentView() }
            .backgroundTask(.appRefresh("com.example.sync")) {
                await store.sync()
            }
        """) { AnyView(Da_BackgroundTaskExample()) },

        ExampleEntry(topic: ".defaultAppStorage()", code: """
        @AppStorage("da.greeting") private var greeting = "Hi there"

        Form {
            TextField("Greeting", text: $greeting)
            LabeledContent("Persisted", value: greeting)
        }
        // redirect the subtree to a shared suite:
        GreetingEditor()
            .defaultAppStorage(UserDefaults(suiteName: "group.com.example.shared") ?? .standard)
        """) { AnyView(Da_DefaultAppStorageExample()) },

        ExampleEntry(topic: ".environment()", code: """
        Reader()
            .environment(\\.locale, Locale(identifier: "fr_FR"))
            .environment(router) // any @Observable object
        """) { AnyView(Da_EnvironmentExample()) },

        ExampleEntry(topic: ".environmentObject()", code: """
        @StateObject private var cart = CartModel()

        VStack {
            CartBadge()               // reads @EnvironmentObject
            Button("Add") { cart.items.append("…") }
        }
        .environmentObject(cart)
        """) { AnyView(Da_EnvironmentObjectExample()) },

        ExampleEntry(topic: ".equatable()", code: """
        ChartBars(values: values)
            .equatable() // skips body re-eval unless `values` changes
        """) { AnyView(Da_EquatableExample()) },

        ExampleEntry(topic: ".focusedSceneObject()", code: """
        WindowGroup {
            DocumentView(model: model)
                .focusedSceneObject(model)
        }
        """) { AnyView(Da_FocusedSceneObjectExample()) },

        ExampleEntry(topic: ".id()", code: """
        Counter()
            .id(sessionID) // bumping sessionID resets the counter's @State
        """) { AnyView(Da_IDExample()) },

        ExampleEntry(topic: ".modelContainer()", code: """
        @Query(sort: \\Recipe.name) private var recipes: [Recipe]
        @Environment(\\.modelContext) private var context

        ForEach(recipes) { Text($0.name) }
        Button("Add") { context.insert(Recipe(name: "Recipe \\(recipes.count + 1)")) }

        RecipeRoster()
            .modelContainer(for: Recipe.self, inMemory: true)
        """) { AnyView(Da_ModelContainerExample()) },

        ExampleEntry(topic: ".modelContext()", code: """
        let context = container.mainContext   // a scratch / preview context

        RecipeList()
            .modelContext(context)

        // inside RecipeList:
        @Environment(\\.modelContext) private var context
        context.insert(Recipe(name: "Draft"))
        let drafts = try context.fetch(FetchDescriptor<Recipe>())
        """) { AnyView(Da_ModelContextExample()) },

        ExampleEntry(topic: ".onCommand()", code: """
        CanvasView(selection: $selection)
            .onCommand(#selector(NSResponder.selectAll(_:))) {
                selection = allShapes
            }
        """) { AnyView(Da_OnCommandExample()) },

        ExampleEntry(topic: ".onDisappear()", code: """
        PlayerView(item: episode)
            .onDisappear { player.pause() }
        """) { AnyView(Da_OnDisappearExample()) },

        ExampleEntry(topic: ".onReceive()", code: """
        Text(now, format: .dateTime.hour().minute().second())
            .onReceive(
                Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            ) { now = $0 }
        """) { AnyView(Da_OnReceiveExample()) },

        ExampleEntry(topic: ".preferredColorScheme()", code: """
        ContentView()
            .preferredColorScheme(forceDark ? .dark : nil)
        """) { AnyView(Da_PreferredColorSchemeExample()) },

        ExampleEntry(topic: ".tag()", code: """
        Picker("Sort", selection: $sort) {
            Text("Name").tag(SortOrder.name)
            Text("Date").tag(SortOrder.date)
            Text("Size").tag(SortOrder.size)
        }
        """) { AnyView(Da_TagExample()) },

        ExampleEntry(topic: ".transformEnvironment()", code: """
        content
            .transformEnvironment(\\.font) { font in
                font = (font ?? .body).bold()
            }
        """) { AnyView(Da_TransformEnvironmentExample()) },

        ExampleEntry(topic: "@Model", code: """
        @Model final class Recipe {
            var name: String
            var createdAt = Date.now
            init(name: String) { self.name = name }
        }

        @State private var recipe = Recipe(name: "Pancakes")
        TextField("Name", text: $recipe.name) // @Model brings Observation
        """) { AnyView(Da_ModelExample()) },

        ExampleEntry(topic: "@ObservationIgnored", code: """
        @Observable final class Feed {
            var unread = 3
            @ObservationIgnored var lastCursor = "—"
        }
        // mutating `unread` refreshes views; writing `lastCursor` does not
        """) { AnyView(Da_ObservationIgnoredExample()) },

        ExampleEntry(topic: "@SectionedFetchRequest", code: """
        @SectionedFetchRequest(
            sectionIdentifier: \\Quake.day,
            sortDescriptors: [SortDescriptor(\\Quake.day, order: .reverse),
                              SortDescriptor(\\Quake.time, order: .reverse)]
        ) private var quakes: SectionedFetchResults<String, Quake>

        List(quakes) { section in
            Section(section.id) { ForEach(section) { Text($0.place) } }
        }
        """) { AnyView(Da_SectionedFetchRequestExample()) },

        ExampleEntry(topic: "Binding", code: """
        let volume = Binding(
            get: { mixer.volume },
            set: { mixer.volume = $0 }
        )
        Slider(value: volume, in: 0...1)

        Toggle("Muted", isOn: .constant(true)) // read-only binding
        """) { AnyView(Da_BindingExample()) },

        ExampleEntry(topic: "EnvironmentValues", code: """
        private struct AccentTintKey: EnvironmentKey {
            static let defaultValue = Color.blue
        }
        extension EnvironmentValues {
            var accentTint: Color {
                get { self[AccentTintKey.self] }
                set { self[AccentTintKey.self] = newValue }
            }
        }

        TintSwatch().environment(\\.accentTint, .orange)
        """) { AnyView(Da_EnvironmentValuesExample()) },

        ExampleEntry(topic: "EquatableView", code: """
        EquatableView(content:
            WaveformView(values: values)
        )
        """) { AnyView(Da_EquatableViewExample()) },

        ExampleEntry(topic: "FetchedResults", code: """
        @FetchRequest(sortDescriptors: [SortDescriptor(\\Recipe.name)])
        private var recipes: FetchedResults<Recipe>

        List(recipes) { RecipeRow(recipe: $0) } // stays in sync with the context
        """) { AnyView(Da_FetchedResultsExample()) },

        ExampleEntry(topic: "FocusedValueKey", code: """
        struct SelectedNoteKey: FocusedValueKey {
            typealias Value = Note
        }
        extension FocusedValues {
            var selectedNote: Note? {
                get { self[SelectedNoteKey.self] }
                set { self[SelectedNoteKey.self] = newValue }
            }
        }
        """) { AnyView(Da_FocusedValueKeyExample()) },

        ExampleEntry(topic: "ModelContainer", code: """
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Recipe.self, configurations: config)

        let context = container.mainContext
        context.insert(Recipe(name: "Pancakes"))
        try context.save()
        """) { AnyView(Da_ModelContainerTypeExample()) },

        ExampleEntry(topic: "Observable", code: """
        @Observable final class Nav {
            var depth = 0
            var title = "Home"
        }

        @State private var nav = Nav()
        Button("Push") { nav.depth += 1 } // re-renders because body reads depth
        """) { AnyView(Da_ObservableExample()) },

        ExampleEntry(topic: "ObservableObject", code: """
        final class CartModel: ObservableObject {
            @Published var items: [Item] = []
            var total: Int { items.count }
        }

        @StateObject private var cart = CartModel()
        """) { AnyView(Da_ObservableObjectExample()) },

        ExampleEntry(topic: "OpenURLAction", code: """
        Button("Read the docs") { openURL(url) }
            .environment(\\.openURL, OpenURLAction { url in
                intercepted = url.absoluteString
                return .handled   // or .discarded / .systemAction
            })
        """) { AnyView(Da_OpenURLActionExample()) },
    ]
}

// MARK: - Shared model & helpers

/// A SwiftData model reused by the SwiftData examples below.
@Model final class Da_Recipe {
    var name: String
    var createdAt: Date
    init(name: String, createdAt: Date = .now) {
        self.name = name
        self.createdAt = createdAt
    }
}

/// A tiny Equatable chart reused by `.equatable()` and `EquatableView`.
private struct Da_Bars: View, Equatable {
    let values: [Double]

    var body: some View {
        HStack(alignment: .bottom, spacing: 6) {
            ForEach(Array(values.enumerated()), id: \.offset) { _, value in
                RoundedRectangle(cornerRadius: 3)
                    .fill(.tint)
                    .frame(width: 18, height: 8 + value * 70)
            }
        }
        .frame(maxWidth: .infinity)
    }

    static func == (lhs: Da_Bars, rhs: Da_Bars) -> Bool {
        lhs.values == rhs.values
    }
}

// MARK: - .backgroundTask()

private struct Da_BackgroundTaskExample: View {
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 14) {
                RoundedRectangle(cornerRadius: 14)
                    .fill(LinearGradient(colors: [.blue, .indigo],
                                         startPoint: .top, endPoint: .bottom))
                    .frame(width: 52, height: 52)
                    .overlay(
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .font(.title2).foregroundStyle(.white)
                    )
                VStack(alignment: .leading, spacing: 3) {
                    Text("Feed").font(.headline)
                    Label("Woken to refresh in the background",
                          systemImage: "circle.dashed")
                        .font(.caption).foregroundStyle(.secondary)
                }
                Spacer()
            }

            VStack(alignment: .leading, spacing: 5) {
                Da_Step(index: 1, text: "System grants a short refresh window")
                Da_Step(index: 2, text: "await store.sync() runs as structured work")
                Da_Step(index: 3, text: "Run ends when the closure returns")
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Text("Illustrative — .backgroundTask applies at the Scene level (iOS / tvOS / watchOS).")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding(4)
    }
}

private struct Da_Step: View {
    let index: Int
    let text: String
    var body: some View {
        HStack(spacing: 8) {
            Text("\(index)")
                .font(.caption2.bold())
                .foregroundStyle(.white)
                .frame(width: 18, height: 18)
                .background(.tint, in: .circle)
            Text(text).font(.caption)
        }
    }
}

// MARK: - .defaultAppStorage()

private let da_sharedDefaults = UserDefaults(suiteName: "group.com.swiftuicompanion.demo") ?? .standard

private struct Da_DefaultAppStorageExample: View {
    var body: some View {
        VStack(spacing: 8) {
            Da_GreetingEditor()
                .defaultAppStorage(da_sharedDefaults)
            Text("@AppStorage in the editor reads the suite installed by .defaultAppStorage.")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

private struct Da_GreetingEditor: View {
    @AppStorage("da.greeting") private var greeting = "Hi there"

    var body: some View {
        Form {
            TextField("Greeting", text: $greeting)
            LabeledContent("Persisted", value: greeting)
        }
        .formStyle(.grouped)
        .frame(height: 110)
        .clipShape(.rect(cornerRadius: 8))
    }
}

// MARK: - .environment()

@Observable final class Da_Router {
    var visited = 1
}

private struct Da_EnvironmentExample: View {
    @State private var router = Da_Router()

    var body: some View {
        VStack(spacing: 10) {
            Da_EnvReader()
                .environment(\.locale, Locale(identifier: "fr_FR"))
                .environment(router)

            Button("Visit next screen") { router.visited += 1 }
                .buttonStyle(.bordered)
        }
    }
}

private struct Da_EnvReader: View {
    @Environment(\.locale) private var locale
    @Environment(Da_Router.self) private var router

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            LabeledContent("locale", value: locale.identifier)
            LabeledContent("1234.5", value: 1234.5.formatted(.number.locale(locale)))
            LabeledContent("router.visited", value: "\(router.visited)")
        }
        .font(.callout.monospaced())
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
    }
}

// MARK: - .environmentObject()

private final class Da_Cart: ObservableObject {
    @Published var items: [String] = ["Keyboard"]
}

private struct Da_EnvironmentObjectExample: View {
    @StateObject private var cart = Da_Cart()

    var body: some View {
        VStack(spacing: 12) {
            Da_CartBadge()
            Button("Add item") { cart.items.append("Item \(cart.items.count + 1)") }
                .buttonStyle(.bordered)
        }
        .environmentObject(cart)
    }
}

private struct Da_CartBadge: View {
    @EnvironmentObject private var cart: Da_Cart

    var body: some View {
        Label("\(cart.items.count) in cart", systemImage: "cart")
            .font(.title3)
            .padding(.horizontal, 14).padding(.vertical, 8)
            .background(.tint.opacity(0.15), in: .capsule)
    }
}

// MARK: - .equatable()

private struct Da_EquatableExample: View {
    @State private var values: [Double] = [0.3, 0.7, 0.5, 0.9, 0.4]
    @State private var tick = 0

    var body: some View {
        VStack(spacing: 10) {
            Da_Bars(values: values)
                .equatable()
                .frame(height: 88)

            HStack {
                Button("Shuffle data") {
                    values = values.map { _ in Double.random(in: 0.1...1) }
                }
                Button("Unrelated tick (\(tick))") { tick += 1 }
            }
            .buttonStyle(.bordered)

            Text("Only “Shuffle” changes `values`, so only it re-runs the bars' body.")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

// MARK: - .focusedSceneObject()

private struct Da_FocusedSceneObjectExample: View {
    var body: some View {
        VStack(spacing: 10) {
            Da_MockWindow(dark: false) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Untitled.md").font(.headline)
                    HStack(spacing: 8) {
                        Image(systemName: "doc.text").foregroundStyle(.tint)
                        Text("Document model published to the scene")
                            .font(.caption)
                    }
                    Divider()
                    Label("File ▸ Export…  ", systemImage: "square.and.arrow.up")
                        .font(.caption)
                        .foregroundStyle(.primary)
                    Text("enabled — the command reads @FocusedObject")
                        .font(.caption2).foregroundStyle(.green)
                }
            }
            Text("Illustrative — .focusedSceneObject feeds @FocusedObject in Scene-level commands.")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

// MARK: - .id()

private struct Da_IDExample: View {
    @State private var sessionID = 0

    var body: some View {
        VStack(spacing: 10) {
            Da_Counter()
                .id(sessionID)

            Button("New session (resets state)") { sessionID += 1 }
                .buttonStyle(.bordered)

            Text("Changing .id() tears the counter down and rebuilds it — its @State returns to 0.")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

private struct Da_Counter: View {
    @State private var count = 0

    var body: some View {
        Stepper("Count: \(count)", value: $count, in: 0...99)
            .fixedSize()
            .padding(10)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 8))
    }
}

// MARK: - .modelContainer()

private struct Da_ModelContainerExample: View {
    var body: some View {
        Da_RecipeRoster()
            .modelContainer(for: Da_Recipe.self, inMemory: true)
    }
}

private struct Da_RecipeRoster: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Da_Recipe.name) private var recipes: [Da_Recipe]

    var body: some View {
        VStack(spacing: 8) {
            if recipes.isEmpty {
                Text("No recipes yet").foregroundStyle(.secondary)
            } else {
                ForEach(recipes) { recipe in
                    Label(recipe.name, systemImage: "fork.knife").font(.callout)
                }
            }
            Button("Add recipe") {
                context.insert(Da_Recipe(name: "Recipe \(recipes.count + 1)"))
            }
            .buttonStyle(.bordered)
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            if recipes.isEmpty {
                context.insert(Da_Recipe(name: "Pancakes"))
                context.insert(Da_Recipe(name: "Waffles"))
            }
        }
    }
}

// MARK: - .modelContext()

private struct Da_ModelContextExample: View {
    @State private var container: ModelContainer? = try? ModelContainer(
        for: Da_Recipe.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true))

    var body: some View {
        Group {
            if let container {
                Da_ContextRoster()
                    .modelContext(container.mainContext)
            } else {
                Label("Store unavailable", systemImage: "exclamationmark.triangle")
            }
        }
    }
}

private struct Da_ContextRoster: View {
    @Environment(\.modelContext) private var context
    @State private var names: [String] = []

    var body: some View {
        VStack(spacing: 8) {
            Text("Injected context holds \(names.count) draft\(names.count == 1 ? "" : "s")")
                .font(.callout)
            ForEach(names, id: \.self) { name in
                Label(name, systemImage: "doc").font(.caption)
            }
            Button("Insert draft") {
                context.insert(Da_Recipe(name: "Draft \(names.count + 1)"))
                reload()
            }
            .buttonStyle(.bordered)
        }
        .frame(maxWidth: .infinity)
        .onAppear(perform: reload)
    }

    private func reload() {
        let fetched = (try? context.fetch(
            FetchDescriptor<Da_Recipe>(sortBy: [SortDescriptor(\.name)]))) ?? []
        names = fetched.map(\.name)
    }
}

// MARK: - .onCommand()

private struct Da_OnCommandExample: View {
    private let shapes = Array(0..<8)
    @State private var selected: Set<Int> = [2]

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 6) {
                ForEach(shapes, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 5)
                        .fill(selected.contains(index)
                              ? AnyShapeStyle(.tint) : AnyShapeStyle(.quaternary))
                        .frame(width: 26, height: 26)
                        .onTapGesture {
                            if selected.contains(index) { selected.remove(index) }
                            else { selected.insert(index) }
                        }
                }
            }
            .onCommand(#selector(NSResponder.selectAll(_:))) {
                selected = Set(shapes)
            }

            HStack {
                Button("Select All (⌘A)") { selected = Set(shapes) }
                Button("Clear") { selected.removeAll() }
            }
            .buttonStyle(.bordered)

            Text("Edit ▸ Select All (⌘A) fires selectAll(_:) up the responder chain to this view.")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

// MARK: - .onDisappear()

private struct Da_OnDisappearExample: View {
    @State private var showing = true
    @State private var pauses = 0

    var body: some View {
        VStack(spacing: 10) {
            Toggle("Show player", isOn: $showing.animation())

            if showing {
                Da_MiniPlayer()
                    .onDisappear { pauses += 1 }
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.quaternary)
                    .frame(height: 58)
                    .overlay(Text("Hidden").foregroundStyle(.secondary))
            }

            Text("Paused on disappear \(pauses) time\(pauses == 1 ? "" : "s")")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

private struct Da_MiniPlayer: View {
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "play.circle.fill")
                .font(.largeTitle).foregroundStyle(.tint)
            VStack(alignment: .leading, spacing: 2) {
                Text("Now Playing").font(.headline)
                Text("Track 1 — Demo").font(.caption).foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding()
        .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
    }
}

// MARK: - .onReceive()

private struct Da_OnReceiveExample: View {
    @State private var now = Date()
    private let ticker = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 8) {
            Text(now, format: .dateTime.hour().minute().second())
                .font(.system(.largeTitle, design: .rounded).monospacedDigit())
            Text("Updated once a second by a Combine Timer publisher via .onReceive")
                .font(.caption).foregroundStyle(.secondary)
        }
        .onReceive(ticker) { now = $0 }
    }
}

// MARK: - .preferredColorScheme()

private enum Da_SchemeChoice: String, CaseIterable, Identifiable {
    case system = "System", light = "Light", dark = "Dark"
    var id: Self { self }
    var scheme: ColorScheme? {
        switch self {
        case .system: nil
        case .light: .light
        case .dark: .dark
        }
    }
}

private struct Da_PreferredColorSchemeExample: View {
    @Environment(\.colorScheme) private var systemScheme
    @State private var choice: Da_SchemeChoice = .dark

    private var isDark: Bool { (choice.scheme ?? systemScheme) == .dark }

    var body: some View {
        VStack(spacing: 10) {
            Picker("Appearance", selection: $choice) {
                ForEach(Da_SchemeChoice.allCases) { Text($0.rawValue).tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            Da_MockWindow(dark: isDark) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Appearance").font(.headline)
                    Text("The window and its chrome follow the requested scheme.")
                        .font(.caption)
                }
            }

            Text("Illustrative — .preferredColorScheme flips the whole enclosing window; nil defers to the system.")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

// MARK: - .tag()

private enum Da_Sort: String, CaseIterable, Identifiable {
    case name = "Name", date = "Date", size = "Size"
    var id: Self { self }
}

private struct Da_TagExample: View {
    @State private var sort: Da_Sort = .date

    var body: some View {
        VStack(spacing: 12) {
            Picker("Sort", selection: $sort) {
                Text("Name").tag(Da_Sort.name)
                Text("Date").tag(Da_Sort.date)
                Text("Size").tag(Da_Sort.size)
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            LabeledContent("selection", value: sort.rawValue)
                .font(.callout.monospaced())

            Text("Each option's .tag() value is matched against the selection binding.")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

// MARK: - .transformEnvironment()

private struct Da_TransformEnvironmentExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack(alignment: .leading, spacing: 4) {
                Text("inherited font").font(.caption).foregroundStyle(.secondary)
                Text("The quick brown fox")
            }
            VStack(alignment: .leading, spacing: 4) {
                Text("after .transformEnvironment(\\.font)")
                    .font(.caption).foregroundStyle(.secondary)
                Text("The quick brown fox")
                    .transformEnvironment(\.font) { font in
                        font = (font ?? .body).bold()
                    }
            }
        }
        .font(.title3)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - @Model

private struct Da_ModelExample: View {
    @State private var recipe = Da_Recipe(name: "Pancakes")

    var body: some View {
        @Bindable var recipe = recipe
        return VStack(spacing: 12) {
            HStack(spacing: 12) {
                Image(systemName: "fork.knife.circle.fill")
                    .font(.largeTitle).foregroundStyle(.tint)
                VStack(alignment: .leading, spacing: 2) {
                    Text(recipe.name).font(.headline)
                    Text(recipe.createdAt, format: .dateTime.hour().minute().second())
                        .font(.caption).foregroundStyle(.secondary)
                }
                Spacer()
            }
            TextField("Name", text: $recipe.name)
                .textFieldStyle(.roundedBorder)
            Text("@Model adds Observation, so editing recipe.name refreshes the view.")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

// MARK: - @ObservationIgnored

@Observable private final class Da_Feed {
    var unread = 3
    @ObservationIgnored var lastCursor = "—"
}

private struct Da_ObservationIgnoredExample: View {
    @State private var feed = Da_Feed()

    var body: some View {
        VStack(spacing: 10) {
            LabeledContent("unread (tracked)", value: "\(feed.unread)")
            LabeledContent("lastCursor (ignored)", value: feed.lastCursor)
                .font(.callout.monospaced())

            HStack {
                Button("unread += 1") { feed.unread += 1 }
                Button("set cursor") {
                    feed.lastCursor = String(UUID().uuidString.prefix(6))
                }
            }
            .buttonStyle(.bordered)

            Text("“set cursor” changes an ignored property — the label stays stale until a tracked change redraws.")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

// MARK: - @SectionedFetchRequest

private struct Da_SectionedFetchRequestExample: View {
    private let groups: [(day: String, quakes: [(place: String, mag: Double)])] = [
        ("Today", [("Ridgecrest", 4.2), ("Ojai", 3.1)]),
        ("Yesterday", [("Anchorage", 5.0), ("Kodiak", 4.6)]),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            List {
                ForEach(groups, id: \.day) { group in
                    Section(group.day) {
                        ForEach(group.quakes, id: \.place) { quake in
                            HStack {
                                Text(quake.place)
                                Spacer()
                                Text(quake.mag, format: .number.precision(.fractionLength(1)))
                                    .monospacedDigit().foregroundStyle(.tint)
                            }
                        }
                    }
                }
            }
            .frame(height: 150)

            Text("Illustrative — @SectionedFetchRequest groups live Core Data results by a key path.")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

// MARK: - Binding

private struct Da_BindingExample: View {
    @State private var volume = 0.4

    var body: some View {
        let volumeBinding = Binding(
            get: { volume },
            set: { volume = $0 }
        )
        return VStack(spacing: 12) {
            Slider(value: volumeBinding, in: 0...1)
            LabeledContent("volume",
                           value: volume.formatted(.percent.precision(.fractionLength(0))))
                .font(.callout.monospaced())
            Toggle("Muted (Binding.constant)", isOn: .constant(true))
                .disabled(true)
        }
    }
}

// MARK: - EnvironmentValues

private struct Da_AccentTintKey: EnvironmentKey {
    static let defaultValue = Color.blue
}

extension EnvironmentValues {
    fileprivate var da_accentTint: Color {
        get { self[Da_AccentTintKey.self] }
        set { self[Da_AccentTintKey.self] = newValue }
    }
}

private struct Da_EnvironmentValuesExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 18) {
                Da_TintSwatch()
                    .environment(\.da_accentTint, .orange)
                Da_TintSwatch() // inherits the default, .blue
            }
            Text("A custom EnvironmentValues entry read with @Environment. Since 2024, @Entry replaces this boilerplate.")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

private struct Da_TintSwatch: View {
    @Environment(\.da_accentTint) private var tint

    var body: some View {
        VStack(spacing: 4) {
            RoundedRectangle(cornerRadius: 8)
                .fill(tint)
                .frame(width: 76, height: 46)
            Text(tint == .orange ? ".orange (override)" : ".blue (default)")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - EquatableView

private struct Da_EquatableViewExample: View {
    @State private var values: [Double] = [0.5, 0.8, 0.4, 0.9]

    var body: some View {
        VStack(spacing: 10) {
            EquatableView(content: Da_Bars(values: values))
                .frame(height: 88)

            Button("New waveform") {
                values = (0..<4).map { _ in Double.random(in: 0.1...1) }
            }
            .buttonStyle(.bordered)

            Text("EquatableView<Content> is what .equatable() returns; you can build it directly.")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

// MARK: - FetchedResults

private struct Da_FetchedResultsExample: View {
    @State private var recipes = ["Pancakes", "Waffles", "Crêpes"]

    var body: some View {
        VStack(spacing: 8) {
            List {
                ForEach(recipes, id: \.self) { Text($0) }
                    .onDelete { recipes.remove(atOffsets: $0) }
            }
            .frame(height: 120)

            HStack {
                Button("Insert") { recipes.append("Recipe \(recipes.count + 1)") }
                    .buttonStyle(.bordered)
                Spacer()
                Text("Illustrative — FetchedResults mirrors the managed object context live.")
                    .font(.caption).foregroundStyle(.secondary)
            }
        }
    }
}

// MARK: - FocusedValueKey

private struct Da_SelectedNoteKey: FocusedValueKey {
    typealias Value = String
}

extension FocusedValues {
    fileprivate var da_selectedNote: String? {
        get { self[Da_SelectedNoteKey.self] }
        set { self[Da_SelectedNoteKey.self] = newValue }
    }
}

private struct Da_FocusedValueKeyExample: View {
    @State private var noteFocused = true

    var body: some View {
        VStack(spacing: 10) {
            Toggle("A note currently has focus", isOn: $noteFocused)

            HStack {
                Label(noteFocused ? "Rename “Draft”" : "Rename", systemImage: "pencil")
                Spacer()
                Text(noteFocused ? "enabled" : "disabled")
                    .foregroundStyle(noteFocused ? Color.green : Color.secondary)
            }
            .padding(10)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 8))
            .opacity(noteFocused ? 1 : 0.5)

            Text("Illustrative — @FocusedValue is nil when nothing relevant has focus, so commands disable themselves.")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

// MARK: - ModelContainer

private struct Da_ModelContainerTypeExample: View {
    @State private var status = "Building container…"
    @State private var count = 0

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "cylinder.split.1x2")
                .font(.largeTitle).foregroundStyle(.tint)
            Text(status).font(.callout)
            LabeledContent("Recipes in store", value: "\(count)")
                .font(.callout.monospaced())
                .fixedSize()
            Text("An in-memory ModelContainer, seeded through its mainContext.")
                .font(.caption).foregroundStyle(.secondary)
        }
        .task { await build() }
    }

    @MainActor private func build() async {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Da_Recipe.self, configurations: config)
            let context = container.mainContext
            context.insert(Da_Recipe(name: "Pancakes"))
            context.insert(Da_Recipe(name: "Waffles"))
            try context.save()
            count = (try? context.fetchCount(FetchDescriptor<Da_Recipe>())) ?? 0
            status = "In-memory container ready"
        } catch {
            status = "Failed to build container"
        }
    }
}

// MARK: - Observable

@Observable private final class Da_Nav {
    var depth = 0
    var title = "Home"
}

private struct Da_ObservableExample: View {
    @State private var nav = Da_Nav()

    var body: some View {
        VStack(spacing: 10) {
            LabeledContent("title", value: nav.title)
            LabeledContent("depth", value: "\(nav.depth)")

            HStack {
                Button("Push") {
                    nav.depth += 1
                    nav.title = "Screen \(nav.depth)"
                }
                Button("Pop") {
                    guard nav.depth > 0 else { return }
                    nav.depth -= 1
                    nav.title = nav.depth == 0 ? "Home" : "Screen \(nav.depth)"
                }
            }
            .buttonStyle(.bordered)

            Text("The @Observable macro adds the conformance; the view updates on the properties it reads.")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

// MARK: - ObservableObject

private final class Da_CartModel: ObservableObject {
    @Published var items: [String] = ["Keyboard", "Mouse"]
    var total: Int { items.count }
}

private struct Da_ObservableObjectExample: View {
    @StateObject private var cart = Da_CartModel()

    var body: some View {
        VStack(spacing: 8) {
            LabeledContent("items in cart", value: "\(cart.total)")
                .font(.callout.monospaced())
            ForEach(cart.items, id: \.self) { item in
                Label(item, systemImage: "bag").font(.callout)
            }
            Button("Add item") { cart.items.append("Item \(cart.items.count + 1)") }
                .buttonStyle(.bordered)
        }
    }
}

// MARK: - OpenURLAction

private struct Da_OpenURLActionExample: View {
    @State private var intercepted = "—"

    var body: some View {
        VStack(spacing: 10) {
            Da_OpenURLRow()
                .environment(\.openURL, OpenURLAction { url in
                    intercepted = url.absoluteString
                    return .handled
                })

            LabeledContent("intercepted", value: intercepted)
                .font(.callout.monospaced())

            Text("A custom OpenURLAction returns .handled to swallow the link instead of opening a browser.")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

private struct Da_OpenURLRow: View {
    @Environment(\.openURL) private var openURL

    var body: some View {
        Button("Read the docs") {
            if let url = URL(string: "https://example.com/docs") {
                openURL(url)
            }
        }
        .buttonStyle(.bordered)
    }
}

// MARK: - Mock window chrome (shared illustration)

private struct Da_MockWindow<Content: View>: View {
    let dark: Bool
    @ViewBuilder let content: Content

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 6) {
                Circle().fill(.red).frame(width: 10, height: 10)
                Circle().fill(.yellow).frame(width: 10, height: 10)
                Circle().fill(.green).frame(width: 10, height: 10)
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 7)
            .background(dark ? Color(white: 0.18) : Color(white: 0.92))

            content
                .foregroundStyle(dark ? Color.white : Color.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(12)
                .background(dark ? Color(white: 0.11) : Color.white)
        }
        .clipShape(.rect(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))
    }
}
