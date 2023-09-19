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
    
    func test_ShowIconAndTitle() {
        let sut = Spacer()
            .airHud(isPresented: .constant(true),
                    iconImage: Image(systemName: "doc.on.doc"),
                    iconColor: Color(uiColor: .systemBlue),
                    title: "Text Copied")
        
        assertView(sut, named: "test_ShowIconAndTitle", trait: lightMode, recordMode: recordMode)
        assertView(sut, named: "test_ShowIconAndTitle", trait: darkMode, recordMode: recordMode)
    }
    
    func test_ShowTitleAndButton() {
        let sut = Spacer()
            .airHud(isPresented: .constant(true),
                    iconImage: Image(systemName: "trash"),
                    iconColor: Color(uiColor: .systemRed),
                    title: "Conversation Deleted",
                    buttonTitle: "Undo",
                    buttonAction: nil)
        
        assertView(sut, named: "test_ShowTitleAndButton", trait: lightMode, recordMode: recordMode)
        assertView(sut, named: "test_ShowTitleAndButton", trait: darkMode, recordMode: recordMode)
    }
    
    func test_ShowTitleAndSubtitle() {
        let sut = Spacer()
            .airHud(isPresented: .constant(true),
                    iconImage: Image(systemName: "folder"),
                    iconColor: Color(uiColor: .systemBlue),
                    title: "Moved",
                    subtitle: "File moved to \"Personal\"")
        
        assertView(sut, named: "test_ShowTitleAndSubtitle", trait: lightMode, recordMode: recordMode)
        assertView(sut, named: "test_ShowTitleAndSubtitle", trait: darkMode, recordMode: recordMode)
    }
    
    func test_Customized() {
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
                
        assertView(sut, named: "test_Customized", trait: lightMode, recordMode: recordMode)
        assertView(sut, named: "test_Customized", trait: darkMode, recordMode: recordMode)
    }
}
