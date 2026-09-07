//
//  ChildExamples+Part03.swift
//  Aviary
//
//  Compiled renderings for variant entries (part 03: gen-system — Swift Charts,
//  MapKit, StoreKit, TipKit, PhotosUI and the view-controller representables).
//  One private C03_* struct per variant; every rendering exercises the exact
//  overload the variant names, so siblings can be compared side by side.
//  Variants that need live data (map tiles, StoreKit products, picker results,
//  a configured TipKit datastore) keep the real call in their code string and
//  render a captioned illustration.
//

import SwiftUI
import Charts
import MapKit
import AppKit
import TipKit

enum ChildExamplesPart03 {
    static let entries: [ChildExampleEntry] = [

        // MARK: ChartProxy

        ChildExampleEntry(parent: "ChartProxy", child: "plotFrame", code: """
        Chart(readings) { r in
            LineMark(x: .value("Day", r.day), y: .value("Level", r.value))
        }
        .chartBackground { proxy in
            GeometryReader { geo in
                if let anchor = proxy.plotFrame {      // Anchor<CGRect>?
                    let frame = geo[anchor]            // resolved in the reader's space
                    Rectangle().fill(.yellow.opacity(0.18))
                        .frame(width: frame.width, height: frame.height)
                        .offset(x: frame.minX, y: frame.minY)
                }
            }
        }
        """) { AnyView(C03_PlotFrameExample()) },

        // MARK: LineMark

        ChildExampleEntry(parent: "LineMark", child: "LineMark(x:y:)", code: """
        Chart(prices) { p in
            LineMark(x: .value("Day", p.day),
                     y: .value("Close", p.value))
        }
        """) { AnyView(C03_LineMarkXYExample()) },

        ChildExampleEntry(parent: "LineMark", child: "LineMark(x:y:series:)", code: """
        Chart(runs) { r in
            LineMark(x: .value("Km", r.day),
                     y: .value("Pace", r.value),
                     series: .value("Run", r.series))   // separate lines, one shared style
            .foregroundStyle(.gray.opacity(0.6))
        }
        """) { AnyView(C03_LineMarkSeriesExample()) },

        ChildExampleEntry(parent: "LineMark", child: ".interpolationMethod(_:)", code: """
        Chart(levels) { d in
            LineMark(x: .value("Day", d.day), y: .value("Level", d.value))
                .interpolationMethod(method)
            PointMark(x: .value("Day", d.day), y: .value("Level", d.value))
        }
        // .linear, .monotone, .catmullRom, .cardinal, .stepStart, .stepCenter, .stepEnd
        """) { AnyView(C03_InterpolationMethodExample()) },

        ChildExampleEntry(parent: "LineMark", child: ".lineStyle(_:)", code: """
        Chart(forecast) { d in
            LineMark(x: .value("Day", d.day), y: .value("Forecast", d.value))
                .lineStyle(StrokeStyle(lineWidth: 2, dash: [6, 4]))
        }
        """) { AnyView(C03_LineStyleExample()) },

        // MARK: PlottableValue

        ChildExampleEntry(parent: "PlottableValue", child: "PlottableValue.value(_:_:)", code: """
        func bar(for quarter: Quarter) -> some ChartContent {
            let x: PlottableValue<String> = .value("Quarter", quarter.name)
            let y: PlottableValue<Double> = .value("Revenue", quarter.revenue)
            return BarMark(x: x, y: y)
        }

        Chart(quarters) { bar(for: $0) }
        """) { AnyView(C03_PlottableValueExample()) },

        ChildExampleEntry(parent: "PlottableValue", child: "Plottable.primitivePlottable", code: """
        enum Weekday: String, CaseIterable, Plottable {
            case mon, tue, wed, thu, fri
            var primitivePlottable: String { rawValue.capitalized }   // what the axis scales
            init?(primitivePlottable: String) {
                self.init(rawValue: primitivePlottable.lowercased())
            }
        }

        Chart(entries) { e in
            BarMark(x: .value("Day", e.day), y: .value("Steps", e.steps))   // e.day: Weekday
        }
        """) { AnyView(C03_PrimitivePlottableExample()) },

        ChildExampleEntry(parent: "PlottableValue", child: "Plottable.init?(primitivePlottable:)", code: """
        @State private var selected: Weekday?

        Chart(entries) { e in
            BarMark(x: .value("Day", e.day), y: .value("Steps", e.steps))
                .opacity(selected == nil || selected == e.day ? 1 : 0.35)
        }
        .chartXSelection(value: $selected)   // rebuilds a Weekday via init?(primitivePlottable:)
        """) { AnyView(C03_PlottableInitExample()) },

        // MARK: PointMark

        ChildExampleEntry(parent: "PointMark", child: "PointMark(x:y:)", code: """
        Chart(specimens) { s in
            PointMark(x: .value("Height", s.height),
                      y: .value("Weight", s.weight))
        }
        """) { AnyView(C03_PointMarkXYExample()) },

        ChildExampleEntry(parent: "PointMark", child: ".symbol(_:)", code: """
        PointMark(x: .value("Height", s.height), y: .value("Weight", s.weight))
            .symbol(shape)
        // .circle, .square, .triangle, .diamond, .pentagon, .plus, .cross, .asterisk
        """) { AnyView(C03_SymbolShapeExample()) },

        ChildExampleEntry(parent: "PointMark", child: ".symbol(by:)", code: """
        PointMark(x: .value("Height", s.height), y: .value("Weight", s.weight))
            .symbol(by: .value("Species", s.species))   // glyph per category + legend
        """) { AnyView(C03_SymbolByExample()) },

        ChildExampleEntry(parent: "PointMark", child: ".symbolSize(by:)", code: """
        PointMark(x: .value("Height", s.height), y: .value("Weight", s.weight))
            .symbolSize(by: .value("Population", s.population))   // area scales with the value
        """) { AnyView(C03_SymbolSizeByExample()) },

        // MARK: RectangleMark

        ChildExampleEntry(parent: "RectangleMark", child: "RectangleMark(x:y:width:height:)", code: """
        Chart(cells) { cell in
            RectangleMark(x: .value("Hour", cell.hour),
                          y: .value("Day", cell.day),
                          width: .ratio(0.9),
                          height: .ratio(0.9))
            .foregroundStyle(by: .value("Load", cell.load))
        }
        """) { AnyView(C03_RectangleMarkXYExample()) },

        ChildExampleEntry(parent: "RectangleMark", child: "RectangleMark(xStart:xEnd:yStart:yEnd:)", code: """
        Chart {
            RectangleMark(xStart: .value("From", 3),
                          xEnd: .value("To", 5),
                          yStart: .value("Low", 0),
                          yEnd: .value("High", 7))
                .foregroundStyle(.gray.opacity(0.15))
            ForEach(levels) { d in
                LineMark(x: .value("Day", d.day), y: .value("Level", d.value))
            }
        }
        """) { AnyView(C03_RectangleMarkRangeExample()) },

        ChildExampleEntry(parent: "RectangleMark", child: "RectangleMark(x:yStart:yEnd:width:)", code: """
        Chart(candles) { c in
            RectangleMark(x: .value("Day", c.date, unit: .day),
                          yStart: .value("Open", c.open),
                          yEnd: .value("Close", c.close),
                          width: .ratio(0.6))
            .foregroundStyle(c.close >= c.open ? Color.green : Color.red)
        }
        """) { AnyView(C03_RectangleMarkCandleExample()) },

        // MARK: RuleMark

        ChildExampleEntry(parent: "RuleMark", child: "RuleMark(y:)", code: """
        Chart {
            ForEach(levels) { d in
                BarMark(x: .value("Day", d.day), y: .value("Level", d.value))
            }
            RuleMark(y: .value("Average", average))
                .lineStyle(StrokeStyle(lineWidth: 1, dash: [4]))
                .foregroundStyle(.secondary)
        }
        """) { AnyView(C03_RuleMarkYExample()) },

        ChildExampleEntry(parent: "RuleMark", child: "RuleMark(x:)", code: """
        Chart {
            ForEach(levels) { d in
                LineMark(x: .value("Day", d.day), y: .value("Level", d.value))
            }
            if let selectedDay {
                RuleMark(x: .value("Selected", selectedDay))
                    .foregroundStyle(.gray)
                    .zIndex(-1)
            }
        }
        .chartXSelection(value: $selectedDay)
        """) { AnyView(C03_RuleMarkXExample()) },

        ChildExampleEntry(parent: "RuleMark", child: "RuleMark(x:yStart:yEnd:)", code: """
        Chart(samples) { s in
            RuleMark(x: .value("Trial", s.trial),
                     yStart: .value("Min", s.min),
                     yEnd: .value("Max", s.max))
            PointMark(x: .value("Trial", s.trial), y: .value("Mean", s.mean))
        }
        """) { AnyView(C03_RuleMarkSegmentExample()) },

        ChildExampleEntry(parent: "RuleMark", child: ".annotation(position:alignment:spacing:content:)", code: """
        RuleMark(y: .value("Limit", 80))
            .foregroundStyle(.red)
            .annotation(position: .topTrailing, alignment: .trailing, spacing: 2) {
                Text("Limit")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        """) { AnyView(C03_RuleMarkAnnotationExample()) },

        // MARK: SectorMark

        ChildExampleEntry(parent: "SectorMark", child: "SectorMark(angle:innerRadius:outerRadius:angularInset:)", code: """
        Chart(shares) { share in
            SectorMark(angle: .value("Users", share.count),
                       innerRadius: .ratio(0.6),
                       outerRadius: .ratio(1.0),
                       angularInset: 1.5)
            .foregroundStyle(by: .value("Platform", share.platform))
        }
        """) { AnyView(C03_SectorMarkExample()) },

        ChildExampleEntry(parent: "SectorMark", child: ".cornerRadius(_:style:)", code: """
        SectorMark(angle: .value("Share", item.count),
                   innerRadius: .ratio(0.5),
                   angularInset: 2)
            .cornerRadius(radius, style: .continuous)
            .foregroundStyle(by: .value("Platform", item.platform))
        """) { AnyView(C03_SectorCornerRadiusExample()) },

        ChildExampleEntry(parent: "SectorMark", child: ".chartAngleSelection(value:)", code: """
        @State private var selectedCount: Int?

        Chart(shares) { share in
            SectorMark(angle: .value("Users", share.count), innerRadius: .ratio(0.6))
                .opacity(isSelected(share) ? 1 : 0.5)
                .foregroundStyle(by: .value("Platform", share.platform))
        }
        .chartAngleSelection(value: $selectedCount)   // angle-domain value under the pointer
        """) { AnyView(C03_ChartAngleSelectionExample()) },

        // MARK: LookAroundPreview

        ChildExampleEntry(parent: "LookAroundPreview", child: "LookAroundPreview(scene:allowsNavigation:showsRoadLabels:pointsOfInterest:badgePosition:)", code: """
        @State private var scene: MKLookAroundScene?   // swap in a new scene → the card updates

        LookAroundPreview(scene: $scene,
                          allowsNavigation: true,
                          showsRoadLabels: false,
                          pointsOfInterest: .all,
                          badgePosition: .bottomTrailing)
            .frame(height: 140)
        """) { AnyView(C03_LookAroundSceneBindingExample()) },

        ChildExampleEntry(parent: "LookAroundPreview", child: "LookAroundPreview(initialScene:allowsNavigation:showsRoadLabels:pointsOfInterest:badgePosition:)", code: """
        if let scene = place.lookAroundScene {          // fixed for the life of the view
            LookAroundPreview(initialScene: scene,
                              allowsNavigation: false,
                              showsRoadLabels: true,
                              pointsOfInterest: .excludingAll,
                              badgePosition: .topLeading)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        """) { AnyView(C03_LookAroundInitialSceneExample()) },

        // MARK: MapCameraPosition

        ChildExampleEntry(parent: "MapCameraPosition", child: "MapCameraPosition.camera()", code: """
        let peak = CLLocationCoordinate2D(latitude: 46.8523, longitude: -121.7603)

        position = .camera(
            MapCamera(centerCoordinate: peak,
                      distance: 1200, heading: heading, pitch: 60)
        )
        // position.camera?.heading reads back what was set
        """) { AnyView(C03_CameraHeadingExample()) },

        ChildExampleEntry(parent: "MapCameraPosition", child: "MapCameraPosition.userLocation()", code: """
        position = .userLocation(fallback: .automatic)
        // position.followsUserLocation == true; the fallback shows until a fix arrives
        """) { AnyView(C03_UserLocationPositionExample()) },

        ChildExampleEntry(parent: "MapCameraPosition", child: "MapCameraPosition.region(_:)", code: """
        position = .region(MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: 2000,
            longitudinalMeters: 2000))
        // position.region?.span gives the framed extent back
        """) { AnyView(C03_RegionPositionExample()) },

        ChildExampleEntry(parent: "MapCameraPosition", child: "MapCameraPosition.camera(_:)", code: """
        position = .camera(
            MapCamera(centerCoordinate: peak,
                      distance: 1200,
                      heading: 90,
                      pitch: pitch)          // 0 = top-down, larger = more tilt
        )
        """) { AnyView(C03_CameraPitchExample()) },

        // MARK: MapCircle

        ChildExampleEntry(parent: "MapCircle", child: "MapCircle(center:radius:)", code: """
        Map {
            MapCircle(center: store.coordinate, radius: 250)   // meters
                .foregroundStyle(.blue.opacity(0.2))
                .stroke(.blue, lineWidth: 2)
        }
        """) { AnyView(C03_MapCircleCenterRadiusExample()) },

        ChildExampleEntry(parent: "MapCircle", child: "MapCircle(_:)", code: """
        let geofence = MKCircle(center: home, radius: 100)   // existing MapKit overlay

        Map {
            MapCircle(geofence)
                .foregroundStyle(.green.opacity(0.3))
        }
        """) { AnyView(C03_MapCircleMKCircleExample()) },

        ChildExampleEntry(parent: "MapCircle", child: ".mapOverlayLevel(level:)", code: """
        Map {
            MapCircle(center: center, radius: 800)
                .foregroundStyle(.red.opacity(0.35))
                .mapOverlayLevel(level: level)   // .aboveRoads or .aboveLabels
        }
        """) { AnyView(C03_MapOverlayLevelExample()) },

        // MARK: MapPolygon

        ChildExampleEntry(parent: "MapPolygon", child: "MapPolygon(coordinates:)", code: """
        Map {
            MapPolygon(coordinates: parkOutline)   // [CLLocationCoordinate2D], last edge closes itself
                .foregroundStyle(.green.opacity(0.25))
                .stroke(.green, lineWidth: 2)
        }
        """) { AnyView(C03_MapPolygonCoordinatesExample()) },

        ChildExampleEntry(parent: "MapPolygon", child: "MapPolygon(points:)", code: """
        let corners = boundary.map { MKMapPoint($0) }   // projected map space

        Map {
            MapPolygon(points: corners)
                .foregroundStyle(.purple.opacity(0.2))
        }
        """) { AnyView(C03_MapPolygonPointsExample()) },

        ChildExampleEntry(parent: "MapPolygon", child: "MapPolygon(_:)", code: """
        let shape = MKPolygon(coordinates: outline, count: outline.count)   // e.g. decoded from GeoJSON

        Map {
            MapPolygon(shape)
                .foregroundStyle(.orange.opacity(0.3))
        }
        """) { AnyView(C03_MapPolygonMKPolygonExample()) },

        // MARK: MapPolyline

        ChildExampleEntry(parent: "MapPolyline", child: "MapPolyline(coordinates:contourStyle:)", code: """
        Map {
            MapPolyline(coordinates: [tokyo, sanFrancisco],
                        contourStyle: .geodesic)     // great-circle arc; .straight for segments
                .stroke(.orange, lineWidth: 3)
        }
        """) { AnyView(C03_MapPolylineContourExample()) },

        ChildExampleEntry(parent: "MapPolyline", child: "MapPolyline(_ route: MKRoute)", code: """
        Map {
            if let route {                    // MKRoute from MKDirections.calculate()
                MapPolyline(route)
                    .stroke(.blue, lineWidth: 5)
            }
        }
        """) { AnyView(C03_MapPolylineRouteExample()) },

        ChildExampleEntry(parent: "MapPolyline", child: "MapPolyline(_ polyline: MKPolyline)", code: """
        let track = MKPolyline(coordinates: gpsPoints, count: gpsPoints.count)

        Map {
            MapPolyline(track)
                .stroke(.red, lineWidth: 2)
        }
        """) { AnyView(C03_MapPolylineMKPolylineExample()) },

        ChildExampleEntry(parent: "MapPolyline", child: ".stroke(_:style:)", code: """
        MapPolyline(coordinates: plannedRoute)
            .stroke(.gray, style: StrokeStyle(lineWidth: 4,
                                              lineCap: .round,
                                              dash: [8, 8]))
        """) { AnyView(C03_MapPolylineStrokeStyleExample()) },

        // MARK: MapReader

        ChildExampleEntry(parent: "MapReader", child: "MapProxy.convert(_ point:from:)", code: """
        MapReader { proxy in
            Map()
                .onTapGesture { screenPoint in
                    if let coordinate = proxy.convert(screenPoint, from: .local) {
                        addPin(at: coordinate)          // nil when the point misses the map
                    }
                }
        }
        """) { AnyView(C03_MapProxyPointToCoordinateExample()) },

        ChildExampleEntry(parent: "MapReader", child: "MapProxy.convert(_ coordinate:to:)", code: """
        MapReader { proxy in
            Map()
                .overlay(alignment: .topLeading) {
                    if let p = proxy.convert(landmark, to: .local) {
                        Text("Here").position(p)        // SwiftUI content pinned to a coordinate
                    }
                }
        }
        """) { AnyView(C03_MapProxyCoordinateToPointExample()) },

        ChildExampleEntry(parent: "MapReader", child: "MapProxy.convert(_ rect:from:)", code: """
        MapReader { proxy in
            Map(position: $position)
                .onTapGesture {
                    let box = CGRect(x: 0, y: 0, width: 200, height: 200)
                    selectedRegion = proxy.convert(box, from: .local)   // MKCoordinateRegion?
                }
        }
        """) { AnyView(C03_MapProxyRectToRegionExample()) },

        // MARK: Marker

        ChildExampleEntry(parent: "Marker", child: "Marker(item:)", code: """
        Map {
            Marker(item: coffeeShopItem)   // MKMapItem: name + category glyph/tint come from the place
        }
        """) { AnyView(C03_MarkerItemExample()) },

        ChildExampleEntry(parent: "Marker", child: "Marker(_:coordinate:)", code: """
        Map {
            Marker("Ferry Building", coordinate: ferryBuilding)   // default pin glyph
        }
        """) { AnyView(C03_MarkerTitleCoordinateExample()) },

        ChildExampleEntry(parent: "Marker", child: "Marker(_:systemImage:coordinate:)", code: """
        Map {
            Marker("Trailhead", systemImage: "figure.hiking",
                   coordinate: trailhead)
                .tint(.green)
        }
        """) { AnyView(C03_MarkerSystemImageExample()) },

        ChildExampleEntry(parent: "Marker", child: "Marker(_:monogram:coordinate:)", code: """
        Map {
            ForEach(Array(stops.enumerated()), id: \\.offset) { index, stop in
                Marker(stop.name, monogram: Text("\\(index + 1)"),
                       coordinate: stop.coordinate)
            }
        }
        """) { AnyView(C03_MarkerMonogramExample()) },

        // MARK: NSViewControllerRepresentable

        ChildExampleEntry(parent: "NSViewControllerRepresentable", child: "makeNSViewController(context:)", code: """
        func makeNSViewController(context: Context) -> BadgeController {
            let controller = BadgeController()                       // runs once per view identity
            controller.headline.stringValue = "Made at " + Date.now.formatted(date: .omitted, time: .standard)
            return controller
        }
        // updateNSViewController only rewrites `detail`, so the headline never changes
        """) { AnyView(C03_MakeNSViewControllerExample()) },

        ChildExampleEntry(parent: "NSViewControllerRepresentable", child: "updateNSViewController(_:context:)", code: """
        func updateNSViewController(_ controller: BadgeController, context: Context) {
            controller.headline.stringValue = String(format: "zoom %.2f", zoom)          // SwiftUI state in
            controller.detail.stringValue = context.environment.controlSize == .small
                ? "controlSize: .small" : "controlSize: .regular"                         // environment in
        }
        """) { AnyView(C03_UpdateNSViewControllerExample()) },

        ChildExampleEntry(parent: "NSViewControllerRepresentable", child: "makeCoordinator()", code: """
        func makeCoordinator() -> Coordinator { Coordinator(taps: $taps) }

        func makeNSViewController(context: Context) -> ButtonController {
            let controller = ButtonController()
            controller.button.target = context.coordinator          // AppKit → coordinator
            controller.button.action = #selector(Coordinator.tapped)
            return controller
        }

        final class Coordinator: NSObject {
            @Binding var taps: Int
            init(taps: Binding<Int>) { _taps = taps }
            @objc func tapped() { taps += 1 }                        // coordinator → SwiftUI
        }
        """) { AnyView(C03_MakeCoordinatorExample()) },

        ChildExampleEntry(parent: "NSViewControllerRepresentable", child: "sizeThatFits(_:nsViewController:context:)", code: """
        func sizeThatFits(_ proposal: ProposedViewSize,
                          nsViewController: BadgeController,
                          context: Context) -> CGSize? {
            CGSize(width: proposal.width ?? 200, height: 56)   // take the width, insist on 56 pt tall
        }
        """) { AnyView(C03_SizeThatFitsExample()) },

        // MARK: PhotosPickerItem

        ChildExampleEntry(parent: "PhotosPickerItem", child: "loadTransferable(type:)", code: """
        if let item = selection,
           let data = try? await item.loadTransferable(type: Data.self),
           let image = NSImage(data: data) {
            avatar = image
        }
        """) { AnyView(C03_LoadTransferableAsyncExample()) },

        ChildExampleEntry(parent: "PhotosPickerItem", child: "loadTransferable(type:completionHandler:)", code: """
        let progress = item.loadTransferable(type: Data.self) { result in   // returns Progress
            if case .success(let data?) = result {
                Task { @MainActor in imageData = data }
            }
        }
        ProgressView(progress)
        """) { AnyView(C03_LoadTransferableProgressExample()) },

        ChildExampleEntry(parent: "PhotosPickerItem", child: "supportedContentTypes", code: """
        if item.supportedContentTypes.contains(.livePhoto) {
            livePhoto = try? await item.loadTransferable(type: PHLivePhoto.self)
        } else {
            imageData = try? await item.loadTransferable(type: Data.self)
        }
        """) { AnyView(C03_SupportedContentTypesExample()) },

        ChildExampleEntry(parent: "PhotosPickerItem", child: "itemIdentifier", code: """
        PhotosPicker("Choose", selection: $selection, photoLibrary: .shared())   // library → identifiers

        if let id = item.itemIdentifier {
            let result = PHAsset.fetchAssets(withLocalIdentifiers: [id], options: nil)
            asset = result.firstObject
        }
        """) { AnyView(C03_ItemIdentifierExample()) },

        // MARK: StoreView

        ChildExampleEntry(parent: "StoreView", child: "StoreView(ids:prefersPromotionalIcon:)", code: """
        StoreView(ids: ["com.example.tip.small", "com.example.tip.large"],
                  prefersPromotionalIcon: prefersPromotionalIcon)   // App Store Connect promo image as each row's icon
        """) { AnyView(C03_StoreViewIDsExample()) },

        ChildExampleEntry(parent: "StoreView", child: "StoreView(products:prefersPromotionalIcon:)", code: """
        // loadedProducts: [Product] from an earlier Product.products(for:) call
        StoreView(products: loadedProducts,
                  prefersPromotionalIcon: false)   // no second round trip to the App Store
            .productViewStyle(.compact)
        """) { AnyView(C03_StoreViewProductsExample()) },

        ChildExampleEntry(parent: "StoreView", child: "StoreView(ids:prefersPromotionalIcon:icon:)", code: """
        StoreView(ids: ["com.example.bundle.basic", "com.example.bundle.pro"],
                  prefersPromotionalIcon: false) { product in
            Image(systemName: product.id.hasSuffix("pro") ? "crown.fill" : "star.fill")   // your icon per Product
                .font(.title2)
                .foregroundStyle(product.id.hasSuffix("pro") ? Color.yellow : Color.blue)
        }
        """) { AnyView(C03_StoreViewIconExample()) },

        // MARK: SubscriptionStoreView

        ChildExampleEntry(parent: "SubscriptionStoreView", child: "SubscriptionStoreView(groupID:visibleRelationships:)", code: """
        SubscriptionStoreView(groupID: "21534970",
                              visibleRelationships: relationships)   // .all, .upgrade, .downgrade, .crossgrade, .current
        // Filtered against the subscriber's current plan (Pro here): .upgrade lists only higher tiers
        """) { AnyView(C03_SubscriptionRelationshipsExample()) },

        ChildExampleEntry(parent: "SubscriptionStoreView", child: "SubscriptionStoreView(groupID:visibleRelationships:marketingContent:)", code: """
        SubscriptionStoreView(groupID: "21534970", visibleRelationships: .all) {
            VStack(spacing: 6) {                                   // replaces the default icon + title header
                LinearGradient(colors: [.purple, .blue], startPoint: .leading, endPoint: .trailing)
                    .frame(height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                Text("Unlock everything").font(.headline)
            }
        }
        """) { AnyView(C03_SubscriptionMarketingExample()) },

        ChildExampleEntry(parent: "SubscriptionStoreView", child: "SubscriptionStoreView(productIDs:)", code: """
        SubscriptionStoreView(productIDs: [
            "com.example.pro.monthly",     // only these two plans are merchandised,
            "com.example.pro.yearly"       // not the whole subscription group
        ])
        """) { AnyView(C03_SubscriptionProductIDsExample()) },

        ChildExampleEntry(parent: "SubscriptionStoreView", child: "SubscriptionStoreView(subscriptions:)", code: """
        SubscriptionStoreView(subscriptions: proPlans)       // [Product] you already fetched — no built-in load
            .subscriptionStoreControlStyle(.prominentPicker)
        """) { AnyView(C03_SubscriptionProductsExample()) },

        // MARK: Tip

        ChildExampleEntry(parent: "Tip", child: "Tip.rules", code: """
        struct ExportTip: Tip {
            @Parameter static var hasCreatedProject: Bool = false
            var title: Text { Text("Export Anytime") }
            var rules: [Rule] {
                #Rule(Self.$hasCreatedProject) { $0 == true }   // every rule must hold before the tip may show
            }
        }

        ExportTip.hasCreatedProject = true     // flipping the parameter re-evaluates the rule
        """) { AnyView(C03_TipRulesExample()) },

        ChildExampleEntry(parent: "Tip", child: "Tip.options", code: """
        var options: [TipOption] {
            [Tips.MaxDisplayCount(3),               // retire the tip after three showings
             Tips.IgnoresDisplayFrequency(true)]    // skip the app-wide displayFrequency spacing
        }
        """) { AnyView(C03_TipOptionsExample()) },

        ChildExampleEntry(parent: "Tip", child: "Tip.actions", code: """
        var actions: [Tips.Action] {
            [Tips.Action(id: "learn", title: "Learn More")]
        }

        TipView(ExportTip()) { action in
            if action.id == "learn" { showHelp = true }    // the id comes back in the closure
        }
        """) { AnyView(C03_TipActionsExample()) },

        ChildExampleEntry(parent: "Tip", child: "invalidate(reason:)", code: """
        Button("Export") {
            export()
            ExportTip().invalidate(reason: .actionPerformed)   // retired for good — it never shows again
        }
        // other reasons: .displayCountExceeded, .tipClosed
        """) { AnyView(C03_TipInvalidateExample()) },

        // MARK: TipView

        ChildExampleEntry(parent: "TipView", child: "TipView(_:arrowEdge:action:)", code: """
        TipView(RenameTip(), arrowEdge: arrowEdge) { action in     // nil, .top or .bottom
            if action.id == "learn" { showHelp = true }
        }
        """) { AnyView(C03_TipViewArrowEdgeExample()) },

        ChildExampleEntry(parent: "TipView", child: ".tipViewStyle(_:)", code: """
        TipView(SyncTip())                       // default inline card

        TipView(SyncTip())
            .tipViewStyle(.miniature)            // title + glyph only, for tight spaces
        """) { AnyView(C03_TipViewStyleExample()) },

        ChildExampleEntry(parent: "TipView", child: ".tipBackground(_:)", code: """
        TipView(SyncTip())
            .tipBackground(style)   // any ShapeStyle: .blue.opacity(0.1), .mint.gradient, .regularMaterial
        """) { AnyView(C03_TipBackgroundExample()) },

        ChildExampleEntry(parent: "TipView", child: ".tipCornerRadius(_:antialiased:)", code: """
        TipView(SyncTip())
            .tipCornerRadius(radius, antialiased: true)
        """) { AnyView(C03_TipCornerRadiusExample()) },

        // MARK: UIViewControllerRepresentable

        ChildExampleEntry(parent: "UIViewControllerRepresentable", child: "makeUIViewController(context:)", code: """
        func makeUIViewController(context: Context) -> UIPageViewController {
            let pager = UIPageViewController(transitionStyle: .scroll,
                                             navigationOrientation: .horizontal)
            pager.dataSource = context.coordinator          // runs once per view identity
            return pager
        }
        """) { AnyView(C03_MakeUIViewControllerExample()) },

        ChildExampleEntry(parent: "UIViewControllerRepresentable", child: "updateUIViewController(_:context:)", code: """
        func updateUIViewController(_ pager: UIPageViewController, context: Context) {
            let target = context.coordinator.controllers[currentIndex]        // SwiftUI state in
            pager.setViewControllers([target], direction: .forward, animated: true)
        }
        """) { AnyView(C03_UpdateUIViewControllerExample()) },

        ChildExampleEntry(parent: "UIViewControllerRepresentable", child: "makeCoordinator()", code: """
        func makeCoordinator() -> Coordinator { Coordinator(pages: pages) }

        final class Coordinator: NSObject, UIPageViewControllerDataSource {
            let controllers: [UIViewController]
            init(pages: [AnyView]) { controllers = pages.map { UIHostingController(rootView: $0) } }
            func pageViewController(_ pager: UIPageViewController,
                                    viewControllerAfter vc: UIViewController) -> UIViewController? {
                let next = (controllers.firstIndex(of: vc) ?? -1) + 1        // + viewControllerBefore
                return next < controllers.count ? controllers[next] : nil
            }
        }
        """) { AnyView(C03_MakeCoordinatorUIExample()) },

        ChildExampleEntry(parent: "UIViewControllerRepresentable", child: "sizeThatFits(_:uiViewController:context:)", code: """
        func sizeThatFits(_ proposal: ProposedViewSize,
                          uiViewController: UIPageViewController,
                          context: Context) -> CGSize? {
            CGSize(width: proposal.width ?? 320, height: 56)   // take the width, insist on 56 pt tall
        }
        """) { AnyView(C03_SizeThatFitsUIExample()) },

        // MARK: UserAnnotation

        ChildExampleEntry(parent: "UserAnnotation", child: "UserAnnotation()", code: """
        Map(position: $position) {
            UserAnnotation()          // the system's pulsing blue puck at the device location
        }
        """) { AnyView(C03_UserAnnotationExample()) },

        ChildExampleEntry(parent: "UserAnnotation", child: "UserAnnotation(anchor:content:)", code: """
        Map {
            UserAnnotation(anchor: anchor) { location in         // UserLocation: coordinate + heading
                Image(systemName: "location.north.fill")
                    .rotationEffect(.degrees(location.heading?.trueHeading ?? 0))
            }
        }
        """) { AnyView(C03_UserAnnotationContentExample()) },

        // C03_END_ENTRIES
    ]
}

