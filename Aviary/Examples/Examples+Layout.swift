//
//  Examples+Layout.swift
//  Aviary
//
//  Rendered usage examples for the entries in CatalogData/gen-layout.json.
//  Entries that already have an interactive demo (demoID) are not here.
//

import SwiftUI
import CoreGraphics

enum ExamplesLayout {
    static let entries: [ExampleEntry] = [
        ExampleEntry(topic: ".alignmentGuide()", code: """
        VStack(alignment: .leading) {
            Text("Title").font(.headline)
            Text("Hanging detail")
                .alignmentGuide(.leading) { d in d[.leading] - 16 }
        }
        """) { AnyView(L_AlignmentGuideExample()) },

        ExampleEntry(topic: ".anchorPreference()", code: """
        Text(tab)
            .anchorPreference(key: TabBoundsKey.self, value: .bounds) {
                tab == selection ? $0 : nil
            }
        // ...an ancestor resolves the anchor to draw an underline
        """) { AnyView(L_AnchorPreferenceExample()) },

        ExampleEntry(topic: ".backgroundPreferenceValue()", code: """
        tabBar.backgroundPreferenceValue(SelectionKey.self) { anchor in
            GeometryReader { proxy in
                if let anchor {
                    let rect = proxy[anchor]
                    Capsule().fill(.tint.opacity(0.25))
                        .frame(width: rect.width, height: rect.height)
                        .offset(x: rect.minX, y: rect.minY)
                }
            }
        }
        """) { AnyView(L_BackgroundPreferenceValueExample()) },

        ExampleEntry(topic: ".clipped()", code: """
        Image(systemName: "mountain.2.fill")
            .resizable()
            .scaledToFill()
            .frame(width: 150, height: 90)
            .clipped()
        """) { AnyView(L_ClippedExample()) },

        ExampleEntry(topic: ".containerShape()", code: """
        VStack {
            Label("Wi-Fi", systemImage: "wifi")
                .padding(10)
                .background(ContainerRelativeShape().fill(.thinMaterial))
        }
        .padding()
        .containerShape(RoundedRectangle(cornerRadius: 22))
        """) { AnyView(L_ContainerShapeExample()) },

        ExampleEntry(topic: ".containerValue()", code: """
        extension ContainerValues {
            @Entry var isFeatured: Bool = false
        }

        Gallery {
            Label("Inbox", systemImage: "tray")
            Label("Starred", systemImage: "star")
                .containerValue(\\.isFeatured, true)
        }
        """) { AnyView(L_ContainerValueExample()) },

        ExampleEntry(topic: ".contentMargins()", code: """
        ScrollView(.horizontal) {
            LazyHStack(spacing: 12) { cards }
        }
        .contentMargins(.horizontal, 24, for: .scrollContent)
        """) { AnyView(L_ContentMarginsExample()) },

        ExampleEntry(topic: ".contentShape()", code: """
        HStack {
            Image(systemName: "star")
            Spacer()
            Text("Favorite")
        }
        .contentShape(Rectangle())   // the Spacer's gap is now tappable
        .onTapGesture { taps += 1 }
        """) { AnyView(L_ContentShapeExample()) },

        ExampleEntry(topic: ".coordinateSpace()", code: """
        ZStack { boardContent }
            .coordinateSpace(.named("board"))
            .gesture(
                DragGesture(coordinateSpace: .named("board"))
                    .onChanged { dragPoint = $0.location }
            )
        """) { AnyView(L_CoordinateSpaceExample()) },

        ExampleEntry(topic: ".geometryGroup()", code: """
        HStack(spacing: 6) {
            Circle().fill(.blue)
            Circle().fill(.teal)
        }
        .geometryGroup()                       // animate as one unit
        .scaleEffect(isExpanded ? 1 : 0.4, anchor: .leading)
        """) { AnyView(L_GeometryGroupExample()) },

        ExampleEntry(topic: ".gridCellAnchor()", code: """
        Grid {
            GridRow {
                Text("Label")
                Color.blue.frame(width: 80, height: 40)
            }
            GridRow {
                Text("Pin")
                Image(systemName: "mappin.circle.fill")
                    .gridCellAnchor(UnitPoint(x: 0, y: 1))
            }
        }
        """) { AnyView(L_GridCellAnchorExample()) },

        ExampleEntry(topic: ".gridCellColumns()", code: """
        Grid {
            GridRow {
                Text("Revenue"); Text("Q1"); Text("Q2")
            }
            GridRow {
                SummaryBanner()
                    .gridCellColumns(3)
            }
        }
        """) { AnyView(L_GridCellColumnsExample()) },

        ExampleEntry(topic: ".gridCellUnsizedAxes()", code: """
        Grid {
            GridRow { Text("A"); Text("B") }
            Divider()
                .gridCellUnsizedAxes(.horizontal)
            GridRow { Text("C"); Text("D") }
        }
        """) { AnyView(L_GridCellUnsizedAxesExample()) },

        ExampleEntry(topic: ".gridColumnAlignment()", code: """
        Grid(alignment: .leading) {
            GridRow {
                Text("Item")
                Text("$1,200")
                    .gridColumnAlignment(.trailing)
            }
            GridRow { Text("Tax"); Text("$96") }
        }
        """) { AnyView(L_GridColumnAlignmentExample()) },

        ExampleEntry(topic: ".layoutValue()", code: """
        struct Flex: LayoutValueKey {
            static let defaultValue: CGFloat = 1
        }

        FlexRow {
            Sidebar().layoutValue(key: Flex.self, value: 0.35)
            Detail().layoutValue(key: Flex.self, value: 0.65)
        }
        """) { AnyView(L_LayoutValueExample()) },

        ExampleEntry(topic: ".onGeometryChange()", code: """
        Rectangle()
            .frame(width: width)
            .onGeometryChange(for: CGFloat.self) { proxy in
                proxy.size.width
            } action: { newWidth in
                columns = max(1, Int(newWidth / 80))
            }
        """) { AnyView(L_OnGeometryChangeExample()) },

        ExampleEntry(topic: ".onPreferenceChange()", code: """
        DetailPane(section: section)
            .preference(key: TitleKey.self, value: section)
            .onPreferenceChange(TitleKey.self) { title in
                headerTitle = title
            }
        """) { AnyView(L_OnPreferenceChangeExample()) },

        ExampleEntry(topic: ".overlayPreferenceValue()", code: """
        tabBar.overlayPreferenceValue(MarkerKey.self) { anchor in
            GeometryReader { proxy in
                if let anchor {
                    let rect = proxy[anchor]
                    Circle().fill(.tint).frame(width: 7, height: 7)
                        .position(x: rect.midX, y: rect.minY)
                }
            }
        }
        """) { AnyView(L_OverlayPreferenceValueExample()) },

        ExampleEntry(topic: ".preference()", code: """
        struct TitleKey: PreferenceKey {
            static let defaultValue = ""
            static func reduce(value: inout String,
                               nextValue: () -> String) {
                value = nextValue()
            }
        }

        DetailPane().preference(key: TitleKey.self, value: "Orders")
        """) { AnyView(L_PreferenceExample()) },

        ExampleEntry(topic: ".projectionEffect()", code: """
        let skew = CGAffineTransform(a: 1, b: 0, c: -0.3, d: 1,
                                     tx: 0, ty: 0)
        Text("SLANTED")
            .font(.title.bold())
            .projectionEffect(ProjectionTransform(skew))
        """) { AnyView(L_ProjectionEffectExample()) },

        ExampleEntry(topic: ".safeAreaBar()", code: """
        ScrollView {
            messages
        }
        .safeAreaBar(edge: .bottom) {
            ComposerField(text: $draft)
                .padding(.horizontal)
        }
        """) { AnyView(L_SafeAreaBarExample()) },

        ExampleEntry(topic: ".safeAreaPadding()", code: """
        ScrollView(.horizontal) {
            LazyHStack(spacing: 12) { cards }
        }
        .safeAreaPadding(.horizontal, 24)
        """) { AnyView(L_SafeAreaPaddingExample()) },

        ExampleEntry(topic: ".scaledToFill()", code: """
        Image(systemName: "mountain.2.fill")
            .resizable()
            .scaledToFill()          // covers, overflows the short side
            .frame(width: 150, height: 90)
            .clipped()
        """) { AnyView(L_ScaledToFillExample()) },

        ExampleEntry(topic: ".scaledToFit()", code: """
        Image(systemName: "cloud.sun.rain.fill")
            .resizable()
            .scaledToFit()           // letterboxes to fit
            .frame(width: 150, height: 90)
        """) { AnyView(L_ScaledToFitExample()) },

        ExampleEntry(topic: ".scenePadding()", code: """
        VStack(alignment: .leading) {
            Text("Now Playing").font(.headline)
            trackList
        }
        .scenePadding(.horizontal)
        """) { AnyView(L_ScenePaddingExample()) },

        ExampleEntry(topic: ".transformAnchorPreference()", code: """
        ForEach(chips) { chip in
            ChipView(chip)
                .transformAnchorPreference(
                    key: DotsKey.self, value: .center) { list, anchor in
                    list.append(anchor)
                }
        }
        // ...an overlay resolves every collected anchor and marks it
        """) { AnyView(L_TransformAnchorPreferenceExample()) },

        ExampleEntry(topic: ".transformEffect()", code: """
        Text("APPROVED")
            .font(.title.bold())
            .foregroundStyle(.green)
            .transformEffect(
                CGAffineTransform(rotationAngle: -.pi / 16)
                    .translatedBy(x: 4, y: 0))
        """) { AnyView(L_TransformEffectExample()) },

        ExampleEntry(topic: ".transformPreference()", code: """
        BarRow()
            .transformPreference(ValuesKey.self) { values in
                values = values.filter { $0 >= threshold }
            }
            .onPreferenceChange(ValuesKey.self) { kept = $0.count }
        """) { AnyView(L_TransformPreferenceExample()) },

        ExampleEntry(topic: "Alignment", code: """
        ZStack(alignment: Alignment(horizontal: .trailing,
                                    vertical: .bottom)) {
            Color.gray.opacity(0.2)
            Text("Badge").padding(6)
                .background(.tint, in: .capsule)
        }
        .frame(width: 200, height: 120)
        """) { AnyView(L_AlignmentExample()) },

        ExampleEntry(topic: "AlignmentID", code: """
        private enum MidBadge: AlignmentID {
            static func defaultValue(in d: ViewDimensions) -> CGFloat {
                d[VerticalAlignment.center]
            }
        }
        extension VerticalAlignment {
            static let midBadge = VerticalAlignment(MidBadge.self)
        }

        HStack(alignment: .midBadge) {
            Text("Level").alignmentGuide(.midBadge) { $0[.bottom] }
            BadgePill().alignmentGuide(.midBadge) { $0[VerticalAlignment.center] }
        }
        """) { AnyView(L_AlignmentIDExample()) },

        ExampleEntry(topic: "Anchor", code: """
        struct BoundsKey: PreferenceKey {
            static let defaultValue: Anchor<CGRect>? = nil
            static func reduce(value: inout Anchor<CGRect>?,
                               nextValue: () -> Anchor<CGRect>?) {
                value = value ?? nextValue()
            }
        }

        Text(item).anchorPreference(key: BoundsKey.self,
                                    value: .bounds) { $0 }
        """) { AnyView(L_AnchorExample()) },

        ExampleEntry(topic: "Angle", code: """
        Slider(value: $bearing, in: 0...360)

        Image(systemName: "location.north.fill")
            .rotationEffect(Angle.degrees(bearing))
        """) { AnyView(L_AngleExample()) },

        ExampleEntry(topic: "AnyLayout", code: """
        let layout = isWide
            ? AnyLayout(HStackLayout(spacing: 12))
            : AnyLayout(VStackLayout(alignment: .leading, spacing: 8))
        layout {
            ChartPane()
            DetailPane()
        }
        """) { AnyView(L_AnyLayoutExample()) },

        ExampleEntry(topic: "Axis", code: """
        ScrollView(Axis.Set.horizontal) {
            HStack(spacing: 10) { chips }
        }

        Text(longNote)
            .fixedSize(horizontal: false, vertical: true)
        """) { AnyView(L_AxisExample()) },

        ExampleEntry(topic: "ContainerValues", code: """
        extension ContainerValues {
            @Entry var badgeCount: Int = 0
        }

        ForEach(subviews: content) { subview in
            subview.badge(subview.containerValues.badgeCount)
        }
        """) { AnyView(L_ContainerValuesExample()) },

        ExampleEntry(topic: "ContentMarginPlacement", code: """
        ScrollView {
            articleBody
        }
        .contentMargins(.horizontal, 32,
                        for: ContentMarginPlacement.scrollContent)
        """) { AnyView(L_ContentMarginPlacementExample()) },

        ExampleEntry(topic: "ContentMode", code: """
        Image(systemName: "photo.fill")
            .resizable()
            .aspectRatio(contentMode: ContentMode.fit)
            .frame(width: 150, height: 90)
        """) { AnyView(L_ContentModeExample()) },

        ExampleEntry(topic: "ContentShapeKinds", code: """
        ThumbnailView(item: item)
            .contentShape(ContentShapeKinds.dragPreview,
                          RoundedRectangle(cornerRadius: 12))
            .draggable(item.id)
        """) { AnyView(L_ContentShapeKindsExample()) },

        ExampleEntry(topic: "CoordinateSpace", code: """
        GeometryReader { proxy in
            let onScreen = proxy.frame(in: CoordinateSpace.global)
            let local = proxy.frame(in: .local)
            Text("global y: \\(Int(onScreen.minY)), local y: \\(Int(local.minY))")
        }
        """) { AnyView(L_CoordinateSpaceEnumExample()) },

        ExampleEntry(topic: "CoordinateSpaceProtocol", code: """
        ScrollView {
            GeometryReader { proxy in
                let y = proxy.frame(in: .scrollView).minY
                Color.clear
                    .onChange(of: y) { _, new in offset = new }
            }
        }
        """) { AnyView(L_CoordinateSpaceProtocolExample()) },

        ExampleEntry(topic: "Edge", code: """
        DetailCard()
            .padding([.leading, .trailing], 24)
            .transition(.move(edge: Edge.bottom).combined(with: .opacity))
        """) { AnyView(L_EdgeExample()) },

        ExampleEntry(topic: "EdgeInsets", code: """
        Text("Pull quote")
            .padding(EdgeInsets(top: 8, leading: 20,
                                bottom: 8, trailing: 12))
            .background(.tint.opacity(0.15), in: .rect(cornerRadius: 8))
        """) { AnyView(L_EdgeInsetsExample()) },

        ExampleEntry(topic: "GeometryProxy", code: """
        GeometryReader { proxy in
            let side = min(proxy.size.width, proxy.size.height)
            Circle()
                .frame(width: side, height: side)
                .position(x: proxy.frame(in: .local).midX,
                          y: proxy.frame(in: .local).midY)
        }
        """) { AnyView(L_GeometryProxyExample()) },

        ExampleEntry(topic: "GridItem", code: """
        let columns = [
            GridItem(.fixed(44)),
            GridItem(.flexible(minimum: 60)),
            GridItem(.adaptive(minimum: 44), spacing: 6)
        ]
        LazyVGrid(columns: columns, spacing: 6) {
            ForEach(0..<9, id: \\.self) { Text("\\($0)") }
        }
        """) { AnyView(L_GridItemExample()) },

        ExampleEntry(topic: "GridRow", code: """
        Grid(alignment: .leading) {
            GridRow {
                Text("Name")
                TextField("Value", text: $name)
            }
            GridRow {
                Text("Status")
                Label("Active", systemImage: "checkmark.circle")
            }
        }
        """) { AnyView(L_GridRowExample()) },

        ExampleEntry(topic: "HorizontalAlignment", code: """
        private enum IconCenter: AlignmentID {
            static func defaultValue(in d: ViewDimensions) -> CGFloat {
                d[HorizontalAlignment.center]
            }
        }
        extension HorizontalAlignment {
            static let iconCenter = HorizontalAlignment(IconCenter.self)
        }

        VStack(alignment: .iconCenter) {
            Image(systemName: "star.fill").alignmentGuide(.iconCenter) { $0[HorizontalAlignment.center] }
            Text("Rated").alignmentGuide(.iconCenter) { $0[HorizontalAlignment.center] }
        }
        """) { AnyView(L_HorizontalAlignmentExample()) },

        ExampleEntry(topic: "HorizontalEdge", code: """
        List(messages) { message in
            MessageRow(message: message)
                .swipeActions(edge: HorizontalEdge.leading) {
                    Button("Pin") { pin(message) }.tint(.orange)
                }
        }
        """) { AnyView(L_HorizontalEdgeExample()) },

        ExampleEntry(topic: "LayoutDirection", code: """
        @Environment(\\.layoutDirection) private var direction

        HStack {
            Text("Start")
            Spacer()
            Image(systemName: direction == LayoutDirection.rightToLeft
                  ? "chevron.left" : "chevron.right")
        }
        """) { AnyView(L_LayoutDirectionExample()) },

        ExampleEntry(topic: "LayoutDirectionBehavior", code: """
        struct ArrowShape: Shape {
            var layoutDirectionBehavior: LayoutDirectionBehavior { .mirrors }
            func path(in rect: CGRect) -> Path {
                var p = Path()
                p.move(to: CGPoint(x: rect.minX, y: rect.midY))
                p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
                p.addLine(to: CGPoint(x: rect.maxX - 10, y: rect.midY - 8))
                return p
            }
        }
        """) { AnyView(L_LayoutDirectionBehaviorExample()) },

        ExampleEntry(topic: "LayoutProperties", code: """
        struct RailLayout: Layout {
            static var layoutProperties: LayoutProperties {
                var props = LayoutProperties()
                props.stackOrientation = .vertical
                return props
            }
            // sizeThatFits / placeSubviews stack children vertically
        }
        """) { AnyView(L_LayoutPropertiesExample()) },

        ExampleEntry(topic: "LayoutSubview", code: """
        func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize,
                           subviews: Subviews, cache: inout ()) {
            let cell = bounds.width / CGFloat(subviews.count)
            var x = bounds.minX
            for subview in subviews {
                subview.place(at: CGPoint(x: x, y: bounds.midY),
                              anchor: .leading,
                              proposal: ProposedViewSize(width: cell,
                                                         height: bounds.height))
                x += cell
            }
        }
        """) { AnyView(L_LayoutSubviewExample()) },

        ExampleEntry(topic: "LayoutSubviews", code: """
        func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize,
                           subviews: LayoutSubviews, cache: inout ()) {
            for (index, subview) in subviews.enumerated() {
                subview.place(
                    at: CGPoint(x: bounds.minX + CGFloat(index) * step,
                                y: bounds.minY + CGFloat(index) * 22),
                    anchor: .topLeading, proposal: .unspecified)
            }
        }
        """) { AnyView(L_LayoutSubviewsExample()) },

        ExampleEntry(topic: "LayoutValueKey", code: """
        struct Flex: LayoutValueKey {
            static let defaultValue: CGFloat = 1
        }

        // In placeSubviews, the layout reads each child's value:
        let flex = subview[Flex.self]
        let width = available * (flex / totalFlex)
        """) { AnyView(L_LayoutValueKeyExample()) },

        ExampleEntry(topic: "PinnedScrollableViews", code: """
        ScrollView {
            LazyVStack(pinnedViews: PinnedScrollableViews.sectionHeaders) {
                Section {
                    ForEach(items) { ItemRow(item: $0) }
                } header: {
                    Text("Today").font(.headline)
                }
            }
        }
        """) { AnyView(L_PinnedScrollableViewsExample()) },

        ExampleEntry(topic: "pixelLength", code: """
        @Environment(\\.pixelLength) private var pixelLength

        Rectangle()
            .fill(.primary)
            .frame(height: pixelLength)   // exactly one device pixel
        """) { AnyView(L_PixelLengthExample()) },

        ExampleEntry(topic: "ProjectionTransform", code: """
        var t = CATransform3DIdentity
        t.m34 = -1 / 500
        t = CATransform3DRotate(t, .pi / 6, 0, 1, 0)
        CardFace()
            .projectionEffect(ProjectionTransform(t))
        """) { AnyView(L_ProjectionTransformExample()) },

        ExampleEntry(topic: "ProposedViewSize", code: """
        func sizeThatFits(proposal: ProposedViewSize,
                          subviews: Subviews, cache: inout ()) -> CGSize {
            let target = proposal.replacingUnspecifiedDimensions(
                by: CGSize(width: 300, height: 44))
            return CGSize(width: target.width, height: 44)
        }
        """) { AnyView(L_ProposedViewSizeExample()) },

        ExampleEntry(topic: "SafeAreaRegions", code: """
        BackdropArt()
            .ignoresSafeArea(SafeAreaRegions.container, edges: .top)

        ChatThread()
            .ignoresSafeArea(.keyboard, edges: .bottom)
        """) { AnyView(L_SafeAreaRegionsExample()) },

        ExampleEntry(topic: "ScrollGeometry", code: """
        ScrollView {
            feed
        }
        .onScrollGeometryChange(for: CGFloat.self) { geometry in
            geometry.contentOffset.y
        } action: { _, y in
            headerOpacity = max(0, 1 - y / 60)
        }
        """) { AnyView(L_ScrollGeometryExample()) },

        ExampleEntry(topic: "Subview", code: """
        Group(subviews: content) { subviews in
            if let hero = subviews.first {
                hero.font(.headline)
            }
            HStack {
                ForEach(subviews.dropFirst()) { $0 }
            }
        }
        """) { AnyView(L_SubviewExample()) },

        ExampleEntry(topic: "SubviewsCollection", code: """
        Group(subviews: content) { subviews in
            ForEach(subviews.prefix(4)) { $0 }
            if subviews.count > 4 {
                Text("+\\(subviews.count - 4) more")
            }
        }
        """) { AnyView(L_SubviewsCollectionExample()) },

        ExampleEntry(topic: "UnitPoint", code: """
        LinearGradient(colors: [.indigo, .cyan],
                       startPoint: UnitPoint(x: 0.1, y: 0),
                       endPoint: .bottomTrailing)

        Circle().fill(.orange)
            .scaleEffect(scale, anchor: anchor)   // anchor is a UnitPoint
        """) { AnyView(L_UnitPointExample()) },

        ExampleEntry(topic: "UserInterfaceSizeClass", code: """
        @Environment(\\.horizontalSizeClass) private var sizeClass

        if sizeClass == UserInterfaceSizeClass.compact {
            CompactHome()
        } else {
            SidebarHome()
        }
        """) { AnyView(L_UserInterfaceSizeClassExample()) },

        ExampleEntry(topic: "VerticalAlignment", code: """
        HStack(alignment: .firstTextBaseline) {
            Text("Total").font(.largeTitle)
            Text("$42.00").font(.body)
        }
        """) { AnyView(L_VerticalAlignmentExample()) },

        ExampleEntry(topic: "VerticalEdge", code: """
        PageView()
            .safeAreaInset(edge: VerticalEdge.bottom) {
                PageScrubber()
                    .background(.thinMaterial)
            }
        """) { AnyView(L_VerticalEdgeExample()) },

        ExampleEntry(topic: "verticalSizeClass", code: """
        @Environment(\\.verticalSizeClass) private var verticalSizeClass

        if verticalSizeClass == .compact {
            HStack { player; controls }   // landscape phone
        } else {
            VStack { player; controls }
        }
        """) { AnyView(L_VerticalSizeClassExample()) },

        ExampleEntry(topic: "ViewDimensions", code: """
        Text("Caption")
            .alignmentGuide(.leading) { (d: ViewDimensions) in
                d[.leading] + (d.width / 4)
            }
        """) { AnyView(L_ViewDimensionsExample()) },

        ExampleEntry(topic: "ViewSpacing", code: """
        func spacing(subviews: Subviews, cache: inout ()) -> ViewSpacing {
            var spacing = ViewSpacing()
            for subview in subviews {
                spacing.formUnion(subview.spacing)
            }
            return spacing
        }
        """) { AnyView(L_ViewSpacingExample()) },
    ]
}

