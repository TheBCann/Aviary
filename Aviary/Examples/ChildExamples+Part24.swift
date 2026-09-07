//
//  ChildExamples+Part24.swift
//  Aviary
//
//  Compiled renderings for variant entries (part 24: gen-navpres).
//  One private C24_* struct per variant; every rendering exercises the exact
//  overload the variant names, so siblings can be compared side by side.
//  Toolbar, window-scene and split-view variants act on the host window on
//  macOS, so those render as mock window chrome with a caption rather than
//  hoisting items into the app's real toolbar.
//

import SwiftUI
import Foundation

enum ChildExamplesPart24 {
    static let entries: [ChildExampleEntry] = [

        // MARK: .toolbarRole()

        ChildExampleEntry(parent: ".toolbarRole()", child: ".browser", code: """
        NavigationStack {
            ArticleView(article: article)
                .navigationTitle(article.title)
                .toolbarRole(.browser)   // back/forward controls, leading title
        }
        """) { AnyView(C24_ToolbarRoleBrowserExample()) },

        ChildExampleEntry(parent: ".toolbarRole()", child: ".navigationStack", code: """
        NavigationStack {
            DetailView(item: item)
                .navigationTitle(item.name)
                .toolbarRole(.navigationStack)   // back button leading, centered title
        }
        """) { AnyView(C24_ToolbarRoleNavigationStackExample()) },

        // MARK: .toolbarTitleDisplayMode()

        ChildExampleEntry(parent: ".toolbarTitleDisplayMode()", child: ".large", code: """
        List(albums) { AlbumRow(album: $0) }
            .navigationTitle("Albums")
            .toolbarTitleDisplayMode(.large)   // large title collapses to inline on scroll
        """) { AnyView(C24_TitleDisplayModeLargeExample()) },

        ChildExampleEntry(parent: ".toolbarTitleDisplayMode()", child: ".inline", code: """
        SettingsForm()
            .navigationTitle("Settings")
            .toolbarTitleDisplayMode(.inline)   // compact centered title, never grows
        """) { AnyView(C24_TitleDisplayModeInlineExample()) },

        ChildExampleEntry(parent: ".toolbarTitleDisplayMode()", child: ".inlineLarge", code: """
        DocumentCanvas(document: $document)
            .navigationTitle(document.name)
            .toolbarTitleDisplayMode(.inlineLarge)   // large title pinned inside the bar
        """) { AnyView(C24_TitleDisplayModeInlineLargeExample()) },

        // MARK: .userActivity()

        ChildExampleEntry(parent: ".userActivity()", child: "userActivity(_:isActive:_:)", code: """
        Toggle("Recipe is selected", isOn: $isSelected)
            .userActivity("com.aviary.viewingRecipe", isActive: isSelected) { activity in
                activity.title = "Lemon Tart"
                activity.userInfo = ["id": "tart-01"]
            }
        """) { AnyView(C24_UserActivityIsActiveExample()) },

        ChildExampleEntry(parent: ".userActivity()", child: "userActivity(_:element:_:)", code: """
        RecipeDetail(recipe: selected)
            .userActivity("com.aviary.viewingRecipe", element: selected) { recipe, activity in
                activity.title = recipe.name      // nil element → nothing advertised
            }
        """) { AnyView(C24_UserActivityElementExample()) },

        // MARK: Alert

        ChildExampleEntry(parent: "Alert", child: "Alert(title:message:dismissButton:)", code: """
        Button("Import Library") { showError = true }
            .alert(isPresented: $showError) {
                Alert(title: Text("Import Failed"),
                      message: Text("The file couldn't be read."),
                      dismissButton: .default(Text("OK")))
            }
        """) { AnyView(C24_AlertDismissButtonExample()) },

        ChildExampleEntry(parent: "Alert", child: "Alert(title:message:primaryButton:secondaryButton:)", code: """
        Button("Delete Draft") { confirmDelete = true }
            .alert(isPresented: $confirmDelete) {
                Alert(title: Text("Delete Draft?"),
                      message: Text("This cannot be undone."),
                      primaryButton: .destructive(Text("Delete"), action: delete),
                      secondaryButton: .cancel())
            }
        """) { AnyView(C24_AlertPrimarySecondaryExample()) },

        ChildExampleEntry(parent: "Alert", child: "Alert.Button.destructive(_:action:)", code: """
        let erase = Alert.Button.destructive(Text("Erase")) {
            eraseEverything()
        }
        Alert(title: Text("Erase everything?"),
              primaryButton: erase,
              secondaryButton: .cancel())
        """) { AnyView(C24_AlertButtonDestructiveExample()) },

        // MARK: CustomizableToolbarContent

        ChildExampleEntry(parent: "CustomizableToolbarContent", child: "defaultCustomization(_:options:)", code: """
        .toolbar(id: "editor") {
            ToolbarItem(id: "fonts", placement: .secondaryAction) {
                FontPickerButton(selection: $font)
            }
            .defaultCustomization(.hidden, options: .alwaysAvailable)
        }
        """) { AnyView(C24_DefaultCustomizationExample()) },

        ChildExampleEntry(parent: "CustomizableToolbarContent", child: "customizationBehavior(_:)", code: """
        .toolbar(id: "editor") {
            ToolbarItem(id: "share", placement: .primaryAction) {
                ShareButton()
            }
            .customizationBehavior(.disabled)   // can't be moved or removed
        }
        """) { AnyView(C24_CustomizationBehaviorExample()) },

        // MARK: dismissWindow

        ChildExampleEntry(parent: "dismissWindow", child: "dismissWindow()", code: """
        @Environment(\\.dismissWindow) private var dismissWindow

        Button("Close") { dismissWindow() }   // closes the window this view lives in
        """) { AnyView(C24_DismissWindowExample()) },

        ChildExampleEntry(parent: "dismissWindow", child: "dismissWindow(id:)", code: """
        Window("Statistics", id: "stats") { StatsView() }   // declared in the App

        Button("Close Statistics") {
            dismissWindow(id: "stats")
        }
        """) { AnyView(C24_DismissWindowIDExample()) },

        ChildExampleEntry(parent: "dismissWindow", child: "dismissWindow(value:)", code: """
        WindowGroup(for: Report.ID.self) { $id in ReportView(id: id) }   // declared in the App

        Button("Close \\(report.name)") {
            dismissWindow(value: report.id)
        }
        """) { AnyView(C24_DismissWindowValueExample()) },

        // MARK: NavigationPath

        ChildExampleEntry(parent: "NavigationPath", child: "NavigationPath.CodableRepresentation", code: """
        @State private var path = NavigationPath()

        let snapshot: NavigationPath.CodableRepresentation? = path.codable   // nil if any element isn't Codable
        let saved = try JSONEncoder().encode(snapshot)
        …
        let restored = try JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: saved)
        path = NavigationPath(restored)
        """) { AnyView(C24_NavigationPathCodableExample()) },

        // MARK: NavigationSplitViewColumn

        ChildExampleEntry(parent: "NavigationSplitViewColumn", child: "NavigationSplitViewColumn.sidebar", code: """
        @State private var column = NavigationSplitViewColumn.sidebar

        NavigationSplitView(preferredCompactColumn: $column) {
            LibraryList()        // shown first in a compact layout
        } content: {
            ShelfList()
        } detail: {
            ReaderView()
        }
        """) { AnyView(C24_SplitColumnSidebarExample()) },

        ChildExampleEntry(parent: "NavigationSplitViewColumn", child: "NavigationSplitViewColumn.content", code: """
        @State private var column = NavigationSplitViewColumn.content

        NavigationSplitView(preferredCompactColumn: $column) {
            LibraryList()
        } content: {
            ShelfList()          // shown first in a compact layout
        } detail: {
            ReaderView()
        }
        """) { AnyView(C24_SplitColumnContentExample()) },

        ChildExampleEntry(parent: "NavigationSplitViewColumn", child: "NavigationSplitViewColumn.detail", code: """
        @State private var column = NavigationSplitViewColumn.sidebar

        func openFromLink() {
            column = .detail     // jump a compact layout straight to the detail column
        }
        """) { AnyView(C24_SplitColumnDetailExample()) },

        // MARK: NavigationSplitViewVisibility

        ChildExampleEntry(parent: "NavigationSplitViewVisibility", child: "NavigationSplitViewVisibility.all", code: """
        @State private var visibility = NavigationSplitViewVisibility.all

        NavigationSplitView(columnVisibility: $visibility) {
            Sidebar()
        } content: {
            ContentList()
        } detail: {
            Detail()
        }
        """) { AnyView(C24_SplitVisibilityAllExample()) },

        ChildExampleEntry(parent: "NavigationSplitViewVisibility", child: "NavigationSplitViewVisibility.doubleColumn", code: """
        @State private var visibility = NavigationSplitViewVisibility.doubleColumn

        Button("Hide Sidebar") {
            withAnimation { visibility = .doubleColumn }   // content + detail of a three-column split
        }
        """) { AnyView(C24_SplitVisibilityDoubleColumnExample()) },

        ChildExampleEntry(parent: "NavigationSplitViewVisibility", child: "NavigationSplitViewVisibility.detailOnly", code: """
        @State private var visibility = NavigationSplitViewVisibility.detailOnly

        Button("Focus Reader") {
            withAnimation { visibility = .detailOnly }     // collapses every leading column
        }
        """) { AnyView(C24_SplitVisibilityDetailOnlyExample()) },

        ChildExampleEntry(parent: "NavigationSplitViewVisibility", child: "NavigationSplitViewVisibility.automatic", code: """
        @State private var visibility = NavigationSplitViewVisibility.automatic

        NavigationSplitView(columnVisibility: $visibility) {   // system picks per platform and width
            Sidebar()
        } content: {
            ContentList()
        } detail: {
            Detail()
        }
        """) { AnyView(C24_SplitVisibilityAutomaticExample()) },

        // MARK: PresentationDetent

        ChildExampleEntry(parent: "PresentationDetent", child: "PresentationDetent.height()", code: """
        .sheet(isPresented: $showPlayer) {
            MiniPlayer()
                .presentationDetents([.height(240)])   // rests exactly 240 pt tall
        }
        """) { AnyView(C24_DetentHeightExample()) },

        ChildExampleEntry(parent: "PresentationDetent", child: "PresentationDetent.fraction()", code: """
        .sheet(isPresented: $showPlayer) {
            MiniPlayer()
                .presentationDetents([.fraction(0.3), .large])   // 30 % of the available height
        }
        """) { AnyView(C24_DetentFractionExample()) },

        ChildExampleEntry(parent: "PresentationDetent", child: "PresentationDetent.custom()", code: """
        struct MiniPlayerDetent: CustomPresentationDetent {
            static func height(in context: Context) -> CGFloat? {
                context.maxDetentValue * 0.25
            }
        }

        .presentationDetents([.custom(MiniPlayerDetent.self), .large])
        """) { AnyView(C24_DetentCustomExample()) },

        // MARK: ToolbarItem

        ChildExampleEntry(parent: "ToolbarItem", child: "ToolbarItem(placement:content:)", code: """
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Save", systemImage: "square.and.arrow.down") { save() }
            }
        }
        """) { AnyView(C24_ToolbarItemPlacementExample()) },

        ChildExampleEntry(parent: "ToolbarItem", child: "ToolbarItem(id:placement:content:)", code: """
        .toolbar(id: "editor") {                      // customizable toolbars need ids
            ToolbarItem(id: "fonts", placement: .secondaryAction) {
                FontPickerButton(selection: $font)
            }
        }
        """) { AnyView(C24_ToolbarItemIDExample()) },

        // MARK: ToolbarItemGroup

        ChildExampleEntry(parent: "ToolbarItemGroup", child: "ToolbarItemGroup(placement:content:)", code: """
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button("Markup", systemImage: "pencil.tip.crop.circle", action: markup)
                Spacer()
                Button("Share", systemImage: "square.and.arrow.up", action: share)
            }
        }
        """) { AnyView(C24_ToolbarItemGroupExample()) },

        ChildExampleEntry(parent: "ToolbarItemGroup", child: "ToolbarItemGroup(placement:content:label:)", code: """
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button("Bold", systemImage: "bold", action: bold)
                Button("Italic", systemImage: "italic", action: italic)
            } label: {
                Label("Format", systemImage: "textformat")   // group collapses behind this when space is tight
            }
        }
        """) { AnyView(C24_ToolbarItemGroupLabelExample()) },

        // MARK: ToolbarItemPlacement

        ChildExampleEntry(parent: "ToolbarItemPlacement", child: "ToolbarItemPlacement.primaryAction", code: """
        ToolbarItem(placement: .primaryAction) {
            Button("Add", systemImage: "plus", action: add)
        }
        """) { AnyView(C24_PlacementPrimaryActionExample()) },

        ChildExampleEntry(parent: "ToolbarItemPlacement", child: "ToolbarItemPlacement.confirmationAction", code: """
        .sheet(isPresented: $editing) {
            EditorForm()
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) { Button("Cancel", action: dismiss) }
                    ToolbarItem(placement: .confirmationAction) { Button("Done", action: commit) }
                }
        }
        """) { AnyView(C24_PlacementConfirmationActionExample()) },

        ChildExampleEntry(parent: "ToolbarItemPlacement", child: "ToolbarItemPlacement.topBarTrailing", code: """
        ToolbarItem(placement: .topBarTrailing) {          // iOS/tvOS/watchOS/visionOS only
            Button("Filter", systemImage: "line.3.horizontal.decrease", action: showFilters)
        }
        """) { AnyView(C24_PlacementTopBarTrailingExample()) },

        ChildExampleEntry(parent: "ToolbarItemPlacement", child: "ToolbarItemPlacement.bottomBar", code: """
        ToolbarItem(placement: .bottomBar) {                // iOS bottom toolbar
            Button("Export", action: export)
        }
        """) { AnyView(C24_PlacementBottomBarExample()) },

        // MARK: ToolbarPlacement

        ChildExampleEntry(parent: "ToolbarPlacement", child: "ToolbarPlacement.navigationBar", code: """
        ReaderView()
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        """) { AnyView(C24_ToolbarPlacementNavigationBarExample()) },

        ChildExampleEntry(parent: "ToolbarPlacement", child: "ToolbarPlacement.tabBar", code: """
        GalleryDetail(photo: photo)
            .toolbarVisibility(.hidden, for: .tabBar)
        """) { AnyView(C24_ToolbarPlacementTabBarExample()) },

        ChildExampleEntry(parent: "ToolbarPlacement", child: "ToolbarPlacement.bottomBar", code: """
        Editor(document: $document)
            .toolbarBackground(.visible, for: .bottomBar)
        """) { AnyView(C24_ToolbarPlacementBottomBarExample()) },

        ChildExampleEntry(parent: "ToolbarPlacement", child: "ToolbarPlacement.windowToolbar", code: """
        InspectorPane(selection: $selection)
            .toolbarBackground(.hidden, for: .windowToolbar)   // the Mac titlebar toolbar
        """) { AnyView(C24_ToolbarPlacementWindowToolbarExample()) },

        // MARK: ToolbarSpacer

        ChildExampleEntry(parent: "ToolbarSpacer", child: "ToolbarSpacer(.fixed)", code: """
        .toolbar {
            ToolbarItem { Button("Undo", systemImage: "arrow.uturn.backward", action: undo) }
            ToolbarSpacer(.fixed)     // small gap; splits the shared glass background
            ToolbarItem { Button("Inspector", systemImage: "sidebar.trailing", action: toggleInspector) }
        }
        """) { AnyView(C24_ToolbarSpacerFixedExample()) },

        ChildExampleEntry(parent: "ToolbarSpacer", child: "ToolbarSpacer(.flexible)", code: """
        .toolbar {
            ToolbarItemGroup { EditButtons() }
            ToolbarSpacer(.flexible)  // pushes the clusters apart across the bar
            ToolbarItem { ShareButton() }
        }
        """) { AnyView(C24_ToolbarSpacerFlexibleExample()) },

        // MARK: end of entries
    ]
}

