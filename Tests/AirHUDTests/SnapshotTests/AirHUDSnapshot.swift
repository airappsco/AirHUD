//
//  Snapshot.swift
//  AirHUD
//
//  Created by Ufuk Benlice on 19/09/23.
//  Copyright © 2023 AirApps. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

protocol AirHUDSnapshotting: XCTestCase {
    var fileName: StaticString { get }
    
    var className: String { get }
}

extension AirHUDSnapshotting {
    
    var allDevices: [String: ViewImageConfig] {
        [
            "iPhoneSe": .iPhoneSe,
            "iPhoneXsMax": .iPhoneXsMax,
            "iPhone13Pro": .iPhone13Pro,
            "iPadMini": .iPadMini,
            "iPadMini(.landscape)": .iPadMini(.landscape),
            "iPadPro10_5": .iPadPro10_5,
            "iPadPro12_9": .iPadPro12_9,
            "iPadPro12_9(.landscape(splitView: .oneThird))": .iPadPro12_9(.landscape(splitView: .oneThird)),
            "iPadPro12_9(.portrait(splitView: .twoThirds))": .iPadPro12_9(.portrait(splitView: .twoThirds)),
            "iPadPro12_9(.portrait(splitView: .oneThird))": .iPadPro12_9(.portrait(splitView: .oneThird)),
            "iPadPro12_9(.landscape)": .iPadPro12_9(.landscape)
        ]
    }
    
    var baseDevices: [String: ViewImageConfig] {
        ["iPhone13": .iPhone13]
    }
    
    var dynamicSizes: [ContentSizeCategory] {
        [
            .extraSmall,
            .accessibilityMedium,
            .accessibilityExtraExtraExtraLarge
        ]
    }
    
    var darkMode: (String, UITraitCollection) {
        ("darkMode", UITraitCollection(userInterfaceStyle: .dark))
    }
    
    var lightMode: (String, UITraitCollection) {
        ("lightMode", UITraitCollection(userInterfaceStyle: .light))
    }
    
    var rtl: (String, UITraitCollection) {
        ("rtl", UITraitCollection(layoutDirection: .rightToLeft))
    }
    
    func assertViewInAllCases<SnapshotView: View>(_ view: SnapshotView, named: String, recordMode: Bool = false) {
        let traitTuples: [(String, UITraitCollection)] = [darkMode, lightMode, rtl]
        allDevices.forEach { device in
            traitTuples.forEach { trait in
                assertSnapshot(
                    matching: view.toVC(),
                    as: .image(on: device.value, traits: trait.1),
                    named: "\(named)-\(device.key)-Trait:\(trait.0)",
                    record: recordMode,
                    file: fileName,
                    testName: className)
            }
            dynamicSizes.forEach { contentSize in
                assertSnapshot(
                    matching: view.environment(\.sizeCategory, contentSize).toVC(),
                    as: .image(on: device.value),
                    named: "\(named)-\(device.key)-DynamicSize:\(contentSize)",
                    record: recordMode,
                    file: fileName,
                    testName: className)
            }
        }
    }
    
    func assertView<SnapshotView: View>(
        _ view: SnapshotView,
        named: String,
        traits: [(String, UITraitCollection)] = [],
        recordMode: Bool = false
    ) {
        let selectedTraits = traits.isEmpty ? [lightMode] : traits
        for trait in selectedTraits {
            baseDevices.forEach { device in
                assertSnapshot(
                    matching: view.toVC(),
                    as: .image(on: device.1, traits: trait.1),
                    named: "\(named)-\(device.key)-Trait:\(trait.0)",
                    record: recordMode,
                    file: fileName,
                    testName: className
                )
            }
        }
    }
}

extension SwiftUI.View {
    func toVC() -> UIViewController {
        let viewController = UIHostingController(rootView: self)
        viewController.view.frame = UIScreen.main.bounds
        return viewController
    }
}