// MARK: - Shared chart data

private struct C03_Sample: Identifiable {
    let id = UUID()
    var day: Int
    var value: Double
    var series: String = "A"
}

private struct C03_Specimen: Identifiable {
    let id = UUID()
    var height: Double
    var weight: Double
    var species: String
    var population: Double
}

private enum C03_Weekday: String, CaseIterable, Plottable {
    case mon, tue, wed, thu, fri
    var primitivePlottable: String { rawValue.capitalized }
    init?(primitivePlottable: String) {
        self.init(rawValue: primitivePlottable.lowercased())
    }
}

private struct C03_StepEntry: Identifiable {
    let id = UUID()
    var day: C03_Weekday
    var steps: Int
}

private enum C03_Data {
    static let week: [C03_Sample] = [3.2, 4.1, 2.8, 5.0, 4.4, 6.1, 5.6]
        .enumerated().map { C03_Sample(day: $0.offset + 1, value: $0.element) }

    static let runs: [C03_Sample] =
        [8.2, 7.9, 8.4, 8.0, 7.6].enumerated().map { C03_Sample(day: $0.offset + 1, value: $0.element, series: "Run 1") } +
        [8.6, 8.5, 8.1, 8.3, 7.9].enumerated().map { C03_Sample(day: $0.offset + 1, value: $0.element, series: "Run 2") }

