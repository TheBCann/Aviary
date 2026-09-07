//
//  ChildExamples+Part22.swift
//  Aviary
//
//  Compiled renderings for variant entries (part 22: styles).
//  One private C22_* struct per variant; every rendering exercises the exact
//  overload the variant names, so siblings can be compared side by side.
//

import SwiftUI

enum ChildExamplesPart22 {
    static let entries: [ChildExampleEntry] = [

        // MARK: .progressViewStyle()

        ChildExampleEntry(parent: ".progressViewStyle()", child: "makeBody(configuration:)", code: """
        struct Ring: ProgressViewStyle {
            func makeBody(configuration: Configuration) -> some View {
                ZStack {
                    Circle().stroke(.quaternary, lineWidth: 6)
                    Circle()
                        .trim(from: 0, to: configuration.fractionCompleted ?? 0)
                        .stroke(.tint, lineWidth: 6)
                        .rotationEffect(.degrees(-90))
                    configuration.label.font(.caption)
                }
            }
        }

        ProgressView(value: progress) { Text("\\(Int(progress * 100))%") }
            .progressViewStyle(Ring())
        """) { AnyView(C22_RingProgressStyleExample()) },

        // MARK: .tableStyle()

        ChildExampleEntry(parent: ".tableStyle()", child: ".automatic", code: """
        Table(people) {
            TableColumn("Name", value: \\.name)
            TableColumn("Role", value: \\.role)
        }
        .tableStyle(.automatic)
        """) { AnyView(C22_TableAutomaticExample()) },

        ChildExampleEntry(parent: ".tableStyle()", child: ".inset", code: """
        Table(orders, selection: $selected) {
            TableColumn("ID", value: \\.id.description)
            TableColumn("Total", value: \\.totalText)
        }
        .tableStyle(.inset)
        """) { AnyView(C22_TableInsetExample()) },

        ChildExampleEntry(parent: ".tableStyle()", child: ".bordered", code: """
        Table(files) {
            TableColumn("Name", value: \\.name)
            TableColumn("Size", value: \\.sizeText)
        }
        .tableStyle(.bordered)
        .alternatingRowBackgrounds()
        """) { AnyView(C22_TableBorderedExample()) },

        // MARK: .tabViewStyle()

        ChildExampleEntry(parent: ".tabViewStyle()", child: ".page(indexDisplayMode:)", code: """
        TabView {
            ForEach(slides) { SlideView($0) }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))   // swipe between pages; dots stay visible
        """) { AnyView(C22_TabPageExample()) },

        ChildExampleEntry(parent: ".tabViewStyle()", child: ".sidebarAdaptable", code: """
        TabView {
            Tab("Library", systemImage: "books.vertical") { LibraryView() }
            Tab("Playlists", systemImage: "music.note.list") { PlaylistsView() }
            Tab("Search", systemImage: "magnifyingglass", role: .search) {
                SearchView()
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        """) { AnyView(C22_TabSidebarAdaptableExample()) },

        ChildExampleEntry(parent: ".tabViewStyle()", child: ".tabBarOnly", code: """
        TabView(selection: $tab) {
            Tab("Home", systemImage: "house", value: .home) { HomeView() }
            Tab("Inbox", systemImage: "tray", value: .inbox) { InboxView() }
        }
        .tabViewStyle(.tabBarOnly)
        """) { AnyView(C22_TabBarOnlyExample()) },

        ChildExampleEntry(parent: ".tabViewStyle()", child: ".grouped", code: """
        TabView {
            Tab("General", systemImage: "gear") { GeneralPane() }
            Tab("Advanced", systemImage: "slider.horizontal.3") { AdvancedPane() }
        }
        .tabViewStyle(.grouped)
        """) { AnyView(C22_TabGroupedExample()) },

        // MARK: .textFieldStyle()

        ChildExampleEntry(parent: ".textFieldStyle()", child: ".plain", code: """
        TextField("Search", text: $query)
            .textFieldStyle(.plain)
            .padding(8)
            .background(.quaternary, in: .capsule)
        """) { AnyView(C22_TextFieldPlainExample()) },

        ChildExampleEntry(parent: ".textFieldStyle()", child: ".roundedBorder", code: """
        TextField("City", text: $city)
            .textFieldStyle(.roundedBorder)
        """) { AnyView(C22_TextFieldRoundedBorderExample()) },

        ChildExampleEntry(parent: ".textFieldStyle()", child: ".squareBorder", code: """
        TextField("Path", text: $path)
            .textFieldStyle(.squareBorder)   // macOS only
        """) { AnyView(C22_TextFieldSquareBorderExample()) },

        ChildExampleEntry(parent: ".textFieldStyle()", child: ".automatic", code: """
        Form {
            TextField("Email", text: $email)
                .textFieldStyle(.automatic)   // the Form decides the chrome
        }
        .formStyle(.grouped)
        """) { AnyView(C22_TextFieldAutomaticExample()) },

        // MARK: .toggleStyle()

        ChildExampleEntry(parent: ".toggleStyle()", child: ".switch", code: """
        Toggle("Wi-Fi", isOn: $wifiEnabled)
            .toggleStyle(.switch)
        """) { AnyView(C22_ToggleSwitchExample()) },

        ChildExampleEntry(parent: ".toggleStyle()", child: ".checkbox", code: """
        Toggle("Remember me", isOn: $remember)
            .toggleStyle(.checkbox)
        """) { AnyView(C22_ToggleCheckboxExample()) },

        ChildExampleEntry(parent: ".toggleStyle()", child: ".button", code: """
        Toggle("Italic", systemImage: "italic", isOn: $isItalic)
            .toggleStyle(.button)

        Text("The quick brown fox")
            .italic(isItalic)
        """) { AnyView(C22_ToggleButtonExample()) },

        // MARK: AngularGradient

        ChildExampleEntry(parent: "AngularGradient", child: "AngularGradient(colors:center:startAngle:endAngle:)", code: """
        Circle()
            .fill(AngularGradient(
                colors: [.red, .yellow, .green, .blue, .red],
                center: .center,
                startAngle: .zero,
                endAngle: .degrees(360)
            ))
        """) { AnyView(C22_AngularColorsExample()) },

        ChildExampleEntry(parent: "AngularGradient", child: "AngularGradient(gradient:center:angle:)", code: """
        Circle()
            .fill(AngularGradient(
                gradient: Gradient(colors: [.orange, .pink, .orange]),
                center: .center,
                angle: .degrees(rotation)     // one angle rotates the whole sweep
            ))
        Slider(value: $rotation, in: -180...180)
        """) { AnyView(C22_AngularGradientAngleExample()) },

        ChildExampleEntry(parent: "AngularGradient", child: "AngularGradient(stops:center:startAngle:endAngle:)", code: """
        Circle()
            .fill(AngularGradient(
                stops: [
                    .init(color: .green, location: 0),
                    .init(color: .green, location: 0.7),
                    .init(color: .red, location: 0.7),
                    .init(color: .red, location: 1)
                ],
                center: .center, startAngle: .zero, endAngle: .degrees(270)
            ))
        """) { AnyView(C22_AngularStopsExample()) },

        ChildExampleEntry(parent: "AngularGradient", child: ".conicGradient(colors:center:angle:)", code: """
        Circle()
            .fill(.conicGradient(
                colors: [.purple, .blue, .cyan, .purple],
                center: .center,
                angle: .degrees(45)
            ))
        """) { AnyView(C22_ConicGradientExample()) },

        // MARK: Animation.timingCurve()

        ChildExampleEntry(parent: "Animation.timingCurve()", child: "timingCurve(_:_:_:_:duration:)", code: """
        Button("Toggle") {
            withAnimation(.timingCurve(0.68, -0.6, 0.32, 1.6, duration: 0.5)) {
                isPresented.toggle()   // y values outside 0…1 anticipate, then overshoot
            }
        }
        marker.offset(x: isPresented ? 80 : -80)
        """) { AnyView(C22_TimingCurveRawExample()) },

        ChildExampleEntry(parent: "Animation.timingCurve()", child: "timingCurve(_:duration:)", code: """
        marker
            .offset(x: pressed ? 80 : -80)
            .animation(.timingCurve(curve, duration: 0.6), value: pressed)   // curve: UnitCurve

        Picker("Curve", selection: $curveIndex) { … }   // .easeInOut, .easeIn, .easeOut, .linear
        Button(pressed ? "Back" : "Go") { pressed.toggle() }
        """) { AnyView(C22_TimingCurveUnitCurveExample()) },

        ChildExampleEntry(parent: "Animation.timingCurve()", child: "UnitCurve.bezier(startControlPoint:endControlPoint:)", code: """
        let snappy = UnitCurve.bezier(
            startControlPoint: UnitPoint(x: 0.2, y: 0.9),
            endControlPoint: UnitPoint(x: 0.4, y: 1)
        )
        let halfway = snappy.value(at: 0.5)                  // sample the curve directly
        let motion = Animation.timingCurve(snappy, duration: 0.4)

        Button("Animate") { withAnimation(motion) { moved.toggle() } }
        """) { AnyView(C22_UnitCurveBezierExample()) },

        // MARK: Color.mix()

        ChildExampleEntry(parent: "Color.mix()", child: "mix(with:by:in:)", code: """
        let pressed = Color.accentColor.mix(with: .black, by: 0.15)
        let raw = Color.red.mix(with: .blue, by: fraction, in: .device)

        Slider(value: $fraction, in: 0...1)
        """) { AnyView(C22_ColorMixExample()) },

        ChildExampleEntry(parent: "Color.mix()", child: "Gradient.ColorSpace", code: """
        // Same colors, same fractions — only the color space differs.
        ForEach(fractions, id: \\.self) { f in
            Rectangle().fill(Color.yellow.mix(with: .blue, by: f, in: .perceptual))
        }
        ForEach(fractions, id: \\.self) { f in
            Rectangle().fill(Color.yellow.mix(with: .blue, by: f, in: .device))
        }
        """) { AnyView(C22_GradientColorSpaceExample()) },

        // MARK: ImagePaint

        ChildExampleEntry(parent: "ImagePaint", child: "ImagePaint(image:sourceRect:scale:)", code: """
        let tile = Image(size: CGSize(width: 32, height: 32)) { ctx in   // drawn, not an asset
            ctx.fill(Path(ellipseIn: CGRect(x: 4, y: 4, width: 8, height: 8)), with: .color(.orange))
            ctx.fill(Path(CGRect(x: 16, y: 16, width: 16, height: 16)), with: .color(.teal))
        }
        let texture = ImagePaint(
            image: tile,
            sourceRect: CGRect(x: 0, y: 0, width: 0.5, height: 0.5),   // top-left quarter only
            scale: 0.75
        )
        Capsule().stroke(texture, lineWidth: 14)
        """) { AnyView(C22_ImagePaintInitExample()) },

        ChildExampleEntry(parent: "ImagePaint", child: ".image(_:sourceRect:scale:)", code: """
        RoundedRectangle(cornerRadius: 12)
            .fill(.image(tile, scale: 0.5))     // sourceRect defaults to the whole image
            .frame(width: 200, height: 100)
        """) { AnyView(C22_ImagePaintStaticExample()) },

        // MARK: LinearGradient

        ChildExampleEntry(parent: "LinearGradient", child: "LinearGradient(colors:startPoint:endPoint:)", code: """
        RoundedRectangle(cornerRadius: 12)
            .fill(LinearGradient(
                colors: [.purple, .blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ))
        """) { AnyView(C22_LinearColorsExample()) },

        ChildExampleEntry(parent: "LinearGradient", child: "LinearGradient(gradient:startPoint:endPoint:)", code: """
        let brand = Gradient(colors: [.indigo, .pink])   // one stop list, reused twice

        Rectangle()
            .fill(LinearGradient(gradient: brand, startPoint: .leading, endPoint: .trailing))
        Capsule()
            .fill(LinearGradient(gradient: brand, startPoint: .top, endPoint: .bottom))
        """) { AnyView(C22_LinearGradientReuseExample()) },

        ChildExampleEntry(parent: "LinearGradient", child: "LinearGradient(stops:startPoint:endPoint:)", code: """
        artwork.overlay {
            LinearGradient(
                stops: [
                    .init(color: .black, location: 0),
                    .init(color: .black.opacity(0), location: 0.4)   // fade ends 40% of the way up
                ],
                startPoint: .bottom, endPoint: .top
            )
        }
        """) { AnyView(C22_LinearStopsExample()) },

        ChildExampleEntry(parent: "LinearGradient", child: ".linearGradient(colors:startPoint:endPoint:)", code: """
        Text("Hello")
            .font(.largeTitle.bold())
            .foregroundStyle(.linearGradient(
                colors: [.orange, .red],
                startPoint: .top, endPoint: .bottom
            ))
        """) { AnyView(C22_LinearShorthandExample()) },

        // MARK: Material

        ChildExampleEntry(parent: "Material", child: ".ultraThinMaterial", code: """
        Text("Now Playing · 3:42")
            .padding(8)
            .background(.ultraThinMaterial, in: .capsule)   // most of the backdrop shows through
        """) { AnyView(C22_MaterialUltraThinExample()) },

        ChildExampleEntry(parent: "Material", child: ".regularMaterial", code: """
        VStack { controls }
            .padding()
            .background(.regularMaterial, in: .rect(cornerRadius: 16))
        """) { AnyView(C22_MaterialRegularExample()) },

        ChildExampleEntry(parent: "Material", child: ".ultraThickMaterial", code: """
        Text("Sheet content")
            .padding()
            .background(.ultraThickMaterial, in: .rect(cornerRadius: 12))   // inline preview

        Button("Show Sheet") { showSheet = true }
            .sheet(isPresented: $showSheet) {
                sheetContent
                    .presentationBackground(.ultraThickMaterial)   // on a real sheet
            }
        """) { AnyView(C22_MaterialUltraThickExample()) },

        ChildExampleEntry(parent: "Material", child: ".bar", code: """
        HStack { playbackButtons }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.bar)   // the material system toolbars and tab bars use
        """) { AnyView(C22_MaterialBarExample()) },

        // MARK: MeshGradient

        ChildExampleEntry(parent: "MeshGradient", child: "MeshGradient(width:height:points:colors:background:smoothsColors:colorSpace:)", code: """
        MeshGradient(
            width: 2, height: 2,
            points: [[0, 0], [1, 0], [0, 1], [1, 1]],
            colors: [.red, .orange, .purple, .blue],
            smoothsColors: smooth          // bicubic (true) vs. bilinear (false) blending
        )
        Toggle("smoothsColors", isOn: $smooth)
        """) { AnyView(C22_MeshPointsExample()) },

        ChildExampleEntry(parent: "MeshGradient", child: "MeshGradient(width:height:locations:colors:background:smoothsColors:colorSpace:)", code: """
        MeshGradient(
            width: 2, height: 2,
            locations: .points([[0, 0], [1, 0], [0, 1], [1, 1]]),
            colors: .colors([.mint, .teal, .indigo, .cyan]),
            background: .black,
            colorSpace: .perceptual
        )
        """) { AnyView(C22_MeshLocationsExample()) },

        ChildExampleEntry(parent: "MeshGradient", child: "MeshGradient.Locations", code: """
        let simple: MeshGradient.Locations = .points(grid)
        let curved: MeshGradient.Locations = .bezierPoints(bezierGrid)   // handles bow every edge inward

        MeshGradient(width: 2, height: 2, locations: simple, colors: palette, background: .black)
        MeshGradient(width: 2, height: 2, locations: curved, colors: palette, background: .black)
        """) { AnyView(C22_MeshLocationsEnumExample()) },

        ChildExampleEntry(parent: "MeshGradient", child: "MeshGradient.BezierPoint", code: """
        let corner = MeshGradient.BezierPoint(
            position: [0, 0],
            leadingControlPoint: [0, 0],
            topControlPoint: [0, 0],
            trailingControlPoint: [0.35, 0.3],   // pulls the top edge down…
            bottomControlPoint: [0.3, 0.35]      // …and the left edge in
        )
        MeshGradient(width: 2, height: 2,
                     locations: .bezierPoints([corner] + straightCorners),
                     colors: palette, background: .black)
        """) { AnyView(C22_MeshBezierPointExample()) },

        // MARK: RadialGradient

        ChildExampleEntry(parent: "RadialGradient", child: "RadialGradient(colors:center:startRadius:endRadius:)", code: """
        Circle()
            .fill(RadialGradient(
                colors: [.yellow, .orange, .red],
                center: .center,
                startRadius: 5,      // radii are in points, not fractions
                endRadius: 60
            ))
        """) { AnyView(C22_RadialColorsExample()) },

        ChildExampleEntry(parent: "RadialGradient", child: "RadialGradient(gradient:center:startRadius:endRadius:)", code: """
        let glow = Gradient(colors: [.white, .clear])   // reusable stop list

        RoundedRectangle(cornerRadius: 12)
            .fill(.indigo)
            .overlay {
                RadialGradient(gradient: glow, center: .topLeading,
                               startRadius: 0, endRadius: 120)
            }
        """) { AnyView(C22_RadialGradientReuseExample()) },

        ChildExampleEntry(parent: "RadialGradient", child: "RadialGradient(stops:center:startRadius:endRadius:)", code: """
        Circle()
            .fill(RadialGradient(
                stops: [
                    .init(color: .white, location: 0),
                    .init(color: .white, location: 0.2),   // flat highlight…
                    .init(color: .blue, location: 0.25)    // …then a sharp ring
                ],
                center: .center, startRadius: 0, endRadius: 80
            ))
        """) { AnyView(C22_RadialStopsExample()) },

        ChildExampleEntry(parent: "RadialGradient", child: ".radialGradient(colors:center:startRadius:endRadius:)", code: """
        artwork.overlay {
            Rectangle()
                .fill(.radialGradient(
                    colors: [.black.opacity(0), .black.opacity(0.6)],   // vignette
                    center: .center, startRadius: 40, endRadius: 140
                ))
        }
        """) { AnyView(C22_RadialShorthandExample()) },
    ]
}

