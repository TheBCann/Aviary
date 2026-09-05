//
//  Examples+System.swift
//  Aviary
//
//  Rendered usage examples for CatalogData/gen-system.json.
//
//  Swift Charts examples render for real with inline sample data. APIs that
//  need live map tiles, App Store entitlements, or the photo library render
//  a captioned illustration while the code string shows the true API.
//

import SwiftUI
import Charts
import UniformTypeIdentifiers

// MARK: - Shared illustration for APIs that can't execute standalone

private struct Sy_Illustration: View {
    let icon: String
    let title: String
    let caption: String
    var tint: Color = .accentColor

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 34))
                .foregroundStyle(tint)
            Text(title)
                .font(.headline)
            Text(caption)
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

// MARK: - A faux map surface for MapKit illustrations

private struct Sy_MapCanvas<Overlay: View>: View {
    let caption: String
    @ViewBuilder var overlay: Overlay

    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                LinearGradient(colors: [Color(hue: 0.33, saturation: 0.18, brightness: 0.85),
                                        Color(hue: 0.55, saturation: 0.20, brightness: 0.80)],
                               startPoint: .top, endPoint: .bottom)
                // A few "roads" for map texture.
                Path { p in
                    p.move(to: CGPoint(x: 0, y: 70)); p.addLine(to: CGPoint(x: 240, y: 40))
                    p.move(to: CGPoint(x: 60, y: 0)); p.addLine(to: CGPoint(x: 120, y: 150))
                }
                .stroke(.white.opacity(0.5), lineWidth: 3)
                overlay
            }
            .frame(width: 240, height: 150)
            .clipShape(.rect(cornerRadius: 10))
            Text(caption).font(.caption2).foregroundStyle(.secondary)
        }
    }
}

// MARK: - Shared Swift Charts sample data

private struct Sy_Sale: Identifiable {
    let id = UUID()
    let month: String
    let revenue: Double
    let region: String
}

private let sy_sales: [Sy_Sale] = [
    .init(month: "Jan", revenue: 42, region: "North"),
    .init(month: "Feb", revenue: 55, region: "North"),
    .init(month: "Mar", revenue: 48, region: "North"),
    .init(month: "Jan", revenue: 30, region: "South"),
    .init(month: "Feb", revenue: 40, region: "South"),
    .init(month: "Mar", revenue: 62, region: "South"),
]

private struct Sy_Reading: Identifiable {
    let id = UUID()
    let day: Int
    let value: Double
}

private let sy_readings: [Sy_Reading] = (0..<12).map {
    .init(day: $0, value: 40 + 30 * sin(Double($0) / 2))
}