    static let specimens: [C03_Specimen] = [
        C03_Specimen(height: 12, weight: 3.1, species: "Finch", population: 40),
        C03_Specimen(height: 14, weight: 3.6, species: "Finch", population: 120),
        C03_Specimen(height: 15, weight: 4.0, species: "Finch", population: 260),
        C03_Specimen(height: 18, weight: 4.4, species: "Finch", population: 80),
        C03_Specimen(height: 21, weight: 6.2, species: "Thrush", population: 300),
        C03_Specimen(height: 23, weight: 6.9, species: "Thrush", population: 150),
        C03_Specimen(height: 25, weight: 7.5, species: "Thrush", population: 500),
        C03_Specimen(height: 27, weight: 8.4, species: "Thrush", population: 60),
    ]

    static let steps: [C03_StepEntry] = [
        C03_StepEntry(day: .mon, steps: 6200), C03_StepEntry(day: .tue, steps: 8100),
        C03_StepEntry(day: .wed, steps: 4700), C03_StepEntry(day: .thu, steps: 9900),
        C03_StepEntry(day: .fri, steps: 7300),
    ]
}

// MARK: - ChartProxy

private struct C03_PlotFrameExample: View {
    var body: some View {
        Chart(C03_Data.week) { r in
            LineMark(x: .value("Day", r.day), y: .value("Level", r.value))
        }
        .chartBackground { proxy in
            GeometryReader { geo in
                if let anchor = proxy.plotFrame {
                    let frame = geo[anchor]
                    Rectangle().fill(.yellow.opacity(0.18))
                        .frame(width: frame.width, height: frame.height)
                        .offset(x: frame.minX, y: frame.minY)
                }
            }
        }
        .frame(height: 150)
        .padding()
    }
}

// MARK: - LineMark

private struct C03_LineMarkXYExample: View {
    var body: some View {
        Chart(C03_Data.week) { p in
            LineMark(x: .value("Day", p.day),
                     y: .value("Close", p.value))
        }
        .frame(height: 150)
        .padding()
    }
}

private struct C03_LineMarkSeriesExample: View {
    var body: some View {
        Chart(C03_Data.runs) { r in
            LineMark(x: .value("Km", r.day),
                     y: .value("Pace", r.value),
                     series: .value("Run", r.series))
            .foregroundStyle(.gray.opacity(0.6))
        }
        .chartYScale(domain: 7...9)
        .frame(height: 150)
        .padding()
    }
}

private struct C03_InterpolationMethodExample: View {
    @State private var index = 1
    private let methods: [(name: String, method: InterpolationMethod)] = [
        (name: "linear", method: .linear), (name: "monotone", method: .monotone),
        (name: "catmullRom", method: .catmullRom), (name: "cardinal", method: .cardinal),
        (name: "stepStart", method: .stepStart), (name: "stepCenter", method: .stepCenter),
        (name: "stepEnd", method: .stepEnd),
    ]

    var body: some View {
        VStack(spacing: 8) {
            Picker("Method", selection: $index) {
                ForEach(methods.indices, id: \.self) { i in
                    Text(".\(methods[i].name)").tag(i)
                }
            }
            .pickerStyle(.menu)
            Chart(C03_Data.week) { d in
                LineMark(x: .value("Day", d.day), y: .value("Level", d.value))
                    .interpolationMethod(methods[index].method)
                PointMark(x: .value("Day", d.day), y: .value("Level", d.value))
            }
            .frame(height: 130)
        }
        .padding()
    }
}

private struct C03_LineStyleExample: View {
    var body: some View {
        Chart(C03_Data.week) { d in
            LineMark(x: .value("Day", d.day), y: .value("Forecast", d.value))
                .lineStyle(StrokeStyle(lineWidth: 2, dash: [6, 4]))
        }
        .frame(height: 150)
        .padding()
    }
}

// MARK: - PlottableValue

private struct C03_PlottableValueExample: View {
    private struct Quarter: Identifiable {
        let id = UUID()
        var name: String
        var revenue: Double
    }

    private let quarters = [
        Quarter(name: "Q1", revenue: 42), Quarter(name: "Q2", revenue: 58),
        Quarter(name: "Q3", revenue: 51), Quarter(name: "Q4", revenue: 73),
    ]

    private func bar(for quarter: Quarter) -> some ChartContent {
        let x: PlottableValue<String> = .value("Quarter", quarter.name)
        let y: PlottableValue<Double> = .value("Revenue", quarter.revenue)
        return BarMark(x: x, y: y)
    }

    var body: some View {
        Chart(quarters) { bar(for: $0) }
            .frame(height: 150)
            .padding()
    }
}

