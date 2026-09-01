//
//  Catalog.swift
//  Swift-UI-Companion
//
//  The seed catalog. Each kind lives in its own file as an extension on
//  Catalog; adding an entry is appending a Topic literal there.
//

import Foundation

enum Catalog {
    static let all: [Topic] =
        views
        + moreViews
        + frameworkViews
        + modifiers
        + interactionModifiers
        + visualModifiers
        + shapes
        + moreShapes
        + protocols
        + moreProtocols
        + scenes
        + moreScenes
        + styles
        + moreStyles
        + propertyWrappers
        + moreWrappers
        + environmentValues
        + moreEnvironmentValues
}
