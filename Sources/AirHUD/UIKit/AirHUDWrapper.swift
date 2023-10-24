//
//  AirHUDWrapper.swift
//  AirHUD
//
//  Created by Christian Skorobogatow on 24/10/23.
//  Copyright © 2023 AirApps. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

@available(iOS 13.0, *)
public class AirHUDIKitState: ObservableObject {
    
    public init(isPresented: Bool = false) {
        self.isPresented = isPresented
    }
    
    @Published public var isPresented = false
}

@available(iOS 13.0, *)
public struct AirHUDContainer: View {
    public enum HUDType {
        case configuration(AirHUDConfiguration)
        case iconAndTitle(Image, Color, String)
        case iconTitleAndButton(Image, Color, String, String, (() -> Void)?)
        case iconTitleAndSubtitle(Image, Color, String, String)
    }
    
    @ObservedObject var state: AirHUDIKitState
    public var hudType: HUDType
    
    public init(state: AirHUDIKitState, hudType: HUDType) {
        self.state = state
        self.hudType = hudType
    }
    
    public func toHudView() -> some View {
        ZStack {
            switch self.hudType {
            case .configuration(
                let configuration
            ):
                Color.red
                    .airHud(
                        isPresented: $state.isPresented,
                        configuration: configuration
                    )
                
            case .iconAndTitle(
                let iconImage,
                let iconColor,
                let title
            ):
                Color.red
                    .airHud(
                        isPresented: $state.isPresented,
                        iconImage: iconImage,
                        iconColor: iconColor,
                        title: title
                    )
                
            case .iconTitleAndButton(
                let iconImage,
                let iconColor,
                let title,
                let buttonTitle,
                let buttonAction
            ):
                Color.red
                    .airHud(
                        isPresented: $state.isPresented,
                        iconImage: iconImage,
                        iconColor: iconColor,
                        title: title,
                        buttonTitle: buttonTitle,
                        buttonAction: buttonAction
                    )
                
            case .iconTitleAndSubtitle(
                let iconImage,
                let iconColor,
                let title,
                let subtitle
            ):
                Color.red
                    .airHud(
                        isPresented: $state.isPresented,
                        iconImage: iconImage,
                        iconColor: iconColor,
                        title: title,
                        subtitle: subtitle
                    )
            }
        }
    }
    
    public var body: some View {
        if state.isPresented {
            toHudView()
        } else {
            EmptyView()
        }
    }
}

@available(iOS 13.0, *)
public class UIKitViewController: UIViewController {
    
    private var stateIconAndTitle: AirHUDIKitState
    private var stateIconTitleAndButton: AirHUDIKitState
    private var stateIconTitleAndSubtitle: AirHUDIKitState
    private var stateCustomized: AirHUDIKitState
    
    private var cancellable: AnyCancellable?
    
    init(
        stateIconAndTitle: AirHUDIKitState,
        stateIconTitleAndButton: AirHUDIKitState,
        stateIconTitleAndSubtitle: AirHUDIKitState,
        stateCustomized: AirHUDIKitState,
        cancellable: AnyCancellable?
    ) {
        self.stateIconAndTitle = stateIconAndTitle
        self.stateIconTitleAndButton = stateIconTitleAndButton
        self.stateIconTitleAndSubtitle = stateIconTitleAndSubtitle
        self.stateCustomized = stateCustomized
        
        self.cancellable = cancellable
        
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
    
        cancellable = stateIconAndTitle.$isPresented.sink { value in // weak self here
            print(value)
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
        
        airHUDView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(airHUDView)
        
        airHUDView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.addChild(airHUDHostingController)
        airHUDHostingController.didMove(toParent: self)
    }
    
    func setupAirHUDIconTitleAndButton() {
        cancellable = stateIconTitleAndButton.$isPresented.sink { value in // weak self here
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
        
        airHUDView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.addChild(airHUDHostingController)
        airHUDHostingController.didMove(toParent: self)
    }

    func setupAirHUDIconTitleAndSubtitle() {
        cancellable = stateIconTitleAndSubtitle.$isPresented.sink { value in // weak self here
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
        
        airHUDView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.addChild(airHUDHostingController)
        airHUDHostingController.didMove(toParent: self)
    }
    
    func setupAirHUDCustomized() {
        cancellable = stateCustomized.$isPresented.sink { value in // weak self here
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
        
        airHUDView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
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
            cancellable: nil
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
