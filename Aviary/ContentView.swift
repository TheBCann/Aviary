//
//  ContentView.swift
//  Aviary
//
//  Created by Brandon Cannizzaro on 8/31/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(AppModel.self) private var model

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                TabStripView()
                Divider()
                WorkspaceView(tab: model.activeTab)
                    .id(model.activeTabID)
            }

            if model.isQuickOpenPresented {
                QuickOpenOverlay()
            }
        }
        .frame(minWidth: 940, minHeight: 580)
    }
}

/// One workspace tab's three-column browser.
struct WorkspaceView: View {
    @Environment(AppModel.self) private var model
    @Bindable var tab: WorkspaceTab

    private var sidebarKinds: [TopicKind] {
        TopicKind.allCases.filter {
            tab.criteria.kinds.isEmpty || tab.criteria.kinds.contains($0)
        }
    }

    var body: some View {
        NavigationSplitView {
            List(selection: $tab.sidebarSelection) {
                Label("All APIs", systemImage: "books.vertical")
                    .badge(model.count(of: .all, for: tab))
                    .tag(SidebarItem.all)

                Section("Kinds") {
                    // A tab filtered to specific API areas shows only those.
                    ForEach(sidebarKinds) { kind in
                        Label {
                            Text(kind.pluralTitle)
                        } icon: {
                            KindBadge(kind: kind, size: 16)
                        }
                        .badge(model.count(of: .kind(kind), for: tab))
                        .tag(SidebarItem.kind(kind))
                    }
                }
            }
            .listStyle(.sidebar)
            .scrollContentBackground(.hidden)
            .background(Theme.Surface.sidebar)
            .navigationSplitViewColumnWidth(min: 200, ideal: 220)
        } content: {
            TopicListView(tab: tab)
                .navigationSplitViewColumnWidth(min: 260, ideal: 300)
        } detail: {
            Group {
                if let selection = model.resolve(tab.selectedTopicID) {
                    // Keyed on the topic (not the child) so selecting a
                    // variant swaps its example in place, preserving the page
                    // and scroll position, instead of rebuilding the view.
                    TopicDetailView(topic: selection.topic, focusedChild: selection.child)
                        .id(selection.topic.id)
                } else {
                    ContentUnavailableView {
                        Label("Aviary", systemImage: "swift")
                    } description: {
                        Text("Select a topic, or search from the menu bar icon.")
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Theme.Surface.window)
        }
    }
}

#Preview {
    ContentView()
        .environment(AppModel())
}
