//
//  ChildExamples+Part21.swift
//  Aviary
//
//  Compiled renderings for variant entries (part 21: styles).
//  One private C21_* struct per variant; every rendering exercises the exact
//  style the variant names, so siblings can be compared side by side.
//

import SwiftUI

enum ChildExamplesPart21 {
    static let entries: [ChildExampleEntry] = [

        // MARK: .buttonStyle()

        ChildExampleEntry(parent: ".buttonStyle()", child: ".automatic", code: """
        Button("Continue") { proceed() }
            .buttonStyle(.automatic)      // macOS: a standard push button
        """) { AnyView(C21_ButtonAutomaticExample()) },

        ChildExampleEntry(parent: ".buttonStyle()", child: ".bordered", code: """
        Button("Add to Cart") { add() }
            .buttonStyle(.bordered)

        Button("Add to Cart", systemImage: "cart.badge.plus") { add() }
            .buttonStyle(.bordered)
            .tint(.orange)                // the platter picks up the tint
        """) { AnyView(C21_ButtonBorderedExample()) },

        ChildExampleEntry(parent: ".buttonStyle()", child: ".borderedProminent", code: """
        HStack {
            Button("Cancel") { dismiss() }
                .buttonStyle(.bordered)
            Button("Buy Now") { checkout() }
                .buttonStyle(.borderedProminent)
                .tint(.green)
        }
        """) { AnyView(C21_ButtonBorderedProminentExample()) },

        ChildExampleEntry(parent: ".buttonStyle()", child: ".plain", code: """
        Button("Show details") { reveal() }
            .buttonStyle(.plain)          // reads as text until pressed
        """) { AnyView(C21_ButtonPlainExample()) },

        ChildExampleEntry(parent: ".buttonStyle()", child: ".link", code: """
        Text("Sync keeps your library identical on every Mac.")
        Button("Learn more…") { openDocs() }
            .buttonStyle(.link)
        """) { AnyView(C21_ButtonLinkExample()) },

        // MARK: .buttonStyle(.glass)

        ChildExampleEntry(parent: ".buttonStyle(.glass)", child: ".glass", code: """
        ZStack {
            artwork                        // the button refracts what sits beneath it
            Button("Later") { skip() }
                .buttonStyle(.glass)
        }
        """) { AnyView(C21_ButtonGlassExample()) },

        ChildExampleEntry(parent: ".buttonStyle(.glass)", child: ".glassProminent", code: """
        HStack {
            Button("Later") { skip() }
                .buttonStyle(.glass)
            Button("Get Started") { begin() }
                .buttonStyle(.glassProminent)
                .tint(.blue)
        }
        """) { AnyView(C21_ButtonGlassProminentExample()) },

        // MARK: .datePickerStyle()

        ChildExampleEntry(parent: ".datePickerStyle()", child: ".compact", code: """
        DatePicker("Due", selection: $due, displayedComponents: .date)
            .datePickerStyle(.compact)
        """) { AnyView(C21_DatePickerCompactExample()) },

        ChildExampleEntry(parent: ".datePickerStyle()", child: ".graphical", code: """
        DatePicker("Start", selection: $start, displayedComponents: .date)
            .datePickerStyle(.graphical)
        """) { AnyView(C21_DatePickerGraphicalExample()) },

        ChildExampleEntry(parent: ".datePickerStyle()", child: ".wheel", code: """
        DatePicker("Alarm", selection: $alarm,
                   displayedComponents: .hourAndMinute)
            .datePickerStyle(.wheel)      // iOS and watchOS only
        """) { AnyView(C21_DatePickerWheelExample()) },

        ChildExampleEntry(parent: ".datePickerStyle()", child: ".field", code: """
        DatePicker("Expires", selection: $expires, displayedComponents: .date)
            .datePickerStyle(.field)

        DatePicker("Expires", selection: $expires, displayedComponents: .date)
            .datePickerStyle(.stepperField)   // same field, plus arrows
        """) { AnyView(C21_DatePickerFieldExample()) },

        // MARK: .disclosureGroupStyle()

        ChildExampleEntry(parent: ".disclosureGroupStyle()", child: ".automatic", code: """
        VStack {
            DisclosureGroup("Appearance") { appearanceRows }   // inherits PillStyle
            DisclosureGroup("Advanced") { AdvancedOptions() }
                .disclosureGroupStyle(.automatic)             // back to the chevron
        }
        .disclosureGroupStyle(PillStyle())
        """) { AnyView(C21_DisclosureAutomaticExample()) },

        ChildExampleEntry(parent: ".disclosureGroupStyle()", child: "makeBody(configuration:)", code: """
        struct RowToggle: DisclosureGroupStyle {
            func makeBody(configuration: Configuration) -> some View {
                VStack(alignment: .leading) {
                    HStack {
                        configuration.label
                        Spacer()
                        Image(systemName: configuration.isExpanded ? "minus.circle" : "plus.circle")
                    }
                    .contentShape(.rect)
                    .onTapGesture { withAnimation { configuration.isExpanded.toggle() } }
                    if configuration.isExpanded { configuration.content }
                }
            }
        }
        """) { AnyView(C21_DisclosureMakeBodyExample()) },

        ChildExampleEntry(parent: ".disclosureGroupStyle()", child: "DisclosureGroupStyleConfiguration", code: """
        func makeBody(configuration: Configuration) -> some View {
            VStack(alignment: .leading) {
                Toggle(isOn: configuration.$isExpanded) { configuration.label }   // the binding + label
                configuration.content                                            // the content view
                    .opacity(configuration.isExpanded ? 1 : 0.25)
            }
        }
        """) { AnyView(C21_DisclosureConfigurationExample()) },

        // MARK: .formStyle()

        ChildExampleEntry(parent: ".formStyle()", child: ".automatic", code: """
        Form {
            TextField("Name", text: $name)
            Toggle("Sync", isOn: $sync)
        }
        .formStyle(.automatic)        // resolves per platform and container
        """) { AnyView(C21_FormAutomaticExample()) },

        ChildExampleEntry(parent: ".formStyle()", child: ".grouped", code: """
        Form {
            Section("Account") {
                TextField("Name", text: $name)
                Toggle("Sync", isOn: $sync)
            }
        }
        .formStyle(.grouped)
        """) { AnyView(C21_FormGroupedExample()) },

        ChildExampleEntry(parent: ".formStyle()", child: ".columns", code: """
        Form {
            TextField("Host", text: $host)
            TextField("Port", value: $port, format: .number)
        }
        .formStyle(.columns)
        """) { AnyView(C21_FormColumnsExample()) },

        // MARK: .gaugeStyle()

        ChildExampleEntry(parent: ".gaugeStyle()", child: ".linearCapacity", code: """
        Gauge(value: usedGB, in: 0...capacityGB) { Text("Storage") }
            .gaugeStyle(.linearCapacity)
        """) { AnyView(C21_GaugeLinearCapacityExample()) },

        ChildExampleEntry(parent: ".gaugeStyle()", child: ".accessoryLinear", code: """
        Gauge(value: temperature, in: -10...40) { Text("°C") }
            .gaugeStyle(.accessoryLinear)
            .tint(Gradient(colors: [.blue, .red]))
        """) { AnyView(C21_GaugeAccessoryLinearExample()) },

        ChildExampleEntry(parent: ".gaugeStyle()", child: ".accessoryCircular", code: """
        Gauge(value: speed, in: 0...200) {
            Text("km/h")
        } currentValueLabel: {
            Text("\\(Int(speed))")
        }
        .gaugeStyle(.accessoryCircular)
        """) { AnyView(C21_GaugeAccessoryCircularExample()) },

        ChildExampleEntry(parent: ".gaugeStyle()", child: ".accessoryCircularCapacity", code: """
        Gauge(value: batteryLevel) {
            Text("\\(Int(batteryLevel * 100))%")
        }
        .gaugeStyle(.accessoryCircularCapacity)
        .tint(batteryLevel < 0.2 ? .red : .green)
        """) { AnyView(C21_GaugeAccessoryCircularCapacityExample()) },

        // MARK: .groupBoxStyle()

        ChildExampleEntry(parent: ".groupBoxStyle()", child: ".automatic", code: """
        HStack {
            GroupBox("Network") { networkRows }      // inherits Callout
            GroupBox("Network") { networkRows }
                .groupBoxStyle(.automatic)           // the stock platter
        }
        .groupBoxStyle(Callout())
        """) { AnyView(C21_GroupBoxAutomaticExample()) },

        ChildExampleEntry(parent: ".groupBoxStyle()", child: "makeBody(configuration:)", code: """
        struct Callout: GroupBoxStyle {
            func makeBody(configuration: Configuration) -> some View {
                HStack(alignment: .top) {
                    Image(systemName: "info.circle")
                    VStack(alignment: .leading) {
                        configuration.label.bold()
                        configuration.content
                    }
                }
                .padding()
                .background(.yellow.opacity(0.15), in: .rect(cornerRadius: 10))
            }
        }
        """) { AnyView(C21_GroupBoxMakeBodyExample()) },

        ChildExampleEntry(parent: ".groupBoxStyle()", child: "GroupBoxStyleConfiguration", code: """
        func makeBody(configuration: Configuration) -> some View {
            VStack(spacing: 4) {
                configuration.content              // the box's body
                configuration.label                // the box's title, moved below
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        """) { AnyView(C21_GroupBoxConfigurationExample()) },

        // MARK: .labelStyle()

        ChildExampleEntry(parent: ".labelStyle()", child: ".iconOnly", code: """
        HStack {
            Label("Share", systemImage: "square.and.arrow.up")
            Label("Favorite", systemImage: "heart")
            Label("Delete", systemImage: "trash")
        }
        .labelStyle(.iconOnly)
        """) { AnyView(C21_LabelIconOnlyExample()) },

        ChildExampleEntry(parent: ".labelStyle()", child: ".titleOnly", code: """
        Label("Settings", systemImage: "gear")
            .labelStyle(.titleOnly)
        """) { AnyView(C21_LabelTitleOnlyExample()) },

        ChildExampleEntry(parent: ".labelStyle()", child: ".titleAndIcon", code: """
        Menu("Actions") {
            Button { } label: {
                Label("Duplicate", systemImage: "plus.square.on.square")
            }
        }
        .labelStyle(.titleAndIcon)     // menu items keep their symbols
        """) { AnyView(C21_LabelTitleAndIconExample()) },

        ChildExampleEntry(parent: ".labelStyle()", child: ".automatic", code: """
        Label("Downloads", systemImage: "arrow.down.circle")
            .labelStyle(.automatic)    // each container picks the parts it shows
        """) { AnyView(C21_LabelAutomaticExample()) },

        // MARK: .listStyle()

        ChildExampleEntry(parent: ".listStyle()", child: ".plain", code: """
        List(results, id: \\.self) { Text($0) }
            .listStyle(.plain)
        """) { AnyView(C21_ListPlainExample()) },

        ChildExampleEntry(parent: ".listStyle()", child: ".inset", code: """
        List(tracks, id: \\.self) { Label($0, systemImage: "music.note") }
            .listStyle(.inset)
        """) { AnyView(C21_ListInsetExample()) },

        ChildExampleEntry(parent: ".listStyle()", child: ".sidebar", code: """
        List(selection: $selection) {
            Section("Library") {
                ForEach(folders, id: \\.self) { Label($0, systemImage: "folder") }
            }
        }
        .listStyle(.sidebar)
        """) { AnyView(C21_ListSidebarExample()) },

        ChildExampleEntry(parent: ".listStyle()", child: ".bordered", code: """
        List(devices, id: \\.self, selection: $device) {
            Label($0, systemImage: "laptopcomputer")
        }
        .listStyle(.bordered)
        """) { AnyView(C21_ListBorderedExample()) },

        // MARK: .menuStyle()

        ChildExampleEntry(parent: ".menuStyle()", child: ".automatic", code: """
        Menu("Sort") {
            Button("By Name") { sort = "By Name" }
            Button("By Date") { sort = "By Date" }
            Button("By Size") { sort = "By Size" }
        }
        .menuStyle(.automatic)
        """) { AnyView(C21_MenuAutomaticExample()) },

        ChildExampleEntry(parent: ".menuStyle()", child: ".button", code: """
        Menu("Options") {
            Button("Rename") { }
            Button("Delete", role: .destructive) { }
        }
        .menuStyle(.button)
        .buttonStyle(.bordered)       // the label now honors button styles
        """) { AnyView(C21_MenuButtonExample()) },

        ChildExampleEntry(parent: ".menuStyle()", child: "makeBody(configuration:)", code: """
        struct Quiet: MenuStyle {
            func makeBody(configuration: Configuration) -> some View {
                Menu(configuration)
                    .buttonStyle(.borderless)
                    .foregroundStyle(.secondary)
            }
        }
        """) { AnyView(C21_MenuMakeBodyExample()) },

        // MARK: .pickerStyle()

        ChildExampleEntry(parent: ".pickerStyle()", child: ".menu", code: """
        Picker("Sort", selection: $sort) {
            ForEach(SortOrder.allCases) { Text($0.label).tag($0) }
        }
        .pickerStyle(.menu)
        """) { AnyView(C21_PickerMenuExample()) },

        ChildExampleEntry(parent: ".pickerStyle()", child: ".segmented", code: """
        Picker("Units", selection: $units) {
            Text("Metric").tag(Units.metric)
            Text("Imperial").tag(Units.imperial)
        }
        .pickerStyle(.segmented)
        """) { AnyView(C21_PickerSegmentedExample()) },

        ChildExampleEntry(parent: ".pickerStyle()", child: ".radioGroup", code: """
        Picker("Format", selection: $format) {
            Text("PNG").tag(Format.png)
            Text("JPEG").tag(Format.jpeg)
        }
        .pickerStyle(.radioGroup)
        """) { AnyView(C21_PickerRadioGroupExample()) },

        ChildExampleEntry(parent: ".pickerStyle()", child: ".inline", code: """
        Form {
            Picker("Theme", selection: $theme) {
                ForEach(Theme.allCases) { Text($0.name).tag($0) }
            }
            .pickerStyle(.inline)
        }
        """) { AnyView(C21_PickerInlineExample()) },

        // MARK: .progressViewStyle()

        ChildExampleEntry(parent: ".progressViewStyle()", child: ".linear", code: """
        ProgressView("Uploading", value: sent, total: total)
            .progressViewStyle(.linear)
        """) { AnyView(C21_ProgressLinearExample()) },

        ChildExampleEntry(parent: ".progressViewStyle()", child: ".circular", code: """
        ProgressView()                       // indeterminate → spins
            .progressViewStyle(.circular)
            .controlSize(.large)

        ProgressView(value: 0.4)             // determinate → fills the ring
            .progressViewStyle(.circular)
            .controlSize(.large)
        """) { AnyView(C21_ProgressCircularExample()) },

        ChildExampleEntry(parent: ".progressViewStyle()", child: ".automatic", code: """
        ProgressView(value: 0.7)
            .progressViewStyle(.automatic)   // macOS: a bar when there's a value…
        ProgressView()
            .progressViewStyle(.automatic)   // …and a spinner when there isn't
        """) { AnyView(C21_ProgressAutomaticExample()) },
    ]
}

