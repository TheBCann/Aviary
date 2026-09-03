//
//  Examples+NavPres.swift
//  Swift-UI-Companion
//
//  Rendered usage examples for the entries in CatalogData/gen-navpres.json.
//  Many of these APIs describe navigation chrome, presentations, scenes, and
//  system integration that live above an embedded view, so those examples
//  render a faithful illustration with a caption while the code string shows
//  the real API. The rest run live.
//

import SwiftUI
import UniformTypeIdentifiers

enum ExamplesNavPres {
    static let entries: [ExampleEntry] = [
        ExampleEntry(topic: ".dialogIcon()", code: """
        .alert("Reset Library?", isPresented: $confirming) {
            Button("Reset", role: .destructive, action: reset)
            Button("Cancel", role: .cancel) { }
        }
        .dialogIcon(Image(systemName: "externaldrive.badge.exclamationmark"))
        """) { AnyView(N_DialogIconExample()) },

        ExampleEntry(topic: ".dialogSeverity()", code: """
        .alert("Erase All Annotations?", isPresented: $confirming) {
            Button("Erase", role: .destructive, action: eraseAnnotations)
            Button("Cancel", role: .cancel) { }
        }
        .dialogSeverity(.critical)
        """) { AnyView(N_DialogSeverityExample()) },

        ExampleEntry(topic: ".dialogSuppressionToggle()", code: """
        @AppStorage("suppressReplaceWarning") private var suppress = false

        exportButton
            .alert("Replace Existing File?", isPresented: $confirming) {
                Button("Replace", action: performExport)
                Button("Cancel", role: .cancel) { }
            }
            .dialogSuppressionToggle(isSuppressed: $suppress)
        """) { AnyView(N_DialogSuppressionExample()) },

        ExampleEntry(topic: ".fileDialogBrowserOptions()", code: """
        .fileImporter(isPresented: $importing,
                      allowedContentTypes: [.item]) { open($0) }
        .fileDialogBrowserOptions([.includeHiddenFiles, .displayFileExtensions])
        """) { AnyView(N_FileDialogBrowserOptionsExample()) },

        ExampleEntry(topic: ".fileDialogConfirmationLabel()", code: """
        .fileImporter(isPresented: $importing,
                      allowedContentTypes: [.pdf]) { handle($0) }
        .fileDialogConfirmationLabel("Add to Library")
        """) { AnyView(N_FileDialogConfirmationLabelExample()) },

        ExampleEntry(topic: ".fileDialogCustomizationID()", code: """
        .fileExporter(isPresented: $exporting,
                      document: bookmarksDoc,
                      contentType: .json,
                      defaultFilename: "Bookmarks") { _ in }
        .fileDialogCustomizationID("bookmarksExport")
        """) { AnyView(N_FileDialogCustomizationIDExample()) },

        ExampleEntry(topic: ".fileDialogDefaultDirectory()", code: """
        .fileImporter(isPresented: $importing,
                      allowedContentTypes: [.epub]) { handle($0) }
        .fileDialogDefaultDirectory(.downloadsDirectory)
        """) { AnyView(N_FileDialogDefaultDirectoryExample()) },

        ExampleEntry(topic: ".fileDialogImportsUnresolvedAliases()", code: """
        .fileImporter(isPresented: $importing,
                      allowedContentTypes: [.item]) { inspect($0) }
        .fileDialogImportsUnresolvedAliases(true)
        """) { AnyView(N_FileDialogAliasesExample()) },

        ExampleEntry(topic: ".fileDialogMessage()", code: """
        .fileImporter(isPresented: $importing,
                      allowedContentTypes: [.pdf, .epub]) { handle($0) }
        .fileDialogMessage("Choose a book to add. PDFs keep their printed contents pages.")
        """) { AnyView(N_FileDialogMessageExample()) },

        ExampleEntry(topic: ".fileExporter()", code: """
        .fileExporter(isPresented: $exporting,
                      document: notesDocument,
                      contentType: .plainText,
                      defaultFilename: "Meeting Notes") { result in
            if case .failure(let error) = result { presentError(error) }
        }
        """) { AnyView(N_FileExporterExample()) },

        ExampleEntry(topic: ".fileExporterFilenameLabel()", code: """
        .fileExporter(isPresented: $exporting,
                      document: reportDoc,
                      contentType: .pdf,
                      defaultFilename: "Quarterly Report") { _ in }
        .fileExporterFilenameLabel("Export As:")
        """) { AnyView(N_FileExporterFilenameLabelExample()) },

        ExampleEntry(topic: ".fileImporter()", code: """
        .fileImporter(isPresented: $importing,
                      allowedContentTypes: [.pdf],
                      allowsMultipleSelection: true) { result in
            if case .success(let urls) = result { addToLibrary(urls) }
        }
        """) { AnyView(N_FileImporterExample()) },

        ExampleEntry(topic: ".fileMover()", code: """
        .fileMover(isPresented: $moving, file: draftURL) { result in
            if case .success(let newURL) = result { archivedURL = newURL }
        }
        """) { AnyView(N_FileMoverExample()) },

        ExampleEntry(topic: ".handlesExternalEvents()", code: """
        WindowGroup("Reader") {
            ReaderWindow()
        }
        .handlesExternalEvents(matching: ["reader"])
        """) { AnyView(N_HandlesExternalEventsExample()) },

        ExampleEntry(topic: ".inspector()", code: """
        CanvasView(document: $document, selection: $selection)
            .inspector(isPresented: $showsInspector) {
                ShapeAttributesPane(selection: $selection)
            }
        """) { AnyView(N_InspectorExample()) },

        ExampleEntry(topic: ".inspectorColumnWidth()", code: """
        .inspector(isPresented: $showsInspector) {
            AttributesPane(selection: $selection)
                .inspectorColumnWidth(min: 220, ideal: 260, max: 340)
        }
        """) { AnyView(N_InspectorColumnWidthExample()) },

        ExampleEntry(topic: ".matchedTransitionSource()", code: """
        NavigationLink(value: photo) {
            Thumbnail(photo: photo)
                .matchedTransitionSource(id: photo.id, in: gallery)
        }
        .navigationDestination(for: Photo.self) { photo in
            PhotoDetail(photo: photo)
                .navigationTransition(.zoom(sourceID: photo.id, in: gallery))
        }
        """) { AnyView(N_MatchedTransitionSourceExample()) },

        ExampleEntry(topic: ".navigationBarBackButtonHidden()", code: """
        PaymentStep(order: order)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: abandonCheckout)
                }
            }
        """) { AnyView(N_NavBarBackButtonHiddenExample()) },

        ExampleEntry(topic: ".navigationBarHidden()", code: """
        // Deprecated:
        LegacyReaderView()
            .navigationBarHidden(true)
        """) { AnyView(N_NavBarHiddenExample()) },

        ExampleEntry(topic: ".navigationBarItems()", code: """
        // Deprecated:
        LegacyListView()
            .navigationBarItems(
                leading: Button("Close", action: close),
                trailing: EditButton()
            )
        """) { AnyView(N_NavBarItemsExample()) },

        ExampleEntry(topic: ".navigationBarTitleDisplayMode()", code: """
        List(albums) { AlbumRow(album: $0) }
            .navigationTitle("Albums")
            .navigationBarTitleDisplayMode(.inline)
        """) { AnyView(N_NavBarTitleDisplayModeExample()) },

        ExampleEntry(topic: ".navigationDestination()", code: """
        NavigationStack {
            List(recipes) { recipe in
                NavigationLink(recipe.name, value: recipe)
            }
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetail(recipe: recipe)
            }
        }
        """) { AnyView(N_NavigationDestinationExample()) },

        ExampleEntry(topic: ".navigationDocument()", code: """
        TextEditorPane(text: $draft.text)
            .navigationTitle(draft.name)
            .navigationDocument(draft.fileURL)
        """) { AnyView(N_NavigationDocumentExample()) },

        ExampleEntry(topic: ".navigationSplitViewColumnWidth()", code: """
        NavigationSplitView {
            Sidebar()
                .navigationSplitViewColumnWidth(min: 160, ideal: 200, max: 260)
        } detail: {
            MessageView()
        }
        """) { AnyView(N_NavSplitColumnWidthExample()) },

        ExampleEntry(topic: ".navigationSplitViewStyle()", code: """
        NavigationSplitView {
            MailboxList(selection: $mailbox)
        } detail: {
            MessageView(mailbox: mailbox)
        }
        .navigationSplitViewStyle(.balanced)
        """) { AnyView(N_NavSplitStyleExample()) },

        ExampleEntry(topic: ".navigationSubtitle()", code: """
        DocumentList(folder: folder)
            .navigationTitle(folder.name)
            .navigationSubtitle("\\(folder.items.count) documents")
        """) { AnyView(N_NavigationSubtitleExample()) },

        ExampleEntry(topic: ".navigationViewStyle()", code: """
        // Deprecated:
        NavigationView {
            LegacyRootList()
        }
        .navigationViewStyle(.stack)
        """) { AnyView(N_NavigationViewStyleExample()) },

        ExampleEntry(topic: ".onContinueUserActivity()", code: """
        ContentView()
            .onContinueUserActivity("com.shelf.viewingRecipe") { activity in
                guard let idString = activity.userInfo?["id"] as? String,
                      let id = UUID(uuidString: idString) else { return }
                selectedRecipeID = id
            }
        """) { AnyView(N_OnContinueUserActivityExample()) },

        ExampleEntry(topic: ".onOpenURL()", code: """
        ContentView()
            .onOpenURL { url in
                guard url.scheme == "shelf",
                      let id = UUID(uuidString: url.lastPathComponent) else { return }
                path.append(id)
            }
        """) { AnyView(N_OnOpenURLExample()) },

        ExampleEntry(topic: ".presentationBackground()", code: """
        .sheet(isPresented: $showsEditor) {
            Editor(document: $document)
                .presentationBackground {
                    LinearGradient(colors: [.indigo, .black],
                                   startPoint: .top, endPoint: .bottom)
                }
        }
        """) { AnyView(N_PresentationBackgroundExample()) },

        ExampleEntry(topic: ".presentationBackgroundInteraction()", code: """
        .sheet(isPresented: $showsSearch) {
            PlaceSearch(results: $results)
                .presentationDetents([.height(88), .medium, .large])
                .presentationBackgroundInteraction(.enabled(upThrough: .medium))
        }
        """) { AnyView(N_PresentationBackgroundInteractionExample()) },

        ExampleEntry(topic: ".presentationCompactAdaptation()", code: """
        .popover(isPresented: $showsLegend) {
            ChartLegend(series: series)
                .presentationCompactAdaptation(.popover)
        }
        """) { AnyView(N_PresentationCompactAdaptationExample()) },

        ExampleEntry(topic: ".presentationContentInteraction()", code: """
        .sheet(isPresented: $showsComments) {
            CommentList(post: post)
                .presentationDetents([.medium, .large])
                .presentationContentInteraction(.scrolls)
        }
        """) { AnyView(N_PresentationContentInteractionExample()) },

        ExampleEntry(topic: ".presentationCornerRadius()", code: """
        .sheet(isPresented: $showsDetails) {
            TicketDetails(ticket: ticket)
                .presentationDetents([.medium])
                .presentationCornerRadius(32)
        }
        """) { AnyView(N_PresentationCornerRadiusExample()) },

        ExampleEntry(topic: ".presentationDragIndicator()", code: """
        .sheet(isPresented: $showsFilters) {
            FilterList(filters: $filters)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
        """) { AnyView(N_PresentationDragIndicatorExample()) },

        ExampleEntry(topic: ".sharedBackgroundVisibility()", code: """
        .toolbar {
            ToolbarItem { Button("Edit", action: beginEditing) }
            ToolbarItem {
                Button("Delete", systemImage: "trash", role: .destructive, action: remove)
            }
            .sharedBackgroundVisibility(.hidden)
        }
        """) { AnyView(N_SharedBackgroundVisibilityExample()) },

        ExampleEntry(topic: ".toolbar(removing:)", code: """
        NavigationSplitView {
            Sidebar()
                .toolbar(removing: .sidebarToggle)
        } detail: {
            DetailView()
        }
        """) { AnyView(N_ToolbarRemovingExample()) },

        ExampleEntry(topic: ".toolbarBackgroundVisibility()", code: """
        NavigationStack {
            FullBleedMap(region: $region)
                .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
        }
        """) { AnyView(N_ToolbarBackgroundVisibilityExample()) },

        ExampleEntry(topic: ".toolbarColorScheme()", code: """
        ArtworkGrid()
            .toolbarBackground(.black, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        """) { AnyView(N_ToolbarColorSchemeExample()) },

        ExampleEntry(topic: ".toolbarRole()", code: """
        NavigationStack {
            DocumentCanvas(document: $document)
                .navigationTitle(document.name)
                .toolbarRole(.editor)
        }
        """) { AnyView(N_ToolbarRoleExample()) },

        ExampleEntry(topic: ".toolbarTitleDisplayMode()", code: """
        List(albums) { AlbumRow(album: $0) }
            .navigationTitle("Albums")
            .toolbarTitleDisplayMode(.inlineLarge)
        """) { AnyView(N_ToolbarTitleDisplayModeExample()) },

        ExampleEntry(topic: ".toolbarTitleMenu()", code: """
        .navigationTitle(document.name)
        .toolbarTitleMenu {
            RenameButton()
            Button("Duplicate", systemImage: "plus.square.on.square") { duplicate() }
            Button("Move...", systemImage: "folder") { showMove = true }
        }
        """) { AnyView(N_ToolbarTitleMenuExample()) },

        ExampleEntry(topic: ".toolbarVisibility()", code: """
        ReaderView(chapter: chapter)
            .toolbarVisibility(isImmersed ? .hidden : .visible, for: .navigationBar)
        """) { AnyView(N_ToolbarVisibilityExample()) },

        ExampleEntry(topic: ".userActivity()", code: """
        RecipeDetail(recipe: recipe)
            .userActivity("com.shelf.viewingRecipe") { activity in
                activity.title = recipe.name
                activity.userInfo = ["id": recipe.id.uuidString]
                activity.isEligibleForHandoff = true
            }
        """) { AnyView(N_UserActivityExample()) },

        ExampleEntry(topic: "Alert", code: """
        // Deprecated type:
        .alert(isPresented: $showingImportError) {
            Alert(title: Text("Import Failed"),
                  message: Text(importError.localizedDescription),
                  dismissButton: .default(Text("OK")))
        }
        """) { AnyView(N_AlertTypeExample()) },

        ExampleEntry(topic: "CustomizableToolbarContent", code: """
        .toolbar(id: "editor") {
            ToolbarItem(id: "fonts", placement: .secondaryAction) {
                FontPickerButton(selection: $font)
            }
            .defaultCustomization(.hidden, options: .alwaysAvailable)
        }
        """) { AnyView(N_CustomizableToolbarContentExample()) },

        ExampleEntry(topic: "CustomPresentationDetent", code: """
        struct MiniPlayerDetent: CustomPresentationDetent {
            static func height(in context: Context) -> CGFloat? {
                max(80, context.maxDetentValue * 0.12)
            }
        }

        .presentationDetents([.custom(MiniPlayerDetent.self), .large])
        """) { AnyView(N_CustomPresentationDetentExample()) },

        ExampleEntry(topic: "DefaultToolbarItem", code: """
        .searchable(text: $query)
        .toolbar {
            DefaultToolbarItem(kind: .search, placement: .bottomBar)
            ToolbarItem(placement: .topBarTrailing) {
                Button("Filter", systemImage: "line.3.horizontal.decrease", action: showFilters)
            }
        }
        """) { AnyView(N_DefaultToolbarItemExample()) },

        ExampleEntry(topic: "dismissWindow", code: """
        @Environment(\\.dismissWindow) private var dismissWindow

        Button("Close Statistics") {
            dismissWindow(id: "stats")
        }
        """) { AnyView(N_DismissWindowExample()) },

        ExampleEntry(topic: "isPresented", code: """
        @Environment(\\.isPresented) private var isPresented

        Text(isPresented ? "In a presentation" : "Not presented")
        """) { AnyView(N_IsPresentedExample()) },

        ExampleEntry(topic: "NavigationPath", code: """
        @State private var path = NavigationPath()

        NavigationStack(path: $path) {
            List(recipes, id: \\.self) { recipe in
                NavigationLink(recipe, value: recipe)
            }
            .navigationDestination(for: String.self) { RecipeDetail(name: $0) }
        }
        """) { AnyView(N_NavigationPathExample()) },

        ExampleEntry(topic: "NavigationSplitViewColumn", code: """
        @State private var column = NavigationSplitViewColumn.sidebar

        NavigationSplitView(preferredCompactColumn: $column) {
            LibraryList()
        } detail: {
            ReaderView()
        }
        """) { AnyView(N_NavSplitColumnExample()) },

        ExampleEntry(topic: "NavigationSplitViewVisibility", code: """
        @State private var visibility = NavigationSplitViewVisibility.doubleColumn

        NavigationSplitView(columnVisibility: $visibility) {
            Sidebar()
        } detail: {
            DetailView()
        }
        """) { AnyView(N_NavSplitVisibilityExample()) },

        ExampleEntry(topic: "newDocument", code: """
        @Environment(\\.newDocument) private var newDocument

        Button("New Markdown File") {
            newDocument(MarkdownFile(template: .meetingNotes))
        }
        """) { AnyView(N_NewDocumentExample()) },

        ExampleEntry(topic: "openDocument", code: """
        @Environment(\\.openDocument) private var openDocument

        Button("Open Recent") {
            Task { try await openDocument(at: recentURL) }
        }
        """) { AnyView(N_OpenDocumentExample()) },

        ExampleEntry(topic: "PresentationDetent", code: """
        .sheet(isPresented: $showsRoute) {
            RouteSummary(route: route)
                .presentationDetents([.height(120), .medium, .large],
                                     selection: $detent)
        }
        """) { AnyView(N_PresentationDetentExample()) },

        ExampleEntry(topic: "presentationMode", code: """
        // Deprecated:
        @Environment(\\.presentationMode) private var presentationMode

        Button("Done") {
            presentationMode.wrappedValue.dismiss()
        }
        """) { AnyView(N_PresentationModeExample()) },

        ExampleEntry(topic: "ToolbarContentBuilder", code: """
        @ToolbarContentBuilder
        private var editingItems: some ToolbarContent {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done", action: commit)
            }
            if hasChanges {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Revert", role: .destructive, action: revert)
                }
            }
        }
        """) { AnyView(N_ToolbarContentBuilderExample()) },

        ExampleEntry(topic: "ToolbarItem", code: """
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Save", systemImage: "square.and.arrow.down") { save() }
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", role: .cancel) { dismiss() }
            }
        }
        """) { AnyView(N_ToolbarItemExample()) },

        ExampleEntry(topic: "ToolbarItemGroup", code: """
        ToolbarItemGroup(placement: .bottomBar) {
            Button("Markup", systemImage: "pencil.tip.crop.circle", action: markup)
            Spacer()
            Button("Share", systemImage: "square.and.arrow.up", action: share)
        }
        """) { AnyView(N_ToolbarItemGroupExample()) },

        ExampleEntry(topic: "ToolbarItemPlacement", code: """
        ToolbarItem(placement: .primaryAction) {
            Button("Add", systemImage: "plus", action: add)
        }
        ToolbarItem(placement: .confirmationAction) {
            Button("Done", action: commit)
        }
        """) { AnyView(N_ToolbarItemPlacementExample()) },

        ExampleEntry(topic: "ToolbarPlacement", code: """
        GalleryDetail(photo: photo)
            .toolbarVisibility(.hidden, for: .tabBar)
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        """) { AnyView(N_ToolbarPlacementExample()) },

        ExampleEntry(topic: "ToolbarSpacer", code: """
        .toolbar {
            ToolbarItem { Button("Undo", systemImage: "arrow.uturn.backward", action: undo) }
            ToolbarItem { Button("Redo", systemImage: "arrow.uturn.forward", action: redo) }
            ToolbarSpacer(.fixed)
            ToolbarItem { Button("Inspector", systemImage: "sidebar.trailing", action: toggleInspector) }
        }
        """) { AnyView(N_ToolbarSpacerExample()) },
    ]
}