enum ExamplesSystem {
    static let entries: [ExampleEntry] = [

        // MARK: Swift Charts — marks

        ExampleEntry(topic: "BarMark", code: """
        Chart(sales) { sale in
            BarMark(
                x: .value("Month", sale.month),
                y: .value("Revenue", sale.revenue)
            )
            .foregroundStyle(by: .value("Region", sale.region))
        }
        """) { AnyView(Sy_BarMark()) },

        ExampleEntry(topic: "LineMark", code: """
        Chart(readings) { r in
            LineMark(x: .value("Day", r.day),
                     y: .value("Value", r.value))
            .interpolationMethod(.catmullRom)
        }
        """) { AnyView(Sy_LineMark()) },

        ExampleEntry(topic: "AreaMark", code: """
        Chart(readings) { r in
            AreaMark(x: .value("Day", r.day),
                     y: .value("Value", r.value))
            .foregroundStyle(.linearGradient(
                colors: [.teal, .clear],
                startPoint: .top, endPoint: .bottom))
        }
        """) { AnyView(Sy_AreaMark()) },

        ExampleEntry(topic: "PointMark", code: """
        Chart(samples) { s in
            PointMark(x: .value("Height", s.x),
                      y: .value("Weight", s.y))
            .symbol(by: .value("Group", s.group))
        }
        """) { AnyView(Sy_PointMark()) },

        ExampleEntry(topic: "RuleMark", code: """
        Chart(readings) { r in
            LineMark(x: .value("Day", r.day), y: .value("Value", r.value))
            RuleMark(y: .value("Threshold", 60))
                .lineStyle(StrokeStyle(lineWidth: 1, dash: [4]))
                .annotation(position: .top) { Text("Limit") }
        }
        """) { AnyView(Sy_RuleMark()) },

        ExampleEntry(topic: "RectangleMark", code: """
        Chart(bins) { bin in
            RectangleMark(
                xStart: .value("Start", bin.start),
                xEnd: .value("End", bin.end),
                yStart: .value("Low", bin.low),
                yEnd: .value("High", bin.high)
            )
        }
        """) { AnyView(Sy_RectangleMark()) },

        ExampleEntry(topic: "SectorMark", code: """
        Chart(shares) { share in
            SectorMark(
                angle: .value("Users", share.count),
                innerRadius: .ratio(0.6),
                angularInset: 1.5
            )
            .foregroundStyle(by: .value("Platform", share.platform))
        }
        """) { AnyView(Sy_SectorMark()) },

        ExampleEntry(topic: "PlottableValue", code: """
        let x = PlottableValue.value("Month", sale.month)
        let y = PlottableValue.value("Revenue", sale.revenue)

        BarMark(x: x, y: y)
        """) { AnyView(Sy_PlottableValue()) },

        ExampleEntry(topic: "AxisMarks", code: """
        .chartYAxis {
            AxisMarks(position: .leading) {
                AxisGridLine()
                AxisTick()
                AxisValueLabel()
            }
        }
        """) { AnyView(Sy_AxisMarks()) },

        ExampleEntry(topic: "ChartProxy", code: """
        .chartOverlay { proxy in
            // proxy.value(atX:) converts a touch x to a data value
            Color.clear
        }
        """) { AnyView(Sy_ChartProxy()) },

        // MARK: Swift Charts — modifiers

        ExampleEntry(topic: ".chartForegroundStyleScale()", code: """
        Chart(sales) { sale in
            BarMark(x: .value("Month", sale.month),
                    y: .value("Revenue", sale.revenue))
            .foregroundStyle(by: .value("Region", sale.region))
        }
        .chartForegroundStyleScale([
            "North": Color.blue, "South": Color.orange
        ])
        """) { AnyView(Sy_ForegroundScale()) },

        ExampleEntry(topic: ".chartLegend()", code: """
        Chart(sales) { sale in
            BarMark(x: .value("Month", sale.month),
                    y: .value("Revenue", sale.revenue))
            .foregroundStyle(by: .value("Region", sale.region))
        }
        .chartLegend(position: .bottom, alignment: .leading)
        """) { AnyView(Sy_Legend()) },

        ExampleEntry(topic: ".chartXAxis()", code: """
        Chart(readings) { r in
            LineMark(x: .value("Day", r.day), y: .value("Value", r.value))
        }
        .chartXAxis(.hidden)
        """) { AnyView(Sy_XAxisHidden()) },

        ExampleEntry(topic: ".chartYAxis()", code: """
        Chart(readings) { r in
            LineMark(x: .value("Day", r.day), y: .value("Value", r.value))
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        """) { AnyView(Sy_YAxisLeading()) },

        ExampleEntry(topic: ".chartXScale()", code: """
        Chart(readings) { r in
            LineMark(x: .value("Day", r.day), y: .value("Value", r.value))
        }
        .chartXScale(domain: 0...20)
        """) { AnyView(Sy_XScale()) },

        ExampleEntry(topic: ".chartYScale()", code: """
        Chart(readings) { r in
            LineMark(x: .value("Day", r.day), y: .value("Value", r.value))
        }
        .chartYScale(domain: 0...100)
        """) { AnyView(Sy_YScale()) },

        ExampleEntry(topic: ".chartPlotStyle()", code: """
        Chart(sales) { sale in
            BarMark(x: .value("Month", sale.month),
                    y: .value("Revenue", sale.revenue))
        }
        .chartPlotStyle { plotArea in
            plotArea.background(.quaternary.opacity(0.3))
        }
        """) { AnyView(Sy_PlotStyle()) },

        ExampleEntry(topic: ".chartBackground()", code: """
        Chart(readings) { r in
            LineMark(x: .value("Day", r.day), y: .value("Value", r.value))
        }
        .chartBackground { proxy in
            Text("12-day trend")
                .font(.caption2).foregroundStyle(.secondary)
        }
        """) { AnyView(Sy_Background()) },

        ExampleEntry(topic: ".chartOverlay()", code: """
        Chart(readings) { r in
            LineMark(x: .value("Day", r.day), y: .value("Value", r.value))
        }
        .chartOverlay { proxy in
            Color.clear.contentShape(Rectangle())
                .gesture(DragGesture().onChanged { drag in
                    let day: Int? = proxy.value(atX: drag.location.x)
                    scrub(to: day)
                })
        }
        """) { AnyView(Sy_Overlay()) },

        ExampleEntry(topic: ".chartXSelection()", code: """
        @State private var selectedDay: Int?

        Chart(readings) { r in
            LineMark(x: .value("Day", r.day), y: .value("Value", r.value))
            if let selectedDay {
                RuleMark(x: .value("Selected", selectedDay))
            }
        }
        .chartXSelection(value: $selectedDay)
        """) { AnyView(Sy_XSelection()) },

        ExampleEntry(topic: ".chartScrollableAxes()", code: """
        Chart(readings) { r in
            BarMark(x: .value("Day", r.day), y: .value("Value", r.value))
        }
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 6)
        """) { AnyView(Sy_Scrollable()) },

        // MARK: Drag & drop, pasteboard (macOS-native)

        ExampleEntry(topic: ".onDrag()", code: """
        Image(systemName: "doc")
            .onDrag { NSItemProvider(object: "report.pdf" as NSString) }
        """) { AnyView(Sy_OnDrag()) },

        ExampleEntry(topic: ".onDrop()", code: """
        @State private var isTargeted = false

        RoundedRectangle(cornerRadius: 10)
            .fill(isTargeted ? .blue.opacity(0.3) : .quaternary)
            .onDrop(of: [.text], isTargeted: $isTargeted) { providers in
                true
            }
        """) { AnyView(Sy_OnDrop()) },

        ExampleEntry(topic: ".copyable()", code: """
        Text(name)
            .focusable()
            .copyable([name])   // ⌘C places it on the pasteboard
        """) { AnyView(Sy_Copyable()) },

        ExampleEntry(topic: ".cuttable()", code: """
        Text(item.title)
            .focusable()
            .cuttable(for: String.self) {
                remove(item)
                return [item.title]
            }
        """) { AnyView(Sy_Cuttable()) },

        ExampleEntry(topic: ".pasteDestination()", code: """
        List(lines, id: \\.self) { Text($0) }
            .pasteDestination(for: String.self) { pasted in
                lines.append(contentsOf: pasted)
            }
        """) { AnyView(Sy_PasteDestination()) },

        // MARK: MapKit (illustrated — renders on a live map at runtime)

        ExampleEntry(topic: "Marker", code: """
        Map {
            Marker("Ferry Building", systemImage: "ferry",
                   coordinate: ferryBuilding)
                .tint(.teal)
        }
        """) { AnyView(Sy_Marker()) },

        ExampleEntry(topic: "Annotation", code: """
        Map {
            Annotation("HQ", coordinate: hq, anchor: .bottom) {
                Image(systemName: "building.2")
                    .padding(6)
                    .background(.thinMaterial, in: Circle())
            }
        }
        """) { AnyView(Sy_Annotation()) },

        ExampleEntry(topic: "MapCircle", code: """
        Map {
            MapCircle(center: dropZone, radius: 500)
                .foregroundStyle(.orange.opacity(0.25))
        }
        """) { AnyView(Sy_MapCircle()) },

        ExampleEntry(topic: "MapPolygon", code: """
        Map {
            MapPolygon(coordinates: campusBoundary)
                .foregroundStyle(.green.opacity(0.2))
        }
        """) { AnyView(Sy_MapPolygon()) },

        ExampleEntry(topic: "MapPolyline", code: """
        Map {
            MapPolyline(coordinates: routeCoordinates)
                .stroke(.blue, lineWidth: 4)
        }
        """) { AnyView(Sy_MapPolyline()) },

        ExampleEntry(topic: "UserAnnotation", code: """
        Map {
            UserAnnotation()
        }
        .mapControls { MapUserLocationButton() }
        """) { AnyView(Sy_UserAnnotation()) },

        ExampleEntry(topic: "MapReader", code: """
        MapReader { proxy in
            Map()
                .onTapGesture { point in
                    let coord = proxy.convert(point, from: .local)
                    addPin(at: coord)
                }
        }
        """) { AnyView(Sy_MapReader()) },

        ExampleEntry(topic: "MapCameraPosition", code: """
        @State private var position: MapCameraPosition = .region(
            MKCoordinateRegion(center: sanFrancisco,
                               span: .init(latitudeDelta: 0.05,
                                           longitudeDelta: 0.05)))

        Map(position: $position)
        """) { AnyView(Sy_CameraPosition()) },

        ExampleEntry(topic: "LookAroundPreview", code: """
        @State private var scene: MKLookAroundScene?

        LookAroundPreview(scene: $scene)
            .task {
                let request = MKLookAroundSceneRequest(coordinate: place)
                scene = try? await request.scene
            }
        """) { AnyView(Sy_LookAround()) },

        ExampleEntry(topic: ".mapStyle()", code: """
        Map {
            Marker("Camp", coordinate: camp)
        }
        .mapStyle(.hybrid(elevation: .realistic))
        """) { AnyView(Sy_MapStyle()) },

        ExampleEntry(topic: ".mapControls()", code: """
        Map(position: $position)
            .mapControls {
                MapCompass()
                MapScaleView()
                MapPitchToggle()
            }
        """) { AnyView(Sy_MapControls()) },

        ExampleEntry(topic: ".onMapCameraChange()", code: """
        Map(position: $position)
            .onMapCameraChange(frequency: .onEnd) { context in
                visibleRegion = context.region
            }
        """) { AnyView(Sy_MapCameraChange()) },

        // MARK: StoreKit (illustrated — renders live products at runtime)

        ExampleEntry(topic: "StoreView", code: """
        StoreView(ids: [
            "com.example.tipjar.small",
            "com.example.tipjar.large"
        ])
        """) { AnyView(Sy_StoreView()) },

        ExampleEntry(topic: "SubscriptionStoreView", code: """
        SubscriptionStoreView(groupID: "21534970") {
            MarketingHeader()
        }
        .storeButton(.visible, for: .restorePurchases)
        .subscriptionStoreControlStyle(.prominentPicker)
        """) { AnyView(Sy_SubscriptionStore()) },

        ExampleEntry(topic: ".productViewStyle()", code: """
        ProductView(id: "com.example.pro.lifetime")
            .productViewStyle(.large)
        """) { AnyView(Sy_ProductViewStyle()) },

        ExampleEntry(topic: ".storeButton()", code: """
        SubscriptionStoreView(groupID: groupID)
            .storeButton(.visible, for: .redeemCode)
            .storeButton(.hidden, for: .cancellation)
        """) { AnyView(Sy_StoreButton()) },

        ExampleEntry(topic: ".subscriptionStoreControlStyle()", code: """
        SubscriptionStoreView(groupID: groupID)
            .subscriptionStoreControlStyle(.buttons)
        """) { AnyView(Sy_SubControlStyle()) },

        ExampleEntry(topic: ".onInAppPurchaseCompletion()", code: """
        ProductView(id: "com.example.pro")
            .onInAppPurchaseCompletion { product, result in
                if case .success(.success(let verification)) = result {
                    await entitlements.process(verification)
                }
            }
        """) { AnyView(Sy_PurchaseCompletion()) },

        ExampleEntry(topic: ".manageSubscriptionsSheet()", code: """
        Button("Manage Subscription") { showing = true }
            .manageSubscriptionsSheet(isPresented: $showing)
        """) { AnyView(Sy_ManageSubs()) },

        ExampleEntry(topic: ".offerCodeRedemption()", code: """
        Button("Redeem Code") { redeeming = true }
            .offerCodeRedemption(isPresented: $redeeming) { result in
                print(result)
            }
        """) { AnyView(Sy_OfferCode()) },

        ExampleEntry(topic: ".refundRequestSheet()", code: """
        Button("Report a Problem") { showing = true }
            .refundRequestSheet(for: transaction.id,
                                isPresented: $showing) { result in
                log(result)
            }
        """) { AnyView(Sy_Refund()) },

        ExampleEntry(topic: ".appStoreOverlay()", code: """
        ContentBanner()
            .appStoreOverlay(isPresented: $showing) {
                SKOverlay.AppConfiguration(appIdentifier: "1234567890",
                                           position: .bottom)
            }
        """) { AnyView(Sy_AppStoreOverlay()) },

        // MARK: TipKit (illustrated)

        ExampleEntry(topic: "TipView", code: """
        struct FavoriteTip: Tip {
            var title: Text { Text("Save Favorites") }
            var message: Text? { Text("Tap the star to keep it handy.") }
        }

        TipView(FavoriteTip(), arrowEdge: .top)
        """) { AnyView(Sy_TipView()) },

        ExampleEntry(topic: "Tip", code: """
        struct RenameTip: Tip {
            var title: Text { Text("Rename Anywhere") }
            var message: Text? { Text("Double-click a name to edit it.") }
            var image: Image? { Image(systemName: "pencil") }
        }
        """) { AnyView(Sy_Tip()) },

        ExampleEntry(topic: ".popoverTip()", code: """
        Button {
            toggleFavorite()
        } label: {
            Image(systemName: "star")
        }
        .popoverTip(FavoriteTip())
        """) { AnyView(Sy_PopoverTip()) },

        // MARK: PhotosUI, QuickLook (illustrated)

        ExampleEntry(topic: ".photosPicker()", code: """
        @State private var selection: PhotosPickerItem?

        LibraryGrid()
            .photosPicker(isPresented: $showing,
                          selection: $selection,
                          matching: .images)
        """) { AnyView(Sy_PhotosPicker()) },

        ExampleEntry(topic: "PhotosPickerItem", code: """
        if let item = selection,
           let data = try? await item.loadTransferable(type: Data.self) {
            avatar = data
        }
        """) { AnyView(Sy_PhotosPickerItem()) },

        ExampleEntry(topic: ".quickLookPreview()", code: """
        @State private var previewURL: URL?

        Button("Preview") { previewURL = fileURL }
            .quickLookPreview($previewURL)
        """) { AnyView(Sy_QuickLook()) },

        // MARK: Representables & widget/system (illustrated)

        ExampleEntry(topic: "NSViewControllerRepresentable", code: """
        struct LegacyPane: NSViewControllerRepresentable {
            func makeNSViewController(context: Context) -> NSViewController {
                InspectorController()
            }
            func updateNSViewController(_ c: NSViewController,
                                        context: Context) {}
        }
        """) { AnyView(Sy_NSRepresentable()) },

        ExampleEntry(topic: "UIViewControllerRepresentable", code: """
        struct SafariView: UIViewControllerRepresentable {
            let url: URL
            func makeUIViewController(context: Context) -> SFSafariViewController {
                SFSafariViewController(url: url)
            }
            func updateUIViewController(_ vc: SFSafariViewController,
                                        context: Context) {}
        }
        """) { AnyView(Sy_UIRepresentable()) },

        ExampleEntry(topic: ".widgetURL()", code: """
        Gauge(value: progress) { Text("Goal") }
            .widgetURL(URL(string: "habit://today"))
        """) { AnyView(Sy_WidgetURL()) },

        ExampleEntry(topic: ".persistentSystemOverlays()", code: """
        VideoScrubber()
            .persistentSystemOverlays(.hidden)
        """) { AnyView(Sy_PersistentOverlays()) },
    ]
}

