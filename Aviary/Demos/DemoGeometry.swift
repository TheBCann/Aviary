//
//  DemoGeometry.swift
//  Aviary
//
//  Shared geometry helpers for the draggable flagship demos: named
//  UnitPoint snapping, code formatting, and the standard drag handle.
//

import SwiftUI

let namedUnitPoints: [(name: String, point: CGPoint)] = [
    ("topLeading", CGPoint(x: 0, y: 0)), ("top", CGPoint(x: 0.5, y: 0)),
    ("topTrailing", CGPoint(x: 1, y: 0)), ("leading", CGPoint(x: 0, y: 0.5)),
    ("center", CGPoint(x: 0.5, y: 0.5)), ("trailing", CGPoint(x: 1, y: 0.5)),
    ("bottomLeading", CGPoint(x: 0, y: 1)), ("bottom", CGPoint(x: 0.5, y: 1)),
    ("bottomTrailing", CGPoint(x: 1, y: 1)),
]

/// Snaps a unit point to the nearest named anchor when close enough.
func snapped(_ point: CGPoint) -> CGPoint {
    for named in namedUnitPoints
    where abs(named.point.x - point.x) < 0.06 && abs(named.point.y - point.y) < 0.06 {
        return named.point
    }
    return point
}

/// ".topLeading" for named anchors, "UnitPoint(x:y:)" otherwise.
func unitPointCode(_ point: CGPoint) -> String {
    for named in namedUnitPoints
    where named.point.x == point.x && named.point.y == point.y {
        return ".\(named.name)"
    }
    return "UnitPoint(x: \(codeNumber(Double(point.x))), y: \(codeNumber(Double(point.y))))"
}

/// The standard draggable dot. `update` receives the location normalized
/// to `size` (0...1 on both axes).
func dragHandle(
    at location: CGPoint,
    color: Color,
    size: CGSize,
    update: @escaping (CGPoint) -> Void,
    onEnded: @escaping () -> Void = {}
) -> some View {
    Circle()
        .fill(color)
        .frame(width: 16, height: 16)
        .overlay { Circle().strokeBorder(.white, lineWidth: 2) }
        .shadow(radius: 2)
        .position(location)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    guard size.width > 0, size.height > 0 else { return }
                    update(CGPoint(
                        x: min(max(value.location.x / size.width, 0), 1),
                        y: min(max(value.location.y / size.height, 0), 1)
                    ))
                }
                .onEnded { _ in onEnded() }
        )
}

/// A drag handle reporting raw view-space locations, for demos whose
/// parameters aren't unit-normalized (angles, radii, offsets).
func rawDragHandle(
    at location: CGPoint,
    color: Color,
    systemImage: String? = nil,
    update: @escaping (CGPoint) -> Void
) -> some View {
    ZStack {
        Circle()
            .fill(color)
            .frame(width: systemImage == nil ? 16 : 26, height: systemImage == nil ? 16 : 26)
            .overlay { Circle().strokeBorder(.white, lineWidth: 2) }
            .shadow(radius: 2)
        if let systemImage {
            Image(systemName: systemImage)
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(.white)
        }
    }
    .position(location)
    .gesture(
        DragGesture(minimumDistance: 0)
            .onChanged { update($0.location) }
    )
}
