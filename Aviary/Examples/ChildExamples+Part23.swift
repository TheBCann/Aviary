//
//  ChildExamples+Part23.swift
//  Aviary
//
//  Compiled renderings for variant entries (part 23: gen-navpres).
//  One private C23_* struct per variant; every rendering exercises the exact
//  overload the variant names, so siblings can be compared side by side.
//

import SwiftUI
import Foundation
import UniformTypeIdentifiers

enum ChildExamplesPart23 {
    static let entries: [ChildExampleEntry] = [

        // MARK: .dialogSeverity()

        ChildExampleEntry(parent: ".dialogSeverity()", child: ".standard", code: """
        Button("Remove Bookmark…") { confirming = true }
            .alert("Remove Bookmark?", isPresented: $confirming) {
                Button("Remove", role: .destructive) { bookmarks -= 1 }
                Button("Cancel", role: .cancel) { }
            }
            .dialogSeverity(.standard)
        """) { AnyView(C23_DialogSeverityStandardExample()) },

        ChildExampleEntry(parent: ".dialogSeverity()", child: ".critical", code: """
        Button("Erase All Annotations…") { confirming = true }
            .alert("Erase All Annotations?", isPresented: $confirming) {
                Button("Erase", role: .destructive) { annotations = 0 }
                Button("Cancel", role: .cancel) { }
            }
            .dialogSeverity(.critical)
        """) { AnyView(C23_DialogSeverityCriticalExample()) },

        ChildExampleEntry(parent: ".dialogSeverity()", child: ".automatic", code: """
        Button("Sign Out…") { confirming = true }
            .alert("Sign Out?", isPresented: $confirming) {
                Button("Sign Out") { signedIn = false }
                Button("Cancel", role: .cancel) { }
            }
            .dialogSeverity(.automatic)
        """) { AnyView(C23_DialogSeverityAutomaticExample()) },

        // MARK: .dialogSuppressionToggle()

        ChildExampleEntry(parent: ".dialogSuppressionToggle()", child: "dialogSuppressionToggle(isSuppressed:)", code: """
        Button("Export") {
            if suppressReplaceWarning { performExport() } else { confirmingReplace = true }
        }
        .alert("Replace Existing File?", isPresented: $confirmingReplace) {
            Button("Replace") { performExport() }
            Button("Cancel", role: .cancel) { }
        }
        .dialogSuppressionToggle(isSuppressed: $suppressReplaceWarning)
        """) { AnyView(C23_SuppressionToggleDefaultExample()) },

        ChildExampleEntry(parent: ".dialogSuppressionToggle()", child: "dialogSuppressionToggle(_:isSuppressed:)", code: """
        Button("Export") {
            if suppressReplaceWarning { performExport() } else { confirmingReplace = true }
        }
        .alert("Replace Existing File?", isPresented: $confirmingReplace) {
            Button("Replace") { performExport() }
            Button("Cancel", role: .cancel) { }
        }
        .dialogSuppressionToggle("Don't warn me before replacing files",
                                 isSuppressed: $suppressReplaceWarning)
        """) { AnyView(C23_SuppressionToggleLabeledExample()) },

        // MARK: .fileDialogBrowserOptions()

        ChildExampleEntry(parent: ".fileDialogBrowserOptions()", child: "FileDialogBrowserOptions.includeHiddenFiles", code: """
        Button("Open File…") { importing = true }
            .fileImporter(isPresented: $importing, allowedContentTypes: [.item]) { result in
                if case .success(let url) = result { chosen = url.lastPathComponent }
            }
            .fileDialogBrowserOptions(.includeHiddenFiles)
        """) { AnyView(C23_BrowserHiddenFilesExample()) },

        ChildExampleEntry(parent: ".fileDialogBrowserOptions()", child: "FileDialogBrowserOptions.enumeratePackages", code: """
        Button("Open File…") { importing = true }
            .fileImporter(isPresented: $importing, allowedContentTypes: [.item]) { result in
                if case .success(let url) = result { chosen = url.lastPathComponent }
            }
            .fileDialogBrowserOptions(.enumeratePackages)
        """) { AnyView(C23_BrowserEnumeratePackagesExample()) },

        ChildExampleEntry(parent: ".fileDialogBrowserOptions()", child: "FileDialogBrowserOptions.displayFileExtensions", code: """
        Button("Open File…") { importing = true }
            .fileImporter(isPresented: $importing, allowedContentTypes: [.item]) { result in
                if case .success(let url) = result { chosen = url.lastPathComponent }
            }
            .fileDialogBrowserOptions(.displayFileExtensions)
        """) { AnyView(C23_BrowserFileExtensionsExample()) },

        // MARK: .fileExporter()

        ChildExampleEntry(parent: ".fileExporter()", child: "fileExporter(isPresented:document:contentType:defaultFilename:onCompletion:)", code: """
        struct NotesDocument: FileDocument { var text: String /* … */ }

        Button("Export Notes…") { exporting = true }
            .fileExporter(isPresented: $exporting,
                          document: NotesDocument(text: notes),
                          contentType: .plainText,
                          defaultFilename: "Meeting Notes") { result in
                switch result {
                case .success(let url): status = "Saved \\(url.lastPathComponent)"
                case .failure(let error): status = error.localizedDescription
                }
            }
        """) { AnyView(C23_ExportDocumentExample()) },

        ChildExampleEntry(parent: ".fileExporter()", child: "fileExporter(isPresented:documents:contentType:onCompletion:)", code: """
        let pages = (1...3).map { NotesDocument(text: "Page \\($0)") }

        Button("Export 3 Pages…") { exporting = true }
            .fileExporter(isPresented: $exporting,
                          documents: pages,
                          contentType: .plainText) { result in
                if case .success(let urls) = result { status = "Saved \\(urls.count) files" }
            }
        """) { AnyView(C23_ExportDocumentsExample()) },

        ChildExampleEntry(parent: ".fileExporter()", child: "fileExporter(isPresented:item:contentTypes:defaultFilename:onCompletion:)", code: """
        // `snapshot` is a String — any Transferable works, no FileDocument needed
        Button("Export Snapshot…") { exporting = true }
            .fileExporter(isPresented: $exporting,
                          item: snapshot,
                          contentTypes: [.utf8PlainText],
                          defaultFilename: "Snapshot") { result in
                if case .success(let url) = result { status = "Saved \\(url.lastPathComponent)" }
            }
        """) { AnyView(C23_ExportItemExample()) },

        // MARK: .fileImporter()

        ChildExampleEntry(parent: ".fileImporter()", child: "fileImporter(isPresented:allowedContentTypes:onCompletion:)", code: """
        Button("Add PDF to Library…") { importing = true }
            .fileImporter(isPresented: $importing,
                          allowedContentTypes: [.pdf]) { result in
                if case .success(let url) = result {          // exactly one URL
                    library.append(url.lastPathComponent)
                }
            }
        """) { AnyView(C23_ImportSingleExample()) },

        ChildExampleEntry(parent: ".fileImporter()", child: "fileImporter(isPresented:allowedContentTypes:allowsMultipleSelection:onCompletion:)", code: """
        Button("Add PDFs to Library…") { importing = true }
            .fileImporter(isPresented: $importing,
                          allowedContentTypes: [.pdf],
                          allowsMultipleSelection: true) { result in
                if case .success(let urls) = result {         // an array of URLs
                    library.append(contentsOf: urls.map(\\.lastPathComponent))
                }
            }
        """) { AnyView(C23_ImportMultipleExample()) },

        // MARK: .fileMover()

        ChildExampleEntry(parent: ".fileMover()", child: "fileMover(isPresented:file:onCompletion:)", code: """
        Button("Move Draft…") { movingDraft = true }
            .fileMover(isPresented: $movingDraft, file: draftURL) { result in
                if case .success(let newURL) = result { archivedURL = newURL }
            }
        """) { AnyView(C23_MoveFileExample()) },

        ChildExampleEntry(parent: ".fileMover()", child: "fileMover(isPresented:files:onCompletion:)", code: """
        Button("Move \\(draftURLs.count) Drafts…") { movingDrafts = true }
            .fileMover(isPresented: $movingDrafts, files: draftURLs) { result in
                if case .success(let newURLs) = result { archivedURLs = newURLs }
            }
        """) { AnyView(C23_MoveFilesExample()) },

        // MARK: .handlesExternalEvents()

        ChildExampleEntry(parent: ".handlesExternalEvents()", child: "handlesExternalEvents(matching:)", code: """
        WindowGroup("Reader") {
            ReaderWindow()
        }
        .handlesExternalEvents(matching: ["reader"])   // URLs containing "reader" open here

        WindowGroup("Library") {
            LibraryWindow()
        }
        """) { AnyView(C23_ExternalEventsMatchingExample()) },

        ChildExampleEntry(parent: ".handlesExternalEvents()", child: "handlesExternalEvents(preferring:allowing:)", code: """
        ReaderWindow(documentID: documentID)
            .handlesExternalEvents(preferring: [documentID],   // events naming this document come here
                                   allowing: ["*"])            // any other event may still land here
        """) { AnyView(C23_ExternalEventsPreferringExample()) },

        // MARK: .inspectorColumnWidth()

        ChildExampleEntry(parent: ".inspectorColumnWidth()", child: "inspectorColumnWidth(_:)", code: """
        Canvas()
            .inspector(isPresented: $showsInspector) {
                AttributesPane(selection: $selection)
                    .inspectorColumnWidth(280)          // fixed: the divider does not drag
            }
        """) { AnyView(C23_InspectorFixedWidthExample()) },

        ChildExampleEntry(parent: ".inspectorColumnWidth()", child: "inspectorColumnWidth(min:ideal:max:)", code: """
        Canvas()
            .inspector(isPresented: $showsInspector) {
                AttributesPane(selection: $selection)
                    .inspectorColumnWidth(min: 220, ideal: 260, max: 340)
            }
        """) { AnyView(C23_InspectorFlexibleWidthExample()) },

        // MARK: .navigationBarTitleDisplayMode()

        ChildExampleEntry(parent: ".navigationBarTitleDisplayMode()", child: ".large", code: """
        List(albums) { AlbumRow(album: $0) }
            .navigationTitle("Albums")
            .navigationBarTitleDisplayMode(.large)
        """) { AnyView(C23_TitleDisplayLargeExample()) },

        ChildExampleEntry(parent: ".navigationBarTitleDisplayMode()", child: ".inline", code: """
        TrackDetail(track: track)
            .navigationTitle(track.title)
            .navigationBarTitleDisplayMode(.inline)
        """) { AnyView(C23_TitleDisplayInlineExample()) },

        ChildExampleEntry(parent: ".navigationBarTitleDisplayMode()", child: ".automatic", code: """
        List(albums) { AlbumRow(album: $0) }
            .navigationTitle("Albums")
            .navigationBarTitleDisplayMode(rootMode)          // .large or .inline
            .navigationDestination(for: Album.self) { album in
                AlbumScreen(album: album)
                    .navigationTitle(album.name)
                    .navigationBarTitleDisplayMode(.automatic)   // inherits rootMode
            }
        """) { AnyView(C23_TitleDisplayAutomaticExample()) },

        // MARK: .navigationDestination()

        ChildExampleEntry(parent: ".navigationDestination()", child: "navigationDestination(for:)", code: """
        NavigationStack(path: $path) {
            List(recipes, id: \\.self) { recipe in
                NavigationLink(recipe.name, value: recipe)   // pushes a Recipe value
            }
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetail(recipe: recipe)
            }
        }
        """) { AnyView(C23_DestinationForExample()) },

        ChildExampleEntry(parent: ".navigationDestination()", child: "navigationDestination(isPresented:)", code: """
        NavigationStack {
            Button("Open Settings") { showingSettings = true }
                .navigationDestination(isPresented: $showingSettings) {
                    SettingsView()          // popping resets showingSettings to false
                }
        }
        """) { AnyView(C23_DestinationIsPresentedExample()) },

        ChildExampleEntry(parent: ".navigationDestination()", child: "navigationDestination(item:)", code: """
        NavigationStack {
            List(recipes, id: \\.self) { recipe in
                Button(recipe.name) { inspectedRecipe = recipe }   // non-nil → push
            }
            .navigationDestination(item: $inspectedRecipe) { recipe in
                RecipeDetail(recipe: recipe)                        // pop → nil
            }
        }
        """) { AnyView(C23_DestinationItemExample()) },

        // MARK: .navigationSplitViewColumnWidth()

        ChildExampleEntry(parent: ".navigationSplitViewColumnWidth()", child: "navigationSplitViewColumnWidth(_:)", code: """
        NavigationSplitView {
            MailboxList(selection: $mailbox)
                .navigationSplitViewColumnWidth(320)   // constant: the divider does not drag
        } detail: {
            MessageView(mailbox: mailbox)
        }
        """) { AnyView(C23_SplitFixedWidthExample()) },

        ChildExampleEntry(parent: ".navigationSplitViewColumnWidth()", child: "navigationSplitViewColumnWidth(min:ideal:max:)", code: """
        NavigationSplitView {
            MailboxList(selection: $mailbox)
                .navigationSplitViewColumnWidth(min: 180, ideal: 220, max: 300)
        } detail: {
            MessageView(mailbox: mailbox)
        }
        """) { AnyView(C23_SplitFlexibleWidthExample()) },

        // MARK: .navigationSplitViewStyle()

        ChildExampleEntry(parent: ".navigationSplitViewStyle()", child: ".balanced", code: """
        NavigationSplitView {
            MailboxList(selection: $mailbox)
        } detail: {
            MessageView(mailbox: mailbox)
        }
        .navigationSplitViewStyle(.balanced)   // detail narrows to make room
        """) { AnyView(C23_SplitStyleBalancedExample()) },

        ChildExampleEntry(parent: ".navigationSplitViewStyle()", child: ".prominentDetail", code: """
        NavigationSplitView {
            Sidebar()
        } detail: {
            MapView(region: $region)
        }
        .navigationSplitViewStyle(.prominentDetail)   // detail keeps its size; sidebar overlays
        """) { AnyView(C23_SplitStyleProminentExample()) },

        ChildExampleEntry(parent: ".navigationSplitViewStyle()", child: ".automatic", code: """
        NavigationSplitView {
            Sidebar()
        } detail: {
            DetailView()
        }
        .navigationSplitViewStyle(.automatic)   // platform + size class decide
        """) { AnyView(C23_SplitStyleAutomaticExample()) },

        // MARK: .presentationBackground()

        ChildExampleEntry(parent: ".presentationBackground()", child: "presentationBackground(_:)", code: """
        Button("Show Now Playing") { showsNowPlaying = true }
            .sheet(isPresented: $showsNowPlaying) {
                NowPlayingControls()
                    .padding(30)
                    .presentationBackground(.thinMaterial)   // a ShapeStyle fills the sheet
            }
        """) { AnyView(C23_PresentationBackgroundStyleExample()) },

        ChildExampleEntry(parent: ".presentationBackground()", child: "presentationBackground(alignment:content:)", code: """
        Button("Show Editor") { showsEditor = true }
            .sheet(isPresented: $showsEditor) {
                Editor()
                    .padding(30)
                    .presentationBackground(alignment: .center) {   // any View goes behind the content
                        LinearGradient(colors: [.indigo, .black],
                                       startPoint: .top, endPoint: .bottom)
                    }
            }
        """) { AnyView(C23_PresentationBackgroundViewExample()) },

        // MARK: .presentationBackgroundInteraction()

        ChildExampleEntry(parent: ".presentationBackgroundInteraction()", child: ".enabled", code: """
        PlaceSearch(results: $results)
            .presentationDetents([.medium, .large])
            .presentationBackgroundInteraction(.enabled)   // the map stays tappable at every detent
        """) { AnyView(C23_BackgroundInteractionEnabledExample()) },

        ChildExampleEntry(parent: ".presentationBackgroundInteraction()", child: ".enabled(upThrough:)", code: """
        PlaceSearch(results: $results)
            .presentationDetents([.medium, .large])
            .presentationBackgroundInteraction(.enabled(upThrough: .medium))
            // interactive at .medium; dimmed and blocked once the sheet reaches .large
        """) { AnyView(C23_BackgroundInteractionUpThroughExample()) },

        ChildExampleEntry(parent: ".presentationBackgroundInteraction()", child: ".disabled", code: """
        ConfirmSheet()
            .presentationDetents([.medium, .large])
            .presentationBackgroundInteraction(.disabled)   // always dimmed and blocked
        """) { AnyView(C23_BackgroundInteractionDisabledExample()) },

        // MARK: .presentationCompactAdaptation()

        ChildExampleEntry(parent: ".presentationCompactAdaptation()", child: "presentationCompactAdaptation(_:)", code: """
        Button("Show Legend") { showsLegend = true }
            .popover(isPresented: $showsLegend) {
                ChartLegend(series: series)
                    .padding()
                    .presentationCompactAdaptation(.popover)   // both compact axes: stay a popover
            }
        """) { AnyView(C23_CompactAdaptationSingleExample()) },

        ChildExampleEntry(parent: ".presentationCompactAdaptation()", child: "presentationCompactAdaptation(horizontal:vertical:)", code: """
        Button("Show Legend") { showsLegend = true }
            .popover(isPresented: $showsLegend) {
                ChartLegend(series: series)
                    .padding()
                    .presentationCompactAdaptation(horizontal: .popover,   // compact width: popover
                                                   vertical: .sheet)       // compact height: sheet
            }
        """) { AnyView(C23_CompactAdaptationAxesExample()) },

        // MARK: .presentationContentInteraction()

        ChildExampleEntry(parent: ".presentationContentInteraction()", child: ".scrolls", code: """
        CommentList(post: post)
            .presentationDetents([.medium, .large])
            .presentationContentInteraction(.scrolls)   // swipe scrolls comments first
        """) { AnyView(C23_ContentInteractionScrollsExample()) },

        ChildExampleEntry(parent: ".presentationContentInteraction()", child: ".resizes", code: """
        FilterList(filters: $filters)
            .presentationDetents([.medium, .large])
            .presentationContentInteraction(.resizes)   // swipe grows the sheet first
        """) { AnyView(C23_ContentInteractionResizesExample()) },

        // MARK: .toolbarRole()

        ChildExampleEntry(parent: ".toolbarRole()", child: ".editor", code: """
        DocumentCanvas(document: $document)
            .navigationTitle(document.name)
            .toolbar {
                ToolbarItemGroup { undoButton; redoButton; shareButton }
            }
            .toolbarRole(.editor)   // title moves leading; the center is left for editing controls
        """) { AnyView(C23_ToolbarRoleEditorExample()) },
    ]
}

