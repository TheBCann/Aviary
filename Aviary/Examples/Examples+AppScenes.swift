//
//  Examples+AppScenes.swift
//  Aviary
//
//  Rendered usage examples for the entries in CatalogData/gen-appscenes.json.
//
//  This domain is almost entirely Scene- and App-level infrastructure (window
//  chrome, menu commands, launch behavior, watchOS lifecycle). None of it can
//  run as a live Scene inside a view, so each example renders a faithful macOS
//  illustration and keeps the CODE string showing the true scene-level API.
//

import SwiftUI

enum ExamplesAppScenes {
    static let entries: [ExampleEntry] = [
        ExampleEntry(topic: ".commandsReplaced()", code: """
        Window("Player", id: "player") {
            PlayerView()
        }
        .commandsReplaced {
            CommandMenu("Playback") {
                Button("Play", action: play)
            }
        }
        """) { AnyView(AS_CommandsReplacedExample()) },

        ExampleEntry(topic: ".defaultLaunchBehavior()", code: """
        Window("Debug Console", id: "console") {
            ConsoleView()
        }
        .defaultLaunchBehavior(.suppressed)
        """) { AnyView(AS_DefaultLaunchBehaviorExample()) },

        ExampleEntry(topic: ".defaultPosition()", code: """
        Window("Activity", id: "activity") {
            ActivityMonitorView()
        }
        .defaultPosition(.bottomTrailing)
        """) { AnyView(AS_DefaultPositionExample()) },

        ExampleEntry(topic: ".defaultSize()", code: """
        WindowGroup {
            LibraryView()
        }
        .defaultSize(width: 1000, height: 650)

        Window("Inspector", id: "inspector") {
            InspectorView()
        }
        .defaultSize(CGSize(width: 320, height: 480))
        """) { AnyView(AS_DefaultSizeExample()) },

        ExampleEntry(topic: ".presentedWindowStyle()", code: """
        ContentView()
            .presentedWindowStyle(.hiddenTitleBar)
        """) { AnyView(AS_PresentedWindowStyleExample()) },

        ExampleEntry(topic: ".presentedWindowToolbarStyle()", code: """
        ContentView()
            .presentedWindowToolbarStyle(.unified)
        """) { AnyView(AS_PresentedWindowToolbarStyleExample()) },

        ExampleEntry(topic: ".restorationBehavior()", code: """
        Window("Welcome", id: "welcome") {
            WelcomeView()
        }
        .restorationBehavior(.disabled)
        """) { AnyView(AS_RestorationBehaviorExample()) },

        ExampleEntry(topic: ".windowBackgroundDragBehavior()", code: """
        Window("Scratchpad", id: "scratch") {
            ScratchpadView()
        }
        .windowStyle(.plain)
        .windowBackgroundDragBehavior(.enabled)
        """) { AnyView(AS_WindowBackgroundDragExample()) },

        ExampleEntry(topic: ".windowFullScreenBehavior()", code: """
        Window("Mini Player", id: "mini") {
            MiniPlayerView()
        }
        .windowFullScreenBehavior(.disabled)
        """) { AnyView(AS_WindowFullScreenBehaviorExample()) },

        ExampleEntry(topic: ".windowLevel()", code: """
        Window("Timer", id: "timer") {
            TimerHUD()
        }
        .windowLevel(.floating)
        """) { AnyView(AS_WindowLevelModifierExample()) },

        ExampleEntry(topic: ".windowMinimizeBehavior()", code: """
        UtilityWindow("Inspector", id: "inspector") {
            InspectorPane()
        }
        .windowMinimizeBehavior(.disabled)
        """) { AnyView(AS_WindowMinimizeBehaviorExample()) },

        ExampleEntry(topic: ".windowResizability()", code: """
        Window("About", id: "about") {
            AboutView()
                .frame(width: 420, height: 260)
        }
        .windowResizability(.contentSize)
        """) { AnyView(AS_WindowResizabilityModifierExample()) },

        ExampleEntry(topic: ".windowStyle()", code: """
        WindowGroup {
            CanvasView()
        }
        .windowStyle(.hiddenTitleBar)
        """) { AnyView(AS_WindowStyleModifierExample()) },

        ExampleEntry(topic: ".windowToolbarStyle()", code: """
        WindowGroup {
            BrowserView()
                .toolbar {
                    ToolbarItem { Button("Add", action: addFeed) }
                }
        }
        .windowToolbarStyle(.unifiedCompact)
        """) { AnyView(AS_WindowToolbarStyleModifierExample()) },

        ExampleEntry(topic: "@WKApplicationDelegateAdaptor", code: """
        @main
        struct WorkoutApp: App {
            @WKApplicationDelegateAdaptor(AppDelegate.self) var delegate
            var body: some Scene {
                WindowGroup { ContentView() }
            }
        }
        """) { AnyView(AS_WKAppDelegateAdaptorExample()) },

        ExampleEntry(topic: "BackgroundTask", code: """
        WindowGroup { ContentView() }
            .backgroundTask(.appRefresh("com.example.sync")) {
                await SyncEngine.shared.run()
            }
            .backgroundTask(.urlSession("com.example.downloads")) {
                await Downloads.shared.processEvents()
            }
        """) { AnyView(AS_BackgroundTaskExample()) },

        ExampleEntry(topic: "CommandGroupPlacement", code: """
        CommandGroup(replacing: .newItem) {
            Button("New Board", action: newBoard)
                .keyboardShortcut("n")
        }
        """) { AnyView(AS_CommandGroupPlacementExample()) },

        ExampleEntry(topic: "ImportFromDevicesCommands", code: """
        .commands {
            ImportFromDevicesCommands()
        }
        """) { AnyView(AS_ImportFromDevicesExample()) },

        ExampleEntry(topic: "InspectorCommands", code: """
        .commands {
            InspectorCommands()
        }
        """) { AnyView(AS_InspectorCommandsExample()) },

        ExampleEntry(topic: "MenuBarExtraStyle", code: """
        MenuBarExtra("CPU", systemImage: "gauge") {
            CPUMeterView()
        }
        .menuBarExtraStyle(.window)
        """) { AnyView(AS_MenuBarExtraStyleExample()) },

        ExampleEntry(topic: "SceneBuilder", code: """
        @SceneBuilder
        var body: some Scene {
            WindowGroup { ContentView() }
            Settings { SettingsView() }
            MenuBarExtra("Status", systemImage: "gauge") { StatusView() }
        }
        """) { AnyView(AS_SceneBuilderExample()) },

        ExampleEntry(topic: "TextEditingCommands", code: """
        .commands {
            TextEditingCommands()
        }
        """) { AnyView(AS_TextEditingCommandsExample()) },

        ExampleEntry(topic: "TextFormattingCommands", code: """
        .commands {
            TextFormattingCommands()
        }
        """) { AnyView(AS_TextFormattingCommandsExample()) },

        ExampleEntry(topic: "ToolbarCommands", code: """
        .commands {
            ToolbarCommands()
        }
        """) { AnyView(AS_ToolbarCommandsExample()) },

        ExampleEntry(topic: "UtilityWindow", code: """
        UtilityWindow("Color Palette", id: "palette") {
            PaletteView()
        }
        .keyboardShortcut("p", modifiers: [.command, .option])
        """) { AnyView(AS_UtilityWindowExample()) },

        ExampleEntry(topic: "WindowInteractionBehavior", code: """
        Window("Palette", id: "palette") {
            PaletteView()
        }
        .windowBackgroundDragBehavior(.enabled)
        .windowMinimizeBehavior(.disabled)
        """) { AnyView(AS_WindowInteractionBehaviorExample()) },

        ExampleEntry(topic: "WindowLevel", code: """
        Window("Now Playing", id: "nowPlaying") {
            NowPlayingHUD()
        }
        .windowLevel(.floating)
        """) { AnyView(AS_WindowLevelTypeExample()) },

        ExampleEntry(topic: "WindowResizability", code: """
        Settings {
            SettingsView()
                .frame(minWidth: 480, minHeight: 320)
        }
        .windowResizability(.contentMinSize)
        """) { AnyView(AS_WindowResizabilityTypeExample()) },

        ExampleEntry(topic: "WindowStyle", code: """
        WindowGroup {
            StageView()
        }
        .windowStyle(.plain)
        """) { AnyView(AS_WindowStyleTypeExample()) },

        ExampleEntry(topic: "WindowToolbarStyle", code: """
        WindowGroup {
            DocumentView()
        }
        .windowToolbarStyle(.expanded)
        """) { AnyView(AS_WindowToolbarStyleTypeExample()) },

        ExampleEntry(topic: "WKNotificationScene", code: """
        @main
        struct CoffeeApp: App {
            var body: some Scene {
                WindowGroup { ContentView() }
                WKNotificationScene(
                    controller: ReminderController.self,
                    category: "reminder"
                )
            }
        }
        """) { AnyView(AS_WKNotificationSceneExample()) },
    ]
}