private struct C03_PrimitivePlottableExample: View {
    var body: some View {
        VStack(spacing: 6) {
            Chart(C03_Data.steps) { e in
                BarMark(x: .value("Day", e.day), y: .value("Steps", e.steps))
            }
            .frame(height: 130)
            Text("Axis labels come from primitivePlottable: \"Mon\", \"Tue\", …")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C03_PlottableInitExample: View {
    @State private var selected: C03_Weekday?

    var body: some View {
        VStack(spacing: 6) {
            Chart(C03_Data.steps) { e in
                BarMark(x: .value("Day", e.day), y: .value("Steps", e.steps))
                    .opacity(selected == nil || selected == e.day ? 1 : 0.35)
            }
            .chartXSelection(value: $selected)
            .frame(height: 130)
            Text("selected: \(selected.map { ".\($0.rawValue)" } ?? "nil") — hover or drag over the bars")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

// MARK: - PointMark

private struct C03_PointMarkXYExample: View {
    var body: some View {
        Chart(C03_Data.specimens) { s in
            PointMark(x: .value("Height", s.height),
                      y: .value("Weight", s.weight))
        }
        .frame(height: 150)
        .padding()
    }
}

private struct C03_SymbolShapeExample: View {
    @State private var index = 3
    private let shapes: [(name: String, shape: BasicChartSymbolShape)] = [
        (name: "circle", shape: .circle), (name: "square", shape: .square),
        (name: "triangle", shape: .triangle), (name: "diamond", shape: .diamond),
        (name: "pentagon", shape: .pentagon), (name: "plus", shape: .plus),
        (name: "cross", shape: .cross), (name: "asterisk", shape: .asterisk),
    ]

    var body: some View {
        VStack(spacing: 8) {
            Picker("Symbol", selection: $index) {
                ForEach(shapes.indices, id: \.self) { i in
                    Text(".\(shapes[i].name)").tag(i)
                }
            }
            .pickerStyle(.menu)
            Chart(C03_Data.specimens) { s in
                PointMark(x: .value("Height", s.height), y: .value("Weight", s.weight))
                    .symbol(shapes[index].shape)
                    .symbolSize(90)
            }
            .frame(height: 130)
        }
        .padding()
    }
}

private struct C03_SymbolByExample: View {
    var body: some View {
        Chart(C03_Data.specimens) { s in
            PointMark(x: .value("Height", s.height), y: .value("Weight", s.weight))
                .symbol(by: .value("Species", s.species))
                .symbolSize(80)
        }
        .frame(height: 150)
        .padding()
    }
}

private struct C03_SymbolSizeByExample: View {
    var body: some View {
        Chart(C03_Data.specimens) { s in
            PointMark(x: .value("Height", s.height), y: .value("Weight", s.weight))
                .symbolSize(by: .value("Population", s.population))
                .foregroundStyle(.blue.opacity(0.6))
        }
        .frame(height: 150)
        .padding()
    }
}

// MARK: - RectangleMark

private struct C03_RectangleMarkXYExample: View {
    private struct Cell: Identifiable {
        let id = UUID()
        var hour: String
        var day: String
        var load: Double
    }

    private let cells: [Cell] = {
        let hours = ["8", "10", "12", "14", "16"]
        let days = ["Mon", "Tue", "Wed"]
        let loads: [Double] = [0.2, 0.5, 0.9, 0.7, 0.3,
                               0.1, 0.4, 0.8, 1.0, 0.5,
                               0.3, 0.6, 0.7, 0.6, 0.2]
        var out: [Cell] = []
        for (d, day) in days.enumerated() {
            for (h, hour) in hours.enumerated() {
                out.append(Cell(hour: hour, day: day, load: loads[d * hours.count + h]))
            }
        }
        return out
    }()

    var body: some View {
        Chart(cells) { cell in
            RectangleMark(x: .value("Hour", cell.hour),
                          y: .value("Day", cell.day),
                          width: .ratio(0.9),
                          height: .ratio(0.9))
            .foregroundStyle(by: .value("Load", cell.load))
        }
        .frame(height: 150)
        .padding()
    }
}

private struct C03_RectangleMarkRangeExample: View {
    var body: some View {
        Chart {
            RectangleMark(xStart: .value("From", 3),
                          xEnd: .value("To", 5),
                          yStart: .value("Low", 0),
                          yEnd: .value("High", 7))
                .foregroundStyle(.gray.opacity(0.15))
            ForEach(C03_Data.week) { d in
                LineMark(x: .value("Day", d.day), y: .value("Level", d.value))
            }
        }
        .frame(height: 150)
        .padding()
    }
}

private struct C03_RectangleMarkCandleExample: View {
    private struct Candle: Identifiable {
        let id = UUID()
        var date: Date
        var open: Double
        var close: Double
    }

    private let candles: [Candle] = {
        let base = Date(timeIntervalSince1970: 1_700_000_000)
        let pairs: [(Double, Double)] = [(10, 12), (12, 11), (11, 14), (14, 13), (13, 16), (16, 15), (15, 18)]
        return pairs.enumerated().map { i, p in
            Candle(date: base.addingTimeInterval(Double(i) * 86_400), open: p.0, close: p.1)
        }
    }()

    var body: some View {
        Chart(candles) { c in
            RectangleMark(x: .value("Day", c.date, unit: .day),
                          yStart: .value("Open", c.open),
                          yEnd: .value("Close", c.close),
                          width: .ratio(0.6))
            .foregroundStyle(c.close >= c.open ? Color.green : Color.red)
        }
        .chartYScale(domain: 8...20)
        .frame(height: 150)
        .padding()
    }
}

// MARK: - RuleMark

private struct C03_RuleMarkYExample: View {
    private var average: Double {
        C03_Data.week.map(\.value).reduce(0, +) / Double(C03_Data.week.count)
    }

    var body: some View {
        Chart {
            ForEach(C03_Data.week) { d in
                BarMark(x: .value("Day", d.day), y: .value("Level", d.value))
            }
            RuleMark(y: .value("Average", average))
                .lineStyle(StrokeStyle(lineWidth: 1, dash: [4]))
                .foregroundStyle(.secondary)
        }
        .frame(height: 150)
        .padding()
    }
}

private struct C03_RuleMarkXExample: View {
    @State private var selectedDay: Int? = 4

    var body: some View {
        VStack(spacing: 6) {
            Chart {
                ForEach(C03_Data.week) { d in
                    LineMark(x: .value("Day", d.day), y: .value("Level", d.value))
                }
                if let selectedDay {
                    RuleMark(x: .value("Selected", selectedDay))
                        .foregroundStyle(.gray)
                        .zIndex(-1)
                }
            }
            .chartXSelection(value: $selectedDay)
            .frame(height: 130)
            Text("selectedDay: \(selectedDay.map(String.init) ?? "nil") — hover or drag to scrub")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C03_RuleMarkSegmentExample: View {
    private struct Sample: Identifiable {
        let id = UUID()
        var trial: Int
        var min: Double
        var max: Double
        var mean: Double
    }

    private let samples = [
        Sample(trial: 1, min: 2.1, max: 4.9, mean: 3.4),
        Sample(trial: 2, min: 3.0, max: 5.2, mean: 4.1),
        Sample(trial: 3, min: 2.6, max: 6.4, mean: 4.6),
        Sample(trial: 4, min: 3.9, max: 6.1, mean: 5.0),
        Sample(trial: 5, min: 4.2, max: 7.3, mean: 5.7),
    ]

    var body: some View {
        Chart(samples) { s in
            RuleMark(x: .value("Trial", s.trial),
                     yStart: .value("Min", s.min),
                     yEnd: .value("Max", s.max))
            PointMark(x: .value("Trial", s.trial), y: .value("Mean", s.mean))
        }
        .frame(height: 150)
        .padding()
    }
}

private struct C03_RuleMarkAnnotationExample: View {
    var body: some View {
        Chart {
            ForEach(C03_Data.week) { d in
                LineMark(x: .value("Day", d.day), y: .value("Usage", d.value * 14))
            }
            RuleMark(y: .value("Limit", 80))
                .foregroundStyle(.red)
                .annotation(position: .topTrailing, alignment: .trailing, spacing: 2) {
                    Text("Limit")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
        }
        .chartYScale(domain: 0...100)
        .frame(height: 150)
        .padding()
    }
}

// MARK: - SectorMark

private struct C03_Share: Identifiable {
    let id = UUID()
    var platform: String
    var count: Int
}

private let C03_shares = [
    C03_Share(platform: "iOS", count: 62),
    C03_Share(platform: "macOS", count: 21),
    C03_Share(platform: "iPadOS", count: 12),
    C03_Share(platform: "watchOS", count: 5),
]

private struct C03_SectorMarkExample: View {
    var body: some View {
        Chart(C03_shares) { share in
            SectorMark(angle: .value("Users", share.count),
                       innerRadius: .ratio(0.6),
                       outerRadius: .ratio(1.0),
                       angularInset: 1.5)
            .foregroundStyle(by: .value("Platform", share.platform))
        }
        .frame(height: 170)
        .padding()
    }
}

private struct C03_SectorCornerRadiusExample: View {
    @State private var radius: CGFloat = 6

    var body: some View {
        VStack(spacing: 6) {
            Chart(C03_shares) { item in
                SectorMark(angle: .value("Share", item.count),
                           innerRadius: .ratio(0.5),
                           angularInset: 2)
                    .cornerRadius(radius, style: .continuous)
                    .foregroundStyle(by: .value("Platform", item.platform))
            }
            .chartLegend(.hidden)
            .frame(height: 140)
            Slider(value: $radius, in: 0...14) {
                Text("cornerRadius \(Int(radius))")
            }
            .font(.caption)
        }
        .padding()
    }
}

private struct C03_ChartAngleSelectionExample: View {
    @State private var selectedCount: Int?

    private var selectedShare: C03_Share? {
        guard let selectedCount else { return nil }
        var running = 0
        for share in C03_shares {
            running += share.count
            if selectedCount <= running { return share }
        }
        return nil
    }

    private func isSelected(_ share: C03_Share) -> Bool {
        selectedShare == nil || selectedShare?.id == share.id
    }

    var body: some View {
        VStack(spacing: 6) {
            Chart(C03_shares) { share in
                SectorMark(angle: .value("Users", share.count), innerRadius: .ratio(0.6))
                    .opacity(isSelected(share) ? 1 : 0.5)
                    .foregroundStyle(by: .value("Platform", share.platform))
            }
            .chartAngleSelection(value: $selectedCount)
            .chartLegend(.hidden)
            .frame(height: 140)
            Text("selectedCount: \(selectedCount.map(String.init) ?? "nil") → \(selectedShare?.platform ?? "none") — hover the ring")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

// MARK: - Shared map illustration

/// A street-grid stand-in for a live `Map`, so overlay variants can be drawn
/// without loading tiles.
private struct C03_MockMap<Overlay: View>: View {
    var caption: String
    var showsLabels: Bool
    @ViewBuilder var overlay: () -> Overlay

    init(caption: String = "Illustrative — map tiles load at runtime",
         showsLabels: Bool = false,
         @ViewBuilder overlay: @escaping () -> Overlay) {
        self.caption = caption
        self.showsLabels = showsLabels
        self.overlay = overlay
    }

    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                Canvas { context, size in
                    context.fill(Path(CGRect(origin: .zero, size: size)),
                                 with: .color(Color(red: 0.92, green: 0.93, blue: 0.88)))
                    var streets = Path()
                    for x in stride(from: 22.0, to: size.width, by: 36) {
                        streets.move(to: CGPoint(x: x, y: 0))
                        streets.addLine(to: CGPoint(x: x, y: size.height))
                    }
                    for y in stride(from: 18.0, to: size.height, by: 32) {
                        streets.move(to: CGPoint(x: 0, y: y))
                        streets.addLine(to: CGPoint(x: size.width, y: y))
                    }
                    context.stroke(streets, with: .color(.white), lineWidth: 4)
                    context.fill(Path(ellipseIn: CGRect(x: size.width * 0.66, y: 10, width: 64, height: 40)),
                                 with: .color(Color.green.opacity(0.28)))
                    context.fill(Path(CGRect(x: 0, y: size.height - 26, width: size.width, height: 26)),
                                 with: .color(Color.blue.opacity(0.2)))
                }
                if showsLabels {
                    Text("MAIN ST").font(.system(size: 9, weight: .semibold)).foregroundStyle(.gray)
                        .offset(x: -70, y: -46)
                    Text("RIVERSIDE").font(.system(size: 9, weight: .semibold)).foregroundStyle(.gray)
                        .offset(x: 60, y: 52)
                }
                overlay()
            }
            .frame(height: 140)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            Text(caption)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private let C03_pinCoordinate = CLLocationCoordinate2D(latitude: 37.7955, longitude: -122.3937)

// MARK: - LookAroundPreview

private struct C03_StreetScene: View {
    var skyTint: Color
    var showsRoadLabels: Bool
    var showsPointsOfInterest: Bool
    var badgePosition: Alignment

    var body: some View {
        ZStack(alignment: badgePosition) {
            VStack(spacing: 0) {
                LinearGradient(colors: [skyTint.opacity(0.75), skyTint.opacity(0.25)],
                               startPoint: .top, endPoint: .bottom)
                    .overlay(alignment: .bottom) {
                        HStack(alignment: .bottom, spacing: 6) {
                            ForEach([44.0, 70, 52, 86, 60, 40], id: \.self) { h in
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(Color.gray.opacity(0.55))
                                    .frame(width: 30, height: h)
                            }
                        }
                    }
                Rectangle().fill(Color(white: 0.35)).frame(height: 36)
                    .overlay {
                        Rectangle().fill(.yellow).frame(height: 2)
                    }
            }
            if showsRoadLabels {
                Text("Market St")
                    .font(.caption2)
                    .padding(.horizontal, 6).padding(.vertical, 2)
                    .background(.white.opacity(0.85), in: Capsule())
                    .offset(y: 46)
            }
            if showsPointsOfInterest {
                Image(systemName: "cup.and.saucer.fill")
                    .font(.caption2)
                    .foregroundStyle(.white)
                    .padding(5)
                    .background(.orange, in: Circle())
                    .offset(x: 40, y: -24)
            }
            Image(systemName: "binoculars.fill")
                .font(.caption)
                .foregroundStyle(.white)
                .padding(6)
                .background(.black.opacity(0.55), in: Circle())
                .padding(8)
        }
        .frame(height: 140)
    }
}

private struct C03_LookAroundSceneBindingExample: View {
    @State private var sceneIndex = 0
    private let tints: [Color] = [.blue, .orange, .purple]

    var body: some View {
        VStack(spacing: 8) {
            C03_StreetScene(skyTint: tints[sceneIndex],
                            showsRoadLabels: false,
                            showsPointsOfInterest: true,
                            badgePosition: .bottomTrailing)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            HStack {
                Button("Swap scene") { sceneIndex = (sceneIndex + 1) % tints.count }
                Text("$scene changed \(sceneIndex) time\(sceneIndex == 1 ? "" : "s") — the card follows the binding")
                    .font(.caption2).foregroundStyle(.secondary)
            }
            Text("Illustrative — needs a live MKLookAroundScene")
                .font(.caption2).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C03_LookAroundInitialSceneExample: View {
    var body: some View {
        VStack(spacing: 6) {
            C03_StreetScene(skyTint: .blue,
                            showsRoadLabels: true,
                            showsPointsOfInterest: false,
                            badgePosition: .topLeading)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            Text("Illustrative — initialScene is read once; pointsOfInterest: .excludingAll hides POI pins")
                .font(.caption2).foregroundStyle(.secondary)
        }
        .padding()
    }
}

// MARK: - MapCameraPosition

private struct C03_CameraHeadingExample: View {
    @State private var heading: Double = 90
    private let peak = CLLocationCoordinate2D(latitude: 46.8523, longitude: -121.7603)

    private var position: MapCameraPosition {
        .camera(MapCamera(centerCoordinate: peak, distance: 1200, heading: heading, pitch: 60))
    }

    var body: some View {
        VStack(spacing: 6) {
            C03_MockMap(caption: "Illustrative — the camera drives a live Map at runtime") {
                Image(systemName: "mountain.2.fill")
                    .font(.system(size: 34))
                    .foregroundStyle(.brown)
                Image(systemName: "location.north.fill")
                    .font(.title2)
                    .foregroundStyle(.blue)
                    .rotationEffect(.degrees(position.camera?.heading ?? 0))
                    .offset(x: 90, y: -40)
            }
            Slider(value: $heading, in: 0...359) { Text("heading") }
                .font(.caption)
                .padding(.horizontal)
            Text("camera: distance \(Int(position.camera?.distance ?? 0)) m · heading \(Int(position.camera?.heading ?? 0))° · pitch \(Int(position.camera?.pitch ?? 0))°")
                .font(.caption2).foregroundStyle(.secondary)
        }
    }
}

private struct C03_UserLocationPositionExample: View {
    @State private var pulsing = false
    private let position: MapCameraPosition = .userLocation(fallback: .automatic)

    var body: some View {
        VStack(spacing: 6) {
            C03_MockMap(caption: "Illustrative — follows the device location at runtime") {
                Circle()
                    .fill(.blue.opacity(0.25))
                    .frame(width: pulsing ? 64 : 24, height: pulsing ? 64 : 24)
                    .opacity(pulsing ? 0 : 1)
                    .animation(.easeOut(duration: 1.6).repeatForever(autoreverses: false), value: pulsing)
                Circle()
                    .fill(.blue)
                    .frame(width: 16, height: 16)
                    .overlay(Circle().stroke(.white, lineWidth: 3))
                    .shadow(radius: 2)
            }
            .onAppear { pulsing = true }
            Text(verbatim: "position.followsUserLocation == \(position.followsUserLocation) · fallback: .automatic")
                .font(.caption2).foregroundStyle(.secondary)
        }
    }
}

private struct C03_RegionPositionExample: View {
    private let position: MapCameraPosition = .region(MKCoordinateRegion(
        center: C03_pinCoordinate,
        latitudinalMeters: 2000,
        longitudinalMeters: 2000))

    var body: some View {
        VStack(spacing: 6) {
            C03_MockMap(caption: "Illustrative — frames the region on a live Map") {
                Rectangle()
                    .strokeBorder(.blue, style: StrokeStyle(lineWidth: 1.5, dash: [5, 4]))
                    .frame(width: 110, height: 110)
                Image(systemName: "mappin.circle.fill")
                    .font(.title2)
                    .foregroundStyle(.red)
                Text("2000 m")
                    .font(.caption2)
                    .foregroundStyle(.blue)
                    .offset(y: -62)
            }
            Text("position.region?.span.latitudeDelta ≈ \(String(format: "%.4f", position.region?.span.latitudeDelta ?? 0))°")
                .font(.caption2).foregroundStyle(.secondary)
        }
    }
}

private struct C03_CameraPitchExample: View {
    @State private var pitch: Double = 60
    private let peak = CLLocationCoordinate2D(latitude: 46.8523, longitude: -121.7603)

    private var position: MapCameraPosition {
        .camera(MapCamera(centerCoordinate: peak, distance: 1200, heading: 90, pitch: pitch))
    }

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(red: 0.92, green: 0.93, blue: 0.88))
                    .overlay {
                        Canvas { context, size in
                            var grid = Path()
                            for x in stride(from: 0.0, through: size.width, by: 24) {
                                grid.move(to: CGPoint(x: x, y: 0)); grid.addLine(to: CGPoint(x: x, y: size.height))
                            }
                            for y in stride(from: 0.0, through: size.height, by: 24) {
                                grid.move(to: CGPoint(x: 0, y: y)); grid.addLine(to: CGPoint(x: size.width, y: y))
                            }
                            context.stroke(grid, with: .color(.white), lineWidth: 3)
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                Image(systemName: "mountain.2.fill")
                    .font(.system(size: 34))
                    .foregroundStyle(.brown)
            }
            .frame(width: 220, height: 110)
            .rotation3DEffect(.degrees((position.camera?.pitch ?? 0) * 0.7),
                              axis: (x: 1, y: 0, z: 0),
                              perspective: 0.5)
            .frame(height: 120)
            Slider(value: $pitch, in: 0...85) { Text("pitch") }
                .font(.caption)
                .padding(.horizontal)
            Text("Illustrative — camera.pitch \(Int(position.camera?.pitch ?? 0))° tilts a live Map at runtime")
                .font(.caption2).foregroundStyle(.secondary)
        }
        .padding()
    }
}

// MARK: - MapCircle

private struct C03_MapCircleCenterRadiusExample: View {
    var body: some View {
        C03_MockMap {
            Circle()
                .fill(.blue.opacity(0.2))
                .stroke(.blue, lineWidth: 2)
                .frame(width: 96, height: 96)
            Image(systemName: "storefront.fill")
                .foregroundStyle(.blue)
            Text("radius: 250 m")
                .font(.caption2)
                .foregroundStyle(.blue)
                .offset(y: -58)
        }
    }
}

private struct C03_MapCircleMKCircleExample: View {
    private let geofence = MKCircle(center: C03_pinCoordinate, radius: 100)

    var body: some View {
        C03_MockMap(caption: "Illustrative — MapCircle(geofence) wraps the MKCircle, radius \(Int(geofence.radius)) m") {
            Circle()
                .fill(.green.opacity(0.3))
                .frame(width: 64, height: 64)
            Image(systemName: "house.fill")
                .foregroundStyle(.green)
        }
    }
}

private struct C03_MapOverlayLevelExample: View {
    @State private var level: MKOverlayLevel = .aboveLabels

    var body: some View {
        VStack(spacing: 0) {
            C03_MockMap(caption: "Illustrative — .aboveRoads sits under labels, .aboveLabels covers them",
                        showsLabels: true) {
                Circle()
                    .fill(.red.opacity(level == .aboveLabels ? 0.55 : 0.35))
                    .frame(width: 150, height: 150)
                    .offset(x: -40, y: -20)
                    .zIndex(level == .aboveLabels ? 1 : -1)
            }
            Picker("level", selection: $level) {
                Text(".aboveRoads").tag(MKOverlayLevel.aboveRoads)
                Text(".aboveLabels").tag(MKOverlayLevel.aboveLabels)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .padding(.horizontal)
        }
    }
}

// MARK: - Shared overlay geometry

/// Draws a polyline/polygon from unit-square points inside whatever rect it is given.
private struct C03_UnitPath: Shape {
    var points: [CGPoint]
    var closed: Bool = true

    func path(in rect: CGRect) -> Path {
        var path = Path()
        guard let first = points.first else { return path }
        func scaled(_ p: CGPoint) -> CGPoint {
            CGPoint(x: rect.minX + p.x * rect.width, y: rect.minY + p.y * rect.height)
        }
        path.move(to: scaled(first))
        for p in points.dropFirst() { path.addLine(to: scaled(p)) }
        if closed { path.closeSubpath() }
        return path
    }
}

private let C03_outline: [CLLocationCoordinate2D] = [
    CLLocationCoordinate2D(latitude: 37.7690, longitude: -122.5110),
    CLLocationCoordinate2D(latitude: 37.7740, longitude: -122.5110),
    CLLocationCoordinate2D(latitude: 37.7740, longitude: -122.4550),
    CLLocationCoordinate2D(latitude: 37.7690, longitude: -122.4550),
]

// MARK: - MapPolygon

private struct C03_MapPolygonCoordinatesExample: View {
    var body: some View {
        C03_MockMap {
            C03_UnitPath(points: [CGPoint(x: 0.25, y: 0.2), CGPoint(x: 0.7, y: 0.15),
                                  CGPoint(x: 0.75, y: 0.6), CGPoint(x: 0.45, y: 0.75), CGPoint(x: 0.2, y: 0.55)])
                .fill(.green.opacity(0.25))
                .stroke(.green, lineWidth: 2)
        }
    }
}

private struct C03_MapPolygonPointsExample: View {
    private let corners = C03_outline.map { MKMapPoint($0) }

    var body: some View {
        C03_MockMap(caption: "Illustrative — \(corners.count) MKMapPoints; first x ≈ \(String(format: "%.0f", corners.first?.x ?? 0))") {
            C03_UnitPath(points: [CGPoint(x: 0.2, y: 0.25), CGPoint(x: 0.8, y: 0.25),
                                  CGPoint(x: 0.8, y: 0.7), CGPoint(x: 0.2, y: 0.7)])
                .fill(.purple.opacity(0.2))
        }
    }
}

private struct C03_MapPolygonMKPolygonExample: View {
    private let shape = MKPolygon(coordinates: C03_outline, count: C03_outline.count)

    var body: some View {
        C03_MockMap(caption: "Illustrative — MapPolygon(shape) wraps an MKPolygon with \(shape.pointCount) points") {
            C03_UnitPath(points: [CGPoint(x: 0.3, y: 0.15), CGPoint(x: 0.7, y: 0.3),
                                  CGPoint(x: 0.65, y: 0.8), CGPoint(x: 0.25, y: 0.7)])
                .fill(.orange.opacity(0.3))
        }
    }
}

// MARK: - MapPolyline

private struct C03_MapPolylineContourExample: View {
    @State private var geodesic = true

    var body: some View {
        VStack(spacing: 0) {
            C03_MockMap(caption: "Illustrative — .geodesic bows toward the pole, .straight cuts across") {
                GeometryReader { geo in
                    let a = CGPoint(x: geo.size.width * 0.12, y: geo.size.height * 0.62)
                    let b = CGPoint(x: geo.size.width * 0.88, y: geo.size.height * 0.62)
                    Path { p in
                        p.move(to: a)
                        if geodesic {
                            p.addQuadCurve(to: b, control: CGPoint(x: geo.size.width / 2, y: geo.size.height * 0.05))
                        } else {
                            p.addLine(to: b)
                        }
                    }
                    .stroke(.orange, lineWidth: 3)
                    Text("Tokyo").font(.caption2).position(x: a.x, y: a.y + 14)
                    Text("San Francisco").font(.caption2).position(x: b.x - 10, y: b.y + 14)
                }
            }
            Picker("contourStyle", selection: $geodesic) {
                Text(".straight").tag(false)
                Text(".geodesic").tag(true)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .padding(.horizontal)
        }
    }
}

private struct C03_MapPolylineRouteExample: View {
    var body: some View {
        C03_MockMap(caption: "Illustrative — renders after an MKDirections request returns a route") {
            C03_UnitPath(points: [CGPoint(x: 0.12, y: 0.75), CGPoint(x: 0.12, y: 0.42),
                                  CGPoint(x: 0.45, y: 0.42), CGPoint(x: 0.45, y: 0.15), CGPoint(x: 0.85, y: 0.15)],
                         closed: false)
                .stroke(.blue, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
            GeometryReader { geo in
                Circle().fill(.green).frame(width: 10, height: 10)
                    .position(x: geo.size.width * 0.12, y: geo.size.height * 0.75)
                Image(systemName: "mappin.circle.fill").foregroundStyle(.red)
                    .position(x: geo.size.width * 0.85, y: geo.size.height * 0.15)
            }
        }
    }
}

private struct C03_MapPolylineMKPolylineExample: View {
    private let track = MKPolyline(coordinates: C03_outline, count: C03_outline.count)

    var body: some View {
        C03_MockMap(caption: "Illustrative — MapPolyline(track) draws an MKPolyline with \(track.pointCount) points") {
            C03_UnitPath(points: [CGPoint(x: 0.1, y: 0.7), CGPoint(x: 0.25, y: 0.35), CGPoint(x: 0.4, y: 0.55),
                                  CGPoint(x: 0.55, y: 0.2), CGPoint(x: 0.7, y: 0.45), CGPoint(x: 0.9, y: 0.3)],
                         closed: false)
                .stroke(.red, lineWidth: 2)
        }
    }
}

private struct C03_MapPolylineStrokeStyleExample: View {
    var body: some View {
        C03_MockMap {
            C03_UnitPath(points: [CGPoint(x: 0.1, y: 0.65), CGPoint(x: 0.35, y: 0.65),
                                  CGPoint(x: 0.5, y: 0.3), CGPoint(x: 0.9, y: 0.3)],
                         closed: false)
                .stroke(.gray, style: StrokeStyle(lineWidth: 4,
                                                  lineCap: .round,
                                                  dash: [8, 8]))
        }
    }
}

// MARK: - MapReader

/// A fixed sample region used to illustrate MapProxy conversions.
private enum C03_FakeProjection {
    static let region = MKCoordinateRegion(
        center: C03_pinCoordinate,
        span: MKCoordinateSpan(latitudeDelta: 0.012, longitudeDelta: 0.016))

    static func coordinate(at point: CGPoint, in size: CGSize) -> CLLocationCoordinate2D {
        let lat = region.center.latitude + region.span.latitudeDelta * (0.5 - point.y / size.height)
        let lon = region.center.longitude + region.span.longitudeDelta * (point.x / size.width - 0.5)
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }

    static func point(for coordinate: CLLocationCoordinate2D, in size: CGSize) -> CGPoint {
        let x = (0.5 + (coordinate.longitude - region.center.longitude) / region.span.longitudeDelta) * size.width
        let y = (0.5 - (coordinate.latitude - region.center.latitude) / region.span.latitudeDelta) * size.height
        return CGPoint(x: x, y: y)
    }
}

private struct C03_MapProxyPointToCoordinateExample: View {
    @State private var pin: CGPoint?
    @State private var coordinate: CLLocationCoordinate2D?

    var body: some View {
        C03_MockMap(caption: coordinate.map {
            "Illustrative — converted (\(Int(pin?.x ?? 0)), \(Int(pin?.y ?? 0))) → \(String(format: "%.4f, %.4f", $0.latitude, $0.longitude))"
        } ?? "Illustrative — click the map; MapProxy resolves the tap against the live map") {
            GeometryReader { geo in
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture { screenPoint in
                        pin = screenPoint
                        coordinate = C03_FakeProjection.coordinate(at: screenPoint, in: geo.size)
                    }
                if let pin {
                    Image(systemName: "mappin.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.red)
                        .position(pin)
                }
            }
        }
    }
}

private struct C03_MapProxyCoordinateToPointExample: View {
    private let landmark = CLLocationCoordinate2D(latitude: 37.7985, longitude: -122.3890)

    var body: some View {
        C03_MockMap(caption: "Illustrative — \(String(format: "%.4f, %.4f", landmark.latitude, landmark.longitude)) projected into .local space") {
            GeometryReader { geo in
                let p = C03_FakeProjection.point(for: landmark, in: geo.size)
                Text("Here")
                    .font(.caption.bold())
                    .padding(.horizontal, 8).padding(.vertical, 3)
                    .background(.blue, in: Capsule())
                    .foregroundStyle(.white)
                    .position(p)
            }
        }
    }
}

private struct C03_MapProxyRectToRegionExample: View {
    @State private var selectedRegion: MKCoordinateRegion?

    var body: some View {
        C03_MockMap(caption: selectedRegion.map {
            "Illustrative — region center \(String(format: "%.4f, %.4f", $0.center.latitude, $0.center.longitude)) · span \(String(format: "%.4f × %.4f", $0.span.latitudeDelta, $0.span.longitudeDelta))"
        } ?? "Illustrative — click to convert the dashed box into an MKCoordinateRegion") {
            GeometryReader { geo in
                let box = CGRect(x: 0, y: 0, width: 100, height: 100)
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        let topLeft = C03_FakeProjection.coordinate(at: box.origin, in: geo.size)
                        let bottomRight = C03_FakeProjection.coordinate(at: CGPoint(x: box.maxX, y: box.maxY), in: geo.size)
                        selectedRegion = MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: (topLeft.latitude + bottomRight.latitude) / 2,
                                                           longitude: (topLeft.longitude + bottomRight.longitude) / 2),
                            span: MKCoordinateSpan(latitudeDelta: topLeft.latitude - bottomRight.latitude,
                                                   longitudeDelta: bottomRight.longitude - topLeft.longitude))
                    }
                Rectangle()
                    .strokeBorder(selectedRegion == nil ? Color.gray : Color.blue,
                                  style: StrokeStyle(lineWidth: 1.5, dash: [5, 4]))
                    .frame(width: box.width, height: box.height)
                    .position(x: box.midX, y: box.midY)
            }
        }
    }
}

// MARK: - Marker

private struct C03_MarkerBalloon<Glyph: View>: View {
    var title: String
    var tint: Color
    @ViewBuilder var glyph: () -> Glyph

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Circle()
                    .fill(tint)
                    .frame(width: 30, height: 30)
                    .overlay(Circle().stroke(.white, lineWidth: 2))
                    .shadow(radius: 1.5, y: 1)
                glyph()
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(.white)
            }
            Image(systemName: "arrowtriangle.down.fill")
                .font(.system(size: 9))
                .foregroundStyle(tint)
                .offset(y: -3)
            Text(title)
                .font(.system(size: 10, weight: .semibold))
                .padding(.horizontal, 5).padding(.vertical, 1)
                .background(.white.opacity(0.75), in: Capsule())
                .foregroundStyle(.black)
        }
    }
}

private struct C03_MarkerItemExample: View {
    var body: some View {
        C03_MockMap(caption: "Illustrative — the MKMapItem supplies the name and the café category styling") {
            C03_MarkerBalloon(title: "Blue Bottle Coffee", tint: .orange) {
                Image(systemName: "cup.and.saucer.fill")
            }
            .offset(y: -8)
        }
    }
}

private struct C03_MarkerTitleCoordinateExample: View {
    var body: some View {
        C03_MockMap(caption: "Illustrative — default pin glyph in the system red tint") {
            C03_MarkerBalloon(title: "Ferry Building", tint: .red) {
                Image(systemName: "mappin")
            }
            .offset(y: -8)
        }
    }
}

private struct C03_MarkerSystemImageExample: View {
    var body: some View {
        C03_MockMap(caption: "Illustrative — systemImage replaces the pin glyph; .tint(.green) colors the balloon") {
            C03_MarkerBalloon(title: "Trailhead", tint: .green) {
                Image(systemName: "figure.hiking")
            }
            .offset(y: -8)
        }
    }
}

private struct C03_MarkerMonogramExample: View {
    private let stops = ["Depot", "Harbor", "Museum"]

    var body: some View {
        C03_MockMap(caption: "Illustrative — monogram: Text(\"1\"), Text(\"2\"), Text(\"3\") inside the balloons") {
            ForEach(Array(stops.enumerated()), id: \.offset) { index, name in
                C03_MarkerBalloon(title: name, tint: .indigo) {
                    Text("\(index + 1)")
                }
                .offset(x: CGFloat(index - 1) * 90, y: CGFloat(index % 2 == 0 ? 14 : -30))
            }
        }
    }
}

// MARK: - NSViewControllerRepresentable

private final class C03_BadgeController: NSViewController {
    let headline = NSTextField(labelWithString: "")
    let detail = NSTextField(labelWithString: "")

    override func loadView() {
        let stack = NSStackView(views: [headline, detail])
        stack.orientation = .vertical
        stack.alignment = .centerX
        stack.spacing = 4
        stack.edgeInsets = NSEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
        stack.wantsLayer = true
        stack.layer?.backgroundColor = NSColor.controlAccentColor.withAlphaComponent(0.15).cgColor
        stack.layer?.cornerRadius = 8
        headline.font = .boldSystemFont(ofSize: 12)
        detail.font = .monospacedSystemFont(ofSize: 11, weight: .regular)
        detail.textColor = .secondaryLabelColor
        view = stack
    }
}

private struct C03_MadeOnceBadge: NSViewControllerRepresentable {
    var updates: Int

    func makeNSViewController(context: Context) -> C03_BadgeController {
        let controller = C03_BadgeController()
        controller.headline.stringValue = "Made at " + Date.now.formatted(date: .omitted, time: .standard)
        return controller
    }

    func updateNSViewController(_ controller: C03_BadgeController, context: Context) {
        controller.detail.stringValue = "updates: \(updates)"
    }
}

private struct C03_MakeNSViewControllerExample: View {
    @State private var updates = 0

    var body: some View {
        VStack(spacing: 10) {
            C03_MadeOnceBadge(updates: updates)
                .frame(width: 220, height: 60)
            Button("Change SwiftUI state") { updates += 1 }
            Text("makeNSViewController ran once — the timestamp stays while updates count up")
                .font(.caption2).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C03_ZoomBadge: NSViewControllerRepresentable {
    var zoom: Double

    func makeNSViewController(context: Context) -> C03_BadgeController {
        C03_BadgeController()
    }

    func updateNSViewController(_ controller: C03_BadgeController, context: Context) {
        controller.headline.stringValue = String(format: "zoom %.2f", zoom)
        controller.detail.stringValue = context.environment.controlSize == .small
            ? "controlSize: .small" : "controlSize: .regular"
    }
}

private struct C03_UpdateNSViewControllerExample: View {
    @State private var zoom = 1.0
    @State private var small = false

    var body: some View {
        VStack(spacing: 10) {
            C03_ZoomBadge(zoom: zoom)
                .controlSize(small ? .small : .regular)
                .frame(width: 220, height: 60)
            Slider(value: $zoom, in: 0.5...2) { Text("zoom") }
                .font(.caption)
            Toggle("controlSize: .small", isOn: $small)
                .font(.caption)
        }
        .padding()
    }
}

private final class C03_ButtonController: NSViewController {
    let button = NSButton(title: "AppKit NSButton", target: nil, action: nil)

    override func loadView() {
        button.bezelStyle = .rounded
        let container = NSView()
        button.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: container.centerYAnchor),
        ])
        view = container
    }
}

private struct C03_CoordinatedButton: NSViewControllerRepresentable {
    @Binding var taps: Int

    func makeCoordinator() -> Coordinator { Coordinator(taps: $taps) }

    func makeNSViewController(context: Context) -> C03_ButtonController {
        let controller = C03_ButtonController()
        controller.button.target = context.coordinator
        controller.button.action = #selector(Coordinator.tapped)
        return controller
    }

    func updateNSViewController(_ controller: C03_ButtonController, context: Context) { }

    final class Coordinator: NSObject {
        @Binding var taps: Int
        init(taps: Binding<Int>) { _taps = taps }
        @objc func tapped() { taps += 1 }
    }
}

private struct C03_MakeCoordinatorExample: View {
    @State private var taps = 0

    var body: some View {
        VStack(spacing: 10) {
            C03_CoordinatedButton(taps: $taps)
                .frame(width: 220, height: 44)
            Text("SwiftUI @State taps: \(taps)")
                .font(.headline.monospacedDigit())
            Text("The NSButton's target/action lands in the Coordinator, which writes the binding")
                .font(.caption2).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C03_FixedHeightBadge: NSViewControllerRepresentable {
    func makeNSViewController(context: Context) -> C03_BadgeController {
        let controller = C03_BadgeController()
        controller.headline.stringValue = "sizeThatFits"
        controller.detail.stringValue = "height: 56"
        return controller
    }

    func updateNSViewController(_ controller: C03_BadgeController, context: Context) { }

    func sizeThatFits(_ proposal: ProposedViewSize,
                      nsViewController: C03_BadgeController,
                      context: Context) -> CGSize? {
        CGSize(width: proposal.width ?? 200, height: 56)
    }
}

private struct C03_SizeThatFitsExample: View {
    @State private var width: Double = 220

    var body: some View {
        VStack(spacing: 10) {
            C03_FixedHeightBadge()
                .frame(width: width, height: 110)          // proposal: width × 110
                .overlay(Rectangle().strokeBorder(.red, style: StrokeStyle(lineWidth: 1, dash: [4])))
            Slider(value: $width, in: 120...260) { Text("proposed width") }
                .font(.caption)
            Text("Red box = proposal (\(Int(width)) × 110); the controller answers \(Int(width)) × 56 and ignores the extra height")
                .font(.caption2).foregroundStyle(.secondary)
        }
        .padding()
    }
}

// MARK: - PhotosPickerItem

private struct C03_PhotoStandIn: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(LinearGradient(colors: [.orange, .pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
            .overlay {
                Image(systemName: "photo.fill")
                    .font(.title)
                    .foregroundStyle(.white.opacity(0.85))
            }
    }
}

private struct C03_LoadTransferableAsyncExample: View {
    @State private var loaded = false

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 14) {
                VStack(spacing: 4) {
                    Image(systemName: "photo.on.rectangle.angled")
                        .font(.title2)
                        .frame(width: 56, height: 56)
                        .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
                    Text("PhotosPickerItem").font(.caption2)
                }
                VStack(spacing: 2) {
                    Image(systemName: "arrow.right")
                    Text("await loadTransferable(type: Data.self)").font(.caption2.monospaced())
                }
                VStack(spacing: 4) {
                    Group {
                        if loaded {
                            C03_PhotoStandIn()
                        } else {
                            RoundedRectangle(cornerRadius: 8).fill(.quaternary)
                                .overlay(Text("nil").font(.caption2).foregroundStyle(.secondary))
                        }
                    }
                    .frame(width: 56, height: 56)
                    Text(loaded ? "NSImage(data:)" : "avatar").font(.caption2)
                }
            }
            Button(loaded ? "Reset" : "Simulate a picker selection") { loaded.toggle() }
            Text("Illustrative — the real call decodes whatever asset the user picked")
                .font(.caption2).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C03_LoadTransferableProgressExample: View {
    @State private var fraction = 0.35

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 12) {
                Group {
                    if fraction >= 1 {
                        C03_PhotoStandIn()
                    } else {
                        RoundedRectangle(cornerRadius: 8).fill(.quaternary)
                            .overlay(ProgressView().controlSize(.small))
                    }
                }
                .frame(width: 56, height: 56)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Progress.fractionCompleted").font(.caption.monospaced())
                    ProgressView(value: fraction)
                    Text(fraction >= 1 ? "completionHandler: .success(data)" : "loading…")
                        .font(.caption2).foregroundStyle(.secondary)
                }
            }
            Slider(value: $fraction, in: 0...1) { Text("simulated progress") }
                .font(.caption)
            Text("Illustrative — the returned Progress drives ProgressView(progress) for real")
                .font(.caption2).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C03_SupportedContentTypesExample: View {
    @State private var kind = 1
    private let kinds: [(name: String, types: [String], branch: String)] = [
        (name: "Photo", types: ["public.heic", "public.jpeg"], branch: "loadTransferable(type: Data.self)"),
        (name: "Live Photo", types: ["com.apple.live-photo", "public.heic"], branch: "loadTransferable(type: PHLivePhoto.self)"),
        (name: "Video", types: ["public.mpeg-4", "com.apple.quicktime-movie"], branch: "loadTransferable(type: Data.self)"),
    ]

    var body: some View {
        VStack(spacing: 10) {
            Picker("Asset", selection: $kind) {
                ForEach(kinds.indices, id: \.self) { Text(kinds[$0].name).tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            VStack(alignment: .leading, spacing: 4) {
                Text("item.supportedContentTypes").font(.caption.monospaced().bold())
                ForEach(kinds[kind].types, id: \.self) { type in
                    Label(type, systemImage: type == "com.apple.live-photo" ? "livephoto" : "checkmark")
                        .font(.caption.monospaced())
                }
                Text("→ \(kinds[kind].branch)")
                    .font(.caption.monospaced())
                    .foregroundStyle(.blue)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
            Text("Illustrative — .contains(.livePhoto) decides which Transferable to request")
                .font(.caption2).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C03_ItemIdentifierExample: View {
    @State private var usesLibrary = true

    var body: some View {
        VStack(spacing: 10) {
            Toggle("PhotosPicker(…, photoLibrary: .shared())", isOn: $usesLibrary)
                .font(.caption)
            HStack {
                Text("item.itemIdentifier").font(.caption.monospaced())
                Spacer()
                Text(usesLibrary ? "\"5F1A9C2E-7B3D-4E8A-A1F0-2C9B6D4E8F10/L0/001\"" : "nil")
                    .font(.caption.monospaced())
                    .foregroundStyle(usesLibrary ? .primary : .secondary)
            }
            .padding(8)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
            Text(usesLibrary
                 ? "→ PHAsset.fetchAssets(withLocalIdentifiers: [id]) can find the asset"
                 : "→ no library was given, so there is nothing to fetch")
                .font(.caption2).foregroundStyle(.secondary)
            Text("Illustrative — identifiers come from a real picker selection")
                .font(.caption2).foregroundStyle(.tertiary)
        }
        .padding()
    }
}

// MARK: - Shared illustration helpers

private struct C03_Caption: View {
    var text: String
    init(_ text: String) { self.text = text }

    var body: some View {
        Text(text)
            .font(.caption2)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
    }
}

// MARK: - Shared StoreKit illustration

private struct C03_StoreProduct: Identifiable {
    let id: String
    var name: String
    var detail: String
    var price: String
}

private let C03_tipProducts = [
    C03_StoreProduct(id: "com.example.tip.small", name: "Small Tip", detail: "Buy the developer a coffee", price: "$0.99"),
    C03_StoreProduct(id: "com.example.tip.large", name: "Large Tip", detail: "Fund a week of work", price: "$4.99"),
]

private let C03_bundleProducts = [
    C03_StoreProduct(id: "com.example.bundle.basic", name: "Basic Bundle", detail: "The core tools", price: "$2.99"),
    C03_StoreProduct(id: "com.example.bundle.pro", name: "Pro Bundle", detail: "Everything, forever", price: "$14.99"),
]

private struct C03_PromoImage: View {
    var symbol: String

    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(LinearGradient(colors: [.orange, .pink], startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(width: 40, height: 40)
            .overlay { Image(systemName: symbol).foregroundStyle(.white) }
    }
}

/// One ProductView-shaped row: icon slot, name/description, system buy button.
private struct C03_StoreRow<Icon: View>: View {
    var product: C03_StoreProduct
    var compact: Bool
    var icon: () -> Icon

    init(product: C03_StoreProduct, compact: Bool = false, @ViewBuilder icon: @escaping () -> Icon) {
        self.product = product
        self.compact = compact
        self.icon = icon
    }

    var body: some View {
        HStack(spacing: 10) {
            icon()
            VStack(alignment: .leading, spacing: 2) {
                Text(product.name).font(.callout.weight(.semibold))
                if !compact {
                    Text(product.detail).font(.caption).foregroundStyle(.secondary)
                }
            }
            Spacer()
            Text(product.price)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.white)
                .padding(.horizontal, 12).padding(.vertical, 5)
                .background(.blue, in: Capsule())
        }
        .padding(.horizontal, 10)
        .padding(.vertical, compact ? 5 : 8)
        .background(.quaternary.opacity(0.5), in: RoundedRectangle(cornerRadius: 8))
    }
}

private struct C03_StoreViewIDsExample: View {
    @State private var prefersPromotionalIcon = true

    var body: some View {
        VStack(spacing: 8) {
            Toggle("prefersPromotionalIcon", isOn: $prefersPromotionalIcon)
                .font(.caption.monospaced())
            ForEach(C03_tipProducts) { product in
                C03_StoreRow(product: product) {
                    if prefersPromotionalIcon {
                        C03_PromoImage(symbol: product.id.hasSuffix("large") ? "cup.and.saucer.fill" : "cup.and.saucer")
                    }
                }
            }
            C03_Caption("Illustrative — StoreView(ids:) fetches these products from the App Store; true swaps in each product's App Store Connect promotional image")
        }
        .padding()
    }
}

private struct C03_StoreViewProductsExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("loadedProducts.count == \(C03_tipProducts.count)").font(.caption.monospaced())
                Spacer()
                Text("no fetch").font(.caption2).foregroundStyle(.green)
            }
            ForEach(C03_tipProducts) { product in
                C03_StoreRow(product: product, compact: true) { EmptyView() }
            }
            C03_Caption("Illustrative — takes Product values already fetched with Product.products(for:); .compact keeps name and price on one line")
        }
        .padding()
    }
}

private struct C03_StoreViewIconExample: View {
    var body: some View {
        VStack(spacing: 8) {
            ForEach(C03_bundleProducts) { product in
                C03_StoreRow(product: product) {
                    Image(systemName: product.id.hasSuffix("pro") ? "crown.fill" : "star.fill")
                        .font(.title2)
                        .foregroundStyle(product.id.hasSuffix("pro") ? Color.yellow : Color.blue)
                        .frame(width: 40, height: 40)
                }
            }
            C03_Caption("Illustrative — the icon closure runs once per loaded Product; prices and buy buttons are drawn by StoreKit")
        }
        .padding()
    }
}

// MARK: - Shared SubscriptionStoreView illustration

private struct C03_Plan: Identifiable {
    let id: String
    var name: String
    var price: String
    var tier: Int          // 1 = top tier, mirroring the App Store Connect ranking
}

private let C03_groupPlans = [
    C03_Plan(id: "com.example.premium.monthly", name: "Premium", price: "$9.99 / month", tier: 1),
    C03_Plan(id: "com.example.pro.monthly", name: "Pro", price: "$4.99 / month", tier: 2),
    C03_Plan(id: "com.example.basic.monthly", name: "Basic", price: "$1.99 / month", tier: 3),
]

private let C03_proPlans = [
    C03_Plan(id: "com.example.pro.monthly", name: "Pro Monthly", price: "$4.99 / month", tier: 2),
    C03_Plan(id: "com.example.pro.yearly", name: "Pro Yearly", price: "$39.99 / year", tier: 2),
]

private struct C03_DefaultMarketingHeader: View {
    var title: String

    var body: some View {
        HStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 7)
                .fill(LinearGradient(colors: [.blue, .cyan], startPoint: .top, endPoint: .bottom))
                .frame(width: 28, height: 28)
                .overlay { Image(systemName: "bird.fill").font(.caption).foregroundStyle(.white) }
            Text(title).font(.headline)
        }
    }
}

/// A SubscriptionStoreView-shaped sheet: marketing header, plan picker, subscribe button.
private struct C03_SubscriptionSheet<Header: View>: View {
    var plans: [C03_Plan]
    var currentID: String?
    var prominent: Bool
    var showsIDs: Bool
    var header: () -> Header
    @State private var selection: String?

    init(plans: [C03_Plan], currentID: String? = nil, prominent: Bool = false, showsIDs: Bool = false,
         @ViewBuilder header: @escaping () -> Header) {
        self.plans = plans
        self.currentID = currentID
        self.prominent = prominent
        self.showsIDs = showsIDs
        self.header = header
    }

    var body: some View {
        VStack(spacing: 8) {
            header()
            ForEach(plans) { plan in
                let picked = selection == plan.id
                HStack(spacing: 8) {
                    Image(systemName: picked ? "checkmark.circle.fill" : "circle")
                        .foregroundStyle(picked ? Color.blue : Color.secondary)
                    VStack(alignment: .leading, spacing: 1) {
                        Text(plan.name).font(prominent ? .callout.weight(.semibold) : .caption.weight(.semibold))
                        Text(showsIDs ? plan.id : plan.price)
                            .font(showsIDs ? .caption2.monospaced() : .caption2)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    if showsIDs {
                        Text(plan.price).font(.caption2)
                    } else if plan.id == currentID {
                        Text("Current").font(.caption2).foregroundStyle(.secondary)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, prominent ? 8 : 4)
                .background(picked ? Color.blue.opacity(0.12) : Color.gray.opacity(0.1),
                            in: RoundedRectangle(cornerRadius: 8))
                .overlay(RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(picked ? Color.blue : Color.clear, lineWidth: prominent ? 2 : 1))
                .contentShape(Rectangle())
                .onTapGesture { selection = plan.id }
            }
            Button("Subscribe") { }
                .buttonStyle(.borderedProminent)
                .controlSize(.small)
                .disabled(selection == nil)
        }
    }
}

private enum C03_Relationship: String, CaseIterable {
    case all, upgrade, downgrade, current
}

private struct C03_SubscriptionRelationshipsExample: View {
    @State private var relationships: C03_Relationship = .upgrade
    private let currentPlan = C03_groupPlans[1]   // Pro

    private var visible: [C03_Plan] {
        switch relationships {
        case .all: return C03_groupPlans
        case .upgrade: return C03_groupPlans.filter { $0.tier < currentPlan.tier }
        case .downgrade: return C03_groupPlans.filter { $0.tier > currentPlan.tier }
        case .current: return [currentPlan]
        }
    }

    var body: some View {
        VStack(spacing: 8) {
            Picker("visibleRelationships", selection: $relationships) {
                ForEach(C03_Relationship.allCases, id: \.self) { Text(".\($0.rawValue)").tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            C03_SubscriptionSheet(plans: visible, currentID: currentPlan.id) {
                C03_DefaultMarketingHeader(title: "Pro Access")
            }
            C03_Caption("Illustrative — StoreKit loads group 21534970 and filters it against the subscriber's current plan (Pro)")
        }
        .padding()
    }
}

private struct C03_SubscriptionMarketingExample: View {
    var body: some View {
        VStack(spacing: 8) {
            C03_SubscriptionSheet(plans: Array(C03_groupPlans.prefix(2))) {
                VStack(spacing: 6) {
                    LinearGradient(colors: [.purple, .blue], startPoint: .leading, endPoint: .trailing)
                        .frame(height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    Text("Unlock everything").font(.headline)
                }
            }
            C03_Caption("Illustrative — marketingContent replaces the default icon-and-title header; plans and purchase come from StoreKit")
        }
        .padding()
    }
}

private struct C03_SubscriptionProductIDsExample: View {
    var body: some View {
        VStack(spacing: 8) {
            C03_SubscriptionSheet(plans: C03_proPlans, showsIDs: true) {
                C03_DefaultMarketingHeader(title: "Pro")
            }
            C03_Caption("Illustrative — only the listed identifiers are loaded; a group with six plans would still show just these two")
        }
        .padding()
    }
}

private struct C03_SubscriptionProductsExample: View {
    var body: some View {
        VStack(spacing: 8) {
            C03_SubscriptionSheet(plans: C03_proPlans, prominent: true) {
                C03_DefaultMarketingHeader(title: "Pro")
            }
            C03_Caption("Illustrative — proPlans are Product values you fetched yourself; .prominentPicker renders the plans as large cards")
        }
        .padding()
    }
}

// MARK: - Shared TipKit illustration

private struct C03_ExportTip: Tip {
    @Parameter static var hasCreatedProject: Bool = false
    var title: Text { Text("Export Anytime") }
    var message: Text? { Text("Share a project as a PDF from the toolbar.") }
    var image: Image? { Image(systemName: "square.and.arrow.up") }
    var rules: [Rule] {
        #Rule(Self.$hasCreatedProject) { $0 == true }
    }
    var options: [TipOption] {
        [Tips.MaxDisplayCount(3), Tips.IgnoresDisplayFrequency(true)]
    }
    var actions: [Tips.Action] {
        [Tips.Action(id: "learn", title: "Learn More")]
    }
}

private struct C03_SyncTip: Tip {
    var title: Text { Text("Sync Across Devices") }
    var message: Text? { Text("Turn on iCloud sync in Settings to keep every Mac up to date.") }
    var image: Image? { Image(systemName: "icloud") }
}

private struct C03_Pointer: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.minX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        p.closeSubpath()
        return p
    }
}

/// Mirrors TipView's macOS layout so tip variants can be drawn without a
/// configured TipKit datastore (a real TipView stays empty until Tips.configure()).
/// Everything it shows — image, title, message, actions — is read from the real Tip.
private struct C03_TipCard: View {
    var tip: any Tip
    var arrowEdge: Edge? = nil
    var background: AnyShapeStyle = AnyShapeStyle(Color.gray.opacity(0.14))
    var cornerRadius: CGFloat = 12
    var miniature = false
    var onAction: (Tips.Action) -> Void = { _ in }
    var onClose: () -> Void = { }

    var body: some View {
        VStack(spacing: 0) {
            if arrowEdge == .top { pointer.rotationEffect(.degrees(180)) }
            HStack(alignment: miniature ? .center : .top, spacing: 10) {
                if let image = tip.image {
                    image.font(miniature ? .body : .title2).foregroundStyle(.blue)
                }
                VStack(alignment: .leading, spacing: 4) {
                    tip.title.font(.callout.weight(.semibold))
                    if !miniature, let message = tip.message {
                        message.font(.caption).foregroundStyle(.secondary)
                    }
                    if !miniature, !tip.actions.isEmpty {
                        HStack(spacing: 12) {
                            ForEach(tip.actions) { action in
                                Button { onAction(action) } label: { action.label() }
                                    .buttonStyle(.link)
                                    .font(.caption.weight(.semibold))
                            }
                        }
                        .padding(.top, 2)
                    }
                }
                Spacer(minLength: 0)
                Button(action: onClose) {
                    Image(systemName: "xmark").font(.caption2.weight(.bold))
                }
                .buttonStyle(.plain)
                .foregroundStyle(.secondary)
            }
            .padding(miniature ? 8 : 12)
            .background(background, in: RoundedRectangle(cornerRadius: cornerRadius))
            if arrowEdge == .bottom { pointer }
        }
    }

    private var pointer: some View {
        C03_Pointer()
            .fill(background)
            .frame(width: 18, height: 9)
    }
}

private struct C03_HiddenTipSlot: View {
    var reason: String

    var body: some View {
        Text(reason)
            .font(.caption)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, minHeight: 64)
            .background(.quaternary.opacity(0.4), in: RoundedRectangle(cornerRadius: 12))
    }
}

private struct C03_TipRulesExample: View {
    @State private var hasCreatedProject = false
    private let tip = C03_ExportTip()

    var body: some View {
        VStack(spacing: 10) {
            Toggle("ExportTip.hasCreatedProject", isOn: $hasCreatedProject)
                .font(.caption.monospaced())
                .onChange(of: hasCreatedProject) { _, newValue in
                    C03_ExportTip.hasCreatedProject = newValue     // the real @Parameter
                }
            if hasCreatedProject {
                C03_TipCard(tip: tip)
            } else {
                C03_HiddenTipSlot(reason: "#Rule { $0 == true } is false → the tip stays hidden")
            }
            C03_Caption("Illustrative — ExportTip declares \(tip.rules.count) rule; TipKit evaluates it once Tips.configure() has run")
        }
        .padding()
    }
}

private struct C03_TipOptionsExample: View {
    @State private var displays = 1
    private let tip = C03_ExportTip()
    private let maxDisplayCount = 3

    private var optionNames: String {
        tip.options.map { String(describing: type(of: $0)) }.joined(separator: ", ")
    }

    var body: some View {
        VStack(spacing: 10) {
            if displays <= maxDisplayCount {
                C03_TipCard(tip: tip, onClose: { displays += 1 })
            } else {
                C03_HiddenTipSlot(reason: "displayCountExceeded — MaxDisplayCount(3) retired the tip")
            }
            HStack {
                Button("Dismiss and show again") { displays += 1 }
                    .disabled(displays > maxDisplayCount)
                Spacer()
                Text("display \(min(displays, maxDisplayCount)) of \(maxDisplayCount)")
                    .font(.caption.monospacedDigit())
            }
            C03_Caption("Illustrative — options: [\(optionNames)]; IgnoresDisplayFrequency(true) ignores the displayFrequency set in Tips.configure()")
        }
        .padding()
    }
}

private struct C03_TipActionsExample: View {
    @State private var showHelp = false
    @State private var lastActionID: String?
    private let tip = C03_ExportTip()

    var body: some View {
        VStack(spacing: 10) {
            C03_TipCard(tip: tip, onAction: { action in
                lastActionID = action.id
                if action.id == "learn" { showHelp = true }
            })
            HStack {
                Text("action.id: \(lastActionID.map { "\"\($0)\"" } ?? "—")")
                    .font(.caption.monospaced())
                Spacer()
                Text("showHelp: \(showHelp ? "true" : "false")")
                    .font(.caption.monospaced())
                    .foregroundStyle(showHelp ? Color.green : Color.secondary)
            }
            C03_Caption("Illustrative — the button comes from the real tip.actions; TipView draws it once Tips.configure() has run")
        }
        .padding()
    }
}

private struct C03_TipInvalidateExample: View {
    @State private var invalidated = false
    @State private var exports = 0
    private let tip = C03_ExportTip()

    var body: some View {
        VStack(spacing: 10) {
            if invalidated {
                C03_HiddenTipSlot(reason: "invalidated(.actionPerformed) — the tip never shows again")
            } else {
                C03_TipCard(tip: tip)
            }
            HStack {
                Button("Export") {
                    exports += 1
                    C03_ExportTip().invalidate(reason: .actionPerformed)   // the real call
                    invalidated = true
                }
                .disabled(invalidated)
                Spacer()
                Text("exports: \(exports) · status: \(invalidated ? ".invalidated(.actionPerformed)" : ".available")")
                    .font(.caption.monospaced())
            }
            C03_Caption("Illustrative — invalidate(reason:) runs on the real ExportTip; TipKit persists the invalidation once Tips.configure() has run")
        }
        .padding()
    }
}

// MARK: - TipView

private struct C03_RenameTip: Tip {
    var title: Text { Text("Rename in Place") }
    var message: Text? { Text("Double-click a title to rename it without opening the inspector.") }
    var image: Image? { Image(systemName: "pencil.line") }
    var actions: [Tips.Action] { [Tips.Action(id: "learn", title: "Learn More")] }
}

private struct C03_TipViewArrowEdgeExample: View {
    @State private var edgeIndex = 1
    @State private var lastActionID: String?
    @State private var showHelp = false
    private let edges: [(name: String, edge: Edge?)] = [
        (name: "nil", edge: nil), (name: ".bottom", edge: .bottom), (name: ".top", edge: .top),
    ]

    var body: some View {
        VStack(spacing: 10) {
            Picker("arrowEdge", selection: $edgeIndex) {
                ForEach(edges.indices, id: \.self) { Text(edges[$0].name).tag($0) }
            }
            .pickerStyle(.segmented)
            .font(.caption)
            C03_TipCard(tip: C03_RenameTip(), arrowEdge: edges[edgeIndex].edge, onAction: { action in
                lastActionID = action.id
                if action.id == "learn" { showHelp = true }
            })
            HStack {
                Text("action.id: \(lastActionID.map { "\"\($0)\"" } ?? "—")")
                    .font(.caption.monospaced())
                Spacer()
                Text("showHelp: \(showHelp ? "true" : "false")")
                    .font(.caption.monospaced())
                    .foregroundStyle(showHelp ? Color.green : Color.secondary)
            }
            C03_Caption("Illustrative — the pointer sits on arrowEdge; TipView draws the real card once Tips.configure() has run")
        }
        .padding()
    }
}

private struct C03_TipViewStyleExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("default").font(.caption2).foregroundStyle(.secondary)
            C03_TipCard(tip: C03_SyncTip())
            Text(".tipViewStyle(.miniature)").font(.caption2).foregroundStyle(.secondary)
            C03_TipCard(tip: C03_SyncTip(), miniature: true)
            C03_Caption("Illustrative — .miniature drops the message and shrinks the glyph; a custom TipViewStyle can replace the whole layout")
        }
        .padding()
    }
}

private struct C03_TipBackgroundExample: View {
    @State private var index = 0
    private let styles: [(name: String, style: AnyShapeStyle)] = [
        (name: ".blue.opacity(0.1)", style: AnyShapeStyle(Color.blue.opacity(0.1))),
        (name: ".yellow.opacity(0.2)", style: AnyShapeStyle(Color.yellow.opacity(0.2))),
        (name: ".mint.gradient", style: AnyShapeStyle(Color.mint.gradient)),
        (name: ".regularMaterial", style: AnyShapeStyle(Material.regular)),
    ]

    var body: some View {
        VStack(spacing: 10) {
            Picker("tipBackground", selection: $index) {
                ForEach(styles.indices, id: \.self) { Text(styles[$0].name).tag($0) }
            }
            .pickerStyle(.menu)
            .font(.caption)
            C03_TipCard(tip: C03_SyncTip(), background: styles[index].style)
            C03_Caption("Illustrative — the whole tip container is filled with the ShapeStyle you pass")
        }
        .padding()
    }
}

private struct C03_TipCornerRadiusExample: View {
    @State private var radius: CGFloat = 20

    var body: some View {
        VStack(spacing: 10) {
            C03_TipCard(tip: C03_SyncTip(), cornerRadius: radius)
            Slider(value: $radius, in: 0...28) { Text("tipCornerRadius \(Int(radius))") }
                .font(.caption)
            C03_Caption("Illustrative — antialiased: true smooths the clipped edge; match the radius of the surrounding cards")
        }
        .padding()
    }
}

// MARK: - UIViewControllerRepresentable (iOS only — rendered through the macOS analog)

private let C03_pageTitles = ["Welcome", "Features", "Get Started"]

private struct C03_PagerMadeOnceBadge: NSViewControllerRepresentable {
    var page: Int

    func makeNSViewController(context: Context) -> C03_BadgeController {
        let controller = C03_BadgeController()
        controller.headline.stringValue = "Pager made at " + Date.now.formatted(date: .omitted, time: .standard)
        return controller
    }

    func updateNSViewController(_ controller: C03_BadgeController, context: Context) {
        controller.detail.stringValue = "page \(page + 1) of \(C03_pageTitles.count)"
    }
}

private struct C03_MakeUIViewControllerExample: View {
    @State private var page = 0

    var body: some View {
        VStack(spacing: 10) {
            C03_PagerMadeOnceBadge(page: page)
                .frame(width: 220, height: 60)
            Button("Next page") { page = (page + 1) % C03_pageTitles.count }
            C03_Caption("Illustrative — iOS only. The macOS analog's make ran once: the timestamp stays while the page advances through update")
        }
        .padding()
    }
}

private struct C03_PagerSyncBadge: NSViewControllerRepresentable {
    var currentIndex: Int

    func makeNSViewController(context: Context) -> C03_BadgeController { C03_BadgeController() }

    func updateNSViewController(_ controller: C03_BadgeController, context: Context) {
        controller.headline.stringValue = "Page \(currentIndex + 1): \(C03_pageTitles[currentIndex])"
        controller.detail.stringValue = "setViewControllers([controllers[\(currentIndex)]], direction: .forward)"
    }
}

private struct C03_UpdateUIViewControllerExample: View {
    @State private var currentIndex = 0

    var body: some View {
        VStack(spacing: 10) {
            C03_PagerSyncBadge(currentIndex: currentIndex)
                .frame(width: 320, height: 60)
            Picker("currentIndex", selection: $currentIndex) {
                ForEach(C03_pageTitles.indices, id: \.self) { Text("\($0)").tag($0) }
            }
            .pickerStyle(.segmented)
            .font(.caption)
            C03_Caption("Illustrative — iOS only. Each change of currentIndex re-runs update (updateNSViewController here) and pushes the target page in")
        }
        .padding()
    }
}

private struct C03_PagerCoordinatorButton: NSViewControllerRepresentable {
    @Binding var index: Int

    func makeCoordinator() -> Coordinator { Coordinator(pages: C03_pageTitles, index: $index) }

    func makeNSViewController(context: Context) -> C03_ButtonController {
        let controller = C03_ButtonController()
        controller.button.title = "Next page ›"
        controller.button.target = context.coordinator
        controller.button.action = #selector(Coordinator.advance)
        return controller
    }

    func updateNSViewController(_ controller: C03_ButtonController, context: Context) { }

    final class Coordinator: NSObject {
        let pages: [String]                     // the data source's backing store
        @Binding var index: Int
        init(pages: [String], index: Binding<Int>) {
            self.pages = pages
            _index = index
        }
        @objc func advance() { index = (index + 1) % pages.count }
    }
}

private struct C03_MakeCoordinatorUIExample: View {
    @State private var index = 0

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 6) {
                ForEach(C03_pageTitles.indices, id: \.self) { i in
                    Circle()
                        .fill(i == index ? Color.accentColor : Color.gray.opacity(0.35))
                        .frame(width: 8, height: 8)
                }
            }
            Text(C03_pageTitles[index]).font(.headline)
            C03_PagerCoordinatorButton(index: $index)
                .frame(width: 220, height: 44)
            C03_Caption("Illustrative — iOS only. The Coordinator owns the pages and answers the control's callbacks, writing the result back into @State")
        }
        .padding()
    }
}

private struct C03_SizeThatFitsUIExample: View {
    @State private var width: Double = 220

    var body: some View {
        VStack(spacing: 10) {
            C03_FixedHeightBadge()
                .frame(width: width, height: 110)          // proposal: width × 110
                .overlay(Rectangle().strokeBorder(.red, style: StrokeStyle(lineWidth: 1, dash: [4])))
            Slider(value: $width, in: 120...260) { Text("proposed width") }
                .font(.caption)
            C03_Caption("Illustrative — iOS only. Red box = proposal (\(Int(width)) × 110); the macOS analog answers \(Int(width)) × 56, exactly as the UIKit form would")
        }
        .padding()
    }
}

// MARK: - UserAnnotation

private struct C03_UserPuck: View {
    @State private var pulsing = false

    var body: some View {
        ZStack {
            Circle()
                .fill(.blue.opacity(0.25))
                .frame(width: pulsing ? 64 : 24, height: pulsing ? 64 : 24)
                .opacity(pulsing ? 0 : 1)
                .animation(.easeOut(duration: 1.6).repeatForever(autoreverses: false), value: pulsing)
            Circle()
                .fill(.blue)
                .frame(width: 16, height: 16)
                .overlay(Circle().stroke(.white, lineWidth: 3))
                .shadow(radius: 2)
        }
        .onAppear { pulsing = true }
    }
}

private struct C03_UserAnnotationExample: View {
    var body: some View {
        C03_MockMap(caption: "Illustrative — the puck follows the device location at runtime") {
            C03_UserPuck()
        }
    }
}

private struct C03_UserAnnotationContentExample: View {
    @State private var heading: Double = 45
    @State private var anchorIndex = 0
    private let anchors: [(name: String, point: UnitPoint)] = [
        (name: ".center", point: .center), (name: ".bottom", point: .bottom), (name: ".top", point: .top),
    ]

    var body: some View {
        VStack(spacing: 6) {
            C03_MockMap(caption: "Illustrative — UserLocation (coordinate + heading) arrives live at runtime; + marks the location") {
                Image(systemName: "plus")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.red)
                Image(systemName: "location.north.fill")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(.blue, in: Circle())
                    .rotationEffect(.degrees(heading))
                    .offset(y: (0.5 - anchors[anchorIndex].point.y) * 40)   // hang the content on its anchor
            }
            HStack {
                Picker("anchor", selection: $anchorIndex) {
                    ForEach(anchors.indices, id: \.self) { Text(anchors[$0].name).tag($0) }
                }
                .pickerStyle(.segmented)
                Slider(value: $heading, in: 0...359) { Text("heading \(Int(heading))°") }
            }
            .font(.caption)
            .padding(.horizontal)
        }
    }
}

// C03_END_STRUCTS
