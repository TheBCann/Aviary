//
//  ChildExamples+Part13.swift
//  Aviary
//
//  Compiled renderings for variant entries (part 13: gen-layout).
//  One private C13_* struct per variant; every rendering exercises the exact
//  overload the variant names, so siblings can be compared side by side.
//

import SwiftUI
import AppKit
import QuartzCore

enum ChildExamplesPart13 {
    static let entries: [ChildExampleEntry] = [

        // MARK: Edge

        ChildExampleEntry(parent: "Edge", child: "Edge.Set.horizontal", code: """
        Text("Padded on the leading and trailing edges only")
            .padding(.horizontal, 20)
            .background(.yellow.opacity(0.35))
        """) { AnyView(C13_EdgeSetHorizontalExample()) },

        ChildExampleEntry(parent: "Edge", child: "Edge.Set(_:)", code: """
        @State private var edge: Edge = .leading

        Text("Inset from one edge")
            .padding(Edge.Set(edge), 28)      // Edge → single-member Edge.Set
            .background(.blue.opacity(0.2))
        """) { AnyView(C13_EdgeSetFromEdgeExample()) },

        // MARK: EdgeInsets

        ChildExampleEntry(parent: "EdgeInsets", child: "EdgeInsets(top:leading:bottom:trailing:)", code: """
        let rowInsets = EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 12)

        HStack { Image(systemName: "tray"); Text("Inbox"); Spacer(); Text("12") }
            .padding(rowInsets)
            .background(.blue.opacity(0.12))
        """) { AnyView(C13_EdgeInsetsMemberwiseExample()) },

        ChildExampleEntry(parent: "EdgeInsets", child: "EdgeInsets()", code: """
        var insets = EdgeInsets()                 // all four edges start at 0
        if showsSidebar { insets.leading = 60 }

        Text("Content")
            .frame(maxWidth: .infinity, minHeight: 48)
            .background(.green.opacity(0.25))
            .padding(insets)
        """) { AnyView(C13_EdgeInsetsZeroExample()) },

        ChildExampleEntry(parent: "EdgeInsets", child: "EdgeInsets(_ nsEdgeInsets:)", code: """
        // The parameter is labelled nsEdgeInsets but takes AppKit's directional insets.
        let appKitInsets = NSDirectionalEdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)

        Text("Bridged from AppKit")
            .padding(EdgeInsets(appKitInsets))
            .background(.purple.opacity(0.15))
        """) { AnyView(C13_EdgeInsetsFromNSExample()) },

        // MARK: GeometryProxy

        ChildExampleEntry(parent: "GeometryProxy", child: "frame(in:)", code: """
        ScrollView {
            GeometryReader { proxy in
                let visible = proxy.frame(in: .scrollView)
                RoundedRectangle(cornerRadius: 8).fill(.blue.gradient)
                    .onChange(of: visible.minY, initial: true) { _, y in scrollMinY = y }
            }
            .frame(height: 44)
            rows
        }
        """) { AnyView(C13_GeometryFrameInExample()) },

        ChildExampleEntry(parent: "GeometryProxy", child: "safeAreaInsets", code: """
        GeometryReader { proxy in
            hero
                .padding(.top, -proxy.safeAreaInsets.top)   // slide under the header
        }
        .safeAreaInset(edge: .top) { header }
        """) { AnyView(C13_GeometrySafeAreaExample()) },

        ChildExampleEntry(parent: "GeometryProxy", child: "subscript(_ anchor:)", code: """
        tabs
            .overlayPreferenceValue(SelectedTabKey.self) { anchor in
                GeometryReader { proxy in
                    if let anchor {
                        let rect = proxy[anchor]          // Anchor<CGRect> → local CGRect
                        Capsule().fill(.blue)
                            .frame(width: rect.width, height: 3)
                            .offset(x: rect.minX, y: rect.maxY + 4)
                    }
                }
            }
        """) { AnyView(C13_GeometryAnchorExample()) },

        ChildExampleEntry(parent: "GeometryProxy", child: "bounds(of:)", code: """
        board                                    // .coordinateSpace(.named("board"))
            GeometryReader { proxy in
                if let board = proxy.bounds(of: .named("board")) {
                    Text("board origin \\(Int(board.minX)), \\(Int(board.minY))")
                }
                Text(proxy.bounds(of: .named("missing")) == nil ? "missing → nil" : "")
            }
        """) { AnyView(C13_GeometryBoundsOfExample()) },

        // MARK: GridItem

        ChildExampleEntry(parent: "GridItem", child: "GridItem.Size.fixed()", code: """
        let columns = [GridItem(.fixed(100)), GridItem(.fixed(60))]

        LazyVGrid(columns: columns, spacing: 6) {
            ForEach(0..<6) { i in cell(i) }
        }
        """) { AnyView(C13_GridFixedExample()) },

        ChildExampleEntry(parent: "GridItem", child: "GridItem.Size.flexible()", code: """
        let columns = [
            GridItem(.flexible(minimum: 40, maximum: 200)),
            GridItem(.flexible(minimum: 40, maximum: 80))     // stops growing at 80
        ]

        LazyVGrid(columns: columns, spacing: 6) { cells }
        """) { AnyView(C13_GridFlexibleExample()) },

        ChildExampleEntry(parent: "GridItem", child: "GridItem.Size.adaptive()", code: """
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80, maximum: 120))], spacing: 6) {
            ForEach(0..<8) { i in cell(i) }
        }
        .frame(width: width)          // drag the slider: cells per row follow the width
        """) { AnyView(C13_GridAdaptiveExample()) },

        ChildExampleEntry(parent: "GridItem", child: "GridItem(_:spacing:alignment:)", code: """
        let columns = [
            GridItem(.flexible(), spacing: 4, alignment: .leading),
            GridItem(.fixed(80), alignment: .trailing)
        ]

        LazyVGrid(columns: columns, spacing: 8) { cells }
        """) { AnyView(C13_GridItemInitExample()) },

        // MARK: HorizontalAlignment

        ChildExampleEntry(parent: "HorizontalAlignment", child: "HorizontalAlignment(_:)", code: """
        struct ControlStart: AlignmentID {
            static func defaultValue(in d: ViewDimensions) -> CGFloat { d[.leading] }
        }
        extension HorizontalAlignment {
            static let controlStart = HorizontalAlignment(ControlStart.self)
        }

        VStack(alignment: .controlStart) {
            HStack { Text("Name");  field.alignmentGuide(.controlStart) { $0[.leading] } }
            HStack { Text("Email address");  field.alignmentGuide(.controlStart) { $0[.leading] } }
        }
        """) { AnyView(C13_HorizontalAlignmentInitExample()) },

        ChildExampleEntry(parent: "HorizontalAlignment", child: "HorizontalAlignment.leading", code: """
        VStack(alignment: .leading, spacing: 4) {
            Text("Title").font(.headline)
            Text("Subtitle").font(.subheadline)
            Text("A longer third line").font(.caption)
        }
        // .leading is the left edge in left-to-right, the right edge in right-to-left
        """) { AnyView(C13_HorizontalLeadingExample()) },

        ChildExampleEntry(parent: "HorizontalAlignment", child: "HorizontalAlignment.listRowSeparatorLeading", code: """
        List {
            ForEach(folders, id: \\.self) { name in
                Label(name, systemImage: "folder")
                    .alignmentGuide(.listRowSeparatorLeading) { d in
                        d[.leading] + 32          // start the separator after the icon
                    }
                    .listRowSeparator(.visible)
            }
        }
        """) { AnyView(C13_ListRowSeparatorLeadingExample()) },

        ChildExampleEntry(parent: "HorizontalAlignment", child: "combined(with:)", code: """
        // SwiftUI has no HorizontalAlignment.combined(with:); pair a horizontal guide
        // with a vertical one through Alignment's memberwise initializer instead.
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
            poster
            ratingBadge
        }
        """) { AnyView(C13_HorizontalCombinedExample()) },

        // MARK: LayoutDirectionBehavior

        ChildExampleEntry(parent: "LayoutDirectionBehavior", child: "LayoutDirectionBehavior.fixed", code: """
        struct Arrow: Shape {
            var layoutDirectionBehavior: LayoutDirectionBehavior { .fixed }
            func path(in rect: CGRect) -> Path { arrowPath(rect) }
        }

        Arrow().fill(.blue)                                          // left-to-right
        Arrow().fill(.blue).environment(\\.layoutDirection, .rightToLeft)
        """) { AnyView(C13_DirectionFixedExample()) },

        ChildExampleEntry(parent: "LayoutDirectionBehavior", child: "LayoutDirectionBehavior.mirrors", code: """
        struct BackChevron: Shape {
            var layoutDirectionBehavior: LayoutDirectionBehavior { .mirrors }
            func path(in rect: CGRect) -> Path { chevronPath(rect) }
        }

        BackChevron().fill(.blue)                                    // left-to-right
        BackChevron().fill(.blue).environment(\\.layoutDirection, .rightToLeft)
        """) { AnyView(C13_DirectionMirrorsExample()) },

        ChildExampleEntry(parent: "LayoutDirectionBehavior", child: "LayoutDirectionBehavior.mirrors(in:)", code: """
        struct RTLAuthoredArrow: Shape {          // drawn pointing left = "forward" in RTL
            var layoutDirectionBehavior: LayoutDirectionBehavior {
                .mirrors(in: .leftToRight)        // so flip it for left-to-right instead
            }
            func path(in rect: CGRect) -> Path { leftArrowPath(rect) }
        }
        """) { AnyView(C13_DirectionMirrorsInExample()) },

        // MARK: LayoutSubview

        ChildExampleEntry(parent: "LayoutSubview", child: "sizeThatFits(_:)", code: """
        func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
            let sizes = subviews.map { $0.sizeThatFits(.unspecified) }   // each child's ideal size
            let width = sizes.map(\\.width).reduce(0, +) + spacing * CGFloat(max(subviews.count - 1, 0))
            return CGSize(width: width, height: sizes.map(\\.height).max() ?? 0)
        }
        """) { AnyView(C13_SubviewSizeThatFitsExample()) },

        ChildExampleEntry(parent: "LayoutSubview", child: "dimensions(in:)", code: """
        let dims = subviews.map { $0.dimensions(in: .unspecified) }
        let baselineY = bounds.minY + (dims.map { $0[.firstTextBaseline] }.max() ?? 0)
        for (subview, d) in zip(subviews, dims) {
            subview.place(at: CGPoint(x: x, y: baselineY - d[.firstTextBaseline]),
                          anchor: .topLeading, proposal: .unspecified)
            x += d.width + spacing
        }
        """) { AnyView(C13_SubviewDimensionsExample()) },

        ChildExampleEntry(parent: "LayoutSubview", child: "place(at:anchor:proposal:)", code: """
        let anchors: [UnitPoint] = [.topLeading, .center, .bottomTrailing]
        let points = [CGPoint(x: bounds.minX, y: bounds.minY),
                      CGPoint(x: bounds.midX, y: bounds.midY),
                      CGPoint(x: bounds.maxX, y: bounds.maxY)]
        for (i, subview) in subviews.enumerated() {
            subview.place(at: points[i], anchor: anchors[i], proposal: .unspecified)
        }
        """) { AnyView(C13_SubviewPlaceExample()) },

        ChildExampleEntry(parent: "LayoutSubview", child: "subscript(_ key:)", code: """
        struct Flex: LayoutValueKey { static let defaultValue: CGFloat = 1 }

        let totalFlex = subviews.reduce(0) { $0 + $1[Flex.self] }
        for subview in subviews {
            let width = available * subview[Flex.self] / totalFlex
            subview.place(at: CGPoint(x: x, y: bounds.minY), anchor: .topLeading,
                          proposal: ProposedViewSize(width: width, height: bounds.height))
            x += width + spacing
        }
        """) { AnyView(C13_SubviewLayoutValueExample()) },

        // MARK: PinnedScrollableViews

        ChildExampleEntry(parent: "PinnedScrollableViews", child: "PinnedScrollableViews.sectionHeaders", code: """
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0, pinnedViews: .sectionHeaders) {
                Section { todayRows } header: { header("Today") }
                Section { earlierRows } header: { header("Earlier") }
            }
        }
        """) { AnyView(C13_PinnedHeadersExample()) },

        ChildExampleEntry(parent: "PinnedScrollableViews", child: "PinnedScrollableViews.sectionFooters", code: """
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 48))], pinnedViews: [.sectionFooters]) {
                Section {
                    photoCells
                } footer: {
                    Text("12 photos").padding(6).frame(maxWidth: .infinity).background(.regularMaterial)
                }
            }
        }
        """) { AnyView(C13_PinnedFootersExample()) },

        // MARK: ProjectionTransform

        ChildExampleEntry(parent: "ProjectionTransform", child: "ProjectionTransform(_ m: CGAffineTransform)", code: """
        let shear = CGAffineTransform(a: 1, b: 0, c: shearAmount, d: 1, tx: 0, ty: 0)

        Text("Italic-ish")
            .font(.system(size: 34, weight: .bold))
            .projectionEffect(ProjectionTransform(shear))
        """) { AnyView(C13_ProjectionAffineExample()) },

        ChildExampleEntry(parent: "ProjectionTransform", child: "ProjectionTransform(_ m: CATransform3D)", code: """
        var t = CATransform3DIdentity
        t.m34 = -1 / 500                                   // perspective
        t = CATransform3DTranslate(t, 70, 45, 0)           // rotate about the card's centre
        t = CATransform3DRotate(t, angle * .pi / 180, 0, 1, 0)
        t = CATransform3DTranslate(t, -70, -45, 0)

        card.projectionEffect(ProjectionTransform(t))
        """) { AnyView(C13_Projection3DExample()) },

        ChildExampleEntry(parent: "ProjectionTransform", child: "concatenating(_:)", code: """
        let tilt = ProjectionTransform(CGAffineTransform(rotationAngle: 0.2))
        let shift = ProjectionTransform(CGAffineTransform(translationX: 40, y: 0))

        card.projectionEffect(tilt.concatenating(shift))   // tilt first, then shift
        """) { AnyView(C13_ProjectionConcatenatingExample()) },

        ChildExampleEntry(parent: "ProjectionTransform", child: "inverted()", code: """
        let forward = ProjectionTransform(CGAffineTransform(rotationAngle: 0.2))
        let backward = forward.inverted()

        VStack {
            Text("Tilted card")
            Text("Level label").projectionEffect(backward)  // cancels the parent's tilt
        }
        .projectionEffect(forward)
        """) { AnyView(C13_ProjectionInvertedExample()) },

        // MARK: ProposedViewSize

        ChildExampleEntry(parent: "ProposedViewSize", child: "ProposedViewSize(width:height:)", code: """
        let columnProposal = ProposedViewSize(width: columnWidth, height: nil)  // nil = "your ideal height"
        var y = bounds.minY
        for subview in subviews {
            let height = subview.sizeThatFits(columnProposal).height
            subview.place(at: CGPoint(x: bounds.minX, y: y), anchor: .topLeading, proposal: columnProposal)
            y += height + spacing
        }
        """) { AnyView(C13_ProposedWidthHeightExample()) },

        ChildExampleEntry(parent: "ProposedViewSize", child: "ProposedViewSize.unspecified", code: """
        let ideal = subviews.map { $0.sizeThatFits(.unspecified) }   // nil × nil → ideal sizes
        let tallest = ideal.map(\\.height).max() ?? 0
        for (subview, size) in zip(subviews, ideal) {
            subview.place(at: CGPoint(x: x, y: bounds.minY), anchor: .topLeading,
                          proposal: ProposedViewSize(width: size.width, height: tallest))
            x += size.width + spacing
        }
        """) { AnyView(C13_ProposedUnspecifiedExample()) },

        ChildExampleEntry(parent: "ProposedViewSize", child: "ProposedViewSize.infinity", code: """
        // Probe each child with an unbounded proposal: a shape says "infinite", text says "one line".
        let isGreedy = subviews.map { $0.sizeThatFits(.infinity).width > bounds.width }
        // greedy children split the spare width; the rest get their ideal width
        """) { AnyView(C13_ProposedInfinityExample()) },

        ChildExampleEntry(parent: "ProposedViewSize", child: "replacingUnspecifiedDimensions(by:)", code: """
        func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
            proposal.replacingUnspecifiedDimensions(by: CGSize(width: 240, height: 90))
        }

        FallbackCanvas { … }.fixedSize()                     // nil × nil → 240 × 90
        FallbackCanvas { … }.frame(width: 160, height: 60)   // concrete proposal wins
        """) { AnyView(C13_ProposedReplacingExample()) },

        // MARK: SafeAreaRegions

        ChildExampleEntry(parent: "SafeAreaRegions", child: "SafeAreaRegions.container", code: """
        ZStack {
            backdrop
                .ignoresSafeArea(.container, edges: .top)   // extend under the header only
            Text("Content stays inside the safe area")
        }
        .safeAreaInset(edge: .top) { header }
        """) { AnyView(C13_SafeAreaContainerExample()) },

        ChildExampleEntry(parent: "SafeAreaRegions", child: "SafeAreaRegions.keyboard", code: """
        chatList
            .ignoresSafeArea(.keyboard, edges: .bottom)   // don't shrink when the keyboard rises
        """) { AnyView(C13_SafeAreaKeyboardExample()) },

        ChildExampleEntry(parent: "SafeAreaRegions", child: "SafeAreaRegions.all", code: """
        ZStack {
            backdrop
                .ignoresSafeArea(.all)          // container + keyboard, every edge (the default)
            Text("Content")
        }
        .safeAreaInset(edge: .top) { header }
        .safeAreaInset(edge: .bottom) { footer }
        """) { AnyView(C13_SafeAreaAllExample()) },

        // MARK: ScrollGeometry

        ChildExampleEntry(parent: "ScrollGeometry", child: "contentOffset", code: """
        ScrollView { rows }
            .onScrollGeometryChange(for: CGFloat.self) { $0.contentOffset.y } action: { _, y in
                offsetY = y
            }
        header.opacity(max(0, 1 - offsetY / 120))
        """) { AnyView(C13_ScrollContentOffsetExample()) },

        ChildExampleEntry(parent: "ScrollGeometry", child: "contentSize", code: """
        ScrollView { rows }
            .onScrollGeometryChange(for: Bool.self) { g in
                g.contentSize.height > g.containerSize.height
            } action: { _, overflows in
                showsScrollHint = overflows
            }
        """) { AnyView(C13_ScrollContentSizeExample()) },

        ChildExampleEntry(parent: "ScrollGeometry", child: "containerSize", code: """
        ScrollView { rows }
            .onScrollGeometryChange(for: Bool.self) { g in
                g.contentOffset.y + g.containerSize.height > g.contentSize.height - 40
            } action: { _, nearEnd in
                isNearEnd = nearEnd
            }
        """) { AnyView(C13_ScrollContainerSizeExample()) },

        ChildExampleEntry(parent: "ScrollGeometry", child: "visibleRect", code: """
        ScrollView { rows }                                   // rows are 30 pt tall, 4 pt apart
            .onScrollGeometryChange(for: CGRect.self) { $0.visibleRect } action: { _, rect in
                visibleRows = (0..<rowCount).filter { rowFrame($0).intersects(rect) }
            }
        """) { AnyView(C13_ScrollVisibleRectExample()) },

        // MARK: UnitPoint

        ChildExampleEntry(parent: "UnitPoint", child: "UnitPoint(x:y:)", code: """
        poster
            .overlay {
                LinearGradient(colors: [.clear, .black],
                               startPoint: UnitPoint(x: 0.5, y: startY),   // any fraction of the bounds
                               endPoint: UnitPoint(x: 0.5, y: 1))
            }
        """) { AnyView(C13_UnitPointInitExample()) },

        ChildExampleEntry(parent: "UnitPoint", child: "UnitPoint.center", code: """
        Image(systemName: "gear")
            .rotationEffect(.degrees(angle), anchor: .center)       // spins in place (the default)

        Image(systemName: "gear")
            .rotationEffect(.degrees(angle), anchor: .topLeading)   // for comparison
        """) { AnyView(C13_UnitPointCenterExample()) },

        ChildExampleEntry(parent: "UnitPoint", child: "UnitPoint.topLeading", code: """
        card
            .scaleEffect(isPressed ? 0.85 : 1, anchor: .topLeading)   // top-left corner stays put
        """) { AnyView(C13_UnitPointTopLeadingExample()) },

        ChildExampleEntry(parent: "UnitPoint", child: "UnitPoint.bottomTrailing", code: """
        RoundedRectangle(cornerRadius: 10)
            .fill(RadialGradient(colors: [.orange, .clear],
                                 center: .bottomTrailing, startRadius: 0, endRadius: 200))
        """) { AnyView(C13_UnitPointBottomTrailingExample()) },

        // MARK: VerticalAlignment

        ChildExampleEntry(parent: "VerticalAlignment", child: "VerticalAlignment(_:)", code: """
        struct SliderTrack: AlignmentID {
            static func defaultValue(in d: ViewDimensions) -> CGFloat { d[VerticalAlignment.center] }
        }
        extension VerticalAlignment {
            static let sliderTrack = VerticalAlignment(SliderTrack.self)
        }

        HStack(alignment: .sliderTrack) {
            Text("Volume")
            VStack { caption; track.alignmentGuide(.sliderTrack) { $0[VerticalAlignment.center] }; footnote }
        }
        """) { AnyView(C13_VerticalAlignmentInitExample()) },

        ChildExampleEntry(parent: "VerticalAlignment", child: "VerticalAlignment.firstTextBaseline", code: """
        HStack(alignment: .firstTextBaseline) {
            Text("$")
            Text("1,280").font(.largeTitle)
            Text("/ month").font(.caption)
        }
        """) { AnyView(C13_VerticalFirstBaselineExample()) },

        ChildExampleEntry(parent: "VerticalAlignment", child: "VerticalAlignment.lastTextBaseline", code: """
        HStack(alignment: .lastTextBaseline) {
            Text(longDescription)          // wraps to three lines
            Button("More") { expand() }
        }
        """) { AnyView(C13_VerticalLastBaselineExample()) },

        ChildExampleEntry(parent: "VerticalAlignment", child: "combined(with:)", code: """
        // SwiftUI has no VerticalAlignment.combined(with:); pair a vertical guide with a
        // horizontal one through Alignment's memberwise initializer instead.
        Color.clear
            .overlay(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                closeButton
            }
        """) { AnyView(C13_VerticalCombinedExample()) },

        // MARK: ViewDimensions

        ChildExampleEntry(parent: "ViewDimensions", child: "width", code: """
        VStack(alignment: .leading) {
            Text("Aligned normally")
            Text("Offset by a third of its width")
                .alignmentGuide(.leading) { d in d.width / 3 }   // guide sits ⅓ of the way in
            Text("Aligned normally")
        }
        """) { AnyView(C13_DimensionsWidthExample()) },

        ChildExampleEntry(parent: "ViewDimensions", child: "subscript(_ guide: HorizontalAlignment)", code: """
        VStack(alignment: .leading) {
            Text("Aligned normally")
            Text("Hangs past the edge")
                .alignmentGuide(.leading) { d in d[.trailing] - 20 }   // read the trailing guide
            Text("Aligned normally")
        }
        """) { AnyView(C13_DimensionsHorizontalSubscriptExample()) },

        ChildExampleEntry(parent: "ViewDimensions", child: "subscript(_ guide: VerticalAlignment)", code: """
        HStack(alignment: .top) {
            Image(systemName: "info.circle.fill")
                .alignmentGuide(.top) { d in d[.firstTextBaseline] }   // remap .top to the baseline
            Text(paragraph)
                .alignmentGuide(.top) { d in d[.firstTextBaseline] }
        }
        """) { AnyView(C13_DimensionsVerticalSubscriptExample()) },

        ChildExampleEntry(parent: "ViewDimensions", child: "subscript(explicit:)", code: """
        struct AnchorLine: AlignmentID {
            static func defaultValue(in d: ViewDimensions) -> CGFloat {
                d[explicit: .firstTextBaseline] ?? d[.bottom]   // honour an override, else bottom
            }
        }

        HStack(alignment: .anchorLine) {
            Text("no override")                                            // → d[.bottom]
            swatch.alignmentGuide(.firstTextBaseline) { $0[VerticalAlignment.center] }   // → explicit
            Text("no override").font(.title)
        }
        """) { AnyView(C13_DimensionsExplicitExample()) },

        // MARK: ViewSpacing

        ChildExampleEntry(parent: "ViewSpacing", child: "ViewSpacing.zero", code: """
        struct FlushRow: Layout {
            func spacing(subviews: Subviews, cache: inout ()) -> ViewSpacing {
                .zero                       // no preferred gap to any neighbour
            }
            …
        }

        VStack { Text("Above"); FlushRow { chips }; Text("Below") }
        """) { AnyView(C13_SpacingZeroExample()) },

        ChildExampleEntry(parent: "ViewSpacing", child: "distance(to:along:)", code: """
        var x = bounds.minX
        for (i, subview) in subviews.enumerated() {
            let size = subview.sizeThatFits(.unspecified)
            subview.place(at: CGPoint(x: x, y: bounds.midY), anchor: .leading, proposal: ProposedViewSize(size))
            x += size.width
            if i + 1 < subviews.count {
                x += subview.spacing.distance(to: subviews[i + 1].spacing, along: .horizontal)
            }
        }
        """) { AnyView(C13_SpacingDistanceExample()) },

        ChildExampleEntry(parent: "ViewSpacing", child: "formUnion(_:edges:)", code: """
        func spacing(subviews: Subviews, cache: inout ()) -> ViewSpacing {
            var merged = ViewSpacing()
            for subview in subviews {
                merged.formUnion(subview.spacing, edges: .vertical)   // largest top/bottom wins
            }
            return merged
        }
        """) { AnyView(C13_SpacingFormUnionExample()) },

        ChildExampleEntry(parent: "ViewSpacing", child: "union(_:edges:)", code: """
        func spacing(subviews: Subviews, cache: inout ()) -> ViewSpacing {
            subviews.reduce(ViewSpacing.zero) {
                $0.union($1.spacing, edges: .horizontal)   // non-mutating merge, leading/trailing only
            }
        }
        """) { AnyView(C13_SpacingUnionExample()) },
    ]
}

