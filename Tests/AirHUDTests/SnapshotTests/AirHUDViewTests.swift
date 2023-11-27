////
////  AirHUDViewTests.swift
////  AirHUD
////
////  Created by Ufuk Benlice on 19/09/23.
////  Copyright © 2023 AirApps. All rights reserved.
////
//
//@testable import AirHUD
//import SnapshotTesting
//import SwiftUI
//import XCTest
//
//final class AirHUDViewTests: XCTestCase, AirHUDSnapshotting {
//    
//    var fileName: StaticString = #file
//    var className = String(describing: AirHUDViewTests.self)
//    
//    var recordMode = false
//    
//    func test_ShowIconAndTitle() {
//        let sut = Spacer()
//            .airHud(isPresented: .constant(true),
//                    iconImage: Image(systemName: "doc.on.doc"),
//                    iconColor: Color(uiColor: .systemBlue),
//                    title: "Text Copied")
//        
//        assertView(sut, named: "test_ShowIconAndTitle", traits: [lightMode, darkMode], recordMode: recordMode)
//    }
//    
//    func test_ShowTitleAndButton() {
//        let sut = Spacer()
//            .airHud(isPresented: .constant(true),
//                    iconImage: Image(systemName: "trash"),
//                    iconColor: Color(uiColor: .systemRed),
//                    title: "Conversation Deleted",
//                    buttonTitle: "Undo",
//                    buttonAction: nil)
//        
//        assertView(sut, named: "test_ShowTitleAndButton", traits: [lightMode, darkMode], recordMode: recordMode)
//    }
//    
//    func test_ShowTitleAndSubtitle() {
//        let sut = Spacer()
//            .airHud(isPresented: .constant(true),
//                    iconImage: Image(systemName: "folder"),
//                    iconColor: Color(uiColor: .systemBlue),
//                    title: "Moved",
//                    subtitle: "File moved to \"Personal\"")
//        
//        assertView(sut, named: "test_ShowTitleAndSubtitle", traits: [lightMode, darkMode], recordMode: recordMode)
//    }
//}
