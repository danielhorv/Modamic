//
//  TopAnimatedTransitioning.swift
//  Modamic
//
//  Created by Daniel Horvath on 14.06.20.
//  Copyright © 2020 Daniel Horvath. All rights reserved.
//

import UIKit

class TopAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting: Bool = false
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.33
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresenting ? animatePresentTransition(using: transitionContext) : animateDismissTransition(using: transitionContext)
    }
    
    func animateDismissTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) else {
            fatalError("fromViewController not found")
        }
        
        guard let fromView = fromViewController.view else {
            fatalError("fromView not found")
        }
        
        let toView = fromViewController.view

        let initialFrame = transitionContext.initialFrame(for: fromViewController)
        var finalFrame = initialFrame
        finalFrame.origin.y = -fromView.bounds.height
        
        toView?.frame = initialFrame
        
        UIView.animate(withDuration: 0.2, animations: {
            toView?.frame = finalFrame
        }, completion: { isFinished in
            guard isFinished else { return }
            toView?.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }
    
    func animatePresentTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to) else {
                fatalError("fromViewController or toViewController not found")
        }
        
        let fromView: UIView = fromViewController.view
        let toView: UIView = toViewController.view
        let animatingView = toViewController.view
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        
        var initialFrame = finalFrame
        
        initialFrame.origin.y = -fromView.bounds.height
        
        animatingView?.frame = initialFrame
        
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
                            animatingView?.frame = finalFrame
                       },
                       completion: { finished in
                            guard finished else { return }
                            transitionContext.completeTransition(true)
                        })
    }
}