// MARK: - Shared preference keys

private struct L_TabAnchorKey: PreferenceKey {
    static let defaultValue: Anchor<CGRect>? = nil
    static func reduce(value: inout Anchor<CGRect>?, nextValue: () -> Anchor<CGRect>?) {
        value = value ?? nextValue()
    }
}

private struct L_TitleKey: PreferenceKey {
    static let defaultValue = ""
    static func reduce(value: inout String, nextValue: () -> String) {
        let next = nextValue()
        if !next.isEmpty { value = next }
    }
}

private struct L_DotsKey: PreferenceKey {
    static let defaultValue: [Anchor<CGPoint>] = []
    static func reduce(value: inout [Anchor<CGPoint>], nextValue: () -> [Anchor<CGPoint>]) {
        value.append(contentsOf: nextValue())
    }
}

private struct L_ValuesKey: PreferenceKey {
    static let defaultValue: [CGFloat] = []
    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
}

// MARK: - Shared container values

extension ContainerValues {
    @Entry var l_isFeatured: Bool = false
    @Entry var l_badgeCount: Int = 0
}

// MARK: - Shared caption helper

private struct L_Caption: View {
    let text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
    }
}

// MARK: - .alignmentGuide()

private struct L_AlignmentGuideExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Title").font(.headline)
            Text("Body sits flush with the title")
            Text("Hanging detail is outdented")
                .foregroundStyle(.tint)
                .alignmentGuide(.leading) { d in d[.leading] - 16 }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
    }
}

