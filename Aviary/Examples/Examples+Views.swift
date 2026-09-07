//
//  Examples+Views.swift
//  Aviary
//
//  Rendered usage examples for the entries in CatalogData/views.json.
//  Entries that already have an interactive demo (Button, DatePicker, Gauge,
//  Grid, HStack, Label, LazyVGrid, Picker, ProgressView, Slider, Text, Toggle,
//  VStack) are not repeated here.
//
//  Platform-locked or live-data views (EditButton, MultiDatePicker,
//  NowPlayingView, TextFieldLink, Map, ProductView, VideoPlayer) render a
//  faithful macOS illustration with a caption; their code strings show the
//  real API.
//

import SwiftUI
import Charts
import SceneKit
import SpriteKit
import WebKit
import PhotosUI
import AuthenticationServices

enum ExamplesViews {
    static let entries: [ExampleEntry] = [
        ExampleEntry(topic: "AnyView", code: """
        @State private var isLocked = true

        var icon: AnyView {
            isLocked
                ? AnyView(Image(systemName: "lock"))
                : AnyView(ProgressView())
        }

        icon.frame(width: 44, height: 44)
        Toggle("Locked", isOn: $isLocked)
        """) { AnyView(V_AnyViewExample()) },

        ExampleEntry(topic: "AsyncImage", code: """
        AsyncImage(url: photoURL) { phase in
            switch phase {
            case .empty: ProgressView()
            case .success(let image): image.resizable().scaledToFit()
            case .failure: Image(systemName: "photo.badge.exclamationmark")
            @unknown default: EmptyView()
            }
        }
        .frame(width: 220, height: 146)
        .clipShape(.rect(cornerRadius: 12))
        """) { AnyView(V_AsyncImageExample()) },

        ExampleEntry(topic: "Canvas", code: """
        Canvas { context, size in
            let rect = CGRect(origin: .zero, size: size).insetBy(dx: 8, dy: 8)
            context.fill(Path(ellipseIn: rect), with: .color(.orange.opacity(0.15)))
            context.stroke(Path(ellipseIn: rect), with: .color(.orange), lineWidth: 4)
            context.draw(Text("Canvas").font(.headline),
                         at: CGPoint(x: size.width / 2, y: size.height / 2))
        }
        .frame(width: 220, height: 120)
        """) { AnyView(V_CanvasExample()) },

        ExampleEntry(topic: "Chart", code: """
        import Charts

        Chart(sales) { day in
            BarMark(
                x: .value("Day", day.date, unit: .day),
                y: .value("Revenue", day.total)
            )
            .foregroundStyle(.teal.gradient)
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { _ in
                AxisValueLabel(format: .dateTime.weekday(.abbreviated))
            }
        }
        """) { AnyView(V_ChartExample()) },

        ExampleEntry(topic: "Chart3D", code: """
        import Charts

        Chart3D(samples) { sample in
            PointMark(
                x: .value("X", sample.x),
                y: .value("Y", sample.y),
                z: .value("Z", sample.z)
            )
            .foregroundStyle(.purple)
        }
        """) { AnyView(V_Chart3DExample()) },

        ExampleEntry(topic: "ColorPicker", code: """
        @State private var accent = Color.blue

        ColorPicker("Accent color", selection: $accent, supportsOpacity: false)

        RoundedRectangle(cornerRadius: 10)
            .fill(accent)
            .frame(width: 220, height: 50)
        """) { AnyView(V_ColorPickerExample()) },

        ExampleEntry(topic: "ContentUnavailableView", code: """
        ContentUnavailableView {
            Label("No Documents", systemImage: "tray")
        } description: {
            Text("Documents you add appear here.")
        } actions: {
            Button("Add Document") { count += 1 }
        }
        """) { AnyView(V_ContentUnavailableViewExample()) },

        ExampleEntry(topic: "ControlGroup", code: """
        ControlGroup {
            Button("Back", systemImage: "chevron.backward") { page -= 1 }
            Button("Forward", systemImage: "chevron.forward") { page += 1 }
        }
        .labelStyle(.iconOnly)
        .fixedSize()
        """) { AnyView(V_ControlGroupExample()) },

        ExampleEntry(topic: "DisclosureGroup", code: """
        @State private var showAdvanced = false
        @State private var verbose = false

        DisclosureGroup("Advanced", isExpanded: $showAdvanced) {
            Toggle("Verbose logging", isOn: $verbose)
        }
        """) { AnyView(V_DisclosureGroupExample()) },

        ExampleEntry(topic: "Divider", code: """
        VStack {
            Text("Above")
            Divider()
            Text("Below")
        }

        HStack {
            Text("Left")
            Divider()   // vertical inside an HStack
            Text("Right")
        }
        .frame(height: 32)
        """) { AnyView(V_DividerExample()) },

        ExampleEntry(topic: "EditButton", code: """
        List {
            ForEach(items, id: \\.self) { item in
                Text(item)
            }
            .onDelete { items.remove(atOffsets: $0) }
        }
        .toolbar { EditButton() }   // iOS: toggles the list's editMode
        """) { AnyView(V_EditButtonExample()) },

        ExampleEntry(topic: "EmptyView", code: """
        List {
            Section {
                Text("Row one")
                Text("Row two")
            } header: {
                if showHeader { Text("Today") } else { EmptyView() }
            }
        }
        """) { AnyView(V_EmptyViewExample()) },

        ExampleEntry(topic: "ForEach", code: """
        ForEach(items) { item in
            HStack {
                Text(item.name)
                Spacer()
                Button("Remove", systemImage: "trash") {
                    items.removeAll { $0.id == item.id }
                }
            }
        }
        Button("Add step") { items.append(Step(name: "Step \\(items.count + 1)")) }
        """) { AnyView(V_ForEachExample()) },

        ExampleEntry(topic: "Form", code: """
        Form {
            Section("Account") {
                TextField("Username", text: $username)
                Toggle("Public profile", isOn: $isPublic)
            }
        }
        .formStyle(.grouped)
        """) { AnyView(V_FormExample()) },

        ExampleEntry(topic: "GeometryReader", code: """
        GeometryReader { proxy in
            Rectangle()
                .fill(.mint)
                .frame(width: proxy.size.width / 2)
                .overlay {
                    Text("\\(Int(proxy.size.width)) × \\(Int(proxy.size.height)) offered")
                }
        }
        .frame(width: width, height: 60)
        Slider(value: $width, in: 120...300)
        """) { AnyView(V_GeometryReaderExample()) },

        ExampleEntry(topic: "GlassEffectContainer", code: """
        GlassEffectContainer(spacing: 20) {
            HStack(spacing: spacing) {
                Image(systemName: "sun.max.fill")
                    .frame(width: 60, height: 60)
                    .glassEffect()
                Image(systemName: "moon.fill")
                    .frame(width: 60, height: 60)
                    .glassEffect()
            }
        }
        Slider(value: $spacing, in: 0...60)
        """) { AnyView(V_GlassEffectContainerExample()) },

        ExampleEntry(topic: "Group", code: """
        HStack(spacing: 16) {
            Group {
                Text("One")
                Text("Two")
                Text("Three")
            }
            .font(.headline)
            .foregroundStyle(.teal)

            Text("Four")   // outside the group: unstyled
        }
        """) { AnyView(V_GroupExample()) },

        ExampleEntry(topic: "GroupBox", code: """
        GroupBox("Notifications") {
            Toggle("Email", isOn: $email)
            Toggle("Push", isOn: $push)
        }
        """) { AnyView(V_GroupBoxExample()) },

        ExampleEntry(topic: "HelpLink", code: """
        HStack {
            HelpLink(destination: URL(string: "https://swift.org")!)
            Spacer()
            Button("Cancel") { }
            Button("OK") { }.buttonStyle(.borderedProminent)
        }
        """) { AnyView(V_HelpLinkExample()) },

        ExampleEntry(topic: "Image", code: """
        Image(systemName: "swift")
            .imageScale(.large)
            .foregroundStyle(.orange)

        // A raster image drawn in code, standing in for Image("beach"):
        Image(size: CGSize(width: 200, height: 120)) { context in
            context.fill(Path(rect), with: .linearGradient(sky,
                startPoint: .zero, endPoint: CGPoint(x: 0, y: 120)))
        }
        .resizable()
        .scaledToFill()
        .frame(width: 200, height: 120)
        .clipShape(.rect(cornerRadius: 12))
        """) { AnyView(V_ImageExample()) },

        ExampleEntry(topic: "KeyframeAnimator", code: """
        KeyframeAnimator(initialValue: Pose(), trigger: bounces) { pose in
            Circle().fill(.orange).frame(width: 36, height: 36)
                .offset(y: pose.y)
                .scaleEffect(pose.squash)
        } keyframes: { _ in
            KeyframeTrack(\\.y) {
                CubicKeyframe(-80, duration: 0.3)
                SpringKeyframe(0, duration: 0.5)
            }
            KeyframeTrack(\\.squash) {
                CubicKeyframe(1.15, duration: 0.3)
                SpringKeyframe(1, duration: 0.5)
            }
        }
        """) { AnyView(V_KeyframeAnimatorExample()) },

        ExampleEntry(topic: "LabeledContent", code: """
        Form {
            LabeledContent("Version", value: "2.4.1")
            LabeledContent("Storage") {
                Text("82%\(Text(" used").foregroundStyle(.secondary))")
            }
            LabeledContent("Battery") {
                ProgressView(value: 0.6).frame(width: 100)
            }
        }
        .formStyle(.grouped)
        """) { AnyView(V_LabeledContentExample()) },

        ExampleEntry(topic: "LazyHGrid", code: """
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.fixed(32)), GridItem(.fixed(32))], spacing: 8) {
                ForEach(tags, id: \\.self) { tag in
                    Text(tag)
                        .padding(.horizontal, 10)
                        .frame(height: 28)
                        .background(.teal.opacity(0.2), in: .capsule)
                }
            }
        }
        """) { AnyView(V_LazyHGridExample()) },

        ExampleEntry(topic: "LazyHStack", code: """
        ScrollView(.horizontal) {
            LazyHStack(spacing: 12) {
                ForEach(albums) { album in
                    VStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(album.tint.gradient)
                            .frame(width: 72, height: 72)
                        Text(album.title).font(.caption2)
                    }
                }
            }
        }
        """) { AnyView(V_LazyHStackExample()) },

        ExampleEntry(topic: "LazyVStack", code: """
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 8) {
                ForEach(messages) { message in
                    HStack(alignment: .top) {
                        Circle().fill(.blue.opacity(0.3)).frame(width: 22, height: 22)
                        Text(message.text)
                    }
                }
            }
        }
        """) { AnyView(V_LazyVStackExample()) },

        ExampleEntry(topic: "Link", code: """
        Link("Swift.org", destination: URL(string: "https://swift.org")!)

        Link(destination: URL(string: "https://developer.apple.com/swiftui")!) {
            Label("SwiftUI documentation", systemImage: "book")
        }
        """) { AnyView(V_LinkExample()) },

        ExampleEntry(topic: "List", code: """
        struct Ocean: Identifiable {
            let name: String
            var id: String { name }
        }
        @State private var selected: Ocean.ID?

        List(oceans, selection: $selected) { ocean in
            Text(ocean.name)
        }
        .listStyle(.inset(alternatesRowBackgrounds: true))
        """) { AnyView(V_ListExample()) },

        ExampleEntry(topic: "Map", code: """
        import MapKit

        Map(initialPosition: .region(region)) {
            Marker("HQ", coordinate: hq)
        }
        .mapStyle(.standard(elevation: .realistic))
        """) { AnyView(V_MapExample()) },

        ExampleEntry(topic: "Menu", code: """
        Menu("Sort") {
            Button("By name") { sort = .name }
            Button("By date") { sort = .date }
            Divider()
            Button("Reverse", systemImage: "arrow.up.arrow.down") {
                reversed.toggle()
            }
        }
        """) { AnyView(V_MenuExample()) },

        ExampleEntry(topic: "MenuButton", code: """
        // Legacy (deprecated on macOS 11):
        MenuButton("Actions") {
            Button("Duplicate") { duplicate() }
        }

        // Modern replacement, which is what renders here:
        Menu("Actions") {
            Button("Duplicate") { copies += 1 }
            Button("Delete", role: .destructive) { copies = 0 }
        }
        """) { AnyView(V_MenuButtonExample()) },

        ExampleEntry(topic: "ModifiedContent", code: """
        struct Badge: ViewModifier {
            func body(content: Content) -> some View {
                content.padding(.horizontal, 10).padding(.vertical, 4)
                    .background(.blue.opacity(0.15), in: .capsule)
            }
        }

        // These two values have exactly the same type:
        let a = Text("Hi").modifier(Badge())
        let b = ModifiedContent(content: Text("Hi"), modifier: Badge())
        Text(String(describing: type(of: a)))
        """) { AnyView(V_ModifiedContentExample()) },

        ExampleEntry(topic: "MultiDatePicker", code: """
        @State private var dates: Set<DateComponents> = []

        MultiDatePicker("Days off", selection: $dates)   // iOS only
        """) { AnyView(V_MultiDatePickerExample()) },

        ExampleEntry(topic: "NavigationLink", code: """
        NavigationStack {
            List(parks) { park in
                NavigationLink(value: park) {
                    Label(park.name, systemImage: "tree")
                }
            }
            .navigationDestination(for: Park.self) { park in
                ParkDetail(park)
            }
        }
        """) { AnyView(V_NavigationLinkExample()) },

        ExampleEntry(topic: "NavigationSplitView", code: """
        NavigationSplitView {
            List(folders, selection: $folder) { Label($0.name, systemImage: $0.icon) }
                .navigationSplitViewColumnWidth(130)
        } detail: {
            if let folder {
                Text(folder).font(.title2)
            } else {
                Text("Select a folder")
            }
        }
        """) { AnyView(V_NavigationSplitViewExample()) },

        ExampleEntry(topic: "NavigationStack", code: """
        @State private var path: [Park] = []

        NavigationStack(path: $path) {
            List(parks) { park in
                NavigationLink(park.name, value: park)
            }
            .navigationDestination(for: Park.self) { park in
                ParkDetail(park)   // its "Pop" button calls path.removeLast()
            }
        }
        Button("Push Yosemite") { path.append(parks[0]) }
        """) { AnyView(V_NavigationStackExample()) },

        ExampleEntry(topic: "NavigationView", code: """
        // Legacy (deprecated since 2022):
        NavigationView {
            List(items) { ItemRow($0) }
        }

        // Modern replacement, which is what renders here:
        NavigationStack {
            List(items) { ItemRow($0) }
        }
        """) { AnyView(V_NavigationViewExample()) },

        ExampleEntry(topic: "NowPlayingView", code: """
        import WatchKit

        TabView {
            LibraryView()
            NowPlayingView()   // watchOS only
        }
        """) { AnyView(V_NowPlayingViewExample()) },

        ExampleEntry(topic: "OutlineGroup", code: """
        List {
            OutlineGroup(fileTree, children: \\.children) { node in
                Label(node.name, systemImage: node.icon)
            }
        }
        """) { AnyView(V_OutlineGroupExample()) },

        ExampleEntry(topic: "PasteButton", code: """
        @State private var notes: [String] = []

        PasteButton(payloadType: String.self) { strings in
            notes.append(contentsOf: strings)
        }
        Text(notes.joined(separator: " · "))
        """) { AnyView(V_PasteButtonExample()) },

        ExampleEntry(topic: "PhaseAnimator", code: """
        PhaseAnimator([1.0, 1.3, 0.9, 1.0], trigger: taps) { scale in
            Image(systemName: "heart.fill")
                .scaleEffect(scale)
        } animation: { _ in
            .bouncy(duration: 0.25)
        }
        Button("Like") { taps += 1 }
        """) { AnyView(V_PhaseAnimatorExample()) },

        ExampleEntry(topic: "PhotosPicker", code: """
        import PhotosUI

        @State private var picked: PhotosPickerItem?
        @State private var image: Image?

        PhotosPicker(selection: $picked, matching: .images) {
            Label("Choose Photo", systemImage: "photo")
        }
        .task(id: picked) {
            image = try? await picked?.loadTransferable(type: Image.self)
        }
        """) { AnyView(V_PhotosPickerExample()) },

        ExampleEntry(topic: "ProductView", code: """
        import StoreKit

        ProductView(id: "com.example.pro.monthly")
            .productViewStyle(.compact)
        """) { AnyView(V_ProductViewExample()) },

        ExampleEntry(topic: "RenameButton", code: """
        @FocusState private var isRenaming: Bool

        TextField("Name", text: $name)
            .focused($isRenaming)
            .contextMenu { RenameButton() }
            .renameAction { isRenaming = true }
        """) { AnyView(V_RenameButtonExample()) },

        ExampleEntry(topic: "SceneView", code: """
        import SceneKit

        let scene = SCNScene()
        scene.rootNode.addChildNode(
            SCNNode(geometry: SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0.12))
        )

        SceneView(
            scene: scene,
            options: [.allowsCameraControl, .autoenablesDefaultLighting]
        )
        """) { AnyView(V_SceneViewExample()) },

        ExampleEntry(topic: "ScrollView", code: """
        ScrollView(.horizontal) {
            LazyHStack(spacing: 12) {
                ForEach(photos) { photo in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(photo.tint.gradient)
                        .frame(width: 120, height: 80)
                }
            }
        }
        .scrollIndicators(.hidden)
        """) { AnyView(V_ScrollViewExample()) },

        ExampleEntry(topic: "ScrollViewReader", code: """
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(messages) { Text($0.text) }
                }
            }
            .onChange(of: messages.count) {
                if let last = messages.last {
                    withAnimation { proxy.scrollTo(last.id, anchor: .bottom) }
                }
            }
        }
        Button("Send") { messages.append(Message(text: "Message \\(messages.count + 1)")) }
        """) { AnyView(V_ScrollViewReaderExample()) },

        ExampleEntry(topic: "Section", code: """
        List {
            Section {
                Text("Fix the login bug")
                Text("Review pull request")
            } header: {
                Text("Today")
            } footer: {
                Text("Updated just now.")
            }
        }
        """) { AnyView(V_SectionExample()) },

        ExampleEntry(topic: "SecureField", code: """
        @State private var password = ""

        SecureField("Password", text: $password)
            .textFieldStyle(.roundedBorder)
        ProgressView(value: min(Double(password.count) / 12, 1))
        """) { AnyView(V_SecureFieldExample()) },

        ExampleEntry(topic: "SettingsLink", code: """
        SettingsLink {
            Label("Preferences…", systemImage: "gearshape")
        }
        """) { AnyView(V_SettingsLinkExample()) },

        ExampleEntry(topic: "ShareLink", code: """
        ShareLink(
            item: URL(string: "https://example.com/article")!,
            subject: Text("Worth a read"),
            message: Text("Found this today.")
        )

        ShareLink(item: "Plain text to share") {
            Label("Share Note", systemImage: "square.and.arrow.up")
        }
        """) { AnyView(V_ShareLinkExample()) },

        ExampleEntry(topic: "SignInWithAppleButton", code: """
        import AuthenticationServices

        SignInWithAppleButton(.signIn) { request in
            request.requestedScopes = [.email]
        } onCompletion: { result in
            status = (try? result.get()) == nil ? "Failed" : "Signed in"
        }
        .signInWithAppleButtonStyle(.black)
        .frame(width: 220, height: 36)
        """) { AnyView(V_SignInWithAppleButtonExample()) },

        ExampleEntry(topic: "Spacer", code: """
        HStack {
            Image(systemName: "wifi")
            Spacer()
            Text("Connected")
        }

        HStack {
            Spacer()
            Text("Centered by two spacers")
            Spacer()
        }
        """) { AnyView(V_SpacerExample()) },

        ExampleEntry(topic: "SpriteView", code: """
        import SpriteKit

        class BounceScene: SKScene {
            override func didMove(to view: SKView) {
                physicsWorld.gravity = .zero
                physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
                // …add SKShapeNode balls with velocity and restitution 1
            }
        }

        SpriteView(scene: scene, options: [.allowsTransparency])
            .frame(width: 280, height: 140)
        """) { AnyView(V_SpriteViewExample()) },

        ExampleEntry(topic: "Stepper", code: """
        @State private var quantity = 1

        Stepper("Quantity: \\(quantity)", value: $quantity, in: 1...10)
        """) { AnyView(V_StepperExample()) },

        ExampleEntry(topic: "Table", code: """
        @State private var selection: Person.ID?
        @State private var order = [KeyPathComparator(\\Person.name)]

        Table(people, selection: $selection, sortOrder: $order) {
            TableColumn("Name", value: \\.name)
            TableColumn("Age", value: \\.age) { person in
                Text(person.age, format: .number)
            }
        }
        .onChange(of: order) { people.sort(using: order) }
        """) { AnyView(V_TableExample()) },

        ExampleEntry(topic: "TabView", code: """
        TabView(selection: $selection) {
            Tab("Library", systemImage: "books.vertical", value: .library) {
                LibraryView()
            }
            Tab("Search", systemImage: "magnifyingglass", value: .search) {
                SearchView()
            }
        }
        """) { AnyView(V_TabViewExample()) },

        ExampleEntry(topic: "TextEditor", code: """
        @State private var notes = "Dear diary…"

        TextEditor(text: $notes)
            .font(.body)
            .frame(minHeight: 120)
        """) { AnyView(V_TextEditorExample()) },

        ExampleEntry(topic: "TextField", code: """
        @State private var name = ""

        TextField("Name", text: $name, prompt: Text("Your name"))
            .textFieldStyle(.roundedBorder)
        Text(name.isEmpty ? "Hello, stranger" : "Hello, \\(name)")
        """) { AnyView(V_TextFieldExample()) },

        ExampleEntry(topic: "TextFieldLink", code: """
        TextFieldLink(prompt: Text("Name")) {          // watchOS only
            Label("Add name", systemImage: "pencil")
        } onSubmit: { value in
            name = value
        }
        """) { AnyView(V_TextFieldLinkExample()) },

        ExampleEntry(topic: "TimelineView", code: """
        TimelineView(.animation) { context in
            let angle = context.date.timeIntervalSinceReferenceDate
                .truncatingRemainder(dividingBy: 2) * 180
            Image(systemName: "arrow.triangle.2.circlepath")
                .rotationEffect(.degrees(angle))
        }
        """) { AnyView(V_TimelineViewExample()) },

        ExampleEntry(topic: "VideoPlayer", code: """
        import AVKit

        VideoPlayer(player: AVPlayer(url: clipURL)) {
            Text("Preview").font(.caption).padding(4)
        }
        """) { AnyView(V_VideoPlayerExample()) },

        ExampleEntry(topic: "ViewThatFits", code: """
        ViewThatFits {
            HStack { LongLabels() }   // preferred when space allows
            VStack { LongLabels() }   // fallback
        }
        .frame(width: width)
        Slider(value: $width, in: 120...320)
        """) { AnyView(V_ViewThatFitsExample()) },

        ExampleEntry(topic: "WebView", code: """
        import WebKit

        @State private var page = WebPage()
        let html = "<h2>Hello from WebKit</h2><p>Loaded from a string.</p>"

        WebView(page)
            .task {
                _ = page.load(html: html)
            }
        """) { AnyView(V_WebViewExample()) },

        ExampleEntry(topic: "ZStack", code: """
        ZStack(alignment: .topTrailing) {
            LinearGradient(colors: [.blue, .cyan],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 200, height: 120)
                .clipShape(.rect(cornerRadius: 12))
            Text("NEW")
                .font(.caption2.bold())
                .padding(.horizontal, 8).padding(.vertical, 3)
                .background(.red, in: .capsule)
                .foregroundStyle(.white)
                .padding(6)
        }
        """) { AnyView(V_ZStackExample()) },
    ]
}

