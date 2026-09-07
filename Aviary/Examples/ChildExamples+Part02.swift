//
//  ChildExamples+Part02.swift
//  Aviary
//
//  Compiled renderings for variant entries (part 02: gen-system).
//  One private C02_* struct per variant; every rendering exercises the exact
//  overload the variant names. Variants that need iOS-only frameworks, App
//  Store data, map tiles, or file URLs render as faithful illustrations with
//  a caption saying so.
//

import SwiftUI
import Charts
import PhotosUI
import UniformTypeIdentifiers

enum ChildExamplesPart02 {
    static let entries: [ChildExampleEntry] = [

        // MARK: .appStoreOverlay()

        ChildExampleEntry(parent: ".appStoreOverlay()", child: "SKOverlay.AppConfiguration(appIdentifier:position:)", code: """
        .appStoreOverlay(isPresented: $showingOverlay) {
            let config = SKOverlay.AppConfiguration(appIdentifier: "1234567890",
                                                    position: .bottomRaised)
            config.campaignToken = "spring-launch"
            return config
        }
        """) { AnyView(C02_AppStoreOverlayConfigExample()) },

        ChildExampleEntry(parent: ".appStoreOverlay()", child: "SKOverlay.AppClipConfiguration(position:)", code: """
        // Inside an App Clip: promotes the clip's parent app, no identifier needed.
        .appStoreOverlay(isPresented: $promptForFullApp) {
            SKOverlay.AppClipConfiguration(position: .bottom)
        }
        """) { AnyView(C02_AppClipOverlayExample()) },

        ChildExampleEntry(parent: ".appStoreOverlay()", child: "SKOverlay.Position", code: """
        let raised = SKOverlay.AppConfiguration(appIdentifier: "1234567890",
                                                position: .bottomRaised)   // floats above a tab bar
        let flush = SKOverlay.AppConfiguration(appIdentifier: "1234567890",
                                               position: .bottom)          // hugs the bottom edge
        """) { AnyView(C02_SKOverlayPositionExample()) },

        // MARK: .chartForegroundStyleScale()

        ChildExampleEntry(parent: ".chartForegroundStyleScale()", child: ".chartForegroundStyleScale(_:)", code: """
        Chart(sales) { s in
            BarMark(x: .value("Month", s.month), y: .value("Amount", s.amount))
                .foregroundStyle(by: .value("Kind", s.kind))
        }
        .chartForegroundStyleScale([
            "Revenue": Color.green,
            "Cost": Color.red
        ])
        """) { AnyView(C02_ForegroundScaleMappingExample()) },

        ChildExampleEntry(parent: ".chartForegroundStyleScale()", child: ".chartForegroundStyleScale(domain:range:)", code: """
        let regions = ["North", "South", "West"]       // could come from data

        Chart(sales) { s in
            BarMark(x: .value("Month", s.month), y: .value("Amount", s.amount))
                .foregroundStyle(by: .value("Region", s.region))
        }
        .chartForegroundStyleScale(
            domain: regions,
            range: [Color.blue, Color.orange, Color.green]
        )
        """) { AnyView(C02_ForegroundScaleDomainRangeExample()) },

        ChildExampleEntry(parent: ".chartForegroundStyleScale()", child: ".chartForegroundStyleScale(range:)", code: """
        Chart(sales) { s in
            BarMark(x: .value("Month", s.month), y: .value("Amount", s.amount))
                .foregroundStyle(by: .value("Region", s.region))
        }
        .chartForegroundStyleScale(
            range: [Color.mint, Color.indigo, Color.pink]   // domain is inferred
        )
        """) { AnyView(C02_ForegroundScaleRangeExample()) },

        // MARK: .chartLegend()

        ChildExampleEntry(parent: ".chartLegend()", child: ".chartLegend(_:)", code: """
        Chart(sales) { s in
            BarMark(x: .value("Month", s.month), y: .value("Amount", s.amount))
                .foregroundStyle(by: .value("Region", s.region))
        }
        .chartLegend(showLegend ? .visible : .hidden)
        """) { AnyView(C02_ChartLegendVisibilityExample()) },

        ChildExampleEntry(parent: ".chartLegend()", child: ".chartLegend(position:alignment:spacing:)", code: """
        Chart(sales) { s in
            BarMark(x: .value("Month", s.month), y: .value("Amount", s.amount))
                .foregroundStyle(by: .value("Region", s.region))
        }
        .chartLegend(position: .trailing,
                     alignment: .top,
                     spacing: 12)
        """) { AnyView(C02_ChartLegendPositionExample()) },

        ChildExampleEntry(parent: ".chartLegend()", child: ".chartLegend(position:alignment:spacing:content:)", code: """
        Chart(sales) { s in
            BarMark(x: .value("Month", s.month), y: .value("Amount", s.amount))
                .foregroundStyle(by: .value("Region", s.region))
        }
        .chartLegend(position: .bottom, alignment: .leading) {
            HStack {
                Circle().fill(.blue).frame(width: 8)
                Text("North")
                Circle().fill(.orange).frame(width: 8)
                Text("South")
                Circle().fill(.green).frame(width: 8)
                Text("West")
            }.font(.caption)
        }
        """) { AnyView(C02_ChartLegendContentExample()) },

        // MARK: .chartXAxis()

        ChildExampleEntry(parent: ".chartXAxis()", child: ".chartXAxis(_:)", code: """
        Chart(entries) { e in
            BarMark(x: .value("Day", e.day), y: .value("Steps", e.steps))
        }
        .chartXAxis(showAxis ? .visible : .hidden)
        """) { AnyView(C02_ChartXAxisVisibilityExample()) },

        ChildExampleEntry(parent: ".chartXAxis()", child: ".chartXAxis(content:)", code: """
        Chart(prices) { p in
            LineMark(x: .value("Date", p.date), y: .value("Close", p.close))
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .day, count: 7)) { _ in
                AxisGridLine()
                AxisValueLabel(format: .dateTime.month().day())
            }
        }
        """) { AnyView(C02_ChartXAxisContentExample()) },

        // MARK: .chartXScale()

        ChildExampleEntry(parent: ".chartXScale()", child: ".chartXScale(domain:type:)", code: """
        Chart(prices) { p in
            LineMark(x: .value("Date", p.date), y: .value("Close", p.close))
        }
        .chartXScale(domain: startDate...endDate)   // pinned, not inferred from the data
        """) { AnyView(C02_ChartXScaleDomainExample()) },

        ChildExampleEntry(parent: ".chartXScale()", child: ".chartXScale(range:)", code: """
        Chart(points) { pt in
            PointMark(x: .value("Day", pt.day), y: .value("Steps", pt.steps))
        }
        .chartXScale(range: .plotDimension(padding: padding))   // 0 … 40 pt
        """) { AnyView(C02_ChartXScaleRangeExample()) },

        ChildExampleEntry(parent: ".chartXScale()", child: ".chartXScale(type:)", code: """
        Chart(samples) { s in                       // 20 Hz … 20 kHz
            LineMark(x: .value("Frequency", s.hz), y: .value("Gain", s.db))
            PointMark(x: .value("Frequency", s.hz), y: .value("Gain", s.db))
        }
        .chartXScale(type: .log)                    // domain still inferred
        """) { AnyView(C02_ChartXScaleTypeExample()) },

        // MARK: .chartXSelection()

        ChildExampleEntry(parent: ".chartXSelection()", child: ".chartXSelection(value:)", code: """
        @State private var selected: Date?

        Chart {
            ForEach(prices) { p in
                LineMark(x: .value("Date", p.date), y: .value("Close", p.close))
            }
            if let selected {
                RuleMark(x: .value("Selected", selected))
            }
        }
        .chartXSelection(value: $selected)
        """) { AnyView(C02_ChartXSelectionValueExample()) },

        ChildExampleEntry(parent: ".chartXSelection()", child: ".chartXSelection(range:)", code: """
        @State private var window: ClosedRange<Date>?

        Chart {
            ForEach(prices) { p in
                LineMark(x: .value("Date", p.date), y: .value("Close", p.close))
            }
            if let window {
                RectangleMark(xStart: .value("From", window.lowerBound),
                              xEnd: .value("To", window.upperBound))
            }
        }
        .chartXSelection(range: $window)
        """) { AnyView(C02_ChartXSelectionRangeExample()) },

        // MARK: .chartYAxis()

        ChildExampleEntry(parent: ".chartYAxis()", child: ".chartYAxis(_:)", code: """
        Chart(entries) { e in
            LineMark(x: .value("Day", e.day), y: .value("Steps", e.steps))
        }
        .chartYAxis(showAxis ? .visible : .hidden)
        """) { AnyView(C02_ChartYAxisVisibilityExample()) },

        ChildExampleEntry(parent: ".chartYAxis()", child: ".chartYAxis(content:)", code: """
        Chart(scores) { s in
            LineMark(x: .value("Trial", s.trial), y: .value("Score", s.score))
        }
        .chartYAxis {
            AxisMarks(position: .leading, values: [0, 50, 100]) { _ in
                AxisGridLine()
                AxisValueLabel()
            }
        }
        """) { AnyView(C02_ChartYAxisContentExample()) },

        // MARK: .chartYScale()

        ChildExampleEntry(parent: ".chartYScale()", child: ".chartYScale(domain:type:)", code: """
        Chart(samples) { s in                       // inferred: ~40 … 85
            LineMark(x: .value("Trial", s.trial), y: .value("Score", s.score))
        }

        Chart(samples) { s in                       // locked: 0 … 100
            LineMark(x: .value("Trial", s.trial), y: .value("Score", s.score))
        }
        .chartYScale(domain: 0...100)
        """) { AnyView(C02_ChartYScaleDomainExample()) },

        ChildExampleEntry(parent: ".chartYScale()", child: "AutomaticScaleDomain.automatic(includesZero:reversed:)", code: """
        Chart(entries) { e in
            LineMark(x: .value("Day", e.day), y: .value("Change", e.delta))
        }
        .chartYScale(domain: .automatic(includesZero: includesZero, reversed: reversed))
        """) { AnyView(C02_AutomaticScaleDomainExample()) },

        ChildExampleEntry(parent: ".chartYScale()", child: ".chartYScale(type:)", code: """
        Chart(readings) { r in                      // −1 200 … 9 000, crossing zero
            LineMark(x: .value("Time", r.time), y: .value("Delta", r.delta))
            PointMark(x: .value("Time", r.time), y: .value("Delta", r.delta))
        }
        .chartYScale(type: .symmetricLog)
        """) { AnyView(C02_ChartYScaleTypeExample()) },

        // MARK: .manageSubscriptionsSheet()

        ChildExampleEntry(parent: ".manageSubscriptionsSheet()", child: ".manageSubscriptionsSheet(isPresented:subscriptionGroupID:)", code: """
        Button("Manage Subscription") { managing = true }
            .manageSubscriptionsSheet(isPresented: $managing,
                                      subscriptionGroupID: "21534970")
        """) { AnyView(C02_ManageSubscriptionsGroupExample()) },

        ChildExampleEntry(parent: ".manageSubscriptionsSheet()", child: ".manageSubscriptionsSheet(isPresented:)", code: """
        Button("Manage Subscription") { managing = true }
            .manageSubscriptionsSheet(isPresented: $managing)
        """) { AnyView(C02_ManageSubscriptionsAllExample()) },

        // MARK: .mapControls()

        ChildExampleEntry(parent: ".mapControls()", child: "MapUserLocationButton", code: """
        Map(position: $position)
            .mapControls { MapUserLocationButton() }
        """) { AnyView(C02_MapUserLocationButtonExample()) },

        ChildExampleEntry(parent: ".mapControls()", child: "MapCompass", code: """
        Map(position: $position)
            .mapControls { MapCompass() }   // appears once the heading leaves north
        """) { AnyView(C02_MapCompassExample()) },

        ChildExampleEntry(parent: ".mapControls()", child: "MapScaleView", code: """
        Map(position: $position)
            .mapControls { MapScaleView() }
        """) { AnyView(C02_MapScaleViewExample()) },

        ChildExampleEntry(parent: ".mapControls()", child: "MapPitchToggle", code: """
        Map(position: $position)
            .mapStyle(.standard(elevation: .realistic))
            .mapControls {
                MapPitchToggle()
            }
        """) { AnyView(C02_MapPitchToggleExample()) },

        // MARK: .mapStyle()

        ChildExampleEntry(parent: ".mapStyle()", child: "MapStyle.standard(elevation:emphasis:pointsOfInterest:showsTraffic:)", code: """
        Map {
            MapPolyline(coordinates: route).stroke(.blue, lineWidth: 5)
        }
        .mapStyle(.standard(elevation: .flat,
                            emphasis: .muted,
                            pointsOfInterest: .excludingAll,
                            showsTraffic: true))
        """) { AnyView(C02_MapStyleStandardExample()) },

        ChildExampleEntry(parent: ".mapStyle()", child: "MapStyle.imagery(elevation:)", code: """
        Map(position: $position)
            .mapStyle(.imagery(elevation: .realistic))   // no labels, no roads
        """) { AnyView(C02_MapStyleImageryExample()) },

        ChildExampleEntry(parent: ".mapStyle()", child: "MapStyle.hybrid(elevation:pointsOfInterest:showsTraffic:)", code: """
        Map(position: $position)
            .mapStyle(.hybrid(elevation: .realistic,
                              pointsOfInterest: .including([.cafe, .park]),
                              showsTraffic: false))
        """) { AnyView(C02_MapStyleHybridExample()) },

        ChildExampleEntry(parent: ".mapStyle()", child: "PointOfInterestCategories", code: """
        let onlyFood: PointOfInterestCategories = .including([.restaurant, .cafe, .bakery])
        let noSchools: PointOfInterestCategories = .excluding([.school, .university])

        Map(position: $position)
            .mapStyle(.standard(pointsOfInterest: onlyFood))   // or .includingAll / .excludingAll
        """) { AnyView(C02_PointOfInterestCategoriesExample()) },

        // MARK: .onDrag()

        ChildExampleEntry(parent: ".onDrag()", child: ".onDrag(_:preview:)", code: """
        Text("Quarterly Report.pdf")
            .onDrag {
                NSItemProvider(object: "Quarterly Report.pdf" as NSString)
            } preview: {
                Label("Quarterly Report", systemImage: "doc.richtext")   // lifted instead of a snapshot
                    .padding(8)
                    .background(.blue.opacity(0.2), in: Capsule())
            }
        """) { AnyView(C02_OnDragPreviewExample()) },

        ChildExampleEntry(parent: ".onDrag()", child: ".onDrag(_:)", code: """
        Image(systemName: "doc")
            .onDrag {
                NSItemProvider(object: "Quarterly Report.pdf" as NSString)   // preview = snapshot of the source
            }
        """) { AnyView(C02_OnDragBasicExample()) },

        // MARK: .onDrop()

        ChildExampleEntry(parent: ".onDrop()", child: ".onDrop(of:delegate:)", code: """
        ForEach(items, id: \\.self) { item in
            Chip(item)
                .onDrag { NSItemProvider(object: item as NSString) }
                .onDrop(of: [.text],
                        delegate: ReorderDelegate(target: item, items: $items, dragging: $dragging))
        }
        """) { AnyView(C02_OnDropDelegateExample()) },

        ChildExampleEntry(parent: ".onDrop()", child: ".onDrop(of:isTargeted:perform:)", code: """
        RoundedRectangle(cornerRadius: 10)
            .fill(isTargeted ? Color.blue.opacity(0.3) : Color.gray.opacity(0.15))
            .onDrop(of: [.text], isTargeted: $isTargeted) { providers in
                dropped += providers.count
                return true
            }
        """) { AnyView(C02_OnDropTargetedExample()) },

        ChildExampleEntry(parent: ".onDrop()", child: ".onDrop(of:isTargeted:perform:) with drop location", code: """
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.15))
            ForEach(pins.indices, id: \\.self) { i in
                Image(systemName: "mappin").position(pins[i])
            }
        }
        .onDrop(of: [.text], isTargeted: nil) { providers, location in
            pins.append(location)            // in the view's own coordinate space
            return true
        }
        """) { AnyView(C02_OnDropLocationExample()) },

        ChildExampleEntry(parent: ".onDrop()", child: "DropDelegate", code: """
        struct StatusDelegate: DropDelegate {
            @Binding var status: String
            func validateDrop(info: DropInfo) -> Bool { info.hasItemsConforming(to: [.text]) }
            func dropEntered(info: DropInfo) { status = "dropEntered" }
            func dropUpdated(info: DropInfo) -> DropProposal? {
                status = "dropUpdated at \\(Int(info.location.x)), \\(Int(info.location.y))"
                return DropProposal(operation: .copy)
            }
            func dropExited(info: DropInfo) { status = "dropExited" }
            func performDrop(info: DropInfo) -> Bool { status = "performDrop → true"; return true }
        }
        """) { AnyView(C02_DropDelegateExample()) },

        // MARK: .onMapCameraChange()

        ChildExampleEntry(parent: ".onMapCameraChange()", child: ".onMapCameraChange(frequency:_:)", code: """
        Map(position: $position)
            .onMapCameraChange(frequency: .continuous) { context in
                center = context.camera.centerCoordinate
                callbacks += 1
            }
        """) { AnyView(C02_OnMapCameraChangeExample()) },

        ChildExampleEntry(parent: ".onMapCameraChange()", child: "MapCameraUpdateContext", code: """
        .onMapCameraChange(frequency: .onEnd) { context in
            let region = context.region      // MKCoordinateRegion
            let rect = context.rect          // MKMapRect
            let camera = context.camera      // MapCamera
            reloadPins(in: region, zoomDistance: camera.distance)
        }
        """) { AnyView(C02_MapCameraUpdateContextExample()) },

        ChildExampleEntry(parent: ".onMapCameraChange()", child: "MapCameraUpdateFrequency", code: """
        Map(position: $position)
            .onMapCameraChange(frequency: frequency) { context in   // .continuous or .onEnd
                fetchPlaces(in: context.region)
            }
        """) { AnyView(C02_MapCameraUpdateFrequencyExample()) },

        // MARK: .photosPicker()

        ChildExampleEntry(parent: ".photosPicker()", child: ".photosPicker(isPresented:selection:maxSelectionCount:matching:)", code: """
        @State private var items: [PhotosPickerItem] = []

        Button("Choose up to 4 Photos…") { picking = true }
            .photosPicker(isPresented: $picking,
                          selection: $items,
                          maxSelectionCount: 4,
                          matching: .any(of: [.images, .screenshots]))
        """) { AnyView(C02_PhotosPickerMaxCountExample()) },

        ChildExampleEntry(parent: ".photosPicker()", child: ".photosPicker(isPresented:selection:matching:preferredItemEncoding:)", code: """
        @State private var selection: PhotosPickerItem?      // single, optional

        Button("Choose a Photo…") { showingPicker = true }
            .photosPicker(isPresented: $showingPicker,
                          selection: $selection,
                          matching: .images,
                          preferredItemEncoding: .current)
        """) { AnyView(C02_PhotosPickerSingleExample()) },

        ChildExampleEntry(parent: ".photosPicker()", child: ".photosPicker(isPresented:selection:maxSelectionCount:selectionBehavior:matching:preferredItemEncoding:)", code: """
        @State private var items: [PhotosPickerItem] = []

        Button("Choose Photos…") { picking = true }
            .photosPicker(isPresented: $picking,
                          selection: $items,
                          maxSelectionCount: 4,
                          selectionBehavior: .ordered,          // numbered badges, array keeps pick order
                          matching: .any(of: [.images, .screenshots]),
                          preferredItemEncoding: .automatic)
        """) { AnyView(C02_PhotosPickerOrderedExample()) },

        ChildExampleEntry(parent: ".photosPicker()", child: "PHPickerFilter.any(of:)", code: """
        let stills: PHPickerFilter = .any(of: [.images, .screenshots])
        let noLive: PHPickerFilter = .all(of: [.images, .not(.livePhotos)])

        Button("Choose Photos…") { picking = true }
            .photosPicker(isPresented: $picking, selection: $items, matching: useStills ? stills : noLive)
        """) { AnyView(C02_PHPickerFilterAnyExample()) },

        // MARK: .productViewStyle()

        ChildExampleEntry(parent: ".productViewStyle()", child: "ProductViewStyle.compact", code: """
        StoreView(ids: ["com.example.tip.small", "com.example.tip.large"])
            .productViewStyle(.compact)      // icon · name · price on one row
        """) { AnyView(C02_ProductViewCompactExample()) },

        ChildExampleEntry(parent: ".productViewStyle()", child: "ProductViewStyle.regular", code: """
        ProductView(id: "com.example.pro")
            .productViewStyle(.regular)      // the default: icon beside name, description, buy button
        """) { AnyView(C02_ProductViewRegularExample()) },

        ChildExampleEntry(parent: ".productViewStyle()", child: "ProductViewStyle.large", code: """
        ProductView(id: "com.example.pro.lifetime") {
            Image("lifetime-art").resizable().scaledToFit()   // your own hero artwork
        }
        .productViewStyle(.large)
        """) { AnyView(C02_ProductViewLargeExample()) },

        // MARK: .quickLookPreview()

        ChildExampleEntry(parent: ".quickLookPreview()", child: ".quickLookPreview(_:in:)", code: """
        @State private var selected: URL?
        let attachments: [URL] = [invoice, contract, photo]

        Button("Preview All") { selected = attachments.first }
            .quickLookPreview($selected, in: attachments)   // ← / → step through the collection
        """) { AnyView(C02_QuickLookCollectionExample()) },

        ChildExampleEntry(parent: ".quickLookPreview()", child: ".quickLookPreview(_:)", code: """
        @State private var previewURL: URL?

        Button("Preview") { previewURL = attachment }
            .quickLookPreview($previewURL)    // dismissing sets previewURL back to nil
        """) { AnyView(C02_QuickLookSingleExample()) },

        // MARK: .storeButton()

        ChildExampleEntry(parent: ".storeButton()", child: "StoreButtonKind.restorePurchases", code: """
        StoreView(ids: productIDs)
            .storeButton(.visible, for: .restorePurchases)   // hidden unless you opt in
        """) { AnyView(C02_StoreButtonRestoreExample()) },

        ChildExampleEntry(parent: ".storeButton()", child: "StoreButtonKind.redeemCode", code: """
        SubscriptionStoreView(groupID: groupID)
            .storeButton(.visible, for: .redeemCode)         // offer-code redemption
        """) { AnyView(C02_StoreButtonRedeemExample()) },

        ChildExampleEntry(parent: ".storeButton()", child: "StoreButtonKind.policies", code: """
        SubscriptionStoreView(groupID: groupID)
            .storeButton(.visible, for: .policies)
            .subscriptionStorePolicyDestination(url: privacyURL, for: .privacyPolicy)
        """) { AnyView(C02_StoreButtonPoliciesExample()) },

        ChildExampleEntry(parent: ".storeButton()", child: "StoreButtonKind.cancellation", code: """
        NavigationLink("Upgrade") {
            SubscriptionStoreView(groupID: groupID)
                .storeButton(.hidden, for: .cancellation)    // no close button on a pushed screen
        }
        """) { AnyView(C02_StoreButtonCancellationExample()) },

        // MARK: .subscriptionStoreControlStyle()

        ChildExampleEntry(parent: ".subscriptionStoreControlStyle()", child: "SubscriptionStoreControlStyle.picker", code: """
        SubscriptionStoreView(groupID: groupID)
            .subscriptionStoreControlStyle(.picker)          // rows + one shared Subscribe button
        """) { AnyView(C02_SubscriptionControlPickerExample()) },

        ChildExampleEntry(parent: ".subscriptionStoreControlStyle()", child: "SubscriptionStoreControlStyle.prominentPicker", code: """
        SubscriptionStoreView(groupID: groupID)
            .subscriptionStoreControlStyle(.prominentPicker) // the selected plan is filled in
        """) { AnyView(C02_SubscriptionControlProminentExample()) },

        ChildExampleEntry(parent: ".subscriptionStoreControlStyle()", child: "SubscriptionStoreControlStyle.buttons", code: """
        SubscriptionStoreView(groupID: groupID)
            .subscriptionStoreControlStyle(.buttons)         // one purchase button per plan
            .subscriptionStoreButtonLabel(.multiline)
        """) { AnyView(C02_SubscriptionControlButtonsExample()) },

        // MARK: Annotation

        ChildExampleEntry(parent: "Annotation", child: "Annotation(_:coordinate:anchor:content:)", code: """
        Map {
            Annotation("Coffee", coordinate: cafe, anchor: anchor) {   // .bottom / .center / .top / .leading
                Image(systemName: "cup.and.saucer.fill")
                    .padding(6)
                    .background(.orange, in: Circle())
            }
        }
        """) { AnyView(C02_AnnotationAnchorExample()) },

        ChildExampleEntry(parent: "Annotation", child: "Annotation(coordinate:anchor:content:label:)", code: """
        Map {
            Annotation(coordinate: hq, anchor: .center) {
                Circle().fill(.blue).frame(width: 12, height: 12)
            } label: {
                Text("Aviary HQ")                      // a view, not a plain string
                    .font(.caption.bold())
                    .foregroundStyle(.blue)
            }
        }
        """) { AnyView(C02_AnnotationLabelExample()) },

        ChildExampleEntry(parent: "Annotation", child: ".annotationTitles(_:)", code: """
        Map {
            ForEach(stops) { stop in
                Annotation(stop.name, coordinate: stop.coordinate) {
                    Image(systemName: "tram.fill").padding(5).background(.green, in: Circle())
                }
                .annotationTitles(titles)             // .hidden keeps the glyphs, drops the captions
            }
        }
        """) { AnyView(C02_AnnotationTitlesExample()) },

        // MARK: AreaMark

        ChildExampleEntry(parent: "AreaMark", child: "AreaMark(x:y:stacking:)", code: """
        Chart(traffic) { t in
            AreaMark(x: .value("Hour", t.hour),
                     y: .value("Requests", t.count),
                     stacking: normalized ? .normalized : .standard)   // .normalized: every hour sums to 100 %
            .foregroundStyle(by: .value("Source", t.source))
        }
        """) { AnyView(C02_AreaMarkStackingExample()) },

        ChildExampleEntry(parent: "AreaMark", child: "AreaMark(x:yStart:yEnd:)", code: """
        Chart(forecast) { f in
            AreaMark(x: .value("Day", f.date),
                     yStart: .value("Low", f.low),
                     yEnd: .value("High", f.high))       // a band between two values, not a fill from the baseline
            .foregroundStyle(Color.orange)
            .opacity(0.3)
            LineMark(x: .value("Day", f.date), y: .value("Forecast", f.mid))
                .foregroundStyle(Color.orange)
        }
        """) { AnyView(C02_AreaMarkBandExample()) },

        ChildExampleEntry(parent: "AreaMark", child: "AreaMark(x:y:series:stacking:)", code: """
        Chart(readings) { r in
            AreaMark(x: .value("Time", r.time),
                     y: .value("Level", r.level),
                     series: .value("Sensor", r.sensorID),   // three separate areas …
                     stacking: .unstacked)
            .foregroundStyle(Color.teal.opacity(0.4))         // … in one shared style, no legend
        }
        """) { AnyView(C02_AreaMarkSeriesExample()) },

        ChildExampleEntry(parent: "AreaMark", child: "MarkStackingMethod", code: """
        Chart(shares) { m in
            AreaMark(x: .value("Month", m.month),
                     y: .value("Share", m.share),
                     stacking: method.value)             // .standard, .normalized, .center, .unstacked
            .foregroundStyle(by: .value("Product", m.product))
        }
        """) { AnyView(C02_MarkStackingMethodExample()) },

        // MARK: AxisMarks

        ChildExampleEntry(parent: "AxisMarks", child: "AxisGridLine", code: """
        Chart(scores) { s in
            LineMark(x: .value("Trial", s.trial), y: .value("Score", s.score))
        }
        .chartYAxis {
            AxisMarks { _ in
                AxisGridLine(stroke: StrokeStyle(dash: dashed ? [2, 3] : []))   // the line across the plot
                AxisValueLabel()
            }
        }
        """) { AnyView(C02_AxisGridLineExample()) },

        ChildExampleEntry(parent: "AxisMarks", child: "AxisTick", code: """
        Chart(steps) { e in
            BarMark(x: .value("Day", e.day), y: .value("Steps", e.steps))
        }
        .chartXAxis {
            AxisMarks { _ in
                AxisTick(length: tickLength)        // short mark outside the plot edge; no grid line
                AxisValueLabel()
            }
        }
        """) { AnyView(C02_AxisTickExample()) },

        ChildExampleEntry(parent: "AxisMarks", child: "AxisValueLabel", code: """
        Chart(prices) { p in
            LineMark(x: .value("Date", p.date), y: .value("Close", p.close))
        }
        .chartYAxis {
            AxisMarks(values: .automatic) { _ in
                AxisGridLine()
                AxisValueLabel(format: .currency(code: "USD"))   // "$100" instead of "100"
            }
        }
        """) { AnyView(C02_AxisValueLabelExample()) },

        ChildExampleEntry(parent: "AxisMarks", child: "AxisMarks(preset:position:values:stroke:)", code: """
        Chart(scores) { s in
            LineMark(x: .value("Trial", s.trial), y: .value("Score", s.score))
        }
        .chartYAxis {
            AxisMarks(preset: preset.value,                 // .automatic / .aligned / .extended / .inset
                      position: leading ? .leading : .trailing,
                      values: .automatic(desiredCount: 4),
                      stroke: StrokeStyle(lineWidth: 0.5))
        }
        """) { AnyView(C02_AxisMarksPresetExample()) },

        // MARK: BarMark

        ChildExampleEntry(parent: "BarMark", child: "BarMark(x:y:width:height:stacking:)", code: """
        Chart(sales) { sale in
            BarMark(x: .value("Month", sale.month),
                    y: .value("Units", sale.units),
                    width: .ratio(ratio),                       // 0.2 … 1.0 of the band
                    height: .automatic,
                    stacking: normalized ? .normalized : .standard)
            .foregroundStyle(by: .value("Region", sale.region))
        }
        """) { AnyView(C02_BarMarkStandardExample()) },

        ChildExampleEntry(parent: "BarMark", child: "BarMark(x:yStart:yEnd:width:)", code: """
        Chart(shifts) { s in                                    // hours of the day
            BarMark(x: .value("Day", s.day),
                    yStart: .value("Start", s.start),
                    yEnd: .value("End", s.end),                 // floats between two y values
                    width: .fixed(14))
            .cornerRadius(4)
        }
        .chartYScale(domain: 6...24)
        """) { AnyView(C02_BarMarkRangeExample()) },

        ChildExampleEntry(parent: "BarMark", child: "BarMark(xStart:xEnd:y:height:)", code: """
        Chart(tasks) { task in
            BarMark(xStart: .value("Begin", task.start),
                    xEnd: .value("Finish", task.end),
                    y: .value("Task", task.name),               // categorical y → horizontal bars
                    height: .inset(4))
            .foregroundStyle(by: .value("Task", task.name))
        }
        .chartLegend(.hidden)
        """) { AnyView(C02_BarMarkHorizontalExample()) },

        ChildExampleEntry(parent: "BarMark", child: "MarkDimension", code: """
        Chart(teams) { t in
            BarMark(x: .value("Team", t.name),
                    y: .value("Wins", t.wins),
                    width: width.value)     // .automatic, .fixed(24), .ratio(0.5), .inset(6)
        }
        """) { AnyView(C02_MarkDimensionExample()) },

        // MARK: ChartProxy

        ChildExampleEntry(parent: "ChartProxy", child: "value(atX:as:)", code: """
        .chartOverlay { proxy in
            GeometryReader { geo in
                Rectangle().fill(.clear).contentShape(Rectangle())
                    .gesture(DragGesture(minimumDistance: 0).onChanged { drag in
                        guard let plot = proxy.plotFrame else { return }
                        let x = drag.location.x - geo[plot].origin.x        // into plot coordinates
                        selected = proxy.value(atX: x, as: Date.self)      // nil outside the plot
                    })
            }
        }
        """) { AnyView(C02_ChartProxyValueAtXExample()) },

        ChildExampleEntry(parent: "ChartProxy", child: "position(forX:)", code: """
        .chartOverlay { proxy in
            GeometryReader { geo in
                if let x = proxy.position(forX: selectedDate), let plot = proxy.plotFrame {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 1, height: geo[plot].height)
                        .offset(x: geo[plot].origin.x + x, y: geo[plot].origin.y)   // plot → overlay space
                }
            }
        }
        """) { AnyView(C02_ChartProxyPositionForXExample()) },

        ChildExampleEntry(parent: "ChartProxy", child: "value(at:as:)", code: """
        .chartOverlay { proxy in
            GeometryReader { geo in
                Rectangle().fill(.clear).contentShape(Rectangle())
                    .gesture(DragGesture(minimumDistance: 0).onChanged { drag in
                        guard let plot = proxy.plotFrame else { return }
                        let origin = geo[plot].origin
                        let point = CGPoint(x: drag.location.x - origin.x, y: drag.location.y - origin.y)
                        hit = proxy.value(at: point, as: (Date, Double).self)   // x and y in one call
                    })
            }
        }
        """) { AnyView(C02_ChartProxyValueAtExample()) },

        // C02_END_ENTRIES
    ]
}