// MARK: - Shared building blocks

/// A short, muted caption used to mark illustrations and add context.
private struct AS_Caption: View {
    let text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        Text(text)
            .font(.caption2)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
    }
}

/// The macOS traffic-light controls, with optional greyed-out states.
private struct AS_TrafficLights: View {
    var minimizeEnabled: Bool = true
    var zoomEnabled: Bool = true
    var body: some View {
        HStack(spacing: 7) {
            dot(Color(red: 1.00, green: 0.37, blue: 0.35), on: true)
            dot(Color(red: 1.00, green: 0.79, blue: 0.28), on: minimizeEnabled)
            dot(Color(red: 0.36, green: 0.80, blue: 0.35), on: zoomEnabled)
        }
    }
    private func dot(_ color: Color, on: Bool) -> some View {
        Circle()
            .fill(on ? color : Color.gray.opacity(0.35))
            .frame(width: 11, height: 11)
    }
}

private enum AS_Chrome: Hashable { case titled, hiddenTitleBar, plain }

/// A faithful mock macOS window: title bar with traffic lights, plus content.
private struct AS_MockWindow<Content: View>: View {
    var title: String = ""
    var chrome: AS_Chrome = .titled
    var minimizeEnabled: Bool = true
    var zoomEnabled: Bool = true
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack(spacing: 0) {
            header
            content()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(.background)
        .clipShape(.rect(cornerRadius: 9))
        .overlay(RoundedRectangle(cornerRadius: 9).strokeBorder(.quaternary))
    }

    @ViewBuilder private var header: some View {
        switch chrome {
        case .titled:
            ZStack {
                Text(title).font(.caption.weight(.semibold)).lineLimit(1)
                HStack {
                    AS_TrafficLights(minimizeEnabled: minimizeEnabled, zoomEnabled: zoomEnabled)
                    Spacer()
                }
                .padding(.horizontal, 9)
            }
            .frame(height: 26)
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
        case .hiddenTitleBar:
            HStack {
                AS_TrafficLights(minimizeEnabled: minimizeEnabled, zoomEnabled: zoomEnabled)
                Spacer()
            }
            .padding(7)
        case .plain:
            EmptyView()
        }
    }
}