// MARK: - Shared mock chrome

private struct C24_Caption: View {
    private let text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(.secondary)
            .fixedSize(horizontal: false, vertical: true)
    }
}

private struct C24_Chip: View {
    private let title: String
    private let systemImage: String?
    private let prominent: Bool
    init(_ title: String, systemImage: String? = nil, prominent: Bool = false) {
        self.title = title
        self.systemImage = systemImage
        self.prominent = prominent
    }
    var body: some View {
        Group {
            if let systemImage {
                Label(title, systemImage: systemImage)
            } else {
                Text(title)
            }
        }
        .font(.caption)
        .lineLimit(1)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .foregroundStyle(prominent ? Color.white : Color.primary)
        .background(prominent ? Color.accentColor : Color.secondary.opacity(0.15), in: .rect(cornerRadius: 6))
    }
}

private struct C24_TrafficLights: View {
    var body: some View {
        HStack(spacing: 5) {
            Circle().fill(.red).frame(width: 9, height: 9)
            Circle().fill(.yellow).frame(width: 9, height: 9)
            Circle().fill(.green).frame(width: 9, height: 9)
        }
    }
}

private struct C24_TextLines: View {
    var count = 4
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ForEach(0..<count, id: \.self) { index in
                RoundedRectangle(cornerRadius: 2)
                    .fill(.quaternary)
                    .frame(maxWidth: index == count - 1 ? 60 : 110)
                    .frame(height: 6)
            }
        }
        .padding(10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

/// A mock macOS window: traffic lights + a toolbar row, then content.
private struct C24_MacWindow<Toolbar: View, Content: View>: View {
    private let toolbar: Toolbar
    private let content: Content
    init(@ViewBuilder toolbar: () -> Toolbar, @ViewBuilder content: () -> Content) {
        self.toolbar = toolbar()
        self.content = content()
    }
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                C24_TrafficLights()
                toolbar
            }
            .padding(.horizontal, 10)
            .frame(height: 36)
            .frame(maxWidth: .infinity)
            .background(Color.secondary.opacity(0.1))
            Divider()
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(.background)
        .clipShape(.rect(cornerRadius: 8))
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.quaternary, lineWidth: 1))
    }
}

