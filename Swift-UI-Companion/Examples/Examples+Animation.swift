//
//  Examples+Animation.swift
//  Swift-UI-Companion
//
//  Rendered usage examples for the entries in CatalogData/gen-animation.json.
//  Entries that already have an interactive demo (demoID) are not here.
//

import SwiftUI
import CoreGraphics

enum ExamplesAnimation {
    static let entries: [ExampleEntry] = [
        ExampleEntry(topic: ".animation(body:)", code: """
        RoundedRectangle(cornerRadius: 12)
            .fill(.blue)
            .animation(.smooth) { content in
                content.opacity(isDimmed ? 0.4 : 1)   // this fades
            }
            .scaleEffect(isDimmed ? 0.9 : 1)           // this snaps
        """) { AnyView(An_AnimationBodyExample()) },

        ExampleEntry(topic: ".defersSystemGestures()", code: """
        GameSurface()
            .ignoresSafeArea()
            .defersSystemGestures(on: .bottom)
        """) { AnyView(An_DefersSystemGesturesExample()) },

        ExampleEntry(topic: ".highPriorityGesture()", code: """
        Panel {
            Button("Inner button") { innerTaps += 1 }
        }
        .highPriorityGesture(
            TapGesture(count: 2).onEnded { panelTaps += 1 }
        )
        """) { AnyView(An_HighPriorityGestureExample()) },

        ExampleEntry(topic: ".keyframeAnimator()", code: """
        Image(systemName: "bell.fill")
            .keyframeAnimator(initialValue: ShakeValue(), trigger: alerts) { view, value in
                view.rotationEffect(.degrees(value.angle))
            } keyframes: { _ in
                KeyframeTrack(\\.angle) {
                    CubicKeyframe(-18, duration: 0.1)
                    SpringKeyframe(0, duration: 0.4, spring: .bouncy)
                }
            }
        """) { AnyView(An_KeyframeAnimatorExample()) },

        ExampleEntry(topic: ".onLongPressGesture()", code: """
        Tile()
            .scaleEffect(isPressing ? 0.95 : 1)
            .onLongPressGesture(minimumDuration: 0.4) {
                edits += 1
            } onPressingChanged: { pressing in
                isPressing = pressing
            }
        """) { AnyView(An_OnLongPressGestureExample()) },

        ExampleEntry(topic: ".onPencilDoubleTap()", code: """
        DrawingCanvas()
            .onPencilDoubleTap { _ in
                activeTool = activeTool.next()
            }
        """) { AnyView(An_OnPencilDoubleTapExample()) },

        ExampleEntry(topic: ".onPencilSqueeze()", code: """
        DrawingCanvas()
            .onPencilSqueeze { phase in
                if case .ended(let value) = phase {
                    paletteAnchor = value.hoverPose?.location
                    showPalette = true
                }
            }
        """) { AnyView(An_OnPencilSqueezeExample()) },

        ExampleEntry(topic: ".phaseAnimator()", code: """
        Image(systemName: "bell.fill")
            .phaseAnimator([0.0, -20.0, 14.0, 0.0], trigger: alerts) { view, angle in
                view.rotationEffect(.degrees(angle))
            } animation: { _ in
                .spring(duration: 0.2)
            }
        """) { AnyView(An_PhaseAnimatorExample()) },

        ExampleEntry(topic: ".simultaneousGesture()", code: """
        ScrollView {
            ArtworkGrid()
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0).onChanged { value in
                lastDrag = value.translation
            }
        )
        """) { AnyView(An_SimultaneousGestureModifierExample()) },

        ExampleEntry(topic: ".transaction()", code: """
        // Same withAnimation drives both circles.
        Circle().offset(x: moved ? 80 : 0)              // animates

        Circle().offset(x: moved ? 80 : 0)
            .transaction { $0.animation = nil }         // jumps
        """) { AnyView(An_TransactionModifierExample()) },

        ExampleEntry(topic: "AnimatableModifier", code: """
        // Deprecated spelling — kept only for reference:
        struct CountBadge: AnimatableModifier {
            var count: Double
            var animatableData: Double {
                get { count } set { count = newValue }
            }
            func body(content: Content) -> some View {
                content.overlay(Text("\\(Int(count))"))
            }
        }
        """) { AnyView(An_AnimatableModifierExample()) },

        ExampleEntry(topic: "AnimatablePair", code: """
        struct Wedge: Shape {
            var start: Double
            var end: Double
            var animatableData: AnimatablePair<Double, Double> {
                get { AnimatablePair(start, end) }
                set { (start, end) = (newValue.first, newValue.second) }
            }
            func path(in rect: CGRect) -> Path { arc(rect) }
        }
        """) { AnyView(An_AnimatablePairExample()) },

        ExampleEntry(topic: "Animation", code: """
        Circle()
            .scaleEffect(pulsing ? 1.25 : 0.85)
            .opacity(pulsing ? 0.4 : 1)
            .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true),
                       value: pulsing)
            .onAppear { pulsing = true }
        """) { AnyView(An_AnimationExample()) },

        ExampleEntry(topic: "Animation.bouncy", code: """
        let animation: Animation = switch preset {
        case .bouncy: .bouncy
        case .snappy: .snappy
        case .smooth: .smooth
        }
        withAnimation(animation) { moved.toggle() }
        """) { AnyView(An_AnimationBouncyExample()) },

        ExampleEntry(topic: "Animation.spring()", code: """
        // Classic parameterization:
        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
            expanded.toggle()
        }
        // 2023 perceptual parameterization:
        withAnimation(.spring(duration: 0.5, bounce: 0.3)) {
            expanded.toggle()
        }
        """) { AnyView(An_AnimationSpringExample()) },

        ExampleEntry(topic: "AnimationCompletionCriteria", code: """
        withAnimation(.easeOut, completionCriteria: .removed) {
            toastVisible = false
        } completion: {
            status = "queue.showNext()"
        }
        """) { AnyView(An_AnimationCompletionCriteriaExample()) },

        ExampleEntry(topic: "AnyGesture", code: """
        var activeGesture: AnyGesture<Void> {
            if mode == .draw {
                AnyGesture(DragGesture(minimumDistance: 0).map { _ in () })
            } else {
                AnyGesture(TapGesture().map { _ in () })
            }
        }

        Surface().gesture(activeGesture.onEnded { fires += 1 })
        """) { AnyView(An_AnyGestureExample()) },

        ExampleEntry(topic: "AnyTransition", code: """
        extension AnyTransition {
            static var slideAndFade: AnyTransition {
                .move(edge: .bottom).combined(with: .opacity)
            }
        }

        if show {
            DetailCard().transition(.slideAndFade)
        }
        """) { AnyView(An_AnyTransitionExample()) },

        ExampleEntry(topic: "ContentTransition", code: """
        Text(price, format: .currency(code: "USD"))
            .contentTransition(.numericText(value: price))
            .animation(.snappy, value: price)
        """) { AnyView(An_ContentTransitionExample()) },

        ExampleEntry(topic: "CubicKeyframe", code: """
        Circle()
            .keyframeAnimator(initialValue: 0.0, trigger: bounces) { view, y in
                view.offset(y: y)
            } keyframes: { _ in
                CubicKeyframe(-40, duration: 0.35)
                CubicKeyframe(0, duration: 0.45, endVelocity: 0)
            }
        """) { AnyView(An_CubicKeyframeExample()) },

        ExampleEntry(topic: "DragGesture", code: """
        @GestureState private var drag = CGSize.zero
        @State private var position = CGSize.zero

        Circle()
            .offset(x: position.width + drag.width, y: position.height + drag.height)
            .gesture(
                DragGesture()
                    .updating($drag) { value, state, _ in state = value.translation }
                    .onEnded { value in position += value.translation }
            )
        """) { AnyView(An_DragGestureExample()) },

        ExampleEntry(topic: "EmptyAnimatableData", code: """
        struct HatchFill: Shape, Animatable {
            var animatableData = EmptyAnimatableData()
            func path(in rect: CGRect) -> Path { hatchPath(in: rect) }
        }

        HatchFill().stroke(.blue, lineWidth: 2)
        """) { AnyView(An_EmptyAnimatableDataExample()) },

        ExampleEntry(topic: "ExclusiveGesture", code: """
        let tapOrPress = TapGesture()
            .exclusively(before: LongPressGesture(minimumDuration: 0.4))
            .onEnded { value in
                if case .first = value { result = "tap" }
                else { result = "long press" }
            }

        Swatch().gesture(tapOrPress)
        """) { AnyView(An_ExclusiveGestureExample()) },

        ExampleEntry(topic: "GestureMask", code: """
        Panel {
            Button("Inner") { innerTaps += 1 }
        }
        .gesture(
            TapGesture().onEnded { panelTaps += 1 },
            including: mask   // .all / .gesture / .subviews / .none
        )
        """) { AnyView(An_GestureMaskExample()) },

        ExampleEntry(topic: "KeyframeTimeline", code: """
        let timeline = KeyframeTimeline(initialValue: CGPoint.zero) {
            KeyframeTrack(\\.x) { LinearKeyframe(160, duration: 1.0) }
            KeyframeTrack(\\.y) { SpringKeyframe(60, duration: 1.4, spring: .bouncy) }
        }

        TimelineView(.animation) { context in
            let t = context.date.timeIntervalSince(start)
            let p = timeline.value(time: t.truncatingRemainder(dividingBy: timeline.duration))
            Circle().frame(width: 16).position(x: p.x + 20, y: p.y + 20)
        }
        """) { AnyView(An_KeyframeTimelineExample()) },

        ExampleEntry(topic: "KeyframeTrack", code: """
        Capsule()
            .keyframeAnimator(initialValue: Jump(), trigger: taps) { view, value in
                view.offset(y: value.offset)
            } keyframes: { _ in
                KeyframeTrack(\\.offset) {
                    CubicKeyframe(-60, duration: 0.3)
                    SpringKeyframe(0, duration: 0.5, spring: .bouncy)
                }
            }
        """) { AnyView(An_KeyframeTrackExample()) },

        ExampleEntry(topic: "LinearKeyframe", code: """
        Capsule()
            .keyframeAnimator(initialValue: 0.0, repeating: true) { view, p in
                view.scaleEffect(x: p, anchor: .leading)
            } keyframes: { _ in
                LinearKeyframe(1.0, duration: 0.8, timingCurve: .easeInOut)
                LinearKeyframe(0.0, duration: 0.8)
            }
        """) { AnyView(An_LinearKeyframeExample()) },

        ExampleEntry(topic: "LongPressGesture", code: """
        @GestureState private var isPressing = false

        Circle()
            .scaleEffect(isPressing ? 1.1 : 1)
            .gesture(
                LongPressGesture(minimumDuration: 0.5)
                    .updating($isPressing) { current, state, _ in state = current }
                    .onEnded { _ in options += 1 }
            )
        """) { AnyView(An_LongPressGestureExample()) },

        ExampleEntry(topic: "MagnificationGesture", code: """
        // Deprecated — MagnificationGesture, value is a bare scale factor:
        PhotoView()
            .scaleEffect(scale)
            .gesture(
                MagnificationGesture()
                    .onChanged { scale = $0 }
            )
        """) { AnyView(An_MagnificationGestureExample()) },

        ExampleEntry(topic: "MagnifyGesture", code: """
        @State private var zoom: CGFloat = 1
        @State private var base: CGFloat = 1

        PhotoView()
            .scaleEffect(zoom)
            .gesture(
                MagnifyGesture()
                    .onChanged { zoom = base * $0.magnification }
                    .onEnded { _ in base = zoom }
            )
        """) { AnyView(An_MagnifyGestureExample()) },

        ExampleEntry(topic: "MoveKeyframe", code: """
        Circle()
            .keyframeAnimator(initialValue: 1.0, trigger: flashes) { view, opacity in
                view.opacity(opacity)
            } keyframes: { _ in
                MoveKeyframe(0.0)               // jump, no interpolation
                LinearKeyframe(1.0, duration: 0.4)
            }
        """) { AnyView(An_MoveKeyframeExample()) },

        ExampleEntry(topic: "NavigationTransition", code: """
        NavigationLink(value: index) {
            Swatch(color).matchedTransitionSource(id: index, in: ns)
        }

        // destination
        DetailView(color)
            .navigationTransition(.zoom(sourceID: index, in: ns))
        """) { AnyView(An_NavigationTransitionExample()) },

        ExampleEntry(topic: "RotateGesture", code: """
        @State private var angle = Angle.zero
        @State private var base = Angle.zero

        KnobView()
            .rotationEffect(angle)
            .gesture(
                RotateGesture()
                    .onChanged { angle = base + $0.rotation }
                    .onEnded { _ in base = angle }
            )
        """) { AnyView(An_RotateGestureExample()) },

        ExampleEntry(topic: "RotationGesture", code: """
        // Deprecated — RotationGesture, value is a bare Angle:
        StickerView()
            .rotationEffect(twist)
            .gesture(
                RotationGesture()
                    .onChanged { twist = $0 }
            )
        """) { AnyView(An_RotationGestureExample()) },

        ExampleEntry(topic: "ScrollTransitionConfiguration", code: """
        ScrollView(.horizontal) {
            HStack(spacing: 14) {
                ForEach(cards) { card in
                    Card(card)
                        .scrollTransition(.interactive) { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1 : 0.3)
                                .scaleEffect(phase.isIdentity ? 1 : 0.8)
                        }
                }
            }
        }
        """) { AnyView(An_ScrollTransitionConfigurationExample()) },

        ExampleEntry(topic: "SequenceGesture", code: """
        let pressThenDrag = LongPressGesture(minimumDuration: 0.25)
            .sequenced(before: DragGesture())
            .updating($offset) { value, state, _ in
                if case .second(true, let drag?) = value { state = drag.translation }
            }
            .onEnded { value in
                if case .second(true, let drag?) = value { committed += drag.translation }
            }
        """) { AnyView(An_SequenceGestureExample()) },

        ExampleEntry(topic: "SimultaneousGesture", code: """
        let manipulate = MagnifyGesture()
            .simultaneously(with: RotateGesture())
            .onChanged { value in
                if let m = value.first?.magnification { zoom = m }
                if let r = value.second?.rotation { angle = r }
            }

        Sticker().scaleEffect(zoom).rotationEffect(angle).gesture(manipulate)
        """) { AnyView(An_SimultaneousGestureExample()) },

        ExampleEntry(topic: "SpatialEventGesture", code: """
        ParticleField()
            .gesture(
                SpatialEventGesture()
                    .onChanged { events in
                        points = events.filter { $0.phase == .active }.map(\\.location)
                    }
                    .onEnded { _ in points = [] }
            )
        """) { AnyView(An_SpatialEventGestureExample()) },

        ExampleEntry(topic: "SpatialTapGesture", code: """
        BoardView()
            .gesture(
                SpatialTapGesture()
                    .onEnded { value in
                        markers.append(value.location)
                    }
            )
        """) { AnyView(An_SpatialTapGestureExample()) },

        ExampleEntry(topic: "Spring", code: """
        let spring = Spring(duration: 0.6, bounce: 0.35)

        TimelineView(.animation) { context in
            let t = context.date.timeIntervalSince(start)
            let x = spring.value(target: 160.0, initialVelocity: 0.0, time: t)
            Circle().frame(width: 20).offset(x: x)
        }
        """) { AnyView(An_SpringExample()) },

        ExampleEntry(topic: "SpringKeyframe", code: """
        Image(systemName: "star.fill")
            .keyframeAnimator(initialValue: 1.0, trigger: pops) { view, scale in
                view.scaleEffect(scale)
            } keyframes: { _ in
                SpringKeyframe(1.4, duration: 0.2, spring: .bouncy)
                SpringKeyframe(1.0, spring: .smooth)
            }
        """) { AnyView(An_SpringKeyframeExample()) },

        ExampleEntry(topic: "TapGesture", code: """
        RoundedRectangle(cornerRadius: 16)
            .scaleEffect(zoomed ? 1.4 : 1)
            .animation(.snappy, value: zoomed)
            .contentShape(.rect)
            .gesture(
                TapGesture(count: 2).onEnded { zoomed.toggle() }
            )
        """) { AnyView(An_TapGestureExample()) },

        ExampleEntry(topic: "Transaction", code: """
        Button("Skip") {
            var t = Transaction()
            t.disablesAnimations = true
            withTransaction(t) { progress = 1.0 }   // jumps, no animation
        }
        """) { AnyView(An_TransactionExample()) },

        ExampleEntry(topic: "TransactionKey", code: """
        struct AvatarTapKey: TransactionKey {
            static let defaultValue = false
        }
        extension Transaction {
            var isAvatarTap: Bool {
                get { self[AvatarTapKey.self] }
                set { self[AvatarTapKey.self] = newValue }
            }
        }

        Avatar().transaction { if !$0.isAvatarTap { $0.animation = nil } }
        """) { AnyView(An_TransactionKeyExample()) },

        ExampleEntry(topic: "TransitionPhase", code: """
        struct Twirl: Transition {
            func body(content: Content, phase: TransitionPhase) -> some View {
                content
                    .rotationEffect(.degrees(phase.isIdentity ? 0 : 180))
                    .opacity(phase.isIdentity ? 1 : 0)
            }
        }

        if show { Badge().transition(Twirl()) }
        """) { AnyView(An_TransitionPhaseExample()) },

        ExampleEntry(topic: "UnitCurve", code: """
        let curve = UnitCurve.easeInOut
        let eased = curve.value(at: progress)   // reshape 0...1

        Capsule().frame(width: eased * trackWidth)   // eased
        Capsule().frame(width: progress * trackWidth) // linear
        """) { AnyView(An_UnitCurveExample()) },

        ExampleEntry(topic: "VectorArithmetic", code: """
        // Double conforms to VectorArithmetic:
        let width = 20.0.interpolated(towards: 180.0, amount: amount)

        Capsule().frame(width: width, height: 20)
        Slider(value: $amount, in: 0...1)
        """) { AnyView(An_VectorArithmeticExample()) },

        ExampleEntry(topic: "WindowDragGesture", code: """
        HStack {
            Text(documentName).font(.headline)
            Spacer()
        }
        .gesture(WindowDragGesture())   // dragging the bar moves the window
        """) { AnyView(An_WindowDragGestureExample()) },

        ExampleEntry(topic: "withAnimation()", code: """
        Button {
            withAnimation(.bouncy) {
                isFavorite.toggle()
            }
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .scaleEffect(isFavorite ? 1.2 : 1)
        }
        """) { AnyView(An_WithAnimationExample()) },

        ExampleEntry(topic: "withTransaction()", code: """
        // Full transaction:
        let t = Transaction(animation: .easeInOut(duration: 0.4))
        withTransaction(t) { index = next }

        // 2023 key-path shorthand:
        withTransaction(\\.disablesAnimations, true) { index = next }
        """) { AnyView(An_WithTransactionExample()) },
    ]
}

