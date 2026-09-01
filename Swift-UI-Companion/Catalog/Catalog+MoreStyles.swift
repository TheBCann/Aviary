//
//  Catalog+MoreStyles.swift
//  Swift-UI-Companion
//
//  Second wave of style entries: control styles, materials, and the
//  WWDC '25 glass button styles.
//

import Foundation

extension Catalog {
    static let moreStyles: [Topic] = [
        Topic(
            name: ".textFieldStyle()",
            kind: .style,
            summary: "Chooses how text fields draw their chrome.",
            discussion: "textFieldStyle switches between plain, roundedBorder, and the macOS squareBorder appearance for every field in scope. Plain is the base for fully custom field designs built with background and overlay.",
            wwdcYear: 2019,
            code: #"""
            TextField("City", text: $city)
                .textFieldStyle(.roundedBorder)
            """#,
            related: ["TextField"]
        ),
        Topic(
            name: ".menuStyle()",
            kind: .style,
            summary: "Sets the presentation of menus.",
            discussion: "menuStyle picks how a Menu presents — the standard button form, or borderlessButton on macOS for toolbar-like menus. Most apps only need it to remove chrome.",
            wwdcYear: 2020,
            platforms: [.iOS, .macOS],
            code: #"""
            Menu("Options") {
                Button("Rename") { }
            }
            .menuStyle(.button)
            """#,
            related: ["Menu"]
        ),
        Topic(
            name: ".formStyle()",
            kind: .style,
            summary: "Chooses a form's layout family.",
            discussion: "formStyle selects grouped (rows on platters, labels leading) or columns (aligned label column, macOS settings look) for a Form. Grouped on macOS gives the iOS-like settings design used since Ventura.",
            wwdcYear: 2022,
            platforms: [.iOS, .macOS],
            code: #"""
            Form {
                TextField("Server", text: $server)
                Toggle("Use TLS", isOn: $tls)
            }
            .formStyle(.grouped)
            """#,
            related: ["Form", "Section"]
        ),
        Topic(
            name: ".tableStyle()",
            kind: .style,
            summary: "Adjusts a table's borders and row insets.",
            discussion: "tableStyle switches Table between the inset default and bordered variants on macOS, with alternating row backgrounds controlled separately. Mostly a macOS concern; iOS tables keep list styling.",
            wwdcYear: 2021,
            platforms: [.iOS, .macOS],
            code: #"""
            Table(people) {
                TableColumn("Name", value: \.name)
            }
            .tableStyle(.bordered(alternatesRowBackgrounds: true))
            """#,
            related: ["Table"]
        ),
        Topic(
            name: ".tabViewStyle()",
            kind: .style,
            summary: "Switches tabs between bar, page, and sidebar modes.",
            discussion: "tabViewStyle turns a TabView into swipeable pages (page), the watch's vertical carousel, or sidebarAdaptable (2024) where tabs can promote into a sidebar on iPad and Mac.",
            wwdcYear: 2020,
            code: #"""
            TabView {
                ForEach(slides) { SlideView($0) }
            }
            .tabViewStyle(.page(indexDisplayMode: .automatic))
            """#,
            related: ["TabView", ".tabBarMinimizeBehavior()"]
        ),
        Topic(
            name: ".datePickerStyle()",
            kind: .style,
            summary: "Chooses calendar, wheel, field, or compact date UI.",
            discussion: "datePickerStyle spans compact (tap-to-pop-over), graphical (full calendar), wheel on iOS, and field/stepperField on macOS — same binding, very different footprints.",
            wwdcYear: 2019,
            platforms: [.iOS, .macOS, .watchOS],
            code: #"""
            DatePicker("Date", selection: $date, displayedComponents: .date)
                .datePickerStyle(.graphical)
            """#,
            demoID: "datePicker",
            related: ["DatePicker"]
        ),
        Topic(
            name: ".groupBoxStyle()",
            kind: .style,
            summary: "Custom chrome for GroupBox containers.",
            discussion: "A GroupBoxStyle receives the label and content and draws its own platter — brand cards and callout boxes that still read as grouped content at the call site.",
            wwdcYear: 2020,
            platforms: [.iOS, .macOS],
            code: #"""
            struct CardBox: GroupBoxStyle {
                func makeBody(configuration: Configuration) -> some View {
                    VStack(alignment: .leading, spacing: 8) {
                        configuration.label.font(.headline)
                        configuration.content
                    }
                    .padding()
                    .background(.background.secondary, in: .rect(cornerRadius: 12))
                }
            }
            """#,
            related: ["GroupBox"]
        ),
        Topic(
            name: ".disclosureGroupStyle()",
            kind: .style,
            summary: "Custom expansion chrome for disclosure groups.",
            discussion: "DisclosureGroupStyle exposes the label, content, and isExpanded binding so you can replace the chevron treatment entirely — animated arrows, plus/minus buttons, or full-row toggles.",
            wwdcYear: 2022,
            platforms: [.iOS, .macOS],
            code: #"""
            struct PlusMinus: DisclosureGroupStyle {
                func makeBody(configuration: Configuration) -> some View {
                    Button {
                        configuration.isExpanded.toggle()
                    } label: {
                        HStack {
                            configuration.label
                            Spacer()
                            Image(systemName: configuration.isExpanded
                                  ? "minus" : "plus")
                        }
                    }
                    if configuration.isExpanded { configuration.content }
                }
            }
            """#,
            related: ["DisclosureGroup"]
        ),
        Topic(
            name: "Material",
            kind: .style,
            summary: "Translucent blur layers that adapt to their backdrop.",
            discussion: "Materials — ultraThin through ultraThick, plus bar — blur whatever is behind them and keep vibrant text legible on top. They are ShapeStyles, so they slot into background and fill; under the 2025 design language, glassEffect supersedes them for floating controls.",
            wwdcYear: 2021,
            code: #"""
            VStack { controls }
                .padding()
                .background(.ultraThinMaterial, in: .rect(cornerRadius: 16))
            """#,
            demoID: "material",
            related: [".background()", ".glassEffect()", "ShapeStyle"]
        ),
        Topic(
            name: "ImagePaint",
            kind: .style,
            summary: "Tiles an image as a fill or stroke style.",
            discussion: "ImagePaint repeats a source image (or a cropped portion) as a ShapeStyle — textured fills and patterned borders without a custom shader.",
            wwdcYear: 2019,
            code: #"""
            RoundedRectangle(cornerRadius: 12)
                .fill(ImagePaint(image: Image("dots"), scale: 0.4))
                .frame(width: 200, height: 100)
            """#,
            related: ["ShapeStyle", "Image"]
        ),
        Topic(
            name: ".buttonStyle(.glass)",
            kind: .style,
            summary: "Buttons rendered on Liquid Glass material.",
            discussion: "WWDC '25 added glass and glassProminent button styles: capsule buttons on the refractive glass material with the system's press morphing. Use them for floating controls above content; inside toolbars, glass comes for free.",
            wwdcYear: 2025,
            code: #"""
            Button("Get Started") { begin() }
                .buttonStyle(.glassProminent)

            Button("Later") { skip() }
                .buttonStyle(.glass)
            """#,
            related: [".glassEffect()", ".buttonStyle()", "GlassEffectContainer"]
        ),
    ]
}
