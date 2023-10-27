//
//  AirHUDUIKitProvider.swift
//  AirHUD
//
//  Created by Christian Skorobogatow on 24/10/23.
//  Copyright © 2023 AirApps. All rights reserved.
//

import AirHUD
import SwiftUI
import UIKit

@available(iOS 13.0, *)
public class UIKitViewController: UIViewController {
    
    private let hudProvider = AirHUDUIKitProvider()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupButtonsUI()
        setupAirHUDS()
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
    
    func setupAirHUDS() {
        setupIconAndTitleHUD()
        setupIconTitleAndButtonHUD()
        setupIconTitleAndSubtitleHUD()
        setupCustomisedHUD()
    }
    
    @objc func didTapButtonStateIconAndTitle() {
        hudProvider.toggleAirHUD(hudID: "1")
    }
    
    @objc func didTapButtonStateIconTitleAndButton() {
        hudProvider.toggleAirHUD(hudID: "2")
    }
    
    @objc func didTapButtonStateIconAndSubtitle() {
        hudProvider.toggleAirHUD(hudID: "3")
    }
    
    @objc func didTapStateCustomized() {
        hudProvider.toggleAirHUD(hudID: "4")
    }
    
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
    
    @objc func setupIconTitleAndButtonHUD() {
        hudProvider.setupAirHUD(
            hudID: "2",
            hudType: .iconTitleAndButton(
                Image(systemName: "trash"),
                .blue,
                "Conversation Deleted",
                "Undo",
                nil
            ),
            in: self
        )
    }
    
    @objc func setupIconTitleAndSubtitleHUD() {
        hudProvider.setupAirHUD(
            hudID: "3",
            hudType: .iconTitleAndSubtitle(
                Image(systemName: "folder"),
                .blue,
                "Moved",
                "File moved to \"Personal\""
            ),
            in: self
        )
    }
    
    @objc func setupCustomisedHUD() {
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
            ))
        )
        
        hudProvider.setupAirHUD(
            hudID: "4",
            hudType: .configuration(customizedConfiguration),
            in: self
        )
    }
}