// MARK: - Shared helpers

private struct C02_Caption: View {
    let text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        Text(text)
            .font(.caption2)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
    }
}

private enum C02_Data {
    struct Sale: Identifiable {
        let id = UUID()
        let month: String
        let amount: Double
        let kind: String
    }
    static let sales: [Sale] = [
        Sale(month: "Jan", amount: 42, kind: "Revenue"), Sale(month: "Jan", amount: 28, kind: "Cost"),
        Sale(month: "Feb", amount: 55, kind: "Revenue"), Sale(month: "Feb", amount: 31, kind: "Cost"),
        Sale(month: "Mar", amount: 61, kind: "Revenue"), Sale(month: "Mar", amount: 35, kind: "Cost"),
        Sale(month: "Apr", amount: 48, kind: "Revenue"), Sale(month: "Apr", amount: 30, kind: "Cost"),
    ]

    struct Regional: Identifiable {
        let id = UUID()
        let month: String
        let amount: Double
        let region: String
    }
    static let regional: [Regional] = [
        Regional(month: "Jan", amount: 30, region: "North"), Regional(month: "Jan", amount: 22, region: "South"), Regional(month: "Jan", amount: 14, region: "West"),
        Regional(month: "Feb", amount: 34, region: "North"), Regional(month: "Feb", amount: 25, region: "South"), Regional(month: "Feb", amount: 19, region: "West"),
        Regional(month: "Mar", amount: 28, region: "North"), Regional(month: "Mar", amount: 31, region: "South"), Regional(month: "Mar", amount: 23, region: "West"),
        Regional(month: "Apr", amount: 39, region: "North"), Regional(month: "Apr", amount: 27, region: "South"), Regional(month: "Apr", amount: 26, region: "West"),
    ]