// MARK: - Chart example views

private struct Sy_BarMark: View {
    var body: some View {
        Chart(sy_sales) { sale in
            BarMark(x: .value("Month", sale.month), y: .value("Revenue", sale.revenue))
                .foregroundStyle(by: .value("Region", sale.region))
        }
        .frame(height: 180)
    }
}

private struct Sy_LineMark: View {
    var body: some View {
        Chart(sy_readings) { r in
            LineMark(x: .value("Day", r.day), y: .value("Value", r.value))
                .interpolationMethod(.catmullRom)
        }
        .frame(height: 180)
    }
}

private struct Sy_AreaMark: View {
    var body: some View {
        Chart(sy_readings) { r in
            AreaMark(x: .value("Day", r.day), y: .value("Value", r.value))
                .foregroundStyle(.linearGradient(colors: [.teal, .clear],
                                                 startPoint: .top, endPoint: .bottom))
        }
        .frame(height: 180)
    }
}

private struct Sy_Scatter: Identifiable {
    let id = UUID(); let x: Double; let y: Double; let group: String
}
private let sy_scatter: [Sy_Scatter] = [
    .init(x: 1, y: 2, group: "A"), .init(x: 2, y: 3, group: "A"),
    .init(x: 3, y: 2.5, group: "B"), .init(x: 4, y: 4, group: "B"),
    .init(x: 2.5, y: 1.5, group: "A"), .init(x: 3.5, y: 3.2, group: "B"),
]

