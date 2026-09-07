//
//  ChildExamples+Part18.swift
//  Aviary
//
//  Compiled renderings for variant entries (part 18: gen-animation, gen-data).
//  One private C18_* struct per variant; every rendering exercises the exact
//  overload the variant names, so siblings can be compared side by side.
//

import SwiftUI
import Observation
internal import Combine

enum ChildExamplesPart18 {
    static let entries: [ChildExampleEntry] = [

        // MARK: KeyframeTimeline

        ChildExampleEntry(parent: "KeyframeTimeline", child: "KeyframeTimeline.value(progress:)", code: """
        let timeline = KeyframeTimeline(initialValue: CGPoint(x: -80, y: 0)) {
            KeyframeTrack(\\.x) { CubicKeyframe(80, duration: 1) }
            KeyframeTrack(\\.y) {
                SpringKeyframe(-40, duration: 0.5, spring: .bouncy)
                SpringKeyframe(0, duration: 0.5, spring: .bouncy)
            }
        }
        let point = timeline.value(progress: scrubFraction)   // 0...1 of the whole duration
        Circle().offset(x: point.x, y: point.y)
        Slider(value: $scrubFraction, in: 0...1)
        """) { AnyView(C18_KeyframeProgressExample()) },

        ChildExampleEntry(parent: "KeyframeTimeline", child: "KeyframeTimeline.duration", code: """
        let timeline = KeyframeTimeline(initialValue: 1.0) {
            KeyframeTrack {
                CubicKeyframe(1.6, duration: 0.8)
                SpringKeyframe(0.7, duration: 0.7, spring: .bouncy)
                LinearKeyframe(1.0, duration: 0.5)
            }
        }
        TimelineView(.animation) { context in
            let elapsed = context.date.timeIntervalSince(start)
            let finished = elapsed >= timeline.duration        // 2.0 s — the longest track
            Circle().scaleEffect(timeline.value(time: min(elapsed, timeline.duration)))
        }
        """) { AnyView(C18_KeyframeDurationExample()) },

        // MARK: KeyframeTrack

        ChildExampleEntry(parent: "KeyframeTrack", child: "KeyframeTrack(_:content:)", code: """
        struct Pose { var verticalOffset = 0.0; var scale = 1.0 }

        ball.keyframeAnimator(initialValue: Pose(), trigger: taps) { view, pose in
            view.offset(y: pose.verticalOffset).scaleEffect(pose.scale)
        } keyframes: { _ in
            KeyframeTrack(\\.verticalOffset) {         // one track per property
                CubicKeyframe(-60, duration: 0.3)
                SpringKeyframe(0, duration: 0.5, spring: .bouncy)
            }
            KeyframeTrack(\\.scale) {
                CubicKeyframe(1.25, duration: 0.3)
                SpringKeyframe(1, duration: 0.5, spring: .bouncy)
            }
        }
        """) { AnyView(C18_KeyframeTrackKeyPathExample()) },

        ChildExampleEntry(parent: "KeyframeTrack", child: "KeyframeTrack(content:)", code: """
        bell.keyframeAnimator(initialValue: 0.0, trigger: taps) { view, angle in
            view.rotationEffect(.degrees(angle), anchor: .top)
        } keyframes: { _ in
            KeyframeTrack {                            // no key path: the value IS the Double
                CubicKeyframe(-18, duration: 0.1)
                CubicKeyframe(14, duration: 0.15)
                SpringKeyframe(0, duration: 0.4, spring: .bouncy)
            }
        }
        """) { AnyView(C18_KeyframeTrackScalarExample()) },

        // MARK: MagnifyGesture

        ChildExampleEntry(parent: "MagnifyGesture", child: "MagnifyGesture(minimumScaleDelta:)", code: """
        tile.scaleEffect(zoom)
            .gesture(
                MagnifyGesture(minimumScaleDelta: 0.05)   // ignore pinches smaller than 5 %
                    .onChanged { value in
                        zoom = baseZoom * value.magnification
                    }
                    .onEnded { _ in baseZoom = zoom }
            )
        """) { AnyView(C18_MagnifyMinimumDeltaExample()) },

        ChildExampleEntry(parent: "MagnifyGesture", child: "MagnifyGesture.Value", code: """
        photo.scaleEffect(zoom, anchor: anchor)
            .gesture(MagnifyGesture().onChanged { value in
                zoom = value.magnification        // running scale factor
                anchor = value.startAnchor        // where the pinch began, as a UnitPoint
                velocity = value.velocity         // scale change per second
            })
        """) { AnyView(C18_MagnifyValueExample()) },

        // MARK: NavigationTransition

        ChildExampleEntry(parent: "NavigationTransition", child: "NavigationTransition.automatic", code: """
        NavigationStack {
            List {
                NavigationLink("Settings") {
                    SettingsView()
                        .navigationTransition(.automatic)   // the platform's default push
                }
            }
        }
        """) { AnyView(C18_NavigationTransitionAutomaticExample()) },

        ChildExampleEntry(parent: "NavigationTransition", child: "NavigationTransition.zoom(sourceID:in:)", code: """
        @Namespace private var namespace

        NavigationLink(value: id) {
            Thumbnail(id)
                .matchedTransitionSource(id: id, in: namespace)
        }
        .navigationDestination(for: Int.self) { id in
            PhotoDetail(id)
                .navigationTransition(.zoom(sourceID: id, in: namespace))
        }
        """) { AnyView(C18_NavigationTransitionZoomExample()) },

        // MARK: RotateGesture

        ChildExampleEntry(parent: "RotateGesture", child: "RotateGesture(minimumAngleDelta:)", code: """
        dial.rotationEffect(.degrees(degrees))
            .gesture(
                RotateGesture(minimumAngleDelta: .degrees(3))   // ignore twists under 3°
                    .onChanged { value in
                        degrees = baseDegrees + value.rotation.degrees
                    }
                    .onEnded { _ in baseDegrees = degrees }
            )
        """) { AnyView(C18_RotateMinimumDeltaExample()) },

        ChildExampleEntry(parent: "RotateGesture", child: "RotateGesture.Value", code: """
        knob.rotationEffect(rotation, anchor: anchor)
            .gesture(RotateGesture().onChanged { value in
                rotation = value.rotation          // an Angle
                anchor = value.startAnchor         // where the twist began
                velocity = value.velocity          // angular velocity, also an Angle
            })
        """) { AnyView(C18_RotateValueExample()) },

        // MARK: ScrollTransitionConfiguration

        ChildExampleEntry(parent: "ScrollTransitionConfiguration", child: "ScrollTransitionConfiguration.interactive(timingCurve:)", code: """
        ScrollView(.horizontal) {
            HStack { ForEach(albums) { album in
                AlbumCard(album)
                    .scrollTransition(.interactive(timingCurve: .easeInOut)) { content, phase in
                        content                       // tracks the scroll offset, eased by the curve
                            .scaleEffect(1 - abs(phase.value) * 0.3)
                            .opacity(1 - abs(phase.value) * 0.5)
                    }
            } }
        }
        """) { AnyView(C18_ScrollTransitionInteractiveCurveExample()) },

        ChildExampleEntry(parent: "ScrollTransitionConfiguration", child: "ScrollTransitionConfiguration.animated(_:)", code: """
        CardView()
            .scrollTransition(.animated(.bouncy)) { content, phase in
                content                               // snaps between states with the animation
                    .opacity(phase.isIdentity ? 1 : 0.3)
                    .scaleEffect(phase.isIdentity ? 1 : 0.7)
            }
        """) { AnyView(C18_ScrollTransitionAnimatedExample()) },

        ChildExampleEntry(parent: "ScrollTransitionConfiguration", child: "ScrollTransitionConfiguration.threshold(_:)", code: """
        RowView()
            .scrollTransition(.animated.threshold(.visible(0.4))) { content, phase in
                content                               // flips once 40 % of the card is visible
                    .offset(y: phase.value * 30)
                    .opacity(phase.isIdentity ? 1 : 0.4)
            }
        """) { AnyView(C18_ScrollTransitionThresholdExample()) },

        ChildExampleEntry(parent: "ScrollTransitionConfiguration", child: "ScrollTransitionConfiguration.Threshold", code: """
        TileView()
            .scrollTransition(.interactive.threshold(.centered)) { content, phase in
                content                               // identity only at the centre of the viewport
                    .blur(radius: phase.isIdentity ? 0 : 4)
                    .scaleEffect(phase.isIdentity ? 1 : 0.8)
            }
        // other thresholds: .visible, .hidden, .visible(0.4), .visible.inset(by: 24)
        """) { AnyView(C18_ScrollTransitionThresholdTypeExample()) },

        // MARK: SequenceGesture

        ChildExampleEntry(parent: "SequenceGesture", child: "SequenceGesture(_:_:)", code: """
        let pressThenDrag = SequenceGesture(LongPressGesture(minimumDuration: 0.4), DragGesture())
            .onChanged { value in
                switch value {
                case .second(true, .none):      armed = true            // press recognised
                case .second(true, let drag?):  offset = drag.translation
                default:                        break
                }
            }
            .onEnded { _ in withAnimation(.bouncy) { offset = .zero; armed = false } }
        """) { AnyView(C18_SequenceGestureInitExample()) },

        ChildExampleEntry(parent: "SequenceGesture", child: "SequenceGesture.Value", code: """
        LongPressGesture(minimumDuration: 0.4).sequenced(before: DragGesture())
            .updating($dragState) { value, state, _ in
                switch value {
                case .first(true):             state = .pressing
                case .second(true, .none):     state = .armed
                case .second(true, let drag?): state = .dragging(drag.translation)
                default:                       state = .inactive
                }
            }
        """) { AnyView(C18_SequenceGestureValueExample()) },

        // MARK: SimultaneousGesture

        ChildExampleEntry(parent: "SimultaneousGesture", child: "SimultaneousGesture(_:_:)", code: """
        let manipulate = SimultaneousGesture(MagnifyGesture(), RotateGesture())
            .onChanged { value in
                zoom = value.first?.magnification ?? zoom
                degrees = value.second?.rotation.degrees ?? degrees
            }
        tile.scaleEffect(zoom).rotationEffect(.degrees(degrees)).gesture(manipulate)
        """) { AnyView(C18_SimultaneousGestureInitExample()) },

        ChildExampleEntry(parent: "SimultaneousGesture", child: "SimultaneousGesture.Value", code: """
        SimultaneousGesture(MagnifyGesture(), RotateGesture())
            .onChanged { value in
                first = value.first?.magnification     // nil until the pinch reports
                second = value.second?.rotation        // nil until the twist reports
            }
            .onEnded { value in
                let finalZoom = value.first?.magnification ?? 1
                let finalTwist = value.second?.rotation ?? .zero
                commit(zoom: finalZoom, rotation: finalTwist)
            }
        """) { AnyView(C18_SimultaneousGestureValueExample()) },

        // MARK: SpatialEventGesture

        ChildExampleEntry(parent: "SpatialEventGesture", child: "SpatialEventGesture(coordinateSpace:)", code: """
        pad.coordinateSpace(.named("pad"))
            .gesture(
                SpatialEventGesture(coordinateSpace: .named("pad"))   // locations in "pad", not .local
                    .onChanged { events in
                        touches = events.map(\\.location)
                    }
                    .onEnded { _ in touches = [] }
            )
        """) { AnyView(C18_SpatialEventCoordinateSpaceExample()) },

        ChildExampleEntry(parent: "SpatialEventGesture", child: "SpatialEventCollection.Event", code: """
        SpatialEventGesture().onChanged { events in
            for event in events {                   // one Event per touch or pointer
                strokes[event.id, default: []].append(event.location)
                inputKind = event.kind              // .touch, .pointer, .directPinch, .indirectPinch
            }
        }
        """) { AnyView(C18_SpatialEventExample()) },

        ChildExampleEntry(parent: "SpatialEventGesture", child: "SpatialEventCollection.Event.Phase", code: """
        SpatialEventGesture().onChanged { events in
            for event in events {
                switch event.phase {
                case .active:    track(event)        // still down / moving
                case .ended:     finish(event)       // lifted normally
                case .cancelled: discard(event)      // taken over by the system
                @unknown default: break
                }
            }
        }
        """) { AnyView(C18_SpatialEventPhaseExample()) },

        // MARK: SpatialTapGesture

        ChildExampleEntry(parent: "SpatialTapGesture", child: "SpatialTapGesture(count:coordinateSpace:)", code: """
        pad.gesture(
            SpatialTapGesture(count: 2, coordinateSpace: .local)   // double-click, view coordinates
                .onEnded { value in
                    withAnimation(.bouncy) { focus = value.location }
                }
        )
        """) { AnyView(C18_SpatialTapInitExample()) },

        ChildExampleEntry(parent: "SpatialTapGesture", child: "SpatialTapGesture.Value", code: """
        board.gesture(SpatialTapGesture().onEnded { value in
            let column = Int(value.location.x / cellSize)   // value.location is a CGPoint
            placeMarker(in: column)
        })
        """) { AnyView(C18_SpatialTapValueExample()) },

        // MARK: Spring

        ChildExampleEntry(parent: "Spring", child: "Spring(duration:bounce:)", code: """
        Button("Toggle") {
            let lively = Spring(duration: 0.5, bounce: bounce)   // perceptual: settle time + bounce
            withAnimation(.spring(lively)) { isRight.toggle() }
        }
        Slider(value: $bounce, in: 0...0.9)
        """) { AnyView(C18_SpringDurationBounceExample()) },

        ChildExampleEntry(parent: "Spring", child: "Spring(mass:stiffness:damping:allowOverDamping:)", code: """
        Button("Open drawer") {
            let heavy = Spring(mass: 2, stiffness: 180, damping: damping, allowOverDamping: true)
            withAnimation(.spring(heavy)) { isOpen.toggle() }
        }
        Slider(value: $damping, in: 4...60)   // critical damping ≈ 38; above it the drawer creeps
        """) { AnyView(C18_SpringPhysicalExample()) },

        ChildExampleEntry(parent: "Spring", child: "Spring(response:dampingRatio:)", code: """
        tabStrip.onTap { index in
            let quick = Spring(response: 0.3, dampingRatio: dampingRatio)
            withAnimation(.spring(quick)) { selected = index }
        }
        Slider(value: $dampingRatio, in: 0.2...1)   // < 1 overshoots, 1 is critically damped
        """) { AnyView(C18_SpringResponseExample()) },

        ChildExampleEntry(parent: "Spring", child: "Spring.value(target:initialVelocity:time:)", code: """
        let spring = Spring(duration: 0.6, bounce: 0.2)
        TimelineView(.animation) { context in
            let t = context.date.timeIntervalSince(start)
            let x = spring.value(target: 160.0, initialVelocity: 0, time: t)   // sampled by hand
            Circle().frame(width: 24).offset(x: x)
        }
        """) { AnyView(C18_SpringValueExample()) },

        // MARK: Transaction

        ChildExampleEntry(parent: "Transaction", child: "Transaction(animation:)", code: """
        Button("Next tab") {
            let t = Transaction(animation: .easeInOut(duration: 0.6))
            withTransaction(t) { selected = (selected + 1) % 3 }
        }
        """) { AnyView(C18_TransactionAnimationExample()) },

        ChildExampleEntry(parent: "Transaction", child: "Transaction.disablesAnimations", code: """
        bar.animation(.easeInOut(duration: 1), value: progress)   // a downstream request…

        Button("Snap") {
            var t = Transaction()
            t.disablesAnimations = true                            // …suppressed for this update
            withTransaction(t) { progress = 1.0 }
        }
        """) { AnyView(C18_TransactionDisablesAnimationsExample()) },

        ChildExampleEntry(parent: "Transaction", child: "Transaction.isContinuous", code: """
        circle.offset(offset)
            .transaction { t in if t.isContinuous { t.animation = nil } }   // views may opt out
            .animation(.bouncy(duration: 0.6), value: offset)
            .gesture(DragGesture().onChanged { value in
                var t = Transaction()
                t.isContinuous = true                 // one of a rapid stream of updates
                withTransaction(t) { offset = value.translation }
            })
        """) { AnyView(C18_TransactionIsContinuousExample()) },

        ChildExampleEntry(parent: "Transaction", child: "Transaction.addAnimationCompletion(criteria:_:)", code: """
        Button("Dismiss overlay") {
            var t = Transaction(animation: .bouncy)
            t.addAnimationCompletion(criteria: .removed) {   // fires once the view is gone
                log = "overlay removed — cleaned up"
            }
            withTransaction(t) { overlayShown = false }
        }
        """) { AnyView(C18_TransactionCompletionExample()) },

        // MARK: TransitionPhase

        ChildExampleEntry(parent: "TransitionPhase", child: "TransitionPhase.willAppear", code: """
        struct RiseTransition: Transition {
            func body(content: Content, phase: TransitionPhase) -> some View {
                content
                    .offset(y: phase == .willAppear ? 40 : 0)   // start below, animate to identity
                    .opacity(phase == .willAppear ? 0 : 1)
            }
        }
        if shown { banner.transition(RiseTransition()) }
        """) { AnyView(C18_TransitionWillAppearExample()) },

        ChildExampleEntry(parent: "TransitionPhase", child: "TransitionPhase.didDisappear", code: """
        struct ShrinkAwayTransition: Transition {
            func body(content: Content, phase: TransitionPhase) -> some View {
                content
                    .scaleEffect(phase == .didDisappear ? 0.6 : 1)   // exits shrink and fade…
                    .opacity(phase == .didDisappear ? 0 : 1)         // …entrances are a plain cut
            }
        }
        if shown { card.transition(ShrinkAwayTransition()) }
        """) { AnyView(C18_TransitionDidDisappearExample()) },

        ChildExampleEntry(parent: "TransitionPhase", child: "TransitionPhase.value", code: """
        struct SlideThroughTransition: Transition {
            func body(content: Content, phase: TransitionPhase) -> some View {
                content
                    .offset(x: phase.value * 120)          // -1 before appearing, 0 identity, +1 after
                    .opacity(1 - abs(phase.value))
            }
        }
        if shown { chip.transition(SlideThroughTransition()) }
        """) { AnyView(C18_TransitionValueExample()) },

        // MARK: UnitCurve

        ChildExampleEntry(parent: "UnitCurve", child: "UnitCurve.bezier(startControlPoint:endControlPoint:)", code: """
        let overshoot = UnitCurve.bezier(
            startControlPoint: UnitPoint(x: 0.34, y: 1.56),   // y > 1 pushes the curve past its target
            endControlPoint: UnitPoint(x: 0.64, y: 1)
        )
        Button("Play") {
            withAnimation(.timingCurve(overshoot, duration: 0.8)) { isRight.toggle() }
        }
        """) { AnyView(C18_UnitCurveBezierExample()) },

        ChildExampleEntry(parent: "UnitCurve", child: "UnitCurve.value(at:)", code: """
        let eased = UnitCurve.easeInOut.value(at: fraction)   // 0...1 in, 0...1 out
        Capsule().frame(width: eased * maxWidth)              // vs. width: fraction * maxWidth
        Slider(value: $fraction, in: 0...1)
        """) { AnyView(C18_UnitCurveValueExample()) },

        ChildExampleEntry(parent: "UnitCurve", child: "UnitCurve.velocity(at:)", code: """
        let curve = UnitCurve.easeOut
        let speed = curve.velocity(at: fraction)              // slope of the curve, units per unit
        let spring = Spring(duration: 0.4, bounce: 0.2)
        let carried = spring.value(target: 1.0, initialVelocity: speed, time: 0.1)
        """) { AnyView(C18_UnitCurveVelocityExample()) },

        ChildExampleEntry(parent: "UnitCurve", child: "UnitCurve.inverse", code: """
        let easeIn = UnitCurve.easeIn
        let mirrored = easeIn.inverse                          // flipped across the diagonal → ease-out
        let p = mirrored.value(at: 0.25)
        """) { AnyView(C18_UnitCurveInverseExample()) },

        // MARK: VectorArithmetic

        ChildExampleEntry(parent: "VectorArithmetic", child: "VectorArithmetic.scale(by:)", code: """
        let start = AnimatablePair(20.0, 70.0)          // AnimatablePair is a VectorArithmetic
        let end = AnimatablePair(220.0, 20.0)

        var delta = end
        delta -= start
        delta.scale(by: amount)                          // every component × amount, in place
        """) { AnyView(C18_VectorScaleExample()) },

        ChildExampleEntry(parent: "VectorArithmetic", child: "VectorArithmetic.magnitudeSquared", code: """
        let target = AnimatablePair(200.0, 50.0)
        var remaining = target
        remaining -= current
        if remaining.magnitudeSquared < 0.0001 {   // first² + second², no square root needed
            finish()
        }
        """) { AnyView(C18_VectorMagnitudeExample()) },

        ChildExampleEntry(parent: "VectorArithmetic", child: "VectorArithmetic.interpolated(towards:amount:)", code: """
        let a = AnimatablePair(0.0, 10.0)
        let b = AnimatablePair(100.0, 0.0)
        let mid = a.interpolated(towards: b, amount: amount)   // linear blend, 0 = a, 1 = b
        Slider(value: $amount, in: 0...1)
        """) { AnyView(C18_VectorInterpolatedExample()) },

        // MARK: withAnimation()

        ChildExampleEntry(parent: "withAnimation()", child: "withAnimation(_:_:)", code: """
        Button("Favorite") {
            let nowFavorite = withAnimation(.bouncy) {   // returns the closure's result
                isFavorite.toggle()
                return isFavorite
            }
            log = "returned \\(nowFavorite)"
        }
        """) { AnyView(C18_WithAnimationExample()) },

        ChildExampleEntry(parent: "withAnimation()", child: "withAnimation(_:completionCriteria:_:completion:)", code: """
        Button("Dismiss") {
            withAnimation(.easeOut, completionCriteria: .removed) {
                toastVisible = false
            } completion: {
                queue.removeFirst()                     // runs after the toast is gone
                if !queue.isEmpty { withAnimation(.bouncy) { toastVisible = true } }
            }
        }
        """) { AnyView(C18_WithAnimationCompletionExample()) },

        // MARK: withTransaction()

        ChildExampleEntry(parent: "withTransaction()", child: "withTransaction(_:_:)", code: """
        tabStrip.animation(.bouncy(duration: 1.5), value: selected)   // downstream request

        Button("Next") {
            var t = Transaction(animation: .easeInOut(duration: 0.2))
            t.disablesAnimations = true                 // your animation wins, downstream ignored
            withTransaction(t) { selected = (selected + 1) % 3 }
        }
        """) { AnyView(C18_WithTransactionExample()) },

        ChildExampleEntry(parent: "withTransaction()", child: "withTransaction(_:_:_:)", code: """
        tabStrip.animation(.bouncy, value: selected)

        Button("Next, no animation") {
            withTransaction(\\.disablesAnimations, true) {   // one key path, one value
                selected = (selected + 1) % 3
            }
        }
        """) { AnyView(C18_WithTransactionKeyPathExample()) },

        // MARK: .backgroundTask()

        ChildExampleEntry(parent: ".backgroundTask()", child: "BackgroundTask.appRefresh(_:)", code: """
        WindowGroup { ContentView() }
            .backgroundTask(.appRefresh("com.example.refresh")) {   // a BGAppRefreshTask identifier
                await store.refreshTimeline()
            }
        """) { AnyView(C18_BackgroundTaskAppRefreshExample()) },

        ChildExampleEntry(parent: ".backgroundTask()", child: "BackgroundTask.urlSession(_:)", code: """
        WindowGroup { ContentView() }
            .backgroundTask(.urlSession("com.example.downloads")) {   // one background URLSession
                await downloads.handleSessionEvents()
            }
        """) { AnyView(C18_BackgroundTaskURLSessionExample()) },

        ChildExampleEntry(parent: ".backgroundTask()", child: "BackgroundTask.urlSession(matching:)", code: """
        WindowGroup { ContentView() }
            .backgroundTask(.urlSession(matching: { $0.hasPrefix("com.example.export.") })) { identifier in
                await exporter.finish(sessionID: identifier)   // the matched identifier is passed in
            }
        """) { AnyView(C18_BackgroundTaskMatchingExample()) },

        // MARK: .environment()

        ChildExampleEntry(parent: ".environment()", child: ".environment(_:_:)", code: """
        List { rows }                                         // default row height

        List { rows }
            .environment(\\.defaultMinListRowHeight, 60)       // one EnvironmentValues key path
        """) { AnyView(C18_EnvironmentKeyPathExample()) },

        ChildExampleEntry(parent: ".environment()", child: ".environment(_:)", code: """
        @Observable final class AppState { var unread = 3 }

        InboxBadge()
            .environment(appState)                            // stored by its type

        struct InboxBadge: View {
            @Environment(AppState.self) private var state
            var body: some View { Label("\\(state.unread) unread", systemImage: "tray.fill") }
        }
        """) { AnyView(C18_EnvironmentObjectExample()) },

        // MARK: .modelContainer()

        ChildExampleEntry(parent: ".modelContainer()", child: ".modelContainer(for:inMemory:isAutosaveEnabled:isUndoEnabled:onSetup:)", code: """
        WindowGroup { ContentView() }
            .modelContainer(for: [Recipe.self, Step.self],
                            inMemory: false,
                            isAutosaveEnabled: true,
                            isUndoEnabled: true) { result in
                if case .failure(let error) = result {
                    logger.error("Store failed: \\(error)")
                }
            }
        """) { AnyView(C18_ModelContainerConvenienceExample()) },

        ChildExampleEntry(parent: ".modelContainer()", child: ".modelContainer(_:)", code: """
        let container = try ModelContainer(
            for: Recipe.self,
            migrationPlan: RecipeMigrationPlan.self      // V1 → V2 → V3
        )
        WindowGroup { ContentView() }
            .modelContainer(container)                   // install one you built yourself
        """) { AnyView(C18_ModelContainerCustomExample()) },

        // MARK: .tag()

        ChildExampleEntry(parent: ".tag()", child: ".tag(_:)", code: """
        TabView(selection: $tab) {                       // Binding<Tab>
            HomeView().tag(Tab.home)
            SearchView().tag(Tab.search)                 // matched against the selection
        }
        """) { AnyView(C18_TagExample()) },

        ChildExampleEntry(parent: ".tag()", child: ".tag(_:includeOptional:)", code: """
        List(selection: $selectedID) {                   // Binding<Int?>
            ForEach(items) { item in
                Text(item.name)
                    .tag(item.id, includeOptional: true) // an Int tag may satisfy an Int? selection
            }
        }
        """) { AnyView(C18_TagIncludeOptionalExample()) },

        // MARK: @Model

        ChildExampleEntry(parent: "@Model", child: "@Attribute", code: """
        @Model final class Recipe {
            @Attribute(.unique) var slug: String          // inserts with an existing slug upsert
            @Attribute(.externalStorage) var photo: Data? // large blobs live outside the store
            var name: String
        }
        """) { AnyView(C18_AttributeExample()) },

        ChildExampleEntry(parent: "@Model", child: "@Relationship", code: """
        @Model final class Recipe {
            @Relationship(deleteRule: .cascade, inverse: \\Step.recipe)
            var steps: [Step] = []                        // deleting the recipe deletes its steps
        }
        """) { AnyView(C18_RelationshipExample()) },

        // MARK: @SectionedFetchRequest

        ChildExampleEntry(parent: "@SectionedFetchRequest", child: "init(sectionIdentifier:sortDescriptors:predicate:animation:)", code: """
        @SectionedFetchRequest(
            sectionIdentifier: \\Quake.day,
            sortDescriptors: [SortDescriptor(\\Quake.day, order: .reverse),
                              SortDescriptor(\\Quake.time, order: .reverse)],
            predicate: NSPredicate(format: "magnitude >= 4"),
            animation: .default
        ) private var quakes: SectionedFetchResults<String, Quake>
        """) { AnyView(C18_SectionedFetchInlineExample()) },

        ChildExampleEntry(parent: "@SectionedFetchRequest", child: "init(fetchRequest:sectionIdentifier:animation:)", code: """
        @SectionedFetchRequest(
            fetchRequest: Quake.recentRequest(limit: 4),   // an NSFetchRequest<Quake> with fetchLimit
            sectionIdentifier: \\.day,
            animation: .default
        ) private var quakes: SectionedFetchResults<String, Quake>
        """) { AnyView(C18_SectionedFetchRequestExample()) },

        ChildExampleEntry(parent: "@SectionedFetchRequest", child: "SectionedFetchRequest.Configuration", code: """
        @Binding var config: SectionedFetchRequest<String, Quake>.Configuration   // from $quakes

        Button("Strongest first") {
            config.sortDescriptors = [
                SortDescriptor(\\Quake.day, order: .reverse),
                SortDescriptor(\\Quake.magnitude, order: .reverse)
            ]
        }
        """) { AnyView(C18_SectionedFetchConfigurationExample()) },

        // MARK: Binding

        ChildExampleEntry(parent: "Binding", child: "Binding.constant()", code: """
        Toggle("Wi-Fi", isOn: .constant(true))     // read-only: clicks never change it
        Toggle("Bluetooth", isOn: $bluetooth)      // state-backed, for contrast
        """) { AnyView(C18_BindingConstantExample()) },

        ChildExampleEntry(parent: "Binding", child: "Binding(get:set:)", code: """
        let isPro = Binding(
            get: { plan == .pro },                     // derive a Bool from the enum…
            set: { plan = $0 ? .pro : .free }          // …and write the enum back
        )
        Toggle("Pro plan", isOn: isPro)
        """) { AnyView(C18_BindingGetSetExample()) },

        // MARK: EnvironmentValues

        ChildExampleEntry(parent: "EnvironmentValues", child: "subscript(key:)", code: """
        private struct AccentTintKey: EnvironmentKey {
            static let defaultValue = Color.blue
        }
        extension EnvironmentValues {
            var accentTint: Color {
                get { self[AccentTintKey.self] }               // read through the key type
                set { self[AccentTintKey.self] = newValue }    // write through the key type
            }
        }
        chip.environment(\\.accentTint, .orange)
        """) { AnyView(C18_EnvironmentSubscriptExample()) },

        ChildExampleEntry(parent: "EnvironmentValues", child: "init()", code: """
        let values = EnvironmentValues()        // standalone: every entry at its default
        values.accentTint == .blue              // true — the custom key's defaultValue
        values.colorScheme                      // .light
        values.isEnabled                        // true
        """) { AnyView(C18_EnvironmentInitExample()) },

        // MARK: FetchedResults

        ChildExampleEntry(parent: "FetchedResults", child: "nsPredicate", code: """
        List(recipes) { RecipeRow(recipe: $0) }
            .searchable(text: $query)
            .onChange(of: query) { _, text in
                recipes.nsPredicate = text.isEmpty          // re-executes the fetch in place
                    ? nil
                    : NSPredicate(format: "name CONTAINS[cd] %@", text)
            }
        """) { AnyView(C18_FetchedResultsPredicateExample()) },

        ChildExampleEntry(parent: "FetchedResults", child: "sortDescriptors", code: """
        Picker("Order", selection: $order) { /* .newest, .name */ }
            .onChange(of: order) { _, order in
                recipes.sortDescriptors = order == .newest      // type-safe Swift descriptors
                    ? [SortDescriptor(\\Recipe.createdAt, order: .reverse)]
                    : [SortDescriptor(\\Recipe.name)]
            }
        """) { AnyView(C18_FetchedResultsSortExample()) },

        ChildExampleEntry(parent: "FetchedResults", child: "nsSortDescriptors", code: """
        recipes.nsSortDescriptors = [
            NSSortDescriptor(
                key: "name", ascending: true,
                selector: #selector(NSString.localizedStandardCompare(_:))   // Finder-style order
            )
        ]
        """) { AnyView(C18_FetchedResultsNSSortExample()) },

        // MARK: ModelContainer

        ChildExampleEntry(parent: "ModelContainer", child: "init(for:migrationPlan:configurations:)", code: """
        let store = ModelConfiguration("Library", cloudKitDatabase: .none)
        let container = try ModelContainer(
            for: Recipe.self, Step.self,               // variadic model types
            migrationPlan: RecipeMigrationPlan.self,
            configurations: store
        )
        """) { AnyView(C18_ModelContainerInitExample()) },

        ChildExampleEntry(parent: "ModelContainer", child: "mainContext", code: """
        @MainActor
        func seed(_ container: ModelContainer) throws {
            let context = container.mainContext        // the UI's ModelContext
            context.insert(Recipe(name: "Pancakes"))
            try context.save()
        }
        """) { AnyView(C18_ModelContainerMainContextExample()) },

        ChildExampleEntry(parent: "ModelContainer", child: "deleteAllData()", code: """
        Button("Reset Library", role: .destructive) {
            container.deleteAllData()                  // wipes every store the container owns
            showResetConfirmation = false
        }
        """) { AnyView(C18_ModelContainerDeleteAllExample()) },

        // MARK: ObservableObject

        ChildExampleEntry(parent: "ObservableObject", child: "objectWillChange", code: """
        final class Settings: ObservableObject {
            var theme = Theme.system {                 // a plain var, not @Published…
                willSet { objectWillChange.send() }    // …so announce the change yourself
            }
        }
        @StateObject private var settings = Settings()
        Text("theme = .\\(settings.theme.rawValue)")
        """) { AnyView(C18_ObjectWillChangeExample()) },

        ChildExampleEntry(parent: "ObservableObject", child: "ObjectWillChangePublisher", code: """
        final class Feed: ObservableObject {
            typealias ObjectWillChangePublisher = ObservableObjectPublisher   // the associated type
            let objectWillChange = ObservableObjectPublisher()               // supplied by hand
            private(set) var items: [String] = []

            func replace(with latest: [String]) {
                objectWillChange.send()
                items = latest
            }
        }
        """) { AnyView(C18_ObjectWillChangePublisherExample()) },

        // MARK: OpenURLAction

        ChildExampleEntry(parent: "OpenURLAction", child: "init(handler:)", code: """
        let intercept = OpenURLAction { url in
            guard url.host() == "example.com" else { return .systemAction }   // let the OS open it
            router.open(url)
            return .handled                                                   // consumed in-app
        }
        links.environment(\\.openURL, intercept)
        """) { AnyView(C18_OpenURLHandlerExample()) },

        ChildExampleEntry(parent: "OpenURLAction", child: "callAsFunction(_:)", code: """
        @Environment(\\.openURL) private var openURL

        Button("Help Center") {
            openURL(URL(string: "https://example.com/help")!)   // fire and forget
        }
        """) { AnyView(C18_OpenURLCallExample()) },

        ChildExampleEntry(parent: "OpenURLAction", child: "callAsFunction(_:completion:)", code: """
        openURL(url) { accepted in                 // did anything take the URL?
            log = "accepted = \\(accepted)"
            if !accepted { showCopyLinkAlert = true }
        }
        """) { AnyView(C18_OpenURLCompletionExample()) },

        ChildExampleEntry(parent: "OpenURLAction", child: "OpenURLAction.Result", code: """
        OpenURLAction { url in
            if url.scheme == "myapp" { return .handled }              // consumed
            if url.host() == "ads.example" { return .discarded }      // dropped entirely
            var clean = URLComponents(url: url, resolvingAgainstBaseURL: false)
            clean?.queryItems = nil
            return .systemAction(clean?.url ?? url)                   // OS opens a substitute URL
        }
        """) { AnyView(C18_OpenURLResultExample()) },
    ]
}