// MARK: - Edge

private struct C13_EdgeSetHorizontalExample: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Padded on the leading and trailing edges only")
                .padding(.horizontal, 20)
                .background(.yellow.opacity(0.35))
                .border(.orange)
            Text("Compare: .padding(.vertical, 20)")
                .padding(.vertical, 20)
                .background(.yellow.opacity(0.35))
                .border(.orange)
        }
        .font(.callout)
    }
}

private struct C13_EdgeSetFromEdgeExample: View {
    @State private var edge: Edge = .leading

    var body: some View {
        VStack(spacing: 12) {
            Picker("Edge", selection: $edge) {
                Text("top").tag(Edge.top)
                Text("leading").tag(Edge.leading)
                Text("bottom").tag(Edge.bottom)
                Text("trailing").tag(Edge.trailing)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            Text("Inset from \(edgeName)")
                .padding(Edge.Set(edge), 28)
                .background(.blue.opacity(0.2))
                .border(.blue)
                .animation(.default, value: edge)
        }
    }

    private var edgeName: String {
        switch edge {
        case .top: "top"
        case .leading: "leading"
        case .bottom: "bottom"
        case .trailing: "trailing"
        }
    }
}

// MARK: - EdgeInsets

private struct C13_EdgeInsetsMemberwiseExample: View {
    private let rowInsets = EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 12)

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Image(systemName: "tray")
                Text("Inbox")
                Spacer()
                Text("12").foregroundStyle(.secondary)
            }
            .padding(rowInsets)
            .background(.blue.opacity(0.12))
            .overlay(RoundedRectangle(cornerRadius: 6).stroke(.blue.opacity(0.5)))
            Text("top 6 · leading 16 · bottom 6 · trailing 12 — leading/trailing flip in right-to-left layouts")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