// MARK: - Shared helpers

private struct C23_Caption: View {
    let text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
    }
}

/// A minimal plain-text FileDocument used by the exporter examples.
nonisolated struct C23_NotesDocument: FileDocument {
    static let readableContentTypes: [UTType] = [.plainText]
    var text: String

    init(text: String) { self.text = text }

    init(configuration: ReadConfiguration) throws {
        let data = configuration.file.regularFileContents ?? Data()
        text = String(decoding: data, as: UTF8.self)
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        FileWrapper(regularFileWithContents: Data(text.utf8))
    }
}

// MARK: - .dialogSeverity()

private struct C23_DialogSeverityStandardExample: View {
    @State private var confirming = false
    @State private var bookmarks = 4

    var body: some View {
        VStack(spacing: 12) {
            Label("\(bookmarks) bookmarks", systemImage: "bookmark.fill")
                .foregroundStyle(.orange)
            Button("Remove Bookmark…") { confirming = true }
                .disabled(bookmarks == 0)
                .alert("Remove Bookmark?", isPresented: $confirming) {
                    Button("Remove", role: .destructive) { bookmarks = max(0, bookmarks - 1) }
                    Button("Cancel", role: .cancel) { }
                }
                .dialogSeverity(.standard)
            C23_Caption("Ordinary weight: the plain app icon, no caution badge.")
        }
        .padding()
    }
}