    struct Steps: Identifiable {
        let id = UUID()
        let day: String
        let steps: Double
    }
    static let steps: [Steps] = [
        Steps(day: "Mon", steps: 6_200), Steps(day: "Tue", steps: 8_100), Steps(day: "Wed", steps: 4_900),
        Steps(day: "Thu", steps: 9_400), Steps(day: "Fri", steps: 7_300), Steps(day: "Sat", steps: 11_800),
        Steps(day: "Sun", steps: 3_600),
    ]

    struct Score: Identifiable {
        let id = UUID()
        let trial: Int
        let score: Double
    }
    static let scores: [Score] = [
        Score(trial: 1, score: 42), Score(trial: 2, score: 58), Score(trial: 3, score: 51),
        Score(trial: 4, score: 73), Score(trial: 5, score: 66), Score(trial: 6, score: 81),
    ]

    struct Price: Identifiable {
        let id = UUID()
        let date: Date
        let close: Double
    }
    /// 2024-06-01 00:00 UTC, so every rendering shows the same dates.
    static let baseDate = Date(timeIntervalSince1970: 1_717_200_000)
    static func day(_ offset: Int) -> Date { baseDate.addingTimeInterval(Double(offset) * 86_400) }
    static let prices: [Price] = (0..<28).map { i in
        Price(date: day(i), close: 100 + 12 * sin(Double(i) / 3) + Double(i) * 0.8)
    }
}

/// A mock App Store overlay banner (SKOverlay is iOS-only).
private struct C02_MockOverlayBanner: View {
    var title: String
    var subtitle: String
    var body: some View {
        HStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.blue.gradient)
                .frame(width: 34, height: 34)
                .overlay(Image(systemName: "sparkles").foregroundStyle(.white))
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.caption.bold())
                Text(subtitle).font(.caption2).foregroundStyle(.secondary)
            }
            Spacer()
            Text("GET")
                .font(.caption.bold())
                .padding(.horizontal, 12)
                .padding(.vertical, 5)
                .background(Color.blue, in: Capsule())
                .foregroundStyle(.white)
        }
        .padding(10)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 4, y: 2)
    }
}

/// A mock phone screen with a tab bar, so `.bottom` vs `.bottomRaised` is visible.
private struct C02_MockPhone: View {
    enum BannerPosition { case bottom, bottomRaised }
    var isPresented: Bool
    var position: BannerPosition
    var title: String
    var subtitle: String

    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 14).fill(.quaternary)
            VStack(spacing: 0) {
                Spacer()
                if isPresented && position == .bottomRaised {
                    C02_MockOverlayBanner(title: title, subtitle: subtitle)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 6)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                HStack {
                    ForEach(["house.fill", "magnifyingglass", "person.fill"], id: \.self) { name in
                        Image(systemName: name).frame(maxWidth: .infinity)
                    }
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(.vertical, 8)
                .background(.bar)
            }
            .clipShape(RoundedRectangle(cornerRadius: 14))
            if isPresented && position == .bottom {
                C02_MockOverlayBanner(title: title, subtitle: subtitle)
                    .padding(6)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .frame(width: 220, height: 130)
        .animation(.easeInOut(duration: 0.25), value: isPresented)
        .animation(.easeInOut(duration: 0.25), value: position == .bottomRaised)
    }
}

// MARK: - .appStoreOverlay()

private struct C02_AppStoreOverlayConfigExample: View {
    @State private var showingOverlay = true
    var body: some View {
        VStack(spacing: 10) {
            C02_MockPhone(isPresented: showingOverlay, position: .bottomRaised,
                          title: "Aviary Pro", subtitle: "App 1234567890 · spring-launch")
            Toggle("isPresented", isOn: $showingOverlay)
                .toggleStyle(.switch)
                .controlSize(.small)
                .font(.caption)
            C02_Caption("Illustrative — iOS only. .bottomRaised floats the banner above the tab bar.")
        }
    }
}

private struct C02_AppClipOverlayExample: View {
    @State private var promptForFullApp = true
    var body: some View {
        VStack(spacing: 10) {
            C02_MockPhone(isPresented: promptForFullApp, position: .bottom,
                          title: "Aviary", subtitle: "Get the full app")
            Toggle("isPresented", isOn: $promptForFullApp)
                .toggleStyle(.switch)
                .controlSize(.small)
                .font(.caption)
            C02_Caption("Illustrative — iOS App Clips only. The clip's parent app is promoted automatically.")
        }
    }
}

private struct C02_SKOverlayPositionExample: View {
    @State private var raised = true
    var body: some View {
        VStack(spacing: 10) {
            Picker("position", selection: $raised) {
                Text(".bottom").tag(false)
                Text(".bottomRaised").tag(true)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 220)
            C02_MockPhone(isPresented: true, position: raised ? .bottomRaised : .bottom,
                          title: "Aviary Pro", subtitle: "App 1234567890")
            C02_Caption("Illustrative — iOS only")
        }
    }
}

// MARK: - .chartForegroundStyleScale()

private struct C02_ForegroundScaleMappingExample: View {
    var body: some View {
        Chart(C02_Data.sales) { s in
            BarMark(x: .value("Month", s.month), y: .value("Amount", s.amount))
                .foregroundStyle(by: .value("Kind", s.kind))
        }
        .chartForegroundStyleScale([
            "Revenue": Color.green,
            "Cost": Color.red
        ])
        .frame(height: 150)
    }
}

private struct C02_ForegroundScaleDomainRangeExample: View {
    let regions = ["North", "South", "West"]
    var body: some View {
        Chart(C02_Data.regional) { s in
            BarMark(x: .value("Month", s.month), y: .value("Amount", s.amount))
                .foregroundStyle(by: .value("Region", s.region))
        }
        .chartForegroundStyleScale(
            domain: regions,
            range: [Color.blue, Color.orange, Color.green]
        )
        .frame(height: 150)
    }
}

private struct C02_ForegroundScaleRangeExample: View {
    var body: some View {
        Chart(C02_Data.regional) { s in
            BarMark(x: .value("Month", s.month), y: .value("Amount", s.amount))
                .foregroundStyle(by: .value("Region", s.region))
        }
        .chartForegroundStyleScale(
            range: [Color.mint, Color.indigo, Color.pink]
        )
        .frame(height: 150)
    }
}

