//
//  Catalog+MoreWrappers.swift
//  Swift-UI-Companion
//
//  Second wave of property wrappers and macros, including data-framework
//  integrations.
//

import Foundation

extension Catalog {
    static let moreWrappers: [Topic] = [
        Topic(
            name: "@EnvironmentObject",
            kind: .propertyWrapper,
            summary: "Reads an ObservableObject injected upstream.",
            discussion: "@EnvironmentObject pulls a shared ObservableObject placed with environmentObject from any descendant — crashing at runtime if nobody injected it. New code on current targets shares @Observable models through plain @Environment instead.",
            wwdcYear: 2019,
            code: #"""
            struct CartBadge: View {
                @EnvironmentObject var cart: CartModel

                var body: some View {
                    Text("\(cart.items.count)")
                }
            }

            // upstream: ContentView().environmentObject(cart)
            """#,
            related: ["@Environment", "@Observable", "@StateObject"]
        ),
        Topic(
            name: "@Published",
            kind: .propertyWrapper,
            summary: "Marks an ObservableObject property as change-emitting.",
            discussion: "@Published fires objectWillChange before every mutation, which is what @StateObject and @ObservedObject listen for. It belongs to Combine's ObservableObject world; the @Observable macro tracks properties without it.",
            wwdcYear: 2019,
            framework: "Combine",
            code: #"""
            final class FeedModel: ObservableObject {
                @Published var posts: [Post] = []
                @Published var isLoading = false
            }
            """#,
            related: ["@StateObject", "@ObservedObject", "@Observable"]
        ),
        Topic(
            name: "@NSApplicationDelegateAdaptor",
            kind: .propertyWrapper,
            summary: "Attaches an AppKit app delegate to a SwiftUI app.",
            discussion: "Declared on the App struct, this wrapper instantiates your NSApplicationDelegate so lifecycle callbacks SwiftUI doesn't surface — Sparkle updaters, dock menu APIs, legacy integrations — still have a home.",
            wwdcYear: 2020,
            platforms: [.macOS],
            code: #"""
            @main
            struct CompanionApp: App {
                @NSApplicationDelegateAdaptor(AppDelegate.self)
                private var appDelegate

                var body: some Scene { WindowGroup { ContentView() } }
            }
            """#,
            related: ["@UIApplicationDelegateAdaptor", "App"]
        ),
        Topic(
            name: "@UIApplicationDelegateAdaptor",
            kind: .propertyWrapper,
            summary: "Attaches a UIKit app delegate to a SwiftUI app.",
            discussion: "The iOS counterpart: hosts a UIApplicationDelegate for push-notification registration, third-party SDK hooks, and other callbacks the SwiftUI lifecycle doesn't expose directly.",
            wwdcYear: 2020,
            platforms: [.iOS, .tvOS],
            code: #"""
            @main
            struct CompanionApp: App {
                @UIApplicationDelegateAdaptor(AppDelegate.self)
                private var appDelegate

                var body: some Scene { WindowGroup { ContentView() } }
            }
            """#,
            related: ["@NSApplicationDelegateAdaptor", "App"]
        ),
        Topic(
            name: "@FetchRequest",
            kind: .propertyWrapper,
            summary: "Live Core Data query results as a view property.",
            discussion: "@FetchRequest runs a fetch against the managedObjectContext in the environment and re-renders the view as objects change, with sort descriptors and predicates in the declaration. Requires import CoreData.",
            wwdcYear: 2019,
            framework: "CoreData",
            code: #"""
            @FetchRequest(sortDescriptors: [SortDescriptor(\.date)])
            private var entries: FetchedResults<Entry>

            var body: some View {
                List(entries) { EntryRow($0) }
            }
            """#,
            related: ["@Query", "@Environment"]
        ),
        Topic(
            name: "@Query",
            kind: .propertyWrapper,
            summary: "Live SwiftData query results as a view property.",
            discussion: "@Query is SwiftData's answer to @FetchRequest: declarative filtering and sorting over @Model types from the modelContext, updating the view as the store changes. Requires import SwiftData.",
            wwdcYear: 2023,
            framework: "SwiftData",
            code: #"""
            @Query(sort: \Trip.startDate, order: .reverse)
            private var trips: [Trip]

            var body: some View {
                List(trips) { TripRow($0) }
            }
            """#,
            related: ["@FetchRequest", "modelContext"]
        ),
        Topic(
            name: "@FocusedValue",
            kind: .propertyWrapper,
            summary: "Reads a value published by the focused view.",
            discussion: "Focused values flow from whatever currently has focus to interested observers — the mechanism menu commands use to act on 'the focused document'. Publish with focusedValue, read with @FocusedValue.",
            wwdcYear: 2020,
            platforms: [.iOS, .macOS],
            code: #"""
            // In the editor view:
            editor.focusedValue(\.document, document)

            // In a Commands struct:
            @FocusedValue(\.document) var document
            Button("Export") { export(document) }
                .disabled(document == nil)
            """#,
            related: ["Commands", "@FocusState"]
        ),
        Topic(
            name: "@Previewable",
            kind: .propertyWrapper,
            summary: "Allows live state directly inside a #Preview.",
            discussion: "The @Previewable macro (WWDC '24) lets a #Preview declare @State and other dynamic properties inline — interactive previews without wrapping everything in a throwaway container view.",
            wwdcYear: 2024,
            code: #"""
            #Preview {
                @Previewable @State var volume = 0.5
                Slider(value: $volume)
            }
            """#,
            related: ["@State"]
        ),
        Topic(
            name: "@Animatable",
            kind: .propertyWrapper,
            summary: "Macro that synthesizes animatableData for a type.",
            discussion: "New at WWDC '25, the @Animatable macro generates the animatableData plumbing from a type's stored numeric properties — custom shapes and modifiers animate without hand-written getters and setters; @AnimatableIgnored opts a property out.",
            wwdcYear: 2025,
            code: #"""
            @Animatable
            struct Wedge: Shape {
                var startAngle: Angle
                var endAngle: Angle

                func path(in rect: CGRect) -> Path {
                    wedgePath(rect, startAngle, endAngle)
                }
            }
            """#,
            related: ["Animatable", "Shape", ".animation()"]
        ),
    ]
}
