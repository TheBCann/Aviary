//
//  TopicDetailView.swift
//  Aviary
//

import SwiftUI

struct TopicDetailView: View {
    let topic: Topic
    /// When a variant is selected, its example swaps into the page in place;
    /// the parent's header, availability, and discussion stay put.
    var focusedChild: TopicChild? = nil
    @Environment(AppModel.self) private var model

    private let exampleAnchor = "example"

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    header

                    AvailabilityRow(topic: topic)

                    Divider()

                    Text(topic.discussion)
                        .font(.body)
                        .lineSpacing(3)

                    if !topic.children.isEmpty {
                        VariantsSection(topic: topic, focusedChildID: focusedChild?.id)
                    }

                    exampleRegion
                        .id(exampleAnchor)

                    if !topic.related.isEmpty {
                        relatedSection
                    }
                }
                .padding(24)
                .frame(maxWidth: 760, alignment: .leading)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .onChange(of: focusedChild?.id) { _, newID in
                if newID != nil {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        proxy.scrollTo(exampleAnchor, anchor: .center)
                    }
                }
            }
        }
    }

    /// The swappable region: the selected variant's example, or — when the
    /// topic itself is selected — its interactive demo, rendered example, or
    /// static code.
    @ViewBuilder
    private var exampleRegion: some View {
        if let child = focusedChild {
            ChildExampleSection(child: child)
                .transition(.opacity)
        } else if let demo = DemoRegistry.view(for: topic.demoID) {
            demo
        } else if let example = ExampleRegistry.entry(for: topic.name) {
            ExampleSection(entry: example)
        } else {
            VStack(alignment: .leading, spacing: 8) {
                Label("Example", systemImage: "curlybraces")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                CodeBlockView(code: topic.code)
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Label(topic.kind.rawValue, systemImage: topic.kind.symbolName)
                    .font(.caption.weight(.semibold))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(topic.kind.tint.opacity(0.15), in: .capsule)
                    .foregroundStyle(topic.kind.tint)

                if topic.framework != "SwiftUI" {
                    Label(topic.framework, systemImage: "shippingbox")
                        .font(.caption.weight(.semibold))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(.brown.opacity(0.15), in: .capsule)
                        .foregroundStyle(.brown)
                        .help("Requires import \(topic.framework.replacingOccurrences(of: " ", with: ""))")
                }

                if topic.deprecated {
                    Label("Deprecated", systemImage: "exclamationmark.triangle.fill")
                        .font(.caption.weight(.semibold))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(.orange.opacity(0.15), in: .capsule)
                        .foregroundStyle(.orange)
                }

                Spacer()

                Text("WWDC '\(topic.wwdcYear % 100)")
                    .font(.caption.weight(.semibold))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(.quaternary, in: .capsule)
                    .foregroundStyle(.secondary)
            }

            Text(topic.name)
                .font(.system(.largeTitle, design: .monospaced).weight(.bold))
                .textSelection(.enabled)

            Text(topic.summary)
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }

    private var relatedSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("See also", systemImage: "link")
                .font(.headline)
                .foregroundStyle(.secondary)

            HStack(spacing: 8) {
                ForEach(topic.related, id: \.self) { name in
                    if let target = model.topic(withID: name) {
                        Button(name) {
                            model.reveal(target)
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.small)
                        .font(.system(.caption, design: .monospaced))
                    } else {
                        Text(name)
                            .font(.system(.caption, design: .monospaced))
                            .foregroundStyle(.tertiary)
                    }
                }
            }
        }
    }
}

/// The variant picker. Selecting a row swaps its example into the page in
/// place (see TopicDetailView.focusedChild); the active row is highlighted,
/// and an Overview row returns to the topic's own example.
struct VariantsSection: View {
    let topic: Topic
    var focusedChildID: String? = nil
    @Environment(AppModel.self) private var model

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("Variants", systemImage: "list.bullet.indent")
                .font(.headline)
                .foregroundStyle(.secondary)

            VStack(alignment: .leading, spacing: 4) {
                overviewRow

                ForEach(topic.children) { child in
                    row(
                        title: child.name,
                        isActive: focusedChildID == child.id,
                        activeIcon: "checkmark"
                    ) {
                        model.activeTab.selectedTopicID = child.id
                    }
                }
            }
        }
    }

    @ViewBuilder
    private var overviewRow: some View {
        // Only useful once a variant is focused; then it swaps back to the
        // topic's own demo/example.
        if focusedChildID != nil {
            row(title: "Overview", isActive: false, activeIcon: "checkmark") {
                model.activeTab.selectedTopicID = topic.id
            }
            .foregroundStyle(.secondary)
        }
    }

    private func row(
        title: String,
        isActive: Bool,
        activeIcon: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.system(.callout, design: .monospaced))
                    .lineLimit(1)
                    .truncationMode(.middle)
                Spacer()
                Image(systemName: isActive ? activeIcon : "chevron.right")
                    .font(.caption2)
                    .foregroundStyle(isActive ? AnyShapeStyle(Color.accentColor) : AnyShapeStyle(.tertiary))
            }
            .contentShape(.rect)
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 10)
        .padding(.vertical, 7)
        .background(
            isActive ? AnyShapeStyle(Color.accentColor.opacity(0.18))
                     : AnyShapeStyle(.background.secondary),
            in: .rect(cornerRadius: 8)
        )
        .overlay {
            if isActive {
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.accentColor.opacity(0.5), lineWidth: 1)
            }
        }
    }
}

/// The in-place example for a selected variant: its identity, summary,
/// optional discussion, and code.
struct ChildExampleSection: View {
    let child: TopicChild

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("Selected variant", systemImage: "curlybraces")
                .font(.headline)
                .foregroundStyle(.secondary)

            Text(child.name)
                .font(.system(.title3, design: .monospaced).weight(.semibold))
                .textSelection(.enabled)

            Text(child.summary)
                .font(.callout)
                .foregroundStyle(.secondary)

            if !child.discussion.isEmpty {
                Text(child.discussion)
                    .font(.body)
                    .lineSpacing(3)
            }

            CodeBlockView(code: child.code)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.background.secondary, in: .rect(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(.quaternary, lineWidth: 1)
        }
    }
}

/// Per-platform availability badges, e.g. "iOS 13.0+".
struct AvailabilityRow: View {
    let topic: Topic

    var body: some View {
        HStack(spacing: 8) {
            ForEach(ApplePlatform.allCases) { platform in
                if let version = topic.introducedVersion(on: platform) {
                    Label("\(platform.rawValue) \(version)+", systemImage: platform.symbolName)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(.green.opacity(0.12), in: .capsule)
                        .foregroundStyle(.green)
                } else {
                    Label(platform.rawValue, systemImage: platform.symbolName)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(.quaternary.opacity(0.5), in: .capsule)
                        .foregroundStyle(.tertiary)
                        .strikethrough()
                }
            }
            Spacer()
        }
    }
}