// MARK: - .buttonStyle()

private struct C21_ButtonAutomaticExample: View {
    @State private var presses = 0

    var body: some View {
        VStack(spacing: 12) {
            Button("Continue") { presses += 1 }
                .buttonStyle(.automatic)
            Text(presses == 0 ? "Not pressed yet" : "Pressed \(presses)×")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C21_ButtonBorderedExample: View {
    @State private var cartCount = 0

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                Button("Add to Cart") { cartCount += 1 }
                    .buttonStyle(.bordered)
                Button("Add to Cart", systemImage: "cart.badge.plus") { cartCount += 1 }
                    .buttonStyle(.bordered)
                    .tint(.orange)
            }
            Label("\(cartCount) in cart", systemImage: "cart")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C21_ButtonBorderedProminentExample: View {
    @State private var status = "Awaiting your decision"

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                Button("Cancel") { status = "Cancelled" }
                    .buttonStyle(.bordered)
                Button("Buy Now") { status = "Purchased — thank you!" }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
            }
            Text(status)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C21_ButtonPlainExample: View {
    @State private var isRevealed = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Invoice #4821")
                Spacer()
                Button(isRevealed ? "Hide details" : "Show details") {
                    withAnimation { isRevealed.toggle() }
                }
                .buttonStyle(.plain)
                .foregroundStyle(.tint)
            }
            if isRevealed {
                Text("3 items · $128.40 · paid on Aug 12")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .frame(width: 260)
        .background(.quaternary.opacity(0.4), in: .rect(cornerRadius: 10))
    }
}

private struct C21_ButtonLinkExample: View {
    @State private var opened = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Sync keeps your library identical on every Mac.")
            Button("Learn more…") { opened += 1 }
                .buttonStyle(.link)
            if opened > 0 {
                Text("openDocs() called \(opened)×")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
    }
}

// MARK: - .buttonStyle(.glass)

private struct C21_GlassBackdrop: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(LinearGradient(colors: [.purple, .orange, .teal],
                                 startPoint: .topLeading, endPoint: .bottomTrailing))
            .overlay {
                HStack(spacing: 14) {
                    ForEach(0..<4, id: \.self) { index in
                        Circle()
                            .fill(.white.opacity(0.35))
                            .frame(width: 26 + CGFloat(index) * 10)
                    }
                }
            }
    }
}