private struct C23_DialogSeverityCriticalExample: View {
    @State private var confirming = false
    @State private var annotations = 12

    var body: some View {
        VStack(spacing: 12) {
            Label("\(annotations) annotations", systemImage: "pencil.tip.crop.circle")
                .foregroundStyle(.blue)
            Button("Erase All Annotations…") { confirming = true }
                .disabled(annotations == 0)
                .alert("Erase All Annotations?", isPresented: $confirming) {
                    Button("Erase", role: .destructive) { annotations = 0 }
                    Button("Cancel", role: .cancel) { }
                }
                .dialogSeverity(.critical)
            C23_Caption("Critical weight: the caution badge overlays the app icon.")
        }
        .padding()
    }
}

private struct C23_DialogSeverityAutomaticExample: View {
    @State private var confirming = false
    @State private var signedIn = true

    var body: some View {
        VStack(spacing: 12) {
            Label(signedIn ? "Signed in as Robin" : "Signed out",
                  systemImage: signedIn ? "person.crop.circle.badge.checkmark" : "person.crop.circle.badge.xmark")
            Button(signedIn ? "Sign Out…" : "Sign In") {
                if signedIn { confirming = true } else { signedIn = true }
            }
            .alert("Sign Out?", isPresented: $confirming) {
                Button("Sign Out") { signedIn = false }
                Button("Cancel", role: .cancel) { }
            }
            .dialogSeverity(.automatic)
            C23_Caption("The system infers the weight from the buttons and context.")
        }
        .padding()
    }
}

// MARK: - .dialogSuppressionToggle()

private struct C23_SuppressionToggleDefaultExample: View {
    @State private var confirmingReplace = false
    @State private var suppressReplaceWarning = false
    @State private var exports = 0

