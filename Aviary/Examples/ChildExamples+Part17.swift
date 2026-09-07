//
//  ChildExamples+Part17.swift
//  Aviary
//
//  Compiled renderings for variant entries (part 17: gen-animation, gen-appscenes).
//  One private C17_* struct per variant; every rendering exercises the exact
//  overload the variant names, so siblings can be compared side by side.
//

import SwiftUI
import Symbols

enum ChildExamplesPart17 {
    static let entries: [ChildExampleEntry] = [

        // MARK: .highPriorityGesture()

        ChildExampleEntry(parent: ".highPriorityGesture()", child: ".highPriorityGesture(_:including:)", code: """
        canvas                                   // contains a Button subview
            .highPriorityGesture(
                DragGesture().onChanged { pan = $0.translation },
                including: silenceSubviews ? .gesture : .all
            )
        Toggle("Mask: .gesture (silence subviews)", isOn: $silenceSubviews)
        """) { AnyView(C17_HighPriorityIncludingExample()) },

        ChildExampleEntry(parent: ".highPriorityGesture()", child: ".highPriorityGesture(_:isEnabled:)", code: """
        board
            .highPriorityGesture(
                TapGesture(count: 2).onEnded { zoom = min(zoom + 0.25, 2) },
                isEnabled: !isEditing
            )
        Toggle("Editing", isOn: $isEditing)
        """) { AnyView(C17_HighPriorityIsEnabledExample()) },

        // MARK: .keyframeAnimator()

        ChildExampleEntry(parent: ".keyframeAnimator()", child: ".keyframeAnimator(initialValue:trigger:content:keyframes:)", code: """
        Image(systemName: "heart.fill")
            .keyframeAnimator(initialValue: 1.0, trigger: likeCount) { view, scale in
                view.scaleEffect(scale)
            } keyframes: { _ in
                SpringKeyframe(1.4, duration: 0.15, spring: .bouncy)
                SpringKeyframe(1.0, duration: 0.35)
            }
        Button("Like") { likeCount += 1 }
        """) { AnyView(C17_KeyframeTriggerExample()) },

        ChildExampleEntry(parent: ".keyframeAnimator()", child: ".keyframeAnimator(initialValue:repeating:content:keyframes:)", code: """
        Circle()
            .keyframeAnimator(initialValue: 0.0, repeating: isLive) { view, y in
                view.offset(y: y)
            } keyframes: { _ in
                CubicKeyframe(-12, duration: 0.8)
                CubicKeyframe(0, duration: 0.8)
            }
        Toggle("Live", isOn: $isLive)
        """) { AnyView(C17_KeyframeRepeatingExample()) },

        // MARK: .onLongPressGesture()

        ChildExampleEntry(parent: ".onLongPressGesture()", child: ".onLongPressGesture(minimumDuration:maximumDistance:perform:onPressingChanged:)", code: """
        avatar
            .scaleEffect(scale)
            .onLongPressGesture(minimumDuration: 0.6, maximumDistance: 20) {
                holds += 1
            } onPressingChanged: { pressing in
                withAnimation(.snappy) { scale = pressing ? 0.9 : 1 }
            }
        """) { AnyView(C17_LongPressDistanceExample()) },

        ChildExampleEntry(parent: ".onLongPressGesture()", child: ".onLongPressGesture(minimumDuration:perform:onPressingChanged:)", code: """
        poster
            .onLongPressGesture(minimumDuration: 1) {
                holds += 1
            } onPressingChanged: { isPressing = $0 }
        """) { AnyView(C17_LongPressTVExample()) },

        ChildExampleEntry(parent: ".onLongPressGesture()", child: ".onLongPressGesture(minimumDuration:maximumDistance:pressing:perform:)", code: """
        tile
            .onLongPressGesture(minimumDuration: 0.5, maximumDistance: 10, pressing: { pressing in
                isHighlighted = pressing
            }, perform: { editCount += 1 })
        """) { AnyView(C17_LongPressDeprecatedExample()) },

        // MARK: .phaseAnimator()

        ChildExampleEntry(parent: ".phaseAnimator()", child: ".phaseAnimator(_:content:animation:)", code: """
        Image(systemName: "arrow.down")
            .phaseAnimator([0.0, 8.0]) { view, offset in
                view.offset(y: offset)
            } animation: { _ in
                .easeInOut(duration: 0.6)
            }
        """) { AnyView(C17_PhaseLoopExample()) },

        ChildExampleEntry(parent: ".phaseAnimator()", child: ".phaseAnimator(_:trigger:content:animation:)", code: """
        enum Pulse: CaseIterable { case idle, grow, shrink }

        Text("Saved")
            .phaseAnimator(Pulse.allCases, trigger: saveCount) { view, phase in
                view.scaleEffect(phase == .grow ? 1.2 : phase == .shrink ? 0.9 : 1)
            } animation: { _ in .snappy }
        Button("Save") { saveCount += 1 }
        """) { AnyView(C17_PhaseTriggerExample()) },

        // MARK: .simultaneousGesture()

        ChildExampleEntry(parent: ".simultaneousGesture()", child: ".simultaneousGesture(_:including:)", code: """
        HStack { Button("A") { taps += 1 }; Button("B") { taps += 1 } }
            .simultaneousGesture(
                DragGesture(minimumDistance: 0).onChanged { _ in presses += 1 },
                including: .all                  // the buttons still fire
            )
        """) { AnyView(C17_SimultaneousIncludingExample()) },

        ChildExampleEntry(parent: ".simultaneousGesture()", child: ".simultaneousGesture(_:isEnabled:)", code: """
        HStack { Button("A") { taps += 1 }; Button("B") { taps += 1 } }
            .simultaneousGesture(
                DragGesture(minimumDistance: 0).onChanged { _ in presses += 1 },
                isEnabled: trackPresses
            )
        Toggle("Track presses", isOn: $trackPresses)
        """) { AnyView(C17_SimultaneousIsEnabledExample()) },

        // MARK: .transaction()

        ChildExampleEntry(parent: ".transaction()", child: ".transaction(_:)", code: """
        Button("+1") { withAnimation(.bouncy(duration: 0.8)) { count += 1 } }
        Text("\\(count)").contentTransition(.numericText())          // animates
        Text("\\(count)").contentTransition(.numericText())
            .transaction { $0.animation = nil }                   // snaps
        """) { AnyView(C17_TransactionBasicExample()) },

        ChildExampleEntry(parent: ".transaction()", child: ".transaction(value:_:)", code: """
        bar                              // width follows `progress`, color follows `tinted`
            .transaction(value: progress) { t in
                t.animation = .linear(duration: 0.1)   // only when progress changes
            }
        Button("Advance") { withAnimation(.bouncy(duration: 1.2)) { progress = next } }
        Button("Recolor") { withAnimation(.bouncy(duration: 1.2)) { tinted.toggle() } }
        """) { AnyView(C17_TransactionValueExample()) },

        ChildExampleEntry(parent: ".transaction()", child: ".transaction(_:body:)", code: """
        card
            .transaction { $0.animation = .bouncy } body: { content in
                content.rotationEffect(.degrees(isFlipped ? 180 : 0))   // bouncy
            }
            .opacity(isFlipped ? 0.4 : 1)                               // linear 1.5 s
        Button("Flip") { withAnimation(.linear(duration: 1.5)) { isFlipped.toggle() } }
        """) { AnyView(C17_TransactionBodyExample()) },

        // MARK: Animation

        ChildExampleEntry(parent: "Animation", child: "Animation.easeInOut", code: """
        Circle().offset(x: isRight ? 80 : -80)
        Button("Move") {
            withAnimation(.easeInOut) { isRight.toggle() }    // default 0.35 s
        }
        """) { AnyView(C17_EaseInOutPresetExample()) },

        ChildExampleEntry(parent: "Animation", child: "Animation.repeatForever()", code: """
        Circle()
            .opacity(pulsing ? 0.2 : 1)
            .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true),
                       value: pulsing)
            .onAppear { pulsing = true }
        """) { AnyView(C17_RepeatForeverExample()) },

        ChildExampleEntry(parent: "Animation", child: "Animation.speed()", code: """
        Image(systemName: "arrow.up").rotationEffect(.degrees(isFlipped ? 180 : 0))
        Button("Flip") {
            withAnimation(.default.speed(speed)) { isFlipped.toggle() }
        }
        Slider(value: $speed, in: 0.25...4)
        """) { AnyView(C17_SpeedExample()) },

        ChildExampleEntry(parent: "Animation", child: "Animation.easeInOut(duration:)", code: """
        Circle().offset(x: isRight ? 80 : -80)
        Button("Move") {
            withAnimation(.easeInOut(duration: 1.2)) { isRight.toggle() }
        }
        """) { AnyView(C17_EaseInOutDurationExample()) },

        // MARK: Animation.bouncy

        ChildExampleEntry(parent: "Animation.bouncy", child: "Animation.snappy", code: """
        ForEach(0..<3) { index in
            Button("Item \\(index + 1)") {
                withAnimation(.snappy) { selection = index }
            }
        }
        Capsule().frame(width: 70, height: 4)
            .offset(x: CGFloat(selection - 1) * 78)     // indicator follows the pick
        """) { AnyView(C17_SnappyExample()) },

        ChildExampleEntry(parent: "Animation.bouncy", child: "Animation.smooth", code: """
        Capsule().frame(width: 220 * progress, height: 10)
        Button("Fill") {
            withAnimation(.smooth) { progress = progress == 1 ? 0.1 : 1 }
        }
        """) { AnyView(C17_SmoothExample()) },

        ChildExampleEntry(parent: "Animation.bouncy", child: "Animation.bouncy(duration:extraBounce:)", code: """
        drawer.offset(y: drawerOpen ? 0 : 60)
        Button("Toggle drawer") {
            withAnimation(.bouncy(duration: 0.6, extraBounce: extraBounce)) {
                drawerOpen.toggle()
            }
        }
        Slider(value: $extraBounce, in: 0...0.3)
        """) { AnyView(C17_BouncyTunableExample()) },

        ChildExampleEntry(parent: "Animation.bouncy", child: "Animation.smooth(duration:extraBounce:)", code: """
        sheet.offset(y: expanded ? 0 : 50)
        Button("Toggle sheet") {
            withAnimation(.smooth(duration: duration, extraBounce: 0)) { expanded.toggle() }
        }
        Slider(value: $duration, in: 0.2...1.5)
        """) { AnyView(C17_SmoothTunableExample()) },

        // MARK: Animation.spring()

        ChildExampleEntry(parent: "Animation.spring()", child: "Animation.spring(response:dampingFraction:blendDuration:)", code: """
        Circle().offset(x: isAway ? 90 : -90)
        Button("Spring") {
            withAnimation(.spring(response: 0.4, dampingFraction: damping, blendDuration: 0)) {
                isAway.toggle()
            }
        }
        Slider(value: $damping, in: 0.2...1)      // < 1 overshoots
        """) { AnyView(C17_SpringResponseExample()) },

        ChildExampleEntry(parent: "Animation.spring()", child: "Animation.spring(duration:bounce:blendDuration:)", code: """
        RoundedRectangle(cornerRadius: 8).frame(width: isExpanded ? 220 : 110, height: 32)
        Button("Toggle") {
            withAnimation(.spring(duration: 0.5, bounce: bounce, blendDuration: 0)) {
                isExpanded.toggle()
            }
        }
        Slider(value: $bounce, in: 0...0.8)
        """) { AnyView(C17_SpringDurationBounceExample()) },

        ChildExampleEntry(parent: "Animation.spring()", child: "Animation.spring(_:blendDuration:)", code: """
        let gentle = Spring(mass: 1, stiffness: 120, damping: 18)

        Circle().offset(y: sheetUp ? -30 : 30)
        Button("Toggle") {
            withAnimation(.spring(gentle, blendDuration: 0)) { sheetUp.toggle() }
        }
        Text("settles in \\(gentle.settlingDuration) s")   // same Spring, used for math
        """) { AnyView(C17_SpringValueExample()) },

        ChildExampleEntry(parent: "Animation.spring()", child: "Animation.interactiveSpring(response:dampingFraction:blendDuration:)", code: """
        knob.offset(offset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation(.interactiveSpring(response: 0.15, dampingFraction: 0.86, blendDuration: 0.25)) {
                            offset = value.translation
                        }
                    }
                    .onEnded { _ in withAnimation(.spring) { offset = .zero } }
            )
        """) { AnyView(C17_InteractiveSpringExample()) },

        // MARK: AnimationCompletionCriteria

        ChildExampleEntry(parent: "AnimationCompletionCriteria", child: "AnimationCompletionCriteria.logicallyComplete", code: """
        Button("Present") {
            let start = Date()
            withAnimation(.bouncy, completionCriteria: .logicallyComplete) {
                isPresented.toggle()
            } completion: {
                elapsed = Date().timeIntervalSince(start)   // fires when the value "arrives"
            }
        }
        """) { AnyView(C17_CompletionLogicalExample()) },

        ChildExampleEntry(parent: "AnimationCompletionCriteria", child: "AnimationCompletionCriteria.removed", code: """
        Button("Present") {
            let start = Date()
            withAnimation(.bouncy, completionCriteria: .removed) {
                isPresented.toggle()
            } completion: {
                elapsed = Date().timeIntervalSince(start)   // fires after full teardown
            }
        }
        """) { AnyView(C17_CompletionRemovedExample()) },

        // MARK: AnyTransition

        ChildExampleEntry(parent: "AnyTransition", child: "AnyTransition.move()", code: """
        if showBanner {
            banner
                .transition(.move(edge: .top))
        }
        Button("Toggle banner") { withAnimation(.smooth) { showBanner.toggle() } }
        """) { AnyView(C17_TransitionMoveExample()) },

        ChildExampleEntry(parent: "AnyTransition", child: "AnyTransition.asymmetric()", code: """
        if showRow {
            row
                .transition(.asymmetric(insertion: .scale, removal: .opacity))
        }
        Button(showRow ? "Remove" : "Insert") { withAnimation(.smooth) { showRow.toggle() } }
        """) { AnyView(C17_TransitionAsymmetricExample()) },

        ChildExampleEntry(parent: "AnyTransition", child: "AnyTransition.modifier()", code: """
        struct BlurMod: ViewModifier {
            var radius: CGFloat
            func body(content: Content) -> some View { content.blur(radius: radius) }
        }

        if showCard {
            card.transition(.modifier(active: BlurMod(radius: 12), identity: BlurMod(radius: 0)))
        }
        """) { AnyView(C17_TransitionModifierExample()) },

        ChildExampleEntry(parent: "AnyTransition", child: "AnyTransition.move(edge:)", code: """
        if showPanel {
            panel
                .transition(.move(edge: edge))
        }
        Picker("Edge", selection: $edge) { /* .top, .bottom, .leading, .trailing */ }
        """) { AnyView(C17_TransitionMoveEdgeExample()) },

        // MARK: ContentTransition

        ChildExampleEntry(parent: "ContentTransition", child: "ContentTransition.numericText(countsDown:)", code: """
        Text("\\(remaining)")
            .contentTransition(.numericText(countsDown: true))
            .animation(.snappy, value: remaining)
        Button("−1") { remaining -= 1 }
        """) { AnyView(C17_NumericCountsDownExample()) },

        ChildExampleEntry(parent: "ContentTransition", child: "ContentTransition.numericText(value:)", code: """
        Text(price, format: .currency(code: "USD"))
            .contentTransition(.numericText(value: price))   // direction from the value
            .animation(.snappy, value: price)
        HStack { Button("−5") { price -= 5 }; Button("+5") { price += 5 } }
        """) { AnyView(C17_NumericValueExample()) },

        ChildExampleEntry(parent: "ContentTransition", child: "ContentTransition.interpolate", code: """
        Text("Score")
            .font(.system(size: emphasized ? 40 : 24, weight: emphasized ? .bold : .regular))
            .contentTransition(.interpolate)
            .animation(.smooth, value: emphasized)
        Toggle("Emphasize", isOn: $emphasized)
        """) { AnyView(C17_InterpolateExample()) },

        ChildExampleEntry(parent: "ContentTransition", child: "ContentTransition.symbolEffect(_:options:)", code: """
        Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
            .contentTransition(.symbolEffect(.replace.downUp, options: .speed(1.5)))
            .animation(.default, value: isMuted)
        Toggle("Muted", isOn: $isMuted)
        """) { AnyView(C17_SymbolEffectTransitionExample()) },

        // MARK: DragGesture

        ChildExampleEntry(parent: "DragGesture", child: "DragGesture.Value", code: """
        DragGesture()
            .onChanged { value in
                translation = value.translation
                velocity = value.velocity
                predicted = value.predictedEndTranslation
            }
            .onEnded { _ in translation = .zero }
        """) { AnyView(C17_DragValueExample()) },

        ChildExampleEntry(parent: "DragGesture", child: "DragGesture(minimumDistance:coordinateSpace:)", code: """
        board
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged { value in cursor = value.location }   // starts at once
            )
        """) { AnyView(C17_DragInitExample()) },

        // MARK: ExclusiveGesture

        ChildExampleEntry(parent: "ExclusiveGesture", child: "ExclusiveGesture(_:_:)", code: """
        let pressOrTap = ExclusiveGesture(LongPressGesture(minimumDuration: 0.5), TapGesture())
            .onEnded { value in
                if case .first = value { presses += 1 } else { taps += 1 }
            }
        tile.gesture(pressOrTap)
        """) { AnyView(C17_ExclusiveInitExample()) },

        ChildExampleEntry(parent: "ExclusiveGesture", child: "ExclusiveGesture.Value", code: """
        TapGesture().exclusively(before: DragGesture())
            .onEnded { value in
                switch value {
                case .first: isSelected.toggle()
                case .second(let drag): offset.width += drag.translation.width
                }
            }
        """) { AnyView(C17_ExclusiveValueExample()) },

        // MARK: GestureMask

        ChildExampleEntry(parent: "GestureMask", child: "GestureMask.all", code: """
        stage                                        // contains a Button subview
            .gesture(TapGesture().onEnded { outerTaps += 1 }, including: .all)
        // both the attached tap and the button may recognize
        """) { AnyView(C17_MaskAllExample()) },

        ChildExampleEntry(parent: "GestureMask", child: "GestureMask.gesture", code: """
        stage                                        // contains a Button subview
            .gesture(TapGesture().onEnded { outerTaps += 1 }, including: .gesture)
        // only the attached tap runs; the button is silenced
        """) { AnyView(C17_MaskGestureExample()) },

        ChildExampleEntry(parent: "GestureMask", child: "GestureMask.subviews", code: """
        stage                                        // contains a Button subview
            .gesture(TapGesture().onEnded { outerTaps += 1 }, including: .subviews)
        // the button still works; the attached tap stays dormant
        """) { AnyView(C17_MaskSubviewsExample()) },

        ChildExampleEntry(parent: "GestureMask", child: "GestureMask.none", code: """
        stage                                        // contains a Button subview
            .gesture(TapGesture().onEnded { outerTaps += 1 }, including: .none)
        // neither the attached tap nor the button recognizes
        """) { AnyView(C17_MaskNoneExample()) },

        // MARK: KeyframeTimeline

        ChildExampleEntry(parent: "KeyframeTimeline", child: "KeyframeTimeline(initialValue:content:)", code: """
        let timeline = KeyframeTimeline(initialValue: CGPoint.zero) {
            KeyframeTrack(\\.x) { LinearKeyframe(200, duration: 0.5) }
            KeyframeTrack(\\.y) { SpringKeyframe(60, duration: 1.0, spring: .bouncy) }
        }
        // sampled at 40 evenly spaced progress values below
        """) { AnyView(C17_KeyframeTimelineInitExample()) },

        ChildExampleEntry(parent: "KeyframeTimeline", child: "KeyframeTimeline.value(time:)", code: """
        TimelineView(.animation) { context in
            let t = context.date.timeIntervalSince(start)
                .truncatingRemainder(dividingBy: timeline.duration)
            let point = timeline.value(time: t)
            Circle().frame(width: 14).position(point)
        }
        """) { AnyView(C17_KeyframeTimelineValueExample()) },

        // MARK: .defaultSize()

        ChildExampleEntry(parent: ".defaultSize()", child: ".defaultSize(width:height:)", code: """
        WindowGroup {
            LibraryView()
        }
        .defaultSize(width: 1000, height: 650)
        """) { AnyView(C17_DefaultSizeWidthHeightExample()) },

        ChildExampleEntry(parent: ".defaultSize()", child: ".defaultSize(_:)", code: """
        Window("Inspector", id: "inspector") {
            InspectorView()
        }
        .defaultSize(CGSize(width: 320, height: 480))
        """) { AnyView(C17_DefaultSizeCGSizeExample()) },

        // MARK: @WKApplicationDelegateAdaptor

        ChildExampleEntry(parent: "@WKApplicationDelegateAdaptor", child: "WKApplicationDelegateAdaptor(_:)", code: """
        final class AppDelegate: NSObject, WKApplicationDelegate {
            func applicationDidFinishLaunching() {
                WKApplication.shared().registerForRemoteNotifications()
            }
        }
        @WKApplicationDelegateAdaptor(AppDelegate.self) var delegate
        """) { AnyView(C17_WKDelegateAdaptorInitExample()) },

        ChildExampleEntry(parent: "@WKApplicationDelegateAdaptor", child: "WKApplicationDelegateAdaptor.projectedValue", code: """
        final class AppDelegate: NSObject, WKApplicationDelegate, ObservableObject {
            @Published var lastBackgroundRefresh: Date?
        }
        @WKApplicationDelegateAdaptor(AppDelegate.self) private var delegate

        var body: some Scene {
            WindowGroup { StatusView(refreshed: $delegate.lastBackgroundRefresh) }
        }
        """) { AnyView(C17_WKDelegateAdaptorProjectedExample()) },

        // MARK: BackgroundTask

        ChildExampleEntry(parent: "BackgroundTask", child: "BackgroundTask.appRefresh()", code: """
        WindowGroup { ContentView() }
            .backgroundTask(.appRefresh("com.example.sync")) {
                await SyncEngine.shared.run()
            }
        """) { AnyView(C17_BackgroundAppRefreshExample()) },

        ChildExampleEntry(parent: "BackgroundTask", child: "BackgroundTask.urlSession()", code: """
        WindowGroup { ContentView() }
            .backgroundTask(.urlSession("com.example.downloads")) {
                await Downloads.shared.processEvents()
            }
        """) { AnyView(C17_BackgroundURLSessionExample()) },

        // MARK: CommandGroupPlacement

        ChildExampleEntry(parent: "CommandGroupPlacement", child: "CommandGroupPlacement.newItem", code: """
        .commands {
            CommandGroup(after: .newItem) {
                Button("New Tag…", action: newTag)
            }
        }
        """) { AnyView(C17_PlacementNewItemExample()) },

        ChildExampleEntry(parent: "CommandGroupPlacement", child: "CommandGroupPlacement.appInfo", code: """
        .commands {
            CommandGroup(replacing: .appInfo) {
                Button("About Ledger", action: showAbout)
            }
        }
        """) { AnyView(C17_PlacementAppInfoExample()) },

        ChildExampleEntry(parent: "CommandGroupPlacement", child: "CommandGroupPlacement.help", code: """
        .commands {
            CommandGroup(replacing: .help) {
                Link("Ledger Manual", destination: manualURL)
            }
        }
        """) { AnyView(C17_PlacementHelpExample()) },

        // MARK: MenuBarExtraStyle

        ChildExampleEntry(parent: "MenuBarExtraStyle", child: "MenuBarExtraStyle.menu", code: """
        MenuBarExtra("Uploads", systemImage: "icloud.and.arrow.up") {
            Button("Pause All") { pauseAll() }
            Divider()
            Button("Quit") { NSApp.terminate(nil) }
        }
        .menuBarExtraStyle(.menu)
        """) { AnyView(C17_MenuBarExtraMenuExample()) },

        ChildExampleEntry(parent: "MenuBarExtraStyle", child: "MenuBarExtraStyle.window", code: """
        MenuBarExtra("Uploads", systemImage: "icloud.and.arrow.up") {
            VStack { ProgressView(value: 0.6); Toggle("Wi-Fi only", isOn: $wifiOnly) }
                .padding()
        }
        .menuBarExtraStyle(.window)
        """) { AnyView(C17_MenuBarExtraWindowExample()) },

        // MARK: SceneBuilder

        ChildExampleEntry(parent: "SceneBuilder", child: "SceneBuilder.buildBlock(_:)", code: """
        @SceneBuilder
        private var auxiliaryScenes: some Scene {
            Window("Activity", id: "activity") { ActivityView() }
            Settings { SettingsView() }
        }
        """) { AnyView(C17_SceneBuildBlockExample()) },

        ChildExampleEntry(parent: "SceneBuilder", child: "SceneBuilder.buildOptional(_:)", code: """
        var body: some Scene {
            WindowGroup { ContentView() }
            if ProcessInfo.processInfo.environment["DEBUG_TOOLS"] != nil {
                Window("Debug Console", id: "console") { ConsoleView() }
            }
        }
        """) { AnyView(C17_SceneBuildOptionalExample()) },

        ChildExampleEntry(parent: "SceneBuilder", child: "SceneBuilder.buildEither(first:)", code: """
        var body: some Scene {
            if usesDocumentModel {
                DocumentGroup(newDocument: NoteDocument()) { NoteEditor(file: $0) }
            } else {
                WindowGroup { NotesBrowser() }
            }
        }
        """) { AnyView(C17_SceneBuildEitherExample()) },

        // MARK: WindowInteractionBehavior

        ChildExampleEntry(parent: "WindowInteractionBehavior", child: "WindowInteractionBehavior.automatic", code: """
        Window("Palette", id: "palette") {
            PaletteView()
        }
        .windowStyle(.plain)
        .windowBackgroundDragBehavior(.automatic)   // the style decides
        """) { AnyView(C17_InteractionAutomaticExample()) },

        ChildExampleEntry(parent: "WindowInteractionBehavior", child: "WindowInteractionBehavior.enabled", code: """
        Window("Scratchpad", id: "scratch") {
            ScratchpadView()
        }
        .windowStyle(.hiddenTitleBar)
        .windowBackgroundDragBehavior(.enabled)     // drag anywhere to move
        """) { AnyView(C17_InteractionEnabledExample()) },

        ChildExampleEntry(parent: "WindowInteractionBehavior", child: "WindowInteractionBehavior.disabled", code: """
        UtilityWindow("Inspector", id: "inspector") {
            InspectorPane()
        }
        .windowMinimizeBehavior(.disabled)
        .windowFullScreenBehavior(.disabled)
        """) { AnyView(C17_InteractionDisabledExample()) },

        // MARK: WindowLevel

        ChildExampleEntry(parent: "WindowLevel", child: "WindowLevel.automatic", code: """
        WindowGroup {
            DocumentView()
        }
        .windowLevel(.automatic)      // tier derived from style and role
        """) { AnyView(C17_LevelAutomaticExample()) },

        ChildExampleEntry(parent: "WindowLevel", child: "WindowLevel.normal", code: """
        Window("Library", id: "library") {
            LibraryView()
        }
        .windowLevel(.normal)         // ordinary document tier
        """) { AnyView(C17_LevelNormalExample()) },

        ChildExampleEntry(parent: "WindowLevel", child: "WindowLevel.floating", code: """
        Window("Timer", id: "timer") {
            TimerHUD()
        }
        .windowStyle(.plain)
        .windowLevel(.floating)       // stays above normal windows, even when not key
        """) { AnyView(C17_LevelFloatingExample()) },

        // MARK: WindowResizability

        ChildExampleEntry(parent: "WindowResizability", child: "WindowResizability.contentSize", code: """
        Window("About", id: "about") {
            AboutView().frame(width: 300, height: 180)
        }
        .windowResizability(.contentSize)     // min = max = content size
        """) { AnyView(C17_ResizabilityContentSizeExample()) },

        ChildExampleEntry(parent: "WindowResizability", child: "WindowResizability.contentMinSize", code: """
        WindowGroup {
            EditorView().frame(minWidth: 480, minHeight: 320)
        }
        .windowResizability(.contentMinSize)  // min = content, grows without limit
        """) { AnyView(C17_ResizabilityContentMinSizeExample()) },

        // MARK: WindowStyle

        ChildExampleEntry(parent: "WindowStyle", child: "WindowStyle.titleBar", code: """
        WindowGroup {
            ContentView()
        }
        .windowStyle(.titleBar)
        """) { AnyView(C17_StyleTitleBarExample()) },

        ChildExampleEntry(parent: "WindowStyle", child: "WindowStyle.hiddenTitleBar", code: """
        WindowGroup {
            ContentView()
        }
        .windowStyle(.hiddenTitleBar)
        """) { AnyView(C17_StyleHiddenTitleBarExample()) },

        ChildExampleEntry(parent: "WindowStyle", child: "WindowStyle.plain", code: """
        Window("Now Playing", id: "nowPlaying") {
            NowPlayingCard()
        }
        .windowStyle(.plain)
        """) { AnyView(C17_StylePlainExample()) },

        // MARK: WindowToolbarStyle

        ChildExampleEntry(parent: "WindowToolbarStyle", child: "WindowToolbarStyle.unified", code: """
        WindowGroup {
            ContentView().toolbar { toolbarItems }
        }
        .windowToolbarStyle(.unified)
        """) { AnyView(C17_ToolbarUnifiedExample()) },

        ChildExampleEntry(parent: "WindowToolbarStyle", child: "WindowToolbarStyle.unifiedCompact", code: """
        WindowGroup {
            ContentView().toolbar { toolbarItems }
        }
        .windowToolbarStyle(.unifiedCompact)
        """) { AnyView(C17_ToolbarUnifiedCompactExample()) },

        ChildExampleEntry(parent: "WindowToolbarStyle", child: "WindowToolbarStyle.expanded", code: """
        WindowGroup {
            ContentView().toolbar { toolbarItems }
        }
        .windowToolbarStyle(.expanded)
        """) { AnyView(C17_ToolbarExpandedExample()) },
    ]
}

