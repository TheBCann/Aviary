//
//  TabStripView.swift
//  Swift-UI-Companion
//
//  Workspace tabs: each has its own filter, search, and selection.
//

import SwiftUI

struct TabStripView: View {
    @Environment(AppModel.self) private var model

    var body: some View {
        HStack(spacing: 4) {
            ForEach(model.tabs) { tab in
                TabChip(tab: tab, isActive: tab.id == model.activeTabID)
            }

            Button {
                model.addTab()
            } label: {
                Image(systemName: "plus")
            }
            .buttonStyle(.borderless)
            .help("New tab with its own filter")

            Spacer()
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(Theme.Surface.bar)
    }
}

struct TabChip: View {
    @Environment(AppModel.self) private var model
    let tab: WorkspaceTab
    let isActive: Bool

    var body: some View {
        HStack(spacing: 6) {
            if tab.criteria.isActive {
                Image(systemName: "line.3.horizontal.decrease")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            Text(tab.title)
                .font(.callout)

            if model.tabs.count > 1 {
                Button {
                    model.close(tab)
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 8, weight: .bold))
                }
                .buttonStyle(.borderless)
                .help("Close tab")
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(
            isActive ? Color.accentColor.opacity(0.18) : .clear,
            in: .rect(cornerRadius: 6)
        )
        .contentShape(.rect)
        .onTapGesture {
            model.activeTabID = tab.id
        }
    }
}
