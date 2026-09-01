//
//  Theme.swift
//  Swift-UI-Companion
//
//  The app's palette: a Swift-orange accent, one harmonized hue per API
//  kind and platform, and an always-dark editor-style code panel.
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

extension Color {
    /// Creates a color from a 24-bit sRGB hex value, e.g. 0xF05138.
    init(hex: UInt32) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255
        )
    }
}

enum Theme {
    static let accent = Color(hex: 0xF05138)

    // One hue per API kind.
    static let viewTint = Color(hex: 0x3E8BFF)
    static let modifierTint = Color(hex: 0x8B5CF6)
    static let shapeTint = Color(hex: 0xF59E0B)
    static let protocolTint = Color(hex: 0x14B8A6)
    static let sceneTint = Color(hex: 0x6366F1)
    static let styleTint = Color(hex: 0xEC4899)
    static let wrapperTint = Color(hex: 0x22C55E)
    static let environmentTint = Color(hex: 0x06B6D4)

    // Platform chips.
    static let iOSTint = Color(hex: 0x3E8BFF)
    static let macOSTint = Color(hex: 0x8B5CF6)
    static let tvOSTint = Color(hex: 0xF59E0B)
    static let watchOSTint = Color(hex: 0xEF4444)

    /// Availability badges ("iOS 13.0+").
    static let availableTint = Color(hex: 0x30B252)

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

    /// The code panel renders dark in both appearances, like the embedded
    /// editors on documentation sites, so these are fixed colors.
    enum Code {
        static let background = Color(hex: 0x1E222A)
        static let border = Color.white.opacity(0.08)
        static let plain = Color(hex: 0xDCE0E8)
        static let keyword = Color(hex: 0xFF7AB2)
        static let string = Color(hex: 0xFF8170)
        static let number = Color(hex: 0xD0BF69)
        static let type = Color(hex: 0x6BDFFF)
        static let dotAccess = Color(hex: 0xB281EB)
        static let attribute = Color(hex: 0xFFA14F)
        static let comment = Color(hex: 0x7F8C98)
    }
}
