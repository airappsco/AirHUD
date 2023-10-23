//
//  AirHUDViewModifier.swift
//  AirHUD
//
//  Created by Ufuk Benlice on 8/15/23.
//  Copyright © 2023 AirApps. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct AirHUDViewModifier: ViewModifier {
    
    @Binding var isPresented: Bool
    let configuration: AirHUDConfiguration
    let viewModel: AirHUDViewModel
    
    init(isPresented: Binding<Bool>, configuration: AirHUDConfiguration) {
        self._isPresented = isPresented
        self.configuration = configuration
        self.viewModel = .init(isPresented: isPresented, configuration: configuration)
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            GeometryReader { geoProxy in
                AirHudView(viewModel: viewModel)
                    .frame(
                        width: geoProxy.frame(in: .global).width,
                        height: geoProxy.frame(in: .global).height,
                        alignment: .top
                    )
            }
        }
        .animation(
            .spring().speed(isPresented ? Constant.showAnimationSpeed : Constant.hideAnimationSpeed),
            value: isPresented)
    }
}

private enum Constant {
    static let showAnimationSpeed = 1.0
    static let hideAnimationSpeed = 0.4
}