// MARK: - Shared helpers

private struct C18_Caption: View {
    let text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
    }
}

/// Plots a UnitCurve on a unit square; optionally marks a progress fraction
/// and draws the tangent there (slope = curve.velocity(at:)).
private struct C18_CurvePlot: View {
    let curve: UnitCurve
    var marker: Double? = nil
    var tangent = false
    var tint: Color = .blue

    var body: some View {
        Canvas { context, size in
            let frame = CGRect(origin: .zero, size: size)
            context.stroke(Path(frame), with: .color(.gray.opacity(0.4)), lineWidth: 1)
            var diagonal = Path()
            diagonal.move(to: CGPoint(x: 0, y: size.height))
            diagonal.addLine(to: CGPoint(x: size.width, y: 0))
            context.stroke(diagonal, with: .color(.gray.opacity(0.3)), style: StrokeStyle(lineWidth: 1, dash: [3, 3]))

            var path = Path()
            for step in 0...48 {
                let t = Double(step) / 48
                let v = curve.value(at: t)
                let point = CGPoint(x: t * size.width, y: (1 - v) * size.height)
                if step == 0 { path.move(to: point) } else { path.addLine(to: point) }
            }
            context.stroke(path, with: .color(tint), lineWidth: 2)

            if let marker {
                let v = curve.value(at: marker)
                let slope = curve.velocity(at: marker)
                let center = CGPoint(x: marker * size.width, y: (1 - v) * size.height)
                if tangent {
                    var line = Path()
                    let dx = 0.18 * size.width
                    let dy = slope * dx * (size.height / size.width)
                    line.move(to: CGPoint(x: center.x - dx, y: center.y + dy))
                    line.addLine(to: CGPoint(x: center.x + dx, y: center.y - dy))
                    context.stroke(line, with: .color(.orange), lineWidth: 1.5)
                }
                context.fill(Path(ellipseIn: CGRect(x: center.x - 4, y: center.y - 4, width: 8, height: 8)), with: .color(.orange))
            }
        }
    }
}