private struct C21_ButtonGlassExample: View {
    @State private var skipped = false

    var body: some View {
        ZStack {
            C21_GlassBackdrop()
            Button(skipped ? "Skipped" : "Later") { skipped.toggle() }
                .buttonStyle(.glass)
        }
        .frame(width: 280, height: 140)
    }
}

private struct C21_ButtonGlassProminentExample: View {
    @State private var choice = "Nothing chosen yet"

    var body: some View {
        ZStack {
            C21_GlassBackdrop()
            VStack(spacing: 10) {
                HStack(spacing: 12) {
                    Button("Later") { choice = "skip()" }
                        .buttonStyle(.glass)
                    Button("Get Started") { choice = "begin()" }
                        .buttonStyle(.glassProminent)
                        .tint(.blue)
                }
                Text(choice)
                    .font(.caption)
                    .foregroundStyle(.white)
            }
        }
        .frame(width: 280, height: 140)
    }
}

// MARK: - .datePickerStyle()

private struct C21_DatePickerCompactExample: View {
    @State private var due = Date.now.addingTimeInterval(7 * 86_400)

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            DatePicker("Due", selection: $due, displayedComponents: .date)
                .datePickerStyle(.compact)
            Text("Due \(due.formatted(date: .long, time: .omitted))")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(width: 260)
    }
}

