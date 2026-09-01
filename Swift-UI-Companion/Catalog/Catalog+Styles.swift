//
//  Catalog+Styles.swift
//  Swift-UI-Companion
//

import Foundation

extension Catalog {
    static let styles: [Topic] = [
        Topic(
            name: ".buttonStyle()",
            kind: .style,
            summary: "Applies a built-in or custom style to buttons.",
            discussion: "buttonStyle propagates through the environment, so one call on a container restyles every button inside. Built-ins span .plain, .borderless, .bordered, and .borderedProminent; controlSize and tint refine them further.",
            wwdcYear: 2019,
            code: #"""
            HStack {
                Button("Cancel") { }
                Button("Save") { }
                    .buttonStyle(.borderedProminent)
            }
            .buttonStyle(.bordered)
            """#,
            demoID: "button",
            related: ["Button", "ButtonStyle"],
            children: [
                TopicChild(
                    name: ".automatic",
                    summary: "Resolves to the platform's default look per context.",
                    code: #"""
                    Button("Continue") { proceed() }
                        .buttonStyle(.automatic)
                    """#
                ),
                TopicChild(
                    name: ".bordered",
                    summary: "A tinted platter behind the label.",
                    code: #"""
                    Button("Add to Cart") { add() }
                        .buttonStyle(.bordered)
                    """#
                ),
                TopicChild(
                    name: ".borderedProminent",
                    summary: "Filled with the tint color — the primary action.",
                    discussion: "Reserve it for the one action you most want taken; a screen full of prominent buttons has none.",
                    code: #"""
                    Button("Buy Now") { checkout() }
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                    """#
                ),
                TopicChild(
                    name: ".plain",
                    summary: "No chrome until the button is pressed or focused.",
                    code: #"""
                    Button("Show details") { reveal() }
                        .buttonStyle(.plain)
                    """#
                ),
                TopicChild(
                    name: ".link",
                    summary: "Hyperlink styling for navigation-flavored actions (macOS).",
                    code: #"""
                    Button("Learn more…") { openDocs() }
                        .buttonStyle(.link)
                    """#
                ),
            ]
        ),
        Topic(
            name: ".toggleStyle()",
            kind: .style,
            summary: "Chooses how toggles render — switch, checkbox, or button.",
            discussion: "The same Toggle declaration can appear as an iOS switch, a macOS checkbox, or a pressed-state button via .button style. Custom ToggleStyle conformances take over rendering entirely.",
            wwdcYear: 2019,
            code: #"""
            Toggle("Bold", systemImage: "bold", isOn: $isBold)
                .toggleStyle(.button)
            """#,
            demoID: "toggle",
            related: ["Toggle"],
            children: [
                TopicChild(
                    name: ".switch",
                    summary: "The sliding on/off switch.",
                    code: #"""
                    Toggle("Wi-Fi", isOn: $wifiEnabled)
                        .toggleStyle(.switch)
                    """#
                ),
                TopicChild(
                    name: ".checkbox",
                    summary: "The classic macOS checkbox.",
                    code: #"""
                    Toggle("Remember me", isOn: $remember)
                        .toggleStyle(.checkbox)
                    """#
                ),
                TopicChild(
                    name: ".button",
                    summary: "A button that stays highlighted while on.",
                    discussion: "The natural fit for formatting toggles — bold, italic, filters — especially with a symbol label in a toolbar.",
                    code: #"""
                    Toggle("Italic", systemImage: "italic", isOn: $isItalic)
                        .toggleStyle(.button)
                    """#
                ),
            ]
        ),
        Topic(
            name: ".pickerStyle()",
            kind: .style,
            summary: "Selects the presentation for pickers.",
            discussion: "pickerStyle switches a Picker between menu, segmented, inline, wheel (iOS), radioGroup (macOS), and palette renderings. The right style depends on option count and how prominent the choice should be.",
            wwdcYear: 2019,
            code: #"""
            Picker("Units", selection: $units) {
                Text("Metric").tag(Units.metric)
                Text("Imperial").tag(Units.imperial)
            }
            .pickerStyle(.segmented)
            """#,
            demoID: "picker",
            related: ["Picker"],
            children: [
                TopicChild(
                    name: ".menu",
                    summary: "Collapses the options into a pull-down menu.",
                    code: #"""
                    Picker("Sort", selection: $sort) {
                        ForEach(SortOrder.allCases) { Text($0.label).tag($0) }
                    }
                    .pickerStyle(.menu)
                    """#
                ),
                TopicChild(
                    name: ".segmented",
                    summary: "Every option visible side by side in one control.",
                    discussion: "Best with two to five short, mutually exclusive options — beyond that the segments get cramped.",
                    code: #"""
                    Picker("Units", selection: $units) {
                        Text("Metric").tag(Units.metric)
                        Text("Imperial").tag(Units.imperial)
                    }
                    .pickerStyle(.segmented)
                    """#
                ),
                TopicChild(
                    name: ".radioGroup",
                    summary: "macOS radio buttons, one per option.",
                    code: #"""
                    Picker("Format", selection: $format) {
                        Text("PNG").tag(Format.png)
                        Text("JPEG").tag(Format.jpeg)
                    }
                    .pickerStyle(.radioGroup)
                    """#
                ),
                TopicChild(
                    name: ".inline",
                    summary: "Options listed flat inside the surrounding container.",
                    code: #"""
                    Form {
                        Picker("Theme", selection: $theme) {
                            ForEach(Theme.allCases) { Text($0.name).tag($0) }
                        }
                        .pickerStyle(.inline)
                    }
                    """#
                ),
            ]
        ),
        Topic(
            name: ".listStyle()",
            kind: .style,
            summary: "Sets the visual treatment of a list.",
            discussion: "listStyle moves a List between plain, inset, grouped, insetGrouped, and sidebar appearances. Sidebar styling also enables collapsible sections — the standard look for source lists on macOS and iPadOS.",
            wwdcYear: 2019,
            code: #"""
            List(items, selection: $selection) { ItemRow($0) }
                .listStyle(.sidebar)
            """#,
            related: ["List"],
            children: [
                TopicChild(
                    name: ".plain",
                    summary: "Edge-to-edge rows with minimal decoration.",
                    code: #"""
                    List(results) { ResultRow($0) }
                        .listStyle(.plain)
                    """#
                ),
                TopicChild(
                    name: ".inset",
                    summary: "Rows inset from the container's edges.",
                    code: #"""
                    List(tracks) { TrackRow($0) }
                        .listStyle(.inset)
                    """#
                ),
                TopicChild(
                    name: ".sidebar",
                    summary: "Source-list styling with collapsible sections.",
                    discussion: "The standard treatment for the leading column of a NavigationSplitView; section headers gain disclosure behavior automatically.",
                    code: #"""
                    List(selection: $selection) {
                        Section("Library") {
                            ForEach(folders) { FolderRow($0) }
                        }
                    }
                    .listStyle(.sidebar)
                    """#
                ),
                TopicChild(
                    name: ".bordered",
                    summary: "A macOS list framed with a visible border.",
                    code: #"""
                    List(devices, selection: $device) { DeviceRow($0) }
                        .listStyle(.bordered)
                    """#
                ),
            ]
        ),
        Topic(
            name: ".labelStyle()",
            kind: .style,
            summary: "Shows a label's icon, title, or both.",
            discussion: "labelStyle adapts Labels to their surroundings: iconOnly for compact toolbars, titleOnly where symbols would be noise, titleAndIcon to force both. Custom LabelStyles can rearrange the pair arbitrarily.",
            wwdcYear: 2020,
            code: #"""
            Label("Downloads", systemImage: "arrow.down.circle")
                .labelStyle(.iconOnly)
            """#,
            demoID: "label",
            related: ["Label"]
        ),
        Topic(
            name: ".progressViewStyle()",
            kind: .style,
            summary: "Renders progress as a bar or a circle.",
            discussion: "progressViewStyle picks linear or circular rendering independent of whether progress is determinate. A custom ProgressViewStyle reads fractionCompleted from the configuration to draw gauges of any design.",
            wwdcYear: 2020,
            code: #"""
            ProgressView(value: 0.4)
                .progressViewStyle(.circular)
            """#,
            demoID: "progress",
            related: ["ProgressView", "Gauge"]
        ),
        Topic(
            name: ".gaugeStyle()",
            kind: .style,
            summary: "Chooses a gauge's rendering, from bars to dials.",
            discussion: "gaugeStyle spans linear and circular families, including the accessory variants designed for widgets and watch complications where space is tight.",
            wwdcYear: 2022,
            platforms: [.iOS, .macOS, .watchOS],
            code: #"""
            Gauge(value: speed, in: 0...200) { Text("km/h") }
                .gaugeStyle(.accessoryCircular)
                .tint(.green)
            """#,
            demoID: "gauge",
            related: ["Gauge"]
        ),
        Topic(
            name: "LinearGradient",
            kind: .style,
            summary: "Blends colors along a straight line.",
            discussion: "LinearGradient interpolates between color stops from a start to an end unit point. As a ShapeStyle it slots into fill, background, and foregroundStyle alike; every Color also offers a subtle built-in .gradient variant.",
            wwdcYear: 2019,
            code: #"""
            RoundedRectangle(cornerRadius: 12)
                .fill(LinearGradient(
                    colors: [.purple, .blue],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
            """#,
            demoID: "gradient",
            related: ["RadialGradient", "AngularGradient", "MeshGradient"]
        ),
        Topic(
            name: "RadialGradient",
            kind: .style,
            summary: "Blends colors outward from a center point.",
            discussion: "RadialGradient runs its stops from a center unit point between a start and end radius — the go-to for spotlight and glow effects.",
            wwdcYear: 2019,
            code: #"""
            Circle()
                .fill(RadialGradient(
                    colors: [.yellow, .orange, .red],
                    center: .center,
                    startRadius: 5,
                    endRadius: 60
                ))
            """#,
            demoID: "gradient",
            related: ["LinearGradient", "AngularGradient"]
        ),
        Topic(
            name: "AngularGradient",
            kind: .style,
            summary: "Sweeps colors around a center point.",
            discussion: "AngularGradient (a conic gradient) rotates through its stops around a center, from a start to an end angle — the foundation of color wheels and circular meters.",
            wwdcYear: 2019,
            code: #"""
            Circle()
                .fill(AngularGradient(
                    colors: [.red, .yellow, .green, .blue, .red],
                    center: .center
                ))
            """#,
            demoID: "gradient",
            related: ["LinearGradient", "RadialGradient"]
        ),
        Topic(
            name: "MeshGradient",
            kind: .style,
            summary: "A 2D mesh of control points, each with its own color.",
            discussion: "New at WWDC '24, MeshGradient interpolates colors across a grid of movable control points, producing fluid, organic blends impossible with linear or radial gradients. Animate the points for lava-lamp backgrounds.",
            wwdcYear: 2024,
            code: #"""
            MeshGradient(
                width: 3, height: 3,
                points: [
                    [0, 0], [0.5, 0], [1, 0],
                    [0, 0.5], [0.7, 0.6], [1, 0.5],
                    [0, 1], [0.5, 1], [1, 1]
                ],
                colors: [
                    .indigo, .purple, .pink,
                    .blue, .teal, .orange,
                    .cyan, .mint, .yellow
                ]
            )
            """#,
            demoID: "meshGradient",
            related: ["LinearGradient", "Color.mix()"]
        ),
        Topic(
            name: "Color.mix()",
            kind: .style,
            summary: "Blends two colors by a fraction in a color space.",
            discussion: "A WWDC '24 addition: mix interpolates a color toward another by a given fraction, in perceptual or device color spaces — no more manual component math for hover tints and charts.",
            wwdcYear: 2024,
            code: #"""
            let hover = Color.blue.mix(with: .white, by: 0.2)

            Rectangle()
                .fill(Color.red.mix(with: .purple, by: 0.5))
            """#,
            related: ["MeshGradient", ".foregroundStyle()"]
        ),
    ]
}