/// A simple placeholder document body: a few lines of "content".
private struct AS_DocBody: View {
    var lines: Int = 3
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ForEach(0..<lines, id: \.self) { i in
                RoundedRectangle(cornerRadius: 3)
                    .fill(.quaternary)
                    .frame(height: 7)
                    .frame(maxWidth: i == lines - 1 ? 90 : .infinity)
            }
        }
        .padding(9)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

/// A mock macOS menu-bar strip with one menu highlighted.
private struct AS_MenuBarStrip: View {
    var items: [String]
    var active: String? = nil
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "apple.logo").font(.caption2)
            ForEach(items, id: \.self) { item in
                Text(item)
                    .fontWeight(item == active ? .semibold : .regular)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(item == active ? Color.accentColor.opacity(0.25) : Color.clear,
                                in: .rect(cornerRadius: 4))
            }
            Spacer(minLength: 0)
        }
        .font(.caption)
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(.regularMaterial)
    }
}

/// A floating menu panel that hosts mock menu items.
private struct AS_MenuPanel<Content: View>: View {
    var width: CGFloat = 232
    @ViewBuilder var content: () -> Content
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            content()
        }
        .padding(.vertical, 4)
        .frame(width: width, alignment: .leading)
        .background(.regularMaterial, in: .rect(cornerRadius: 6))
        .overlay(RoundedRectangle(cornerRadius: 6).strokeBorder(.quaternary))
        .shadow(color: .black.opacity(0.15), radius: 5, y: 2)
    }
}

/// A single row inside a mock menu.
private struct AS_MenuItem: View {
    var title: String
    var shortcut: String? = nil
    var systemImage: String? = nil
    var highlighted: Bool = false
    var body: some View {
        HStack(spacing: 8) {
            if let systemImage {
                Image(systemName: systemImage).frame(width: 16)
            }
            Text(title)
            Spacer(minLength: 12)
            if let shortcut {
                Text(shortcut)
                    .foregroundStyle(highlighted ? Color.white.opacity(0.85) : Color.secondary)
            }
        }
        .font(.callout)
        .foregroundStyle(highlighted ? Color.white : Color.primary)
        .padding(.horizontal, 8)
        .padding(.vertical, 3)
        .background(highlighted ? Color.accentColor : Color.clear, in: .rect(cornerRadius: 4))
        .padding(.horizontal, 4)
    }
}

/// A mock menu bar with one open dropdown menu, indented under its title.
private struct AS_MenuMock<Menu: View>: View {
    var bar: [String]
    var active: String
    var indent: CGFloat = 36
    @ViewBuilder var menu: () -> Menu
    var body: some View {
        VStack(spacing: 0) {
            AS_MenuBarStrip(items: bar, active: active)
            HStack(alignment: .top, spacing: 0) {
                Color.clear.frame(width: indent)
                menu()
                Spacer(minLength: 0)
            }
            .padding(.top, 4)
        }
    }
}

/// A small watchOS-style bezel, for the two watch-only entries.
private struct AS_WatchFrame<Content: View>: View {
    @ViewBuilder var content: () -> Content
    var body: some View {
        content()
            .frame(width: 158, height: 122)
            .background(.black, in: .rect(cornerRadius: 24))
            .overlay(RoundedRectangle(cornerRadius: 24).strokeBorder(.gray.opacity(0.45), lineWidth: 3))
    }
}

// MARK: - .commandsReplaced()

private struct AS_CommandsReplacedExample: View {
    var body: some View {
        VStack(spacing: 8) {
            AS_MenuMock(bar: ["Playback"], active: "Playback", indent: 20) {
                AS_MenuPanel(width: 160) {
                    AS_MenuItem(title: "Play", shortcut: "Space", highlighted: true)
                }
            }
            .frame(height: 108)
            AS_Caption("Illustrative — .commandsReplaced() drops the scene's default menus and keeps only your commands.")
        }
    }
}

// MARK: - .defaultLaunchBehavior()

private struct AS_DefaultLaunchBehaviorExample: View {
    @State private var consoleOpen = false
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 10) {
                AS_MockWindow(title: "Main") { AS_DocBody(lines: 3) }
                    .frame(width: 130, height: 90)
                if consoleOpen {
                    AS_MockWindow(title: "Debug Console") {
                        VStack(alignment: .leading, spacing: 3) {
                            Text("› build succeeded").font(.system(size: 9, design: .monospaced))
                            Text("› 0 warnings").font(.system(size: 9, design: .monospaced))
                        }
                        .foregroundStyle(.green)
                        .padding(8)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    }
                    .frame(width: 130, height: 90)
                    .transition(.opacity)
                }
            }
            .frame(height: 92)
            Button(consoleOpen ? "closeWindow(\"console\")" : "openWindow(\"console\")") {
                withAnimation { consoleOpen.toggle() }
            }
            .controlSize(.small)
            .font(.caption.monospaced())
            AS_Caption(".suppressed keeps the console closed at launch until openWindow shows it.")
        }
    }
}

// MARK: - .defaultPosition()

private struct AS_DefaultPositionExample: View {
    @State private var key = "bottomTrailing"
    private let keys = ["topLeading", "top", "topTrailing",
                        "leading", "center", "trailing",
                        "bottomLeading", "bottom", "bottomTrailing"]