// MARK: - Shared helpers

private struct C17_Caption: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
    }
}

// MARK: - .highPriorityGesture()

private struct C17_HighPriorityIncludingExample: View {
    @State private var pan: CGSize = .zero
    @State private var buttonTaps = 0
    @State private var silenceSubviews = true

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.12))
                Circle().fill(.blue).frame(width: 18, height: 18).offset(pan)
                Button("Tap me") { buttonTaps += 1 }
            }
            .frame(width: 240, height: 90)
            .highPriorityGesture(
                DragGesture().onChanged { pan = $0.translation },
                including: silenceSubviews ? .gesture : .all
            )
            Toggle("Mask: .gesture (silence subviews)", isOn: $silenceSubviews)
                .toggleStyle(.switch)
                .controlSize(.small)
            C17_Caption(text: "Button taps: \(buttonTaps) · pan \(String(format: "%.0f, %.0f", pan.width, pan.height))")
        }
    }
}

private struct C17_HighPriorityIsEnabledExample: View {
    @State private var zoom: CGFloat = 1
    @State private var isEditing = false

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(Color.green.opacity(0.12))
                Image(systemName: "map.fill")
                    .font(.title)
                    .foregroundStyle(.green)
                    .scaleEffect(zoom)
                    .animation(.snappy, value: zoom)
            }
            .frame(width: 240, height: 90)
            .highPriorityGesture(
                TapGesture(count: 2).onEnded { zoom = min(zoom + 0.25, 2) },
                isEnabled: !isEditing
            )
            Toggle("Editing", isOn: $isEditing).toggleStyle(.switch).controlSize(.small)
            C17_Caption(text: isEditing ? "Double-click ignored while editing" : "Double-click to zoom · \(String(format: "%.2f×", zoom))")
        }
    }
}

