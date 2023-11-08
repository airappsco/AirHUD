//
//  AirHUDViewModel.swift
//  AirHUD
//
//  Created by Ufuk Benlice on 8/15/23.
//  Copyright © 2023 AirApps. All rights reserved.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
protocol AirHUDViewModelObservable: ObservableObject {
    var isPresented: Binding<Bool> { get }
    
    var mode: AirHUDMode { get }
    var icon: IconConfiguration { get }
    var title: TitleConfiguration { get }
    var subtitle: SubtitleConfiguration? { get }
    var button: ButtonConfiguration? { get }
    var dismiss: DismissConfiguration { get }
    var general: GeneralConfiguration { get }
    
    func runAutoDismissIfNeeded()
    func show()
    func hide()
}

@available(iOS 13.0, *)
final class AirHUDViewModel: AirHUDViewModelObservable {
    
    let isPresented: Binding<Bool>
    let configuration: AirHUDConfiguration
    var analytics: AirHUDAnalyticsBridge?
    
    private var timer: Timer?
    
    var mode: AirHUDMode {
        configuration.mode
    }
    
    var icon: IconConfiguration {
        configuration.icon
    }
    
    var title: TitleConfiguration {
        configuration.title
    }
    
    var subtitle: SubtitleConfiguration? {
        configuration.subtitle
    }
    
    var button: ButtonConfiguration? {
        configuration.button
    }
    
    var dismiss: DismissConfiguration {
        configuration.dismiss
    }
    
    var general: GeneralConfiguration {
        configuration.general
    }
    
    init(
        isPresented: Binding<Bool>,
        configuration: AirHUDConfiguration,
        analytics: AirHUDAnalyticsBridge?
    ) {
        self.isPresented = isPresented
        self.configuration = configuration
        self.analytics = analytics
        self.runAutoDismissIfNeeded()
    }
    
    deinit {
        timer?.invalidate()
    }
    
    func runAutoDismissIfNeeded() {
        guard configuration.dismiss.autoDismiss,
              isPresented.wrappedValue else { return }
        
        self.analytics?.logEvent(
            name: AirHUDAnalyticsEvent.didShowAirHUD.rawValue,
            params: [AirHUDAnalyticsParameter.hud.rawValue: title.text]
        )
        
        timer = Timer.scheduledTimer(
            withTimeInterval: self.configuration.dismiss.autoDismissDuration,
            repeats: false) { [weak self] _ in
                self?.hide()
                self?.analytics?.logEvent(
                    name: AirHUDAnalyticsEvent.didHideAirHUD.rawValue,
                    params: [AirHUDAnalyticsParameter.hud.rawValue: self?.title.text ?? ""]
                )
        }
    }
    
    func show() {
        isPresented.wrappedValue = true
    }
    
    func hide() {
        isPresented.wrappedValue = false
    }
}
