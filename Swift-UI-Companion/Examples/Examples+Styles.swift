//
//  Examples+Styles.swift
//  Swift-UI-Companion
//
//  Rendered usage examples for the entries in CatalogData/styles.json.
//  Entries that already have an interactive demo (demoID) are not here.
//

import SwiftUI
import CoreGraphics

enum ExamplesStyles {
    static let entries: [ExampleEntry] = [
        ExampleEntry(topic: ".buttonStyle(.glass)", code: """
        ZStack {
            LinearGradient(colors: [.indigo, .pink],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            HStack(spacing: 12) {
                Button("Later") { taps += 1 }
                    .buttonStyle(.glass)
                Button("Get Started") { taps += 1 }
                    .buttonStyle(.glassProminent)
                    .tint(.blue)
            }
            .controlSize(.large)
        }
        """) { AnyView(St_GlassButtonsExample()) },

        ExampleEntry(topic: ".disclosureGroupStyle()", code: """
        struct PlusMinus: DisclosureGroupStyle {
            func makeBody(configuration: Configuration) -> some View {
                Button { configuration.isExpanded.toggle() } label: {
                    HStack {
                        configuration.label
                        Spacer()
                        Image(systemName: configuration.isExpanded ? "minus" : "plus")
                    }
                }
                if configuration.isExpanded { configuration.content }
            }
        }

        DisclosureGroup("Advanced") { advancedOptions }
            .disclosureGroupStyle(PlusMinus())
        """) { AnyView(St_DisclosureGroupStyleExample()) },

        ExampleEntry(topic: ".formStyle()", code: """
        Form {
            TextField("Server", text: $server)
            Toggle("Use TLS", isOn: $tls)
        }
        .formStyle(.grouped)

        Form {
            TextField("Server", text: $server)
            Toggle("Use TLS", isOn: $tls)
        }
        .formStyle(.columns)
        """) { AnyView(St_FormStyleExample()) },

        ExampleEntry(topic: ".groupBoxStyle()", code: """
        struct CardBox: GroupBoxStyle {
            func makeBody(configuration: Configuration) -> some View {
                VStack(alignment: .leading, spacing: 8) {
                    configuration.label.font(.headline)
                    configuration.content
                }
                .padding()
                .background(.tint.opacity(0.12), in: .rect(cornerRadius: 12))
            }
        }

        GroupBox("Storage") { storageRows }
            .groupBoxStyle(CardBox())
        """) { AnyView(St_GroupBoxStyleExample()) },

        ExampleEntry(topic: ".listStyle()", code: """
        let list = List(fruits, id: \\.self, selection: $selection) { Text($0) }

        switch style {
        case .plain:    list.listStyle(.plain)
        case .inset:    list.listStyle(.inset)
        case .sidebar:  list.listStyle(.sidebar)
        case .bordered: list.listStyle(.bordered)
        }
        """) { AnyView(St_ListStyleExample()) },

        ExampleEntry(topic: ".menuStyle()", code: """
        Menu("Options") {
            Button("Rename") { lastAction = "Rename" }
            Button("Duplicate") { lastAction = "Duplicate" }
            Divider()
            Button("Delete", role: .destructive) { lastAction = "Delete" }
        }
        .menuStyle(.button)
        .buttonStyle(.bordered)

        Text("Last action: \\(lastAction)")
        """) { AnyView(St_MenuStyleExample()) },

        ExampleEntry(topic: ".tableStyle()", code: """
        let table = Table(files) {
            TableColumn("Name", value: \\.name)
            TableColumn("Size", value: \\.sizeText)
        }

        switch style {
        case .inset:    table.tableStyle(.inset)
        case .bordered: table.tableStyle(.bordered)
                             .alternatingRowBackgrounds()
        }
        """) { AnyView(St_TableStyleExample()) },

        ExampleEntry(topic: ".tabViewStyle()", code: """
        TabView {
            Tab("General", systemImage: "gear") { GeneralPane() }
            Tab("Advanced", systemImage: "slider.horizontal.3") { AdvancedPane() }
        }
        .tabViewStyle(.grouped)
        """) { AnyView(St_TabViewStyleExample()) },

        ExampleEntry(topic: ".textFieldStyle()", code: """
        TextField("City", text: $city)
            .textFieldStyle(.roundedBorder)

        TextField("Path", text: $path)
            .textFieldStyle(.squareBorder)

        TextField("Search", text: $query)
            .textFieldStyle(.plain)
            .padding(8)
            .background(.quaternary, in: .capsule)
        """) { AnyView(St_TextFieldStyleExample()) },

        ExampleEntry(topic: "Color.mix()", code: """
        Slider(value: $amount, in: 0...1)

        HStack {
            Rectangle()
                .fill(Color.yellow.mix(with: .blue, by: amount))
            Rectangle()
                .fill(Color.yellow.mix(with: .blue, by: amount, in: .device))
        }
        """) { AnyView(St_ColorMixExample()) },

        ExampleEntry(topic: "ImagePaint", code: """
        // `dots` is a 24×24 tile drawn with CoreGraphics
        RoundedRectangle(cornerRadius: 12)
            .fill(ImagePaint(image: dots, scale: 0.5))
            .frame(height: 90)

        Capsule()
            .stroke(ImagePaint(image: dots, scale: 0.25), lineWidth: 14)
            .frame(height: 44)
        """) { AnyView(St_ImagePaintExample()) },
    ]
}

