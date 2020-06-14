//
//  DynamicContentSizePresenterConfiguration.swift
//  DynamicContentSizePresenter
//
//  Created by Daniel Horvath on 29.03.20.
//  Copyright © 2020 Daniel Horvath. All rights reserved.
//

import UIKit

public class DynamicContentSizePresenterConfiguration {
    
    public enum ModalVerticalPosition {
        case top
        case center
        case bottom
    }
    
    public typealias AnimationSettings = (duration: TimeInterval, delay: TimeInterval, usingSpringWithDamping: CGFloat, initialSpringVelocity: CGFloat)
    
    /// Should the presented controller have rounded corners.
    public var roundCorners: Bool = true
    
    /// Radius of rounded corners for presented controller if roundCorners is true.
    public var cornerRadius: CGFloat = 10
    
    /// Multiplier for the original width size
    /// 1.0 is the same width as the parentViewController
    public var widthFactor: CGFloat = 0.9
    
    /// Keyboard showing animation duration
    public var showKeyboardAnimationDuration: TimeInterval = 0.5
    
    /// Keyboard hiding animation duration
    public var hideKeyboardAnimationDuration: TimeInterval = 0.5
    
    /// Non notch device bottom spacing
    public var nonNotchBottomSpacing: CGFloat = 20
    
    /// Non notch device top spacing
    public var nonNotchTopSpacing: CGFloat = 20
    
    /// Automatically dismiss keyboard if the viewController dismissed
    public var autoDismissKeyboard: Bool = true
    
    /// Background color of the dimmed backgroundView
    public var dimmingViewBackgroundColor = UIColor(white: 0, alpha: 0.4)
    
    /// Cutomize the animation of the contentSize resizing
    public var contentSizeChangedAnimationOptions: AnimationSettings = (duration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 15)

    /// Tap on the backgroundView automatically dismiss the ViewController
    public var autoDismissOnBackgroundTap: Bool = true
    
    /// Vertical position of the viewController
    public var modalVerticalPosition: ModalVerticalPosition = .bottom
    
    public init() { }
}
