//
//  Examples+PropertyWrappers.swift
//  Aviary
//
//  Rendered usage examples for the entries in CatalogData/property-wrappers.json.
//  Entries that already have an interactive demo (demoID) are not here.
//
//  This domain leans non-visual (property wrappers, environment values, app
//  infrastructure). Wrappers that cannot execute a rendered result on their own
//  are shown as faithful, captioned illustrations while their code string keeps
//  the real API exactly as written.
//

import SwiftUI
internal import Combine
import CoreGraphics

enum ExamplesPropertyWrappers {
    static let entries: [ExampleEntry] = [
        ExampleEntry(topic: "@Animatable", code: """
        @Animatable
        struct Wedge: Shape {
            var startAngle: Angle
            var endAngle: Angle
            func path(in rect: CGRect) -> Path {
                var p = Path()
                let c = CGPoint(x: rect.midX, y: rect.midY)
                p.move(to: c)
                p.addArc(center: c, radius: rect.width / 2,
                         startAngle: startAngle, endAngle: endAngle, clockwise: false)
                return p
            }
        }

        Wedge(startAngle: .degrees(-90), endAngle: .degrees(open ? 240 : -60))
            .fill(.orange.gradient)
            .animation(.easeInOut(duration: 0.6), value: open)
        """) { AnyView(PW_AnimatableExample()) },

        ExampleEntry(topic: "@AppStorage", code: """
        @AppStorage("fontSize") private var fontSize = 14.0

        Text("The quick brown fox")
            .font(.system(size: fontSize))
        Slider(value: $fontSize, in: 10...24)
        """) { AnyView(PW_AppStorageExample()) },

        ExampleEntry(topic: "@Bindable", code: """
        @Observable final class Book { var title = "Untitled"; var rating = 3.0 }

        @State private var book = Book()

        @Bindable var book = book                  // rebind inside body
        TextField("Title", text: $book.title)
        Slider(value: $book.rating, in: 0...5)
        """) { AnyView(PW_BindableExample()) },

        ExampleEntry(topic: "@Binding", code: """
        struct Row: View {
            @Binding var isChecked: Bool
            let label: String
            var body: some View { Toggle(label, isOn: $isChecked) }
        }

        @State private var tasks = [false, true, false]
        Row(isChecked: $tasks[0], label: "Buy milk")   // child mutates parent
        """) { AnyView(PW_BindingExample()) },

        ExampleEntry(topic: "@Entry", code: """
        struct Theme { var accent: Color; var name: String }

        extension EnvironmentValues {
            @Entry var theme = Theme(accent: .blue, name: "Standard")
        }

        @Environment(\\.theme) private var theme                      // reader
        badge.environment(\\.theme, midnight ? .midnight : .standard) // provider
        """) { AnyView(PW_EntryExample()) },

        ExampleEntry(topic: "@Environment", code: """
        @Environment(\\.colorScheme) private var scheme
        @Environment(\\.locale) private var locale

        LabeledContent("Color scheme", value: scheme == .dark ? "Dark" : "Light")
        LabeledContent("Locale", value: locale.identifier)
        """) { AnyView(PW_EnvironmentExample()) },

        ExampleEntry(topic: "@EnvironmentObject", code: """
        final class CartModel: ObservableObject {
            @Published var items: [String] = ["Book", "Pen"]
        }

        struct CartBadge: View {
            @EnvironmentObject var cart: CartModel
            var body: some View { Label("\\(cart.items.count)", systemImage: "cart") }
        }

        CartBadge().environmentObject(cart)   // inject upstream
        """) { AnyView(PW_EnvironmentObjectExample()) },

        ExampleEntry(topic: "@FetchRequest", code: """
        @FetchRequest(
            sortDescriptors: [SortDescriptor(\\.createdAt, order: .reverse)],
            predicate: NSPredicate(format: "isArchived == NO"),
            animation: .default
        ) private var notes: FetchedResults<Note>

        List(notes) { note in Text(note.title) }
        """) { AnyView(PW_FetchRequestExample()) },

        ExampleEntry(topic: "@FocusedValue", code: """
        extension FocusedValues {
            @Entry var fieldName: String?
        }

        TextField("Title", text: $title)
            .focusedValue(\\.fieldName, "Title")

        // elsewhere in the window:
        @FocusedValue(\\.fieldName) private var focused
        Text("Focused field: \\(focused ?? "none")")
        """) { AnyView(PW_FocusedValueExample()) },

        ExampleEntry(topic: "@FocusState", code: """
        enum Field { case user, password }
        @FocusState private var focus: Field?

        TextField("User", text: $user).focused($focus, equals: .user)
        SecureField("Password", text: $pass).focused($focus, equals: .password)
        Button("Next") { focus = .password }
        """) { AnyView(PW_FocusStateExample()) },

        ExampleEntry(topic: "@GestureState", code: """
        @GestureState private var drag = CGSize.zero

        Circle()
            .offset(drag)
            .gesture(
                DragGesture().updating($drag) { value, state, _ in
                    state = value.translation
                }
            )
        """) { AnyView(PW_GestureStateExample()) },

        ExampleEntry(topic: "@Namespace", code: """
        @Namespace private var animation

        RoundedRectangle(cornerRadius: expanded ? 16 : 8)
            .matchedGeometryEffect(id: "box", in: animation)
            .frame(width: expanded ? 140 : 44, height: expanded ? 90 : 44)

        Button("Toggle") { withAnimation(.spring) { expanded.toggle() } }
        """) { AnyView(PW_NamespaceExample()) },

        ExampleEntry(topic: "@NSApplicationDelegateAdaptor", code: """
        final class AppDelegate: NSObject, NSApplicationDelegate {
            func applicationShouldTerminateAfterLastWindowClosed(_ s: NSApplication) -> Bool {
                true
            }
        }

        @main
        struct CompanionApp: App {
            @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
            var body: some Scene { WindowGroup { ContentView() } }
        }
        """) { AnyView(PW_NSAppDelegateExample()) },

        ExampleEntry(topic: "@Observable", code: """
        @Observable final class Library {
            var books = ["Dune", "1984"]
            var filter = ""
        }

        @State private var library = Library()
        @Bindable var library = library
        TextField("Filter", text: $library.filter)
        Button("Add") { library.books.append("Book \\(library.books.count + 1)") }
        """) { AnyView(PW_ObservableExample()) },

        ExampleEntry(topic: "@ObservedObject", code: """
        final class FeedModel: ObservableObject {
            @Published var posts = ["Hello", "World"]
        }

        struct PostList: View {
            @ObservedObject var model: FeedModel
            var body: some View { ForEach(model.posts, id: \\.self) { Text($0) } }
        }

        // parent owns it: @StateObject private var model = FeedModel()
        """) { AnyView(PW_ObservedObjectExample()) },

        ExampleEntry(topic: "@Previewable", code: """
        #Preview {
            @Previewable @State var volume = 0.5
            Slider(value: $volume)
        }
        """) { AnyView(PW_PreviewableExample()) },

        ExampleEntry(topic: "@Published", code: """
        final class Model: ObservableObject {
            @Published var count = 0
            @Published var isRunning = false
        }

        @StateObject private var model = Model()
        Text("Count: \\(model.count)")
        Button("Increment") { model.count += 1 }
        Toggle("Running", isOn: $model.isRunning)
        """) { AnyView(PW_PublishedExample()) },

        ExampleEntry(topic: "@Query", code: """
        @Query(sort: \\Trip.startDate, order: .reverse)
        private var trips: [Trip]

        var body: some View {
            List(trips) { trip in
                HStack { Text(trip.name); Spacer(); Text(trip.date) }
            }
        }
        """) { AnyView(PW_QueryExample()) },

        ExampleEntry(topic: "@ScaledMetric", code: """
        @ScaledMetric(relativeTo: .body) private var iconSize = 20.0

        Image(systemName: "star.fill")
            .resizable().scaledToFit()
            .frame(width: iconSize, height: iconSize)
        """) { AnyView(PW_ScaledMetricExample()) },

        ExampleEntry(topic: "@SceneStorage", code: """
        @SceneStorage("selectedTab") private var tab = "home"

        Picker("Tab", selection: $tab) {
            Text("Home").tag("home")
            Text("Search").tag("search")
            Text("Profile").tag("profile")
        }
        """) { AnyView(PW_SceneStorageExample()) },

        ExampleEntry(topic: "@State", code: """
        @State private var count = 0

        Text("\\(count)")
            .contentTransition(.numericText())
        Button("+") { withAnimation { count += 1 } }
        Button("−") { withAnimation { count -= 1 } }
        """) { AnyView(PW_StateExample()) },

        ExampleEntry(topic: "@StateObject", code: """
        final class Counter: ObservableObject {
            @Published var value = 0
        }

        struct CounterView: View {
            @StateObject private var model = Counter()
            var body: some View {
                Button("Value: \\(model.value)") { model.value += 1 }
            }
        }
        """) { AnyView(PW_StateObjectExample()) },

        ExampleEntry(topic: "@UIApplicationDelegateAdaptor", code: """
        final class AppDelegate: NSObject, UIApplicationDelegate {
            func application(_ app: UIApplication,
                didFinishLaunchingWithOptions options:
                    [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool { true }
        }

        @main
        struct CompanionApp: App {
            @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
            var body: some Scene { WindowGroup { ContentView() } }
        }
        """) { AnyView(PW_UIAppDelegateExample()) },
    ]
}