// MARK: - Shared helpers

private struct V_Caption: View {
    let text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        Text(text)
            .font(.caption2)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
    }
}

private struct V_Park: Hashable, Identifiable {
    let name: String
    var id: String { name }
}

private let V_parks = [V_Park(name: "Yosemite"), V_Park(name: "Zion"), V_Park(name: "Acadia")]

// MARK: - AnyView

private struct V_AnyViewExample: View {
    @State private var isLocked = true

    var icon: AnyView {
        isLocked
            ? AnyView(Image(systemName: "lock"))
            : AnyView(ProgressView())
    }

    var body: some View {
        VStack(spacing: 14) {
            icon
                .font(.title)
                .frame(width: 44, height: 44)
            Toggle("Locked", isOn: $isLocked)
                .toggleStyle(.switch)
            V_Caption("One property, two different view types — AnyView erases the difference")
        }
    }
}

// MARK: - AsyncImage

private struct V_AsyncImageExample: View {
    /// A 48×32 PNG embedded as a data: URL, so the load is real but needs no network.
    private static let photoURL = URL(string: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAgCAIAAADbtmxLAAAA+klEQVR42s3OwWfCYQDG8ecvmRETIxIxEhGJWCPGREQiIp2SRJIxMyOTSLJZSdnyUyoRI2LssImIMUaMiDGiQx26TN7e25uHz/F7+CLaX1FBpLekgnB3QQWh9h8VBJu/VBDQ5nuw+nD/Jynhb8xU27rZ2BXD9/SjlPBmQ9jDW5sqJRkS9riofislGRL2OK98KSUZEvbwPH4qJRkS9ji7n6gmvNkV47Q03oOtG0kJV3FEBc7COxU48m9UYM+9UoHtbkgF1uyACiy3L1RwctOnAvN1jwpMVx0qMF62qMCQ0ajgOP1MBfpUnQqOklUq0CXKVHAYf6CCg1iJyhpx/Dle2gqyRAAAAABJRU5ErkJggg==")

    var body: some View {
        VStack(spacing: 8) {
            AsyncImage(url: Self.photoURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable().scaledToFit()
                case .failure:
                    Image(systemName: "photo.badge.exclamationmark").font(.largeTitle)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 220, height: 146)
            .clipShape(.rect(cornerRadius: 12))
            V_Caption("Loaded asynchronously from an embedded data: URL — the same phases a remote URL goes through")
        }
    }
}

// MARK: - Canvas

private struct V_CanvasExample: View {
    var body: some View {
        Canvas { context, size in
            let rect = CGRect(origin: .zero, size: size).insetBy(dx: 8, dy: 8)
            context.fill(Path(ellipseIn: rect), with: .color(.orange.opacity(0.15)))
            context.stroke(Path(ellipseIn: rect), with: .color(.orange), lineWidth: 4)
            context.draw(Text("Canvas").font(.headline),
                         at: CGPoint(x: size.width / 2, y: size.height / 2))
        }
        .frame(width: 220, height: 120)
    }
}

// MARK: - Chart

private struct V_DaySale: Identifiable {
    let id = UUID()
    let date: Date
    let total: Double
}

private struct V_ChartExample: View {
    private let sales: [V_DaySale] = {
        let totals: [Double] = [420, 610, 380, 720, 560, 810, 660]
        return totals.enumerated().map { offset, total in
            let date = Calendar.current.date(byAdding: .day, value: offset - 6, to: .now) ?? .now
            return V_DaySale(date: date, total: total)
        }
    }()