// MARK: - .anchorPreference()

private struct L_AnchorPreferenceExample: View {
    @State private var selection = 1
    private let tabs = ["Files", "Edit", "View"]

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 4) {
                ForEach(tabs.indices, id: \.self) { i in
                    Text(tabs[i])
                        .padding(.horizontal, 14).padding(.vertical, 7)
                        .anchorPreference(key: L_TabAnchorKey.self, value: .bounds) {
                            i == selection ? $0 : nil
                        }
                        .contentShape(.rect)
                        .onTapGesture { withAnimation(.snappy) { selection = i } }
                }
            }
            .overlayPreferenceValue(L_TabAnchorKey.self) { anchor in
                GeometryReader { proxy in
                    if let anchor {
                        let rect = proxy[anchor]
                        Capsule().fill(.tint)
                            .frame(width: rect.width, height: 2)
                            .offset(x: rect.minX, y: rect.maxY - 2)
                    }
                }
            }
            L_Caption("Tap a tab — its bounds anchor drives the underline.")
        }
    }
}

// MARK: - .backgroundPreferenceValue()

private struct L_BackgroundPreferenceValueExample: View {
    @State private var selection = 0
    private let tabs = ["All", "Unread", "Flagged"]

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 4) {
                ForEach(tabs.indices, id: \.self) { i in
                    Text(tabs[i])
                        .padding(.horizontal, 14).padding(.vertical, 7)
                        .anchorPreference(key: L_TabAnchorKey.self, value: .bounds) {
                            i == selection ? $0 : nil
                        }
                        .contentShape(.rect)
                        .onTapGesture { withAnimation(.snappy) { selection = i } }
                }
            }
            .backgroundPreferenceValue(L_TabAnchorKey.self) { anchor in
                GeometryReader { proxy in
                    if let anchor {
                        let rect = proxy[anchor]
                        Capsule().fill(.tint.opacity(0.25))
                            .frame(width: rect.width, height: rect.height)
                            .offset(x: rect.minX, y: rect.minY)
                    }
                }
            }
            L_Caption("A moving pill is drawn behind the labels from the same anchor.")
        }
    }
}

// MARK: - .clipped()

