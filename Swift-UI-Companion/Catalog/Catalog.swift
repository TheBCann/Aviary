//
//  Catalog.swift
//  Swift-UI-Companion
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
        precondition(!urls.isEmpty, "Catalog JSON files are missing from the app bundle")

        let decoder = JSONDecoder()
        return urls.flatMap { url in
            do {
                return try decoder.decode([Topic].self, from: Data(contentsOf: url))
            } catch {
                fatalError("Corrupt catalog file \(url.lastPathComponent): \(error)")
            }
        }
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
