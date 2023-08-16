//
//  View+Extensions.swift
//  AirHUD
//
//  Created by Ufuk Benlice on 8/15/23.
//

import SwiftUI

public extension View {
    
    func airHud(isPresented: Binding<Bool>,
                configuration: AirHUDConfiguration) -> some View {
        modifier(AirHUDViewModifier(isPresented: isPresented, configuration: configuration))
    }
    
    func airHud(isPresented: Binding<Bool>,
                icon: Image,
                iconColor: Color,
                title: String) -> some View {
        let mode: AirHUDMode = .iconAndTitle(icon: .init(image: icon, color: iconColor),
                                             title: .init(text: title))
        let configuration: AirHUDConfiguration = .init(mode: mode)
        return modifier(AirHUDViewModifier(isPresented: isPresented, configuration: configuration))
    }
    
    func airHud(isPresented: Binding<Bool>,
                icon: Image,
                iconColor: Color,
                title: String,
                buttonTitle: String,
                buttonAction: (() -> Void)? = nil) -> some View {
        let mode: AirHUDMode = .iconTitleAndButton(icon: .init(image: icon, color: iconColor),
                                                   title: .init(text: title),
                                                   button: .init(text: buttonTitle, didTap: buttonAction),
                                                   general: .init(horizontalAlingment: .leading))
        let configuration: AirHUDConfiguration = .init(mode: mode)
        return modifier(AirHUDViewModifier(isPresented: isPresented, configuration: configuration))
    }
    
    func airHud(isPresented: Binding<Bool>,
                icon: Image,
                iconColor: Color,
                title: String,
                subtitle: String) -> some View {
        let mode: AirHUDMode = .iconTitleAndSubtitle(icon: .init(image: icon, color: iconColor),
                                                     title: .init(text: title),
                                                     subtitle: .init(text: subtitle),
                                                     general: .init(horizontalAlingment: .leading))
        let configuration: AirHUDConfiguration = .init(mode: mode)
        return modifier(AirHUDViewModifier(isPresented: isPresented, configuration: configuration))
    }
}
