//
//  ControlDemos.swift
//  Aviary
//
//  Interactive demos for Button, Toggle, and Picker.
//

import SwiftUI

// MARK: - Button

struct ButtonDemo: View {
    private enum StyleChoice: String, CaseIterable, Identifiable {
        case automatic, bordered, borderedProminent, plain, link
        var id: String { rawValue }
    }

    @State private var style = StyleChoice.borderedProminent
    @State private var isDestructive = false
    @State private var size = ControlSize.regular
    @State private var tapCount = 0

    private var liveCode: String {
        let role = isDestructive ? "role: .destructive, " : ""
        return """
        Button("Press Me", \(role)action: { … })
            .buttonStyle(.\(style.rawValue))
            .controlSize(.\(sizeName))
        """
    }

    private var sizeName: String {
        switch size {
        case .mini: "mini"
        case .small: "small"
        case .large: "large"
        case .extraLarge: "extraLarge"
        default: "regular"
        }
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            VStack(spacing: 10) {
                styledButton
                    .controlSize(size)
                Text("Pressed \(tapCount) times")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "Style") {
                    Picker("", selection: $style) {
                        ForEach(StyleChoice.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .labelsHidden()
                    .fixedSize()
                }
                DemoControlRow(label: "Size") {
                    Picker("", selection: $size) {
                        Text("mini").tag(ControlSize.mini)
                        Text("small").tag(ControlSize.small)
                        Text("regular").tag(ControlSize.regular)
                        Text("large").tag(ControlSize.large)
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .fixedSize()
                }
                DemoControlRow(label: "Role") {
                    Toggle("Destructive", isOn: $isDestructive)
                }
            }
        }
    }

    @ViewBuilder
    private var styledButton: some View {
        let button = Button("Press Me", role: isDestructive ? .destructive : nil) {
            tapCount += 1
        }
        switch style {
        case .automatic: button.buttonStyle(.automatic)
        case .bordered: button.buttonStyle(.bordered)
        case .borderedProminent: button.buttonStyle(.borderedProminent)
        case .plain: button.buttonStyle(.plain)
        case .link: button.buttonStyle(.link)
        }
    }
}

// MARK: - Toggle

struct ToggleDemo: View {
    private enum StyleChoice: String, CaseIterable, Identifiable {
        case automatic, `switch`, checkbox, button
        var id: String { rawValue }
    }

    @State private var style = StyleChoice.switch
    @State private var isOn = true

    private var liveCode: String {
        """
        Toggle("Enabled", isOn: $isOn)
            .toggleStyle(.\(style.rawValue))
        """
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            styledToggle
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
    private var styledToggle: some View {
        let toggle = Toggle("Enabled", isOn: $isOn)
        switch style {
        case .automatic: toggle.toggleStyle(.automatic)
        case .switch: toggle.toggleStyle(.switch)
        case .checkbox: toggle.toggleStyle(.checkbox)
        case .button: toggle.toggleStyle(.button)
        }
    }
}

// MARK: - Picker

struct PickerDemo: View {
    private enum StyleChoice: String, CaseIterable, Identifiable {
        case automatic, menu, segmented, radioGroup, inline
        var id: String { rawValue }
    }

    @State private var style = StyleChoice.segmented
    @State private var flavor = "Vanilla"
    private let flavors = ["Vanilla", "Chocolate", "Mango"]

    private var liveCode: String {
        """
        Picker("Flavor", selection: $flavor) {
            ForEach(flavors, id: \\.self) { Text($0) }
        }
        .pickerStyle(.\(style.rawValue))
        """
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            VStack(spacing: 10) {
                styledPicker
                    .fixedSize()
                Text("Selected: \(flavor)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        } controls: {
            DemoControlRow(label: "Style") {
                Picker("", selection: $style) {
                    ForEach(StyleChoice.allCases) { Text($0.rawValue).tag($0) }
                }
                .labelsHidden()
                .fixedSize()
            }
        }
    }

    @ViewBuilder
    private var styledPicker: some View {
        let picker = Picker("Flavor", selection: $flavor) {
            ForEach(flavors, id: \.self) { Text($0) }
        }
        switch style {
        case .automatic: picker.pickerStyle(.automatic)
        case .menu: picker.pickerStyle(.menu)
        case .segmented: picker.pickerStyle(.segmented)
        case .radioGroup: picker.pickerStyle(.radioGroup)
        case .inline: picker.pickerStyle(.inline)
        }
    }
}