    var body: some View {
        VStack(spacing: 12) {
            Button("Export (replaces the existing file)") {
                if suppressReplaceWarning { exports += 1 } else { confirmingReplace = true }
            }
            .alert("Replace Existing File?", isPresented: $confirmingReplace) {
                Button("Replace") { exports += 1 }
                Button("Cancel", role: .cancel) { }
            }
            .dialogSuppressionToggle(isSuppressed: $suppressReplaceWarning)

            HStack(spacing: 16) {
                Label("Exports: \(exports)", systemImage: "square.and.arrow.up")
                Label(suppressReplaceWarning ? "Suppressed" : "Asks every time",
                      systemImage: suppressReplaceWarning ? "checkmark.square" : "square")
            }
            .font(.callout)
            Button("Reset suppression") { suppressReplaceWarning = false }
                .buttonStyle(.link)
                .disabled(!suppressReplaceWarning)
            C23_Caption("The checkbox uses the system's default \"Do not ask again\" wording.")
        }
        .padding()
    }
}

private struct C23_SuppressionToggleLabeledExample: View {
    @State private var confirmingReplace = false
    @State private var suppressReplaceWarning = false
    @State private var exports = 0

    var body: some View {
        VStack(spacing: 12) {
            Button("Export (replaces the existing file)") {
                if suppressReplaceWarning { exports += 1 } else { confirmingReplace = true }
            }
            .alert("Replace Existing File?", isPresented: $confirmingReplace) {
                Button("Replace") { exports += 1 }
                Button("Cancel", role: .cancel) { }
            }
            .dialogSuppressionToggle("Don't warn me before replacing files",
                                     isSuppressed: $suppressReplaceWarning)

            HStack(spacing: 16) {
                Label("Exports: \(exports)", systemImage: "square.and.arrow.up")
                Label(suppressReplaceWarning ? "Suppressed" : "Asks every time",
                      systemImage: suppressReplaceWarning ? "checkmark.square" : "square")
            }
            .font(.callout)
            Button("Reset suppression") { suppressReplaceWarning = false }
                .buttonStyle(.link)
                .disabled(!suppressReplaceWarning)
            C23_Caption("The checkbox carries your own label instead of the default phrasing.")
        }
        .padding()
    }
}

// MARK: - .fileDialogBrowserOptions()

private struct C23_BrowserHiddenFilesExample: View {
    @State private var importing = false
    @State private var chosen = "Nothing chosen yet"

    var body: some View {
        VStack(spacing: 12) {
            Button("Open File…") { importing = true }
                .fileImporter(isPresented: $importing, allowedContentTypes: [.item]) { result in
                    if case .success(let url) = result { chosen = url.lastPathComponent }
                }
                .fileDialogBrowserOptions(.includeHiddenFiles)
            Label(chosen, systemImage: "doc")
                .font(.callout)
            C23_Caption("Dotfiles such as .zshrc are listed in the browser.")
        }
        .padding()
    }
}

private struct C23_BrowserEnumeratePackagesExample: View {
    @State private var importing = false
    @State private var chosen = "Nothing chosen yet"

    var body: some View {
        VStack(spacing: 12) {
            Button("Open File…") { importing = true }
                .fileImporter(isPresented: $importing, allowedContentTypes: [.item]) { result in
                    if case .success(let url) = result { chosen = url.lastPathComponent }
                }
                .fileDialogBrowserOptions(.enumeratePackages)
            Label(chosen, systemImage: "doc")
                .font(.callout)
            C23_Caption("Bundles like .app open as ordinary folders, so you can pick a file inside.")
        }
        .padding()
    }
}

private struct C23_BrowserFileExtensionsExample: View {
    @State private var importing = false
    @State private var chosen = "Nothing chosen yet"

    var body: some View {
        VStack(spacing: 12) {
            Button("Open File…") { importing = true }
                .fileImporter(isPresented: $importing, allowedContentTypes: [.item]) { result in
                    if case .success(let url) = result { chosen = url.lastPathComponent }
                }
                .fileDialogBrowserOptions(.displayFileExtensions)
            Label(chosen, systemImage: "doc")
                .font(.callout)
            C23_Caption("Extensions stay visible even if Finder is set to hide them.")
        }
        .padding()
    }
}

// MARK: - .fileExporter()

private struct C23_ExportDocumentExample: View {
    @State private var exporting = false
    @State private var status = "Not exported yet"
    private let notes = "Meeting Notes\n• Roadmap review\n• Hiring plan"

    var body: some View {
        VStack(spacing: 12) {
            Text(notes)
                .font(.callout.monospaced())
                .padding(8)
                .background(.quaternary, in: RoundedRectangle(cornerRadius: 6))
            Button("Export Notes…") { exporting = true }
                .fileExporter(isPresented: $exporting,
                              document: C23_NotesDocument(text: notes),
                              contentType: .plainText,
                              defaultFilename: "Meeting Notes") { result in
                    switch result {
                    case .success(let url): status = "Saved \(url.lastPathComponent)"
                    case .failure(let error): status = error.localizedDescription
                    }
                }
            C23_Caption(status)
        }
        .padding()
    }
}

private struct C23_ExportDocumentsExample: View {
    @State private var exporting = false
    @State private var status = "Not exported yet"
    private let pages = (1...3).map { C23_NotesDocument(text: "Page \($0)") }

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 8) {
                ForEach(pages.indices, id: \.self) { index in
                    Text(pages[index].text)
                        .font(.caption)
                        .frame(width: 56, height: 40)
                        .background(.quaternary, in: RoundedRectangle(cornerRadius: 4))
                }
            }
            Button("Export \(pages.count) Pages…") { exporting = true }
                .fileExporter(isPresented: $exporting,
                              documents: pages,
                              contentType: .plainText) { result in
                    switch result {
                    case .success(let urls): status = "Saved \(urls.count) files"
                    case .failure(let error): status = error.localizedDescription
                    }
                }
            C23_Caption(status)
        }
        .padding()
    }
}

private struct C23_ExportItemExample: View {
    @State private var exporting = false
    @State private var status = "Not exported yet"
    private let snapshot = "Snapshot 001 — 3 layers, 1024×768"

    var body: some View {
        VStack(spacing: 12) {
            Label(snapshot, systemImage: "camera.viewfinder")
                .font(.callout.monospaced())
            Button("Export Snapshot…") { exporting = true }
                .fileExporter(isPresented: $exporting,
                              item: snapshot,
                              contentTypes: [.utf8PlainText],
                              defaultFilename: "Snapshot") { result in
                    switch result {
                    case .success(let url): status = "Saved \(url.lastPathComponent)"
                    case .failure(let error): status = error.localizedDescription
                    }
                }
            C23_Caption("\(status) · the item is a plain String (Transferable), not a FileDocument")
        }
        .padding()
    }
}

// MARK: - .fileImporter()

private struct C23_ImportSingleExample: View {
    @State private var importing = false
    @State private var library: [String] = []

    var body: some View {
        VStack(spacing: 12) {
            Button("Add PDF to Library…") { importing = true }
                .fileImporter(isPresented: $importing,
                              allowedContentTypes: [.pdf]) { result in
                    if case .success(let url) = result {
                        library.append(url.lastPathComponent)
                    }
                }
            C23_LibraryList(names: library)
            C23_Caption("Single selection: the completion receives one URL.")
        }
        .padding()
    }
}