private struct L_ClippedExample: View {
    var body: some View {
        HStack(spacing: 20) {
            VStack(spacing: 6) {
                Image(systemName: "mountain.2.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 80)
                    .clipped()
                    .border(.tint)
                L_Caption(".clipped()")
            }
            VStack(spacing: 6) {
                Image(systemName: "mountain.2.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 80)
                    .border(.tint)
                L_Caption("spills past the frame")
            }
        }
        .foregroundStyle(.teal)
    }
}

// MARK: - .containerShape()

private struct L_ContainerShapeExample: View {
    var body: some View {
        VStack(spacing: 8) {
            ForEach(["Wi-Fi", "Bluetooth"], id: \.self) { name in
                Label(name, systemImage: name == "Wi-Fi" ? "wifi" : "dot.radiowaves.right")
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(ContainerRelativeShape().fill(.thinMaterial))
            }
        }
        .padding()
        .background(.tint.opacity(0.3), in: .rect(cornerRadius: 22))
        .containerShape(RoundedRectangle(cornerRadius: 22))
        .frame(maxWidth: 240)
    }
}

// MARK: - .containerValue()

private struct L_Gallery<Content: View>: View {
    @ViewBuilder var content: Content
    var body: some View {
        VStack(spacing: 8) {
            ForEach(subviews: content) { subview in
                let featured = subview.containerValues.l_isFeatured
                subview
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(featured ? 14 : 8)
                    .background(featured ? Color.accentColor.opacity(0.22)
                                         : Color.gray.opacity(0.15),
                                in: .rect(cornerRadius: 8))
                    .overlay(alignment: .trailing) {
                        if featured {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.tint).padding(.trailing, 10)
                        }
                    }
            }
        }
    }
}

private struct L_ContainerValueExample: View {
    var body: some View {
        L_Gallery {
            Label("Inbox", systemImage: "tray")
            Label("Starred", systemImage: "star")
                .containerValue(\.l_isFeatured, true)
            Label("Drafts", systemImage: "doc")
        }
        .frame(maxWidth: 240)
    }
}

// MARK: - .contentMargins()

private struct L_ContentMarginsExample: View {
    var body: some View {
        VStack(spacing: 8) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 12) {
                    ForEach(0..<8, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.tint)
                            .frame(width: 70, height: 70)
                            .overlay(Text("\(i)").foregroundStyle(.white))
                    }
                }
            }
            .contentMargins(.horizontal, 24, for: .scrollContent)
            .frame(height: 84)
            .background(.quaternary.opacity(0.4), in: .rect(cornerRadius: 10))
            L_Caption("24pt margins sit inside the scroll view; items still scroll edge-to-edge.")
        }
    }
}

// MARK: - .contentShape()

private struct L_ContentShapeExample: View {
    @State private var taps = 0
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "star")
                Spacer()
                Text("Favorite")
            }
            .padding(12)
            .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 8))
            .contentShape(Rectangle())
            .onTapGesture { taps += 1 }

            L_Caption("The Spacer's empty gap is tappable too — taps: \(taps)")
        }
    }
}

// MARK: - .coordinateSpace()

private struct L_CoordinateSpaceExample: View {
    @State private var dragPoint = CGPoint(x: 60, y: 40)
    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 10).fill(.quaternary.opacity(0.5))
                Circle().fill(.tint).frame(width: 26, height: 26)
                    .position(dragPoint)
            }
            .frame(height: 120)
            .coordinateSpace(.named("board"))
            .gesture(
                DragGesture(coordinateSpace: .named("board"))
                    .onChanged { dragPoint = $0.location }
            )
            L_Caption("Drag the dot — location is reported in the \"board\" space: (\(Int(dragPoint.x)), \(Int(dragPoint.y)))")
        }
    }
}

// MARK: - .geometryGroup()

private struct L_GeometryGroupExample: View {
    @State private var expanded = true
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 6) {
                ForEach([Color.blue, .teal, .indigo], id: \.self) { c in
                    Circle().fill(c).frame(width: 26, height: 26)
                }
            }
            .geometryGroup()
            .scaleEffect(expanded ? 1 : 0.4, anchor: .leading)
            .frame(height: 30)

            Button(expanded ? "Collapse" : "Expand") {
                withAnimation(.spring) { expanded.toggle() }
            }
            .buttonStyle(.bordered)
            L_Caption("geometryGroup() keeps the row scaling as one unit.")
        }
    }
}

// MARK: - .gridCellAnchor()

private struct L_GridCellAnchorExample: View {
    var body: some View {
        VStack(spacing: 8) {
            Grid(horizontalSpacing: 12, verticalSpacing: 10) {
                GridRow {
                    Text("Label")
                    Color.blue.opacity(0.3).frame(width: 90, height: 36)
                        .overlay(Text("wide cell").font(.caption2))
                }
                GridRow {
                    Text("Pin")
                    Image(systemName: "mappin.circle.fill")
                        .foregroundStyle(.red)
                        .gridCellAnchor(UnitPoint(x: 0, y: 1))
                }
            }
            L_Caption("The pin is anchored to its cell's bottom-leading corner, not centered.")
        }
    }
}

// MARK: - .gridCellColumns()

private struct L_GridCellColumnsExample: View {
    var body: some View {
        Grid(horizontalSpacing: 12, verticalSpacing: 8) {
            GridRow {
                Text("Revenue").bold()
                Text("Q1"); Text("Q2")
            }
            GridRow {
                Text("Full-width summary banner")
                    .font(.caption)
                    .padding(6)
                    .frame(maxWidth: .infinity)
                    .background(.tint.opacity(0.2), in: .rect(cornerRadius: 6))
                    .gridCellColumns(3)
            }
            GridRow {
                Text("Total").bold(); Text("$4k"); Text("$6k")
            }
        }
        .frame(maxWidth: 260)
    }
}

// MARK: - .gridCellUnsizedAxes()

private struct L_GridCellUnsizedAxesExample: View {
    var body: some View {
        VStack(spacing: 8) {
            Grid(horizontalSpacing: 16, verticalSpacing: 8) {
                GridRow { Text("Apple"); Text("Banana") }
                Divider()
                    .gridCellUnsizedAxes(.horizontal)
                GridRow { Text("Cherry"); Text("Date") }
            }
            L_Caption("The divider no longer blows out the column widths.")
        }
    }
}

// MARK: - .gridColumnAlignment()

private struct L_GridColumnAlignmentExample: View {
    var body: some View {
        Grid(alignment: .leading, horizontalSpacing: 24, verticalSpacing: 6) {
            GridRow {
                Text("Item")
                Text("$1,200").gridColumnAlignment(.trailing)
            }
            GridRow { Text("Tax"); Text("$96") }
            GridRow { Text("Shipping"); Text("$14") }
        }
        .monospacedDigit()
        .frame(maxWidth: 220)
    }
}

// MARK: - Custom Layout: FlexRow

private struct L_Flex {}

extension L_Flex: LayoutValueKey {
    nonisolated static let defaultValue: CGFloat = 1
}

private struct L_FlexRow: Layout {
    var spacing: CGFloat = 8
    func sizeThatFits(proposal: ProposedViewSize, subviews: LayoutSubviews, cache: inout ()) -> CGSize {
        let width = proposal.replacingUnspecifiedDimensions(by: CGSize(width: 300, height: 44)).width
        let height = subviews.map { $0.sizeThatFits(.unspecified).height }.max() ?? 0
        return CGSize(width: width, height: height)
    }
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: LayoutSubviews, cache: inout ()) {
        let totalFlex = subviews.reduce(CGFloat.zero) { $0 + $1[L_Flex.self] }
        let totalSpacing = spacing * CGFloat(max(0, subviews.count - 1))
        let available = bounds.width - totalSpacing
        var x = bounds.minX
        for subview in subviews {
            let flex = subview[L_Flex.self]
            let w = totalFlex > 0 ? available * (flex / totalFlex) : 0
            subview.place(at: CGPoint(x: x, y: bounds.midY), anchor: .leading,
                          proposal: ProposedViewSize(width: w, height: bounds.height))
            x += w + spacing
        }
    }
}

private struct L_Pane: View {
    let title: String
    let color: Color
    var body: some View {
        RoundedRectangle(cornerRadius: 8).fill(color.gradient)
            .frame(height: 56)
            .overlay(Text(title).font(.caption).foregroundStyle(.white))
    }
}

// MARK: - .layoutValue()

private struct L_LayoutValueExample: View {
    var body: some View {
        VStack(spacing: 8) {
            L_FlexRow {
                L_Pane(title: "Sidebar 0.35", color: .indigo)
                    .layoutValue(key: L_Flex.self, value: 0.35)
                L_Pane(title: "Detail 0.65", color: .teal)
                    .layoutValue(key: L_Flex.self, value: 0.65)
            }
            L_Caption("Each pane's Flex value sets its share of the row width.")
        }
    }
}

// MARK: - .onGeometryChange()

private struct L_OnGeometryChangeExample: View {
    @State private var width: CGFloat = 220
    @State private var columns = 2
    var body: some View {
        VStack(spacing: 10) {
            Slider(value: $width, in: 120...320)
            RoundedRectangle(cornerRadius: 8)
                .fill(.tint.opacity(0.25))
                .frame(width: width, height: 40)
                .onGeometryChange(for: CGFloat.self) { proxy in
                    proxy.size.width
                } action: { newWidth in
                    columns = max(1, Int(newWidth / 80))
                }
            L_Caption("width \(Int(width)) pt → \(columns) columns")
        }
    }
}

// MARK: - .onPreferenceChange()

private struct L_OnPreferenceChangeExample: View {
    @State private var section = "Orders"
    @State private var observed = "Orders"
    private let sections = ["Orders", "Inbox", "Trash"]
    var body: some View {
        VStack(spacing: 10) {
            Text("Ancestor header: \(observed)")
                .font(.headline)
            Picker("Section", selection: $section) {
                ForEach(sections, id: \.self) { Text($0).tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            Color.clear.frame(height: 0)
                .preference(key: L_TitleKey.self, value: section)
        }
        .onPreferenceChange(L_TitleKey.self) { observed = $0 }
    }
}

// MARK: - .overlayPreferenceValue()

private struct L_OverlayPreferenceValueExample: View {
    @State private var selection = 2
    private let tabs = ["One", "Two", "Three", "Four"]
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 4) {
                ForEach(tabs.indices, id: \.self) { i in
                    Text(tabs[i])
                        .padding(.horizontal, 12).padding(.vertical, 7)
                        .anchorPreference(key: L_TabAnchorKey.self, value: .bounds) {
                            i == selection ? $0 : nil
                        }
                        .contentShape(.rect)
                        .onTapGesture { withAnimation(.snappy) { selection = i } }
                }
            }
            .overlayPreferenceValue(L_TabAnchorKey.self) { anchor in
                GeometryReader { proxy in
                    if let anchor {
                        let rect = proxy[anchor]
                        Circle().fill(.tint).frame(width: 7, height: 7)
                            .position(x: rect.midX, y: rect.minY)
                    }
                }
            }
            L_Caption("A dot is drawn on top of the selected tab from its anchor.")
        }
    }
}

