//
//  ControlExtraDemos.swift
//  Aviary
//
//  Interactive demos for Gauge, DatePicker, label styles, and controlSize.
//

import SwiftUI

// MARK: - Gauge

struct GaugeDemo: View {
    private enum StyleChoice: String, CaseIterable, Identifiable {
        case linearCapacity, accessoryLinear, accessoryCircular, accessoryCircularCapacity
        var id: String { rawValue }
    }

    private enum TintChoice: String, CaseIterable, Identifiable {
        case blue, green, orange, gradient
        var id: String { rawValue }
    }

    @State private var value = 62.0
    @State private var style = StyleChoice.accessoryCircular
    @State private var tint = TintChoice.blue

    private var tintCode: String {
        switch tint {
        case .gradient: "Gradient(colors: [.green, .yellow, .red])"
        default: ".\(tint.rawValue)"
        }
    }

    private var liveCode: String {
        """
        Gauge(value: \(codeNumber(value, decimals: 0)), in: 0...100) {
            Text("Battery")
        }
        .gaugeStyle(.\(style.rawValue))
        .tint(\(tintCode))
        """
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            tintedGauge
                .frame(maxWidth: 220)
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "Value") {
                    Slider(value: $value, in: 0...100, step: 1)
                        .frame(width: 200)
                }
                DemoControlRow(label: "Style") {
                    Picker("", selection: $style) {
                        ForEach(StyleChoice.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .labelsHidden()
                    .fixedSize()
                }
                DemoControlRow(label: "Tint") {
                    Picker("", selection: $tint) {
                        ForEach(TintChoice.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .fixedSize()
                }
            }
        }
    }

    @ViewBuilder
    private var styledGauge: some View {
        let gauge = Gauge(value: value, in: 0...100) {
            Text("Battery")
        }
        switch style {
        case .linearCapacity: gauge.gaugeStyle(.linearCapacity)
        case .accessoryLinear: gauge.gaugeStyle(.accessoryLinear)
        case .accessoryCircular: gauge.gaugeStyle(.accessoryCircular)
        case .accessoryCircularCapacity: gauge.gaugeStyle(.accessoryCircularCapacity)
        }
    }

    @ViewBuilder
    private var tintedGauge: some View {
        switch tint {
        case .blue: styledGauge.tint(.blue)
        case .green: styledGauge.tint(.green)
        case .orange: styledGauge.tint(.orange)
        case .gradient: styledGauge.tint(Gradient(colors: [.green, .yellow, .red]))
        }
    }
}

// MARK: - DatePicker

struct DatePickerDemo: View {
    private enum StyleChoice: String, CaseIterable, Identifiable {
        case compact, graphical, field, stepperField
        var id: String { rawValue }
    }

    @State private var date = Date()
    @State private var style = StyleChoice.compact
    @State private var showsDate = true
    @State private var showsTime = false

    private var components: DatePickerComponents {
        // A DatePicker needs at least one component to show.
        var set = DatePickerComponents()
        if showsDate { set.insert(.date) }
        if showsTime { set.insert(.hourAndMinute) }
        return set.isEmpty ? [.date] : set
    }

    private var componentsCode: String {
        var names: [String] = []
        if showsDate { names.append(".date") }
        if showsTime { names.append(".hourAndMinute") }
        if names.isEmpty { names = [".date"] }
        return "[\(names.joined(separator: ", "))]"
    }

    private var liveCode: String {
        """
        DatePicker(
            "Departure",
            selection: $date,
            displayedComponents: \(componentsCode)
        )
        .datePickerStyle(.\(style.rawValue))
        """
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            styledPicker
                .fixedSize()
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "Style") {
                    Picker("", selection: $style) {
                        ForEach(StyleChoice.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .fixedSize()
                }
                DemoControlRow(label: "Components") {
                    Toggle("date", isOn: $showsDate)
                    Toggle("hourAndMinute", isOn: $showsTime)
                }
            }
        }
    }

    @ViewBuilder
    private var styledPicker: some View {
        let picker = DatePicker(
            "Departure",
            selection: $date,
            displayedComponents: components
        )
        switch style {
        case .compact: picker.datePickerStyle(.compact)
        case .graphical: picker.datePickerStyle(.graphical)
        case .field: picker.datePickerStyle(.field)
        case .stepperField: picker.datePickerStyle(.stepperField)
        }
    }
}

// MARK: - Label styles

struct LabelStyleDemo: View {
    private enum StyleChoice: String, CaseIterable, Identifiable {
        case titleAndIcon, iconOnly, titleOnly
        var id: String { rawValue }
    }

    @State private var style = StyleChoice.titleAndIcon

    private var liveCode: String {
        """
        VStack(alignment: .leading, spacing: 8) {
            Label("Wi-Fi", systemImage: "wifi")
            Label("Bluetooth", systemImage: "dot.radiowaves.left.and.right")
            Label("Battery", systemImage: "battery.75percent")
        }
        .labelStyle(.\(style.rawValue))
        """
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            styledLabels
        } controls: {
            DemoControlRow(label: "Style") {
                Picker("", selection: $style) {
                    ForEach(StyleChoice.allCases) { Text($0.rawValue).tag($0) }
                }
                .pickerStyle(.segmented)
                .labelsHidden()
                .fixedSize()
            }
        }
    }

    @ViewBuilder
    private var styledLabels: some View {
        let labels = VStack(alignment: .leading, spacing: 8) {
            Label("Wi-Fi", systemImage: "wifi")
            Label("Bluetooth", systemImage: "dot.radiowaves.left.and.right")
            Label("Battery", systemImage: "battery.75percent")
        }
        switch style {
        case .titleAndIcon: labels.labelStyle(.titleAndIcon)
        case .iconOnly: labels.labelStyle(.iconOnly)
        case .titleOnly: labels.labelStyle(.titleOnly)
        }
    }
}

// MARK: - controlSize

struct ControlSizeDemo: View {
    @State private var size = ControlSize.regular
    @State private var isOn = true
    @State private var fruit = "Apple"
    private let fruits = ["Apple", "Pear", "Plum"]

    private var sizeName: String {
        switch size {
        case .mini: "mini"
        case .small: "small"
        case .large: "large"
        case .extraLarge: "extraLarge"
        default: "regular"
        }
    }

    private var liveCode: String {
        """
        HStack(spacing: 16) {
            Button("Save") { … }
                .buttonStyle(.borderedProminent)
            Toggle("On", isOn: $isOn)
                .toggleStyle(.switch)
            Picker("Fruit", selection: $fruit) { … }
                .pickerStyle(.menu)
            ProgressView()
        }
        .controlSize(.\(sizeName))
        """
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            HStack(spacing: 16) {
                Button("Save") {}
                    .buttonStyle(.borderedProminent)
                Toggle("On", isOn: $isOn)
                    .toggleStyle(.switch)
                Picker("Fruit", selection: $fruit) {
                    ForEach(fruits, id: \.self) { Text($0) }
                }
                .pickerStyle(.menu)
                ProgressView()
            }
            .controlSize(size)
        } controls: {
            DemoControlRow(label: "Size") {
                Picker("", selection: $size) {
                    Text("mini").tag(ControlSize.mini)
                    Text("small").tag(ControlSize.small)
                    Text("regular").tag(ControlSize.regular)
                    Text("large").tag(ControlSize.large)
                    Text("extraLarge").tag(ControlSize.extraLarge)
                }
                .pickerStyle(.segmented)
                .labelsHidden()
                .fixedSize()
            }
        }
    }
}
