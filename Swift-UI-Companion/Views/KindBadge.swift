//
//  KindBadge.swift
//  Swift-UI-Companion
//
//  A colored rounded-square symbol badge in the style of Xcode's
//  documentation navigator: a one- or two-letter code on the kind's tint.
//

import SwiftUI

struct KindBadge: View {
    let kind: TopicKind
    var size: CGFloat = 18

    var body: some View {
        Text(kind.badgeCode)
            .font(.system(size: size * (kind.badgeCode.count > 1 ? 0.44 : 0.54),
                          weight: .bold, design: .rounded))
            .foregroundStyle(.white)
            .frame(width: size, height: size)
            .background(kind.tint.gradient, in: .rect(cornerRadius: size * 0.28))
            .accessibilityLabel(kind.rawValue)
    }
}