/// A mock iPhone screen for iOS-only behaviors.
private struct C24_Phone<Content: View>: View {
    private let content: Content
    init(@ViewBuilder content: () -> Content) { self.content = content() }
    var body: some View {
        content
            .frame(width: 170, height: 180, alignment: .top)
            .background(.background)
            .clipShape(.rect(cornerRadius: 14))
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(.quaternary, lineWidth: 1.5))
    }
}

// MARK: - .toolbarRole()

private struct C24_ToolbarRoleBrowserExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C24_MacWindow {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.left")
                    Image(systemName: "chevron.right").foregroundStyle(.tertiary)
                }
                .font(.caption.weight(.semibold))
                Text("Swift Concurrency")
                    .font(.callout.weight(.semibold))
                Spacer()
                C24_Chip("Share", systemImage: "square.and.arrow.up")
            } content: {
                C24_TextLines(count: 4)
            }
            .frame(height: 120)
            C24_Caption("Illustrative — .browser arranges the window toolbar for back/forward browsing with a leading title")
        }
    }
}

private struct C24_ToolbarRoleNavigationStackExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C24_MacWindow {
                HStack(spacing: 10) {
                    Label("Library", systemImage: "chevron.left")
                        .font(.caption.weight(.semibold))
                    Spacer()
                    C24_Chip("Edit", systemImage: "pencil")
                }
                .overlay {
                    Text("Album")
                        .font(.callout.weight(.semibold))
                }
            } content: {
                C24_TextLines(count: 4)
            }
            .frame(height: 120)
            C24_Caption("Illustrative — .navigationStack keeps the standard pushed layout: back button leading, title centered")
        }
    }
}

// MARK: - .toolbarTitleDisplayMode()

/// Mirrors the three ToolbarTitleDisplayMode values for the mock (the real
/// type isn't Equatable, and `.large` only exists on iOS/tvOS/watchOS).
private enum C24_TitleMode { case large, inline, inlineLarge }

private struct C24_TitleModeMock: View {
    var mode: C24_TitleMode
    var title: String
    var scrolled: Bool

