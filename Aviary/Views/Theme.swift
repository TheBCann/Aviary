//
//  Theme.swift
//  Aviary
//
//  Adaptive surface colors for the window chrome, plus the user's
//  appearance override. Widget and content colors use system defaults.
//

import SwiftUI
import AppKit

extension NSColor {
    convenience init(hex: UInt32) {
        self.init(
            srgbRed: CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >> 8) & 0xFF) / 255,
            blue: CGFloat(hex & 0xFF) / 255,
            alpha: 1
        )
    }

    /// A color that resolves per-appearance, so themed surfaces adapt to
    /// light and dark mode without environment plumbing.
    static func dynamic(light: UInt32, dark: UInt32) -> NSColor {
        NSColor(name: nil) { appearance in
            let isDark = appearance.bestMatch(from: [.aqua, .darkAqua]) == .darkAqua
            return NSColor(hex: isDark ? dark : light)
        }
    }
}

enum Theme {
    /// The window's chrome: warm paper tones in light mode, deep slate in
    /// dark mode, stepped so sidebar < tab bar < window < list column.
    enum Surface {
        /// Detail pane and the window's base coat.
        static let window = Color(nsColor: .dynamic(light: 0xF4F2EE, dark: 0x161A22))
        /// The topic list column, slightly raised off the base.
        static let raised = Color(nsColor: .dynamic(light: 0xFBFAF8, dark: 0x1C212B))
        /// The sidebar column, the deepest surface.
        static let sidebar = Color(nsColor: .dynamic(light: 0xEBE8E1, dark: 0x121620))
        /// The workspace tab strip.
        static let bar = Color(nsColor: .dynamic(light: 0xE7E3DB, dark: 0x0F131B))
    }
}

/// The user's in-app appearance override, persisted via @AppStorage.
enum AppearanceSetting: String, CaseIterable, Identifiable {
    case system, light, dark

    static let storageKey = "appearance"

    var id: String { rawValue }

    var title: String {
        switch self {
        case .system: "System"
        case .light: "Light"
        case .dark: "Dark"
        }
    }

    var symbolName: String {
        switch self {
        case .system: "circle.lefthalf.filled"
        case .light: "sun.max"
        case .dark: "moon"
        }
    }

    /// nil follows the system appearance.
    var colorScheme: ColorScheme? {
        switch self {
        case .system: nil
        case .light: .light
        case .dark: .dark
        }
    }
}
