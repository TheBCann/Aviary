//
//  ChildExamples+Part12.swift
//  Aviary
//
//  Compiled renderings for variant entries (part 12: gen-layout).
//  One private C12_* struct per variant; every rendering exercises the exact
//  overload the variant names, so siblings can be compared side by side.
//

import SwiftUI

enum ChildExamplesPart12 {
    static let entries: [ChildExampleEntry] = [

        // MARK: .alignmentGuide()

        ChildExampleEntry(parent: ".alignmentGuide()", child: ".alignmentGuide(_ g: HorizontalAlignment, computeValue:)", code: """
        VStack(alignment: .leading) {
            Text("Heading")
            Text("Indented body")
                .alignmentGuide(.leading) { d in d[.leading] - 24 }   // reports its edge 24 pt left → shifts right
            Text("Back at the edge")
        }
        """) { AnyView(C12_AlignmentGuideHorizontalExample()) },

        ChildExampleEntry(parent: ".alignmentGuide()", child: ".alignmentGuide(_ g: VerticalAlignment, computeValue:)", code: """
        HStack(alignment: .firstTextBaseline) {
            Image(systemName: "quote.opening")
                .alignmentGuide(.firstTextBaseline) { d in d[.bottom] }   // sit the glyph's bottom on the baseline
            Text("Design is how it works.")
        }
        """) { AnyView(C12_AlignmentGuideVerticalExample()) },

        // MARK: .backgroundPreferenceValue()

        ChildExampleEntry(parent: ".backgroundPreferenceValue()", child: ".backgroundPreferenceValue(_:_:)", code: """
        rows        // each flagged row publishes 1 to FlagCountKey; reduce sums them
            .backgroundPreferenceValue(FlagCountKey.self) { count in
                RoundedRectangle(cornerRadius: 10)
                    .fill(.orange.opacity(Double(count) * 0.2))   // centered, sized to the view
            }
        """) { AnyView(C12_BackgroundPreferenceExample()) },

        ChildExampleEntry(parent: ".backgroundPreferenceValue()", child: ".backgroundPreferenceValue(_:alignment:_:)", code: """
        tabs        // the selected tab publishes its width to WidthKey
            .backgroundPreferenceValue(WidthKey.self, alignment: .topLeading) { width in
                Rectangle()
                    .fill(.yellow.opacity(0.6))
                    .frame(width: width, height: 4)   // pinned to the top-leading corner
            }
        """) { AnyView(C12_BackgroundPreferenceAlignedExample()) },

        // MARK: .contentMargins()

        ChildExampleEntry(parent: ".contentMargins()", child: ".contentMargins(_ length: CGFloat, for:)", code: """
        ScrollView {
            LazyVStack(spacing: 6) { rows }
        }
        .contentMargins(20)          // 20 pt on every edge, content and indicators
        """) { AnyView(C12_ContentMarginsLengthExample()) },

        ChildExampleEntry(parent: ".contentMargins()", child: ".contentMargins(_ edges: Edge.Set, _ length: CGFloat?, for:)", code: """
        ScrollView(.horizontal) {
            LazyHStack(spacing: 16) { cards }
        }
        .contentMargins(.horizontal, 24, for: .scrollContent)   // top and bottom untouched
        """) { AnyView(C12_ContentMarginsEdgesExample()) },

        ChildExampleEntry(parent: ".contentMargins()", child: ".contentMargins(_ edges: Edge.Set, _ insets: EdgeInsets, for:)", code: """
        ScrollView { rows }
            .contentMargins(
                .all,
                EdgeInsets(top: 32, leading: 0, bottom: 12, trailing: 0),   // room for the floating header
                for: .scrollContent)
            .overlay(alignment: .top) { floatingHeader }
        """) { AnyView(C12_ContentMarginsInsetsExample()) },

        // MARK: .contentShape()

        ChildExampleEntry(parent: ".contentShape()", child: ".contentShape(_:eoFill:)", code: """
        let ring = Path { p in
            p.addEllipse(in: CGRect(x: 0, y: 0, width: 100, height: 100))
            p.addEllipse(in: CGRect(x: 30, y: 30, width: 40, height: 40))
        }
        ring.fill(.blue, style: FillStyle(eoFill: true))
            .frame(width: 100, height: 100)
            .contentShape(ring, eoFill: true)     // the hole is excluded from hit testing too
            .onTapGesture { taps += 1 }
        """) { AnyView(C12_ContentShapeEOFillExample()) },

        ChildExampleEntry(parent: ".contentShape()", child: ".contentShape(_:_:eoFill:)", code: """
        avatar
            .contentShape([.interaction, .dragPreview], Circle())   // kinds first, then the shape
            .onTapGesture { taps += 1 }        // only the circle responds
            .draggable("Avatar")               // the lifted preview is circular
        """) { AnyView(C12_ContentShapeKindsExample()) },

        // MARK: .coordinateSpace()

        ChildExampleEntry(parent: ".coordinateSpace()", child: ".coordinateSpace(_:)", code: """
        let board = NamedCoordinateSpace.named("board")

        ZStack(alignment: .topLeading) { pieces }
            .coordinateSpace(board)
            .gesture(
                DragGesture(coordinateSpace: board)      // same typed value on both ends
                    .onChanged { location = $0.location }
            )
        """) { AnyView(C12_CoordinateSpaceTypedExample()) },

        ChildExampleEntry(parent: ".coordinateSpace()", child: ".coordinateSpace(name:)", code: """
        // Pre-iOS 17 spelling (deprecated): any Hashable name
        ScrollView { rows }
            .coordinateSpace(name: "list")
        // …read back the same way from a descendant:
        GeometryReader { proxy in
            Color.clear.preference(key: OffsetKey.self,
                                   value: proxy.frame(in: .named("list")).minY)
        }
        """) { AnyView(C12_CoordinateSpaceNameExample()) },

        // MARK: .onGeometryChange()

        ChildExampleEntry(parent: ".onGeometryChange()", child: ".onGeometryChange(for:of:action: (T) -> Void)", code: """
        tiles
            .frame(width: width)                      // driven by the slider
            .onGeometryChange(for: CGFloat.self) { proxy in
                proxy.size.width
            } action: { width in                      // only the new value
                columns = max(1, Int(width / 60))
            }
        """) { AnyView(C12_OnGeometryChangeNewValueExample()) },

        ChildExampleEntry(parent: ".onGeometryChange()", child: ".onGeometryChange(for:of:action: (T, T) -> Void)", code: """
        ScrollView {
            lines
                .onGeometryChange(for: CGFloat.self) { proxy in
                    proxy.frame(in: .scrollView).minY
                } action: { oldY, newY in             // previous and current values
                    isScrollingUp = newY > oldY
                }
        }
        """) { AnyView(C12_OnGeometryChangeOldNewExample()) },

        // MARK: .overlayPreferenceValue()

        ChildExampleEntry(parent: ".overlayPreferenceValue()", child: ".overlayPreferenceValue(_:_:)", code: """
        form        // each invalid field publishes 1 to ErrorCountKey
            .overlayPreferenceValue(ErrorCountKey.self) { count in
                if count > 0 {
                    Text("\\(count) issues").font(.caption.bold()).padding(6)
                        .background(.red, in: Capsule())   // centered over the form
                }
            }
        """) { AnyView(C12_OverlayPreferenceExample()) },

        ChildExampleEntry(parent: ".overlayPreferenceValue()", child: ".overlayPreferenceValue(_:alignment:_:)", code: """
        board       // the focused cell publishes its name to FocusKey
            .overlayPreferenceValue(FocusKey.self, alignment: .topTrailing) { name in
                if let name {
                    Text(name).font(.caption2).padding(4)
                        .background(.thinMaterial)       // anchored to the corner
                }
            }
        """) { AnyView(C12_OverlayPreferenceAlignedExample()) },

        // MARK: .safeAreaBar()

        ChildExampleEntry(parent: ".safeAreaBar()", child: ".safeAreaBar(edge: VerticalEdge, alignment:spacing:content:)", code: """
        ScrollView { messages }
            .safeAreaBar(edge: .bottom, alignment: .center, spacing: 4) {
                HStack {
                    TextField("Message", text: $draft)
                    Image(systemName: "arrow.up.circle.fill")
                }
                .padding(.horizontal)
            }
        """) { AnyView(C12_SafeAreaBarVerticalExample()) },

        ChildExampleEntry(parent: ".safeAreaBar()", child: ".safeAreaBar(edge: HorizontalEdge, alignment:spacing:content:)", code: """
        canvas
            .safeAreaBar(edge: .trailing, alignment: .top, spacing: 8) {
                VStack(spacing: 8) { toolButtons }    // a tool strip beside the canvas
                    .padding(8)
            }
        """) { AnyView(C12_SafeAreaBarHorizontalExample()) },

        // MARK: .safeAreaPadding()

        ChildExampleEntry(parent: ".safeAreaPadding()", child: ".safeAreaPadding(_ length: CGFloat)", code: """
        ScrollView { feed }
            .safeAreaPadding(16)         // all four sides
            .background(.quaternary)     // still fills under the inset; posts scroll beneath it
        """) { AnyView(C12_SafeAreaPaddingLengthExample()) },

        ChildExampleEntry(parent: ".safeAreaPadding()", child: ".safeAreaPadding(_ edges: Edge.Set, _ length: CGFloat?)", code: """
        ScrollView(.horizontal) {
            LazyHStack(spacing: 12) { cards }
        }
        .safeAreaPadding(.horizontal, 20)   // leading/trailing only
        """) { AnyView(C12_SafeAreaPaddingEdgesExample()) },

        ChildExampleEntry(parent: ".safeAreaPadding()", child: ".safeAreaPadding(_ insets: EdgeInsets)", code: """
        mapContent
            .safeAreaPadding(
                EdgeInsets(top: 0, leading: 12, bottom: 40, trailing: 12))
            .background { mapTiles }                    // extends under the inset
            .overlay(alignment: .bottom) { mockTabBar } // occupies the 40 pt bottom inset
        """) { AnyView(C12_SafeAreaPaddingInsetsExample()) },

        // MARK: .scenePadding()

        ChildExampleEntry(parent: ".scenePadding()", child: ".scenePadding(_ edges:)", code: """
        VStack(alignment: .leading) {
            header
            content
        }
        .scenePadding(.horizontal)     // the platform's scene margin, not a literal number
        """) { AnyView(C12_ScenePaddingEdgesExample()) },

        ChildExampleEntry(parent: ".scenePadding()", child: ".scenePadding(_:edges:)", code: """
        List(items) { row($0) }
            .scenePadding(.navigationBar, edges: .horizontal)   // iOS: aligns with navigation-bar content

        row.scenePadding(.minimum, edges: .horizontal)          // the style available everywhere
        """) { AnyView(C12_ScenePaddingStyleExample()) },

        // MARK: Alignment

        ChildExampleEntry(parent: "Alignment", child: "Alignment(horizontal:vertical:)", code: """
        let badgeCorner = Alignment(horizontal: .trailing, vertical: .top)

        ZStack(alignment: badgeCorner) {
            avatar
            badge
        }
        """) { AnyView(C12_AlignmentInitExample()) },

        ChildExampleEntry(parent: "Alignment", child: "Alignment.center", code: """
        VStack { ProgressView(); Text("Loading…") }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        """) { AnyView(C12_AlignmentCenterExample()) },

        ChildExampleEntry(parent: "Alignment", child: "Alignment.topLeading", code: """
        page
            .overlay(alignment: .topLeading) {
                Text("DRAFT").font(.caption.bold()).padding(4)
            }
            .environment(\\.layoutDirection, rightToLeft ? .rightToLeft : .leftToRight)
        """) { AnyView(C12_AlignmentTopLeadingExample()) },

        ChildExampleEntry(parent: "Alignment", child: "Alignment.centerFirstTextBaseline", code: """
        ZStack(alignment: .centerFirstTextBaseline) {
            Rectangle().fill(.quaternary)          // no text → its baseline guide is its bottom edge
                .frame(width: 180, height: 60)
            Text("Typography")
                .font(.system(size: 34, weight: .semibold))
        }
        """) { AnyView(C12_AlignmentCenterFirstTextBaselineExample()) },

        // MARK: Anchor

        ChildExampleEntry(parent: "Anchor", child: "Anchor.Source", code: """
        let source: Anchor<CGRect>.Source = useSubRect
            ? .rect(CGRect(x: 0, y: 0, width: 40, height: 24))   // a rect in local coordinates
            : .bounds                                             // the whole frame

        Text("Target view")
            .anchorPreference(key: BoundsKey.self, value: source) { $0 }
        """) { AnyView(C12_AnchorSourceExample()) },

        ChildExampleEntry(parent: "Anchor", child: "Anchor.Source.bounds", code: """
        Button(tabs[i]) { selected = i }
            .anchorPreference(key: TabBoundsKey.self, value: .bounds) { [i: $0] }
        // …resolved in an overlay: proxy[anchor] → CGRect for the underline
        """) { AnyView(C12_AnchorBoundsExample()) },

        ChildExampleEntry(parent: "Anchor", child: "Anchor.Source.point(_:)", code: """
        Circle()
            .frame(width: 12, height: 12)
            .anchorPreference(key: PinKey.self,
                              value: .point(CGPoint(x: 6, y: 12))) { $0 }   // bottom-center, local coords
        """) { AnyView(C12_AnchorPointExample()) },

        ChildExampleEntry(parent: "Anchor", child: "Anchor.Source.unitPoint(_:)", code: """
        sourceNode
            .anchorPreference(key: PortsKey.self, value: .unitPoint(.trailing)) { ["out": $0] }
        sinkNode
            .anchorPreference(key: PortsKey.self, value: .unitPoint(.leading)) { ["in": $0] }
        // …an overlay resolves both ports and draws the connector
        """) { AnyView(C12_AnchorUnitPointExample()) },

        // MARK: Angle

        ChildExampleEntry(parent: "Angle", child: "Angle(degrees:)", code: """
        let tilt = Angle(degrees: degrees)      // stored as degrees; .radians converts on read
        polaroid
            .rotationEffect(tilt)
        Text("\\(tilt.degrees)° = \\(tilt.radians) rad")
        """) { AnyView(C12_AngleDegreesInitExample()) },

        ChildExampleEntry(parent: "Angle", child: "Angle.degrees(_:)", code: """
        Image(systemName: "arrow.up")
            .rotationEffect(.degrees(heading))   // reads naturally inline
        Slider(value: $heading, in: 0...360)
        """) { AnyView(C12_AngleDegreesFactoryExample()) },

        ChildExampleEntry(parent: "Angle", child: "Angle.radians(_:)", code: """
        Path { p in
            p.addArc(center: CGPoint(x: 50, y: 50), radius: 40,
                     startAngle: .radians(0), endAngle: .radians(sweep),
                     clockwise: false)
        }
        .stroke(.blue, style: StrokeStyle(lineWidth: 8, lineCap: .round))
        """) { AnyView(C12_AngleRadiansExample()) },

        ChildExampleEntry(parent: "Angle", child: "Angle.zero", code: """
        @State private var spin: Angle = .zero          // the resting state

        Image(systemName: "arrow.clockwise")
            .rotationEffect(spin)
        Button(spin == .zero ? "Spin" : "Reset to .zero") {
            withAnimation { spin = spin == .zero ? .degrees(360) : .zero }
        }
        """) { AnyView(C12_AngleZeroExample()) },

        // MARK: AnyLayout

        ChildExampleEntry(parent: "AnyLayout", child: "HStackLayout", code: """
        let layout = horizontal
            ? AnyLayout(HStackLayout(alignment: .top, spacing: 8))
            : AnyLayout(VStackLayout(spacing: 8))

        layout { chips }        // same children, so identity and state survive the swap
        """) { AnyView(C12_HStackLayoutExample()) },

        ChildExampleEntry(parent: "AnyLayout", child: "VStackLayout", code: """
        let layout = vertical
            ? AnyLayout(VStackLayout(alignment: .leading, spacing: 4))
            : AnyLayout(HStackLayout(spacing: 4))

        layout { chips }
        """) { AnyView(C12_VStackLayoutExample()) },

        ChildExampleEntry(parent: "AnyLayout", child: "ZStackLayout", code: """
        let layout = stacked
            ? AnyLayout(ZStackLayout(alignment: .bottomTrailing))
            : AnyLayout(HStackLayout(alignment: .bottom, spacing: 8))

        layout { squares }
        """) { AnyView(C12_ZStackLayoutExample()) },

        ChildExampleEntry(parent: "AnyLayout", child: "GridLayout", code: """
        let layout = AnyLayout(GridLayout(alignment: .leading,
                                          horizontalSpacing: wide ? 32 : 12,
                                          verticalSpacing: 8))
        layout {
            GridRow { Text("Name"); Text("Ada Lovelace") }
            GridRow { Text("Email"); Text("ada@example.com") }
        }
        """) { AnyView(C12_GridLayoutExample()) },

        // MARK: ContainerValues

        ChildExampleEntry(parent: "ContainerValues", child: "isSectionHeader", code: """
        // Inside a custom container:
        ForEach(subviews: content) { subview in
            subview
                .font(subview.containerValues.isSectionHeader ? .headline : .body)
        }
        // Used as:  Section("Fruit") { Text("Apple"); Text("Pear") }
        """) { AnyView(C12_IsSectionHeaderExample()) },

        ChildExampleEntry(parent: "ContainerValues", child: "isSectionFooter", code: """
        ForEach(subviews: content) { subview in
            if subview.containerValues.isSectionFooter {
                subview.font(.caption).foregroundStyle(.secondary)
            } else {
                subview
            }
        }
        // Used as:  Section { rows } footer: { Text("2 items in season") }
        """) { AnyView(C12_IsSectionFooterExample()) },

        ChildExampleEntry(parent: "ContainerValues", child: "tag(for:)", code: """
        ForEach(subviews: content) { subview in
            let page = subview.containerValues.tag(for: Page.self)   // Page? — nil when untagged
            subview
                .opacity(page == selected ? 1 : 0.4)
        }
        // Children:  Label("Home", systemImage: "house").tag(Page.home)
        """) { AnyView(C12_TagForExample()) },

        ChildExampleEntry(parent: "ContainerValues", child: "hasTag(_:)", code: """
        Group(subviews: content) { subviews in
            let selected = subviews.first {
                $0.containerValues.hasTag(selection)      // true for the child tagged with `selection`
            }
            selected?.frame(maxWidth: .infinity)
        }
        """) { AnyView(C12_HasTagExample()) },

        // MARK: ContentMarginPlacement

        ChildExampleEntry(parent: "ContentMarginPlacement", child: "ContentMarginPlacement.automatic", code: """
        ScrollView { rows }
            .contentMargins(.vertical, 12, for: .automatic)   // content and indicators both inset
            .scrollIndicators(.visible)
        """) { AnyView(C12_ContentMarginAutomaticExample()) },

        ChildExampleEntry(parent: "ContentMarginPlacement", child: "ContentMarginPlacement.scrollContent", code: """
        ScrollView { articleBody }
            .contentMargins(.horizontal, 40, for: .scrollContent)   // indicators stay at the edge
            .scrollIndicators(.visible)
        """) { AnyView(C12_ContentMarginScrollContentExample()) },

        ChildExampleEntry(parent: "ContentMarginPlacement", child: "ContentMarginPlacement.scrollIndicators", code: """
        ScrollView { rows }
            .contentMargins(.trailing, 24, for: .scrollIndicators)   // only the indicator moves inward
            .scrollIndicators(.visible)
            .overlay(alignment: .trailing) { floatingControl }
        """) { AnyView(C12_ContentMarginScrollIndicatorsExample()) },

        // MARK: ContentShapeKinds

        ChildExampleEntry(parent: "ContentShapeKinds", child: "ContentShapeKinds.interaction", code: """
        HStack { Text(title); Spacer() }
            .contentShape(.interaction, Rectangle())   // whitespace in the row becomes tappable
            .onTapGesture { taps += 1 }
        """) { AnyView(C12_ContentShapeInteractionExample()) },

        ChildExampleEntry(parent: "ContentShapeKinds", child: "ContentShapeKinds.dragPreview", code: """
        photoCell
            .contentShape(.dragPreview, RoundedRectangle(cornerRadius: 12))   // the lifted preview is rounded
            .draggable("Sunset photo")
        """) { AnyView(C12_ContentShapeDragPreviewExample()) },

        ChildExampleEntry(parent: "ContentShapeKinds", child: "ContentShapeKinds.contextMenuPreview", code: """
        avatar
            .contentShape(.contextMenuPreview, Circle())   // the platter behind the open menu is round
            .contextMenu {
                Button("Message") { }
                Button("Block", role: .destructive) { }
            }
        """) { AnyView(C12_ContentShapeContextMenuPreviewExample()) },

        ChildExampleEntry(parent: "ContentShapeKinds", child: "ContentShapeKinds.hoverEffect", code: """
        Image(systemName: "gear")
            .padding(8)
            .contentShape(.hoverEffect, Circle())   // iPadOS / visionOS pointer highlight
            .hoverEffect(.highlight)
        """) { AnyView(C12_ContentShapeHoverEffectExample()) },

        // MARK: CoordinateSpace

        ChildExampleEntry(parent: "CoordinateSpace", child: "CoordinateSpace.global", code: """
        GeometryReader { proxy in
            let frame = proxy.frame(in: CoordinateSpace.global)   // relative to the window
            Text("origin x \\(frame.minX)  y \\(frame.minY)")
        }
        """) { AnyView(C12_CoordinateSpaceGlobalExample()) },

        ChildExampleEntry(parent: "CoordinateSpace", child: "CoordinateSpace.local", code: """
        GeometryReader { proxy in
            let local = proxy.frame(in: CoordinateSpace.local)   // origin is always (0, 0)
            Circle().frame(width: 12, height: 12)
                .position(x: local.midX, y: local.midY)
        }
        """) { AnyView(C12_CoordinateSpaceLocalExample()) },

        ChildExampleEntry(parent: "CoordinateSpace", child: "CoordinateSpace.named(_:)", code: """
        canvas                                    // .coordinateSpace(.named("canvas")) on the ancestor
            .gesture(
                DragGesture(minimumDistance: 0,
                            coordinateSpace: CoordinateSpace.named("canvas"))
                    .onChanged { cursor = $0.location }   // reported in the ancestor's space
            )
        """) { AnyView(C12_CoordinateSpaceNamedExample()) },

        // MARK: CoordinateSpaceProtocol

        ChildExampleEntry(parent: "CoordinateSpaceProtocol", child: "NamedCoordinateSpace", code: """
        let board: NamedCoordinateSpace = .named("board")

        boardView
            .coordinateSpace(board)
        // …a piece inside reads its frame with proxy.frame(in: board)
        """) { AnyView(C12_NamedCoordinateSpaceExample()) },

        ChildExampleEntry(parent: "CoordinateSpaceProtocol", child: "GlobalCoordinateSpace", code: """
        let space: GlobalCoordinateSpace = .global

        GeometryReader { proxy in
            let onScreen = proxy.frame(in: space)
            Text("window y: \\(Int(onScreen.minY))")
        }
        """) { AnyView(C12_GlobalCoordinateSpaceExample()) },

        ChildExampleEntry(parent: "CoordinateSpaceProtocol", child: "LocalCoordinateSpace", code: """
        let space: LocalCoordinateSpace = .local

        GeometryReader { proxy in
            let bounds = proxy.frame(in: space)
            Rectangle().path(in: bounds.insetBy(dx: 4, dy: 4))
                .stroke(.blue, style: StrokeStyle(lineWidth: 2, dash: [4]))
        }
        """) { AnyView(C12_LocalCoordinateSpaceExample()) },

        ChildExampleEntry(parent: "CoordinateSpaceProtocol", child: ".scrollView(axis:)", code: """
        card
            .onGeometryChange(for: CGFloat.self) { proxy in
                proxy.frame(in: .scrollView(axis: .horizontal)).minX   // nearest horizontal scroller
            } action: { x = $0 }
        // …the card's icon is offset by -x / 4 for a parallax effect
        """) { AnyView(C12_ScrollViewAxisSpaceExample()) },

        // MARK: Edge

        ChildExampleEntry(parent: "Edge", child: "Edge.Set", code: """
        Text("Content")
            .padding(Edge.Set.horizontal, 16)   // an OptionSet: .all, .horizontal, .vertical, [.top, .leading]…
        """) { AnyView(C12_EdgeSetExample()) },
    ]
}