    var body: some View {
        Chart(sales) { day in
            BarMark(
                x: .value("Day", day.date, unit: .day),
                y: .value("Revenue", day.total)
            )
            .foregroundStyle(.teal.gradient)
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { _ in
                AxisValueLabel(format: .dateTime.weekday(.abbreviated))
            }
        }
        .frame(width: 260, height: 150)
    }
}

// MARK: - Chart3D

private struct V_Sample3D: Identifiable {
    let id = UUID()
    let x: Double
    let y: Double
    let z: Double
}

private struct V_Chart3DExample: View {
    private let samples: [V_Sample3D] = (0..<24).map { i in
        let t = Double(i) / 24 * 2 * .pi
        return V_Sample3D(x: cos(t), y: Double(i) / 24, z: sin(t))
    }

    var body: some View {
        VStack(spacing: 6) {
            Chart3D(samples) { sample in
                PointMark(
                    x: .value("X", sample.x),
                    y: .value("Y", sample.y),
                    z: .value("Z", sample.z)
                )
                .foregroundStyle(.purple)
            }
            .frame(width: 260, height: 180)
            V_Caption("Drag to rotate the helix")
        }
    }
}

// MARK: - ColorPicker

private struct V_ColorPickerExample: View {
    @State private var accent = Color.blue

