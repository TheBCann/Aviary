//
//  TopicDetailView.swift
//  Swift-UI-Companion
//
//  The documentation page for one catalog entry.
//

import SwiftUI

struct TopicDetailView: View {
    let topic: Topic
    @Environment(AppModel.self) private var model

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                header

                AvailabilityRow(topic: topic)

                Divider()

                Text(topic.discussion)
                    .font(.body)
                    .lineSpacing(3)

                if !topic.children.isEmpty {
                    VariantsSection(topic: topic)
                }

                if let demo = DemoRegistry.view(for: topic.demoID) {
                    demo
                } else {
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Example", systemImage: "curlybraces")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        CodeBlockView(code: topic.code)
                    }
                }

                if !topic.related.isEmpty {
                    relatedSection
                }
            }
            .padding(24)
            .frame(maxWidth: 760, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .center)
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

/// Buttons linking a topic's page to each of its child entries.
struct VariantsSection: View {
    let topic: Topic
    @Environment(AppModel.self) private var model

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("Variants", systemImage: "list.bullet.indent")
                .font(.headline)
                .foregroundStyle(.secondary)

            VStack(alignment: .leading, spacing: 4) {
                ForEach(topic.children) { child in
                    Button {
                        model.activeTab.selectedTopicID = child.id
                    } label: {
                        HStack {
                            Text(child.name)
                                .font(.system(.callout, design: .monospaced))
                                .lineLimit(1)
                                .truncationMode(.middle)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption2)
                                .foregroundStyle(.tertiary)
                        }
                        .contentShape(.rect)
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    .background(.background.secondary, in: .rect(cornerRadius: 8))
                }
            }
        }
    }
}

/// The documentation page for one child entry, with a breadcrumb back to
/// its parent topic.
struct ChildDetailView: View {
    let topic: Topic
    let child: TopicChild
    @Environment(AppModel.self) private var model

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                Button {
                    model.activeTab.selectedTopicID = topic.id
                } label: {
                    Label(topic.name, systemImage: "chevron.backward")
                        .font(.system(.callout, design: .monospaced))
                }
                .buttonStyle(.link)

                Text(child.name)
                    .font(.system(.title, design: .monospaced).weight(.bold))
                    .textSelection(.enabled)

                Text(child.summary)
                    .font(.title3)
                    .foregroundStyle(.secondary)

                AvailabilityRow(topic: topic)

                Divider()

                if !child.discussion.isEmpty {
                    Text(child.discussion)
                        .font(.body)
                        .lineSpacing(3)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Label("Example", systemImage: "curlybraces")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    CodeBlockView(code: child.code)
                }

                let siblings = topic.children.filter { $0.id != child.id }
                if !siblings.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Other variants", systemImage: "list.bullet.indent")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        ForEach(siblings) { sibling in
                            Button(sibling.name) {
                                model.activeTab.selectedTopicID = sibling.id
                            }
                            .buttonStyle(.link)
                            .font(.system(.callout, design: .monospaced))
                        }
                    }
                }
            }
            .padding(24)
            .frame(maxWidth: 760, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .center)
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