// MARK: - .progressViewStyle()

private struct C22_RingProgressStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle().stroke(.quaternary, lineWidth: 6)
            Circle()
                .trim(from: 0, to: configuration.fractionCompleted ?? 0)
                .stroke(.tint, lineWidth: 6)
                .rotationEffect(.degrees(-90))
            configuration.label.font(.caption)
        }
    }
}

private struct C22_RingProgressStyleExample: View {
    @State private var progress = 0.65

    var body: some View {
        VStack(spacing: 14) {
            ProgressView(value: progress) { Text("\(Int(progress * 100))%") }
                .progressViewStyle(C22_RingProgressStyle())
                .frame(width: 76, height: 76)
                .animation(.easeInOut(duration: 0.2), value: progress)
            Slider(value: $progress, in: 0...1)
                .frame(width: 180)
        }
    }
}

// MARK: - .tableStyle()

private struct C22_TablePerson: Identifiable {
    let id = UUID()
    let name: String
    let role: String
}

private struct C22_TableAutomaticExample: View {
    private let people = [
        C22_TablePerson(name: "Ada Lovelace", role: "Analyst"),
        C22_TablePerson(name: "Grace Hopper", role: "Rear Admiral"),
        C22_TablePerson(name: "Margaret Hamilton", role: "Engineer"),
    ]

