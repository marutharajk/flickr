//
//  UIViewController+Extension.swift
//  ImageDetector
//
//  Created by Marutharaj K on 17/09/21.
//

import SwiftUI

public struct ViewControllerHolder {
    
    weak var value: UIViewController?
}

public struct ViewControllerKey: EnvironmentKey {
    
    public static var defaultValue: ViewControllerHolder {
        return ViewControllerHolder(value: UIApplication.shared.windows.first?.rootViewController)

    }
}

public extension EnvironmentValues {
    
    var viewController: UIViewController? {
        get { return self[ViewControllerKey.self].value }
        set { self[ViewControllerKey.self].value = newValue }
    }
}

public extension UIViewController {
        
    func present<Content: View>(backgroundColor: UIColor = .systemBackground,
                                style: UIModalPresentationStyle = .automatic,
                                isModalPresent: Bool = false,
                                @ViewBuilder
                                builder: @escaping () -> Content,
                                completion: (() -> Void)? = nil) {
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.present(backgroundColor: backgroundColor,
                             style: style,
                             isModalPresent: isModalPresent,
                             builder: builder,
                             completion: completion)
            }
            return
        }
        
        let toPresent = UIHostingController(rootView: AnyView(EmptyView()))
        if UIDevice.current.userInterfaceIdiom == .pad {
            toPresent.modalPresentationStyle = style == .popover ? .overFullScreen : style
            toPresent.popoverPresentationController?.sourceView = UIApplication.shared.windows.first
            toPresent.popoverPresentationController?.sourceRect = CGRect(x: 25.0, y: 25.0, width: UIScreen.main.bounds.width - 25.0, height: UIScreen.main.bounds.height - 25.0)
            toPresent.popoverPresentationController?.permittedArrowDirections = .init(rawValue: .zero)
        } else {
            toPresent.modalPresentationStyle = style
        }
        toPresent.isModalInPresentation = isModalPresent
        toPresent.view.backgroundColor = backgroundColor
        toPresent.rootView = AnyView(
            builder()
                .environment(\.viewController, toPresent)
        )
        _ = NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "dismissModal"), object: nil, queue: nil) { [weak toPresent] _ in
            toPresent?.dismiss(animated: true, completion: nil)
        }
        self.present(toPresent, animated: true, completion: {
            completion?()
        })
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
    }
    
    func present<Content: View>(style: UIModalPresentationStyle = .automatic,
                                transitionStyle: UIModalTransitionStyle = .coverVertical,
                                @ViewBuilder
                                builder: @escaping () -> Content) {
        
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.present(style: style,
                             transitionStyle: transitionStyle,
                             builder: builder)
            }
            return
        }
        
        let toPresent = UIHostingController(rootView: AnyView(EmptyView()))
        toPresent.modalPresentationStyle = style
        toPresent.modalTransitionStyle = transitionStyle
        toPresent.view.backgroundColor = .popupBackgroundColor
        toPresent.rootView = AnyView(
            builder()
                .environment(\.viewController, toPresent)
        )
        self.present(toPresent, animated: true, completion: nil)
    }
    
    func dismissRootViewController(animated: Bool = true, completion: (() -> Void)? = nil) {
        
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.dismissRootViewController(animated: animated,
                                               completion: completion)
            }
            return
        }
        
        UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: animated, completion: {
            completion?()
        })
    }
}
