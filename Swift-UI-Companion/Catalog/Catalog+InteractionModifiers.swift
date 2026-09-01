//
//  Catalog+InteractionModifiers.swift
//  Swift-UI-Companion
//
//  Second wave of modifiers: events, input, presentation, and lists.
//

import Foundation

extension Catalog {
    static let interactionModifiers: [Topic] = [
        Topic(
            name: ".onChange()",
            kind: .modifier,
            summary: "Runs an action when an observed value changes.",
            discussion: "onChange watches any Equatable value and fires with the old and new values (the two-parameter form arrived in 2023). Reach for it to trigger side effects; for pure derived state, compute in body instead.",
            wwdcYear: 2020,
            code: #"""
            DetailView()
                .onChange(of: selection) { oldValue, newValue in
                    save(newValue)
                }
            """#,
            related: [".task()", ".onAppear()"],
            children: [
                TopicChild(
                    name: "onChange(of:initial:_:) (two-parameter)",
                    summary: "Hands the closure both the old and new values for comparison.",
                    discussion: "Use this form when the reaction depends on the direction or size of the change — the closure receives the value before and after the mutation.",
                    code: #"""
                    Slider(value: $volume)
                        .onChange(of: volume) { oldValue, newValue in
                            if newValue > oldValue { fadeUp() }
                        }
                    """#
                ),
                TopicChild(
                    name: "onChange(of:initial:_:) (zero-parameter)",
                    summary: "Fires on change without passing the values — a pure signal.",
                    discussion: "Pass initial: true to also run the action once when the view first appears, handy for kicking off a load that should repeat on every subsequent change.",
                    code: #"""
                    ChartView(data)
                        .onChange(of: filter, initial: true) {
                            reloadData()
                        }
                    """#
                ),
            ]
        ),
        Topic(
            name: ".onSubmit()",
            kind: .modifier,
            summary: "Responds to the submit action of text input.",
            discussion: "onSubmit fires when the user presses Return in a TextField or search field within its scope. Combine with submitLabel to change the keyboard's action key.",
            wwdcYear: 2021,
            code: #"""
            TextField("Search", text: $query)
                .onSubmit { runSearch() }
            """#,
            related: ["TextField", ".searchable()"]
        ),
        Topic(
            name: ".refreshable()",
            kind: .modifier,
            summary: "Adds pull-to-refresh backed by an async closure.",
            discussion: "refreshable installs the platform refresh gesture and keeps the indicator visible until your async closure returns — structured concurrency defines 'done'. Lists and scroll views adopt it automatically.",
            wwdcYear: 2021,
            code: #"""
            List(articles) { ArticleRow($0) }
                .refreshable {
                    articles = await store.latest()
                }
            """#,
            related: [".task()", "List"]
        ),
        Topic(
            name: ".swipeActions()",
            kind: .modifier,
            summary: "Adds leading or trailing swipe buttons to list rows.",
            discussion: "swipeActions attaches buttons revealed by swiping a row, per edge, with optional full-swipe triggering the first action. Roles tint destructive actions; tint colors the rest.",
            wwdcYear: 2021,
            platforms: [.iOS, .macOS, .watchOS],
            code: #"""
            ItemRow(item)
                .swipeActions(edge: .trailing) {
                    Button("Delete", role: .destructive) { delete(item) }
                    Button("Pin") { pin(item) }.tint(.yellow)
                }
            """#,
            related: ["List", ".contextMenu()"],
            children: [
                TopicChild(
                    name: "swipeActions(edge:allowsFullSwipe:content:)",
                    summary: "The full signature: choose the edge and whether a full swipe fires the first button.",
                    discussion: "allowsFullSwipe defaults to true, so a hard swipe triggers the first action in the group — turn it off when that action is not obviously safe to run by accident.",
                    code: #"""
                    ItemRow(item)
                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            Button("Read") { markRead(item) }.tint(.blue)
                        }
                    """#
                ),
                TopicChild(
                    name: "HorizontalEdge",
                    summary: "The two-case enum naming which side the buttons slide in from.",
                    discussion: "Apply the modifier once per edge to offer both leading and trailing sets; applying it more than once on the same edge accumulates the buttons rather than replacing them.",
                    code: #"""
                    MessageRow(message)
                        .swipeActions(edge: .leading) {
                            Button("Flag") { flag(message) }.tint(.orange)
                        }
                        .swipeActions(edge: .trailing) {
                            Button("Delete", role: .destructive) { delete(message) }
                        }
                    """#
                ),
            ]
        ),
        Topic(
            name: ".badge()",
            kind: .modifier,
            summary: "Shows a count or text badge on rows and tabs.",
            discussion: "badge annotates list rows and tab items with the platform's badge treatment — a number, string, or styled Text. A zero count hides it automatically. This app uses badges for the sidebar's entry counts.",
            wwdcYear: 2021,
            platforms: [.iOS, .macOS],
            code: #"""
            Label("Inbox", systemImage: "tray")
                .badge(unreadCount)
            """#,
            related: ["List", "TabView"]
        ),
        Topic(
            name: ".tint()",
            kind: .modifier,
            summary: "Sets the accent color for controls in a hierarchy.",
            discussion: "tint recolors interactive elements — buttons, toggles, progress — for its subtree, overriding the app accent. Unlike foregroundStyle it only touches what the platform considers tintable.",
            wwdcYear: 2021,
            code: #"""
            Toggle("Alarm", isOn: $armed)
                .tint(.red)
            """#,
            related: [".foregroundStyle()", ".buttonStyle()"]
        ),
        Topic(
            name: ".disabled()",
            kind: .modifier,
            summary: "Blocks interaction for a view subtree.",
            discussion: "disabled(true) stops hit-testing and grays out system controls in the subtree; nested values combine so any enclosing true wins. Styles can read the state through the isEnabled environment value.",
            wwdcYear: 2019,
            code: #"""
            Button("Purchase") { buy() }
                .disabled(!termsAccepted)
            """#,
            related: ["isEnabled", ".allowsHitTesting()"]
        ),
        Topic(
            name: ".redacted()",
            kind: .modifier,
            summary: "Replaces content with placeholder shapes.",
            discussion: "redacted(reason: .placeholder) swaps text and images for neutral blocks — the standard skeleton-loading look with zero layout changes. Remove it with unredacted or by dropping the modifier.",
            wwdcYear: 2020,
            code: #"""
            ArticleRow(article)
                .redacted(reason: isLoading ? .placeholder : [])
            """#,
            related: ["ProgressView", ".opacity()"]
        ),
        Topic(
            name: ".safeAreaInset()",
            kind: .modifier,
            summary: "Pins accessory views that shrink the safe area.",
            discussion: "safeAreaInset attaches a view to an edge and extends the safe area by its size, so scrollable content underneath ends above it instead of hiding behind it — the correct tool for floating bottom bars.",
            wwdcYear: 2021,
            code: #"""
            ScrollView { content }
                .safeAreaInset(edge: .bottom) {
                    ComposeBar().background(.bar)
                }
            """#,
            related: [".ignoresSafeArea()", ".toolbar()"]
        ),
        Topic(
            name: ".ignoresSafeArea()",
            kind: .modifier,
            summary: "Lets content extend under bars and notches.",
            discussion: "ignoresSafeArea expands a view into the regions the layout normally avoids, filterable by edge and by region (container vs. keyboard). Backgrounds usually ignore; controls usually shouldn't.",
            wwdcYear: 2020,
            code: #"""
            Image("hero")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(edges: .top)
            """#,
            related: [".safeAreaInset()", ".backgroundExtensionEffect()"]
        ),
        Topic(
            name: ".keyboardShortcut()",
            kind: .modifier,
            summary: "Assigns a key combination to a control.",
            discussion: "keyboardShortcut triggers a button from the keyboard, with .defaultAction mapping to Return and .cancelAction to Escape. Shortcuts surface automatically in the macOS menu discovery overlays.",
            wwdcYear: 2020,
            platforms: [.iOS, .macOS],
            code: #"""
            Button("Save", action: save)
                .keyboardShortcut("s", modifiers: .command)
            """#,
            related: ["Button", "Commands"]
        ),
        Topic(
            name: ".popover()",
            kind: .modifier,
            summary: "Presents content anchored to a view.",
            discussion: "popover shows an anchored bubble on macOS and iPadOS, adapting to a sheet on compact iPhones unless presentationCompactAdaptation says otherwise. This app's filter editor is one.",
            wwdcYear: 2019,
            platforms: [.iOS, .macOS],
            code: #"""
            Button("Info") { showInfo = true }
                .popover(isPresented: $showInfo, arrowEdge: .bottom) {
                    InfoPanel().padding()
                }
            """#,
            related: [".sheet()", ".alert()"],
            children: [
                TopicChild(
                    name: "popover(isPresented:attachmentAnchor:arrowEdge:content:)",
                    summary: "Boolean-driven: the popover shows while the binding stays true.",
                    discussion: "The system flips the binding back to false when the user dismisses by clicking away, so plain @State is all the bookkeeping you need.",
                    code: #"""
                    Button("Legend") { showLegend = true }
                        .popover(isPresented: $showLegend, arrowEdge: .top) {
                            LegendView().padding()
                        }
                    """#
                ),
                TopicChild(
                    name: "popover(item:attachmentAnchor:arrowEdge:content:)",
                    summary: "Item-driven: presents while an optional Identifiable value is non-nil.",
                    discussion: "The unwrapped item arrives in the content closure, which keeps the presented view honest — it can only render data that actually exists. When the item's identity changes, the system dismisses the current popover and presents a new one for the new value.",
                    code: #"""
                    TileGrid(tiles)
                        .popover(item: $inspectedTile) { tile in
                            TileInspector(tile)
                                .frame(minWidth: 260)
                        }
                    """#
                ),
            ]
        ),
        Topic(
            name: ".confirmationDialog()",
            kind: .modifier,
            summary: "Asks the user to confirm from a list of choices.",
            discussion: "confirmationDialog presents an action sheet on iOS and an alert-style dialog on macOS, for choice sets that would crowd an alert. Give destructive buttons a role and keep a cancel path.",
            wwdcYear: 2021,
            code: #"""
            .confirmationDialog("Export format?", isPresented: $choosing) {
                Button("PDF") { export(.pdf) }
                Button("PNG") { export(.png) }
                Button("Cancel", role: .cancel) { }
            }
            """#,
            related: [".alert()", ".sheet()"]
        ),
        Topic(
            name: ".fullScreenCover()",
            kind: .modifier,
            summary: "Presents a modal that covers the entire screen.",
            discussion: "fullScreenCover is sheet without the partial-height card: the destination owns the whole screen and must dismiss itself. Right for immersive flows like onboarding and players.",
            wwdcYear: 2020,
            platforms: [.iOS, .tvOS, .watchOS],
            code: #"""
            .fullScreenCover(isPresented: $showingPlayer) {
                PlayerView()
            }
            """#,
            related: [".sheet()", "dismiss"]
        ),
        Topic(
            name: ".presentationDetents()",
            kind: .modifier,
            summary: "Gives a sheet resizable height stops.",
            discussion: "presentationDetents lists the heights a sheet can rest at — medium, large, fractions, or fixed points — and the user drags between them. Bind the selection to react to detent changes.",
            wwdcYear: 2022,
            platforms: [.iOS],
            code: #"""
            .sheet(isPresented: $showMap) {
                MapSheet()
                    .presentationDetents([.medium, .large])
            }
            """#,
            related: [".sheet()", ".presentationSizing()"]
        ),
        Topic(
            name: ".interactiveDismissDisabled()",
            kind: .modifier,
            summary: "Stops a sheet from being swiped away.",
            discussion: "interactiveDismissDisabled keeps the drag-to-dismiss gesture from discarding a presentation mid-task — unsaved edits, running payments — while programmatic dismissal keeps working.",
            wwdcYear: 2021,
            platforms: [.iOS, .macOS],
            code: #"""
            .sheet(isPresented: $editing) {
                EditorView()
                    .interactiveDismissDisabled(hasUnsavedChanges)
            }
            """#,
            related: [".sheet()", "dismiss"]
        ),
        Topic(
            name: ".listRowSeparator()",
            kind: .modifier,
            summary: "Shows or hides separators for a list row.",
            discussion: "listRowSeparator controls the hairline under (and above) individual rows, with listRowSeparatorTint recoloring instead of hiding. Applies per row, not on the List itself.",
            wwdcYear: 2021,
            platforms: [.iOS, .macOS],
            code: #"""
            List(photos) { photo in
                PhotoRow(photo)
                    .listRowSeparator(.hidden)
            }
            """#,
            related: ["List", ".listStyle()"]
        ),
        Topic(
            name: ".focused()",
            kind: .modifier,
            summary: "Binds a view's focus to @FocusState.",
            discussion: "focused ties a field to a Boolean or enum-valued FocusState binding: reading tells you where focus is, writing moves it. The equals variant scales to whole forms.",
            wwdcYear: 2021,
            code: #"""
            TextField("Email", text: $email)
                .focused($focusedField, equals: .email)
            """#,
            related: ["@FocusState", "TextField"]
        ),
        Topic(
            name: ".onHover()",
            kind: .modifier,
            summary: "Tracks pointer enter and exit over a view.",
            discussion: "onHover reports when the cursor enters or leaves, for hover highlights and reveal-on-hover controls on macOS and iPadOS pointers. Keep the reaction subtle; touch platforms never see it.",
            wwdcYear: 2020,
            platforms: [.iOS, .macOS],
            code: #"""
            RowView(item)
                .onHover { isHovering = $0 }
                .background(isHovering ? .quaternary : .clear)
            """#,
            related: [".onTapGesture()", ".help()"]
        ),
        Topic(
            name: ".gesture()",
            kind: .modifier,
            summary: "Attaches a configurable gesture recognizer.",
            discussion: "gesture accepts drag, magnification, rotation, long-press, and tap gestures — composable with simultaneously, sequenced, and exclusively — with updating/onChanged/onEnded callbacks. The quad-curve demo's draggable points use one.",
            wwdcYear: 2019,
            code: #"""
            Circle()
                .offset(dragOffset)
                .gesture(
                    DragGesture()
                        .onChanged { dragOffset = $0.translation }
                        .onEnded { _ in dragOffset = .zero }
                )
            """#,
            related: ["@GestureState", ".onTapGesture()", "Gesture"],
            children: [
                TopicChild(
                    name: "gesture(_:including:)",
                    summary: "Attaches a gesture with a mask deciding who else may receive it.",
                    discussion: "The GestureMask options — .all, .gesture, .subviews, .none — let the modifier claim input exclusively or defer entirely to gestures declared deeper in the subtree.",
                    code: #"""
                    MapCanvas()
                        .gesture(
                            LongPressGesture(minimumDuration: 0.4)
                                .onEnded { _ in dropPin() },
                            including: .gesture
                        )
                    """#
                ),
                TopicChild(
                    name: "simultaneousGesture(_:including:)",
                    summary: "Runs the new gesture alongside whatever the subtree already recognizes.",
                    discussion: "Where gesture(_:) competes with descendants, this form cooperates — the classic case is counting taps on content inside a ScrollView without stealing the scroll.",
                    code: #"""
                    ScrollView { gallery }
                        .simultaneousGesture(
                            TapGesture().onEnded { logImpression() }
                        )
                    """#
                ),
                TopicChild(
                    name: "highPriorityGesture(_:including:)",
                    summary: "Gives the attached gesture first claim over the subtree's own gestures.",
                    code: #"""
                    CardStack()
                        .highPriorityGesture(
                            DragGesture(minimumDistance: 20)
                                .onEnded { swipe($0.translation) }
                        )
                    """#
                ),
            ]
        ),
        Topic(
            name: ".draggable()",
            kind: .modifier,
            summary: "Makes a view a drag source for a Transferable payload.",
            discussion: "draggable starts system drag and drop with any Transferable value, generating the default preview from the view itself. Pair with dropDestination on the receiving side.",
            wwdcYear: 2022,
            platforms: [.iOS, .macOS],
            code: #"""
            PhotoThumb(photo)
                .draggable(photo)
            """#,
            related: [".dropDestination()", "Transferable"]
        ),
        Topic(
            name: ".dropDestination()",
            kind: .modifier,
            summary: "Accepts dropped Transferable content.",
            discussion: "dropDestination declares the payload type a view accepts and receives the decoded values plus drop location, with isTargeted feedback while a drag hovers. The typed counterpart of the old onDrop.",
            wwdcYear: 2022,
            platforms: [.iOS, .macOS],
            code: #"""
            Board()
                .dropDestination(for: Photo.self) { photos, _ in
                    board.add(photos)
                    return true
                } isTargeted: { highlight = $0 }
            """#,
            related: [".draggable()", "Transferable"]
        ),
        Topic(
            name: ".textSelection()",
            kind: .modifier,
            summary: "Lets users select and copy static text.",
            discussion: "textSelection(.enabled) makes read-only Text copyable — long-press on iOS, drag-select on macOS. This app enables it on API names and code blocks.",
            wwdcYear: 2021,
            platforms: [.iOS, .macOS],
            code: #"""
            Text(serialNumber)
                .textSelection(.enabled)
            """#,
            related: ["Text"]
        ),
        Topic(
            name: ".help()",
            kind: .modifier,
            summary: "Adds a tooltip and accessibility hint.",
            discussion: "help supplies the string shown as a macOS tooltip on hover and read as the accessibility hint elsewhere — cheap discoverability for icon-only controls.",
            wwdcYear: 2020,
            code: #"""
            Button {
                lock()
            } label: {
                Image(systemName: "lock")
            }
            .help("Lock the document")
            """#,
            related: [".onHover()", "Button"]
        ),
        Topic(
            name: ".searchToolbarBehavior()",
            kind: .modifier,
            summary: "Controls how the search field collapses in the toolbar.",
            discussion: "New in the WWDC '25 design refresh: minimize collapses the search field into a compact button until tapped, keeping toolbars uncluttered under Liquid Glass.",
            wwdcYear: 2025,
            platforms: [.iOS],
            code: #"""
            NavigationStack { results }
                .searchable(text: $query)
                .searchToolbarBehavior(.minimize)
            """#,
            related: [".searchable()", ".toolbar()"]
        ),
    ]
}