private struct C21_DatePickerGraphicalExample: View {
    @State private var start = Date.now

    var body: some View {
        DatePicker("Start", selection: $start, displayedComponents: .date)
            .datePickerStyle(.graphical)
            .frame(width: 240)
            .padding()
    }
}

private struct C21_DatePickerWheelExample: View {
    private let hours = ["6", "7", "8", "9", "10"]
    private let minutes = ["15", "20", "25", "30", "35"]
    private let periods = ["", "AM", "PM", "", ""]

    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 0) {
                Text("Alarm")
                    .frame(width: 60, alignment: .leading)
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.quaternary.opacity(0.5))
                        .frame(height: 30)
                    HStack(spacing: 24) {
                        C21_WheelColumn(values: hours)
                        C21_WheelColumn(values: minutes)
                        C21_WheelColumn(values: periods)
                    }
                }
            }
            .frame(width: 260)
            Text("Illustrative — .wheel is iOS and watchOS only")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C21_WheelColumn: View {
    let values: [String]

    var body: some View {
        VStack(spacing: 4) {
            ForEach(Array(values.enumerated()), id: \.offset) { index, value in
                Text(value)
                    .fontWeight(index == 2 ? .semibold : .regular)
                    .foregroundStyle(index == 2 ? .primary : .secondary)
                    .opacity(index == 2 ? 1 : (abs(index - 2) == 1 ? 0.55 : 0.25))
                    .scaleEffect(x: 1, y: index == 2 ? 1 : 0.8)
            }
        }
        .frame(width: 36)
    }
}