// MARK: - .chartLegend()

private struct C02_ChartLegendVisibilityExample: View {
    @State private var showLegend = false
    var body: some View {
        VStack(spacing: 8) {
            Chart(C02_Data.regional) { s in
                BarMark(x: .value("Month", s.month), y: .value("Amount", s.amount))
                    .foregroundStyle(by: .value("Region", s.region))
            }
            .chartLegend(showLegend ? .visible : .hidden)
            .frame(height: 130)
            Toggle(".chartLegend(.visible)", isOn: $showLegend)
                .toggleStyle(.switch)
                .controlSize(.small)
                .font(.caption)
        }
    }
}

private struct C02_ChartLegendPositionExample: View {
    var body: some View {
        Chart(C02_Data.regional) { s in
            BarMark(x: .value("Month", s.month), y: .value("Amount", s.amount))
                .foregroundStyle(by: .value("Region", s.region))
        }
        .chartLegend(position: .trailing,
                     alignment: .top,
                     spacing: 12)
        .frame(height: 150)
    }
}

private struct C02_ChartLegendContentExample: View {
    var body: some View {
        Chart(C02_Data.regional) { s in
            BarMark(x: .value("Month", s.month), y: .value("Amount", s.amount))
                .foregroundStyle(by: .value("Region", s.region))
        }
        .chartForegroundStyleScale(["North": Color.blue, "South": Color.orange, "West": Color.green])
        .chartLegend(position: .bottom, alignment: .leading) {
            HStack {
                Circle().fill(.blue).frame(width: 8)
                Text("North")
                Circle().fill(.orange).frame(width: 8)
                Text("South")
                Circle().fill(.green).frame(width: 8)
                Text("West")
            }.font(.caption)
        }
        .frame(height: 160)
    }
}

// MARK: - .chartXAxis()

private struct C02_ChartXAxisVisibilityExample: View {
    @State private var showAxis = false
    var body: some View {
        VStack(spacing: 8) {
            Chart(C02_Data.steps) { e in
                BarMark(x: .value("Day", e.day), y: .value("Steps", e.steps))
            }
            .chartXAxis(showAxis ? .visible : .hidden)
            .frame(height: 130)
            Toggle(".chartXAxis(.visible)", isOn: $showAxis)
                .toggleStyle(.switch)
                .controlSize(.small)
                .font(.caption)
        }
    }
}

private struct C02_ChartXAxisContentExample: View {
    var body: some View {
        Chart(C02_Data.prices) { p in
            LineMark(x: .value("Date", p.date), y: .value("Close", p.close))
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .day, count: 7)) { _ in
                AxisGridLine()
                AxisValueLabel(format: .dateTime.month().day())
            }
        }
        .frame(height: 150)
    }
}

// MARK: - .chartXScale()

private struct C02_ChartXScaleDomainExample: View {
    @State private var padded = false
    var body: some View {
        let startDate = C02_Data.day(padded ? -7 : 0)
        let endDate = C02_Data.day(padded ? 34 : 27)
        VStack(spacing: 8) {
            Chart(C02_Data.prices) { p in
                LineMark(x: .value("Date", p.date), y: .value("Close", p.close))
            }
            .chartXScale(domain: startDate...endDate)
            .frame(height: 130)
            Toggle("Pin the domain a week wider on each side", isOn: $padded)
                .toggleStyle(.switch)
                .controlSize(.small)
                .font(.caption)
        }
    }
}

private struct C02_ChartXScaleRangeExample: View {
    @State private var padding: CGFloat = 24
    var body: some View {
        VStack(spacing: 8) {
            Chart(C02_Data.steps) { pt in
                PointMark(x: .value("Day", pt.day), y: .value("Steps", pt.steps))
            }
            .chartXScale(range: .plotDimension(padding: padding))
            .frame(height: 120)
            HStack {
                Text("padding: \(Int(padding)) pt").font(.caption).monospacedDigit()
                Slider(value: $padding, in: 0...40)
            }
            .controlSize(.small)
        }
    }
}

private struct C02_ChartXScaleTypeExample: View {
    struct Sample: Identifiable {
        let id = UUID()
        let hz: Double
        let db: Double
    }
    let samples = [
        Sample(hz: 20, db: -3), Sample(hz: 100, db: 0), Sample(hz: 1_000, db: 2),
        Sample(hz: 10_000, db: -1), Sample(hz: 20_000, db: -12),
    ]
    @State private var useLog = true
    var body: some View {
        VStack(spacing: 8) {
            Chart(samples) { s in
                LineMark(x: .value("Frequency", s.hz), y: .value("Gain", s.db))
                PointMark(x: .value("Frequency", s.hz), y: .value("Gain", s.db))
            }
            .chartXScale(type: useLog ? .log : .linear)
            .frame(height: 120)
            Picker("type", selection: $useLog) {
                Text(".linear").tag(false)
                Text(".log").tag(true)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 180)
        }
    }
}

// MARK: - .chartXSelection()

private struct C02_ChartXSelectionValueExample: View {
    @State private var selected: Date?
    var body: some View {
        VStack(spacing: 6) {
            Chart {
                ForEach(C02_Data.prices) { p in
                    LineMark(x: .value("Date", p.date), y: .value("Close", p.close))
                }
                if let selected {
                    RuleMark(x: .value("Selected", selected))
                        .foregroundStyle(.secondary)
                }
            }
            .chartXSelection(value: $selected)
            .frame(height: 130)
            Text(selected.map { "selected = \($0.formatted(.dateTime.month().day()))" } ?? "Drag across the chart — selected = nil")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C02_ChartXSelectionRangeExample: View {
    @State private var window: ClosedRange<Date>?
    var body: some View {
        VStack(spacing: 6) {
            Chart {
                ForEach(C02_Data.prices) { p in
                    LineMark(x: .value("Date", p.date), y: .value("Close", p.close))
                }
                if let window {
                    RectangleMark(xStart: .value("From", window.lowerBound),
                                  xEnd: .value("To", window.upperBound))
                        .foregroundStyle(Color.blue.opacity(0.2))
                }
            }
            .chartXSelection(range: $window)
            .frame(height: 130)
            Text(window.map {
                "window = \($0.lowerBound.formatted(.dateTime.month().day())) … \($0.upperBound.formatted(.dateTime.month().day()))"
            } ?? "Drag out a band — window = nil")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - .chartYAxis()

private struct C02_ChartYAxisVisibilityExample: View {
    @State private var showAxis = false
    var body: some View {
        VStack(spacing: 8) {
            Chart(C02_Data.steps) { e in
                LineMark(x: .value("Day", e.day), y: .value("Steps", e.steps))
            }
            .chartYAxis(showAxis ? .visible : .hidden)
            .frame(height: 130)
            Toggle(".chartYAxis(.visible)", isOn: $showAxis)
                .toggleStyle(.switch)
                .controlSize(.small)
                .font(.caption)
        }
    }
}

private struct C02_ChartYAxisContentExample: View {
    var body: some View {
        Chart(C02_Data.scores) { s in
            LineMark(x: .value("Trial", s.trial), y: .value("Score", s.score))
        }
        .chartYAxis {
            AxisMarks(position: .leading, values: [0, 50, 100]) { _ in
                AxisGridLine()
                AxisValueLabel()
            }
        }
        .frame(height: 150)
    }
}

// MARK: - .chartYScale()

private struct C02_ChartYScaleDomainExample: View {
    var body: some View {
        HStack(spacing: 16) {
            VStack(spacing: 4) {
                Chart(C02_Data.scores) { s in
                    LineMark(x: .value("Trial", s.trial), y: .value("Score", s.score))
                }
                .frame(height: 120)
                C02_Caption("inferred domain")
            }
            VStack(spacing: 4) {
                Chart(C02_Data.scores) { s in
                    LineMark(x: .value("Trial", s.trial), y: .value("Score", s.score))
                }
                .chartYScale(domain: 0...100)
                .frame(height: 120)
                C02_Caption(".chartYScale(domain: 0...100)")
            }
        }
    }
}

private struct C02_AutomaticScaleDomainExample: View {
    struct Entry: Identifiable {
        let id = UUID()
        let day: String
        let delta: Double
    }
    let entries = [
        Entry(day: "Mon", delta: 44), Entry(day: "Tue", delta: 52), Entry(day: "Wed", delta: 47),
        Entry(day: "Thu", delta: 60), Entry(day: "Fri", delta: 55),
    ]
    @State private var includesZero = true
    @State private var reversed = false
    var body: some View {
        VStack(spacing: 8) {
            Chart(entries) { e in
                LineMark(x: .value("Day", e.day), y: .value("Change", e.delta))
                PointMark(x: .value("Day", e.day), y: .value("Change", e.delta))
            }
            .chartYScale(domain: .automatic(includesZero: includesZero, reversed: reversed))
            .frame(height: 120)
            HStack(spacing: 16) {
                Toggle("includesZero", isOn: $includesZero)
                Toggle("reversed", isOn: $reversed)
            }
            .toggleStyle(.switch)
            .controlSize(.small)
            .font(.caption)
        }
    }
}

private struct C02_ChartYScaleTypeExample: View {
    struct Reading: Identifiable {
        let id = UUID()
        let time: Int
        let delta: Double
    }
    let readings = [
        Reading(time: 0, delta: -1_200), Reading(time: 1, delta: -40), Reading(time: 2, delta: 0),
        Reading(time: 3, delta: 6), Reading(time: 4, delta: 350), Reading(time: 5, delta: 9_000),
    ]
    @State private var useSymLog = true
    var body: some View {
        VStack(spacing: 8) {
            Chart(readings) { r in
                LineMark(x: .value("Time", r.time), y: .value("Delta", r.delta))
                PointMark(x: .value("Time", r.time), y: .value("Delta", r.delta))
            }
            .chartYScale(type: useSymLog ? .symmetricLog : .linear)
            .frame(height: 120)
            Picker("type", selection: $useSymLog) {
                Text(".linear").tag(false)
                Text(".symmetricLog").tag(true)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 220)
        }
    }
}

// MARK: - .manageSubscriptionsSheet() (mock — iOS only)

private struct C02_PlanRow: Identifiable {
    let id = UUID()
    let name: String
    let detail: String
    let current: Bool
}

private struct C02_MockSubscriptionSheet: View {
    var title: String
    var rows: [C02_PlanRow]
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(title).font(.caption.bold())
                Spacer()
                Text("Done").font(.caption).foregroundStyle(.blue)
            }
            Divider()
            ForEach(rows) { row in
                HStack {
                    VStack(alignment: .leading, spacing: 1) {
                        Text(row.name).font(.caption)
                        Text(row.detail).font(.caption2).foregroundStyle(.secondary)
                    }
                    Spacer()
                    if row.current {
                        Image(systemName: "checkmark").font(.caption.bold()).foregroundStyle(.blue)
                    }
                }
            }
            Text("Cancel Subscription").font(.caption2).foregroundStyle(.red).padding(.top, 2)
        }
        .padding(10)
        .frame(width: 230)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
    }
}

private struct C02_ManageSubscriptionsGroupExample: View {
    @State private var managing = true
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 12).fill(.quaternary).frame(width: 250, height: 128)
                if managing {
                    C02_MockSubscriptionSheet(title: "Aviary Pro · group 21534970", rows: [
                        C02_PlanRow(name: "Monthly", detail: "$4.99 / month", current: true),
                        C02_PlanRow(name: "Yearly", detail: "$39.99 / year", current: false),
                    ])
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .animation(.easeInOut(duration: 0.25), value: managing)
            Button(managing ? "Dismiss" : "Manage Subscription") { managing.toggle() }
                .controlSize(.small)
            C02_Caption("Illustrative — iOS only. Only plans in subscription group 21534970 are listed.")
        }
    }
}

private struct C02_ManageSubscriptionsAllExample: View {
    @State private var managing = true
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 12).fill(.quaternary).frame(width: 250, height: 128)
                if managing {
                    C02_MockSubscriptionSheet(title: "Subscriptions", rows: [
                        C02_PlanRow(name: "Aviary Pro", detail: "Monthly · $4.99", current: true),
                        C02_PlanRow(name: "Aviary Cloud", detail: "Yearly · $19.99", current: true),
                    ])
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .animation(.easeInOut(duration: 0.25), value: managing)
            Button(managing ? "Dismiss" : "Manage Subscription") { managing.toggle() }
                .controlSize(.small)
            C02_Caption("Illustrative — iOS only. Every subscription the account holds for this app is listed.")
        }
    }
}

// MARK: - Mock map (no tiles are requested)

/// A drawn stand-in for a MapKit basemap.
private struct C02_MockMap: View {
    enum Style { case standard, imagery, hybrid }
    var style: Style = .standard
    var muted = false
    var showsTraffic = false
    var showsLabels = true
    var showsPOI = true

    private var isSatellite: Bool { style != .standard }