// MARK: - Shared helpers

private struct An_Caption: View {
    let text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
    }
}

// MARK: - .animation(body:)

private struct An_AnimationBodyExample: View {
    @State private var isDimmed = false

    var body: some View {
        VStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 12)
                .fill(.blue)
                .frame(width: 130, height: 80)
                .animation(.smooth) { content in
                    content.opacity(isDimmed ? 0.4 : 1)
                }
                .scaleEffect(isDimmed ? 0.9 : 1)

            Button("Toggle") { isDimmed.toggle() }
                .buttonStyle(.bordered)

            An_Caption("Opacity animates (inside the body); scale snaps (outside it).")
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 6)
    }
}

// MARK: - .defersSystemGestures()

private struct An_DefersSystemGesturesExample: View {
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                LinearGradient(colors: [.black, .indigo],
                               startPoint: .top, endPoint: .bottom)
                VStack(spacing: 6) {
                    Image(systemName: "gamecontroller.fill")
                        .font(.system(size: 34))
                        .foregroundStyle(.white)
                    Text("Immersive surface")
                        .font(.caption).foregroundStyle(.white.opacity(0.8))
                }
                VStack {
                    Spacer()
                    Capsule()
                        .fill(.white.opacity(0.5))
                        .frame(width: 90, height: 5)
                        .padding(.bottom, 6)
                }
            }
            .frame(height: 130)
            .clipShape(.rect(cornerRadius: 12))

            An_Caption("Illustrative — iOS only. The first bottom-edge swipe reaches your view instead of the home indicator.")
        }
    }
}