    var body: some View {
        VStack(spacing: 8) {
            Picker("Position", selection: $key) {
                ForEach(keys, id: \.self) { Text(".\($0)").tag($0) }
            }
            .labelsHidden()

            ZStack(alignment: alignment(for: key)) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.12))
                    .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(.quaternary))
                AS_MockWindow(title: "Activity") {
                    AS_DocBody(lines: 2)
                }
                .frame(width: 92, height: 54)
                .padding(6)
            }
            .frame(height: 118)
        }
    }

    private func alignment(for key: String) -> Alignment {
        switch key {
        case "topLeading": return .topLeading
        case "top": return .top
        case "topTrailing": return .topTrailing
        case "leading": return .leading
        case "center": return .center
        case "trailing": return .trailing
        case "bottomLeading": return .bottomLeading
        case "bottom": return .bottom
        case "bottomTrailing": return .bottomTrailing
        default: return .center
        }
    }
}

// MARK: - .defaultSize()

private struct AS_DefaultSizeExample: View {
    var body: some View {
        VStack(spacing: 8) {
            AS_MockWindow(title: "Library") {
                ZStack {
                    AS_DocBody(lines: 3)
                    Text("1000 × 650")
                        .font(.caption2.monospaced().weight(.semibold))
                        .padding(.horizontal, 7).padding(.vertical, 3)
                        .background(.tint.opacity(0.85), in: .capsule)
                        .foregroundStyle(.white)
                }
            }
            .frame(width: 210, height: 118)
            AS_Caption("Seeds the first-launch size only — the system remembers the user's later resizes. An overload takes a CGSize.")
        }
    }
}

// MARK: - .presentedWindowStyle()

private struct AS_PresentedWindowStyleExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 12) {
                VStack(spacing: 4) {
                    AS_MockWindow(title: "Default", chrome: .titled) { AS_DocBody(lines: 2) }
                        .frame(height: 82)
                    Text(".titleBar").font(.caption2.monospaced()).foregroundStyle(.secondary)
                }
                VStack(spacing: 4) {
                    AS_MockWindow(chrome: .hiddenTitleBar) { AS_DocBody(lines: 2) }
                        .frame(height: 82)
                    Text(".hiddenTitleBar").font(.caption2.monospaced()).foregroundStyle(.secondary)
                }
            }
            AS_Caption("Styles windows spawned from this view's context, rather than restyling the current window.")
        }
    }
}

// MARK: - .presentedWindowToolbarStyle()

private struct AS_PresentedWindowToolbarStyleExample: View {
    var body: some View {
        VStack(spacing: 8) {
            AS_ToolbarWindowMock(style: .unified)
                .frame(width: 230, height: 96)
            AS_Caption("Mirrors .windowToolbarStyle() but travels with the presenting view. Shown: .unified.")
        }
    }
}

// MARK: - .restorationBehavior()

private struct AS_RestorationBehaviorExample: View {
    @State private var relaunched = false
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 10) {
                AS_MockWindow(title: "Main") { AS_DocBody(lines: 3) }
                    .frame(width: 130, height: 88)
                if !relaunched {
                    AS_MockWindow(title: "Welcome") {
                        VStack(spacing: 5) {
                            Image(systemName: "hand.wave.fill").foregroundStyle(.tint)
                            Text("Welcome!").font(.caption.weight(.semibold))
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .frame(width: 130, height: 88)
                    .transition(.opacity)
                }
            }
            .frame(height: 90)
            Button(relaunched ? "Reset" : "Quit & relaunch") {
                withAnimation { relaunched.toggle() }
            }
            .controlSize(.small)
            AS_Caption(".disabled opts the Welcome window out of restoration, so it does not reopen after relaunch.")
        }
    }
}

// MARK: - .windowBackgroundDragBehavior()

private struct AS_WindowBackgroundDragExample: View {
    @State private var offset = CGSize.zero
    @State private var start = CGSize.zero

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.10))
                AS_MockWindow(chrome: .plain) {
                    VStack(spacing: 4) {
                        Image(systemName: "hand.draw.fill").foregroundStyle(.tint)
                        Text("Drag me").font(.caption.weight(.semibold))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: 108, height: 66)
                .offset(offset)
                .gesture(
                    DragGesture()
                        .onChanged { g in
                            offset = CGSize(width: start.width + g.translation.width,
                                            height: start.height + g.translation.height)
                        }
                        .onEnded { _ in start = offset }
                )
            }
            .frame(height: 118)
            .clipShape(.rect(cornerRadius: 8))
            AS_Caption(".enabled lets a drag on the plain window's background relocate it — there is no title bar to grab.")
        }
    }
}

// MARK: - .windowFullScreenBehavior()

