//
//  Catalog+Views.swift
//  Swift-UI-Companion
//

import Foundation

extension Catalog {
    static let views: [Topic] = [
        Topic(
            name: "Text",
            kind: .view,
            summary: "Displays one or more lines of read-only styled text.",
            discussion: "Text is the workhorse for showing strings. It supports Markdown in string literals, date and number formatting through format styles, and composes with font, weight, and color modifiers. Multiple Text values can be joined with + to mix styles inside one line.",
            wwdcYear: 2019,
            code: #"""
            VStack(alignment: .leading) {
                Text("Hello, SwiftUI!")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Rendered *with* **Markdown**.")
                Text(Date.now, style: .time)
                    .foregroundStyle(.secondary)
            }
            """#,
            demoID: "text",
            related: ["Label", "TextField", ".font()"],
            children: [
                TopicChild(
                    name: "Text(_:)",
                    summary: "Creates text from a string literal, with Markdown parsed.",
                    discussion: "A literal is treated as a LocalizedStringKey, so it participates in localization and inline Markdown like *emphasis* and **bold** renders styled.",
                    code: #"""
                    Text("Welcome back, **\(username)**")
                        .font(.headline)
                    """#
                ),
                TopicChild(
                    name: "Text(verbatim:)",
                    summary: "Shows a string exactly as given — no localization, no Markdown.",
                    code: #"""
                    Text(verbatim: "v2.1.0-beta+build.417")
                        .monospaced()
                    """#
                ),
                TopicChild(
                    name: "Text(_:style:)",
                    summary: "Renders a Date with a live-updating system style.",
                    discussion: "The relative, timer, and offset styles keep ticking on their own — no timer state required in your view.",
                    code: #"""
                    Text(meeting.start, style: .relative)
                    Text(meeting.start, style: .timer)
                    """#
                ),
                TopicChild(
                    name: "Text(_:format:)",
                    summary: "Formats any value through a FormatStyle at render time.",
                    code: #"""
                    Text(price, format: .currency(code: "USD"))
                    Text(distance, format: .number.precision(.fractionLength(1)))
                    """#
                ),
            ]
        ),
        Topic(
            name: "Label",
            kind: .view,
            summary: "Pairs a title with an icon in a standard layout.",
            discussion: "Label keeps text and image aligned the way the platform expects, and adapts when shown in toolbars, menus, or lists. Use labelStyle to show only the icon or only the title without changing the call site.",
            wwdcYear: 2020,
            code: #"""
            Label("Favorites", systemImage: "star.fill")
                .labelStyle(.titleAndIcon)
            """#,
            demoID: "label",
            related: ["Text", "Image", "LabelStyle"],
            children: [
                TopicChild(
                    name: "Label(_:systemImage:)",
                    summary: "Titles the label and pulls its icon from SF Symbols.",
                    code: #"""
                    Label("Favorites", systemImage: "star.fill")
                    """#
                ),
                TopicChild(
                    name: "Label(_:image:)",
                    summary: "Uses an image from your asset catalog as the icon.",
                    code: #"""
                    Label("Teams", image: "team-badge")
                    """#
                ),
                TopicChild(
                    name: "Label(title:icon:)",
                    summary: "Builds title and icon from arbitrary views.",
                    discussion: "The closure form is the escape hatch when either half needs styling of its own — a multi-line title, a tinted or resized icon.",
                    code: #"""
                    Label {
                        Text("Storage")
                            .font(.headline)
                    } icon: {
                        Image(systemName: "externaldrive")
                            .foregroundStyle(.tint)
                    }
                    """#
                ),
            ]
        ),
        Topic(
            name: "TextField",
            kind: .view,
            summary: "An editable, single-line text input bound to a string.",
            discussion: "TextField writes what the user types into a Binding<String>. It can also bind to non-string values through a format style, and the prompt argument supplies placeholder text. Pair with @FocusState to control keyboard focus programmatically.",
            wwdcYear: 2019,
            code: #"""
            @State private var name = ""

            TextField("Name", text: $name, prompt: Text("Your name"))
                .textFieldStyle(.roundedBorder)
            """#,
            related: ["SecureField", "TextEditor", "@FocusState"],
            children: [
                TopicChild(
                    name: "TextField(_:text:)",
                    summary: "The basic form: a titled field bound to a String.",
                    code: #"""
                    @State private var name = ""

                    TextField("Name", text: $name)
                    """#
                ),
                TopicChild(
                    name: "TextField(_:text:prompt:)",
                    summary: "Adds explicit placeholder text separate from the label.",
                    discussion: "The title still describes the field to accessibility and forms; the prompt is what shows in the empty field.",
                    code: #"""
                    TextField("Email", text: $email, prompt: Text("name@example.com"))
                    """#
                ),
                TopicChild(
                    name: "TextField(_:value:format:)",
                    summary: "Binds a non-string value through a parsing format style.",
                    discussion: "Typing is converted both ways: the value renders through the format, and committed edits parse back into it — invalid input leaves the binding untouched.",
                    code: #"""
                    @State private var amount = 0.0

                    TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    """#
                ),
                TopicChild(
                    name: "TextField(_:text:axis:)",
                    summary: "Lets the field grow vertically as the text wraps.",
                    code: #"""
                    TextField("Comment", text: $comment, axis: .vertical)
                        .lineLimit(1...5)
                    """#
                ),
            ]
        ),
        Topic(
            name: "SecureField",
            kind: .view,
            summary: "A text field that masks the characters the user types.",
            discussion: "SecureField behaves like TextField but obscures its content, making it the right control for passwords and other secrets. The bound string still contains the real value.",
            wwdcYear: 2019,
            code: #"""
            @State private var password = ""

            SecureField("Password", text: $password)
            """#,
            related: ["TextField"]
        ),
        Topic(
            name: "TextEditor",
            kind: .view,
            summary: "A scrollable, multi-line editable text region.",
            discussion: "TextEditor is the multi-line counterpart to TextField. It fills the space it is given, scrolls internally, and honors font and foregroundStyle modifiers for its content.",
            wwdcYear: 2020,
            platforms: [.iOS, .macOS],
            code: #"""
            @State private var notes = "Dear diary…"

            TextEditor(text: $notes)
                .font(.body)
                .frame(minHeight: 120)
            """#,
            related: ["TextField"]
        ),
        Topic(
            name: "Image",
            kind: .view,
            summary: "Renders an asset, SF Symbol, or platform image.",
            discussion: "Image draws fixed content at its natural size unless you mark it resizable. SF Symbols come through the systemName initializer and scale with the surrounding font. Combine resizable with scaledToFit or scaledToFill inside a frame for photos.",
            wwdcYear: 2019,
            code: #"""
            Image(systemName: "swift")
                .imageScale(.large)

            Image("beach")
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 120)
                .clipShape(.rect(cornerRadius: 12))
            """#,
            related: ["AsyncImage", "Label"],
            children: [
                TopicChild(
                    name: "Image(_:)",
                    summary: "Loads a named image from the asset catalog.",
                    code: #"""
                    Image("beach")
                        .resizable()
                        .scaledToFit()
                    """#
                ),
                TopicChild(
                    name: "Image(systemName:)",
                    summary: "Draws an SF Symbol that scales with the current font.",
                    discussion: "Symbols behave like text: font, imageScale, and foregroundStyle all apply, and many symbols support multicolor and variable rendering.",
                    code: #"""
                    Image(systemName: "cloud.sun.rain")
                        .symbolRenderingMode(.multicolor)
                        .font(.largeTitle)
                    """#
                ),
                TopicChild(
                    name: "Image(decorative:)",
                    summary: "An asset image that accessibility skips over entirely.",
                    discussion: "Use it for purely visual flourishes so VoiceOver users are not read a meaningless image name.",
                    code: #"""
                    Image(decorative: "confetti-background")
                        .resizable()
                        .scaledToFill()
                    """#
                ),
            ]
        ),
        Topic(
            name: "AsyncImage",
            kind: .view,
            summary: "Loads and displays an image from a URL asynchronously.",
            discussion: "AsyncImage downloads on a background task and swaps in the result when it arrives. The phase-based initializer lets you branch over empty, success, and failure states, and supply a placeholder while loading.",
            wwdcYear: 2021,
            code: #"""
            AsyncImage(url: URL(string: "https://example.com/photo.jpg")) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 220, height: 160)
            """#,
            related: ["Image", "ProgressView"],
            children: [
                TopicChild(
                    name: "AsyncImage(url:)",
                    summary: "The simplest form: fetches the URL, shows a gray placeholder meanwhile.",
                    code: #"""
                    AsyncImage(url: URL(string: "https://example.com/avatar.png"))
                        .frame(width: 44, height: 44)
                    """#
                ),
                TopicChild(
                    name: "AsyncImage(url:content:placeholder:)",
                    summary: "Lets you style the loaded image and supply your own placeholder.",
                    discussion: "The content closure only receives the successfully loaded image, so this form cannot distinguish a failure from still-loading — use the phase initializer for that.",
                    code: #"""
                    AsyncImage(url: photoURL) { image in
                        image.resizable().scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.2)
                    }
                    """#
                ),
                TopicChild(
                    name: "AsyncImage(url:scale:transaction:content:)",
                    summary: "Branches over every loading phase, with an animated swap-in.",
                    discussion: "The closure receives an AsyncImagePhase — empty, success, or failure — and the transaction animates the transition between them.",
                    code: #"""
                    AsyncImage(url: photoURL, transaction: Transaction(animation: .easeOut)) { phase in
                        switch phase {
                        case .success(let image): image.resizable().scaledToFit()
                        case .failure: Image(systemName: "photo.badge.exclamationmark")
                        case .empty: ProgressView()
                        @unknown default: EmptyView()
                        }
                    }
                    """#
                ),
            ]
        ),
        Topic(
            name: "Button",
            kind: .view,
            summary: "Runs an action when the user taps or clicks it.",
            discussion: "Button separates behavior (the action closure) from appearance (the label). Roles communicate intent — a destructive role renders red where the platform expects it — and buttonStyle plus controlSize change the visual weight without touching the action.",
            wwdcYear: 2019,
            code: #"""
            Button("Delete", role: .destructive) {
                deleteItem()
            }
            .buttonStyle(.borderedProminent)
            """#,
            demoID: "button",
            related: ["ButtonStyle", "Menu", "Link"],
            children: [
                TopicChild(
                    name: "Button(_:action:)",
                    summary: "A titled button that runs a closure when activated.",
                    code: #"""
                    Button("Save") {
                        save()
                    }
                    """#
                ),
                TopicChild(
                    name: "Button(_:role:action:)",
                    summary: "Attaches a semantic role such as destructive or cancel.",
                    discussion: "Roles let the platform place and color the button correctly — destructive turns red in menus and swipe actions, cancel gets the dismiss position in dialogs.",
                    code: #"""
                    Button("Delete", role: .destructive) {
                        deleteItem()
                    }
                    """#
                ),
                TopicChild(
                    name: "Button(_:systemImage:action:)",
                    summary: "Builds a Label-style button from a title and SF Symbol in one call.",
                    code: #"""
                    Button("Compose", systemImage: "square.and.pencil") {
                        startDraft()
                    }
                    """#
                ),
            ]
        ),
        Topic(
            name: "Toggle",
            kind: .view,
            summary: "A control that switches a Boolean binding on or off.",
            discussion: "Toggle reflects and writes a Binding<Bool>. Its rendering is platform- and context-dependent: a switch on iOS, a checkbox in macOS forms — and toggleStyle overrides that choice, including a button-like appearance.",
            wwdcYear: 2019,
            code: #"""
            @State private var isOn = true

            Toggle("Wi-Fi", isOn: $isOn)
                .toggleStyle(.switch)
            """#,
            demoID: "toggle",
            related: ["ToggleStyle", "Picker"],
            children: [
                TopicChild(
                    name: "Toggle(_:isOn:)",
                    summary: "A titled toggle bound to a Boolean.",
                    code: #"""
                    @State private var notificationsOn = true

                    Toggle("Notifications", isOn: $notificationsOn)
                    """#
                ),
                TopicChild(
                    name: "Toggle(_:systemImage:isOn:)",
                    summary: "Labels the toggle with a title and SF Symbol together.",
                    code: #"""
                    Toggle("Airplane Mode", systemImage: "airplane", isOn: $airplane)
                    """#
                ),
                TopicChild(
                    name: "Toggle(isOn:label:)",
                    summary: "Supplies the label as an arbitrary view.",
                    discussion: "Reach for the closure form when the label needs more than a string — a two-line description, custom styling, or composed views.",
                    code: #"""
                    Toggle(isOn: $backupEnabled) {
                        VStack(alignment: .leading) {
                            Text("iCloud Backup")
                            Text("Runs nightly on Wi-Fi")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    """#
                ),
            ]
        ),
        Topic(
            name: "Slider",
            kind: .view,
            summary: "Selects a value from a continuous range by dragging.",
            discussion: "Slider binds to a numeric value within a range you provide, with an optional step. Labels at the ends describe the extremes; the onEditingChanged closure reports when the drag begins and ends.",
            wwdcYear: 2019,
            platforms: [.iOS, .macOS, .watchOS],
            code: #"""
            @State private var volume = 0.5

            Slider(value: $volume, in: 0...1, step: 0.05) {
                Text("Volume")
            } minimumValueLabel: {
                Image(systemName: "speaker")
            } maximumValueLabel: {
                Image(systemName: "speaker.wave.3")
            }
            """#,
            demoID: "slider",
            related: ["Stepper", "ProgressView", "Gauge"],
            children: [
                TopicChild(
                    name: "Slider(value:in:)",
                    summary: "A continuous slider over a closed range.",
                    code: #"""
                    @State private var brightness = 0.8

                    Slider(value: $brightness, in: 0...1)
                    """#
                ),
                TopicChild(
                    name: "Slider(value:in:step:)",
                    summary: "Snaps the thumb to discrete increments.",
                    code: #"""
                    @State private var rating = 3.0

                    Slider(value: $rating, in: 0...5, step: 0.5)
                    """#
                ),
                TopicChild(
                    name: "Slider(value:in:onEditingChanged:)",
                    summary: "Reports when the drag gesture starts and ends.",
                    discussion: "Useful for deferring expensive work — apply a filter preview while editing is true, commit the real render when it flips back to false.",
                    code: #"""
                    Slider(value: $exposure, in: -2...2) { editing in
                        isScrubbing = editing
                    }
                    """#
                ),
            ]
        ),
        Topic(
            name: "Stepper",
            kind: .view,
            summary: "Increments or decrements a value with plus/minus controls.",
            discussion: "Stepper is the precise sibling of Slider: each press changes the bound value by a fixed step, clamped to an optional range. Use it where exact integer adjustments matter.",
            wwdcYear: 2019,
            platforms: [.iOS, .macOS, .watchOS],
            code: #"""
            @State private var quantity = 1

            Stepper("Quantity: \(quantity)", value: $quantity, in: 1...10)
            """#,
            related: ["Slider"]
        ),
        Topic(
            name: "Picker",
            kind: .view,
            summary: "Chooses one option from a set of mutually exclusive values.",
            discussion: "Picker binds a selection to tagged content. The same declaration renders as a menu, segmented control, wheel, or radio group depending on pickerStyle and platform, so choose the style that fits the context rather than building custom selection UI.",
            wwdcYear: 2019,
            code: #"""
            @State private var flavor = "Vanilla"

            Picker("Flavor", selection: $flavor) {
                ForEach(["Vanilla", "Chocolate", "Mango"], id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            """#,
            demoID: "picker",
            related: ["PickerStyle", "Toggle", "Menu"],
            children: [
                TopicChild(
                    name: "Picker(_:selection:content:)",
                    summary: "A titled picker whose options come from the content builder.",
                    discussion: "Each option needs a tag matching the selection's type — ForEach over Identifiable data tags rows automatically.",
                    code: #"""
                    Picker("Priority", selection: $priority) {
                        Text("Low").tag(Priority.low)
                        Text("Medium").tag(Priority.medium)
                        Text("High").tag(Priority.high)
                    }
                    """#
                ),
                TopicChild(
                    name: "Picker(_:systemImage:selection:content:)",
                    summary: "Adds an SF Symbol to the picker's label.",
                    code: #"""
                    Picker("Layout", systemImage: "square.grid.2x2", selection: $layout) {
                        ForEach(Layout.allCases) { Text($0.title) }
                    }
                    """#
                ),
                TopicChild(
                    name: "Picker(selection:content:label:)",
                    summary: "Supplies a fully custom view as the label.",
                    code: #"""
                    Picker(selection: $theme) {
                        ForEach(Theme.allCases) { Text($0.name) }
                    } label: {
                        Label("Theme", systemImage: "paintpalette")
                    }
                    """#
                ),
            ]
        ),
        Topic(
            name: "DatePicker",
            kind: .view,
            summary: "Selects a date, a time, or both from calendar-style UI.",
            discussion: "DatePicker binds to a Date and limits input through displayedComponents and an optional closed range. Styles range from the compact field to a full graphical calendar.",
            wwdcYear: 2019,
            platforms: [.iOS, .macOS, .watchOS],
            code: #"""
            @State private var departure = Date.now

            DatePicker(
                "Departure",
                selection: $departure,
                displayedComponents: [.date, .hourAndMinute]
            )
            .datePickerStyle(.compact)
            """#,
            demoID: "datePicker",
            related: ["Picker"],
            children: [
                TopicChild(
                    name: "DatePicker(_:selection:displayedComponents:)",
                    summary: "Picks a date, a time, or both, bound to a Date value.",
                    code: #"""
                    DatePicker(
                        "Reminder",
                        selection: $reminder,
                        displayedComponents: .hourAndMinute
                    )
                    """#
                ),
                TopicChild(
                    name: "DatePicker(_:selection:in:displayedComponents:)",
                    summary: "Restricts the selectable dates to a range.",
                    discussion: "Open-ended ranges work too — Date.now... forbids past dates without capping the future.",
                    code: #"""
                    DatePicker(
                        "Check-in",
                        selection: $checkIn,
                        in: Date.now...,
                        displayedComponents: .date
                    )
                    """#
                ),
                TopicChild(
                    name: "DatePicker(selection:displayedComponents:label:)",
                    summary: "Provides the label as a custom view.",
                    code: #"""
                    DatePicker(selection: $due, displayedComponents: .date) {
                        Label("Due date", systemImage: "calendar.badge.clock")
                    }
                    """#
                ),
            ]
        ),
        Topic(
            name: "ColorPicker",
            kind: .view,
            summary: "Opens the system color well to pick a color binding.",
            discussion: "ColorPicker presents the platform's color panel and writes the choice into a Binding<Color> (or CGColor). The supportsOpacity flag hides the alpha slider when transparency is not meaningful.",
            wwdcYear: 2020,
            platforms: [.iOS, .macOS],
            code: #"""
            @State private var accent = Color.blue

            ColorPicker("Accent color", selection: $accent, supportsOpacity: false)
            """#,
            related: ["Picker"]
        ),
        Topic(
            name: "ProgressView",
            kind: .view,
            summary: "Shows determinate progress or an indeterminate spinner.",
            discussion: "Without arguments ProgressView spins forever — the right choice when duration is unknown. Give it a value and total for a progress bar, or a timerInterval for a self-updating countdown. progressViewStyle switches between linear and circular renderings.",
            wwdcYear: 2020,
            code: #"""
            ProgressView("Uploading…", value: 0.7, total: 1.0)
                .progressViewStyle(.linear)

            ProgressView()   // indeterminate spinner
            """#,
            demoID: "progress",
            related: ["Gauge", "ProgressViewStyle"],
            children: [
                TopicChild(
                    name: "ProgressView()",
                    summary: "An indeterminate spinner for work of unknown length.",
                    code: #"""
                    ProgressView()
                        .controlSize(.large)
                    """#
                ),
                TopicChild(
                    name: "ProgressView(value:total:)",
                    summary: "A determinate bar showing value as a fraction of total.",
                    discussion: "Passing nil for value drops back to the indeterminate look, which makes one declaration serve both phases of a download.",
                    code: #"""
                    ProgressView(value: bytesReceived, total: bytesExpected)
                        .progressViewStyle(.linear)
                    """#
                ),
                TopicChild(
                    name: "ProgressView(timerInterval:countsDown:)",
                    summary: "Tracks a date interval automatically, counting down by default.",
                    code: #"""
                    ProgressView(
                        timerInterval: Date.now...Date.now.addingTimeInterval(60),
                        countsDown: true
                    )
                    """#
                ),
            ]
        ),
        Topic(
            name: "Gauge",
            kind: .view,
            summary: "Displays a value within a range, dial- or capacity-style.",
            discussion: "Gauge grew out of watch complications and shows where a current value sits between bounds, with optional labels for the value and the extremes. Accessory styles render compact dials suited to widgets and small spaces.",
            wwdcYear: 2022,
            platforms: [.iOS, .macOS, .watchOS],
            code: #"""
            Gauge(value: 74, in: 0...100) {
                Text("Battery")
            } currentValueLabel: {
                Text("74%")
            }
            .gaugeStyle(.accessoryCircular)
            """#,
            demoID: "gauge",
            related: ["ProgressView", "GaugeStyle"],
            children: [
                TopicChild(
                    name: "Gauge(value:in:label:)",
                    summary: "The minimal gauge: a value, its range, and a label.",
                    code: #"""
                    Gauge(value: speed, in: 0...240) {
                        Text("km/h")
                    }
                    """#
                ),
                TopicChild(
                    name: "Gauge(value:in:label:currentValueLabel:)",
                    summary: "Adds a label showing the current reading.",
                    discussion: "Accessory styles print the current value inside the dial, so keep this label short — a number, not a sentence.",
                    code: #"""
                    Gauge(value: cpuLoad, in: 0...1) {
                        Text("CPU")
                    } currentValueLabel: {
                        Text(cpuLoad, format: .percent.precision(.fractionLength(0)))
                    }
                    """#
                ),
                TopicChild(
                    name: "Gauge(value:in:label:currentValueLabel:minimumValueLabel:maximumValueLabel:)",
                    summary: "Also labels both extremes of the range.",
                    code: #"""
                    Gauge(value: 74, in: 0...100) {
                        Text("Battery")
                    } currentValueLabel: {
                        Text("74%")
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("100")
                    }
                    """#
                ),
            ]
        ),
        Topic(
            name: "Menu",
            kind: .view,
            summary: "A button that reveals a list of actions when pressed.",
            discussion: "Menu groups related actions behind one control, supporting nested submenus, dividers, and a primaryAction that runs on a plain tap while the menu appears on press-and-hold.",
            wwdcYear: 2020,
            platforms: [.iOS, .macOS, .tvOS],
            code: #"""
            Menu("Sort") {
                Button("By name") { sort(.name) }
                Button("By date") { sort(.date) }
                Divider()
                Button("Reverse", systemImage: "arrow.up.arrow.down") {
                    reverse()
                }
            }
            """#,
            related: ["Button", ".contextMenu()"],
            children: [
                TopicChild(
                    name: "Menu(_:content:)",
                    summary: "A titled menu whose items come from the content builder.",
                    code: #"""
                    Menu("Options") {
                        Button("Rename") { rename() }
                        Button("Duplicate") { duplicate() }
                        Button("Delete", role: .destructive) { delete() }
                    }
                    """#
                ),
                TopicChild(
                    name: "Menu(content:label:)",
                    summary: "Uses a custom view as the menu's visible control.",
                    code: #"""
                    Menu {
                        Picker("Sort by", selection: $sortKey) {
                            ForEach(SortKey.allCases) { Text($0.title) }
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                    """#
                ),
                TopicChild(
                    name: "Menu(_:content:primaryAction:)",
                    summary: "Runs a default action on tap; the menu opens on long press.",
                    discussion: "This is the split-button pattern — the common case is one tap away while the variants stay reachable.",
                    code: #"""
                    Menu("Bookmark") {
                        Button("Bookmark All Tabs") { bookmarkAll() }
                    } primaryAction: {
                        bookmarkCurrent()
                    }
                    """#
                ),
            ]
        ),
        Topic(
            name: "Link",
            kind: .view,
            summary: "Opens a URL in the appropriate app when activated.",
            discussion: "Link looks like a button but its action is fixed: open the destination URL, typically in the default browser. For custom handling, set the openURL environment value instead of intercepting the tap.",
            wwdcYear: 2020,
            code: #"""
            Link("Swift.org", destination: URL(string: "https://swift.org")!)
            """#,
            related: ["Button", "ShareLink", "openURL"]
        ),
        Topic(
            name: "ShareLink",
            kind: .view,
            summary: "Presents the system share sheet for an item.",
            discussion: "ShareLink hands any Transferable value to the platform share experience — no view controller bridging required. Provide a subject and message to prefill fields where the chosen activity supports them.",
            wwdcYear: 2022,
            platforms: [.iOS, .macOS, .watchOS],
            code: #"""
            ShareLink(
                item: URL(string: "https://example.com/article")!,
                subject: Text("Worth a read"),
                message: Text("Found this today.")
            )
            """#,
            related: ["Link", "Transferable"]
        ),
        Topic(
            name: "List",
            kind: .view,
            summary: "A scrolling container of rows with platform styling.",
            discussion: "List provides selection, swipe actions, separators, and editing for free, and reuses rows efficiently for large data sets. Rows come from static content, a ForEach over data, or hierarchical children for outlines. listStyle adapts it from inset-grouped tables to macOS sidebars.",
            wwdcYear: 2019,
            code: #"""
            struct Ocean: Identifiable {
                let name: String
                var id: String { name }
            }

            List(oceans, selection: $selected) { ocean in
                Text(ocean.name)
            }
            .listStyle(.sidebar)
            """#,
            related: ["ForEach", "Table", "ListStyle", "ScrollView"],
            children: [
                TopicChild(
                    name: "List(_:rowContent:)",
                    summary: "Builds one row per element of an Identifiable collection.",
                    code: #"""
                    List(oceans) { ocean in
                        Text(ocean.name)
                    }
                    """#
                ),
                TopicChild(
                    name: "List(selection:content:)",
                    summary: "Tracks the selected row (or rows) through a binding.",
                    discussion: "Bind a single optional id for one selection or a Set for multi-select; on macOS multi-select works immediately, on iOS it appears in edit mode.",
                    code: #"""
                    @State private var selection = Set<Ocean.ID>()

                    List(selection: $selection) {
                        ForEach(oceans) { Text($0.name) }
                    }
                    """#
                ),
                TopicChild(
                    name: "List(_:children:rowContent:)",
                    summary: "Renders a tree as an expandable outline.",
                    discussion: "The children key path points at an optional array of the same type — nil marks a leaf, an empty array an expandable-but-empty node.",
                    code: #"""
                    struct FileItem: Identifiable {
                        let id = UUID()
                        let name: String
                        var children: [FileItem]?
                    }

                    List(fileTree, children: \.children) { item in
                        Label(item.name, systemImage: item.children == nil ? "doc" : "folder")
                    }
                    """#
                ),
            ]
        ),
        Topic(
            name: "ForEach",
            kind: .view,
            summary: "Generates views from a collection of identified data.",
            discussion: "ForEach is not a loop — it is a view that maps identifiable data to child views, which lets SwiftUI diff, animate, and reorder them by identity. Prefer Identifiable data over id: \\.self for anything that can contain duplicates.",
            wwdcYear: 2019,
            code: #"""
            ForEach(items) { item in
                ItemRow(item)
            }
            .onDelete { offsets in
                items.remove(atOffsets: offsets)
            }
            """#,
            related: ["List", "LazyVGrid", "Identifiable"]
        ),
        Topic(
            name: "ScrollView",
            kind: .view,
            summary: "Scrolls arbitrary content along one or both axes.",
            discussion: "Unlike List, ScrollView imposes no row structure — it simply makes its content scrollable. Combine it with lazy stacks for long content, scrollTargetBehavior for paging, and ScrollViewReader or scrollPosition to control the offset programmatically.",
            wwdcYear: 2019,
            code: #"""
            ScrollView(.horizontal) {
                LazyHStack(spacing: 12) {
                    ForEach(photos) { photo in
                        PhotoCard(photo)
                    }
                }
            }
            .scrollIndicators(.hidden)
            """#,
            related: ["List", "LazyVGrid", "ScrollPosition"]
        ),
        Topic(
            name: "LazyVGrid",
            kind: .view,
            summary: "A vertically growing grid that creates items on demand.",
            discussion: "LazyVGrid arranges children into columns described by GridItem values — fixed, flexible, or adaptive — and instantiates rows only as they scroll into view. Use adaptive columns for photo-grid layouts that reflow with the window.",
            wwdcYear: 2020,
            code: #"""
            let columns = [GridItem(.adaptive(minimum: 90))]

            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(photos) { PhotoCell($0) }
                }
            }
            """#,
            demoID: "lazyGrid",
            related: ["Grid", "ScrollView", "ForEach"]
        ),
        Topic(
            name: "Grid",
            kind: .view,
            summary: "A static two-dimensional layout of aligned rows and columns.",
            discussion: "Grid loads all of its content at once and aligns cells across rows, which makes it ideal for forms, scoreboards, and comparison tables where columns must line up. GridRow defines each row; cells can span columns with gridCellColumns.",
            wwdcYear: 2022,
            code: #"""
            Grid(alignment: .leading, horizontalSpacing: 16) {
                GridRow {
                    Text("Plan")
                    Text("Price").gridColumnAlignment(.trailing)
                }
                Divider()
                GridRow {
                    Text("Pro")
                    Text("$9.99").gridColumnAlignment(.trailing)
                }
            }
            """#,
            demoID: "grid",
            related: ["LazyVGrid", "Table", "HStack"]
        ),
        Topic(
            name: "Table",
            kind: .view,
            summary: "A multi-column data table with sortable headers.",
            discussion: "Table maps key paths of your row type to columns, supporting selection, sorting via KeyPathComparator bindings, and context menus. On compact iOS widths it collapses to show only the first column.",
            wwdcYear: 2021,
            platforms: [.iOS, .macOS],
            code: #"""
            Table(people, selection: $selection, sortOrder: $order) {
                TableColumn("Name", value: \.name)
                TableColumn("Age") { person in
                    Text(person.age, format: .number)
                }
            }
            """#,
            related: ["List", "Grid"]
        ),
        Topic(
            name: "NavigationStack",
            kind: .view,
            summary: "Push-and-pop navigation driven by a typed path.",
            discussion: "NavigationStack replaces NavigationView with data-driven navigation: NavigationLink pushes values, and navigationDestination maps each value type to a destination view. Binding the path enables deep linking and programmatic pops.",
            wwdcYear: 2022,
            code: #"""
            NavigationStack(path: $path) {
                List(parks) { park in
                    NavigationLink(park.name, value: park)
                }
                .navigationDestination(for: Park.self) { park in
                    ParkDetail(park)
                }
            }
            """#,
            related: ["NavigationSplitView", "TabView"]
        ),
        Topic(
            name: "NavigationSplitView",
            kind: .view,
            summary: "Two- or three-column navigation for wide layouts.",
            discussion: "NavigationSplitView shows sidebar, optional content, and detail columns, collapsing to a stack on compact widths automatically. Drive it with list selection bindings; columnVisibility controls which columns are on screen.",
            wwdcYear: 2022,
            code: #"""
            NavigationSplitView {
                List(folders, selection: $folder) { Text($0.name) }
            } detail: {
                if let folder {
                    FolderDetail(folder)
                } else {
                    Text("Select a folder")
                }
            }
            """#,
            related: ["NavigationStack", "List"]
        ),
        Topic(
            name: "TabView",
            kind: .view,
            summary: "Switches between child views with a tab bar or pages.",
            discussion: "TabView presents parallel sections of an app. Since WWDC '24 the Tab initializer declares each tab with a title, image, and value in one place, and the sidebarAdaptable style lets iPadOS render tabs as a sidebar. The page style turns it into swipeable pages instead.",
            wwdcYear: 2019,
            code: #"""
            TabView(selection: $selection) {
                Tab("Library", systemImage: "books.vertical", value: .library) {
                    LibraryView()
                }
                Tab("Search", systemImage: "magnifyingglass", value: .search) {
                    SearchView()
                }
            }
            """#,
            related: ["NavigationStack", "Tab"],
            children: [
                TopicChild(
                    name: "TabView(selection:content:)",
                    summary: "Binds the active tab so code can switch sections.",
                    discussion: "The binding's type must match each tab's value (or tag). Writing to it programmatically changes tabs — handy for deep links and onboarding flows.",
                    code: #"""
                    @State private var selection: Section = .library

                    TabView(selection: $selection) {
                        Tab("Library", systemImage: "books.vertical", value: .library) {
                            LibraryView()
                        }
                        Tab("Search", systemImage: "magnifyingglass", value: .search) {
                            SearchView()
                        }
                    }
                    """#
                ),
                TopicChild(
                    name: "Tab(_:systemImage:value:content:)",
                    summary: "Declares one tab — title, icon, selection value, and content together.",
                    discussion: "Introduced at WWDC '24 to replace the tabItem modifier: the tab's identity lives in the declaration itself instead of being attached afterwards.",
                    code: #"""
                    Tab("Settings", systemImage: "gear", value: Section.settings) {
                        SettingsView()
                    }
                    """#
                ),
            ]
        ),
        Topic(
            name: "Form",
            kind: .view,
            summary: "Groups controls into platform-standard settings layouts.",
            discussion: "Form gives labeled controls the platform's settings appearance — grouped rows on iOS, aligned labels on macOS with the grouped form style. Sections add headers and visual separation; most controls adapt their look automatically inside a form.",
            wwdcYear: 2019,
            code: #"""
            Form {
                Section("Account") {
                    TextField("Username", text: $username)
                    Toggle("Public profile", isOn: $isPublic)
                }
            }
            .formStyle(.grouped)
            """#,
            related: ["Section", "List", "GroupBox"]
        ),
        Topic(
            name: "Section",
            kind: .view,
            summary: "A logical grouping with optional header and footer.",
            discussion: "Section structures the content of lists, forms, and pickers. Headers and footers take arbitrary views, and sections can be collapsible in sidebar-styled lists.",
            wwdcYear: 2019,
            code: #"""
            List {
                Section {
                    Text("Row")
                } header: {
                    Text("Today")
                } footer: {
                    Text("Updated just now.")
                }
            }
            """#,
            related: ["List", "Form"]
        ),
        Topic(
            name: "GroupBox",
            kind: .view,
            summary: "A visual container with a background and optional label.",
            discussion: "GroupBox draws its content on a rounded platter, giving related controls a visible boundary without the semantics of a Form. A label view titles the group.",
            wwdcYear: 2019,
            platforms: [.iOS, .macOS],
            code: #"""
            GroupBox("Notifications") {
                Toggle("Email", isOn: $email)
                Toggle("Push", isOn: $push)
            }
            """#,
            related: ["Form", "DisclosureGroup"]
        ),
        Topic(
            name: "DisclosureGroup",
            kind: .view,
            summary: "Shows or hides content behind a disclosure chevron.",
            discussion: "DisclosureGroup collapses secondary content until the user expands it, with an optional binding to control expansion programmatically. Lists build outline hierarchies from the same idea via the children parameter.",
            wwdcYear: 2020,
            platforms: [.iOS, .macOS],
            code: #"""
            DisclosureGroup("Advanced", isExpanded: $showAdvanced) {
                Toggle("Verbose logging", isOn: $verbose)
            }
            """#,
            related: ["GroupBox", "List"]
        ),
        Topic(
            name: "HStack",
            kind: .view,
            summary: "Arranges children in a horizontal line.",
            discussion: "HStack lays out its children left to right with a shared vertical alignment and spacing. It sizes to fit its content; add Spacer or frame(maxWidth:) to control distribution. For many children created lazily, use LazyHStack inside a ScrollView.",
            wwdcYear: 2019,
            code: #"""
            HStack(alignment: .firstTextBaseline, spacing: 12) {
                Text("Total")
                Spacer()
                Text("$42.00").bold()
            }
            """#,
            demoID: "stacks",
            related: ["VStack", "ZStack", "Spacer", "Grid"]
        ),
        Topic(
            name: "VStack",
            kind: .view,
            summary: "Arranges children in a vertical column.",
            discussion: "VStack stacks children top to bottom with a shared horizontal alignment. Alignment matters most with mixed-width children — leading alignment plus a maxWidth frame is the common recipe for form-like columns.",
            wwdcYear: 2019,
            code: #"""
            VStack(alignment: .leading, spacing: 8) {
                Text("Title").font(.headline)
                Text("Subtitle").foregroundStyle(.secondary)
            }
            """#,
            demoID: "stacks",
            related: ["HStack", "ZStack", "LazyVGrid"]
        ),
        Topic(
            name: "ZStack",
            kind: .view,
            summary: "Overlays children back to front in the same space.",
            discussion: "ZStack draws its children on top of each other, aligned by a shared anchor. Use it for badges, watermarks, and layered compositions; for a single decoration behind or in front of one view, background and overlay are lighter-weight.",
            wwdcYear: 2019,
            code: #"""
            ZStack(alignment: .topTrailing) {
                PhotoView()
                BadgeView()
                    .padding(6)
            }
            """#,
            related: ["HStack", "VStack", ".overlay()", ".background()"]
        ),
        Topic(
            name: "Spacer",
            kind: .view,
            summary: "Expands along the stack axis to push siblings apart.",
            discussion: "Inside a stack, Spacer greedily claims leftover space, which is how you pin content to edges or distribute it. The minLength parameter keeps a floor under how small it may shrink.",
            wwdcYear: 2019,
            code: #"""
            HStack {
                Image(systemName: "wifi")
                Spacer()
                Text("Connected")
            }
            """#,
            related: ["HStack", "Divider", ".frame()"]
        ),
        Topic(
            name: "Divider",
            kind: .view,
            summary: "A thin line separating content in a stack.",
            discussion: "Divider renders a hairline perpendicular to its containing stack's axis — horizontal in a VStack, vertical in an HStack. Tint it with foregroundStyle or replace it with a styled Rectangle for custom weight.",
            wwdcYear: 2019,
            code: #"""
            VStack {
                Text("Above")
                Divider()
                Text("Below")
            }
            """#,
            related: ["Spacer"]
        ),
        Topic(
            name: "Canvas",
            kind: .view,
            summary: "Immediate-mode drawing into a graphics context.",
            discussion: "Canvas hands you a GraphicsContext and a size every time it needs to draw, ideal for particle systems, charts, and other high-volume graphics that would be expensive as individual views. It redraws when its inputs change; pair with TimelineView for animation.",
            wwdcYear: 2021,
            code: #"""
            Canvas { context, size in
                let rect = CGRect(origin: .zero, size: size).insetBy(dx: 8, dy: 8)
                context.stroke(
                    Path(ellipseIn: rect),
                    with: .color(.orange),
                    lineWidth: 4
                )
            }
            """#,
            related: ["Path", "TimelineView", "Shape"]
        ),
        Topic(
            name: "TimelineView",
            kind: .view,
            summary: "Redraws its content on a schedule you choose.",
            discussion: "TimelineView re-evaluates its content at times supplied by a schedule — every minute, on animation frames, or explicit dates — without any state of your own. The context's date drives the drawing, which keeps clocks and ambient animations correct even in always-on displays.",
            wwdcYear: 2021,
            code: #"""
            TimelineView(.animation) { context in
                let angle = context.date.timeIntervalSinceReferenceDate
                    .truncatingRemainder(dividingBy: 2) * 180
                Image(systemName: "arrow.triangle.2.circlepath")
                    .rotationEffect(.degrees(angle))
            }
            """#,
            related: ["Canvas", ".animation()"]
        ),
        Topic(
            name: "ViewThatFits",
            kind: .view,
            summary: "Picks the first child that fits the available space.",
            discussion: "ViewThatFits tries its children in order and displays the first whose ideal size fits, making adaptive layouts declarative: offer a wide layout first and a compact fallback second, and let the container decide.",
            wwdcYear: 2022,
            code: #"""
            ViewThatFits {
                HStack { LongLabels() }   // preferred when space allows
                VStack { LongLabels() }   // fallback
            }
            """#,
            related: ["HStack", "VStack"]
        ),
        Topic(
            name: "ContentUnavailableView",
            kind: .view,
            summary: "A standard empty-state with icon, title, and description.",
            discussion: "ContentUnavailableView renders the platform's canonical empty state — use the search preset for no-results screens, or compose your own icon, description, and action buttons for empty libraries and error states.",
            wwdcYear: 2023,
            code: #"""
            ContentUnavailableView {
                Label("No Documents", systemImage: "tray")
            } description: {
                Text("Documents you add appear here.")
            } actions: {
                Button("Add Document") { add() }
            }
            """#,
            related: ["List"]
        ),
    ]
}
