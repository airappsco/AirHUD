//
//  HUDStateManagerUIKit.swift
//  AirHUD
//
//  Created by Christian Skorobogatow on 27/10/23.
//  Copyright © 2023 AirApps. All rights reserved.
//

import Combine
import UIKit

@available(iOS 13.0, *)
class HUDStateManagerUIKit: ObservableObject {
    
    @Published var isPresented: Bool
    
    weak var hudView: UIView?
    weak var viewController: UIViewController?
    var analytics: AirHUDAnalyticsBridge?
    
    var cancellable: AnyCancellable?
    
    init(
        isPresented: Bool = false,
        analytics: AirHUDAnalyticsBridge?
    ) {
        self.analytics = analytics
        self.isPresented = isPresented
    }
    
    func updateCancellable(cancellable: AnyCancellable?) {
        self.cancellable?.cancel()
        self.cancellable = cancellable
    }

    func cancel() {
        cancellable?.cancel()
        cancellable = nil
    }
}