    var body: some View {
        Table(people) {
            TableColumn("Name", value: \.name)
            TableColumn("Role", value: \.role)
        }
        .tableStyle(.automatic)
        .frame(height: 140)
    }
}

private struct C22_TableOrder: Identifiable {
    let id: Int
    let total: Double
    var totalText: String { String(format: "$%.2f", total) }
}

private struct C22_TableInsetExample: View {
    @State private var selected: C22_TableOrder.ID?
    private let orders = [
        C22_TableOrder(id: 1042, total: 19.99),
        C22_TableOrder(id: 1043, total: 148.50),
        C22_TableOrder(id: 1044, total: 7.25),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Table(orders, selection: $selected) {
                TableColumn("ID", value: \.id.description)
                TableColumn("Total", value: \.totalText)
            }
            .tableStyle(.inset)
            .frame(height: 130)
            Text(selected.map { "Selected order #\($0)" } ?? "Click a row to select it")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C22_TableFile: Identifiable {
    let id = UUID()
    let name: String
    let sizeText: String
}

private struct C22_TableBorderedExample: View {
    private let files = [
        C22_TableFile(name: "Notes.md", sizeText: "4 KB"),
        C22_TableFile(name: "Budget.numbers", sizeText: "212 KB"),
        C22_TableFile(name: "Keynote.key", sizeText: "18 MB"),
        C22_TableFile(name: "Photo.heic", sizeText: "3 MB"),
    ]

    var body: some View {
        Table(files) {
            TableColumn("Name", value: \.name)
            TableColumn("Size", value: \.sizeText)
        }
        .tableStyle(.bordered)
        .alternatingRowBackgrounds()
        .frame(height: 150)
    }
}

// MARK: - .tabViewStyle()

private struct C22_TabPane: View {
    let title: String
    let symbol: String

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: symbol)
                .font(.largeTitle)
                .foregroundStyle(.tint)
            Text(title)
                .font(.headline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

private struct C22_TabPageExample: View {
    @State private var page = 0
    private let colors: [Color] = [.blue, .orange, .green]

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(colors[page].gradient)
                Text("Slide \(page + 1)")
                    .font(.title2.bold())
                    .foregroundStyle(.white)
            }
            .frame(width: 220, height: 104)
            .gesture(
                DragGesture(minimumDistance: 20).onEnded { value in
                    withAnimation {
                        page = value.translation.width < 0
                            ? min(page + 1, colors.count - 1)
                            : max(page - 1, 0)
                    }
                }
            )
            HStack(spacing: 6) {
                ForEach(colors.indices, id: \.self) { index in
                    Circle()
                        .fill(index == page ? Color.primary : Color.secondary.opacity(0.35))
                        .frame(width: 6, height: 6)
                }
            }
            Text("Illustrative — .page is iOS, tvOS, watchOS, and visionOS only (drag to page)")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C22_TabSidebarAdaptableExample: View {
    var body: some View {
        TabView {
            Tab("Library", systemImage: "books.vertical") {
                C22_TabPane(title: "Library", symbol: "books.vertical")
            }
            Tab("Playlists", systemImage: "music.note.list") {
                C22_TabPane(title: "Playlists", symbol: "music.note.list")
            }
            Tab("Search", systemImage: "magnifyingglass", role: .search) {
                C22_TabPane(title: "Search", symbol: "magnifyingglass")
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        .frame(height: 200)
    }
}

private enum C22_MainTab: Hashable {
    case home, inbox
}

private struct C22_TabBarOnlyExample: View {
    @State private var tab = C22_MainTab.home

    var body: some View {
        TabView(selection: $tab) {
            Tab("Home", systemImage: "house", value: C22_MainTab.home) {
                C22_TabPane(title: "Home", symbol: "house")
            }
            Tab("Inbox", systemImage: "tray", value: C22_MainTab.inbox) {
                C22_TabPane(title: "Inbox", symbol: "tray")
            }
        }
        .tabViewStyle(.tabBarOnly)
        .frame(height: 180)
    }
}

private struct C22_TabGroupedExample: View {
    var body: some View {
        TabView {
            Tab("General", systemImage: "gear") {
                C22_TabPane(title: "General", symbol: "gear")
            }
            Tab("Advanced", systemImage: "slider.horizontal.3") {
                C22_TabPane(title: "Advanced", symbol: "slider.horizontal.3")
            }
        }
        .tabViewStyle(.grouped)
        .frame(height: 180)
    }
}

// MARK: - .textFieldStyle()

private struct C22_TextFieldPlainExample: View {
    @State private var query = ""

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            TextField("Search", text: $query)
                .textFieldStyle(.plain)
        }
        .padding(8)
        .background(.quaternary, in: .capsule)
        .frame(width: 220)
    }
}

private struct C22_TextFieldRoundedBorderExample: View {
    @State private var city = ""

    var body: some View {
        TextField("City", text: $city)
            .textFieldStyle(.roundedBorder)
            .frame(width: 220)
    }
}

private struct C22_TextFieldSquareBorderExample: View {
    @State private var path = "/Users/me/Documents"

    var body: some View {
        TextField("Path", text: $path)
            .textFieldStyle(.squareBorder)
            .frame(width: 220)
    }
}

private struct C22_TextFieldAutomaticExample: View {
    @State private var email = ""

    var body: some View {
        Form {
            TextField("Email", text: $email)
                .textFieldStyle(.automatic)
        }
        .formStyle(.grouped)
        .frame(width: 280, height: 110)
    }
}

// MARK: - .toggleStyle()

private struct C22_ToggleSwitchExample: View {
    @State private var wifiEnabled = true

    var body: some View {
        Toggle("Wi-Fi", isOn: $wifiEnabled)
            .toggleStyle(.switch)
            .frame(width: 180)
    }
}

private struct C22_ToggleCheckboxExample: View {
    @State private var remember = true

    var body: some View {
        Toggle("Remember me", isOn: $remember)
            .toggleStyle(.checkbox)
    }
}

private struct C22_ToggleButtonExample: View {
    @State private var isItalic = true

    var body: some View {
        VStack(spacing: 12) {
            Toggle("Italic", systemImage: "italic", isOn: $isItalic)
                .toggleStyle(.button)
            Text("The quick brown fox")
                .italic(isItalic)
        }
    }
}

// MARK: - AngularGradient

private struct C22_AngularColorsExample: View {
    var body: some View {
        Circle()
            .fill(AngularGradient(
                colors: [.red, .yellow, .green, .blue, .red],
                center: .center,
                startAngle: .zero,
                endAngle: .degrees(360)
            ))
            .frame(width: 120, height: 120)
    }
}

private struct C22_AngularGradientAngleExample: View {
    @State private var rotation = -90.0

    var body: some View {
        VStack(spacing: 12) {
            Circle()
                .fill(AngularGradient(
                    gradient: Gradient(colors: [.orange, .pink, .orange]),
                    center: .center,
                    angle: .degrees(rotation)
                ))
                .frame(width: 104, height: 104)
            Slider(value: $rotation, in: -180...180)
                .frame(width: 180)
            Text(String(format: "angle: %.0f°", rotation))
                .font(.caption)
                .monospacedDigit()
                .foregroundStyle(.secondary)
        }
    }
}

private struct C22_AngularStopsExample: View {
    var body: some View {
        HStack(spacing: 20) {
            Circle()
                .fill(AngularGradient(
                    stops: [
                        .init(color: .green, location: 0),
                        .init(color: .green, location: 0.7),
                        .init(color: .red, location: 0.7),
                        .init(color: .red, location: 1),
                    ],
                    center: .center, startAngle: .zero, endAngle: .degrees(270)
                ))
                .frame(width: 110, height: 110)
            VStack(alignment: .leading, spacing: 4) {
                Text("0 → 0.7  green").foregroundStyle(.green)
                Text("0.7 → 1  red").foregroundStyle(.red)
                Text("Two stops at 0.7 make a hard edge; the arc spans 0°–270°.")
                    .foregroundStyle(.secondary)
            }
            .font(.caption)
            .frame(width: 150, alignment: .leading)
        }
    }
}

private struct C22_ConicGradientExample: View {
    var body: some View {
        Circle()
            .fill(.conicGradient(
                colors: [.purple, .blue, .cyan, .purple],
                center: .center,
                angle: .degrees(45)
            ))
            .frame(width: 120, height: 120)
    }
}

// MARK: - Animation.timingCurve()

private struct C22_TimingCurveRawExample: View {
    @State private var isPresented = false

    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                Capsule()
                    .fill(.quaternary)
                    .frame(width: 220, height: 36)
                Circle()
                    .fill(.tint)
                    .frame(width: 28, height: 28)
                    .offset(x: isPresented ? 80 : -80)
            }
            Button("Toggle") {
                withAnimation(.timingCurve(0.68, -0.6, 0.32, 1.6, duration: 0.5)) {
                    isPresented.toggle()
                }
            }
            Text("cubic-bezier(0.68, -0.6, 0.32, 1.6): pulls back, then overshoots")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C22_TimingCurveUnitCurveExample: View {
    private static let presets: [(name: String, curve: UnitCurve)] = [
        ("easeInOut", .easeInOut),
        ("easeIn", .easeIn),
        ("easeOut", .easeOut),
        ("linear", .linear),
    ]
    @State private var curveIndex = 0
    @State private var pressed = false

    var body: some View {
        VStack(spacing: 14) {
            ZStack {
                Capsule()
                    .fill(.quaternary)
                    .frame(width: 220, height: 36)
                Circle()
                    .fill(.tint)
                    .frame(width: 28, height: 28)
                    .offset(x: pressed ? 80 : -80)
                    .animation(.timingCurve(Self.presets[curveIndex].curve, duration: 0.6), value: pressed)
            }
            Picker("Curve", selection: $curveIndex) {
                ForEach(Self.presets.indices, id: \.self) { index in
                    Text(Self.presets[index].name).tag(index)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 260)
            Button(pressed ? "Back" : "Go") { pressed.toggle() }
        }
    }
}

private struct C22_UnitCurveBezierExample: View {
    private let snappy = UnitCurve.bezier(
        startControlPoint: UnitPoint(x: 0.2, y: 0.9),
        endControlPoint: UnitPoint(x: 0.4, y: 1)
    )
    @State private var moved = false

    var body: some View {
        let halfway = snappy.value(at: 0.5)
        let motion = Animation.timingCurve(snappy, duration: 0.4)
        HStack(spacing: 20) {
            plot
                .frame(width: 120, height: 80)
            VStack(alignment: .leading, spacing: 10) {
                Text(String(format: "value(at: 0.5) = %.2f", halfway))
                    .font(.caption)
                    .monospacedDigit()
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(.quaternary)
                        .frame(width: 150, height: 24)
                    Circle()
                        .fill(.tint)
                        .frame(width: 18, height: 18)
                        .padding(.leading, 3)
                        .offset(x: moved ? 126 : 0)
                }
                Button("Animate") { withAnimation(motion) { moved.toggle() } }
            }
        }
    }

    private var plot: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .stroke(.quaternary)
            Path { path in
                let width = 120.0
                let height = 80.0
                path.move(to: CGPoint(x: 0, y: height))
                for step in 1...40 {
                    let t = Double(step) / 40
                    path.addLine(to: CGPoint(x: t * width, y: height - snappy.value(at: t) * height))
                }
            }
            .stroke(.tint, lineWidth: 2)
        }
    }
}

// MARK: - Color.mix()

private struct C22_ColorMixExample: View {
    @State private var fraction = 0.5