// MARK: - Shared helpers

private func N_note(_ text: String) -> some View {
    Text(text)
        .font(.caption2)
        .foregroundStyle(.secondary)
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
        .fixedSize(horizontal: false, vertical: true)
}

private struct N_TrafficLights: View {
    var body: some View {
        HStack(spacing: 6) {
            Circle().fill(.red).frame(width: 9, height: 9)
            Circle().fill(.yellow).frame(width: 9, height: 9)
            Circle().fill(.green).frame(width: 9, height: 9)
        }
    }
}

private struct N_Chip: View {
    var title: String? = nil
    var systemImage: String? = nil
    var tint: Color = .primary
    var filled: Bool = false

    var body: some View {
        HStack(spacing: 5) {
            if let systemImage { Image(systemName: systemImage) }
            if let title { Text(title) }
        }
        .font(.system(size: 13, weight: .medium))
        .foregroundStyle(filled ? Color.white : tint)
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(filled ? AnyShapeStyle(tint) : AnyShapeStyle(.quaternary), in: .capsule)
    }
}

private struct N_GlassGroup<Content: View>: View {
    private let content: Content
    init(@ViewBuilder content: () -> Content) { self.content = content() }

    var body: some View {
        HStack(spacing: 14) { content }
            .font(.system(size: 15, weight: .medium))
            .padding(.horizontal, 13)
            .padding(.vertical, 8)
            .background(.regularMaterial, in: .capsule)
            .overlay(Capsule().strokeBorder(.white.opacity(0.12)))
    }
}

