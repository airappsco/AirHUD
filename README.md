![Static Badge](https://img.shields.io/badge/license-MIT-lightgray)
![Static Badge](https://img.shields.io/badge/iOS-12.0+-blue.svg)
![Static Badge](https://img.shields.io/badge/SPM-compatible-brightgreen)

![AirHUD_Project Banner_Github 2](https://github.com/airappsco/AirHUD/assets/104971436/d838c0df-60ba-4def-baef-b25239a28eaa)

HUD component written using SwiftUI for **iOS 15** and later

## 🌟 Features
- 3 different layouts 📐:
    * Icon and Title 🏷️
    * Icon, Title and Button 🖲️
    * Icon, Title and Subtitle 📄
- Customizable Fonts, Colors, Alignments and more 🎨
- Dynamic Type support 🔠
- Compatible with Dark Mode by default 🌙
- Swift Package Manager support 📦

## 📋  Requirements
- iOS 12 ((if you use only UIKit)
- iOS 15.0+ (if you use it in SwiftUI)
- Swift 5.8+ (Xcode 14.3+).

## 🔧 Installation
AirHUD is distributed via **Swift Package Manager** 📦. 

To install AirHUD, please add the following line to the `dependencies:` section in your `Package.swift` file:

```swift
.package(url: "https://github.com/airappsco/AirHUD.git", .upToNextMinor(from: "1.0.0")),
```

## 🚀 Usage

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

### 🏷️ Icon and Title

<p><img src="https://github.com/airappsco/AirHUD/assets/104971436/5288d2d9-c27c-4eb5-bc8d-9232e38f1746" width="400"></p>

```swift
        .airHud(isPresented: $isPresented,
                iconImage: Image(systemName: "doc.on.doc"),
                iconColor: Color(uiColor: .systemBlue),
                title: "Text Copied")
```

### 🖲️ Icon, Title and Button

<p><img src="https://github.com/airappsco/AirHUD/assets/104971436/34336c04-c2d9-4f0c-9f1e-a751bce85470" width="400"></p>

```swift
        .airHud(isPresented: $isPresented,
                iconImage: Image(systemName: "trash"),
                iconColor: Color(uiColor: .systemRed),
                title: "Conversation Deleted",
                buttonTitle: "Undo",
                buttonAction: nil)
```

### 📄 Icon, Title and Subtitle

<p><img src="https://github.com/airappsco/AirHUD/assets/104971436/adbc8bb0-bac3-47da-b53c-5d44e3d0dbef" width="400"></p>

```swift
        .airHud(isPresented: $isPresented,
                iconImage: Image(systemName: "folder"),
                iconColor: Color(uiColor: .systemBlue),
                title: "Moved",
                subtitle: "File moved to \"Personal\"")
```

### ⚙️ With Configuration

<p><img src="https://github.com/airappsco/AirHUD/assets/104971436/29ea12c2-9667-4770-a457-351f22ec0302" width="400"></p>

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

### 🏗️ Using AirHUD with UIKit

AirHUD also supports UIKit using a wrapper, though the underlying views utilize SwiftUI. You can achieve the same 4 configurations as presented above. However, due to the dependency on SwiftUI, the setup process slightly differs.

> **Note:** To use AirHUD with UIKit, you will need to switch to the `feature/ios-12-support` branch.

The steps to use AirHUD with UIKit are as follows:

1. **Import the AirHUD module.** Initiate AirHUDUIKitProvider in the file where it's needed.

```swift
import AirHUD
private let hudProvider = AirHUDUIKitProvider()
```

2. **Set up the type of HUD that suits your requirement.** 

For this, you need to provide an ID of type `String` and the target `UIViewController` where the HUD should be displayed. 

```swift
override public func viewDidLoad() {
    super.viewDidLoad()
    setupIconAndTitleHUD()
}
```

Here is an example setup of an `IconAndTitle` HUD:

```swift
@objc func setupIconAndTitleHUD() {
    hudProvider.setupAirHUD(
        hudID: "1",
        hudType: .iconAndTitle(
            Image(systemName: "doc.on.doc"),
            .blue,
            "Text Copied"
        ),
        in: self
    )
}
```

3. **Present the HUD.** 

This can be executed from your trigger function by providing the HUD's ID:

```swift
@objc func didTapButtonStateIconAndTitle() {
    hudProvider.toggleAirHUD(hudID: "1")
}
```

You can check out the **[Example project](Example)** in the workspace for both SwiftUI and UIKit's detailed usage.

## Validation
This framework has been validated and tested through integration into our app [Translate Now](https://apps.apple.com/us/app/translate-now-translator/id1348028646).

## Contributing to Air Apps
Want to contribute to **Air Apps**? Please refer to the following guide [here](./CONTRIBUTING.md).

## About Air Apps

**Air Apps** is a leading mobile application publisher dedicated to creating practical solutions for everyday challenges. With a portfolio of over 30 mobile applications spanning Fitness, Productivity, Creative, and Learning, we aim to simplify lives. Our unique approach includes a fully remote work environment, allowing our diverse team to collaborate from around the world. As an AI-first company, we stay up-to-date with technology trends, integrating them into our products to enhance user experiences. Our ongoing mission is to provide value to both our users and our team, fostering continuous improvement and a commitment to making life easier.

Learn more about us in the following links:

**Website:** [airapps.co](https://airapps.co/)  
**Our Apps:** [View on App Store](https://apps.apple.com/us/developer/wzp-solutions-lda/id1316153435)  
**Careers:** [airapps.co/careers](https://airapps.co/careers/)  
**Linkedin:** [linkedin.com/company/airapps](http://linkedin.com/company/airapps/)  
**Blog:** [blog.airapps.co](https://blog.airapps.co/)  
**Instagram:** [@airappsco](https://www.instagram.com/airappsco/)  
**Twitter:** [@airappsco](https://twitter.com/airappsco/)  
**Facebook:** [facebook.com/airappsco](https://www.facebook.com/airappsco/)  
**Youtube:** [Youtube @airapps](https://www.youtube.com/@airapps)

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
