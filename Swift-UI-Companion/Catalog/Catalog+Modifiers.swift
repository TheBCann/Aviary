//
//  Catalog+Modifiers.swift
//  Swift-UI-Companion
//

import Foundation

extension Catalog {
    static let modifiers: [Topic] = [
        Topic(
            name: ".padding()",
            kind: .modifier,
            summary: "Adds space around a view's edges.",
            discussion: "Without arguments, padding applies the platform's default amount on every edge. Pass an edge set and length for precise control. Order matters: padding before a background grows the colored area, padding after it pushes the whole decorated view inward.",
            wwdcYear: 2019,
            code: #"""
            Text("Boxed")
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(.yellow.opacity(0.3))
            """#,
            demoID: "padding",
            related: [".frame()", ".background()"],
            children: [
                TopicChild(
                    name: "padding()",
                    summary: "padding(_:_:) with everything defaulted: all edges, the platform's standard length.",
                    discussion: "Not a distinct overload — this is the fully-defaulted call of padding(_:_:), where the edge set falls back to .all and the length to a system-chosen amount per platform and context, so it stays appropriate without hardcoding a number. Reach for it first and only specify lengths when a design demands them.",
                    code: #"""
                    Text("Comfortable")
                        .padding()
                        .border(.secondary)
                    """#
                ),
                TopicChild(
                    name: "padding(_:)",
                    summary: "One length applied uniformly to every edge.",
                    code: #"""
                    Image(systemName: "star.fill")
                        .padding(12)
                        .background(.quaternary, in: .circle)
                    """#
                ),
                TopicChild(
                    name: "padding(_:_:)",
                    summary: "An edge set plus a length — pad only where you say.",
                    discussion: "Stacking two calls with different edge sets is the common way to get asymmetric insets, like wide horizontal padding with tight vertical padding.",
                    code: #"""
                    Text("Wide sides")
                        .padding(.horizontal, 24)
                        .padding(.top, 4)
                    """#
                ),
            ]
        ),
        Topic(
            name: ".frame()",
            kind: .modifier,
            summary: "Proposes a fixed or bounded size for a view.",
            discussion: "frame wraps its target in an invisible container of the given dimensions and aligns the content inside it. Fixed width/height pin exact sizes; minWidth/maxWidth express flexible bounds — maxWidth: .infinity is the idiom for filling available width.",
            wwdcYear: 2019,
            code: #"""
            Text("Stretch")
                .frame(maxWidth: .infinity, alignment: .leading)

            Color.blue
                .frame(width: 80, height: 80)
            """#,
            demoID: "frame",
            related: [".padding()", "Spacer"],
            children: [
                TopicChild(
                    name: "frame(width:height:alignment:)",
                    summary: "Pins exact dimensions; omit either axis to leave it flexible.",
                    discussion: "Both parameters are optional, so you can fix just a height while the width keeps following the content. Alignment places the content when it is smaller than the frame.",
                    code: #"""
                    Image(systemName: "photo")
                        .frame(width: 44, height: 44)

                    Divider()
                        .frame(height: 200)
                    """#
                ),
                TopicChild(
                    name: "frame(minWidth:idealWidth:maxWidth:minHeight:idealHeight:maxHeight:alignment:)",
                    summary: "Bounded sizing: clamp each axis between a minimum and maximum.",
                    discussion: "The six sizing parameters default to nil (alignment defaults to .center), so you state only the constraints you care about. The frame negotiates with the proposed size, clamping it into the given range rather than fixing it outright.",
                    code: #"""
                    TextEditor(text: $notes)
                        .frame(minHeight: 80, maxHeight: 240)
                    """#
                ),
                TopicChild(
                    name: "frame(maxWidth: .infinity) idiom",
                    summary: "A usage pattern of the flexible-frame overload, not a separate signature: fill the offered width.",
                    discussion: "This is the flexible frame called with only maxWidth. Passing .infinity tells the frame to accept all the width offered, and the alignment then decides where the content sits inside that expanse — the standard recipe for full-width buttons and leading-aligned rows.",
                    code: #"""
                    Text("Left-aligned in a full-width row")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.quinary)
                    """#
                ),
            ]
        ),
        Topic(
            name: ".background()",
            kind: .modifier,
            summary: "Layers a style or view behind the modified view.",
            discussion: "background places material behind a view without affecting layout of siblings. It accepts a ShapeStyle plus an optional shape — the concise way to draw tinted rounded platters — or an arbitrary trailing-closure view.",
            wwdcYear: 2019,
            code: #"""
            Label("Pro", systemImage: "crown")
                .padding(8)
                .background(.purple.gradient, in: .capsule)
            """#,
            related: [".overlay()", ".clipShape()", "ZStack"],
            children: [
                TopicChild(
                    name: "background(_:in:)",
                    summary: "Fills a shape with a style behind the view — the platter recipe.",
                    discussion: "One call replaces the older background-plus-clipShape dance for simple badges and chips: the style fills the given shape, and the shape sizes itself to the modified view.",
                    code: #"""
                    Text("NEW")
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(.orange, in: .capsule)
                    """#
                ),
                TopicChild(
                    name: "background(alignment:content:)",
                    summary: "Any view as the backdrop, aligned within the base view's bounds.",
                    discussion: "The trailing closure can build arbitrary content — images, gradients, whole stacks. The base view still dictates the layout size; the background just draws behind it.",
                    code: #"""
                    Text("Score: 42")
                        .background(alignment: .bottomTrailing) {
                            Image(systemName: "seal.fill")
                                .foregroundStyle(.yellow)
                        }
                    """#
                ),
                TopicChild(
                    name: "background(_:ignoresSafeAreaEdges:)",
                    summary: "A plain style behind the view, extending under chosen safe-area edges.",
                    discussion: "By default the style bleeds under all safe-area edges it touches, which is what a screen-wide backdrop usually wants. Pass an empty set to keep the background strictly inside the view's bounds.",
                    code: #"""
                    ContentColumn()
                        .background(.thinMaterial, ignoresSafeAreaEdges: .bottom)
                    """#
                ),
            ]
        ),
        Topic(
            name: ".overlay()",
            kind: .modifier,
            summary: "Layers a style or view in front of the modified view.",
            discussion: "overlay is background's mirror image: the extra content draws on top, aligned within the base view's bounds, and the base view keeps its size. Borders are the classic use — stroke a shape in an overlay so the line never changes layout.",
            wwdcYear: 2019,
            code: #"""
            Image("avatar")
                .clipShape(.circle)
                .overlay {
                    Circle().strokeBorder(.white, lineWidth: 2)
                }
            """#,
            related: [".background()", "ZStack"],
            children: [
                TopicChild(
                    name: "overlay(_:in:)",
                    summary: "Fills a shape with a style on top of the view.",
                    discussion: "Handy for wash effects and selection tints: the shape sizes itself to the underlying view and the style paints over it without disturbing layout.",
                    code: #"""
                    Image("cover")
                        .overlay(.black.opacity(0.25), in: .rect(cornerRadius: 12))
                    """#
                ),
                TopicChild(
                    name: "overlay(alignment:content:)",
                    summary: "Builds arbitrary content above the view, aligned to its bounds.",
                    discussion: "The classic home for badges and borders: the overlaid content is positioned by the alignment but never changes the size of the view underneath.",
                    code: #"""
                    ThumbnailView(item)
                        .overlay(alignment: .topTrailing) {
                            UnreadBadge(count: item.unread)
                                .padding(4)
                        }
                    """#
                ),
            ]
        ),
        Topic(
            name: ".clipShape()",
            kind: .modifier,
            summary: "Clips a view's rendering to a shape.",
            discussion: "clipShape masks drawing outside the given shape while leaving the layout frame untouched. With the shorthand shape styles — .circle, .capsule, .rect(cornerRadius:) — it replaces the older cornerRadius modifier.",
            wwdcYear: 2019,
            code: #"""
            Image("banner")
                .resizable()
                .scaledToFill()
                .frame(height: 120)
                .clipShape(.rect(cornerRadius: 16))
            """#,
            demoID: "clipShape",
            related: ["RoundedRectangle", ".overlay()", ".mask()"]
        ),
        Topic(
            name: ".shadow()",
            kind: .modifier,
            summary: "Draws a blurred shadow behind a view.",
            discussion: "shadow offsets and blurs a copy of the view's alpha channel. Small radii with subtle opacity read as elevation; the color parameter tints the shadow for glows. For shadows on shape fills specifically, the .shadow ShapeStyle keeps text inside unaffected.",
            wwdcYear: 2019,
            code: #"""
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
            """#,
            demoID: "effects",
            related: [".opacity()", ".blur()"],
            children: [
                TopicChild(
                    name: "shadow(color:radius:x:y:)",
                    summary: "The full form: tint, blur radius, and offset in points.",
                    discussion: "All parameters except radius have defaults — a semi-opaque black with no offset — so most call sites only tune what the design specifies. A small y offset with a modest radius reads as gentle elevation.",
                    code: #"""
                    CardView()
                        .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 3)
                    """#
                ),
                TopicChild(
                    name: "ShapeStyle.shadow(_:)",
                    summary: "Shadows the fill itself, not the whole view.",
                    discussion: "Applying .shadow(.drop(...)) or .shadow(.inner(...)) to a ShapeStyle confines the effect to that fill, so text or symbols layered on the shape stay crisp. Inner shadows give the pressed, inset look the view modifier cannot.",
                    code: #"""
                    Circle()
                        .fill(.blue.shadow(.inner(radius: 4, y: 2)))
                        .frame(width: 60, height: 60)
                    """#
                ),
            ]
        ),
        Topic(
            name: ".opacity()",
            kind: .modifier,
            summary: "Makes a view partially or fully transparent.",
            discussion: "opacity multiplies the transparency of the entire subtree, compositing it as one group. Animating between 0 and 1 is the simplest fade; a view at opacity 0 still occupies layout space, unlike one removed from the hierarchy.",
            wwdcYear: 2019,
            code: #"""
            Text("Ghost")
                .opacity(0.35)
            """#,
            demoID: "effects",
            related: [".shadow()", ".blur()", ".transition()"]
        ),
        Topic(
            name: ".blur()",
            kind: .modifier,
            summary: "Applies a Gaussian blur to a view.",
            discussion: "blur softens the view's rendering by the given radius. The opaque flag controls whether the effect extends past the view's edges. Prefer system Materials over manual blurs when the goal is a translucent background.",
            wwdcYear: 2019,
            code: #"""
            Image("secret")
                .blur(radius: isRevealed ? 0 : 12)
            """#,
            related: [".opacity()", ".shadow()"]
        ),
        Topic(
            name: ".font()",
            kind: .modifier,
            summary: "Sets the default font for text in a hierarchy.",
            discussion: "font propagates through the environment, so setting it on a container styles every Text and SF Symbol inside. Prefer semantic text styles (.title, .body) — they scale with Dynamic Type — over fixed sizes, and refine with fontWeight, fontDesign, and monospaced variants.",
            wwdcYear: 2019,
            code: #"""
            VStack {
                Text("Headline")
                Text("Details")
            }
            .font(.system(.body, design: .rounded))
            """#,
            related: ["Text", ".foregroundStyle()"],
            children: [
                TopicChild(
                    name: "font(_:)",
                    summary: "Sets a Font — semantic text styles scale, fixed sizes do not.",
                    discussion: "Dynamic Type only tracks the semantic styles like .headline and .caption, so prefer them over .system(size:) unless the design truly needs a fixed size.",
                    code: #"""
                    Text("Section")
                        .font(.headline)