private struct Sy_PointMark: View {
    var body: some View {
        Chart(sy_scatter) { s in
            PointMark(x: .value("Height", s.x), y: .value("Weight", s.y))
                .symbol(by: .value("Group", s.group))
        }
        .frame(height: 180)
    }
}

private struct Sy_RuleMark: View {
    var body: some View {
        Chart(sy_readings) { r in
            LineMark(x: .value("Day", r.day), y: .value("Value", r.value))
            RuleMark(y: .value("Threshold", 60))
                .lineStyle(StrokeStyle(lineWidth: 1, dash: [4]))
                .annotation(position: .top) { Text("Limit").font(.caption2) }
        }
        .frame(height: 180)
    }
}

private struct Sy_Bin: Identifiable {
    let id = UUID(); let start: Double; let end: Double; let low: Double; let high: Double
}
private struct Sy_RectangleMark: View {
    private let bins: [Sy_Bin] = [
        .init(start: 0, end: 2, low: 1, high: 4),
        .init(start: 2, end: 4, low: 2, high: 5),
        .init(start: 4, end: 6, low: 0, high: 3),
    ]
    var body: some View {
        Chart(bins) { bin in
            RectangleMark(xStart: .value("Start", bin.start), xEnd: .value("End", bin.end),
                          yStart: .value("Low", bin.low), yEnd: .value("High", bin.high))
                .foregroundStyle(.indigo.opacity(0.5))
        }
        .frame(height: 180)
    }
}

