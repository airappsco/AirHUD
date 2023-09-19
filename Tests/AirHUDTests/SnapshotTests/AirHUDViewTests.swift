//
//  AirHUDViewTests.swift
//  AirHUD
//
//  Created by Ufuk Benlice on 19/09/23.
//  Copyright © 2023 AirApps. All rights reserved.
//

@testable import AirHUD
import SnapshotTesting
import SwiftUI
import XCTest

final class AirHUDViewTests: XCTestCase, AirHUDSnapshotting {
    
    var fileName: StaticString = #file
    var className = String(describing: AirHUDViewTests.self)
    
    var recordMode = false
    
    func testAirHud() {
        var customizedConfiguration: AirHUDConfiguration {
            let iconConfiguration = IconConfiguration(image: .init(systemName: "star"),
                                                      color: .white,
                                                      position: .trailing,
                                                      size: CGSize(width: 60, height: 60))
            let titleConfiguration = TitleConfiguration(text: "Added to Favorites",
                                                        color: .purple,
                                                        font: .headline.italic())
            let subtitleConfiguration = SubtitleConfiguration(text: "You can change your favorites at any time from favorites section",
                                                              color: .blue,
                                                              font: .callout)
            let dismissConfiguration = DismissConfiguration(autoDismiss: false)
            let generalConfiguration = GeneralConfiguration(backgroundColor: .orange,
                                                            horizontalAlingment: .center,
                                                            verticalAlignment: .center)
            let mode: AirHUDMode = .iconTitleAndSubtitle(icon: iconConfiguration,
                                                         title: titleConfiguration,
                                                         subtitle: subtitleConfiguration,
                                                         dismiss: dismissConfiguration,
                                                         general: generalConfiguration)
            return AirHUDConfiguration(mode: mode)
        }
        
        let sut = Spacer()
            .airHud(isPresented: .constant(true),
                    configuration: customizedConfiguration)
        
        assertViewInAllCases(sut, named: "test_Customized", recordMode: recordMode)
    }
}
