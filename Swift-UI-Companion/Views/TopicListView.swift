//
//  TopicListView.swift
//  Swift-UI-Companion
//
//  The middle column: searchable, filtered topic list for the active tab.
//

import SwiftUI

struct TopicListView: View {
    @Environment(AppModel.self) private var model
    @Bindable var tab: WorkspaceTab

    var body: some View {
        let topics = model.visibleTopics(for: tab)

        List(selection: $tab.selectedTopicID) {
            ForEach(topics) { topic in
                if topic.children.isEmpty {
                    TopicRow(topic: topic)
                        .tag(topic.id)
                } else {
                    DisclosureGroup {
                        ForEach(topic.children) { child in
                            ChildRow(child: child)
                                .tag(child.id)
                        }
                    } label: {
                        TopicRow(topic: topic)
                            .tag(topic.id)
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(Theme.Surface.raised)
        .searchable(text: $tab.searchText, prompt: "Search APIs")
        .navigationTitle(listTitle)
        .navigationSubtitle("\(topics.count) entries")
        .toolbar {
            ToolbarItemGroup(placement: .navigation) {
                Button {
                    tab.goBack()
                } label: {
                    Image(systemName: "chevron.backward")
                }
                .disabled(!tab.canGoBack)
                .help("Back")

                Button {
                    tab.goForward()
                } label: {
                    Image(systemName: "chevron.forward")
                }
                .disabled(!tab.canGoForward)
                .help("Forward")
            }

            ToolbarItem(placement: .primaryAction) {
                FilterButton(tab: tab)
            }
        }
        .overlay {
            if topics.isEmpty {
                ContentUnavailableView.search(text: tab.searchText)
            }
        }
    }

    private var listTitle: String {
        if case .kind(let kind) = tab.sidebarSelection {
            return kind.pluralTitle
        }
        return "All APIs"
    }
}

struct TopicRow: View {
    let topic: Topic

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack(spacing: 6) {
                KindBadge(kind: topic.kind, size: 17)
                Text(topic.name)
                    .font(.system(.body, design: .monospaced))
                    .lineLimit(1)
                if topic.deprecated {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.caption2)
                        .foregroundStyle(.orange)
                        .help("Deprecated")
                }
                Spacer()
                if topic.framework != "SwiftUI" {
                    Text(topic.framework)
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                }
                if topic.demoID != nil {
                    Image(systemName: "wand.and.stars")
                        .font(.caption)
                        .foregroundStyle(.purple)
                        .help("Has an interactive example")
                }
            }

            Text(topic.summary)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(2)

            HStack(spacing: 4) {
                ForEach(topic.orderedPlatforms) { platform in
                    if let version = topic.compactIntroducedVersion(on: platform) {
                        Text("\(platform.shortLetter)\(version)")
                            .font(.system(size: 9, weight: .semibold, design: .monospaced))
                            .padding(.horizontal, 4)
                            .padding(.vertical, 1)
                            .background(platform.tint.opacity(0.14), in: .rect(cornerRadius: 3))
                            .foregroundStyle(platform.tint)
                    }
                }
            }
        }
        .padding(.vertical, 2)
    }
}

/// A row for one child entry (an initializer, overload, or nested type).
struct ChildRow: View {
    let child: TopicChild

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "arrow.turn.down.right")
                .font(.caption2)
                .foregroundStyle(.tertiary)
                .frame(width: 16)
            Text(child.name)
                .font(.system(.callout, design: .monospaced))
                .lineLimit(1)
                .truncationMode(.middle)
        }
        .padding(.vertical, 1)
        .help(child.summary)
    }
}

/// Toolbar button opening the per-tab filter editor.
struct FilterButton: View {
    @Bindable var tab: WorkspaceTab
    @State private var isPresented = false

    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            Label(
                "Filter",
                systemImage: tab.criteria.isActive
                    ? "line.3.horizontal.decrease.circle.fill"
                    : "line.3.horizontal.decrease.circle"
            )
        }
        .help("Filter this tab by API area, platform, and WWDC year")
        .popover(isPresented: $isPresented, arrowEdge: .bottom) {
            FilterEditor(tab: tab)
                .padding(16)
                .frame(width: 300)
        }
    }
}