private struct C21_DatePickerFieldExample: View {
    @State private var expires = Date.now.addingTimeInterval(30 * 86_400)

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            DatePicker("Expires", selection: $expires, displayedComponents: .date)
                .datePickerStyle(.field)
            DatePicker("Expires", selection: $expires, displayedComponents: .date)
                .datePickerStyle(.stepperField)
            Text("Both edit the same date: \(expires.formatted(date: .abbreviated, time: .omitted))")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(width: 280)
    }
}

// MARK: - .disclosureGroupStyle()

private struct C21_PillDisclosureStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Button {
                withAnimation { configuration.isExpanded.toggle() }
            } label: {
                HStack {
                    configuration.label
                    Spacer()
                    Text(configuration.isExpanded ? "Hide" : "Show")
                        .font(.caption2)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(.tint.opacity(0.15), in: .capsule)
            }
            .buttonStyle(.plain)
            if configuration.isExpanded {
                configuration.content
                    .padding(.leading, 10)
            }
        }
    }
}

private struct C21_DisclosureAutomaticExample: View {
    @State private var showAppearance = false
    @State private var showAdvanced = true

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            DisclosureGroup("Appearance", isExpanded: $showAppearance) {
                Toggle("Reduce motion", isOn: .constant(false))
            }
            DisclosureGroup("Advanced", isExpanded: $showAdvanced) {
                Toggle("Verbose logging", isOn: .constant(true))
            }
            .disclosureGroupStyle(.automatic)
        }
        .disclosureGroupStyle(C21_PillDisclosureStyle())
        .padding()
        .frame(width: 260)
    }
}

private struct C21_RowToggleDisclosureStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                configuration.label
                Spacer()
                Image(systemName: configuration.isExpanded ? "minus.circle" : "plus.circle")
                    .foregroundStyle(.tint)
            }
            .contentShape(.rect)
            .onTapGesture { withAnimation { configuration.isExpanded.toggle() } }
            if configuration.isExpanded { configuration.content }
        }
    }
}

private struct C21_DisclosureMakeBodyExample: View {
    @State private var isExpanded = false

    var body: some View {
        DisclosureGroup("Shipping options", isExpanded: $isExpanded) {
            VStack(alignment: .leading, spacing: 4) {
                Label("Standard — free", systemImage: "shippingbox")
                Label("Express — $9", systemImage: "hare")
            }
            .font(.callout)
        }
        .disclosureGroupStyle(C21_RowToggleDisclosureStyle())
        .padding()
        .frame(width: 260)
    }
}