    var body: some View {
        Canvas { ctx, size in
            let w = size.width, h = size.height
            let land: Color = isSatellite ? Color(red: 0.27, green: 0.36, blue: 0.22)
                : (muted ? Color(white: 0.9) : Color(red: 0.96, green: 0.95, blue: 0.9))
            ctx.fill(Path(CGRect(origin: .zero, size: size)), with: .color(land))

            var water = Path()
            water.move(to: CGPoint(x: 0, y: h * 0.72))
            water.addQuadCurve(to: CGPoint(x: w, y: h * 0.9), control: CGPoint(x: w * 0.5, y: h * 0.5))
            water.addLine(to: CGPoint(x: w, y: h))
            water.addLine(to: CGPoint(x: 0, y: h))
            water.closeSubpath()
            let waterColor: Color = isSatellite ? Color(red: 0.12, green: 0.27, blue: 0.42)
                : (muted ? Color(white: 0.8) : Color(red: 0.68, green: 0.84, blue: 0.96))
            ctx.fill(water, with: .color(waterColor))

            let park = Path(ellipseIn: CGRect(x: w * 0.62, y: h * 0.1, width: w * 0.26, height: h * 0.32))
            let parkColor: Color = isSatellite ? Color(red: 0.2, green: 0.45, blue: 0.2)
                : (muted ? Color(white: 0.85) : Color(red: 0.78, green: 0.9, blue: 0.74))
            ctx.fill(park, with: .color(parkColor))

            if style != .imagery {
                let road: Color = style == .standard
                    ? (muted ? Color(white: 0.72) : Color.white)
                    : Color.white.opacity(0.8)
                var avenue = Path()
                avenue.move(to: CGPoint(x: 0, y: h * 0.42))
                avenue.addCurve(to: CGPoint(x: w, y: h * 0.52),
                                control1: CGPoint(x: w * 0.35, y: h * 0.25),
                                control2: CGPoint(x: w * 0.65, y: h * 0.72))
                ctx.stroke(avenue, with: .color(road), lineWidth: 6)
                var street = Path()
                street.move(to: CGPoint(x: w * 0.3, y: 0))
                street.addLine(to: CGPoint(x: w * 0.42, y: h))
                ctx.stroke(street, with: .color(road), lineWidth: 3)
                if showsTraffic {
                    ctx.stroke(street, with: .color(.red), style: StrokeStyle(lineWidth: 3, dash: [6, 5]))
                    ctx.stroke(avenue, with: .color(.orange), style: StrokeStyle(lineWidth: 3, dash: [10, 6]))
                }
            }
        }
        .overlay(alignment: .topTrailing) {
            if showsLabels && showsPOI {
                Label("Elm Park", systemImage: "leaf.fill")
                    .font(.system(size: 8))
                    .foregroundStyle(isSatellite ? Color.white : Color(red: 0.2, green: 0.5, blue: 0.2))
                    .padding(6)
            }
        }
        .overlay(alignment: .bottomLeading) {
            if showsLabels {
                Text("Riverside")
                    .font(.system(size: 8))
                    .foregroundStyle(isSatellite ? Color.white : Color.secondary)
                    .padding(6)
            }
        }
        .overlay(alignment: .leading) {
            if showsLabels && showsPOI {
                Label("Cafe", systemImage: "cup.and.saucer.fill")
                    .font(.system(size: 8))
                    .foregroundStyle(isSatellite ? Color.white : Color.orange)
                    .padding(.leading, 8)
                    .offset(y: -16)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

/// The glassy square chrome MapKit gives its controls.
private struct C02_MapControl<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) { self.content = content() }
    var body: some View {
        content
            .font(.system(size: 12, weight: .medium))
            .frame(width: 28, height: 28)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 7))
            .shadow(radius: 1, y: 1)
    }
}

// MARK: - .mapControls()

private struct C02_MapUserLocationButtonExample: View {
    @State private var following = false
    var body: some View {
        VStack(spacing: 8) {
            C02_MockMap()
                .frame(width: 240, height: 110)
                .overlay {
                    if following {
                        Circle()
                            .fill(.blue)
                            .frame(width: 12, height: 12)
                            .overlay(Circle().stroke(.white, lineWidth: 2))
                            .transition(.scale)
                    }
                }
                .overlay(alignment: .topTrailing) {
                    Button {
                        withAnimation(.easeInOut) { following.toggle() }
                    } label: {
                        C02_MapControl {
                            Image(systemName: following ? "location.fill" : "location")
                                .foregroundStyle(.blue)
                        }
                    }
                    .buttonStyle(.plain)
                    .padding(6)
                }
            C02_Caption(following
                ? "Illustrative — the camera now follows the user's location"
                : "Illustrative — MapKit control; tiles and location arrive at runtime")
        }
    }
}

private struct C02_MapCompassExample: View {
    @State private var heading: Double = 35
    var body: some View {
        VStack(spacing: 8) {
            C02_MockMap(showsLabels: false)
                .frame(width: 320, height: 200)
                .rotationEffect(.degrees(-heading))
                .frame(width: 240, height: 110)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(alignment: .topTrailing) {
                    if heading != 0 {
                        Button {
                            withAnimation(.easeInOut) { heading = 0 }
                        } label: {
                            C02_MapControl {
                                Image(systemName: "location.north.fill")
                                    .foregroundStyle(.red)
                                    .rotationEffect(.degrees(-heading))
                            }
                        }
                        .buttonStyle(.plain)
                        .padding(6)
                    }
                }
            HStack {
                Text("heading \(Int(heading))°").font(.caption).monospacedDigit()
                Slider(value: $heading, in: 0...90)
            }
            .controlSize(.small)
            C02_Caption("Illustrative — the compass shows only while the heading is off north; tap it to reset")
        }
    }
}

private struct C02_MapScaleViewExample: View {
    @State private var meters: Double = 200
    var body: some View {
        VStack(spacing: 8) {
            C02_MockMap()
                .frame(width: 240, height: 110)
                .overlay(alignment: .topLeading) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("\(Int(meters)) m").font(.system(size: 9)).monospacedDigit()
                        Rectangle()
                            .fill(.primary)
                            .frame(width: 20 + meters / 5, height: 1.5)
                            .overlay(alignment: .leading) { Rectangle().frame(width: 1.5, height: 6) }
                            .overlay(alignment: .trailing) { Rectangle().frame(width: 1.5, height: 6) }
                    }
                    .padding(6)
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 6))
                    .padding(6)
                }
            HStack {
                Text("zoom").font(.caption)
                Slider(value: $meters, in: 50...500)
            }
            .controlSize(.small)
            C02_Caption("Illustrative — the scale legend tracks the camera distance")
        }
    }
}

private struct C02_MapPitchToggleExample: View {
    @State private var pitched = false
    var body: some View {
        VStack(spacing: 8) {
            C02_MockMap()
                .frame(width: 240, height: 110)
                .rotation3DEffect(.degrees(pitched ? 45 : 0), axis: (x: 1, y: 0, z: 0), perspective: 0.6)
                .overlay(alignment: .topTrailing) {
                    Button {
                        withAnimation(.easeInOut(duration: 0.4)) { pitched.toggle() }
                    } label: {
                        C02_MapControl { Text(pitched ? "2D" : "3D").font(.system(size: 11, weight: .semibold)) }
                    }
                    .buttonStyle(.plain)
                    .padding(6)
                }
                .frame(height: 120)
            C02_Caption("Illustrative — flips between an overhead camera and a tilted perspective")
        }
    }
}

// MARK: - .mapStyle()

private struct C02_MapStyleStandardExample: View {
    var body: some View {
        VStack(spacing: 8) {
            C02_MockMap(style: .standard, muted: true, showsTraffic: true, showsPOI: false)
                .frame(width: 240, height: 110)
                .overlay {
                    Path { p in
                        p.move(to: CGPoint(x: 20, y: 95))
                        p.addCurve(to: CGPoint(x: 215, y: 18),
                                   control1: CGPoint(x: 90, y: 100),
                                   control2: CGPoint(x: 140, y: 10))
                    }
                    .stroke(.blue, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                }
            C02_Caption("Illustrative — muted basemap, no POI labels, traffic on, route overlay on top")
        }
    }
}

private struct C02_MapStyleImageryExample: View {
    @State private var realistic = true
    var body: some View {
        VStack(spacing: 8) {
            C02_MockMap(style: .imagery, showsLabels: false)
                .frame(width: 240, height: 110)
                .rotation3DEffect(.degrees(realistic ? 30 : 0), axis: (x: 1, y: 0, z: 0), perspective: 0.6)
                .frame(height: 114)
            Picker("elevation", selection: $realistic) {
                Text(".flat").tag(false)
                Text(".realistic").tag(true)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 180)
            C02_Caption("Illustrative — satellite imagery only; labels and roads are not drawn")
        }
    }
}

private struct C02_MapStyleHybridExample: View {
    var body: some View {
        VStack(spacing: 8) {
            C02_MockMap(style: .hybrid, showsLabels: true, showsPOI: true)
                .frame(width: 240, height: 110)
            C02_Caption("Illustrative — imagery plus roads and labels; POIs limited to cafés and parks")
        }
    }
}

private struct C02_PointOfInterestCategoriesExample: View {
    enum Filter: String, CaseIterable, Identifiable {
        case includingAll = ".includingAll"
        case excludingAll = ".excludingAll"
        case onlyFood = ".including([.restaurant, .cafe, .bakery])"
        case noSchools = ".excluding([.school, .university])"
        var id: String { rawValue }
    }
    struct POI: Identifiable {
        let id = UUID()
        let name: String
        let symbol: String
        let kind: String
        let x: CGFloat
        let y: CGFloat
    }
    let pois = [
        POI(name: "Cafe", symbol: "cup.and.saucer.fill", kind: "cafe", x: 0.18, y: 0.28),
        POI(name: "Bakery", symbol: "birthday.cake.fill", kind: "bakery", x: 0.55, y: 0.25),
        POI(name: "School", symbol: "graduationcap.fill", kind: "school", x: 0.22, y: 0.62),
        POI(name: "Museum", symbol: "building.columns.fill", kind: "museum", x: 0.75, y: 0.62),
    ]
    @State private var filter: Filter = .onlyFood

    func isVisible(_ p: POI) -> Bool {
        switch filter {
        case .includingAll: return true
        case .excludingAll: return false
        case .onlyFood: return ["restaurant", "cafe", "bakery"].contains(p.kind)
        case .noSchools: return !["school", "university"].contains(p.kind)
        }
    }

    var body: some View {
        VStack(spacing: 8) {
            C02_MockMap(showsPOI: false)
                .frame(width: 240, height: 110)
                .overlay {
                    GeometryReader { geo in
                        ForEach(pois) { p in
                            if isVisible(p) {
                                Label(p.name, systemImage: p.symbol)
                                    .font(.system(size: 8))
                                    .position(x: geo.size.width * p.x, y: geo.size.height * p.y)
                            }
                        }
                    }
                }
            Picker("pointsOfInterest", selection: $filter) {
                ForEach(Filter.allCases) { Text($0.rawValue).tag($0) }
            }
            .labelsHidden()
            .controlSize(.small)
            .frame(width: 240)
            C02_Caption("Illustrative — filters which point-of-interest labels the basemap draws")
        }
    }
}

// MARK: - .onDrag()

private struct C02_OnDragPreviewExample: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("Quarterly Report.pdf")
                .padding(8)
                .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
                .onDrag {
                    NSItemProvider(object: "Quarterly Report.pdf" as NSString)
                } preview: {
                    Label("Quarterly Report", systemImage: "doc.richtext")
                        .padding(8)
                        .background(.blue.opacity(0.2), in: Capsule())
                }
            C02_Caption("Drag the row — the lifted image is the Label, not a snapshot of the row")
        }
    }
}

private struct C02_OnDragBasicExample: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "doc")
                .font(.system(size: 28))
                .padding(10)
                .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
                .onDrag {
                    NSItemProvider(object: "Quarterly Report.pdf" as NSString)
                }
            C02_Caption("Drag the icon — the lifted image is a snapshot of the source view")
        }
    }
}

// MARK: - .onDrop()

private struct C02_ReorderDelegate: DropDelegate {
    let target: String
    @Binding var items: [String]
    @Binding var dragging: String?

    func dropEntered(info: DropInfo) {
        guard let dragging, dragging != target,
              let from = items.firstIndex(of: dragging),
              let to = items.firstIndex(of: target) else { return }
        items.move(fromOffsets: IndexSet(integer: from), toOffset: to > from ? to + 1 : to)
    }
    func dropUpdated(info: DropInfo) -> DropProposal? { DropProposal(operation: .move) }
    func performDrop(info: DropInfo) -> Bool {
        dragging = nil
        return true
    }
}

private struct C02_OnDropDelegateExample: View {
    @State private var items = ["Inbox", "Drafts", "Sent", "Archive"]
    @State private var dragging: String?
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 6) {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(dragging == item ? Color.accentColor.opacity(0.3) : Color.secondary.opacity(0.15), in: Capsule())
                        .onDrag {
                            dragging = item
                            return NSItemProvider(object: item as NSString)
                        }
                        .onDrop(of: [.text],
                                delegate: C02_ReorderDelegate(target: item, items: $items, dragging: $dragging))
                }
            }
            .animation(.default, value: items)
            C02_Caption("Drag a chip over another — dropEntered moves it, dropUpdated proposes .move")
        }
    }
}

private struct C02_OnDropTargetedExample: View {
    @State private var isTargeted = false
    @State private var dropped = 0
    var body: some View {
        HStack(spacing: 16) {
            Text("Photo")
                .font(.caption)
                .padding(8)
                .background(.orange.opacity(0.3), in: Capsule())
                .onDrag { NSItemProvider(object: "Photo" as NSString) }
            RoundedRectangle(cornerRadius: 10)
                .fill(isTargeted ? Color.blue.opacity(0.3) : Color.gray.opacity(0.15))
                .frame(width: 150, height: 80)
                .overlay {
                    Text(dropped == 0 ? "Drop here" : "\(dropped) dropped")
                        .font(.caption)
                }
                .onDrop(of: [.text], isTargeted: $isTargeted) { providers in
                    dropped += providers.count
                    return true
                }
        }
    }
}

private struct C02_OnDropLocationExample: View {
    @State private var pins: [CGPoint] = []
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "mappin.circle.fill")
                .font(.title2)
                .foregroundStyle(.red)
                .onDrag { NSItemProvider(object: "pin" as NSString) }
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.15))
                ForEach(pins.indices, id: \.self) { i in
                    Image(systemName: "mappin")
                        .foregroundStyle(.red)
                        .position(pins[i])
                }
                if pins.isEmpty {
                    Text("Drop the pin anywhere")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(8)
                }
            }
            .frame(width: 180, height: 100)
            .onDrop(of: [.text], isTargeted: nil) { providers, location in
                pins.append(location)
                return true
            }
        }
    }
}