private struct N_WindowCard<Content: View>: View {
    var title: String
    var subtitle: String? = nil
    var proxyIcon: String? = nil
    private let content: Content
    init(title: String, subtitle: String? = nil, proxyIcon: String? = nil,
         @ViewBuilder content: () -> Content) {
        self.title = title; self.subtitle = subtitle
        self.proxyIcon = proxyIcon; self.content = content()
    }

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack { N_TrafficLights(); Spacer() }
                VStack(spacing: 1) {
                    HStack(spacing: 5) {
                        if let proxyIcon {
                            Image(systemName: proxyIcon).foregroundStyle(.blue)
                        }
                        Text(title).font(.system(size: 12, weight: .semibold))
                    }
                    if let subtitle {
                        Text(subtitle).font(.system(size: 10)).foregroundStyle(.secondary)
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 7)
            .background(.regularMaterial)
            Divider()
            content
                .frame(maxWidth: .infinity)
                .padding(12)
                .background(.background)
        }
        .clipShape(.rect(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))
    }
}

private struct N_FileRow: Identifiable {
    let id = UUID()
    var name: String
    var icon: String = "doc"
    var tint: Color = .secondary
    var badge: String? = nil
    var selected: Bool = false
}

private struct N_FilePanel<Footer: View>: View {
    var pathBar: String = "Documents"
    var rows: [N_FileRow]
    var message: String? = nil
    var saveLabel: String? = nil
    var saveName: String = ""
    private let footer: Footer
    init(pathBar: String = "Documents", rows: [N_FileRow], message: String? = nil,
         saveLabel: String? = nil, saveName: String = "",
         @ViewBuilder footer: () -> Footer) {
        self.pathBar = pathBar; self.rows = rows; self.message = message
        self.saveLabel = saveLabel; self.saveName = saveName; self.footer = footer()
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 6) {
                Image(systemName: "chevron.left").foregroundStyle(.tertiary)
                Image(systemName: "chevron.right").foregroundStyle(.tertiary)
                Image(systemName: "folder.fill").foregroundStyle(.blue)
                Text(pathBar).font(.caption.weight(.medium))
                Spacer()
            }
            .padding(8)
            .background(.regularMaterial)
            Divider()
            VStack(spacing: 0) {
                ForEach(rows) { row in
                    HStack(spacing: 8) {
                        Image(systemName: row.icon).foregroundStyle(row.tint).frame(width: 16)
                        Text(row.name).font(.caption)
                        if let badge = row.badge {
                            Image(systemName: badge).font(.caption2).foregroundStyle(.secondary)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(row.selected ? AnyShapeStyle(Color.accentColor.opacity(0.18))
                                             : AnyShapeStyle(Color.clear))
                }
            }
            .padding(.vertical, 4)
            if let message {
                Divider()
                Text(message)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            if let saveLabel {
                Divider()
                HStack(spacing: 8) {
                    Text(saveLabel).font(.caption.weight(.medium)).foregroundStyle(.secondary)
                    Text(saveName)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.quaternary, in: .rect(cornerRadius: 5))
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
            }
            Divider()
            HStack(spacing: 8) { Spacer(); footer }
                .padding(8)
                .background(.regularMaterial)
        }
        .frame(width: 280)
        .background(.background)
        .clipShape(.rect(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))
    }
}

private struct N_AlertMock<Buttons: View>: View {
    var symbol: String
    var symbolColor: Color = .accentColor
    var title: String
    var message: String
    private let buttons: Buttons
    init(symbol: String, symbolColor: Color = .accentColor, title: String,
         message: String, @ViewBuilder buttons: () -> Buttons) {
        self.symbol = symbol; self.symbolColor = symbolColor
        self.title = title; self.message = message; self.buttons = buttons()
    }

    var body: some View {
        VStack(spacing: 9) {
            Image(systemName: symbol).font(.system(size: 30)).foregroundStyle(symbolColor)
            Text(title).font(.headline)
            Text(message)
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            VStack(spacing: 6) { buttons }
                .controlSize(.small)
                .padding(.top, 2)
        }
        .padding(16)
        .frame(width: 235)
        .background(.regularMaterial, in: .rect(cornerRadius: 14))
        .overlay(RoundedRectangle(cornerRadius: 14).strokeBorder(.quaternary))
    }
}

private let N_sheetShape = UnevenRoundedRectangle(
    topLeadingRadius: 18, bottomLeadingRadius: 0,
    bottomTrailingRadius: 0, topTrailingRadius: 18)

private struct N_SheetMock<Content: View>: View {
    var grabber: Bool = false
    var surface: AnyShapeStyle = AnyShapeStyle(.regularMaterial)
    var cornerRadius: CGFloat = 18
    private let content: Content
    init(grabber: Bool = false, surface: AnyShapeStyle = AnyShapeStyle(.regularMaterial),
         cornerRadius: CGFloat = 18, @ViewBuilder content: () -> Content) {
        self.grabber = grabber; self.surface = surface
        self.cornerRadius = cornerRadius; self.content = content()
    }

    var body: some View {
        let shape = UnevenRoundedRectangle(
            topLeadingRadius: cornerRadius, bottomLeadingRadius: 0,
            bottomTrailingRadius: 0, topTrailingRadius: cornerRadius)
        VStack(spacing: 8) {
            if grabber {
                Capsule().fill(.secondary).frame(width: 36, height: 5)
            }
            content
        }
        .padding(14)
        .frame(maxWidth: .infinity)
        .background(surface, in: shape)
        .overlay(shape.strokeBorder(.quaternary))
    }
}

/// Minimal document so the `newDocument` example can call the real action.
private struct N_PlainDoc: FileDocument {
    static var readableContentTypes: [UTType] { [.plainText] }
    var text: String = ""
    init() {}
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            text = String(decoding: data, as: UTF8.self)
        }
    }
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        FileWrapper(regularFileWithContents: Data(text.utf8))
    }
}

// MARK: - .dialogIcon()

private struct N_DialogIconExample: View {
    var body: some View {
        VStack(spacing: 8) {
            N_AlertMock(symbol: "externaldrive.badge.exclamationmark",
                        symbolColor: .orange,
                        title: "Reset Library?",
                        message: "This removes every imported document.") {
                Button("Reset", role: .destructive) { }
                Button("Cancel", role: .cancel) { }
            }
            N_note("Illustrative — the image replaces the app icon in a real .alert / .confirmationDialog.")
        }
    }
}

// MARK: - .dialogSeverity()

private enum N_Severity: String, CaseIterable, Identifiable {
    case standard, critical, automatic
    var id: Self { self }
}

private struct N_DialogSeverityExample: View {
    @State private var severity: N_Severity = .critical

