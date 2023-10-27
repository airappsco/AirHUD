//
//  File.swift
//  
//
//  Created by Christian on 27/10/23.
//

import Combine
import UIKit

@available(iOS 13.0, *)
class HUDStateManagerUIKit: ObservableObject {
    
    @Published var isPresented: Bool
    
    weak var hudView: UIView?
    var cancellable: AnyCancellable?
    
    init(isPresented: Bool = false) {
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