private struct C02_StatusDropDelegate: DropDelegate {
    @Binding var status: String
    func validateDrop(info: DropInfo) -> Bool { info.hasItemsConforming(to: [.text]) }
    func dropEntered(info: DropInfo) { status = "dropEntered" }
    func dropUpdated(info: DropInfo) -> DropProposal? {
        status = "dropUpdated at \(Int(info.location.x)), \(Int(info.location.y))"
        return DropProposal(operation: .copy)
    }
    func dropExited(info: DropInfo) { status = "dropExited" }
    func performDrop(info: DropInfo) -> Bool {
        status = "performDrop → true"
        return true
    }
}

private struct C02_DropDelegateExample: View {
    @State private var status = "waiting for a drag"
    var body: some View {
        HStack(spacing: 16) {
            Text("Note")
                .font(.caption)
                .padding(8)
                .background(.yellow.opacity(0.4), in: Capsule())
                .onDrag { NSItemProvider(object: "Note" as NSString) }
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.15))
                .frame(width: 170, height: 80)
                .overlay {
                    Text(status)
                        .font(.caption)
                        .monospacedDigit()
                        .multilineTextAlignment(.center)
                }
                .onDrop(of: [.text], delegate: C02_StatusDropDelegate(status: $status))
        }
    }
}

// MARK: - .onMapCameraChange() (mock — a real Map reports these values)

private enum C02_MockCamera {
    static func describe(_ pan: CGSize) -> String {
        let lat = 37.3349 - Double(pan.height) * 0.0004
        let lon = -122.0090 + Double(pan.width) * 0.0004
        return String(format: "%.4f, %.4f", lat, lon)
    }
}

/// A mock map you can drag; reports the pan like a camera change would.
private struct C02_PannableMockMap: View {
    @Binding var pan: CGSize
    var onChange: (_ pan: CGSize, _ ended: Bool) -> Void
    @State private var drag: CGSize = .zero

    var body: some View {
        C02_MockMap(showsLabels: false)
            .frame(width: 480, height: 260)
            .offset(x: pan.width + drag.width, y: pan.height + drag.height)
            .frame(width: 240, height: 110)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .contentShape(Rectangle())
            .gesture(
                DragGesture()
                    .onChanged { value in
                        drag = value.translation
                        onChange(CGSize(width: pan.width + drag.width, height: pan.height + drag.height), false)
                    }
                    .onEnded { value in
                        pan.width += value.translation.width
                        pan.height += value.translation.height
                        drag = .zero
                        onChange(pan, true)
                    }
            )
    }
}

private struct C02_OnMapCameraChangeExample: View {
    @State private var pan: CGSize = .zero
    @State private var center = C02_MockCamera.describe(.zero)
    @State private var callbacks = 0
    var body: some View {
        VStack(spacing: 6) {
            C02_PannableMockMap(pan: $pan) { total, _ in
                center = C02_MockCamera.describe(total)
                callbacks += 1
            }
            Text("centerCoordinate ≈ \(center)   ·   \(callbacks) callbacks")
                .font(.caption)
                .monospacedDigit()
            C02_Caption("Illustrative — drag the mock map; .continuous fires on every camera update")
        }
    }
}

private struct C02_MapCameraUpdateContextExample: View {
    @State private var pan: CGSize = .zero
    @State private var settled: CGSize = .zero
    var body: some View {
        VStack(spacing: 6) {
            C02_PannableMockMap(pan: $pan) { total, ended in
                if ended { settled = total }
            }
            VStack(alignment: .leading, spacing: 2) {
                Text("context.camera.centerCoordinate  \(C02_MockCamera.describe(settled))")
                Text("context.region.span              0.0120 × 0.0210")
                Text("context.rect.origin              \(Int(43_000_000 + settled.width * 40)), \(Int(104_000_000 + settled.height * 40))")
            }
            .font(.system(.caption2, design: .monospaced))
            .foregroundStyle(.secondary)
            C02_Caption("Illustrative — the context bundles camera, region, and rect; updated on gesture end")
        }
    }
}

private struct C02_MapCameraUpdateFrequencyExample: View {
    enum Frequency: String, CaseIterable, Identifiable {
        case continuous = ".continuous"
        case onEnd = ".onEnd"
        var id: String { rawValue }
    }
    @State private var frequency: Frequency = .onEnd
    @State private var pan: CGSize = .zero
    @State private var reported = C02_MockCamera.describe(.zero)
    @State private var callbacks = 0
    var body: some View {
        VStack(spacing: 6) {
            C02_PannableMockMap(pan: $pan) { total, ended in
                guard frequency == .continuous || ended else { return }
                reported = C02_MockCamera.describe(total)
                callbacks += 1
            }
            Picker("frequency", selection: $frequency) {
                ForEach(Frequency.allCases) { Text($0.rawValue).tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 200)
            Text("region.center ≈ \(reported)   ·   \(callbacks) callbacks")
                .font(.caption)
                .monospacedDigit()
            C02_Caption("Illustrative — drag the mock map and compare how often the handler runs")
        }
    }
}

// MARK: - .photosPicker() (the real picker; picked items resolve at runtime)

/// Thumbnail slots that fill in as items are picked.
private struct C02_PickedThumbnails: View {
    var count: Int
    var capacity: Int
    var numbered = false
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<capacity, id: \.self) { i in
                RoundedRectangle(cornerRadius: 8)
                    .fill(i < count ? AnyShapeStyle(Color.teal.gradient) : AnyShapeStyle(Color.clear))
                    .frame(width: 44, height: 44)
                    .overlay {
                        if i < count {
                            Image(systemName: "photo.fill").foregroundStyle(.white)
                        } else {
                            RoundedRectangle(cornerRadius: 8)
                                .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [4, 3]))
                                .foregroundStyle(.tertiary)
                        }
                    }
                    .overlay(alignment: .topTrailing) {
                        if numbered && i < count {
                            Text("\(i + 1)")
                                .font(.system(size: 9, weight: .bold))
                                .foregroundStyle(.white)
                                .frame(width: 16, height: 16)
                                .background(Color.blue, in: Circle())
                                .offset(x: 4, y: -4)
                        }
                    }
            }
        }
    }
}

private struct C02_PhotosPickerMaxCountExample: View {
    @State private var picking = false
    @State private var items: [PhotosPickerItem] = []
    var body: some View {
        VStack(spacing: 8) {
            C02_PickedThumbnails(count: items.count, capacity: 4)
            Button("Choose up to 4 Photos…") { picking = true }
                .controlSize(.small)
                .photosPicker(isPresented: $picking,
                              selection: $items,
                              maxSelectionCount: 4,
                              matching: .any(of: [.images, .screenshots]))
            C02_Caption("\(items.count) of 4 selected — the picker stops accepting picks at maxSelectionCount")
        }
    }
}

private struct C02_PhotosPickerSingleExample: View {
    @State private var showingPicker = false
    @State private var selection: PhotosPickerItem?
    var body: some View {
        VStack(spacing: 8) {
            C02_PickedThumbnails(count: selection == nil ? 0 : 1, capacity: 1)
            Button("Choose a Photo…") { showingPicker = true }
                .controlSize(.small)
                .photosPicker(isPresented: $showingPicker,
                              selection: $selection,
                              matching: .images,
                              preferredItemEncoding: .current)
            C02_Caption(selection == nil
                ? "selection = nil — one optional item, delivered in its stored encoding (.current)"
                : "selection = PhotosPickerItem — picking again replaces it")
        }
    }
}

private struct C02_PhotosPickerOrderedExample: View {
    @State private var picking = false
    @State private var items: [PhotosPickerItem] = []
    var body: some View {
        VStack(spacing: 8) {
            C02_PickedThumbnails(count: items.count, capacity: 4, numbered: true)
            Button("Choose Photos…") { picking = true }
                .controlSize(.small)
                .photosPicker(isPresented: $picking,
                              selection: $items,
                              maxSelectionCount: 4,
                              selectionBehavior: .ordered,
                              matching: .any(of: [.images, .screenshots]),
                              preferredItemEncoding: .automatic)
            C02_Caption("\(items.count) picked — .ordered numbers each pick and the array keeps that order")
        }
    }
}

private struct C02_PHPickerFilterAnyExample: View {
    @State private var picking = false
    @State private var items: [PhotosPickerItem] = []
    @State private var useStills = true
    let stills: PHPickerFilter = .any(of: [.images, .screenshots])
    let noLive: PHPickerFilter = .all(of: [.images, .not(.livePhotos)])
    var body: some View {
        VStack(spacing: 8) {
            Picker("matching", selection: $useStills) {
                Text(".any(of: [.images, .screenshots])").tag(true)
                Text(".all(of: [.images, .not(.livePhotos)])").tag(false)
            }
            .pickerStyle(.radioGroup)
            .labelsHidden()
            .font(.system(.caption, design: .monospaced))
            Button("Choose Photos…") { picking = true }
                .controlSize(.small)
                .photosPicker(isPresented: $picking, selection: $items, matching: useStills ? stills : noLive)
            C02_Caption("\(items.count) selected — the picker only offers assets matching the composed filter")
        }
    }
}

// MARK: - .productViewStyle() (mock — ProductView loads App Store data at runtime)

private struct C02_MockProductCard: View {
    enum Style { case compact, regular, large }
    var style: Style
    var name = "Aviary Pro"
    var detail = "Unlock every example and offline docs."
    var price = "$9.99"

    private var icon: some View {
        RoundedRectangle(cornerRadius: style == .large ? 14 : 8)
            .fill(Color.indigo.gradient)
            .overlay {
                Image(systemName: "bird.fill")
                    .font(style == .large ? .title : .body)
                    .foregroundStyle(.white)
            }
    }
    private func buyButton(wide: Bool) -> some View {
        Text(wide ? "Buy for \(price)" : price)
            .font(.caption.bold())
            .padding(.horizontal, 12)
            .padding(.vertical, 5)
            .frame(maxWidth: wide ? .infinity : nil)
            .background(Color.blue, in: Capsule())
            .foregroundStyle(.white)
    }

    var body: some View {
        Group {
            switch style {
            case .compact:
                HStack(spacing: 10) {
                    icon.frame(width: 26, height: 26)
                    Text(name).font(.caption)
                    Spacer()
                    buyButton(wide: false)
                }
            case .regular:
                HStack(alignment: .top, spacing: 10) {
                    icon.frame(width: 44, height: 44)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(name).font(.caption.bold())
                        Text(detail).font(.caption2).foregroundStyle(.secondary)
                    }
                    Spacer()
                    buyButton(wide: false)
                }
            case .large:
                VStack(spacing: 6) {
                    icon.frame(width: 60, height: 60)
                    Text(name).font(.headline)
                    Text(detail).font(.caption2).foregroundStyle(.secondary).multilineTextAlignment(.center)
                    buyButton(wide: true).padding(.top, 2)
                }
            }
        }
        .padding(10)
        .frame(width: 240)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
    }
}

private struct C02_ProductViewCompactExample: View {
    var body: some View {
        VStack(spacing: 6) {
            C02_MockProductCard(style: .compact, name: "Small Tip", price: "$0.99")
            C02_MockProductCard(style: .compact, name: "Large Tip", price: "$4.99")
            C02_Caption("Illustrative — StoreView rows load from App Store Connect at runtime; .compact keeps each to one line")
        }
    }
}

private struct C02_ProductViewRegularExample: View {
    var body: some View {
        VStack(spacing: 6) {
            C02_MockProductCard(style: .regular)
            C02_Caption("Illustrative — product metadata loads at runtime; .regular is the default layout")
        }
    }
}

private struct C02_ProductViewLargeExample: View {
    var body: some View {
        VStack(spacing: 6) {
            C02_MockProductCard(style: .large, name: "Aviary Pro · Lifetime",
                                detail: "One purchase, every future update.", price: "$29.99")
            C02_Caption("Illustrative — .large gives the artwork and description a hero-sized card")
        }
    }
}

// MARK: - .quickLookPreview() (mock — Quick Look renders the real file at runtime)

private struct C02_MockQuickLookPanel: View {
    var title: String
    var symbol: String
    var index: Int? = nil
    var count: Int? = nil
    var onPrevious: () -> Void = {}
    var onNext: () -> Void = {}
    var onClose: () -> Void = {}
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 8) {
                Button(action: onClose) {
                    Circle().fill(.red).frame(width: 9, height: 9)
                }
                if let index, let count {
                    Button(action: onPrevious) { Image(systemName: "chevron.left") }
                        .disabled(index == 0)
                    Button(action: onNext) { Image(systemName: "chevron.right") }
                        .disabled(index == count - 1)
                }
                Spacer()
                Text(title).font(.caption2)
                Spacer()
                Image(systemName: "square.and.arrow.up")
            }
            .font(.caption2)
            .buttonStyle(.plain)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background(.bar)
            Rectangle()
                .fill(Color.white.opacity(0.9))
                .overlay {
                    Image(systemName: symbol)
                        .font(.system(size: 30))
                        .foregroundStyle(.secondary)
                }
        }
        .frame(width: 230, height: 104)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(radius: 6, y: 3)
    }
}

