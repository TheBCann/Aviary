//
//  Catalog.swift
//  Aviary
//
//  The catalog is data, not code: entries live in the bundled
//  CatalogData/*.json files and decode into Topic at launch. Adding or
//  editing an entry is a JSON edit — no recompilation.
//

import Foundation

enum Catalog {
    static let all: [Topic] = load()

    private static func load() -> [Topic] {
        let urls = jsonURLs()
        precondition(!urls.isEmpty, "No JSON resources found in the app bundle")

        let decoder = JSONDecoder()
        var topics: [Topic] = []
        for url in urls {
            guard let data = try? Data(contentsOf: url) else { continue }

            // A catalog file is a top-level JSON array. Other bundled JSON
            // (editor caches, tool reports) is a dictionary — skip it rather
            // than crashing, but a genuinely malformed catalog array still
            // fails loudly.
            let top = try? JSONSerialization.jsonObject(with: data)
            guard top is [Any] else { continue }

            do {
                topics += try decoder.decode([Topic].self, from: data)
            } catch {
                fatalError("Corrupt catalog file \(url.lastPathComponent): \(error)")
            }
        }

        precondition(!topics.isEmpty, "Catalog JSON files are missing from the app bundle")
        return topics
    }

    private static func jsonURLs() -> [URL] {
        let bundle = Bundle.main
        // Xcode may bundle the folder as a subdirectory or flatten it into
        // Resources; accept either.
        if let urls = bundle.urls(forResourcesWithExtension: "json", subdirectory: "CatalogData"),
           !urls.isEmpty {
            return urls
        }
        return bundle.urls(forResourcesWithExtension: "json", subdirectory: nil) ?? []
    }
}
