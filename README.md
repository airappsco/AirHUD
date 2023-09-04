![Static Badge](https://img.shields.io/badge/license-MIT-lightgray)
![Static Badge](https://img.shields.io/badge/iOS-15.0+-blue.svg)
![Static Badge](https://img.shields.io/badge/SPM-compatible-brightgreen)

![AirHUD_Project Banner_Github 2](https://github.com/airappsco/AirHUD/assets/101549919/07159edb-163a-4207-9977-010359cfef89)

HUD component written using SwiftUI for **iOS 15** and later

## Features
- 3 different layouts
    * Icon and Title
    * Icon, Title and Button
    * Icon, Title and Subtitle
- Customizable Fonts, Colors, Alignments and more
- Dynamic Type support
- Compatible with Dark Mode by default
- Swift Package Manager support

## Installation
AirHUD is distributed via **Swift Package Manager**. <br>

To install AirHUD, please add following line to the `dependencies:` section in your `Package.swift` file:

```swift
.package(url: "https://github.com/airappsco/AirHUD.git", .upToNextMinor(from: "1.0.0")),
```

## Usage

Import module in the file which will be used in
```swift
import AirHUD
```

Call related `airHUD` function after a SwiftUI View that takes up the whole screen with a bindable boolean and necessary information.

```swift
struct ContentView: View {
    
    @State var isPresented: Bool = false

    var body: some View {
        VStack {
            Spacer()
            Button("Show HUD") {
                isPresented = true
            }
            Spacer()
        }
        .airHud(isPresented: $isPresented,
                iconImage: Image(systemName: "doc.on.doc"),
                iconColor: Color(uiColor: .systemBlue),
                title: "Text Copied")
    }
}
```

There are 4 different `airHUD` functions. 3 of them provides ease of use for 3 different layouts with default UI customization. Last one provides customization over HUD elements such as fonts, colors, alignments and more.

### Icon and Title

<p><img src="https://github.com/airappsco/AirHUD/assets/110384781/793f90d8-5618-48ad-83c2-8d4de024f007" width="400"></p>

```swift
        .airHud(isPresented: $isPresented,
                iconImage: Image(systemName: "doc.on.doc"),
                iconColor: Color(uiColor: .systemBlue),
                title: "Text Copied")
```

### Icon, Title and Button

<p><img src="https://github.com/airappsco/AirHUD/assets/110384781/f00ae526-fbb6-48f7-9212-e66eddeca417" width="400"></p>

```swift
        .airHud(isPresented: $isPresented,
                iconImage: Image(systemName: "trash"),
                iconColor: Color(uiColor: .systemRed),
                title: "Conversation Deleted",
                buttonTitle: "Undo",
                buttonAction: nil)
```

### Icon, Title and Subtitle

<p><img src="https://github.com/airappsco/AirHUD/assets/110384781/6e829c89-f52a-4d80-b639-5acfa7f7364c" width="400"></p>

```swift
        .airHud(isPresented: $isPresented,
                iconImage: Image(systemName: "folder"),
                iconColor: Color(uiColor: .systemBlue),
                title: "Moved",
                subtitle: "File moved to \"Personal\"")
```

### With Configuration

<p><img src="https://github.com/airappsco/AirHUD/assets/110384781/82a1669f-c6b5-4480-8d4f-946b20ce01c1" width="400"></p>

```swift
    var hudConfiguration: AirHUDConfiguration {
        let iconConfiguration = IconConfiguration(image: .init(systemName: "star"),
                                                  color: .white,
                                                  position: .trailing,
                                                  size: Constant.customIconSize)
        let titleConfiguration = TitleConfiguration(text: "Added to Favorites",
                                                    color: .purple,
                                                    font: .headline.italic())
        let subtitleConfiguration = SubtitleConfiguration(text: "You can change your favorites at any time from favorites section",
                                                          color: .blue,
                                                          font: .callout)
        let dismissConfiguration = DismissConfiguration(autoDismiss: true)
        let generalConfiguration = GeneralConfiguration(backgroundColor: .orange,
                                                        horizontalAlingment: .center,
                                                        verticalAlignment: .bottom)
        let mode: AirHUDMode = .iconTitleAndSubtitle(icon: iconConfiguration,
                                                     title: titleConfiguration,
                                                     subtitle: subtitleConfiguration,
                                                     dismiss: dismissConfiguration,
                                                     general: generalConfiguration)
        return AirHUDConfiguration(mode: mode)
    }
```
```swift
        .airHud(isPresented: $isPresented,
                configuration: hudConfiguration)
```

You can also check the **[Example project](Example)** for usage.

## License

MIT License

Copyright (c) 2023  Air Apps (Air Apps, Inc. and Affiliates)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
