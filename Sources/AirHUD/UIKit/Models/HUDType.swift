//
//  HUDType.swift
//  AirHUD
//
//  Created by Christian Skorobogatow on 27/10/23.
//  Copyright © 2023 AirApps. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public enum HUDType {
    case configuration(AirHUDConfiguration)
    case iconAndTitle(Image, Color, String)
    case iconTitleAndButton(Image, Color, String, String, (() -> Void)?)
    case iconTitleAndSubtitle(Image, Color, String, String)
}
