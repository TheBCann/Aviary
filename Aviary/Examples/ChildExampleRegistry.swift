//
//  ChildExampleRegistry.swift
//  Aviary
//
//  Aggregates every part's compiled variant renderings. Each
//  ChildExamples+PartNN.swift contributes one static `entries` array;
//  adding renderings never touches this file.
//

import SwiftUI

enum ChildExampleRegistry {
    static let all: [String: ChildExampleEntry] = {
        let groups: [[ChildExampleEntry]] = [
            ChildExamplesPart01.entries,
            ChildExamplesPart02.entries,
            ChildExamplesPart03.entries,
            ChildExamplesPart04.entries,
            ChildExamplesPart05.entries,
            ChildExamplesPart06.entries,
            ChildExamplesPart07.entries,
            ChildExamplesPart08.entries,
            ChildExamplesPart09.entries,
            ChildExamplesPart10.entries,
            ChildExamplesPart11.entries,
            ChildExamplesPart12.entries,
            ChildExamplesPart13.entries,
            ChildExamplesPart14.entries,
            ChildExamplesPart15.entries,
            ChildExamplesPart16.entries,
            ChildExamplesPart17.entries,
            ChildExamplesPart18.entries,
            ChildExamplesPart19.entries,
            ChildExamplesPart20.entries,
            ChildExamplesPart21.entries,
            ChildExamplesPart22.entries,
            ChildExamplesPart23.entries,
            ChildExamplesPart24.entries,
        ]
        var map: [String: ChildExampleEntry] = [:]
        for group in groups {
            for entry in group {
                map[entry.id] = entry
            }
        }
        return map
    }()

    static func entry(for childID: String) -> ChildExampleEntry? {
        all[childID]
    }

    /// Child ids that have a compiled rendering (for coverage tests).
    static var coveredChildIDs: Set<String> { Set(all.keys) }
}