    var body: some View {
        VStack(spacing: 10) {
            Picker("Severity", selection: $severity) {
                ForEach(N_Severity.allCases) { Text(".\($0.rawValue)").tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            N_AlertMock(symbol: severity == .critical ? "exclamationmark.triangle.fill" : "trash",
                        symbolColor: severity == .critical ? .red : .accentColor,
                        title: "Erase All Annotations?",
                        message: severity == .critical
                            ? "Caution styling for irreversible actions."
                            : "Ordinary weight for routine confirmations.") {
                Button("Erase", role: .destructive) { }
                Button("Cancel", role: .cancel) { }
            }
            N_note("Illustrative — .critical adopts the caution styling macOS reserves for dangerous operations.")
        }
    }
}

// MARK: - .dialogSuppressionToggle()

private struct N_DialogSuppressionExample: View {
    @AppStorage("n_suppressReplaceWarning") private var suppress = false

    var body: some View {
        VStack(spacing: 8) {
            N_AlertMock(symbol: "doc.on.doc",
                        title: "Replace Existing File?",
                        message: "A file with that name already exists.") {
                Button("Replace") { }
                Button("Cancel", role: .cancel) { }
                Toggle("Don't ask again", isOn: $suppress)
                    .toggleStyle(.checkbox)
                    .font(.caption)
            }
            Text("Persisted flag: \(suppress ? "true" : "false")")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
            N_note("The checkbox binds to your @AppStorage flag; your code consults it to skip the dialog next time.")
        }
    }
}

// MARK: - .fileDialogBrowserOptions()

private struct N_FileDialogBrowserOptionsExample: View {
    var body: some View {
        VStack(spacing: 8) {
            N_FilePanel(pathBar: "Project", rows: [
                N_FileRow(name: ".env", icon: "gearshape", tint: .gray),
                N_FileRow(name: ".gitignore", icon: "gearshape", tint: .gray),
                N_FileRow(name: "README.md", icon: "doc.text", tint: .blue),
                N_FileRow(name: "Package.swift", icon: "shippingbox", tint: .orange),
            ]) {
                N_Chip(title: "Cancel")
                N_Chip(title: "Open", tint: .accentColor, filled: true)
            }
            N_note("Illustrative — .includeHiddenFiles reveals dotfiles; .displayFileExtensions keeps extensions visible.")
        }
    }
}

// MARK: - .fileDialogConfirmationLabel()

private struct N_FileDialogConfirmationLabelExample: View {
    var body: some View {
        VStack(spacing: 8) {
            N_FilePanel(pathBar: "Books", rows: [
                N_FileRow(name: "Dune.pdf", icon: "doc.richtext", tint: .red, selected: true),
                N_FileRow(name: "Sapiens.pdf", icon: "doc.richtext", tint: .red),
            ]) {
                N_Chip(title: "Cancel")
                N_Chip(title: "Add to Library", tint: .accentColor, filled: true)
            }
            N_note("Illustrative — the confirm button reads \"Add to Library\" instead of the default \"Open\".")
        }
    }
}

// MARK: - .fileDialogCustomizationID()

private struct N_FileDialogCustomizationIDExample: View {
    var body: some View {
        VStack(spacing: 8) {
            N_FilePanel(pathBar: "Downloads", rows: [
                N_FileRow(name: "Reports", icon: "folder.fill", tint: .blue),
                N_FileRow(name: "Exports", icon: "folder.fill", tint: .blue),
            ], saveLabel: "Save As:", saveName: "Bookmarks.json") {
                N_Chip(title: "Cancel")
                N_Chip(title: "Save", tint: .accentColor, filled: true)
            }
            N_note("Illustrative — macOS remembers this panel's size and last folder, keyed by \"bookmarksExport\".")
        }
    }
}

// MARK: - .fileDialogDefaultDirectory()

private struct N_FileDialogDefaultDirectoryExample: View {
    var body: some View {
        VStack(spacing: 8) {
            N_FilePanel(pathBar: "Downloads", rows: [
                N_FileRow(name: "Moby-Dick.epub", icon: "book", tint: .green, selected: true),
                N_FileRow(name: "Ulysses.epub", icon: "book", tint: .green),
            ]) {
                N_Chip(title: "Cancel")
                N_Chip(title: "Open", tint: .accentColor, filled: true)
            }
            N_note("Illustrative — the panel opens in Downloads the first time; the system tracks it afterward.")
        }
    }
}

// MARK: - .fileDialogImportsUnresolvedAliases()

private struct N_FileDialogAliasesExample: View {
    var body: some View {
        VStack(spacing: 8) {
            N_FilePanel(pathBar: "Backups", rows: [
                N_FileRow(name: "Latest", icon: "doc", tint: .blue,
                          badge: "arrowshape.turn.up.left", selected: true),
                N_FileRow(name: "Snapshot.zip", icon: "doc.zipper", tint: .gray),
            ]) {
                N_Chip(title: "Cancel")
                N_Chip(title: "Open", tint: .accentColor, filled: true)
            }
            N_note("Illustrative — the alias (arrow badge) is returned as-is rather than resolved to its target.")
        }
    }
}

// MARK: - .fileDialogMessage()

private struct N_FileDialogMessageExample: View {
    var body: some View {
        VStack(spacing: 8) {
            N_FilePanel(pathBar: "Books",
                        rows: [
                            N_FileRow(name: "Dune.pdf", icon: "doc.richtext", tint: .red),
                            N_FileRow(name: "Notes.epub", icon: "book", tint: .green),
                        ],
                        message: "Choose a book to add. PDFs keep their printed contents pages.") {
                N_Chip(title: "Cancel")
                N_Chip(title: "Open", tint: .accentColor, filled: true)
            }
            N_note("Illustrative — the message appears inside the open/save panel, prominently on macOS.")
        }
    }
}

// MARK: - .fileExporter()

private struct N_FileExporterExample: View {
    var body: some View {
        VStack(spacing: 8) {
            N_FilePanel(pathBar: "Documents", rows: [
                N_FileRow(name: "Archive", icon: "folder.fill", tint: .blue),
                N_FileRow(name: "Meetings", icon: "folder.fill", tint: .blue),
            ], saveLabel: "Save As:", saveName: "Meeting Notes.txt") {
                N_Chip(title: "Cancel")
                N_Chip(title: "Save", tint: .accentColor, filled: true)
            }
            N_note("Illustrative — presents a save panel writing your FileDocument (or any Transferable item).")
        }
    }
}

// MARK: - .fileExporterFilenameLabel()

private struct N_FileExporterFilenameLabelExample: View {
    var body: some View {
        VStack(spacing: 8) {
            N_FilePanel(pathBar: "Reports", rows: [
                N_FileRow(name: "2025", icon: "folder.fill", tint: .blue),
            ], saveLabel: "Export As:", saveName: "Quarterly Report.pdf") {
                N_Chip(title: "Cancel")
                N_Chip(title: "Export", tint: .accentColor, filled: true)
            }
            N_note("Illustrative — the field label reads \"Export As:\" in place of the default \"Save As:\".")
        }
    }
}

// MARK: - .fileImporter()

private struct N_FileImporterExample: View {
    var body: some View {
        VStack(spacing: 8) {
            N_FilePanel(pathBar: "Books", rows: [
                N_FileRow(name: "Dune.pdf", icon: "doc.richtext", tint: .red, selected: true),
                N_FileRow(name: "Sapiens.pdf", icon: "doc.richtext", tint: .red, selected: true),
                N_FileRow(name: "Cover.png", icon: "photo", tint: .gray),
            ]) {
                N_Chip(title: "Cancel")
                N_Chip(title: "Open", tint: .accentColor, filled: true)
            }
            N_note("Illustrative — the system picker returns security-scoped URLs; allowsMultipleSelection permits a batch.")
        }
    }
}

// MARK: - .fileMover()

private struct N_FileMoverExample: View {
    var body: some View {
        VStack(spacing: 8) {
            N_FilePanel(pathBar: "Archive", rows: [
                N_FileRow(name: "2024", icon: "folder.fill", tint: .blue),
                N_FileRow(name: "2025", icon: "folder.fill", tint: .blue, selected: true),
            ], message: "Moving \"Draft.md\" to a new location.") {
                N_Chip(title: "Cancel")
                N_Chip(title: "Move", tint: .accentColor, filled: true)
            }
            N_note("Illustrative — the file already exists; the system moves it rather than writing new content.")
        }
    }
}

// MARK: - .handlesExternalEvents()

private struct N_HandlesExternalEventsExample: View {
    var body: some View {
        VStack(spacing: 8) {
            N_WindowCard(title: "Reader") {
                VStack(spacing: 6) {
                    Image(systemName: "book.pages").font(.system(size: 26)).foregroundStyle(.blue)
                    Label("reader://…  →  this window", systemImage: "link")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            N_note("Illustrative — applies at the Scene level; matching URLs open or reuse this window group.")
        }
    }
}

// MARK: - .inspector()

private struct N_InspectorExample: View {
    @State private var shows = true
    @State private var thickness = 3.0

    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(.blue, lineWidth: thickness)
                .frame(maxWidth: .infinity)
                .overlay(Text("Canvas").foregroundStyle(.secondary))
                .inspector(isPresented: $shows) {
                    Form {
                        Slider(value: $thickness, in: 1...10) { Text("Stroke") }
                        LabeledContent("Stroke",
                            value: thickness, format: .number.precision(.fractionLength(1)))
                    }
                    .frame(minWidth: 170)
                }
            Button(shows ? "Hide Inspector" : "Show Inspector") { shows.toggle() }
                .controlSize(.small)
        }
        .frame(height: 190)
    }
}

// MARK: - .inspectorColumnWidth()

private struct N_InspectorColumnWidthExample: View {
    @State private var shows = true

    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.blue.opacity(0.12))
                .frame(maxWidth: .infinity)
                .overlay(Text("Content").foregroundStyle(.secondary))
                .inspector(isPresented: $shows) {
                    Form {
                        Text("Attributes").font(.headline)
                        LabeledContent("Opacity", value: "80%")
                        LabeledContent("Blend", value: "Normal")
                    }
                    .inspectorColumnWidth(min: 200, ideal: 240, max: 320)
                }
            N_note("The pane is user-resizable between 200 and 320 pt; the system persists the chosen width.")
        }
        .frame(height: 190)
    }
}

// MARK: - .matchedTransitionSource()

private struct N_Swatch: Identifiable, Hashable {
    let id: Int
    let name: String
    let color: Color
}