    var body: some View {
        C24_Phone {
            VStack(spacing: 0) {
                ZStack {
                    if mode == .inlineLarge {
                        Text(title)
                            .font(.title3.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 12)
                    } else if mode == .inline || scrolled {
                        Text(title).font(.subheadline.weight(.semibold))
                    }
                }
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background(Color.secondary.opacity(0.1))
                if mode == .large && !scrolled {
                    Text(title)
                        .font(.title2.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 12)
                        .padding(.top, 8)
                }
                C24_TextLines(count: 5)
            }
        }
    }
}

private struct C24_TitleDisplayModeLargeExample: View {
    @State private var scrolled = false
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            C24_TitleModeMock(mode: .large, title: "Albums", scrolled: scrolled)
            VStack(alignment: .leading, spacing: 8) {
                Toggle("Content scrolled", isOn: $scrolled.animation())
                C24_Caption("Illustrative — .large (iOS/tvOS/watchOS) shows a prominent title that collapses to an inline one once the content scrolls")
            }
        }
    }
}

private struct C24_TitleDisplayModeInlineExample: View {
    @State private var scrolled = false
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            C24_TitleModeMock(mode: .inline, title: "Settings", scrolled: scrolled)
            VStack(alignment: .leading, spacing: 8) {
                Toggle("Content scrolled", isOn: $scrolled.animation())
                C24_Caption("Illustrative — .inline keeps a compact centered title whether or not the content has scrolled")
            }
        }
    }
}

private struct C24_TitleDisplayModeInlineLargeExample: View {
    @State private var scrolled = false
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            C24_TitleModeMock(mode: .inlineLarge, title: "Report.md", scrolled: scrolled)
            VStack(alignment: .leading, spacing: 8) {
                Toggle("Content scrolled", isOn: $scrolled.animation())
                C24_Caption("Illustrative — .inlineLarge pins a large title inside the bar; scrolling never collapses it")
            }
        }
    }
}

// MARK: - .userActivity()

private struct C24_UserActivityIsActiveExample: View {
    @State private var isSelected = false
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Toggle("Recipe is selected", isOn: $isSelected)
                .userActivity("com.aviary.viewingRecipe", isActive: isSelected) { activity in
                    activity.title = "Lemon Tart"
                    activity.userInfo = ["id": "tart-01"]
                }
            Label(isSelected ? "Advertising com.aviary.viewingRecipe" : "isActive is false — nothing advertised",
                  systemImage: isSelected ? "dot.radiowaves.left.and.right" : "wifi.slash")
                .font(.callout)
                .foregroundStyle(isSelected ? Color.green : Color.secondary)
            C24_Caption("The modifier only registers the NSUserActivity while isActive is true")
        }
    }
}

private nonisolated struct C24_Recipe: Hashable, Identifiable {
    let id: String
    let name: String
}

private struct C24_UserActivityElementExample: View {
    private let recipes = [
        C24_Recipe(id: "tart", name: "Lemon Tart"),
        C24_Recipe(id: "soup", name: "Miso Soup"),
        C24_Recipe(id: "pie", name: "Apple Pie"),
    ]
    @State private var selected: C24_Recipe?

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .leading, spacing: 2) {
                ForEach(recipes) { recipe in
                    Button {
                        selected = selected == recipe ? nil : recipe
                    } label: {
                        Text(recipe.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(6)
                            .background(selected == recipe ? Color.accentColor.opacity(0.2) : Color.clear,
                                        in: .rect(cornerRadius: 6))
                    }
                    .buttonStyle(.plain)
                }
            }
            .frame(width: 130)
            VStack(alignment: .leading, spacing: 8) {
                Label(selected.map { "Advertising \($0.name)" } ?? "element is nil — nothing advertised",
                      systemImage: selected == nil ? "wifi.slash" : "dot.radiowaves.left.and.right")
                    .font(.callout)
                    .foregroundStyle(selected == nil ? Color.secondary : Color.green)
                C24_Caption("Click a row: each element value re-runs the update closure with that recipe")
            }
            .userActivity("com.aviary.viewingRecipe", element: selected) { recipe, activity in
                activity.title = recipe.name
            }
        }
    }
}

// MARK: - Alert (deprecated; rendered with the modern .alert modifiers)

private struct C24_AlertDismissButtonExample: View {
    @State private var showError = false
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button("Import Library") { showError = true }
                .alert("Import Failed", isPresented: $showError) {
                    Button("OK") { }
                } message: {
                    Text("The file couldn't be read.")
                }
            C24_Caption("Deprecated — rendered with the modern .alert(_:isPresented:actions:message:); one button just dismisses")
        }
    }
}

private struct C24_AlertPrimarySecondaryExample: View {
    @State private var confirmDelete = false
    @State private var deleted = false
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Button("Delete Draft", role: .destructive) { confirmDelete = true }
                    .alert("Delete Draft?", isPresented: $confirmDelete) {
                        Button("Delete", role: .destructive) { deleted = true }
                        Button("Cancel", role: .cancel) { }
                    } message: {
                        Text("This cannot be undone.")
                    }
                Text(deleted ? "Draft deleted" : "Draft intact")
                    .foregroundStyle(.secondary)
                if deleted {
                    Button("Reset") { deleted = false }.controlSize(.small)
                }
            }
            C24_Caption("Deprecated — rendered with the modern .alert; primary = destructive Delete, secondary = Cancel")
        }
    }
}

private struct C24_AlertButtonDestructiveExample: View {
    @State private var confirmErase = false
    @State private var erased = false
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Button("Erase Everything…") { confirmErase = true }
                    .alert("Erase everything?", isPresented: $confirmErase) {
                        Button("Erase", role: .destructive) { erased = true }
                        Button("Cancel", role: .cancel) { }
                    }
                Label(erased ? "Erased" : "Data present", systemImage: erased ? "trash" : "internaldrive")
                    .foregroundStyle(erased ? Color.red : Color.secondary)
                if erased {
                    Button("Reset") { erased = false }.controlSize(.small)
                }
            }
            C24_Caption("Deprecated — Alert.Button.destructive maps to Button(role: .destructive) inside the modern .alert")
        }
    }
}

// MARK: - CustomizableToolbarContent

private struct C24_DashedOutline: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 6)
            .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 1, dash: [3]))
    }
}

private struct C24_DefaultCustomizationExample: View {
    @State private var fontsInToolbar = false
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C24_MacWindow {
                C24_Chip("Bold", systemImage: "bold")
                C24_Chip("Italic", systemImage: "italic")
                if fontsInToolbar {
                    C24_Chip("Fonts", systemImage: "textformat")
                        .transition(.scale.combined(with: .opacity))
                }
                Spacer()
            } content: {
                HStack(spacing: 10) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Customize Toolbar… palette").font(.caption.weight(.semibold))
                        Text("Fonts is always offered here (.alwaysAvailable)")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Button(fontsInToolbar ? "Remove Fonts" : "Add Fonts") {
                        withAnimation { fontsInToolbar.toggle() }
                    }
                    .controlSize(.small)
                }
                .padding(10)
            }
            .frame(height: 100)
            C24_Caption("Illustrative — .hidden leaves Fonts out of the default toolbar; users add it back from the customization palette")
        }
    }
}