// MARK: - Example views

// MARK: .alignmentGuide()

private struct C12_AlignmentGuideHorizontalExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Heading").font(.headline)
            Text("Indented body")
                .alignmentGuide(.leading) { d in d[.leading] - 24 }
            Text("Back at the edge")
        }
        .padding()
        .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
    }
}

private struct C12_AlignmentGuideVerticalExample: View {
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 6) {
            Image(systemName: "quote.opening")
                .font(.title)
                .foregroundStyle(.secondary)
                .alignmentGuide(.firstTextBaseline) { d in d[.bottom] }
            Text("Design is how it works.")
                .font(.title2)
        }
        .padding()
    }
}

// MARK: .backgroundPreferenceValue()

private struct C12_FlagCountKey: PreferenceKey {
    nonisolated static var defaultValue: Int { 0 }
    nonisolated static func reduce(value: inout Int, nextValue: () -> Int) { value += nextValue() }
}

private struct C12_BackgroundPreferenceExample: View {
    @State private var flags = [false, true, false]

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(0..<3) { i in
                Toggle("Flag row \(i + 1)", isOn: $flags[i])
                    .preference(key: C12_FlagCountKey.self, value: flags[i] ? 1 : 0)
            }
            Text("Background tint scales with the flagged count.")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
        .backgroundPreferenceValue(C12_FlagCountKey.self) { count in
            RoundedRectangle(cornerRadius: 10)
                .fill(.orange.opacity(Double(count) * 0.2))
        }
        .frame(width: 240)
    }
}

