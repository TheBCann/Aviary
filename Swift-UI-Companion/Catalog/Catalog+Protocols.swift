//
//  Catalog+Protocols.swift
//  Swift-UI-Companion
//

import Foundation

extension Catalog {
    static let protocols: [Topic] = [
        Topic(
            name: "View",
            kind: .protocolItem,
            summary: "The requirement every piece of SwiftUI UI conforms to.",
            discussion: "A View is a lightweight value describing what to display; its single requirement is the body property. SwiftUI recreates these values freely and diffs them, so keep them cheap — state lives in property wrappers, not in the struct's stored properties.",
            wwdcYear: 2019,
            code: #"""
            struct BadgeView: View {
                let count: Int

                var body: some View {
                    Text("\(count)")
                        .padding(6)
                        .background(.red, in: .circle)
                        .foregroundStyle(.white)
                }
            }
            """#,
            related: ["ViewModifier", "App", "@State"]
        ),
        Topic(
            name: "ViewModifier",
            kind: .protocolItem,
            summary: "A reusable transformation applied to any view.",
            discussion: "Conform to ViewModifier to bundle a set of modifiers — and any state they need — into one named unit, applied with the modifier function. Pair it with a View extension for a fluent call site.",
            wwdcYear: 2019,
            code: #"""
            struct CardStyle: ViewModifier {
                func body(content: Content) -> some View {
                    content
                        .padding()
                        .background(.background, in: .rect(cornerRadius: 12))
                        .shadow(radius: 4)
                }
            }

            extension View {
                func cardStyle() -> some View { modifier(CardStyle()) }
            }
            """#,
            related: ["View", ".padding()"]
        ),
        Topic(
            name: "Shape",
            kind: .protocolItem,
            summary: "A view defined purely by the path it draws in a rect.",
            discussion: "A Shape converts any rectangle into a Path, which makes it resolution-independent and reusable at any size. Conformers get fill, stroke, trim, and clipping behavior for free; animate custom geometry via animatableData.",
            wwdcYear: 2019,
            code: #"""
            struct Triangle: Shape {
                func path(in rect: CGRect) -> Path {
                    Path { p in
                        p.move(to: CGPoint(x: rect.midX, y: rect.minY))
                        p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
                        p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
                        p.closeSubpath()
                    }
                }
            }
            """#,
            related: ["Path", "Animatable", "InsettableShape"]
        ),
        Topic(
            name: "App",
            kind: .protocolItem,
            summary: "The entry point declaring an app's scenes.",
            discussion: "Marking a struct @main and conforming to App replaces the app delegate as the program's root: its body lists the scenes the app can present. App-wide state created here flows into every scene through the environment.",
            wwdcYear: 2020,
            code: #"""
            @main
            struct CompanionApp: App {
                @State private var model = AppModel()

                var body: some Scene {
                    WindowGroup {
                        ContentView()
                            .environment(model)
                    }
                }
            }
            """#,
            related: ["Scene", "WindowGroup", "View"]
        ),
        Topic(
            name: "Scene",
            kind: .protocolItem,
            summary: "A root container the system manages — windows, settings, menus.",
            discussion: "Scenes sit between the App and its views: WindowGroup, Window, Settings, DocumentGroup, and MenuBarExtra all conform. The system owns their lifecycle; scenePhase reports whether a scene is active, inactive, or backgrounded.",
            wwdcYear: 2020,
            code: #"""
            var body: some Scene {
                WindowGroup { ContentView() }
                Settings { SettingsView() }
            }
            """#,
            related: ["App", "WindowGroup", "scenePhase"]
        ),
        Topic(
            name: "ButtonStyle",
            kind: .protocolItem,
            summary: "Custom button appearance driven by press state.",
            discussion: "Implement makeBody(configuration:) to restyle every button it is applied to: the configuration exposes the label, the role, and isPressed so the style can react to interaction. PrimitiveButtonStyle goes deeper and takes over triggering too.",
            wwdcYear: 2019,
            code: #"""
            struct SquishyStyle: ButtonStyle {
                func makeBody(configuration: Configuration) -> some View {
                    configuration.label
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(.blue, in: .capsule)
                        .foregroundStyle(.white)
                        .scaleEffect(configuration.isPressed ? 0.92 : 1)
                }
            }
            """#,
            related: ["Button", "ToggleStyle", ".buttonStyle()"]
        ),
        Topic(
            name: "Animatable",
            kind: .protocolItem,
            summary: "Lets SwiftUI interpolate a type's data during animation.",
            discussion: "Animation works by interpolating animatableData between old and new values and re-rendering each frame. Custom shapes and modifiers adopt Animatable to make their numeric properties smoothly animatable; AnimatablePair combines multiple values.",
            wwdcYear: 2019,
            code: #"""
            struct Wave: Shape {
                var phase: Double

                var animatableData: Double {
                    get { phase }
                    set { phase = newValue }
                }

                func path(in rect: CGRect) -> Path { wavePath(rect, phase) }
            }
            """#,
            demoID: "spring",
            related: ["Shape", ".animation()", "CustomAnimation"]
        ),
        Topic(
            name: "CustomAnimation",
            kind: .protocolItem,
            summary: "Defines your own timing curve or physics for animations.",
            discussion: "Added at WWDC '23, CustomAnimation exposes the animation engine itself: given elapsed time and a vector value, return the interpolated result — or nil to finish. Bounce, gravity, or any bespoke physics can drive standard SwiftUI animations this way.",
            wwdcYear: 2023,
            code: #"""
            struct Linear2x: CustomAnimation {
                func animate<V: VectorArithmetic>(
                    value: V, time: TimeInterval, context: inout AnimationContext<V>
                ) -> V? {
                    time < 0.5 ? value.scaled(by: time * 2) : nil
                }
            }
            """#,
            related: ["Animatable", ".animation()"]
        ),
        Topic(
            name: "Transferable",
            kind: .protocolItem,
            summary: "Declares how a type moves via drag, copy, or share.",
            discussion: "Transferable centralizes serialization for sharing, drag and drop, and the pasteboard: describe your representations — Codable, data, file, or proxy — once, and every transfer surface understands the type.",
            wwdcYear: 2022,
            code: #"""
            struct Recipe: Codable, Transferable {
                var title: String

                static var transferRepresentation: some TransferRepresentation {
                    CodableRepresentation(contentType: .json)
                }
            }
            """#,
            related: ["ShareLink"]
        ),
    ]
}