/// Mock scene chrome used by the Scene-level illustrations.
private struct C18_MockScene<Content: View>: View {
    let title: String
    @ViewBuilder var content: Content

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 6) {
                Circle().fill(.red).frame(width: 8, height: 8)
                Circle().fill(.yellow).frame(width: 8, height: 8)
                Circle().fill(.green).frame(width: 8, height: 8)
                Spacer()
                Text(title).font(.caption2).foregroundStyle(.secondary)
                Spacer()
            }
            .padding(6)
            .background(.quaternary)
            content
                .padding(8)
        }
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.quaternary))
    }
}

// MARK: - KeyframeTimeline

private struct C18_KeyframeProgressExample: View {
    @State private var scrubFraction = 0.0
    private let timeline = KeyframeTimeline(initialValue: CGPoint(x: -80, y: 0)) {
        KeyframeTrack(\.x) { CubicKeyframe(80, duration: 1) }
        KeyframeTrack(\.y) {
            SpringKeyframe(-40, duration: 0.5, spring: .bouncy)
            SpringKeyframe(0, duration: 0.5, spring: .bouncy)
        }
    }

    var body: some View {
        let point = timeline.value(progress: scrubFraction)
        VStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 8).fill(.quaternary)
                Circle().fill(.orange).frame(width: 22, height: 22)
                    .offset(x: point.x, y: point.y)
            }
            .frame(height: 90)
            Slider(value: $scrubFraction, in: 0...1)
            Text(String(format: "progress %.2f → x %.0f, y %.0f", scrubFraction, point.x, point.y))
                .font(.caption.monospacedDigit()).foregroundStyle(.secondary)
        }
    }
}

private struct C18_KeyframeDurationExample: View {
    @State private var start = Date()
    private let timeline = KeyframeTimeline(initialValue: 1.0) {
        KeyframeTrack {
            CubicKeyframe(1.6, duration: 0.8)
            SpringKeyframe(0.7, duration: 0.7, spring: .bouncy)
            LinearKeyframe(1.0, duration: 0.5)
        }
    }

    var body: some View {
        TimelineView(.animation) { context in
            let elapsed = context.date.timeIntervalSince(start)
            let finished = elapsed >= timeline.duration
            let clamped = min(elapsed, timeline.duration)
            VStack(spacing: 10) {
                Circle()
                    .fill(finished ? Color.green : Color.blue)
                    .frame(width: 44, height: 44)
                    .scaleEffect(timeline.value(time: clamped))
                    .frame(height: 80)
                Text(String(format: "%.2f s of duration %.2f s", clamped, timeline.duration))
                    .font(.caption.monospacedDigit())
                Text(finished ? "Finished — end state reached" : "Sampling…")
                    .font(.caption).foregroundStyle(.secondary)
                Button("Replay") { start = Date() }
            }
        }
    }
}

// MARK: - KeyframeTrack

private struct C18_Pose {
    var verticalOffset = 0.0
    var scale = 1.0
}

private struct C18_KeyframeTrackKeyPathExample: View {
    @State private var taps = 0

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "basketball.fill")
                .font(.system(size: 40))
                .foregroundStyle(.orange)
                .keyframeAnimator(initialValue: C18_Pose(), trigger: taps) { view, pose in
                    view.offset(y: pose.verticalOffset).scaleEffect(pose.scale)
                } keyframes: { _ in
                    KeyframeTrack(\.verticalOffset) {
                        CubicKeyframe(-60, duration: 0.3)
                        SpringKeyframe(0, duration: 0.5, spring: .bouncy)
                    }
                    KeyframeTrack(\.scale) {
                        CubicKeyframe(1.25, duration: 0.3)
                        SpringKeyframe(1, duration: 0.5, spring: .bouncy)
                    }
                }
                .frame(height: 90, alignment: .bottom)
            Button("Bounce") { taps += 1 }
        }
    }
}

private struct C18_KeyframeTrackScalarExample: View {
    @State private var taps = 0

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "bell.fill")
                .font(.system(size: 40))
                .foregroundStyle(.yellow)
                .keyframeAnimator(initialValue: 0.0, trigger: taps) { view, angle in
                    view.rotationEffect(.degrees(angle), anchor: .top)
                } keyframes: { _ in
                    KeyframeTrack {
                        CubicKeyframe(-18, duration: 0.1)
                        CubicKeyframe(14, duration: 0.15)
                        SpringKeyframe(0, duration: 0.4, spring: .bouncy)
                    }
                }
                .frame(height: 70)
            Button("Ring") { taps += 1 }
        }
    }
}