private struct C12_WidthKey: PreferenceKey {
    nonisolated static var defaultValue: CGFloat { 0 }
    nonisolated static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) { value = max(value, nextValue()) }
}

private struct C12_BackgroundPreferenceAlignedExample: View {
    @State private var selected = 1
    private let titles = ["Short", "A medium one", "The longest label"]

    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 14) {
                ForEach(titles.indices, id: \.self) { i in
                    Button(titles[i]) { selected = i }
                        .buttonStyle(.plain)
                        .fontWeight(selected == i ? .semibold : .regular)
                        .background {
                            GeometryReader { proxy in
                                Color.clear
                                    .preference(key: C12_WidthKey.self, value: selected == i ? proxy.size.width : 0)
                            }
                        }
                }
            }
            .padding(.top, 8)
            .backgroundPreferenceValue(C12_WidthKey.self, alignment: .topLeading) { width in
                Rectangle()
                    .fill(.yellow.opacity(0.6))
                    .frame(width: width, height: 4)
            }
            Text("The bar matches the selected tab's width but stays pinned top-leading.")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

// MARK: .contentMargins()

private struct C12_ContentMarginsLengthExample: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 6) {
                ForEach(1...8, id: \.self) { i in
                    Text("Row \(i)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(6)
                        .background(.quaternary, in: RoundedRectangle(cornerRadius: 6))
                }
            }
        }
        .contentMargins(20)
        .frame(width: 220, height: 140)
        .border(.secondary)
    }
}