                    Text("42")
                        .font(.system(size: 64, weight: .bold))
                    """#
                ),
                TopicChild(
                    name: "fontWeight(_:)",
                    summary: "Adjusts weight without replacing the font.",
                    code: #"""
                    Text("Emphasis without a new font")
                        .fontWeight(.semibold)
                    """#
                ),
                TopicChild(
                    name: "fontDesign(_:)",
                    summary: "Switches the design axis: default, rounded, serif, or monospaced.",
                    discussion: "Because it layers onto whatever font is already in the environment, one call restyles a whole hierarchy — rounded for playful UI, monospaced for numbers and code.",
                    code: #"""
                    VStack {
                        Text("Friendly title")
                        Text("And its caption")
                    }
                    .fontDesign(.rounded)
                    """#
                ),
            ]
        ),
        Topic(
            name: ".foregroundStyle()",
            kind: .modifier,
            summary: "Sets the style content draws with — color, gradient, or hierarchy.",
            discussion: "foregroundStyle supersedes foregroundColor and accepts any ShapeStyle: plain colors, gradients, materials, or the semantic .primary/.secondary/.tertiary levels. Passing multiple styles maps them onto the hierarchical layers of SF Symbols.",
            wwdcYear: 2021,
            code: #"""
            Image(systemName: "cloud.sun.rain.fill")
                .foregroundStyle(.gray, .yellow, .cyan)

