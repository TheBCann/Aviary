//
//  ChildExamples+Part10.swift
//  Aviary
//
//  Compiled renderings for variant entries (part 10: views).
//  One private C10_* struct per variant; every rendering exercises the exact
//  overload the variant names, so siblings can be compared side by side.
//

import SwiftUI
import PhotosUI
import UniformTypeIdentifiers

enum ChildExamplesPart10 {
    static let entries: [ChildExampleEntry] = [

        // MARK: KeyframeAnimator

        ChildExampleEntry(parent: "KeyframeAnimator", child: "CubicKeyframe(_:duration:startVelocity:endVelocity:)", code: """
        KeyframeAnimator(initialValue: Bounce(), repeating: true) { value in
            Circle().fill(.orange).frame(width: 36).offset(y: value.y)
        } keyframes: { _ in
            KeyframeTrack(\\.y) {
                CubicKeyframe(-50, duration: 0.35, startVelocity: 0)   // smooth launch
                CubicKeyframe(0, duration: 0.45, endVelocity: 0)       // settles instead of snapping
                CubicKeyframe(0, duration: 0.3)                        // rest
            }
        }
        """) { AnyView(C10_CubicKeyframeExample()) },

        // MARK: Label

        ChildExampleEntry(parent: "Label", child: "Label(_:systemImage:)", code: """
        Label("Favorites", systemImage: "star.fill")
        Label("Downloads", systemImage: "arrow.down.circle")
        Label("Favorites", systemImage: "star.fill")
            .labelStyle(.iconOnly)
        """) { AnyView(C10_LabelSystemImageExample()) },

        ChildExampleEntry(parent: "Label", child: "Label(_:image:)", code: """
        Label("Teams", image: "team-badge")   // "team-badge" is an asset-catalog image
        """) { AnyView(C10_LabelImageExample()) },

        ChildExampleEntry(parent: "Label", child: "Label(title:icon:)", code: """
        Label {
            VStack(alignment: .leading) {
                Text("Storage").font(.headline)
                Text("128 GB used of 512 GB").font(.caption).foregroundStyle(.secondary)
            }
        } icon: {
            Image(systemName: "externaldrive")
                .font(.title)
                .foregroundStyle(.tint)
        }
        """) { AnyView(C10_LabelTitleIconExample()) },

        // MARK: LabeledContent

        ChildExampleEntry(parent: "LabeledContent", child: "LabeledContent(_:value:)", code: """
        Form {
            LabeledContent("Build", value: "1024")
            LabeledContent("Channel", value: "Beta")
            LabeledContent("Region", value: "eu-west-1")
        }
        """) { AnyView(C10_LabeledContentValueExample()) },

        ChildExampleEntry(parent: "LabeledContent", child: "LabeledContent(_:value:format:)", code: """
        LabeledContent("Distance", value: meters, format: .number.precision(.fractionLength(1)))
        LabeledContent("Updated", value: lastSync, format: .dateTime.hour().minute())
        LabeledContent("Battery", value: charge, format: .percent)
        """) { AnyView(C10_LabeledContentFormatExample()) },

        ChildExampleEntry(parent: "LabeledContent", child: "LabeledContent(_:content:)", code: """
        LabeledContent("Status") {
            Label("Online", systemImage: "circle.fill")
                .foregroundStyle(.green)
        }
        LabeledContent("Volume") {
            Slider(value: $volume, in: 0...1)
        }
        """) { AnyView(C10_LabeledContentContentExample()) },

        ChildExampleEntry(parent: "LabeledContent", child: "LabeledContent(content:label:)", code: """
        Form {
            LabeledContent {
                Text("@aviary")
            } label: {
                Text("Handle")
                Text("Visible on your public profile")   // extra Text → secondary subtitle
            }
        }
        """) { AnyView(C10_LabeledContentBuildersExample()) },

        // MARK: LazyHGrid

        ChildExampleEntry(parent: "LazyHGrid", child: "LazyHGrid(rows:alignment:spacing:pinnedViews:content:)", code: """
        let rows = [GridItem(.fixed(40)), GridItem(.fixed(40))]

        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, alignment: .top, spacing: 12, pinnedViews: [.sectionHeaders]) {
                Section {
                    ForEach(0..<14, id: \\.self) { i in Thumbnail(index: i) }
                } header: {
                    Text("Recent").bold().padding(.horizontal, 8).background(.bar)
                }
            }
        }
        """) { AnyView(C10_LazyHGridExample()) },

        ChildExampleEntry(parent: "LazyHGrid", child: "GridItem.Size", code: """
        let rows = [
            GridItem(.fixed(60)),                            // always 60 pt tall
            GridItem(.flexible(minimum: 40)),                // shares the leftover height
            GridItem(.adaptive(minimum: 30, maximum: 60))    // as many rows as fit
        ]
        LazyHGrid(rows: rows, spacing: 6) { ForEach(0..<18, id: \\.self) { i in Cell(i) } }
        """) { AnyView(C10_LazyHGridSizeExample()) },

        // MARK: LazyVGrid

        ChildExampleEntry(parent: "LazyVGrid", child: "LazyVGrid(columns:alignment:spacing:pinnedViews:content:)", code: """
        let columns = [GridItem(.adaptive(minimum: 44))]

        ScrollView {
            LazyVGrid(columns: columns, alignment: .leading, spacing: 16, pinnedViews: [.sectionHeaders]) {
                Section {
                    ForEach(favorites) { PhotoCell($0) }
                } header: {
                    Text("Favorites").bold()
                }
            }
        }
        """) { AnyView(C10_LazyVGridExample()) },

        ChildExampleEntry(parent: "LazyVGrid", child: "GridItem(_:spacing:alignment:)", code: """
        let columns = [
            GridItem(.fixed(80), spacing: 4, alignment: .top),       // 4 pt gap after this column
            GridItem(.flexible(), spacing: 24, alignment: .center),  // 24 pt gap after this one
            GridItem(.flexible(), alignment: .bottom)
        ]
        LazyVGrid(columns: columns, spacing: 8) { ForEach(cells) { Cell($0) } }
        """) { AnyView(C10_GridItemInitExample()) },

        ChildExampleEntry(parent: "LazyVGrid", child: "GridItem.Size", code: """
        LazyVGrid(columns: [GridItem(.fixed(100)), GridItem(.fixed(100))]) { … }        // exact width
        LazyVGrid(columns: [GridItem(.flexible(minimum: 60)), GridItem(.flexible())]) { … }   // share leftover
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))]) { … }                    // as many as fit
        """) { AnyView(C10_LazyVGridSizeExample()) },

        ChildExampleEntry(parent: "LazyVGrid", child: "PinnedScrollableViews", code: """
        ScrollView {
            LazyVGrid(columns: columns, pinnedViews: [.sectionHeaders, .sectionFooters]) {
                ForEach(albums) { album in
                    Section {
                        ForEach(album.photos) { PhotoCell($0) }
                    } header: { Text(album.title).bold() }
                      footer: { Text("\\(album.photos.count) photos") }
                }
            }
        }
        """) { AnyView(C10_PinnedViewsExample()) },

        // MARK: LazyVStack

        ChildExampleEntry(parent: "LazyVStack", child: "LazyVStack(alignment:spacing:pinnedViews:content:)", code: """
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 4, pinnedViews: [.sectionHeaders]) {
                ForEach(days) { day in
                    Section {
                        ForEach(day.events) { EventRow($0) }
                    } header: {
                        Text(day.title).bold().padding(6).background(.bar)
                    }
                }
            }
        }
        """) { AnyView(C10_LazyVStackExample()) },

        ChildExampleEntry(parent: "LazyVStack", child: "PinnedScrollableViews.sectionHeaders", code: """
        LazyVStack(pinnedViews: [.sectionHeaders]) {
            Section {
                ForEach(messages) { MessageRow($0) }
            } header: {
                Text("Today").padding(8).frame(maxWidth: .infinity, alignment: .leading).background(.bar)
            }
        }
        """) { AnyView(C10_SectionHeadersPinnedExample()) },

        // MARK: Link

        ChildExampleEntry(parent: "Link", child: "Link(_:destination:)", code: """
        Link("Privacy Policy", destination: URL(string: "https://example.com/privacy")!)
            .font(.footnote)
        """) { AnyView(C10_LinkTitleExample()) },

        ChildExampleEntry(parent: "Link", child: "Link(destination:label:)", code: """
        Link(destination: URL(string: "https://example.com/terms")!) {
            Label("Terms of Service", systemImage: "doc.text")
        }
        """) { AnyView(C10_LinkLabelExample()) },

        // MARK: List

        ChildExampleEntry(parent: "List", child: "List(_:rowContent:)", code: """
        List(oceans) { ocean in          // oceans: [Ocean], Ocean: Identifiable
            Label(ocean.name, systemImage: "water.waves")
        }
        """) { AnyView(C10_ListRowContentExample()) },

        ChildExampleEntry(parent: "List", child: "List(selection:content:)", code: """
        @State private var selection = Set<Ocean.ID>()

        List(selection: $selection) {
            ForEach(oceans) { Text($0.name) }
        }
        Text("\\(selection.count) selected")
        """) { AnyView(C10_ListSelectionExample()) },

        ChildExampleEntry(parent: "List", child: "List(_:children:rowContent:)", code: """
        struct FileItem: Identifiable {
            let id = UUID()
            let name: String
            var children: [FileItem]?      // nil → leaf, [] → empty folder
        }

        List(fileTree, children: \\.children) { item in
            Label(item.name, systemImage: item.children == nil ? "doc" : "folder")
        }
        """) { AnyView(C10_ListChildrenExample()) },

        // MARK: Map

        ChildExampleEntry(parent: "Map", child: "Map(initialPosition:content:)", code: """
        Map(initialPosition: .region(campus)) {   // sets the opening frame, then the user roams
            Marker("Library", coordinate: library)
        }
        """) { AnyView(C10_MapInitialPositionExample()) },

        ChildExampleEntry(parent: "Map", child: "Map(position:content:)", code: """
        @State private var position: MapCameraPosition = .automatic

        Map(position: $position) {               // updates as the user pans; assign to steer
            UserAnnotation()
        }
        Button("Go to Library") { position = .region(libraryRegion) }
        """) { AnyView(C10_MapPositionExample()) },

        // MARK: Menu

        ChildExampleEntry(parent: "Menu", child: "Menu(_:content:)", code: """
        Menu("Options") {
            Button("Rename") { rename() }
            Button("Duplicate") { duplicate() }
            Divider()
            Button("Delete", role: .destructive) { delete() }
        }
        """) { AnyView(C10_MenuTitleExample()) },

        ChildExampleEntry(parent: "Menu", child: "Menu(content:label:)", code: """
        Menu {
            Picker("Sort by", selection: $sortKey) {
                ForEach(SortKey.allCases) { Text($0.title) }
            }
        } label: {
            Image(systemName: "ellipsis.circle")
        }
        """) { AnyView(C10_MenuLabelExample()) },

        ChildExampleEntry(parent: "Menu", child: "Menu(_:content:primaryAction:)", code: """
        Menu("Bookmark") {
            Button("Bookmark All Tabs") { bookmarkAll() }
        } primaryAction: {
            bookmarkCurrent()      // a plain click; the chevron (or a long press) opens the menu
        }
        """) { AnyView(C10_MenuPrimaryActionExample()) },

        // MARK: MultiDatePicker

        ChildExampleEntry(parent: "MultiDatePicker", child: "MultiDatePicker(_:selection:)", code: """
        @State private var daysOff: Set<DateComponents> = []

        MultiDatePicker("Days off", selection: $daysOff)
        """) { AnyView(C10_MultiDatePickerExample()) },

        ChildExampleEntry(parent: "MultiDatePicker", child: "MultiDatePicker(_:selection:in:)", code: """
        let month = Calendar.current.dateInterval(of: .month, for: .now)!

        MultiDatePicker("Shifts", selection: $shifts, in: month.start..<month.end)
        """) { AnyView(C10_MultiDatePickerRangeExample()) },

        ChildExampleEntry(parent: "MultiDatePicker", child: "MultiDatePicker(selection:label:)", code: """
        MultiDatePicker(selection: $blackoutDates) {
            Label("Blackout dates", systemImage: "calendar.badge.minus")
        }
        """) { AnyView(C10_MultiDatePickerLabelExample()) },

        // MARK: NavigationLink

        ChildExampleEntry(parent: "NavigationLink", child: "NavigationLink(value:label:)", code: """
        NavigationStack {
            List(recipes) { recipe in
                NavigationLink(value: recipe) {
                    Label(recipe.title, systemImage: "fork.knife")
                }
            }
            .navigationDestination(for: Recipe.self) { RecipeDetail($0) }
        }
        """) { AnyView(C10_NavigationLinkValueExample()) },

        ChildExampleEntry(parent: "NavigationLink", child: "NavigationLink(_:value:)", code: """
        NavigationStack {
            List {
                NavigationLink("Statistics", value: Route.stats)
                NavigationLink("Settings", value: Route.settings)
            }
            .navigationDestination(for: Route.self) { RouteView($0) }
        }
        """) { AnyView(C10_NavigationLinkTitleValueExample()) },

        ChildExampleEntry(parent: "NavigationLink", child: "NavigationLink(destination:label:)", code: """
        NavigationStack {
            List {
                NavigationLink {
                    AboutView()                       // built right here — no value type involved
                } label: {
                    Label("About", systemImage: "info.circle")
                }
            }
        }
        """) { AnyView(C10_NavigationLinkDestinationExample()) },

        // MARK: NavigationSplitView

        ChildExampleEntry(parent: "NavigationSplitView", child: "NavigationSplitView(sidebar:detail:)", code: """
        NavigationSplitView {
            List(mailboxes, selection: $mailbox) { Text($0.name) }
        } detail: {
            MailboxView(mailbox)
        }
        """) { AnyView(C10_SplitViewTwoColumnExample()) },

        ChildExampleEntry(parent: "NavigationSplitView", child: "NavigationSplitView(sidebar:content:detail:)", code: """
        NavigationSplitView {
            List(mailboxes, selection: $mailbox) { Text($0.name) }
        } content: {
            List(messages, id: \\.self, selection: $message) { Text($0) }
        } detail: {
            Text(message ?? "Select a message")
        }
        """) { AnyView(C10_SplitViewThreeColumnExample()) },

        ChildExampleEntry(parent: "NavigationSplitView", child: "NavigationSplitView(columnVisibility:sidebar:detail:)", code: """
        @State private var columns: NavigationSplitViewVisibility = .doubleColumn

        NavigationSplitView(columnVisibility: $columns) {
            Sidebar()
        } detail: {
            Detail()
        }
        Button("Hide Sidebar") { columns = .detailOnly }
        """) { AnyView(C10_SplitViewVisibilityExample()) },

        ChildExampleEntry(parent: "NavigationSplitView", child: "NavigationSplitView(columnVisibility:preferredCompactColumn:sidebar:content:detail:)", code: """
        @State private var visibility: NavigationSplitViewVisibility = .all
        @State private var compactColumn: NavigationSplitViewColumn = .detail

        NavigationSplitView(columnVisibility: $visibility, preferredCompactColumn: $compactColumn) {
            Sidebar()
        } content: { ItemList() } detail: { Detail() }
        """) { AnyView(C10_SplitViewCompactColumnExample()) },

        // MARK: NavigationStack

        ChildExampleEntry(parent: "NavigationStack", child: "NavigationStack(root:)", code: """
        NavigationStack {                              // manages its own path
            List(routes, id: \\.self) { route in
                NavigationLink(route.title, value: route)
            }
            .navigationDestination(for: Route.self) { RouteView($0) }
        }
        """) { AnyView(C10_NavigationStackRootExample()) },

        ChildExampleEntry(parent: "NavigationStack", child: "NavigationStack(path:root:)", code: """
        @State private var path: [Route] = []

        NavigationStack(path: $path) {
            RootView()
                .navigationDestination(for: Route.self) { RouteView($0) }
        }
        Button("Show Settings") { path.append(.settings) }
        Button("Pop to root") { path.removeAll() }
        """) { AnyView(C10_NavigationStackPathExample()) },

        ChildExampleEntry(parent: "NavigationStack", child: "NavigationPath", code: """
        @State private var path = NavigationPath()          // type-erased: mixes value types

        Button("Deep link") {
            path.append(Folder.inbox)
            path.append(Message.latest)
        }
        Button("Pop to root") { path.removeLast(path.count) }
        Text("Depth: \\(path.count)")
        """) { AnyView(C10_NavigationPathExample()) },

        // MARK: OutlineGroup

        ChildExampleEntry(parent: "OutlineGroup", child: "OutlineGroup(_:children:content:)", code: """
        List {
            OutlineGroup(fileTree, children: \\.children) { node in
                Label(node.name, systemImage: node.children == nil ? "doc" : "folder")
            }
        }
        """) { AnyView(C10_OutlineGroupExample()) },

        ChildExampleEntry(parent: "OutlineGroup", child: "OutlineGroup(_:id:children:content:)", code: """
        struct Chapter { let title: String; var subsections: [Chapter]? }   // not Identifiable

        List {
            OutlineGroup(chapters, id: \\.title, children: \\.subsections) { chapter in
                Text(chapter.title)
            }
        }
        """) { AnyView(C10_OutlineGroupIDExample()) },

        // MARK: PasteButton

        ChildExampleEntry(parent: "PasteButton", child: "PasteButton(payloadType:onPaste:)", code: """
        PasteButton(payloadType: String.self) { strings in     // decoded Transferable values
            notes.append(contentsOf: strings)
        }
        """) { AnyView(C10_PasteButtonPayloadExample()) },

        ChildExampleEntry(parent: "PasteButton", child: "PasteButton(supportedContentTypes:payloadAction:)", code: """
        PasteButton(supportedContentTypes: [.plainText, .url]) { providers in   // raw NSItemProviders
            received = providers.map { $0.registeredTypeIdentifiers.first ?? "?" }
        }
        """) { AnyView(C10_PasteButtonContentTypesExample()) },

        // MARK: PhaseAnimator

        ChildExampleEntry(parent: "PhaseAnimator", child: "PhaseAnimator(_:content:animation:)", code: """
        PhaseAnimator([0.4, 1.0]) { opacity in           // no trigger → loops forever
            Circle()
                .fill(.red)
                .opacity(opacity)
        } animation: { _ in
            .easeInOut(duration: 0.8)
        }
        """) { AnyView(C10_PhaseAnimatorLoopExample()) },

        ChildExampleEntry(parent: "PhaseAnimator", child: "PhaseAnimator(_:trigger:content:animation:)", code: """
        PhaseAnimator([0, -8, 8, 0], trigger: failedAttempts) { offset in   // one pass per change
            SecureField("Password", text: $password)
                .offset(x: offset)
        } animation: { _ in
            .easeInOut(duration: 0.08)
        }
        """) { AnyView(C10_PhaseAnimatorTriggerExample()) },

        // MARK: PhotosPicker

        ChildExampleEntry(parent: "PhotosPicker", child: "PhotosPicker(selection:matching:label:)", code: """
        @State private var picked: PhotosPickerItem?

        PhotosPicker(selection: $picked, matching: .images) {
            Label("Choose Photo", systemImage: "photo")
        }
        """) { AnyView(C10_PhotosPickerSingleExample()) },

        ChildExampleEntry(parent: "PhotosPicker", child: "PhotosPicker(selection:maxSelectionCount:matching:label:)", code: """
        @State private var items: [PhotosPickerItem] = []

        PhotosPicker(selection: $items, maxSelectionCount: 4, matching: .images) {
            Label("Add up to 4", systemImage: "photo.stack")
        }
        """) { AnyView(C10_PhotosPickerMultiExample()) },

        // MARK: Picker

        ChildExampleEntry(parent: "Picker", child: "Picker(_:selection:content:)", code: """
        Picker("Priority", selection: $priority) {
            Text("Low").tag(Priority.low)
            Text("Medium").tag(Priority.medium)
            Text("High").tag(Priority.high)
        }
        """) { AnyView(C10_PickerTitleExample()) },

        ChildExampleEntry(parent: "Picker", child: "Picker(_:systemImage:selection:content:)", code: """
        Picker("Layout", systemImage: "square.grid.2x2", selection: $layout) {
            ForEach(Layout.allCases) { Text($0.title) }
        }
        """) { AnyView(C10_PickerSystemImageExample()) },

        ChildExampleEntry(parent: "Picker", child: "Picker(selection:content:label:)", code: """
        Picker(selection: $theme) {
            ForEach(Theme.allCases) { Text($0.name) }
        } label: {
            Label("Theme", systemImage: "paintpalette")
        }
        """) { AnyView(C10_PickerLabelExample()) },

        // MARK: ProductView

        ChildExampleEntry(parent: "ProductView", child: "ProductView(id:prefersPromotionalIcon:)", code: """
        ProductView(id: "com.example.pro.yearly", prefersPromotionalIcon: true)
            .productViewStyle(.large)
        """) { AnyView(C10_ProductViewIDExample()) },

        ChildExampleEntry(parent: "ProductView", child: "ProductView(id:prefersPromotionalIcon:icon:)", code: """
        ProductView(id: "com.example.tipjar.small", prefersPromotionalIcon: false) {
            Image(systemName: "cup.and.saucer.fill")
                .font(.largeTitle)
                .foregroundStyle(.brown)
        }
        """) { AnyView(C10_ProductViewIconExample()) },

        ChildExampleEntry(parent: "ProductView", child: "ProductView(_:prefersPromotionalIcon:)", code: """
        let products = try await Product.products(for: ids)   // already fetched

        ForEach(products) { product in
            ProductView(product, prefersPromotionalIcon: false)
                .productViewStyle(.compact)
        }
        """) { AnyView(C10_ProductViewProductExample()) },

        // MARK: ProgressView

        ChildExampleEntry(parent: "ProgressView", child: "ProgressView()", code: """
        ProgressView()                    // indeterminate spinner
            .controlSize(.small)
        ProgressView()
        ProgressView()
            .controlSize(.large)
        """) { AnyView(C10_ProgressViewIndeterminateExample()) },

        ChildExampleEntry(parent: "ProgressView", child: "ProgressView(value:total:)", code: """
        ProgressView(value: bytesReceived, total: bytesExpected)
            .progressViewStyle(.linear)
        ProgressView(value: bytesReceived, total: bytesExpected)
            .progressViewStyle(.circular)
        """) { AnyView(C10_ProgressViewValueExample()) },

        ChildExampleEntry(parent: "ProgressView", child: "ProgressView(timerInterval:countsDown:)", code: """
        let interval = Date.now...Date.now.addingTimeInterval(60)

        ProgressView(timerInterval: interval, countsDown: true)     // drains
        ProgressView(timerInterval: interval, countsDown: false)    // fills
        """) { AnyView(C10_ProgressViewTimerExample()) },

        // MARK: SceneView

        ChildExampleEntry(parent: "SceneView", child: "SceneView(scene:pointOfView:options:)", code: """
        SceneView(
            scene: spaceScene,                 // an SCNScene
            pointOfView: chaseCamera,          // SCNNode carrying a camera; nil → the scene's own
            options: [.rendersContinuously]
        )
        """) { AnyView(C10_SceneViewExample()) },

        ChildExampleEntry(parent: "SceneView", child: "SceneView.Options", code: """
        SceneView(
            scene: modelScene,
            options: [.allowsCameraControl, .autoenablesDefaultLighting]
        )
        """) { AnyView(C10_SceneViewOptionsExample()) },

        // MARK: ScrollView

        ChildExampleEntry(parent: "ScrollView", child: "ScrollView(_:content:)", code: """
        ScrollView([.horizontal, .vertical]) {      // both axes; the default is .vertical
            LargeDiagram()
        }
        .scrollIndicators(.hidden)
        """) { AnyView(C10_ScrollViewAxesExample()) },
    ]
}

