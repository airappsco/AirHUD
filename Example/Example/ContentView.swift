//
//  ContentView.swift
//  Example
//
//  Created by Ufuk Benlice on 8/15/23.
//

import AirHUD
import SwiftUI

struct ContentView: View {
    
    @State var showIconAndTitle: Bool = false
    @State var showTitleAndButton: Bool = false
    @State var showTitleAndSubtitle: Bool = false
    @State var showCustomized: Bool = false

    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 40) {
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
            }
            Spacer()
        }
        .airHud(isPresented: $showIconAndTitle,
                icon: Image(systemName: "doc.on.doc"),
                iconColor: Color(uiColor: .systemBlue),
                title: "Text Copied")
        .airHud(isPresented: $showTitleAndButton,
                icon: Image(systemName: "trash"),
                iconColor: Color(uiColor: .systemRed),
                title: "Conversation Deleted",
                buttonTitle: "Undo",
                buttonAction: nil)
        .airHud(isPresented: $showTitleAndSubtitle,
                icon: Image(systemName: "folder"),
                iconColor: Color(uiColor: .systemBlue),
                title: "Moved",
                subtitle: "File moved to \"Personal\"")
        .airHud(isPresented: $showCustomized,
                configuration: customizedConfiguration)
    }
    
    var customizedConfiguration: AirHUDConfiguration {
        let iconConfiguration = IconConfiguration(image: .init(systemName: "star"),
                                                  color: .white,
                                                  position: .trailing,
                                                  size: .init(width: 60, height: 60))
        let titleConfiguration = TitleConfiguration(text: "Added to Favorites",
                                                    color: .purple,
                                                    font: .headline.italic())
        let subtitleConfiguration = SubtitleConfiguration(text: "You can change your favorites at any time from favorites section",
                                                          color: .blue,
                                                          font: .callout)
        let dismissConfiguration = DismissConfiguration(autoDismiss: false)
        let generalConfiguration = GeneralConfiguration(backgroundColor: .orange,
                                                        horizontalAlingment: .center,
                                                        verticalAlignment: .bottom)
        let mode: AirHUDMode = .iconTitleAndSubtitle(icon: iconConfiguration,
                                                     title: titleConfiguration,
                                                     subtitle: subtitleConfiguration,
                                                     dismiss: dismissConfiguration,
                                                     general: generalConfiguration)
        return AirHUDConfiguration(mode: mode)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
