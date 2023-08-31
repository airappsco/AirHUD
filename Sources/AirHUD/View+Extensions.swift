//
//  View+Extensions.swift
//  AirHUD
//
//  Created by Ufuk Benlice on 8/15/23.
//  Copyright ©2023 AirApps. All rights reserved.
//

import SwiftUI

public extension View {
    
    /// Populates AirHUD with given configuration. It can be used if a customize display is preferred.
    /// - Parameters:
    ///   - isPresented: Binding value that shows view is visible or not
    ///   - configuration: Model that contains all customization of AirHUD
    /// - Returns: View instance that contains AirHUD as top item according to Z-axis
    func airHud(isPresented: Binding<Bool>,
                configuration: AirHUDConfiguration) -> some View {
        modifier(AirHUDViewModifier(isPresented: isPresented, configuration: configuration))
    }
    
    /// Populates AirHUD with icon-title appearance and it uses default visual configurations. It can be preferred for quick and easy use.
    /// - Parameters:
    ///   - isPresented: Binding value that shows view is visible or not
    ///   - iconImage: Image which will show on AirHUD.
    ///   - iconColor: Foreground color for the given image.
    ///   - title: String which will show as title on AirHUD.
    /// - Returns: View instance that contains AirHUD as top item according to Z-axis
    func airHud(isPresented: Binding<Bool>,
                iconImage: Image,
                iconColor: Color,
                title: String) -> some View {
        let mode: AirHUDMode = .iconAndTitle(icon: .init(image: iconImage, color: iconColor),
                                             title: .init(text: title))
        let configuration: AirHUDConfiguration = .init(mode: mode)
        return modifier(AirHUDViewModifier(isPresented: isPresented, configuration: configuration))
    }
    
    /// Populates AirHUD with icon-title-button appearance and it uses default visual configurations. It can be preferred for quick and easy use.
    /// - Parameters:
    ///   - isPresented: Binding value that shows view is visible or not.
    ///   - iconImage: Image which will show on AirHUD.
    ///   - iconColor: Foreground color for the given image.
    ///   - title: String which will show as title on AirHUD.
    ///   - buttonTitle: String which will show as button's title on AirHUD.
    ///   - buttonAction: Tap action of the button.
    /// - Returns: View instance that contains AirHUD as top item according to Z-axis.
    func airHud(isPresented: Binding<Bool>,
                iconImage: Image,
                iconColor: Color,
                title: String,
                buttonTitle: String,
                buttonAction: (() -> Void)? = nil) -> some View {
        let mode: AirHUDMode = .iconTitleAndButton(icon: .init(image: iconImage, color: iconColor),
                                                   title: .init(text: title),
                                                   button: .init(text: buttonTitle, didTap: buttonAction),
                                                   general: .init(horizontalAlingment: .leading))
        let configuration: AirHUDConfiguration = .init(mode: mode)
        return modifier(AirHUDViewModifier(isPresented: isPresented, configuration: configuration))
    }
    
    /// Populates AirHUD with icon-title-subtitle appearance and it uses default visual configurations. It can be preferred for quick and easy use.
    /// - Parameters:
    ///   - isPresented: Binding value that shows view is visible or not.
    ///   - iconImage: Image which will show on AirHUD.
    ///   - iconColor: Foreground color for the given image.
    ///   - title: String which will show as title on AirHUD.
    ///   - subtitle: String which will show as subtitle on AirHUD
    /// - Returns: View instance that contains AirHUD as top item according to Z-axis.
    func airHud(isPresented: Binding<Bool>,
                iconImage: Image,
                iconColor: Color,
                title: String,
                subtitle: String) -> some View {
        let mode: AirHUDMode = .iconTitleAndSubtitle(icon: .init(image: iconImage, color: iconColor),
                                                     title: .init(text: title),
                                                     subtitle: .init(text: subtitle),
                                                     general: .init(horizontalAlingment: .leading))
        let configuration: AirHUDConfiguration = .init(mode: mode)
        return modifier(AirHUDViewModifier(isPresented: isPresented, configuration: configuration))
    }
}