// MARK: - .highPriorityGesture()

private struct An_HighPriorityGestureExample: View {
    @State private var innerTaps = 0
    @State private var panelTaps = 0

    var body: some View {
        VStack(spacing: 12) {
            VStack(spacing: 8) {
                Image(systemName: "square.on.square")
                    .font(.title2)
                Button("Inner button") { innerTaps += 1 }
                    .buttonStyle(.borderedProminent)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 12))
            .highPriorityGesture(
                TapGesture(count: 2).onEnded { panelTaps += 1 }
            )

            Text("Panel double-taps: \(panelTaps)   ·   Inner taps: \(innerTaps)")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)

            An_Caption("Double-click the panel — the container gesture wins over the inner button.")
        }
    }
}

// MARK: - .keyframeAnimator()

private struct An_ShakeValue { var angle = 0.0 }

private struct An_KeyframeAnimatorExample: View {
    @State private var alerts = 0

    var body: some View {
        VStack(spacing: 14) {
            Image(systemName: "bell.fill")
                .font(.system(size: 44))
                .foregroundStyle(.orange)
                .keyframeAnimator(initialValue: An_ShakeValue(), trigger: alerts) { view, value in
                    view.rotationEffect(.degrees(value.angle), anchor: .top)
                } keyframes: { _ in
                    KeyframeTrack(\.angle) {
                        CubicKeyframe(-18, duration: 0.1)
                        SpringKeyframe(0, duration: 0.4, spring: .bouncy)
                    }
                }

            Button("Ring") { alerts += 1 }
                .buttonStyle(.bordered)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 6)
    }
}

// MARK: - .onLongPressGesture()

private struct An_OnLongPressGestureExample: View {
    @State private var isPressing = false
    @State private var edits = 0

    var body: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 14)
                .fill(isPressing ? Color.blue : Color.blue.opacity(0.7))
                .frame(width: 120, height: 80)
                .overlay(Image(systemName: "square.grid.2x2").foregroundStyle(.white))
                .scaleEffect(isPressing ? 0.95 : 1)
                .animation(.snappy, value: isPressing)
                .onLongPressGesture(minimumDuration: 0.4) {
                    edits += 1
                } onPressingChanged: { pressing in
                    isPressing = pressing
                }

            Text(isPressing ? "Pressing…" : "Idle   ·   entered edit mode \(edits)×")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)

            An_Caption("Press and hold the tile.")
        }
    }
}

// MARK: - .onPencilDoubleTap()

private enum An_PencilTool: String, CaseIterable {
    case pen, eraser, highlighter
    var symbol: String {
        switch self {
        case .pen: "pencil.tip"
        case .eraser: "eraser"
        case .highlighter: "highlighter"
        }
    }
    func next() -> An_PencilTool {
        let all = An_PencilTool.allCases
        let i = all.firstIndex(of: self) ?? 0
        return all[(i + 1) % all.count]
    }
}