// MARK: - .keyframeAnimator()

private struct C17_KeyframeTriggerExample: View {
    @State private var likeCount = 0

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "heart.fill")
                .font(.system(size: 40))
                .foregroundStyle(.pink)
                .keyframeAnimator(initialValue: 1.0, trigger: likeCount) { view, scale in
                    view.scaleEffect(scale)
                } keyframes: { _ in
                    SpringKeyframe(1.4, duration: 0.15, spring: .bouncy)
                    SpringKeyframe(1.0, duration: 0.35)
                }
                .frame(height: 60)
            Button("Like") { likeCount += 1 }
            C17_Caption(text: "Likes: \(likeCount) — each change of the trigger replays the timeline")
        }
    }
}

private struct C17_KeyframeRepeatingExample: View {
    @State private var isLive = true

    var body: some View {
        VStack(spacing: 12) {
            Circle()
                .fill(.orange.gradient)
                .frame(width: 32, height: 32)
                .keyframeAnimator(initialValue: 0.0, repeating: isLive) { view, y in
                    view.offset(y: y)
                } keyframes: { _ in
                    CubicKeyframe(-12, duration: 0.8)
                    CubicKeyframe(0, duration: 0.8)
                }
                .frame(height: 60)
            Toggle("Live", isOn: $isLive).toggleStyle(.switch).controlSize(.small)
            C17_Caption(text: isLive ? "Looping while repeating is true" : "Paused — repeating is false")
        }
    }
}