// MARK: - KeyframeAnimator

private struct C10_Bounce {
    var y: CGFloat = 0
}

private struct C10_CubicKeyframeExample: View {
    var body: some View {
        VStack(spacing: 8) {
            KeyframeAnimator(initialValue: C10_Bounce(), repeating: true) { value in
                Circle()
                    .fill(.orange)
                    .frame(width: 36, height: 36)
                    .offset(y: value.y)
            } keyframes: { _ in
                KeyframeTrack(\.y) {
                    CubicKeyframe(-50, duration: 0.35, startVelocity: 0)
                    CubicKeyframe(0, duration: 0.45, endVelocity: 0)
                    CubicKeyframe(0, duration: 0.3)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 100, alignment: .bottom)
            Text("Cubic keyframes ease between targets; endVelocity: 0 makes the landing settle instead of snapping")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - Label

private struct C10_LabelSystemImageExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Favorites", systemImage: "star.fill")
            Label("Downloads", systemImage: "arrow.down.circle")
            HStack(spacing: 6) {
                Label("Favorites", systemImage: "star.fill")
                    .labelStyle(.iconOnly)
                Text("← .labelStyle(.iconOnly) keeps just the symbol")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .font(.title3)
    }
}

private struct C10_LabelImageExample: View {
    var body: some View {
        VStack(spacing: 10) {
            Label {
                Text("Teams")
            } icon: {
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.indigo.gradient)
                    Image(systemName: "person.3.fill")
                        .font(.system(size: 9))
                        .foregroundStyle(.white)
                }
                .frame(width: 20, height: 20)
            }
            .font(.title3)
            Text("Illustrative — \"team-badge\" is loaded from the asset catalog by name")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C10_LabelTitleIconExample: View {
    var body: some View {
        Label {
            VStack(alignment: .leading, spacing: 2) {
                Text("Storage")
                    .font(.headline)
                Text("128 GB used of 512 GB")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        } icon: {
            Image(systemName: "externaldrive")
                .font(.title)
                .foregroundStyle(.tint)
        }
    }
}

// MARK: - LabeledContent

private struct C10_LabeledContentValueExample: View {
    var body: some View {
        Form {
            LabeledContent("Build", value: "1024")
            LabeledContent("Channel", value: "Beta")
            LabeledContent("Region", value: "eu-west-1")
        }
        .formStyle(.grouped)
        .frame(height: 150)
    }
}

private struct C10_LabeledContentFormatExample: View {
    private let meters: Double = 1234.56
    private let charge: Double = 0.82
    private let lastSync = Date.now.addingTimeInterval(-1800)
    var body: some View {
        Form {
            LabeledContent("Distance", value: meters, format: .number.precision(.fractionLength(1)))
            LabeledContent("Updated", value: lastSync, format: .dateTime.hour().minute())
            LabeledContent("Battery", value: charge, format: .percent)
        }
        .formStyle(.grouped)
        .frame(height: 150)
    }
}

private struct C10_LabeledContentContentExample: View {
    @State private var volume = 0.6
    var body: some View {
        Form {
            LabeledContent("Status") {
                Label("Online", systemImage: "circle.fill")
                    .foregroundStyle(.green)
            }
            LabeledContent("Volume") {
                Slider(value: $volume, in: 0...1)
                    .frame(width: 140)
            }
        }
        .formStyle(.grouped)
        .frame(height: 130)
    }
}

private struct C10_LabeledContentBuildersExample: View {
    var body: some View {
        Form {
            LabeledContent {
                Text("@aviary")
            } label: {
                Text("Handle")
                Text("Visible on your public profile")
            }
            LabeledContent {
                Text("Pro")
            } label: {
                Text("Plan")
                Text("Renews 12 Oct")
            }
        }
        .formStyle(.grouped)
        .frame(height: 150)
    }
}

// MARK: - LazyHGrid

private struct C10_LazyHGridExample: View {
    private let rows = [GridItem(.fixed(40)), GridItem(.fixed(40))]
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, alignment: .top, spacing: 12, pinnedViews: [.sectionHeaders]) {
                Section {
                    ForEach(0..<14, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(hue: Double(i) / 14, saturation: 0.55, brightness: 0.9))
                            .frame(width: 40)
                            .overlay(Text("\(i)").font(.caption2).foregroundStyle(.white))
                    }
                } header: {
                    Text("Recent")
                        .bold()
                        .padding(.horizontal, 8)
                        .frame(maxHeight: .infinity)
                        .background(.bar)
                }
            }
        }
        .frame(height: 100)
    }
}

private struct C10_LazyHGridSizeExample: View {
    private let rows = [
        GridItem(.fixed(60)),
        GridItem(.flexible(minimum: 40)),
        GridItem(.adaptive(minimum: 30, maximum: 60))
    ]
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: 6) {
                    ForEach(0..<18, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.teal.opacity(0.7))
                            .frame(width: 34)
                    }
                }
            }
            .frame(height: 170)
            Text("Row 1 .fixed(60) · row 2 .flexible(minimum: 40) · .adaptive(minimum: 30, maximum: 60) fills the rest with as many rows as fit")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - LazyVGrid