private struct C12_ContentMarginsEdgesExample: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 16) {
                ForEach(0..<6) { i in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(hue: Double(i) / 6, saturation: 0.5, brightness: 0.9).gradient)
                        .frame(width: 90, height: 70)
                        .overlay(Text("Card \(i + 1)").font(.caption))
                }
            }
        }
        .contentMargins(.horizontal, 24, for: .scrollContent)
        .frame(width: 260, height: 100)
        .border(.secondary)
    }
}

private struct C12_ContentMarginsInsetsExample: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 4) {
                ForEach(1...10, id: \.self) { i in
                    Text("Item \(i)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(.quaternary, in: RoundedRectangle(cornerRadius: 4))
                }
            }
        }
        .contentMargins(
            .all,
            EdgeInsets(top: 32, leading: 0, bottom: 12, trailing: 0),
            for: .scrollContent)
        .overlay(alignment: .top) {
            Text("Floating header")
                .font(.caption.bold())
                .frame(maxWidth: .infinity)
                .padding(.vertical, 6)
                .background(.thinMaterial)
        }
        .frame(width: 220, height: 150)
        .border(.secondary)
    }
}

// MARK: .contentShape()

private struct C12_ContentShapeEOFillExample: View {
    @State private var taps = 0

    private var ring: Path {
        Path { p in
            p.addEllipse(in: CGRect(x: 0, y: 0, width: 100, height: 100))
            p.addEllipse(in: CGRect(x: 30, y: 30, width: 40, height: 40))
        }
    }

    var body: some View {
        VStack(spacing: 8) {
            ring.fill(.blue, style: FillStyle(eoFill: true))
                .frame(width: 100, height: 100)
                .contentShape(ring, eoFill: true)
                .onTapGesture { taps += 1 }
            Text("Ring taps: \(taps)")
                .font(.caption.monospacedDigit())
            Text("Taps in the hole are ignored (eoFill).")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

private struct C12_ContentShapeKindsExample: View {
    @State private var taps = 0

    var body: some View {
        VStack(spacing: 8) {
            Circle()
                .fill(.teal.gradient)
                .frame(width: 72, height: 72)
                .overlay(Image(systemName: "person.fill").font(.title).foregroundStyle(.white))
                .contentShape([.interaction, .dragPreview], Circle())
                .onTapGesture { taps += 1 }
                .draggable("Avatar")
            Text("Circle taps: \(taps)")
                .font(.caption.monospacedDigit())
            Text("Corners don't respond; the drag preview is round.")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

// MARK: .coordinateSpace()

private struct C12_CoordinateSpaceTypedExample: View {
    @State private var location = CGPoint(x: 60, y: 40)
    private let board = NamedCoordinateSpace.named("board")

    var body: some View {
        VStack(spacing: 6) {
            ZStack(alignment: .topLeading) {
                Rectangle().fill(.quaternary)
                Circle()
                    .fill(.blue)
                    .frame(width: 18, height: 18)
                    .position(location)
            }
            .frame(width: 220, height: 110)
            .coordinateSpace(board)
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: board)
                    .onChanged { location = $0.location }
            )
            Text(String(format: "board x: %.0f  y: %.0f", location.x, location.y))
                .font(.caption.monospacedDigit())
        }
    }
}

private struct C12_CoordinateSpaceNameExample: View {
    @State private var minY: CGFloat = 0

    var body: some View {
        VStack(spacing: 6) {
            ScrollView {
                VStack(spacing: 4) {
                    ForEach(1...12, id: \.self) { i in
                        Text("Row \(i)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(4)
                            .background(.quaternary, in: RoundedRectangle(cornerRadius: 4))
                    }
                }
                .onGeometryChange(for: CGFloat.self) { proxy in
                    proxy.frame(in: .named("list")).minY
                } action: { minY = $0 }
            }
            .coordinateSpace(.named("list"))
            .frame(width: 200, height: 100)
            .border(.secondary)
            Text(String(format: "content minY in \"list\": %.0f", minY))
                .font(.caption.monospacedDigit())
            Text("Deprecated — rendered with .coordinateSpace(.named(\"list\"))")
                .font(.caption2).foregroundStyle(.secondary)
        }
    }
}

// MARK: .onGeometryChange()

private struct C12_OnGeometryChangeNewValueExample: View {
    @State private var width: CGFloat = 200
    @State private var columns = 3

    var body: some View {
        VStack(spacing: 8) {
            Slider(value: $width, in: 80...260) { Text("Width") }
            HStack(spacing: 4) {
                ForEach(0..<columns, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 4)
                        .fill(.blue.gradient)
                        .frame(height: 40)
                }
            }
            .frame(width: width)
            .onGeometryChange(for: CGFloat.self) { proxy in
                proxy.size.width
            } action: { newWidth in
                columns = max(1, Int(newWidth / 60))
            }
            Text("\(columns) columns").font(.caption.monospacedDigit())
        }
        .frame(width: 260)
    }
}

private struct C12_OnGeometryChangeOldNewExample: View {
    @State private var isScrollingUp = false

    var body: some View {
        VStack(spacing: 6) {
            ScrollView {
                VStack(spacing: 4) {
                    ForEach(1...14, id: \.self) { i in
                        Text("Line \(i)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(4)
                            .background(.quaternary, in: RoundedRectangle(cornerRadius: 4))
                    }
                }
                .onGeometryChange(for: CGFloat.self) { proxy in
                    proxy.frame(in: .scrollView).minY
                } action: { oldY, newY in
                    isScrollingUp = newY > oldY
                }
            }
            .frame(width: 200, height: 100)
            .border(.secondary)
            Label(isScrollingUp ? "Last scroll: up" : "Last scroll: down",
                  systemImage: isScrollingUp ? "arrow.up" : "arrow.down")
                .font(.caption)
        }
    }
}

// MARK: .overlayPreferenceValue()

private struct C12_ErrorCountKey: PreferenceKey {
    nonisolated static var defaultValue: Int { 0 }
    nonisolated static func reduce(value: inout Int, nextValue: () -> Int) { value += nextValue() }
}

private struct C12_OverlayPreferenceExample: View {
    @State private var name = ""
    @State private var email = "sam@"

    var body: some View {
        VStack(spacing: 6) {
            TextField("Name", text: $name)
                .preference(key: C12_ErrorCountKey.self, value: name.isEmpty ? 1 : 0)
            TextField("Email", text: $email)
                .preference(key: C12_ErrorCountKey.self, value: email.contains("@") && email.count > 3 ? 0 : 1)
        }
        .textFieldStyle(.roundedBorder)
        .padding()
        .frame(width: 220)
        .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
        .overlayPreferenceValue(C12_ErrorCountKey.self) { count in
            if count > 0 {
                Text("\(count) issue\(count == 1 ? "" : "s")")
                    .font(.caption.bold())
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.red, in: Capsule())
                    .foregroundStyle(.white)
                    .allowsHitTesting(false)
            }
        }
    }
}

private struct C12_FocusNameKey: PreferenceKey {
    nonisolated static var defaultValue: String? { nil }
    nonisolated static func reduce(value: inout String?, nextValue: () -> String?) { value = nextValue() ?? value }
}

private struct C12_OverlayPreferenceAlignedExample: View {
    @State private var focused: String? = "Beta"
    private let names = ["Alpha", "Beta", "Gamma", "Delta"]

    var body: some View {
        HStack(spacing: 8) {
            ForEach(names, id: \.self) { name in
                Button { focused = name } label: {
                    Text(name.prefix(1))
                        .font(.headline)
                        .frame(width: 36, height: 36)
                        .background(focused == name ? Color.accentColor.opacity(0.3) : Color.clear,
                                    in: RoundedRectangle(cornerRadius: 6))
                }
                .buttonStyle(.plain)
                .preference(key: C12_FocusNameKey.self, value: focused == name ? name : nil)
            }
        }
        .padding(20)
        .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
        .overlayPreferenceValue(C12_FocusNameKey.self, alignment: .topTrailing) { name in
            if let name {
                Text(name)
                    .font(.caption2)
                    .padding(4)
                    .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 4))
                    .padding(4)
            }
        }
    }
}

// MARK: .safeAreaBar()

private struct C12_SafeAreaBarVerticalExample: View {
    @State private var draft = ""
    private let messages = ["Hi!", "Are we still on for 3?", "Yes — see you there.", "Great, bringing the slides.", "Perfect."]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 6) {
                ForEach(messages, id: \.self) { m in
                    Text(m)
                        .padding(8)
                        .background(.blue.opacity(0.15), in: RoundedRectangle(cornerRadius: 10))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)
        }
        .safeAreaBar(edge: .bottom, alignment: .center, spacing: 4) {
            HStack {
                TextField("Message", text: $draft)
                    .textFieldStyle(.roundedBorder)
                Image(systemName: "arrow.up.circle.fill")
                    .font(.title2)
                    .foregroundStyle(.blue)
            }
            .padding(.horizontal)
            .padding(.vertical, 6)
        }
        .frame(width: 240, height: 170)
        .border(.secondary)
    }
}

