//
//  QuickOpenView.swift
//  Aviary
//
//  The ⌘K command palette: type-ahead search over every entry and child,
//  arrow keys to choose, Return to jump, Escape to dismiss.
//

import SwiftUI

/// Full-window dimming layer hosting the palette.
struct QuickOpenOverlay: View {
    @Environment(AppModel.self) private var model

    var body: some View {
        ZStack(alignment: .top) {
            Color.black.opacity(0.25)
                .ignoresSafeArea()
                .onTapGesture { model.isQuickOpenPresented = false }

            QuickOpenPanel()
                .padding(.top, 80)
        }
    }
}

struct QuickOpenPanel: View {
    @Environment(AppModel.self) private var model
    @State private var query = ""
    @State private var selectedIndex = 0
    @FocusState private var isFocused: Bool

    private struct Result: Identifiable {
        let id: String
        let title: String
        let detail: String
        let kind: TopicKind
        let isChild: Bool
        let score: Int
    }

    private var results: [Result] {
        if query.isEmpty {
            return model.topics.prefix(8).map {
                Result(id: $0.id, title: $0.name, detail: $0.kind.rawValue,
                       kind: $0.kind, isChild: false, score: 0)
            }
        }

        let q = query.lowercased()

        // 0 = name prefix (ignoring leading . or @), 1 = name contains,
        // 3 = summary contains; children rank one step below their parents.
        func score(name: String, summary: String) -> Int? {
            let n = name.lowercased()
            if n.hasPrefix(q) || n.drop(while: { $0 == "." || $0 == "@" }).hasPrefix(q) {
                return 0
            }
            if n.contains(q) { return 1 }
            if summary.lowercased().contains(q) { return 3 }
            return nil
        }

        var matches: [Result] = []
        for topic in model.topics {
            if let s = score(name: topic.name, summary: topic.summary) {
                matches.append(Result(id: topic.id, title: topic.name,
                                      detail: topic.kind.rawValue,
                                      kind: topic.kind, isChild: false, score: s))
            }
            for child in topic.children {
                if let s = score(name: child.name, summary: child.summary) {
                    matches.append(Result(id: child.id, title: child.name,
                                          detail: topic.name,
                                          kind: topic.kind, isChild: true,
                                          score: s + 1))
                }
            }
        }
        return Array(
            matches
                .sorted {
                    ($0.score, $0.title.lowercased()) < ($1.score, $1.title.lowercased())
                }
                .prefix(20)
        )
    }

    var body: some View {
        let results = self.results

        VStack(spacing: 0) {
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)
                TextField("Jump to any API…", text: $query)
                    .textFieldStyle(.plain)
                    .font(.title3)
                    .focused($isFocused)
                    .onSubmit { openSelected(in: results) }
            }
            .padding(14)

            Divider()

            if results.isEmpty {
                Text("No matches")
                    .foregroundStyle(.secondary)
                    .padding(24)
            } else {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 2) {
                            ForEach(Array(results.enumerated()), id: \.element.id) { index, result in
                                row(result, isSelected: index == selectedIndex)
                                    .id(index)
                                    .onTapGesture { open(result) }
                            }
                        }
                        .padding(6)
                    }
                    .frame(maxHeight: 320)
                    .onChange(of: selectedIndex) {
                        proxy.scrollTo(selectedIndex)
                    }
                }
            }
        }
        .frame(width: 560)
        .background(.regularMaterial, in: .rect(cornerRadius: 14))
        .overlay {
            RoundedRectangle(cornerRadius: 14)
                .strokeBorder(.quaternary, lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.3), radius: 28, y: 10)
        .onKeyPress(.downArrow) { move(1, in: results); return .handled }
        .onKeyPress(.upArrow) { move(-1, in: results); return .handled }
        .onKeyPress(.escape) { dismiss(); return .handled }
        .onMoveCommand { direction in
            if direction == .down { move(1, in: results) }
            if direction == .up { move(-1, in: results) }
        }
        .onExitCommand { dismiss() }
        .onAppear { isFocused = true }
        .onChange(of: query) { selectedIndex = 0 }
    }

    private func row(_ result: Result, isSelected: Bool) -> some View {
        HStack(spacing: 10) {
            Image(systemName: result.isChild ? "arrow.turn.down.right" : result.kind.symbolName)
                .foregroundStyle(result.isChild ? AnyShapeStyle(.tertiary) : AnyShapeStyle(result.kind.tint))
                .frame(width: 18)
            Text(result.title)
                .font(.system(.body, design: .monospaced))
                .lineLimit(1)
                .truncationMode(.middle)
            Spacer()
            Text(result.detail)
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 7)
        .background(
            isSelected ? Color.accentColor.opacity(0.22) : .clear,
            in: .rect(cornerRadius: 7)
        )
        .contentShape(.rect)
    }

    private func move(_ delta: Int, in results: [Result]) {
        guard !results.isEmpty else { return }
        selectedIndex = min(max(selectedIndex + delta, 0), results.count - 1)
    }

    private func openSelected(in results: [Result]) {
        guard results.indices.contains(selectedIndex) else { return }
        open(results[selectedIndex])
    }

    private func open(_ result: Result) {
        if result.isChild {
            model.reveal(childID: result.id)
        } else if let topic = model.topic(withID: result.id) {
            model.reveal(topic)
        }
        dismiss()
    }

    private func dismiss() {
        model.isQuickOpenPresented = false
    }
}