// MARK: - .preference()

private struct L_PreferenceExample: View {
    @State private var observed = "Orders"
    var body: some View {
        VStack(spacing: 10) {
            Text("Published up the tree: \(observed)")
                .font(.headline)
            HStack {
                ForEach(["Orders", "Refunds", "Payouts"], id: \.self) { name in
                    Button(name) { }
                        .buttonStyle(.bordered)
                        .background {
                            if name == observed {
                                Color.clear.preference(key: L_TitleKey.self, value: name)
                            }
                        }
                }
            }
            HStack {
                ForEach(["Orders", "Refunds", "Payouts"], id: \.self) { name in
                    Button("Set \(name)") { observed = name }
                        .font(.caption)
                }
            }
        }
        .onPreferenceChange(L_TitleKey.self) { _ in }
    }
}

// MARK: - .projectionEffect()

private struct L_ProjectionEffectExample: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("SLANTED")
                .font(.title.bold())
                .foregroundStyle(.tint)
                .projectionEffect(
                    ProjectionTransform(CGAffineTransform(a: 1, b: 0, c: -0.3, d: 1, tx: 0, ty: 0)))
            L_Caption("A skew matrix applied through projectionEffect — layout is unchanged.")
        }
        .padding(.vertical, 8)
    }
}

// MARK: - .safeAreaBar()

private struct L_SafeAreaBarExample: View {
    @State private var draft = ""
    var body: some View {
        ScrollView {
            VStack(spacing: 6) {
                ForEach(0..<8, id: \.self) { i in
                    Text("Message \(i)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(8)
                        .background(.quaternary.opacity(0.4), in: .rect(cornerRadius: 6))
                }
            }
            .padding(.horizontal)
        }
        .safeAreaBar(edge: .bottom) {
            HStack {
                TextField("Message", text: $draft)
                    .textFieldStyle(.roundedBorder)
                Image(systemName: "arrow.up.circle.fill").foregroundStyle(.tint)
            }
            .padding(8)
            .background(.bar)
        }
        .frame(height: 190)
        .clipShape(.rect(cornerRadius: 10))
    }
}

// MARK: - .safeAreaPadding()

private struct L_SafeAreaPaddingExample: View {
    var body: some View {
        VStack(spacing: 8) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 12) {
                    ForEach(0..<8, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.indigo.gradient)
                            .frame(width: 64, height: 64)
                            .overlay(Text("\(i)").foregroundStyle(.white))
                    }
                }
            }
            .safeAreaPadding(.horizontal, 24)
            .frame(height: 78)
            .background(.quaternary.opacity(0.4), in: .rect(cornerRadius: 10))
            L_Caption("Resting content is inset 24pt, but items are not clipped mid-scroll.")
        }
    }
}

// MARK: - .scaledToFill()

private struct L_ScaledToFillExample: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "mountain.2.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 90)
                .clipped()
                .foregroundStyle(.teal)
                .background(.quaternary.opacity(0.4))
            L_Caption("Content covers the frame and overflows the shorter side (then clipped).")
        }
    }
}

// MARK: - .scaledToFit()

private struct L_ScaledToFitExample: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "cloud.sun.rain.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 90)
                .foregroundStyle(.orange)
                .background(.quaternary.opacity(0.4))
            L_Caption("Content fits entirely inside the frame, letterboxing the extra space.")
        }
    }
}

// MARK: - .scenePadding()

private struct L_ScenePaddingExample: View {
    var body: some View {
        VStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Now Playing").font(.headline)
                Text("Track one")
                Text("Track two")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .scenePadding(.horizontal)
            .padding(.vertical, 10)
            .background(.quaternary.opacity(0.4), in: .rect(cornerRadius: 10))
            L_Caption("Horizontal padding matches the platform's standard scene margin.")
        }
    }
}

// MARK: - .transformAnchorPreference()

private struct L_TransformAnchorPreferenceExample: View {
    private let chips = ["North", "East", "South", "West"]
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 14) {
                ForEach(chips, id: \.self) { chip in
                    Text(chip)
                        .padding(.horizontal, 10).padding(.vertical, 6)
                        .background(.quaternary.opacity(0.5), in: .capsule)
                        .transformAnchorPreference(key: L_DotsKey.self, value: .center) { list, anchor in
                            list.append(anchor)
                        }
                }
            }
            .overlayPreferenceValue(L_DotsKey.self) { anchors in
                GeometryReader { proxy in
                    ForEach(anchors.indices, id: \.self) { i in
                        let p = proxy[anchors[i]]
                        Circle().fill(.tint).frame(width: 6, height: 6)
                            .position(x: p.x, y: p.y - 18)
                    }
                }
            }
            L_Caption("Every chip folds its center anchor into one array the overlay then marks.")
        }
    }
}

// MARK: - .transformEffect()

private struct L_TransformEffectExample: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("APPROVED")
                .font(.title.bold())
                .foregroundStyle(.green)
                .padding(6)
                .overlay(RoundedRectangle(cornerRadius: 6).stroke(.green, lineWidth: 3))
                .transformEffect(CGAffineTransform(rotationAngle: -.pi / 16).translatedBy(x: 4, y: 0))
            L_Caption("An affine rotate + translate on the rendering; the layout frame is unmoved.")
        }
        .padding(.vertical, 8)
    }
}

// MARK: - .transformPreference()

private struct L_TransformPreferenceExample: View {
    @State private var threshold: CGFloat = 30
    @State private var kept = 0
    private let values: [CGFloat] = [10, 25, 40, 55, 70]
    var body: some View {
        VStack(spacing: 10) {
            Slider(value: $threshold, in: 0...70)
            HStack(alignment: .bottom, spacing: 8) {
                ForEach(values, id: \.self) { v in
                    RoundedRectangle(cornerRadius: 3)
                        .fill(v >= threshold ? Color.accentColor : Color.gray.opacity(0.4))
                        .frame(width: 22, height: v)
                        .preference(key: L_ValuesKey.self, value: [v])
                }
            }
            .frame(height: 72, alignment: .bottom)
            .transformPreference(L_ValuesKey.self) { current in
                current = current.filter { $0 >= threshold }
            }
            .onPreferenceChange(L_ValuesKey.self) { kept = $0.count }

            L_Caption("transformPreference filters values in place — \(kept) survive the threshold.")
        }
    }
}

// MARK: - Alignment

private struct L_AlignmentExample: View {
    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                Color.gray.opacity(0.2)
                Text("Badge")
                    .font(.caption).padding(6)
                    .background(.tint, in: .capsule)
                    .foregroundStyle(.white)
                    .padding(8)
            }
            .frame(height: 110)
            .clipShape(.rect(cornerRadius: 10))
            L_Caption("Alignment(horizontal: .trailing, vertical: .bottom)")
        }
    }
}

// MARK: - AlignmentID

private enum L_MidBadge: AlignmentID {
    static func defaultValue(in d: ViewDimensions) -> CGFloat { d[VerticalAlignment.center] }
}
private extension VerticalAlignment {
    static let l_midBadge = VerticalAlignment(L_MidBadge.self)
}

private struct L_AlignmentIDExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .l_midBadge, spacing: 10) {
                Text("Level")
                    .font(.largeTitle.bold())
                    .alignmentGuide(.l_midBadge) { $0[.bottom] }
                Text("PRO")
                    .font(.caption.bold())
                    .padding(.horizontal, 8).padding(.vertical, 4)
                    .background(.tint, in: .capsule)
                    .foregroundStyle(.white)
                    .alignmentGuide(.l_midBadge) { $0[VerticalAlignment.center] }
            }
            L_Caption("A custom VerticalAlignment lines the pill's center up with the word's baseline.")
        }
    }
}

// MARK: - Anchor

private struct L_AnchorExample: View {
    @State private var selection = 1
    private let items = ["Draft", "Review", "Publish"]
    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 4) {
                ForEach(items.indices, id: \.self) { i in
                    Text(items[i])
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(6)
                        .anchorPreference(key: L_TabAnchorKey.self, value: .bounds) {
                            i == selection ? $0 : nil
                        }
                        .contentShape(.rect)
                        .onTapGesture { withAnimation(.snappy) { selection = i } }
                }
            }
            .overlayPreferenceValue(L_TabAnchorKey.self) { anchor in
                GeometryReader { proxy in
                    if let anchor {
                        let rect = proxy[anchor]
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.tint, lineWidth: 2)
                            .frame(width: rect.width, height: rect.height)
                            .offset(x: rect.minX, y: rect.minY)
                    }
                }
            }
            L_Caption("The Anchor<CGRect> token is resolved by a proxy into the selection outline.")
        }
        .frame(maxWidth: 220)
    }
}

// MARK: - Angle

private struct L_AngleExample: View {
    @State private var bearing = 45.0
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "location.north.fill")
                .font(.system(size: 40))
                .foregroundStyle(.tint)
                .rotationEffect(Angle.degrees(bearing))
            Slider(value: $bearing, in: 0...360)
            L_Caption("Angle.degrees(\(Int(bearing)))")
        }
    }
}