private struct C10_LazyVGridExample: View {
    private let columns = [GridItem(.adaptive(minimum: 44))]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .leading, spacing: 16, pinnedViews: [.sectionHeaders]) {
                Section {
                    ForEach(0..<16, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(hue: Double(i) / 16, saturation: 0.5, brightness: 0.9))
                            .frame(height: 44)
                    }
                } header: {
                    Text("Favorites")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(6)
                        .background(.bar)
                }
            }
        }
        .frame(height: 180)
    }
}

private struct C10_GridItemInitExample: View {
    private let columns = [
        GridItem(.fixed(80), spacing: 4, alignment: .top),
        GridItem(.flexible(), spacing: 24, alignment: .center),
        GridItem(.flexible(), alignment: .bottom)
    ]
    private let palette: [Color] = [.orange, .teal, .purple]
    var body: some View {
        VStack(spacing: 6) {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(0..<6, id: \.self) { i in
                    RoundedRectangle(cornerRadius: 6)
                        .fill(palette[i % 3])
                        .frame(width: i % 3 == 0 ? 80 : 50, height: i % 3 == 0 ? 44 : 22)
                }
            }
            Text("fixed(80) top-aligned · 4 pt gap · flexible centered · 24 pt gap · flexible bottom-aligned")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C10_SizeRow: View {
    let label: String
    let columns: [GridItem]
    let count: Int
    let color: Color
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(label).font(.caption.monospaced()).foregroundStyle(.secondary)
            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(0..<count, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 5).fill(color.opacity(0.75)).frame(height: 22)
                }
            }
        }
    }
}