private struct C12_SafeAreaBarHorizontalExample: View {
    @State private var tool = "pencil"
    private let tools = ["pencil", "paintbrush", "eraser", "lasso"]

    var body: some View {
        Rectangle()
            .fill(.indigo.gradient)
            .overlay(Text("Canvas").foregroundStyle(.white))
            .safeAreaBar(edge: .trailing, alignment: .top, spacing: 8) {
                VStack(spacing: 8) {
                    ForEach(tools, id: \.self) { name in
                        Button { tool = name } label: {
                            Image(systemName: name).frame(width: 22, height: 22)
                        }
                        .buttonStyle(.bordered)
                        .tint(tool == name ? Color.accentColor : nil)
                    }
                }
                .padding(8)
            }
            .frame(width: 240, height: 160)
            .border(.secondary)
    }
}

// MARK: .safeAreaPadding()

private struct C12_SafeAreaPaddingLengthExample: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 6) {
                ForEach(1...8, id: \.self) { i in
                    Text("Post \(i)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(6)
                        .background(.background, in: RoundedRectangle(cornerRadius: 6))
                }
            }
        }
        .safeAreaPadding(16)
        .background(.quaternary)
        .frame(width: 220, height: 140)
        .border(.secondary)
    }
}

private struct C12_SafeAreaPaddingEdgesExample: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 12) {
                ForEach(0..<6) { i in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(hue: 0.55 + Double(i) * 0.05, saturation: 0.5, brightness: 0.9).gradient)
                        .frame(width: 90, height: 70)
                        .overlay(Text("Card \(i + 1)").font(.caption))
                }
            }
        }
        .safeAreaPadding(.horizontal, 20)
        .background(.quaternary)
        .frame(width: 260, height: 90)
        .border(.secondary)
    }
}

private struct C12_SafeAreaPaddingInsetsExample: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Search here")
                .font(.caption)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(.thinMaterial, in: Capsule())
        }
        .frame(maxWidth: .infinity)
        .safeAreaPadding(EdgeInsets(top: 0, leading: 12, bottom: 40, trailing: 12))
        .background {
            LinearGradient(colors: [.green.opacity(0.45), .mint.opacity(0.7)],
                           startPoint: .top, endPoint: .bottom)
        }
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(.thinMaterial)
                .frame(height: 40)
                .overlay(Text("Tab bar (40 pt)").font(.caption2))
        }
        .frame(width: 220, height: 150)
        .border(.secondary)
    }
}

// MARK: .scenePadding()

private struct C12_ScenePaddingEdgesExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Header").font(.headline)
            Text("Padded by the platform's scene margin, not a hard-coded number.")
                .font(.caption)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 8)
        .background(.quaternary)
        .scenePadding(.horizontal)
        .frame(width: 260)
        .border(.secondary)
    }
}

private struct C12_ScenePaddingStyleExample: View {
    var body: some View {
        VStack(spacing: 8) {
            Text(".padding(.horizontal)")
                .font(.caption)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 6)
                .background(.quaternary)
                .padding(.horizontal)
                .border(.secondary)
            Text(".scenePadding(.minimum, edges: .horizontal)")
                .font(.caption)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 6)
                .background(.quaternary)
                .scenePadding(.minimum, edges: .horizontal)
                .border(.secondary)
            Text("Illustrative — .navigationBar is iOS-only; rendered with .minimum")
                .font(.caption2).foregroundStyle(.secondary)
        }
        .frame(width: 280)
    }
}

// MARK: Alignment

private struct C12_AlignmentInitExample: View {
    private let badgeCorner = Alignment(horizontal: .trailing, vertical: .top)

    var body: some View {
        ZStack(alignment: badgeCorner) {
            Circle()
                .fill(.gray.gradient)
                .frame(width: 64, height: 64)
                .overlay(Image(systemName: "person.fill").font(.title).foregroundStyle(.white))
            Circle()
                .fill(.red)
                .frame(width: 20, height: 20)
                .overlay(Text("3").font(.caption2.bold()).foregroundStyle(.white))
        }
        .padding()
    }
}

private struct C12_AlignmentCenterExample: View {
    var body: some View {
        VStack(spacing: 6) {
            ProgressView()
                .controlSize(.small)
            Text("Loading…").font(.caption)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .frame(width: 220, height: 100)
        .border(.secondary)
    }
}

private struct C12_AlignmentTopLeadingExample: View {
    @State private var rightToLeft = false

    var body: some View {
        VStack(spacing: 8) {
            Rectangle()
                .fill(.quaternary)
                .frame(width: 220, height: 90)
                .overlay(alignment: .topLeading) {
                    Text("DRAFT")
                        .font(.caption.bold())
                        .padding(4)
                        .background(.yellow, in: RoundedRectangle(cornerRadius: 4))
                        .padding(4)
                }
                .environment(\.layoutDirection, rightToLeft ? .rightToLeft : .leftToRight)
            Toggle("Right-to-left layout", isOn: $rightToLeft)
                .font(.caption)
        }
    }
}

private struct C12_AlignmentCenterFirstTextBaselineExample: View {
    var body: some View {
        ZStack(alignment: .centerFirstTextBaseline) {
            Rectangle()
                .fill(.quaternary)
                .frame(width: 180, height: 60)
                .overlay(alignment: .bottom) { Rectangle().fill(.red).frame(height: 1) }
            Text("Typography")
                .font(.system(size: 34, weight: .semibold))
        }
        .padding(.bottom, 12)
    }
}

// MARK: Anchor

private struct C12_BoundsAnchorKey: PreferenceKey {
    nonisolated static var defaultValue: Anchor<CGRect>? { nil }
    nonisolated static func reduce(value: inout Anchor<CGRect>?, nextValue: () -> Anchor<CGRect>?) { value = nextValue() ?? value }
}

private struct C12_AnchorSourceExample: View {
    @State private var useSubRect = false

