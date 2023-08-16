//
//  AirHUDView.swift
//  AirHUD
//
//  Created by Ufuk Benlice on 8/15/23.
//

import Foundation
import SwiftUI

struct AirHudView<ViewModel: AirHUDViewModelObservable>: View {
    
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        if viewModel.isPresented.wrappedValue {
            VStack {
                viewForMode
                .padding(.vertical, Layout.viewVerticalPadding)
                .padding(.horizontal, Layout.viewHorizontalPadding)
                .background(viewModel.configuration.general.backgroundColor)
                .cornerRadius(Layout.viewCornerRadius)
                .shadow(
                    color: .black.opacity(Layout.shadowOpacity),
                    radius: Layout.shadowRadius,
                    x: Layout.shadowX,
                    y: Layout.shadowY
                )
                .offset(y: viewModel.configuration.general.topOffset)
                .frame(maxWidth: Layout.hudMaximumWidth)
                Spacer()
            }
            .padding(.horizontal, Layout.hudHorizontalPadding)
            .transition(.move(edge: .top))
            .gesture(DragGesture().onEnded({ value in
                if value.translation.height < 0 {
                    viewModel.hide()
                }
            }))
        }
    }
    
    @ViewBuilder var viewForMode: some View {
        switch viewModel.configuration.mode {
        case .iconAndTitle:
            iconAndTitleView
        case .iconTitleAndButton:
            iconTitleAndButtonView
        case .iconTitleAndSubtitle:
            iconTitleAndSubtitleView
        }
    }
    
    var iconAndTitleView: some View {
        HStack(alignment: viewModel.configuration.general.verticalAlignment,
               spacing: Layout.horizontalItemSpacing) {
            if viewModel.configuration.icon.position == .leading {
                iconView
            }
            VStack(alignment: viewModel.configuration.general.horizontalAlignment) {
                titleView
            }
            if viewModel.configuration.icon.position == .trailing {
                iconView
            }
        }
    }
    
    var iconTitleAndButtonView: some View {
        HStack(alignment: viewModel.configuration.general.verticalAlignment,
               spacing: Layout.horizontalItemSpacing) {
            if viewModel.configuration.icon.position == .leading {
                iconView
            }
            VStack(alignment: viewModel.configuration.general.horizontalAlignment,
                   spacing: Layout.verticalItemSpacing) {
                titleView
                button
            }
            if viewModel.configuration.icon.position == .trailing {
                iconView
            }
        }
    }
    
    var iconTitleAndSubtitleView: some View {
        HStack(alignment: viewModel.configuration.general.verticalAlignment,
               spacing: Layout.horizontalItemSpacing) {
            if viewModel.configuration.icon.position == .leading {
                iconView
            }
            VStack(alignment: viewModel.configuration.general.horizontalAlignment,
                   spacing: Layout.verticalItemSpacing) {
                titleView
                subtitleView
            }
            if viewModel.configuration.icon.position == .trailing {
                iconView
            }
        }
    }
    
    var iconView: some View {
        viewModel.configuration.icon.image
            .resizable()
            .scaledToFit()
            .frame(width: viewModel.configuration.icon.size.width, height: viewModel.configuration.icon.size.height)
            .foregroundColor(viewModel.configuration.icon.color)
    }
    
    var titleView: some View {
        Text(viewModel.configuration.title.text)
            .lineLimit(lineLimitOfTitle())
            .font(viewModel.configuration.title.font)
            .foregroundColor(viewModel.configuration.title.color)
    }
    
    var subtitleView: some View {
        Text(viewModel.configuration.subtitle?.text ?? "")
            .lineLimit(Layout.subtitleLineLimit)
            .font(viewModel.configuration.subtitle?.font ?? .subheadline)
            .foregroundColor(viewModel.configuration.subtitle?.color ?? .gray)
    }
    
    var button: some View {
        Button(viewModel.configuration.button?.text ?? "") {
            if viewModel.configuration.button?.dismissOnTap == true {
                viewModel.hide()
            }
            viewModel.configuration.button?.didTap?()
        }
        .foregroundColor(viewModel.configuration.button?.color ?? .blue)
        .font(viewModel.configuration.button?.font ?? .body)
    }
    
    enum Layout {
        static var titleLineLimit: Int { 1 }
        static var subtitleLineLimit: Int { 2 }
        static var horizontalItemSpacing: CGFloat { 12 }
        static var verticalItemSpacing: CGFloat { 2 }
        static var viewVerticalPadding: CGFloat { 12 }
        static var viewHorizontalPadding: CGFloat { 24 }
        static var hudHorizontalPadding: CGFloat { 16 }
        static var viewCornerRadius: CGFloat { 1000 }
        static var shadowOpacity: CGFloat { 0.2 }
        static var shadowRadius: CGFloat { 18 }
        static var shadowX: CGFloat { 0 }
        static var shadowY: CGFloat { 4 }
        static var hudMaximumWidth: CGFloat {
            UIDevice.current.userInterfaceIdiom == .pad ? 360.0 : .infinity
        }
    }
}

// MARK: Private Helpers
private extension AirHudView {
    func lineLimitOfTitle() -> Int {
        switch viewModel.configuration.mode {
        case .iconAndTitle:
            return Layout.subtitleLineLimit
        default:
            return Layout.titleLineLimit
        }
    }
}