    var body: some View {
        VStack(spacing: 14) {
            ColorPicker("Accent color", selection: $accent, supportsOpacity: false)
                .frame(width: 220)
            RoundedRectangle(cornerRadius: 10)
                .fill(accent)
                .frame(width: 220, height: 50)
                .overlay(Text("Preview").bold().foregroundStyle(.white))
        }
    }
}

// MARK: - ContentUnavailableView

private struct V_ContentUnavailableViewExample: View {
    @State private var count = 0

    var body: some View {
        Group {
            if count == 0 {
                ContentUnavailableView {
                    Label("No Documents", systemImage: "tray")
                } description: {
                    Text("Documents you add appear here.")
                } actions: {
                    Button("Add Document") { count += 1 }
                }
            } else {
                VStack(spacing: 12) {
                    Label("\(count) document\(count == 1 ? "" : "s")", systemImage: "doc.text")
                        .font(.title3)
                    HStack {
                        Button("Add Another") { count += 1 }
                        Button("Remove All") { count = 0 }
                    }
                    V_Caption("The empty state returns when the last document goes")
                }
            }
        }
        .frame(width: 300, height: 190)
    }
}

// MARK: - ControlGroup

private struct V_ControlGroupExample: View {
    @State private var page = 1

    var body: some View {
        VStack(spacing: 12) {
            ControlGroup {
                Button("Back", systemImage: "chevron.backward") { page = max(1, page - 1) }
                Button("Forward", systemImage: "chevron.forward") { page = min(9, page + 1) }
            }
            .labelStyle(.iconOnly)
            .fixedSize()
            Text("Page \(page) of 9").monospacedDigit()
        }
    }
}

// MARK: - DisclosureGroup

private struct V_DisclosureGroupExample: View {
    @State private var showAdvanced = false
    @State private var verbose = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            DisclosureGroup("Advanced", isExpanded: $showAdvanced) {
                Toggle("Verbose logging", isOn: $verbose)
                    .padding(.top, 4)
            }
            .frame(width: 240)
            V_Caption(showAdvanced ? "Expanded — verbose is \(verbose ? "on" : "off")" : "Collapsed — click the chevron")
        }
    }
}

// MARK: - Divider

private struct V_DividerExample: View {
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                Text("Above")
                Divider()
                Text("Below")
            }
            .frame(width: 160)

            HStack {
                Text("Left")
                Divider()
                Text("Right")
            }
            .frame(height: 32)
        }
    }
}

// MARK: - EditButton (iOS only — illustrative)

private struct V_EditButtonExample: View {
    @State private var items = ["Milk", "Eggs", "Bread", "Coffee"]
    @State private var isEditing = false

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Groceries").font(.headline)
                Spacer()
                Button(isEditing ? "Done" : "Edit") {
                    withAnimation { isEditing.toggle() }
                }
            }
            List {
                ForEach(items, id: \.self) { item in
                    HStack {
                        if isEditing {
                            Button {
                                withAnimation { items.removeAll { $0 == item } }
                            } label: {
                                Image(systemName: "minus.circle.fill").foregroundStyle(.red)
                            }
                            .buttonStyle(.plain)
                        }
                        Text(item)
                    }
                }
            }
            .frame(height: 110)
            V_Caption("Illustrative — EditButton is iOS-only; it flips the list's editMode to reveal delete controls")
        }
        .frame(width: 260)
    }
}

// MARK: - EmptyView

private struct V_EmptyViewExample: View {
    @State private var showHeader = true

    var body: some View {
        VStack(spacing: 8) {
            Toggle("Show header", isOn: $showHeader)
                .toggleStyle(.switch)
            List {
                Section {
                    Text("Row one")
                    Text("Row two")
                } header: {
                    if showHeader { Text("Today") } else { EmptyView() }
                }
            }
            .frame(width: 240, height: 110)
            V_Caption("EmptyView draws nothing and takes no space")
        }
    }
}

// MARK: - ForEach

private struct V_Step: Identifiable {
    let id = UUID()
    let name: String
}

private struct V_ForEachExample: View {
    @State private var items = ["Design", "Build", "Test"].map { V_Step(name: $0) }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ForEach(items) { item in
                HStack {
                    Image(systemName: "checkmark.circle")
                    Text(item.name)
                    Spacer()
                    Button("Remove", systemImage: "trash") {
                        items.removeAll { $0.id == item.id }
                    }
                    .labelStyle(.iconOnly)
                    .buttonStyle(.borderless)
                }
            }
            Button("Add step") { items.append(V_Step(name: "Step \(items.count + 1)")) }
                .padding(.top, 4)
        }
        .frame(width: 220)
        .animation(.default, value: items.count)
    }
}

// MARK: - Form

private struct V_FormExample: View {
    @State private var username = "sam"
    @State private var isPublic = true