    var body: some View {
        let pressed = Color.accentColor.mix(with: .black, by: 0.15)
        let raw = Color.red.mix(with: .blue, by: fraction, in: .device)
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                C22_Swatch(color: .accentColor, label: "accentColor")
                C22_Swatch(color: pressed, label: "mix(.black, by: 0.15)")
                C22_Swatch(color: raw, label: String(format: "red→blue by %.2f, .device", fraction))
            }
            Slider(value: $fraction, in: 0...1)
                .frame(width: 220)
        }
    }
}

private struct C22_Swatch: View {
    let color: Color
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            RoundedRectangle(cornerRadius: 8)
                .fill(color)
                .frame(width: 64, height: 44)
            Text(label)
                .font(.caption2)
                .foregroundStyle(.secondary)
                .frame(width: 96)
                .multilineTextAlignment(.center)
        }
    }
}

private struct C22_GradientColorSpaceExample: View {
    private let fractions: [Double] = [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            row(title: ".perceptual") { f in Color.yellow.mix(with: .blue, by: f, in: .perceptual) }
            row(title: ".device") { f in Color.yellow.mix(with: .blue, by: f, in: .device) }
            Text("Device math passes through a muddy gray at 0.5; perceptual stays vivid.")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }

    private func row(title: String, mix: (Double) -> Color) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title).font(.caption).monospaced()
            HStack(spacing: 2) {
                ForEach(fractions, id: \.self) { f in
                    Rectangle()
                        .fill(mix(f))
                        .frame(width: 26, height: 26)
                }
            }
        }
    }
}