private struct N_MatchedTransitionSourceExample: View {
    @Namespace private var gallery
    private let photos: [N_Swatch] = [
        .init(id: 0, name: "Coral", color: .pink),
        .init(id: 1, name: "Kelp", color: .green),
        .init(id: 2, name: "Tide", color: .teal),
        .init(id: 3, name: "Dusk", color: .indigo),
    ]

    var body: some View {
        NavigationStack {
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(photos) { photo in
                        NavigationLink(value: photo) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(photo.color)
                                .frame(width: 62, height: 62)
                                .matchedTransitionSource(id: photo.id, in: gallery)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(10)
            }
            .navigationDestination(for: N_Swatch.self) { photo in
                photo.color
                    .overlay(Text(photo.name).font(.title.bold()).foregroundStyle(.white))
            }
        }
        .frame(height: 130)
        .clipShape(.rect(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))
        .safeAreaInset(edge: .bottom) {
            N_note("Tap a swatch to push its detail. The .zoom transition itself renders on iOS; macOS uses a standard push.")
        }
    }
}

// MARK: - .navigationBarBackButtonHidden()

private struct N_NavBarBackButtonHiddenExample: View {
    var body: some View {
        VStack(spacing: 8) {
            VStack(spacing: 0) {
                HStack {
                    N_Chip(title: "Cancel", tint: .red)
                    Spacer()
                    Text("Payment").font(.headline)
                    Spacer()
                    Color.clear.frame(width: 54, height: 1)
                }
                .padding(.horizontal, 10).padding(.vertical, 8)
                .background(.regularMaterial)
                Divider()
                VStack(spacing: 6) {
                    Image(systemName: "creditcard").font(.system(size: 24)).foregroundStyle(.blue)
                    Text("Step 2 of 3").font(.caption).foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity).padding(14).background(.background)
            }
            .clipShape(.rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))
            N_note("Illustrative — hides the automatic back button (and back-swipe); supply your own Cancel.")
        }
    }
}

// MARK: - .navigationBarHidden()

private struct N_NavBarHiddenExample: View {
    @State private var immersed = true

    var body: some View {
        VStack(spacing: 8) {
            VStack(spacing: 0) {
                if !immersed {
                    HStack {
                        N_Chip(systemImage: "chevron.left", tint: .accentColor)
                        Spacer()
                        Text("Chapter 4").font(.headline)
                        Spacer()
                        Color.clear.frame(width: 32, height: 1)
                    }
                    .padding(.horizontal, 10).padding(.vertical, 8)
                    .background(.regularMaterial)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    Divider()
                }
                LinearGradient(colors: [.orange, .pink], startPoint: .top, endPoint: .bottom)
                    .overlay(Text("Reader").foregroundStyle(.white).font(.headline))
                    .frame(height: 90)
            }
            .clipShape(.rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))
            Toggle("Immersed (bar hidden)", isOn: $immersed.animation()).controlSize(.small)
            N_note("Deprecated — modern equivalent: .toolbarVisibility(.hidden, for: .navigationBar).")
        }
    }
}

// MARK: - .navigationBarItems()

private struct N_NavBarItemsExample: View {
    @State private var editing = false

    var body: some View {
        VStack(spacing: 8) {
            VStack(spacing: 0) {
                HStack {
                    N_Chip(title: "Close", tint: .accentColor)
                    Spacer()
                    Text("Files").font(.headline)
                    Spacer()
                    Button(editing ? "Done" : "Edit") { editing.toggle() }
                        .buttonStyle(.borderless)
                        .font(.system(size: 13, weight: .medium))
                }
                .padding(.horizontal, 10).padding(.vertical, 8)
                .background(.regularMaterial)
                Divider()
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(["Report.pdf", "Budget.numbers"], id: \.self) { name in
                        Label(name, systemImage: editing ? "minus.circle.fill" : "doc")
                            .foregroundStyle(editing ? .red : .primary)
                            .font(.caption)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(12).background(.background)
            }
            .clipShape(.rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))
            N_note("Deprecated — modern equivalent: .toolbar { ToolbarItem(placement:) } with EditButton.")
        }
    }
}

// MARK: - .navigationBarTitleDisplayMode()

private enum N_TitleMode: String, CaseIterable, Identifiable {
    case large, inline, automatic
    var id: Self { self }
}

private struct N_NavBarTitleDisplayModeExample: View {
    @State private var mode: N_TitleMode = .large

    var body: some View {
        VStack(spacing: 10) {
            Picker("Mode", selection: $mode) {
                ForEach(N_TitleMode.allCases) { Text(".\($0.rawValue)").tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            VStack(spacing: 0) {
                if mode == .inline {
                    HStack {
                        N_Chip(systemImage: "chevron.left", tint: .accentColor)
                        Spacer()
                        Text("Albums").font(.headline)
                        Spacer()
                        Color.clear.frame(width: 32, height: 1)
                    }
                    .padding(.horizontal, 10).padding(.vertical, 8)
                } else {
                    VStack(alignment: .leading, spacing: 2) {
                        HStack { N_Chip(systemImage: "chevron.left", tint: .accentColor); Spacer() }
                        Text("Albums").font(.largeTitle.bold())
                    }
                    .padding(.horizontal, 10).padding(.vertical, 8)
                }
                Divider()
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(["Discovery", "Rumours"], id: \.self) {
                        Label($0, systemImage: "music.note").font(.caption)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(12).background(.background)
            }
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))
            N_note("Illustrative — iOS / watchOS navigation bar. .large collapses to inline as content scrolls.")
        }
    }
}

// MARK: - .navigationDestination()

private struct N_NavigationDestinationExample: View {
    private let recipes = ["Focaccia", "Ramen", "Tacos", "Pho"]

    var body: some View {
        NavigationStack {
            List(recipes, id: \.self) { recipe in
                NavigationLink(recipe, value: recipe)
            }
            .navigationDestination(for: String.self) { recipe in
                VStack(spacing: 8) {
                    Image(systemName: "fork.knife.circle.fill")
                        .font(.system(size: 36)).foregroundStyle(.orange)
                    Text(recipe).font(.title2.bold())
                    Text("Pushed via navigationDestination(for:)").font(.caption).foregroundStyle(.secondary)
                }
                .padding()
            }
        }
        .frame(height: 180)
        .clipShape(.rect(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))
    }
}

// MARK: - .navigationDocument()

private struct N_NavigationDocumentExample: View {
    var body: some View {
        VStack(spacing: 8) {
            N_WindowCard(title: "Meeting Notes", proxyIcon: "doc.text.fill") {
                VStack(spacing: 6) {
                    Text("Command-click or drag the titlebar icon to reveal the file.")
                        .font(.caption).foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                    Label("~/Documents/Meeting Notes.txt", systemImage: "folder")
                        .font(.caption2).foregroundStyle(.tertiary)
                }
            }
            N_note("Illustrative — the URL produces the macOS titlebar proxy icon and feeds the title menu.")
        }
    }
}

// MARK: - .navigationSplitViewColumnWidth()

private struct N_NavSplitColumnWidthExample: View {
    @State private var selection: String? = "Design"

    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                ForEach(["Inbox", "Design", "Shipping"], id: \.self) { Text($0) }
            }
            .navigationSplitViewColumnWidth(min: 120, ideal: 150, max: 200)
        } detail: {
            VStack(spacing: 6) {
                Text(selection ?? "—").font(.title3.bold())
                Text("Sidebar is bounded 120…200 pt").font(.caption).foregroundStyle(.secondary)
            }
        }
        .frame(height: 160)
        .clipShape(.rect(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))
    }
}

// MARK: - .navigationSplitViewStyle()

private enum N_SplitStyle: String, CaseIterable, Identifiable {
    case balanced, prominentDetail, automatic
    var id: Self { self }
}

private struct N_NavSplitStyleExample: View {
    @State private var style: N_SplitStyle = .balanced
    @State private var mailbox: String? = "Work"

    var body: some View {
        VStack(spacing: 8) {
            Picker("Style", selection: $style) {
                ForEach(N_SplitStyle.allCases) { Text(".\($0.rawValue)").tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            let split = NavigationSplitView {
                List(selection: $mailbox) {
                    ForEach(["Work", "Personal"], id: \.self) { Text($0) }
                }
            } detail: {
                Text(mailbox ?? "—")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.blue.opacity(0.1))
            }

            Group {
                switch style {
                case .balanced:        split.navigationSplitViewStyle(.balanced)
                case .prominentDetail: split.navigationSplitViewStyle(.prominentDetail)
                case .automatic:       split.navigationSplitViewStyle(.automatic)
                }
            }
            .frame(height: 140)
            .clipShape(.rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))
        }
    }
}

// MARK: - .navigationSubtitle()

private struct N_NavigationSubtitleExample: View {
    var body: some View {
        VStack(spacing: 8) {
            N_WindowCard(title: "Invoices", subtitle: "24 documents") {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(["INV-0012.pdf", "INV-0013.pdf"], id: \.self) {
                        Label($0, systemImage: "doc.text").font(.caption)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            N_note("Illustrative — renders under the title (macOS always; iPhone / iPad since 2025).")
        }
    }
}

// MARK: - .navigationViewStyle()

private struct N_NavigationViewStyleExample: View {
    private let items = ["Overview", "Members", "Settings"]

    var body: some View {
        VStack(spacing: 8) {
            NavigationStack {
                List(items, id: \.self) { item in
                    NavigationLink(item, value: item)
                }
                .navigationDestination(for: String.self) { item in
                    Text(item).font(.title3.bold()).padding()
                }
            }
            .frame(height: 150)
            .clipShape(.rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))
            N_note("Deprecated — NavigationView + .navigationViewStyle(.stack) is now NavigationStack (shown).")
        }
    }
}

// MARK: - .onContinueUserActivity()

private struct N_OnContinueUserActivityExample: View {
    @State private var selectedRecipeID: UUID?
    @State private var log = "Waiting for a handoff activity…"
    private let recipeID = UUID()