private struct An_OnPencilDoubleTapExample: View {
    @State private var activeTool: An_PencilTool = .pen

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 16) {
                ForEach(An_PencilTool.allCases, id: \.self) { tool in
                    Image(systemName: tool.symbol)
                        .font(.title3)
                        .foregroundStyle(tool == activeTool ? Color.accentColor : .secondary)
                        .padding(8)
                        .background(tool == activeTool ? Color.accentColor.opacity(0.15) : .clear,
                                    in: .rect(cornerRadius: 8))
                }
            }
            .padding(8)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 12))

            Button("Simulate barrel double-tap") { activeTool = activeTool.next() }
                .buttonStyle(.bordered)

            An_Caption("Illustrative — iOS / Apple Pencil only. On device, double-tapping the barrel cycles the tool.")
        }
    }
}

// MARK: - .onPencilSqueeze()

private struct An_OnPencilSqueezeExample: View {
    @State private var showPalette = false

    var body: some View {
        VStack(spacing: 12) {
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.background)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(.quaternary))
                    .frame(height: 90)
                    .overlay(Text("Canvas").font(.caption).foregroundStyle(.secondary))

                if showPalette {
                    HStack(spacing: 6) {
                        ForEach([Color.red, .green, .blue, .orange], id: \.self) { c in
                            Circle().fill(c).frame(width: 16, height: 16)
                        }
                    }
                    .padding(6)
                    .background(.thinMaterial, in: .capsule)
                    .padding(8)
                    .transition(.scale.combined(with: .opacity))
                }
            }

            Button(showPalette ? "Hide palette" : "Simulate squeeze") {
                withAnimation(.snappy) { showPalette.toggle() }
            }
            .buttonStyle(.bordered)

            An_Caption("Illustrative — iOS / Apple Pencil Pro only. A squeeze reveals UI near the pencil tip.")
        }
    }
}

// MARK: - .phaseAnimator()

private struct An_PhaseAnimatorExample: View {
    @State private var alerts = 0

    var body: some View {
        VStack(spacing: 14) {
            Image(systemName: "bell.fill")
                .font(.system(size: 44))
                .foregroundStyle(.red)
                .phaseAnimator([0.0, -20.0, 14.0, 0.0], trigger: alerts) { view, angle in
                    view.rotationEffect(.degrees(angle), anchor: .top)
                } animation: { _ in
                    .spring(duration: 0.2)
                }

            Button("Alert") { alerts += 1 }
                .buttonStyle(.bordered)

            An_Caption("Each tap plays the phase sequence once.")
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 6)
    }
}

// MARK: - .simultaneousGesture()

private struct An_SimultaneousGestureModifierExample: View {
    @State private var lastDrag = CGSize.zero

    var body: some View {
        VStack(spacing: 10) {
            ScrollView {
                VStack(spacing: 6) {
                    ForEach(0..<14, id: \.self) { i in
                        HStack {
                            Image(systemName: "photo").foregroundStyle(.secondary)
                            Text("Artwork \(i + 1)")
                            Spacer()
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 6)
                        .background(.quaternary.opacity(0.4), in: .rect(cornerRadius: 6))
                    }
                }
                .padding(.horizontal, 6)
            }
            .frame(height: 120)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0).onChanged { value in
                    lastDrag = value.translation
                }
            )

            Text(String(format: "observed drag  Δx %.0f  Δy %.0f", lastDrag.width, lastDrag.height))
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)

            An_Caption("The list still scrolls while the drag is observed alongside it.")
        }
    }
}

// MARK: - .transaction()

private struct An_TransactionModifierExample: View {
    @State private var moved = false

    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 14) {
                row("animates") {
                    Circle().fill(.blue).frame(width: 26, height: 26)
                        .offset(x: moved ? 90 : 0)
                }
                row("nil animation") {
                    Circle().fill(.orange).frame(width: 26, height: 26)
                        .offset(x: moved ? 90 : 0)
                        .transaction { $0.animation = nil }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Button("Toggle") {
                withAnimation(.bouncy(duration: 0.7)) { moved.toggle() }
            }
            .buttonStyle(.bordered)
        }
        .padding(.vertical, 6)
    }

    private func row<Content: View>(_ label: String, @ViewBuilder _ content: () -> Content) -> some View {
        HStack(spacing: 10) {
            Text(label)
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
                .frame(width: 96, alignment: .leading)
            content()
            Spacer(minLength: 0)
        }
    }
}

// MARK: - AnimatableModifier (deprecated → modern spelling rendered)

private struct An_CountEffect: ViewModifier, Animatable {
    var count: Double
    var animatableData: Double {
        get { count }
        set { count = newValue }
    }
    func body(content: Content) -> some View {
        content.overlay(
            Text("\(Int(count.rounded()))")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .monospacedDigit()
                .foregroundStyle(.white)
        )
    }
}

private struct An_AnimatableModifierExample: View {
    @State private var value = 0

    var body: some View {
        VStack(spacing: 14) {
            Circle()
                .fill(.blue.gradient)
                .frame(width: 84, height: 84)
                .modifier(An_CountEffect(count: Double(value)))
                .animation(.smooth(duration: 0.6), value: value)

            Button("Add 25") { value += 25 }
                .buttonStyle(.bordered)

            An_Caption("AnimatableModifier is deprecated — rendered with a ViewModifier that conforms to Animatable, the supported spelling. The count interpolates.")
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 6)
    }
}

// MARK: - AnimatablePair

private struct An_Wedge: Shape {
    var start: Double
    var end: Double
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(start, end) }
        set { (start, end) = (newValue.first, newValue.second) }
    }
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        p.move(to: center)
        p.addArc(center: center, radius: radius,
                 startAngle: .degrees(start), endAngle: .degrees(end), clockwise: false)
        p.closeSubpath()
        return p
    }
}

private struct An_AnimatablePairExample: View {
    @State private var open = false

    var body: some View {
        VStack(spacing: 14) {
            An_Wedge(start: -90, end: open ? 250 : -60)
                .fill(.purple.gradient)
                .frame(width: 100, height: 100)
                .animation(.smooth(duration: 0.7), value: open)

            Button(open ? "Collapse" : "Sweep") { open.toggle() }
                .buttonStyle(.bordered)

            An_Caption("Both wedge angles animate together through AnimatablePair.")
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 6)
    }
}

// MARK: - Animation

private struct An_AnimationExample: View {
    @State private var pulsing = false

    var body: some View {
        VStack(spacing: 12) {
            Circle()
                .fill(.blue)
                .frame(width: 64, height: 64)
                .scaleEffect(pulsing ? 1.25 : 0.85)
                .opacity(pulsing ? 0.4 : 1)
                .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true),
                           value: pulsing)
                .onAppear { pulsing = true }

            An_Caption("An Animation value composed with .repeatForever(autoreverses:).")
        }
        .frame(height: 120)
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Animation.bouncy

private enum An_Preset: String, CaseIterable, Identifiable {
    case bouncy, snappy, smooth
    var id: Self { self }
    var animation: Animation {
        switch self {
        case .bouncy: .bouncy
        case .snappy: .snappy
        case .smooth: .smooth
        }
    }
}

private struct An_AnimationBouncyExample: View {
    @State private var preset: An_Preset = .bouncy
    @State private var moved = false

