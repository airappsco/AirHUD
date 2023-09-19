//
//  AirHUDViewModelTests.swift
//  AirHUD
//
//  Created by Ufuk Benlice on 8/15/23.
//  Copyright © 2023 AirApps. All rights reserved.
//

@testable import AirHUD
import SwiftUI
import XCTest

final class AirHUDViewModelTests: XCTestCase {

    func test_Show() {
        let mode: AirHUDMode = .iconAndTitle(icon: .init(image: Image(""), color: .blue),
                                             title: .init(text: "Show Test"))
        let sut = getSut(for: mode)
        XCTAssertFalse(sut.isPresented.wrappedValue)
        sut.show()
        XCTAssertTrue(sut.isPresented.wrappedValue)
    }
    
    func test_Hide() {
        let mode: AirHUDMode = .iconAndTitle(icon: .init(image: Image(""), color: .blue),
                                             title: .init(text: "Hide Test"))
        let sut = getSut(for: mode)
        sut.show()
        XCTAssertTrue(sut.isPresented.wrappedValue)
        sut.hide()
        XCTAssertFalse(sut.isPresented.wrappedValue)
    }
    
    func test_AutoDismiss() {
        let autoDismissExpectation = XCTestExpectation(description: "Auto Dismiss Expectation")
        let mode: AirHUDMode = .iconAndTitle(icon: .init(image: Image(""), color: .blue),
                                             title: .init(text: "Hide Test"),
                                             dismiss: .init(autoDismiss: true, autoDismissDuration: 0.5))
        let sut = getSut(for: mode)
        sut.show()
        XCTAssertTrue(sut.isPresented.wrappedValue)
        sut.runAutoDismissIfNeeded()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
            XCTAssertFalse(sut.isPresented.wrappedValue)
            autoDismissExpectation.fulfill()
        })
        wait(for: [autoDismissExpectation], timeout: 1.0)
    }
    
    func test_IconAndTitleModeProperties() {
        let mode: AirHUDMode = .iconAndTitle(icon: .init(image: Image(""), color: .blue),
                                             title: .init(text: "Title1"))
        let sut = getSut(for: mode)

        XCTAssertEqual(sut.title.text, "Title1")
        XCTAssertNil(sut.subtitle)
        XCTAssertNil(sut.button)
        XCTAssertNotNil(sut.mode)
        XCTAssertNotNil(sut.dismiss)
        XCTAssertNotNil(sut.general)
    }
    
    func test_IconTitleAndButtonModeProperties() {
        let mode: AirHUDMode = .iconTitleAndButton(icon: .init(image: Image(""), color: .blue),
                                                   title: .init(text: "Title2"),
                                                   button: .init(text: "Button2"))
        let sut = getSut(for: mode)
        XCTAssertEqual(sut.title.text, "Title2")
        XCTAssertEqual(sut.button?.text, "Button2")
        XCTAssertNil(sut.subtitle)
        XCTAssertNotNil(sut.button)
        XCTAssertNotNil(sut.mode)
        XCTAssertNotNil(sut.dismiss)
        XCTAssertNotNil(sut.general)
    }
    
    func testIconTitleAndSubtitleModeProperties() {
        let mode: AirHUDMode = .iconTitleAndSubtitle(icon: .init(image: Image(""), color: .blue),
                                                     title: .init(text: "Title3"),
                                                     subtitle: .init(text: "Subtitle3"))
        
        let sut = getSut(for: mode)
        XCTAssertEqual(sut.title.text, "Title3")
        XCTAssertEqual(sut.subtitle?.text, "Subtitle3")
        XCTAssertNotNil(sut.subtitle)
        XCTAssertNil(sut.button)
        XCTAssertNotNil(sut.mode)
        XCTAssertNotNil(sut.dismiss)
        XCTAssertNotNil(sut.general)
    }
}

private extension AirHUDViewModelTests {
    
    func getSut(for mode: AirHUDMode) -> any AirHUDViewModelObservable {
        var bindingValue = false
        let binding = Binding(get: { bindingValue }, set: { bindingValue = $0 })
        return AirHUDViewModel(isPresented: binding, configuration: .init(mode: mode))
    }
}
