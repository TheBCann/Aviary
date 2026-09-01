//
//  FilteringTests.swift
//  Swift-UI-CompanionTests
//

import Testing
@testable import Swift_UI_Companion

struct FilteringTests {
    private func makeTopic(
        name: String = "Sample",
        kind: TopicKind = .view,
        platforms: Set<ApplePlatform> = Set(ApplePlatform.allCases),
        framework: String = "SwiftUI",
        year: Int = 2019
    ) -> Topic {
        Topic(
            name: name,
            kind: kind,
            summary: "s",
            discussion: "d",
            wwdcYear: year,
            platforms: platforms,
            framework: framework,
            code: "c"
        )
    }

    @Test func emptyCriteriaMatchesEverything() {
        let criteria = FilterCriteria()
        #expect(!criteria.isActive)
        #expect(criteria.matches(makeTopic()))
        #expect(criteria.matches(makeTopic(kind: .modifier, platforms: [.watchOS], year: 2025)))
    }

    @Test func kindFilterExcludesOtherKinds() {
        var criteria = FilterCriteria()
        criteria.kinds = [.shape, .style]
        #expect(criteria.matches(makeTopic(kind: .shape)))
        #expect(!criteria.matches(makeTopic(kind: .view)))
    }

    @Test func platformFilterUsesIntersection() {
        var criteria = FilterCriteria()
        criteria.platforms = [.macOS]
        #expect(criteria.matches(makeTopic(platforms: [.iOS, .macOS])))
        #expect(!criteria.matches(makeTopic(platforms: [.iOS, .watchOS])))
    }

    @Test func yearBoundsAreInclusive() {
        var criteria = FilterCriteria()
        criteria.minYear = 2022
        criteria.maxYear = 2023
        #expect(criteria.matches(makeTopic(year: 2022)))
        #expect(criteria.matches(makeTopic(year: 2023)))
        #expect(!criteria.matches(makeTopic(year: 2021)))
        #expect(!criteria.matches(makeTopic(year: 2024)))
    }

    @Test func frameworkFilterIsExact() {
        var criteria = FilterCriteria()
        criteria.framework = "MapKit"
        #expect(criteria.matches(makeTopic(framework: "MapKit")))
        #expect(!criteria.matches(makeTopic()))
    }

    @Test func summaryLabelDescribesActiveParts() {
        var criteria = FilterCriteria()
        #expect(criteria.summaryLabel == "All APIs")

        criteria.kinds = [.view]
        criteria.platforms = [.iOS, .macOS]
        criteria.minYear = 2023
        #expect(criteria.summaryLabel == "Views · iOS+macOS · '23+")

        criteria.kinds = []
        criteria.minYear = 2024
        criteria.maxYear = 2024
        criteria.platforms = []
        #expect(criteria.summaryLabel == "WWDC '24")
    }
}
