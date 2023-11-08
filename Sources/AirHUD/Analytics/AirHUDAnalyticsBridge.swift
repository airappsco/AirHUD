//
//  AirHUDAnalyticsBridge.swift
//  AirHUD
//
//  Created by Christian Skorobogatow on 8/11/23.
//  Copyright © 2023 AirApps. All rights reserved.
//

import Foundation

public protocol AirHUDAnalyticsBridge {
    func logEvent(name: String, params: [String: Any]?)
}