// MARK: - MagnifyGesture

private struct C18_MagnifyMinimumDeltaExample: View {
    @State private var zoom: CGFloat = 1
    @State private var baseZoom: CGFloat = 1

    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 12)
                .fill(.teal.gradient)
                .frame(width: 80, height: 80)
                .scaleEffect(zoom)
                .frame(maxWidth: .infinity)
                .frame(height: 120)
                .clipped()
                .contentShape(Rectangle())
                .gesture(
                    MagnifyGesture(minimumScaleDelta: 0.05)
                        .onChanged { value in
                            zoom = baseZoom * value.magnification
                        }
                        .onEnded { _ in baseZoom = zoom }
                )
            Text(String(format: "zoom %.2f — pinch on the trackpad", zoom))
                .font(.caption.monospacedDigit()).foregroundStyle(.secondary)
            Button("Reset") { withAnimation { zoom = 1; baseZoom = 1 } }.controlSize(.small)
        }
    }
}

private struct C18_MagnifyValueExample: View {
    @State private var zoom: CGFloat = 1
    @State private var anchor: UnitPoint = .center
    @State private var velocity: CGFloat = 0

    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 120, height: 80)
                .scaleEffect(zoom, anchor: anchor)
                .frame(maxWidth: .infinity)
                .frame(height: 120)
                .clipped()
                .contentShape(Rectangle())
                .gesture(
                    MagnifyGesture()
                        .onChanged { value in
                            zoom = value.magnification
                            anchor = value.startAnchor
                            velocity = value.velocity
                        }
                        .onEnded { _ in withAnimation { zoom = 1 } }
                )
            Text(String(format: "magnification %.2f   velocity %.2f   startAnchor (%.2f, %.2f)",
                        zoom, velocity, anchor.x, anchor.y))
                .font(.caption.monospacedDigit()).foregroundStyle(.secondary)
        }
    }
}

// MARK: - NavigationTransition

private struct C18_NavigationTransitionAutomaticExample: View {
    var body: some View {
        VStack(spacing: 6) {
            NavigationStack {
                List {
                    NavigationLink("Settings") {
                        Label("Settings", systemImage: "gearshape")
                            .navigationTitle("Settings")
                            .navigationTransition(.automatic)
                    }
                    NavigationLink("Account") {
                        Label("Account", systemImage: "person.crop.circle")
                            .navigationTitle("Account")
                            .navigationTransition(.automatic)
                    }
                }
                .navigationTitle("Home")
            }
            .frame(height: 150)
            C18_Caption(".automatic keeps the platform's standard push — the same as applying no modifier")
        }
    }
}

/// `.zoom(sourceID:in:)` is unavailable on macOS, so this illustrates the hero
/// zoom with a matched-geometry mock instead of a real navigation push.
private struct C18_NavigationTransitionZoomExample: View {
    @Namespace private var namespace
    @State private var expanded: Int? = nil
    private let colors: [Color] = [.orange, .teal, .purple]

    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                HStack(spacing: 12) {
                    ForEach(0..<3, id: \.self) { id in
                        if expanded != id {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(colors[id].gradient)
                                .matchedGeometryEffect(id: id, in: namespace)
                                .frame(width: 48, height: 48)
                                .onTapGesture { withAnimation(.snappy) { expanded = id } }
                        } else {
                            Color.clear.frame(width: 48, height: 48)
                        }
                    }
                }
                if let expanded {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(colors[expanded].gradient)
                        .matchedGeometryEffect(id: expanded, in: namespace)
                        .padding(12)
                        .overlay(alignment: .topLeading) {
                            Button("Back") { withAnimation(.snappy) { self.expanded = nil } }
                                .controlSize(.small)
                                .padding(20)
                        }
                }
            }
            .frame(height: 140)
            C18_Caption("Illustrative — .zoom is iOS, tvOS and visionOS only; macOS keeps the standard push. Click a thumbnail.")
        }
    }
}

// MARK: - RotateGesture

private struct C18_RotateMinimumDeltaExample: View {
    @State private var degrees = 0.0
    @State private var baseDegrees = 0.0

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "arrow.up.circle.fill")
                .font(.system(size: 56))
                .foregroundStyle(.indigo)
                .rotationEffect(.degrees(degrees))
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .contentShape(Rectangle())
                .gesture(
                    RotateGesture(minimumAngleDelta: .degrees(3))
                        .onChanged { value in
                            degrees = baseDegrees + value.rotation.degrees
                        }
                        .onEnded { _ in baseDegrees = degrees }
                )
            Text(String(format: "%.0f° — twist with two fingers on the trackpad", degrees))
                .font(.caption.monospacedDigit()).foregroundStyle(.secondary)
        }
    }
}

private struct C18_RotateValueExample: View {
    @State private var rotation: Angle = .zero
    @State private var anchor: UnitPoint = .center
    @State private var velocity: Angle = .zero

    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.mint.gradient)
                .frame(width: 110, height: 70)
                .overlay(Image(systemName: "dial.medium").font(.title))
                .rotationEffect(rotation, anchor: anchor)
                .frame(maxWidth: .infinity)
                .frame(height: 110)
                .contentShape(Rectangle())
                .gesture(
                    RotateGesture()
                        .onChanged { value in
                            rotation = value.rotation
                            anchor = value.startAnchor
                            velocity = value.velocity
                        }
                        .onEnded { _ in withAnimation { rotation = .zero } }
                )
            Text(String(format: "rotation %.0f°   velocity %.0f°/s   startAnchor (%.2f, %.2f)",
                        rotation.degrees, velocity.degrees, anchor.x, anchor.y))
                .font(.caption.monospacedDigit()).foregroundStyle(.secondary)
        }
    }
}

// MARK: - ScrollTransitionConfiguration

private struct C18_CardRow<Effect: VisualEffect>: View {
    let configuration: ScrollTransitionConfiguration
    let effect: @Sendable (EmptyVisualEffect, ScrollTransitionPhase) -> Effect

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 12) {
                ForEach(0..<10, id: \.self) { i in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(hue: Double(i) / 10, saturation: 0.55, brightness: 0.95).gradient)
                        .frame(width: 80, height: 80)
                        .overlay(Text("\(i + 1)").font(.headline).foregroundStyle(.white))
                        .scrollTransition(configuration) { [effect] content, phase in
                            effect(content, phase)
                        }
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 110)
    }
}

private struct C18_ScrollTransitionInteractiveCurveExample: View {
    var body: some View {
        VStack(spacing: 4) {
            C18_CardRow(configuration: .interactive(timingCurve: .easeInOut)) { content, phase in
                content
                    .scaleEffect(1 - abs(phase.value) * 0.3)
                    .opacity(1 - abs(phase.value) * 0.5)
            }
            C18_Caption("Scroll sideways — the edge cards shrink continuously with the offset")
        }
    }
}

private struct C18_ScrollTransitionAnimatedExample: View {
    var body: some View {
        VStack(spacing: 4) {
            C18_CardRow(configuration: .animated(.bouncy)) { content, phase in
                content
                    .opacity(phase.isIdentity ? 1 : 0.3)
                    .scaleEffect(phase.isIdentity ? 1 : 0.7)
            }
            C18_Caption("Scroll sideways — cards pop with a bouncy animation when they cross the threshold")
        }
    }
}

private struct C18_ScrollTransitionThresholdExample: View {
    var body: some View {
        VStack(spacing: 4) {
            C18_CardRow(configuration: .animated.threshold(.visible(0.4))) { content, phase in
                content
                    .offset(y: phase.value * 30)
                    .opacity(phase.isIdentity ? 1 : 0.4)
            }
            C18_Caption("Scroll sideways — a card flips to identity once 40 % of it is visible")
        }
    }
}

private struct C18_ScrollTransitionThresholdTypeExample: View {
    var body: some View {
        VStack(spacing: 4) {
            C18_CardRow(configuration: .interactive.threshold(.centered)) { content, phase in
                content
                    .blur(radius: phase.isIdentity ? 0 : 4)
                    .scaleEffect(phase.isIdentity ? 1 : 0.8)
            }
            C18_Caption(".centered — only the card at the middle of the viewport is sharp")
        }
    }
}

// MARK: - SequenceGesture

private struct C18_SequenceGestureInitExample: View {
    @State private var offset: CGSize = .zero
    @State private var armed = false

    var body: some View {
        let pressThenDrag = SequenceGesture(LongPressGesture(minimumDuration: 0.4), DragGesture())
            .onChanged { value in
                switch value {
                case .second(true, .none):      armed = true
                case .second(true, let drag?):  offset = drag.translation
                default:                        break
                }
            }
            .onEnded { _ in withAnimation(.bouncy) { offset = .zero; armed = false } }

        VStack(spacing: 8) {
            Circle()
                .fill(armed ? Color.green : Color.gray)
                .frame(width: 56, height: 56)
                .offset(offset)
                .gesture(pressThenDrag)
                .frame(maxWidth: .infinity)
                .frame(height: 110)
            Text(armed ? "Press recognised — now drag" : "Press and hold, then drag")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

private enum C18_PressDragState {
    case inactive, pressing, armed, dragging(CGSize)

    var label: String {
        switch self {
        case .inactive: "inactive"
        case .pressing: ".first(true) — pressing"
        case .armed: ".second(true, nil) — press succeeded"
        case .dragging(let t): String(format: ".second(true, drag) — (%.0f, %.0f)", t.width, t.height)
        }
    }

    var translation: CGSize {
        if case .dragging(let t) = self { return t }
        return .zero
    }

    var isActive: Bool {
        if case .inactive = self { return false }
        return true
    }
}

private struct C18_SequenceGestureValueExample: View {
    @GestureState private var dragState = C18_PressDragState.inactive

    var body: some View {
        let gesture = LongPressGesture(minimumDuration: 0.4)
            .sequenced(before: DragGesture())
            .updating($dragState) { value, state, _ in
                switch value {
                case .first(true):             state = .pressing
                case .second(true, .none):     state = .armed
                case .second(true, let drag?): state = .dragging(drag.translation)
                default:                       state = .inactive
                }
            }

        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 12)
                .fill(dragState.isActive ? Color.blue : Color.gray)
                .frame(width: 64, height: 64)
                .scaleEffect(dragState.isActive ? 1.15 : 1)
                .offset(dragState.translation)
                .gesture(gesture)
                .animation(.snappy, value: dragState.isActive)
                .frame(maxWidth: .infinity)
                .frame(height: 110)
            Text(dragState.label)
                .font(.caption.monospacedDigit()).foregroundStyle(.secondary)
        }
    }
}

// MARK: - SimultaneousGesture

private struct C18_SimultaneousGestureInitExample: View {
    @State private var zoom: CGFloat = 1
    @State private var degrees = 0.0

    var body: some View {
        let manipulate = SimultaneousGesture(MagnifyGesture(), RotateGesture())
            .onChanged { value in
                zoom = value.first?.magnification ?? zoom
                degrees = value.second?.rotation.degrees ?? degrees
            }
            .onEnded { _ in withAnimation(.snappy) { zoom = 1; degrees = 0 } }

        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.orange.gradient)
                .frame(width: 100, height: 70)
                .scaleEffect(zoom)
                .rotationEffect(.degrees(degrees))
                .frame(maxWidth: .infinity)
                .frame(height: 120)
                .clipped()
                .contentShape(Rectangle())
                .gesture(manipulate)
            Text(String(format: "zoom %.2f   rotation %.0f° — pinch and twist together", zoom, degrees))
                .font(.caption.monospacedDigit()).foregroundStyle(.secondary)
        }
    }
}

private struct C18_SimultaneousGestureValueExample: View {
    @State private var first: CGFloat? = nil
    @State private var second: Angle? = nil
    @State private var committed = "—"

    var body: some View {
        let gesture = SimultaneousGesture(MagnifyGesture(), RotateGesture())
            .onChanged { value in
                first = value.first?.magnification
                second = value.second?.rotation
            }
            .onEnded { value in
                let finalZoom = value.first?.magnification ?? 1
                let finalTwist = value.second?.rotation ?? .zero
                committed = String(format: "zoom %.2f, rotation %.0f°", finalZoom, finalTwist.degrees)
                first = nil
                second = nil
            }

        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.indigo.gradient)
                .frame(width: 120, height: 60)
                .overlay(Text("pinch + twist").font(.caption).foregroundStyle(.white))
                .frame(maxWidth: .infinity)
                .frame(height: 80)
                .contentShape(Rectangle())
                .gesture(gesture)
            Grid(alignment: .leading, verticalSpacing: 2) {
                GridRow {
                    Text("value.first").foregroundStyle(.secondary)
                    Text(first.map { String(format: "%.2f", $0) } ?? "nil")
                }
                GridRow {
                    Text("value.second").foregroundStyle(.secondary)
                    Text(second.map { String(format: "%.0f°", $0.degrees) } ?? "nil")
                }
                GridRow {
                    Text("committed").foregroundStyle(.secondary)
                    Text(committed)
                }
            }
            .font(.caption.monospacedDigit())
        }
    }
}

// MARK: - SpatialEventGesture

private struct C18_SpatialEventCoordinateSpaceExample: View {
    @State private var touches: [CGPoint] = []

    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 8).fill(.quaternary)
                ForEach(Array(touches.enumerated()), id: \.offset) { _, point in
                    Circle().fill(.blue).frame(width: 14, height: 14).position(point)
                }
            }
            .frame(height: 110)
            .coordinateSpace(.named("pad"))
            .gesture(
                SpatialEventGesture(coordinateSpace: .named("pad"))
                    .onChanged { events in
                        touches = events.map(\.location)
                    }
                    .onEnded { _ in touches = [] }
            )
            Text(touches.first.map { String(format: "location in \"pad\": (%.0f, %.0f)", $0.x, $0.y) }
                 ?? "Click or drag on the pad")
                .font(.caption.monospacedDigit()).foregroundStyle(.secondary)
        }
    }
}