// MARK: - .onLongPressGesture()

private struct C17_LongPressDistanceExample: View {
    @State private var holds = 0
    @State private var scale: CGFloat = 1

    var body: some View {
        VStack(spacing: 12) {
            Circle()
                .fill(.indigo.gradient)
                .overlay { Image(systemName: "person.fill").font(.title).foregroundStyle(.white) }
                .frame(width: 64, height: 64)
                .scaleEffect(scale)
                .onLongPressGesture(minimumDuration: 0.6, maximumDistance: 20) {
                    holds += 1
                } onPressingChanged: { pressing in
                    withAnimation(.snappy) { scale = pressing ? 0.9 : 1 }
                }
            C17_Caption(text: "Hold 0.6 s (move < 20 pt) · completed holds: \(holds)")
        }
    }
}

private struct C17_LongPressTVExample: View {
    @State private var holds = 0
    @State private var isPressing = false

    var body: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 8)
                .fill(.purple.gradient)
                .frame(width: 70, height: 90)
                .overlay { Image(systemName: "film").font(.title2).foregroundStyle(.white) }
                .scaleEffect(isPressing ? 1.06 : 1)
                .animation(.snappy, value: isPressing)
                .onLongPressGesture(minimumDuration: 1) {
                    holds += 1
                } onPressingChanged: { isPressing = $0 }
            C17_Caption(text: "Holds: \(holds) · pressing: \(isPressing ? "yes" : "no")\nIllustrative — tvOS overload; on macOS the call resolves to the maximumDistance form")
        }
    }
}

private struct C17_LongPressDeprecatedExample: View {
    @State private var isHighlighted = false
    @State private var editCount = 0

    var body: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 10)
                .fill(isHighlighted ? Color.yellow : Color.gray.opacity(0.3))
                .frame(width: 120, height: 56)
                .overlay { Text(isHighlighted ? "Pressing…" : "Tile").font(.callout) }
                .onLongPressGesture(minimumDuration: 0.5, maximumDistance: 10) {
                    editCount += 1
                } onPressingChanged: { isHighlighted = $0 }
            C17_Caption(text: "Edit mode entered \(editCount)×\nDeprecated — rendered with the perform:onPressingChanged: form")
        }
    }
}

// MARK: - .phaseAnimator()

private struct C17_PhaseLoopExample: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "arrow.down")
                .font(.system(size: 32, weight: .semibold))
                .foregroundStyle(.blue)
                .phaseAnimator([0.0, 8.0]) { view, offset in
                    view.offset(y: offset)
                } animation: { _ in
                    .easeInOut(duration: 0.6)
                }
                .frame(height: 60)
            C17_Caption(text: "No trigger — phases 0 → 8 cycle endlessly")
        }
    }
}

private struct C17_PhaseTriggerExample: View {
    enum Pulse: CaseIterable { case idle, grow, shrink }
    @State private var saveCount = 0

    var body: some View {
        VStack(spacing: 12) {
            Text("Saved")
                .font(.title2.bold())
                .foregroundStyle(.green)
                .phaseAnimator(Pulse.allCases, trigger: saveCount) { view, phase in
                    view.scaleEffect(phase == .grow ? 1.2 : phase == .shrink ? 0.9 : 1)
                } animation: { _ in .snappy }
                .frame(height: 44)
            Button("Save") { saveCount += 1 }
            C17_Caption(text: "Saves: \(saveCount) — idle → grow → shrink once per trigger change")
        }
    }
}

// MARK: - .simultaneousGesture()

private struct C17_SimultaneousIncludingExample: View {
    @State private var taps = 0
    @State private var presses = 0

    var body: some View {
        VStack(spacing: 12) {
            HStack { Button("A") { taps += 1 }; Button("B") { taps += 1 } }
                .padding(12)
                .background(Color.teal.opacity(0.12), in: RoundedRectangle(cornerRadius: 10))
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0).onChanged { _ in presses += 1 },
                    including: .all
                )
            C17_Caption(text: "Button taps: \(taps) · outer drag events: \(presses) — both recognize")
        }
    }
}

private struct C17_SimultaneousIsEnabledExample: View {
    @State private var taps = 0
    @State private var presses = 0
    @State private var trackPresses = true

    var body: some View {
        VStack(spacing: 10) {
            HStack { Button("A") { taps += 1 }; Button("B") { taps += 1 } }
                .padding(12)
                .background(Color.teal.opacity(0.12), in: RoundedRectangle(cornerRadius: 10))
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0).onChanged { _ in presses += 1 },
                    isEnabled: trackPresses
                )
            Toggle("Track presses", isOn: $trackPresses).toggleStyle(.switch).controlSize(.small)
            C17_Caption(text: "Button taps: \(taps) · outer drag events: \(presses)")
        }
    }
}

// MARK: - .transaction()

private struct C17_TransactionBasicExample: View {
    @State private var count = 0

    var body: some View {
        VStack(spacing: 12) {
            Button("+1") { withAnimation(.bouncy(duration: 0.8)) { count += 1 } }
            HStack(spacing: 40) {
                VStack {
                    Text("\(count)").font(.system(size: 34, weight: .bold, design: .rounded))
                        .contentTransition(.numericText())
                    C17_Caption(text: "animates")
                }
                VStack {
                    Text("\(count)").font(.system(size: 34, weight: .bold, design: .rounded))
                        .contentTransition(.numericText())
                        .transaction { $0.animation = nil }
                    C17_Caption(text: ".transaction { $0.animation = nil }")
                }
            }
        }
    }
}

private struct C17_TransactionValueExample: View {
    @State private var progress: CGFloat = 0.25
    @State private var tinted = false

    var body: some View {
        VStack(spacing: 12) {
            ZStack(alignment: .leading) {
                Capsule().fill(Color.gray.opacity(0.2))
                Capsule().fill(tinted ? Color.orange : Color.blue).frame(width: 220 * progress)
            }
            .frame(width: 220, height: 12)
            .transaction(value: progress) { t in
                t.animation = .linear(duration: 0.1)
            }
            HStack {
                Button("Advance") {
                    withAnimation(.bouncy(duration: 1.2)) { progress = progress >= 1 ? 0.25 : progress + 0.25 }
                }
                Button("Recolor") {
                    withAnimation(.bouncy(duration: 1.2)) { tinted.toggle() }
                }
            }
            C17_Caption(text: "Width snaps in 0.1 s; color keeps the 1.2 s bounce")
        }
    }
}

private struct C17_TransactionBodyExample: View {
    @State private var isFlipped = false

    var body: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.purple.gradient)
                .frame(width: 90, height: 60)
                .overlay { Image(systemName: "arrow.up").font(.title2).foregroundStyle(.white) }
                .transaction { $0.animation = .bouncy } body: { content in
                    content.rotationEffect(.degrees(isFlipped ? 180 : 0))
                }
                .opacity(isFlipped ? 0.4 : 1)
            Button("Flip") { withAnimation(.linear(duration: 1.5)) { isFlipped.toggle() } }
            C17_Caption(text: "Rotation bounces; opacity fades linearly over 1.5 s")
        }
    }
}

// MARK: - Animation

private struct C17_EaseInOutPresetExample: View {
    @State private var isRight = false

    var body: some View {
        VStack(spacing: 12) {
            Circle().fill(.blue.gradient).frame(width: 36, height: 36)
                .offset(x: isRight ? 80 : -80)
                .frame(height: 44)
            Button("Move") { withAnimation(.easeInOut) { isRight.toggle() } }
            C17_Caption(text: ".easeInOut — the preset with its default 0.35 s duration")
        }
    }
}

private struct C17_RepeatForeverExample: View {
    @State private var pulsing = false

    var body: some View {
        VStack(spacing: 12) {
            Circle().fill(.red.gradient).frame(width: 44, height: 44)
                .opacity(pulsing ? 0.2 : 1)
                .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: pulsing)
                .onAppear { pulsing = true }
            C17_Caption(text: "repeatForever(autoreverses: true) — fades out and back, endlessly")
        }
    }
}