private struct C21_ConfigurationDisclosureStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Toggle(isOn: configuration.$isExpanded) { configuration.label }
            configuration.content
                .opacity(configuration.isExpanded ? 1 : 0.25)
        }
    }
}

private struct C21_DisclosureConfigurationExample: View {
    @State private var isExpanded = true

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            DisclosureGroup("Notifications", isExpanded: $isExpanded) {
                Label("Badges, sounds, banners", systemImage: "bell.badge")
                    .font(.callout)
            }
            .disclosureGroupStyle(C21_ConfigurationDisclosureStyle())
            Text("label · content · isExpanded = \(isExpanded ? "true" : "false")")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(width: 260)
    }
}

// MARK: - .formStyle()

private struct C21_FormAutomaticExample: View {
    @State private var name = "Robin"
    @State private var sync = true

    var body: some View {
        Form {
            TextField("Name", text: $name)
            Toggle("Sync", isOn: $sync)
        }
        .formStyle(.automatic)
        .frame(width: 300, height: 130)
    }
}

private struct C21_FormGroupedExample: View {
    @State private var name = "Robin"
    @State private var sync = true

    var body: some View {
        Form {
            Section("Account") {
                TextField("Name", text: $name)
                Toggle("Sync", isOn: $sync)
            }
        }
        .formStyle(.grouped)
        .frame(width: 300, height: 150)
    }
}

private struct C21_FormColumnsExample: View {
    @State private var host = "example.org"
    @State private var port = 8080

    var body: some View {
        Form {
            TextField("Host", text: $host)
            TextField("Port", value: $port, format: .number)
        }
        .formStyle(.columns)
        .frame(width: 300)
        .padding()
    }
}

// MARK: - .gaugeStyle()

private struct C21_GaugeLinearCapacityExample: View {
    @State private var usedGB = 312.0
    private let capacityGB = 512.0

    var body: some View {
        VStack(spacing: 12) {
            Gauge(value: usedGB, in: 0...capacityGB) { Text("Storage") }
                .gaugeStyle(.linearCapacity)
            Slider(value: $usedGB, in: 0...capacityGB)
                .controlSize(.small)
            Text("\(Int(usedGB)) of \(Int(capacityGB)) GB used")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(width: 260)
    }
}

private struct C21_GaugeAccessoryLinearExample: View {
    @State private var temperature = 22.0

    var body: some View {
        VStack(spacing: 12) {
            Gauge(value: temperature, in: -10...40) { Text("°C") }
                .gaugeStyle(.accessoryLinear)
                .tint(Gradient(colors: [.blue, .red]))
            Slider(value: $temperature, in: -10...40)
                .controlSize(.small)
            Text(String(format: "%.0f °C", temperature))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(width: 240)
    }
}

private struct C21_GaugeAccessoryCircularExample: View {
    @State private var speed = 84.0

    var body: some View {
        VStack(spacing: 12) {
            Gauge(value: speed, in: 0...200) {
                Text("km/h")
            } currentValueLabel: {
                Text("\(Int(speed))")
            }
            .gaugeStyle(.accessoryCircular)
            .tint(.orange)
            Slider(value: $speed, in: 0...200)
                .controlSize(.small)
                .frame(width: 160)
        }
        .padding()
    }
}

private struct C21_GaugeAccessoryCircularCapacityExample: View {
    @State private var batteryLevel = 0.62

    var body: some View {
        VStack(spacing: 12) {
            Gauge(value: batteryLevel) {
                Text("\(Int(batteryLevel * 100))%")
            }
            .gaugeStyle(.accessoryCircularCapacity)
            .tint(batteryLevel < 0.2 ? .red : .green)
            Slider(value: $batteryLevel, in: 0...1)
                .controlSize(.small)
                .frame(width: 160)
        }
        .padding()
    }
}

// MARK: - .groupBoxStyle()

private struct C21_CalloutGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .top) {
            Image(systemName: "info.circle")
            VStack(alignment: .leading) {
                configuration.label.bold()
                configuration.content
            }
        }
        .padding()
        .background(.yellow.opacity(0.15), in: .rect(cornerRadius: 10))
    }
}

private struct C21_NetworkRows: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Label("Wi-Fi: Studio", systemImage: "wifi")
            Label("VPN: connected", systemImage: "lock.shield")
        }
        .font(.callout)
    }
}

private struct C21_GroupBoxAutomaticExample: View {
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            GroupBox("Network") { C21_NetworkRows() }
            GroupBox("Network") { C21_NetworkRows() }
                .groupBoxStyle(.automatic)
        }
        .groupBoxStyle(C21_CalloutGroupBoxStyle())
        .padding()
    }
}

