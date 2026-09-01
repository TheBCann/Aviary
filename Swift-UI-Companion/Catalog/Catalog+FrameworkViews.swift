//
//  Catalog+FrameworkViews.swift
//  Swift-UI-Companion
//
//  SwiftUI views vended by other Apple frameworks — each entry notes the
//  module it requires importing.
//

import Foundation

extension Catalog {
    static let frameworkViews: [Topic] = [
        Topic(
            name: "Map",
            kind: .view,
            summary: "An interactive MapKit map with SwiftUI content.",
            discussion: "Map shows a region or camera position and takes markers, annotations, and overlays as builder content. Since 2023 the camera is a bindable MapCameraPosition, and map controls like the compass are separate composable views. Requires import MapKit.",
            wwdcYear: 2020,
            framework: "MapKit",
            code: #"""
            import MapKit

            Map(initialPosition: .region(region)) {
                Marker("HQ", coordinate: hq)
            }
            .mapStyle(.standard(elevation: .realistic))
            """#,
            related: ["Canvas"],
            children: [
                TopicChild(
                    name: "Map(initialPosition:content:)",
                    summary: "Starts the camera somewhere, then lets the user roam.",
                    discussion: "Fire-and-forget: the app sets the opening frame but never hears about later panning or zooming. Use the binding form when you need to observe or steer the camera.",
                    code: #"""
                    Map(initialPosition: .region(campus)) {
                        Marker("Library", coordinate: library)
                    }
                    """#
                ),
                TopicChild(
                    name: "Map(position:content:)",
                    summary: "Two-way binding to the camera position.",
                    discussion: "The binding updates as the user moves the map, and assigning a new MapCameraPosition — a region, a rect, or .userLocation — animates the camera there.",
                    code: #"""
                    @State private var position: MapCameraPosition = .automatic

                    Map(position: $position) {
                        UserAnnotation()
                    }
                    """#
                ),
            ]
        ),
        Topic(
            name: "VideoPlayer",
            kind: .view,
            summary: "Plays an AVPlayer's content with system controls.",
            discussion: "VideoPlayer wraps AVKit playback — transport controls, PiP eligibility — around an AVPlayer you own and can drive programmatically. The overlay builder layers SwiftUI views above the video surface. Requires import AVKit.",
            wwdcYear: 2020,
            platforms: [.iOS, .macOS, .tvOS],
            framework: "AVKit",
            code: #"""
            import AVKit

            VideoPlayer(player: AVPlayer(url: clipURL)) {
                Text("Preview").font(.caption).padding(4)
            }
            """#,
            related: ["AsyncImage"],
            children: [
                TopicChild(
                    name: "VideoPlayer(player:)",
                    summary: "System playback UI around the AVPlayer you supply.",
                    discussion: "The view never starts playback on its own — you own the player, so call play() yourself and reuse the same instance across view updates.",
                    code: #"""
                    VideoPlayer(player: player)
                        .onAppear { player.play() }
                    """#
                ),
                TopicChild(
                    name: "VideoPlayer(player:videoOverlay:)",
                    summary: "Layers SwiftUI content above the video surface.",
                    discussion: "The overlay sits over the video image itself — captions, watermarks, scoreboards — while the system transport controls stay on top of everything.",
                    code: #"""
                    VideoPlayer(player: player) {
                        VStack {
                            Text(caption).padding(6).background(.thinMaterial)
                            Spacer()
                        }
                    }
                    """#
                ),
            ]
        ),
        Topic(
            name: "SpriteView",
            kind: .view,
            summary: "Hosts a SpriteKit scene inside SwiftUI.",
            discussion: "SpriteView runs an SKScene with options for frame rate, debug overlays, and paused state — the fast path for 2D games and particle effects in a SwiftUI hierarchy. The scene object carries its own physics and node graph. Requires import SpriteKit.",
            wwdcYear: 2020,
            framework: "SpriteKit",
            code: #"""
            import SpriteKit

            SpriteView(
                scene: BouncingScene(size: CGSize(width: 300, height: 300)),
                options: [.allowsTransparency]
            )
            .frame(width: 300, height: 300)
            """#,
            related: ["SceneView", "Canvas", "TimelineView"],
            children: [
                TopicChild(
                    name: "SpriteView(scene:)",
                    summary: "Just the scene — default frame rate, opaque, running.",
                    code: #"""
                    SpriteView(scene: GameScene(size: CGSize(width: 320, height: 480)))
                        .ignoresSafeArea()
                    """#
                ),
                TopicChild(
                    name: "SpriteView(scene:transition:isPaused:preferredFramesPerSecond:options:)",
                    summary: "A heavily configured form: transition, pause, frame cap, options.",
                    discussion: "Every parameter past the scene has a default, so you only spell out what you change. The transition plays when the view switches to a different scene object, and isPaused freezes the scene's update loop. This still isn't the whole surface: a defaulted shouldRender: closure lets you skip rendering individual frames, and a sibling overload adds a debugOptions: parameter.",
                    code: #"""
                    SpriteView(
                        scene: level,
                        transition: .crossFade(withDuration: 0.4),
                        isPaused: isInMenu,
                        preferredFramesPerSecond: 120,
                        options: [.ignoresSiblingOrder]
                    )
                    """#
                ),
                TopicChild(
                    name: "SpriteView.Options",
                    summary: "Rendering flags: transparency, sibling order, culling.",
                    discussion: "allowsTransparency lets SwiftUI content show through the scene's clear areas, ignoresSiblingOrder frees SpriteKit to batch nodes at equal zPosition, and shouldCullNonVisibleNodes skips drawing offscreen nodes.",
                    code: #"""
                    SpriteView(
                        scene: hudScene,
                        options: [.allowsTransparency, .shouldCullNonVisibleNodes]
                    )
                    """#
                ),
            ]
        ),
        Topic(
            name: "SceneView",
            kind: .view,
            summary: "Renders a 3D SceneKit scene.",
            discussion: "SceneView displays an SCNScene with optional camera controls, letting users orbit and zoom 3D content without any UIKit/AppKit bridging. Rendering delegates and technique options pass through. Requires import SceneKit.",
            wwdcYear: 2020,
            platforms: [.iOS, .macOS, .tvOS],
            framework: "SceneKit",
            code: #"""
            import SceneKit

            SceneView(
                scene: SCNScene(named: "ship.scn"),
                options: [.allowsCameraControl, .autoenablesDefaultLighting]
            )
            """#,
            related: ["SpriteView"],
            children: [
                TopicChild(
                    name: "SceneView(scene:pointOfView:options:)",
                    summary: "Scene plus an optional camera node and render options.",
                    discussion: "pointOfView names the SCNNode to render from; leave it nil and the scene's own camera (or a default one) is used. Later parameters with defaults add a frame-rate target, antialiasing mode, and render delegate.",
                    code: #"""
                    SceneView(
                        scene: spaceScene,
                        pointOfView: chaseCamera,
                        options: [.rendersContinuously]
                    )
                    """#
                ),
                TopicChild(
                    name: "SceneView.Options",
                    summary: "Flags for camera control, lighting, jitter, and render cadence.",
                    discussion: "allowsCameraControl gives users orbit/zoom gestures, autoenablesDefaultLighting adds an omni light when the scene has none, and rendersContinuously redraws every frame instead of only when the scene changes.",
                    code: #"""
                    SceneView(
                        scene: modelScene,
                        options: [.allowsCameraControl, .autoenablesDefaultLighting]
                    )
                    """#
                ),
            ]
        ),
        Topic(
            name: "SignInWithAppleButton",
            kind: .view,
            summary: "The standard Sign in with Apple button and flow.",
            discussion: "SignInWithAppleButton starts the system authorization sheet and reports the credential result to your closures, with label variants (signIn, signUp, continue) and black/white styles. Requires import AuthenticationServices.",
            wwdcYear: 2020,
            framework: "AuthenticationServices",
            code: #"""
            import AuthenticationServices

            SignInWithAppleButton(.signIn) { request in
                request.requestedScopes = [.email]
            } onCompletion: { result in
                handle(result)
            }
            .signInWithAppleButtonStyle(.black)
            """#,
            related: ["Button"],
            children: [
                TopicChild(
                    name: "SignInWithAppleButton(_:onRequest:onCompletion:)",
                    summary: "Label choice, request configuration, and result handling in one call.",
                    discussion: "onRequest is where you ask for scopes and set a nonce for backend verification; onCompletion delivers a Result wrapping the ASAuthorization or the error.",
                    code: #"""
                    SignInWithAppleButton(.signUp) { request in
                        request.requestedScopes = [.fullName, .email]
                    } onCompletion: { result in
                        switch result {
                        case .success(let auth): store(auth)
                        case .failure(let error): report(error)
                        }
                    }
                    """#
                ),
                TopicChild(
                    name: "SignInWithAppleButton.Label",
                    summary: "The three sanctioned titles: signIn, signUp, and continue.",
                    discussion: "Pick the phrase that matches the surrounding flow — the system supplies the localized wording, so the button never needs a custom string.",
                    code: #"""
                    SignInWithAppleButton(.continue) { request in
                        request.requestedScopes = [.email]
                    } onCompletion: { result in
                        handle(result)
                    }
                    """#
                ),
            ]
        ),
        Topic(
            name: "PhotosPicker",
            kind: .view,
            summary: "Presents the system photo library picker.",
            discussion: "PhotosPicker binds selected PhotosPickerItems and runs out-of-process, so the app never sees the library — only what the user picks. Load the actual image data asynchronously from each item. Requires import PhotosUI.",
            wwdcYear: 2022,
            platforms: [.iOS, .macOS, .watchOS],
            framework: "PhotosUI",
            code: #"""
            import PhotosUI

            PhotosPicker(selection: $picked, matching: .images) {
                Label("Choose Photo", systemImage: "photo")
            }
            """#,
            related: ["ShareLink", "Transferable"],
            children: [
                TopicChild(
                    name: "PhotosPicker(selection:matching:label:)",
                    summary: "Single selection into an optional PhotosPickerItem binding.",
                    discussion: "The matching filter narrows what the sheet offers — .images, .videos, .screenshots, or combinations built with .any(of:). Load the picked item's data afterwards with loadTransferable.",
                    code: #"""
                    @State private var picked: PhotosPickerItem?

                    PhotosPicker(selection: $picked, matching: .images) {
                        Label("Choose Photo", systemImage: "photo")
                    }
                    """#
                ),
                TopicChild(
                    name: "PhotosPicker(selection:maxSelectionCount:matching:label:)",
                    summary: "Multi-selection bound to an array, with an optional cap.",
                    discussion: "Pass nil for maxSelectionCount to allow as many items as the library holds; a number caps the sheet at that count.",
                    code: #"""
                    @State private var items: [PhotosPickerItem] = []

                    PhotosPicker(selection: $items, maxSelectionCount: 4, matching: .images) {
                        Label("Add up to 4", systemImage: "photo.stack")
                    }
                    """#
                ),
            ]
        ),
        Topic(
            name: "ProductView",
            kind: .view,
            summary: "Displays an App Store product with a buy button.",
            discussion: "ProductView loads an in-app purchase by identifier and renders its name, price, and purchase button with StoreKit handling the transaction sheet. Styles scale from compact rows to large promotional layouts. Requires import StoreKit.",
            wwdcYear: 2023,
            framework: "StoreKit",
            code: #"""
            import StoreKit

            ProductView(id: "com.example.pro.monthly")
                .productViewStyle(.compact)
            """#,
            related: ["Link"]
        ),
        Topic(
            name: "Chart",
            kind: .view,
            summary: "Declarative data visualization from Swift Charts.",
            discussion: "Chart composes marks — BarMark, LineMark, PointMark, AreaMark — from your data the way SwiftUI composes views, deriving axes, scales, and legends automatically. Requires import Charts.",
            wwdcYear: 2022,
            framework: "Swift Charts",
            code: #"""
            import Charts

            Chart(sales) { day in
                BarMark(
                    x: .value("Day", day.date, unit: .day),
                    y: .value("Revenue", day.total)
                )
            }
            """#,
            related: ["Chart3D", "Canvas"]
        ),
        Topic(
            name: "Chart3D",
            kind: .view,
            summary: "Three-dimensional charts from Swift Charts.",
            discussion: "Added at WWDC '25, Chart3D plots marks in three dimensions — surface plots and 3D point clouds — with orbitable cameras. Best for data whose third axis genuinely carries meaning. Requires import Charts.",
            wwdcYear: 2025,
            platforms: [.iOS, .macOS],
            framework: "Swift Charts",
            code: #"""
            import Charts

            Chart3D(samples) { sample in
                PointMark(
                    x: .value("X", sample.x),
                    y: .value("Y", sample.y),
                    z: .value("Z", sample.z)
                )
            }
            """#,
            related: ["Chart"]
        ),
        Topic(
            name: "WebView",
            kind: .view,
            summary: "Displays web content natively in SwiftUI.",
            discussion: "WebView arrived at WWDC '25 alongside the observable WebPage model: point it at a URL or drive a WebPage for navigation control, JavaScript calls, and loading state — no more wrapping WKWebView by hand. Requires import WebKit.",
            wwdcYear: 2025,
            platforms: [.iOS, .macOS],
            framework: "WebKit",
            code: #"""
            import WebKit

            @State private var page = WebPage()

            WebView(page)
                .task {
                    page.load(URLRequest(url: docsURL))
                }
            """#,
            related: ["Link", "openURL"]
        ),
        Topic(
            name: "NowPlayingView",
            kind: .view,
            summary: "The system Now Playing screen for watchOS apps.",
            discussion: "NowPlayingView drops the standard media transport UI — artwork, scrubber, volume — into a watch app, staying in sync with the active audio session. Requires import WatchKit.",
            wwdcYear: 2020,
            platforms: [.watchOS],
            framework: "WatchKit",
            code: #"""
            import WatchKit

            TabView {
                LibraryView()
                NowPlayingView()
            }
            """#,
            related: ["VideoPlayer"]
        ),
    ]
}