private struct C23_ImportMultipleExample: View {
    @State private var importing = false
    @State private var library: [String] = []

    var body: some View {
        VStack(spacing: 12) {
            Button("Add PDFs to Library…") { importing = true }
                .fileImporter(isPresented: $importing,
                              allowedContentTypes: [.pdf],
                              allowsMultipleSelection: true) { result in
                    if case .success(let urls) = result {
                        library.append(contentsOf: urls.map(\.lastPathComponent))
                    }
                }
            C23_LibraryList(names: library)
            C23_Caption("Batch selection (⇧-click in the panel): the completion receives an array of URLs.")
        }
        .padding()
    }
}

private struct C23_LibraryList: View {
    let names: [String]
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if names.isEmpty {
                Text("Library is empty").foregroundStyle(.tertiary)
            } else {
                ForEach(Array(names.enumerated()), id: \.offset) { _, name in
                    Label(name, systemImage: "doc.richtext")
                }
            }
        }
        .font(.callout)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
        .background(.quaternary, in: RoundedRectangle(cornerRadius: 6))
    }
}

// MARK: - .fileMover() (illustrative: the real panel needs an existing file on disk)

private struct C23_MockMovePanel: View {
    let files: [String]
    let onMove: () -> Void
    let onCancel: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(files.count == 1 ? "Move “\(files[0])” to:" : "Move \(files.count) items to:",
                  systemImage: "folder.fill")
                .font(.callout.weight(.semibold))
            HStack(alignment: .top, spacing: 8) {
                VStack(alignment: .leading, spacing: 3) {
                    ForEach(["Desktop", "Documents", "Archive"], id: \.self) { name in
                        Label(name, systemImage: "folder")
                            .font(.caption)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(name == "Archive" ? Color.accentColor.opacity(0.2) : Color.clear,
                                        in: RoundedRectangle(cornerRadius: 4))
                    }
                }
                Divider().frame(height: 60)
                VStack(alignment: .leading, spacing: 3) {
                    ForEach(files, id: \.self) { file in
                        Label(file, systemImage: "doc.text").font(.caption)
                    }
                }
                Spacer()
            }
            HStack {
                Spacer()
                Button("Cancel", action: onCancel)
                Button("Move", action: onMove).buttonStyle(.borderedProminent)
            }
            .controlSize(.small)
        }
        .padding(10)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 10))
    }
}

private struct C23_MoveFileExample: View {
    @State private var movingDraft = false
    @State private var archivedPath: String?

    var body: some View {
        VStack(spacing: 10) {
            if movingDraft {
                C23_MockMovePanel(files: ["Draft.md"],
                                  onMove: { archivedPath = "Archive/Draft.md"; movingDraft = false },
                                  onCancel: { movingDraft = false })
            } else {
                Button("Move Draft…") { movingDraft = true }
                Label(archivedPath.map { "Moved to \($0)" } ?? "Draft.md is still in Documents",
                      systemImage: archivedPath == nil ? "doc.text" : "checkmark.circle")
                    .font(.callout)
            }
            C23_Caption("Illustrative — the real modifier presents the system Move panel for one existing file and reports its new URL.")
        }
        .padding()
    }
}

private struct C23_MoveFilesExample: View {
    @State private var movingDrafts = false
    @State private var archivedCount = 0
    private let drafts = ["Draft 1.md", "Draft 2.md", "Draft 3.md"]

    var body: some View {
        VStack(spacing: 10) {
            if movingDrafts {
                C23_MockMovePanel(files: drafts,
                                  onMove: { archivedCount = drafts.count; movingDrafts = false },
                                  onCancel: { movingDrafts = false })
            } else {
                Button("Move \(drafts.count) Drafts…") { movingDrafts = true }
                Label(archivedCount == 0 ? "\(drafts.count) drafts in Documents" : "Moved \(archivedCount) files to Archive",
                      systemImage: archivedCount == 0 ? "doc.on.doc" : "checkmark.circle")
                    .font(.callout)
            }
            C23_Caption("Illustrative — the real modifier moves a whole collection of existing files and reports their new URLs.")
        }
        .padding()
    }
}

// MARK: - .handlesExternalEvents()

private struct C23_MockWindow: View {
    let title: String
    let systemImage: String
    var highlighted: Bool

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 5) {
                ForEach(0..<3) { _ in
                    Circle().fill(.quaternary).frame(width: 7, height: 7)
                }
                Spacer()
                Text(title).font(.caption2.weight(.medium)).lineLimit(1)
                Spacer()
                Color.clear.frame(width: 31, height: 7)
            }
            .padding(6)
            .background(.bar)
            Image(systemName: systemImage)
                .font(.title2)
                .foregroundStyle(highlighted ? Color.accentColor : Color.secondary)
                .frame(maxWidth: .infinity, minHeight: 50)
        }
        .frame(width: 130)
        .background(.background, in: RoundedRectangle(cornerRadius: 8))
        .overlay(RoundedRectangle(cornerRadius: 8)
            .stroke(highlighted ? Color.accentColor : Color.secondary.opacity(0.3), lineWidth: highlighted ? 2 : 1))
    }
}

private struct C23_ExternalEventsMatchingExample: View {
    @State private var incoming = "myapp://reader/42"
    private let urls = ["myapp://reader/42", "myapp://library"]

    var body: some View {
        VStack(spacing: 10) {
            Picker("Incoming URL", selection: $incoming) {
                ForEach(urls, id: \.self) { Text($0).font(.caption.monospaced()) }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(maxWidth: 300)
            HStack(spacing: 16) {
                C23_MockWindow(title: "Reader", systemImage: "book", highlighted: incoming.contains("reader"))
                C23_MockWindow(title: "Library", systemImage: "books.vertical", highlighted: !incoming.contains("reader"))
            }
            Text("Reader: matching: [\"reader\"]")
                .font(.caption.monospaced())
            C23_Caption("Illustrative — applies at the Scene level: a URL containing “reader” opens or reuses a Reader window; others fall through to the next scene.")
        }
        .padding()
    }
}

private struct C23_ExternalEventsPreferringExample: View {
    private let documentID = "7F3A-READER"

    var body: some View {
        VStack(spacing: 10) {
            C23_MockWindow(title: "Reader — \(documentID)", systemImage: "book", highlighted: true)
                .handlesExternalEvents(preferring: [documentID], allowing: ["*"])
            VStack(spacing: 2) {
                Text("preferring: [\"\(documentID)\"]")
                Text("allowing: [\"*\"]")
            }
            .font(.caption.monospaced())
            C23_Caption("Applied for real on this view: an event naming this document prefers this window; any other event is still allowed here.")
        }
        .padding()
    }
}

// MARK: - .inspectorColumnWidth() (illustrative at 50% scale)

private struct C23_MockInspectorWindow: View {
    /// Column width in points; drawn at half scale.
    let columnWidth: CGFloat

    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                Rectangle().fill(.quaternary)
                Image(systemName: "paintpalette").font(.title2).foregroundStyle(.secondary)
            }
            Divider()
            VStack(alignment: .leading, spacing: 6) {
                Text("Attributes").font(.caption.weight(.semibold))
                ForEach(["Fill", "Stroke", "Opacity"], id: \.self) { row in
                    HStack {
                        Text(row).font(.caption2)
                        Spacer()
                        Capsule().fill(.quaternary).frame(width: 30, height: 8)
                    }
                }
                Spacer()
                Text("\(Int(columnWidth)) pt")
                    .font(.caption2.monospaced())
                    .foregroundStyle(.secondary)
            }
            .padding(8)
            .frame(width: columnWidth / 2)
            .background(.bar)
        }
        .frame(width: 320, height: 110)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.secondary.opacity(0.3)))
    }
}

