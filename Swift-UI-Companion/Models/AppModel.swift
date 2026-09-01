//
//  AppModel.swift
//  Swift-UI-Companion
//

import SwiftUI

/// One selection state a tab can navigate back or forward to.
struct NavSnapshot: Hashable {
    var sidebar: SidebarItem?
    var topicID: Topic.ID?
}

/// One workspace tab: its own filter, search text, selection, and
/// back/forward navigation history.
@Observable
final class WorkspaceTab: Identifiable {
    let id = UUID()
    var criteria = FilterCriteria()
    var searchText = ""

    private(set) var backStack: [NavSnapshot] = []
    private(set) var forwardStack: [NavSnapshot] = []
    private var isRestoring = false
    /// The state as of the last recorded change — what a new navigation
    /// pushes onto the back stack.
    private var current = NavSnapshot(sidebar: .all, topicID: nil)

    var sidebarSelection: SidebarItem? = .all {
        didSet { syncCurrent() }
    }

    var selectedTopicID: Topic.ID? {
        didSet {
            guard !isRestoring, oldValue != selectedTopicID else {
                syncCurrent()
                return
            }
            // Don't record the empty "nothing selected" launch state.
            if current.topicID != nil {
                backStack.append(current)
                forwardStack.removeAll()
            }
            syncCurrent()
        }
    }

    var title: String { criteria.summaryLabel }

    var canGoBack: Bool { !backStack.isEmpty }
    var canGoForward: Bool { !forwardStack.isEmpty }

    func goBack() {
        guard let snapshot = backStack.popLast() else { return }
        forwardStack.append(current)
        apply(snapshot)
    }

    func goForward() {
        guard let snapshot = forwardStack.popLast() else { return }
        backStack.append(current)
        apply(snapshot)
    }

    private func apply(_ snapshot: NavSnapshot) {
        isRestoring = true
        sidebarSelection = snapshot.sidebar
        selectedTopicID = snapshot.topicID
        current = snapshot
        isRestoring = false
    }

    private func syncCurrent() {
        guard !isRestoring else { return }
        current = NavSnapshot(sidebar: sidebarSelection, topicID: selectedTopicID)
    }
}

/// App-wide state: the catalog plus the open workspace tabs.
/// What a selection id points at: a topic page, or one of its children.
struct ResolvedSelection {
    let topic: Topic
    let child: TopicChild?
}

@Observable
final class AppModel {
    let topics: [Topic]
    let frameworks: [String]
    var tabs: [WorkspaceTab]
    var activeTabID: WorkspaceTab.ID

    private let topicsByID: [String: Topic]
    private let childParents: [String: String]

    init(topics: [Topic] = Catalog.all) {
        let sorted = topics.sorted {
            $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
        }
        self.topics = sorted
        self.frameworks = Set(topics.map(\.framework)).sorted()

        var byID: [String: Topic] = [:]
        var parents: [String: String] = [:]
        for topic in sorted {
            byID[topic.id] = topic
            for child in topic.children {
                parents[child.id] = topic.id
            }
        }
        self.topicsByID = byID
        self.childParents = parents

        let tab = WorkspaceTab()
        self.tabs = [tab]
        self.activeTabID = tab.id
    }

    /// Total number of child entries across the catalog.
    var childEntryCount: Int { childParents.count }

    /// Resolves a selection id to its topic — and child, when the id names
    /// one of a topic's variants.
    func resolve(_ id: String?) -> ResolvedSelection? {
        guard let id else { return nil }
        if let topic = topicsByID[id] {
            return ResolvedSelection(topic: topic, child: nil)
        }
        guard
            let parentID = childParents[id],
            let parent = topicsByID[parentID],
            let child = parent.children.first(where: { $0.id == id })
        else { return nil }
        return ResolvedSelection(topic: parent, child: child)
    }

    var activeTab: WorkspaceTab {
        tabs.first { $0.id == activeTabID } ?? tabs[0]
    }

    func topic(withID id: Topic.ID?) -> Topic? {
        guard let id else { return nil }
        return topicsByID[id]
    }

    func addTab() {
        let tab = WorkspaceTab()
        tabs.append(tab)
        activeTabID = tab.id
    }

    func close(_ tab: WorkspaceTab) {
        guard tabs.count > 1, let index = tabs.firstIndex(where: { $0.id == tab.id }) else {
            return
        }
        tabs.remove(at: index)
        if activeTabID == tab.id {
            activeTabID = tabs[min(index, tabs.count - 1)].id
        }
    }

    /// Topics shown in the list column for `tab`, honoring the sidebar
    /// selection, the tab's filter, and its search text.
    func visibleTopics(for tab: WorkspaceTab) -> [Topic] {
        topics.filter { topic in
            if case .kind(let kind) = tab.sidebarSelection, topic.kind != kind {
                return false
            }
            guard tab.criteria.matches(topic) else { return false }
            guard !tab.searchText.isEmpty else { return true }
            return topic.name.localizedCaseInsensitiveContains(tab.searchText)
                || topic.summary.localizedCaseInsensitiveContains(tab.searchText)
                || topic.framework.localizedCaseInsensitiveContains(tab.searchText)
                || topic.children.contains {
                    $0.name.localizedCaseInsensitiveContains(tab.searchText)
                }
        }
    }

    /// Number of topics of `kind` that pass the tab's filter (sidebar badge).
    func count(of item: SidebarItem, for tab: WorkspaceTab) -> Int {
        topics.count { topic in
            if case .kind(let kind) = item, topic.kind != kind { return false }
            return tab.criteria.matches(topic)
        }
    }

    /// Jump the active tab to `topic` (used by the menu bar search and
    /// related-topic links). The topic is selected before the sidebar moves
    /// so the history snapshot keeps the old entry with its old context.
    func reveal(_ topic: Topic) {
        let tab = activeTab
        tab.criteria = FilterCriteria()
        tab.searchText = ""
        tab.selectedTopicID = topic.id
        tab.sidebarSelection = .kind(topic.kind)
    }

    /// Jump the active tab straight to a child entry.
    func reveal(childID: String) {
        guard
            let parentID = childParents[childID],
            let parent = topicsByID[parentID]
        else { return }
        let tab = activeTab
        tab.criteria = FilterCriteria()
        tab.searchText = ""
        tab.selectedTopicID = childID
        tab.sidebarSelection = .kind(parent.kind)
    }
}