    var body: some View {
        VStack(spacing: 12) {
            Picker("Preset", selection: $preset) {
                ForEach(An_Preset.allCases) { Text(".\($0.rawValue)").tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            HStack {
                Circle()
                    .fill(.green)
                    .frame(width: 34, height: 34)
                    .offset(x: moved ? 120 : 0)
                Spacer()
            }
            .frame(height: 40)

            Button("Move with \(preset.rawValue)") {
                withAnimation(preset.animation) { moved.toggle() }
            }
            .buttonStyle(.bordered)
        }
        .padding(.vertical, 6)
    }
}

// MARK: - Animation.spring()

private struct An_AnimationSpringExample: View {
    @State private var expanded = false

    var body: some View {
        VStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 16)
                .fill(.teal.gradient)
                .frame(width: expanded ? 180 : 90, height: 80)

            Button(expanded ? "Contract" : "Expand") {
                withAnimation(.spring(duration: 0.5, bounce: 0.35)) { expanded.toggle() }
            }
            .buttonStyle(.bordered)

            An_Caption("Rendered with .spring(duration:bounce:) — the 2023 perceptual form.")
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 6)
    }
}

// MARK: - AnimationCompletionCriteria

private struct An_AnimationCompletionCriteriaExample: View {
    @State private var toastVisible = true
    @State private var status = "—"

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                if toastVisible {
                    Label("Saved", systemImage: "checkmark.circle.fill")
                        .padding(.horizontal, 14).padding(.vertical, 8)
                        .background(.green.opacity(0.2), in: .capsule)
                        .transition(.opacity)
                }
            }
            .frame(height: 44)

            HStack {
                Button("Dismiss") {
                    withAnimation(.easeOut, completionCriteria: .removed) {
                        toastVisible = false
                    } completion: {
                        status = "queue.showNext()"
                    }
                }
                Button("Reset") {
                    status = "—"
                    withAnimation { toastVisible = true }
                }
            }
            .buttonStyle(.bordered)

            Text("completion fired: \(status)")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)

            An_Caption(".removed waits until the animation is fully torn down before the handler runs.")
        }
        .padding(.vertical, 6)
    }
}

// MARK: - AnyGesture

private enum An_GestureMode: String { case draw, tap }

private struct An_AnyGestureExample: View {
    @State private var mode: An_GestureMode = .tap
    @State private var fires = 0

    private var activeGesture: AnyGesture<Void> {
        if mode == .draw {
            AnyGesture(DragGesture(minimumDistance: 0).map { _ in () })
        } else {
            AnyGesture(TapGesture().map { _ in () })
        }
    }

    var body: some View {
        VStack(spacing: 12) {
            Picker("Mode", selection: $mode) {
                Text("tap").tag(An_GestureMode.tap)
                Text("draw (drag)").tag(An_GestureMode.draw)
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            RoundedRectangle(cornerRadius: 12)
                .fill(.indigo.opacity(0.15))
                .overlay(Text(mode == .tap ? "Click me" : "Drag me").foregroundStyle(.secondary))
                .frame(height: 70)
                .contentShape(.rect)
                .gesture(activeGesture.onEnded { _ in fires += 1 })

            Text("gesture fired: \(fires)")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)

            An_Caption("One property returns either recognizer, erased to AnyGesture<Void>.")
        }
        .padding(.vertical, 6)
    }
}

// MARK: - AnyTransition

private extension AnyTransition {
    static var an_slideAndFade: AnyTransition {
        .move(edge: .bottom).combined(with: .opacity)
    }
}

private struct An_AnyTransitionExample: View {
    @State private var show = false

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                if show {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.blue.gradient)
                        .frame(width: 160, height: 70)
                        .overlay(Text("Detail").foregroundStyle(.white))
                        .transition(.an_slideAndFade)
                }
            }
            .frame(height: 80)

            Button(show ? "Remove" : "Insert") {
                withAnimation(.smooth(duration: 0.5)) { show.toggle() }
            }
            .buttonStyle(.bordered)

            An_Caption("A custom AnyTransition composed with .combined(with:).")
        }
        .padding(.vertical, 6)
    }
}

// MARK: - ContentTransition

private struct An_ContentTransitionExample: View {
    @State private var price = 42.0

    var body: some View {
        VStack(spacing: 14) {
            Text(price, format: .currency(code: "USD"))
                .font(.system(size: 40, weight: .semibold, design: .rounded))
                .contentTransition(.numericText(value: price))
                .animation(.snappy, value: price)

            HStack {
                Button("−5") { price = max(0, price - 5) }
                Button("+5") { price += 5 }
            }
            .buttonStyle(.bordered)

            An_Caption("numericText(value:) rolls the changed digits in the right direction.")
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 6)
    }
}

// MARK: - CubicKeyframe

private struct An_CubicKeyframeExample: View {
    @State private var bounces = 0

    var body: some View {
        VStack(spacing: 14) {
            Circle()
                .fill(.orange)
                .frame(width: 40, height: 40)
                .keyframeAnimator(initialValue: 0.0, trigger: bounces) { view, y in
                    view.offset(y: y)
                } keyframes: { _ in
                    CubicKeyframe(-40, duration: 0.35)
                    CubicKeyframe(0, duration: 0.45, endVelocity: 0)
                }

            Button("Hop") { bounces += 1 }
                .buttonStyle(.bordered)

            An_Caption("Adjacent cubic keyframes blend velocity into a smooth arc.")
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 6)
    }
}

// MARK: - DragGesture

private struct An_DragGestureExample: View {
    @GestureState private var drag = CGSize.zero
    @State private var position = CGSize.zero

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 12).fill(.quaternary.opacity(0.4))
                Circle()
                    .fill(.blue)
                    .frame(width: 54, height: 54)
                    .offset(x: position.width + drag.width, y: position.height + drag.height)
                    .gesture(
                        DragGesture()
                            .updating($drag) { value, state, _ in state = value.translation }
                            .onEnded { value in
                                position.width += value.translation.width
                                position.height += value.translation.height
                            }
                    )
            }
            .frame(height: 150)

            An_Caption("Drag the circle. @GestureState resets the live offset when the drag ends.")
        }
    }
}

// MARK: - EmptyAnimatableData

private struct An_Hatch: Shape, Animatable {
    var animatableData = EmptyAnimatableData()
    func path(in rect: CGRect) -> Path {
        var p = Path()
        var x = rect.minX - rect.height
        while x < rect.maxX {
            p.move(to: CGPoint(x: x, y: rect.maxY))
            p.addLine(to: CGPoint(x: x + rect.height, y: rect.minY))
            x += 12
        }
        return p
    }
}

private struct An_EmptyAnimatableDataExample: View {
    var body: some View {
        VStack(spacing: 12) {
            An_Hatch()
                .stroke(.blue, lineWidth: 2)
                .frame(height: 90)
                .clipShape(.rect(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.quaternary))

            An_Caption("This Shape adopts Animatable but has nothing to interpolate, so animatableData is EmptyAnimatableData.")
        }
        .padding(.vertical, 6)
    }
}

// MARK: - ExclusiveGesture

private struct An_ExclusiveGestureExample: View {
    @State private var result = "—"

    var body: some View {
        VStack(spacing: 12) {
            let tapOrPress = TapGesture()
                .exclusively(before: LongPressGesture(minimumDuration: 0.4))
                .onEnded { value in
                    if case .first = value { result = "tap" }
                    else { result = "long press" }
                }

            RoundedRectangle(cornerRadius: 14)
                .fill(.mint.gradient)
                .frame(width: 130, height: 80)
                .overlay(Image(systemName: "hand.tap").foregroundStyle(.white))
                .gesture(tapOrPress)

            Text("recognized: \(result)")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)

            An_Caption("Tap quickly, or press and hold — only one gesture can win, tap first.")
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 6)
    }
}

// MARK: - GestureMask

private enum An_MaskChoice: String, CaseIterable, Identifiable {
    case all, gesture, subviews, none
    var id: Self { self }
    var mask: GestureMask {
        switch self {
        case .all: .all
        case .gesture: .gesture
        case .subviews: .subviews
        case .none: .none
        }
    }
}

