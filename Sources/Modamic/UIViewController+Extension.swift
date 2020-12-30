//
//  UIViewController+Extension.swift
//  ModamicPresenter
//
//  Created by Daniel Horvath on 29.03.20.
//  Copyright © 2020 Daniel Horvath. All rights reserved.
//

import UIKit

public extension UIViewController {
    /// Recalculate the height and resize with animation
    func setPreferredContentSizeFromAutolayout() {
         let contentSize = view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        if let navigationController = navigationController {
            navigationController.preferredContentSize = contentSize
            navigationController.popoverPresentationController?.presentedViewController.preferredContentSize = contentSize
        } else {
            preferredContentSize = contentSize
            popoverPresentationController?.presentedViewController.preferredContentSize = contentSize
        }
    }
}
