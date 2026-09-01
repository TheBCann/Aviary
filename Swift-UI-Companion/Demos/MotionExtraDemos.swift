//
//  MotionExtraDemos.swift
//  Swift-UI-Companion
//
//  Interactive demos for view transitions, content transitions,
//  SF Symbol effects, and spring animations.
//

import SwiftUI

// MARK: - Transition

struct TransitionDemo: View {
    private enum TransitionChoice: String, CaseIterable, Identifiable {
        case opacity, scale, move, push, slide
        var id: String { rawValue }

        var code: String {
            switch self {
            case .opacity: ".opacity"
            case .scale: ".scale"
            case .move: ".move(edge: .leading)"
            case .push: ".push(from: .bottom)"
            case .slide: ".slide"
            }
        }

        var transition: AnyTransition {
            switch self {
            case .opacity: .opacity
            case .scale: .scale
            case .move: .move(edge: .leading)
            case .push: .push(from: .bottom)
            case .slide: .slide
            }
        }
    }

    @State private var choice = TransitionChoice.move
    @State private var combineOpacity = false
    @State private var showCard = true

    private var activeTransition: AnyTransition {
        combineOpacity ? choice.transition.combined(with: .opacity) : choice.transition
    }

    private var liveCode: String {
        let suffix = combineOpacity ? ".combined(with: .opacity)" : ""
        return """
        ZStack {
            if showCard {
                CardView()
                    .transition(\(choice.code)\(suffix))
            }
        }
        // Button: withAnimation(.easeInOut(duration: 0.45)) { showCard.toggle() }
        """
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            VStack(spacing: 14) {
                // Fixed-size stage: the layout never collapses, so the
                // card's entrance and exit stay easy to see.
                ZStack {
                    if showCard {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.blue.gradient)
                            .overlay {
                                Label("Card", systemImage: "rectangle.on.rectangle")
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 180, height: 90)
                            .transition(activeTransition)
                    }
                }
                .frame(width: 240, height: 110)
                .clipped()

                Button {
                    toggleCard()
                } label: {
                    Label("Toggle card", systemImage: "play.fill")
                }
                .buttonStyle(.borderedProminent)
            }
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "Transition") {
                    Picker("", selection: $choice) {
                        ForEach(TransitionChoice.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .labelsHidden()
                    .fixedSize()
                }
                DemoControlRow(label: "Combine") {
                    Toggle("combined with .opacity", isOn: $combineOpacity)
                }
            }
        }
        .onChange(of: choice) { toggleCard() }
        .onChange(of: combineOpacity) { toggleCard() }
    }

    private func toggleCard() {
        withAnimation(.easeInOut(duration: 0.45)) { showCard.toggle() }
    }
}

// MARK: - Content transition

struct ContentTransitionDemo: View {
    private enum TransitionChoice: String, CaseIterable, Identifiable {
        case numericText, opacity, identity
        var id: String { rawValue }
    }

    @State private var choice = TransitionChoice.numericText
    @State private var value = 250
    @State private var countsDown = false

    private var activeTransition: ContentTransition {
        switch choice {
        case .numericText: .numericText(countsDown: countsDown)
        case .opacity: .opacity
        case .identity: .identity
        }
    }

    private var transitionCode: String {
        switch choice {
        case .numericText: ".numericText(countsDown: \(countsDown))"
        case .opacity: ".opacity"
        case .identity: ".identity"
        }
    }