private struct C13_EdgeInsetsZeroExample: View {
    @State private var showsSidebar = false

    private var insets: EdgeInsets {
        var insets = EdgeInsets()
        if showsSidebar { insets.leading = 60 }
        return insets
    }

    var body: some View {
        VStack(spacing: 10) {
            Toggle("Reserve room for a sidebar", isOn: $showsSidebar)
            Text("Content")
                .frame(maxWidth: .infinity, minHeight: 48)
                .background(.green.opacity(0.25))
                .padding(insets)
                .background(.gray.opacity(0.15))
            Text("leading inset: \(Int(insets.leading)) — every other edge stays 0")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .animation(.default, value: showsSidebar)
    }
}

private struct C13_EdgeInsetsFromNSExample: View {
    private let appKitInsets = NSDirectionalEdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)

    var body: some View {
        let bridged = EdgeInsets(appKitInsets)
        VStack(spacing: 8) {
            Text("Bridged from AppKit")
                .padding(EdgeInsets(appKitInsets))
                .background(.purple.opacity(0.15))
                .border(.purple)
            Text("AppKit leading 12 → SwiftUI leading \(Int(bridged.leading)) · trailing 12 → trailing \(Int(bridged.trailing))")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - GeometryProxy

private struct C13_GeometryFrameInExample: View {
    @State private var scrollMinY: CGFloat = 0

    var body: some View {
        VStack(spacing: 6) {
            ScrollView {
                VStack(spacing: 8) {
                    GeometryReader { proxy in
                        let visible = proxy.frame(in: .scrollView)
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.blue.gradient)
                            .overlay(Text("Tracked view").font(.caption).foregroundStyle(.white))
                            .onChange(of: visible.minY, initial: true) { _, y in scrollMinY = y }
                    }
                    .frame(height: 44)
                    ForEach(0..<6, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.gray.opacity(0.2))
                            .frame(height: 44)
                            .overlay(Text("Row \(i + 1)").font(.caption))
                    }
                }
                .padding(.horizontal, 4)
            }
            .frame(height: 130)
            .border(.gray.opacity(0.4))
            Text(String(format: "frame(in: .scrollView).minY = %.0f  ·  frame(in: .local).minY is always 0", scrollMinY))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C13_GeometrySafeAreaExample: View {
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 6) {
                Text(String(format: "safeAreaInsets.top = %.0f", proxy.safeAreaInsets.top))
                    .font(.headline)
                Text("The hero is pushed under the header by exactly that amount")
                    .font(.caption)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                LinearGradient(colors: [.orange, .pink], startPoint: .top, endPoint: .bottom)
            }
            .padding(.top, -proxy.safeAreaInsets.top)
        }
        .safeAreaInset(edge: .top) {
            Text("Header added with safeAreaInset(edge: .top)")
                .font(.caption.bold())
                .padding(8)
                .frame(maxWidth: .infinity)
                .background(.thinMaterial)
        }
        .frame(height: 170)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

private struct C13_SelectedTabKey: PreferenceKey {
    nonisolated static var defaultValue: Anchor<CGRect>? { nil }
    nonisolated static func reduce(value: inout Anchor<CGRect>?, nextValue: () -> Anchor<CGRect>?) {
        value = nextValue() ?? value
    }
}

private struct C13_GeometryAnchorExample: View {
    @State private var selected = "Photos"
    private let tabs = ["Photos", "Albums", "Shared"]

    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 24) {
                ForEach(tabs, id: \.self) { tab in
                    Text(tab)
                        .fontWeight(selected == tab ? .semibold : .regular)
                        .anchorPreference(key: C13_SelectedTabKey.self, value: .bounds) { selected == tab ? $0 : nil }
                        .onTapGesture { withAnimation(.snappy) { selected = tab } }
                }
            }
            .overlayPreferenceValue(C13_SelectedTabKey.self) { anchor in
                GeometryReader { proxy in
                    if let anchor {
                        let rect = proxy[anchor]
                        Capsule()
                            .fill(.blue)
                            .frame(width: rect.width, height: 3)
                            .offset(x: rect.minX, y: rect.maxY + 4)
                    }
                }
            }
            Text("Click a tab — the anchor is resolved into the overlay's local space")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C13_GeometryBoundsOfExample: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.indigo.opacity(0.12))
            Text("board").font(.caption2).foregroundStyle(.secondary).padding(6)
            GeometryReader { proxy in
                VStack(alignment: .leading, spacing: 4) {
                    if let board = proxy.bounds(of: .named("board")) {
                        Text(String(format: "board: origin (%.0f, %.0f), %.0f × %.0f", board.minX, board.minY, board.width, board.height))
                    }
                    Text(proxy.bounds(of: .named("missing")) == nil ? "bounds(of: .named(\"missing\")) → nil" : "unexpected")
                }
                .font(.caption.monospaced())
                .padding(8)
                .background(.background.opacity(0.85), in: RoundedRectangle(cornerRadius: 6))
            }
            .padding(EdgeInsets(top: 40, leading: 24, bottom: 12, trailing: 12))
        }
        .coordinateSpace(.named("board"))
        .frame(height: 140)
    }
}

