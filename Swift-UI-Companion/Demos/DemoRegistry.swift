//
//  DemoRegistry.swift
//  Swift-UI-Companion
//
//  Maps a Topic's demoID to its interactive demo view.
//

import SwiftUI

enum DemoRegistry {
    static func view(for demoID: String?) -> AnyView? {
        guard let demoID else { return nil }
        switch demoID {
        case "button": return AnyView(ButtonDemo())
        case "toggle": return AnyView(ToggleDemo())
        case "picker": return AnyView(PickerDemo())
        case "text": return AnyView(TextDemo())
        case "slider": return AnyView(SliderDemo())
        case "progress": return AnyView(ProgressDemo())
        case "stacks": return AnyView(StacksDemo())
        case "gradient": return AnyView(GradientDemo())
        case "roundedRect": return AnyView(RoundedRectDemo())
        case "animation": return AnyView(AnimationDemo())
        case "effects": return AnyView(EffectsDemo())
        case "quadCurve": return AnyView(QuadCurveDemo())
        case "padding": return AnyView(PaddingDemo())
        case "frame": return AnyView(FrameDemo())
        case "lazyGrid": return AnyView(LazyGridDemo())
        case "grid": return AnyView(GridSpacingDemo())
        case "transform": return AnyView(TransformDemo())
        case "clipShape": return AnyView(ClipShapeDemo())
        case "mask": return AnyView(MaskDemo())
        case "arc": return AnyView(ArcDemo())
        case "cubicCurve": return AnyView(CubicCurveDemo())
        case "meshGradient": return AnyView(MeshGradientDemo())
        case "material": return AnyView(MaterialDemo())
        case "trimRing": return AnyView(TrimRingDemo())
        case "transition": return AnyView(TransitionDemo())
        case "contentTransition": return AnyView(ContentTransitionDemo())
        case "symbol": return AnyView(SymbolDemo())
        case "spring": return AnyView(SpringDemo())
        case "gauge": return AnyView(GaugeDemo())
        case "datePicker": return AnyView(DatePickerDemo())
        case "label": return AnyView(LabelStyleDemo())
        case "controlSize": return AnyView(ControlSizeDemo())
        default: return nil
        }
    }
}

/// Formats a Double for generated code snippets (trims trailing zeros).
func codeNumber(_ value: Double, decimals: Int = 2) -> String {
    let formatted = String(format: "%.\(decimals)f", value)
    guard formatted.contains(".") else { return formatted }
    var trimmed = formatted
    while trimmed.hasSuffix("0") { trimmed.removeLast() }
    if trimmed.hasSuffix(".") { trimmed.removeLast() }
    return trimmed
}