// MARK: - AnyLayout

private struct L_AnyLayoutExample: View {
    @State private var isWide = true
    var body: some View {
        VStack(spacing: 10) {
            Toggle("Wide layout", isOn: $isWide)
            let layout = isWide
                ? AnyLayout(HStackLayout(spacing: 10))
                : AnyLayout(VStackLayout(alignment: .leading, spacing: 8))
            layout {
                L_Pane(title: "Chart", color: .blue)
                L_Pane(title: "Detail", color: .purple)
            }
            .animation(.spring, value: isWide)
            L_Caption("Swapping AnyLayout keeps child identity, so the change animates.")
        }
    }
}

// MARK: - Axis

private struct L_AxisExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ScrollView(Axis.Set.horizontal) {
                HStack(spacing: 8) {
                    ForEach(0..<10, id: \.self) { i in
                        Text("Chip \(i)")
                            .padding(.horizontal, 10).padding(.vertical, 6)
                            .background(.tint.opacity(0.2), in: .capsule)
                    }
                }
            }
            Text("This note is allowed to grow along the vertical axis only, wrapping instead of truncating.")
                .fixedSize(horizontal: false, vertical: true)
                .font(.caption)
            L_Caption("Axis.Set.horizontal scrolls sideways; fixedSize scopes growth to one axis.")
        }
    }
}

// MARK: - ContainerValues

private struct L_BadgeStrip<Content: View>: View {
    @ViewBuilder var content: Content
    var body: some View {
        HStack(spacing: 10) {
            ForEach(subviews: content) { subview in
                let count = subview.containerValues.l_badgeCount
                subview
                    .padding(8)
                    .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 8))
                    .overlay(alignment: .topTrailing) {
                        if count > 0 {
                            Text("\(count)")
                                .font(.caption2.bold())
                                .padding(5)
                                .background(.red, in: .circle)
                                .foregroundStyle(.white)
                                .offset(x: 8, y: -8)
                        }
                    }
            }
        }
    }
}

private struct L_ContainerValuesExample: View {
    var body: some View {
        VStack(spacing: 8) {
            L_BadgeStrip {
                Image(systemName: "tray").containerValue(\.l_badgeCount, 3)
                Image(systemName: "bell").containerValue(\.l_badgeCount, 12)
                Image(systemName: "gearshape")
            }
            .font(.title3)
            L_Caption("Each child publishes a badgeCount its container reads from the subview.")
        }
    }
}

// MARK: - ContentMarginPlacement

private struct L_ContentMarginPlacementExample: View {
    var body: some View {
        VStack(spacing: 8) {
            ScrollView {
                VStack(spacing: 6) {
                    ForEach(0..<12, id: \.self) { i in
                        Text("Row \(i)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(6)
                            .background(.quaternary.opacity(0.4), in: .rect(cornerRadius: 6))
                    }
                }
            }
            .contentMargins(.horizontal, 32, for: ContentMarginPlacement.scrollContent)
            .frame(height: 150)
            .background(.quaternary.opacity(0.25), in: .rect(cornerRadius: 10))
            L_Caption(".scrollContent insets the rows while indicators stay at the edge.")
        }
    }
}

// MARK: - ContentMode

private struct L_ContentModeExample: View {
    var body: some View {
        HStack(spacing: 20) {
            VStack(spacing: 6) {
                Image(systemName: "photo.fill")
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fit)
                    .frame(width: 110, height: 70)
                    .foregroundStyle(.blue)
                    .background(.quaternary.opacity(0.4))
                L_Caption(".fit")
            }
            VStack(spacing: 6) {
                Image(systemName: "photo.fill")
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fill)
                    .frame(width: 110, height: 70)
                    .clipped()
                    .foregroundStyle(.blue)
                    .background(.quaternary.opacity(0.4))
                L_Caption(".fill")
            }
        }
    }
}

// MARK: - ContentShapeKinds

private struct L_ContentShapeKindsExample: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Drag me")
                .padding(.horizontal, 16).padding(.vertical, 12)
                .background(.tint, in: .rect(cornerRadius: 12))
                .foregroundStyle(.white)
                .contentShape(ContentShapeKinds.dragPreview, RoundedRectangle(cornerRadius: 12))
                .draggable("thumbnail")
            L_Caption("The .dragPreview kind shapes the lifted preview to a rounded rectangle.")
        }
        .padding(.vertical, 6)
    }
}

// MARK: - CoordinateSpace (enum)

private struct L_CoordinateSpaceEnumExample: View {
    var body: some View {
        VStack(spacing: 8) {
            GeometryReader { proxy in
                let onScreen = proxy.frame(in: CoordinateSpace.global)
                let local = proxy.frame(in: .local)
                VStack(spacing: 4) {
                    Text("global.minY: \(Int(onScreen.minY))")
                    Text("local.minY: \(Int(local.minY))")
                }
                .font(.callout.monospaced())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.quaternary.opacity(0.4), in: .rect(cornerRadius: 10))
            }
            .frame(height: 90)
            L_Caption("The same reader measured in .global vs .local coordinate spaces.")
        }
    }
}

// MARK: - CoordinateSpaceProtocol

private struct L_CoordinateSpaceProtocolExample: View {
    @State private var offset: CGFloat = 0
    var body: some View {
        VStack(spacing: 8) {
            Text("frame(in: .scrollView).minY: \(Int(offset))")
                .font(.callout.monospaced())
            ScrollView {
                VStack(spacing: 0) {
                    GeometryReader { proxy in
                        let y = proxy.frame(in: .scrollView).minY
                        Color.clear.onChange(of: y) { _, new in offset = new }
                    }
                    .frame(height: 1)
                    ForEach(0..<12, id: \.self) { i in
                        Text("Row \(i)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(6)
                    }
                }
            }
            .frame(height: 120)
            .background(.quaternary.opacity(0.3), in: .rect(cornerRadius: 10))
            L_Caption("The typed .scrollView space reports the content's offset as you scroll.")
        }
    }
}

// MARK: - Edge

private struct L_EdgeExample: View {
    @State private var show = true
    var body: some View {
        VStack(spacing: 10) {
            Button(show ? "Hide" : "Show") {
                withAnimation(.spring) { show.toggle() }
            }
            .buttonStyle(.bordered)
            ZStack {
                if show {
                    Text("Card")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.tint.opacity(0.2), in: .rect(cornerRadius: 10))
                        .padding([.leading, .trailing], 24)
                        .transition(.move(edge: Edge.bottom).combined(with: .opacity))
                }
            }
            .frame(height: 70)
            L_Caption("Edge.bottom drives the move transition; Edge.Set pads left and trailing.")
        }
    }
}

// MARK: - EdgeInsets

private struct L_EdgeInsetsExample: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("Pull quote")
                .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 12))
                .background(.tint.opacity(0.18), in: .rect(cornerRadius: 8))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(.tint.opacity(0.4)))
            L_Caption("Distinct top/leading/bottom/trailing insets that mirror under RTL.")
        }
    }
}

// MARK: - GeometryProxy

private struct L_GeometryProxyExample: View {
    var body: some View {
        VStack(spacing: 8) {
            GeometryReader { proxy in
                let side = min(proxy.size.width, proxy.size.height)
                Circle()
                    .fill(.tint)
                    .frame(width: side, height: side)
                    .position(x: proxy.frame(in: .local).midX,
                              y: proxy.frame(in: .local).midY)
            }
            .frame(height: 110)
            .background(.quaternary.opacity(0.3), in: .rect(cornerRadius: 10))
            L_Caption("The proxy's size and local frame center a circle sized to the smaller edge.")
        }
    }
}

// MARK: - GridItem

private struct L_GridItemExample: View {
    private let columns = [
        GridItem(.fixed(44)),
        GridItem(.flexible(minimum: 60)),
        GridItem(.adaptive(minimum: 44), spacing: 6)
    ]
    var body: some View {
        VStack(spacing: 8) {
            LazyVGrid(columns: columns, spacing: 6) {
                ForEach(0..<9, id: \.self) { i in
                    RoundedRectangle(cornerRadius: 6)
                        .fill(.tint.opacity(0.25))
                        .frame(height: 30)
                        .overlay(Text("\(i)").font(.caption))
                }
            }
            L_Caption("A fixed, a flexible, and an adaptive track combined in one grid.")
        }
    }
}

// MARK: - GridRow

private struct L_GridRowExample: View {
    @State private var name = "Widget"
    var body: some View {
        Grid(alignment: .leading, horizontalSpacing: 12, verticalSpacing: 8) {
            GridRow {
                Text("Name")
                TextField("Value", text: $name).textFieldStyle(.roundedBorder)
            }
            GridRow {
                Text("Status")
                Label("Active", systemImage: "checkmark.circle").foregroundStyle(.green)
            }
        }
        .frame(maxWidth: 260)
    }
}

// MARK: - HorizontalAlignment

private enum L_IconCenter: AlignmentID {
    static func defaultValue(in d: ViewDimensions) -> CGFloat { d[HorizontalAlignment.center] }
}
private extension HorizontalAlignment {
    static let l_iconCenter = HorizontalAlignment(L_IconCenter.self)
}

private struct L_HorizontalAlignmentExample: View {
    var body: some View {
        VStack(spacing: 8) {
            VStack(alignment: .l_iconCenter, spacing: 6) {
                Image(systemName: "star.fill")
                    .font(.title)
                    .foregroundStyle(.tint)
                    .alignmentGuide(.l_iconCenter) { $0[HorizontalAlignment.center] }
                Text("Rated five stars for reliability")
                    .frame(width: 150)
                    .alignmentGuide(.l_iconCenter) { $0[HorizontalAlignment.center] }
            }
            L_Caption("A custom horizontal guide centers the icon over the caption's midpoint.")
        }
    }
}

