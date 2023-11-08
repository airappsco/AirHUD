//
//  AirHUDSwiftUIContainer.swift
//  AirHUD
//
//  Created by Christian Skorobogatow on 24/10/23.
//  Copyright © 2023 AirApps. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

@available(iOS 13.0, *)
struct AirHUDSwiftUIContainer: View {
    
    @ObservedObject var state: HUDStateManagerUIKit
    var hudType: HUDType
    
    init(state: HUDStateManagerUIKit, hudType: HUDType) {
        self.state = state
        self.hudType = hudType
    }
    
    var body: some View {
        if state.isPresented {
            toHudView()
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    func toHudView() -> some View {
        switch self.hudType {
        case .configuration(let configuration):
            Color.clear
                .airHud(
                    isPresented: $state.isPresented,
                    configuration: configuration,
                    showAnimationSpeed: UIKitAnimationTiming.showAnimationSpeed,
                    hideAnimationSpeed: UIKitAnimationTiming.hideAnimationSpeed,
                    analytics: state.analytics
                )
            
        case .iconAndTitle(let iconImage, let iconColor, let title):
            Color.clear
                .airHud(
                    isPresented: $state.isPresented,
                    iconImage: iconImage,
                    iconColor: iconColor,
                    title: title,
                    showAnimationSpeed: UIKitAnimationTiming.showAnimationSpeed,
                    hideAnimationSpeed: UIKitAnimationTiming.hideAnimationSpeed,
                    analytics: state.analytics
                )
            
        case .iconTitleAndButton(let iconImage, let iconColor, let title, let buttonTitle, let buttonAction):
            
            Color.clear
                .airHud(
                    isPresented: $state.isPresented,
                    iconImage: iconImage,
                    iconColor: iconColor,
                    title: title,
                    buttonTitle: buttonTitle,
                    showAnimationSpeed: UIKitAnimationTiming.showAnimationSpeed,
                    hideAnimationSpeed: UIKitAnimationTiming.hideAnimationSpeed,
                    analytics: state.analytics,
                    buttonAction: buttonAction
                )
            
        case .iconTitleAndSubtitle( let iconImage, let iconColor, let title, let subtitle):
            Color.clear
                .airHud(
                    isPresented: $state.isPresented,
                    iconImage: iconImage,
                    iconColor: iconColor,
                    title: title,
                    subtitle: subtitle,
                    showAnimationSpeed: UIKitAnimationTiming.showAnimationSpeed,
                    hideAnimationSpeed: UIKitAnimationTiming.hideAnimationSpeed,
                    analytics: state.analytics
                )
        }
    }
}

@available(iOS 13.0, *)
private extension AirHUDSwiftUIContainer {
     enum UIKitAnimationTiming {
        static let showAnimationSpeed = 3.0
        static let hideAnimationSpeed = 1.4
    }
}
