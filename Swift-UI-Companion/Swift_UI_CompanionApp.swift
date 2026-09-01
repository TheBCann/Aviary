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

    var body: some Scene {
        WindowGroup(id: "main") {
            ContentView()
                .environment(model)
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
        }
        .menuBarExtraStyle(.window)
    }
}
