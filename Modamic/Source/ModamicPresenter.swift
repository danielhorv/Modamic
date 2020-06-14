//
//  DynamicContentSizePresenter.swift
//  DynamicContentSizePresenter
//
//  Created by Daniel Horvath on 29.03.20.
//  Copyright © 2020 Daniel Horvath. All rights reserved.
//

import UIKit

public class ModamicPresenter: NSObject, UIViewControllerTransitioningDelegate {
    
    public let configuration: DynamicContentSizePresenterConfiguration
        
    public init(configuration: DynamicContentSizePresenterConfiguration = DynamicContentSizePresenterConfiguration()) {
        self.configuration = configuration
        super.init()
    }
}

public extension ModamicPresenter {
    
    func presentModal(viewController: UIViewController, on presenterViewController: UIViewController?, completion: (() -> Void)?) {
        viewController.transitioningDelegate = self
        viewController.modalPresentationStyle = .custom
        presenterViewController?.present(viewController, animated: true, completion: completion)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DynamicContentSizePresentationController(presentedViewController: presented, presenting: presenting, configuration: configuration)
     }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch configuration.animatedTransition {
        case .bottom:
            return nil
            
        case .top:
            return TopAnimatedTransitioning(isPresenting: true)
            
        case .custom(forPresented: let presentedAnimatedTransitioning, forDismissed: _):
            return presentedAnimatedTransitioning
        }
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch configuration.animatedTransition {
        case .bottom:
            return nil
            
        case .top:
            return TopAnimatedTransitioning(isPresenting: false)
            
        case .custom(forPresented: _, forDismissed: let dismissedAnimatedTransitioning):
            return dismissedAnimatedTransitioning
        }
    }
}
