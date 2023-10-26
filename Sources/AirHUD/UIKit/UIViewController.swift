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
    
    deinit {
        cancellableIconAndTitle?.cancel()
        cancellableIconTitleAndButton?.cancel()
        cancellableIconTitleAndSubtitle?.cancel()
        cancellableCustomized?.cancel()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupButtonsUI()
        setupAirHUDStates()
    }
        
    func setupAirHUDStates() {
        setupAirHUDIconAndTitle()
        setupAirHUDIconTitleAndButton()
        setupAirHUDIconTitleAndSubtitle()
        setupAirHUDCustomized()
    }
    
    func setupAirHUD(
        state: AirHUDIKitState,
        hudType: HUDType,
        hudView: UIView?,
        viewController: UIViewController
    ) {
    
        let airHUDHostingController = UIHostingController(
            rootView: createAirHUDContainer(
                state: state,
                hudType: hudType
            )
        )
        
        guard let airHUDView = airHUDHostingController.view else { return }
        
        configureHUDView(airHUDView)
        animateHUDView(
            hudView: airHUDView,
            state: state
        )
        constrainHUDView(hudView: airHUDView, viewController: viewController)
    }

    func createAirHUDContainer(
        state: AirHUDIKitState,
        hudType: HUDType
    ) -> AirHUDContainer {
         AirHUDContainer(
            state: state,
            hudType: hudType
        )
    }

    func configureHUDView(_ airHUDView: UIView) {
        airHUDView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(airHUDView)
    }

    func animateHUDView(hudView: UIView?, state: AirHUDIKitState) {
        state.cancellable?.cancel()
        state.cancellable = state.$isPresented.sink { [weak self] value in
            let YOffset: CGFloat = -20
            let transform: CGAffineTransform = value ? .identity : CGAffineTransform(translationX: 0, y: -YOffset)
            
            DispatchQueue.main.async { [weak self] in
                self?.animateTransform(transform, hudView: hudView)
            }
        }
    }

    func animateTransform(_ transform: CGAffineTransform, hudView: UIView?) {
        UIView.animate(
            withDuration: 1.5,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.6,
            options: [.curveEaseInOut],
            animations: {
                hudView?.transform = transform
            },
            completion: { [weak self] _ in
                self?.animateFinalTransform(hudView)
            }
        )
    }

    func animateFinalTransform(_ hudView: UIView?) {
        UIView.animate(
            withDuration: 1.0,
            delay: 1,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            options: [.curveEaseInOut],
            animations: {
                hudView?.transform = CGAffineTransform(translationX: 0, y: -200)
            },
            completion: nil
        )
    }

    func constrainHUDView(hudView: UIView?, viewController: UIViewController) {
        hudView?.topAnchor.constraint(equalTo: viewController.view.topAnchor).isActive = true
        hudView?.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor).isActive = true
        hudView?.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor).isActive = true
        hudView?.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor).isActive = true
    }

    func setupAirHUDIconAndTitle() {
        setupAirHUD(
            state: stateIconAndTitle,
            hudType: .iconAndTitle(
                Image(systemName: "doc.on.doc"),
                .blue,
                "Text Copied"
            ),
            hudView: hudView,
            viewController: self
        )
    }
    
    func setupAirHUDIconTitleAndButton() {
        setupAirHUD(
            state: stateIconTitleAndButton,
            hudType: .iconTitleAndButton(
                Image(systemName: "trash"),
                .blue,
                "Conversation Deleted",
                "Undo",
                nil
            ),
            hudView: hudView,
            viewController: self
        )
    }
    
    func setupAirHUDIconTitleAndSubtitle() {
        setupAirHUD(
            state: stateIconTitleAndSubtitle,
            hudType: .iconTitleAndSubtitle(
                Image(systemName: "folder"),
                .blue,
                "Moved",
                "File moved to \"Personal\""
            ),
            hudView: hudView,
            viewController: self
        )
    }
    
    func setupAirHUDCustomized() {
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
        
        setupAirHUD(
            state: stateCustomized,
            hudType: .configuration(customizedConfiguration),
            hudView: hudView,
            viewController: self
        )
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