private struct C23_InspectorFixedWidthExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C23_MockInspectorWindow(columnWidth: 280)
            C23_Caption("Illustrative at 50% — the inspector column is pinned to 280 pt; the divider does not drag.")
        }
        .padding()
    }
}

private struct C23_InspectorFlexibleWidthExample: View {
    @State private var width: CGFloat = 260

    var body: some View {
        VStack(spacing: 10) {
            C23_MockInspectorWindow(columnWidth: width)
            Slider(value: $width, in: 220...340) {
                Text("Width")
            } minimumValueLabel: {
                Text("220").font(.caption2)
            } maximumValueLabel: {
                Text("340").font(.caption2)
            }
            .frame(maxWidth: 320)
            Text("min 220 · ideal 260 · max 340")
                .font(.caption.monospaced())
            C23_Caption("Illustrative at 50% — drag stands in for the divider, clamped to the bounds; the system persists the chosen width.")
        }
        .padding()
    }
}

// MARK: - .navigationBarTitleDisplayMode() (illustrative: iOS/watchOS only)

private struct C23_PhoneFrame<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        content
            .frame(width: 190, height: 150, alignment: .top)
            .background(.background)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.secondary.opacity(0.4), lineWidth: 1.5))
    }
}

private struct C23_MockNavBar: View {
    enum Mode { case large, inline }
    let title: String
    let mode: Mode

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Label("Back", systemImage: "chevron.left").font(.caption).foregroundStyle(.blue)
                Spacer()
                if mode == .inline {
                    Text(title).font(.caption.weight(.semibold))
                }
                Spacer()
                Image(systemName: "ellipsis.circle").font(.caption).foregroundStyle(.blue)
            }
            .padding(.horizontal, 10)
            .frame(height: 28)
            if mode == .large {
                Text(title)
                    .font(.title2.bold())
                    .padding(.horizontal, 12)
                    .padding(.bottom, 6)
            }
            Divider()
        }
        .background(.bar)
    }
}

private struct C23_MockRows: View {
    let items: [String]
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(items, id: \.self) { item in
                Text(item).font(.caption).padding(.horizontal, 12).frame(height: 22)
                Divider().padding(.leading, 12)
            }
        }
    }
}

private struct C23_TitleDisplayLargeExample: View {
    @State private var scrolled = false

    var body: some View {
        VStack(spacing: 10) {
            C23_PhoneFrame {
                C23_MockNavBar(title: "Albums", mode: scrolled ? .inline : .large)
                C23_MockRows(items: ["Abbey Road", "Blue", "Kind of Blue", "Rumours", "Thriller"])
            }
            .animation(.easeInOut(duration: 0.25), value: scrolled)
            Toggle("Simulate scrolling", isOn: $scrolled)
                .toggleStyle(.switch)
                .controlSize(.small)
            C23_Caption("Illustrative — iOS only. The prominent title collapses to inline once the list scrolls.")
        }
        .padding()
    }
}

private struct C23_TitleDisplayInlineExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C23_PhoneFrame {
                C23_MockNavBar(title: "Blue Monday", mode: .inline)
                VStack(spacing: 6) {
                    Image(systemName: "waveform").font(.title).foregroundStyle(.secondary)
                    Text("New Order · 7:29").font(.caption).foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            C23_Caption("Illustrative — iOS only. A small centered title stays inline regardless of scrolling.")
        }
        .padding()
    }
}

private struct C23_TitleDisplayAutomaticExample: View {
    @State private var rootMode: C23_MockNavBar.Mode = .large

    var body: some View {
        VStack(spacing: 10) {
            Picker("Root mode", selection: $rootMode) {
                Text(".large").tag(C23_MockNavBar.Mode.large)
                Text(".inline").tag(C23_MockNavBar.Mode.inline)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(maxWidth: 220)
            HStack(spacing: 14) {
                VStack(spacing: 4) {
                    C23_PhoneFrame {
                        C23_MockNavBar(title: "Albums", mode: rootMode)
                        C23_MockRows(items: ["Abbey Road", "Blue", "Rumours"])
                    }
                    Text("root: \(rootMode == .large ? ".large" : ".inline")").font(.caption2.monospaced())
                }
                Image(systemName: "arrow.right").foregroundStyle(.secondary)
                VStack(spacing: 4) {
                    C23_PhoneFrame {
                        C23_MockNavBar(title: "Rumours", mode: rootMode)
                        C23_MockRows(items: ["Dreams", "Go Your Own Way"])
                    }
                    Text("child: .automatic").font(.caption2.monospaced())
                }
            }
            .animation(.easeInOut(duration: 0.25), value: rootMode)
            C23_Caption("Illustrative — iOS only. .automatic inherits whatever mode the previous navigation item established.")
        }
        .padding()
    }
}

// MARK: - .navigationDestination()

nonisolated struct C23_Recipe: Hashable {
    let name: String
    let minutes: Int
}

private struct C23_RecipeDetail: View {
    let recipe: C23_Recipe
    let onBack: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "fork.knife.circle.fill").font(.largeTitle).foregroundStyle(.orange)
            Text(recipe.name).font(.title3.bold())
            Text("\(recipe.minutes) min").foregroundStyle(.secondary)
            Button("Back", action: onBack)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(recipe.name)
    }
}

private let c23_recipes = [
    C23_Recipe(name: "Shakshuka", minutes: 25),
    C23_Recipe(name: "Pad Thai", minutes: 30),
    C23_Recipe(name: "Risotto", minutes: 45),
]

private struct C23_DestinationForExample: View {
    @State private var path: [C23_Recipe] = []

    var body: some View {
        NavigationStack(path: $path) {
            List(c23_recipes, id: \.self) { recipe in
                NavigationLink(recipe.name, value: recipe)
            }
            .navigationDestination(for: C23_Recipe.self) { recipe in
                C23_RecipeDetail(recipe: recipe) { path.removeLast() }
            }
            .navigationTitle("Recipes")
        }
        .frame(height: 200)
    }
}

private struct C23_DestinationIsPresentedExample: View {
    @State private var showingSettings = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                Label("Home", systemImage: "house").font(.title3)
                Button("Open Settings") { showingSettings = true }
                Text("showingSettings == false").font(.caption.monospaced()).foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationDestination(isPresented: $showingSettings) {
                VStack(spacing: 10) {
                    Label("Settings", systemImage: "gearshape").font(.title3)
                    Text("Fixed destination — no data value involved")
                        .font(.caption).foregroundStyle(.secondary)
                    Text("showingSettings == true").font(.caption.monospaced()).foregroundStyle(.secondary)
                    Button("Done") { showingSettings = false }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationTitle("Settings")
            }
            .navigationTitle("Home")
        }
        .frame(height: 200)
    }
}

private struct C23_DestinationItemExample: View {
    @State private var inspectedRecipe: C23_Recipe?