private struct AS_WindowFullScreenBehaviorExample: View {
    var body: some View {
        VStack(spacing: 8) {
            AS_MockWindow(title: "Mini Player", zoomEnabled: false) {
                HStack(spacing: 8) {
                    Image(systemName: "play.circle.fill").font(.title2).foregroundStyle(.tint)
                    VStack(alignment: .leading, spacing: 3) {
                        RoundedRectangle(cornerRadius: 3).fill(.quaternary).frame(width: 80, height: 6)
                        RoundedRectangle(cornerRadius: 3).fill(.quaternary).frame(width: 50, height: 6)
                    }
                }
                .padding(9)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(width: 190, height: 74)
            AS_Caption(".disabled greys out the green control — the window can no longer enter full screen.")
        }
    }
}

// MARK: - .windowLevel()

private struct AS_WindowLevelModifierExample: View {
    @State private var floating = true
    var body: some View {
        VStack(spacing: 8) {
            Toggle("Timer window .floating", isOn: $floating)
                .toggleStyle(.switch)
                .controlSize(.small)
                .font(.caption)
            ZStack {
                AS_MockWindow(title: "Document") { AS_DocBody(lines: 3) }
                    .frame(width: 150, height: 96)
                    .offset(x: -20, y: -8)
                AS_MockWindow(title: "Timer") {
                    Text("00:45").font(.title3.monospacedDigit().weight(.semibold))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: 110, height: 64)
                .offset(x: 30, y: 20)
                .zIndex(floating ? 1 : 0)
                .shadow(radius: floating ? 8 : 0)
            }
            .frame(height: 110)
        }
    }
}

// MARK: - .windowMinimizeBehavior()

private struct AS_WindowMinimizeBehaviorExample: View {
    var body: some View {
        VStack(spacing: 8) {
            AS_MockWindow(title: "Inspector", minimizeEnabled: false) {
                VStack(alignment: .leading, spacing: 6) {
                    labelRow("Opacity", "100%")
                    labelRow("Rotation", "0°")
                    labelRow("Blend", "Normal")
                }
                .padding(9)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(width: 180, height: 96)
            AS_Caption(".disabled removes the yellow minimize control — the panel can't be sent to the Dock.")
        }
    }
    private func labelRow(_ name: String, _ value: String) -> some View {
        HStack {
            Text(name).foregroundStyle(.secondary)
            Spacer()
            Text(value)
        }
        .font(.caption)
    }
}

// MARK: - .windowResizability()

private struct AS_WindowResizabilityModifierExample: View {
    var body: some View {
        VStack(spacing: 8) {
            AS_MockWindow(title: "About") {
                VStack(spacing: 5) {
                    Image(systemName: "app.gift.fill").font(.title2).foregroundStyle(.tint)
                    Text("Ledger 3.0").font(.caption.weight(.semibold))
                    Text("420 × 260, fixed")
                        .font(.caption2.monospaced()).foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: 180, height: 96)
            .overlay(alignment: .bottomTrailing) {
                Image(systemName: "lock.fill")
                    .font(.caption2)
                    .padding(4)
                    .foregroundStyle(.secondary)
            }
            AS_Caption(".contentSize pins the window to the content's exact size, so this About box can't be resized.")
        }
    }
}

// MARK: - .windowStyle()

private struct AS_WindowStyleModifierExample: View {
    @State private var chrome: AS_Chrome = .hiddenTitleBar
    var body: some View {
        VStack(spacing: 8) {
            Picker("Style", selection: $chrome) {
                Text(".titleBar").tag(AS_Chrome.titled)
                Text(".hiddenTitleBar").tag(AS_Chrome.hiddenTitleBar)
                Text(".plain").tag(AS_Chrome.plain)
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            AS_MockWindow(title: "Canvas", chrome: chrome) {
                LinearGradient(colors: [.indigo, .teal],
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                    .overlay(Image(systemName: "scribble.variable")
                        .font(.title2).foregroundStyle(.white.opacity(0.9)))
            }
            .frame(height: 104)
        }
    }
}

// MARK: - .windowToolbarStyle()

private enum AS_TB: String, CaseIterable, Identifiable {
    case unified, unifiedCompact, expanded
    var id: Self { self }
}

/// A mock window whose toolbar/title arrangement follows a WindowToolbarStyle.
private struct AS_ToolbarWindowMock: View {
    var style: AS_TB
    var body: some View {
        VStack(spacing: 0) {
            switch style {
            case .unified:        unifiedRow(compact: false)
            case .unifiedCompact: unifiedRow(compact: true)
            case .expanded:
                titleRow
                Divider()
                toolbarRow
            }
            Divider()
            AS_DocBody(lines: 3)
        }
        .background(.background)
        .clipShape(.rect(cornerRadius: 9))
        .overlay(RoundedRectangle(cornerRadius: 9).strokeBorder(.quaternary))
    }

    private func unifiedRow(compact: Bool) -> some View {
        HStack(spacing: 10) {
            AS_TrafficLights()
            Text("Feeds").font(.caption.weight(.semibold))
            Spacer()
            Image(systemName: "plus")
            Image(systemName: "square.and.arrow.up")
        }
        .font(.callout)
        .padding(.horizontal, 10)
        .frame(height: compact ? 28 : 40)
        .frame(maxWidth: .infinity)
        .background(.regularMaterial)
    }

    private var titleRow: some View {
        ZStack {
            Text("Feeds").font(.caption.weight(.semibold))
            HStack { AS_TrafficLights(); Spacer() }.padding(.horizontal, 10)
        }
        .frame(height: 24)
        .frame(maxWidth: .infinity)
        .background(.regularMaterial)
    }

    private var toolbarRow: some View {
        HStack(spacing: 16) {
            Image(systemName: "chevron.left")
            Image(systemName: "chevron.right")
            Spacer()
            Image(systemName: "plus")
            Image(systemName: "square.and.arrow.up")
        }
        .font(.callout)
        .foregroundStyle(.secondary)
        .padding(.horizontal, 10)
        .frame(height: 32)
        .frame(maxWidth: .infinity)
        .background(.regularMaterial)
    }
}

private struct AS_WindowToolbarStyleModifierExample: View {
    @State private var style: AS_TB = .unifiedCompact
    var body: some View {
        VStack(spacing: 8) {
            Picker("Toolbar", selection: $style) {
                Text(".unified").tag(AS_TB.unified)
                Text(".unifiedCompact").tag(AS_TB.unifiedCompact)
                Text(".expanded").tag(AS_TB.expanded)
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            AS_ToolbarWindowMock(style: style)
                .frame(height: 118)
        }
    }
}

// MARK: - @WKApplicationDelegateAdaptor

private struct AS_WKAppDelegateAdaptorExample: View {
    var body: some View {
        VStack(spacing: 8) {
            AS_WatchFrame {
                VStack(alignment: .leading, spacing: 5) {
                    HStack(spacing: 6) {
                        Image(systemName: "figure.run")
                        Text("WorkoutApp").fontWeight(.semibold)
                    }
                    Divider().overlay(Color.gray)
                    callback("didFinishLaunching()", "bolt.fill")
                    callback("registerForRemote…", "bell.badge.fill")
                    callback("backgroundRefresh", "arrow.clockwise")
                }
                .font(.system(size: 9))
                .foregroundStyle(.white)
                .padding(11)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            AS_Caption("Illustrative — watchOS only. The adaptor installs your WKApplicationDelegate for lifecycle callbacks.")
        }
    }
    private func callback(_ text: String, _ symbol: String) -> some View {
        Label(text, systemImage: symbol).foregroundStyle(.white.opacity(0.9))
    }
}

// MARK: - BackgroundTask

private struct AS_BackgroundTaskExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 6) {
                Image(systemName: "moon.zzz.fill").foregroundStyle(.indigo)
                Text("System wakes the app").font(.caption)
                Image(systemName: "arrow.right").font(.caption2).foregroundStyle(.secondary)
                Text("handler runs").font(.caption)
            }
            taskRow(".appRefresh", "com.example.sync", "arrow.triangle.2.circlepath")
            taskRow(".urlSession", "com.example.downloads", "arrow.down.circle")
            AS_Caption("Illustrative — the identifier must match what you scheduled with the BackgroundTasks framework.")
        }
    }
    private func taskRow(_ kind: String, _ id: String, _ symbol: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: symbol).foregroundStyle(.tint).frame(width: 18)
            Text(kind).font(.caption.monospaced().weight(.semibold))
            Text(id).font(.caption2.monospaced()).foregroundStyle(.secondary)
            Spacer()
        }
        .padding(.horizontal, 9).padding(.vertical, 6)
        .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 7))
    }
}