    var body: some View {
        let source: Anchor<CGRect>.Source = useSubRect
            ? .rect(CGRect(x: 0, y: 0, width: 40, height: 24))
            : .bounds
        VStack(spacing: 10) {
            Picker("Source", selection: $useSubRect) {
                Text(".bounds").tag(false)
                Text(".rect(…)").tag(true)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 200)
            ZStack {
                Rectangle().fill(.quaternary).frame(width: 220, height: 80)
                Text("Target view")
                    .padding(12)
                    .background(.blue.opacity(0.2), in: RoundedRectangle(cornerRadius: 6))
                    .anchorPreference(key: C12_BoundsAnchorKey.self, value: source) { $0 }
            }
            .overlayPreferenceValue(C12_BoundsAnchorKey.self) { anchor in
                GeometryReader { proxy in
                    if let anchor {
                        let r = proxy[anchor]
                        Rectangle()
                            .stroke(.red, lineWidth: 2)
                            .frame(width: r.width, height: r.height)
                            .offset(x: r.minX, y: r.minY)
                    }
                }
            }
        }
    }
}

private struct C12_TabBoundsKey: PreferenceKey {
    nonisolated static var defaultValue: [Int: Anchor<CGRect>] { [:] }
    nonisolated static func reduce(value: inout [Int: Anchor<CGRect>], nextValue: () -> [Int: Anchor<CGRect>]) {
        value.merge(nextValue()) { $1 }
    }
}

private struct C12_AnchorBoundsExample: View {
    @State private var selected = 0
    private let tabs = ["Inbox", "Sent", "Archive"]

    var body: some View {
        HStack(spacing: 20) {
            ForEach(tabs.indices, id: \.self) { i in
                Button(tabs[i]) { selected = i }
                    .buttonStyle(.plain)
                    .fontWeight(selected == i ? .semibold : .regular)
                    .anchorPreference(key: C12_TabBoundsKey.self, value: .bounds) { [i: $0] }
            }
        }
        .padding(.vertical, 10)
        .overlayPreferenceValue(C12_TabBoundsKey.self) { anchors in
            GeometryReader { proxy in
                if let anchor = anchors[selected] {
                    let r = proxy[anchor]
                    Capsule()
                        .fill(.blue)
                        .frame(width: r.width, height: 3)
                        .position(x: r.midX, y: r.maxY + 5)
                }
            }
        }
        .animation(.snappy, value: selected)
    }
}

private struct C12_PointAnchorKey: PreferenceKey {
    nonisolated static var defaultValue: Anchor<CGPoint>? { nil }
    nonisolated static func reduce(value: inout Anchor<CGPoint>?, nextValue: () -> Anchor<CGPoint>?) { value = nextValue() ?? value }
}

private struct C12_AnchorPointExample: View {
    @State private var offset: CGFloat = 60

    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .topLeading) {
                Rectangle().fill(.quaternary)
                Circle()
                    .fill(.orange)
                    .frame(width: 12, height: 12)
                    .anchorPreference(key: C12_PointAnchorKey.self,
                                      value: .point(CGPoint(x: 6, y: 12))) { $0 }
                    .padding(.leading, offset)
                    .padding(.top, 24)
            }
            .frame(width: 220, height: 80)
            .overlayPreferenceValue(C12_PointAnchorKey.self) { anchor in
                GeometryReader { proxy in
                    if let anchor {
                        let p = proxy[anchor]
                        Image(systemName: "plus")
                            .font(.caption)
                            .foregroundStyle(.red)
                            .position(p)
                        Text(String(format: "(%.0f, %.0f) in the box", p.x, p.y))
                            .font(.caption2.monospacedDigit())
                            .position(x: p.x, y: p.y + 16)
                    }
                }
            }
            Slider(value: $offset, in: 0...180).frame(width: 200)
        }
    }
}

private struct C12_PortsKey: PreferenceKey {
    nonisolated static var defaultValue: [String: Anchor<CGPoint>] { [:] }
    nonisolated static func reduce(value: inout [String: Anchor<CGPoint>], nextValue: () -> [String: Anchor<CGPoint>]) {
        value.merge(nextValue()) { $1 }
    }
}

private struct C12_AnchorUnitPointExample: View {
    var body: some View {
        HStack(alignment: .top, spacing: 60) {
            node("Source", .green)
                .anchorPreference(key: C12_PortsKey.self, value: .unitPoint(.trailing)) { ["out": $0] }
            node("Sink", .purple)
                .anchorPreference(key: C12_PortsKey.self, value: .unitPoint(.leading)) { ["in": $0] }
                .padding(.top, 40)
        }
        .padding()
        .overlayPreferenceValue(C12_PortsKey.self) { ports in
            GeometryReader { proxy in
                if let a = ports["out"], let b = ports["in"] {
                    let p0 = proxy[a]
                    let p1 = proxy[b]
                    Path { path in
                        path.move(to: p0)
                        path.addCurve(to: p1,
                                      control1: CGPoint(x: (p0.x + p1.x) / 2, y: p0.y),
                                      control2: CGPoint(x: (p0.x + p1.x) / 2, y: p1.y))
                    }
                    .stroke(.secondary, lineWidth: 2)
                    Circle().fill(.green).frame(width: 8, height: 8).position(p0)
                    Circle().fill(.purple).frame(width: 8, height: 8).position(p1)
                }
            }
        }
    }

    private func node(_ title: String, _ color: Color) -> some View {
        Text(title)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(color.opacity(0.2), in: RoundedRectangle(cornerRadius: 8))
    }
}

// MARK: Angle

private struct C12_AngleDegreesInitExample: View {
    @State private var degrees = 12.0

    var body: some View {
        let tilt = Angle(degrees: degrees)
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 4)
                .fill(.white)
                .frame(width: 84, height: 100)
                .overlay(alignment: .top) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(.orange.gradient)
                        .frame(width: 70, height: 70)
                        .padding(.top, 7)
                }
                .shadow(radius: 3)
                .rotationEffect(tilt)
            Slider(value: $degrees, in: -45...45).frame(width: 160)
            Text(String(format: "%.0f° = %.3f rad", tilt.degrees, tilt.radians))
                .font(.caption.monospacedDigit())
        }
        .padding(.top, 8)
    }
}

private struct C12_AngleDegreesFactoryExample: View {
    @State private var heading = 45.0

    var body: some View {
        VStack(spacing: 10) {
            Circle()
                .stroke(.quaternary, lineWidth: 2)
                .frame(width: 70, height: 70)
                .overlay {
                    Image(systemName: "arrow.up")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundStyle(.blue)
                        .rotationEffect(.degrees(heading))
                }
            Slider(value: $heading, in: 0...360).frame(width: 160)
            Text("heading \(Int(heading))°").font(.caption.monospacedDigit())
        }
    }
}

private struct C12_AngleRadiansExample: View {
    @State private var sweep = Double.pi * 1.25

    var body: some View {
        VStack(spacing: 10) {
            Path { p in
                p.addArc(center: CGPoint(x: 50, y: 50), radius: 40,
                         startAngle: .radians(0), endAngle: .radians(sweep),
                         clockwise: false)
            }
            .stroke(.blue, style: StrokeStyle(lineWidth: 8, lineCap: .round))
            .frame(width: 100, height: 100)
            Slider(value: $sweep, in: 0...(2 * Double.pi)).frame(width: 160)
            Text(String(format: "sweep %.2f rad (%.0f°)", sweep, Angle.radians(sweep).degrees))
                .font(.caption.monospacedDigit())
        }
    }
}