    var body: some View {
        VStack(spacing: 10) {
            Label(log, systemImage: "arrow.right.arrow.left.circle")
                .font(.caption)
                .foregroundStyle(selectedRecipeID == nil ? .secondary : .primary)
                .frame(maxWidth: .infinity, alignment: .leading)

            Button("Simulate incoming activity") {
                // The same parsing the real .onContinueUserActivity closure runs:
                let userInfo: [String: Any] = ["id": recipeID.uuidString]
                if let idString = userInfo["id"] as? String,
                   let id = UUID(uuidString: idString) {
                    selectedRecipeID = id
                    log = "Restored recipe \(id.uuidString.prefix(8))…"
                }
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.small)

            N_note("The real trigger is an NSUserActivity from Handoff or a Spotlight result; register it high in the scene.")
        }
    }
}

// MARK: - .onOpenURL()

private struct N_OnOpenURLExample: View {
    @State private var path: [UUID] = []
    @State private var log = "No deep link handled yet."
    private let sample = URL(string: "shelf://\(UUID().uuidString)")!

    var body: some View {
        VStack(spacing: 10) {
            Text(sample.absoluteString)
                .font(.caption2.monospaced())
                .lineLimit(1)
                .truncationMode(.middle)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)

            Button("Open URL") {
                // Same validation the real .onOpenURL closure performs:
                if sample.scheme == "shelf",
                   let id = UUID(uuidString: sample.lastPathComponent) {
                    path.append(id)
                    log = "Pushed route \(id.uuidString.prefix(8))…  (stack depth \(path.count))"
                }
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.small)

            Text(log).font(.caption).foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            N_note("Validate the URL before acting on it — any process on the system can send one.")
        }
    }
}

// MARK: - .presentationBackground()

private struct N_PresentationBackgroundExample: View {
    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .bottom) {
                LinearGradient(colors: [.mint, .cyan], startPoint: .top, endPoint: .bottom)
                    .frame(height: 40)
                N_SheetMock(grabber: true,
                            surface: AnyShapeStyle(
                                LinearGradient(colors: [.indigo, .black],
                                               startPoint: .top, endPoint: .bottom))) {
                    VStack(spacing: 6) {
                        Text("Editor").font(.headline).foregroundStyle(.white)
                        Text("The gradient fills the sheet container itself.")
                            .font(.caption).foregroundStyle(.white.opacity(0.75))
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .clipShape(.rect(cornerRadius: 10))
            N_note("Illustrative — styles the presented sheet's container, not a background inside its content.")
        }
    }
}

// MARK: - .presentationBackgroundInteraction()

private struct N_PresentationBackgroundInteractionExample: View {
    @State private var pin = 0.35

    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .bottom) {
                LinearGradient(colors: [.green.opacity(0.5), .blue.opacity(0.5)],
                               startPoint: .top, endPoint: .bottom)
                    .overlay(alignment: .top) {
                        Slider(value: $pin, in: 0...1) { Text("Map still pans") }
                            .labelsHidden().tint(.white).padding(8)
                    }
                    .frame(height: 150)
                N_SheetMock(grabber: true) {
                    VStack(spacing: 4) {
                        Text("Place Search").font(.subheadline.bold())
                        Text("Background stays interactive up through .medium")
                            .font(.caption2).foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .clipShape(.rect(cornerRadius: 10))
            N_note("Illustrative — .enabled(upThrough:) lets touches reach the map while the sheet rests low.")
        }
    }
}

// MARK: - .presentationCompactAdaptation()

private struct N_PresentationCompactAdaptationExample: View {
    var body: some View {
        VStack(spacing: 8) {
            VStack(spacing: 0) {
                HStack { Spacer(); N_Chip(systemImage: "chart.pie", tint: .accentColor) }
                    .padding(.horizontal, 10)
                VStack(alignment: .leading, spacing: 5) {
                    Text("Legend").font(.caption.bold())
                    Label("Revenue", systemImage: "circle.fill").foregroundStyle(.blue)
                    Label("Costs", systemImage: "circle.fill").foregroundStyle(.orange)
                }
                .font(.caption2)
                .padding(10)
                .background(.regularMaterial, in: .rect(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))
                .overlay(alignment: .top) {
                    Triangle().fill(.regularMaterial).frame(width: 16, height: 8).offset(y: -7)
                }
                .padding(.top, 8)
            }
            N_note("Illustrative — .popover keeps true popover chrome even on a compact iPhone width (default: a sheet).")
        }
    }
}

private struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.midX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        p.closeSubpath()
        return p
    }
}

// MARK: - .presentationContentInteraction()

private struct N_PresentationContentInteractionExample: View {
    var body: some View {
        VStack(spacing: 8) {
            N_SheetMock(grabber: true) {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text("Comments").font(.subheadline.bold())
                        Spacer()
                        Image(systemName: "arrow.up.and.down.text.horizontal")
                            .foregroundStyle(.secondary)
                    }
                    ForEach(["Great write-up!", "Agreed — shipping it.", "One nit on line 4."], id: \.self) {
                        Text($0).font(.caption).padding(6)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.quaternary, in: .rect(cornerRadius: 6))
                    }
                }
            }
            N_note("Illustrative — .scrolls lets an upward swipe scroll the list first, expanding the sheet only at the top.")
        }
    }
}

// MARK: - .presentationCornerRadius()

private struct N_PresentationCornerRadiusExample: View {
    @State private var radius = 32.0

    var body: some View {
        VStack(spacing: 8) {
            Slider(value: $radius, in: 0...48) { Text("Corner radius") }
                .labelsHidden()
            N_SheetMock(grabber: true, cornerRadius: radius) {
                VStack(spacing: 4) {
                    Text("Ticket Details").font(.subheadline.bold())
                    Text("presentationCornerRadius(\(Int(radius)))")
                        .font(.caption2.monospaced()).foregroundStyle(.secondary)
                }
            }
            N_note("Illustrative — overrides the sheet container's top corner radius; nil restores the system value.")
        }
    }
}

// MARK: - .presentationDragIndicator()

private struct N_PresentationDragIndicatorExample: View {
    var body: some View {
        VStack(spacing: 8) {
            N_SheetMock(grabber: true) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Filters").font(.subheadline.bold())
                    Toggle("Unread only", isOn: .constant(true))
                    Toggle("Flagged", isOn: .constant(false))
                }
                .font(.caption)
                .toggleStyle(.switch)
                .controlSize(.mini)
            }
            N_note("The grabber capsule signals the sheet is resizable; force it with .visible or remove it with .hidden.")
        }
    }
}

// MARK: - .sharedBackgroundVisibility()

private struct N_SharedBackgroundVisibilityExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                N_GlassGroup {
                    Image(systemName: "pencil")
                    Image(systemName: "square.on.square")
                }
                N_GlassGroup {
                    Image(systemName: "trash").foregroundStyle(.red)
                }
            }
            N_note("Illustrative — Delete uses .sharedBackgroundVisibility(.hidden), so it sits on its own capsule.")
        }
        .padding(.vertical, 6)
    }
}

// MARK: - .toolbar(removing:)

private struct N_ToolbarRemovingExample: View {
    var body: some View {
        VStack(spacing: 8) {
            VStack(spacing: 0) {
                HStack(spacing: 8) {
                    Image(systemName: "sidebar.leading")
                        .foregroundStyle(.tertiary)
                        .overlay(
                            Image(systemName: "line.diagonal")
                                .foregroundStyle(.red).font(.system(size: 18)))
                    Text("Sidebar toggle removed").font(.caption).foregroundStyle(.secondary)
                    Spacer()
                    N_Chip(systemImage: "plus", tint: .accentColor)
                }
                .padding(.horizontal, 10).padding(.vertical, 8)
                .background(.regularMaterial)
                Divider()
                HStack(spacing: 0) {
                    VStack { Text("Sidebar").font(.caption) }
                        .frame(maxWidth: 90, maxHeight: .infinity).background(.quaternary)
                    Divider()
                    VStack { Text("Detail").font(.caption).foregroundStyle(.secondary) }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(height: 70).background(.background)
            }
            .clipShape(.rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))
            N_note("Illustrative — removes only the framework's default .sidebarToggle item, not the whole bar.")
        }
    }
}

// MARK: - .toolbarBackgroundVisibility()

private struct N_ToolbarBackgroundVisibilityExample: View {
    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .top) {
                LinearGradient(colors: [.green, .teal, .blue],
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                HStack {
                    N_Chip(systemImage: "chevron.left", tint: .white)
                    Spacer()
                    N_Chip(systemImage: "location", tint: .white)
                }
                .padding(.horizontal, 10).padding(.vertical, 8)
            }
            .frame(height: 110)
            .clipShape(.rect(cornerRadius: 10))
            N_note("Illustrative — .hidden drops the bar's material so map/photo content runs edge to edge under floating items.")
        }
    }
}

// MARK: - .toolbarColorScheme()

private struct N_ToolbarColorSchemeExample: View {
    var body: some View {
        VStack(spacing: 8) {
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "chevron.left")
                    Spacer()
                    Text("Artwork").font(.headline)
                    Spacer()
                    Image(systemName: "square.and.arrow.up")
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 12).padding(.vertical, 9)
                .background(.black)
                Divider()
                LinearGradient(colors: [.purple, .pink], startPoint: .top, endPoint: .bottom)
                    .frame(height: 70)
            }
            .clipShape(.rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))
            N_note("Illustrative — forces light glyphs on a dark bar, independent of the content's color scheme.")
        }
    }
}

// MARK: - .toolbarRole()

