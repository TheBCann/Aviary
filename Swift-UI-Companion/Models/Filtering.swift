//
//  Filtering.swift
//  Swift-UI-Companion
//

import Foundation

/// A sidebar row: the whole catalog or a single API kind.
enum SidebarItem: Hashable {
    case all
    case kind(TopicKind)
}

/// The per-tab filter over the catalog. Empty sets and nil years mean
/// "no restriction". Year bounds express use cases like "only WWDC '23
/// and later" (new additions) or "nothing past '21" (a legacy project).
struct FilterCriteria: Hashable {
    var kinds: Set<TopicKind> = []
    var platforms: Set<ApplePlatform> = []
    var minYear: Int? = nil
    var maxYear: Int? = nil
    var framework: String? = nil

    /// The WWDC years the catalog spans.
    static let yearSpan = 2019...2025

    var isActive: Bool {
        !kinds.isEmpty || !platforms.isEmpty || minYear != nil || maxYear != nil
            || framework != nil
    }

    func matches(_ topic: Topic) -> Bool {
        if !kinds.isEmpty, !kinds.contains(topic.kind) {
            return false
        }
        if !platforms.isEmpty, platforms.isDisjoint(with: topic.platforms) {
            return false
        }
        if let minYear, topic.wwdcYear < minYear {
            return false
        }
        if let maxYear, topic.wwdcYear > maxYear {
            return false
        }
        if let framework, topic.framework != framework {
            return false
        }
        return true
    }

    /// Short label describing the active filter, used as the tab title.
    var summaryLabel: String {
        var parts: [String] = []

        if kinds.count == 1, let kind = kinds.first {
            parts.append(kind.pluralTitle)
        } else if kinds.count > 1 {
            parts.append("\(kinds.count) areas")
        }

        if !platforms.isEmpty {
            parts.append(
                ApplePlatform.allCases
                    .filter(platforms.contains)
                    .map(\.rawValue)
                    .joined(separator: "+")
            )
        }

        if let framework {
            parts.append(framework)
        }

        switch (minYear, maxYear) {
        case (nil, nil):
            break
        case (let min?, nil):
            parts.append("'\(min % 100)+")
        case (nil, let max?):
            parts.append("≤'\(max % 100)")
        case (let min?, let max?):
            parts.append(
                min == max
                    ? "WWDC '\(min % 100)"
                    : "'\(min % 100)–'\(max % 100)"
            )
        }

        return parts.isEmpty ? "All APIs" : parts.joined(separator: " · ")
    }
}