private struct Sy_Share: Identifiable {
    let id = UUID(); let platform: String; let count: Double
}
private struct Sy_SectorMark: View {
    private let shares: [Sy_Share] = [
        .init(platform: "iOS", count: 62), .init(platform: "macOS", count: 24),
        .init(platform: "watchOS", count: 14),
    ]
    var body: some View {
        Chart(shares) { share in
            SectorMark(angle: .value("Users", share.count),
                       innerRadius: .ratio(0.6), angularInset: 1.5)
                .foregroundStyle(by: .value("Platform", share.platform))
        }
        .frame(height: 180)
    }
}

private struct Sy_PlottableValue: View {
    var body: some View {
        Chart(sy_sales.filter { $0.region == "North" }) { sale in
            BarMark(x: PlottableValue.value("Month", sale.month),
                    y: PlottableValue.value("Revenue", sale.revenue))
        }
        .frame(height: 180)
    }
}

private struct Sy_AxisMarks: View {
    var body: some View {
        Chart(sy_readings) { r in
            LineMark(x: .value("Day", r.day), y: .value("Value", r.value))
        }
        .chartYAxis {
            AxisMarks(position: .leading) {
                AxisGridLine(); AxisTick(); AxisValueLabel()
            }
        }
        .frame(height: 180)
    }
}

private struct Sy_ChartProxy: View {
    @State private var picked: Int?
    var body: some View {
        VStack(spacing: 6) {
            Chart(sy_readings) { r in
                LineMark(x: .value("Day", r.day), y: .value("Value", r.value))
                if let picked {
                    RuleMark(x: .value("Day", picked)).foregroundStyle(.orange)
                }
            }
            .chartOverlay { proxy in
                Color.clear.contentShape(Rectangle())
                    .onTapGesture { location in
                        picked = proxy.value(atX: location.x)
                    }
            }
            .frame(height: 150)
            Text(picked.map { "Tapped day \($0)" } ?? "Tap the chart — ChartProxy maps the point to a day")
                .font(.caption2).foregroundStyle(.secondary)
        }
    }
}

