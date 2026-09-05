//
//  MenuBarSearchView.swift
//  Aviary
//
//  Quick search from the system menu bar: pick a result to jump the main
//  window straight to that topic.
//

import SwiftUI
import AppKit

struct MenuBarSearchView: View {
    @Environment(AppModel.self) private var model
    @Environment(\.openWindow) private var openWindow
    @State private var query = ""

    private struct Result: Identifiable {
        let id: String
        let title: String
        let kind: TopicKind
        let detail: String
        let isChild: Bool
    }

    private var results: [Result] {
        if query.isEmpty {
            return model.topics.prefix(12).map {
                Result(id: $0.id, title: $0.name, kind: $0.kind,
                       detail: $0.kind.rawValue, isChild: false)
            }
        }
        var matches: [Result] = []
        for topic in model.topics {
            if topic.name.localizedCaseInsensitiveContains(query)
                || topic.summary.localizedCaseInsensitiveContains(query) {
                matches.append(Result(id: topic.id, title: topic.name,
                                      kind: topic.kind,
                                      detail: topic.kind.rawValue,
                                      isChild: false))
            }
            for child in topic.children
            where child.name.localizedCaseInsensitiveContains(query) {
                matches.append(Result(id: child.id, title: child.name,
                                      kind: topic.kind, detail: topic.name,
                                      isChild: true))
            }
            if matches.count >= 12 { break }
        }
        return Array(matches.prefix(12))
    }

    var body: some View {
        VStack(spacing: 0) {
            TextField("Search SwiftUI APIs", text: $query)
                .textFieldStyle(.roundedBorder)
                .padding(10)

            Divider()

            if results.isEmpty {
                ContentUnavailableView.search(text: query)
                    .frame(height: 140)
            } else {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 2) {
                        ForEach(results) { result in
                            Button {
                                open(result)
                            } label: {
                                HStack(spacing: 8) {
                                    Image(systemName: result.isChild
                                          ? "arrow.turn.down.right"
                                          : result.kind.symbolName)
                                        .foregroundStyle(result.isChild
                                                         ? AnyShapeStyle(.tertiary)
                                                         : AnyShapeStyle(result.kind.tint))
                                        .frame(width: 16)
                                    Text(result.title)
                                        .font(.system(.body, design: .monospaced))
                                        .lineLimit(1)
                                        .truncationMode(.middle)
                                    Spacer()
                                    Text(result.detail)
                                        .font(.caption2)
                                        .foregroundStyle(.tertiary)
                                }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 5)
                                .contentShape(.rect)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(6)
                }
                .frame(maxHeight: 320)
            }
        }
        .frame(width: 320)
    }

    private func open(_ result: Result) {
        if result.isChild {
            model.reveal(childID: result.id)
        } else if let topic = model.topic(withID: result.id) {
            model.reveal(topic)
        }
        openWindow(id: "main")
        NSApp.activate(ignoringOtherApps: true)
    }
}