// MARK: - GridItem

private struct C13_GridFixedExample: View {
    private let columns = [GridItem(.fixed(100)), GridItem(.fixed(60))]

    var body: some View {
        VStack(spacing: 6) {
            LazyVGrid(columns: columns, spacing: 6) {
                ForEach(0..<6, id: \.self) { i in
                    RoundedRectangle(cornerRadius: 6)
                        .fill(i.isMultiple(of: 2) ? Color.blue.opacity(0.4) : Color.orange.opacity(0.4))
                        .frame(height: 32)
                        .overlay(Text(i.isMultiple(of: 2) ? "100 pt" : "60 pt").font(.caption2))
                }
            }
            Text("Tracks keep their exact width no matter how much room is available")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C13_GridFlexibleExample: View {
    private let columns = [
        GridItem(.flexible(minimum: 40, maximum: 200)),
        GridItem(.flexible(minimum: 40, maximum: 80))
    ]

    var body: some View {
        VStack(spacing: 6) {
            LazyVGrid(columns: columns, spacing: 6) {
                ForEach(0..<4, id: \.self) { i in
                    RoundedRectangle(cornerRadius: 6)
                        .fill(i.isMultiple(of: 2) ? Color.teal.opacity(0.4) : Color.orange.opacity(0.4))
                        .frame(height: 32)
                        .overlay(Text(i.isMultiple(of: 2) ? "40…200" : "40…80").font(.caption2))
                }
            }
            Text("Both tracks share the width; the second one stops growing at 80 pt")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C13_GridAdaptiveExample: View {
    @State private var width: CGFloat = 320

    var body: some View {
        VStack(spacing: 8) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80, maximum: 120))], spacing: 6) {
                ForEach(0..<8, id: \.self) { i in
                    RoundedRectangle(cornerRadius: 6)
                        .fill(.mint.opacity(0.5))
                        .frame(height: 26)
                        .overlay(Text("\(i + 1)").font(.caption2))
                }
            }
            .frame(width: width)
            .background(.gray.opacity(0.1))
            Slider(value: $width, in: 170...360) { Text("Width") }
                .labelsHidden()
            Text(String(format: "Width %.0f pt — as many 80–120 pt cells as fit per row", width))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

private struct C13_GridItemInitExample: View {
    private let columns = [
        GridItem(.flexible(), spacing: 4, alignment: .leading),
        GridItem(.fixed(80), alignment: .trailing)
    ]

    var body: some View {
        VStack(spacing: 8) {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(["Milk", "Sourdough loaf", "Eggs"], id: \.self) { name in
                    Text(name)
                        .padding(.horizontal, 8).padding(.vertical, 4)
                        .background(.blue.opacity(0.2), in: Capsule())
                    Text("$\(name.count).50")
                        .padding(.horizontal, 8).padding(.vertical, 4)
                        .background(.orange.opacity(0.3), in: Capsule())
                }
            }
            .padding(4)
            .background(.gray.opacity(0.08))
            Text("4 pt gap after column 1 · cells lead in column 1 and trail in the 80 pt column")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - HorizontalAlignment

private struct C13_ControlStartID: AlignmentID {
    nonisolated static func defaultValue(in context: ViewDimensions) -> CGFloat { context[.leading] }
}

extension HorizontalAlignment {
    fileprivate static let c13ControlStart = HorizontalAlignment(C13_ControlStartID.self)
}

private struct C13_HorizontalAlignmentInitExample: View {
    var body: some View {
        VStack(alignment: .c13ControlStart, spacing: 8) {
            row("Name", "Ada Lovelace")
            row("Email address", "ada@example.com")
            row("Role", "Engineer")
            Text("Fields line up on the custom guide regardless of label width")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private func row(_ label: String, _ value: String) -> some View {
        HStack(spacing: 8) {
            Text(label).foregroundStyle(.secondary)
            Text(value)
                .padding(.horizontal, 8).padding(.vertical, 4)
                .background(.blue.opacity(0.15), in: RoundedRectangle(cornerRadius: 5))
                .alignmentGuide(.c13ControlStart) { $0[.leading] }
        }
    }
}

private struct C13_HorizontalLeadingExample: View {
    var body: some View {
        HStack(spacing: 24) {
            column(title: "leftToRight")
            column(title: "rightToLeft")
                .environment(\.layoutDirection, .rightToLeft)
        }
    }

    private func column(title: String) -> some View {
        VStack(spacing: 6) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Title").font(.headline)
                Text("Subtitle").font(.subheadline)
                Text("A longer third line").font(.caption)
            }
            .padding(8)
            .frame(width: 150)
            .background(.blue.opacity(0.12))
            .overlay(alignment: .leading) { Rectangle().fill(.blue).frame(width: 2) }
            Text(title).font(.caption2).foregroundStyle(.secondary)
        }
    }
}

private struct C13_ListRowSeparatorLeadingExample: View {
    var body: some View {
        VStack(spacing: 6) {
            List {
                ForEach(["Documents", "Downloads", "Pictures"], id: \.self) { name in
                    Label(name, systemImage: "folder")
                        .alignmentGuide(.listRowSeparatorLeading) { d in d[.leading] + 32 }
                        .listRowSeparator(.visible)
                }
            }
            .frame(height: 120)
            Text("Separators start 32 pt in, under the text rather than the icon")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C13_HorizontalCombinedExample: View {
    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(colors: [.indigo, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 200, height: 110)
                Text("★ 4.8")
                    .font(.caption.bold())
                    .padding(6)
                    .background(.yellow, in: Capsule())
                    .padding(8)
            }
            Text("No combined(with:) exists on HorizontalAlignment — Alignment(horizontal:vertical:) is the real pairing API")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - LayoutDirectionBehavior

private enum C13_Paths {
    nonisolated static func rightArrow(in rect: CGRect) -> Path {
        var p = Path()
        let inset = rect.height * 0.2
        p.move(to: CGPoint(x: rect.minX, y: rect.midY - inset))
        p.addLine(to: CGPoint(x: rect.midX, y: rect.midY - inset))
        p.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        p.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.midX, y: rect.midY + inset))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.midY + inset))
        p.closeSubpath()
        return p
    }

    nonisolated static func leftArrow(in rect: CGRect) -> Path {
        rightArrow(in: rect).applying(CGAffineTransform(scaleX: -1, y: 1).translatedBy(x: -rect.width, y: 0))
    }

    nonisolated static func backChevron(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.minX + rect.width * 0.35, y: rect.midY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.maxX - rect.width * 0.3, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        p.addLine(to: CGPoint(x: rect.maxX - rect.width * 0.3, y: rect.minY))
        p.closeSubpath()
        return p
    }
}

private nonisolated struct C13_FixedArrow: Shape {
    var layoutDirectionBehavior: LayoutDirectionBehavior { .fixed }
    func path(in rect: CGRect) -> Path { C13_Paths.rightArrow(in: rect) }
}

private nonisolated struct C13_MirroringChevron: Shape {
    var layoutDirectionBehavior: LayoutDirectionBehavior { .mirrors }
    func path(in rect: CGRect) -> Path { C13_Paths.backChevron(in: rect) }
}

private nonisolated struct C13_RTLAuthoredArrow: Shape {
    var layoutDirectionBehavior: LayoutDirectionBehavior { .mirrors(in: .leftToRight) }
    func path(in rect: CGRect) -> Path { C13_Paths.leftArrow(in: rect) }
}

private struct C13_DirectionPair<S: Shape>: View {
    let shape: S
    let caption: String

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 40) {
                VStack(spacing: 6) {
                    shape.fill(.blue).frame(width: 64, height: 40)
                    Text("leftToRight").font(.caption2).foregroundStyle(.secondary)
                }
                VStack(spacing: 6) {
                    shape.fill(.blue).frame(width: 64, height: 40)
                    Text("rightToLeft").font(.caption2).foregroundStyle(.secondary)
                }
                .environment(\.layoutDirection, .rightToLeft)
            }
            Text(caption).font(.caption).foregroundStyle(.secondary)
        }
    }
}

private struct C13_DirectionFixedExample: View {
    var body: some View {
        C13_DirectionPair(shape: C13_FixedArrow(), caption: ".fixed — identical path in both layout directions")
    }
}

private struct C13_DirectionMirrorsExample: View {
    var body: some View {
        C13_DirectionPair(shape: C13_MirroringChevron(), caption: ".mirrors — flipped horizontally under right-to-left")
    }
}

private struct C13_DirectionMirrorsInExample: View {
    var body: some View {
        C13_DirectionPair(shape: C13_RTLAuthoredArrow(), caption: ".mirrors(in: .leftToRight) — the RTL-authored arrow flips for LTR, not RTL")
    }
}

// MARK: - LayoutSubview

private nonisolated struct C13_MeasuredRow: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let width = sizes.map(\.width).reduce(0, +) + spacing * CGFloat(max(subviews.count - 1, 0))
        return CGSize(width: width, height: sizes.map(\.height).max() ?? 0)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            subview.place(at: CGPoint(x: x, y: bounds.midY), anchor: .leading, proposal: ProposedViewSize(size))
            x += size.width + spacing
        }
    }
}