private struct Sy_ForegroundScale: View {
    var body: some View {
        Chart(sy_sales) { sale in
            BarMark(x: .value("Month", sale.month), y: .value("Revenue", sale.revenue))
                .foregroundStyle(by: .value("Region", sale.region))
        }
        .chartForegroundStyleScale(["North": Color.blue, "South": Color.orange])
        .frame(height: 180)
    }
}

private struct Sy_Legend: View {
    var body: some View {
        Chart(sy_sales) { sale in
            BarMark(x: .value("Month", sale.month), y: .value("Revenue", sale.revenue))
                .foregroundStyle(by: .value("Region", sale.region))
        }
        .chartLegend(position: .bottom, alignment: .leading)
        .frame(height: 180)
    }
}

private struct Sy_XAxisHidden: View {
    var body: some View {
        Chart(sy_readings) { r in
            LineMark(x: .value("Day", r.day), y: .value("Value", r.value))
        }
        .chartXAxis(.hidden)
        .frame(height: 180)
    }
}

private struct Sy_YAxisLeading: View {
    var body: some View {
        Chart(sy_readings) { r in
            LineMark(x: .value("Day", r.day), y: .value("Value", r.value))
        }
        .chartYAxis { AxisMarks(position: .leading) }
        .frame(height: 180)
    }
}

private struct Sy_XScale: View {
    var body: some View {
        Chart(sy_readings) { r in
            LineMark(x: .value("Day", r.day), y: .value("Value", r.value))
        }
        .chartXScale(domain: 0...20)
        .frame(height: 180)
    }
}

private struct Sy_YScale: View {
    var body: some View {
        Chart(sy_readings) { r in
            LineMark(x: .value("Day", r.day), y: .value("Value", r.value))
        }
        .chartYScale(domain: 0...100)
        .frame(height: 180)
    }
}

private struct Sy_PlotStyle: View {
    var body: some View {
        Chart(sy_sales) { sale in
            BarMark(x: .value("Month", sale.month), y: .value("Revenue", sale.revenue))
        }
        .chartPlotStyle { plotArea in
            plotArea.background(.quaternary.opacity(0.3))
        }
        .frame(height: 180)
    }
}

private struct Sy_Background: View {
    var body: some View {
        Chart(sy_readings) { r in
            LineMark(x: .value("Day", r.day), y: .value("Value", r.value))
        }
        .chartBackground { _ in
            Text("12-day trend").font(.caption2).foregroundStyle(.secondary)
        }
        .frame(height: 180)
    }
}

private struct Sy_Overlay: View {
    @State private var day: Int?
    var body: some View {
        VStack(spacing: 6) {
            Chart(sy_readings) { r in
                LineMark(x: .value("Day", r.day), y: .value("Value", r.value))
            }
            .chartOverlay { proxy in
                Color.clear.contentShape(Rectangle())
                    .gesture(DragGesture().onChanged { drag in
                        day = proxy.value(atX: drag.location.x)
                    })
            }
            .frame(height: 150)
            Text(day.map { "Scrubbing day \($0)" } ?? "Drag across the plot")
                .font(.caption2).foregroundStyle(.secondary)
        }
    }
}

private struct Sy_XSelection: View {
    @State private var selectedDay: Int?
    var body: some View {
        Chart(sy_readings) { r in
            LineMark(x: .value("Day", r.day), y: .value("Value", r.value))
            if let selectedDay {
                RuleMark(x: .value("Selected", selectedDay)).foregroundStyle(.orange)
            }
        }
        .chartXSelection(value: $selectedDay)
        .frame(height: 180)
    }
}

private struct Sy_Scrollable: View {
    var body: some View {
        Chart(sy_readings) { r in
            BarMark(x: .value("Day", r.day), y: .value("Value", r.value))
        }
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 6)
        .frame(height: 180)
    }
}

// MARK: - Drag & drop, pasteboard views

private struct Sy_OnDrag: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "doc.fill")
                .font(.system(size: 40))
                .foregroundStyle(.blue)
                .onDrag { NSItemProvider(object: "report.pdf" as NSString) }
            Text("Drag the document onto another app").font(.caption2).foregroundStyle(.secondary)
        }
    }
}

private struct Sy_OnDrop: View {
    @State private var isTargeted = false
    @State private var dropped = 0
    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 10)
                .fill(isTargeted ? Color.blue.opacity(0.3) : Color.quaternaryLabelFill)
                .frame(width: 200, height: 80)
                .overlay(Text(dropped == 0 ? "Drop text here" : "Received \(dropped)"))
                .onDrop(of: [.text], isTargeted: $isTargeted) { _ in dropped += 1; return true }
        }
    }
}

private extension Color {
    static var quaternaryLabelFill: Color { Color(.quaternaryLabelColor) }
}

private struct Sy_Copyable: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("Ada Lovelace").font(.title3).focusable().copyable(["Ada Lovelace"])
            Text("Focus it and press ⌘C").font(.caption2).foregroundStyle(.secondary)
        }
    }
}