private struct C12_AngleZeroExample: View {
    @State private var spin: Angle = .zero

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "arrow.clockwise")
                .font(.system(size: 36))
                .rotationEffect(spin)
            Button(spin == .zero ? "Spin" : "Reset to .zero") {
                withAnimation(.easeInOut(duration: 0.8)) {
                    spin = spin == .zero ? .degrees(360) : .zero
                }
            }
            Text(spin == .zero ? "spin == .zero" : "spin == .degrees(360)")
                .font(.caption.monospacedDigit())
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: AnyLayout

private struct C12_LayoutChip: View {
    var title: String
    var width: CGFloat = 60
    var height: CGFloat = 32
    var color: Color = .blue

    var body: some View {
        Text(title)
            .font(.caption)
            .frame(width: width, height: height)
            .background(color.opacity(0.25), in: RoundedRectangle(cornerRadius: 6))
    }
}

private struct C12_HStackLayoutExample: View {
    @State private var horizontal = true

    var body: some View {
        let layout = horizontal
            ? AnyLayout(HStackLayout(alignment: .top, spacing: 8))
            : AnyLayout(VStackLayout(spacing: 8))
        VStack(spacing: 10) {
            Toggle("HStackLayout(alignment: .top, spacing: 8)", isOn: $horizontal)
                .font(.caption)
            layout {
                C12_LayoutChip(title: "Short", height: 28)
                C12_LayoutChip(title: "Tall", height: 56)
                C12_LayoutChip(title: "Mid", height: 40)
            }
            .animation(.snappy, value: horizontal)
        }
    }
}

private struct C12_VStackLayoutExample: View {
    @State private var vertical = true

    var body: some View {
        let layout = vertical
            ? AnyLayout(VStackLayout(alignment: .leading, spacing: 4))
            : AnyLayout(HStackLayout(spacing: 4))
        VStack(spacing: 10) {
            Toggle("VStackLayout(alignment: .leading, spacing: 4)", isOn: $vertical)
                .font(.caption)
            layout {
                C12_LayoutChip(title: "Narrow", width: 56, color: .green)
                C12_LayoutChip(title: "Much wider", width: 100, color: .green)
                C12_LayoutChip(title: "Mid", width: 76, color: .green)
            }
            .animation(.snappy, value: vertical)
        }
    }
}

private struct C12_ZStackLayoutExample: View {
    @State private var stacked = true

    var body: some View {
        let layout = stacked
            ? AnyLayout(ZStackLayout(alignment: .bottomTrailing))
            : AnyLayout(HStackLayout(alignment: .bottom, spacing: 8))
        VStack(spacing: 10) {
            Toggle("ZStackLayout(alignment: .bottomTrailing)", isOn: $stacked)
                .font(.caption)
            layout {
                RoundedRectangle(cornerRadius: 6).fill(.purple.opacity(0.35)).frame(width: 70, height: 70)
                RoundedRectangle(cornerRadius: 6).fill(.purple.opacity(0.55)).frame(width: 50, height: 50)
                RoundedRectangle(cornerRadius: 6).fill(.purple).frame(width: 30, height: 30)
            }
            .animation(.snappy, value: stacked)
        }
    }
}

private struct C12_GridLayoutExample: View {
    @State private var wide = false

    var body: some View {
        let layout = AnyLayout(GridLayout(alignment: .leading,
                                          horizontalSpacing: wide ? 32 : 12,
                                          verticalSpacing: 8))
        VStack(spacing: 10) {
            Toggle("horizontalSpacing: 32", isOn: $wide)
                .font(.caption)
            layout {
                GridRow {
                    Text("Name").foregroundStyle(.secondary)
                    Text("Ada Lovelace")
                }
                GridRow {
                    Text("Email").foregroundStyle(.secondary)
                    Text("ada@example.com")
                }
            }
            .animation(.snappy, value: wide)
        }
    }
}

// MARK: ContainerValues

private struct C12_HeaderAwareStack<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(sections: content) { section in
                section.header
                    .font(.headline)
                    .foregroundStyle(.tint)
                section.content
            }
        }
    }
}

private struct C12_IsSectionHeaderExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            C12_HeaderAwareStack {
                Section("Fruit") {
                    Text("Apple")
                    Text("Pear")
                }
                Section("Vegetables") {
                    Text("Kale")
                    Text("Leek")
                }
            }
            Text("Illustrative — isSectionHeader isn't public in this SDK; rendered with ForEach(sections:)")
                .font(.caption2).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C12_FooterAwareStack<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(sections: content) { section in
                section.content
                section.footer
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

private struct C12_IsSectionFooterExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            C12_FooterAwareStack {
                Section {
                    Text("Apple")
                    Text("Pear")
                } footer: {
                    Text("2 items in season")
                }
                Section {
                    Text("Kale")
                } footer: {
                    Text("1 item in season")
                }
            }
            Text("Illustrative — isSectionFooter isn't public in this SDK; rendered with ForEach(sections:)")
                .font(.caption2).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private enum C12_Page: String, Hashable, CaseIterable {
    case home, search, profile
}

private struct C12_PageStrip<Content: View>: View {
    var selected: C12_Page
    @ViewBuilder var content: Content

    var body: some View {
        HStack(spacing: 16) {
            ForEach(subviews: content) { subview in
                let page = subview.containerValues.tag(for: C12_Page.self)
                subview
                    .opacity(page == selected ? 1 : 0.4)
                    .overlay(alignment: .bottom) {
                        if page == selected {
                            Capsule().fill(.blue).frame(height: 3).offset(y: 6)
                        }
                    }
            }
        }
    }
}

private struct C12_TagForExample: View {
    @State private var selected: C12_Page = .search

    var body: some View {
        VStack(spacing: 16) {
            C12_PageStrip(selected: selected) {
                Label("Home", systemImage: "house").tag(C12_Page.home)
                Label("Search", systemImage: "magnifyingglass").tag(C12_Page.search)
                Label("Profile", systemImage: "person").tag(C12_Page.profile)
            }
            Picker("Selected", selection: $selected) {
                ForEach(C12_Page.allCases, id: \.self) { page in
                    Text(page.rawValue.capitalized).tag(page)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 220)
        }
    }
}

private struct C12_SelectedOnly<Content: View>: View {
    var selection: String
    @ViewBuilder var content: Content

    var body: some View {
        Group(subviews: content) { subviews in
            let selected = subviews.first {
                $0.containerValues.hasTag(selection)
            }
            selected?.frame(maxWidth: .infinity)
        }
    }
}

private struct C12_HasTagExample: View {
    @State private var selection = "Stats"

    var body: some View {
        VStack(spacing: 10) {
            Picker("Tab", selection: $selection) {
                ForEach(["Stats", "Log", "Settings"], id: \.self) { Text($0).tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 220)
            C12_SelectedOnly(selection: selection) {
                panel("Stats", "chart.bar", .blue).tag("Stats")
                panel("Log", "list.bullet", .green).tag("Log")
                panel("Settings", "gear", .orange).tag("Settings")
            }
            .frame(width: 220, height: 64)
        }
    }

    private func panel(_ title: String, _ symbol: String, _ color: Color) -> some View {
        Label(title, systemImage: symbol)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(color.opacity(0.2), in: RoundedRectangle(cornerRadius: 8))
    }
}

// MARK: ContentMarginPlacement

private struct C12_MarginRows: View {
    var count: Int = 8

    var body: some View {
        VStack(spacing: 4) {
            ForEach(1...count, id: \.self) { i in
                Text("Row \(i)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(4)
                    .background(.quaternary, in: RoundedRectangle(cornerRadius: 4))
            }
        }
    }
}

private struct C12_ContentMarginAutomaticExample: View {
    var body: some View {
        ScrollView {
            C12_MarginRows()
        }
        .contentMargins(.vertical, 12, for: .automatic)
        .scrollIndicators(.visible)
        .frame(width: 220, height: 120)
        .border(.secondary)
    }
}

private struct C12_ContentMarginScrollContentExample: View {
    var body: some View {
        ScrollView {
            C12_MarginRows()
        }
        .contentMargins(.horizontal, 40, for: .scrollContent)
        .scrollIndicators(.visible)
        .frame(width: 240, height: 120)
        .border(.secondary)
    }
}

private struct C12_ContentMarginScrollIndicatorsExample: View {
    var body: some View {
        ScrollView {
            C12_MarginRows()
        }
        .contentMargins(.trailing, 24, for: .scrollIndicators)
        .scrollIndicators(.visible)
        .overlay(alignment: .trailing) {
            Image(systemName: "plus")
                .font(.caption.bold())
                .padding(6)
                .background(.blue, in: Circle())
                .foregroundStyle(.white)
                .padding(.trailing, 4)
        }
        .frame(width: 220, height: 120)
        .border(.secondary)
    }
}

// MARK: ContentShapeKinds

private struct C12_ContentShapeInteractionExample: View {
    @State private var taps = 0

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Quarterly report.pdf")
                Spacer()
            }
            .padding(8)
            .frame(width: 220)
            .border(.secondary)
            .contentShape(.interaction, Rectangle())
            .onTapGesture { taps += 1 }
            Text("Row taps: \(taps) — the empty space counts too")
                .font(.caption.monospacedDigit())
        }
    }
}

private struct C12_ContentShapeDragPreviewExample: View {
    var body: some View {
        VStack(spacing: 8) {
            LinearGradient(colors: [.orange, .pink, .indigo], startPoint: .top, endPoint: .bottom)
                .frame(width: 120, height: 80)
                .overlay(Image(systemName: "sun.horizon.fill").font(.title).foregroundStyle(.white))
                .contentShape(.dragPreview, RoundedRectangle(cornerRadius: 12))
                .draggable("Sunset photo")
            Text("Drag it: the lifted preview has rounded corners.")
                .font(.caption).foregroundStyle(.secondary)
        }
    }
}

private struct C12_ContentShapeContextMenuPreviewExample: View {
    var body: some View {
        VStack(spacing: 8) {
            Circle()
                .fill(.mint.gradient)
                .frame(width: 64, height: 64)
                .overlay(Image(systemName: "person.fill").font(.title).foregroundStyle(.white))
                .contextMenu {
                    Button("Message") { }
                    Button("Block", role: .destructive) { }
                }
            Text("Illustrative — .contextMenuPreview is iOS-only; right-click opens the menu, the round platter appears on iOS.")
                .font(.caption2)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .frame(width: 240)
        }
    }
}

private struct C12_ContentShapeHoverEffectExample: View {
    @State private var hovering = false

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "gear")
                .font(.title2)
                .padding(8)
                .background(hovering ? Color.accentColor.opacity(0.25) : Color.clear, in: Circle())
                .onHover { hovering = $0 }
            Text("Illustrative — .hoverEffect is iPadOS/visionOS-only; a circular onHover highlight stands in.")
                .font(.caption2)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .frame(width: 230)
        }
    }
}

