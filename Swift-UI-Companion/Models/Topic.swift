//
//  Topic.swift
//  Swift-UI-Companion
//

import SwiftUI

/// A platform a catalog entry can be available on.
enum ApplePlatform: String, CaseIterable, Identifiable, Hashable {
    case iOS = "iOS"
    case macOS = "macOS"
    case tvOS = "tvOS"
    case watchOS = "watchOS"

    var id: String { rawValue }

    var symbolName: String {
        switch self {
        case .iOS: "iphone"
        case .macOS: "macbook"
        case .tvOS: "appletv"
        case .watchOS: "applewatch"
        }
    }

    /// Single-letter abbreviation used by the compact version chips.
    var shortLetter: String {
        switch self {
        case .iOS: "i"
        case .macOS: "m"
        case .tvOS: "t"
        case .watchOS: "w"
        }
    }

    var tint: Color {
        switch self {
        case .iOS: .blue
        case .macOS: .purple
        case .tvOS: .orange
        case .watchOS: .red
        }
    }
}

/// The kind of API a catalog entry documents.
enum TopicKind: String, CaseIterable, Identifiable, Hashable {
    case view = "View"
    case modifier = "Modifier"
    case shape = "Shape"
    case protocolItem = "Protocol"
    case scene = "Scene"
    case style = "Style"
    case propertyWrapper = "Property Wrapper"
    case environmentValue = "Environment Value"

    var id: String { rawValue }

    var pluralTitle: String {
        switch self {
        case .view: "Views"
        case .modifier: "Modifiers"
        case .shape: "Shapes"
        case .protocolItem: "Protocols"
        case .scene: "Scenes"
        case .style: "Styles"
        case .propertyWrapper: "Property Wrappers"
        case .environmentValue: "Environment Values"
        }
    }

    var symbolName: String {
        switch self {
        case .view: "rectangle.on.rectangle"
        case .modifier: "slider.horizontal.3"
        case .shape: "circle.square"
        case .protocolItem: "puzzlepiece.extension"
        case .scene: "macwindow"
        case .style: "paintbrush"
        case .propertyWrapper: "at"
        case .environmentValue: "leaf"
        }
    }

    var tint: Color {
        switch self {
        case .view: .blue
        case .modifier: .purple
        case .shape: .orange
        case .protocolItem: .teal
        case .scene: .indigo
        case .style: .pink
        case .propertyWrapper: .green
        case .environmentValue: .mint
        }
    }
}

/// A sub-entry of a Topic: one initializer, method overload, or nested type
/// (e.g. `SpriteView(scene:options:)` or `SpriteView.Options`).
struct TopicChild: Identifiable, Hashable {
    let name: String
    let summary: String
    let discussion: String
    let code: String
    /// Set by Topic.init so ids stay unique across parents.
    fileprivate(set) var parentID: String = ""

    var id: String { "\(parentID) › \(name)" }

    init(name: String, summary: String, discussion: String = "", code: String) {
        self.name = name
        self.summary = summary
        self.discussion = discussion
        self.code = code
    }
}

/// One documented SwiftUI API in the catalog.
struct Topic: Identifiable, Hashable {
    let id: String
    let name: String
    let kind: TopicKind
    let summary: String
    let discussion: String
    let code: String
    let platforms: Set<ApplePlatform>
    let wwdcYear: Int
    let framework: String
    let deprecated: Bool
    let demoID: String?
    let related: [String]
    let children: [TopicChild]

    init(
        name: String,
        kind: TopicKind,
        summary: String,
        discussion: String,
        wwdcYear: Int,
        platforms: Set<ApplePlatform> = Set(ApplePlatform.allCases),
        framework: String = "SwiftUI",
        deprecated: Bool = false,
        code: String,
        demoID: String? = nil,
        related: [String] = [],
        children: [TopicChild] = []
    ) {
        self.id = name
        self.name = name
        self.kind = kind
        self.summary = summary
        self.discussion = discussion
        self.wwdcYear = wwdcYear
        self.platforms = platforms
        self.framework = framework
        self.deprecated = deprecated
        self.code = code
        self.demoID = demoID
        self.related = related
        self.children = children.map { child in
            var qualified = child
            qualified.parentID = name
            return qualified
        }
    }

    /// OS versions announced at each WWDC, used to derive availability badges.
    private static let versionTable: [Int: [ApplePlatform: String]] = [
        2019: [.iOS: "13.0", .macOS: "10.15", .tvOS: "13.0", .watchOS: "6.0"],
        2020: [.iOS: "14.0", .macOS: "11.0", .tvOS: "14.0", .watchOS: "7.0"],
        2021: [.iOS: "15.0", .macOS: "12.0", .tvOS: "15.0", .watchOS: "8.0"],
        2022: [.iOS: "16.0", .macOS: "13.0", .tvOS: "16.0", .watchOS: "9.0"],
        2023: [.iOS: "17.0", .macOS: "14.0", .tvOS: "17.0", .watchOS: "10.0"],
        2024: [.iOS: "18.0", .macOS: "15.0", .tvOS: "18.0", .watchOS: "11.0"],
        // WWDC '25 unified every OS on version 26.
        2025: [.iOS: "26.0", .macOS: "26.0", .tvOS: "26.0", .watchOS: "26.0"],
    ]

    /// The OS version this API first shipped in on `platform`, or nil when the
    /// API is unavailable there.
    func introducedVersion(on platform: ApplePlatform) -> String? {
        guard platforms.contains(platform) else { return nil }
        return Self.versionTable[wwdcYear]?[platform]
    }

    /// Introduced version with a trailing ".0" trimmed, for compact chips
    /// like "i13" or "m10.15".
    func compactIntroducedVersion(on platform: ApplePlatform) -> String? {
        guard let version = introducedVersion(on: platform) else { return nil }
        return version.hasSuffix(".0") ? String(version.dropLast(2)) : version
    }

    /// Platforms this topic supports, in canonical display order.
    var orderedPlatforms: [ApplePlatform] {
        ApplePlatform.allCases.filter(platforms.contains)
    }
}