    var body: some View {
        Form {
            Section("Account") {
                TextField("Username", text: $username)
                Toggle("Public profile", isOn: $isPublic)
            }
        }
        .formStyle(.grouped)
        .frame(width: 300, height: 150)
    }
}

// MARK: - GeometryReader

private struct V_GeometryReaderExample: View {
    @State private var width: CGFloat = 240

    var body: some View {
        VStack(spacing: 12) {
            GeometryReader { proxy in
                Rectangle()
                    .fill(.mint)
                    .frame(width: proxy.size.width / 2)
                    .overlay {
                        Text("\(Int(proxy.size.width)) × \(Int(proxy.size.height)) offered")
                            .font(.caption2)
                            .fixedSize()
                    }
            }
            .frame(width: width, height: 60)
            .background(.quaternary)
            Slider(value: $width, in: 120...300) { Text("Width") }
                .frame(width: 220)
            V_Caption("The rectangle always takes half of whatever width is offered")
        }
    }
}

// MARK: - GlassEffectContainer

private struct V_GlassEffectContainerExample: View {
    @State private var spacing: CGFloat = 40

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                LinearGradient(colors: [.indigo, .pink, .orange],
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                GlassEffectContainer(spacing: 20) {
                    HStack(spacing: spacing) {
                        Image(systemName: "sun.max.fill")
                            .font(.title)
                            .frame(width: 60, height: 60)
                            .glassEffect()
                        Image(systemName: "moon.fill")
                            .font(.title)
                            .frame(width: 60, height: 60)
                            .glassEffect()
                    }
                }
            }
            .frame(width: 280, height: 110)
            .clipShape(.rect(cornerRadius: 14))
            Slider(value: $spacing, in: 0...60) { Text("Spacing") }
                .frame(width: 220)
            V_Caption("Bring the shapes within 20 points and their glass blends together")
        }
        .animation(.smooth, value: spacing)
    }
}

// MARK: - Group

private struct V_GroupExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 16) {
                Group {
                    Text("One")
                    Text("Two")
                    Text("Three")
                }
                .font(.headline)
                .foregroundStyle(.teal)

                Text("Four")
            }
            V_Caption("The modifiers reach each grouped view; the HStack still lays out four children")
        }
    }
}

// MARK: - GroupBox

private struct V_GroupBoxExample: View {
    @State private var email = true
    @State private var push = false

    var body: some View {
        GroupBox("Notifications") {
            Toggle("Email", isOn: $email)
            Toggle("Push", isOn: $push)
        }
        .frame(width: 240)
    }
}

// MARK: - HelpLink

private struct V_HelpLinkExample: View {
    @State private var choice = "Waiting…"

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                HelpLink(destination: URL(string: "https://swift.org")!)
                Spacer()
                Button("Cancel") { choice = "Cancelled" }
                Button("OK") { choice = "Confirmed" }
                    .buttonStyle(.borderedProminent)
            }
            .padding(12)
            .frame(width: 280)
            .background(.quaternary, in: .rect(cornerRadius: 10))
            V_Caption("The standard dialog footer: help on the left, actions on the right — \(choice)")
        }
    }
}

// MARK: - Image

private struct V_ImageExample: View {
    var body: some View {
        let rect = CGRect(x: 0, y: 0, width: 200, height: 120)
        let sky = Gradient(colors: [.cyan, .blue])
        return HStack(spacing: 24) {
            Image(systemName: "swift")
                .imageScale(.large)
                .font(.system(size: 40))
                .foregroundStyle(.orange)

            Image(size: CGSize(width: 200, height: 120)) { context in
                context.fill(Path(rect), with: .linearGradient(sky,
                    startPoint: .zero, endPoint: CGPoint(x: 0, y: 120)))
            }
            .resizable()
            .scaledToFill()
            .frame(width: 200, height: 120)
            .clipShape(.rect(cornerRadius: 12))
        }
    }
}

// MARK: - KeyframeAnimator

private struct V_Pose {
    var y: CGFloat = 0
    var squash: CGFloat = 1
}

private struct V_KeyframeAnimatorExample: View {
    @State private var bounces = 0

    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .bottom) {
                Rectangle().fill(.secondary).frame(height: 1)
                KeyframeAnimator(initialValue: V_Pose(), trigger: bounces) { pose in
                    Circle().fill(.orange).frame(width: 36, height: 36)
                        .offset(y: pose.y)
                        .scaleEffect(pose.squash)
                } keyframes: { _ in
                    KeyframeTrack(\.y) {
                        CubicKeyframe(-80, duration: 0.3)
                        SpringKeyframe(0, duration: 0.5)
                    }
                    KeyframeTrack(\.squash) {
                        CubicKeyframe(1.15, duration: 0.3)
                        SpringKeyframe(1, duration: 0.5)
                    }
                }
            }
            .frame(width: 200, height: 130)
            Button("Bounce") { bounces += 1 }
        }
    }
}

// MARK: - LabeledContent

private struct V_LabeledContentExample: View {
    var body: some View {
        Form {
            LabeledContent("Version", value: "2.4.1")
            LabeledContent("Storage") {
                HStack(spacing: 0) {
                    Text("82%")
                    Text(" used").foregroundStyle(.secondary)
                }
            }
            LabeledContent("Battery") {
                ProgressView(value: 0.6).frame(width: 100)
            }
        }
        .formStyle(.grouped)
        .frame(width: 280, height: 150)
    }
}

// MARK: - LazyHGrid

private struct V_LazyHGridExample: View {
    private let tags = ["Swift", "SwiftUI", "Combine", "Charts", "MapKit", "Xcode",
                        "Metal", "ARKit", "Vision", "Shortcuts", "Widgets", "Testing"]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.fixed(32)), GridItem(.fixed(32))], spacing: 8) {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .frame(height: 28)
                        .background(.teal.opacity(0.2), in: .capsule)
                }
            }
            .padding(.horizontal)
        }
        .frame(width: 280, height: 90)
    }
}

// MARK: - LazyHStack

private struct V_Album: Identifiable {
    let id = UUID()
    let title: String
    let tint: Color
}

private struct V_LazyHStackExample: View {
    private let albums = [
        V_Album(title: "Neon Tapes", tint: .purple), V_Album(title: "Low Tide", tint: .teal),
        V_Album(title: "Paper Moons", tint: .orange), V_Album(title: "Static", tint: .gray),
        V_Album(title: "Orchard", tint: .green), V_Album(title: "Glass", tint: .blue),
    ]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 12) {
                ForEach(albums) { album in
                    VStack(alignment: .leading, spacing: 4) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(album.tint.gradient)
                            .frame(width: 72, height: 72)
                        Text(album.title).font(.caption2)
                    }
                }
            }
            .padding(.horizontal)
        }
        .frame(width: 280, height: 110)
    }
}

// MARK: - LazyVStack

private struct V_Message: Identifiable {
    let id: Int
    let text: String
}

private struct V_LazyVStackExample: View {
    private let messages = [
        V_Message(id: 1, text: "Morning! Ready for the review?"),
        V_Message(id: 2, text: "Almost — pushing the last fix now."),
        V_Message(id: 3, text: "Great, I'll grab coffee first."),
        V_Message(id: 4, text: "Make it two."),
        V_Message(id: 5, text: "Deal. See you in five."),
        V_Message(id: 6, text: "Scroll for more…"),
    ]

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 8) {
                ForEach(messages) { message in
                    HStack(alignment: .top) {
                        Circle().fill(.blue.opacity(0.3)).frame(width: 22, height: 22)
                        Text(message.text).font(.caption)
                    }
                }
            }
            .padding(8)
        }
        .frame(width: 260, height: 130)
        .background(.quaternary, in: .rect(cornerRadius: 8))
    }
}

// MARK: - Link

private struct V_LinkExample: View {
    var body: some View {
        VStack(spacing: 12) {
            Link("Swift.org", destination: URL(string: "https://swift.org")!)

            Link(destination: URL(string: "https://developer.apple.com/swiftui")!) {
                Label("SwiftUI documentation", systemImage: "book")
            }
            V_Caption("Each opens in your default browser")
        }
    }
}

// MARK: - List

private struct V_Ocean: Identifiable {
    let name: String
    var id: String { name }
}

private struct V_ListExample: View {
    private let oceans = ["Pacific", "Atlantic", "Indian", "Southern", "Arctic"].map { V_Ocean(name: $0) }
    @State private var selected: V_Ocean.ID?