    var body: some View {
        NavigationStack {
            List(c23_recipes, id: \.self) { recipe in
                Button {
                    inspectedRecipe = recipe
                } label: {
                    HStack {
                        Text(recipe.name)
                        Spacer()
                        Image(systemName: "chevron.right").foregroundStyle(.tertiary)
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
            .navigationDestination(item: $inspectedRecipe) { recipe in
                C23_RecipeDetail(recipe: recipe) { inspectedRecipe = nil }
            }
            .navigationTitle("Recipes")
        }
        .frame(height: 200)
    }
}

// MARK: - .navigationSplitViewColumnWidth() (illustrative at 50% scale)

private struct C23_MockSplitWindow: View {
    /// Sidebar width in points; drawn at half scale.
    let sidebarWidth: CGFloat

    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 4) {
                ForEach(["Inbox", "Drafts", "Sent", "Archive"], id: \.self) { name in
                    Label(name, systemImage: "tray").font(.caption2).lineLimit(1)
                }
                Spacer()
                Text("\(Int(sidebarWidth)) pt")
                    .font(.caption2.monospaced())
                    .foregroundStyle(.secondary)
            }
            .padding(8)
            .frame(width: sidebarWidth / 2, alignment: .leading)
            .background(.bar)
            Divider()
            ZStack {
                Rectangle().fill(.quaternary)
                Image(systemName: "envelope.open").font(.title2).foregroundStyle(.secondary)
            }
        }
        .frame(width: 320, height: 110)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.secondary.opacity(0.3)))
    }
}

private struct C23_SplitFixedWidthExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C23_MockSplitWindow(sidebarWidth: 320)
            C23_Caption("Illustrative at 50% — the sidebar column is fixed at 320 pt; the divider does not drag.")
        }
        .padding()
    }
}

private struct C23_SplitFlexibleWidthExample: View {
    @State private var width: CGFloat = 220

    var body: some View {
        VStack(spacing: 10) {
            C23_MockSplitWindow(sidebarWidth: width)
            Slider(value: $width, in: 180...300) {
                Text("Width")
            } minimumValueLabel: {
                Text("180").font(.caption2)
            } maximumValueLabel: {
                Text("300").font(.caption2)
            }
            .frame(maxWidth: 320)
            Text("min 180 · ideal 220 · max 300")
                .font(.caption.monospaced())
            C23_Caption("Illustrative at 50% — the drag stands in for the divider and is clamped to the bounds.")
        }
        .padding()
    }
}

// MARK: - .navigationSplitViewStyle() (illustrative: column arrangement)

private struct C23_MockSplitStyle: View {
    enum Arrangement { case balanced, prominentDetail }
    let arrangement: Arrangement

    var body: some View {
        ZStack(alignment: .leading) {
            HStack(spacing: 0) {
                if arrangement == .balanced {
                    Color.clear.frame(width: 90)
                }
                ZStack {
                    Rectangle().fill(Color.teal.opacity(0.25))
                    VStack(spacing: 4) {
                        Image(systemName: "map").font(.title2)
                        Text(arrangement == .balanced ? "Detail (narrowed)" : "Detail (full size)").font(.caption2)
                    }
                    .foregroundStyle(.secondary)
                }
            }
            VStack(alignment: .leading, spacing: 4) {
                ForEach(["Places", "Favorites", "Recents"], id: \.self) { name in
                    Label(name, systemImage: "mappin").font(.caption2).lineLimit(1)
                }
                Spacer()
            }
            .padding(8)
            .frame(width: 90, alignment: .leading)
            .frame(maxHeight: .infinity)
            .background(.regularMaterial)
            .shadow(color: .black.opacity(arrangement == .prominentDetail ? 0.25 : 0), radius: 6, x: 3)
        }
        .frame(width: 260, height: 110)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.secondary.opacity(0.3)))
    }
}

private struct C23_SplitStyleBalancedExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C23_MockSplitStyle(arrangement: .balanced)
            C23_Caption("Illustrative — .balanced narrows the detail column so the sidebar sits beside it instead of covering it.")
        }
        .padding()
    }
}

private struct C23_SplitStyleProminentExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C23_MockSplitStyle(arrangement: .prominentDetail)
            C23_Caption("Illustrative — .prominentDetail keeps the detail column full size; the leading columns overlay it.")
        }
        .padding()
    }
}

private struct C23_SplitStyleAutomaticExample: View {
    @State private var context = 0

    var body: some View {
        VStack(spacing: 10) {
            Picker("Context", selection: $context) {
                Text("macOS / regular width").tag(0)
                Text("iPad portrait").tag(1)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(maxWidth: 260)
            C23_MockSplitStyle(arrangement: context == 0 ? .balanced : .prominentDetail)
                .animation(.easeInOut(duration: 0.25), value: context)
            C23_Caption("Illustrative — .automatic defers to the platform and size class: side by side in regular widths, overlaid in iPad portrait.")
        }
        .padding()
    }
}

// MARK: - .presentationBackground()

private struct C23_PresentationBackgroundStyleExample: View {
    @State private var showsNowPlaying = false

    var body: some View {
        VStack(spacing: 10) {
            Button("Show Now Playing") { showsNowPlaying = true }
                .sheet(isPresented: $showsNowPlaying) {
                    VStack(spacing: 12) {
                        Image(systemName: "music.note").font(.largeTitle)
                        Text("Now Playing").font(.headline)
                        HStack(spacing: 24) {
                            Image(systemName: "backward.fill")
                            Image(systemName: "play.fill")
                            Image(systemName: "forward.fill")
                        }
                        .font(.title2)
                        Button("Done") { showsNowPlaying = false }
                    }
                    .padding(30)
                    .presentationBackground(.thinMaterial)
                }
            C23_Caption("The sheet's opaque default background becomes .thinMaterial, so the window behind shows through.")
        }
        .padding()
    }
}

private struct C23_PresentationBackgroundViewExample: View {
    @State private var showsEditor = false

    var body: some View {
        VStack(spacing: 10) {
            Button("Show Editor") { showsEditor = true }
                .sheet(isPresented: $showsEditor) {
                    VStack(spacing: 12) {
                        Image(systemName: "pencil.and.outline").font(.largeTitle)
                        Text("Editor").font(.headline)
                        Text("Content sits on top of the custom background view.")
                            .font(.caption)
                        Button("Done") { showsEditor = false }
                    }
                    .foregroundStyle(.white)
                    .padding(30)
                    .presentationBackground(alignment: .center) {
                        LinearGradient(colors: [.indigo, .black], startPoint: .top, endPoint: .bottom)
                    }
                }
            C23_Caption("An arbitrary view (here a gradient) is painted behind the sheet content; alignment positions a background that does not fill.")
        }
        .padding()
    }
}

// MARK: - .presentationBackgroundInteraction() (illustrative: iOS sheet detents)

private struct C23_MockDetentSheet: View {
    let detent: String
    let sheetFraction: CGFloat
    let dimmed: Bool

