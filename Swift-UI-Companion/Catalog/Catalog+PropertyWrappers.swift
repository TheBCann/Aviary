//
//  Catalog+PropertyWrappers.swift
//  Swift-UI-Companion
//

import Foundation

extension Catalog {
    static let propertyWrappers: [Topic] = [
        Topic(
            name: "@State",
            kind: .propertyWrapper,
            summary: "View-owned storage that survives re-rendering.",
            discussion: "@State moves a value out of the transient view struct into storage SwiftUI manages, re-rendering the view when it changes. Keep it private and pass it down as bindings; since WWDC '23 it also holds @Observable model objects.",
            wwdcYear: 2019,
            code: #"""
            struct Counter: View {
                @State private var count = 0

                var body: some View {
                    Button("Count: \(count)") { count += 1 }
                }
            }
            """#,
            related: ["@Binding", "@Observable", "@StateObject"]
        ),
        Topic(
            name: "@Binding",
            kind: .propertyWrapper,
            summary: "A read-write reference to state owned elsewhere.",
            discussion: "@Binding lets a child view mutate its parent's state without owning it — the $ prefix on a @State property produces one. It is the backbone of every two-way control, from TextField to Toggle.",
            wwdcYear: 2019,
            code: #"""
            struct Row: View {
                @Binding var isChecked: Bool

                var body: some View {
                    Toggle("Done", isOn: $isChecked)
                }
            }

            // parent: Row(isChecked: $item.done)
            """#,
            related: ["@State", "@Bindable"]
        ),
        Topic(
            name: "@Observable",
            kind: .propertyWrapper,
            summary: "Macro that makes a class's properties observable.",
            discussion: "The @Observable macro (WWDC '23) replaces ObservableObject for new code: no @Published, and views re-render only when properties they actually read change. Store instances in @State, share them via .environment, and bind with @Bindable.",
            wwdcYear: 2023,
            code: #"""
            @Observable
            final class Library {
                var books: [Book] = []
                var filter = ""
            }

            struct LibraryView: View {
                @State private var library = Library()
                var body: some View { BookList(library: library) }
            }
            """#,
            related: ["@State", "@Bindable", "@Environment"]
        ),
        Topic(
            name: "@Bindable",
            kind: .propertyWrapper,
            summary: "Creates bindings into an @Observable object.",
            discussion: "@Bindable bridges the gap the macro left: wrap an @Observable reference with it — as a property or a local in body — and the $ syntax yields bindings to its properties for use with controls.",
            wwdcYear: 2023,
            code: #"""
            struct EditorView: View {
                @Bindable var book: Book

                var body: some View {
                    TextField("Title", text: $book.title)
                }
            }
            """#,
            related: ["@Observable", "@Binding"]
        ),
        Topic(
            name: "@Environment",
            kind: .propertyWrapper,
            summary: "Reads a value the surrounding hierarchy provides.",
            discussion: "@Environment pulls system values — color scheme, locale, dismiss — or your own @Observable models injected with .environment out of the context. Values flow down the tree, and any ancestor can override them for its subtree.",
            wwdcYear: 2019,
            code: #"""
            struct ThemedView: View {
                @Environment(\.colorScheme) private var scheme
                @Environment(Library.self) private var library

                var body: some View {
                    Text(scheme == .dark ? "Dark" : "Light")
                }
            }
            """#,
            related: ["@Observable", "colorScheme", "@EnvironmentObject"]
        ),
        Topic(
            name: "@AppStorage",
            kind: .propertyWrapper,
            summary: "State persisted automatically in UserDefaults.",
            discussion: "@AppStorage reads and writes a UserDefaults key while behaving like @State — the view updates when the value changes from anywhere, including Settings panes. Best for small preferences, not documents.",
            wwdcYear: 2020,
            code: #"""
            @AppStorage("fontSize") private var fontSize = 14.0

            Slider(value: $fontSize, in: 10...24)
            """#,
            related: ["@SceneStorage", "@State", "Settings"]
        ),
        Topic(
            name: "@SceneStorage",
            kind: .propertyWrapper,
            summary: "Per-scene state restored across app launches.",
            discussion: "@SceneStorage saves lightweight UI state — selected tab, scroll target, draft text — scoped to each window, so two windows restore independently. The system owns the storage; treat it as best-effort.",
            wwdcYear: 2020,
            code: #"""
            @SceneStorage("selectedTab") private var tab = "home"

            TabView(selection: $tab) { … }
            """#,
            related: ["@AppStorage", "WindowGroup"]
        ),
        Topic(
            name: "@FocusState",
            kind: .propertyWrapper,
            summary: "Tracks and drives which view has keyboard focus.",
            discussion: "@FocusState pairs with the focused modifier: a Boolean for one field, or a hashable enum to manage focus across a form. Setting the property moves focus; nil (or false) dismisses the keyboard.",
            wwdcYear: 2021,
            code: #"""
            enum Field { case user, password }
            @FocusState private var focus: Field?

            TextField("User", text: $user).focused($focus, equals: .user)
            SecureField("Password", text: $pass).focused($focus, equals: .password)

            Button("Next") { focus = .password }
            """#,
            related: ["TextField"]
        ),
        Topic(
            name: "@GestureState",
            kind: .propertyWrapper,
            summary: "Transient state that resets when a gesture ends.",
            discussion: "@GestureState stores in-flight gesture data — a drag translation, a pinch scale — and snaps back to its initial value the moment the gesture finishes, with the reset animating automatically.",
            wwdcYear: 2019,
            code: #"""
            @GestureState private var drag = CGSize.zero

            Circle()
                .offset(drag)
                .gesture(
                    DragGesture().updating($drag) { value, state, _ in
                        state = value.translation
                    }
                )
            """#,
            related: [".onTapGesture()", "@State"]
        ),
        Topic(
            name: "@Namespace",
            kind: .propertyWrapper,
            summary: "An identifier space for matched geometry and focus.",
            discussion: "@Namespace mints a unique namespace tying together matchedGeometryEffect pairs, zoom transition sources, and focus scopes within one view hierarchy.",
            wwdcYear: 2020,
            code: #"""
            @Namespace private var animation

            ThumbView()
                .matchedGeometryEffect(id: item.id, in: animation)
            """#,
            related: [".matchedGeometryEffect()", ".navigationTransition()"]
        ),
        Topic(
            name: "@ScaledMetric",
            kind: .propertyWrapper,
            summary: "A number that scales with Dynamic Type.",
            discussion: "@ScaledMetric multiplies your base value by the user's text-size setting, optionally relative to a specific text style — keeping icons and spacing proportional to enlarged text.",
            wwdcYear: 2020,
            code: #"""
            @ScaledMetric(relativeTo: .body) private var iconSize = 20.0

            Image(systemName: "star")
                .frame(width: iconSize, height: iconSize)
            """#,
            related: ["dynamicTypeSize", ".font()"]
        ),
        Topic(
            name: "@StateObject",
            kind: .propertyWrapper,
            summary: "Owns an ObservableObject for the view's lifetime.",
            discussion: "@StateObject instantiates an ObservableObject once per view identity and keeps it alive across re-renders — the legacy counterpart of @State + @Observable. In new code targeting current OSes, prefer the @Observable macro.",
            wwdcYear: 2020,
            code: #"""
            struct FeedView: View {
                @StateObject private var model = FeedModel()

                var body: some View {
                    List(model.posts) { PostRow($0) }
                }
            }
            """#,
            related: ["@ObservedObject", "@Observable", "@State"]
        ),
        Topic(
            name: "@ObservedObject",
            kind: .propertyWrapper,
            summary: "Subscribes to an ObservableObject owned elsewhere.",
            discussion: "@ObservedObject re-renders the view when the object's @Published properties change, but does not keep the object alive — the parent must own it (typically via @StateObject). Superseded by plain properties on @Observable models.",
            wwdcYear: 2019,
            code: #"""
            struct PostList: View {
                @ObservedObject var model: FeedModel

                var body: some View {
                    List(model.posts) { PostRow($0) }
                }
            }
            """#,
            related: ["@StateObject", "@Observable"]
        ),
        Topic(
            name: "@Entry",
            kind: .propertyWrapper,
            summary: "Declares a custom environment value in one line.",
            discussion: "The @Entry macro (WWDC '24) replaces the EnvironmentKey boilerplate: annotate a var in an EnvironmentValues extension with a default value, and it becomes a fully usable custom environment entry. It works for transaction, container, and focused values too.",
            wwdcYear: 2024,
            code: #"""
            extension EnvironmentValues {
                @Entry var theme: Theme = .standard
            }

            ContentView()
                .environment(\.theme, .midnight)
            """#,
            related: ["@Environment"]
        ),
    ]
}