private struct C10_LazyVGridSizeExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            C10_SizeRow(label: ".fixed(100)", columns: [GridItem(.fixed(100)), GridItem(.fixed(100))], count: 4, color: .orange)
            C10_SizeRow(label: ".flexible(minimum: 60)", columns: [GridItem(.flexible(minimum: 60)), GridItem(.flexible())], count: 4, color: .teal)
            C10_SizeRow(label: ".adaptive(minimum: 50)", columns: [GridItem(.adaptive(minimum: 50))], count: 8, color: .purple)
        }
    }
}

private struct C10_Album: Identifiable {
    let title: String
    let count: Int
    var id: String { title }
}

private struct C10_PinnedViewsExample: View {
    private let columns = [GridItem(.adaptive(minimum: 40))]
    private let albums = [C10_Album(title: "Holiday", count: 9), C10_Album(title: "Pets", count: 7), C10_Album(title: "Work", count: 8)]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 6, pinnedViews: [.sectionHeaders, .sectionFooters]) {
                ForEach(albums) { album in
                    Section {
                        ForEach(0..<album.count, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 6).fill(Color.mint.opacity(0.7)).frame(height: 40)
                        }
                    } header: {
                        Text(album.title).bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(6)
                            .background(.bar)
                    } footer: {
                        Text("\(album.count) photos").font(.caption).foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(4)
                            .background(.bar)
                    }
                }
            }
        }
        .frame(height: 190)
    }
}

// MARK: - LazyVStack

private struct C10_Day: Identifiable {
    let title: String
    let events: [String]
    var id: String { title }
}

