//
//  File.swift
//  
//
//  Created by Christian on 27/10/23.
//

import SwiftUI

@available(iOS 13.0, *)
public enum HUDType {
    case configuration(AirHUDConfiguration)
    case iconAndTitle(Image, Color, String)
    case iconTitleAndButton(Image, Color, String, String, (() -> Void)?)
    case iconTitleAndSubtitle(Image, Color, String, String)
}