// MARK: - @Animatable

@Animatable
private struct PW_Wedge: Shape {
    var startAngle: Angle
    var endAngle: Angle

    func path(in rect: CGRect) -> Path {
        var p = Path()
        let c = CGPoint(x: rect.midX, y: rect.midY)
        p.move(to: c)
        p.addArc(center: c, radius: rect.width / 2,
                 startAngle: startAngle, endAngle: endAngle, clockwise: false)
        return p
    }
}

private struct PW_AnimatableExample: View {
    @State private var open = false

    var body: some View {
        VStack(spacing: 12) {
            PW_Wedge(startAngle: .degrees(-90),
                     endAngle: .degrees(open ? 240 : -60))
                .fill(.orange.gradient)
                .frame(width: 110, height: 110)
                .animation(.easeInOut(duration: 0.6), value: open)

            Button(open ? "Collapse" : "Expand") { open.toggle() }
                .buttonStyle(.bordered)

            Text("@Animatable synthesizes animatableData from the two Angle properties.")
                .font(.caption).foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - @AppStorage

private struct PW_AppStorageExample: View {
    @AppStorage("companion.demo.fontSize") private var fontSize = 14.0

    var body: some View {
        VStack(spacing: 12) {
            Text("The quick brown fox")
                .font(.system(size: fontSize))
                .lineLimit(1)
                .minimumScaleFactor(0.5)

            Slider(value: $fontSize, in: 10...24)

            Text("Persisted in UserDefaults — fontSize \(fontSize, format: .number.precision(.fractionLength(0)))")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

// MARK: - @Bindable

@Observable private final class PW_Book {
    var title = "Untitled"
    var rating = 3.0
}

private struct PW_BindableExample: View {
    @State private var book = PW_Book()

    var body: some View {
        @Bindable var book = book
        VStack(spacing: 10) {
            TextField("Title", text: $book.title)
                .textFieldStyle(.roundedBorder)
            Slider(value: $book.rating, in: 0...5)
            Text("“\(book.title)” — \(book.rating, format: .number.precision(.fractionLength(1)))★")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

// MARK: - @Binding

private struct PW_BindingRow: View {
    @Binding var isChecked: Bool
    let label: String

    var body: some View {
        Toggle(label, isOn: $isChecked)
    }
}

private struct PW_BindingExample: View {
    @State private var tasks = [false, true, false]
    private let labels = ["Buy milk", "Walk dog", "Write report"]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(labels.indices, id: \.self) { i in
                PW_BindingRow(isChecked: $tasks[i], label: labels[i])
            }
            Text("\(tasks.filter { $0 }.count) of \(tasks.count) done")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

// MARK: - @Entry

private struct PW_Theme {
    var accent: Color
    var name: String
    static let standard = PW_Theme(accent: .blue, name: "Standard")
    static let midnight = PW_Theme(accent: .purple, name: "Midnight")
}

extension EnvironmentValues {
    @Entry fileprivate var pwTheme: PW_Theme = .standard
}

private struct PW_ThemedBadge: View {
    @Environment(\.pwTheme) private var theme

    var body: some View {
        HStack(spacing: 8) {
            Circle().fill(theme.accent).frame(width: 14, height: 14)
            Text("Theme: \(theme.name)")
        }
        .padding(.horizontal, 12).padding(.vertical, 8)
        .background(theme.accent.opacity(0.15), in: .capsule)
    }
}

private struct PW_EntryExample: View {
    @State private var midnight = false

    var body: some View {
        VStack(spacing: 12) {
            PW_ThemedBadge()
                .environment(\.pwTheme, midnight ? .midnight : .standard)

            Toggle("Midnight theme", isOn: $midnight)
                .toggleStyle(.switch)
                .fixedSize()

            Text("@Entry declares the custom environment value in one line.")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

// MARK: - @Environment

private struct PW_EnvironmentExample: View {
    @Environment(\.colorScheme) private var scheme
    @Environment(\.locale) private var locale

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            LabeledContent("Color scheme", value: scheme == .dark ? "Dark" : "Light")
            LabeledContent("Locale", value: locale.identifier)
            LabeledContent("Now") {
                Text(Date.now, format: .dateTime.hour().minute())
            }
        }
        .font(.callout)
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.quaternary.opacity(0.4), in: .rect(cornerRadius: 10))
        .overlay(alignment: .bottomTrailing) {
            Text("Live values — flip the app theme to see 'Color scheme' change")
                .font(.caption2).foregroundStyle(.secondary)
                .padding(6)
        }
    }
}

// MARK: - @EnvironmentObject

private final class PW_CartModel: ObservableObject {
    @Published var items: [String] = ["Book", "Pen"]
}

private struct PW_CartBadge: View {
    @EnvironmentObject var cart: PW_CartModel

    var body: some View {
        Label("\(cart.items.count) items", systemImage: "cart")
    }
}

private struct PW_EnvironmentObjectExample: View {
    @StateObject private var cart = PW_CartModel()

    var body: some View {
        VStack(spacing: 12) {
            PW_CartBadge()
                .environmentObject(cart)   // must be injected upstream
                .font(.title3)

            Button("Add item") { cart.items.append("Item \(cart.items.count + 1)") }
                .buttonStyle(.bordered)

            Text("Reads the CartModel any ancestor injected — crashes if none did.")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

// MARK: - @FetchRequest

private struct PW_FetchRequestExample: View {
    private let notes = [
        ("Groceries", "Sep 3"),
        ("Standup agenda", "Sep 2"),
        ("Trip plan", "Aug 30"),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ForEach(notes, id: \.0) { note in
                HStack {
                    Image(systemName: "doc.text")
                    Text(note.0)
                    Spacer()
                    Text(note.1).foregroundStyle(.secondary)
                }
                .font(.callout)
            }
            Divider()
            Text("Illustrative — @FetchRequest reads a Core Data managedObjectContext at runtime.")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.quaternary.opacity(0.35), in: .rect(cornerRadius: 10))
    }
}

// MARK: - @FocusedValue

extension FocusedValues {
    @Entry var pwFieldName: String?
}

private struct PW_FocusReadout: View {
    @FocusedValue(\.pwFieldName) private var focused

    var body: some View {
        Text("Focused field: \(focused ?? "none")")
            .font(.caption).foregroundStyle(.secondary)
    }
}

private struct PW_FocusedValueExample: View {
    @State private var title = "Chapter 1"
    @State private var note = "Draft notes"

    var body: some View {
        VStack(spacing: 10) {
            TextField("Title", text: $title)
                .focusedValue(\.pwFieldName, "Title")
            TextField("Body", text: $note)
                .focusedValue(\.pwFieldName, "Body")
            PW_FocusReadout()
        }
        .textFieldStyle(.roundedBorder)
    }
}

// MARK: - @FocusState

private struct PW_FocusStateExample: View {
    private enum Field { case user, password }
    @State private var user = ""
    @State private var pass = ""
    @FocusState private var focus: Field?

    var body: some View {
        VStack(spacing: 10) {
            TextField("User", text: $user)
                .focused($focus, equals: .user)
            SecureField("Password", text: $pass)
                .focused($focus, equals: .password)

            HStack {
                Button("Focus user") { focus = .user }
                Button("Focus password") { focus = .password }
                Button("Dismiss") { focus = nil }
            }
            .buttonStyle(.bordered)
            .controlSize(.small)

            Text("Focused: \(label(for: focus))")
                .font(.caption).foregroundStyle(.secondary)
        }
        .textFieldStyle(.roundedBorder)
    }

    private func label(for field: Field?) -> String {
        switch field {
        case .user: "user"
        case .password: "password"
        case nil: "none"
        }
    }
}

// MARK: - @GestureState

private struct PW_GestureStateExample: View {
    @GestureState private var drag = CGSize.zero

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.quaternary.opacity(0.4))
                Circle()
                    .fill(.blue.gradient)
                    .frame(width: 44, height: 44)
                    .offset(drag)
                    .gesture(
                        DragGesture().updating($drag) { value, state, _ in
                            state = value.translation
                        }
                    )
            }
            .frame(height: 120)

            Text("Drag the circle — it snaps back on release · offset \(Int(drag.width)), \(Int(drag.height))")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

// MARK: - @Namespace

private struct PW_NamespaceExample: View {
    @Namespace private var animation
    @State private var expanded = false

    var body: some View {
        VStack(spacing: 14) {
            ZStack {
                if expanded {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.orange.gradient)
                        .matchedGeometryEffect(id: "box", in: animation)
                        .frame(width: 140, height: 80)
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.orange.gradient)
                        .matchedGeometryEffect(id: "box", in: animation)
                        .frame(width: 44, height: 44)
                }
            }
            .frame(height: 90)

            Button("Toggle") { withAnimation(.spring) { expanded.toggle() } }
                .buttonStyle(.bordered)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - @NSApplicationDelegateAdaptor

private struct PW_NSAppDelegateExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("AppDelegate installed", systemImage: "app.badge.checkmark")
                .font(.headline)
            Text("applicationDidFinishLaunching(_:)")
            Text("applicationShouldTerminateAfterLastWindowClosed → true")
                .foregroundStyle(.secondary)
            Divider()
            Text("Illustrative — @NSApplicationDelegateAdaptor applies at the App/Scene level")
                .font(.caption).foregroundStyle(.secondary)
        }
        .font(.callout.monospaced())
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.quaternary.opacity(0.35), in: .rect(cornerRadius: 10))
    }
}

// MARK: - @Observable

@Observable private final class PW_Library {
    var books = ["Dune", "1984"]
    var filter = ""
}

private struct PW_ObservableExample: View {
    @State private var library = PW_Library()

    var body: some View {
        @Bindable var library = library
        VStack(alignment: .leading, spacing: 8) {
            TextField("Filter", text: $library.filter)
                .textFieldStyle(.roundedBorder)

            ForEach(filtered(library), id: \.self) {
                Label($0, systemImage: "book")
            }

            Button("Add book") { library.books.append("Book \(library.books.count + 1)") }
                .buttonStyle(.bordered)
                .controlSize(.small)
        }
    }

    private func filtered(_ lib: PW_Library) -> [String] {
        lib.books.filter { lib.filter.isEmpty || $0.localizedCaseInsensitiveContains(lib.filter) }
    }
}

// MARK: - @ObservedObject

private final class PW_FeedModel: ObservableObject {
    @Published var posts = ["Hello", "World"]
}

private struct PW_PostList: View {
    @ObservedObject var model: PW_FeedModel

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(model.posts, id: \.self) { Label($0, systemImage: "text.bubble") }
        }
    }
}

private struct PW_ObservedObjectExample: View {
    @StateObject private var model = PW_FeedModel()

    var body: some View {
        VStack(spacing: 10) {
            PW_PostList(model: model)   // child observes, parent owns
            Button("Add post") { model.posts.append("Post \(model.posts.count + 1)") }
                .buttonStyle(.bordered)
                .controlSize(.small)
        }
    }
}

// MARK: - @Previewable

private struct PW_PreviewableExample: View {
    @State private var volume = 0.5

    var body: some View {
        VStack(spacing: 10) {
            Slider(value: $volume)
            Text("Volume: \(volume, format: .number.precision(.fractionLength(2)))")
                .font(.caption.monospacedDigit())
            Text("Illustrative — @Previewable makes this @State legal directly inside a #Preview")
                .font(.caption).foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - @Published

private final class PW_TimerModel: ObservableObject {
    @Published var count = 0
    @Published var isRunning = false
}

private struct PW_PublishedExample: View {
    @StateObject private var model = PW_TimerModel()

    var body: some View {
        VStack(spacing: 10) {
            Text("Count: \(model.count)")
                .font(.title3.monospacedDigit())
            HStack(spacing: 12) {
                Button("Increment") { model.count += 1 }
                    .buttonStyle(.bordered)
                Toggle("Running", isOn: $model.isRunning)
                    .toggleStyle(.switch)
                    .fixedSize()
            }
            Text("Each @Published mutation fires objectWillChange, re-rendering the view.")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

// MARK: - @Query

private struct PW_QueryExample: View {
    private let trips = [
        ("Reykjavík", "Sep 12"),
        ("Kyoto", "Oct 3"),
        ("Lisbon", "Nov 20"),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ForEach(trips, id: \.0) { trip in
                HStack {
                    Image(systemName: "airplane")
                    Text(trip.0)
                    Spacer()
                    Text(trip.1).foregroundStyle(.secondary)
                }
                .font(.callout)
            }
            Divider()
            Text("Illustrative — @Query reads a SwiftData modelContext at runtime.")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.quaternary.opacity(0.35), in: .rect(cornerRadius: 10))
    }
}

// MARK: - @ScaledMetric

private struct PW_ScaledIcon: View {
    @ScaledMetric(relativeTo: .body) private var iconSize = 20.0

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: "star.fill")
                .resizable().scaledToFit()
                .foregroundStyle(.yellow)
                .frame(width: iconSize, height: iconSize)
            Text("\(Int(iconSize))pt")
                .font(.caption2).foregroundStyle(.secondary)
        }
    }
}

private struct PW_ScaledMetricExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .bottom, spacing: 24) {
                PW_ScaledIcon().environment(\.dynamicTypeSize, .small)
                PW_ScaledIcon().environment(\.dynamicTypeSize, .large)
                PW_ScaledIcon().environment(\.dynamicTypeSize, .accessibility3)
            }
            .frame(height: 70)

            Text("Same @ScaledMetric(20) at Small · Large · Accessibility 3")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

// MARK: - @SceneStorage

private struct PW_SceneStorageExample: View {
    @SceneStorage("companion.demo.tab") private var tab = "home"

    var body: some View {
        VStack(spacing: 10) {
            Picker("Tab", selection: $tab) {
                Text("Home").tag("home")
                Text("Search").tag("search")
                Text("Profile").tag("profile")
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            Text("Restored tab: \(tab)")
                .font(.caption).foregroundStyle(.secondary)
            Text("Per-scene — each window restores its own value across launches.")
                .font(.caption2).foregroundStyle(.secondary)
        }
    }
}

// MARK: - @State

private struct PW_StateExample: View {
    @State private var count = 0

    var body: some View {
        VStack(spacing: 12) {
            Text("\(count)")
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .contentTransition(.numericText())

            HStack(spacing: 16) {
                Button("−") { withAnimation { count -= 1 } }
                Button("+") { withAnimation { count += 1 } }
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
        }
    }
}

// MARK: - @StateObject

private final class PW_Counter: ObservableObject {
    @Published var value = 0
}

private struct PW_StateObjectExample: View {
    @StateObject private var model = PW_Counter()

    var body: some View {
        VStack(spacing: 10) {
            Text("Model value: \(model.value)")
                .font(.title3.monospacedDigit())
            Button("Increment") { model.value += 1 }
                .buttonStyle(.bordered)
            Text("@StateObject creates the object once and keeps it alive across re-renders.")
                .font(.caption).foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - @UIApplicationDelegateAdaptor

private struct PW_UIAppDelegateExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("UIApplicationDelegate installed", systemImage: "iphone")
                .font(.headline)
            Text("application(_:didFinishLaunchingWithOptions:)")
            Text("didRegisterForRemoteNotificationsWithDeviceToken:")
                .foregroundStyle(.secondary)
            Divider()
            Text("Illustrative — iOS/tvOS only; macOS uses @NSApplicationDelegateAdaptor")
                .font(.caption).foregroundStyle(.secondary)
        }
        .font(.callout.monospaced())
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.quaternary.opacity(0.35), in: .rect(cornerRadius: 10))
    }
}