private struct C21_GroupBoxMakeBodyExample: View {
    var body: some View {
        GroupBox("Heads up") {
            Text("Exports over 2 GB are split into parts.")
                .font(.callout)
        }
        .groupBoxStyle(C21_CalloutGroupBoxStyle())
        .padding()
        .frame(width: 280)
    }
}

private struct C21_CaptionBelowGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 4) {
            configuration.content
            configuration.label
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C21_GroupBoxConfigurationExample: View {
    var body: some View {
        HStack(spacing: 24) {
            GroupBox("CPU") {
                Image(systemName: "cpu")
                    .font(.largeTitle)
            }
            GroupBox("Memory") {
                Image(systemName: "memorychip")
                    .font(.largeTitle)
            }
        }
        .groupBoxStyle(C21_CaptionBelowGroupBoxStyle())
        .padding()
    }
}

// MARK: - .labelStyle()

private struct C21_LabelIconOnlyExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 18) {
                Label("Share", systemImage: "square.and.arrow.up")
                Label("Favorite", systemImage: "heart")
                Label("Delete", systemImage: "trash")
            }
            .labelStyle(.iconOnly)
            .font(.title3)
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(.quaternary.opacity(0.5), in: .capsule)
            Text("Titles stay available to VoiceOver")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C21_LabelTitleOnlyExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("Settings", systemImage: "gear")
                .labelStyle(.titleOnly)
            Label("Settings", systemImage: "gear")
                .foregroundStyle(.secondary)
            Text("Top: .titleOnly · bottom: default")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C21_LabelTitleAndIconExample: View {
    @State private var lastAction = "—"

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 16) {
                Menu("Actions") {
                    Button { lastAction = "Duplicate" } label: {
                        Label("Duplicate", systemImage: "plus.square.on.square")
                    }
                    Button { lastAction = "Rename" } label: {
                        Label("Rename", systemImage: "pencil")
                    }
                }
                Menu("Actions") {
                    Button { lastAction = "Duplicate" } label: {
                        Label("Duplicate", systemImage: "plus.square.on.square")
                    }
                    Button { lastAction = "Rename" } label: {
                        Label("Rename", systemImage: "pencil")
                    }
                }
                .labelStyle(.titleAndIcon)
            }
            .frame(width: 240)
            Text("Left: default · right: .titleAndIcon · last: \(lastAction)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C21_LabelAutomaticExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("Downloads", systemImage: "arrow.down.circle")
                .labelStyle(.automatic)
            HStack(spacing: 12) {
                Button { } label: {
                    Label("Downloads", systemImage: "arrow.down.circle")
                        .labelStyle(.automatic)
                }
                Menu {
                    Button("Clear list") { }
                } label: {
                    Label("Downloads", systemImage: "arrow.down.circle")
                        .labelStyle(.automatic)
                }
                .frame(width: 130)
            }
            Text("Same label: stand-alone, in a Button, and as a Menu title")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

// MARK: - .listStyle()

private struct C21_ListPlainExample: View {
    private let results = ["Aviary", "Avocet", "Avalanche", "Avenue"]

    var body: some View {
        List(results, id: \.self) { Text($0) }
            .listStyle(.plain)
            .frame(width: 240, height: 120)
    }
}

private struct C21_ListInsetExample: View {
    private let tracks = ["Overture", "Nocturne", "Finale"]

    var body: some View {
        List(tracks, id: \.self) { Label($0, systemImage: "music.note") }
            .listStyle(.inset)
            .frame(width: 240, height: 110)
    }
}

private struct C21_ListSidebarExample: View {
    private let folders = ["Inbox", "Drafts", "Archive"]
    @State private var selection: String? = "Inbox"

    var body: some View {
        List(selection: $selection) {
            Section("Library") {
                ForEach(folders, id: \.self) { Label($0, systemImage: "folder") }
            }
        }
        .listStyle(.sidebar)
        .frame(width: 200, height: 150)
    }
}

private struct C21_ListBorderedExample: View {
    private let devices = ["MacBook Pro", "Mac Studio", "iMac"]
    @State private var device: String? = "Mac Studio"

    var body: some View {
        List(devices, id: \.self, selection: $device) {
            Label($0, systemImage: "laptopcomputer")
        }
        .listStyle(.bordered)
        .frame(width: 240, height: 110)
        .padding()
    }
}

// MARK: - .menuStyle()

private struct C21_MenuAutomaticExample: View {
    @State private var sort = "By Name"

    var body: some View {
        VStack(spacing: 10) {
            Menu("Sort") {
                Button("By Name") { sort = "By Name" }
                Button("By Date") { sort = "By Date" }
                Button("By Size") { sort = "By Size" }
            }
            .menuStyle(.automatic)
            .frame(width: 120)
            Text("Sorted \(sort.lowercased())")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C21_MenuButtonExample: View {
    @State private var lastAction = "—"

    var body: some View {
        VStack(spacing: 10) {
            Menu("Options") {
                Button("Rename") { lastAction = "Rename" }
                Button("Delete", role: .destructive) { lastAction = "Delete" }
            }
            .menuStyle(.button)
            .buttonStyle(.bordered)
            .fixedSize()
            Text("Last action: \(lastAction)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C21_QuietMenuStyle: MenuStyle {
    func makeBody(configuration: Configuration) -> some View {
        Menu(configuration)
            .buttonStyle(.borderless)
            .foregroundStyle(.secondary)
    }
}

private struct C21_MenuMakeBodyExample: View {
    @State private var choice = "—"

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 20) {
                Menu("More") {
                    Button("Export…") { choice = "Export" }
                    Button("Print…") { choice = "Print" }
                }
                .fixedSize()
                Menu("More") {
                    Button("Export…") { choice = "Export" }
                    Button("Print…") { choice = "Print" }
                }
                .menuStyle(C21_QuietMenuStyle())
                .fixedSize()
            }
            Text("Left: default · right: Quiet · chose \(choice)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

// MARK: - .pickerStyle()

private enum C21_SortOrder: String, CaseIterable, Identifiable {
    case name, date, size
    var id: Self { self }
    var label: String { rawValue.capitalized }
}

private struct C21_PickerMenuExample: View {
    @State private var sort = C21_SortOrder.name

    var body: some View {
        VStack(spacing: 10) {
            Picker("Sort", selection: $sort) {
                ForEach(C21_SortOrder.allCases) { Text($0.label).tag($0) }
            }
            .pickerStyle(.menu)
            .frame(width: 180)
            Text("Sorting by \(sort.label.lowercased())")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private enum C21_Units: String { case metric, imperial }

private struct C21_PickerSegmentedExample: View {
    @State private var units = C21_Units.metric

    var body: some View {
        VStack(spacing: 10) {
            Picker("Units", selection: $units) {
                Text("Metric").tag(C21_Units.metric)
                Text("Imperial").tag(C21_Units.imperial)
            }
            .pickerStyle(.segmented)
            .frame(width: 220)
            Text(units == .metric ? "21 °C · 5 km" : "70 °F · 3.1 mi")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private enum C21_Format: String { case png, jpeg }

private struct C21_PickerRadioGroupExample: View {
    @State private var format = C21_Format.png

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Picker("Format", selection: $format) {
                Text("PNG").tag(C21_Format.png)
                Text("JPEG").tag(C21_Format.jpeg)
            }
            .pickerStyle(.radioGroup)
            Text("Exports as image.\(format.rawValue)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private enum C21_Theme: String, CaseIterable, Identifiable {
    case system, light, dark
    var id: Self { self }
    var name: String { rawValue.capitalized }
}

private struct C21_PickerInlineExample: View {
    @State private var theme = C21_Theme.system

    var body: some View {
        Form {
            Picker("Theme", selection: $theme) {
                ForEach(C21_Theme.allCases) { Text($0.name).tag($0) }
            }
            .pickerStyle(.inline)
        }
        .frame(width: 260, height: 140)
    }
}

// MARK: - .progressViewStyle()

private struct C21_ProgressLinearExample: View {
    @State private var sent = 42.0
    private let total = 128.0

    var body: some View {
        VStack(spacing: 12) {
            ProgressView("Uploading", value: sent, total: total)
                .progressViewStyle(.linear)
            HStack {
                Button("Send 16 MB") { withAnimation { sent = min(total, sent + 16) } }
                Button("Reset") { sent = 0 }
            }
            .controlSize(.small)
            Text("\(Int(sent)) of \(Int(total)) MB")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(width: 260)
    }
}

private struct C21_ProgressCircularExample: View {
    var body: some View {
        HStack(spacing: 32) {
            VStack(spacing: 6) {
                ProgressView()
                    .progressViewStyle(.circular)
                    .controlSize(.large)
                Text("indeterminate")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            VStack(spacing: 6) {
                ProgressView(value: 0.4)
                    .progressViewStyle(.circular)
                    .controlSize(.large)
                Text("value: 0.4")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
    }
}

private struct C21_ProgressAutomaticExample: View {
    var body: some View {
        VStack(spacing: 16) {
            ProgressView(value: 0.7)
                .progressViewStyle(.automatic)
            ProgressView()
                .progressViewStyle(.automatic)
        }
        .padding()
        .frame(width: 240)
    }
}
