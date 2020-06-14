//
//  DynamicContentSizePresenter.swift
//  DynamicContentSizePresenter
//
//  Created by Daniel Horvath on 29.03.20.
//  Copyright © 2020 Daniel Horvath. All rights reserved.
//

import UIKit

public class DynamicContentSizePresenter: NSObject, UIViewControllerTransitioningDelegate {
    
    public let configuration: DynamicContentSizePresenterConfiguration
        
    public init(configuration: DynamicContentSizePresenterConfiguration = DynamicContentSizePresenterConfiguration()) {
        self.configuration = configuration
        super.init()
    }
}

public extension DynamicContentSizePresenter {
    
    func presentModal(viewController: UIViewController, on presenterViewController: UIViewController?, completion: (() -> Void)?) {
        viewController.transitioningDelegate = self
        viewController.modalPresentationStyle = .custom
        presenterViewController?.present(viewController, animated: true, completion: completion)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DynamicContentSizePresentationController(presentedViewController: presented, presenting: presenting, configuration: configuration)
     }
}
