//
//  ExampleRegistry.swift
//  Swift-UI-Companion
//
//  Aggregates every domain's rendered examples. Each Examples+*.swift file
//  contributes one static `entries` array; adding examples never touches
//  this file.
//

import SwiftUI

enum ExampleRegistry {
    static let all: [String: ExampleEntry] = {
        let groups: [[ExampleEntry]] = [
            ExamplesViews.entries,
            ExamplesModifiers.entries,
            ExamplesShapes.entries,
            ExamplesProtocols.entries,
            ExamplesScenes.entries,
            ExamplesStyles.entries,
            ExamplesPropertyWrappers.entries,
            ExamplesEnvironmentValues.entries,
            ExamplesLayout.entries,
            ExamplesText.entries,
            ExamplesControls.entries,
            ExamplesLists.entries,
            ExamplesNavPres.entries,
            ExamplesDrawing.entries,
            ExamplesAnimation.entries,
            ExamplesData.entries,
            ExamplesEnvValues2.entries,
            ExamplesAppScenes.entries,
            ExamplesSystem.entries,
            ExamplesAccessibility.entries,
        ]
        var map: [String: ExampleEntry] = [:]
        for group in groups {
            for entry in group {
                map[entry.topic] = entry
            }
        }
        return map
    }()

    static func entry(for topic: String) -> ExampleEntry? {
        all[topic]
    }

    /// Topic names that have a rendered example (for coverage tests).
    static var coveredTopics: Set<String> { Set(all.keys) }
}
