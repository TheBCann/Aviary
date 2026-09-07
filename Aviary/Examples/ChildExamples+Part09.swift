//
//  ChildExamples+Part09.swift
//  Aviary
//
//  Compiled renderings for variant entries (part 09: views).
//  One private C09_* struct per variant; every rendering exercises the exact
//  overload the variant names, so siblings can be compared side by side.
//

import SwiftUI
import Charts

enum ChildExamplesPart09 {
    static let entries: [ChildExampleEntry] = [

        // MARK: AnyView

        ChildExampleEntry(parent: "AnyView", child: "AnyView(_:)", code: """
        let cells: [AnyView] = [
            AnyView(Text("Name")),
            AnyView(Toggle("Enabled", isOn: $enabled)),
            AnyView(Image(systemName: "star"))
        ]
        ForEach(cells.indices, id: \\.self) { cells[$0] }
        """) { AnyView(C09_AnyViewInitExample()) },

        ChildExampleEntry(parent: "AnyView", child: "AnyView(erasing:)", code: """
        func erased<V: View>(_ view: V) -> AnyView {
            AnyView(erasing: view)          // explicit label reads better in generic helpers
        }

        let badge = isVerified
            ? erased(Image(systemName: "checkmark.seal.fill"))
            : erased(Text("—"))
        """) { AnyView(C09_AnyViewErasingExample()) },

        // MARK: AsyncImage

        ChildExampleEntry(parent: "AsyncImage", child: "AsyncImage(url:)", code: """
        AsyncImage(url: URL(string: "https://example.com/avatar.png"))
            .frame(width: 44, height: 44)
        """) { AnyView(C09_AsyncImageURLExample()) },

        ChildExampleEntry(parent: "AsyncImage", child: "AsyncImage(url:content:placeholder:)", code: """
        AsyncImage(url: photoURL) { image in
            image.resizable().scaledToFill()
        } placeholder: {
            Color.gray.opacity(0.2).overlay(ProgressView())
        }
        .frame(width: 140, height: 90)
        .clipShape(.rect(cornerRadius: 8))
        """) { AnyView(C09_AsyncImagePlaceholderExample()) },

        ChildExampleEntry(parent: "AsyncImage", child: "AsyncImage(url:scale:transaction:content:)", code: """
        AsyncImage(url: photoURL, transaction: Transaction(animation: .easeOut)) { phase in
            switch phase {
            case .success(let image): image.resizable().scaledToFit()
            case .failure: Image(systemName: "photo.badge.exclamationmark")
            case .empty: ProgressView()
            @unknown default: EmptyView()
            }
        }
        """) { AnyView(C09_AsyncImagePhaseExample()) },

        // MARK: Button

        ChildExampleEntry(parent: "Button", child: "Button(_:action:)", code: """
        Button("Save") {
            save()
        }
        """) { AnyView(C09_ButtonActionExample()) },

        ChildExampleEntry(parent: "Button", child: "Button(_:role:action:)", code: """
        Menu("Actions") {
            Button("Duplicate") { duplicate() }
            Button("Delete", role: .destructive) { deleteItem() }   // red in menus
        }
        Button("Cancel", role: .cancel) { dismiss() }
        """) { AnyView(C09_ButtonRoleExample()) },

        ChildExampleEntry(parent: "Button", child: "Button(_:systemImage:action:)", code: """
        Button("Compose", systemImage: "square.and.pencil") {
            startDraft()
        }
        .buttonStyle(.bordered)
        """) { AnyView(C09_ButtonSystemImageExample()) },

        // MARK: Canvas

        ChildExampleEntry(parent: "Canvas", child: "Canvas(opaque:colorMode:rendersAsynchronously:renderer:)", code: """
        let sunset = Gradient(colors: [.orange, .pink, .indigo])

        Canvas(opaque: true, colorMode: .linear, rendersAsynchronously: true) { context, size in
            context.fill(
                Path(CGRect(origin: .zero, size: size)),
                with: .linearGradient(sunset, startPoint: .zero, endPoint: CGPoint(x: 0, y: size.height))
            )
        }
        .frame(height: 120)
        """) { AnyView(C09_CanvasFlagsExample()) },

        ChildExampleEntry(parent: "Canvas", child: "Canvas(opaque:colorMode:rendersAsynchronously:renderer:symbols:)", code: """
        Canvas { context, size in
            guard let star = context.resolveSymbol(id: "star") else { return }
            for point in starPositions(in: size) {
                context.draw(star, at: point)
            }
        } symbols: {
            Image(systemName: "star.fill").foregroundStyle(.yellow).tag("star")
        }
        """) { AnyView(C09_CanvasSymbolsExample()) },

    ]
}

// MARK: - Example views

private struct C09_AnyViewInitExample: View {
    @State private var enabled = true

