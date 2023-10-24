//
//  ContentView.swift
//  Example
//
//  Created by Ufuk Benlice on 8/15/23.
//  Copyright © 2023 AirApps. All rights reserved.
//

import AirHUD
import SwiftUI

struct ContentView: View {

    @State var showIconAndTitle = false
    @State var showTitleAndButton = false
    @State var showTitleAndSubtitle = false
    @State var showCustomized = false
    @State var showUIViewController = false

    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: Constant.verticalItemSpacing) {
                Button("Icon and Title") {
                    showIconAndTitle.toggle()
                    showTitleAndButton = false
                    showTitleAndSubtitle = false
                    showCustomized = false
                }
                Button("Icon, Title and Button") {
                    self.showTitleAndButton.toggle()
                    showIconAndTitle = false
                    showTitleAndSubtitle = false
                    showCustomized = false
                }
                Button("Icon, Title and Subtitle") {
                    self.showTitleAndSubtitle.toggle()
                    showIconAndTitle = false
                    showTitleAndButton = false
                    showCustomized = false
                }
                Button("Customized") {
                    self.showCustomized.toggle()
                    showIconAndTitle = false
                    showTitleAndButton = false
                    showTitleAndSubtitle = false
                }
                Button("Test UIKit Wrapper Version") {
                    showUIViewController.toggle()
                }
            }
            Spacer()
        }
        .airHud(isPresented: $showIconAndTitle,
                iconImage: Image(systemName: "doc.on.doc"),
                iconColor: Color(uiColor: .systemBlue),
                title: "Text Copied")
        .airHud(isPresented: $showTitleAndButton,
                iconImage: Image(systemName: "trash"),
                iconColor: Color(uiColor: .systemRed),
                title: "Conversation Deleted",
                buttonTitle: "Undo",
                buttonAction: nil)
        .airHud(isPresented: $showTitleAndSubtitle,
                iconImage: Image(systemName: "folder"),
                iconColor: Color(uiColor: .systemBlue),
                title: "Moved",
                subtitle: "File moved to \"Personal\"")
        .airHud(isPresented: $showCustomized,
                configuration: customizedConfiguration)
        .sheet(isPresented: $showUIViewController) {
            ViewControllerRepresentable()
        }
    }

    var customizedConfiguration: AirHUDConfiguration {
        let iconConfiguration = IconConfiguration(image: .init(systemName: "star"),
                                                  color: .white,
                                                  position: .trailing,
                                                  size: Constant.customIconSize)
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
}

private enum Constant {
    static let verticalItemSpacing = 40.0
    static let customIconSize = CGSize(width: 60, height: 60)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
