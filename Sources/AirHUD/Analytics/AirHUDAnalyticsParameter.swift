//
//  AirHUDAnalyticsParameter.swift
//  AirHUD
//
//  Created by Christian Skorobogatow on 7/11/23.
//  Copyright © 2023 AirApps. All rights reserved.
//

import Foundation

public enum AirHUDAnalyticsParameter: String {
    case hud = "HUD"
}

extension String {
    func removingNonAlphanumericCharacters() -> String {
        return self.replacingOccurrences(of: "[^a-zA-Z0-9]", with: "", options: .regularExpression)
    }
}
