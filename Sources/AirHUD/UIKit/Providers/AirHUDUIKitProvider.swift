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
    
    private var hudStateManagerManager = HUDStateManagerUIKitManager()
    
    public init() { }
    
    public func setupAirHUD(
        hudID: String,
        hudType: HUDType,
        in viewController: UIViewController
    ) {
        let state = hudStateManagerManager.createStateManagerForID(hudID)
        
        let airHUDHostingController = UIHostingController(
            rootView: createAirHUDContainer(
                state: state,
                hudType: hudType
            )
        )
        
        guard let airHUDView = airHUDHostingController.view else { return }
        
        state.hudView = airHUDView
        
        configureHUDView(airHUDView, in: viewController)
        animateHUDView(hudView: airHUDView, state: state)
        constrainHUDView(hudView: airHUDView, viewController: viewController)
    }
    
    public func toggleAirHUD(hudID: String) {
            // Access the state manager for the given ID
            guard let stateManager = hudStateManagerManager.stateManagerForID(hudID) else {
                print("No AirHUD associated with the given ID")
                return
            }

            stateManager.isPresented.toggle()
        }
    
     private func createAirHUDContainer(
        state: HUDStateManagerUIKit,
        hudType: HUDType
    ) -> AirHUDContainer {
        AirHUDContainer(
            state: state,
            hudType: hudType
        )
    }
    
    private func configureHUDView(_ airHUDView: UIView, in viewController: UIViewController) {
        airHUDView.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(airHUDView)
    }
    
    private func animateHUDView(hudView: UIView?, state: HUDStateManagerUIKit) {
        state.cancellable?.cancel()
        state.cancellable = state.$isPresented.sink { [weak self] value in
            let YOffset: CGFloat = -20
            let transform: CGAffineTransform = value ? .identity : CGAffineTransform(translationX: 0, y: -YOffset)
            
            DispatchQueue.main.async { [weak self] in
                self?.animateTransform(transform, hudView: hudView)
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
    
    private func animateFinalTransform(_ hudView: UIView?) {
        UIView.animate(
            withDuration: 1.0,
            delay: 1,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            options: [.curveEaseInOut],
            animations: {
                hudView?.transform = CGAffineTransform(translationX: 0, y: -200)
            },
            completion: nil
        )
    }
    
    private func constrainHUDView(hudView: UIView?, viewController: UIViewController) {
        hudView?.topAnchor.constraint(equalTo: viewController.view.topAnchor).isActive = true
        hudView?.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor).isActive = true
        hudView?.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor).isActive = true
        hudView?.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor).isActive = true
    }
}