    var body: some View {
        VStack(spacing: 8) {
            List(oceans, selection: $selected) { ocean in
                Text(ocean.name)
            }
            .listStyle(.inset(alternatesRowBackgrounds: true))
            .frame(width: 220, height: 130)
            V_Caption(selected.map { "Selected: \($0)" } ?? "Click a row to select it")
        }
    }
}

// MARK: - Map (MapKit tiles — illustrative)

private struct V_MapExample: View {
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                LinearGradient(colors: [Color(red: 0.86, green: 0.93, blue: 0.83),
                                        Color(red: 0.78, green: 0.88, blue: 0.95)],
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                Canvas { context, size in
                    var streets = Path()
                    for x in stride(from: 18.0, to: size.width, by: 36) {
                        streets.move(to: CGPoint(x: x, y: 0))
                        streets.addLine(to: CGPoint(x: x, y: size.height))
                    }
                    for y in stride(from: 18.0, to: size.height, by: 36) {
                        streets.move(to: CGPoint(x: 0, y: y))
                        streets.addLine(to: CGPoint(x: size.width, y: y))
                    }
                    context.stroke(streets, with: .color(.white.opacity(0.8)), lineWidth: 3)
                }
                VStack(spacing: 2) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.title)
                        .foregroundStyle(.white, .red)
                    Text("HQ")
                        .font(.caption2.bold())
                        .padding(.horizontal, 6)
                        .background(.thinMaterial, in: .capsule)
                }
            }
            .frame(width: 260, height: 130)
            .clipShape(.rect(cornerRadius: 12))
            V_Caption("Illustrative — Map draws live MapKit tiles at runtime; the Marker sits at its coordinate")
        }
    }
}

// MARK: - Menu

private enum V_SortKey: String { case name, date }

private struct V_MenuExample: View {
    @State private var sort: V_SortKey = .name
    @State private var reversed = false

    var body: some View {
        VStack(spacing: 12) {
            Menu("Sort") {
                Button("By name") { sort = .name }
                Button("By date") { sort = .date }
                Divider()
                Button("Reverse", systemImage: "arrow.up.arrow.down") {
                    reversed.toggle()
                }
            }
            .fixedSize()
            Text("Sorted by \(sort.rawValue)\(reversed ? ", reversed" : "")")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - MenuButton (deprecated — rendered with Menu)

private struct V_MenuButtonExample: View {
    @State private var copies = 1

    var body: some View {
        VStack(spacing: 12) {
            Menu("Actions") {
                Button("Duplicate") { copies += 1 }
                Button("Delete", role: .destructive) { copies = 0 }
            }
            .fixedSize()
            Text("\(copies) cop\(copies == 1 ? "y" : "ies")")
                .font(.caption)
            V_Caption("MenuButton is deprecated on macOS 11+ — this is its replacement, Menu, with the same pull-down behavior")
        }
    }
}

// MARK: - ModifiedContent

private struct V_BadgeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(.blue.opacity(0.15), in: .capsule)
    }
}

private struct V_ModifiedContentExample: View {
    var body: some View {
        let a = Text("Hi").modifier(V_BadgeModifier())
        let b = ModifiedContent(content: Text("Hi"), modifier: V_BadgeModifier())
        return VStack(spacing: 10) {
            HStack(spacing: 16) {
                a
                b
            }
            Text(String(describing: type(of: a)))
                .font(.caption.monospaced())
            V_Caption("Both values are this one type: .modifier(_:) is sugar for ModifiedContent(content:modifier:)")
        }
    }
}

// MARK: - MultiDatePicker (iOS only — illustrative)

private struct V_MultiDatePickerExample: View {
    @State private var selectedDays: Set<Int> = [3, 4, 17]
    private let columns = Array(repeating: GridItem(.fixed(28)), count: 7)

    var body: some View {
        VStack(spacing: 6) {
            Text("Days off — \(selectedDays.count) selected").font(.caption.bold())
            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(1...28, id: \.self) { day in
                    Button {
                        if selectedDays.contains(day) {
                            selectedDays.remove(day)
                        } else {
                            selectedDays.insert(day)
                        }
                    } label: {
                        Text("\(day)")
                            .font(.caption2)
                            .frame(width: 26, height: 26)
                            .background(selectedDays.contains(day) ? Color.accentColor : .clear, in: .circle)
                            .foregroundStyle(selectedDays.contains(day) ? .white : .primary)
                    }
                    .buttonStyle(.plain)
                }
            }
            V_Caption("Illustrative — MultiDatePicker is iOS-only; it binds a Set<DateComponents> of non-contiguous days")
        }
    }
}

// MARK: - NavigationLink

private struct V_NavigationLinkExample: View {
    var body: some View {
        NavigationStack {
            List(V_parks) { park in
                NavigationLink(value: park) {
                    Label(park.name, systemImage: "tree")
                }
            }
            .navigationDestination(for: V_Park.self) { park in
                V_ParkDetail(park: park)
            }
        }
        .frame(width: 260, height: 170)
    }
}

private struct V_ParkDetail: View {
    let park: V_Park
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "tree.fill").font(.largeTitle).foregroundStyle(.green)
            Text(park.name).font(.headline)
            Button("Back") { dismiss() }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - NavigationSplitView

private struct V_Folder: Identifiable, Hashable {
    let name: String
    let icon: String
    var id: String { name }
}

private struct V_NavigationSplitViewExample: View {
    private let folders = [
        V_Folder(name: "Inbox", icon: "tray"),
        V_Folder(name: "Drafts", icon: "doc"),
        V_Folder(name: "Archive", icon: "archivebox"),
    ]
    @State private var folder: V_Folder.ID?

    var body: some View {
        NavigationSplitView {
            List(folders, selection: $folder) { Label($0.name, systemImage: $0.icon) }
                .navigationSplitViewColumnWidth(130)
        } detail: {
            if let folder {
                Text(folder).font(.title2)
            } else {
                Text("Select a folder").foregroundStyle(.secondary)
            }
        }
        .frame(width: 320, height: 160)
    }
}

// MARK: - NavigationStack

private struct V_NavigationStackExample: View {
    @State private var path: [V_Park] = []

    var body: some View {
        VStack(spacing: 8) {
            NavigationStack(path: $path) {
                List(V_parks) { park in
                    NavigationLink(park.name, value: park)
                }
                .navigationDestination(for: V_Park.self) { park in
                    VStack(spacing: 10) {
                        Text(park.name).font(.headline)
                        Button("Pop") { path.removeLast() }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .frame(width: 260, height: 140)
            HStack {
                Button("Push Yosemite") { path.append(V_parks[0]) }
                Text("Path depth: \(path.count)").font(.caption).monospacedDigit()
            }
        }
    }
}

// MARK: - NavigationView (deprecated — rendered with NavigationStack)

private struct V_NavigationViewExample: View {
    private let items = ["Inbox", "Sent", "Trash"]

    var body: some View {
        VStack(spacing: 8) {
            NavigationStack {
                List(items, id: \.self) { item in
                    Label(item, systemImage: "folder")
                }
                .navigationTitle("Mail")
            }
            .frame(width: 260, height: 130)
            V_Caption("NavigationView is deprecated — this is NavigationStack, its drop-in replacement")
        }
    }
}

// MARK: - NowPlayingView (watchOS only — illustrative)

private struct V_NowPlayingViewExample: View {
    @State private var isPlaying = false

    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 8)
                .fill(.purple.gradient)
                .frame(width: 56, height: 56)
                .overlay(Image(systemName: "music.note").foregroundStyle(.white))
            Text("Midnight Drive").font(.headline)
            Text("The Neon Tapes").font(.caption).foregroundStyle(.secondary)
            HStack(spacing: 24) {
                Image(systemName: "backward.fill")
                Button {
                    isPlaying.toggle()
                } label: {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 30))
                }
                .buttonStyle(.plain)
                Image(systemName: "forward.fill")
            }
            V_Caption("Illustrative — NowPlayingView is the system watchOS screen for the current audio session")
        }
    }
}

// MARK: - OutlineGroup

private struct V_FileNode: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    var children: [V_FileNode]? = nil
}

private struct V_OutlineGroupExample: View {
    private let fileTree = [
        V_FileNode(name: "Sources", icon: "folder", children: [
            V_FileNode(name: "App.swift", icon: "swift"),
            V_FileNode(name: "Views", icon: "folder", children: [
                V_FileNode(name: "Home.swift", icon: "swift"),
                V_FileNode(name: "Detail.swift", icon: "swift"),
            ]),
        ]),
        V_FileNode(name: "README.md", icon: "doc.text"),
    ]

