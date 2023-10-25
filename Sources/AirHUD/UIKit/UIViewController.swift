//
//  UIViewController.swift
//  AirHUD
//
//  Created by Christian Skorobogatow on 24/10/23.
//  Copyright © 2023 AirApps. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

// MARK: This is for development purposes and will be moved into Example project later on

@available(iOS 13.0, *)
public class UIKitViewController: UIViewController {
    
    private var stateIconAndTitle: AirHUDIKitState
    private var stateIconTitleAndButton: AirHUDIKitState
    private var stateIconTitleAndSubtitle: AirHUDIKitState
    private var stateCustomized: AirHUDIKitState
    private var hudView: UIView?
    
    private var cancellableIconAndTitle: AnyCancellable?
    private var cancellableIconTitleAndButton: AnyCancellable?
    private var cancellableIconTitleAndSubtitle: AnyCancellable?
    private var cancellableCustomized: AnyCancellable?
    
    init(
        stateIconAndTitle: AirHUDIKitState,
        stateIconTitleAndButton: AirHUDIKitState,
        stateIconTitleAndSubtitle: AirHUDIKitState,
        stateCustomized: AirHUDIKitState,
        cancellableIconAndTitle: AnyCancellable?,
        cancellableIconTitleAndButton: AnyCancellable?,
        cancellableIconTitleAndSubtitle: AnyCancellable?,
        cancellableCustomized: AnyCancellable?
    ) {
        self.stateIconAndTitle = stateIconAndTitle
        self.stateIconTitleAndButton = stateIconTitleAndButton
        self.stateIconTitleAndSubtitle = stateIconTitleAndSubtitle
        self.stateCustomized = stateCustomized
        
        self.cancellableIconAndTitle = cancellableIconAndTitle
        self.cancellableIconTitleAndButton = cancellableIconTitleAndButton
        self.cancellableIconTitleAndSubtitle = cancellableIconTitleAndSubtitle
        self.cancellableCustomized = cancellableCustomized
        
        super.init(
            nibName: nil,
            bundle: nil
        )
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public  func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupButtonsUI()
        setupAirHUDStates()
    }
        
