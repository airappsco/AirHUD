//
//  AirHUDWrapper.swift
//  AirHUD
//
//  Created by Christian Skorobogatow on 24/10/23.
//  Copyright © 2023 AirApps. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

@available(iOS 13.0, *)
public class AirHUDIKitState: ObservableObject {
    
    @Published public var isPresented: Bool
    
    public init(isPresented: Bool = false) {
        self.isPresented = isPresented
    }
    
    public init() {
        self.isPresented = false
    }
}

@available(iOS 13.0, *)
public struct AirHUDContainer: View {
    public enum HUDType {
        case configuration(AirHUDConfiguration)
        case iconAndTitle(Image, Color, String)
        case iconTitleAndButton(Image, Color, String, String, (() -> Void)?)
        case iconTitleAndSubtitle(Image, Color, String, String)
    }
    
    @ObservedObject var state: AirHUDIKitState
    public var hudType: HUDType
    
    public init(state: AirHUDIKitState, hudType: HUDType) {
        self.state = state
        self.hudType = hudType
    }
    
    public func toHudView() -> some View {
        ZStack {
            switch self.hudType {
            case .configuration(
                let configuration
            ):
                Color.clear
                    .airHud(
                        isPresented: $state.isPresented,
                        configuration: configuration
                    )
                
            case .iconAndTitle(
                let iconImage,
                let iconColor,
                let title
            ):
                Color.clear
                    .airHud(
                        isPresented: $state.isPresented,
                        iconImage: iconImage,
                        iconColor: iconColor,
                        title: title
                    )
                    .animation(.spring())
                
            case .iconTitleAndButton(
                let iconImage,
                let iconColor,
                let title,
                let buttonTitle,
                let buttonAction
            ):
                Color.clear
                    .airHud(
                        isPresented: $state.isPresented,
                        iconImage: iconImage,
                        iconColor: iconColor,
                        title: title,
                        buttonTitle: buttonTitle,
                        buttonAction: buttonAction
                    )
                
            case .iconTitleAndSubtitle(
                let iconImage,
                let iconColor,
                let title,
                let subtitle
            ):
                Color.clear
                    .airHud(
                        isPresented: $state.isPresented,
                        iconImage: iconImage,
                        iconColor: iconColor,
                        title: title,
                        subtitle: subtitle
                    )
            }
        }
    }
    
    public var body: some View {
        if state.isPresented {
            toHudView()
        } else {
            EmptyView()
        }
    }
}
