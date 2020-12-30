<img src="https://raw.githubusercontent.com/danielhorv/Modamic/master/logo.png" width="60%" alt="Modamic"/>

[![xcodebuild](https://github.com/danielhorv/Modamic/workflows/xcodebuild/badge.svg)](https://github.com/danielhorv/Modamic/actions?query=workflow%3Axcodebuild)

Lightweight library for presenting UIViewController in Modal.

⚠️ the library is WIP, if you find a bug, please create an issue or pull request

## Preview
<p float="left">
<img src="https://raw.githubusercontent.com/danielhorv/Modamic/master/preview_bottom.gif" width="25%" alt="Preview"/>
<img src="https://raw.githubusercontent.com/danielhorv/Modamic/master/preview_center.gif" width="25%" alt="Preview"/>
<img src="https://raw.githubusercontent.com/danielhorv/Modamic/master/preview_top.gif" width="25%" alt="Preview"/>
</p>

## Features 🎉
- automatic keyboard handling
- runtime animated resizing
- customizable configuration
- vertical positions
- custom AnimatedTransitioning
- UINavigationController support
- coordination pattern support

## Usage

### Available vertical positions
 - top
 - center
 - bottom
 
### Configuration
There is a default ModemicConfiguration, but you can also create a custom configuration.
The list of the available properties

```swift
    /// The presented controller have rounded corners.
    public var roundCorners: Bool = true
    
    /// Radius of rounded corners for presented controller if roundCorners is true.
    public var cornerRadius: CGFloat = 10
    
    /// Keyboard shows animation duration
    public var showKeyboardAnimationDuration: TimeInterval = 0.5
    
    /// Keyboard hiding animation duration
    public var hideKeyboardAnimationDuration: TimeInterval = 0.5
    
    /// Non notch device bottom spacing
    public var nonNotchBottomSpacing: CGFloat = 20
    
    /// Non notch device top spacing
    public var nonNotchTopSpacing: CGFloat = 20
    
    /// Automatically dismisses keyboard if the viewController is dismissed
    public var autoDismissKeyboard: Bool = true
    
    /// Background color of the dimmed backgroundView
    public var dimmingViewBackgroundColor = UIColor(white: 0, alpha: 0.4)
    
    /// Cutomize the animation of the contentSize resizing
    public var contentSizeChangedAnimationOptions: AnimationSettings = (duration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 15)

    /// Tap on the backgroundView automatically dismisses the ViewController
    public var autoDismissOnBackgroundTap: Bool = true
    
    /// Vertical position of the viewController
    public var modalVerticalPosition: ModalVerticalPosition = .bottom
    
    /// Width of the modal viewController
    public var modalWidth: ModalWidth = .parentFactor(0.9)
    
    /// Animated transition for the modal
    public var animatedTransition: AnimatedTransition = .bottom
````

### Runtime resizing
The library supports AutoLayout, so if you add/remove some view or change the height of a subview, you just need to call the `setPreferredContentSizeFromAutolayout()` method of the UIViewController.
This will recalculate the height and animate the resized modal - check the example project.

### Width
There are 2 ways to define the width of the modal
 - dynamic: use a factor to scale the width of the parent ViewController
 - fixed: set a fixed width for the modal

### Animation Transition
You can use the default (bottom push) and also a top animation to present your modal.
But there is also a `custom(forPresented: UIViewControllerAnimatedTransitioning, forDismissed: UIViewControllerAnimatedTransitioning)` case to use your custom Animation.

## Example
```swift
    let modamicConfig = ModamicConfiguration()
    modamicConfig.autoDismissKeyboard = false
    modamicConfig.modalVerticalPosition = .center

    let presenter = ModamicPresenter(configuration: modamicConfig)
    presenter.presentModal(viewController: updateViewController, on: self, completion: nil)
````

## TODOs
- scrollView if the content is bigger than the screen
- rotation handling

## Installation

**CocoaPods:**

```
pod "Modamic"
```

**Swift Package Manager:**

```
git@github.com:danielhorv/Modamic.git
```

## Requirements
- Swift 5
- iOS 9
