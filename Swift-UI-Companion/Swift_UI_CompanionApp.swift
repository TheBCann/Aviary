//
//  Swift_UI_CompanionApp.swift
//  Swift-UI-Companion
//
//  Created by Brandon Cannizzaro on 8/31/26.
//

import SwiftUI

@main
struct Swift_UI_CompanionApp: App {
    @State private var model = AppModel()
    @AppStorage(AppearanceSetting.storageKey)
    private var appearanceRaw = AppearanceSetting.system.rawValue

    private var preferredScheme: ColorScheme? {
        (AppearanceSetting(rawValue: appearanceRaw) ?? .system).colorScheme
    }

    var body: some Scene {
        WindowGroup(id: "main") {
            ContentView()
                .environment(model)
                .preferredColorScheme(preferredScheme)
        }
        .commands {
            CommandGroup(after: .newItem) {
                Button("New Tab") {
                    model.addTab()
                }
                .keyboardShortcut("t")

                Button("Close Tab") {
                    model.close(model.activeTab)
                }
                .keyboardShortcut("w", modifiers: [.command, .shift])
                .disabled(model.tabs.count == 1)
            }
        }

        MenuBarExtra("SwiftUI Companion", systemImage: "swift") {
            MenuBarSearchView()
                .environment(model)
                .preferredColorScheme(preferredScheme)
        }
        .menuBarExtraStyle(.window)
    }
}