private enum N_Role: String, CaseIterable, Identifiable {
    case editor, browser, navigationStack
    var id: Self { self }
}

private struct N_ToolbarRoleExample: View {
    @State private var role: N_Role = .editor

    var body: some View {
        VStack(spacing: 10) {
            Picker("Role", selection: $role) {
                ForEach(N_Role.allCases) { Text(".\($0.rawValue)").tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            HStack {
                N_Chip(systemImage: "chevron.left", tint: .accentColor)
                if role == .editor {
                    Text("Proposal.doc").font(.headline)
                    Spacer()
                } else {
                    Spacer()
                    Text(role == .browser ? "Article" : "Detail").font(.headline)
                    Spacer()
                }
                N_Chip(systemImage: "square.and.arrow.up", tint: .accentColor)
            }
            .padding(.horizontal, 10).padding(.vertical, 9)
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))
            N_note("Illustrative — .editor shifts the title to the leading edge (iPad); .browser mirrors Safari.")
        }
    }
}

// MARK: - .toolbarTitleDisplayMode()

private enum N_TitleDisplay: String, CaseIterable, Identifiable {
    case large, inline, inlineLarge
    var id: Self { self }
}

private struct N_ToolbarTitleDisplayModeExample: View {
    @State private var mode: N_TitleDisplay = .inlineLarge

    var body: some View {
        VStack(spacing: 10) {
            Picker("Mode", selection: $mode) {
                ForEach(N_TitleDisplay.allCases) { Text(".\($0.rawValue)").tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            Group {
                switch mode {
                case .inline:
                    HStack { Spacer(); Text("Albums").font(.headline); Spacer() }
                case .large:
                    HStack { Text("Albums").font(.largeTitle.bold()); Spacer() }
                case .inlineLarge:
                    HStack { Text("Albums").font(.title2.bold()); Spacer() }
                }
            }
            .padding(.horizontal, 12).padding(.vertical, 9)
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))
            N_note("Cross-platform (iOS/macOS/watchOS). .inlineLarge keeps a large title pinned, as document apps do.")
        }
    }
}

// MARK: - .toolbarTitleMenu()

private struct N_ToolbarTitleMenuExample: View {
    @State private var lastAction = "none"

    var body: some View {
        VStack(spacing: 10) {
            Menu {
                Button("Rename", systemImage: "pencil") { lastAction = "Rename" }
                Button("Duplicate", systemImage: "plus.square.on.square") { lastAction = "Duplicate" }
                Button("Move…", systemImage: "folder") { lastAction = "Move" }
            } label: {
                HStack(spacing: 4) {
                    Text("Proposal.md").font(.headline)
                    Image(systemName: "chevron.down").font(.caption.weight(.bold))
                }
            }
            .menuStyle(.borderlessButton)
            .fixedSize()

            Text("Last action: \(lastAction)").font(.caption).foregroundStyle(.secondary)
            N_note("Illustrative — attaches a menu to the navigation title; RenameButton wires into inline rename there.")
        }
    }
}

// MARK: - .toolbarVisibility()

private struct N_ToolbarVisibilityExample: View {
    @State private var immersed = false

    var body: some View {
        VStack(spacing: 8) {
            VStack(spacing: 0) {
                if !immersed {
                    HStack {
                        N_Chip(systemImage: "chevron.left", tint: .accentColor)
                        Spacer()
                        Text("Chapter 7").font(.subheadline.weight(.semibold))
                        Spacer()
                        N_Chip(systemImage: "textformat.size", tint: .accentColor)
                    }
                    .padding(.horizontal, 10).padding(.vertical, 8)
                    .background(.regularMaterial)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    Divider()
                }
                LinearGradient(colors: [.brown.opacity(0.35), .orange.opacity(0.25)],
                               startPoint: .top, endPoint: .bottom)
                    .overlay(Text("“Call me Ishmael…”").italic().foregroundStyle(.secondary))
                    .frame(height: 84)
            }
            .clipShape(.rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))
            Toggle("Immersed", isOn: $immersed.animation()).controlSize(.small)
            N_note("Shows or hides whole system bars (navigation bar, tab bar) — the 2024 rename of toolbar(_:for:).")
        }
    }
}

// MARK: - .userActivity()

private struct N_UserActivityExample: View {
    var body: some View {
        VStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 7) {
                Label("Advertising activity", systemImage: "dot.radiowaves.right")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.blue)
                Divider()
                Group {
                    LabeledContent("type", value: "com.shelf.viewingRecipe")
                    LabeledContent("title", value: "Focaccia")
                    LabeledContent("userInfo.id", value: "F1A9…")
                    HStack {
                        Text("Handoff").foregroundStyle(.secondary)
                        Spacer()
                        Image(systemName: "checkmark.seal.fill").foregroundStyle(.green)
                    }
                }
                .font(.caption2.monospaced())
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.regularMaterial, in: .rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))
            N_note("Illustrative — while the view is visible, the system keeps this activity current for Handoff & Spotlight.")
        }
    }
}

// MARK: - Alert (deprecated type)

private struct N_AlertTypeExample: View {
    var body: some View {
        VStack(spacing: 8) {
            N_AlertMock(symbol: "exclamationmark.triangle.fill",
                        symbolColor: .orange,
                        title: "Import Failed",
                        message: "The file could not be read.") {
                Button("OK") { }
            }
            N_note("Deprecated type — modern .alert modifiers take a Button view builder (shown here) and support text fields.")
        }
    }
}

// MARK: - CustomizableToolbarContent

private struct N_CustomizableToolbarContentExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 10) {
                N_GlassGroup {
                    Image(systemName: "bold")
                    Image(systemName: "italic")
                }
                N_GlassGroup {
                    Image(systemName: "textformat").foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "slider.horizontal.3").foregroundStyle(.tertiary)
            }
            .padding(.horizontal, 6)
            HStack(spacing: 6) {
                Image(systemName: "hand.point.up.left").font(.caption2)
                Text("Right-click the toolbar → Customize Toolbar")
                    .font(.caption2)
            }
            .foregroundStyle(.secondary)
            N_note("Illustrative — items given stable ids in .toolbar(id:) can be rearranged, removed, and re-added by the user.")
        }
    }
}

// MARK: - CustomPresentationDetent

private struct N_MiniPlayerDetent: CustomPresentationDetent {
    static func height(in context: Context) -> CGFloat? {
        max(80, context.maxDetentValue * 0.12)
    }
}

private struct N_CustomPresentationDetentExample: View {
    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .bottom) {
                LinearGradient(colors: [.pink.opacity(0.35), .purple.opacity(0.25)],
                               startPoint: .top, endPoint: .bottom)
                    .frame(height: 130)
                N_SheetMock(grabber: true) {
                    HStack(spacing: 10) {
                        RoundedRectangle(cornerRadius: 6).fill(.purple).frame(width: 30, height: 30)
                        VStack(alignment: .leading, spacing: 1) {
                            Text("Now Playing").font(.caption.bold())
                            Text("max(80, maxDetentValue × 0.12)")
                                .font(.caption2.monospaced()).foregroundStyle(.secondary)
                        }
                        Spacer()
                        Image(systemName: "play.fill")
                    }
                }
            }
            .clipShape(.rect(cornerRadius: 10))
            N_note("Illustrative — a CustomPresentationDetent computes its height from the live presentation Context.")
        }
    }
}

// MARK: - DefaultToolbarItem

private struct N_DefaultToolbarItemExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                HStack(spacing: 6) {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .font(.system(size: 13))
                .foregroundStyle(.secondary)
                .padding(.horizontal, 12).padding(.vertical, 7)
                .background(.quaternary, in: .capsule)
                Spacer()
                N_Chip(systemImage: "line.3.horizontal.decrease", tint: .accentColor)
            }
            .padding(.horizontal, 10).padding(.vertical, 8)
            .background(.regularMaterial, in: .capsule)
            .overlay(Capsule().strokeBorder(.quaternary))
            N_note("Illustrative — repositions the system search field (from .searchable) within the 2025 toolbar layout.")
        }
    }
}

// MARK: - dismissWindow

private struct N_DismissWindowExample: View {
    @Environment(\.dismissWindow) private var dismissWindow

    var body: some View {
        VStack(spacing: 8) {
            N_WindowCard(title: "Statistics") {
                VStack(spacing: 8) {
                    Image(systemName: "chart.bar.xaxis").font(.system(size: 24)).foregroundStyle(.blue)
                    Button("Close Statistics") { dismissWindow(id: "stats") }
                        .controlSize(.small)
                }
            }
            N_note("Reads @Environment(\\.dismissWindow); at runtime it closes the window scene with id \"stats\".")
        }
    }
}

// MARK: - isPresented

private struct N_IsPresentedExample: View {
    @Environment(\.isPresented) private var isPresented

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                Circle()
                    .fill(isPresented ? .green : .secondary)
                    .frame(width: 14, height: 14)
                Text(isPresented ? "In a presentation" : "Not presented")
                    .font(.title3.weight(.semibold))
            }
            Text("isPresented = \(isPresented ? "true" : "false")")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
            N_note("Live value — reads true only when the view is hosted inside an active sheet, popover, or cover.")
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }
}

// MARK: - NavigationPath

private struct N_NavigationPathExample: View {
    @State private var path = NavigationPath()
    private let recipes = ["Focaccia", "Ramen", "Tacos"]

    var body: some View {
        VStack(spacing: 8) {
            NavigationStack(path: $path) {
                List(recipes, id: \.self) { recipe in
                    NavigationLink(recipe, value: recipe)
                }
                .navigationDestination(for: String.self) { recipe in
                    VStack(spacing: 6) {
                        Text(recipe).font(.title3.bold())
                        Text("Depth \(path.count)").font(.caption).foregroundStyle(.secondary)
                    }
                }
            }
            .frame(height: 120)
            .clipShape(.rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))

            HStack {
                Button("Push Ramen") { path.append("Ramen") }
                Button("Pop") { if !path.isEmpty { path.removeLast() } }
                    .disabled(path.isEmpty)
                Spacer()
                Text("count: \(path.count)").font(.caption.monospaced()).foregroundStyle(.secondary)
            }
            .controlSize(.small)
        }
    }
}