private struct C13_SubviewSizeThatFitsExample: View {
    @State private var measuredWidth: CGFloat = 0

    var body: some View {
        VStack(spacing: 10) {
            C13_MeasuredRow(spacing: 8) {
                chip("Short", .blue)
                chip("A medium chip", .teal)
                chip("The longest chip here", .orange)
            }
            .onGeometryChange(for: CGFloat.self) { $0.size.width } action: { measuredWidth = $0 }
            .background(.gray.opacity(0.12))
            Text(String(format: "Layout width = ideal widths + 2 × 8 pt spacing = %.0f pt", measuredWidth))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private func chip(_ text: String, _ color: Color) -> some View {
        Text(text)
            .font(.caption)
            .padding(.horizontal, 8).padding(.vertical, 4)
            .background(color.opacity(0.25), in: Capsule())
    }
}

private nonisolated struct C13_BaselineRow: Layout {
    var spacing: CGFloat = 10

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let dims = subviews.map { $0.dimensions(in: .unspecified) }
        let width = dims.map(\.width).reduce(0, +) + spacing * CGFloat(max(subviews.count - 1, 0))
        let above = dims.map { $0[.firstTextBaseline] }.max() ?? 0
        let below = dims.map { $0.height - $0[.firstTextBaseline] }.max() ?? 0
        return CGSize(width: width, height: above + below)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let dims = subviews.map { $0.dimensions(in: .unspecified) }
        let baselineY = bounds.minY + (dims.map { $0[.firstTextBaseline] }.max() ?? 0)
        var x = bounds.minX
        for (subview, d) in zip(subviews, dims) {
            subview.place(at: CGPoint(x: x, y: baselineY - d[.firstTextBaseline]),
                          anchor: .topLeading, proposal: .unspecified)
            x += d.width + spacing
        }
    }
}

private struct C13_SubviewDimensionsExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C13_BaselineRow(spacing: 10) {
                Text("$").font(.caption)
                Text("1,280").font(.system(size: 40, weight: .bold))
                Text("/ month").font(.body)
                Text("billed yearly").font(.caption2).foregroundStyle(.secondary)
            }
            .background(.gray.opacity(0.12))
            Text("Each child's dimensions(in:) exposes its firstTextBaseline guide, so the layout lines them up")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

private nonisolated struct C13_AnchorPlacement: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions(by: CGSize(width: 260, height: 120))
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let anchors: [UnitPoint] = [.topLeading, .center, .bottomTrailing]
        let points = [CGPoint(x: bounds.minX, y: bounds.minY),
                      CGPoint(x: bounds.midX, y: bounds.midY),
                      CGPoint(x: bounds.maxX, y: bounds.maxY)]
        for (i, subview) in subviews.enumerated() where i < anchors.count {
            subview.place(at: points[i], anchor: anchors[i], proposal: .unspecified)
        }
    }
}

private struct C13_SubviewPlaceExample: View {
    var body: some View {
        C13_AnchorPlacement {
            tag("anchor: .topLeading", .blue)
            tag("anchor: .center", .purple)
            tag("anchor: .bottomTrailing", .orange)
        }
        .frame(width: 260, height: 120)
        .border(.gray.opacity(0.5))
    }

    private func tag(_ text: String, _ color: Color) -> some View {
        Text(text)
            .font(.caption)
            .padding(6)
            .background(color.opacity(0.3), in: RoundedRectangle(cornerRadius: 6))
    }
}

private struct C13_FlexKey: LayoutValueKey {
    nonisolated static let defaultValue: CGFloat = 1
}

private nonisolated struct C13_FlexRow: Layout {
    var spacing: CGFloat = 6

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let height = subviews.map { $0.sizeThatFits(.unspecified).height }.max() ?? 0
        return CGSize(width: proposal.width ?? 300, height: height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let totalFlex = max(subviews.reduce(0) { $0 + $1[C13_FlexKey.self] }, 1)
        let available = bounds.width - spacing * CGFloat(max(subviews.count - 1, 0))
        var x = bounds.minX
        for subview in subviews {
            let width = available * subview[C13_FlexKey.self] / totalFlex
            subview.place(at: CGPoint(x: x, y: bounds.minY), anchor: .topLeading,
                          proposal: ProposedViewSize(width: width, height: bounds.height))
            x += width + spacing
        }
    }
}

private struct C13_SubviewLayoutValueExample: View {
    var body: some View {
        VStack(spacing: 8) {
            C13_FlexRow(spacing: 6) {
                cell("flex 1", .blue)
                cell("flex 2", .purple)
                    .layoutValue(key: C13_FlexKey.self, value: 2)
                cell("default (1)", .teal)
            }
            .frame(height: 40)
            Text("subview[Flex.self] reads the value set with .layoutValue(key:value:), or the key's default")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }

    private func cell(_ text: String, _ color: Color) -> some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(color.opacity(0.35))
            .overlay(Text(text).font(.caption))
    }
}

// MARK: - PinnedScrollableViews

private struct C13_PinnedHeadersExample: View {
    var body: some View {
        VStack(spacing: 6) {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0, pinnedViews: .sectionHeaders) {
                    Section {
                        ForEach(1...4, id: \.self) { i in row("Message \(i)") }
                    } header: { header("Today") }
                    Section {
                        ForEach(1...4, id: \.self) { i in row("Older message \(i)") }
                    } header: { header("Earlier") }
                }
            }
            .frame(height: 150)
            .border(.gray.opacity(0.3))
            Text("Scroll — each header sticks to the top until the next one pushes it away")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private func header(_ title: String) -> some View {
        Text(title)
            .font(.caption.bold())
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 10).padding(.vertical, 6)
            .background(.regularMaterial)
    }

    private func row(_ text: String) -> some View {
        Text(text).padding(.horizontal, 10).padding(.vertical, 8)
    }
}

private struct C13_PinnedFootersExample: View {
    var body: some View {
        VStack(spacing: 6) {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 48))], spacing: 6, pinnedViews: [.sectionFooters]) {
                    Section {
                        ForEach(0..<12, id: \.self) { i in
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color(hue: Double(i) / 12, saturation: 0.5, brightness: 0.9))
                                .frame(height: 48)
                        }
                    } footer: {
                        Text("12 photos")
                            .font(.caption.bold())
                            .padding(6)
                            .frame(maxWidth: .infinity)
                            .background(.regularMaterial)
                    }
                }
                .padding(.horizontal, 6)
            }
            .frame(height: 150)
            .border(.gray.opacity(0.3))
            Text("The footer stays pinned to the bottom edge while its section is on screen")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - ProjectionTransform