private struct C17_SpeedExample: View {
    @State private var isFlipped = false
    @State private var speed = 1.0

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "arrow.up")
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(.green)
                .rotationEffect(.degrees(isFlipped ? 180 : 0))
                .frame(height: 44)
            Button("Flip") { withAnimation(.default.speed(speed)) { isFlipped.toggle() } }
            Slider(value: $speed, in: 0.25...4).frame(width: 180)
            C17_Caption(text: ".default.speed(\(String(format: "%.2f", speed))) — same curve, \(String(format: "%.2f", 0.35 / speed)) s")
        }
    }
}

private struct C17_EaseInOutDurationExample: View {
    @State private var isRight = false

    var body: some View {
        VStack(spacing: 12) {
            Circle().fill(.teal.gradient).frame(width: 36, height: 36)
                .offset(x: isRight ? 80 : -80)
                .frame(height: 44)
            Button("Move") { withAnimation(.easeInOut(duration: 1.2)) { isRight.toggle() } }
            C17_Caption(text: ".easeInOut(duration: 1.2) — same S-curve stretched over 1.2 s")
        }
    }
}

// MARK: - Animation.bouncy

private struct C17_SnappyExample: View {
    @State private var selection = 1

    var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 8) {
                ForEach(0..<3) { index in
                    Button("Item \(index + 1)") {
                        withAnimation(.snappy) { selection = index }
                    }
                    .frame(width: 70)
                }
            }
            Capsule().fill(.blue).frame(width: 70, height: 4)
                .offset(x: CGFloat(selection - 1) * 78)
            C17_Caption(text: ".snappy — quick spring with minimal bounce")
        }
    }
}

private struct C17_SmoothExample: View {
    @State private var progress: CGFloat = 0.1

    var body: some View {
        VStack(spacing: 12) {
            ZStack(alignment: .leading) {
                Capsule().fill(Color.gray.opacity(0.2))
                Capsule().fill(.green).frame(width: 220 * progress)
            }
            .frame(width: 220, height: 10)
            Button("Fill") { withAnimation(.smooth) { progress = progress == 1 ? 0.1 : 1 } }
            C17_Caption(text: ".smooth — spring with no bounce, settles cleanly")
        }
    }
}

private struct C17_BouncyTunableExample: View {
    @State private var drawerOpen = false
    @State private var extraBounce = 0.15

    var body: some View {
        VStack(spacing: 10) {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.12))
                RoundedRectangle(cornerRadius: 10)
                    .fill(.orange.gradient)
                    .frame(height: 60)
                    .overlay { Text("Drawer").font(.caption).foregroundStyle(.white) }
                    .offset(y: drawerOpen ? 0 : 60)
            }
            .frame(width: 200, height: 70)
            .clipped()
            Button("Toggle drawer") {
                withAnimation(.bouncy(duration: 0.6, extraBounce: extraBounce)) { drawerOpen.toggle() }
            }
            Slider(value: $extraBounce, in: 0...0.3).frame(width: 180)
            C17_Caption(text: ".bouncy(duration: 0.6, extraBounce: \(String(format: "%.2f", extraBounce)))")
        }
    }
}

private struct C17_SmoothTunableExample: View {
    @State private var expanded = false
    @State private var duration = 0.45

    var body: some View {
        VStack(spacing: 10) {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.12))
                RoundedRectangle(cornerRadius: 10)
                    .fill(.blue.gradient)
                    .frame(height: 60)
                    .overlay { Text("Sheet").font(.caption).foregroundStyle(.white) }
                    .offset(y: expanded ? 0 : 50)
            }
            .frame(width: 200, height: 70)
            .clipped()
            Button("Toggle sheet") {
                withAnimation(.smooth(duration: duration, extraBounce: 0)) { expanded.toggle() }
            }
            Slider(value: $duration, in: 0.2...1.5).frame(width: 180)
            C17_Caption(text: ".smooth(duration: \(String(format: "%.2f", duration)), extraBounce: 0)")
        }
    }
}

// MARK: - Animation.spring()

private struct C17_SpringResponseExample: View {
    @State private var isAway = false
    @State private var damping = 0.5

    var body: some View {
        VStack(spacing: 10) {
            Circle().fill(.pink.gradient).frame(width: 36, height: 36)
                .offset(x: isAway ? 90 : -90)
                .frame(height: 44)
            Button("Spring") {
                withAnimation(.spring(response: 0.4, dampingFraction: damping, blendDuration: 0)) { isAway.toggle() }
            }
            Slider(value: $damping, in: 0.2...1).frame(width: 180)
            C17_Caption(text: "response 0.4 · dampingFraction \(String(format: "%.2f", damping)) — below 1 overshoots")
        }
    }
}

private struct C17_SpringDurationBounceExample: View {
    @State private var isExpanded = false
    @State private var bounce = 0.4

    var body: some View {
        VStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 8).fill(.indigo.gradient)
                .frame(width: isExpanded ? 220 : 110, height: 32)
            Button("Toggle") {
                withAnimation(.spring(duration: 0.5, bounce: bounce, blendDuration: 0)) { isExpanded.toggle() }
            }
            Slider(value: $bounce, in: 0...0.8).frame(width: 180)
            C17_Caption(text: "duration 0.5 · bounce \(String(format: "%.2f", bounce)) — 0 is critically damped")
        }
    }
}

private struct C17_SpringValueExample: View {
    @State private var sheetUp = false
    private let gentle = Spring(mass: 1, stiffness: 120, damping: 18)

    var body: some View {
        VStack(spacing: 10) {
            Circle().fill(.mint.gradient).frame(width: 36, height: 36)
                .offset(y: sheetUp ? -30 : 30)
                .frame(height: 80)
            Button("Toggle") { withAnimation(.spring(gentle, blendDuration: 0)) { sheetUp.toggle() } }
            C17_Caption(text: "Spring(mass: 1, stiffness: 120, damping: 18) settles in \(String(format: "%.2f", gentle.settlingDuration)) s")
        }
    }
}

private struct C17_InteractiveSpringExample: View {
    @State private var offset: CGSize = .zero

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.12))
                Circle().fill(.blue.gradient).frame(width: 40, height: 40)
                    .offset(offset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                withAnimation(.interactiveSpring(response: 0.15, dampingFraction: 0.86, blendDuration: 0.25)) {
                                    offset = value.translation
                                }
                            }
                            .onEnded { _ in withAnimation(.spring) { offset = .zero } }
                    )
            }
            .frame(width: 220, height: 100)
            C17_Caption(text: "Drag the knob — a stiff spring tracks the pointer, then springs home")
        }
    }
}

// MARK: - AnimationCompletionCriteria

private struct C17_CompletionLogicalExample: View {
    @State private var isPresented = false
    @State private var elapsed: TimeInterval?

    var body: some View {
        VStack(spacing: 10) {
            Circle().fill(.green.gradient).frame(width: 44, height: 44)
                .scaleEffect(isPresented ? 1.4 : 0.8)
                .frame(height: 70)
            Button("Present") {
                let start = Date()
                withAnimation(.bouncy, completionCriteria: .logicallyComplete) {
                    isPresented.toggle()
                } completion: {
                    elapsed = Date().timeIntervalSince(start)
                }
            }
            C17_Caption(text: elapsed.map { "Completion fired after \(String(format: "%.2f", $0)) s (.logicallyComplete)" } ?? "Completion not yet fired")
        }
    }
}

private struct C17_CompletionRemovedExample: View {
    @State private var isPresented = false
    @State private var elapsed: TimeInterval?

    var body: some View {
        VStack(spacing: 10) {
            Circle().fill(.orange.gradient).frame(width: 44, height: 44)
                .scaleEffect(isPresented ? 1.4 : 0.8)
                .frame(height: 70)
            Button("Present") {
                let start = Date()
                withAnimation(.bouncy, completionCriteria: .removed) {
                    isPresented.toggle()
                } completion: {
                    elapsed = Date().timeIntervalSince(start)
                }
            }
            C17_Caption(text: elapsed.map { "Completion fired after \(String(format: "%.2f", $0)) s (.removed — waits for the spring tail)" } ?? "Completion not yet fired")
        }
    }
}

// MARK: - AnyTransition

private struct C17_TransitionMoveExample: View {
    @State private var showBanner = true

    var body: some View {
        VStack(spacing: 10) {
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.12))
                if showBanner {
                    Text("Banner")
                        .font(.callout.bold())
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background(.blue, in: RoundedRectangle(cornerRadius: 8))
                        .padding(6)
                        .transition(.move(edge: .top))
                }
            }
            .frame(width: 220, height: 70)
            .clipped()
            Button("Toggle banner") { withAnimation(.smooth) { showBanner.toggle() } }
            C17_Caption(text: ".move(edge: .top) — slides in from and out toward the top")
        }
    }
}

private struct C17_TransitionAsymmetricExample: View {
    @State private var showRow = true

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.12))
                if showRow {
                    Label("Result row", systemImage: "doc.text")
                        .padding(8)
                        .background(.teal.opacity(0.25), in: RoundedRectangle(cornerRadius: 8))
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                }
            }
            .frame(width: 220, height: 70)
            Button(showRow ? "Remove" : "Insert") { withAnimation(.smooth) { showRow.toggle() } }
            C17_Caption(text: "Scales in, fades out")
        }
    }
}

private struct C17_TransitionModifierExample: View {
    struct BlurMod: ViewModifier {
        var radius: CGFloat
        func body(content: Content) -> some View { content.blur(radius: radius) }
    }

    @State private var showCard = true

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.12))
                if showCard {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.purple.gradient)
                        .frame(width: 120, height: 48)
                        .overlay { Text("Card").foregroundStyle(.white) }
                        .transition(.modifier(active: BlurMod(radius: 12), identity: BlurMod(radius: 0)))
                }
            }
            .frame(width: 220, height: 70)
            Button(showCard ? "Remove" : "Insert") { withAnimation(.smooth(duration: 0.6)) { showCard.toggle() } }
            C17_Caption(text: "Blurs from 12 pt (active) to 0 (identity)")
        }
    }
}

private struct C17_TransitionMoveEdgeExample: View {
    @State private var showPanel = true
    @State private var edge: Edge = .leading

    private func name(_ edge: Edge) -> String {
        switch edge {
        case .top: "top"
        case .bottom: "bottom"
        case .leading: "leading"
        case .trailing: "trailing"
        }
    }

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.12))
                if showPanel {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.blue.gradient)
                        .frame(width: 140, height: 44)
                        .overlay { Text("Panel").foregroundStyle(.white) }
                        .transition(.move(edge: edge))
                }
            }
            .frame(width: 220, height: 64)
            .clipped()
            HStack {
                Picker("Edge", selection: $edge) {
                    ForEach(Edge.allCases, id: \.self) { Text(name($0)).tag($0) }
                }
                .frame(width: 150)
                Button(showPanel ? "Hide" : "Show") { withAnimation(.smooth) { showPanel.toggle() } }
            }
            .controlSize(.small)
            C17_Caption(text: ".move(edge: .\(name(edge)))")
        }
    }
}