private struct Sy_Cuttable: View {
    @State private var title = "Draft note"
    var body: some View {
        VStack(spacing: 8) {
            Text(title).font(.title3).focusable()
                .cuttable(for: String.self) { title = "(cut)"; return ["Draft note"] }
            Text("Focus it and press ⌘X").font(.caption2).foregroundStyle(.secondary)
        }
    }
}

private struct Sy_PasteDestination: View {
    @State private var lines = ["First line"]
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(lines, id: \.self) { Text($0).font(.callout) }
            Text("Focus and press ⌘V to append pasted text")
                .font(.caption2).foregroundStyle(.secondary)
        }
        .focusable()
        .pasteDestination(for: String.self) { lines.append(contentsOf: $0) }
    }
}

// MARK: - MapKit illustrations

private struct Sy_Marker: View {
    var body: some View {
        Sy_MapCanvas(caption: "Illustrative — a Marker balloon on a live Map") {
            Image(systemName: "mappin.circle.fill")
                .font(.system(size: 30)).foregroundStyle(.teal)
                .background(Circle().fill(.white).padding(3))
        }
    }
}

private struct Sy_Annotation: View {
    var body: some View {
        Sy_MapCanvas(caption: "Illustrative — a custom Annotation view on a live Map") {
            Image(systemName: "building.2")
                .padding(6).background(.thinMaterial, in: Circle())
        }
    }
}

private struct Sy_MapCircle: View {
    var body: some View {
        Sy_MapCanvas(caption: "Illustrative — MapCircle overlay (500 m radius)") {
            Circle().fill(.orange.opacity(0.25)).frame(width: 90, height: 90)
        }
    }
}

private struct Sy_MapPolygon: View {
    var body: some View {
        Sy_MapCanvas(caption: "Illustrative — MapPolygon region fill") {
            Path { p in
                p.move(to: CGPoint(x: 90, y: 40)); p.addLine(to: CGPoint(x: 160, y: 70))
                p.addLine(to: CGPoint(x: 130, y: 120)); p.addLine(to: CGPoint(x: 80, y: 100)); p.closeSubpath()
            }.fill(.green.opacity(0.35))
        }
    }
}

private struct Sy_MapPolyline: View {
    var body: some View {
        Sy_MapCanvas(caption: "Illustrative — MapPolyline route") {
            Path { p in
                p.move(to: CGPoint(x: 30, y: 120)); p.addCurve(to: CGPoint(x: 210, y: 40),
                    control1: CGPoint(x: 100, y: 130), control2: CGPoint(x: 130, y: 20))
            }.stroke(.blue, lineWidth: 4)
        }
    }
}

private struct Sy_UserAnnotation: View {
    var body: some View {
        Sy_MapCanvas(caption: "Illustrative — the system user-location indicator") {
            ZStack {
                Circle().fill(.blue.opacity(0.2)).frame(width: 60, height: 60)
                Circle().fill(.blue).frame(width: 16, height: 16)
                    .overlay(Circle().stroke(.white, lineWidth: 2))
            }
        }
    }
}

private struct Sy_MapReader: View {
    var body: some View {
        Sy_MapCanvas(caption: "Illustrative — MapReader converts taps to coordinates") {
            Image(systemName: "hand.tap").font(.title).foregroundStyle(.white)
        }
    }
}

private struct Sy_CameraPosition: View {
    var body: some View {
        Sy_MapCanvas(caption: "Illustrative — MapCameraPosition frames San Francisco") {
            Image(systemName: "camera.viewfinder").font(.largeTitle).foregroundStyle(.white)
        }
    }
}

private struct Sy_LookAround: View {
    var body: some View {
        Sy_MapCanvas(caption: "Illustrative — LookAroundPreview street scene") {
            Image(systemName: "binoculars.fill").font(.largeTitle).foregroundStyle(.white)
        }
    }
}

private struct Sy_MapStyle: View {
    var body: some View {
        Sy_MapCanvas(caption: "Illustrative — .mapStyle(.hybrid) satellite imagery") {
            Image(systemName: "globe.americas.fill").font(.largeTitle).foregroundStyle(.white)
        }
    }
}

private struct Sy_MapControls: View {
    var body: some View {
        Sy_MapCanvas(caption: "Illustrative — compass, scale, and pitch controls") {
            VStack { Image(systemName: "location.north.circle.fill"); Image(systemName: "ruler") }
                .foregroundStyle(.white)
        }
    }
}

private struct Sy_MapCameraChange: View {
    var body: some View {
        Sy_MapCanvas(caption: "Illustrative — reports the region after panning") {
            Image(systemName: "arrow.up.and.down.and.arrow.left.and.right")
                .font(.title).foregroundStyle(.white)
        }
    }
}

// MARK: - StoreKit illustrations

