//
//  Catalog+VisualModifiers.swift
//  Swift-UI-Companion
//
//  Second wave of modifiers: geometry, drawing, scrolling, and the
//  WWDC '25 Liquid Glass additions.
//

import Foundation

extension Catalog {
    static let visualModifiers: [Topic] = [
        Topic(
            name: ".offset()",
            kind: .modifier,
            summary: "Moves a view's rendering without changing its layout.",
            discussion: "offset shifts where the view draws while siblings still see its original frame — ideal for animation and gesture feedback, wrong for actual positioning, where layout containers belong.",
            wwdcYear: 2019,
            code: #"""
            Circle()
                .offset(x: 40, y: -12)
            """#,
            demoID: "transform",
            related: [".position()", ".scaleEffect()"]
        ),
        Topic(
            name: ".position()",
            kind: .modifier,
            summary: "Centers a view at explicit coordinates in its parent.",
            discussion: "position places the view's center at a point in the parent's space and makes the view fill its parent's proposal. The quad-curve demo positions its drag handles this way inside a GeometryReader.",
            wwdcYear: 2019,
            code: #"""
            Circle()
                .frame(width: 16)
                .position(x: 120, y: 60)
            """#,
            related: [".offset()", "GeometryReader"]
        ),
        Topic(
            name: ".scaleEffect()",
            kind: .modifier,
            summary: "Scales a view's rendering around an anchor.",
            discussion: "scaleEffect multiplies the drawn size — uniformly, per-axis, or from a chosen anchor — without touching layout. A small pressed-state scale is the classic button squish.",
            wwdcYear: 2019,
            code: #"""
            Image(systemName: "heart.fill")
                .scaleEffect(isLiked ? 1.3 : 1)
                .animation(.bouncy, value: isLiked)
            """#,
            demoID: "transform",
            related: [".rotationEffect()", ".animation()"],
            children: [
                TopicChild(
                    name: "scaleEffect(_:anchor:)",
                    summary: "Uniform scaling by one factor, growing outward from the anchor.",
                    discussion: "The anchor is the fixed point of the transform — .topTrailing keeps that corner pinned while the rest of the view grows or shrinks away from it.",
                    code: #"""
                    NotificationDot()
                        .scaleEffect(isDimmed ? 0.6 : 1, anchor: .topTrailing)
                    """#
                ),
                TopicChild(
                    name: "scaleEffect(x:y:anchor:)",
                    summary: "Independent per-axis factors — squash, stretch, or mirror with a negative value.",
                    code: #"""
                    LevelBar()
                        .scaleEffect(x: 1, y: level, anchor: .bottom)
                        .animation(.easeOut(duration: 0.2), value: level)
                    """#
                ),
            ]
        ),
        Topic(
            name: ".rotationEffect()",
            kind: .modifier,
            summary: "Rotates a view's rendering in two dimensions.",
            discussion: "rotationEffect spins the drawing around an anchor point (center by default). Layout keeps the unrotated frame, so give rotated content breathing room.",
            wwdcYear: 2019,
            code: #"""
            Image(systemName: "chevron.right")
                .rotationEffect(.degrees(isExpanded ? 90 : 0))
            """#,
            demoID: "transform",
            related: [".rotation3DEffect()", ".scaleEffect()"]
        ),
        Topic(
            name: ".rotation3DEffect()",
            kind: .modifier,
            summary: "Rotates a view around an axis in 3D.",
            discussion: "rotation3DEffect tilts the view around any (x, y, z) axis with perspective — card flips and cover-flow effects. At 90 degrees the view is edge-on and invisible, the midpoint of a flip.",
            wwdcYear: 2019,
            code: #"""
            CardFront()
                .rotation3DEffect(
                    .degrees(isFlipped ? 180 : 0),
                    axis: (x: 0, y: 1, z: 0)
                )
            """#,
            related: [".rotationEffect()", ".animation()"]
        ),
        Topic(
            name: ".mask()",
            kind: .modifier,
            summary: "Clips a view by another view's alpha channel.",
            discussion: "Where clipShape cuts along a path, mask uses any view's transparency as the stencil — gradient fade-outs and text-shaped fills. Opaque pixels keep content; transparent ones erase it.",
            wwdcYear: 2019,
            code: #"""
            LinearGradient(colors: [.pink, .indigo],
                           startPoint: .leading, endPoint: .trailing)
                .mask {
                    Text("GRADIENT").font(.largeTitle.bold())
                }
            """#,
            demoID: "mask",
            related: [".clipShape()", ".opacity()"]
        ),
        Topic(
            name: ".aspectRatio()",
            kind: .modifier,
            summary: "Constrains a view's proportions while fitting or filling.",
            discussion: "aspectRatio holds a width-to-height ratio as the view fits or fills its proposal; scaledToFit and scaledToFill are its shorthands using the content's own ratio.",
            wwdcYear: 2019,
            code: #"""
            Image("poster")
                .resizable()
                .aspectRatio(2 / 3, contentMode: .fit)
            """#,
            related: [".frame()", "Image"]
        ),
        Topic(
            name: ".fixedSize()",
            kind: .modifier,
            summary: "Makes a view use its ideal size, refusing compression.",
            discussion: "fixedSize opts a view out of the proposal, per axis — the fix when text truncates instead of wrapping, or when a control should hug content inside a stretchy container. This app's demo pickers use it.",
            wwdcYear: 2019,
            code: #"""
            Text("Never truncate this label")
                .fixedSize(horizontal: false, vertical: true)
            """#,
            related: [".frame()", ".layoutPriority()"]
        ),
        Topic(
            name: ".layoutPriority()",
            kind: .modifier,
            summary: "Biases which sibling shrinks when space is tight.",
            discussion: "In a stack short on space, higher layoutPriority views get their size first and lower ones compress. Default is 0; a single 1 on the important child usually settles the fight.",
            wwdcYear: 2019,
            code: #"""
            HStack {
                Text(title).layoutPriority(1)
                Text(subtitle).lineLimit(1)
            }
            """#,
            related: [".fixedSize()", "HStack"]
        ),
        Topic(
            name: ".zIndex()",
            kind: .modifier,
            summary: "Orders overlapping siblings front to back.",
            discussion: "zIndex overrides declaration order for drawing within the same container — essential when a transitioning view must stay above its siblings for the whole animation.",
            wwdcYear: 2019,
            code: #"""
            ZStack {
                Backdrop()
                Toast().zIndex(1)
            }
            """#,
            related: ["ZStack", ".transition()"]
        ),
        Topic(
            name: ".allowsHitTesting()",
            kind: .modifier,
            summary: "Includes or excludes a view from touch handling.",
            discussion: "allowsHitTesting(false) makes a view visually present but transparent to input — decorative overlays that shouldn't swallow taps meant for content beneath.",
            wwdcYear: 2019,
            code: #"""
            content
                .overlay {
                    Vignette()
                        .allowsHitTesting(false)
                }
            """#,
            related: [".disabled()", ".overlay()"]
        ),
        Topic(
            name: ".lineLimit()",
            kind: .modifier,
            summary: "Caps or reserves the number of text lines.",
            discussion: "lineLimit bounds how many lines text may occupy, truncating past the cap; the range forms also reserve minimum space so layouts don't jump. This app's list rows cap summaries at two lines.",
            wwdcYear: 2019,
            code: #"""
            Text(review.body)
                .lineLimit(3)

            TextField("Notes", text: $notes, axis: .vertical)
                .lineLimit(2...5)
            """#,
            related: ["Text", ".multilineTextAlignment()"]
        ),
        Topic(
            name: ".multilineTextAlignment()",
            kind: .modifier,
            summary: "Aligns wrapped lines within their text block.",
            discussion: "multilineTextAlignment sets how lines sit relative to each other inside the text's own frame — it does not move the frame itself; that's the container's alignment job.",
            wwdcYear: 2019,
            code: #"""
            Text(quote)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 280)
            """#,
            related: ["Text", ".lineLimit()"]
        ),
        Topic(
            name: ".symbolRenderingMode()",
            kind: .modifier,
            summary: "Chooses how multilayer SF Symbols are colored.",
            discussion: "symbolRenderingMode selects monochrome, hierarchical, palette, or multicolor rendering for SF Symbols; palette mode then takes its colors from foregroundStyle's layers.",
            wwdcYear: 2021,
            code: #"""
            Image(systemName: "externaldrive.badge.plus")
                .symbolRenderingMode(.palette)
                .foregroundStyle(.gray, .green)
            """#,
            demoID: "symbol",
            related: [".symbolEffect()", ".foregroundStyle()", "Image"]
        ),
        Topic(
            name: ".symbolEffect()",
            kind: .modifier,
            summary: "Animates SF Symbols with built-in effects.",
            discussion: "symbolEffect plays the symbol animations introduced in 2023 — bounce, pulse, variable color — either continuously or per trigger change. Wiggle, breathe, and rotate joined at WWDC '24, and WWDC '25 added draw-on and draw-off stroke animations.",
            wwdcYear: 2023,
            code: #"""
            Image(systemName: "wifi")
                .symbolEffect(.variableColor.iterative, isActive: isScanning)

            Image(systemName: "bell")
                .symbolEffect(.bounce, value: notificationCount)
            """#,
            demoID: "symbol",
            related: [".symbolRenderingMode()", ".contentTransition()"],
            children: [
                TopicChild(
                    name: "symbolEffect(_:options:isActive:)",
                    summary: "Runs an indefinite effect for as long as isActive stays true.",
                    discussion: "For ongoing states — scanning, broadcasting, syncing — the symbol keeps animating until the flag drops, and SwiftUI winds the effect down gracefully rather than stopping mid-cycle.",
                    code: #"""
                    Image(systemName: "dot.radiowaves.left.and.right")
                        .symbolEffect(.pulse, options: .speed(1.5), isActive: isBroadcasting)
                    """#
                ),
                TopicChild(
                    name: "symbolEffect(_:options:value:)",
                    summary: "Plays a discrete effect once each time the value changes.",
                    discussion: "The trigger-style counterpart: pass a counter or any Equatable and the effect fires per change — bounce on each new message rather than pulsing forever.",
                    code: #"""
                    Image(systemName: "envelope.fill")
                        .symbolEffect(.bounce, options: .repeat(.periodic(2)), value: unreadCount)
                    """#
                ),
            ]
        ),
        Topic(
            name: ".contentTransition()",
            kind: .modifier,
            summary: "Animates a view's content change, not its frame.",
            discussion: "contentTransition describes how in-place content swaps render — numericText rolls digits like a counter, symbolEffect crossfades symbol variants — during an animated state change.",
            wwdcYear: 2022,
            code: #"""
            Text(price, format: .currency(code: "USD"))
                .contentTransition(.numericText())
                .animation(.snappy, value: price)
            """#,
            demoID: "contentTransition",
            related: [".transition()", ".animation()"]
        ),
        Topic(
            name: ".scrollTargetBehavior()",
            kind: .modifier,
            summary: "Defines where a scroll gesture may come to rest.",
            discussion: "scrollTargetBehavior makes scrolling settle by rule: paging stops per container width, viewAligned snaps to children marked with scrollTargetLayout. Custom behaviors adopt the ScrollTargetBehavior protocol.",
            wwdcYear: 2023,
            code: #"""
            ScrollView(.horizontal) {
                LazyHStack { cards }
                    .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            """#,
            related: ["ScrollView", "ScrollTargetBehavior", ".scrollPosition()"]
        ),
        Topic(
            name: ".scrollPosition()",
            kind: .modifier,
            summary: "Reads and writes the scroll offset through a binding.",
            discussion: "scrollPosition binds a ScrollPosition value so you can jump to ids, edges, or points and observe where scrolling settled — the two-way successor to ScrollViewReader.",
            wwdcYear: 2023,
            code: #"""
            @State private var position = ScrollPosition(idType: Message.ID.self)

            ScrollView { LazyVStack { messages } }
                .scrollPosition($position)

            Button("Latest") {
                position.scrollTo(edge: .bottom)
            }
            """#,
            related: ["ScrollViewReader", ".onScrollGeometryChange()"],
            children: [
                TopicChild(
                    name: "scrollPosition(_:anchor:)",
                    summary: "Binds a full ScrollPosition value for programmatic control.",
                    discussion: "The ScrollPosition type can target an id, an edge, or an exact point, and after the user drags it reports back where scrolling settled — one binding covers both directions. This ScrollPosition-binding form shipped at WWDC '24, a year after the id-based original.",
                    code: #"""
                    ScrollView { LazyVStack { rows } }
                        .scrollPosition($position)

                    Button("Top") { position.scrollTo(edge: .top) }
                    """#
                ),
                TopicChild(
                    name: "scrollPosition(id:anchor:)",
                    summary: "Tracks and drives scrolling by the id of a child in a scrollTargetLayout.",
                    discussion: "The lighter-weight form: an optional Hashable binding follows whichever child the scroll view is resting on, and writing an id scrolls there — pagination dots fall out of this almost for free.",
                    code: #"""
                    ScrollView(.horizontal) {
                        LazyHStack { pages }
                            .scrollTargetLayout()
                    }
                    .scrollPosition(id: $pageID, anchor: .center)
                    """#
                ),
            ]
        ),
        Topic(
            name: ".containerRelativeFrame()",
            kind: .modifier,
            summary: "Sizes a view as a fraction of its container.",
            discussion: "containerRelativeFrame sizes against the nearest container — scroll view, window, stack — by axis, fraction, or grid-like count and span, replacing many GeometryReader hacks. Carousel cards at 80% of the viewport are the canonical use.",
            wwdcYear: 2023,
            code: #"""
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(cards) { card in
                        CardView(card)
                            .containerRelativeFrame(.horizontal) { length, _ in
                                length * 0.8
                            }
                    }
                }
            }
            """#,
            related: ["GeometryReader", ".frame()"]
        ),
        Topic(
            name: ".visualEffect()",
            kind: .modifier,
            summary: "Applies geometry-driven effects without GeometryReader.",
            discussion: "visualEffect hands you the view's geometry and lets you return rendering effects — offset, scale, blur, hue — as a function of position. Because it can't change layout, SwiftUI evaluates it efficiently for scroll-driven effects.",
            wwdcYear: 2023,
            code: #"""
            content
                .visualEffect { effect, proxy in
                    effect.blur(radius: proxy.frame(in: .scrollView).minY < 0 ? 4 : 0)
                }
            """#,
            related: ["GeometryReader", ".onScrollGeometryChange()"]
        ),
        Topic(
            name: ".toolbarBackground()",
            kind: .modifier,
            summary: "Styles or hides the bars around a screen.",
            discussion: "toolbarBackground sets the material or color of navigation bars, tab bars, and toolbars per placement, with visibility control alongside. Under the 2025 design, prefer letting glass bars sample content unless branding demands otherwise.",
            wwdcYear: 2022,
            code: #"""
            content
                .toolbarBackground(.indigo, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
            """#,
            related: [".toolbar()", ".navigationTitle()"]
        ),
        Topic(
            name: ".glassEffect()",
            kind: .modifier,
            summary: "Renders a view on Liquid Glass material.",
            discussion: "The signature modifier of the WWDC '25 redesign: glassEffect places content on the dynamic glass material that refracts what's behind it, defaulting to a capsule shape with interactive and tinted variants. Group related glass shapes in a GlassEffectContainer so they blend.",
            wwdcYear: 2025,
            code: #"""
            Label("Now Playing", systemImage: "music.note")
                .padding()
                .glassEffect()

            Image(systemName: "plus")
                .frame(width: 56, height: 56)
                .glassEffect(.regular.tint(.blue).interactive(), in: .circle)
            """#,
            related: ["GlassEffectContainer", ".buttonStyle(.glass)", ".background()"],
            children: [
                TopicChild(
                    name: "glassEffect()",
                    summary: "The default treatment: regular glass in a capsule behind the content.",
                    code: #"""
                    Text("Paused")
                        .padding(.horizontal)
                        .glassEffect()
                    """#
                ),
                TopicChild(
                    name: "glassEffect(_:in:)",
                    summary: "Chooses the glass variant and the shape it fills.",
                    discussion: "The Glass value composes fluently — .regular.tint(.red).interactive() yields tinted glass that reacts to presses — while the shape parameter swaps the default capsule for a circle, rounded rectangle, or any Shape.",
                    code: #"""
                    Image(systemName: "mic.fill")
                        .frame(width: 52, height: 52)
                        .glassEffect(.regular.tint(.red).interactive(), in: .circle)
                    """#
                ),
                TopicChild(
                    name: "glassEffectID(_:in:)",
                    summary: "Tags a glass shape with an identity so container transitions morph.",
                    discussion: "Inside a GlassEffectContainer, shapes sharing a @Namespace can fluidly merge and split as views come and go — give each element a stable id in that namespace to opt in.",
                    code: #"""
                    GlassEffectContainer {
                        ForEach(tools) { tool in
                            ToolButton(tool)
                                .glassEffect()
                                .glassEffectID(tool.id, in: glassSpace)
                        }
                    }
                    """#
                ),
            ]
        ),
        Topic(
            name: ".backgroundExtensionEffect()",
            kind: .modifier,
            summary: "Extends imagery under adjacent bars and sidebars.",
            discussion: "New at WWDC '25: backgroundExtensionEffect mirrors and blurs a view's edges outward into neighboring safe areas — hero images bleeding under a floating sidebar without stretching the real content.",
            wwdcYear: 2025,
            platforms: [.iOS, .macOS],
            code: #"""
            Image("landscape")
                .resizable()
                .scaledToFill()
                .backgroundExtensionEffect()
            """#,
            related: [".ignoresSafeArea()", ".glassEffect()"]
        ),
        Topic(
            name: ".tabBarMinimizeBehavior()",
            kind: .modifier,
            summary: "Lets the tab bar shrink away while scrolling.",
            discussion: "Part of the 2025 design refresh: onScrollDown collapses the floating glass tab bar to its selected item as content scrolls, restoring it on scroll up — more room for content without losing orientation.",
            wwdcYear: 2025,
            platforms: [.iOS],
            code: #"""
            TabView {
                Tab("Home", systemImage: "house") { HomeView() }
                Tab("Search", systemImage: "magnifyingglass") { SearchView() }
            }
            .tabBarMinimizeBehavior(.onScrollDown)
            """#,
            related: ["TabView", ".glassEffect()"]
        ),
        Topic(
            name: ".scrollEdgeEffectStyle()",
            kind: .modifier,
            summary: "Tunes the fade where content meets glass bars.",
            discussion: "With Liquid Glass, scrolled content dissolves beneath bars via an edge effect; this modifier picks the soft blur or the hard cutoff per edge — hard suits dense tables, soft suits imagery.",
            wwdcYear: 2025,
            platforms: [.iOS, .macOS],
            code: #"""
            ScrollView { content }
                .scrollEdgeEffectStyle(.soft, for: .top)
            """#,
            related: ["ScrollView", ".glassEffect()"]
        ),
    ]
}