private struct C10_LazyVStackExample: View {
    private let days = [
        C10_Day(title: "Monday", events: ["Standup", "Design review", "1:1"]),
        C10_Day(title: "Tuesday", events: ["Planning", "Lunch & learn", "Retro"]),
        C10_Day(title: "Wednesday", events: ["Deep work", "Demo"])
    ]
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 4, pinnedViews: [.sectionHeaders]) {
                ForEach(days) { day in
                    Section {
                        ForEach(day.events, id: \.self) { event in
                            Label(event, systemImage: "calendar").padding(.leading, 8)
                        }
                    } header: {
                        Text(day.title).bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(6)
                            .background(.bar)
                    }
                }
            }
        }
        .frame(height: 170)
    }
}

private struct C10_SectionHeadersPinnedExample: View {
    var body: some View {
        ScrollView {
            LazyVStack(pinnedViews: [.sectionHeaders]) {
                Section {
                    ForEach(1...8, id: \.self) { i in
                        HStack {
                            Circle().fill(Color.blue.opacity(0.6)).frame(width: 18, height: 18)
                            Text("Message \(i)")
                            Spacer()
                        }
                        .padding(.horizontal, 8)
                    }
                } header: {
                    Text("Today")
                        .padding(8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.bar)
                }
                Section {
                    ForEach(1...6, id: \.self) { i in
                        HStack {
                            Circle().fill(Color.gray.opacity(0.5)).frame(width: 18, height: 18)
                            Text("Older \(i)")
                            Spacer()
                        }
                        .padding(.horizontal, 8)
                    }
                } header: {
                    Text("Yesterday")
                        .padding(8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.bar)
                }
            }
        }
        .frame(height: 170)
    }
}

// MARK: - Link