private struct C24_CustomizationBehaviorExample: View {
    @State private var customizing = false
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C24_MacWindow {
                C24_Chip("Share", systemImage: "square.and.arrow.up")
                    .overlay(alignment: .topTrailing) {
                        if customizing {
                            Image(systemName: "lock.fill")
                                .font(.system(size: 8))
                                .foregroundStyle(.secondary)
                                .offset(x: 5, y: -5)
                        }
                    }
                C24_Chip("Fonts", systemImage: "textformat")
                    .overlay { if customizing { C24_DashedOutline() } }
                C24_Chip("Colors", systemImage: "paintpalette")
                    .overlay { if customizing { C24_DashedOutline() } }
                Spacer()
                Button(customizing ? "Done" : "Customize…") {
                    withAnimation { customizing.toggle() }
                }
                .controlSize(.mini)
            } content: {
                C24_TextLines(count: 3)
            }
            .frame(height: 100)
            C24_Caption("Illustrative — .disabled locks Share in place during customization; the dashed items stay movable and removable")
        }
    }
}

// MARK: - dismissWindow

private struct C24_DismissWindowExample: View {
    /// Read for real; the mock closes instead so the host app's window survives.
    @Environment(\.dismissWindow) private var dismissWindow
    @State private var isOpen = true
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                if isOpen {
                    C24_MacWindow {
                        Text("Preferences").font(.callout.weight(.semibold))
                        Spacer()
                    } content: {
                        Button("Close") { withAnimation { isOpen = false } }
                    }
                    .transition(.scale(scale: 0.8).combined(with: .opacity))
                } else {
                    Button("Reopen the mock window") { withAnimation { isOpen = true } }
                }
            }
            .frame(width: 220, height: 100)
            C24_Caption("Illustrative — dismissWindow() closes the window scene this view belongs to; the mock closes so the app window stays open")
        }
    }
}

private struct C24_DismissWindowIDExample: View {
    @State private var statsOpen = true
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 12) {
                C24_MacWindow {
                    Text("Main").font(.callout.weight(.semibold))
                    Spacer()
                } content: {
                    Button(statsOpen ? "Close Statistics" : "Reopen Statistics") {
                        withAnimation { statsOpen.toggle() }
                    }
                    .controlSize(.small)
                }
                .frame(width: 170)
                if statsOpen {
                    C24_MacWindow {
                        Text("Statistics").font(.callout.weight(.semibold))
                        Spacer()
                        Text("id: \"stats\"").font(.caption2.monospaced()).foregroundStyle(.secondary)
                    } content: {
                        C24_TextLines(count: 3)
                    }
                    .frame(width: 170)
                    .transition(.scale(scale: 0.8).combined(with: .opacity))
                }
            }
            .frame(height: 100)
            C24_Caption("Illustrative — dismissWindow(id: \"stats\") closes the Window scene with that identifier from anywhere in the app")
        }
    }
}

private struct C24_DismissWindowValueExample: View {
    @State private var openReports = ["R-101", "R-102"]
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 12) {
                ForEach(openReports, id: \.self) { report in
                    C24_MacWindow {
                        Text("Report \(report)").font(.callout.weight(.semibold))
                        Spacer()
                    } content: {
                        Button("Close \(report)") {
                            withAnimation { openReports.removeAll { $0 == report } }
                        }
                        .controlSize(.small)
                    }
                    .frame(width: 150)
                    .transition(.scale(scale: 0.8).combined(with: .opacity))
                }
                if openReports.count < 2 {
                    Button("Reopen all") { withAnimation { openReports = ["R-101", "R-102"] } }
                        .controlSize(.small)
                }
            }
            .frame(height: 100)
            C24_Caption("Illustrative — dismissWindow(value:) closes the WindowGroup window presenting exactly that value")
        }
    }
}

// MARK: - NavigationPath

private struct C24_NavigationPathCodableExample: View {
    @State private var path = NavigationPath()
    @State private var saved: Data?

    var body: some View {
        let snapshot: NavigationPath.CodableRepresentation? = path.codable
        let json = snapshot
            .flatMap { try? JSONEncoder().encode($0) }
            .map { String(decoding: $0, as: UTF8.self) } ?? "nil"
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Button("Push \"inbox\"") { path.append("inbox") }
                Button("Push 42") { path.append(42) }
                Button("Pop") { if !path.isEmpty { path.removeLast() } }
                    .disabled(path.isEmpty)
            }
            .controlSize(.small)
            HStack {
                Button("Save snapshot") {
                    saved = snapshot.flatMap { try? JSONEncoder().encode($0) }
                }
                Button("Restore") {
                    if let saved,
                       let restored = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: saved) {
                        path = NavigationPath(restored)
                    }
                }
                .disabled(saved == nil)
            }
            .controlSize(.small)
            Text("path.count = \(path.count)")
                .font(.callout)
            Text("path.codable → \(json)")
                .font(.caption.monospaced())
                .textSelection(.enabled)
            if let saved {
                Text("saved → \(String(decoding: saved, as: UTF8.self))")
                    .font(.caption.monospaced())
                    .foregroundStyle(.secondary)
            }
        }
    }
}

// MARK: - NavigationSplitViewColumn

private struct C24_CompactColumnMock: View {
    var column: NavigationSplitViewColumn

    private var preferredName: String {
        if column == .sidebar { "Sidebar" } else if column == .content { "Content" } else { "Detail" }
    }

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            C24_MacWindow {
                Text("Regular width").font(.caption).foregroundStyle(.secondary)
                Spacer()
            } content: {
                HStack(spacing: 0) {
                    pane("Sidebar", .sidebar)
                    Divider()
                    pane("Content", .content)
                    Divider()
                    pane("Detail", .detail)
                }
            }
            .frame(width: 250, height: 150)
            C24_Phone {
                VStack(spacing: 0) {
                    Text(preferredName)
                        .font(.subheadline.weight(.semibold))
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor.opacity(0.15))
                    C24_TextLines(count: 4)
                    Text("compact width")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 6)
                }
            }
        }
    }

    private func pane(_ title: String, _ id: NavigationSplitViewColumn) -> some View {
        VStack(spacing: 2) {
            Text(title).font(.caption2.weight(column == id ? .bold : .regular))
            C24_TextLines(count: 3)
        }
        .padding(.top, 6)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(column == id ? Color.accentColor.opacity(0.15) : Color.clear)
    }
}