    private var cells: [AnyView] {
        [
            AnyView(Text("Name")),
            AnyView(Toggle("Enabled", isOn: $enabled)),
            AnyView(Image(systemName: "star"))
        ]
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(cells.indices, id: \.self) { cells[$0] }
            Text("Text, Toggle and Image share one [AnyView] storage type")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_AnyViewErasingExample: View {
    @State private var isVerified = true

    private func erased<V: View>(_ view: V) -> AnyView {
        AnyView(erasing: view)
    }

    var body: some View {
        VStack(spacing: 12) {
            Toggle("Verified", isOn: $isVerified)
            let badge = isVerified
                ? erased(Image(systemName: "checkmark.seal.fill").foregroundStyle(.blue))
                : erased(Text("—"))
            badge.font(.largeTitle)
        }
        .padding()
    }
}

private struct C09_AsyncImageURLExample: View {
    var body: some View {
        VStack(spacing: 10) {
            AsyncImage(url: nil)
                .frame(width: 44, height: 44)
                .overlay(RoundedRectangle(cornerRadius: 6).strokeBorder(.secondary.opacity(0.4)))
            Text("Illustrative — no network in this preview; the built-in gray placeholder shows until the fetch finishes")
                .font(.caption).foregroundStyle(.secondary).multilineTextAlignment(.center)
        }
        .padding()
    }
}

private struct C09_AsyncImagePlaceholderExample: View {
    var body: some View {
        VStack(spacing: 10) {
            AsyncImage(url: nil) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.2).overlay(ProgressView())
            }
            .frame(width: 140, height: 90)
            .clipShape(.rect(cornerRadius: 8))
            Text("Illustrative — no network here, so the custom placeholder stays visible")
                .font(.caption).foregroundStyle(.secondary).multilineTextAlignment(.center)
        }
        .padding()
    }
}

private struct C09_AsyncImagePhaseExample: View {
    var body: some View {
        VStack(spacing: 10) {
            AsyncImage(url: nil, transaction: Transaction(animation: .easeOut)) { phase in
                switch phase {
                case .success(let image): image.resizable().scaledToFit()
                case .failure: Image(systemName: "photo.badge.exclamationmark").font(.largeTitle)
                case .empty: ProgressView()
                @unknown default: EmptyView()
                }
            }
            .frame(width: 140, height: 90)
            .background(.quaternary, in: .rect(cornerRadius: 8))
            Text("Illustrative — url is nil here; each phase branch renders with live data at runtime")
                .font(.caption).foregroundStyle(.secondary).multilineTextAlignment(.center)
        }
        .padding()
    }
}

private struct C09_ButtonActionExample: View {
    @State private var saveCount = 0

    var body: some View {
        VStack(spacing: 10) {
            Button("Save") {
                saveCount += 1
            }
            Text("save() ran \(saveCount) time\(saveCount == 1 ? "" : "s")")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_ButtonRoleExample: View {
    @State private var lastAction = "—"

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Menu("Actions") {
                    Button("Duplicate") { lastAction = "duplicate" }
                    Button("Delete", role: .destructive) { lastAction = "delete (destructive)" }
                }
                .fixedSize()
                Button("Cancel", role: .cancel) { lastAction = "cancel" }
            }
            Text("Last: \(lastAction)").font(.caption).foregroundStyle(.secondary)
            Text("The destructive role renders red inside the menu")
                .font(.caption2).foregroundStyle(.tertiary)
        }
        .padding()
    }
}

private struct C09_ButtonSystemImageExample: View {
    @State private var drafts = 0

    var body: some View {
        VStack(spacing: 12) {
            Button("Compose", systemImage: "square.and.pencil") {
                drafts += 1
            }
            .buttonStyle(.bordered)
            Button("Compose", systemImage: "square.and.pencil") {
                drafts += 1
            }
            .buttonStyle(.bordered)
            .labelStyle(.iconOnly)
            Text("Drafts started: \(drafts) — the same Label, icon-only below")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_CanvasFlagsExample: View {
    private let sunset = Gradient(colors: [.orange, .pink, .indigo])

    var body: some View {
        VStack(spacing: 8) {
            Canvas(opaque: true, colorMode: .linear, rendersAsynchronously: true) { context, size in
                context.fill(
                    Path(CGRect(origin: .zero, size: size)),
                    with: .linearGradient(sunset, startPoint: .zero, endPoint: CGPoint(x: 0, y: size.height))
                )
            }
            .frame(height: 120)
            .clipShape(.rect(cornerRadius: 8))
            Text("opaque: true skips alpha compositing; colorMode: .linear blends in linear space")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct C09_CanvasSymbolsExample: View {
    private func starPositions(in size: CGSize) -> [CGPoint] {
        let fractions: [(CGFloat, CGFloat)] = [
            (0.12, 0.30), (0.30, 0.65), (0.48, 0.25), (0.62, 0.70), (0.80, 0.40), (0.92, 0.75)
        ]
        return fractions.map { CGPoint(x: size.width * $0.0, y: size.height * $0.1) }
    }

    var body: some View {
        VStack(spacing: 8) {
            Canvas { context, size in
                guard let star = context.resolveSymbol(id: "star") else { return }
                for point in starPositions(in: size) {
                    context.draw(star, at: point)
                }
            } symbols: {
                Image(systemName: "star.fill").font(.title).foregroundStyle(.yellow).tag("star")
            }
            .frame(height: 110)
            .background(.indigo.gradient, in: .rect(cornerRadius: 8))
            Text("One tagged symbol view, resolved once and stamped six times")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
    }
}
