//
//  AirHUDConfiguration.swift
//  AirHUD
//
//  Created by Ufuk Benlice on 8/15/23.
//

import SwiftUI

public enum AirHUDMode {
    case iconAndTitle(icon: IconConfiguration,
                      title: TitleConfiguration,
                      dismiss: DismissConfiguration = .init(),
                      general: GeneralConfiguration = .init())
    case iconTitleAndButton(icon: IconConfiguration,
                            title: TitleConfiguration,
                            button: ButtonConfiguration,
                            dismiss: DismissConfiguration = .init(),
                            general: GeneralConfiguration = .init())
    case iconTitleAndSubtitle(icon: IconConfiguration,
                              title: TitleConfiguration,
                              subtitle: SubtitleConfiguration,
                              dismiss: DismissConfiguration = .init(),
                              general: GeneralConfiguration = .init())
}

public struct AirHUDConfiguration {
    
    public var mode: AirHUDMode
    public var icon: IconConfiguration
    public var title: TitleConfiguration
    public var subtitle: SubtitleConfiguration?
    public var button: ButtonConfiguration?
    public var dismiss: DismissConfiguration
    public var general: GeneralConfiguration
    
    public init(mode: AirHUDMode) {
        switch mode {
        case .iconAndTitle(let icon, let title, let dismiss, let general):
            self.icon = icon
            self.title = title
            self.dismiss = dismiss
            self.general = general
        case .iconTitleAndButton(let icon, let title, let button, let dismiss, let general):
            self.icon = icon
            self.title = title
            self.button = button
            self.dismiss = dismiss
            self.general = general
        case .iconTitleAndSubtitle(let icon, let title, let subtitle, let dismiss, let general):
            self.icon = icon
            self.title = title
            self.subtitle = subtitle
            self.dismiss = dismiss
            self.general = general
        }
        self.mode = mode
    }
}

public struct IconConfiguration {
    public var image: Image
    public var color: Color
    public var position: Position
    public var size: CGSize
    
    public init(image: Image,
                color: Color,
                position: Position = .leading,
                size: CGSize = .init(width: 32, height: 32)) {
        self.image = image
        self.color = color
        self.position = position
        self.size = size
    }
    
    public enum Position {
        case leading
        case trailing
    }
}

public struct TitleConfiguration {
    public var text: String
    public var color: Color
    public var font: Font
    
    public init(text: String,
                color: Color = Color(.label),
                font: Font = .headline.weight(.semibold)) {
        self.text = text
        self.color = color
        self.font = font
    }
}

public struct SubtitleConfiguration {
    public var text: String
    public var color: Color
    public var font: Font
    
    public init(text: String,
                color: Color = Color(.secondaryLabel),
                font: Font = .subheadline.weight(.medium)) {
        self.text = text
        self.color = color
        self.font = font
    }
}

public struct ButtonConfiguration {
    public var text: String
    public var color: Color
    public var font: Font
    public var didTap: (() -> Void)?
    public var dismissOnTap: Bool
    
    public init(text: String,
                color: Color = Color(.systemBlue),
                font: Font = .subheadline.weight(.semibold),
                didTap: ( () -> Void)? = nil,
                dismissOnTap: Bool = true) {
        self.text = text
        self.color = color
        self.font = font
        self.didTap = didTap
        self.dismissOnTap = dismissOnTap
    }
}

public struct DismissConfiguration {
    public var autoDismiss: Bool
    public var autoDismissDuration: Double
    public var swipeToDismiss: Bool
    
    public init(autoDismiss: Bool = true,
                autoDismissDuration: Double = 3.0,
                swipeToDismiss: Bool = true) {
        self.autoDismiss = autoDismiss
        self.autoDismissDuration = autoDismissDuration
        self.swipeToDismiss = swipeToDismiss
    }
}

public struct GeneralConfiguration {
    public var backgroundColor: Color
    public var topOffset: Double
    public var horizontalAlignment: HorizontalAlignment
    public var verticalAlignment: VerticalAlignment
    
    public init(backgroundColor: Color = Color(uiColor: .tertiarySystemBackground),
                topOffset: Double = 16.0,
                horizontalAlingment: HorizontalAlignment = .center,
                verticalAlignment: VerticalAlignment = .center) {
        self.backgroundColor = backgroundColor
        self.topOffset = topOffset
        self.horizontalAlignment = horizontalAlingment
        self.verticalAlignment = verticalAlignment
    }
}