private struct C18_SpatialEventExample: View {
    @State private var strokes: [SpatialEventCollection.Event.ID: [CGPoint]] = [:]
    @State private var inputKind = "—"

    var body: some View {
        VStack(spacing: 8) {
            Canvas { context, _ in
                for points in strokes.values {
                    guard let firstPoint = points.first else { continue }
                    var path = Path()
                    path.move(to: firstPoint)
                    for point in points.dropFirst() { path.addLine(to: point) }
                    context.stroke(path, with: .color(.blue), style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                }
            }
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
            .frame(height: 110)
            .gesture(
                SpatialEventGesture().onChanged { events in
                    for event in events {
                        strokes[event.id, default: []].append(event.location)
                        inputKind = "\(event.kind)"
                    }
                }
            )
            HStack {
                Text("event.kind: \(inputKind)   strokes: \(strokes.count)")
                    .font(.caption.monospacedDigit()).foregroundStyle(.secondary)
                Button("Clear") { strokes = [:] }.controlSize(.small)
            }
        }
    }
}

private struct C18_SpatialEventPhaseExample: View {
    @State private var phaseLabel = "—"
    @State private var activeCount = 0
    @State private var lastLocation: CGPoint? = nil

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 8).fill(.quaternary)
                if let lastLocation {
                    Circle()
                        .fill(activeCount > 0 ? Color.green : Color.gray)
                        .frame(width: 18, height: 18)
                        .position(lastLocation)
                }
            }
            .frame(height: 100)
            .gesture(
                SpatialEventGesture()
                    .onChanged { events in
                        var active = 0
                        for event in events {
                            switch event.phase {
                            case .active:
                                active += 1
                                phaseLabel = "active"
                                lastLocation = event.location
                            case .ended:
                                phaseLabel = "ended"
                            case .cancelled:
                                phaseLabel = "cancelled"
                            @unknown default:
                                break
                            }
                        }
                        activeCount = active
                    }
                    .onEnded { events in
                        var cancelled = false
                        for event in events {
                            if case .cancelled = event.phase { cancelled = true }
                        }
                        phaseLabel = cancelled ? "cancelled" : "ended"
                        activeCount = 0
                    }
            )
            Text("event.phase: \(phaseLabel)   active events: \(activeCount)")
                .font(.caption.monospacedDigit()).foregroundStyle(.secondary)
        }
    }
}

// MARK: - SpatialTapGesture

private struct C18_SpatialTapInitExample: View {
    @State private var focus: CGPoint? = nil

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 8).fill(.teal.opacity(0.2))
                if let focus {
                    Circle()
                        .stroke(.teal, lineWidth: 3)
                        .frame(width: 36, height: 36)
                        .position(focus)
                }
            }
            .frame(height: 110)
            .contentShape(Rectangle())
            .gesture(
                SpatialTapGesture(count: 2, coordinateSpace: .local)
                    .onEnded { value in
                        withAnimation(.bouncy) { focus = value.location }
                    }
            )
            Text(focus.map { String(format: "double-click at (%.0f, %.0f) in .local", $0.x, $0.y) }
                 ?? "Double-click anywhere on the pad")
                .font(.caption.monospacedDigit()).foregroundStyle(.secondary)
        }
    }
}

private struct C18_SpatialTapValueExample: View {
    @State private var markers: [Int: Int] = [:]
    private let columns = 6

    var body: some View {
        VStack(spacing: 8) {
            GeometryReader { geo in
                let cellSize = geo.size.width / CGFloat(columns)
                let dot = min(cellSize * 0.4, 22)
                HStack(spacing: 0) {
                    ForEach(0..<columns, id: \.self) { column in
                        VStack(spacing: 2) {
                            Spacer(minLength: 0)
                            ForEach(0..<(markers[column] ?? 0), id: \.self) { _ in
                                Circle().fill(.red).frame(width: dot, height: dot)
                            }
                        }
                        .frame(width: cellSize)
                        .padding(.bottom, 4)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .contentShape(Rectangle())
                .gesture(SpatialTapGesture().onEnded { value in
                    let column = min(Int(value.location.x / cellSize), columns - 1)
                    withAnimation(.bouncy) { markers[column, default: 0] += 1 }
                })
            }
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
            .frame(height: 110)
            HStack {
                Text("Click a column — value.location.x picks it")
                    .font(.caption).foregroundStyle(.secondary)
                Button("Clear") { markers = [:] }.controlSize(.small)
            }
        }
    }
}

// MARK: - Spring

private struct C18_SpringDurationBounceExample: View {
    @State private var isRight = false
    @State private var bounce = 0.3

    var body: some View {
        VStack(spacing: 10) {
            Circle()
                .fill(.blue)
                .frame(width: 36, height: 36)
                .frame(maxWidth: .infinity, alignment: isRight ? .trailing : .leading)
                .padding(.horizontal, 24)
                .frame(height: 44)
            Slider(value: $bounce, in: 0...0.9) { Text("bounce") }
            Text(String(format: "Spring(duration: 0.5, bounce: %.2f)", bounce))
                .font(.caption.monospacedDigit()).foregroundStyle(.secondary)
            Button("Toggle") {
                let lively = Spring(duration: 0.5, bounce: bounce)
                withAnimation(.spring(lively)) { isRight.toggle() }
            }
        }
    }
}

private struct C18_SpringPhysicalExample: View {
    @State private var isOpen = false
    @State private var damping = 24.0

    var body: some View {
        VStack(spacing: 10) {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8).fill(.quaternary)
                RoundedRectangle(cornerRadius: 8)
                    .fill(.brown.gradient)
                    .frame(width: isOpen ? 200 : 60)
                    .overlay(Image(systemName: "tray.fill").foregroundStyle(.white))
            }
            .frame(width: 240, height: 40)
            Slider(value: $damping, in: 4...60) { Text("damping") }
            Text(String(format: "Spring(mass: 2, stiffness: 180, damping: %.0f, allowOverDamping: true)", damping))
                .font(.caption.monospacedDigit()).foregroundStyle(.secondary)
            Button(isOpen ? "Close drawer" : "Open drawer") {
                let heavy = Spring(mass: 2, stiffness: 180, damping: damping, allowOverDamping: true)
                withAnimation(.spring(heavy)) { isOpen.toggle() }
            }
        }
    }
}

/// A three-tab strip whose highlight slides with whatever animation is in the transaction.
private struct C18_TabStrip: View {
    let selected: Int
    let namespace: Namespace.ID
    var onSelect: ((Int) -> Void)? = nil
    private let tabs = ["Library", "Search", "Settings"]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs.indices, id: \.self) { i in
                Text(tabs[i])
                    .font(.callout)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 6)
                    .background {
                        if selected == i {
                            Capsule()
                                .fill(.blue.opacity(0.25))
                                .matchedGeometryEffect(id: "indicator", in: namespace)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture { onSelect?(i) }
            }
        }
        .padding(4)
        .background(.quaternary, in: Capsule())
    }
}

private struct C18_SpringResponseExample: View {
    @State private var selected = 0
    @State private var dampingRatio = 0.8
    @Namespace private var namespace

    var body: some View {
        VStack(spacing: 10) {
            C18_TabStrip(selected: selected, namespace: namespace) { index in
                let quick = Spring(response: 0.3, dampingRatio: dampingRatio)
                withAnimation(.spring(quick)) { selected = index }
            }
            Slider(value: $dampingRatio, in: 0.2...1) { Text("dampingRatio") }
            Text(String(format: "Spring(response: 0.3, dampingRatio: %.2f) — click a tab", dampingRatio))
                .font(.caption.monospacedDigit()).foregroundStyle(.secondary)
        }
    }
}

private struct C18_SpringValueExample: View {
    @State private var start = Date()
    private let spring = Spring(duration: 0.6, bounce: 0.2)

    var body: some View {
        VStack(spacing: 8) {
            TimelineView(.animation) { context in
                let t = context.date.timeIntervalSince(start)
                let x = spring.value(target: 160.0, initialVelocity: 0, time: t)
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 8).fill(.quaternary)
                    Circle().fill(.purple).frame(width: 24, height: 24).offset(x: x + 8)
                }
                .frame(width: 200, height: 44)
                Text(String(format: "time %.2f s → value %.1f of 160", min(t, 9.99), x))
                    .font(.caption.monospacedDigit()).foregroundStyle(.secondary)
            }
            Button("Replay") { start = Date() }
        }
    }
}

// MARK: - Transaction

private struct C18_TransactionAnimationExample: View {
    @State private var selected = 0
    @Namespace private var namespace

    var body: some View {
        VStack(spacing: 10) {
            C18_TabStrip(selected: selected, namespace: namespace)
            HStack {
                Button("Next with Transaction(animation:)") {
                    let t = Transaction(animation: .easeInOut(duration: 0.6))
                    withTransaction(t) { selected = (selected + 1) % 3 }
                }
                Button("Next, plain assignment") { selected = (selected + 1) % 3 }
            }
            .controlSize(.small)
        }
    }
}

private struct C18_TransactionDisablesAnimationsExample: View {
    @State private var progress = 0.0

    var body: some View {
        VStack(spacing: 10) {
            ZStack(alignment: .leading) {
                Capsule().fill(.quaternary)
                Capsule().fill(.blue).frame(width: 220 * progress)
            }
            .frame(width: 220, height: 12)
            .animation(.easeInOut(duration: 1), value: progress)
            Text(String(format: "%.0f %%", progress * 100))
                .font(.caption.monospacedDigit()).foregroundStyle(.secondary)
            HStack {
                Button("Animate") { progress = progress >= 1 ? 0 : 1 }
                Button("Snap (disablesAnimations)") {
                    var t = Transaction()
                    t.disablesAnimations = true
                    withTransaction(t) { progress = progress >= 1 ? 0 : 1 }
                }
            }
            .controlSize(.small)
        }
    }
}

private struct C18_TransactionIsContinuousExample: View {
    @State private var offset: CGSize = .zero
    @State private var markContinuous = true

    var body: some View {
        VStack(spacing: 8) {
            Circle()
                .fill(.orange)
                .frame(width: 48, height: 48)
                .offset(offset)
                .transaction { t in
                    if t.isContinuous { t.animation = nil }
                }
                .animation(.bouncy(duration: 0.6), value: offset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            var t = Transaction()
                            t.isContinuous = markContinuous
                            withTransaction(t) { offset = value.translation }
                        }
                        .onEnded { _ in offset = .zero }
                )
                .frame(maxWidth: .infinity)
                .frame(height: 96)
            Toggle("Mark drag updates isContinuous", isOn: $markContinuous)
                .toggleStyle(.switch)
                .controlSize(.small)
            C18_Caption("On: the circle tracks the pointer exactly. Off: every update animates and lags. Release always springs back.")
        }
    }
}

private struct C18_TransactionCompletionExample: View {
    @State private var overlayShown = true
    @State private var log = "—"

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 8).fill(.quaternary)
                if overlayShown {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.blue.gradient)
                        .overlay(Text("Overlay").foregroundStyle(.white))
                        .padding(12)
                        .transition(.scale.combined(with: .opacity))
                }
            }
            .frame(height: 80)
            Text("completion: \(log)")
                .font(.caption).foregroundStyle(.secondary)
            Button(overlayShown ? "Dismiss overlay" : "Show overlay") {
                if overlayShown {
                    var t = Transaction(animation: .bouncy)
                    t.addAnimationCompletion(criteria: .removed) {
                        log = "overlay removed — cleaned up"
                    }
                    withTransaction(t) { overlayShown = false }
                } else {
                    log = "—"
                    withAnimation(.bouncy) { overlayShown = true }
                }
            }
        }
    }
}

// MARK: - TransitionPhase

private nonisolated struct C18_RiseTransition: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .offset(y: phase == .willAppear ? 40 : 0)
            .opacity(phase == .willAppear ? 0 : 1)
    }
}

private nonisolated struct C18_ShrinkAwayTransition: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .scaleEffect(phase == .didDisappear ? 0.6 : 1)
            .opacity(phase == .didDisappear ? 0 : 1)
    }
}

private nonisolated struct C18_SlideThroughTransition: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .offset(x: phase.value * 120)
            .opacity(1 - abs(phase.value))
    }
}

private struct C18_TransitionWillAppearExample: View {
    @State private var shown = true

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 8).fill(.quaternary)
                if shown {
                    Label("New message", systemImage: "envelope.fill")
                        .padding(10)
                        .background(.blue.opacity(0.2), in: RoundedRectangle(cornerRadius: 8))
                        .transition(C18_RiseTransition())
                }
            }
            .frame(height: 80)
            Button(shown ? "Remove" : "Insert") {
                withAnimation(.easeOut(duration: 0.6)) { shown.toggle() }
            }
            C18_Caption("Insertion rises in from below; removal is a plain cut because .didDisappear is styled as identity")
        }
    }
}

private struct C18_TransitionDidDisappearExample: View {
    @State private var shown = true

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 8).fill(.quaternary)
                if shown {
                    Label("Draft", systemImage: "doc.text")
                        .padding(10)
                        .background(.orange.opacity(0.25), in: RoundedRectangle(cornerRadius: 8))
                        .transition(C18_ShrinkAwayTransition())
                }
            }
            .frame(height: 80)
            Button(shown ? "Remove" : "Insert") {
                withAnimation(.easeIn(duration: 0.5)) { shown.toggle() }
            }
            C18_Caption("Removal shrinks and fades; insertion is a plain cut because .willAppear is styled as identity")
        }
    }
}

private struct C18_TransitionValueExample: View {
    @State private var shown = true

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 8).fill(.quaternary)
                if shown {
                    Label("Chip", systemImage: "tag.fill")
                        .padding(10)
                        .background(.green.opacity(0.25), in: Capsule())
                        .transition(C18_SlideThroughTransition())
                }
            }
            .frame(height: 80)
            .clipped()
            Button(shown ? "Remove" : "Insert") {
                withAnimation(.easeInOut(duration: 0.6)) { shown.toggle() }
            }
            C18_Caption("phase.value runs -1 → 0 on insertion and 0 → +1 on removal, so it enters from the left and leaves to the right")
        }
    }
}