private struct C13_ProjectionAffineExample: View {
    @State private var shearAmount: CGFloat = -0.25

    var body: some View {
        let shear = CGAffineTransform(a: 1, b: 0, c: shearAmount, d: 1, tx: 0, ty: 0)
        VStack(spacing: 12) {
            Text("Italic-ish")
                .font(.system(size: 34, weight: .bold))
                .projectionEffect(ProjectionTransform(shear))
                .frame(height: 50)
            Slider(value: $shearAmount, in: -0.5...0.5) { Text("Shear") }
                .labelsHidden()
                .frame(width: 200)
            Text(String(format: "CGAffineTransform c = %.2f, lifted into a 3×3 ProjectionTransform", shearAmount))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C13_Projection3DExample: View {
    @State private var angle: Double = 30

    private var transform: ProjectionTransform {
        var t = CATransform3DIdentity
        t.m34 = -1 / 500
        t = CATransform3DTranslate(t, 70, 45, 0)
        t = CATransform3DRotate(t, angle * .pi / 180, 0, 1, 0)
        t = CATransform3DTranslate(t, -70, -45, 0)
        return ProjectionTransform(t)
    }

    var body: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.blue.gradient)
                .frame(width: 140, height: 90)
                .overlay(Text("Card").foregroundStyle(.white).bold())
                .projectionEffect(transform)
            Slider(value: $angle, in: -60...60) { Text("Angle") }
                .labelsHidden()
                .frame(width: 200)
            Text(String(format: "Y rotation %.0f° with m34 perspective, flattened by ProjectionTransform(CATransform3D)", angle))
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

private struct C13_ProjectionConcatenatingExample: View {
    var body: some View {
        let tilt = ProjectionTransform(CGAffineTransform(rotationAngle: 0.2))
        let shift = ProjectionTransform(CGAffineTransform(translationX: 40, y: 0))
        VStack(spacing: 10) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [4]))
                    .foregroundStyle(.secondary)
                    .frame(width: 120, height: 60)
                    .overlay(Text("original").font(.caption2).foregroundStyle(.secondary))
                RoundedRectangle(cornerRadius: 8)
                    .fill(.orange.opacity(0.8))
                    .frame(width: 120, height: 60)
                    .overlay(Text("tilt → shift").font(.caption))
                    .projectionEffect(tilt.concatenating(shift))
            }
            .frame(width: 220, height: 100, alignment: .topLeading)
            Text("The product applies tilt first, then shift, in one projection")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C13_ProjectionInvertedExample: View {
    var body: some View {
        let forward = ProjectionTransform(CGAffineTransform(rotationAngle: 0.2))
        let backward = forward.inverted()
        VStack(spacing: 10) {
            VStack(spacing: 8) {
                Text("Tilted card").font(.headline)
                Text("Level label")
                    .font(.caption)
                    .padding(4)
                    .background(.yellow, in: RoundedRectangle(cornerRadius: 4))
                    .projectionEffect(backward)
            }
            .padding(14)
            .background(.indigo.opacity(0.25), in: RoundedRectangle(cornerRadius: 10))
            .projectionEffect(forward)
            .frame(width: 220, height: 110)
            Text("forward.inverted() cancels the parent's rotation for one child")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - ProposedViewSize

private nonisolated struct C13_ColumnLayout: Layout {
    var columnWidth: CGFloat
    var spacing: CGFloat = 6

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let columnProposal = ProposedViewSize(width: columnWidth, height: nil)
        let heights = subviews.map { $0.sizeThatFits(columnProposal).height }
        return CGSize(width: columnWidth,
                      height: heights.reduce(0, +) + spacing * CGFloat(max(subviews.count - 1, 0)))
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let columnProposal = ProposedViewSize(width: columnWidth, height: nil)
        var y = bounds.minY
        for subview in subviews {
            let height = subview.sizeThatFits(columnProposal).height
            subview.place(at: CGPoint(x: bounds.minX, y: y), anchor: .topLeading, proposal: columnProposal)
            y += height + spacing
        }
    }
}

private struct C13_ProposedWidthHeightExample: View {
    @State private var columnWidth: CGFloat = 180

    var body: some View {
        VStack(spacing: 8) {
            C13_ColumnLayout(columnWidth: columnWidth) {
                Text("Each child is proposed the column width and nil height, so text wraps to fit and reports its own height.")
                    .font(.caption)
                    .padding(6)
                    .background(.blue.opacity(0.15))
                Text("A second paragraph, shorter.")
                    .font(.caption)
                    .padding(6)
                    .background(.teal.opacity(0.2))
            }
            .frame(height: 110, alignment: .top)
            Slider(value: $columnWidth, in: 120...300) { Text("Column width") }
                .labelsHidden()
                .frame(width: 200)
            Text(String(format: "ProposedViewSize(width: %.0f, height: nil)", columnWidth))
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
    }
}

private nonisolated struct C13_TallestRow: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let ideal = subviews.map { $0.sizeThatFits(.unspecified) }
        let width = ideal.map(\.width).reduce(0, +) + spacing * CGFloat(max(subviews.count - 1, 0))
        return CGSize(width: width, height: ideal.map(\.height).max() ?? 0)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let ideal = subviews.map { $0.sizeThatFits(.unspecified) }
        let tallest = ideal.map(\.height).max() ?? 0
        var x = bounds.minX
        for (subview, size) in zip(subviews, ideal) {
            subview.place(at: CGPoint(x: x, y: bounds.minY), anchor: .topLeading,
                          proposal: ProposedViewSize(width: size.width, height: tallest))
            x += size.width + spacing
        }
    }
}

private struct C13_ProposedUnspecifiedExample: View {
    var body: some View {
        VStack(spacing: 8) {
            C13_TallestRow(spacing: 8) {
                card("One line", .blue)
                card("Two lines of wrapped text here", .purple)
                card("Three lines: the tallest ideal size sets the row", .orange)
            }
            Text("Every child is measured with .unspecified, then stretched to the tallest ideal height")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }

    private func card(_ text: String, _ color: Color) -> some View {
        Text(text)
            .font(.caption)
            .frame(width: 84)
            .padding(6)
            .frame(maxHeight: .infinity)
            .background(color.opacity(0.25), in: RoundedRectangle(cornerRadius: 6))
    }
}

private nonisolated struct C13_GreedyAwareRow: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let height = subviews.map { $0.sizeThatFits(.unspecified).height }.max() ?? 0
        return CGSize(width: proposal.width ?? 300, height: height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let isGreedy = subviews.map { $0.sizeThatFits(.infinity).width > bounds.width }
        var fixedWidth: CGFloat = 0
        var greedyCount = 0
        for (subview, greedy) in zip(subviews, isGreedy) {
            if greedy { greedyCount += 1 } else { fixedWidth += subview.sizeThatFits(.unspecified).width }
        }
        let spare = bounds.width - fixedWidth - spacing * CGFloat(max(subviews.count - 1, 0))
        let greedyWidth = greedyCount > 0 ? max(spare / CGFloat(greedyCount), 0) : 0
        var x = bounds.minX
        for (subview, greedy) in zip(subviews, isGreedy) {
            let width = greedy ? greedyWidth : subview.sizeThatFits(.unspecified).width
            subview.place(at: CGPoint(x: x, y: bounds.midY), anchor: .leading,
                          proposal: ProposedViewSize(width: width, height: bounds.height))
            x += width + spacing
        }
    }
}

private struct C13_ProposedInfinityExample: View {
    var body: some View {
        VStack(spacing: 8) {
            C13_GreedyAwareRow(spacing: 8) {
                Text("Label").font(.callout)
                Capsule()
                    .fill(.blue.opacity(0.3))
                    .frame(height: 24)
                    .overlay(Text("greedy: sizeThatFits(.infinity).width = ∞").font(.caption2))
                Text("Trailing").font(.callout)
            }
            .padding(.horizontal, 8)
            Text("Text answers .infinity with its one-line width; the capsule answers with an unbounded width and takes the spare room")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

private nonisolated struct C13_FallbackCanvas: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions(by: CGSize(width: 240, height: 90))
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        for subview in subviews {
            subview.place(at: CGPoint(x: bounds.midX, y: bounds.midY), anchor: .center, proposal: .unspecified)
        }
    }
}

private struct C13_ProposedReplacingExample: View {
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(spacing: 4) {
                C13_FallbackCanvas { Text("240 × 90").font(.caption) }
                    .fixedSize()
                    .background(.green.opacity(0.25))
                Text(".fixedSize() → nil × nil → fallback").font(.caption2).foregroundStyle(.secondary)
            }
            VStack(spacing: 4) {
                C13_FallbackCanvas { Text("160 × 60").font(.caption) }
                    .frame(width: 160, height: 60)
                    .background(.orange.opacity(0.25))
                Text(".frame(160, 60) → proposal kept").font(.caption2).foregroundStyle(.secondary)
            }
        }
    }
}

// MARK: - SafeAreaRegions

private struct C13_SafeAreaContainerExample: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.teal, .blue], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.container, edges: .top)
            Text("Content stays inside the safe area")
                .foregroundStyle(.white)
                .font(.callout)
        }
        .safeAreaInset(edge: .top) {
            Text("Header — the backdrop runs underneath")
                .font(.caption.bold())
                .padding(8)
                .frame(maxWidth: .infinity)
                .background(.thinMaterial)
        }
        .frame(height: 150)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