// MARK: - ImagePaint

private enum C22_Tiles {
    /// A 32×32 tile drawn with GraphicsContext: an orange dot in the top-left
    /// quarter and a teal square in the bottom-right quarter.
    static func dots() -> Image {
        Image(size: CGSize(width: 32, height: 32)) { ctx in
            ctx.fill(Path(ellipseIn: CGRect(x: 4, y: 4, width: 8, height: 8)), with: .color(.orange))
            ctx.fill(Path(CGRect(x: 16, y: 16, width: 16, height: 16)), with: .color(.teal))
        }
    }
}

private struct C22_ImagePaintInitExample: View {
    var body: some View {
        let tile = C22_Tiles.dots()
        let texture = ImagePaint(
            image: tile,
            sourceRect: CGRect(x: 0, y: 0, width: 0.5, height: 0.5),
            scale: 0.75
        )
        HStack(spacing: 20) {
            VStack(spacing: 4) {
                tile
                    .resizable()
                    .interpolation(.none)
                    .frame(width: 48, height: 48)
                    .border(.quaternary)
                Text("tile").font(.caption2).foregroundStyle(.secondary)
            }
            VStack(spacing: 6) {
                Capsule()
                    .stroke(texture, lineWidth: 14)
                    .frame(width: 180, height: 60)
                Text("Only the top-left quarter (the dot) tiles the stroke")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

private struct C22_ImagePaintStaticExample: View {
    var body: some View {
        let tile = C22_Tiles.dots()
        VStack(spacing: 6) {
            RoundedRectangle(cornerRadius: 12)
                .fill(.image(tile, scale: 0.5))
                .frame(width: 200, height: 100)
            Text("Whole tile, repeated at half size")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - LinearGradient

private struct C22_LinearColorsExample: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(LinearGradient(
                colors: [.purple, .blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ))
            .frame(width: 200, height: 100)
    }
}

private struct C22_LinearGradientReuseExample: View {
    var body: some View {
        let brand = Gradient(colors: [.indigo, .pink])
        HStack(spacing: 16) {
            Rectangle()
                .fill(LinearGradient(gradient: brand, startPoint: .leading, endPoint: .trailing))
                .frame(width: 140, height: 80)
            Capsule()
                .fill(LinearGradient(gradient: brand, startPoint: .top, endPoint: .bottom))
                .frame(width: 60, height: 80)
        }
    }
}

private struct C22_LinearStopsExample: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 12)
                .fill(.mint.gradient)
                .overlay {
                    Image(systemName: "mountain.2.fill")
                        .font(.system(size: 56))
                        .foregroundStyle(.white.opacity(0.7))
                }
                .overlay {
                    LinearGradient(
                        stops: [
                            .init(color: .black, location: 0),
                            .init(color: .black.opacity(0), location: 0.4),
                        ],
                        startPoint: .bottom, endPoint: .top
                    )
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
            Text("Caption sits on the fade")
                .font(.caption.bold())
                .foregroundStyle(.white)
                .padding(10)
        }
        .frame(width: 220, height: 120)
    }
}

private struct C22_LinearShorthandExample: View {
    var body: some View {
        Text("Hello")
            .font(.largeTitle.bold())
            .foregroundStyle(.linearGradient(
                colors: [.orange, .red],
                startPoint: .top, endPoint: .bottom
            ))
    }
}

// MARK: - Material

/// A busy, colorful backdrop so each material's translucency is visible.
private struct C22_Backdrop: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.pink, .orange, .yellow, .mint, .blue],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
            Circle()
                .fill(.white.opacity(0.65))
                .frame(width: 70, height: 70)
                .offset(x: -60, y: -22)
            Circle()
                .fill(.purple.opacity(0.7))
                .frame(width: 90, height: 90)
                .offset(x: 55, y: 28)
        }
    }
}