// MARK: - ContentTransition

private struct C17_NumericCountsDownExample: View {
    @State private var remaining = 10

    var body: some View {
        VStack(spacing: 10) {
            Text("\(remaining)")
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .contentTransition(.numericText(countsDown: true))
                .animation(.snappy, value: remaining)
                .frame(height: 50)
            HStack {
                Button("−1") { remaining -= 1 }
                Button("Reset") { remaining = 10 }
            }
            C17_Caption(text: "countsDown: true — digits roll in the decreasing direction")
        }
    }
}

private struct C17_NumericValueExample: View {
    @State private var price = 24.0

    var body: some View {
        VStack(spacing: 10) {
            Text(price, format: .currency(code: "USD"))
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .contentTransition(.numericText(value: price))
                .animation(.snappy, value: price)
                .frame(height: 50)
            HStack { Button("−5") { price -= 5 }; Button("+5") { price += 5 } }
            C17_Caption(text: "Roll direction follows whether the value went up or down")
        }
    }
}

private struct C17_InterpolateExample: View {
    @State private var emphasized = false

    var body: some View {
        VStack(spacing: 10) {
            Text("Score")
                .font(.system(size: emphasized ? 40 : 24, weight: emphasized ? .bold : .regular))
                .contentTransition(.interpolate)
                .animation(.smooth, value: emphasized)
                .frame(height: 50)
            Toggle("Emphasize", isOn: $emphasized).toggleStyle(.switch).controlSize(.small)
            C17_Caption(text: ".interpolate morphs size and weight instead of cross-fading")
        }
    }
}

private struct C17_SymbolEffectTransitionExample: View {
    @State private var isMuted = false

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                .font(.system(size: 36))
                .foregroundStyle(isMuted ? .red : .blue)
                .contentTransition(.symbolEffect(.replace.downUp, options: .speed(1.5)))
                .animation(.default, value: isMuted)
                .frame(width: 60, height: 50)
            Toggle("Muted", isOn: $isMuted).toggleStyle(.switch).controlSize(.small)
            C17_Caption(text: ".replace.downUp at 1.5× speed")
        }
    }
}

// MARK: - DragGesture

private struct C17_DragValueExample: View {
    @State private var translation: CGSize = .zero
    @State private var velocity: CGSize = .zero
    @State private var predicted: CGSize = .zero

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.12))
                RoundedRectangle(cornerRadius: 8).fill(.blue.gradient).frame(width: 60, height: 40)
                    .offset(translation)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                translation = value.translation
                                velocity = value.velocity
                                predicted = value.predictedEndTranslation
                            }
                            .onEnded { _ in withAnimation(.snappy) { translation = .zero } }
                    )
            }
            .frame(width: 220, height: 80)
            C17_Caption(text: "translation \(String(format: "%.0f, %.0f", translation.width, translation.height)) · velocity \(String(format: "%.0f, %.0f", velocity.width, velocity.height)) pt/s\npredictedEndTranslation \(String(format: "%.0f, %.0f", predicted.width, predicted.height))")
        }
    }
}

private struct C17_DragInitExample: View {
    @State private var cursor = CGPoint(x: 110, y: 40)

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(Color.green.opacity(0.12))
                Image(systemName: "plus").font(.title2).foregroundStyle(.green)
                    .position(cursor)
            }
            .frame(width: 220, height: 80)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged { value in cursor = value.location }
            )
            C17_Caption(text: "minimumDistance: 0 starts on press · location in .local: \(String(format: "%.0f, %.0f", cursor.x, cursor.y))")
        }
    }
}

// MARK: - ExclusiveGesture

private struct C17_ExclusiveInitExample: View {
    @State private var presses = 0
    @State private var taps = 0

    var body: some View {
        let pressOrTap = ExclusiveGesture(LongPressGesture(minimumDuration: 0.5), TapGesture())
            .onEnded { value in
                if case .first = value { presses += 1 } else { taps += 1 }
            }
        VStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.indigo.gradient)
                .frame(width: 140, height: 56)
                .overlay { Text("Tap or hold").foregroundStyle(.white) }
                .gesture(pressOrTap)
            C17_Caption(text: "Long presses (.first): \(presses) · taps (.second): \(taps)")
        }
    }
}

private struct C17_ExclusiveValueExample: View {
    @State private var isSelected = false
    @State private var offset: CGSize = .zero
    @State private var lastCase = "—"

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.12))
                RoundedRectangle(cornerRadius: 8)
                    .fill(isSelected ? Color.orange : Color.blue)
                    .frame(width: 60, height: 40)
                    .offset(offset)
                    .gesture(
                        TapGesture().exclusively(before: DragGesture())
                            .onEnded { value in
                                switch value {
                                case .first:
                                    isSelected.toggle()
                                    lastCase = ".first — tap"
                                case .second(let drag):
                                    offset.width = max(-80, min(80, offset.width + drag.translation.width))
                                    lastCase = ".second(drag) — moved \(String(format: "%.0f", drag.translation.width)) pt"
                                }
                            }
                    )
            }
            .frame(width: 220, height: 70)
            C17_Caption(text: "Click to select, drag to move · last value: \(lastCase)")
        }
    }
}

// MARK: - GestureMask

/// The stage every GestureMask variant renders: an outer tap target holding a Button subview.
private struct C17_MaskStage: View {
    let outerTaps: Int
    let buttonTaps: Int
    let onButton: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.12))
            VStack(spacing: 6) {
                Text("outer tap target").font(.caption2).foregroundStyle(.secondary)
                Button("Subview button", action: onButton)
            }
        }
        .frame(width: 220, height: 70)
        .contentShape(Rectangle())
    }
}

private struct C17_MaskAllExample: View {
    @State private var outerTaps = 0
    @State private var buttonTaps = 0
    var body: some View {
        VStack(spacing: 8) {
            C17_MaskStage(outerTaps: outerTaps, buttonTaps: buttonTaps) { buttonTaps += 1 }
                .gesture(TapGesture().onEnded { outerTaps += 1 }, including: .all)
            C17_Caption(text: ".all — outer taps: \(outerTaps) · button taps: \(buttonTaps)")
        }
    }
}

private struct C17_MaskGestureExample: View {
    @State private var outerTaps = 0
    @State private var buttonTaps = 0
    var body: some View {
        VStack(spacing: 8) {
            C17_MaskStage(outerTaps: outerTaps, buttonTaps: buttonTaps) { buttonTaps += 1 }
                .gesture(TapGesture().onEnded { outerTaps += 1 }, including: .gesture)
            C17_Caption(text: ".gesture — outer taps: \(outerTaps) · button taps: \(buttonTaps) (silenced)")
        }
    }
}

private struct C17_MaskSubviewsExample: View {
    @State private var outerTaps = 0
    @State private var buttonTaps = 0
    var body: some View {
        VStack(spacing: 8) {
            C17_MaskStage(outerTaps: outerTaps, buttonTaps: buttonTaps) { buttonTaps += 1 }
                .gesture(TapGesture().onEnded { outerTaps += 1 }, including: .subviews)
            C17_Caption(text: ".subviews — outer taps: \(outerTaps) (dormant) · button taps: \(buttonTaps)")
        }
    }
}

private struct C17_MaskNoneExample: View {
    @State private var outerTaps = 0
    @State private var buttonTaps = 0
    var body: some View {
        VStack(spacing: 8) {
            C17_MaskStage(outerTaps: outerTaps, buttonTaps: buttonTaps) { buttonTaps += 1 }
                .gesture(TapGesture().onEnded { outerTaps += 1 }, including: .none)
            C17_Caption(text: ".none — outer taps: \(outerTaps) · button taps: \(buttonTaps) (both off)")
        }
    }
}

// MARK: - KeyframeTimeline

private struct C17_KeyframeTimelineInitExample: View {
    private let timeline = KeyframeTimeline(initialValue: CGPoint.zero) {
        KeyframeTrack(\.x) { LinearKeyframe(200, duration: 0.5) }
        KeyframeTrack(\.y) { SpringKeyframe(60, duration: 1.0, spring: .bouncy) }
    }

    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.12))
                ForEach(0..<40, id: \.self) { i in
                    let point = timeline.value(progress: Double(i) / 39)
                    Circle().fill(.blue).frame(width: 6, height: 6)
                        .position(x: point.x + 10, y: point.y + 10)
                }
            }
            .frame(width: 220, height: 84)
            C17_Caption(text: "Two tracks, x linear over 0.5 s and y springy over 1 s · duration \(String(format: "%.1f", timeline.duration)) s")
        }
    }
}

private struct C17_KeyframeTimelineValueExample: View {
    private let timeline = KeyframeTimeline(initialValue: CGPoint(x: 20, y: 40)) {
        KeyframeTrack(\.x) { LinearKeyframe(200, duration: 1.2); LinearKeyframe(20, duration: 1.2) }
        KeyframeTrack(\.y) { SpringKeyframe(12, duration: 0.6, spring: .bouncy); SpringKeyframe(68, duration: 0.6, spring: .bouncy); SpringKeyframe(40, duration: 1.2) }
    }
    private let start = Date()

    var body: some View {
        VStack(spacing: 8) {
            TimelineView(.animation) { context in
                let t = context.date.timeIntervalSince(start).truncatingRemainder(dividingBy: timeline.duration)
                let point = timeline.value(time: t)
                ZStack {
                    RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.12))
                    Circle().fill(.orange.gradient).frame(width: 14, height: 14).position(point)
                }
                .frame(width: 220, height: 80)
                .overlay(alignment: .bottomTrailing) {
                    Text("t = \(String(format: "%.2f", t)) s").font(.caption2.monospacedDigit()).padding(4)
                }
            }
            C17_Caption(text: "value(time:) samples the timeline by absolute seconds")
        }
    }
}

// MARK: - Mock window chrome (scene-level illustrations)

private struct C17_WindowChrome<Content: View>: View {
    var title: String
    var showsTitleBar = true
    var width: CGFloat = 200
    var height: CGFloat = 110
    @ViewBuilder var content: Content