// MARK: - HorizontalEdge

private struct L_MessageRowModel: Identifiable {
    let id: Int
    let title: String
}

private struct L_HorizontalEdgeExample: View {
    @State private var pinned: Int?
    private let messages = [
        L_MessageRowModel(id: 0, title: "Lunch plans?"),
        L_MessageRowModel(id: 1, title: "Design review notes"),
        L_MessageRowModel(id: 2, title: "Invoice attached")
    ]
    var body: some View {
        VStack(spacing: 6) {
            List(messages) { message in
                HStack {
                    Text(message.title)
                    if pinned == message.id {
                        Spacer(); Image(systemName: "pin.fill").foregroundStyle(.orange)
                    }
                }
                .swipeActions(edge: HorizontalEdge.leading) {
                    Button("Pin") { pinned = message.id }.tint(.orange)
                }
            }
            .frame(height: 130)
            L_Caption("Swipe a row from the leading edge to reveal the Pin action.")
        }
    }
}

// MARK: - LayoutDirection

private struct L_LayoutDirectionReadout: View {
    @Environment(\.layoutDirection) private var direction
    var body: some View {
        HStack {
            Text("Start")
            Spacer()
            Image(systemName: direction == LayoutDirection.rightToLeft ? "chevron.left" : "chevron.right")
        }
        .padding(10)
        .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 8))
    }
}

private struct L_LayoutDirectionExample: View {
    @State private var rtl = false
    var body: some View {
        VStack(spacing: 10) {
            Toggle("Right-to-left", isOn: $rtl)
            L_LayoutDirectionReadout()
                .environment(\.layoutDirection, rtl ? .rightToLeft : .leftToRight)
            L_Caption("The HStack mirrors and the chevron flips with the layout direction.")
        }
    }
}

// MARK: - LayoutDirectionBehavior

private struct L_ArrowShape: Shape {
    var layoutDirectionBehavior: LayoutDirectionBehavior { .mirrors }
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.minX, y: rect.midY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        p.addLine(to: CGPoint(x: rect.maxX - 12, y: rect.midY - 9))
        p.move(to: CGPoint(x: rect.maxX, y: rect.midY))
        p.addLine(to: CGPoint(x: rect.maxX - 12, y: rect.midY + 9))
        return p
    }
}

private struct L_LayoutDirectionBehaviorExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 24) {
                VStack(spacing: 6) {
                    L_ArrowShape().stroke(.tint, lineWidth: 3).frame(width: 80, height: 24)
                    L_Caption("LTR")
                }
                VStack(spacing: 6) {
                    L_ArrowShape().stroke(.tint, lineWidth: 3).frame(width: 80, height: 24)
                        .environment(\.layoutDirection, .rightToLeft)
                    L_Caption("RTL — mirrored")
                }
            }
            L_Caption(".mirrors flips the arrow horizontally in right-to-left layouts.")
        }
    }
}

// MARK: - Custom Layout: VerticalRail (LayoutProperties + ViewSpacing)

private struct L_VerticalRail: Layout {
    static var layoutProperties: LayoutProperties {
        var props = LayoutProperties()
        props.stackOrientation = .vertical
        return props
    }
    func sizeThatFits(proposal: ProposedViewSize, subviews: LayoutSubviews, cache: inout ()) -> CGSize {
        let width = subviews.map { $0.sizeThatFits(.unspecified).width }.max() ?? 0
        var height: CGFloat = 0
        for (index, subview) in subviews.enumerated() {
            height += subview.sizeThatFits(.unspecified).height
            if index < subviews.count - 1 {
                height += subview.spacing.distance(to: subviews[index + 1].spacing, along: .vertical)
            }
        }
        return CGSize(width: width, height: height)
    }
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: LayoutSubviews, cache: inout ()) {
        var y = bounds.minY
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: bounds.midX, y: y), anchor: .top,
                          proposal: ProposedViewSize(width: bounds.width, height: nil))
            y += subview.sizeThatFits(.unspecified).height
            if index < subviews.count - 1 {
                y += subview.spacing.distance(to: subviews[index + 1].spacing, along: .vertical)
            }
        }
    }
    func spacing(subviews: LayoutSubviews, cache: inout ()) -> ViewSpacing {
        var spacing = ViewSpacing()
        for subview in subviews { spacing.formUnion(subview.spacing) }
        return spacing
    }
}

// MARK: - LayoutProperties

private struct L_LayoutPropertiesExample: View {
    var body: some View {
        VStack(spacing: 8) {
            L_VerticalRail {
                L_Pane(title: "Header", color: .blue)
                L_Pane(title: "Body", color: .teal)
                L_Pane(title: "Footer", color: .indigo)
            }
            .frame(maxWidth: 200)
            L_Caption("layoutProperties.stackOrientation = .vertical marks this a vertical stack.")
        }
    }
}

// MARK: - Custom Layout: EqualColumns (LayoutSubview / ProposedViewSize)

private struct L_EqualColumns: Layout {
    var spacing: CGFloat = 8
    func sizeThatFits(proposal: ProposedViewSize, subviews: LayoutSubviews, cache: inout ()) -> CGSize {
        let maxHeight = subviews.map { $0.sizeThatFits(.unspecified).height }.max() ?? 0
        let width = proposal.replacingUnspecifiedDimensions(by: CGSize(width: 300, height: maxHeight)).width
        return CGSize(width: width, height: maxHeight)
    }
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: LayoutSubviews, cache: inout ()) {
        guard !subviews.isEmpty else { return }
        let totalSpacing = spacing * CGFloat(subviews.count - 1)
        let cellWidth = (bounds.width - totalSpacing) / CGFloat(subviews.count)
        var x = bounds.minX
        for subview in subviews {
            subview.place(at: CGPoint(x: x, y: bounds.midY), anchor: .leading,
                          proposal: ProposedViewSize(width: cellWidth, height: bounds.height))
            x += cellWidth + spacing
        }
    }
}

private struct L_LayoutSubviewExample: View {
    var body: some View {
        VStack(spacing: 8) {
            L_EqualColumns {
                L_Pane(title: "A", color: .blue)
                L_Pane(title: "B", color: .teal)
                L_Pane(title: "C", color: .indigo)
            }
            L_Caption("Each LayoutSubview is measured, then placed into an equal-width cell.")
        }
    }
}

// MARK: - Custom Layout: DiagonalLayout (LayoutSubviews)

private struct L_DiagonalLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: LayoutSubviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions(by: CGSize(width: 200, height: 110))
    }
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: LayoutSubviews, cache: inout ()) {
        let step = subviews.count > 1 ? (bounds.width - 80) / CGFloat(subviews.count - 1) : 0
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: bounds.minX + CGFloat(index) * step,
                                      y: bounds.minY + CGFloat(index) * 22),
                          anchor: .topLeading, proposal: .unspecified)
        }
    }
}

private struct L_LayoutSubviewsExample: View {
    var body: some View {
        VStack(spacing: 8) {
            L_DiagonalLayout {
                ForEach(0..<4, id: \.self) { i in
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.tint)
                        .frame(width: 70, height: 44)
                        .overlay(Text("\(i)").foregroundStyle(.white))
                }
            }
            .frame(height: 110)
            L_Caption("The layout enumerates the LayoutSubviews collection to cascade the cards.")
        }
    }
}

// MARK: - LayoutValueKey

private struct L_LayoutValueKeyExample: View {
    var body: some View {
        VStack(spacing: 8) {
            L_FlexRow {
                L_Pane(title: "flex 1", color: .indigo)
                    .layoutValue(key: L_Flex.self, value: 1)
                L_Pane(title: "flex 2", color: .teal)
                    .layoutValue(key: L_Flex.self, value: 2)
                L_Pane(title: "flex 1", color: .blue)
                    .layoutValue(key: L_Flex.self, value: 1)
            }
            L_Caption("The layout reads each child's Flex key to size it 1:2:1.")
        }
    }
}

// MARK: - PinnedScrollableViews

private struct L_PinnedScrollableViewsExample: View {
    var body: some View {
        VStack(spacing: 8) {
            ScrollView {
                LazyVStack(spacing: 4, pinnedViews: PinnedScrollableViews.sectionHeaders) {
                    ForEach(["Today", "Yesterday", "Last week"], id: \.self) { header in
                        Section {
                            ForEach(0..<4, id: \.self) { i in
                                Text("\(header) item \(i)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(6)
                            }
                        } header: {
                            Text(header)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(6)
                                .background(.bar)
                        }
                    }
                }
            }
            .frame(height: 150)
            .background(.quaternary.opacity(0.3), in: .rect(cornerRadius: 10))
            L_Caption("Section headers stick to the top edge as you scroll.")
        }
    }
}

// MARK: - pixelLength

private struct L_PixelLengthExample: View {
    @Environment(\.pixelLength) private var pixelLength
    var body: some View {
        VStack(spacing: 12) {
            VStack(spacing: 2) {
                Text("One-pixel hairline:")
                Rectangle().fill(.primary).frame(width: 160, height: pixelLength)
            }
            Text("pixelLength = \(Double(pixelLength), format: .number.precision(.fractionLength(3))) pt")
                .font(.callout.monospaced())
                .foregroundStyle(.secondary)
            L_Caption("1 ÷ displayScale — the thinnest rule that maps to a whole device pixel.")
        }
        .padding(.vertical, 6)
    }
}

// MARK: - ProjectionTransform

private struct L_ProjectionTransformExample: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("3D")
                .font(.system(size: 52, weight: .heavy))
                .foregroundStyle(.tint)
                .projectionEffect(L_perspective())
            L_Caption("A CATransform3D with perspective, flattened into a ProjectionTransform.")
        }
        .padding(.vertical, 6)
    }
    private func L_perspective() -> ProjectionTransform {
        var t = CATransform3DIdentity
        t.m34 = -1 / 500
        t = CATransform3DRotate(t, .pi / 6, 0, 1, 0)
        return ProjectionTransform(t)
    }
}