private struct C13_SafeAreaKeyboardExample: View {
    var body: some View {
        VStack(spacing: 8) {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 6) {
                    bubble("Running late?", .gray.opacity(0.3), .leading)
                    bubble("5 min away", .blue.opacity(0.7), .trailing)
                    bubble("Ordering for you", .gray.opacity(0.3), .leading)
                }
                .padding(8)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea(.keyboard, edges: .bottom)
                VStack(spacing: 3) {
                    ForEach(0..<3, id: \.self) { row in
                        HStack(spacing: 3) {
                            ForEach(0..<(9 - row), id: \.self) { _ in
                                RoundedRectangle(cornerRadius: 2).fill(.white).frame(width: 12, height: 10)
                            }
                        }
                    }
                }
                .padding(6)
                .frame(maxWidth: .infinity)
                .background(.gray.opacity(0.35))
            }
            .frame(width: 180, height: 140)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(.gray))
            Text("Illustrative — the keyboard region only exists on iOS; there the list keeps its size under the keyboard")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }

    private func bubble(_ text: String, _ color: Color, _ side: Alignment) -> some View {
        Text(text)
            .font(.caption2)
            .padding(.horizontal, 8).padding(.vertical, 4)
            .background(color, in: Capsule())
            .frame(maxWidth: .infinity, alignment: side)
    }
}

private struct C13_SafeAreaAllExample: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.pink, .orange], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)
            Text("Content")
                .foregroundStyle(.white)
                .font(.callout)
        }
        .safeAreaInset(edge: .top) { bar("Header") }
        .safeAreaInset(edge: .bottom) { bar("Footer") }
        .frame(height: 160)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    private func bar(_ title: String) -> some View {
        Text(title)
            .font(.caption.bold())
            .padding(6)
            .frame(maxWidth: .infinity)
            .background(.thinMaterial)
    }
}

// MARK: - ScrollGeometry

private struct C13_ScrollRows: View {
    var count: Int = 20

    var body: some View {
        LazyVStack(spacing: 4) {
            ForEach(0..<count, id: \.self) { i in
                RoundedRectangle(cornerRadius: 6)
                    .fill(i.isMultiple(of: 2) ? Color.gray.opacity(0.15) : Color.gray.opacity(0.25))
                    .frame(height: 30)
                    .overlay(Text("Row \(i + 1)").font(.caption))
            }
        }
        .padding(.horizontal, 6)
    }
}

private struct C13_ScrollContentOffsetExample: View {
    @State private var offsetY: CGFloat = 0

    var body: some View {
        VStack(spacing: 6) {
            ZStack(alignment: .top) {
                ScrollView {
                    C13_ScrollRows().padding(.top, 36)
                }
                .onScrollGeometryChange(for: CGFloat.self) { $0.contentOffset.y } action: { _, y in
                    offsetY = y
                }
                Text("Header fades as you scroll")
                    .font(.caption.bold())
                    .foregroundStyle(.white)
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .opacity(max(0, 1 - offsetY / 120))
            }
            .frame(height: 140)
            .border(.gray.opacity(0.3))
            Text(String(format: "contentOffset.y = %.0f", offsetY))
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
    }
}

private struct C13_ScrollContentSizeExample: View {
    @State private var rowCount = 3
    @State private var showsScrollHint = false

    var body: some View {
        VStack(spacing: 6) {
            Picker("Rows", selection: $rowCount) {
                Text("3 rows").tag(3)
                Text("12 rows").tag(12)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            ScrollView {
                C13_ScrollRows(count: rowCount)
            }
            .onScrollGeometryChange(for: Bool.self) { g in
                g.contentSize.height > g.containerSize.height
            } action: { _, overflows in
                showsScrollHint = overflows
            }
            .frame(height: 110)
            .border(.gray.opacity(0.3))
            .overlay(alignment: .bottomTrailing) {
                if showsScrollHint {
                    Image(systemName: "chevron.down.circle.fill")
                        .foregroundStyle(.blue)
                        .padding(6)
                }
            }
            Text(showsScrollHint ? "contentSize.height exceeds the container → scroll hint shown" : "content fits → no hint")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C13_ScrollContainerSizeExample: View {
    @State private var isNearEnd = false

    var body: some View {
        VStack(spacing: 6) {
            ScrollView {
                C13_ScrollRows(count: 14)
            }
            .onScrollGeometryChange(for: Bool.self) { g in
                g.contentOffset.y + g.containerSize.height > g.contentSize.height - 40
            } action: { _, nearEnd in
                isNearEnd = nearEnd
            }
            .frame(height: 130)
            .border(.gray.opacity(0.3))
            HStack(spacing: 6) {
                Image(systemName: isNearEnd ? "arrow.down.circle.fill" : "arrow.down.circle")
                    .foregroundStyle(isNearEnd ? .green : .secondary)
                Text(isNearEnd ? "Bottom edge within 40 pt of the end → load more" : "Scroll to the end to trigger loading")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
    }
}

private struct C13_ScrollVisibleRectExample: View {
    @State private var visibleRows: [Int] = []
    private let rowCount = 20

    private func rowFrame(_ index: Int) -> CGRect {
        CGRect(x: 0, y: CGFloat(index) * 34, width: 1, height: 30)
    }

    var body: some View {
        VStack(spacing: 6) {
            ScrollView {
                C13_ScrollRows(count: rowCount)
            }
            .onScrollGeometryChange(for: CGRect.self) { $0.visibleRect } action: { _, rect in
                visibleRows = (0..<rowCount).filter { rowFrame($0).intersects(rect) }
            }
            .frame(height: 130)
            .border(.gray.opacity(0.3))
            Text(visibleRows.isEmpty
                 ? "visibleRect: —"
                 : "visibleRect covers rows \((visibleRows.first ?? 0) + 1)–\((visibleRows.last ?? 0) + 1)")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - UnitPoint

private struct C13_UnitPointInitExample: View {
    @State private var startY: CGFloat = 0.6

    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.orange.gradient)
                .frame(width: 220, height: 90)
                .overlay {
                    LinearGradient(colors: [.clear, .black],
                                   startPoint: UnitPoint(x: 0.5, y: startY),
                                   endPoint: UnitPoint(x: 0.5, y: 1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .overlay(alignment: .bottomLeading) {
                    Text("Caption over the scrim").font(.caption).foregroundStyle(.white).padding(8)
                }
            Slider(value: $startY, in: 0...1) { Text("Start y") }
                .labelsHidden()
                .frame(width: 200)
            Text(String(format: "startPoint: UnitPoint(x: 0.5, y: %.2f)", startY))
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
        }
    }
}

private struct C13_UnitPointCenterExample: View {
    @State private var angle: Double = 30

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 48) {
                anchored("anchor: .center", anchor: .center, marker: .center)
                anchored("anchor: .topLeading", anchor: .topLeading, marker: .topLeading)
            }
            Slider(value: $angle, in: 0...360) { Text("Angle") }
                .labelsHidden()
                .frame(width: 200)
            Text("The red dot marks the anchor; .center is the default for rotation and scale")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private func anchored(_ label: String, anchor: UnitPoint, marker: Alignment) -> some View {
        VStack(spacing: 6) {
            Image(systemName: "gear")
                .font(.system(size: 44))
                .foregroundStyle(.blue)
                .rotationEffect(.degrees(angle), anchor: anchor)
                .overlay(alignment: marker) { Circle().fill(.red).frame(width: 6, height: 6) }
                .frame(width: 64, height: 64)
            Text(label).font(.caption2).foregroundStyle(.secondary)
        }
    }
}

private struct C13_UnitPointTopLeadingExample: View {
    @State private var isPressed = false

    var body: some View {
        VStack(spacing: 10) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [4]))
                    .foregroundStyle(.secondary)
                    .frame(width: 180, height: 80)
                RoundedRectangle(cornerRadius: 10)
                    .fill(.blue.gradient)
                    .frame(width: 180, height: 80)
                    .overlay(Text("Card").foregroundStyle(.white).bold())
                    .scaleEffect(isPressed ? 0.85 : 1, anchor: .topLeading)
                    .animation(.snappy, value: isPressed)
                Circle().fill(.red).frame(width: 6, height: 6)
            }
            Toggle("Pressed", isOn: $isPressed)
                .toggleStyle(.switch)
            Text("Scaling about .topLeading keeps the top-left corner fixed; the dashed box is the original frame")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

private struct C13_UnitPointBottomTrailingExample: View {
    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 10)
                .fill(RadialGradient(colors: [.orange, .clear],
                                     center: .bottomTrailing, startRadius: 0, endRadius: 200))
                .frame(width: 240, height: 100)
                .background(.indigo.opacity(0.2), in: RoundedRectangle(cornerRadius: 10))
                .overlay(alignment: .bottomTrailing) { Circle().fill(.red).frame(width: 6, height: 6).padding(4) }
            Text("The gradient radiates from UnitPoint(x: 1, y: 1), the far corner")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - VerticalAlignment

private struct C13_SliderTrackID: AlignmentID {
    nonisolated static func defaultValue(in context: ViewDimensions) -> CGFloat { context[VerticalAlignment.center] }
}

extension VerticalAlignment {
    fileprivate static let c13SliderTrack = VerticalAlignment(C13_SliderTrackID.self)
}

private struct C13_VerticalAlignmentInitExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .c13SliderTrack, spacing: 12) {
                Text("Volume")
                    .font(.callout)
                    .padding(.horizontal, 8).padding(.vertical, 4)
                    .background(.yellow.opacity(0.4), in: RoundedRectangle(cornerRadius: 5))
                VStack(alignment: .leading, spacing: 6) {
                    Text("Output level").font(.caption).foregroundStyle(.secondary)
                    Capsule()
                        .fill(.blue.opacity(0.5))
                        .frame(width: 160, height: 8)
                        .alignmentGuide(.c13SliderTrack) { $0[VerticalAlignment.center] }
                    Text("Adjusts every connected speaker").font(.caption2).foregroundStyle(.secondary)
                }
            }
            .padding(8)
            .background(.gray.opacity(0.1))
            Text("The label centres on the track, not on the whole column, thanks to the custom guide")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

private struct C13_VerticalFirstBaselineExample: View {
    var body: some View {
        VStack(spacing: 12) {
            VStack(spacing: 4) {
                HStack(alignment: .firstTextBaseline, spacing: 2) {
                    Text("$")
                    Text("1,280").font(.largeTitle)
                    Text("/ month").font(.caption)
                }
                .padding(.horizontal, 10)
                .background(.green.opacity(0.15))
                Text(".firstTextBaseline").font(.caption2).foregroundStyle(.secondary)
            }
            VStack(spacing: 4) {
                HStack(alignment: .center, spacing: 2) {
                    Text("$")
                    Text("1,280").font(.largeTitle)
                    Text("/ month").font(.caption)
                }
                .padding(.horizontal, 10)
                .background(.gray.opacity(0.12))
                Text(".center, for comparison").font(.caption2).foregroundStyle(.secondary)
            }
        }
    }
}

private struct C13_VerticalLastBaselineExample: View {
    @State private var expanded = false

    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .lastTextBaseline, spacing: 12) {
                Text("A longer caption that wraps onto several lines so the last baseline sits well below the first.")
                    .font(.callout)
                    .frame(width: 200, alignment: .leading)
                Button(expanded ? "Less" : "More") { expanded.toggle() }
            }
            .padding(8)
            .background(.gray.opacity(0.1))
            Text("The button's baseline lines up with the caption's final line")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C13_VerticalCombinedExample: View {
    var body: some View {
        VStack(spacing: 8) {
            Color.clear
                .frame(width: 220, height: 100)
                .background(.indigo.opacity(0.2), in: RoundedRectangle(cornerRadius: 10))
                .overlay(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                        .padding(6)
                }
            Text("No combined(with:) exists on VerticalAlignment — Alignment(horizontal:vertical:) is the real pairing API")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - ViewDimensions

private struct C13_DimensionsWidthExample: View {
    var body: some View {
        VStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 6) {
                row("Aligned normally", .blue)
                row("Offset by a third of its width", .orange)
                    .alignmentGuide(.leading) { d in d.width / 3 }
                row("Aligned normally", .blue)
            }
            .padding(8)
            .background(.gray.opacity(0.1))
            Text("The orange row's .leading guide is moved to d.width / 3, so it slides left by that much")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }

    private func row(_ text: String, _ color: Color) -> some View {
        Text(text).font(.callout).padding(6).background(color.opacity(0.2))
    }
}

private struct C13_DimensionsHorizontalSubscriptExample: View {
    var body: some View {
        VStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 6) {
                row("Aligned normally", .blue)
                row("Hangs past the edge", .orange)
                    .alignmentGuide(.leading) { d in d[.trailing] - 20 }
                row("Aligned normally", .blue)
            }
            .padding(8)
            .background(.gray.opacity(0.1))
            Text("d[.trailing] reads the row's own trailing guide; only its last 20 pt overlap the others")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }

    private func row(_ text: String, _ color: Color) -> some View {
        Text(text).font(.callout).padding(6).background(color.opacity(0.2))
    }
}

private struct C13_DimensionsVerticalSubscriptExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: "info.circle.fill")
                    .font(.title2)
                    .foregroundStyle(.blue)
                    .alignmentGuide(.top) { d in d[.firstTextBaseline] }
                Text("Both views remap .top to d[.firstTextBaseline], so the icon sits on the first line's baseline even though the text wraps.")
                    .font(.callout)
                    .frame(width: 220, alignment: .leading)
                    .alignmentGuide(.top) { d in d[.firstTextBaseline] }
            }
            .padding(8)
            .background(.gray.opacity(0.1))
            Text("Reading a text-aware guide from ViewDimensions")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C13_AnchorLineID: AlignmentID {
    nonisolated static func defaultValue(in context: ViewDimensions) -> CGFloat {
        context[explicit: .firstTextBaseline] ?? context[.bottom]
    }
}

extension VerticalAlignment {
    fileprivate static let c13AnchorLine = VerticalAlignment(C13_AnchorLineID.self)
}

private struct C13_DimensionsExplicitExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .c13AnchorLine, spacing: 12) {
                Text("no override")
                    .padding(6)
                    .background(.gray.opacity(0.2))
                RoundedRectangle(cornerRadius: 6)
                    .fill(.orange.opacity(0.5))
                    .frame(width: 60, height: 50)
                    .overlay(Text("explicit").font(.caption2))
                    .alignmentGuide(.firstTextBaseline) { $0[VerticalAlignment.center] }
                Text("no override")
                    .font(.title)
                    .padding(6)
                    .background(.gray.opacity(0.2))
            }
            .padding(8)
            .background(.gray.opacity(0.1))
            Text("The texts fall back to d[.bottom]; the swatch overrode .firstTextBaseline, so d[explicit:] returns its centre")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - ViewSpacing

private enum C13_RowMath {
    nonisolated static func size(of subviews: LayoutSubviews, gap: CGFloat) -> CGSize {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let width = sizes.map(\.width).reduce(0, +) + gap * CGFloat(max(subviews.count - 1, 0))
        return CGSize(width: width, height: sizes.map(\.height).max() ?? 0)
    }

    nonisolated static func place(_ subviews: LayoutSubviews, in bounds: CGRect, gap: CGFloat) {
        var x = bounds.minX
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            subview.place(at: CGPoint(x: x, y: bounds.midY), anchor: .leading, proposal: ProposedViewSize(size))
            x += size.width + gap
        }
    }
}

private nonisolated struct C13_FlushRow: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        C13_RowMath.size(of: subviews, gap: 4)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        C13_RowMath.place(subviews, in: bounds, gap: 4)
    }

    func spacing(subviews: Subviews, cache: inout ()) -> ViewSpacing {
        .zero
    }
}

private struct C13_SpacingZeroExample: View {
    var body: some View {
        HStack(alignment: .top, spacing: 32) {
            VStack(spacing: 4) {
                VStack {
                    Text("Above")
                    HStack(spacing: 4) { chips }
                    Text("Below")
                }
                .padding(6)
                .background(.gray.opacity(0.1))
                Text("HStack — system spacing").font(.caption2).foregroundStyle(.secondary)
            }
            VStack(spacing: 4) {
                VStack {
                    Text("Above")
                    C13_FlushRow { chips }
                    Text("Below")
                }
                .padding(6)
                .background(.gray.opacity(0.1))
                Text("FlushRow — spacing() returns .zero").font(.caption2).foregroundStyle(.secondary)
            }
        }
    }

