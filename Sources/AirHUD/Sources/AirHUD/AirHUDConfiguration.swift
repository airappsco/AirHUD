//
//  AirHUDConfiguration.swift
//  AirHUD
//
//  Created by Ufuk Benlice on 8/15/23.
//

import SwiftUI

/// Mode enum that provides easy to populate AirHUD configuration.
public enum AirHUDMode {
    
    /// Icon and title mode.
    /// - Parameters:
    ///   - icon: Model that represents hud icon configuration.
    ///   - title: Model that represents hud title configuration.
    ///   - dismiss: Model that represents hud dismissal configuration.
    ///   - general: Model that represents hud general configuration.
    case iconAndTitle(icon: IconConfiguration,
                      title: TitleConfiguration,
                      dismiss: DismissConfiguration = .init(),
                      general: GeneralConfiguration = .init())
    
    /// Icon, title and button mode.
    /// - Parameters:
    ///   - icon: Model that represents hud icon configuration.
    ///   - title: Model that represents hud title configuration.
    ///   - button: Model that represents hud button configuration.
    ///   - dismiss: Model that represents hud dismissal configuration.
    ///   - general: Model that represents hud general configuration.
    case iconTitleAndButton(icon: IconConfiguration,
                            title: TitleConfiguration,
                            button: ButtonConfiguration,
                            dismiss: DismissConfiguration = .init(),
                            general: GeneralConfiguration = .init())
    
    /// Icon, title and subtitle mode.
    /// - Parameters:
    ///   - icon: Model that represents hud icon configuration.
    ///   - title: Model that represents hud title configuration.
    ///   - subtitle: Model that represents hud subtitle configuration.
    ///   - dismiss: Model that represents hud dismissal configuration.
    ///   - general: Model that represents hud general configuration.
    case iconTitleAndSubtitle(icon: IconConfiguration,
                              title: TitleConfiguration,
                              subtitle: SubtitleConfiguration,
                              dismiss: DismissConfiguration = .init(),
                              general: GeneralConfiguration = .init())
}

/// Configuration model of AirHUD.
public struct AirHUDConfiguration {
    
    /// Mode that determines the appearance and content of AirHUD.
    public var mode: AirHUDMode
    
    /// Model that represents hud icon configuration.
    public var icon: IconConfiguration
    
    /// Model that represents hud title configuration.
    public var title: TitleConfiguration
    
    /// Model that represents hud subtitle configuration.
    public var subtitle: SubtitleConfiguration?
    
    /// Model that represents hud button configuration.
    public var button: ButtonConfiguration?
    
    /// Model that represents hud dismiss configuration.
    public var dismiss: DismissConfiguration
    
    /// Model that represents hud general configuration.
    public var general: GeneralConfiguration
    
    /// Creates a configuration model for AirHUD
    /// - Parameter mode: enum value that represents of  AirHUD's preferred mode.
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

/// Model that represents hud icon configuration.
public struct IconConfiguration {
    
    /// Image which will show on AirHUD.
    public var image: Image
    
    /// Foreground color for the given image.
    public var color: Color
    
    /// Position of given image in AirHUD.
    ///
    /// If leading is assigned, image will appear on the left side of AirHUD.
    /// If trailing is assigned, image will appear on the right side of AirHUD.
    public var position: Position
    
    /// Size of the given image
    public var size: CGSize
    
    /// Creates a image configuration model for AirHUD
    /// - Parameters:
    ///   - image: Image which will show on AirHUD.
    ///   - color: Foreground color for the given image.
    ///   - position: Position of given image in AirHUD. Initial value is leading.
    ///   - size: Size of the given image. Initial value is (32,32).
    public init(image: Image,
                color: Color,
                position: Position = .leading,
                size: CGSize = .init(width: 32, height: 32)) {
        self.image = image
        self.color = color
        self.position = position
        self.size = size
    }
    
    /// Enum that represents position of image in AirHUD
    public enum Position {
        case leading
        case trailing
    }
}

/// Model that represents hud title configuration.
public struct TitleConfiguration {
    
    /// String which will show as title on AirHUD.
    public var text: String
    
    /// Color of the title.
    public var color: Color
    
    /// Font of the title.
    public var font: Font
    
