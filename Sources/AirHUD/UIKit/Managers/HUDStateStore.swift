//
//  HUDStateStore.swift
//  AirHUD
//
//  Created by Christian Skorobogatow on 27/10/23.
//  Copyright © 2023 AirApps. All rights reserved.
//


import Combine
import UIKit

@available(iOS 13.0, *)
class HUDStateStore {
    var stateManagers: [String: HUDStateManagerUIKit] = [:]
    var analytics: AirHUDAnalyticsBridge?
    
    // Access stateManager by ID
    func stateManagerForID(
        _ id: String
    ) -> HUDStateManagerUIKit? {
         stateManagers[id]
    }

    // Create a stateManager for ID
    func createStateManagerForID(
        _ id: String,
        isPresented: Bool = false
    ) -> HUDStateManagerUIKit {
        let stateManager = HUDStateManagerUIKit(
            isPresented: isPresented,
            analytics: analytics
        )
        stateManagers[id] = stateManager
        return stateManager
    }
}