private struct C24_SplitColumnButtons: View {
    @Binding var column: NavigationSplitViewColumn
    var body: some View {
        HStack {
            Button(".sidebar") { withAnimation { column = .sidebar } }
            Button(".content") { withAnimation { column = .content } }
            Button(".detail") { withAnimation { column = .detail } }
        }
        .controlSize(.small)
    }
}

private struct C24_SplitColumnSidebarExample: View {
    @State private var column = NavigationSplitViewColumn.sidebar
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C24_CompactColumnMock(column: column)
            C24_SplitColumnButtons(column: $column)
            C24_Caption("Illustrative — preferredCompactColumn: $column picks the column a compact-width layout shows; .sidebar is the leading list")
        }
    }
}

private struct C24_SplitColumnContentExample: View {
    @State private var column = NavigationSplitViewColumn.content
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C24_CompactColumnMock(column: column)
            C24_SplitColumnButtons(column: $column)
            C24_Caption("Illustrative — .content names the middle column of a three-column split view; a compact layout opens on it")
        }
    }
}

private struct C24_SplitColumnDetailExample: View {
    @State private var column = NavigationSplitViewColumn.sidebar
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C24_CompactColumnMock(column: column)
            HStack {
                Button("openFromLink()") { withAnimation { column = .detail } }
                    .controlSize(.small)
                C24_SplitColumnButtons(column: $column)
            }
            C24_Caption("Illustrative — setting column = .detail jumps a compact layout straight to the trailing detail column, as after a deep link")
        }
    }
}

// MARK: - NavigationSplitViewVisibility

private struct C24_VisibilityMock: View {
    var visibility: NavigationSplitViewVisibility

    private var showsSidebar: Bool { visibility == .all || visibility == .automatic }
    private var showsContent: Bool { visibility != .detailOnly }

    var body: some View {
        C24_MacWindow {
            Image(systemName: "sidebar.leading").font(.caption)
            Spacer()
        } content: {
            HStack(spacing: 0) {
                if showsSidebar {
                    pane("Sidebar", width: 64)
                    Divider()
                }
                if showsContent {
                    pane("Content", width: 84)
                    Divider()
                }
                pane("Detail", width: nil)
            }
        }
    }

    private func pane(_ title: String, width: CGFloat?) -> some View {
        VStack(spacing: 2) {
            Text(title).font(.caption2)
            C24_TextLines(count: 3)
        }
        .padding(.top, 6)
        .frame(maxWidth: width ?? .infinity, maxHeight: .infinity)
        .transition(.move(edge: .leading).combined(with: .opacity))
    }
}

private struct C24_VisibilityButtons: View {
    @Binding var visibility: NavigationSplitViewVisibility
    var body: some View {
        HStack {
            Button(".all") { withAnimation { visibility = .all } }
            Button(".doubleColumn") { withAnimation { visibility = .doubleColumn } }
            Button(".detailOnly") { withAnimation { visibility = .detailOnly } }
            Button(".automatic") { withAnimation { visibility = .automatic } }
        }
        .controlSize(.small)
    }
}

private struct C24_SplitVisibilityAllExample: View {
    @State private var visibility = NavigationSplitViewVisibility.all
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C24_VisibilityMock(visibility: visibility).frame(width: 300, height: 120)
            C24_VisibilityButtons(visibility: $visibility)
            C24_Caption("Illustrative — columnVisibility: $visibility drives the split view; .all shows sidebar, content and detail together")
        }
    }
}

private struct C24_SplitVisibilityDoubleColumnExample: View {
    @State private var visibility = NavigationSplitViewVisibility.doubleColumn
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C24_VisibilityMock(visibility: visibility).frame(width: 300, height: 120)
            C24_VisibilityButtons(visibility: $visibility)
            C24_Caption("Illustrative — .doubleColumn hides the sidebar of a three-column split view (sidebar + detail in a two-column one)")
        }
    }
}

private struct C24_SplitVisibilityDetailOnlyExample: View {
    @State private var visibility = NavigationSplitViewVisibility.detailOnly
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C24_VisibilityMock(visibility: visibility).frame(width: 300, height: 120)
            C24_VisibilityButtons(visibility: $visibility)
            C24_Caption("Illustrative — .detailOnly collapses every leading column so the detail view fills the window")
        }
    }
}

private struct C24_SplitVisibilityAutomaticExample: View {
    @State private var visibility = NavigationSplitViewVisibility.automatic
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C24_VisibilityMock(visibility: visibility).frame(width: 300, height: 120)
            C24_VisibilityButtons(visibility: $visibility)
            C24_Caption("Illustrative — .automatic lets the system choose; a regular-width Mac window shows every column")
        }
    }
}

// MARK: - PresentationDetent

private struct C24_DetentMock: View {
    var fraction: CGFloat
    var label: String

    var body: some View {
        C24_Phone {
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    Text("Library")
                        .font(.subheadline.weight(.semibold))
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .background(Color.secondary.opacity(0.1))
                    C24_TextLines(count: 6)
                }
                Color.black.opacity(0.18)
                GeometryReader { proxy in
                    VStack(spacing: 6) {
                        Capsule().fill(.secondary).frame(width: 30, height: 4).padding(.top, 6)
                        Text(label).font(.caption2.monospaced())
                        Spacer(minLength: 0)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: max(24, proxy.size.height * fraction))
                    .background(.regularMaterial)
                    .clipShape(.rect(topLeadingRadius: 12, topTrailingRadius: 12))
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
        }
    }
}

private struct C24_DetentHeightExample: View {
    @State private var height: CGFloat = 240
    /// iPhone point height the mock is scaled from.
    private let screenHeight: CGFloat = 852
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            C24_DetentMock(fraction: height / screenHeight, label: ".height(\(Int(height)))")
            VStack(alignment: .leading, spacing: 8) {
                Slider(value: $height, in: 120...600, step: 20) { Text("Height") }
                Text(".height(\(Int(height))) — \(Int(height)) pt on an 852 pt screen")
                    .font(.caption.monospaced())
                C24_Caption("Illustrative — detents size iOS sheets; macOS sheets ignore presentationDetents")
            }
        }
    }
}

private struct C24_DetentFractionExample: View {
    @State private var fraction: CGFloat = 0.3
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            C24_DetentMock(fraction: fraction, label: ".fraction(\(String(format: "%.2f", fraction)))")
            VStack(alignment: .leading, spacing: 8) {
                Slider(value: $fraction, in: 0.1...0.9, step: 0.05) { Text("Fraction") }
                Text(".fraction(\(String(format: "%.2f", fraction))) — \(Int(fraction * 100)) % of the available height")
                    .font(.caption.monospaced())
                C24_Caption("Illustrative — the sheet rests at that share of the presentation height; .large is the second stop")
            }
        }
    }
}