// MARK: - .buttonStyle(.glass)

private struct St_GlassButtonsExample: View {
    @State private var taps = 0

    var body: some View {
        ZStack {
            LinearGradient(colors: [.indigo, .pink],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack(spacing: 14) {
                HStack(spacing: 12) {
                    Button("Later") { taps += 1 }
                        .buttonStyle(.glass)
                    Button("Get Started") { taps += 1 }
                        .buttonStyle(.glassProminent)
                        .tint(.blue)
                }
                .controlSize(.large)

                Text("Pressed \(taps) time\(taps == 1 ? "" : "s")")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.85))
            }
        }
        .frame(height: 150)
        .clipShape(.rect(cornerRadius: 12))
    }
}

// MARK: - .disclosureGroupStyle()

private struct St_PlusMinus: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button { configuration.isExpanded.toggle() } label: {
            HStack {
                configuration.label
                Spacer()
                Image(systemName: configuration.isExpanded ? "minus" : "plus")
            }
            .contentShape(.rect)
        }
        .buttonStyle(.plain)
        if configuration.isExpanded { configuration.content }
    }
}

private struct St_DisclosureGroupStyleExample: View {
    @State private var verbose = false
    @State private var retries = 3

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            DisclosureGroup("Advanced") {
                Toggle("Verbose logging", isOn: $verbose)
                Stepper("Retries: \(retries)", value: $retries, in: 0...10)
            }
            .disclosureGroupStyle(St_PlusMinus())
            .padding(12)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))

            Text("Click the row to toggle — the style swaps the chevron for plus/minus.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - .formStyle()

private struct St_FormStyleExample: View {
    @State private var server = "api.example.com"
    @State private var tls = true

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(spacing: 4) {
                Form {
                    TextField("Server", text: $server)
                    Toggle("Use TLS", isOn: $tls)
                }
                .formStyle(.grouped)
                .frame(height: 130)
                .clipShape(.rect(cornerRadius: 8))
                Text(".grouped").font(.caption.monospaced()).foregroundStyle(.secondary)
            }

            VStack(spacing: 4) {
                Form {
                    TextField("Server", text: $server)
                    Toggle("Use TLS", isOn: $tls)
                }
                .formStyle(.columns)
                .frame(height: 130)
                Text(".columns").font(.caption.monospaced()).foregroundStyle(.secondary)
            }
        }
    }
}

// MARK: - .groupBoxStyle()

private struct St_CardBox: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            configuration.label.font(.headline)
            configuration.content
        }
        .padding()
        .background(.tint.opacity(0.12), in: .rect(cornerRadius: 12))
    }
}

private struct St_GroupBoxStyleExample: View {
    var body: some View {
        GroupBox("Storage") {
            ProgressView(value: 0.62)
            HStack {
                Label("62 GB used", systemImage: "internaldrive")
                Spacer()
                Text("38 GB free")
                    .foregroundStyle(.secondary)
            }
            .font(.caption)
        }
        .groupBoxStyle(St_CardBox())
        .tint(.blue)
    }
}

// MARK: - .listStyle()

private enum St_ListStyleChoice: String, CaseIterable, Identifiable {
    case plain, inset, sidebar, bordered
    var id: Self { self }
}

private struct St_ListStyleExample: View {
    @State private var style: St_ListStyleChoice = .sidebar
    @State private var selection: String? = "Cherry"
    private let fruits = ["Apple", "Banana", "Cherry", "Date"]