// MARK: - CommandGroupPlacement

private struct AS_CommandGroupPlacementExample: View {
    var body: some View {
        VStack(spacing: 8) {
            AS_MenuMock(bar: ["File", "Edit", "View", "Help"], active: "File") {
                AS_MenuPanel {
                    AS_MenuItem(title: "New Board", shortcut: "⌘N", highlighted: true)
                    AS_MenuItem(title: "New Window", shortcut: "⇧⌘N")
                    Divider().padding(.horizontal, 8)
                    AS_MenuItem(title: "Open…", shortcut: "⌘O")
                    AS_MenuItem(title: "Close", shortcut: "⌘W")
                }
            }
            .frame(height: 132)
            AS_Caption("Anchors name menu regions: .newItem (File's creation block), .appInfo (About), .help (Help).")
        }
    }
}

// MARK: - ImportFromDevicesCommands

private struct AS_ImportFromDevicesExample: View {
    var body: some View {
        VStack(spacing: 8) {
            AS_MenuMock(bar: ["File", "Edit", "View"], active: "File") {
                AS_MenuPanel(width: 250) {
                    AS_MenuItem(title: "Import from iPhone or iPad", systemImage: "iphone")
                    Divider().padding(.horizontal, 8)
                    AS_MenuItem(title: "Take Photo", systemImage: "camera")
                    AS_MenuItem(title: "Scan Documents", systemImage: "doc.viewfinder")
                    AS_MenuItem(title: "Add Sketch", systemImage: "pencil.tip.crop.circle")
                }
            }
            .frame(height: 128)
            AS_Caption("Illustrative — adds Continuity Camera import items to the File menu on macOS.")
        }
    }
}

// MARK: - InspectorCommands

private struct AS_InspectorCommandsExample: View {
    @State private var showInspector = true
    var body: some View {
        VStack(spacing: 8) {
            AS_MenuPanel(width: 220) {
                AS_MenuItem(title: showInspector ? "Hide Inspector" : "Show Inspector",
                            shortcut: "⌥⌘I", highlighted: true)
            }
            HStack(spacing: 0) {
                AS_DocBody(lines: 3)
                    .frame(maxWidth: .infinity)
                if showInspector {
                    Divider()
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Inspector").font(.caption.weight(.semibold))
                        Text("Width  240").font(.caption2).foregroundStyle(.secondary)
                        Text("Locked  No").font(.caption2).foregroundStyle(.secondary)
                    }
                    .padding(8)
                    .frame(width: 120, alignment: .leading)
                    .background(.quaternary.opacity(0.4))
                    .transition(.move(edge: .trailing).combined(with: .opacity))
                }
            }
            .frame(height: 78)
            .background(.background)
            .clipShape(.rect(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(.quaternary))

            Button(showInspector ? "Hide Inspector" : "Show Inspector") {
                withAnimation { showInspector.toggle() }
            }
            .controlSize(.small)
        }
    }
}

// MARK: - MenuBarExtraStyle