private struct C22_MaterialUltraThinExample: View {
    var body: some View {
        ZStack {
            C22_Backdrop()
            Text("Now Playing · 3:42")
                .padding(8)
                .background(.ultraThinMaterial, in: .capsule)
        }
        .frame(width: 240, height: 120)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

private struct C22_MaterialRegularExample: View {
    @State private var shuffle = true
    @State private var volume = 0.6

    var body: some View {
        ZStack {
            C22_Backdrop()
            VStack(spacing: 8) {
                Toggle("Shuffle", isOn: $shuffle)
                Slider(value: $volume)
            }
            .padding()
            .background(.regularMaterial, in: .rect(cornerRadius: 16))
            .frame(width: 180)
        }
        .frame(width: 240, height: 140)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

private struct C22_MaterialUltraThickExample: View {
    @State private var showSheet = false

    var body: some View {
        ZStack {
            C22_Backdrop()
            VStack(spacing: 10) {
                Text("Sheet content")
                    .padding()
                    .background(.ultraThickMaterial, in: .rect(cornerRadius: 12))
                Button("Show Sheet") { showSheet = true }
            }
        }
        .frame(width: 240, height: 140)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .sheet(isPresented: $showSheet) {
            VStack(spacing: 12) {
                Text("Sheet content").font(.headline)
                Button("Done") { showSheet = false }
            }
            .padding(40)
            .presentationBackground(.ultraThickMaterial)
        }
    }
}

private struct C22_MaterialBarExample: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            C22_Backdrop()
            HStack(spacing: 28) {
                Image(systemName: "backward.fill")
                Image(systemName: "play.fill")
                Image(systemName: "forward.fill")
            }
            .font(.title3)
            .frame(maxWidth: .infinity)
            .padding()
            .background(.bar)
        }
        .frame(width: 240, height: 140)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - MeshGradient

private enum C22_Mesh {
    static let grid: [SIMD2<Float>] = [[0, 0], [1, 0], [0, 1], [1, 1]]
    static let palette: MeshGradient.Colors = .colors([.orange, .pink, .purple, .blue])

    /// Every edge bowed toward the middle, so the mesh reads as a rounded pillow
    /// with the `background` color showing around it.
    static let bezierGrid: [MeshGradient.BezierPoint] = [
        .init(position: [0, 0], leadingControlPoint: [0, 0], topControlPoint: [0, 0],
              trailingControlPoint: [0.4, 0.25], bottomControlPoint: [0.25, 0.4]),
        .init(position: [1, 0], leadingControlPoint: [0.6, 0.25], topControlPoint: [1, 0],
              trailingControlPoint: [1, 0], bottomControlPoint: [0.75, 0.4]),
        .init(position: [0, 1], leadingControlPoint: [0, 1], topControlPoint: [0.25, 0.6],
              trailingControlPoint: [0.4, 0.75], bottomControlPoint: [0, 1]),
        .init(position: [1, 1], leadingControlPoint: [0.6, 0.75], topControlPoint: [0.75, 0.6],
              trailingControlPoint: [1, 1], bottomControlPoint: [1, 1]),
    ]

    /// Three corners with straight handles, to pair with one custom corner.
    static let straightCorners: [MeshGradient.BezierPoint] = [
        .init(position: [1, 0], leadingControlPoint: [0.66, 0], topControlPoint: [1, 0],
              trailingControlPoint: [1, 0], bottomControlPoint: [1, 0.33]),
        .init(position: [0, 1], leadingControlPoint: [0, 1], topControlPoint: [0, 0.66],
              trailingControlPoint: [0.33, 1], bottomControlPoint: [0, 1]),
        .init(position: [1, 1], leadingControlPoint: [0.66, 1], topControlPoint: [1, 0.66],
              trailingControlPoint: [1, 1], bottomControlPoint: [1, 1]),
    ]
}

private struct C22_MeshPointsExample: View {
    @State private var smooth = true

    var body: some View {
        VStack(spacing: 10) {
            MeshGradient(
                width: 2, height: 2,
                points: [[0, 0], [1, 0], [0, 1], [1, 1]],
                colors: [.red, .orange, .purple, .blue],
                smoothsColors: smooth
            )
            .frame(width: 200, height: 110)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            Toggle("smoothsColors", isOn: $smooth)
                .toggleStyle(.switch)
                .controlSize(.small)
        }
    }
}

private struct C22_MeshLocationsExample: View {
    var body: some View {
        MeshGradient(
            width: 2, height: 2,
            locations: .points([[0, 0], [1, 0], [0, 1], [1, 1]]),
            colors: .colors([.mint, .teal, .indigo, .cyan]),
            background: .black,
            colorSpace: .perceptual
        )
        .frame(width: 200, height: 120)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

private struct C22_MeshLocationsEnumExample: View {
    var body: some View {
        let simple: MeshGradient.Locations = .points(C22_Mesh.grid)
        let curved: MeshGradient.Locations = .bezierPoints(C22_Mesh.bezierGrid)
        HStack(spacing: 16) {
            VStack(spacing: 4) {
                MeshGradient(width: 2, height: 2, locations: simple, colors: C22_Mesh.palette, background: .black)
                    .frame(width: 130, height: 110)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                Text(".points").font(.caption2).monospaced().foregroundStyle(.secondary)
            }
            VStack(spacing: 4) {
                MeshGradient(width: 2, height: 2, locations: curved, colors: C22_Mesh.palette, background: .black)
                    .frame(width: 130, height: 110)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                Text(".bezierPoints").font(.caption2).monospaced().foregroundStyle(.secondary)
            }
        }
    }
}

private struct C22_MeshBezierPointExample: View {
    var body: some View {
        let corner = MeshGradient.BezierPoint(
            position: [0, 0],
            leadingControlPoint: [0, 0],
            topControlPoint: [0, 0],
            trailingControlPoint: [0.35, 0.3],
            bottomControlPoint: [0.3, 0.35]
        )
        HStack(spacing: 16) {
            MeshGradient(
                width: 2, height: 2,
                locations: .bezierPoints([corner] + C22_Mesh.straightCorners),
                colors: C22_Mesh.palette,
                background: .black
            )
            .frame(width: 150, height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            Text("Only the top-left vertex has bent handles, so the two edges meeting there curve inward; the other three vertices keep straight handles.")
                .font(.caption2)
                .foregroundStyle(.secondary)
                .frame(width: 130)
        }
    }
}

// MARK: - RadialGradient

private struct C22_RadialColorsExample: View {
    var body: some View {
        Circle()
            .fill(RadialGradient(
                colors: [.yellow, .orange, .red],
                center: .center,
                startRadius: 5,
                endRadius: 60
            ))
            .frame(width: 130, height: 130)
    }
}

private struct C22_RadialGradientReuseExample: View {
    var body: some View {
        let glow = Gradient(colors: [.white, .clear])
        RoundedRectangle(cornerRadius: 12)
            .fill(.indigo)
            .overlay {
                RadialGradient(gradient: glow, center: .topLeading,
                               startRadius: 0, endRadius: 120)
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .frame(width: 220, height: 120)
    }
}

private struct C22_RadialStopsExample: View {
    var body: some View {
        Circle()
            .fill(RadialGradient(
                stops: [
                    .init(color: .white, location: 0),
                    .init(color: .white, location: 0.2),
                    .init(color: .blue, location: 0.25),
                ],
                center: .center, startRadius: 0, endRadius: 80
            ))
            .frame(width: 130, height: 130)
    }
}

private struct C22_RadialShorthandExample: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(.mint.gradient)
            .overlay {
                Image(systemName: "sun.max.fill")
                    .font(.system(size: 48))
                    .foregroundStyle(.yellow)
            }
            .overlay {
                Rectangle()
                    .fill(.radialGradient(
                        colors: [.black.opacity(0), .black.opacity(0.6)],
                        center: .center, startRadius: 40, endRadius: 140
                    ))
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .frame(width: 220, height: 120)
    }
}