    var body: some View {
        VStack(spacing: 0) {
            if showsTitleBar {
                HStack(spacing: 5) {
                    Circle().fill(.red).frame(width: 8, height: 8)
                    Circle().fill(.yellow).frame(width: 8, height: 8)
                    Circle().fill(.green).frame(width: 8, height: 8)
                    Spacer()
                    Text(title).font(.caption2).foregroundStyle(.secondary).lineLimit(1)
                    Spacer()
                }
                .padding(.horizontal, 8)
                .frame(height: 20)
                .background(Color.gray.opacity(0.18))
            }
            content.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(width: width, height: height)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(Color.gray.opacity(0.45)))
        .shadow(color: .black.opacity(0.18), radius: 4, y: 2)
    }
}

// MARK: - .defaultSize()

private struct C17_DefaultSizeWidthHeightExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C17_WindowChrome(title: "Library", width: 1000 * 0.18, height: 650 * 0.18) {
                Text("1000 × 650 pt").font(.caption).foregroundStyle(.secondary)
            }
            C17_Caption(text: ".defaultSize(width: 1000, height: 650) — first-launch size\nIllustrative — applies at the Scene level")
        }
    }
}

private struct C17_DefaultSizeCGSizeExample: View {
    private let size = CGSize(width: 320, height: 480)
    var body: some View {
        VStack(spacing: 10) {
            C17_WindowChrome(title: "Inspector", width: size.width * 0.2, height: size.height * 0.2) {
                Text("320 × 480 pt").font(.caption2).foregroundStyle(.secondary)
            }
            C17_Caption(text: ".defaultSize(CGSize(width: 320, height: 480))\nIllustrative — applies at the Scene level")
        }
    }
}

// MARK: - @WKApplicationDelegateAdaptor

private struct C17_WatchFace<Content: View>: View {
    @ViewBuilder var content: Content
    var body: some View {
        content
            .frame(width: 120, height: 100)
            .background(.black, in: RoundedRectangle(cornerRadius: 22))
            .overlay(RoundedRectangle(cornerRadius: 22).strokeBorder(Color.gray.opacity(0.6), lineWidth: 3))
    }
}

private struct C17_WKDelegateAdaptorInitExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C17_WatchFace {
                VStack(spacing: 4) {
                    Image(systemName: "bell.badge.fill").foregroundStyle(.green)
                    Text("applicationDidFinishLaunching").font(.system(size: 8)).foregroundStyle(.white)
                    Text("→ registerForRemoteNotifications()").font(.system(size: 8)).foregroundStyle(.gray)
                }
            }
            C17_Caption(text: "The adaptor installs AppDelegate so its lifecycle callbacks run\nIllustrative — watchOS only")
        }
    }
}

private struct C17_WKDelegateAdaptorProjectedExample: View {
    @State private var lastBackgroundRefresh: Date? = nil
    var body: some View {
        VStack(spacing: 10) {
            C17_WatchFace {
                VStack(spacing: 4) {
                    Text("Last refresh").font(.system(size: 9)).foregroundStyle(.gray)
                    Text(lastBackgroundRefresh.map { $0.formatted(date: .omitted, time: .shortened) } ?? "—")
                        .font(.system(size: 14, weight: .semibold)).foregroundStyle(.white)
                    Button("Simulate refresh") { lastBackgroundRefresh = Date() }
                        .controlSize(.mini)
                }
            }
            C17_Caption(text: "$delegate.lastBackgroundRefresh binds the published property\nIllustrative — watchOS only")
        }
    }
}

// MARK: - BackgroundTask

private struct C17_BackgroundFlow: View {
    let trigger: String
    let triggerSymbol: String
    let handler: String

    var body: some View {
        HStack(spacing: 10) {
            VStack(spacing: 4) {
                Image(systemName: triggerSymbol).font(.title2).foregroundStyle(.blue)
                Text(trigger).font(.caption2).multilineTextAlignment(.center)
            }
            .frame(width: 80)
            Image(systemName: "arrow.right").foregroundStyle(.secondary)
            VStack(spacing: 4) {
                Image(systemName: "app.badge").font(.title2).foregroundStyle(.indigo)
                Text("app woken").font(.caption2)
            }
            .frame(width: 60)
            Image(systemName: "arrow.right").foregroundStyle(.secondary)
            VStack(spacing: 4) {
                Image(systemName: "checkmark.circle.fill").font(.title2).foregroundStyle(.green)
                Text(handler).font(.caption2.monospaced()).multilineTextAlignment(.center)
            }
            .frame(width: 110)
        }
        .padding(10)
        .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10))
    }
}

private struct C17_BackgroundAppRefreshExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C17_BackgroundFlow(trigger: "scheduled refresh\n\"com.example.sync\"", triggerSymbol: "clock.arrow.circlepath", handler: "SyncEngine\n.shared.run()")
            C17_Caption(text: ".appRefresh(_:) matches a BGAppRefreshTask by identifier\nIllustrative — runs when the system wakes the app")
        }
    }
}

private struct C17_BackgroundURLSessionExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C17_BackgroundFlow(trigger: "background session\n\"com.example.downloads\"", triggerSymbol: "arrow.down.circle", handler: "Downloads.shared\n.processEvents()")
            C17_Caption(text: ".urlSession(_:) matches wake-ups for a background URLSession\nIllustrative — runs when transfers finish")
        }
    }
}

// MARK: - CommandGroupPlacement

private struct C17_MockMenu: View {
    let title: String
    let items: [String]          // "-" renders a separator
    let highlighted: Set<Int>

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.caption.bold())
                .foregroundStyle(.white)
                .padding(.horizontal, 8).padding(.vertical, 3)
                .background(Color.accentColor, in: RoundedRectangle(cornerRadius: 4))
            VStack(alignment: .leading, spacing: 1) {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    if item == "-" {
                        Divider().padding(.vertical, 2)
                    } else {
                        Text(item)
                            .font(.caption)
                            .padding(.horizontal, 8).padding(.vertical, 2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(highlighted.contains(index) ? Color.accentColor.opacity(0.25) : Color.clear,
                                        in: RoundedRectangle(cornerRadius: 4))
                    }
                }
            }
            .padding(4)
            .frame(width: 160)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 6))
            .overlay(RoundedRectangle(cornerRadius: 6).strokeBorder(Color.gray.opacity(0.4)))
        }
    }
}

private struct C17_PlacementNewItemExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C17_MockMenu(title: "File", items: ["New Window   ⌘N", "New Tag…", "-", "Open…   ⌘O", "Close   ⌘W"], highlighted: [1])
            C17_Caption(text: "CommandGroup(after: .newItem) lands right after New Window\nIllustrative — applies at the Scene level")
        }
    }
}

private struct C17_PlacementAppInfoExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C17_MockMenu(title: "Ledger", items: ["About Ledger", "-", "Settings…   ⌘,", "-", "Quit Ledger   ⌘Q"], highlighted: [0])
            C17_Caption(text: "CommandGroup(replacing: .appInfo) swaps the About command\nIllustrative — applies at the Scene level")
        }
    }
}

private struct C17_PlacementHelpExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C17_MockMenu(title: "Help", items: ["Search", "-", "Ledger Manual ↗"], highlighted: [2])
            C17_Caption(text: "CommandGroup(replacing: .help) fills the Help menu\nIllustrative — applies at the Scene level")
        }
    }
}

// MARK: - MenuBarExtraStyle

private struct C17_MenuBarStrip: View {
    var body: some View {
        HStack(spacing: 10) {
            Spacer()
            Image(systemName: "icloud.and.arrow.up").foregroundStyle(.white)
                .padding(.horizontal, 4).background(Color.white.opacity(0.25), in: RoundedRectangle(cornerRadius: 4))
            Image(systemName: "wifi")
            Image(systemName: "battery.75percent")
            Text("9:41").font(.caption)
        }
        .font(.caption)
        .padding(.horizontal, 8)
        .frame(width: 230, height: 22)
        .background(Color.gray.opacity(0.35))
    }
}

private struct C17_MenuBarExtraMenuExample: View {
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            C17_MenuBarStrip()
            C17_MockMenu(title: "Uploads", items: ["Pause All", "-", "Quit"], highlighted: [])
                .padding(.trailing, 60)
                .padding(.top, 2)
            C17_Caption(text: ".menu — a standard pull-down menu of commands\nIllustrative — macOS menu bar")
                .frame(maxWidth: .infinity)
                .padding(.top, 6)
        }
        .frame(width: 230)
    }
}

private struct C17_MenuBarExtraWindowExample: View {
    @State private var wifiOnly = true
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            C17_MenuBarStrip()
            VStack(alignment: .leading, spacing: 8) {
                Text("Uploads").font(.caption.bold())
                ProgressView(value: 0.6)
                Toggle("Wi-Fi only", isOn: $wifiOnly).toggleStyle(.switch).controlSize(.mini).font(.caption)
            }
            .padding(10)
            .frame(width: 150)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(Color.gray.opacity(0.4)))
            .padding(.trailing, 60)
            .padding(.top, 2)
            C17_Caption(text: ".window — a floating panel of arbitrary views\nIllustrative — macOS menu bar")
                .frame(maxWidth: .infinity)
                .padding(.top, 6)
        }
        .frame(width: 230)
    }
}

// MARK: - SceneBuilder

private struct C17_SceneBuildBlockExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 12) {
                C17_WindowChrome(title: "Activity", width: 110, height: 70) {
                    Image(systemName: "chart.bar").foregroundStyle(.secondary)
                }
                C17_WindowChrome(title: "Settings", width: 110, height: 70) {
                    Image(systemName: "gearshape").foregroundStyle(.secondary)
                }
            }
            C17_Caption(text: "buildBlock folds two scene declarations into one composite Scene\nIllustrative — applies at the App level")
        }
    }
}

private struct C17_SceneBuildOptionalExample: View {
    @State private var debugTools = false
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 12) {
                C17_WindowChrome(title: "App", width: 110, height: 70) {
                    Image(systemName: "doc.text").foregroundStyle(.secondary)
                }
                if debugTools {
                    C17_WindowChrome(title: "Debug Console", width: 110, height: 70) {
                        Text("> ready").font(.caption2.monospaced()).foregroundStyle(.green)
                    }
                    .transition(.scale.combined(with: .opacity))
                }
            }
            .frame(height: 74)
            Toggle("DEBUG_TOOLS set", isOn: $debugTools.animation(.snappy)).toggleStyle(.switch).controlSize(.small)
            C17_Caption(text: "buildOptional allows an if with no else\nIllustrative — applies at the App level")
        }
    }
}