private struct C10_LinkTitleExample: View {
    private let privacyURL = URL(string: "https://example.com/privacy")!
    var body: some View {
        VStack(spacing: 10) {
            Link("Privacy Policy", destination: privacyURL)
                .font(.footnote)
            Text("Opens in the default browser")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C10_LinkLabelExample: View {
    private let termsURL = URL(string: "https://example.com/terms")!
    var body: some View {
        Link(destination: termsURL) {
            Label("Terms of Service", systemImage: "doc.text")
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.accentColor.opacity(0.15), in: Capsule())
        }
    }
}

// MARK: - List

private struct C10_Ocean: Identifiable, Hashable {
    let id = UUID()
    let name: String
    static let all = ["Pacific", "Atlantic", "Indian", "Southern", "Arctic"].map { C10_Ocean(name: $0) }
}

private struct C10_ListRowContentExample: View {
    var body: some View {
        List(C10_Ocean.all) { ocean in
            Label(ocean.name, systemImage: "water.waves")
        }
        .frame(height: 170)
    }
}

private struct C10_ListSelectionExample: View {
    @State private var selection = Set<C10_Ocean.ID>()
    var body: some View {
        VStack(spacing: 6) {
            List(selection: $selection) {
                ForEach(C10_Ocean.all) { Text($0.name) }
            }
            .frame(height: 150)
            Text("\(selection.count) selected — ⌘-click or ⇧-click for multi-select")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C10_FileItem: Identifiable {
    let id = UUID()
    let name: String
    var children: [C10_FileItem]?
}

private struct C10_ListChildrenExample: View {
    private let tree = [
        C10_FileItem(name: "Sources", children: [
            C10_FileItem(name: "App.swift", children: nil),
            C10_FileItem(name: "Views", children: [
                C10_FileItem(name: "ContentView.swift", children: nil),
                C10_FileItem(name: "Sidebar.swift", children: nil)
            ])
        ]),
        C10_FileItem(name: "Tests", children: []),
        C10_FileItem(name: "README.md", children: nil)
    ]
    var body: some View {
        List(tree, children: \.children) { item in
            Label(item.name, systemImage: item.children == nil ? "doc" : "folder")
        }
        .frame(height: 190)
    }
}

// MARK: - Map (illustrative: MapKit tiles load at runtime)

private struct C10_MapMock: View {
    var pin: CGPoint
    var pinTitle: String
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(
                        colors: [Color(red: 0.86, green: 0.93, blue: 0.84), Color(red: 0.80, green: 0.89, blue: 0.95)],
                        startPoint: .topLeading, endPoint: .bottomTrailing))
                Path { p in
                    p.move(to: CGPoint(x: 0, y: geo.size.height * 0.35))
                    p.addLine(to: CGPoint(x: geo.size.width, y: geo.size.height * 0.55))
                    p.move(to: CGPoint(x: geo.size.width * 0.3, y: 0))
                    p.addLine(to: CGPoint(x: geo.size.width * 0.45, y: geo.size.height))
                    p.move(to: CGPoint(x: geo.size.width * 0.7, y: 0))
                    p.addLine(to: CGPoint(x: geo.size.width * 0.8, y: geo.size.height))
                }
                .stroke(.white, lineWidth: 5)
                VStack(spacing: 2) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.title)
                        .foregroundStyle(.white, .red)
                    Text(pinTitle).font(.caption2).bold()
                }
                .position(x: geo.size.width * pin.x, y: geo.size.height * pin.y)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

private struct C10_MapInitialPositionExample: View {
    var body: some View {
        VStack(spacing: 6) {
            C10_MapMock(pin: CGPoint(x: 0.55, y: 0.45), pinTitle: "Library")
                .frame(height: 140)
            Text("Illustrative — Map renders live MapKit tiles at runtime; initialPosition only sets the opening frame")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

private struct C10_MapPositionExample: View {
    @State private var pin = CGPoint(x: 0.5, y: 0.5)
    @State private var place = "You are here"
    var body: some View {
        VStack(spacing: 6) {
            C10_MapMock(pin: pin, pinTitle: place)
                .frame(height: 120)
                .animation(.easeInOut, value: pin)
            HStack {
                Button("Go to Library") { pin = CGPoint(x: 0.25, y: 0.35); place = "Library" }
                Button("Go to Café") { pin = CGPoint(x: 0.75, y: 0.6); place = "Café" }
                Button("Reset") { pin = CGPoint(x: 0.5, y: 0.5); place = "You are here" }
            }
            .controlSize(.small)
            Text("Illustrative — assigning the bound MapCameraPosition animates the real camera there")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Menu

private struct C10_MenuTitleExample: View {
    @State private var log = "No action yet"
    var body: some View {
        VStack(spacing: 10) {
            Menu("Options") {
                Button("Rename") { log = "Rename" }
                Button("Duplicate") { log = "Duplicate" }
                Divider()
                Button("Delete", role: .destructive) { log = "Delete" }
            }
            .fixedSize()
            Text("Last action: \(log)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private enum C10_SortKey: String, CaseIterable, Identifiable {
    case name, date, size
    var id: Self { self }
    var title: String { rawValue.capitalized }
}

private struct C10_MenuLabelExample: View {
    @State private var sortKey = C10_SortKey.name
    var body: some View {
        VStack(spacing: 10) {
            Menu {
                Picker("Sort by", selection: $sortKey) {
                    ForEach(C10_SortKey.allCases) { Text($0.title) }
                }
            } label: {
                Image(systemName: "ellipsis.circle")
                    .font(.title2)
            }
            .fixedSize()
            Text("Sorted by \(sortKey.title)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C10_MenuPrimaryActionExample: View {
    @State private var bookmarked = 0
    @State private var last = "—"
    var body: some View {
        VStack(spacing: 10) {
            Menu("Bookmark") {
                Button("Bookmark All Tabs") { bookmarked += 5; last = "all tabs" }
            } primaryAction: {
                bookmarked += 1
                last = "current tab"
            }
            .fixedSize()
            Text("\(bookmarked) bookmarks · last: \(last)")
                .font(.caption)
                .foregroundStyle(.secondary)
            Text("Click the title for the primary action; the chevron opens the menu")
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
    }
}

// MARK: - MultiDatePicker (iOS only: illustrative calendar)

private struct C10_CalendarMock: View {
    var title: String
    var selected: Set<Int>
    var allowed: ClosedRange<Int> = 1...30
    var systemImage: String? = nil
    private let weekdays = ["S", "M", "T", "W", "T", "F", "S"]
    private let columns = Array(repeating: GridItem(.fixed(22), spacing: 4), count: 7)
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if let systemImage {
                Label(title, systemImage: systemImage).font(.headline)
            } else {
                Text(title).font(.headline)
            }
            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(0..<7, id: \.self) { i in
                    Text(weekdays[i]).font(.caption2).foregroundStyle(.secondary)
                }
                ForEach(1...30, id: \.self) { day in
                    Text("\(day)")
                        .font(.caption2)
                        .frame(width: 22, height: 22)
                        .background(selected.contains(day) ? Color.accentColor : Color.clear, in: Circle())
                        .foregroundStyle(selected.contains(day) ? Color.white : (allowed.contains(day) ? Color.primary : Color.secondary.opacity(0.45)))
                }
            }
        }
        .padding(8)
        .background(Color.gray.opacity(0.12), in: RoundedRectangle(cornerRadius: 10))
    }
}

private struct C10_MultiDatePickerExample: View {
    var body: some View {
        VStack(spacing: 6) {
            C10_CalendarMock(title: "Days off", selected: [3, 4, 17, 25])
            Text("Illustrative — iOS only; binds a Set<DateComponents>, any date allowed")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C10_MultiDatePickerRangeExample: View {
    var body: some View {
        VStack(spacing: 6) {
            C10_CalendarMock(title: "Shifts", selected: [8, 12, 15], allowed: 6...20)
            Text("Illustrative — iOS only; days outside the half-open Range are disabled")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C10_MultiDatePickerLabelExample: View {
    var body: some View {
        VStack(spacing: 6) {
            C10_CalendarMock(title: "Blackout dates", selected: [1, 2, 24, 30], systemImage: "calendar.badge.minus")
            Text("Illustrative — iOS only; the label closure supplies the calendar's title view")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - NavigationLink

private struct C10_Recipe: Identifiable, Hashable {
    let id: String
    var title: String { id }
    static let all = ["Pancakes", "Ramen", "Tacos"].map { C10_Recipe(id: $0) }
}

private struct C10_NavigationLinkValueExample: View {
    var body: some View {
        NavigationStack {
            List(C10_Recipe.all) { recipe in
                NavigationLink(value: recipe) {
                    Label(recipe.title, systemImage: "fork.knife")
                }
            }
            .navigationDestination(for: C10_Recipe.self) { recipe in
                VStack(spacing: 8) {
                    Image(systemName: "fork.knife.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.orange)
                    Text(recipe.title).font(.title2)
                    Text("Pushed by value; navigationDestination(for:) resolved it to this view")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .frame(height: 200)
    }
}

private enum C10_Route: String, Hashable, CaseIterable {
    case stats = "Statistics", settings = "Settings", about = "About"
    var title: String { rawValue }
    var symbol: String {
        switch self {
        case .stats: "chart.bar"
        case .settings: "gear"
        case .about: "info.circle"
        }
    }
}

private struct C10_RouteView: View {
    let route: C10_Route
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: route.symbol)
                .font(.largeTitle)
                .foregroundStyle(.tint)
            Text(route.title).font(.title3)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

private struct C10_NavigationLinkTitleValueExample: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Statistics", value: C10_Route.stats)
                NavigationLink("Settings", value: C10_Route.settings)
            }
            .navigationDestination(for: C10_Route.self) { C10_RouteView(route: $0) }
        }
        .frame(height: 180)
    }
}

private struct C10_NavigationLinkDestinationExample: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    VStack(spacing: 8) {
                        Image(systemName: "info.circle")
                            .font(.largeTitle)
                            .foregroundStyle(.tint)
                        Text("About").font(.title3)
                        Text("Destination built inline — no navigationDestination needed")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                } label: {
                    Label("About", systemImage: "info.circle")
                }
                NavigationLink {
                    Text("Licenses").font(.title3)
                } label: {
                    Label("Licenses", systemImage: "doc.text")
                }
            }
        }
        .frame(height: 180)
    }
}

// MARK: - NavigationSplitView

private struct C10_Mailbox: Identifiable, Hashable {
    let id: String
    var name: String { id }
    var messages: [String] {
        switch id {
        case "Inbox": ["Welcome aboard", "Invoice #42", "Lunch?"]
        case "Sent": ["Re: Lunch?", "Q3 plan"]
        default: ["Draft: ideas"]
        }
    }
    static let all = ["Inbox", "Sent", "Drafts"].map { C10_Mailbox(id: $0) }
}

private struct C10_SplitViewTwoColumnExample: View {
    @State private var mailbox: C10_Mailbox.ID? = "Inbox"
    var body: some View {
        NavigationSplitView {
            List(C10_Mailbox.all, selection: $mailbox) { Text($0.name) }
                .navigationSplitViewColumnWidth(110)
        } detail: {
            VStack(spacing: 6) {
                Image(systemName: "tray.full")
                    .font(.largeTitle)
                    .foregroundStyle(.tint)
                Text(mailbox ?? "Nothing selected").font(.title3)
            }
        }
        .frame(height: 180)
    }
}

private struct C10_SplitViewThreeColumnExample: View {
    @State private var mailbox: C10_Mailbox.ID? = "Inbox"
    @State private var message: String?
    private var messages: [String] { C10_Mailbox.all.first { $0.id == mailbox }?.messages ?? [] }
    var body: some View {
        NavigationSplitView {
            List(C10_Mailbox.all, selection: $mailbox) { Text($0.name) }
                .navigationSplitViewColumnWidth(90)
        } content: {
            List(messages, id: \.self, selection: $message) { Text($0) }
                .navigationSplitViewColumnWidth(150)
        } detail: {
            Text(message ?? "Select a message").font(.title3)
        }
        .frame(height: 180)
    }
}

private struct C10_SplitViewVisibilityExample: View {
    @State private var columns: NavigationSplitViewVisibility = .doubleColumn
    var body: some View {
        VStack(spacing: 6) {
            NavigationSplitView(columnVisibility: $columns) {
                List {
                    Label("Inbox", systemImage: "tray")
                    Label("Sent", systemImage: "paperplane")
                }
                .navigationSplitViewColumnWidth(110)
            } detail: {
                Text("Detail").font(.title3)
            }
            .frame(height: 140)
            HStack {
                Button("Hide Sidebar") { withAnimation { columns = .detailOnly } }
                Button("Show Sidebar") { withAnimation { columns = .doubleColumn } }
                Text(columns == .detailOnly ? ".detailOnly" : ".doubleColumn")
                    .font(.caption.monospaced())
                    .foregroundStyle(.secondary)
            }
            .controlSize(.small)
        }
    }
}

private struct C10_SplitViewCompactColumnExample: View {
    @State private var visibility: NavigationSplitViewVisibility = .all
    @State private var compactColumn: NavigationSplitViewColumn = .detail
    var body: some View {
        VStack(spacing: 6) {
            NavigationSplitView(columnVisibility: $visibility, preferredCompactColumn: $compactColumn) {
                List { Text("Sidebar") }
                    .navigationSplitViewColumnWidth(80)
            } content: {
                List { Text("Item list") }
                    .navigationSplitViewColumnWidth(100)
            } detail: {
                Text("Detail").font(.title3)
            }
            .frame(height: 130)
            Picker("Compact column", selection: $compactColumn) {
                Text("sidebar").tag(NavigationSplitViewColumn.sidebar)
                Text("content").tag(NavigationSplitViewColumn.content)
                Text("detail").tag(NavigationSplitViewColumn.detail)
            }
            .pickerStyle(.segmented)
            .controlSize(.small)
            Text("preferredCompactColumn applies when the view collapses to a single column (compact width, e.g. iPhone)")
                .font(.caption2)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - NavigationStack

private struct C10_NavigationStackRootExample: View {
    var body: some View {
        NavigationStack {
            List(C10_Route.allCases, id: \.self) { route in
                NavigationLink(route.title, value: route)
            }
            .navigationDestination(for: C10_Route.self) { C10_RouteView(route: $0) }
        }
        .frame(height: 180)
    }
}

private struct C10_NavigationStackPathExample: View {
    @State private var path: [C10_Route] = []
    var body: some View {
        VStack(spacing: 6) {
            NavigationStack(path: $path) {
                VStack(spacing: 4) {
                    Text("Root").font(.title3)
                    Text("path = \(path.map(\.rawValue).description)")
                        .font(.caption.monospaced())
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationDestination(for: C10_Route.self) { C10_RouteView(route: $0) }
            }
            .frame(height: 130)
            HStack {
                Button("Show Settings") { path.append(.settings) }
                Button("Push Stats") { path.append(.stats) }
                Button("Pop to root") { path.removeAll() }
                    .disabled(path.isEmpty)
            }
            .controlSize(.small)
            Text("Depth: \(path.count)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private enum C10_Folder: Hashable { case inbox, archive }
private enum C10_Message: Hashable { case latest }

private struct C10_NavigationPathExample: View {
    @State private var path = NavigationPath()
    var body: some View {
        VStack(spacing: 6) {
            NavigationStack(path: $path) {
                Text("Root").font(.title3)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .navigationDestination(for: C10_Folder.self) { folder in
                        Label(folder == .inbox ? "Inbox" : "Archive", systemImage: "folder")
                    }
                    .navigationDestination(for: C10_Message.self) { _ in
                        Label("Latest message", systemImage: "envelope.open")
                    }
            }
            .frame(height: 120)
            HStack {
                Button("Deep link") {
                    path.append(C10_Folder.inbox)
                    path.append(C10_Message.latest)
                }
                Button("Pop one") { path.removeLast() }
                    .disabled(path.isEmpty)
                Button("Pop to root") { path.removeLast(path.count) }
                    .disabled(path.isEmpty)
            }
            .controlSize(.small)
            Text("Depth: \(path.count) — Folder and Message values share one type-erased path")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - OutlineGroup

private struct C10_OutlineGroupExample: View {
    private let tree = [
        C10_FileItem(name: "Aviary", children: [
            C10_FileItem(name: "App.swift", children: nil),
            C10_FileItem(name: "Examples", children: [
                C10_FileItem(name: "Part01.swift", children: nil),
                C10_FileItem(name: "Part10.swift", children: nil)
            ])
        ]),
        C10_FileItem(name: "Package.swift", children: nil)
    ]
    var body: some View {
        List {
            OutlineGroup(tree, children: \.children) { node in
                Label(node.name, systemImage: node.children == nil ? "doc" : "folder")
            }
        }
        .frame(height: 180)
    }
}

private struct C10_Chapter {
    let title: String
    var subsections: [C10_Chapter]?
}

private struct C10_OutlineGroupIDExample: View {
    private let chapters = [
        C10_Chapter(title: "1. Views", subsections: [
            C10_Chapter(title: "1.1 Text", subsections: nil),
            C10_Chapter(title: "1.2 Images", subsections: nil)
        ]),
        C10_Chapter(title: "2. Layout", subsections: [
            C10_Chapter(title: "2.1 Stacks", subsections: nil),
            C10_Chapter(title: "2.2 Grids", subsections: [
                C10_Chapter(title: "2.2.1 LazyVGrid", subsections: nil)
            ])
        ])
    ]
    var body: some View {
        List {
            OutlineGroup(chapters, id: \.title, children: \.subsections) { chapter in
                Text(chapter.title)
            }
        }
        .frame(height: 180)
    }
}

// MARK: - PasteButton

private struct C10_PasteButtonPayloadExample: View {
    @State private var notes: [String] = []
    var body: some View {
        VStack(spacing: 10) {
            PasteButton(payloadType: String.self) { strings in
                notes.append(contentsOf: strings)
            }
            if notes.isEmpty {
                Text("Copy some text, then paste — the button enables only when the pasteboard holds a String")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            } else {
                ForEach(Array(notes.suffix(3).enumerated()), id: \.offset) { pair in
                    Text(pair.element)
                        .lineLimit(1)
                        .font(.callout)
                }
            }
        }
    }
}

private struct C10_PasteButtonContentTypesExample: View {
    @State private var received: [String] = []
    var body: some View {
        VStack(spacing: 10) {
            PasteButton(supportedContentTypes: [.plainText, .url]) { providers in
                received = providers.map { $0.registeredTypeIdentifiers.first ?? "?" }
            }
            if received.isEmpty {
                Text("Enabled when the pasteboard holds plain text or a URL; you receive NSItemProviders to load yourself")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            } else {
                Text("Received \(received.count) provider(s): \(received.joined(separator: ", "))")
                    .font(.caption.monospaced())
            }
        }
    }
}

// MARK: - PhaseAnimator

private struct C10_PhaseAnimatorLoopExample: View {
    var body: some View {
        VStack(spacing: 8) {
            PhaseAnimator([0.4, 1.0]) { opacity in
                Circle()
                    .fill(.red)
                    .frame(width: 44, height: 44)
                    .opacity(opacity)
            } animation: { _ in
                .easeInOut(duration: 0.8)
            }
            Text("No trigger → cycles through the phases forever")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C10_PhaseAnimatorTriggerExample: View {
    @State private var password = ""
    @State private var failedAttempts = 0
    var body: some View {
        VStack(spacing: 10) {
            PhaseAnimator([0, -8, 8, 0] as [CGFloat], trigger: failedAttempts) { offset in
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 180)
                    .offset(x: offset)
            } animation: { _ in
                .easeInOut(duration: 0.08)
            }
            Button("Sign In") { failedAttempts += 1 }
            Text("Failed attempts: \(failedAttempts) — each change runs the shake once, then rests on phase 0")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - PhotosPicker

private struct C10_PhotosPickerSingleExample: View {
    @State private var picked: PhotosPickerItem?
    var body: some View {
        VStack(spacing: 10) {
            PhotosPicker(selection: $picked, matching: .images) {
                Label("Choose Photo", systemImage: "photo")
            }
            Text(picked == nil ? "Nothing selected yet" : "Picked one item — load it with loadTransferable(type:)")
                .font(.caption)
                .foregroundStyle(.secondary)
            Text("Presents the system photo library at runtime")
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
    }
}

private struct C10_PhotosPickerMultiExample: View {
    @State private var items: [PhotosPickerItem] = []
    var body: some View {
        VStack(spacing: 10) {
            PhotosPicker(selection: $items, maxSelectionCount: 4, matching: .images) {
                Label("Add up to 4", systemImage: "photo.stack")
            }
            Text("\(items.count) of 4 selected")
                .font(.caption)
                .foregroundStyle(.secondary)
            Text("Presents the system photo library at runtime")
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
    }
}

// MARK: - Picker

private enum C10_Priority: String, CaseIterable, Identifiable {
    case low, medium, high
    var id: Self { self }
}

private struct C10_PickerTitleExample: View {
    @State private var priority = C10_Priority.medium
    var body: some View {
        VStack(spacing: 10) {
            Picker("Priority", selection: $priority) {
                Text("Low").tag(C10_Priority.low)
                Text("Medium").tag(C10_Priority.medium)
                Text("High").tag(C10_Priority.high)
            }
            .fixedSize()
            Picker("Priority", selection: $priority) {
                Text("Low").tag(C10_Priority.low)
                Text("Medium").tag(C10_Priority.medium)
                Text("High").tag(C10_Priority.high)
            }
            .pickerStyle(.segmented)
            .frame(width: 220)
            Text("Selected: \(priority.rawValue) — same binding, two styles")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private enum C10_Layout: String, CaseIterable, Identifiable {
    case grid, list, columns
    var id: Self { self }
    var title: String { rawValue.capitalized }
}

private struct C10_PickerSystemImageExample: View {
    @State private var layout = C10_Layout.grid
    var body: some View {
        VStack(spacing: 10) {
            Picker("Layout", systemImage: "square.grid.2x2", selection: $layout) {
                ForEach(C10_Layout.allCases) { Text($0.title) }
            }
            .fixedSize()
            Text("Selected: \(layout.title) — the symbol joins the picker's label")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private enum C10_Theme: String, CaseIterable, Identifiable {
    case system, light, dark
    var id: Self { self }
    var name: String { rawValue.capitalized }
}

private struct C10_PickerLabelExample: View {
    @State private var theme = C10_Theme.system
    var body: some View {
        VStack(spacing: 10) {
            Picker(selection: $theme) {
                ForEach(C10_Theme.allCases) { Text($0.name) }
            } label: {
                Label("Theme", systemImage: "paintpalette")
                    .foregroundStyle(.purple)
            }
            .fixedSize()
            Text("Selected: \(theme.name)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - ProductView (illustrative: StoreKit loads the product at runtime)

private struct C10_ProductCard<Icon: View>: View {
    let title: String
    let subtitle: String
    let price: String
    let compact: Bool
    let icon: Icon

    init(title: String, subtitle: String, price: String, compact: Bool = false, @ViewBuilder icon: () -> Icon) {
        self.title = title
        self.subtitle = subtitle
        self.price = price
        self.compact = compact
        self.icon = icon()
    }

    var body: some View {
        HStack(spacing: 12) {
            icon
                .frame(width: compact ? 32 : 56, height: compact ? 32 : 56)
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(compact ? .body : .headline)
                if !compact {
                    Text(subtitle).font(.caption).foregroundStyle(.secondary)
                }
            }
            Spacer()
            Text(price)
                .font(.callout.bold())
                .padding(.horizontal, 14)
                .padding(.vertical, 6)
                .background(.tint, in: Capsule())
                .foregroundStyle(.white)
        }
        .padding(compact ? 8 : 12)
        .background(Color.gray.opacity(0.12), in: RoundedRectangle(cornerRadius: 12))
    }
}

private struct C10_ProductViewIDExample: View {
    var body: some View {
        VStack(spacing: 8) {
            C10_ProductCard(title: "Aviary Pro", subtitle: "Yearly · unlocks every catalog", price: "$29.99") {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue.gradient)
                    .overlay(Image(systemName: "bird.fill").font(.title).foregroundStyle(.white))
            }
            Text("Illustrative — StoreKit loads \"com.example.pro.yearly\" and its promotional icon at runtime")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

private struct C10_ProductViewIconExample: View {
    var body: some View {
        VStack(spacing: 8) {
            C10_ProductCard(title: "Small Tip", subtitle: "Thanks for the support!", price: "$0.99") {
                Image(systemName: "cup.and.saucer.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.brown)
            }
            Text("Illustrative — your icon closure replaces the store image; name, price and button come from StoreKit")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

private struct C10_ProductViewProductExample: View {
    var body: some View {
        VStack(spacing: 6) {
            C10_ProductCard(title: "Monthly", subtitle: "", price: "$3.99", compact: true) {
                Image(systemName: "calendar").font(.title2).foregroundStyle(.tint)
            }
            C10_ProductCard(title: "Yearly", subtitle: "", price: "$29.99", compact: true) {
                Image(systemName: "calendar.badge.checkmark").font(.title2).foregroundStyle(.tint)
            }
            Text("Illustrative — renders Product values you already fetched, here in the .compact style")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - ProgressView

private struct C10_ProgressViewIndeterminateExample: View {
    var body: some View {
        HStack(spacing: 28) {
            VStack(spacing: 6) {
                ProgressView().controlSize(.small)
                Text(".small").font(.caption2)
            }
            VStack(spacing: 6) {
                ProgressView()
                Text(".regular").font(.caption2)
            }
            VStack(spacing: 6) {
                ProgressView().controlSize(.large)
                Text(".large").font(.caption2)
            }
        }
        .foregroundStyle(.secondary)
    }
}

private struct C10_ProgressViewValueExample: View {
    @State private var bytesReceived = 350.0
    private let bytesExpected = 1000.0
    var body: some View {
        VStack(spacing: 12) {
            ProgressView(value: bytesReceived, total: bytesExpected)
                .progressViewStyle(.linear)
                .frame(width: 220)
            ProgressView(value: bytesReceived, total: bytesExpected)
                .progressViewStyle(.circular)
            Slider(value: $bytesReceived, in: 0...bytesExpected)
                .frame(width: 220)
            Text("\(Int(bytesReceived)) of \(Int(bytesExpected)) bytes")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct C10_ProgressViewTimerExample: View {
    @State private var interval = Date.now...Date.now.addingTimeInterval(60)
    var body: some View {
        VStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 2) {
                Text("countsDown: true").font(.caption2).foregroundStyle(.secondary)
                ProgressView(timerInterval: interval, countsDown: true)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text("countsDown: false").font(.caption2).foregroundStyle(.secondary)
                ProgressView(timerInterval: interval, countsDown: false)
            }
            Button("Restart 60 s") { interval = Date.now...Date.now.addingTimeInterval(60) }
                .controlSize(.small)
        }
        .frame(width: 240)
    }
}

// MARK: - SceneView (illustrative: SceneKit renders the scene at runtime)

private struct C10_CubeMock: View {
    var spin: Double = 0
    var body: some View {
        ZStack {
            Path { p in
                p.move(to: CGPoint(x: 60, y: 10))
                p.addLine(to: CGPoint(x: 110, y: 35))
                p.addLine(to: CGPoint(x: 60, y: 60))
                p.addLine(to: CGPoint(x: 10, y: 35))
                p.closeSubpath()
            }
            .fill(Color(hue: 0.6, saturation: 0.5, brightness: 0.95))
            Path { p in
                p.move(to: CGPoint(x: 10, y: 35))
                p.addLine(to: CGPoint(x: 60, y: 60))
                p.addLine(to: CGPoint(x: 60, y: 115))
                p.addLine(to: CGPoint(x: 10, y: 90))
                p.closeSubpath()
            }
            .fill(Color(hue: 0.6, saturation: 0.6, brightness: 0.7))
            Path { p in
                p.move(to: CGPoint(x: 110, y: 35))
                p.addLine(to: CGPoint(x: 60, y: 60))
                p.addLine(to: CGPoint(x: 60, y: 115))
                p.addLine(to: CGPoint(x: 110, y: 90))
                p.closeSubpath()
            }
            .fill(Color(hue: 0.6, saturation: 0.7, brightness: 0.5))
        }
        .frame(width: 120, height: 125)
        .rotation3DEffect(.degrees(spin), axis: (x: 0, y: 1, z: 0))
    }
}

private struct C10_SceneViewExample: View {
    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(Color.black.gradient)
                TimelineView(.animation) { context in
                    let t = context.date.timeIntervalSinceReferenceDate
                    C10_CubeMock(spin: (t * 40).truncatingRemainder(dividingBy: 360))
                }
                Text("pointOfView: chaseCamera")
                    .font(.caption2.monospaced())
                    .foregroundStyle(Color.white.opacity(0.7))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding(6)
            }
            .frame(height: 150)
            Text("Illustrative — SceneKit renders the SCNScene live; .rendersContinuously redraws every frame")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

private struct C10_SceneViewOptionsExample: View {
    @State private var cameraControl = true
    @State private var defaultLighting = true
    @State private var drag: Double = 0
    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(Color.black.gradient)
                C10_CubeMock(spin: drag)
                    .brightness(defaultLighting ? 0 : -0.35)
                    .gesture(DragGesture().onChanged { value in
                        if cameraControl { drag = Double(value.translation.width) }
                    })
            }
            .frame(height: 120)
            HStack(spacing: 16) {
                Toggle(".allowsCameraControl", isOn: $cameraControl)
                Toggle(".autoenablesDefaultLighting", isOn: $defaultLighting)
            }
            .font(.caption.monospaced())
            .toggleStyle(.checkbox)
            Text("Illustrative — drag orbits only while camera control is on; SceneKit renders live at runtime")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - ScrollView

private struct C10_DiagramMock: View {
    private let columns = Array(repeating: GridItem(.fixed(60), spacing: 20), count: 6)
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(0..<24, id: \.self) { i in
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(hue: Double(i) / 24, saturation: 0.5, brightness: 0.9))
                    .frame(height: 60)
                    .overlay(Text("\(i + 1)").font(.caption).foregroundStyle(.white))
            }
        }
        .padding(20)
    }
}

private struct C10_ScrollViewAxesExample: View {
    var body: some View {
        VStack(spacing: 6) {
            ScrollView([.horizontal, .vertical]) {
                C10_DiagramMock()
                    .frame(width: 520, height: 360)
            }
            .scrollIndicators(.hidden)
            .frame(height: 160)
            .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
            Text("Drag in any direction — both axes scroll; indicators hidden")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