            Text("Gradient text")
                .foregroundStyle(.linearGradient(
                    colors: [.pink, .orange],
                    startPoint: .leading, endPoint: .trailing))
            """#,
            related: [".font()", "LinearGradient", ".tint()"]
        ),
        Topic(
            name: ".animation()",
            kind: .modifier,
            summary: "Animates changes of a value with a given timing curve.",
            discussion: "The value-based form re-renders with animation whenever the observed value changes, leaving unrelated updates instant. Springs are the platform default feel; use withAnimation instead when the trigger is a specific event rather than a value.",
            wwdcYear: 2019,
            code: #"""
            Circle()
                .frame(width: isBig ? 120 : 60)
                .animation(.spring(duration: 0.4), value: isBig)
            """#,
            demoID: "animation",
            related: [".transition()", "Animatable", ".matchedGeometryEffect()"]
        ),
        Topic(
            name: ".transition()",
            kind: .modifier,
            summary: "Defines how a view appears and disappears.",
            discussion: "Transitions describe insertion and removal — opacity, scale, move, push — and only play inside an animated change. Compose them with combined, or split behavior with .asymmetric for different in/out effects.",
            wwdcYear: 2019,
            code: #"""
            if showBanner {
                BannerView()
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
            """#,
            demoID: "transition",
            related: [".animation()", ".matchedGeometryEffect()"]
        ),
        Topic(
            name: ".matchedGeometryEffect()",
            kind: .modifier,
            summary: "Interpolates a view's frame between two hierarchy positions.",
            discussion: "Tag a view in two different states with the same id and namespace, and SwiftUI animates position and size between them — the hero-transition primitive. Only one view per id should be visible at a time.",
            wwdcYear: 2020,
            code: #"""
            @Namespace private var hero

            if isExpanded {
                DetailCard()
                    .matchedGeometryEffect(id: "card", in: hero)
            } else {
                ThumbCard()
                    .matchedGeometryEffect(id: "card", in: hero)
            }
            """#,
            related: ["@Namespace", ".transition()", ".animation()"]
        ),
        Topic(
            name: ".onTapGesture()",
            kind: .modifier,
            summary: "Runs an action when the view is tapped or clicked.",
            discussion: "onTapGesture attaches a discrete tap recognizer, with an optional count for double-taps. Reach for Button instead when the content is semantically a control — it brings accessibility, focus, and styling for free.",
            wwdcYear: 2019,
            code: #"""
            Image(systemName: "heart")
                .onTapGesture(count: 2) {
                    isLiked.toggle()
                }
            """#,
            related: ["Button", "@GestureState"]
        ),
        Topic(
            name: ".task()",
            kind: .modifier,
            summary: "Runs async work tied to the view's lifetime.",
            discussion: "task starts its async closure when the view appears and cancels it automatically on disappear — structured concurrency's answer to onAppear-plus-Task. The id variant restarts the work whenever the id value changes.",
            wwdcYear: 2021,
            code: #"""
            List(articles) { ArticleRow($0) }
                .task {
                    articles = await store.loadArticles()
                }
            """#,
            related: [".onAppear()", "AsyncImage"]
        ),
        Topic(
            name: ".onAppear()",
            kind: .modifier,
            summary: "Runs an action when the view is shown.",
            discussion: "onAppear fires as the view joins the visible hierarchy, with onDisappear as its counterpart. For async loading prefer task, which handles cancellation; onAppear remains right for synchronous side effects like analytics.",
            wwdcYear: 2019,
            code: #"""
            DetailView()
                .onAppear {
                    logView("detail")
                }
            """#,
            related: [".task()"]
        ),
        Topic(
            name: ".sheet()",
            kind: .modifier,
            summary: "Presents a modal sheet over the current context.",
            discussion: "sheet presents when its isPresented binding turns true, or with item, whenever an optional identifiable value is non-nil — the safer pattern for editing a specific model. presentationDetents gives sheets resizable heights on iOS.",
            wwdcYear: 2019,
            code: #"""
            .sheet(item: $editingContact) { contact in
                ContactEditor(contact)
                    .presentationDetents([.medium, .large])
            }
            """#,
            related: [".alert()", ".popover()"],
            children: [
                TopicChild(
                    name: "sheet(isPresented:onDismiss:content:)",
                    summary: "Boolean-driven presentation; onDismiss runs after it closes.",
                    discussion: "The binding flips back to false however the sheet is dismissed — swipe, button, or programmatically — so state and UI cannot drift apart.",
                    code: #"""
                    Button("Settings") { showSettings = true }
                        .sheet(isPresented: $showSettings) {
                            SettingsView()
                        }
                    """#
                ),
                TopicChild(
                    name: "sheet(item:onDismiss:content:)",
                    summary: "Presents whenever an optional Identifiable value is non-nil.",
                    discussion: "The content closure receives the unwrapped value, which removes a whole class of stale-state bugs: the sheet always shows the item that triggered it, and setting a new item swaps the presentation.",
                    code: #"""
                    .sheet(item: $selectedRecipe, onDismiss: { refreshList() }) { recipe in
                        RecipeDetail(recipe)
                    }
                    """#
                ),
            ]
        ),
        Topic(
            name: ".alert()",
            kind: .modifier,
            summary: "Shows an alert dialog with title, message, and actions.",
            discussion: "alert binds presentation to a Boolean or optional data, with buttons declared as regular Buttons — roles mark the cancel and destructive ones. Keep alerts for interruptions that need a decision; use confirmationDialog for choice lists.",
            wwdcYear: 2021,
            code: #"""
            .alert("Delete file?", isPresented: $confirmDelete) {
                Button("Delete", role: .destructive) { delete() }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("This cannot be undone.")
            }
            """#,
            related: [".sheet()"]
        ),
        Topic(
            name: ".contextMenu()",
            kind: .modifier,
            summary: "Attaches a long-press or right-click menu to a view.",
            discussion: "contextMenu reveals actions on right-click (macOS) or touch-and-hold (iOS). The preview variant shows a custom view alongside the menu. Keep items to Buttons, Toggles, and nested Menus.",
            wwdcYear: 2019,
            code: #"""
            FileRow(file)
                .contextMenu {
                    Button("Rename") { rename(file) }
                    Button("Delete", role: .destructive) { delete(file) }
                }
            """#,
            related: ["Menu"]
        ),
        Topic(
            name: ".searchable()",
            kind: .modifier,
            summary: "Adds a platform search field bound to your text.",
            discussion: "searchable installs the search UI in the right place for the platform — navigation bar, sidebar, or toolbar — and drives your filtering through a plain string binding. Suggestions, scopes, and tokens layer onto the same modifier.",
            wwdcYear: 2021,
            code: #"""
            NavigationStack {
                List(results) { ResultRow($0) }
                    .searchable(text: $query, prompt: "Search parks")
            }
            """#,
            related: ["List", "NavigationStack"],
            children: [
                TopicChild(
                    name: "searchable(text:prompt:)",
                    summary: "The minimal form: a string binding and placeholder text.",
                    discussion: "The system decides where the field lives for the current platform and container. Your only job is filtering whatever the binding holds.",
                    code: #"""
                    List(filteredParks) { ParkRow($0) }
                        .searchable(text: $query, prompt: "Park name")
                    """#
                ),
                TopicChild(
                    name: "searchable(text:placement:prompt:)",
                    summary: "Adds a placement hint — sidebar, toolbar, or navigation bar.",
                    discussion: "Placement is a request, not a command: the platform honors it where it makes sense. .navigationBarDrawer(displayMode: .always) is the common iOS choice to keep the field from collapsing on scroll.",
                    code: #"""
                    List(results) { ResultRow($0) }
                        .searchable(
                            text: $query,
                            placement: .sidebar,
                            prompt: "Filter notes"
                        )
                    """#
                ),
                TopicChild(
                    name: "searchSuggestions(_:)",
                    summary: "Supplies a suggestion list shown while the field is active.",
                    discussion: "Attach searchCompletion to each row so tapping it fills the field. Returning an empty builder hides the suggestion panel and shows results directly.",
                    code: #"""
                    .searchable(text: $query)
                    .searchSuggestions {
                        ForEach(recentQueries, id: \.self) { term in
                            Label(term, systemImage: "clock")
                                .searchCompletion(term)
                        }
                    }
                    """#
                ),
            ]
        ),
        Topic(
            name: ".toolbar()",
            kind: .modifier,
            summary: "Places items in the navigation bar or toolbar.",
            discussion: "toolbar declares items with semantic placements — primaryAction, cancellationAction, principal — and the platform positions them appropriately. ToolbarItemGroup clusters related controls; customizable toolbars let users rearrange them on macOS.",
            wwdcYear: 2020,
            code: #"""
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add", systemImage: "plus") { add() }
                }
            }
            """#,
            related: ["NavigationStack", ".navigationTitle()"],
            children: [
                TopicChild(
                    name: "toolbar(content:)",
                    summary: "Declares toolbar items with semantic placements.",
                    discussion: "Placements say what an item means — confirmation, cancellation, navigation — and each platform maps that to a position, so the same declaration lands correctly on Mac and iPhone.",
                    code: #"""
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") { dismiss() }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") { save() }
                        }
                    }
                    """#
                ),
                TopicChild(
                    name: "toolbar(id:content:)",
                    summary: "A user-customizable toolbar; every item needs its own id.",
                    discussion: "With a stable toolbar id and per-item ids, macOS lets users add, remove, and rearrange items, persisting the arrangement across launches.",
                    code: #"""
                    .toolbar(id: "editor") {
                        ToolbarItem(id: "bold", placement: .secondaryAction) {
                            Button("Bold", systemImage: "bold") { toggleBold() }
                        }
                        ToolbarItem(id: "share", placement: .secondaryAction) {
                            ShareLink(item: documentURL)
                        }
                    }
                    """#
                ),
                TopicChild(
                    name: "toolbar(_:for:)",
                    summary: "Shows or hides entire bars — navigation bar, tab bar, window toolbar.",
                    discussion: "This overload takes a Visibility instead of content, which is how you get immersive full-screen moments: hide the bars for a photo viewer, restore them on exit.",
                    code: #"""
                    PhotoViewer(photo)
                        .toolbar(isImmersed ? .hidden : .visible, for: .navigationBar)
                    """#
                ),
            ]
        ),
        Topic(
            name: ".navigationTitle()",
            kind: .modifier,
            summary: "Sets the title of the enclosing navigation context.",
            discussion: "navigationTitle labels the current navigation destination — large or inline on iOS depending on navigationBarTitleDisplayMode, the window title on macOS. A string binding variant enables renamable document titles.",
            wwdcYear: 2020,
            code: #"""
            DetailView()
                .navigationTitle("Trip Details")
            """#,
            related: [".toolbar()", "NavigationStack"]
        ),
        Topic(
            name: ".sensoryFeedback()",
            kind: .modifier,
            summary: "Plays haptic or audio feedback when a value changes.",
            discussion: "sensoryFeedback declares feedback — success, warning, impact, selection — triggered by a value change, letting the system decide how it manifests per device. A condition closure filters which transitions actually play.",
            wwdcYear: 2023,
            platforms: [.iOS, .macOS, .watchOS],
            code: #"""
            Toggle("Armed", isOn: $armed)
                .sensoryFeedback(.success, trigger: armed) { _, new in
                    new == true
                }
            """#,
            related: [".animation()"]
        ),
        Topic(
            name: ".navigationTransition()",
            kind: .modifier,
            summary: "Customizes the transition into a navigation destination.",
            discussion: "Introduced at WWDC '24, navigationTransition(.zoom) makes a pushed detail view expand from a tagged source view and shrink back on pop — the system zoom transition previously exclusive to UIKit apps.",
            wwdcYear: 2024,
            platforms: [.iOS, .tvOS, .watchOS],
            code: #"""
            NavigationLink(value: photo) {
                PhotoThumb(photo)
                    .matchedTransitionSource(id: photo.id, in: zoomNS)
            }
            .navigationDestination(for: Photo.self) { photo in
                PhotoDetail(photo)
                    .navigationTransition(.zoom(sourceID: photo.id, in: zoomNS))
            }
            """#,
            related: ["NavigationStack", ".matchedGeometryEffect()"]
        ),
        Topic(
            name: ".onScrollGeometryChange()",
            kind: .modifier,
            summary: "Observes scroll offset and geometry without a GeometryReader.",
            discussion: "A WWDC '24 addition: transform the enclosing ScrollView's geometry into any Equatable value and react when it changes — the supported way to build offset-driven effects like collapsing headers.",
            wwdcYear: 2024,
            code: #"""
            ScrollView { content }
                .onScrollGeometryChange(for: Bool.self) { geometry in
                    geometry.contentOffset.y > 100
                } action: { _, isPast in
                    showCompactHeader = isPast
                }
            """#,
            related: ["ScrollView", "ScrollPosition"]
        ),
        Topic(
            name: ".presentationSizing()",
            kind: .modifier,
            summary: "Controls how a presented sheet or window sizes itself.",
            discussion: "New at WWDC '24, presentationSizing chooses between form, page, and fitted sizing for sheets — replacing ad-hoc frame math with semantic presets that adapt per platform.",
            wwdcYear: 2024,
            code: #"""
            .sheet(isPresented: $showInspector) {
                InspectorView()
                    .presentationSizing(.form)
            }
            """#,
            related: [".sheet()"]
        ),
    ]
}
