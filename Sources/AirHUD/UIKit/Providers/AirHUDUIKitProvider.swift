//
//  AirHUDUIKitProvider.swift
//  AirHUD
//
//  Created by Christian Skorobogatow on 24/10/23.
//  Copyright © 2023 AirApps. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

@available(iOS 13.0, *)
public class AirHUDUIKitProvider {
    
    private var hudStateManagerManager = HUDStateStore()
    public var analytics: AirHUDAnalyticsBridge?
    
    public init(
        analytics: AirHUDAnalyticsBridge? = nil
    ) {
        self.analytics = analytics
    }
    
    public func setupAirHUD(
        hudID: String,
        hudType: HUDType,
        in viewController: UIViewController
    ) {
        let state = hudStateManagerManager.createStateManagerForID(hudID)
        state.viewController = viewController
        state.analytics = analytics
        
        let airHUDHostingController = UIHostingController(
            rootView: createAirHUDContainer(
                state: state,
                hudType: hudType
            )
        )
        airHUDHostingController.view.backgroundColor = .clear
        
        guard let airHUDView = airHUDHostingController.view else { return }
        state.hudView = airHUDView
        
        configureHUDView(airHUDView, in: viewController)
        animateHUDView(hudView: airHUDView, state: state, viewController: viewController)
    }
    
    public func toggleAirHUD(hudID: String) {
        hudStateManagerManager.dismissAllOtherHUDs(hudID: hudID)
        guard let stateManager = hudStateManagerManager.stateManagerForID(hudID) else {
            debugPrint("No AirHUD associated with the given ID")
            return
        }
        
        stateManager.isPresented.toggle()
    }
}

@available(iOS 13.0, *)
extension AirHUDUIKitProvider {
    
     private func createAirHUDContainer(
        state: HUDStateManagerUIKit,
        hudType: HUDType
    ) -> AirHUDSwiftUIContainer {
        AirHUDSwiftUIContainer(
            state: state,
            hudType: hudType
        )
    }
    
    private func configureHUDView(_ airHUDView: UIView, in viewController: UIViewController) {
        airHUDView.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(airHUDView)
    }
    
    private func animateHUDView(hudView: UIView?, state: HUDStateManagerUIKit, viewController: UIViewController) {
        state.cancellable?.cancel()
        state.cancellable = state.$isPresented.sink { [weak self] value in
            let YOffset: CGFloat = -20
            let transform: CGAffineTransform = value ? .identity : CGAffineTransform(translationX: 0, y: YOffset)
                
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                    
                if value {
                    guard let hudView = hudView else { return }
                    viewController.view.addSubview(hudView)
                    hudView.translatesAutoresizingMaskIntoConstraints = false
                                     
                    NSLayoutConstraint.activate([
                        hudView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
                        hudView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
                        hudView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
                        hudView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor)
                    ])
                } else {
                    self.animateFinalTransform(hudView, animateImmediately: true) {
                        hudView?.removeFromSuperview()
                    }
                }
                self.animateTransform(transform, hudView: hudView)
            }
        }
    }

    private func animateTransform(_ transform: CGAffineTransform, hudView: UIView?) {
        UIView.animate(
            withDuration: 1.5,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.6,
            options: [.curveEaseInOut],
            animations: {
                hudView?.transform = transform
            },
            completion: { [weak self] _ in
                self?.animateFinalTransform(hudView)
            }
        )
    }

    private func animateFinalTransform(_ hudView: UIView?, animateImmediately: Bool = false, completion: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: animateImmediately ? 0 : 1.0,
            delay: animateImmediately ? 0 : 1,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            options: [.curveEaseInOut],
            animations: {
                hudView?.transform = CGAffineTransform(translationX: 0, y: -200)
            },
            completion: { _ in
               completion?()
            }
        )
    }
}
