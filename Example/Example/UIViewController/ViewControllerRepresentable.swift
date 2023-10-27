//
//  ViewControllerRepresentable.swift
//  AirHUD
//
//  Created by Christian Skorobogatow on 24/10/23.
//  Copyright © 2023 AirApps. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct ViewControllerRepresentable: UIViewControllerRepresentable {
    public typealias UiViewControllerType = UIKitViewController
    
    public init() {}
    
    public func makeUIViewController(context: Context) -> UIKitViewController {
        UIKitViewController()
    }
    
    public func updateUIViewController(_ uiViewController: UIKitViewController, context: Context) {}
}

@available(iOS 13.0, *)
public struct ViewController_Previews: PreviewProvider {
    public static var previews: some View {
        ViewControllerRepresentable()
    }
}