    var body: some View {
        List {
            OutlineGroup(fileTree, children: \.children) { node in
                Label(node.name, systemImage: node.icon)
            }
        }
        .frame(width: 240, height: 160)
    }
}

// MARK: - PasteButton

private struct V_PasteButtonExample: View {
    @State private var notes: [String] = []

    var body: some View {
        VStack(spacing: 10) {
            PasteButton(payloadType: String.self) { strings in
                notes.append(contentsOf: strings)
            }
            Text(notes.isEmpty ? "Copy some text, then click Paste" : notes.joined(separator: " · "))
                .font(.caption)
                .lineLimit(2)
                .frame(width: 260)
            V_Caption("The button enables itself only when the pasteboard holds a String")
        }
    }
}

// MARK: - PhaseAnimator

private struct V_PhaseAnimatorExample: View {
    @State private var taps = 0

    var body: some View {
        VStack(spacing: 14) {
            PhaseAnimator([1.0, 1.3, 0.9, 1.0], trigger: taps) { scale in
                Image(systemName: "heart.fill")
                    .font(.system(size: 44))
                    .foregroundStyle(.pink)
                    .scaleEffect(scale)
            } animation: { _ in
                .bouncy(duration: 0.25)
            }
            .frame(height: 70)
            Button("Like") { taps += 1 }
        }
    }
}

// MARK: - PhotosPicker

private struct V_PhotosPickerExample: View {
    @State private var picked: PhotosPickerItem?
    @State private var image: Image?

    var body: some View {
        VStack(spacing: 10) {
            PhotosPicker(selection: $picked, matching: .images) {
                Label("Choose Photo", systemImage: "photo")
            }
            .task(id: picked) {
                image = try? await picked?.loadTransferable(type: Image.self)
            }
            if let image {
                image.resizable().scaledToFit()
                    .frame(height: 90)
                    .clipShape(.rect(cornerRadius: 8))
            } else {
                V_Caption("Pick an image from your library and it loads here via Transferable")
            }
        }
    }
}

// MARK: - ProductView (StoreKit — illustrative)

private struct V_ProductViewExample: View {
    @State private var purchased = false

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.indigo.gradient)
                    .frame(width: 44, height: 44)
                    .overlay(Image(systemName: "star.fill").foregroundStyle(.white))
                VStack(alignment: .leading, spacing: 2) {
                    Text("Pro Monthly").font(.headline)
                    Text("Unlimited exports").font(.caption).foregroundStyle(.secondary)
                }
                Spacer()
                Button(purchased ? "Purchased" : "$4.99") { purchased = true }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .disabled(purchased)
            }
            .padding(12)
            .frame(width: 300)
            .background(.quaternary, in: .rect(cornerRadius: 12))
            V_Caption("Illustrative — ProductView fetches the real product and runs the purchase flow at runtime")
        }
    }
}

// MARK: - RenameButton

private struct V_RenameButtonExample: View {
    @State private var name = "Untitled Document"
    @FocusState private var isRenaming: Bool

    var body: some View {
        VStack(spacing: 10) {
            TextField("Name", text: $name)
                .textFieldStyle(.roundedBorder)
                .frame(width: 220)
                .focused($isRenaming)
                .contextMenu { RenameButton() }
                .renameAction { isRenaming = true }
            V_Caption(isRenaming ? "Renaming — the field is focused" : "Right-click the field and choose Rename")
        }
    }
}

// MARK: - SceneView

private struct V_SceneViewExample: View {
    private let scene: SCNScene = {
        let scene = SCNScene()
        scene.background.contents = NSColor(calibratedWhite: 0.12, alpha: 1)
        let box = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0.12)
        box.firstMaterial?.diffuse.contents = NSColor.systemOrange
        let node = SCNNode(geometry: box)
        node.eulerAngles = SCNVector3(0.5, 0.7, 0)
        scene.rootNode.addChildNode(node)
        let camera = SCNNode()
        camera.camera = SCNCamera()
        camera.position = SCNVector3(0, 0, 4)
        scene.rootNode.addChildNode(camera)
        return scene
    }()

    var body: some View {
        VStack(spacing: 6) {
            SceneView(
                scene: scene,
                options: [.allowsCameraControl, .autoenablesDefaultLighting]
            )
            .frame(width: 260, height: 150)
            .clipShape(.rect(cornerRadius: 12))
            V_Caption("Drag to orbit the camera around the box")
        }
    }
}

// MARK: - ScrollView

private struct V_Photo: Identifiable {
    let id = UUID()
    let tint: Color
}

private struct V_ScrollViewExample: View {
    private let photos = [Color.blue, .teal, .green, .orange, .pink, .purple].map { V_Photo(tint: $0) }

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 12) {
                ForEach(photos) { photo in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(photo.tint.gradient)
                        .frame(width: 120, height: 80)
                        .overlay(Image(systemName: "photo").foregroundStyle(.white))
                }
            }
            .padding(.horizontal)
        }
        .scrollIndicators(.hidden)
        .frame(width: 280, height: 100)
    }
}

// MARK: - ScrollViewReader

private struct V_ScrollViewReaderExample: View {
    @State private var messages = (1...8).map { V_Message(id: $0, text: "Message \($0)") }

    var body: some View {
        VStack(spacing: 8) {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 6) {
                        ForEach(messages) { Text($0.text) }
                    }
                    .padding(8)
                }
                .frame(width: 240, height: 120)
                .background(.quaternary, in: .rect(cornerRadius: 8))
                .onChange(of: messages.count) {
                    if let last = messages.last {
                        withAnimation { proxy.scrollTo(last.id, anchor: .bottom) }
                    }
                }
            }
            Button("Send") {
                messages.append(V_Message(id: messages.count + 1, text: "Message \(messages.count + 1)"))
            }
        }
    }
}

// MARK: - Section

private struct V_SectionExample: View {
    var body: some View {
        List {
            Section {
                Text("Fix the login bug")
                Text("Review pull request")
            } header: {
                Text("Today")
            } footer: {
                Text("Updated just now.")
            }
        }
        .frame(width: 260, height: 130)
    }
}

// MARK: - SecureField

private struct V_SecureFieldExample: View {
    @State private var password = ""

    var body: some View {
        VStack(spacing: 10) {
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .frame(width: 220)
            ProgressView(value: min(Double(password.count) / 12, 1))
                .frame(width: 220)
            V_Caption("\(password.count) characters typed — never displayed")
        }
    }
}

// MARK: - SettingsLink

private struct V_SettingsLinkExample: View {
    var body: some View {
        VStack(spacing: 10) {
            SettingsLink {
                Label("Preferences…", systemImage: "gearshape")
            }
            V_Caption("Opens the app's Settings scene, the same as ⌘, in the app menu")
        }
    }
}

// MARK: - ShareLink

private struct V_ShareLinkExample: View {
    var body: some View {
        VStack(spacing: 12) {
            ShareLink(
                item: URL(string: "https://example.com/article")!,
                subject: Text("Worth a read"),
                message: Text("Found this today.")
            )

            ShareLink(item: "Plain text to share") {
                Label("Share Note", systemImage: "square.and.arrow.up")
            }
            V_Caption("Each opens the system share picker for its item")
        }
    }
}

// MARK: - SignInWithAppleButton

private struct V_SignInWithAppleButtonExample: View {
    @State private var status = "Not signed in"

    var body: some View {
        VStack(spacing: 10) {
            SignInWithAppleButton(.signIn) { request in
                request.requestedScopes = [.email]
            } onCompletion: { result in
                status = (try? result.get()) == nil ? "Failed" : "Signed in"
            }
            .signInWithAppleButtonStyle(.black)
            .frame(width: 220, height: 36)
            Text(status).font(.caption)
            V_Caption("The flow completes only in an app with the Sign in with Apple capability")
        }
    }
}

// MARK: - Spacer

private struct V_SpacerExample: View {
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: "wifi")
                Spacer()
                Text("Connected")
            }
            .padding(10)
            .frame(width: 240)
            .background(.quaternary, in: .rect(cornerRadius: 8))

            HStack {
                Spacer()
                Text("Centered by two spacers")
                Spacer()
            }
            .padding(10)
            .frame(width: 240)
            .background(.quaternary, in: .rect(cornerRadius: 8))
        }
    }
}