    /// Creates a title configuration model for AirHUD
    /// - Parameters:
    ///   - text: String which will show as title on AirHUD.
    ///   - color: Color of the title. Initial value is iOS label system color.
    ///   - font: Font of the title. Initial value is iOS headline system font with semibold weight.
    public init(text: String,
                color: Color = Color(.label),
                font: Font = .headline.weight(.semibold)) {
        self.text = text
        self.color = color
        self.font = font
    }
}

/// Model that represents hud subtitle configuration.
public struct SubtitleConfiguration {
    
    /// String which will show as subtitle on AirHUD.
    public var text: String
    
    /// Color of the subtitle.
    public var color: Color
    
    /// Font of the subtitle.
    public var font: Font
    
    /// Creates a subtitle configuration model for AirHUD.
    /// - Parameters:
    ///   - text: String which will show as subtitle on AirHUD.
    ///   - color: Color of the subtitle. Initial value is iOS secondaryLabel system color.
    ///   - font: Font of the subtitle. Initial value is iOS subheadline system font with medium weight.
    public init(text: String,
                color: Color = Color(.secondaryLabel),
                font: Font = .subheadline.weight(.medium)) {
        self.text = text
        self.color = color
        self.font = font
    }
}

/// Model that represents hud button configuration.
public struct ButtonConfiguration {
    
    /// String which will show as button's title on AirHUD.
    public var text: String
    
    /// Color of the button.
    public var color: Color
    
    /// Font of the button.
    public var font: Font
    
    /// Tap action of the button.
    public var didTap: (() -> Void)?
    
    /// Flag that refers dismiss of AIRHUD when button is tapped.
    public var dismissOnTap: Bool
    
    /// Creates a button configuration model for AirHUD
    /// - Parameters:
    ///   - text: String which will show as button's title on AirHUD.
    ///   - color: Color of the button.
    ///   - font: Font of the button. Initial value is iOS subheadline system font with semibold weight.
    ///   - didTap: Tap action of the button. Initial value is nil.
    ///   - dismissOnTap: Flag that refers dismiss of AIRHUD when button is tapped. Initial value is true.
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

/// Model that represents hud dismissal configuration.
public struct DismissConfiguration {
    
    /// Flag that refers dismiss of AirHUD's auto dismiss after specified duration.
    public var autoDismiss: Bool
    
    /// Value that refers auto dismiss duration (as seconds) of AirHUD.
    public var autoDismissDuration: Double
    
    /// Flag that refers top swipe to refer ability of AirHUD.
    public var swipeToDismiss: Bool
    
    /// Creates a dismissal configuration model for AirHUD
    /// - Parameters:
    ///   - autoDismiss: Flag that refers dismiss of AirHUD's auto dismiss after specified duration.
    ///   - autoDismissDuration: Value that refers auto dismiss duration (as seconds) of AirHUD. Initial value is 3 seconds.
    ///   - swipeToDismiss: Flag that refers top swipe to refer ability of AirHUD. Initial value is true.
    public init(autoDismiss: Bool = true,
                autoDismissDuration: Double = 3.0,
                swipeToDismiss: Bool = true) {
        self.autoDismiss = autoDismiss
        self.autoDismissDuration = autoDismissDuration
        self.swipeToDismiss = swipeToDismiss
    }
}

/// Model that represents hud general configuration.
public struct GeneralConfiguration {
    
    /// Background color of AirHUD.
    public var backgroundColor: Color
    
    /// Value that  refers top offset of AirHUD.
    public var topOffset: Double
    
    /// Value that refers horizontal alignment of the hud's content.
    public var horizontalAlignment: HorizontalAlignment
    
    /// Value that refers vertical alignment of the hud's content.
    public var verticalAlignment: VerticalAlignment
    
    /// Creates a general configuration model for AirHUD
    /// - Parameters:
    ///   - backgroundColor: Background color of AirHUD. Initial value is iOS tertiarySystemBackground system color.
    ///   - topOffset: Value that  presents top offset of AirHUD. Initial value is 16.0/
    ///   - horizontalAlignment: Value that refers horizontal alignment of the hud's content. Initial value is center.
    ///   - verticalAlignment: Value that refers vertical alignment of the hud's content. Initial value is center.
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
