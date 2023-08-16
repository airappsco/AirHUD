//
//  AirHUDViewModel.swift
//  AirHUD
//
//  Created by Ufuk Benlice on 8/15/23.
//

import Foundation
import SwiftUI

protocol AirHUDViewModelObservable: ObservableObject {
    var isPresented: Binding<Bool> { get }
    var configuration: AirHUDConfiguration { get }
    func runAutoDismissIfNeeded()
    func show()
    func hide()
}

final class AirHUDViewModel: AirHUDViewModelObservable {
    
    private(set) var isPresented: Binding<Bool>
    private(set) var configuration: AirHUDConfiguration
    private var timer: Timer?
    
    init(isPresented: Binding<Bool>,
        configuration: AirHUDConfiguration) {
        self.isPresented = isPresented
        self.configuration = configuration
        self.runAutoDismissIfNeeded()
    }
    
    deinit {
        timer?.invalidate()
    }
    
    func runAutoDismissIfNeeded() {
        guard configuration.dismiss.autoDismiss,
              isPresented.wrappedValue else { return }
        timer = Timer.scheduledTimer(
            withTimeInterval: self.configuration.dismiss.autoDismissDuration,
            repeats: false) { [weak self] _ in
                self?.hide()
        }
    }
    
    func show() {
        isPresented.wrappedValue = true
    }
    
    func hide() {
        isPresented.wrappedValue = false
    }
}