private struct AS_MenuBarExtraStyleExample: View {
    var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 12) {
                Spacer()
                Image(systemName: "wifi")
                Image(systemName: "bolt.fill")
                HStack(spacing: 3) {
                    Image(systemName: "gauge.medium")
                    Text("CPU")
                }
                .padding(.horizontal, 5).padding(.vertical, 2)
                .background(Color.accentColor.opacity(0.25), in: .rect(cornerRadius: 4))
                Text("9:41")
            }
            .font(.caption)
            .padding(.horizontal, 8).padding(.vertical, 4)
            .background(.regularMaterial)

            HStack {
                Spacer()
                AS_MenuPanel(width: 150) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("CPU Load").font(.caption.weight(.semibold))
                        ForEach(0..<4, id: \.self) { i in
                            ProgressView(value: [0.7, 0.4, 0.85, 0.3][i])
                                .progressViewStyle(.linear)
                        }
                    }
                    .padding(8)
                }
                Spacer()
            }
            AS_Caption(".window hosts a live SwiftUI panel; .menu instead flattens content into plain menu items.")
        }
    }
}

// MARK: - SceneBuilder

private struct AS_SceneBuilderExample: View {
    var body: some View {
        VStack(spacing: 7) {
            Text("App body — @SceneBuilder")
                .font(.caption.weight(.semibold))
            sceneCard("WindowGroup", "square.stack.3d.up.fill", .blue)
            sceneCard("Settings", "gearshape.fill", .gray)
            sceneCard("MenuBarExtra", "menubar.rectangle", .teal)
            AS_Caption("The result builder folds these scenes into one `some Scene`.")
        }
    }
    private func sceneCard(_ name: String, _ symbol: String, _ tint: Color) -> some View {
        HStack(spacing: 8) {
            Image(systemName: symbol).foregroundStyle(tint).frame(width: 20)
            Text(name).font(.callout.monospaced())
            Spacer()
        }
        .padding(.horizontal, 10).padding(.vertical, 6)
        .background(tint.opacity(0.12), in: .rect(cornerRadius: 7))
        .overlay(RoundedRectangle(cornerRadius: 7).strokeBorder(tint.opacity(0.3)))
    }
}

// MARK: - TextEditingCommands

private struct AS_TextEditingCommandsExample: View {
    var body: some View {
        VStack(spacing: 8) {
            AS_MenuMock(bar: ["Edit", "Format", "View"], active: "Edit") {
                AS_MenuPanel {
                    AS_MenuItem(title: "Undo", shortcut: "⌘Z")
                    AS_MenuItem(title: "Redo", shortcut: "⇧⌘Z")
                    Divider().padding(.horizontal, 8)
                    AS_MenuItem(title: "Find…", shortcut: "⌘F")
                    AS_MenuItem(title: "Find and Replace…", shortcut: "⌥⌘F")
                    AS_MenuItem(title: "Spelling and Grammar")
                }
            }
            .frame(height: 138)
            AS_Caption("Adds Find and spelling items that route to the focused text control.")
        }
    }
}

// MARK: - TextFormattingCommands

private struct AS_TextFormattingCommandsExample: View {
    @State private var bold = true
    @State private var italic = false
    var body: some View {
        VStack(spacing: 8) {
            AS_MenuMock(bar: ["Edit", "Format", "View"], active: "Format") {
                AS_MenuPanel {
                    AS_MenuItem(title: "Bold", shortcut: "⌘B", highlighted: bold)
                    AS_MenuItem(title: "Italic", shortcut: "⌘I", highlighted: italic)
                    AS_MenuItem(title: "Underline", shortcut: "⌘U")
                    Divider().padding(.horizontal, 8)
                    AS_MenuItem(title: "Show Fonts", shortcut: "⌘T")
                }
            }
            HStack(spacing: 14) {
                Toggle("Bold", isOn: $bold).toggleStyle(.button).controlSize(.small)
                Toggle("Italic", isOn: $italic).toggleStyle(.button).controlSize(.small)
                Text("Aa").font(.title3).bold(bold).italic(italic)
            }
            AS_Caption("Contributes the Format menu; include it only when the app supports rich text.")
        }
    }
}

// MARK: - ToolbarCommands

private struct AS_ToolbarCommandsExample: View {
    var body: some View {
        VStack(spacing: 8) {
            AS_MenuMock(bar: ["View", "Window", "Help"], active: "View") {
                AS_MenuPanel {
                    AS_MenuItem(title: "Show Toolbar", shortcut: "⌥⌘T")
                    AS_MenuItem(title: "Hide Sidebar", shortcut: "⌃⌘S")
                    Divider().padding(.horizontal, 8)
                    AS_MenuItem(title: "Customize Toolbar…")
                }
            }
            .frame(height: 120)
            AS_Caption("Adds the standard toolbar show/hide and customize items to the View menu.")
        }
    }
}

// MARK: - UtilityWindow

private struct AS_UtilityWindowExample: View {
    private let swatches: [Color] = [.red, .orange, .yellow, .green, .teal, .blue, .indigo, .purple, .pink, .brown, .mint, .cyan]
    var body: some View {
        VStack(spacing: 8) {
            VStack(spacing: 0) {
                ZStack {
                    Text("Color Palette").font(.caption2.weight(.semibold))
                    HStack { AS_TrafficLights(zoomEnabled: false); Spacer() }.padding(.horizontal, 8)
                }
                .frame(height: 20)
                .frame(maxWidth: .infinity)
                .background(.regularMaterial)
                Divider()
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 5), count: 6), spacing: 5) {
                    ForEach(0..<swatches.count, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 4).fill(swatches[i]).frame(height: 18)
                    }
                }
                .padding(8)
            }
            .background(.background)
            .clipShape(.rect(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(.quaternary))
            .frame(width: 176)
            AS_Caption("A single compact panel with tool chrome; pair with .keyboardShortcut() for a show/hide toggle.")
        }
    }
}