// MARK: - UnitCurve

private struct C18_UnitCurveBezierExample: View {
    @State private var isRight = false
    private let overshoot = UnitCurve.bezier(
        startControlPoint: UnitPoint(x: 0.34, y: 1.56),
        endControlPoint: UnitPoint(x: 0.64, y: 1)
    )

    var body: some View {
        HStack(spacing: 16) {
            C18_CurvePlot(curve: overshoot).frame(width: 100, height: 100)
            VStack(spacing: 10) {
                Circle()
                    .fill(.blue)
                    .frame(width: 28, height: 28)
                    .frame(maxWidth: .infinity, alignment: isRight ? .trailing : .leading)
                    .padding(.horizontal, 12)
                    .frame(height: 40)
                Button("Play") {
                    withAnimation(.timingCurve(overshoot, duration: 0.8)) { isRight.toggle() }
                }
                C18_Caption("The curve climbs above 1, so the dot overshoots its target before settling")
            }
        }
    }
}

private struct C18_UnitCurveValueExample: View {
    @State private var fraction = 0.35

    var body: some View {
        let eased = UnitCurve.easeInOut.value(at: fraction)
        VStack(spacing: 8) {
            HStack(spacing: 16) {
                C18_CurvePlot(curve: .easeInOut, marker: fraction).frame(width: 84, height: 84)
                VStack(alignment: .leading, spacing: 10) {
                    C18_UnitBar(title: "linear", amount: fraction, tint: .gray)
                    C18_UnitBar(title: "easeInOut.value(at:)", amount: eased, tint: .blue)
                }
            }
            Slider(value: $fraction, in: 0...1)
            Text(String(format: "value(at: %.2f) = %.3f", fraction, eased))
                .font(.caption.monospacedDigit()).foregroundStyle(.secondary)
        }
    }
}

private struct C18_UnitBar: View {
    let title: String
    let amount: Double
    let tint: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title).font(.caption2).foregroundStyle(.secondary)
            ZStack(alignment: .leading) {
                Capsule().fill(.quaternary)
                Capsule().fill(tint).frame(width: 160 * amount)
            }
            .frame(width: 160, height: 10)
        }
    }
}

private struct C18_UnitCurveVelocityExample: View {
    @State private var fraction = 0.25
    private let curve = UnitCurve.easeOut
    private let spring = Spring(duration: 0.4, bounce: 0.2)

    var body: some View {
        let speed = curve.velocity(at: fraction)
        let carried = spring.value(target: 1.0, initialVelocity: speed, time: 0.1)
        VStack(spacing: 8) {
            HStack(spacing: 16) {
                C18_CurvePlot(curve: curve, marker: fraction, tangent: true).frame(width: 84, height: 84)
                VStack(alignment: .leading, spacing: 4) {
                    Text(String(format: "easeOut.velocity(at: %.2f)", fraction))
                    Text(String(format: "= %.2f  (slope of the orange tangent)", speed))
                    Text(String(format: "spring at 0.1 s with that velocity: %.3f", carried))
                        .foregroundStyle(.secondary)
                }
                .font(.caption.monospacedDigit())
            }
            Slider(value: $fraction, in: 0...1)
        }
    }
}

private struct C18_UnitCurveInverseExample: View {
    private let easeIn = UnitCurve.easeIn

    var body: some View {
        let mirrored = easeIn.inverse
        HStack(spacing: 20) {
            VStack(spacing: 4) {
                C18_CurvePlot(curve: easeIn, marker: 0.25).frame(width: 84, height: 84)
                Text("easeIn").font(.caption)
                Text(String(format: "value(at: 0.25) = %.3f", easeIn.value(at: 0.25)))
                    .font(.caption2.monospacedDigit()).foregroundStyle(.secondary)
            }
            Image(systemName: "arrow.left.arrow.right").foregroundStyle(.secondary)
            VStack(spacing: 4) {
                C18_CurvePlot(curve: mirrored, marker: 0.25, tint: .green).frame(width: 84, height: 84)
                Text("easeIn.inverse").font(.caption)
                Text(String(format: "value(at: 0.25) = %.3f", mirrored.value(at: 0.25)))
                    .font(.caption2.monospacedDigit()).foregroundStyle(.secondary)
            }
        }
    }
}

// MARK: - VectorArithmetic

private struct C18_VectorScaleExample: View {
    @State private var amount = 0.5
    private let start = AnimatablePair(20.0, 70.0)
    private let end = AnimatablePair(220.0, 20.0)

    private func scaledDelta(_ amount: Double) -> AnimatablePair<Double, Double> {
        var delta = end
        delta -= start
        delta.scale(by: amount)
        return delta
    }

    var body: some View {
        let delta = scaledDelta(amount)
        VStack(spacing: 8) {
            Canvas { context, _ in
                let origin = CGPoint(x: start.first, y: start.second)
                let full = CGPoint(x: end.first, y: end.second)
                let tip = CGPoint(x: start.first + delta.first, y: start.second + delta.second)
                var dashed = Path()
                dashed.move(to: origin)
                dashed.addLine(to: full)
                context.stroke(dashed, with: .color(.gray.opacity(0.5)), style: StrokeStyle(lineWidth: 1, dash: [4, 4]))
                var line = Path()
                line.move(to: origin)
                line.addLine(to: tip)
                context.stroke(line, with: .color(.blue), lineWidth: 3)
                context.fill(Path(ellipseIn: CGRect(x: origin.x - 5, y: origin.y - 5, width: 10, height: 10)), with: .color(.gray))
                context.fill(Path(ellipseIn: CGRect(x: tip.x - 6, y: tip.y - 6, width: 12, height: 12)), with: .color(.blue))
            }
            .frame(width: 240, height: 90)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
            Slider(value: $amount, in: 0...1)
            Text(String(format: "delta.scale(by: %.2f) → (%.0f, %.0f)", amount, delta.first, delta.second))
                .font(.caption.monospacedDigit()).foregroundStyle(.secondary)
        }
    }
}

private struct C18_VectorMagnitudeExample: View {
    @State private var progress = 0.0
    private let target = AnimatablePair(200.0, 50.0)

    private func remaining(from current: AnimatablePair<Double, Double>) -> AnimatablePair<Double, Double> {
        var remaining = target
        remaining -= current
        return remaining
    }

    var body: some View {
        let current = AnimatablePair(target.first * progress, target.second * progress)
        let gap = remaining(from: current)
        let settled = gap.magnitudeSquared < 0.0001
        VStack(spacing: 8) {
            Canvas { context, _ in
                let origin = CGPoint(x: 20, y: 20)
                let goal = CGPoint(x: origin.x + target.first, y: origin.y + target.second)
                let dot = CGPoint(x: origin.x + current.first, y: origin.y + current.second)
                context.stroke(Path(ellipseIn: CGRect(x: goal.x - 9, y: goal.y - 9, width: 18, height: 18)),
                               with: .color(settled ? .green : .gray), lineWidth: 2)
                context.fill(Path(ellipseIn: CGRect(x: dot.x - 6, y: dot.y - 6, width: 12, height: 12)),
                             with: .color(settled ? .green : .blue))
            }
            .frame(width: 250, height: 90)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
            Slider(value: $progress, in: 0...1)
            Text(String(format: "remaining.magnitudeSquared = %.1f", gap.magnitudeSquared)
                 + (settled ? "  → settled" : ""))
                .font(.caption.monospacedDigit())
                .foregroundStyle(settled ? .green : .secondary)
        }
    }
}

private struct C18_VectorInterpolatedExample: View {
    @State private var amount = 0.5
    private let a = AnimatablePair(0.0, 10.0)
    private let b = AnimatablePair(100.0, 0.0)

    private func plot(_ p: AnimatablePair<Double, Double>) -> CGPoint {
        CGPoint(x: 20 + p.first * 2, y: 15 + p.second * 6)
    }

    var body: some View {
        let mid = a.interpolated(towards: b, amount: amount)
        let pa = plot(a), pb = plot(b), pm = plot(mid)
        VStack(spacing: 8) {
            Canvas { context, _ in
                var line = Path()
                line.move(to: pa)
                line.addLine(to: pb)
                context.stroke(line, with: .color(.gray.opacity(0.5)), style: StrokeStyle(lineWidth: 1, dash: [4, 4]))
                context.fill(Path(ellipseIn: CGRect(x: pa.x - 5, y: pa.y - 5, width: 10, height: 10)), with: .color(.gray))
                context.fill(Path(ellipseIn: CGRect(x: pb.x - 5, y: pb.y - 5, width: 10, height: 10)), with: .color(.gray))
                context.fill(Path(ellipseIn: CGRect(x: pm.x - 7, y: pm.y - 7, width: 14, height: 14)), with: .color(.blue))
                context.draw(Text("a").font(.caption2), at: CGPoint(x: pa.x - 10, y: pa.y))
                context.draw(Text("b").font(.caption2), at: CGPoint(x: pb.x + 10, y: pb.y))
            }
            .frame(width: 240, height: 90)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
            Slider(value: $amount, in: 0...1)
            Text(String(format: "a.interpolated(towards: b, amount: %.2f) = (%.1f, %.1f)", amount, mid.first, mid.second))
                .font(.caption.monospacedDigit()).foregroundStyle(.secondary)
        }
    }
}

// MARK: - withAnimation()

private struct C18_WithAnimationExample: View {
    @State private var isFavorite = false
    @State private var log = "—"

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: isFavorite ? "star.fill" : "star")
                .font(.system(size: 40))
                .foregroundStyle(isFavorite ? Color.yellow : Color.gray)
                .scaleEffect(isFavorite ? 1.4 : 1)
                .frame(height: 64)
            Button("Favorite") {
                let nowFavorite = withAnimation(.bouncy) {
                    isFavorite.toggle()
                    return isFavorite
                }
                log = "returned \(nowFavorite)"
            }
            Text(log).font(.caption.monospaced()).foregroundStyle(.secondary)
        }
    }
}