private nonisolated struct C24_MiniPlayerDetent: CustomPresentationDetent {
    static func height(in context: Context) -> CGFloat? {
        context.maxDetentValue * 0.25
    }
}

private struct C24_DetentCustomExample: View {
    private let detents: Set<PresentationDetent> = [.custom(C24_MiniPlayerDetent.self), .large]
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            C24_DetentMock(fraction: 0.25, label: ".custom(MiniPlayerDetent.self)")
            VStack(alignment: .leading, spacing: 8) {
                Text("height(in:) → context.maxDetentValue × 0.25")
                    .font(.caption.monospaced())
                Text("\(detents.count) detents in the set: the custom one plus .large")
                    .font(.caption)
                C24_Caption("Illustrative — the CustomPresentationDetent type computes its height from the presentation context on iOS")
            }
        }
    }
}

// MARK: - ToolbarItem

private struct C24_ToolbarItemPlacementExample: View {
    @State private var saved = false
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C24_MacWindow {
                Text("Notes").font(.callout.weight(.semibold))
                Spacer()
                Button {
                    withAnimation { saved.toggle() }
                } label: {
                    C24_Chip(saved ? "Saved" : "Save",
                             systemImage: saved ? "checkmark" : "square.and.arrow.down",
                             prominent: true)
                }
                .buttonStyle(.plain)
            } content: {
                C24_TextLines(count: 3)
            }
            .frame(height: 100)
            C24_Caption("Illustrative — one view wrapped in a ToolbarItem; .primaryAction lands it in the window toolbar's trailing slot")
        }
    }
}

private struct C24_ToolbarItemIDExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C24_MacWindow {
                Text("Editor").font(.callout.weight(.semibold))
                Spacer()
                C24_Chip("Fonts", systemImage: "textformat")
                    .overlay(alignment: .bottom) {
                        Text("id: \"fonts\"")
                            .font(.system(size: 8, design: .monospaced))
                            .foregroundStyle(.secondary)
                            .fixedSize()
                            .offset(y: 11)
                    }
            } content: {
                C24_TextLines(count: 3)
            }
            .frame(height: 100)
            C24_Caption("Illustrative — the id keys the item inside .toolbar(id:), so users can rearrange or remove it and the app remembers")
        }
    }
}

// MARK: - ToolbarItemGroup

private struct C24_ToolbarItemGroupExample: View {
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            C24_Phone {
                VStack(spacing: 0) {
                    Text("Photo")
                        .font(.subheadline.weight(.semibold))
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .background(Color.secondary.opacity(0.1))
                    LinearGradient(colors: [.orange, .pink], startPoint: .topLeading, endPoint: .bottomTrailing)
                    HStack {
                        Image(systemName: "pencil.tip.crop.circle")
                        Spacer()
                        Image(systemName: "square.and.arrow.up")
                    }
                    .foregroundStyle(Color.accentColor)
                    .padding(.horizontal, 16)
                    .frame(height: 40)
                    .background(.bar)
                }
            }
            C24_Caption("Illustrative — the group's views share one placement: Markup, a Spacer and Share spread across the iOS bottom bar")
                .frame(maxWidth: 220)
        }
    }
}

private struct C24_ToolbarItemGroupLabelExample: View {
    @State private var tight = false
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            C24_MacWindow {
                Text("Editor").font(.callout.weight(.semibold))
                Spacer()
                if tight {
                    C24_Chip("Format ▾", systemImage: "textformat")
                } else {
                    C24_Chip("Bold", systemImage: "bold")
                    C24_Chip("Italic", systemImage: "italic")
                }
            } content: {
                C24_TextLines(count: 3)
            }
            .frame(width: tight ? 190 : 300, height: 100)
            Toggle("Narrow window", isOn: $tight.animation())
            C24_Caption("Illustrative — when the bar runs out of room the whole group collapses behind its label as a menu")
        }
    }
}

// MARK: - ToolbarItemPlacement

private struct C24_PhoneNavBar<Trailing: View>: View {
    private let title: String
    private let trailing: Trailing
    init(_ title: String, @ViewBuilder trailing: () -> Trailing) {
        self.title = title
        self.trailing = trailing()
    }
    var body: some View {
        ZStack {
            Text(title).font(.subheadline.weight(.semibold))
            HStack {
                Spacer()
                trailing
            }
            .font(.caption)
            .foregroundStyle(Color.accentColor)
            .padding(.horizontal, 12)
        }
        .frame(height: 40)
        .frame(maxWidth: .infinity)
        .background(Color.secondary.opacity(0.1))
    }
}

private struct C24_PlacementPrimaryActionExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 14) {
                C24_MacWindow {
                    Text("Tasks").font(.callout.weight(.semibold))
                    Spacer()
                    C24_Chip("Add", systemImage: "plus", prominent: true)
                } content: {
                    C24_TextLines(count: 3)
                }
                .frame(width: 230, height: 110)
                C24_Phone {
                    VStack(spacing: 0) {
                        C24_PhoneNavBar("Tasks") { Image(systemName: "plus") }
                        C24_TextLines(count: 4)
                    }
                }
            }
            C24_Caption("Illustrative — .primaryAction takes each platform's prominent slot: the window toolbar's trailing end on macOS, the nav bar's trailing edge on iOS")
        }
    }
}

private struct C24_PlacementConfirmationActionExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 14) {
                VStack(spacing: 8) {
                    Text("Edit Tag").font(.callout.weight(.semibold))
                    C24_TextLines(count: 2)
                    HStack {
                        Spacer()
                        C24_Chip("Cancel")
                        C24_Chip("Done", prominent: true)
                    }
                }
                .padding(10)
                .frame(width: 210, height: 120)
                .background(.background)
                .clipShape(.rect(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.quaternary))
                C24_Phone {
                    VStack(spacing: 0) {
                        ZStack {
                            Text("Edit Tag").font(.subheadline.weight(.semibold))
                            HStack {
                                Text("Cancel")
                                Spacer()
                                Text("Done").fontWeight(.semibold)
                            }
                            .font(.caption)
                            .foregroundStyle(Color.accentColor)
                            .padding(.horizontal, 12)
                        }
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .background(Color.secondary.opacity(0.1))
                        C24_TextLines(count: 4)
                    }
                }
            }
            C24_Caption("Illustrative — .confirmationAction is the sheet's Done/Save: the default button bottom-trailing on macOS, bold trailing on iOS")
        }
    }
}

private struct C24_PlacementTopBarTrailingExample: View {
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            C24_Phone {
                VStack(spacing: 0) {
                    C24_PhoneNavBar("Inbox") { Image(systemName: "line.3.horizontal.decrease") }
                    C24_TextLines(count: 5)
                }
            }
            C24_Caption("Illustrative — .topBarTrailing names the top bar's trailing edge explicitly instead of a semantic role; it is unavailable on macOS")
                .frame(maxWidth: 220)
        }
    }
}