    private var liveCode: String {
        """
        Text("\(value)")
            .font(.system(size: 54, weight: .bold, design: .monospaced))
            .contentTransition(\(transitionCode))
            .animation(.default, value: value)
        """
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            VStack(spacing: 14) {
                Text("\(value)")
                    .font(.system(size: 54, weight: .bold, design: .monospaced))
                    .contentTransition(activeTransition)
                    .animation(.default, value: value)

                HStack(spacing: 12) {
                    Button {
                        change(to: value - 1)
                    } label: {
                        Image(systemName: "minus")
                    }
                    Button {
                        change(to: Int.random(in: 0...999))
                    } label: {
                        Label("Randomize", systemImage: "play.fill")
                    }
                    .buttonStyle(.borderedProminent)
                    Button {
                        change(to: value + 1)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        } controls: {
            DemoControlRow(label: "Transition") {
                Picker("", selection: $choice) {
                    ForEach(TransitionChoice.allCases) { Text($0.rawValue).tag($0) }
                }
                .pickerStyle(.segmented)
                .labelsHidden()
                .fixedSize()
            }
        }
        .onChange(of: choice) { change(to: Int.random(in: 0...999)) }
    }

    /// Records the change direction so numericText can roll the right way.
    private func change(to newValue: Int) {
        countsDown = newValue < value
        value = newValue
    }
}

// MARK: - SF Symbols

struct SymbolDemo: View {
    private enum RenderingChoice: String, CaseIterable, Identifiable {
        case monochrome, hierarchical, palette, multicolor
        var id: String { rawValue }

        var mode: SymbolRenderingMode {
            switch self {
            case .monochrome: .monochrome
            case .hierarchical: .hierarchical
            case .palette: .palette
            case .multicolor: .multicolor
            }
        }
    }

    private let symbols = ["wifi", "speaker.wave.3.fill", "antenna.radiowaves.left.and.right", "cloud.sun.rain.fill"]

    @State private var symbolName = "wifi"
    @State private var rendering = RenderingChoice.hierarchical
    @State private var bounceTrigger = 0
    @State private var variableActive = false

    private var liveCode: String {
        var lines = ["Image(systemName: \"\(symbolName)\")"]
        switch rendering {
        case .palette:
            lines.append("    .foregroundStyle(.blue, .orange, .green)")
        case .monochrome, .hierarchical:
            lines.append("    .foregroundStyle(.blue)")
        case .multicolor:
            break
        }
        lines.append("    .symbolRenderingMode(.\(rendering.rawValue))")
        lines.append("    .symbolEffect(.bounce, value: trigger)")
        if variableActive {
            lines.append("    .symbolEffect(.variableColor, isActive: true)")
        }
        return lines.joined(separator: "\n")
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            VStack(spacing: 16) {
                styledSymbol
                    .font(.system(size: 64))
                    .symbolRenderingMode(rendering.mode)
                    .symbolEffect(.bounce, value: bounceTrigger)
                    .symbolEffect(.variableColor, isActive: variableActive)
                    .frame(height: 80)

                Button {
                    bounceTrigger += 1
                } label: {
                    Label("Play", systemImage: "play.fill")
                }
                .buttonStyle(.borderedProminent)
            }
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "Symbol") {
                    Picker("", selection: $symbolName) {
                        ForEach(symbols, id: \.self) { Text($0).tag($0) }
                    }
                    .labelsHidden()
                    .fixedSize()
                }
                DemoControlRow(label: "Rendering") {
                    Picker("", selection: $rendering) {
                        ForEach(RenderingChoice.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .labelsHidden()
                    .fixedSize()
                }
                DemoControlRow(label: "Variable") {
                    Toggle("variable color active", isOn: $variableActive)
                }
            }
        }
        .onChange(of: symbolName) { bounceTrigger += 1 }
        .onChange(of: rendering) { bounceTrigger += 1 }
    }

    @ViewBuilder
    private var styledSymbol: some View {
        let image = Image(systemName: symbolName)
        switch rendering {
        case .palette:
            image.foregroundStyle(.blue, .orange, .green)
        case .monochrome, .hierarchical:
            image.foregroundStyle(.blue)
        case .multicolor:
            image
        }
    }
}

// MARK: - Spring

struct SpringDemo: View {
    @State private var duration = 0.6
    @State private var bounce = 0.4
    @State private var isDown = false

    private var liveCode: String {
        """
        Circle()
            .fill(.blue.gradient)
            .frame(width: 44, height: 44)
            .offset(y: isDown ? 35 : -35)
            .animation(
                .spring(duration: \(codeNumber(duration)), bounce: \(codeNumber(bounce))),
                value: isDown
            )
        """
    }

    var body: some View {
        DemoSection(liveCode: liveCode) {
            VStack(spacing: 12) {
                ZStack {
                    VStack {
                        guideLine
                        Spacer()
                        guideLine
                    }
                    Circle()
                        .fill(.blue.gradient)
                        .frame(width: 44, height: 44)
                        .offset(y: isDown ? 35 : -35)
                        .animation(
                            .spring(duration: duration, bounce: bounce),
                            value: isDown
                        )
                }
                .frame(width: 200, height: 190)

                Button {
                    isDown.toggle()
                } label: {
                    Label("Play", systemImage: "play.fill")
                }
                .buttonStyle(.borderedProminent)
            }
        } controls: {
            VStack(alignment: .leading, spacing: 10) {
                DemoControlRow(label: "Duration") {
                    Slider(value: $duration, in: 0.2...2) { editing in
                        if !editing { isDown.toggle() }
                    }
                    .frame(width: 160)
                    Text("\(codeNumber(duration))s")
                        .font(.callout.monospacedDigit())
                        .foregroundStyle(.secondary)
                }
                DemoControlRow(label: "Bounce") {
                    Slider(value: $bounce, in: 0...0.8) { editing in
                        if !editing { isDown.toggle() }
                    }
                    .frame(width: 160)
                    Text(codeNumber(bounce))
                        .font(.callout.monospacedDigit())
                        .foregroundStyle(.secondary)
                }
            }
        }
    }

    private var guideLine: some View {
        RoundedRectangle(cornerRadius: 1)
            .fill(.quaternary)
            .frame(width: 130, height: 2)
    }
}