private struct C18_WithAnimationCompletionExample: View {
    private static let messages = ["Saved", "Synced to iCloud", "Shared with Ana"]
    @State private var queue = C18_WithAnimationCompletionExample.messages
    @State private var toastVisible = true

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 8).fill(.quaternary)
                if toastVisible, let message = queue.first {
                    Label(message, systemImage: "checkmark.circle.fill")
                        .padding(.horizontal, 12).padding(.vertical, 6)
                        .background(.blue.opacity(0.2), in: Capsule())
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .frame(height: 70)
            .clipped()
            HStack {
                Button("Dismiss") {
                    withAnimation(.easeOut, completionCriteria: .removed) {
                        toastVisible = false
                    } completion: {
                        if !queue.isEmpty { queue.removeFirst() }
                        if !queue.isEmpty { withAnimation(.bouncy) { toastVisible = true } }
                    }
                }
                .disabled(!toastVisible || queue.isEmpty)
                Button("Reset") {
                    queue = Self.messages
                    withAnimation(.bouncy) { toastVisible = true }
                }
            }
            .controlSize(.small)
            Text("\(queue.count) queued — the next toast appears only after the removal completes")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

// MARK: - withTransaction()

private struct C18_WithTransactionExample: View {
    @State private var selected = 0
    @Namespace private var namespace

    var body: some View {
        VStack(spacing: 10) {
            C18_TabStrip(selected: selected, namespace: namespace)
                .animation(.bouncy(duration: 1.5), value: selected)
            HStack {
                Button("Next with withTransaction(t)") {
                    var t = Transaction(animation: .easeInOut(duration: 0.2))
                    t.disablesAnimations = true
                    withTransaction(t) { selected = (selected + 1) % 3 }
                }
                Button("Next, plain (downstream bouncy 1.5 s)") { selected = (selected + 1) % 3 }
            }
            .controlSize(.small)
        }
    }
}

private struct C18_WithTransactionKeyPathExample: View {
    @State private var selected = 0
    @Namespace private var namespace

    var body: some View {
        VStack(spacing: 10) {
            C18_TabStrip(selected: selected, namespace: namespace)
                .animation(.bouncy, value: selected)
            HStack {
                Button("Next, no animation") {
                    withTransaction(\.disablesAnimations, true) {
                        selected = (selected + 1) % 3
                    }
                }
                Button("Next, plain (bouncy)") { selected = (selected + 1) % 3 }
            }
            .controlSize(.small)
        }
    }
}

// MARK: - .backgroundTask() (unavailable on macOS — illustrations)

private struct C18_BackgroundTaskCard: View {
    let call: String
    let trigger: String
    let handler: String

    var body: some View {
        VStack(spacing: 6) {
            C18_MockScene(title: "WindowGroup  .backgroundTask(\(call))") {
                HStack(spacing: 10) {
                    step("System", "clock.badge", trigger)
                    Image(systemName: "arrow.right").foregroundStyle(.secondary)
                    step("Scene handler", "bolt.fill", handler)
                }
            }
            C18_Caption("Illustrative — iOS, tvOS and watchOS only; registered at the Scene level")
        }
    }

    private func step(_ title: String, _ symbol: String, _ detail: String) -> some View {
        VStack(spacing: 4) {
            Label(title, systemImage: symbol).font(.caption.bold())
            Text(detail).font(.caption2).foregroundStyle(.secondary).multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(6)
        .background(.blue.opacity(0.1), in: RoundedRectangle(cornerRadius: 6))
    }
}

private struct C18_BackgroundTaskAppRefreshExample: View {
    var body: some View {
        C18_BackgroundTaskCard(
            call: ".appRefresh(\"com.example.refresh\")",
            trigger: "grants a short refresh window for the BGAppRefreshTask identifier",
            handler: "await store.refreshTimeline()")
    }
}

private struct C18_BackgroundTaskURLSessionExample: View {
    var body: some View {
        C18_BackgroundTaskCard(
            call: ".urlSession(\"com.example.downloads\")",
            trigger: "wakes the app when that background URLSession's transfers need processing",
            handler: "await downloads.handleSessionEvents()")
    }
}

private struct C18_BackgroundTaskMatchingExample: View {
    private let sessions = ["com.example.export.pdf", "com.example.downloads", "com.example.export.csv", "com.other.sync"]
    private let matches: (String) -> Bool = { $0.hasPrefix("com.example.export.") }

    var body: some View {
        VStack(spacing: 6) {
            C18_MockScene(title: "WindowGroup  .backgroundTask(.urlSession(matching:))") {
                VStack(alignment: .leading, spacing: 3) {
                    ForEach(sessions, id: \.self) { id in
                        HStack(spacing: 6) {
                            Image(systemName: matches(id) ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(matches(id) ? Color.green : Color.secondary)
                            Text(id).font(.caption.monospaced())
                            if matches(id) {
                                Text("→ handler(identifier)").font(.caption2).foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            C18_Caption("Illustrative — iOS, tvOS and watchOS only. The predicate { $0.hasPrefix(\"com.example.export.\") } is evaluated live above.")
        }
    }
}

// MARK: - .environment()

private struct C18_EnvironmentKeyPathExample: View {
    var body: some View {
        HStack(spacing: 12) {
            VStack(spacing: 4) {
                Text("default").font(.caption)
                List {
                    Text("Row 1")
                    Text("Row 2")
                    Text("Row 3")
                }
            }
            VStack(spacing: 4) {
                Text(".environment(\\.defaultMinListRowHeight, 60)").font(.caption)
                List {
                    Text("Row 1")
                    Text("Row 2")
                    Text("Row 3")
                }
                .environment(\.defaultMinListRowHeight, 60)
            }
        }
        .frame(height: 170)
    }
}

@Observable
private final class C18_AppState {
    var unread = 3
}

private struct C18_InboxBadge: View {
    @Environment(C18_AppState.self) private var state

    var body: some View {
        Label("\(state.unread) unread", systemImage: "tray.fill")
            .font(.title3)
            .padding(10)
            .background(.blue.opacity(0.15), in: RoundedRectangle(cornerRadius: 8))
    }
}

private struct C18_EnvironmentObjectExample: View {
    @State private var appState = C18_AppState()

    var body: some View {
        VStack(spacing: 10) {
            C18_InboxBadge()
            HStack {
                Button("Mark one read") { appState.unread = max(0, appState.unread - 1) }
                Button("New mail") { appState.unread += 1 }
            }
            .controlSize(.small)
            C18_Caption("The badge reads the object through @Environment(AppState.self); no binding is passed down")
        }
        .environment(appState)
    }
}

// MARK: - .modelContainer() (SwiftData — Scene-level illustrations)

private struct C18_SchemaBadge: View {
    let name: String
    var body: some View {
        Label(name, systemImage: "cylinder.split.1x2")
            .font(.caption.bold())
            .padding(.horizontal, 8).padding(.vertical, 4)
            .background(.purple.opacity(0.15), in: Capsule())
    }
}

private struct C18_ModelContainerConvenienceExample: View {
    var body: some View {
        VStack(spacing: 6) {
            C18_MockScene(title: "WindowGroup  .modelContainer(for: [Recipe.self, Step.self], …)") {
                HStack(alignment: .top, spacing: 14) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Schema").font(.caption2).foregroundStyle(.secondary)
                        C18_SchemaBadge(name: "Recipe")
                        C18_SchemaBadge(name: "Step")
                    }
                    VStack(alignment: .leading, spacing: 3) {
                        flag("inMemory", false)
                        flag("isAutosaveEnabled", true)
                        flag("isUndoEnabled", true)
                        Label("onSetup → .success(container)", systemImage: "checkmark.seal")
                            .font(.caption2).foregroundStyle(.green)
                    }
                }
            }
            C18_Caption("Illustrative — installs a SwiftData container at the Scene level; @Query and \\.modelContext work below it")
        }
    }

    private func flag(_ name: String, _ on: Bool) -> some View {
        HStack(spacing: 4) {
            Image(systemName: on ? "checkmark.square.fill" : "square").foregroundStyle(on ? Color.blue : Color.secondary)
            Text("\(name): \(on ? "true" : "false")").font(.caption2.monospaced())
        }
    }
}

private struct C18_ModelContainerCustomExample: View {
    var body: some View {
        VStack(spacing: 6) {
            C18_MockScene(title: ".modelContainer(container)") {
                VStack(alignment: .leading, spacing: 6) {
                    Text("ModelContainer(for: Recipe.self, migrationPlan: RecipeMigrationPlan.self)")
                        .font(.caption2.monospaced())
                    HStack(spacing: 6) {
                        ForEach(["SchemaV1", "SchemaV2", "SchemaV3"], id: \.self) { stage in
                            Text(stage).font(.caption2.bold())
                                .padding(.horizontal, 8).padding(.vertical, 4)
                                .background(.purple.opacity(0.15), in: Capsule())
                            if stage != "SchemaV3" {
                                Image(systemName: "arrow.right").font(.caption2).foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            C18_Caption("Illustrative — a container you construct yourself carries the migration plan, extra configurations, or CloudKit settings")
        }
    }
}

// MARK: - .tag()

private nonisolated enum C18_Tab: String, CaseIterable, Hashable {
    case home, search
}

private struct C18_TagExample: View {
    @State private var tab = C18_Tab.home

    var body: some View {
        VStack(spacing: 6) {
            TabView(selection: $tab) {
                Label("Home", systemImage: "house")
                    .tabItem { Text("Home") }
                    .tag(C18_Tab.home)
                Label("Search", systemImage: "magnifyingglass")
                    .tabItem { Text("Search") }
                    .tag(C18_Tab.search)
            }
            .frame(height: 120)
            HStack {
                Text("selection: .\(tab.rawValue)").font(.caption.monospaced())
                Button("Select .search") { tab = .search }.controlSize(.small)
            }
        }
    }
}

private struct C18_Coffee: Identifiable {
    let id: Int
    let name: String
}

private struct C18_TagIncludeOptionalExample: View {
    @State private var selectedID: Int? = nil
    private let items = [C18_Coffee(id: 1, name: "Espresso"), C18_Coffee(id: 2, name: "Cortado"), C18_Coffee(id: 3, name: "Flat White")]

    var body: some View {
        VStack(spacing: 6) {
            List(selection: $selectedID) {
                ForEach(items) { item in
                    Text(item.name).tag(item.id, includeOptional: true)
                }
            }
            .frame(height: 100)
            Text("selectedID (Int?): \(selectedID.map { "\($0)" } ?? "nil")")
                .font(.caption.monospaced())
            C18_Caption("includeOptional: true lets an Int tag satisfy the Int? selection; false demands an exact type match")
        }
    }
}

// MARK: - @Model (SwiftData — schema illustrations)

private struct C18_AttributeExample: View {
    var body: some View {
        VStack(spacing: 6) {
            C18_MockScene(title: "@Model final class Recipe") {
                Grid(alignment: .leading, horizontalSpacing: 12, verticalSpacing: 4) {
                    row("slug", "String", "@Attribute(.unique)")
                    row("photo", "Data?", "@Attribute(.externalStorage)")
                    row("name", "String", nil)
                }
            }
            C18_Caption("Illustrative — SwiftData schema. .unique turns a second insert with the same slug into an upsert; .externalStorage keeps blobs out of the store file")
        }
    }

    private func row(_ name: String, _ type: String, _ attribute: String?) -> some View {
        GridRow {
            Text(name).font(.caption.monospaced().bold())
            Text(type).font(.caption.monospaced()).foregroundStyle(.secondary)
            if let attribute {
                Text(attribute).font(.caption2.monospaced())
                    .padding(.horizontal, 6).padding(.vertical, 2)
                    .background(.orange.opacity(0.2), in: Capsule())
            } else {
                Text("—").foregroundStyle(.tertiary)
            }
        }
    }
}

private struct C18_RelationshipExample: View {
    @State private var recipeExists = true
    @State private var steps = ["Boil water", "Steep 4 min", "Pour"]

    var body: some View {
        VStack(spacing: 6) {
            C18_MockScene(title: "@Relationship(deleteRule: .cascade, inverse: \\Step.recipe)") {
                HStack(alignment: .top, spacing: 14) {
                    VStack(spacing: 4) {
                        if recipeExists {
                            C18_SchemaBadge(name: "Recipe: Tea")
                                .transition(.scale.combined(with: .opacity))
                        }
                    }
                    .frame(width: 110)
                    VStack(alignment: .leading, spacing: 3) {
                        ForEach(steps, id: \.self) { step in
                            Label(step, systemImage: "arrow.turn.down.right").font(.caption2)
                                .transition(.move(edge: .leading).combined(with: .opacity))
                        }
                        if steps.isEmpty {
                            Text("steps cascaded away").font(.caption2).foregroundStyle(.secondary)
                        }
                    }
                }
                .frame(height: 56, alignment: .top)
            }
            HStack {
                Button("Delete recipe") {
                    withAnimation(.easeInOut) {
                        recipeExists = false
                        steps = []
                    }
                }
                .disabled(!recipeExists)
                Button("Reset") {
                    withAnimation { recipeExists = true; steps = ["Boil water", "Steep 4 min", "Pour"] }
                }
            }
            .controlSize(.small)
            C18_Caption("Illustrative — the cascade is simulated; SwiftData applies the delete rule when the store saves")
        }
    }
}

// MARK: - @SectionedFetchRequest (Core Data — illustrations on sample data)

private struct C18_Quake: Identifiable {
    let id: Int
    let day: String
    let time: String
    let magnitude: Double
}

private let c18SampleQuakes: [C18_Quake] = [
    C18_Quake(id: 1, day: "Wed 3 Sep", time: "09:12", magnitude: 4.6),
    C18_Quake(id: 2, day: "Wed 3 Sep", time: "14:40", magnitude: 3.1),
    C18_Quake(id: 3, day: "Wed 3 Sep", time: "22:05", magnitude: 5.2),
    C18_Quake(id: 4, day: "Thu 4 Sep", time: "02:33", magnitude: 4.1),
    C18_Quake(id: 5, day: "Thu 4 Sep", time: "11:58", magnitude: 3.8),
    C18_Quake(id: 6, day: "Fri 5 Sep", time: "07:20", magnitude: 4.9),
]

/// Groups quakes into day sections, newest day first, keeping the given in-section order.
private func c18Sectioned(_ quakes: [C18_Quake]) -> [(day: String, quakes: [C18_Quake])] {
    let days = ["Fri 5 Sep", "Thu 4 Sep", "Wed 3 Sep"]
    return days.compactMap { day in
        let inDay = quakes.filter { $0.day == day }
        return inDay.isEmpty ? nil : (day: day, quakes: inDay)
    }
}

private struct C18_QuakeSections: View {
    let sections: [(day: String, quakes: [C18_Quake])]

    var body: some View {
        List {
            ForEach(sections, id: \.day) { section in
                Section(section.day) {
                    ForEach(section.quakes) { quake in
                        HStack {
                            Text(quake.time).font(.caption.monospacedDigit())
                            Spacer()
                            Text(String(format: "M %.1f", quake.magnitude))
                                .font(.caption.monospacedDigit().bold())
                                .foregroundStyle(quake.magnitude >= 4.5 ? Color.red : Color.primary)
                        }
                    }
                }
            }
        }
        .frame(height: 130)
    }
}

private struct C18_SectionedFetchInlineExample: View {
    var body: some View {
        let filtered = c18SampleQuakes
            .filter { $0.magnitude >= 4 }
            .sorted { $0.time > $1.time }
        VStack(spacing: 4) {
            C18_QuakeSections(sections: c18Sectioned(filtered))
            C18_Caption("Illustrative — a live Core Data fetch at runtime; here the predicate (magnitude >= 4) and reverse day/time sort are applied to sample rows")
        }
    }
}

private struct C18_SectionedFetchRequestExample: View {
    var body: some View {
        let limited = Array(c18SampleQuakes.reversed().prefix(4))
        VStack(spacing: 4) {
            C18_QuakeSections(sections: c18Sectioned(limited))
            C18_Caption("Illustrative — the NSFetchRequest carries fetchLimit = 4, so only the four newest rows arrive, still grouped by \\.day")
        }
    }
}

private struct C18_SectionedFetchConfigurationExample: View {
    @State private var strongestFirst = false

    var body: some View {
        let ordered = strongestFirst
            ? c18SampleQuakes.sorted { $0.magnitude > $1.magnitude }
            : c18SampleQuakes.sorted { $0.time > $1.time }
        VStack(spacing: 4) {
            C18_QuakeSections(sections: c18Sectioned(ordered))
            HStack {
                Button("Strongest first") { withAnimation { strongestFirst = true } }.disabled(strongestFirst)
                Button("Newest first") { withAnimation { strongestFirst = false } }.disabled(!strongestFirst)
            }
            .controlSize(.small)
            C18_Caption("Illustrative — assigning config.sortDescriptors re-runs the fetch; the same reorder is simulated here")
        }
    }
}

// MARK: - Binding

private struct C18_BindingConstantExample: View {
    @State private var bluetooth = true

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Toggle("Wi-Fi  (.constant(true))", isOn: .constant(true))
            Toggle("Bluetooth  ($bluetooth)", isOn: $bluetooth)
            C18_Caption("Click both: the constant binding never changes, the state-backed one flips")
        }
        .toggleStyle(.switch)
        .frame(width: 260)
    }
}

private nonisolated enum C18_Plan: String {
    case free, pro
}

private struct C18_BindingGetSetExample: View {
    @State private var plan = C18_Plan.free

    var body: some View {
        let isPro = Binding(
            get: { plan == .pro },
            set: { plan = $0 ? .pro : .free }
        )
        VStack(spacing: 10) {
            Toggle("Pro plan", isOn: isPro)
                .toggleStyle(.switch)
            Text("plan = .\(plan.rawValue)")
                .font(.caption.monospaced())
            Button("Set plan = .free directly") { plan = .free }
                .controlSize(.small)
            C18_Caption("The toggle reads and writes the enum through the two closures")
        }
    }
}

// MARK: - EnvironmentValues

private nonisolated struct C18_AccentTintKey: EnvironmentKey {
    static let defaultValue = Color.blue
}

private nonisolated extension EnvironmentValues {
    var accentTint: Color {
        get { self[C18_AccentTintKey.self] }
        set { self[C18_AccentTintKey.self] = newValue }
    }
}

private struct C18_TintedChip: View {
    @Environment(\.accentTint) private var accentTint
    let title: String

    var body: some View {
        Text(title)
            .font(.caption)
            .padding(.horizontal, 10).padding(.vertical, 6)
            .background(accentTint.opacity(0.25), in: Capsule())
            .overlay(Capsule().stroke(accentTint, lineWidth: 1))
    }
}

private struct C18_EnvironmentSubscriptExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 12) {
                C18_TintedChip(title: "default → .blue")
                C18_TintedChip(title: ".environment(\\.accentTint, .orange)")
                    .environment(\.accentTint, .orange)
            }
            C18_Caption("Both chips read @Environment(\\.accentTint); the getter and setter go through self[AccentTintKey.self]")
        }
    }
}

private struct C18_EnvironmentInitExample: View {
    var body: some View {
        let values = EnvironmentValues()
        Grid(alignment: .leading, horizontalSpacing: 14, verticalSpacing: 4) {
            GridRow {
                Text("values.accentTint").foregroundStyle(.secondary)
                HStack(spacing: 6) {
                    Circle().fill(values.accentTint).frame(width: 12, height: 12)
                    Text(values.accentTint == .blue ? ".blue — the key's defaultValue" : "custom")
                }
            }
            GridRow {
                Text("values.colorScheme").foregroundStyle(.secondary)
                Text(".\(String(describing: values.colorScheme))")
            }
            GridRow {
                Text("values.isEnabled").foregroundStyle(.secondary)
                Text(values.isEnabled ? "true" : "false")
            }
            GridRow {
                Text("values.controlSize").foregroundStyle(.secondary)
                Text(".\(String(describing: values.controlSize))")
            }
        }
        .font(.caption.monospaced())
    }
}

// MARK: - FetchedResults (Core Data — illustrations on sample rows)

private struct C18_Recipe: Identifiable {
    let id: Int
    let name: String
    let createdAt: Int
}

private let c18SampleRecipes: [C18_Recipe] = [
    C18_Recipe(id: 1, name: "Pancakes", createdAt: 3),
    C18_Recipe(id: 2, name: "Recipe 10", createdAt: 6),
    C18_Recipe(id: 3, name: "Recipe 2", createdAt: 5),
    C18_Recipe(id: 4, name: "Ramen", createdAt: 1),
    C18_Recipe(id: 5, name: "Risotto", createdAt: 4),
    C18_Recipe(id: 6, name: "Pad Thai", createdAt: 2),
]

private struct C18_RecipeList: View {
    let recipes: [C18_Recipe]

    var body: some View {
        List(recipes) { recipe in
            Label(recipe.name, systemImage: "fork.knife")
                .font(.caption)
        }
        .frame(height: 96)
    }
}

private struct C18_FetchedResultsPredicateExample: View {
    @State private var query = ""

    var body: some View {
        let shown = query.isEmpty
            ? c18SampleRecipes
            : c18SampleRecipes.filter { $0.name.localizedCaseInsensitiveContains(query) }
        VStack(spacing: 6) {
            TextField("Search recipes", text: $query)
                .textFieldStyle(.roundedBorder)
            C18_RecipeList(recipes: shown)
            C18_Caption("Illustrative — assigning recipes.nsPredicate re-executes the Core Data fetch; the same CONTAINS[cd] filter runs on sample rows here")
        }
    }
}

private nonisolated enum C18_RecipeOrder: String, CaseIterable {
    case newest, name
}

private struct C18_FetchedResultsSortExample: View {
    @State private var order = C18_RecipeOrder.newest

    var body: some View {
        let shown = order == .newest
            ? c18SampleRecipes.sorted { $0.createdAt > $1.createdAt }
            : c18SampleRecipes.sorted { $0.name < $1.name }
        VStack(spacing: 6) {
            Picker("Order", selection: $order) {
                ForEach(C18_RecipeOrder.allCases, id: \.self) { Text($0.rawValue).tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            C18_RecipeList(recipes: shown)
            C18_Caption("Illustrative — assigning recipes.sortDescriptors re-runs the fetch; the same reorder is simulated here")
        }
    }
}

private struct C18_FetchedResultsNSSortExample: View {
    var body: some View {
        let plain = c18SampleRecipes.sorted { $0.name < $1.name }
        let standard = c18SampleRecipes.sorted { $0.name.localizedStandardCompare($1.name) == .orderedAscending }
        VStack(spacing: 6) {
            HStack(spacing: 12) {
                VStack(spacing: 2) {
                    Text("plain <").font(.caption2).foregroundStyle(.secondary)
                    C18_RecipeList(recipes: plain)
                }
                VStack(spacing: 2) {
                    Text("localizedStandardCompare").font(.caption2).foregroundStyle(.secondary)
                    C18_RecipeList(recipes: standard)
                }
            }
            C18_Caption("Illustrative — the selector-based NSSortDescriptor orders \"Recipe 2\" before \"Recipe 10\"; the same comparison runs on sample rows")
        }
    }
}

// MARK: - ModelContainer (SwiftData — illustrations)

private struct C18_ModelContainerInitExample: View {
    var body: some View {
        VStack(spacing: 6) {
            C18_MockScene(title: "ModelContainer") {
                HStack(alignment: .top, spacing: 14) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("for:").font(.caption2).foregroundStyle(.secondary)
                        C18_SchemaBadge(name: "Recipe")
                        C18_SchemaBadge(name: "Step")
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("migrationPlan:").font(.caption2).foregroundStyle(.secondary)
                        Text("RecipeMigrationPlan").font(.caption.monospaced())
                        Text("configurations:").font(.caption2).foregroundStyle(.secondary)
                        Label("\"Library\"  cloudKitDatabase: .none", systemImage: "internaldrive")
                            .font(.caption.monospaced())
                    }
                }
            }
            C18_Caption("Illustrative — a throwing initializer; the configurations describe each store file the container opens")
        }
    }
}

private struct C18_ModelContainerMainContextExample: View {
    @State private var saved = ["Waffles"]
    @State private var pending: [String] = []

    var body: some View {
        VStack(spacing: 6) {
            C18_MockScene(title: "container.mainContext") {
                VStack(alignment: .leading, spacing: 3) {
                    ForEach(saved, id: \.self) { name in
                        Label(name, systemImage: "checkmark.circle").font(.caption)
                    }
                    ForEach(pending, id: \.self) { name in
                        Label("\(name)  (inserted, unsaved)", systemImage: "circle.dotted")
                            .font(.caption).foregroundStyle(.orange)
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 44, alignment: .topLeading)
            }
            HStack {
                Button("context.insert(Recipe(name: \"Pancakes\"))") {
                    withAnimation { pending.append("Pancakes \(saved.count + pending.count)") }
                }
                Button("try context.save()") {
                    withAnimation { saved.append(contentsOf: pending); pending = [] }
                }
                .disabled(pending.isEmpty)
            }
            .controlSize(.small)
            C18_Caption("Illustrative — the main-actor context the UI reads and writes, the same one .modelContainer() puts in the environment")
        }
    }
}

private struct C18_ModelContainerDeleteAllExample: View {
    @State private var recipes = ["Pancakes", "Ramen", "Risotto"]
    @State private var steps = ["Boil", "Steep", "Pour", "Stir"]

    var body: some View {
        VStack(spacing: 6) {
            C18_MockScene(title: "container stores") {
                HStack(alignment: .top, spacing: 16) {
                    storeColumn("Recipe", recipes)
                    storeColumn("Step", steps)
                }
                .frame(maxWidth: .infinity, minHeight: 48, alignment: .topLeading)
            }
            HStack {
                Button("Reset Library", role: .destructive) {
                    withAnimation { recipes = []; steps = [] }
                }
                .disabled(recipes.isEmpty && steps.isEmpty)
                Button("Restore sample") {
                    withAnimation { recipes = ["Pancakes", "Ramen", "Risotto"]; steps = ["Boil", "Steep", "Pour", "Stir"] }
                }
            }
            .controlSize(.small)
            C18_Caption("Illustrative — deleteAllData() empties every persisted object across the container's stores")
        }
    }

    private func storeColumn(_ title: String, _ rows: [String]) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(title): \(rows.count)").font(.caption2.bold())
            ForEach(rows, id: \.self) { Text($0).font(.caption2) }
            if rows.isEmpty { Text("empty").font(.caption2).foregroundStyle(.secondary) }
        }
    }
}

// MARK: - ObservableObject

private nonisolated enum C18_Theme: String, CaseIterable {
    case system, light, dark
}

private final class C18_Settings: ObservableObject {
    var theme = C18_Theme.system {
        willSet { objectWillChange.send() }
    }
}

private struct C18_ObjectWillChangeExample: View {
    @StateObject private var settings = C18_Settings()

    var body: some View {
        VStack(spacing: 8) {
            Label("theme = .\(settings.theme.rawValue)", systemImage: settings.theme == .dark ? "moon.fill" : "sun.max.fill")
                .font(.title3)
            HStack {
                ForEach(C18_Theme.allCases, id: \.self) { theme in
                    Button(theme.rawValue) { settings.theme = theme }
                        .disabled(settings.theme == theme)
                }
            }
            .controlSize(.small)
            C18_Caption("theme is a plain var, not @Published — the view still refreshes because willSet calls objectWillChange.send()")
        }
    }
}

private final class C18_Feed: ObservableObject {
    typealias ObjectWillChangePublisher = ObservableObjectPublisher
    let objectWillChange = ObservableObjectPublisher()
    private(set) var items: [String] = ["Welcome aboard", "Your first post"]
    private var batch = 0

    func replace(with latest: [String]) {
        objectWillChange.send()
        items = latest
    }

    func refresh() {
        batch += 1
        replace(with: ["Batch \(batch) — item A", "Batch \(batch) — item B", "Batch \(batch) — item C"])
    }
}

private struct C18_ObjectWillChangePublisherExample: View {
    @StateObject private var feed = C18_Feed()

    var body: some View {
        VStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 3) {
                ForEach(feed.items, id: \.self) { item in
                    Label(item, systemImage: "text.bubble").font(.caption)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
            Button("feed.replace(with: latest)") { feed.refresh() }
                .controlSize(.small)
            C18_Caption("items is a private(set) var; the hand-supplied ObservableObjectPublisher is what SwiftUI subscribes to")
        }
    }
}

// MARK: - OpenURLAction

private func c18URL(_ string: String) -> URL {
    URL(string: string) ?? URL(filePath: "/")
}

private struct C18_OpenURLHandlerExample: View {
    @State private var log = "—"

    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 16) {
                Link("example.com/docs", destination: c18URL("https://example.com/docs"))
                Link("example.com/help", destination: c18URL("https://example.com/help"))
            }
            .environment(\.openURL, OpenURLAction { url in
                guard url.host() == "example.com" else { return .systemAction }
                log = "routed in-app: \(url.path())"
                return .handled
            })
            Text(log).font(.caption.monospaced())
            C18_Caption("Links to example.com are intercepted and routed in-app; any other host would fall through to .systemAction")
        }
    }
}

private struct C18_HelpButton: View {
    @Environment(\.openURL) private var openURL

    var body: some View {
        Button("Help Center") {
            openURL(c18URL("https://example.com/help"))
        }
    }
}

private struct C18_OpenURLCallExample: View {
    @State private var log = "—"

    var body: some View {
        VStack(spacing: 8) {
            C18_HelpButton()
            Text(log).font(.caption.monospaced())
            C18_Caption("openURL(url) hands the URL to whichever handler is in effect — here an in-app interceptor, so nothing leaves the window")
        }
        .environment(\.openURL, OpenURLAction { url in
            log = "opened \(url.absoluteString)"
            return .handled
        })
    }
}

private struct C18_OpenURLCompletionButtons: View {
    @Environment(\.openURL) private var openURL
    @State private var log = "—"
    @State private var showCopyLinkAlert = false

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Button("Open example.com/docs") { open(c18URL("https://example.com/docs")) }
                Button("Open ads.example/promo") { open(c18URL("https://ads.example/promo")) }
            }
            .controlSize(.small)
            Text(log).font(.caption.monospaced())
            if showCopyLinkAlert {
                Label("Nothing accepted the link — offer to copy it instead", systemImage: "doc.on.doc")
                    .font(.caption).foregroundStyle(.orange)
            }
        }
    }

    private func open(_ url: URL) {
        openURL(url) { accepted in
            log = "accepted = \(accepted)"
            showCopyLinkAlert = !accepted
        }
    }
}