private struct C17_SceneBuildEitherExample: View {
    @State private var usesDocumentModel = true
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                if usesDocumentModel {
                    C17_WindowChrome(title: "Untitled.note — DocumentGroup", width: 200, height: 70) {
                        Label("NoteEditor", systemImage: "doc.richtext").font(.caption).foregroundStyle(.secondary)
                    }
                } else {
                    C17_WindowChrome(title: "Notes — WindowGroup", width: 200, height: 70) {
                        Label("NotesBrowser", systemImage: "list.bullet").font(.caption).foregroundStyle(.secondary)
                    }
                }
            }
            .frame(height: 74)
            Toggle("usesDocumentModel", isOn: $usesDocumentModel.animation(.snappy)).toggleStyle(.switch).controlSize(.small)
            C17_Caption(text: "buildEither(first:) carries the if branch; buildEither(second:) the else\nIllustrative — applies at the App level")
        }
    }
}

// MARK: - WindowInteractionBehavior

private struct C17_InteractionAutomaticExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C17_WindowChrome(title: "Palette", showsTitleBar: false, width: 200, height: 70) {
                HStack(spacing: 8) {
                    ForEach([Color.red, .orange, .yellow, .green, .blue], id: \.self) { color in
                        Circle().fill(color).frame(width: 18, height: 18)
                    }
                }
            }
            C17_Caption(text: ".automatic — the .plain style decides whether background drags move it\nIllustrative — applies at the Scene level")
        }
    }
}

private struct C17_InteractionEnabledExample: View {
    @State private var nudge: CGFloat = 0
    var body: some View {
        VStack(spacing: 10) {
            C17_WindowChrome(title: "Scratchpad", showsTitleBar: false, width: 200, height: 70) {
                VStack(spacing: 4) {
                    Image(systemName: "hand.draw").font(.title3).foregroundStyle(.blue)
                    Text("drag the background to move").font(.caption2).foregroundStyle(.secondary)
                }
            }
            .offset(x: nudge)
            .gesture(DragGesture().onChanged { nudge = max(-30, min(30, $0.translation.width)) }
                .onEnded { _ in withAnimation(.snappy) { nudge = 0 } })
            C17_Caption(text: ".enabled — background drags move a window with no title bar\nIllustrative — applies at the Scene level")
        }
    }
}

private struct C17_InteractionDisabledExample: View {
    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 0) {
                HStack(spacing: 5) {
                    Circle().fill(.red).frame(width: 8, height: 8)
                    Circle().fill(Color.gray.opacity(0.35)).frame(width: 8, height: 8)
                    Circle().fill(Color.gray.opacity(0.35)).frame(width: 8, height: 8)
                    Spacer()
                    Text("Inspector").font(.caption2).foregroundStyle(.secondary)
                    Spacer()
                }
                .padding(.horizontal, 8).frame(height: 20)
                .background(Color.gray.opacity(0.18))
                VStack(alignment: .leading, spacing: 4) {
                    Text("Opacity  100%").font(.caption2)
                    Text("Blend  Normal").font(.caption2)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: 200, height: 70)
            .background(.background)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(Color.gray.opacity(0.45)))
            C17_Caption(text: ".disabled — minimize and full-screen affordances are removed\nIllustrative — applies at the Scene level")
        }
    }
}

// MARK: - WindowLevel

private struct C17_LevelAutomaticExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C17_WindowChrome(title: "Document", width: 200, height: 70) {
                Text("tier derived from style and role").font(.caption2).foregroundStyle(.secondary)
            }
            C17_Caption(text: ".automatic — the default; a document window lands in the normal tier\nIllustrative — applies at the Scene level")
        }
    }
}

private struct C17_LevelNormalExample: View {
    var body: some View {
        VStack(spacing: 10) {
            ZStack(alignment: .topLeading) {
                C17_WindowChrome(title: "Library", width: 170, height: 60) {
                    Text("behind when not key").font(.caption2).foregroundStyle(.secondary)
                }
                C17_WindowChrome(title: "Document (key)", width: 170, height: 60) {
                    Text("front when key").font(.caption2).foregroundStyle(.secondary)
                }
                .offset(x: 40, y: 22)
            }
            .frame(width: 220, height: 84, alignment: .topLeading)
            C17_Caption(text: ".normal — ordinary tier: whichever window is key comes forward\nIllustrative — applies at the Scene level")
        }
    }
}

private struct C17_LevelFloatingExample: View {
    var body: some View {
        VStack(spacing: 10) {
            ZStack(alignment: .topLeading) {
                C17_WindowChrome(title: "Document (key)", width: 200, height: 70) {
                    Text("key, yet underneath").font(.caption2).foregroundStyle(.secondary)
                }
                C17_WindowChrome(title: "Timer", showsTitleBar: false, width: 80, height: 34) {
                    Text("04:59").font(.caption.monospacedDigit().bold())
                }
                .offset(x: 130, y: 40)
            }
            .frame(width: 220, height: 84, alignment: .topLeading)
            C17_Caption(text: ".floating — the HUD stays above normal windows even when not key\nIllustrative — applies at the Scene level")
        }
    }
}

// MARK: - WindowResizability

private struct C17_ResizeFrame: View {
    let title: String
    let arrows: String
    let locked: Bool

    var body: some View {
        C17_WindowChrome(title: title, width: 200, height: 76) {
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [3]))
                    .foregroundStyle(.blue)
                    .padding(6)
                Text("content").font(.caption2).foregroundStyle(.secondary)
            }
            .overlay(alignment: .bottomTrailing) {
                Image(systemName: arrows)
                    .font(.caption)
                    .foregroundStyle(locked ? Color.secondary : Color.blue)
                    .padding(3)
            }
        }
    }
}

private struct C17_ResizabilityContentSizeExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C17_ResizeFrame(title: "About", arrows: "lock.fill", locked: true)
            C17_Caption(text: ".contentSize — resize range pinned to the content's min and max\nIllustrative — applies at the Scene level")
        }
    }
}

private struct C17_ResizabilityContentMinSizeExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C17_ResizeFrame(title: "Editor", arrows: "arrow.up.left.and.arrow.down.right", locked: false)
            C17_Caption(text: ".contentMinSize — content min enforced, growth unlimited\nIllustrative — applies at the Scene level")
        }
    }
}

// MARK: - WindowStyle

private struct C17_StyleTitleBarExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C17_WindowChrome(title: "Untitled", width: 200, height: 76) {
                Text("ContentView").font(.caption).foregroundStyle(.secondary)
            }
            C17_Caption(text: ".titleBar — the standard window with a visible title bar\nIllustrative — applies at the Scene level")
        }
    }
}

private struct C17_StyleHiddenTitleBarExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C17_WindowChrome(title: "", showsTitleBar: false, width: 200, height: 76) {
                ZStack(alignment: .topLeading) {
                    LinearGradient(colors: [.blue.opacity(0.35), .clear], startPoint: .top, endPoint: .bottom)
                    HStack(spacing: 5) {
                        Circle().fill(.red).frame(width: 8, height: 8)
                        Circle().fill(.yellow).frame(width: 8, height: 8)
                        Circle().fill(.green).frame(width: 8, height: 8)
                    }
                    .padding(8)
                    Text("content reaches the top edge").font(.caption2).foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            C17_Caption(text: ".hiddenTitleBar — traffic lights float over full-bleed content\nIllustrative — applies at the Scene level")
        }
    }
}

private struct C17_StylePlainExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                RoundedRectangle(cornerRadius: 8).fill(.purple.gradient).frame(width: 40, height: 40)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Now Playing").font(.caption.bold())
                    Text("no title bar, no chrome").font(.caption2).foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "pause.fill")
            }
            .padding(10)
            .frame(width: 200, height: 60)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 14))
            .shadow(color: .black.opacity(0.18), radius: 4, y: 2)
            C17_Caption(text: ".plain — all standard decoration removed for a custom surface\nIllustrative — applies at the Scene level")
        }
    }
}

// MARK: - WindowToolbarStyle

private struct C17_ToolbarWindow: View {
    let title: String
    let rowHeight: CGFloat
    let separateTitleRow: Bool

    private var toolbarIcons: some View {
        HStack(spacing: 8) {
            Image(systemName: "sidebar.left")
            Image(systemName: "square.and.pencil")
            Image(systemName: "paperplane")
            Spacer()
            Image(systemName: "magnifyingglass")
        }
        .font(.system(size: rowHeight * 0.45))
        .foregroundStyle(.secondary)
    }

    var body: some View {
        VStack(spacing: 0) {
            if separateTitleRow {
                HStack(spacing: 5) {
                    Circle().fill(.red).frame(width: 8, height: 8)
                    Circle().fill(.yellow).frame(width: 8, height: 8)
                    Circle().fill(.green).frame(width: 8, height: 8)
                    Spacer()
                    Text(title).font(.caption2).foregroundStyle(.secondary)
                    Spacer()
                }
                .padding(.horizontal, 8).frame(height: 20)
                toolbarIcons.padding(.horizontal, 10).frame(height: rowHeight)
            } else {
                HStack(spacing: 5) {
                    Circle().fill(.red).frame(width: 8, height: 8)
                    Circle().fill(.yellow).frame(width: 8, height: 8)
                    Circle().fill(.green).frame(width: 8, height: 8)
                    Text(title).font(.caption2).foregroundStyle(.secondary).padding(.leading, 6)
                    toolbarIcons.padding(.leading, 10)
                }
                .padding(.horizontal, 8).frame(height: rowHeight)
            }
            Divider()
            Text("ContentView").font(.caption2).foregroundStyle(.tertiary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(width: 220, height: 84)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(Color.gray.opacity(0.45)))
    }
}

private struct C17_ToolbarUnifiedExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C17_ToolbarWindow(title: "Inbox", rowHeight: 32, separateTitleRow: false)
            C17_Caption(text: ".unified — title and toolbar share one standard-height row\nIllustrative — applies at the Scene level")
        }
    }
}

private struct C17_ToolbarUnifiedCompactExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C17_ToolbarWindow(title: "Inbox", rowHeight: 22, separateTitleRow: false)
            C17_Caption(text: ".unifiedCompact — the merged row at a reduced height\nIllustrative — applies at the Scene level")
        }
    }
}

private struct C17_ToolbarExpandedExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C17_ToolbarWindow(title: "Inbox", rowHeight: 28, separateTitleRow: true)
            C17_Caption(text: ".expanded — the title gets its own row above the toolbar items\nIllustrative — applies at the Scene level")
        }
    }
}