struct FilterEditor: View {
    @Environment(AppModel.self) private var model
    @Bindable var tab: WorkspaceTab

    private let twoColumns = [
        GridItem(.flexible(), alignment: .leading),
        GridItem(.flexible(), alignment: .leading),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Filter this tab")
                .font(.headline)

            section("API areas") {
                LazyVGrid(columns: twoColumns, alignment: .leading, spacing: 4) {
                    ForEach(TopicKind.allCases) { kind in
                        Toggle(kind.pluralTitle, isOn: kindBinding(kind))
                    }
                }
            }

            section("Platforms") {
                LazyVGrid(columns: twoColumns, alignment: .leading, spacing: 4) {
                    ForEach(ApplePlatform.allCases) { platform in
                        Toggle(platform.rawValue, isOn: platformBinding(platform))
                    }
                }
            }

            section("Framework") {
                Picker("Framework", selection: frameworkBinding) {
                    Text("Any").tag("")
                    ForEach(model.frameworks, id: \.self) { framework in
                        Text(framework).tag(framework)
                    }
                }
                .labelsHidden()
            }

            section("Introduced") {
                Picker("From", selection: yearBinding(\.minYear, counterpart: \.maxYear, keepBelow: true)) {
                    Text("Any").tag(0)
                    ForEach(Array(FilterCriteria.yearSpan), id: \.self) { year in
                        Text("WWDC \(String(year))").tag(year)
                    }
                }
                Picker("To", selection: yearBinding(\.maxYear, counterpart: \.minYear, keepBelow: false)) {
                    Text("Any").tag(0)
                    ForEach(Array(FilterCriteria.yearSpan), id: \.self) { year in
                        Text("WWDC \(String(year))").tag(year)
                    }
                }
            }

            Divider()

            HStack {
                Button("Clear Filter") {
                    tab.criteria = FilterCriteria()
                }
                .disabled(!tab.criteria.isActive)

                Spacer()

                Text("\(model.count(of: .all, for: tab)) entries match")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }

    @ViewBuilder
    private func section(_ title: String, @ViewBuilder content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            content()
        }
    }

    private func kindBinding(_ kind: TopicKind) -> Binding<Bool> {
        Binding(
            get: { tab.criteria.kinds.contains(kind) },
            set: { include in
                if include {
                    tab.criteria.kinds.insert(kind)
                } else {
                    tab.criteria.kinds.remove(kind)
                }
                // Don't leave the sidebar pointing at an excluded area.
                if case .kind(let selected) = tab.sidebarSelection,
                   !tab.criteria.kinds.isEmpty,
                   !tab.criteria.kinds.contains(selected) {
                    tab.sidebarSelection = .all
                }
            }
        )
    }

    private var frameworkBinding: Binding<String> {
        Binding(
            get: { tab.criteria.framework ?? "" },
            set: { tab.criteria.framework = $0.isEmpty ? nil : $0 }
        )
    }

    private func platformBinding(_ platform: ApplePlatform) -> Binding<Bool> {
        Binding(
            get: { tab.criteria.platforms.contains(platform) },
            set: { include in
                if include {
                    tab.criteria.platforms.insert(platform)
                } else {
                    tab.criteria.platforms.remove(platform)
                }
            }
        )
    }

    /// Binding for one year bound; nudges the other bound so the range
    /// never inverts (From > To).
    private func yearBinding(
        _ keyPath: WritableKeyPath<FilterCriteria, Int?>,
        counterpart: WritableKeyPath<FilterCriteria, Int?>,
        keepBelow: Bool
    ) -> Binding<Int> {
        Binding(
            get: { tab.criteria[keyPath: keyPath] ?? 0 },
            set: { year in
                tab.criteria[keyPath: keyPath] = year == 0 ? nil : year
                guard year != 0, let other = tab.criteria[keyPath: counterpart] else {
                    return
                }
                if keepBelow ? year > other : year < other {
                    tab.criteria[keyPath: counterpart] = year
                }
            }
        )
    }
}
