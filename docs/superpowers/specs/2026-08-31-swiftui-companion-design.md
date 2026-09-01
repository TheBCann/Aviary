# SwiftUI Companion — Design

Date: 2026-08-31
Status: implemented in the same session (autonomous run; user asked to clone the
"Companion for SwiftUI" feature set, decisions below were made without a live
approval loop and are all reversible).

## Goal

An original macOS app that reproduces the *feature set* of the commercial
"Companion for SwiftUI" documentation browser: a searchable, filterable catalog
of SwiftUI APIs with interactive, copy-ready examples and a menu bar quick-search.
No content, assets, or branding from the real app are used — every description
and example is written for this project.

## Architecture

Pure SwiftUI, single macOS target (deployment target macOS 26.x), no external
dependencies. Layers:

- **Models** (`Models/`) — `Topic` (one catalog entry), `TopicKind`,
  `ApplePlatform`, `FilterCriteria`, `WorkspaceTab`, `AppModel` (`@Observable`).
  Platform availability is derived from the entry's WWDC introduction year via a
  version table, so catalog entries stay one-liner cheap.
- **Catalog** (`Catalog/`) — static seed data, one file per kind
  (`Catalog+Views.swift`, …). ~95 entries covering 2019 through WWDC '24.
  Adding an entry = appending a `Topic` literal.
- **Demos** (`Demos/`) — `DemoRegistry` maps a topic's `demoID` to an
  interactive demo view. Each demo owns `@State` controls and emits a live
  `code` string, rendered through the shared `DemoSection` container, so the
  displayed code always matches the controls. Flagship: `QuadCurveDemo` with
  draggable start/end/control points.
- **Views** (`Views/`) — `ContentView` hosts a custom tab strip (one
  `WorkspaceTab` = one filter context) above a `NavigationSplitView`:
  sidebar (All + one row per kind), searchable topic list, and
  `TopicDetailView` (availability badges, discussion, demo or static
  syntax-highlighted `CodeBlockView` with a copy button, related-topic links).
  `FilterPopover` edits the active tab's platform/year criteria.
- **Menu bar** — `MenuBarExtra` scene (`MenuBarSearchView`): type-ahead search;
  choosing a result opens/activates the main window and reveals the topic.

## Data flow

`AppModel` is created in the `App` struct and injected via `.environment`.
Tabs are `@Observable` classes; views bind with `@Bindable`. Filtering is pure:
`FilterCriteria.matches(_:)` + sidebar kind + search text → displayed list.
The menu bar view mutates the active tab through `AppModel.reveal(_:)`.

## Testing

The scaffold has no test target; filtering/availability logic is kept pure so a
unit target can be added later. Verification for this pass = clean `xcodebuild`
build plus a manual launch.

## Out of scope (YAGNI)

Full 3300-entry coverage, visionOS column, persistence of tabs across launches,
in-app code execution beyond the built-in demos, localization.