// MARK: - SpriteView

private final class V_BounceScene: SKScene {
    override func didMove(to view: SKView) {
        backgroundColor = .clear
        physicsWorld.gravity = .zero
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        let colors: [NSColor] = [.systemOrange, .systemTeal, .systemPink]
        for (index, color) in colors.enumerated() {
            let ball = SKShapeNode(circleOfRadius: 12)
            ball.fillColor = color
            ball.strokeColor = .clear
            ball.position = CGPoint(x: frame.width * CGFloat(index + 1) / 4, y: frame.midY)
            let body = SKPhysicsBody(circleOfRadius: 12)
            body.restitution = 1
            body.friction = 0
            body.linearDamping = 0
            body.allowsRotation = false
            body.velocity = CGVector(dx: 90 + 40 * CGFloat(index), dy: 70 - 50 * CGFloat(index))
            ball.physicsBody = body
            addChild(ball)
        }
    }
}

private struct V_SpriteViewExample: View {
    @State private var scene = V_BounceScene(size: CGSize(width: 280, height: 140))

    var body: some View {
        SpriteView(scene: scene, options: [.allowsTransparency])
            .frame(width: 280, height: 140)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.secondary))
    }
}

// MARK: - Stepper

private struct V_StepperExample: View {
    @State private var quantity = 1

    var body: some View {
        VStack(spacing: 12) {
            Stepper("Quantity: \(quantity)", value: $quantity, in: 1...10)
                .frame(width: 200)
            HStack(spacing: 4) {
                ForEach(0..<quantity, id: \.self) { _ in
                    Image(systemName: "cup.and.saucer.fill").foregroundStyle(.brown)
                }
            }
            .frame(height: 20)
        }
    }
}

// MARK: - Table

private struct V_Person: Identifiable {
    let id = UUID()
    var name: String
    var age: Int
}

private struct V_TableExample: View {
    @State private var people = [
        V_Person(name: "Ada", age: 36), V_Person(name: "Grace", age: 45),
        V_Person(name: "Linus", age: 28), V_Person(name: "Margaret", age: 52),
    ]
    @State private var selection: V_Person.ID?
    @State private var order = [KeyPathComparator(\V_Person.name)]

    var body: some View {
        Table(people, selection: $selection, sortOrder: $order) {
            TableColumn("Name", value: \.name)
            TableColumn("Age", value: \.age) { person in
                Text(person.age, format: .number)
            }
        }
        .onChange(of: order) { people.sort(using: order) }
        .frame(width: 280, height: 150)
    }
}

// MARK: - TabView

private struct V_TabViewExample: View {
    enum Section: Hashable { case library, search }
    @State private var selection: Section = .library

    var body: some View {
        TabView(selection: $selection) {
            Tab("Library", systemImage: "books.vertical", value: Section.library) {
                Label("12 books on the shelf", systemImage: "books.vertical.fill")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            Tab("Search", systemImage: "magnifyingglass", value: Section.search) {
                Label("Type to search the library", systemImage: "magnifyingglass")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(width: 280, height: 150)
    }
}

// MARK: - TextEditor

private struct V_TextEditorExample: View {
    @State private var notes = "Dear diary…"

    var body: some View {
        VStack(spacing: 6) {
            TextEditor(text: $notes)
                .font(.body)
                .frame(width: 260, height: 100)
                .clipShape(.rect(cornerRadius: 6))
                .overlay(RoundedRectangle(cornerRadius: 6).stroke(.secondary.opacity(0.4)))
            V_Caption("\(notes.count) characters")
        }
    }
}

// MARK: - TextField

private struct V_TextFieldExample: View {
    @State private var name = ""

    var body: some View {
        VStack(spacing: 10) {
            TextField("Name", text: $name, prompt: Text("Your name"))
                .textFieldStyle(.roundedBorder)
                .frame(width: 220)
            Text(name.isEmpty ? "Hello, stranger" : "Hello, \(name)")
        }
    }
}

// MARK: - TextFieldLink (watchOS only — illustrative)

private struct V_TextFieldLinkExample: View {
    @State private var name = ""
    @State private var draft = ""
    @State private var isEntering = false

    var body: some View {
        VStack(spacing: 10) {
            if isEntering {
                HStack {
                    TextField("Name", text: $draft)
                        .textFieldStyle(.roundedBorder)
                        .onSubmit { commit() }
                    Button("Done") { commit() }
                }
                .frame(width: 220)
            } else {
                Button {
                    draft = name
                    isEntering = true
                } label: {
                    Label(name.isEmpty ? "Add name" : name, systemImage: "pencil")
                }
            }
            V_Caption("Illustrative — TextFieldLink is watchOS-only; it opens system text entry and hands the value to onSubmit")
        }
    }

    private func commit() {
        name = draft
        isEntering = false
    }
}

// MARK: - TimelineView

private struct V_TimelineViewExample: View {
    var body: some View {
        VStack(spacing: 10) {
            TimelineView(.animation) { context in
                let angle = context.date.timeIntervalSinceReferenceDate
                    .truncatingRemainder(dividingBy: 2) * 180
                Image(systemName: "arrow.triangle.2.circlepath")
                    .font(.system(size: 40))
                    .foregroundStyle(.blue)
                    .rotationEffect(.degrees(angle))
            }
            .frame(height: 60)
            V_Caption("Redrawn every frame; one full turn every two seconds")
        }
    }
}

// MARK: - VideoPlayer (AVKit — illustrative)

private struct V_VideoPlayerExample: View {
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 12).fill(.black)
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 44))
                    .foregroundStyle(.white.opacity(0.9))
                VStack {
                    HStack {
                        Text("Preview").font(.caption).padding(4)
                            .background(.thinMaterial, in: .rect(cornerRadius: 4))
                        Spacer()
                    }
                    Spacer()
                    HStack(spacing: 8) {
                        Text("0:00").font(.caption2).foregroundStyle(.white)
                        Capsule().fill(.white.opacity(0.3)).frame(height: 4)
                            .overlay(alignment: .leading) { Capsule().fill(.white).frame(width: 60) }
                        Text("1:24").font(.caption2).foregroundStyle(.white)
                    }
                }
                .padding(10)
            }
            .frame(width: 260, height: 146)
            V_Caption("Illustrative — VideoPlayer renders the AVPlayer's media with these system controls; the overlay is the trailing closure")
        }
    }
}

// MARK: - ViewThatFits

private struct V_LongLabels: View {
    var body: some View {
        Label("Download", systemImage: "arrow.down.circle")
        Label("Share", systemImage: "square.and.arrow.up")
        Label("Favorite", systemImage: "star")
    }
}

private struct V_ViewThatFitsExample: View {
    @State private var width: CGFloat = 320

    var body: some View {
        VStack(spacing: 12) {
            ViewThatFits {
                HStack { V_LongLabels() }
                VStack { V_LongLabels() }
            }
            .frame(width: width)
            .padding(8)
            .background(.quaternary, in: .rect(cornerRadius: 8))
            Slider(value: $width, in: 120...320) { Text("Width") }
                .frame(width: 220)
            V_Caption("Narrow the space and the HStack stops fitting, so the VStack wins")
        }
        .frame(height: 190)
    }
}

// MARK: - WebView

private struct V_WebViewExample: View {
    @State private var page = WebPage()
    private let html = """
    <body style="font: 15px -apple-system, sans-serif; margin: 16px; color: #333; background: #f7f7f7">
    <h2 style="margin: 0 0 6px">Hello from WebKit</h2>
    <p>This page was loaded from an HTML string with <code>page.load(html:)</code>.</p>
    </body>
    """

    var body: some View {
        VStack(spacing: 6) {
            WebView(page)
                .frame(width: 280, height: 130)
                .clipShape(.rect(cornerRadius: 10))
                .task {
                    _ = page.load(html: html)
                }
            V_Caption("Real WebKit content — a URLRequest would load the same way")
        }
    }
}

// MARK: - ZStack

private struct V_ZStackExample: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            LinearGradient(colors: [.blue, .cyan],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 200, height: 120)
                .clipShape(.rect(cornerRadius: 12))
            Text("NEW")
                .font(.caption2.bold())
                .padding(.horizontal, 8).padding(.vertical, 3)
                .background(.red, in: .capsule)
                .foregroundStyle(.white)
                .padding(6)
        }
    }
}