// MARK: - NavigationSplitViewColumn

private struct N_NavSplitColumnExample: View {
    @State private var column = NavigationSplitViewColumn.sidebar

    var body: some View {
        VStack(spacing: 8) {
            NavigationSplitView(preferredCompactColumn: $column) {
                List { Text("Library"); Text("Recents") }
            } detail: {
                Text("Reader")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.blue.opacity(0.1))
            }
            .frame(height: 120)
            .clipShape(.rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))

            HStack {
                Button("Prefer sidebar") { column = .sidebar }
                Button("Prefer detail") { column = .detail }
                Spacer()
                Text(column == .detail ? "detail" : "sidebar")
                    .font(.caption.monospaced()).foregroundStyle(.secondary)
            }
            .controlSize(.small)
            N_note("preferredCompactColumn picks the frontmost column once the split view collapses to one (narrow widths).")
        }
    }
}

// MARK: - NavigationSplitViewVisibility

private struct N_NavSplitVisibilityExample: View {
    @State private var visibility = NavigationSplitViewVisibility.doubleColumn

    var body: some View {
        VStack(spacing: 8) {
            NavigationSplitView(columnVisibility: $visibility) {
                List { Text("Inbox"); Text("Flagged") }
            } detail: {
                Text("Message")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.blue.opacity(0.1))
            }
            .frame(height: 120)
            .clipShape(.rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))

            HStack {
                Button(".all") { withAnimation { visibility = .all } }
                Button(".doubleColumn") { withAnimation { visibility = .doubleColumn } }
                Button(".detailOnly") { withAnimation { visibility = .detailOnly } }
            }
            .controlSize(.small)
            .buttonStyle(.bordered)
        }
    }
}

// MARK: - newDocument

private struct N_NewDocumentExample: View {
    @Environment(\.newDocument) private var newDocument

    var body: some View {
        VStack(spacing: 8) {
            N_WindowCard(title: "Untitled") {
                VStack(spacing: 8) {
                    Image(systemName: "doc.badge.plus").font(.system(size: 24)).foregroundStyle(.blue)
                    Button("New Markdown File") { newDocument(N_PlainDoc()) }
                        .controlSize(.small)
                }
            }
            N_note("Reads @Environment(\\.newDocument); in a DocumentGroup app it opens a fresh untitled window (macOS).")
        }
    }
}

// MARK: - openDocument

private struct N_OpenDocumentExample: View {
    @Environment(\.openDocument) private var openDocument

    var body: some View {
        VStack(spacing: 8) {
            N_WindowCard(title: "Recents") {
                VStack(spacing: 8) {
                    Label("Meeting Notes.md", systemImage: "doc.text").font(.caption)
                    Button("Open Recent") {
                        Task { try? await openDocument(at: URL(filePath: "/tmp/Meeting Notes.md")) }
                    }
                    .controlSize(.small)
                }
            }
            N_note("Reads @Environment(\\.openDocument); the async action opens the file in its own document window (macOS).")
        }
    }
}

// MARK: - PresentationDetent

private enum N_Detent: String, CaseIterable, Identifiable {
    case small = "height(120)", medium, large
    var id: Self { self }
    var height: CGFloat {
        switch self {
        case .small: 60
        case .medium: 110
        case .large: 170
        }
    }
}

private struct N_PresentationDetentExample: View {
    @State private var detent: N_Detent = .medium

    var body: some View {
        VStack(spacing: 8) {
            Picker("Detent", selection: $detent) {
                ForEach(N_Detent.allCases) { Text(".\($0.rawValue)").tag($0) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()

            ZStack(alignment: .bottom) {
                Color.blue.opacity(0.08).frame(height: 190)
                N_SheetMock(grabber: true) {
                    VStack(spacing: 4) {
                        Text("Route Summary").font(.subheadline.bold())
                        Text("Resizes between its detents").font(.caption2).foregroundStyle(.secondary)
                    }
                }
                .frame(height: detent.height, alignment: .top)
                .animation(.spring(duration: 0.35), value: detent)
                .clipped()
            }
            .clipShape(.rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))
            N_note("Multiple detents (.height, .medium, .large) make the sheet resizable; a selection binding tracks the stop.")
        }
    }
}

// MARK: - presentationMode (deprecated)

private struct N_PresentationModeExample: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 8) {
            N_SheetMock(grabber: true) {
                VStack(spacing: 8) {
                    Text("Settings").font(.subheadline.bold())
                    Button("Done") { dismiss() }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.small)
                }
            }
            N_note("Deprecated — modern equivalent: @Environment(\\.dismiss) (shown) with @Environment(\\.isPresented).")
        }
    }
}

// MARK: - ToolbarContentBuilder

private struct N_ToolbarContentBuilderExample: View {
    @State private var hasChanges = true

    // The real builder this example illustrates:
    @ToolbarContentBuilder
    private var editingItems: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button("Done") { }
        }
        if hasChanges {
            ToolbarItem(placement: .cancellationAction) {
                Button("Revert", role: .destructive) { }
            }
        }
    }

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                if hasChanges { N_Chip(title: "Revert", tint: .red) }
                Spacer()
                N_Chip(title: "Done", tint: .accentColor, filled: true)
            }
            .padding(.horizontal, 10).padding(.vertical, 9)
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))

            Toggle("Has changes", isOn: $hasChanges.animation()).controlSize(.small)
            N_note("Illustrative — @ToolbarContentBuilder assembles items and supports conditionals, like ViewBuilder.")
        }
    }
}

// MARK: - ToolbarItem

private struct N_ToolbarItemExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                N_Chip(title: "Cancel", tint: .accentColor)
                Spacer()
                N_Chip(title: "Save", systemImage: "square.and.arrow.down",
                       tint: .accentColor, filled: true)
            }
            .padding(.horizontal, 10).padding(.vertical, 9)
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))
            N_note("Illustrative — a semantic placement (.primaryAction, .cancellationAction) maps to each platform's slot.")
        }
    }
}

// MARK: - ToolbarItemGroup

private struct N_ToolbarItemGroupExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                N_Chip(systemImage: "pencil.tip.crop.circle", tint: .accentColor)
                Spacer()
                N_Chip(systemImage: "square.and.arrow.up", tint: .accentColor)
            }
            .padding(.horizontal, 12).padding(.vertical, 9)
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))
            N_note("Illustrative — several controls under one placement; a Spacer spreads them across the bottom bar.")
        }
    }
}

// MARK: - ToolbarItemPlacement

private struct N_ToolbarItemPlacementExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                VStack(spacing: 2) {
                    N_Chip(systemImage: "chevron.left", tint: .accentColor)
                    Text(".cancellationAction").font(.system(size: 8)).foregroundStyle(.secondary)
                }
                Spacer()
                VStack(spacing: 2) {
                    Text("Title").font(.subheadline.weight(.semibold))
                    Text(".principal").font(.system(size: 8)).foregroundStyle(.secondary)
                }
                Spacer()
                VStack(spacing: 2) {
                    N_Chip(systemImage: "plus", tint: .accentColor)
                    Text(".primaryAction").font(.system(size: 8)).foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal, 10).padding(.vertical, 8)
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))
            N_note("Illustrative — semantic roles map to platform-correct positions; prefer them over fixed edges.")
        }
    }
}

// MARK: - ToolbarPlacement

private struct N_ToolbarPlacementExample: View {
    var body: some View {
        VStack(spacing: 6) {
            barRow("navigationBar", "chevron.left", "square.and.arrow.up")
            content
            HStack(spacing: 0) {
                tabItem("house.fill"); tabItem("magnifyingglass"); tabItem("person.fill")
            }
            .padding(.vertical, 6)
            .background(.regularMaterial)
            .overlay(Text(".tabBar").font(.system(size: 8)).foregroundStyle(.secondary)
                        .padding(.trailing, 6), alignment: .trailing)
        }
        .clipShape(.rect(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.quaternary))
        .overlay(alignment: .bottom) {
            N_note("Identifies which bar a modifier targets: .navigationBar, .tabBar, .bottomBar, .windowToolbar.")
                .padding(.top, 4).offset(y: 34)
        }
        .padding(.bottom, 34)
    }

    private func barRow(_ label: String, _ lead: String, _ trail: String) -> some View {
        HStack {
            Image(systemName: lead)
            Spacer()
            Text(".\(label)").font(.system(size: 9)).foregroundStyle(.secondary)
            Spacer()
            Image(systemName: trail)
        }
        .font(.caption)
        .padding(.horizontal, 10).padding(.vertical, 7)
        .background(.regularMaterial)
    }

    private var content: some View {
        Text("Content")
            .font(.caption).foregroundStyle(.secondary)
            .frame(maxWidth: .infinity).frame(height: 40)
            .background(.background)
    }

    private func tabItem(_ symbol: String) -> some View {
        Image(systemName: symbol)
            .font(.caption)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity)
    }
}

// MARK: - ToolbarSpacer

private struct N_ToolbarSpacerExample: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 16) {
                N_GlassGroup {
                    Image(systemName: "arrow.uturn.backward")
                    Image(systemName: "arrow.uturn.forward")
                }
                N_GlassGroup {
                    Image(systemName: "sidebar.trailing")
                }
            }
            N_note("Illustrative — a ToolbarSpacer breaks the merged Liquid Glass capsule: .fixed for a gap, .flexible to push apart.")
        }
        .padding(.vertical, 6)
    }
}