private struct C18_OpenURLCompletionExample: View {
    var body: some View {
        VStack(spacing: 6) {
            C18_OpenURLCompletionButtons()
            C18_Caption("The installed handler returns .handled for example.com and .discarded for ads.example, so the Bool differs")
        }
        .environment(\.openURL, OpenURLAction { url in
            url.host() == "ads.example" ? .discarded : .handled
        })
    }
}

private struct C18_OpenURLResultExample: View {
    @State private var log = "—"

    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 14) {
                Link("myapp://profile", destination: c18URL("myapp://profile"))
                Link("ads.example/promo", destination: c18URL("https://ads.example/promo"))
                Link("apple.com/?utm=x", destination: c18URL("https://www.apple.com/?utm=x"))
            }
            .font(.caption)
            .environment(\.openURL, OpenURLAction { url in
                if url.scheme == "myapp" {
                    log = ".handled"
                    return .handled
                }
                if url.host() == "ads.example" {
                    log = ".discarded"
                    return .discarded
                }
                var clean = URLComponents(url: url, resolvingAgainstBaseURL: false)
                clean?.queryItems = nil
                log = ".systemAction(\(clean?.url?.absoluteString ?? url.absoluteString)) → the OS opens it"
                return .systemAction(clean?.url ?? url)
            })
            Text(log).font(.caption.monospaced())
            C18_Caption("The third link really opens in your browser, with its query stripped by the substitute URL")
        }
    }
}