// MARK: CoordinateSpace

private struct C12_CoordinateSpaceGlobalExample: View {
    var body: some View {
        GeometryReader { proxy in
            let frame = proxy.frame(in: CoordinateSpace.global)
            VStack(spacing: 4) {
                Text("frame(in: .global)").font(.caption.bold())
                Text(String(format: "origin x %.0f  y %.0f", frame.minX, frame.minY))
                    .font(.caption.monospacedDigit())
                Text("Relative to the window — changes as this box moves")
                    .font(.caption2).foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(width: 250, height: 80)
        .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
    }
}

private struct C12_CoordinateSpaceLocalExample: View {
    var body: some View {
        GeometryReader { proxy in
            let local = proxy.frame(in: CoordinateSpace.local)
            Circle()
                .fill(.blue)
                .frame(width: 12, height: 12)
                .position(x: local.midX, y: local.midY)
            Text(String(format: "origin (%.0f, %.0f)  size %.0f × %.0f",
                        local.minX, local.minY, local.width, local.height))
                .font(.caption2.monospacedDigit())
                .position(x: local.midX, y: local.maxY - 12)
        }
        .frame(width: 220, height: 80)
        .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
    }
}

private struct C12_CoordinateSpaceNamedExample: View {
    @State private var cursor = CGPoint(x: 110, y: 45)

    var body: some View {
        VStack(spacing: 6) {
            ZStack(alignment: .topLeading) {
                Rectangle().fill(.quaternary)
                Rectangle()
                    .fill(.blue.opacity(0.15))
                    .padding(16)
                    .gesture(
                        DragGesture(minimumDistance: 0,
                                    coordinateSpace: CoordinateSpace.named("canvas"))
                            .onChanged { cursor = $0.location }
                    )
                Image(systemName: "scope")
                    .foregroundStyle(.red)
                    .position(cursor)
                    .allowsHitTesting(false)
            }
            .frame(width: 220, height: 90)
            .coordinateSpace(.named("canvas"))
            Text(String(format: "canvas x %.0f  y %.0f (inner area is inset 16)", cursor.x, cursor.y))
                .font(.caption.monospacedDigit())
        }
    }
}

// MARK: CoordinateSpaceProtocol

private struct C12_NamedCoordinateSpaceExample: View {
    @State private var frame = CGRect.zero
    private let board: NamedCoordinateSpace = .named("board")

    var body: some View {
        VStack(spacing: 6) {
            ZStack(alignment: .bottomTrailing) {
                Rectangle().fill(.quaternary)
                RoundedRectangle(cornerRadius: 6)
                    .fill(.orange)
                    .frame(width: 60, height: 30)
                    .overlay(Text("piece").font(.caption2))
                    .onGeometryChange(for: CGRect.self) { proxy in
                        proxy.frame(in: board)
                    } action: { frame = $0 }
                    .padding(10)
            }
            .frame(width: 220, height: 90)
            .coordinateSpace(board)
            Text(String(format: "piece in \"board\": x %.0f  y %.0f", frame.minX, frame.minY))
                .font(.caption.monospacedDigit())
        }
    }
}

private struct C12_GlobalCoordinateSpaceExample: View {
    private let space: GlobalCoordinateSpace = .global

    var body: some View {
        GeometryReader { proxy in
            let onScreen = proxy.frame(in: space)
            VStack(spacing: 4) {
                Text("GlobalCoordinateSpace").font(.caption.bold())
                Text("window x: \(Int(onScreen.minX))   y: \(Int(onScreen.minY))")
                    .font(.caption.monospacedDigit())
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(width: 240, height: 70)
        .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
    }
}

private struct C12_LocalCoordinateSpaceExample: View {
    private let space: LocalCoordinateSpace = .local

    var body: some View {
        GeometryReader { proxy in
            let bounds = proxy.frame(in: space)
            Rectangle()
                .path(in: bounds.insetBy(dx: 4, dy: 4))
                .stroke(.blue, style: StrokeStyle(lineWidth: 2, dash: [4]))
            Text(String(format: "local bounds %.0f × %.0f at (0, 0)", bounds.width, bounds.height))
                .font(.caption2.monospacedDigit())
                .position(x: bounds.midX, y: bounds.midY)
        }
        .frame(width: 220, height: 70)
        .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
    }
}

private struct C12_ParallaxCard: View {
    var index: Int
    @State private var x: CGFloat = 0

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color(hue: 0.55 + Double(index) * 0.06, saturation: 0.5, brightness: 0.9).gradient)
            .frame(width: 110, height: 80)
            .overlay {
                Image(systemName: "cloud.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.white.opacity(0.75))
                    .offset(x: -x / 4)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(alignment: .bottomLeading) {
                Text(String(format: "x %.0f", x))
                    .font(.caption2.monospacedDigit())
                    .padding(4)
            }
            .onGeometryChange(for: CGFloat.self) { proxy in
                proxy.frame(in: .scrollView(axis: .horizontal)).minX
            } action: { x = $0 }
    }
}

private struct C12_ScrollViewAxisSpaceExample: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 12) {
                ForEach(0..<6) { i in
                    C12_ParallaxCard(index: i)
                }
            }
        }
        .frame(width: 260, height: 100)
        .border(.secondary)
    }
}

// MARK: Edge

private struct C12_EdgeSetExample: View {
    @State private var choice = 1
    private let options: [(label: String, edges: Edge.Set)] = [
        ("Edge.Set.all", .all),
        ("Edge.Set.horizontal", .horizontal),
        ("Edge.Set.vertical", .vertical),
        ("[.top, .leading]", [.top, .leading]),
    ]

    var body: some View {
        VStack(spacing: 12) {
            Picker("Edges", selection: $choice) {
                ForEach(options.indices, id: \.self) { i in
                    Text(options[i].label).tag(i)
                }
            }
            .labelsHidden()
            .frame(width: 200)
            Text("Content")
                .padding(6)
                .background(.blue.opacity(0.25))
                .padding(options[choice].edges, 16)
                .background(.quaternary)
        }
    }
}

// MARK: - End of ChildExamplesPart12