    func setupButtonsUI() {
        let stateIconAndTitleButton = UIButton(frame: .zero)
        stateIconAndTitleButton.setTitle("Icon and Title", for: .normal)
        stateIconAndTitleButton.setTitleColor(.systemBlue, for: .normal)
        stateIconAndTitleButton.addTarget(self, action: #selector(didTapButtonStateIconAndTitle), for: .touchUpInside)
        
        let stateIconTitleAndButton = UIButton(frame: .zero)
        stateIconTitleAndButton.setTitle("Icon, Title and Button", for: .normal)
        stateIconTitleAndButton.setTitleColor(.systemBlue, for: .normal)
        stateIconTitleAndButton.addTarget(self, action: #selector(didTapButtonStateIconTitleAndButton), for: .touchUpInside)
        
        let stateIconTitleAndSubtitleButton = UIButton(frame: .zero)
        stateIconTitleAndSubtitleButton.setTitle("Icon, Title and Subtitle", for: .normal)
        stateIconTitleAndSubtitleButton.setTitleColor(.systemBlue, for: .normal)
        stateIconTitleAndSubtitleButton.addTarget(self, action: #selector(didTapButtonStateIconAndSubtitle), for: .touchUpInside)
        
        let stateCustomizedButton = UIButton(frame: .zero)
        stateCustomizedButton.setTitle("Customized", for: .normal)
        stateCustomizedButton.setTitleColor(.systemBlue, for: .normal)
        stateCustomizedButton.addTarget(self, action: #selector(didTapStateCustomized), for: .touchUpInside) // And here too
        
        // Initialize a vertical UIStackView
        let stackView = UIStackView(arrangedSubviews: [stateIconAndTitleButton, stateIconTitleAndButton, stateIconTitleAndSubtitleButton, stateCustomizedButton])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            view.trailingAnchor.constraint(greaterThanOrEqualTo: stackView.trailingAnchor, constant: 20)
        ])
    }
    func setupAirHUDStates() {
        setupAirHUDIconAndTitle()
        setupAirHUDIconTitleAndButton()
        setupAirHUDIconTitleAndSubtitle()
        setupAirHUDCustomized()
    }

    @objc func didTapButtonStateIconAndTitle() {
        stateIconAndTitle.isPresented = true
    }
    
    @objc func didTapButtonStateIconTitleAndButton() {
        stateIconTitleAndButton.isPresented = true
    }
    
    @objc func didTapButtonStateIconAndSubtitle() {
        stateIconTitleAndSubtitle.isPresented = true
    }
    
    @objc func didTapStateCustomized() {
        stateCustomized.isPresented = true
    }
    
    func setupAirHUDIconAndTitle() {
    
        cancellableIconAndTitle = stateIconAndTitle.$isPresented.sink { value in // weak self here
            print("Icon and title is \(value)")
        }
        
        let airHUDHostingController = UIHostingController(
            rootView: AirHUDContainer(
                state: stateIconAndTitle,
                hudType: .iconAndTitle(
                    Image(systemName: "doc.on.doc"),
                    .blue,
                    "Text Copied"
                )
            )
        )
        
        guard let airHUDView = airHUDHostingController.view else {
            return
        }
        
        hudView = airHUDView
        
        if let hudView = hudView {
            
            hudView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(hudView)
            
            NSLayoutConstraint.activate([
                hudView.topAnchor.constraint(equalTo: view.topAnchor),
                hudView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                hudView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                hudView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
            
            self.addChild(airHUDHostingController)
            airHUDHostingController.didMove(toParent: self)
        }
    }
    
    func setupAirHUDIconTitleAndButton() {
        cancellableIconTitleAndButton = stateIconTitleAndButton.$isPresented.sink { value in // weak self here
            print(value)
        }
        
        let airHUDHostingController = UIHostingController(
            rootView: AirHUDContainer(
                state: stateIconTitleAndButton,
                hudType: .iconTitleAndButton(
                    Image(systemName: "trash"),
                    .blue,
                    "Conversation Deleted",
                    "Undo",
                    nil
                )
            )
        )
        
        guard let airHUDView = airHUDHostingController.view else {
            return
        }
        
        airHUDView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(airHUDView)
        
        NSLayoutConstraint.activate([
            airHUDView.topAnchor.constraint(equalTo: view.topAnchor),
            airHUDView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            airHUDView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            airHUDView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        self.addChild(airHUDHostingController)
        airHUDHostingController.didMove(toParent: self)
    }

    func setupAirHUDIconTitleAndSubtitle() {
        cancellableIconTitleAndSubtitle = stateIconTitleAndSubtitle.$isPresented.sink { value in // weak self here
            print(value)
        }
        
        let airHUDHostingController = UIHostingController(
            rootView: AirHUDContainer(
                state: stateIconTitleAndSubtitle,
                hudType: .iconTitleAndSubtitle(
                    Image(systemName: "folder"),
                    .blue,
                    "Moved",
                    "File moved to \"Personal\""
                )
            )
        )
        
        guard let airHUDView = airHUDHostingController.view else {
            return
        }
        
        airHUDView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(airHUDView)
        
        NSLayoutConstraint.activate([
            airHUDView.topAnchor.constraint(equalTo: view.topAnchor),
            airHUDView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            airHUDView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            airHUDView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        self.addChild(airHUDHostingController)
        airHUDHostingController.didMove(toParent: self)
    }
    
    func setupAirHUDCustomized() {
        cancellableCustomized = stateCustomized.$isPresented.sink { value in // weak self here
            print(value)
        }
        
        let customizedConfiguration = AirHUDConfiguration(mode: .iconTitleAndSubtitle(
            icon: IconConfiguration(
                image: .init(systemName: "star"),
                color: .white,
                position: .trailing,
                size: CGSize(width: 60, height: 60)
            ),
            title: TitleConfiguration(
                text: "Added to Favorites",
                color: .purple,
                font: .headline.italic()
            ),
            subtitle: SubtitleConfiguration(
                text: "You can change your favorites at any time from favorites section",
                color: .blue,
                font: .callout
            ),
            dismiss: DismissConfiguration(
                autoDismiss: false
            ),
            general: GeneralConfiguration(
                backgroundColor: .orange,
                horizontalAlingment: .center,
                verticalAlignment: .center
            )
        )
        )

        let airHUDHostingController = UIHostingController(
            rootView: AirHUDContainer(
                state: stateCustomized,
                hudType: .configuration(customizedConfiguration)
            )
        )
        
        guard let airHUDView = airHUDHostingController.view else {
            return
        }
        
        airHUDView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(airHUDView)
        
        NSLayoutConstraint.activate([
            airHUDView.topAnchor.constraint(equalTo: view.topAnchor),
            airHUDView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            airHUDView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            airHUDView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        self.addChild(airHUDHostingController)
        airHUDHostingController.didMove(toParent: self)
    }
}

@available(iOS 13.0, *)
public struct ViewControllerRepresentable: UIViewControllerRepresentable {
    public typealias UiViewControllerType = UIKitViewController
    
    public init() {}
    
    public func makeUIViewController(context: Context) -> UIKitViewController {
        UIKitViewController(
            stateIconAndTitle: AirHUDIKitState(),
            stateIconTitleAndButton: AirHUDIKitState(),
            stateIconTitleAndSubtitle: AirHUDIKitState(),
            stateCustomized: AirHUDIKitState(),
            cancellableIconAndTitle: nil,
            cancellableIconTitleAndButton: nil,
            cancellableIconTitleAndSubtitle: nil,
            cancellableCustomized: nil
        )
    }
    
    public func updateUIViewController(_ uiViewController: UIKitViewController, context: Context) {}
}

@available(iOS 13.0, *)
public struct ViewController_Previews: PreviewProvider {
    public static var previews: some View {
        ViewControllerRepresentable()
    }
}