private struct An_GestureMaskExample: View {
    @State private var choice: An_MaskChoice = .all
    @State private var panelTaps = 0
    @State private var innerTaps = 0

    var body: some View {
        VStack(spacing: 10) {
            Picker("Mask", selection: $choice) {
                ForEach(An_MaskChoice.allCases) { Text(".\($0.rawValue)").tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            VStack(spacing: 8) {
                Button("Inner button") { innerTaps += 1 }
                    .buttonStyle(.borderedProminent)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 12))
            .gesture(TapGesture().onEnded { panelTaps += 1 }, including: choice.mask)

            Text("panel: \(panelTaps)   ·   inner: \(innerTaps)")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)

            An_Caption(".gesture silences the button; .subviews benches the panel tap; .none disables both.")
        }
        .padding(.vertical, 4)
    }
}

// MARK: - KeyframeTimeline

private struct An_KeyframeTimelineExample: View {
    @State private var start = Date()
    private let timeline = KeyframeTimeline(initialValue: CGPoint.zero) {
        KeyframeTrack(\.x) { LinearKeyframe(160, duration: 1.0) }
        KeyframeTrack(\.y) { SpringKeyframe(60, duration: 1.4, spring: .bouncy) }
    }

    var body: some View {
        VStack(spacing: 10) {
            TimelineView(.animation) { context in
                let elapsed = context.date.timeIntervalSince(start)
                let t = elapsed.truncatingRemainder(dividingBy: timeline.duration)
                let p = timeline.value(time: t)
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 10).fill(.quaternary.opacity(0.35))
                    Circle()
                        .fill(.purple)
                        .frame(width: 18, height: 18)
                        .offset(x: p.x + 12, y: p.y + 12)
                }
            }
            .frame(height: 110)

            An_Caption("A standalone KeyframeTimeline sampled with value(time:) inside TimelineView.")
        }
        .padding(.vertical, 4)
    }
}

// MARK: - KeyframeTrack

private struct An_Jump { var offset = 0.0 }

private struct An_KeyframeTrackExample: View {
    @State private var taps = 0

    var body: some View {
        VStack(spacing: 14) {
            Capsule()
                .fill(.pink)
                .frame(width: 46, height: 46)
                .keyframeAnimator(initialValue: An_Jump(), trigger: taps) { view, value in
                    view.offset(y: value.offset)
                } keyframes: { _ in
                    KeyframeTrack(\.offset) {
                        CubicKeyframe(-60, duration: 0.3)
                        SpringKeyframe(0, duration: 0.5, spring: .bouncy)
                    }
                }

            Button("Jump") { taps += 1 }
                .buttonStyle(.bordered)

            An_Caption("KeyframeTrack(\\.offset) binds the keyframes to one property of the animated value.")
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 6)
    }
}

// MARK: - LinearKeyframe

private struct An_LinearKeyframeExample: View {
    var body: some View {
        VStack(spacing: 12) {
            Capsule()
                .fill(.green)
                .frame(width: 180, height: 16)
                .keyframeAnimator(initialValue: 0.0, repeating: true) { view, p in
                    view.scaleEffect(x: max(0.001, p), anchor: .leading)
                } keyframes: { _ in
                    LinearKeyframe(1.0, duration: 0.8, timingCurve: .easeInOut)
                    LinearKeyframe(0.0, duration: 0.8)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

            An_Caption("Constant-rate segments, shaped here by a timingCurve, loop continuously.")
        }
        .padding(.vertical, 6)
    }
}

// MARK: - LongPressGesture

private struct An_LongPressGestureExample: View {
    @GestureState private var isPressing = false
    @State private var options = 0

    var body: some View {
        VStack(spacing: 12) {
            Circle()
                .fill(isPressing ? .blue : .blue.opacity(0.7))
                .frame(width: 74, height: 74)
                .overlay(Image(systemName: "hand.point.up.left.fill").foregroundStyle(.white))
                .scaleEffect(isPressing ? 1.1 : 1)
                .animation(.snappy, value: isPressing)
                .gesture(
                    LongPressGesture(minimumDuration: 0.5)
                        .updating($isPressing) { current, state, _ in state = current }
                        .onEnded { _ in options += 1 }
                )

            Text(isPressing ? "holding…" : "options shown \(options)×")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)

            An_Caption("@GestureState drives the pressed look before the press completes.")
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 6)
    }
}

// MARK: - MagnificationGesture (deprecated → MagnifyGesture rendered)

private struct An_MagnificationGestureExample: View {
    @State private var zoom: CGFloat = 1

    var body: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 14)
                .fill(.blue.gradient)
                .frame(width: 70, height: 70)
                .scaleEffect(zoom)
                .frame(height: 130)
                .gesture(
                    MagnifyGesture()
                        .onChanged { zoom = $0.magnification }
                        .onEnded { _ in withAnimation(.snappy) { zoom = 1 } }
                )

            An_Caption("MagnificationGesture is deprecated — rendered with MagnifyGesture. Pinch on a trackpad to zoom.")
        }
        .padding(.vertical, 6)
    }
}

// MARK: - MagnifyGesture

private struct An_MagnifyGestureExample: View {
    @State private var zoom: CGFloat = 1
    @State private var base: CGFloat = 1

    var body: some View {
        VStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 14)
                .fill(.orange.gradient)
                .frame(width: 70, height: 70)
                .overlay(Image(systemName: "photo").foregroundStyle(.white))
                .scaleEffect(zoom)
                .frame(height: 140)
                .gesture(
                    MagnifyGesture()
                        .onChanged { zoom = base * $0.magnification }
                        .onEnded { _ in base = zoom }
                )

            Text(String(format: "zoom ×%.2f", zoom))
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)

            An_Caption("Pinch on a trackpad. The value also carries velocity and a start anchor.")
        }
        .padding(.vertical, 6)
    }
}

// MARK: - MoveKeyframe

private struct An_MoveKeyframeExample: View {
    @State private var flashes = 0

    var body: some View {
        VStack(spacing: 14) {
            Circle()
                .fill(.yellow)
                .frame(width: 56, height: 56)
                .overlay(Image(systemName: "bolt.fill").foregroundStyle(.orange))
                .keyframeAnimator(initialValue: 1.0, trigger: flashes) { view, opacity in
                    view.opacity(opacity)
                } keyframes: { _ in
                    MoveKeyframe(0.0)
                    LinearKeyframe(1.0, duration: 0.4)
                }

            Button("Flash") { flashes += 1 }
                .buttonStyle(.bordered)

            An_Caption("MoveKeyframe jumps instantly to 0, then a linear keyframe fades back in.")
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 6)
    }
}

// MARK: - NavigationTransition

private struct An_NavigationTransitionExample: View {
    @Namespace private var ns
    @State private var selected: Int? = nil
    private let colors: [Color] = [.pink, .orange, .teal, .indigo, .green, .purple]

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                if let sel = selected {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(colors[sel].gradient)
                        .matchedGeometryEffect(id: sel, in: ns)
                        .overlay(Text("Detail \(sel + 1)").font(.title).foregroundStyle(.white))
                        .frame(height: 150)
                        .onTapGesture { withAnimation(.smooth(duration: 0.45)) { selected = nil } }
                } else {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 56), spacing: 12)], spacing: 12) {
                        ForEach(colors.indices, id: \.self) { i in
                            RoundedRectangle(cornerRadius: 12)
                                .fill(colors[i].gradient)
                                .matchedGeometryEffect(id: i, in: ns)
                                .frame(height: 56)
                                .onTapGesture { withAnimation(.smooth(duration: 0.45)) { selected = i } }
                        }
                    }
                    .padding(6)
                }
            }
            .frame(height: 160)

            An_Caption("Illustrative — the .zoom navigation transition is iOS only. This mock uses matchedGeometryEffect to mimic the morph. Tap a swatch.")
        }
    }
}

// MARK: - RotateGesture

