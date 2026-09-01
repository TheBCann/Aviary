//
//  Catalog+EnvironmentValues.swift
//  Swift-UI-Companion
//

import Foundation

extension Catalog {
    static let environmentValues: [Topic] = [
        Topic(
            name: "colorScheme",
            kind: .environmentValue,
            summary: "Whether the view renders in light or dark mode.",
            discussion: "Read colorScheme to branch custom drawing between appearances; prefer semantic colors and materials that adapt automatically. Setting preferredColorScheme upstream overrides it for a subtree.",
            wwdcYear: 2019,
            code: #"""
            @Environment(\.colorScheme) private var colorScheme

            var body: some View {
                Image(colorScheme == .dark ? "logo-dark" : "logo-light")
            }
            """#,
            related: ["@Environment", "colorSchemeContrast"]
        ),
        Topic(
            name: "dismiss",
            kind: .environmentValue,
            summary: "An action that closes the current presentation.",
            discussion: "Calling dismiss pops the pushed view, closes the sheet or popover, or dismisses the window — whichever presentation the view sits inside. It replaced presentationMode's clunkier API.",
            wwdcYear: 2021,
            code: #"""
            @Environment(\.dismiss) private var dismiss

            Button("Done") { dismiss() }
            """#,
            related: [".sheet()", "@Environment"]
        ),
        Topic(
            name: "openURL",
            kind: .environmentValue,
            summary: "An action that opens a URL with system handling.",
            discussion: "openURL sends a URL to the default browser or owning app. Provide your own OpenURLAction upstream to intercept links — including those inside Markdown Text — for in-app handling.",
            wwdcYear: 2020,
            code: #"""
            @Environment(\.openURL) private var openURL

            Button("Docs") {
                openURL(URL(string: "https://developer.apple.com")!)
            }
            """#,
            related: ["Link", "openWindow"]
        ),
        Topic(
            name: "openWindow",
            kind: .environmentValue,
            summary: "An action that opens a scene by id or value.",
            discussion: "openWindow targets a WindowGroup or Window by identifier, optionally passing a presented value that parameterizes the new window. macOS and iPadOS honor it; this app's menu bar search uses it to raise the main window.",
            wwdcYear: 2022,
            platforms: [.iOS, .macOS],
            code: #"""
            @Environment(\.openWindow) private var openWindow

            Button("Show Activity") {
                openWindow(id: "activity")
            }
            """#,
            related: ["WindowGroup", "Window", "dismiss"]
        ),
        Topic(
            name: "scenePhase",
            kind: .environmentValue,
            summary: "Whether the scene is active, inactive, or backgrounded.",
            discussion: "Observe scenePhase with onChange to pause work, save state, or refresh data as the app moves between foreground and background. Read it at the App level for whole-app transitions.",
            wwdcYear: 2020,
            code: #"""
            @Environment(\.scenePhase) private var scenePhase

            var body: some View {
                content.onChange(of: scenePhase) { _, phase in
                    if phase == .background { save() }
                }
            }
            """#,
            related: ["Scene", "@Environment"]
        ),
        Topic(
            name: "locale",
            kind: .environmentValue,
            summary: "The locale formatting should adapt to.",
            discussion: "The locale environment value drives date, number, and measurement formatting throughout SwiftUI. Override it with .environment for previews and screenshots in other regions.",
            wwdcYear: 2019,
            code: #"""
            ContentView()
                .environment(\.locale, Locale(identifier: "fr_FR"))
            """#,
            related: ["@Environment", "Text"]
        ),
        Topic(
            name: "dynamicTypeSize",
            kind: .environmentValue,
            summary: "The user's current text size setting.",
            discussion: "Read dynamicTypeSize to swap layouts at accessibility sizes, or clamp a subtree's growth with the dynamicTypeSize range modifier while keeping text scalable.",
            wwdcYear: 2021,
            code: #"""
            @Environment(\.dynamicTypeSize) private var typeSize

            var body: some View {
                if typeSize.isAccessibilitySize {
                    VStack { labels }
                } else {
                    HStack { labels }
                }
            }
            """#,
            related: ["@ScaledMetric", ".font()"]
        ),
        Topic(
            name: "horizontalSizeClass",
            kind: .environmentValue,
            summary: "Compact or regular width for adaptive layouts.",
            discussion: "Size classes describe available width coarsely: compact on iPhone portrait, regular on iPad and wide splits. Branching on them is the standard way to choose between phone and tablet arrangements.",
            wwdcYear: 2019,
            platforms: [.iOS],
            code: #"""
            @Environment(\.horizontalSizeClass) private var sizeClass

            var body: some View {
                sizeClass == .compact ? AnyView(list) : AnyView(splitView)
            }
            """#,
            related: ["ViewThatFits", "NavigationSplitView"]
        ),
        Topic(
            name: "isEnabled",
            kind: .environmentValue,
            summary: "Whether the surrounding context allows interaction.",
            discussion: "isEnabled reflects the nearest .disabled modifier. Custom control styles read it to gray themselves out consistently with system controls.",
            wwdcYear: 2019,
            code: #"""
            struct FadedStyle: ButtonStyle {
                @Environment(\.isEnabled) private var isEnabled

                func makeBody(configuration: Configuration) -> some View {
                    configuration.label
                        .opacity(isEnabled ? 1 : 0.4)
                }
            }
            """#,
            related: ["ButtonStyle", "@Environment"]
        ),
        Topic(
            name: "accessibilityReduceMotion",
            kind: .environmentValue,
            summary: "Whether the user asked for fewer animations.",
            discussion: "When reduceMotion is on, replace large movement with crossfades or nothing at all. Gate springs and parallax on it; content changes themselves should still occur.",
            wwdcYear: 2019,
            code: #"""
            @Environment(\.accessibilityReduceMotion) private var reduceMotion

            withAnimation(reduceMotion ? nil : .spring) {
                isExpanded.toggle()
            }
            """#,
            related: [".animation()", "colorScheme"]
        ),
        Topic(
            name: "controlSize",
            kind: .environmentValue,
            summary: "The size classification controls should render at.",
            discussion: "controlSize scales buttons, pickers, and progress indicators from mini through extraLarge. Set it on a container to keep a toolbar's controls uniformly compact.",
            wwdcYear: 2019,
            platforms: [.iOS, .macOS, .watchOS],
            code: #"""
            HStack {
                Button("A") { }
                Button("B") { }
            }
            .controlSize(.small)
            """#,
            demoID: "controlSize",
            related: ["Button", ".buttonStyle()"]
        ),
        Topic(
            name: "colorSchemeContrast",
            kind: .environmentValue,
            summary: "Whether Increase Contrast is enabled.",
            discussion: "colorSchemeContrast distinguishes standard from increased contrast. Pair custom colors with stronger variants when it is .increased, mirroring what system colors do automatically.",
            wwdcYear: 2019,
            code: #"""
            @Environment(\.colorSchemeContrast) private var contrast

            var borderColor: Color {
                contrast == .increased ? .black : .gray
            }
            """#,
            related: ["colorScheme"]
        ),
    ]
}
