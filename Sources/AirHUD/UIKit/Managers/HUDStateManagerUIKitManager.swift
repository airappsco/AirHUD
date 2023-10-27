//
//  File 2.swift
//  
//
//  Created by Christian on 27/10/23.
//

import Combine
import UIKit

@available(iOS 13.0, *)
class HUDStateManagerUIKitManager {
    var stateManagers: [String: HUDStateManagerUIKit] = [:]
    
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
            isPresented: isPresented
        )
        stateManagers[id] = stateManager
        return stateManager
    }
}