    @ViewBuilder private var chips: some View {
        ForEach(["A", "B", "C"], id: \.self) { name in
            Text(name).font(.caption).padding(6).background(.blue.opacity(0.3), in: RoundedRectangle(cornerRadius: 4))
        }
    }
}

private nonisolated struct C13_PreferredGapRow: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for (i, subview) in subviews.enumerated() {
            let size = subview.sizeThatFits(.unspecified)
            width += size.width
            height = max(height, size.height)
            if i + 1 < subviews.count {
                width += subview.spacing.distance(to: subviews[i + 1].spacing, along: .horizontal)
            }
        }
        return CGSize(width: width, height: height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX
        for (i, subview) in subviews.enumerated() {
            let size = subview.sizeThatFits(.unspecified)
            subview.place(at: CGPoint(x: x, y: bounds.midY), anchor: .leading, proposal: ProposedViewSize(size))
            x += size.width
            if i + 1 < subviews.count {
                x += subview.spacing.distance(to: subviews[i + 1].spacing, along: .horizontal)
            }
        }
    }
}

private struct C13_SpacingDistanceExample: View {
    var body: some View {
        VStack(spacing: 8) {
            C13_PreferredGapRow {
                Text("Label")
                Button("Action") { }
                Toggle("On", isOn: .constant(true)).toggleStyle(.switch)
                Text("End")
            }
            .padding(8)
            .background(.gray.opacity(0.1))
            Text("Each gap is distance(to:along:) — the system's preferred spacing between that pair of neighbours")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

private nonisolated struct C13_MergedVerticalRow: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        C13_RowMath.size(of: subviews, gap: 8)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        C13_RowMath.place(subviews, in: bounds, gap: 8)
    }

    func spacing(subviews: Subviews, cache: inout ()) -> ViewSpacing {
        var merged = ViewSpacing()
        for subview in subviews {
            merged.formUnion(subview.spacing, edges: .vertical)
        }
        return merged
    }
}

private struct C13_SpacingFormUnionExample: View {
    var body: some View {
        VStack(spacing: 8) {
            VStack {
                Text("Above").font(.caption).foregroundStyle(.secondary)
                C13_MergedVerticalRow {
                    Text("Title").font(.title3)
                    Button("Save") { }
                    Image(systemName: "star.fill").foregroundStyle(.yellow)
                }
                .background(.blue.opacity(0.12))
                Text("Below").font(.caption).foregroundStyle(.secondary)
            }
            .padding(8)
            .background(.gray.opacity(0.1))
            Text("The row's top/bottom spacing is the largest any child asked for; leading/trailing keep the defaults")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

private nonisolated struct C13_MergedHorizontalRow: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        C13_RowMath.size(of: subviews, gap: 8)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        C13_RowMath.place(subviews, in: bounds, gap: 8)
    }

    func spacing(subviews: Subviews, cache: inout ()) -> ViewSpacing {
        subviews.reduce(ViewSpacing.zero) {
            $0.union($1.spacing, edges: .horizontal)
        }
    }
}

private struct C13_SpacingUnionExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Left").font(.caption).foregroundStyle(.secondary)
                C13_MergedHorizontalRow {
                    Text("Title").font(.title3)
                    Button("Save") { }
                    Image(systemName: "star.fill").foregroundStyle(.yellow)
                }
                .background(.blue.opacity(0.12))
                Text("Right").font(.caption).foregroundStyle(.secondary)
            }
            .padding(8)
            .background(.gray.opacity(0.1))
            Text("Starting from .zero, union(_:edges:) folds in each child's leading/trailing preference; top/bottom stay 0")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}