    var body: some View {
        VStack(spacing: 4) {
            ZStack(alignment: .bottom) {
                LinearGradient(colors: [.green.opacity(0.35), .teal.opacity(0.35)],
                               startPoint: .top, endPoint: .bottom)
                Image(systemName: "mappin.and.ellipse")
                    .font(.title2)
                    .foregroundStyle(.red)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.top, 16)
                if dimmed {
                    Color.black.opacity(0.35)
                }
                VStack(spacing: 6) {
                    Capsule().fill(.secondary).frame(width: 30, height: 4).padding(.top, 6)
                    Text("Search results").font(.caption2.weight(.semibold))
                    ForEach(0..<3) { _ in
                        Capsule().fill(.quaternary).frame(height: 8).padding(.horizontal, 12)
                    }
                    Spacer(minLength: 0)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 150 * sheetFraction)
                .background(.background, in: UnevenRoundedRectangle(topLeadingRadius: 10, topTrailingRadius: 10))
            }
            .frame(width: 110, height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.secondary.opacity(0.4), lineWidth: 1.5))
            Label(dimmed ? "map blocked" : "map tappable",
                  systemImage: dimmed ? "hand.raised.slash" : "hand.tap")
                .font(.caption2)
            Text(".\(detent)").font(.caption2.monospaced()).foregroundStyle(.secondary)
        }
    }
}

private struct C23_BackgroundInteractionEnabledExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 20) {
                C23_MockDetentSheet(detent: "medium", sheetFraction: 0.5, dimmed: false)
                C23_MockDetentSheet(detent: "large", sheetFraction: 0.9, dimmed: false)
            }
            C23_Caption("Illustrative — iOS sheet detents. The view behind stays interactive at every detent.")
        }
        .padding()
    }
}

private struct C23_BackgroundInteractionUpThroughExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 20) {
                C23_MockDetentSheet(detent: "medium", sheetFraction: 0.5, dimmed: false)
                C23_MockDetentSheet(detent: "large", sheetFraction: 0.9, dimmed: true)
            }
            C23_Caption("Illustrative — iOS sheet detents. Interactive up through .medium; at .large the backdrop dims and blocks touches.")
        }
        .padding()
    }
}

private struct C23_BackgroundInteractionDisabledExample: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 20) {
                C23_MockDetentSheet(detent: "medium", sheetFraction: 0.5, dimmed: true)
                C23_MockDetentSheet(detent: "large", sheetFraction: 0.9, dimmed: true)
            }
            C23_Caption("Illustrative — iOS sheet detents. The usual dimmed, non-interactive backdrop at every detent.")
        }
        .padding()
    }
}

// MARK: - .presentationCompactAdaptation()

private struct C23_ChartLegend: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ForEach(Array(zip(["Revenue", "Costs", "Profit"], [Color.blue, .orange, .green])), id: \.0) { name, color in
                HStack(spacing: 6) {
                    Circle().fill(color).frame(width: 10, height: 10)
                    Text(name).font(.callout)
                }
            }
        }
    }
}

private struct C23_CompactAdaptationSingleExample: View {
    @State private var showsLegend = false

    var body: some View {
        VStack(spacing: 10) {
            Button("Show Legend") { showsLegend = true }
                .popover(isPresented: $showsLegend) {
                    C23_ChartLegend()
                        .padding()
                        .presentationCompactAdaptation(.popover)
                }
            C23_Caption("On macOS the popover never adapts. In a compact size class (iPhone) this keeps it a popover in both axes instead of the default sheet.")
        }
        .padding()
    }
}

private struct C23_CompactAdaptationAxesExample: View {
    @State private var showsLegend = false

    var body: some View {
        VStack(spacing: 10) {
            Button("Show Legend") { showsLegend = true }
                .popover(isPresented: $showsLegend) {
                    C23_ChartLegend()
                        .padding()
                        .presentationCompactAdaptation(horizontal: .popover, vertical: .sheet)
                }
            C23_Caption("On macOS the popover never adapts. Compact width (iPhone portrait) keeps a popover; compact height (iPhone landscape) becomes a sheet.")
        }
        .padding()
    }
}

// MARK: - .presentationContentInteraction() (illustrative: iOS sheet detents)

private struct C23_MockContentInteraction: View {
    let resizes: Bool
    @State private var swiped = false

    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .bottom) {
                LinearGradient(colors: [.purple.opacity(0.3), .pink.opacity(0.3)],
                               startPoint: .top, endPoint: .bottom)
                VStack(spacing: 6) {
                    Capsule().fill(.secondary).frame(width: 30, height: 4).padding(.top, 6)
                    Text(resizes ? "Filters" : "Comments").font(.caption2.weight(.semibold))
                    VStack(spacing: 6) {
                        ForEach(0..<8) { _ in
                            HStack(spacing: 4) {
                                Circle().fill(.quaternary).frame(width: 10, height: 10)
                                Capsule().fill(.quaternary).frame(height: 6)
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                    .offset(y: (!resizes && swiped) ? -48 : 0)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .clipped()
                }
                .frame(width: 110, height: (resizes && swiped) ? 135 : 75, alignment: .top)
                .background(.background, in: UnevenRoundedRectangle(topLeadingRadius: 10, topTrailingRadius: 10))
            }
            .frame(width: 110, height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.secondary.opacity(0.4), lineWidth: 1.5))
            .animation(.easeInOut(duration: 0.35), value: swiped)
            Button(swiped ? "Reset" : "Simulate swipe up") { swiped.toggle() }
                .controlSize(.small)
        }
    }
}

private struct C23_ContentInteractionScrollsExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C23_MockContentInteraction(resizes: false)
            C23_Caption("Illustrative — iOS. The swipe scrolls the comments first; the sheet only grows once the content reaches the top.")
        }
        .padding()
    }
}

private struct C23_ContentInteractionResizesExample: View {
    var body: some View {
        VStack(spacing: 10) {
            C23_MockContentInteraction(resizes: true)
            C23_Caption("Illustrative — iOS. The swipe grows the sheet to the next detent before any content scrolls.")
        }
        .padding()
    }
}

// MARK: - .toolbarRole() (illustrative: title placement)

private struct C23_ToolbarRoleEditorExample: View {
    @State private var editor = true

    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 0) {
                HStack(spacing: 10) {
                    Image(systemName: "chevron.left").foregroundStyle(.blue)
                    if editor {
                        HStack(spacing: 4) {
                            Text("Quarterly Report").font(.caption.weight(.semibold))
                            Image(systemName: "chevron.down").font(.caption2).foregroundStyle(.secondary)
                        }
                    }
                    Spacer()
                    if !editor {
                        Text("Quarterly Report").font(.caption.weight(.semibold))
                    }
                    Spacer()
                    HStack(spacing: 10) {
                        Image(systemName: "arrow.uturn.backward")
                        Image(systemName: "arrow.uturn.forward")
                        Image(systemName: "square.and.arrow.up")
                    }
                    .foregroundStyle(.blue)
                }
                .font(.caption)
                .padding(.horizontal, 12)
                .frame(height: 32)
                .background(.bar)
                Divider()
                Rectangle()
                    .fill(.quaternary)
                    .frame(height: 60)
                    .overlay(Text("Document canvas").font(.caption2).foregroundStyle(.secondary))
            }
            .frame(width: 300)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.secondary.opacity(0.3)))
            .animation(.easeInOut(duration: 0.25), value: editor)
            Picker("Role", selection: $editor) {
                Text(".automatic").tag(false)
                Text(".editor").tag(true)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(maxWidth: 220)
            C23_Caption("Illustrative — .editor moves the title leading with a document menu, freeing the center for editing controls (iPadOS); macOS adjusts its toolbar layout similarly.")
        }
        .padding()
    }
}
