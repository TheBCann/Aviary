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

// C02_END_STRUCTS