private struct C02_QuickLookCollectionExample: View {
    struct Attachment { let name: String; let symbol: String }
    let attachments: [URL] = ["Invoice.pdf", "Contract.pages", "Site Photo.heic"]
        .map { URL(fileURLWithPath: "/Users/me/Documents/\($0)") }
    let symbols = ["doc.richtext", "doc.text", "photo"]
    @State private var selected: URL?

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(.quaternary).frame(width: 250, height: 118)
                if let selected, let i = attachments.firstIndex(of: selected) {
                    C02_MockQuickLookPanel(title: "\(selected.lastPathComponent)  (\(i + 1) of \(attachments.count))",
                                           symbol: symbols[i], index: i, count: attachments.count,
                                           onPrevious: { self.selected = attachments[i - 1] },
                                           onNext: { self.selected = attachments[i + 1] },
                                           onClose: { self.selected = nil })
                    .transition(.scale.combined(with: .opacity))
                } else {
                    Button("Preview All") { selected = attachments.first }
                        .controlSize(.small)
                }
            }
            .animation(.easeInOut(duration: 0.2), value: selected)
            C02_Caption(selected.map { "selected = \($0.lastPathComponent) — arrows move through `in: attachments`" }
                ?? "Illustrative — selected = nil; Quick Look shows the real files at runtime")
        }
    }
}

private struct C02_QuickLookSingleExample: View {
    let attachment = URL(fileURLWithPath: "/Users/me/Documents/Invoice.pdf")
    @State private var previewURL: URL?
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(.quaternary).frame(width: 250, height: 118)
                if let previewURL {
                    C02_MockQuickLookPanel(title: previewURL.lastPathComponent, symbol: "doc.richtext",
                                           onClose: { self.previewURL = nil })
                    .transition(.scale.combined(with: .opacity))
                } else {
                    Button("Preview") { previewURL = attachment }
                        .controlSize(.small)
                }
            }
            .animation(.easeInOut(duration: 0.2), value: previewURL)
            C02_Caption(previewURL == nil
                ? "Illustrative — previewURL = nil; Quick Look renders the real file at runtime"
                : "previewURL = Invoice.pdf — closing the panel sets it back to nil")
        }
    }
}

// MARK: - .storeButton()

/// A mock StoreKit merchandising sheet; the real views need App Store products.
private struct C02_MockStoreSheet<Footer: View>: View {
    var title = "Aviary Pro"
    var showsClose = true
    @ViewBuilder var footer: Footer

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Spacer()
                if showsClose {
                    Image(systemName: "xmark.circle.fill").foregroundStyle(.secondary)
                }
            }
            .frame(height: 14)
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.indigo.gradient)
                .frame(width: 40, height: 40)
                .overlay(Image(systemName: "bird.fill").foregroundStyle(.white))
            Text(title).font(.caption.bold())
            Text("Every example, offline.").font(.caption2).foregroundStyle(.secondary)
            Text("Subscribe · $4.99 / month")
                .font(.caption.bold())
                .foregroundStyle(.white)
                .padding(.vertical, 5)
                .frame(maxWidth: .infinity)
                .background(.blue, in: Capsule())
            footer
        }
        .padding(10)
        .frame(width: 210)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
    }
}

private struct C02_StoreButtonRestoreExample: View {
    @State private var visible = true
    var body: some View {
        VStack(spacing: 8) {
            C02_MockStoreSheet(title: "Aviary Pro", showsClose: false) {
                if visible {
                    Text("Restore Purchases")
                        .font(.caption2)
                        .foregroundStyle(.blue)
                        .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 0.2), value: visible)
            Toggle("Restore button visible", isOn: $visible)
                .controlSize(.small)
            C02_Caption("Illustrative — StoreView needs App Store products. The restore button is hidden unless you opt in.")
        }
    }
}

private struct C02_StoreButtonRedeemExample: View {
    @State private var visible = true
    var body: some View {
        VStack(spacing: 8) {
            C02_MockStoreSheet {
                if visible {
                    Text("Redeem Code")
                        .font(.caption2)
                        .foregroundStyle(.blue)
                        .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 0.2), value: visible)
            Toggle("Redeem button visible", isOn: $visible)
                .controlSize(.small)
            C02_Caption("Illustrative — tapping the real button opens the App Store's offer-code sheet.")
        }
    }
}

private struct C02_StoreButtonPoliciesExample: View {
    @State private var visible = true
    var body: some View {
        VStack(spacing: 8) {
            C02_MockStoreSheet {
                if visible {
                    HStack(spacing: 4) {
                        Text("Privacy Policy").foregroundStyle(.blue)
                        Text("·").foregroundStyle(.secondary)
                        Text("Terms of Service").foregroundStyle(.blue)
                    }
                    .font(.caption2)
                    .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 0.2), value: visible)
            Toggle("Policy links visible", isOn: $visible)
                .controlSize(.small)
            C02_Caption("Illustrative — .subscriptionStorePolicyDestination decides where each link goes.")
        }
    }
}

private struct C02_StoreButtonCancellationExample: View {
    @State private var pushed = true
    var body: some View {
        VStack(spacing: 8) {
            VStack(spacing: 4) {
                if pushed {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                        Spacer()
                        Text("Upgrade").bold()
                        Spacer()
                    }
                    .font(.caption2)
                    .foregroundStyle(.blue)
                    .frame(width: 210)
                }
                C02_MockStoreSheet(showsClose: !pushed) { EmptyView() }
            }
            .animation(.easeInOut(duration: 0.2), value: pushed)
            Toggle("Presented by NavigationLink", isOn: $pushed)
                .controlSize(.small)
            C02_Caption(pushed
                ? "Illustrative — the pushed screen already has Back, so the close (cancellation) button is hidden"
                : "Illustrative — presented as a sheet, the close button is the only way out")
        }
    }
}

// MARK: - .subscriptionStoreControlStyle()

private struct C02_MockPlanList: View {
    enum Style { case picker, prominentPicker, buttons }
    var style: Style
    @Binding var selected: Int
    private let plans = [("Monthly", "$4.99 / month"), ("Yearly", "$39.99 / year · save 33%")]

    var body: some View {
        VStack(spacing: 6) {
            ForEach(plans.indices, id: \.self) { i in
                let isSelected = i == selected
                if style == .buttons {
                    VStack(spacing: 1) {
                        Text(plans[i].0).font(.caption.bold())
                        Text(plans[i].1).font(.caption2)
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 5)
                    .background(.blue, in: RoundedRectangle(cornerRadius: 8))
                } else {
                    HStack {
                        Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(isSelected
                                ? (style == .prominentPicker ? Color.white : Color.blue)
                                : Color.secondary)
                        VStack(alignment: .leading, spacing: 1) {
                            Text(plans[i].0).font(.caption.bold())
                            Text(plans[i].1).font(.caption2)
                        }
                        Spacer()
                    }
                    .foregroundStyle(style == .prominentPicker && isSelected ? Color.white : Color.primary)
                    .padding(6)
                    .background(
                        style == .prominentPicker && isSelected ? AnyShapeStyle(.blue) : AnyShapeStyle(.quaternary),
                        in: RoundedRectangle(cornerRadius: 8)
                    )
                    .overlay {
                        if style == .picker && isSelected {
                            RoundedRectangle(cornerRadius: 8).stroke(.blue, lineWidth: 1.5)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture { selected = i }
                }
            }
            if style != .buttons {
                Text("Subscribe")
                    .font(.caption.bold())
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 5)
                    .background(.blue, in: Capsule())
            }
        }
        .padding(10)
        .frame(width: 220)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
        .animation(.easeInOut(duration: 0.15), value: selected)
    }
}

private struct C02_SubscriptionControlPickerExample: View {
    @State private var selected = 0
    var body: some View {
        VStack(spacing: 8) {
            C02_MockPlanList(style: .picker, selected: $selected)
            C02_Caption("Illustrative — .picker: selectable rows plus one shared Subscribe button.")
        }
    }
}

private struct C02_SubscriptionControlProminentExample: View {
    @State private var selected = 1
    var body: some View {
        VStack(spacing: 8) {
            C02_MockPlanList(style: .prominentPicker, selected: $selected)
            C02_Caption("Illustrative — .prominentPicker fills the selected plan with the tint.")
        }
    }
}

private struct C02_SubscriptionControlButtonsExample: View {
    @State private var selected = 0
    var body: some View {
        VStack(spacing: 8) {
            C02_MockPlanList(style: .buttons, selected: $selected)
            C02_Caption("Illustrative — .buttons: one purchase button per plan; .multiline puts the price on its own line.")
        }
    }
}

// MARK: - Annotation

private struct C02_AnnotationAnchorExample: View {
    @State private var anchor: UnitPoint = .bottom
    private let coordinate = CGPoint(x: 120, y: 62)
    private let glyphSize: CGFloat = 26

    var body: some View {
        VStack(spacing: 8) {
            C02_MockMap()
                .frame(width: 240, height: 120)
                .overlay {
                    Circle()
                        .fill(.red)
                        .frame(width: 6, height: 6)
                        .position(coordinate)
                    Image(systemName: "cup.and.saucer.fill")
                        .font(.system(size: 11))
                        .foregroundStyle(.white)
                        .frame(width: glyphSize, height: glyphSize)
                        .background(.orange, in: Circle())
                        .position(
                            x: coordinate.x + (0.5 - anchor.x) * glyphSize,
                            y: coordinate.y + (0.5 - anchor.y) * glyphSize
                        )
                        .animation(.easeInOut(duration: 0.2), value: anchor)
                }
            Picker("Anchor", selection: $anchor) {
                Text("bottom").tag(UnitPoint.bottom)
                Text("center").tag(UnitPoint.center)
                Text("top").tag(UnitPoint.top)
                Text("leading").tag(UnitPoint.leading)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 240)
            C02_Caption("Illustrative — the red dot is the coordinate; the anchor picks which point of the glyph sits on it.")
        }
    }
}

private struct C02_AnnotationLabelExample: View {
    var body: some View {
        VStack(spacing: 8) {
            C02_MockMap()
                .frame(width: 240, height: 120)
                .overlay {
                    VStack(spacing: 2) {
                        Circle()
                            .fill(.blue)
                            .frame(width: 12, height: 12)
                            .overlay(Circle().stroke(.white, lineWidth: 2))
                        Text("Aviary HQ")
                            .font(.caption.bold())
                            .foregroundStyle(.blue)
                            .padding(.horizontal, 4)
                            .background(.white.opacity(0.8), in: Capsule())
                    }
                    .position(x: 110, y: 58)
                }
            C02_Caption("Illustrative — the label is a view, so it can be styled like any other SwiftUI text.")
        }
    }
}

private struct C02_AnnotationTitlesExample: View {
    @State private var titles: Visibility = .visible
    private let stops: [(name: String, point: CGPoint)] = [
        ("Market St", CGPoint(x: 50, y: 40)),
        ("Elm Park", CGPoint(x: 150, y: 30)),
        ("Riverside", CGPoint(x: 110, y: 90)),
    ]