private struct An_RotateGestureExample: View {
    @State private var angle = Angle.zero
    @State private var base = Angle.zero

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "dial.medium.fill")
                .font(.system(size: 66))
                .foregroundStyle(.teal)
                .rotationEffect(angle)
                .frame(height: 110)
                .gesture(
                    RotateGesture()
                        .onChanged { angle = base + $0.rotation }
                        .onEnded { _ in base = angle }
                )

            Text(String(format: "%.0f°", angle.degrees))
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)

            An_Caption("Rotate with two fingers on a trackpad. The value reports an Angle plus an anchor.")
        }
        .padding(.vertical, 6)
    }
}

// MARK: - RotationGesture (deprecated → RotateGesture rendered)

private struct An_RotationGestureExample: View {
    @State private var twist = Angle.zero
    @State private var base = Angle.zero

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "seal.fill")
                .font(.system(size: 62))
                .foregroundStyle(.pink)
                .rotationEffect(twist)
                .frame(height: 110)
                .gesture(
                    RotateGesture()
                        .onChanged { twist = base + $0.rotation }
                        .onEnded { _ in base = twist }
                )

            An_Caption("RotationGesture is deprecated — rendered with RotateGesture. Twist on a trackpad.")
        }
        .padding(.vertical, 6)
    }
}

// MARK: - ScrollTransitionConfiguration

private struct An_ScrollTransitionConfigurationExample: View {
    private let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .indigo, .purple]

    var body: some View {
        VStack(spacing: 8) {
            ScrollView(.horizontal) {
                HStack(spacing: 14) {
                    ForEach(colors.indices, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 14)
                            .fill(colors[i].gradient)
                            .frame(width: 84, height: 110)
                            .scrollTransition(.interactive) { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1 : 0.3)
                                    .scaleEffect(phase.isIdentity ? 1 : 0.8)
                            }
                    }
                }
                .scrollTargetLayout()
                .padding(.horizontal, 20)
            }
            .frame(height: 130)

            An_Caption("Scroll sideways — .interactive tracks each card's visibility and reshapes it continuously.")
        }
    }
}

// MARK: - SequenceGesture

private struct An_SequenceGestureExample: View {
    @GestureState private var offset = CGSize.zero
    @State private var committed = CGSize.zero

    var body: some View {
        VStack(spacing: 10) {
            let pressThenDrag = LongPressGesture(minimumDuration: 0.25)
                .sequenced(before: DragGesture())
                .updating($offset) { value, state, _ in
                    if case .second(true, let drag?) = value { state = drag.translation }
                }
                .onEnded { value in
                    if case .second(true, let drag?) = value {
                        committed.width += drag.translation.width
                        committed.height += drag.translation.height
                    }
                }

            ZStack {
                RoundedRectangle(cornerRadius: 12).fill(.quaternary.opacity(0.4))
                RoundedRectangle(cornerRadius: 10)
                    .fill(.blue)
                    .frame(width: 60, height: 44)
                    .overlay(Image(systemName: "arrow.up.and.down.and.arrow.left.and.right")
                        .foregroundStyle(.white))
                    .offset(x: committed.width + offset.width, y: committed.height + offset.height)
                    .gesture(pressThenDrag)
            }
            .frame(height: 150)

            An_Caption("Press and hold, then drag — the drag only activates after the long press succeeds.")
        }
    }
}

// MARK: - SimultaneousGesture

private struct An_SimultaneousGestureExample: View {
    @State private var zoom: CGFloat = 1
    @State private var angle = Angle.zero

    var body: some View {
        VStack(spacing: 8) {
            let manipulate = MagnifyGesture()
                .simultaneously(with: RotateGesture())
                .onChanged { value in
                    if let m = value.first?.magnification { zoom = m }
                    if let r = value.second?.rotation { angle = r }
                }
                .onEnded { _ in
                    withAnimation(.snappy) { zoom = 1; angle = .zero }
                }

            RoundedRectangle(cornerRadius: 14)
                .fill(.purple.gradient)
                .frame(width: 80, height: 80)
                .overlay(Image(systemName: "photo").foregroundStyle(.white))
                .scaleEffect(zoom)
                .rotationEffect(angle)
                .frame(height: 140)
                .gesture(manipulate)

            An_Caption("Pinch and twist together on a trackpad — both gestures report at once.")
        }
        .padding(.vertical, 4)
    }
}

// MARK: - SpatialEventGesture

private struct An_SpatialEventGestureExample: View {
    @State private var points: [CGPoint] = []

    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 12).fill(.black.opacity(0.85))
                ForEach(Array(points.enumerated()), id: \.offset) { _, point in
                    Circle()
                        .fill(.cyan)
                        .frame(width: 22, height: 22)
                        .position(point)
                }
                if points.isEmpty {
                    Text("Press and move the pointer")
                        .font(.caption).foregroundStyle(.white.opacity(0.6))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .frame(height: 130)
            .contentShape(.rect)
            .gesture(
                SpatialEventGesture()
                    .onChanged { events in
                        points = events.filter { $0.phase == .active }.map(\.location)
                    }
                    .onEnded { _ in points = [] }
            )

            An_Caption("Each active event becomes a dot. Full multi-touch on iOS / visionOS; one pointer on macOS.")
        }
    }
}

// MARK: - SpatialTapGesture

private struct An_SpatialTapGestureExample: View {
    @State private var markers: [CGPoint] = []

    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.green.opacity(0.12))
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(.green.opacity(0.4)))
                ForEach(Array(markers.enumerated()), id: \.offset) { _, point in
                    Circle().fill(.green).frame(width: 16, height: 16).position(point)
                }
                if markers.isEmpty {
                    Text("Click to drop a marker")
                        .font(.caption).foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .frame(height: 130)
            .contentShape(.rect)
            .gesture(
                SpatialTapGesture()
                    .onEnded { value in markers.append(value.location) }
            )

            An_Caption("Unlike TapGesture, the value carries the tap location for hit-testing custom content.")
        }
    }
}

// MARK: - Spring

private struct An_SpringExample: View {
    @State private var start = Date()
    private let spring = Spring(duration: 0.6, bounce: 0.35)

    var body: some View {
        VStack(spacing: 10) {
            TimelineView(.animation) { context in
                let t = context.date.timeIntervalSince(start)
                let x = spring.value(target: 160.0, initialVelocity: 0.0, time: t)
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10).fill(.quaternary.opacity(0.35))
                    Circle().fill(.blue).frame(width: 22, height: 22).offset(x: x + 8)
                }
            }
            .frame(height: 60)

            Button("Release") { start = .now }
                .buttonStyle(.bordered)

            An_Caption("Spring as a calculator: value(target:initialVelocity:time:) drives the position by hand.")
        }
        .padding(.vertical, 6)
    }
}

// MARK: - SpringKeyframe

private struct An_SpringKeyframeExample: View {
    @State private var pops = 0

    var body: some View {
        VStack(spacing: 14) {
            Image(systemName: "star.fill")
                .font(.system(size: 46))
                .foregroundStyle(.yellow)
                .keyframeAnimator(initialValue: 1.0, trigger: pops) { view, scale in
                    view.scaleEffect(scale)
                } keyframes: { _ in
                    SpringKeyframe(1.4, duration: 0.2, spring: .bouncy)
                    SpringKeyframe(1.0, spring: .smooth)
                }

            Button("Pop") { pops += 1 }
                .buttonStyle(.bordered)

            An_Caption("Spring physics inside a keyframe track, carrying velocity into the next segment.")
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 6)
    }
}

// MARK: - TapGesture

private struct An_TapGestureExample: View {
    @State private var zoomed = false

