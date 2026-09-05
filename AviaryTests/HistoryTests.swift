//
//  HistoryTests.swift
//  AviaryTests
//
//  The back/forward stack semantics of WorkspaceTab.
//

import Testing
@testable import Aviary

struct HistoryTests {
    @Test func launchStateIsNotRecorded() {
        let tab = WorkspaceTab()
        tab.selectedTopicID = "Text"
        #expect(!tab.canGoBack)
    }

    @Test func backAndForwardRoundTrip() {
        let tab = WorkspaceTab()
        tab.selectedTopicID = "Text"
        tab.sidebarSelection = .kind(.view)
        tab.selectedTopicID = "Button"

        #expect(tab.canGoBack)
        tab.goBack()
        #expect(tab.selectedTopicID == "Text")
        #expect(tab.sidebarSelection == .kind(.view))
        #expect(tab.canGoForward)

        tab.goForward()
        #expect(tab.selectedTopicID == "Button")
        #expect(!tab.canGoForward)
    }

    @Test func backRestoresTheSidebarContextOfTheOlderEntry() {
        let tab = WorkspaceTab()
        tab.sidebarSelection = .all
        tab.selectedTopicID = "Text"
        // Jump the way reveal() does: topic first, then sidebar.
        tab.selectedTopicID = "Circle"
        tab.sidebarSelection = .kind(.shape)

        tab.goBack()
        #expect(tab.selectedTopicID == "Text")
        #expect(tab.sidebarSelection == .all)
    }

    @Test func newNavigationClearsTheForwardStack() {
        let tab = WorkspaceTab()
        tab.selectedTopicID = "Text"
        tab.selectedTopicID = "Button"
        tab.goBack()
        #expect(tab.canGoForward)

        tab.selectedTopicID = "Slider"
        #expect(!tab.canGoForward)
        #expect(tab.canGoBack)
    }

    @Test func reselectingTheSameEntryRecordsNothing() {
        let tab = WorkspaceTab()
        tab.selectedTopicID = "Text"
        tab.selectedTopicID = "Text"
        #expect(!tab.canGoBack)
    }
}