    var body: some View {
        VStack(spacing: 8) {
            C02_MockMap(showsLabels: false)
                .frame(width: 240, height: 120)
                .overlay {
                    ForEach(stops.indices, id: \.self) { i in
                        VStack(spacing: 2) {
                            Image(systemName: "tram.fill")
                                .font(.system(size: 10))
                                .foregroundStyle(.white)
                                .padding(5)
                                .background(.green, in: Circle())
                            if titles != .hidden {
                                Text(stops[i].name)
                                    .font(.system(size: 9, weight: .medium))
                                    .padding(.horizontal, 3)
                                    .background(.white.opacity(0.8), in: Capsule())
                                    .transition(.opacity)
                            }
                        }
                        .position(stops[i].point)
                    }
                }
                .animation(.easeInOut(duration: 0.2), value: titles)
            Picker("Titles", selection: $titles) {
                Text("automatic").tag(Visibility.automatic)
                Text("visible").tag(Visibility.visible)
                Text("hidden").tag(Visibility.hidden)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 240)
            C02_Caption("Illustrative — .hidden keeps the glyphs and drops the captions; .automatic lets MapKit decide by zoom.")
        }
    }
}

// MARK: - AreaMark

private struct C02_AreaMarkStackingExample: View {
    struct Traffic: Identifiable {
        let id = UUID()
        let hour: Int
        let count: Double
        let source: String
    }
    let traffic: [Traffic] = (0..<8).flatMap { (h: Int) -> [Traffic] in
        [Traffic(hour: h, count: 20 + 12 * sin(Double(h) / 2), source: "Web"),
         Traffic(hour: h, count: 10 + Double(h) * 2, source: "API"),
         Traffic(hour: h, count: 8 + 6 * cos(Double(h) / 2), source: "Mobile")]
    }
    @State private var normalized = true
    var body: some View {
        VStack(spacing: 8) {
            Chart(traffic) { t in
                AreaMark(x: .value("Hour", t.hour),
                         y: .value("Requests", t.count),
                         stacking: normalized ? .normalized : .standard)
                .foregroundStyle(by: .value("Source", t.source))
            }
            .frame(height: 130)
            Picker("stacking", selection: $normalized) {
                Text(".standard").tag(false)
                Text(".normalized").tag(true)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 220)
        }
    }
}

private struct C02_AreaMarkBandExample: View {
    struct Forecast: Identifiable {
        let id = UUID()
        let date: Date
        let low: Double
        let high: Double
        var mid: Double { (low + high) / 2 }
    }
    let forecast: [Forecast] = (0..<10).map { (i: Int) -> Forecast in
        let mid = 18 + 4 * sin(Double(i) / 2)
        return Forecast(date: C02_Data.day(i), low: mid - 3 - Double(i % 3), high: mid + 3 + Double(i % 2))
    }
    var body: some View {
        VStack(spacing: 6) {
            Chart(forecast) { f in
                AreaMark(x: .value("Day", f.date),
                         yStart: .value("Low", f.low),
                         yEnd: .value("High", f.high))
                .foregroundStyle(Color.orange)
                .opacity(0.3)
                LineMark(x: .value("Day", f.date), y: .value("Forecast", f.mid))
                    .foregroundStyle(Color.orange)
            }
            .frame(height: 140)
            C02_Caption("The area spans low … high per day — the shape behind confidence bands and min–max envelopes.")
        }
    }
}

private struct C02_AreaMarkSeriesExample: View {
    struct Reading: Identifiable {
        let id = UUID()
        let time: Int
        let level: Double
        let sensorID: String
    }
    let readings: [Reading] = (0..<10).flatMap { (t: Int) -> [Reading] in
        [Reading(time: t, level: 30 + 15 * sin(Double(t) / 2), sensorID: "A"),
         Reading(time: t, level: 20 + 10 * cos(Double(t) / 3), sensorID: "B"),
         Reading(time: t, level: 12 + Double(t) * 1.5, sensorID: "C")]
    }
    var body: some View {
        VStack(spacing: 6) {
            Chart(readings) { r in
                AreaMark(x: .value("Time", r.time),
                         y: .value("Level", r.level),
                         series: .value("Sensor", r.sensorID),
                         stacking: .unstacked)
                .foregroundStyle(Color.teal.opacity(0.4))
            }
            .frame(height: 130)
            C02_Caption("series: splits sensors A, B, C into separate overlapping areas without coloring by category.")
        }
    }
}

private struct C02_MarkStackingMethodExample: View {
    enum Method: String, CaseIterable, Identifiable {
        case standard, normalized, center, unstacked
        var id: String { rawValue }
        var value: MarkStackingMethod {
            switch self {
            case .standard: return .standard
            case .normalized: return .normalized
            case .center: return .center
            case .unstacked: return .unstacked
            }
        }
    }
    struct Share: Identifiable {
        let id = UUID()
        let month: String
        let share: Double
        let product: String
    }
    let shares: [Share] = {
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        var rows: [Share] = []
        for (i, m) in months.enumerated() {
            rows.append(Share(month: m, share: 20 + Double(i) * 4, product: "Basic"))
            rows.append(Share(month: m, share: 30 - Double(i) * 2, product: "Pro"))
            rows.append(Share(month: m, share: 10 + 8 * sin(Double(i)), product: "Team"))
        }
        return rows
    }()
    @State private var method: Method = .center
    var body: some View {
        VStack(spacing: 8) {
            Chart(shares) { m in
                AreaMark(x: .value("Month", m.month),
                         y: .value("Share", m.share),
                         stacking: method.value)
                .foregroundStyle(by: .value("Product", m.product))
            }
            .frame(height: 130)
            Picker("stacking", selection: $method) {
                ForEach(Method.allCases) { Text(".\($0.rawValue)").tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 320)
        }
    }
}

// MARK: - AxisMarks

private struct C02_AxisGridLineExample: View {
    @State private var dashed = true
    var body: some View {
        VStack(spacing: 8) {
            Chart(C02_Data.scores) { s in
                LineMark(x: .value("Trial", s.trial), y: .value("Score", s.score))
            }
            .chartYAxis {
                AxisMarks { _ in
                    AxisGridLine(stroke: StrokeStyle(dash: dashed ? [2, 3] : []))
                    AxisValueLabel()
                }
            }
            .frame(height: 130)
            Toggle("stroke: StrokeStyle(dash: [2, 3])", isOn: $dashed)
                .toggleStyle(.switch)
                .controlSize(.small)
                .font(.caption)
        }
    }
}

private struct C02_AxisTickExample: View {
    @State private var tickLength: CGFloat = 4
    var body: some View {
        VStack(spacing: 8) {
            Chart(C02_Data.steps) { e in
                BarMark(x: .value("Day", e.day), y: .value("Steps", e.steps))
            }
            .chartXAxis {
                AxisMarks { _ in
                    AxisTick(length: tickLength)
                    AxisValueLabel()
                }
            }
            .frame(height: 130)
            HStack {
                Text("length: \(Int(tickLength)) pt").font(.caption).monospacedDigit()
                Slider(value: $tickLength, in: 0...16)
            }
            .controlSize(.small)
        }
    }
}

private struct C02_AxisValueLabelExample: View {
    var body: some View {
        HStack(spacing: 16) {
            VStack(spacing: 4) {
                Chart(C02_Data.prices) { p in
                    LineMark(x: .value("Date", p.date), y: .value("Close", p.close))
                }
                .chartYAxis {
                    AxisMarks(values: .automatic) { _ in
                        AxisGridLine()
                        AxisValueLabel()
                    }
                }
                .frame(height: 120)
                C02_Caption("AxisValueLabel()")
            }
            VStack(spacing: 4) {
                Chart(C02_Data.prices) { p in
                    LineMark(x: .value("Date", p.date), y: .value("Close", p.close))
                }
                .chartYAxis {
                    AxisMarks(values: .automatic) { _ in
                        AxisGridLine()
                        AxisValueLabel(format: .currency(code: "USD"))
                    }
                }
                .frame(height: 120)
                C02_Caption("AxisValueLabel(format: .currency(code: \"USD\"))")
            }
        }
    }
}

private struct C02_AxisMarksPresetExample: View {
    enum Preset: String, CaseIterable, Identifiable {
        case automatic, aligned, extended, inset
        var id: String { rawValue }
        var value: AxisMarkPreset {
            switch self {
            case .automatic: return .automatic
            case .aligned: return .aligned
            case .extended: return .extended
            case .inset: return .inset
            }
        }
    }
    @State private var preset: Preset = .extended
    @State private var leading = true
    var body: some View {
        VStack(spacing: 8) {
            Chart(C02_Data.scores) { s in
                LineMark(x: .value("Trial", s.trial), y: .value("Score", s.score))
            }
            .chartYAxis {
                AxisMarks(preset: preset.value,
                          position: leading ? .leading : .trailing,
                          values: .automatic(desiredCount: 4),
                          stroke: StrokeStyle(lineWidth: 0.5))
            }
            .frame(height: 120)
            HStack(spacing: 12) {
                Picker("preset", selection: $preset) {
                    ForEach(Preset.allCases) { Text(".\($0.rawValue)").tag($0) }
                }
                .pickerStyle(.segmented)
                .labelsHidden()
                Toggle("position: .leading", isOn: $leading)
                    .toggleStyle(.switch)
            }
            .controlSize(.small)
            .font(.caption)
        }
    }
}

// MARK: - BarMark

private struct C02_BarMarkStandardExample: View {
    @State private var ratio: CGFloat = 0.6
    @State private var normalized = true
    var body: some View {
        VStack(spacing: 8) {
            Chart(C02_Data.regional) { sale in
                BarMark(x: .value("Month", sale.month),
                        y: .value("Units", sale.amount),
                        width: .ratio(ratio),
                        height: .automatic,
                        stacking: normalized ? .normalized : .standard)
                .foregroundStyle(by: .value("Region", sale.region))
            }
            .frame(height: 120)
            HStack(spacing: 12) {
                Text("width: .ratio(\(String(format: "%.1f", ratio)))").monospacedDigit()
                Slider(value: $ratio, in: 0.2...1)
                Toggle("stacking: .normalized", isOn: $normalized)
                    .toggleStyle(.switch)
            }
            .controlSize(.small)
            .font(.caption)
        }
    }
}

private struct C02_BarMarkRangeExample: View {
    struct Shift: Identifiable {
        let id = UUID()
        let day: String
        let start: Double
        let end: Double
    }
    let shifts = [
        Shift(day: "Mon", start: 9, end: 17), Shift(day: "Tue", start: 8, end: 12),
        Shift(day: "Wed", start: 13, end: 21), Shift(day: "Thu", start: 9, end: 17),
        Shift(day: "Fri", start: 10, end: 14),
    ]
    var body: some View {
        VStack(spacing: 6) {
            Chart(shifts) { s in
                BarMark(x: .value("Day", s.day),
                        yStart: .value("Start", s.start),
                        yEnd: .value("End", s.end),
                        width: .fixed(14))
                .foregroundStyle(Color.indigo)
                .cornerRadius(4)
            }
            .chartYScale(domain: 6...24)
            .frame(height: 140)
            C02_Caption("Each bar floats from its start hour to its end hour instead of rising from zero.")
        }
    }
}

private struct C02_BarMarkHorizontalExample: View {
    struct Phase: Identifiable {
        let id = UUID()
        let name: String
        let start: Date
        let end: Date
    }
    let tasks = [
        Phase(name: "Design", start: C02_Data.day(0), end: C02_Data.day(6)),
        Phase(name: "Build", start: C02_Data.day(4), end: C02_Data.day(16)),
        Phase(name: "Test", start: C02_Data.day(14), end: C02_Data.day(22)),
        Phase(name: "Ship", start: C02_Data.day(21), end: C02_Data.day(24)),
    ]
    var body: some View {
        Chart(tasks) { task in
            BarMark(xStart: .value("Begin", task.start),
                    xEnd: .value("Finish", task.end),
                    y: .value("Task", task.name),
                    height: .inset(4))
            .foregroundStyle(by: .value("Task", task.name))
        }
        .chartLegend(.hidden)
        .chartXAxis {
            AxisMarks(values: .stride(by: .day, count: 7)) { _ in
                AxisGridLine()
                AxisValueLabel(format: .dateTime.month().day())
            }
        }
        .frame(height: 150)
    }
}

private struct C02_MarkDimensionExample: View {
    enum Dimension: String, CaseIterable, Identifiable {
        case automatic = ".automatic"
        case fixed = ".fixed(24)"
        case ratio = ".ratio(0.5)"
        case inset = ".inset(6)"
        var id: String { rawValue }
        var value: MarkDimension {
            switch self {
            case .automatic: return .automatic
            case .fixed: return .fixed(24)
            case .ratio: return .ratio(0.5)
            case .inset: return .inset(6)
            }
        }
    }
    struct Team: Identifiable {
        let id = UUID()
        let name: String
        let wins: Double
    }
    let teams = [
        Team(name: "Hawks", wins: 42), Team(name: "Owls", wins: 35),
        Team(name: "Jays", wins: 51), Team(name: "Wrens", wins: 28),
    ]
    @State private var width: Dimension = .fixed
    var body: some View {
        VStack(spacing: 8) {
            Chart(teams) { t in
                BarMark(x: .value("Team", t.name),
                        y: .value("Wins", t.wins),
                        width: width.value)
            }
            .frame(height: 120)
            Picker("width", selection: $width) {
                ForEach(Dimension.allCases) { Text($0.rawValue).tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 320)
        }
    }
}

// MARK: - ChartProxy

private struct C02_ChartProxyValueAtXExample: View {
    @State private var selected: Date?
    var body: some View {
        VStack(spacing: 6) {
            Chart {
                ForEach(C02_Data.prices) { p in
                    LineMark(x: .value("Date", p.date), y: .value("Close", p.close))
                }
                if let selected {
                    RuleMark(x: .value("Selected", selected))
                        .foregroundStyle(.secondary)
                }
            }
            .chartOverlay { proxy in
                GeometryReader { geo in
                    Rectangle().fill(.clear).contentShape(Rectangle())
                        .gesture(DragGesture(minimumDistance: 0).onChanged { drag in
                            guard let plot = proxy.plotFrame else { return }
                            let x = drag.location.x - geo[plot].origin.x
                            selected = proxy.value(atX: x, as: Date.self)
                        })
                }
            }
            .frame(height: 130)
            Text(selected.map { "value(atX:as:) → \($0.formatted(.dateTime.month().day()))" }
                 ?? "Press and drag across the plot — selected = nil")
                .font(.caption)
                .foregroundStyle(.secondary)
                .monospacedDigit()
        }
    }
}

private struct C02_ChartProxyPositionForXExample: View {
    @State private var dayIndex: Double = 12
    var body: some View {
        let selectedDate = C02_Data.day(Int(dayIndex))
        VStack(spacing: 8) {
            Chart(C02_Data.prices) { p in
                LineMark(x: .value("Date", p.date), y: .value("Close", p.close))
            }
            .chartOverlay { proxy in
                GeometryReader { geo in
                    if let x = proxy.position(forX: selectedDate), let plot = proxy.plotFrame {
                        Rectangle()
                            .fill(.red)
                            .frame(width: 1, height: geo[plot].height)
                            .offset(x: geo[plot].origin.x + x, y: geo[plot].origin.y)
                    }
                }
            }
            .frame(height: 120)
            HStack {
                Text("position(forX: \(selectedDate.formatted(.dateTime.month().day())))")
                    .font(.caption)
                    .monospacedDigit()
                Slider(value: $dayIndex, in: 0...27, step: 1)
            }
            .controlSize(.small)
        }
    }
}

private struct C02_ChartProxyValueAtExample: View {
    @State private var hit: (Date, Double)?
    var body: some View {
        VStack(spacing: 6) {
            Chart {
                ForEach(C02_Data.prices) { p in
                    PointMark(x: .value("Date", p.date), y: .value("Close", p.close))
                }
                if let hit {
                    PointMark(x: .value("Date", hit.0), y: .value("Close", hit.1))
                        .foregroundStyle(.red)
                        .symbolSize(120)
                }
            }
            .chartOverlay { proxy in
                GeometryReader { geo in
                    Rectangle().fill(.clear).contentShape(Rectangle())
                        .gesture(DragGesture(minimumDistance: 0).onChanged { drag in
                            guard let plot = proxy.plotFrame else { return }
                            let origin = geo[plot].origin
                            let point = CGPoint(x: drag.location.x - origin.x, y: drag.location.y - origin.y)
                            hit = proxy.value(at: point, as: (Date, Double).self)
                        })
                }
            }
            .frame(height: 130)
            Text(hit.map { "value(at:as:) → (\($0.0.formatted(.dateTime.month().day())), \(String(format: "%.1f", $0.1)))" }
                 ?? "Press and drag inside the plot — hit = nil")
                .font(.caption)
                .foregroundStyle(.secondary)
                .monospacedDigit()
        }
    }
}

// C02_END_STRUCTS