// MARK: - WindowInteractionBehavior

private struct AS_WindowInteractionBehaviorExample: View {
    @State private var behavior = "disabled"
    var body: some View {
        VStack(spacing: 8) {
            Picker("Behavior", selection: $behavior) {
                Text(".automatic").tag("automatic")
                Text(".enabled").tag("enabled")
                Text(".disabled").tag("disabled")
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            AS_MockWindow(title: "Palette", minimizeEnabled: behavior != "disabled") {
                HStack(spacing: 6) {
                    ForEach([Color.red, .green, .blue], id: \.self) { c in
                        Circle().fill(c).frame(width: 16, height: 16)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: 170, height: 66)

            Text(caption)
                .font(.caption2).foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
    private var caption: String {
        switch behavior {
        case "enabled":  return ".enabled forces the interaction on regardless of window style."
        case "disabled": return ".disabled removes the affordance — here the minimize control is gone."
        default:         return ".automatic defers to whatever the window style normally permits."
        }
    }
}

// MARK: - WindowLevel

private struct AS_WindowLevelTypeExample: View {
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                levelWindow("automatic", .gray).offset(x: -46, y: -12).zIndex(0)
                levelWindow("normal", .blue).offset(x: 0, y: 6).zIndex(1)
                levelWindow("floating", .teal).offset(x: 46, y: 24).zIndex(2).shadow(radius: 7)
            }
            .frame(height: 116)
            AS_Caption(".floating keeps a window above standard ones even when it is not key; .normal and .automatic sit in the document tier.")
        }
    }
    private func levelWindow(_ label: String, _ tint: Color) -> some View {
        AS_MockWindow(title: ".\(label)") {
            tint.opacity(0.18)
        }
        .frame(width: 108, height: 60)
    }
}

// MARK: - WindowResizability

private struct AS_WindowResizabilityTypeExample: View {
    var body: some View {
        VStack(spacing: 7) {
            resizeRow(".contentSize", "Pins to the content's exact min and max size.", "lock.fill")
            resizeRow(".contentMinSize", "Enforces the minimum, allows unlimited growth.", "arrow.up.left.and.arrow.down.right")
            resizeRow(".automatic", "Defers to the platform defaults.", "gearshape.fill")
            AS_Caption("The content's frame constraints become the source of truth for window geometry.")
        }
    }
    private func resizeRow(_ name: String, _ desc: String, _ symbol: String) -> some View {
        HStack(spacing: 9) {
            Image(systemName: symbol).foregroundStyle(.tint).frame(width: 20)
            VStack(alignment: .leading, spacing: 1) {
                Text(name).font(.caption.monospaced().weight(.semibold))
                Text(desc).font(.caption2).foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(.horizontal, 9).padding(.vertical, 6)
        .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 7))
    }
}

// MARK: - WindowStyle

private struct AS_WindowStyleTypeExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 10) {
                styled("Titled", .titled, ".titleBar")
                styled("Hidden", .hiddenTitleBar, ".hiddenTitleBar")
                styled("Plain", .plain, ".plain")
            }
            AS_Caption("Static members select the chrome: a titled window, a hidden title bar, or fully undecorated .plain.")
        }
    }
    private func styled(_ title: String, _ chrome: AS_Chrome, _ label: String) -> some View {
        VStack(spacing: 4) {
            AS_MockWindow(title: title, chrome: chrome) {
                LinearGradient(colors: [.purple.opacity(0.5), .blue.opacity(0.5)],
                               startPoint: .top, endPoint: .bottom)
            }
            .frame(height: 72)
            Text(label).font(.system(size: 9, design: .monospaced)).foregroundStyle(.secondary)
        }
    }
}

// MARK: - WindowToolbarStyle

private struct AS_WindowToolbarStyleTypeExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 10) {
                labeled(.unified, ".unified")
                labeled(.unifiedCompact, ".unifiedCompact")
                labeled(.expanded, ".expanded")
            }
            AS_Caption("They trade vertical space against title prominence — merged rows versus a title on its own row.")
        }
    }
    private func labeled(_ style: AS_TB, _ label: String) -> some View {
        VStack(spacing: 4) {
            AS_ToolbarWindowMock(style: style).frame(height: 92)
            Text(label).font(.system(size: 8, design: .monospaced)).foregroundStyle(.secondary)
        }
    }
}

// MARK: - WKNotificationScene

private struct AS_WKNotificationSceneExample: View {
    var body: some View {
        VStack(spacing: 8) {
            AS_WatchFrame {
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 5) {
                        Image(systemName: "cup.and.saucer.fill").foregroundStyle(.orange)
                        Text("Reminder").fontWeight(.semibold)
                        Spacer()
                        Text("now").foregroundStyle(.secondary)
                    }
                    .font(.system(size: 10))
                    Text("Time to refill your cup").font(.system(size: 12))
                    Spacer()
                    Text("Snooze")
                        .font(.system(size: 10, weight: .semibold))
                        .padding(.vertical, 4)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange.opacity(0.4), in: .capsule)
                }
                .foregroundStyle(.white)
                .padding(11)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            AS_Caption("Illustrative — watchOS only. Renders a custom long-look notification for one category.")
        }
    }
}