private struct C24_PlacementBottomBarExample: View {
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            C24_Phone {
                VStack(spacing: 0) {
                    C24_PhoneNavBar("Document") { EmptyView() }
                    C24_TextLines(count: 4)
                    Text("Export")
                        .font(.caption)
                        .foregroundStyle(Color.accentColor)
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .background(.bar)
                }
            }
            C24_Caption("Illustrative — .bottomBar drops the item into the iOS bottom toolbar; macOS windows have no bottom bar")
                .frame(maxWidth: 220)
        }
    }
}

// MARK: - ToolbarPlacement

private struct C24_ToolbarPlacementNavigationBarExample: View {
    @State private var material = true
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            C24_Phone {
                ZStack(alignment: .top) {
                    LinearGradient(colors: [.orange, .pink, .indigo], startPoint: .top, endPoint: .bottom)
                    Text("Reader")
                        .font(.subheadline.weight(.semibold))
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .background(material ? AnyShapeStyle(Material.ultraThinMaterial) : AnyShapeStyle(Color(white: 0.95)))
                }
            }
            VStack(alignment: .leading, spacing: 8) {
                Toggle(".ultraThinMaterial", isOn: $material.animation())
                    .font(.caption.monospaced())
                C24_Caption("Illustrative — for: .navigationBar targets the iOS navigation bar, here with a translucent material instead of the opaque default")
            }
        }
    }
}

private struct C24_ToolbarPlacementTabBarExample: View {
    @State private var hidden = true
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            C24_Phone {
                VStack(spacing: 0) {
                    C24_PhoneNavBar("Photo") { EmptyView() }
                    LinearGradient(colors: [.mint, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                    if !hidden {
                        HStack {
                            Image(systemName: "photo.on.rectangle")
                            Spacer()
                            Image(systemName: "heart")
                            Spacer()
                            Image(systemName: "magnifyingglass")
                        }
                        .font(.caption)
                        .padding(.horizontal, 22)
                        .frame(height: 40)
                        .background(.bar)
                        .transition(.move(edge: .bottom))
                    }
                }
            }
            VStack(alignment: .leading, spacing: 8) {
                Toggle(".toolbarVisibility(.hidden, for: .tabBar)", isOn: $hidden.animation())
                    .font(.caption.monospaced())
                C24_Caption("Illustrative — for: .tabBar lets a pushed detail hide or restyle the iOS tab bar without touching the navigation bar")
            }
        }
    }
}

private struct C24_ToolbarPlacementBottomBarExample: View {
    @State private var visible = true
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            C24_Phone {
                ZStack(alignment: .bottom) {
                    VStack(spacing: 0) {
                        C24_PhoneNavBar("Editor") { EmptyView() }
                        LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom)
                    }
                    HStack {
                        Image(systemName: "bold")
                        Spacer()
                        Image(systemName: "italic")
                        Spacer()
                        Image(systemName: "underline")
                    }
                    .font(.caption)
                    .padding(.horizontal, 22)
                    .frame(height: 40)
                    .background(visible ? AnyShapeStyle(Material.bar) : AnyShapeStyle(Color.clear))
                }
            }
            VStack(alignment: .leading, spacing: 8) {
                Toggle(".toolbarBackground(.visible, for: .bottomBar)", isOn: $visible.animation())
                    .font(.caption.monospaced())
                C24_Caption("Illustrative — for: .bottomBar targets the iOS bottom toolbar region; .visible forces its background even before content scrolls under it")
            }
        }
    }
}

private struct C24_ToolbarPlacementWindowToolbarExample: View {
    @State private var hidden = true
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .top) {
                LinearGradient(colors: [.indigo, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing)
                HStack(spacing: 10) {
                    C24_TrafficLights()
                    Text("Inspector").font(.callout.weight(.semibold))
                    Spacer()
                    C24_Chip("Share", systemImage: "square.and.arrow.up")
                }
                .padding(.horizontal, 10)
                .frame(height: 36)
                .background(hidden ? AnyShapeStyle(Color.clear) : AnyShapeStyle(Material.bar))
                .overlay(alignment: .bottom) {
                    if !hidden { Divider() }
                }
            }
            .frame(width: 280, height: 110)
            .clipShape(.rect(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(.quaternary))
            Toggle(".toolbarBackground(.hidden, for: .windowToolbar)", isOn: $hidden.animation())
                .font(.caption.monospaced())
            C24_Caption("Illustrative — for: .windowToolbar targets the Mac titlebar toolbar; hiding its background lets content run underneath")
        }
    }
}

// MARK: - ToolbarSpacer

private struct C24_GlassGroup<Content: View>: View {
    private let content: Content
    init(@ViewBuilder content: () -> Content) { self.content = content() }
    var body: some View {
        HStack(spacing: 12) { content }
            .font(.callout)
            .padding(.horizontal, 12)
            .padding(.vertical, 7)
            .glassEffect()
    }
}

private struct C24_ToolbarSpacerFixedExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                LinearGradient(colors: [.teal, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 10) {
                        C24_GlassGroup {
                            Image(systemName: "arrow.uturn.backward")
                            Image(systemName: "sidebar.trailing")
                        }
                        Text("no spacer — one shared background")
                            .font(.caption2)
                            .foregroundStyle(.white)
                    }
                    HStack(spacing: 10) {
                        HStack(spacing: 8) {   // the fixed gap between the two capsules
                            C24_GlassGroup { Image(systemName: "arrow.uturn.backward") }
                            C24_GlassGroup { Image(systemName: "sidebar.trailing") }
                        }
                        Text("ToolbarSpacer(.fixed) — split")
                            .font(.caption2)
                            .foregroundStyle(.white)
                    }
                }
                .padding(12)
            }
            .frame(width: 320, height: 110)
            .clipShape(.rect(cornerRadius: 8))
            C24_Caption("Illustrative — a fixed spacer inserts a small deliberate gap and breaks the neighbours' shared Liquid Glass capsule in two")
        }
    }
}

private struct C24_ToolbarSpacerFlexibleExample: View {
    @State private var wide = true
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                LinearGradient(colors: [.pink, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                HStack(spacing: 0) {
                    C24_GlassGroup {
                        Image(systemName: "bold")
                        Image(systemName: "italic")
                        Image(systemName: "underline")
                    }
                    Spacer(minLength: 8)   // ToolbarSpacer(.flexible)
                    C24_GlassGroup { Image(systemName: "square.and.arrow.up") }
                }
                .padding(12)
            }
            .frame(width: wide ? 320 : 220, height: 70)
            .clipShape(.rect(cornerRadius: 8))
            Toggle("Wide window", isOn: $wide.animation())
            C24_Caption("Illustrative — a flexible spacer absorbs whatever width the bar has, pushing the clusters to opposite ends")
        }
    }
}

// MARK: end of structs