private struct Sy_StorePlaceholder: View {
    let title: String
    let subtitle: String
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                RoundedRectangle(cornerRadius: 8).fill(.blue.gradient).frame(width: 44, height: 44)
                    .overlay(Image(systemName: "star.fill").foregroundStyle(.white))
                VStack(alignment: .leading) {
                    Text(title).font(.headline)
                    Text(subtitle).font(.caption).foregroundStyle(.secondary)
                }
                Spacer()
                Text("$4.99").padding(.horizontal, 12).padding(.vertical, 6)
                    .background(.blue, in: .capsule).foregroundStyle(.white).font(.callout.bold())
            }
            .padding().background(.background.secondary, in: .rect(cornerRadius: 12))
            Text("Illustrative — StoreKit renders live App Store products")
                .font(.caption2).foregroundStyle(.secondary)
        }
    }
}

private struct Sy_StoreView: View { var body: some View { Sy_StorePlaceholder(title: "Tip Jar", subtitle: "Support development") } }
private struct Sy_SubscriptionStore: View { var body: some View { Sy_StorePlaceholder(title: "Pro Subscription", subtitle: "Monthly · auto-renews") } }
private struct Sy_ProductViewStyle: View { var body: some View { Sy_StorePlaceholder(title: "Lifetime Pro", subtitle: "One-time purchase") } }
private struct Sy_StoreButton: View { var body: some View { Sy_StorePlaceholder(title: "Subscription", subtitle: "with Redeem Code shown") } }
private struct Sy_SubControlStyle: View { var body: some View { Sy_StorePlaceholder(title: "Subscription", subtitle: "buttons control style") } }
private struct Sy_PurchaseCompletion: View { var body: some View { Sy_Illustration(icon: "checkmark.seal.fill", title: "Purchase Completion", caption: "Illustrative — fires when a StoreKit purchase finishes", tint: .green) } }
private struct Sy_ManageSubs: View { var body: some View { Sy_Illustration(icon: "creditcard", title: "Manage Subscriptions", caption: "Illustrative — opens the system subscription sheet") } }
private struct Sy_OfferCode: View { var body: some View { Sy_Illustration(icon: "ticket", title: "Redeem Offer Code", caption: "Illustrative — presents the code-redemption sheet") } }
private struct Sy_Refund: View { var body: some View { Sy_Illustration(icon: "arrow.uturn.backward.circle", title: "Refund Request", caption: "Illustrative — presents Apple's refund flow") } }
private struct Sy_AppStoreOverlay: View { var body: some View { Sy_Illustration(icon: "square.and.arrow.up.on.square", title: "App Store Overlay", caption: "Illustrative — recommends another app (iOS only)") } }

// MARK: - TipKit illustrations

private struct Sy_TipBubble: View {
    let title: String
    let message: String
    let icon: String
    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .top, spacing: 10) {
                Image(systemName: icon).foregroundStyle(.blue)
                VStack(alignment: .leading, spacing: 2) {
                    Text(title).font(.callout.bold())
                    Text(message).font(.caption).foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "xmark").font(.caption2).foregroundStyle(.tertiary)
            }
            .padding().background(.background.secondary, in: .rect(cornerRadius: 12))
            .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(.quaternary))
            Text("Illustrative — a TipKit tip").font(.caption2).foregroundStyle(.secondary)
        }
    }
}

private struct Sy_TipView: View { var body: some View { Sy_TipBubble(title: "Save Favorites", message: "Tap the star to keep it handy.", icon: "star") } }
private struct Sy_Tip: View { var body: some View { Sy_TipBubble(title: "Rename Anywhere", message: "Double-click a name to edit it in place.", icon: "pencil") } }
private struct Sy_PopoverTip: View { var body: some View { Sy_TipBubble(title: "Save Favorites", message: "Tap the star to keep it handy.", icon: "star") } }

// MARK: - PhotosUI, QuickLook illustrations

private struct Sy_PhotosPicker: View { var body: some View { Sy_Illustration(icon: "photo.on.rectangle.angled", title: "Photos Picker", caption: "Illustrative — opens the out-of-process photo library") } }
private struct Sy_PhotosPickerItem: View { var body: some View { Sy_Illustration(icon: "photo", title: "PhotosPickerItem", caption: "Illustrative — loads the picked asset via Transferable") } }
private struct Sy_QuickLook: View { var body: some View { Sy_Illustration(icon: "eye.circle", title: "Quick Look Preview", caption: "Illustrative — presents the system file preview") } }

// MARK: - Representable & system illustrations

private struct Sy_NSRepresentable: View { var body: some View { Sy_Illustration(icon: "macwindow", title: "NSViewControllerRepresentable", caption: "Illustrative — hosts an AppKit view controller in SwiftUI") } }
private struct Sy_UIRepresentable: View { var body: some View { Sy_Illustration(icon: "iphone", title: "UIViewControllerRepresentable", caption: "Illustrative — hosts a UIKit view controller (iOS)") } }
private struct Sy_WidgetURL: View { var body: some View { Sy_Illustration(icon: "link", title: "Widget Deep Link", caption: "Illustrative — the URL a tapped widget opens") } }
private struct Sy_PersistentOverlays: View { var body: some View { Sy_Illustration(icon: "rectangle.portrait.slash", title: "Hide System Overlays", caption: "Illustrative — requests the Home indicator hide (iOS)") } }