    var body: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 16)
                .fill(.indigo.gradient)
                .frame(width: 90, height: 90)
                .overlay(Image(systemName: "photo").foregroundStyle(.white))
                .scaleEffect(zoomed ? 1.4 : 1)
                .animation(.snappy, value: zoomed)
                .frame(height: 140)
                .contentShape(.rect)
                .gesture(
                    TapGesture(count: 2).onEnded { zoomed.toggle() }
                )

            An_Caption("Double-click the square. TapGesture is the composable form of .onTapGesture().")
        }
        .padding(.vertical, 6)
    }
}

// MARK: - Transaction

private struct An_TransactionExample: View {
    @State private var progress = 0.0

    var body: some View {
        VStack(spacing: 14) {
            ProgressView(value: progress)
                .frame(width: 190)

            HStack {
                Button("Animate") {
                    withAnimation(.easeInOut(duration: 1)) {
                        progress = progress >= 1 ? 0 : 1
                    }
                }
                Button("Skip") {
                    var t = Transaction()
                    t.disablesAnimations = true
                    withTransaction(t) { progress = 1.0 }
                }
            }
            .buttonStyle(.bordered)

            An_Caption("Skip sets disablesAnimations on the transaction, so progress jumps to full.")
        }
        .padding(.vertical, 6)
    }
}

// MARK: - TransactionKey

private struct An_AvatarTapKey: TransactionKey {
    static let defaultValue = false
}

private extension Transaction {
    var an_isAvatarTap: Bool {
        get { self[An_AvatarTapKey.self] }
        set { self[An_AvatarTapKey.self] = newValue }
    }
}

private struct An_TransactionKeyExample: View {
    @State private var big = false
    @State private var lastPath = "—"

    var body: some View {
        VStack(spacing: 12) {
            Circle()
                .fill(.blue.gradient)
                .frame(width: big ? 80 : 48, height: big ? 80 : 48)
                .transaction { t in
                    if !t.an_isAvatarTap { t.animation = nil }
                }
                .frame(height: 90)

            HStack {
                Button("Tagged tap") {
                    var t = Transaction(animation: .bouncy)
                    t.an_isAvatarTap = true
                    lastPath = "tagged → animates"
                    withTransaction(t) { big.toggle() }
                }
                Button("Untagged") {
                    lastPath = "untagged → jumps"
                    withAnimation(.bouncy) { big.toggle() }
                }
            }
            .buttonStyle(.bordered)

            Text(lastPath)
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)

            An_Caption("The view reads a custom transaction key to decide whether to keep the caller's animation.")
        }
        .padding(.vertical, 4)
    }
}

// MARK: - TransitionPhase

private struct An_Twirl: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .rotationEffect(.degrees(phase.isIdentity ? 0 : 180))
            .opacity(phase.isIdentity ? 1 : 0)
            .scaleEffect(phase.isIdentity ? 1 : 0.4)
    }
}

private struct An_TransitionPhaseExample: View {
    @State private var show = false

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                if show {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size: 54))
                        .foregroundStyle(.green)
                        .transition(An_Twirl())
                }
            }
            .frame(height: 80)

            Button(show ? "Remove" : "Insert") {
                withAnimation(.smooth(duration: 0.5)) { show.toggle() }
            }
            .buttonStyle(.bordered)

            An_Caption("A custom Transition styles the content per TransitionPhase (identity vs. non-identity).")
        }
        .padding(.vertical, 6)
    }
}

// MARK: - UnitCurve

private struct An_UnitCurveExample: View {
    @State private var progress = 0.5
    private let trackWidth: CGFloat = 200

    var body: some View {
        VStack(spacing: 12) {
            let eased = UnitCurve.easeInOut.value(at: progress)

            VStack(alignment: .leading, spacing: 8) {
                bar("linear", fraction: progress, color: .gray)
                bar("easeInOut", fraction: eased, color: .blue)
            }

            Slider(value: $progress, in: 0...1)
                .frame(width: trackWidth)

            Text(String(format: "at %.2f  →  eased %.2f", progress, eased))
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 6)
    }

    private func bar(_ label: String, fraction: Double, color: Color) -> some View {
        HStack(spacing: 8) {
            Text(label)
                .font(.caption2.monospaced())
                .foregroundStyle(.secondary)
                .frame(width: 66, alignment: .trailing)
            ZStack(alignment: .leading) {
                Capsule().fill(.quaternary.opacity(0.4)).frame(width: trackWidth, height: 14)
                Capsule().fill(color).frame(width: max(2, fraction * trackWidth), height: 14)
            }
        }
    }
}

// MARK: - VectorArithmetic

private struct An_VectorArithmeticExample: View {
    @State private var amount = 0.5

    var body: some View {
        VStack(spacing: 12) {
            let width = 20.0.interpolated(towards: 200.0, amount: amount)

            ZStack(alignment: .leading) {
                Capsule().fill(.quaternary.opacity(0.4)).frame(width: 200, height: 22)
                Capsule().fill(.orange).frame(width: max(4, width), height: 22)
            }

            Slider(value: $amount, in: 0...1)
                .frame(width: 200)

            Text(String(format: "interpolated width: %.0f", width))
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)

            An_Caption("Double conforms to VectorArithmetic, so interpolated(towards:amount:) blends the two ends.")
        }
        .padding(.vertical, 6)
    }
}

// MARK: - WindowDragGesture

private struct An_WindowDragGestureExample: View {
    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 0) {
                HStack(spacing: 8) {
                    Circle().fill(.red).frame(width: 11, height: 11)
                    Circle().fill(.yellow).frame(width: 11, height: 11)
                    Circle().fill(.green).frame(width: 11, height: 11)
                    Spacer()
                    Text("Untitled").font(.caption).foregroundStyle(.secondary)
                    Spacer()
                    Color.clear.frame(width: 40, height: 1)
                }
                .padding(.horizontal, 10)
                .frame(height: 34)
                .background(.regularMaterial)
                .gesture(WindowDragGesture())

                Rectangle()
                    .fill(.quaternary.opacity(0.3))
                    .frame(height: 70)
                    .overlay(Text("Content").font(.caption).foregroundStyle(.secondary))
            }
            .clipShape(.rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.quaternary))

            An_Caption("Drag the title bar to move the whole window (macOS). No value to observe — it moves the window itself.")
        }
        .padding(.vertical, 6)
    }
}

// MARK: - withAnimation()

private struct An_WithAnimationExample: View {
    @State private var isFavorite = false

    var body: some View {
        VStack(spacing: 12) {
            Button {
                withAnimation(.bouncy) { isFavorite.toggle() }
            } label: {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .font(.system(size: 46))
                    .foregroundStyle(isFavorite ? .red : .secondary)
                    .scaleEffect(isFavorite ? 1.2 : 1)
            }
            .buttonStyle(.plain)

            An_Caption("withAnimation stamps every state change inside the closure with the given animation.")
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 6)
    }
}

// MARK: - withTransaction()

private struct An_WithTransactionExample: View {
    @State private var index = 0
    private let stops = 3
    private let step: CGFloat = 60

    var body: some View {
        VStack(spacing: 12) {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10).fill(.quaternary.opacity(0.35))
                    .frame(width: step * CGFloat(stops), height: 40)
                RoundedRectangle(cornerRadius: 8).fill(.blue)
                    .frame(width: step - 8, height: 32)
                    .offset(x: CGFloat(index) * step + 4)
            }
            .frame(width: step * CGFloat(stops))

            HStack {
                Button("Animated") {
                    let t = Transaction(animation: .easeInOut(duration: 0.4))
                    withTransaction(t) { index = (index + 1) % stops }
                }
                Button("Instant") {
                    withTransaction(\.disablesAnimations, true) {
                        index = (index + 1) % stops
                    }
                }
            }
            .buttonStyle(.bordered)

            An_Caption("Both forms shown: a full Transaction, and the key-path shorthand withTransaction(\\.disablesAnimations, true).")
        }
        .padding(.vertical, 6)
    }
}