// MARK: - Custom Layout: BannerLayout (ProposedViewSize)

private struct L_BannerLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: LayoutSubviews, cache: inout ()) -> CGSize {
        let target = proposal.replacingUnspecifiedDimensions(by: CGSize(width: 300, height: 44))
        return CGSize(width: target.width, height: 44)
    }
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: LayoutSubviews, cache: inout ()) {
        for subview in subviews {
            subview.place(at: CGPoint(x: bounds.midX, y: bounds.midY), anchor: .center,
                          proposal: ProposedViewSize(width: bounds.width, height: 44))
        }
    }
}

private struct L_ProposedViewSizeExample: View {
    var body: some View {
        VStack(spacing: 8) {
            L_BannerLayout {
                Text("Fixed-height banner")
                    .frame(maxWidth: .infinity)
                    .background(.tint.opacity(0.2), in: .rect(cornerRadius: 8))
            }
            L_Caption("replacingUnspecifiedDimensions turns the nil proposal into a concrete width.")
        }
    }
}

// MARK: - SafeAreaRegions

private struct L_SafeAreaRegionsExample: View {
    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .top) {
                LinearGradient(colors: [.indigo, .purple], startPoint: .top, endPoint: .bottom)
                VStack(spacing: 2) {
                    Capsule().fill(.white.opacity(0.6)).frame(width: 44, height: 5)
                        .padding(.top, 6)
                    Text("status bar / sensor housing")
                        .font(.caption2).foregroundStyle(.white.opacity(0.85))
                        .padding(.top, 4)
                }
            }
            .frame(height: 96)
            .clipShape(.rect(cornerRadius: 12))
            L_Caption("Illustrative — .container lets art extend under system chrome; .keyboard is separate.")
        }
    }
}

// MARK: - ScrollGeometry

private struct L_ScrollGeometryExample: View {
    @State private var headerOpacity = 1.0
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Text("Sticky header")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(6)
                    .background(.tint.opacity(headerOpacity), in: .rect(cornerRadius: 8))
                    .foregroundStyle(.white)
            }
            ScrollView {
                VStack(spacing: 4) {
                    ForEach(0..<14, id: \.self) { i in
                        Text("Row \(i)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 8).padding(.vertical, 4)
                    }
                }
            }
            .onScrollGeometryChange(for: CGFloat.self) { geometry in
                geometry.contentOffset.y
            } action: { _, y in
                headerOpacity = max(0.15, 1 - y / 60)
            }
            .frame(height: 110)
            .background(.quaternary.opacity(0.3), in: .rect(cornerRadius: 10))
            L_Caption("Scroll — the header fades as ScrollGeometry.contentOffset.y grows.")
        }
    }
}

// MARK: - Subview

private struct L_HeroList<Content: View>: View {
    @ViewBuilder var content: Content
    var body: some View {
        Group(subviews: content) { subviews in
            VStack(alignment: .leading, spacing: 8) {
                if let hero = subviews.first {
                    hero.font(.headline).foregroundStyle(.tint)
                }
                HStack {
                    ForEach(subviews.dropFirst()) { $0 }
                }
                .font(.caption)
            }
        }
    }
}

private struct L_SubviewExample: View {
    var body: some View {
        VStack(spacing: 8) {
            L_HeroList {
                Text("Featured article")
                Text("Sports")
                Text("Weather")
                Text("Finance")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            L_Caption("Group(subviews:) styles the first child as a hero and lays out the rest.")
        }
    }
}

// MARK: - SubviewsCollection

private struct L_OverflowStack<Content: View>: View {
    @ViewBuilder var content: Content
    var body: some View {
        Group(subviews: content) { subviews in
            HStack(spacing: 6) {
                ForEach(subviews.prefix(4)) { $0 }
                if subviews.count > 4 {
                    Text("+\(subviews.count - 4) more")
                        .font(.caption).foregroundStyle(.secondary)
                }
            }
        }
    }
}

private struct L_SubviewsCollectionExample: View {
    var body: some View {
        VStack(spacing: 8) {
            L_OverflowStack {
                ForEach(0..<7, id: \.self) { i in
                    Circle().fill(.tint).frame(width: 28, height: 28)
                        .overlay(Text("\(i)").font(.caption2).foregroundStyle(.white))
                }
            }
            L_Caption("The collection is counted and sliced to show the first four plus an overflow.")
        }
    }
}

// MARK: - UnitPoint

private enum L_AnchorChoice: String, CaseIterable, Identifiable {
    case center, topLeading, bottomTrailing
    var id: Self { self }
    var point: UnitPoint {
        switch self {
        case .center: .center
        case .topLeading: .topLeading
        case .bottomTrailing: .bottomTrailing
        }
    }
}

private struct L_UnitPointExample: View {
    @State private var choice: L_AnchorChoice = .center
    var body: some View {
        VStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(colors: [.indigo, .cyan],
                                     startPoint: UnitPoint(x: 0.1, y: 0),
                                     endPoint: .bottomTrailing))
                .frame(height: 60)
                .overlay {
                    Circle().fill(.white.opacity(0.9)).frame(width: 26, height: 26)
                        .scaleEffect(1.6, anchor: choice.point)
                }
            Picker("Anchor", selection: $choice) {
                ForEach(L_AnchorChoice.allCases) { Text($0.rawValue).tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            L_Caption("The gradient uses UnitPoints; the dot scales from the chosen anchor.")
        }
    }
}

// MARK: - UserInterfaceSizeClass

private enum L_MockSizeClass: String, CaseIterable, Identifiable {
    case compact, regular
    var id: Self { self }
}

private struct L_UserInterfaceSizeClassExample: View {
    @State private var mock: L_MockSizeClass = .regular
    var body: some View {
        VStack(spacing: 10) {
            Picker("Size class", selection: $mock) {
                ForEach(L_MockSizeClass.allCases) { Text($0.rawValue).tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            Group {
                if mock == .compact {
                    VStack(spacing: 6) { L_Pane(title: "List", color: .blue); L_Pane(title: "Detail", color: .teal) }
                } else {
                    HStack(spacing: 6) { L_Pane(title: "Sidebar", color: .blue); L_Pane(title: "Detail", color: .teal) }
                }
            }
            .animation(.spring, value: mock)
            L_Caption("Illustrative — size classes are iOS/iPadOS; macOS is always regular.")
        }
    }
}

// MARK: - VerticalAlignment

private struct L_VerticalAlignmentExample: View {
    var body: some View {
        VStack(spacing: 12) {
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text("Total").font(.body).foregroundStyle(.secondary)
                Text("$42").font(.largeTitle.bold())
                Text(".00").font(.body).foregroundStyle(.secondary)
            }
            L_Caption("firstTextBaseline lines mixed-size text up on the real baseline.")
        }
    }
}

// MARK: - VerticalEdge

private struct L_VerticalEdgeExample: View {
    @State private var page = 3.0
    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.quaternary.opacity(0.5))
                .overlay(Text("Page \(Int(page))").font(.title3))
                .safeAreaInset(edge: VerticalEdge.bottom) {
                    HStack {
                        Image(systemName: "doc")
                        Slider(value: $page, in: 1...20)
                        Text("\(Int(page))/20").monospacedDigit()
                    }
                    .padding(8)
                    .background(.bar)
                }
                .frame(height: 130)
                .clipShape(.rect(cornerRadius: 10))
            L_Caption("VerticalEdge.bottom docks the scrubber below the page content.")
        }
    }
}

// MARK: - verticalSizeClass

private struct L_VerticalSizeClassExample: View {
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    private var label: String {
        switch verticalSizeClass {
        case .compact: "compact"
        case .regular: "regular"
        default: "nil (macOS reports no size class)"
        }
    }
    var body: some View {
        VStack(spacing: 10) {
            Label("verticalSizeClass: \(label)", systemImage: "rectangle.split.2x1")
                .padding(10)
                .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 8))
            L_Caption("Illustrative — on iPhone landscape this is .compact, flattening a VStack to an HStack.")
        }
    }
}

// MARK: - ViewDimensions

private struct L_ViewDimensionsExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Flush caption")
            Text("Offset by a quarter of its own width")
                .foregroundStyle(.tint)
                .alignmentGuide(.leading) { (d: ViewDimensions) in
                    d[.leading] + (d.width / 4)
                }
            L_Caption("The alignment closure reads ViewDimensions.width to compute the guide.")
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 10))
    }
}

// MARK: - ViewSpacing

private struct L_ViewSpacingExample: View {
    var body: some View {
        VStack(spacing: 8) {
            L_VerticalRail {
                Text("First").padding(8).background(.tint.opacity(0.2), in: .rect(cornerRadius: 6))
                Text("Second").padding(8).background(.tint.opacity(0.2), in: .rect(cornerRadius: 6))
                Text("Third").padding(8).background(.tint.opacity(0.2), in: .rect(cornerRadius: 6))
            }
            .frame(maxWidth: 180)
            L_Caption("The rail reports merged ViewSpacing and spaces rows by each pair's preferred gap.")
        }
    }
}