    var body: some View {
        VStack(spacing: 10) {
            Picker("Style", selection: $style) {
                ForEach(St_ListStyleChoice.allCases) { Text(".\($0.rawValue)").tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            let list = List(fruits, id: \.self, selection: $selection) { Text($0) }

            Group {
                switch style {
                case .plain:    list.listStyle(.plain)
                case .inset:    list.listStyle(.inset)
                case .sidebar:  list.listStyle(.sidebar)
                case .bordered: list.listStyle(.bordered)
                }
            }
            .frame(height: 120)
        }
    }
}

// MARK: - .menuStyle()

private struct St_MenuStyleExample: View {
    @State private var lastAction = "none"

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Menu("Options") {
                Button("Rename") { lastAction = "Rename" }
                Button("Duplicate") { lastAction = "Duplicate" }
                Divider()
                Button("Delete", role: .destructive) { lastAction = "Delete" }
            }
            .menuStyle(.button)
            .buttonStyle(.bordered)
            .fixedSize()

            Text("Last action: \(lastAction)")
                .font(.callout)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - .tableStyle()

private struct St_FileRow: Identifiable {
    let id: Int
    let name: String
    let sizeText: String
}

private enum St_TableStyleChoice: String, CaseIterable, Identifiable {
    case inset, bordered
    var id: Self { self }
}

private struct St_TableStyleExample: View {
    @State private var style: St_TableStyleChoice = .bordered
    private let files = [
        St_FileRow(id: 1, name: "Notes.md", sizeText: "4 KB"),
        St_FileRow(id: 2, name: "Sketch.png", sizeText: "1.2 MB"),
        St_FileRow(id: 3, name: "Budget.numbers", sizeText: "220 KB"),
        St_FileRow(id: 4, name: "Archive.zip", sizeText: "18 MB"),
    ]

    var body: some View {
        VStack(spacing: 10) {
            Picker("Style", selection: $style) {
                ForEach(St_TableStyleChoice.allCases) { Text(".\($0.rawValue)").tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            let table = Table(files) {
                TableColumn("Name", value: \.name)
                TableColumn("Size", value: \.sizeText)
            }

            Group {
                switch style {
                case .inset:    table.tableStyle(.inset)
                case .bordered: table.tableStyle(.bordered)
                                     .alternatingRowBackgrounds()
                }
            }
            .frame(height: 140)
        }
    }
}

// MARK: - .tabViewStyle()

private struct St_TabViewStyleExample: View {
    @State private var launchAtLogin = true
    @State private var logLevel = "Info"

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TabView {
                Tab("General", systemImage: "gear") {
                    Form {
                        Toggle("Launch at login", isOn: $launchAtLogin)
                    }
                    .padding(8)
                }
                Tab("Advanced", systemImage: "slider.horizontal.3") {
                    Form {
                        Picker("Log level", selection: $logLevel) {
                            ForEach(["Error", "Info", "Debug"], id: \.self) { Text($0) }
                        }
                    }
                    .padding(8)
                }
            }
            .tabViewStyle(.grouped)
            .frame(height: 150)

            Text(".grouped is macOS-only; .page(indexDisplayMode:) is iOS / watchOS only.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - .textFieldStyle()

private struct St_TextFieldStyleExample: View {
    @State private var city = "Cupertino"
    @State private var path = "/Users/me/Documents"
    @State private var query = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            row(".roundedBorder") {
                TextField("City", text: $city)
                    .textFieldStyle(.roundedBorder)
            }
            row(".squareBorder") {
                TextField("Path", text: $path)
                    .textFieldStyle(.squareBorder)
            }
            row(".plain") {
                TextField("Search", text: $query)
                    .textFieldStyle(.plain)
                    .padding(8)
                    .background(.quaternary, in: .capsule)
            }
        }
    }

    private func row<Content: View>(_ caption: String, @ViewBuilder _ content: () -> Content) -> some View {
        HStack(spacing: 12) {
            Text(caption)
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
                .frame(width: 110, alignment: .trailing)
            content()
        }
    }
}

// MARK: - Color.mix()

private struct St_ColorMixExample: View {
    @State private var amount = 0.5

    var body: some View {
        VStack(spacing: 10) {
            Slider(value: $amount, in: 0...1) {
                Text("by")
            } minimumValueLabel: {
                Text("yellow").font(.caption)
            } maximumValueLabel: {
                Text("blue").font(.caption)
            }
            .labelsHidden()

            HStack(spacing: 12) {
                VStack(spacing: 4) {
                    Rectangle()
                        .fill(Color.yellow.mix(with: .blue, by: amount))
                        .frame(height: 60)
                        .clipShape(.rect(cornerRadius: 8))
                    Text(".perceptual (default)")
                        .font(.caption.monospaced())
                        .foregroundStyle(.secondary)
                }
                VStack(spacing: 4) {
                    Rectangle()
                        .fill(Color.yellow.mix(with: .blue, by: amount, in: .device))
                        .frame(height: 60)
                        .clipShape(.rect(cornerRadius: 8))
                    Text(".device")
                        .font(.caption.monospaced())
                        .foregroundStyle(.secondary)
                }
            }

            Text("by: \(amount, format: .number.precision(.fractionLength(2)))")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - ImagePaint

/// Draws a 24×24 polka-dot tile with CoreGraphics so the example needs no asset.
private func St_makeDotsTile() -> Image {
    let size = 24
    let fallback = Image(systemName: "circle.grid.3x3.fill")
    guard let context = CGContext(
        data: nil,
        width: size,
        height: size,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: CGColorSpaceCreateDeviceRGB(),
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    ) else { return fallback }

    context.setFillColor(CGColor(red: 1.0, green: 0.87, blue: 0.45, alpha: 1))
    context.fill(CGRect(x: 0, y: 0, width: size, height: size))
    context.setFillColor(CGColor(red: 0.85, green: 0.33, blue: 0.22, alpha: 1))
    context.fillEllipse(in: CGRect(x: 6, y: 6, width: 12, height: 12))

    guard let cgImage = context.makeImage() else { return fallback }
    return Image(cgImage, scale: 1, label: Text("dots"))
}

private struct St_ImagePaintExample: View {
    @State private var dots = St_makeDotsTile()

    var body: some View {
        VStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 12)
                .fill(ImagePaint(image: dots, scale: 0.5))
                .frame(height: 90)

            Capsule()
                .stroke(ImagePaint(image: dots, scale: 0.25), lineWidth: 14)
                .frame(height: 44)
                .padding(.horizontal, 7)
        }
    }
}
