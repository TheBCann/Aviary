//
//  AvailabilityTests.swift
//  AviaryTests
//
//  Version derivation from WWDC years, and the Codable round trip.
//

import Foundation
import Testing
@testable import Aviary

struct AvailabilityTests {
    private func makeTopic(year: Int, platforms: Set<ApplePlatform>) -> Topic {
        Topic(
            name: "Sample",
            kind: .view,
            summary: "s",
            discussion: "d",
            wwdcYear: year,
            platforms: platforms,
            code: "c"
        )
    }

    @Test func versionsDeriveFromTheWWDCYear() {
        let topic = makeTopic(year: 2022, platforms: [.iOS, .macOS])
        #expect(topic.introducedVersion(on: .iOS) == "16.0")
        #expect(topic.introducedVersion(on: .macOS) == "13.0")
    }

    @Test func excludedPlatformsHaveNoVersion() {
        let topic = makeTopic(year: 2022, platforms: [.iOS])
        #expect(topic.introducedVersion(on: .tvOS) == nil)
    }

    @Test func wwdc25UnifiedEverythingOnVersion26() {
        let topic = makeTopic(year: 2025, platforms: Set(ApplePlatform.allCases))
        for platform in ApplePlatform.allCases {
            #expect(topic.introducedVersion(on: platform) == "26.0")
        }
    }

    @Test func compactVersionsTrimTrailingZero() {
        let modern = makeTopic(year: 2020, platforms: [.iOS, .macOS])
        #expect(modern.compactIntroducedVersion(on: .iOS) == "14")

        let original = makeTopic(year: 2019, platforms: [.macOS])
        #expect(original.compactIntroducedVersion(on: .macOS) == "10.15")
    }

    @Test func codableRoundTripPreservesTheTopic() throws {
        let child = TopicChild(name: "Sample(_:)", summary: "cs", code: "cc")
        let original = Topic(
            name: "Sample",
            kind: .modifier,
            summary: "s",
            discussion: "d",
            wwdcYear: 2023,
            platforms: [.iOS, .watchOS],
            framework: "MapKit",
            deprecated: true,
            code: "c",
            demoID: "sample",
            related: ["Other"],
            children: [child]
        )

        let data = try JSONEncoder().encode([original])
        let decoded = try JSONDecoder().decode([Topic].self, from: data)

        #expect(decoded == [original])
        #expect(decoded[0].children[0].id == original.children[0].id)
    }

    @Test func decodingFillsOmittedDefaults() throws {
        let json = Data("""
        [{
            "name": "Bare",
            "kind": "View",
            "summary": "s",
            "discussion": "d",
            "wwdcYear": 2019,
            "code": "c"
        }]
        """.utf8)

        let decoded = try JSONDecoder().decode([Topic].self, from: json)
        #expect(decoded[0].platforms == Set(ApplePlatform.allCases))
        #expect(decoded[0].framework == "SwiftUI")
        #expect(decoded[0].deprecated == false)
        #expect(decoded[0].related.isEmpty)
        #expect(decoded[0].children.isEmpty)
    }
}
