//
//  CatalogIntegrityTests.swift
//  Swift-UI-CompanionTests
//
//  Validates the bundled JSON catalog as a whole — the compile-time
//  checking we gave up by moving entries out of Swift source.
//

import Testing
@testable import Swift_UI_Companion

struct CatalogIntegrityTests {
    let topics = Catalog.all

    @Test func catalogDecodesAndIsComplete() {
        #expect(topics.count >= 269)
    }

    @Test func everyKindIsRepresented() {
        let kinds = Set(topics.map(\.kind))
        #expect(kinds == Set(TopicKind.allCases))
    }

    @Test func topicIDsAreUnique() {
        let ids = topics.map(\.id)
        #expect(Set(ids).count == ids.count)
    }

    @Test func childIDsAreUniqueAndQualified() {
        let children = topics.flatMap(\.children)
        let ids = children.map(\.id)
        #expect(Set(ids).count == ids.count)
        // Decoding must have re-applied the parent qualifier.
        #expect(children.allSatisfy { $0.parentID.isEmpty == false })
    }

    @Test func everyDemoIDHasARegisteredDemo() {
        let unregistered = Set(
            topics.compactMap(\.demoID).filter { DemoRegistry.view(for: $0) == nil }
        )
        #expect(unregistered.isEmpty, "demoIDs with no demo: \(unregistered)")
    }

    @Test func availabilityResolvesForEveryDeclaredPlatform() {
        for topic in topics {
            for platform in topic.platforms {
                #expect(
                    topic.introducedVersion(on: platform) != nil,
                    "\(topic.name) has no version table entry for \(platform.rawValue) (year \(topic.wwdcYear))"
                )
            }
        }
    }

    @Test func wwdcYearsAreWithinTheSupportedSpan() {
        for topic in topics {
            #expect(
                FilterCriteria.yearSpan.contains(topic.wwdcYear),
                "\(topic.name): \(topic.wwdcYear)"
            )
        }
    }

    @Test func entriesHaveSubstantiveContent() {
        for topic in topics {
            #expect(!topic.summary.isEmpty, "\(topic.name)")
            #expect(!topic.discussion.isEmpty, "\(topic.name)")
            #expect(!topic.code.isEmpty, "\(topic.name)")
        }
    }

    /// Related links may intentionally dangle (the UI renders them as plain
    /// text), but the set should only shrink — additions belong in the
    /// catalog or should be renamed to an existing entry.
    @Test func danglingRelatedLinksDoNotGrow() {
        let ids = Set(topics.map(\.id))
        let dangling = Set(
            topics.flatMap { topic in
                topic.related.filter { !ids.contains($0) }
            }
        )
        #expect(
            dangling.count <= 12,
            "Dangling related links (\(dangling.count)): \(dangling.sorted())"
        )
    }
}

struct VisualizationCoverageTests {
    let topics = Catalog.all

    /// Every entry should render something: an interactive demo or a
    /// compiled usage example. Enabled once the example waves complete.
    @Test
    func everyTopicHasAVisualization() {
        let covered = ExampleRegistry.coveredTopics
        let missing = topics
            .filter { $0.demoID == nil && !covered.contains($0.name) }
            .map(\.name)
            .sorted()
        #expect(missing.isEmpty, "Topics without a visualization (\(missing.count)): \(missing.prefix(40))")
    }

    @Test func exampleTopicsResolveToCatalogEntries() {
        let names = Set(topics.map(\.name))
        let orphans = ExampleRegistry.coveredTopics.subtracting(names).sorted()
        #expect(orphans.isEmpty, "Examples registered for unknown topics: \(orphans)")
    }

    @Test func exampleCodeIsNonEmpty() {
        for entry in ExampleRegistry.all.values {
            #expect(!entry.code.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, "\(entry.topic)")
        }
    }
}
