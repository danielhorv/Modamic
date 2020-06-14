//
//  DynamicContentSizePresentationController.swift
//  DynamicContentSizePresenter
//
//  Created by Daniel Horvath on 29.03.20.
//  Copyright © 2020 Daniel Horvath. All rights reserved.
//

import UIKit

public class DynamicContentSizePresentationController: UIPresentationController {
    
    private var keyboardIsShowing: Bool = false

    private let configuration: DynamicContentSizePresenterConfiguration
    
    private let originalWidth: CGFloat
    
    private lazy var dimmingView: UIView = {
        $0.backgroundColor = configuration.dimmingViewBackgroundColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dimmViewTapped(gesture:)))
        $0.addGestureRecognizer(tap)
        return $0
    }(UIView())
    
    private var preferredWidth: CGFloat {
        switch configuration.modalWidth {
        case .parentFactor(let factor): return originalWidth * factor
        case .fixed(let fixedWidth): return fixedWidth
        }
    }
    
    // The ViewController which will presented
    private var wrappedPresentedController: UIViewController {
        if let navigationController = presentedViewController as? UINavigationController, let visibleViewController = navigationController.visibleViewController {
            return visibleViewController
        } else {
            return presentedViewController
        }
    }
    
    // Height of the navigationBar if the modalViewController is an UINavigationController
    private var navigationBarHeigt: CGFloat {
        guard let navigationController = presentedViewController as? UINavigationController else {
            return .zero
        }
        return navigationController.navigationBar.frame.height
    }
    
    private var topInset: CGFloat {
        if #available(iOS 11.0, *) {
            guard let safeAreaTopInset = UIApplication.shared.keyWindow?.safeAreaInsets.top, safeAreaTopInset > 0 else {
                return configuration.nonNotchTopSpacing
            }
            return safeAreaTopInset

        } else {
            return configuration.nonNotchTopSpacing
        }
    }
    
    private var bottomInset: CGFloat {
        if #available(iOS 11.0, *) {
            guard let safeAreaBottomInset = UIApplication.shared.keyWindow?.safeAreaInsets.bottom, safeAreaBottomInset > 0 else {
                return configuration.nonNotchBottomSpacing
            }
            
            return safeAreaBottomInset
        } else {
            return configuration.nonNotchTopSpacing
        }
    }
    
    override public var frameOfPresentedViewInContainerView: CGRect {
       guard let containerBounds = containerView?.bounds else { return .zero }
        
        // Calculate the new size for the ViewController
        let size = self.size(forChildContentContainer: wrappedPresentedController, withParentContainerSize: containerBounds.size)
        
        var presentedViewFrame = CGRect.zero
        presentedViewFrame.size = size
        presentedViewFrame.origin.x = ((containerBounds.size.width) - (presentedViewFrame.size.width)) / 2.0
        
        switch configuration.modalVerticalPosition {
        case .top:
            presentedViewFrame.origin.y = topInset
        case .center:
            presentedViewFrame.origin.y = ((containerBounds.size.height) - (presentedViewFrame.size.height)) / 2.0
        case .bottom:
            presentedViewFrame.origin.y = containerBounds.height - bottomInset - size.height
        }
        
        return presentedViewFrame
    }
        
    public init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, configuration: DynamicContentSizePresenterConfiguration) {
        self.configuration = configuration
        self.originalWidth = presentedViewController.view.frame.width
        
        // Needed because of the right UILabel height calculation
        if #available(iOS 11.0, *) {
            presentedViewController.viewRespectsSystemMinimumLayoutMargins = false
        }
        
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        if configuration.roundCorners {
            presentedViewController.view.layer.masksToBounds = true
            presentedViewController.view.layer.cornerRadius = configuration.cornerRadius
        }
        
        // For the right height calculation, need to be set the preferred modal width
        presentedViewController.view.frame.size.width = preferredWidth
        
        // Because of the autoLayouted UILabel, need to refresh the layout
        presentedViewController.view.layoutIfNeeded()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override public func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        guard containerView != nil else { return .zero }
        
        let targetSize = CGSize(width: preferredWidth, height: UIView.layoutFittingCompressedSize.height)
        
        // Calculate the new height with the preferred new width
        var calculatedSize = wrappedPresentedController.view.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
        
        // Add a NavigationBar height if needed
        calculatedSize.height += navigationBarHeigt
        
        return calculatedSize
    }
    
    override public func presentationTransitionWillBegin() {
        guard let containerView = self.containerView else { return }
        
        dimmingView.frame = containerView.bounds
        dimmingView.alpha = .zero
        
        containerView.insertSubview(dimmingView, at: .zero)
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
            self?.dimmingView.alpha = 1.0
        })
    }
    
    override public func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
            self?.dimmingView.alpha = .zero
        })
    }
    
    override public func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        // Skip for the first time
        guard containerView != nil else { return }
        
        // Resize the presentedView with the new size
        UIView.animate(withDuration: configuration.contentSizeChangedAnimationOptions.duration,
                       delay: configuration.contentSizeChangedAnimationOptions.delay,
                       usingSpringWithDamping: configuration.contentSizeChangedAnimationOptions.usingSpringWithDamping,
                       initialSpringVelocity: configuration.contentSizeChangedAnimationOptions.initialSpringVelocity, options: [.curveEaseInOut], animations: {
            self.presentedView?.frame = self.frameOfPresentedViewInContainerView
        })
    }
    
    @objc private func dimmViewTapped(gesture: UIGestureRecognizer) {
        guard configuration.autoDismissOnBackgroundTap else {
            return
        }
        
        if keyboardIsShowing && configuration.autoDismissKeyboard {
            presentedViewController.view.endEditing(true)
        }
        
        presentingViewController.dismiss(animated: true, completion: nil)
    }

    @objc private func keyboardWasShown(notification: Notification) {
        if let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let presentedFrame = frameOfPresentedViewInContainerView
            var translatedFrame = presentedFrame
            
            if keyboardFrame.origin.y < translatedFrame.origin.y + translatedFrame.size.height {
                let diff = translatedFrame.origin.y + translatedFrame.size.height - keyboardFrame.origin.y + bottomInset
                translatedFrame.origin.y -= diff
            }
     
            if translatedFrame != presentedFrame {
                UIView.animate(withDuration: configuration.showKeyboardAnimationDuration, animations: { [weak presentedView] in
                    presentedView?.frame = translatedFrame
                })
            }
            keyboardIsShowing = true
        }
    }

    @objc private func keyboardWillHide (notification: Notification) {
        if keyboardIsShowing {
            let presentedFrame = frameOfPresentedViewInContainerView
            if self.presentedView?.frame !=  presentedFrame {
                UIView.animate(withDuration: configuration.hideKeyboardAnimationDuration, animations: { [weak presentedView] in
                    presentedView?.frame = presentedFrame
                })
            }
            keyboardIsShowing = false
        }
    }
}
