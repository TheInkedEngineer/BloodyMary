//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import Foundation

private var viewControllerKey = "BMViewWithViewModel_controller_key"

/// A `BMViewWithViewControllerAndViewModel` is a `BMViewWithViewModel` view managed by a `UIViewController`.
/// This "managing" automatically calls the `configure`, `style` and `layout` phases.
/// In addition, the controller set the `viewModel` of the view, therefore invoking the update at least once before the view is actually displayed.
/// This view is extended with helpers allowing to access the UINavigationBar, UINavigationItem, UIViewController from the view when present.
public protocol BMViewWithViewControllerAndViewModel: BMViewWithViewModel {
  /// The `UIViewController` managing the view.
  var viewController: UIViewController? { get set }
}

public extension BMViewWithViewControllerAndViewModel {
  /// A shortcut to access `UINavigationController` from the view when available.
  var navigationBar: UINavigationBar? {
    self.viewController?.navigationController?.navigationBar
  }
  
  /// A shortcut to access `UINavigationItem` from the view when available.
  var navigationItem: UINavigationItem? {
    self.viewController?.navigationItem
  }
  
  /// Syntactic sugar to access the `UIViewController` managing this UIView.
  var viewController: UIViewController? {
    get {
      return objc_getAssociatedObject(self, &viewControllerKey) as? UIViewController
    }
    
    set {
      objc_setAssociatedObject(
        self,
        &viewControllerKey,
        newValue,
        .OBJC_ASSOCIATION_ASSIGN
      )
    }
  }
}

// Original Code: https://github.com/BendingSpoons/tempura-swift/blob/master/Tempura/Core/ViewControllerModellableView.swift
/// Implementation of iOS 11 safeAreaInsets accessible even to older iOS versions.
/// see also https://developer.apple.com/documentation/uikit/uiview/positioning_content_relative_to_the_safe_area
public extension UIView {
  /// Implementation of safeAreaInsets in order to be accessible even to older iOS versions.
  var universalSafeAreaInsets: UIEdgeInsets {
    if #available(iOS 11.0, *) {
      return self.safeAreaInsets
    } else {
      return self.legacyIOSSafeAreaInsets
    }
  }
  
  private var legacyIOSSafeAreaInsets: UIEdgeInsets {
    let vc = Router.topViewController()
    let rootView: UIView! = vc.view
    var top = vc.topLayoutGuide.length
    var bottom = vc.bottomLayoutGuide.length
    // the safe area expressed in rootView coordinates
    let rootViewSafeAreaFrame = CGRect(x: 0, y: top, width: rootView.bounds.width, height: rootView.bounds.height - top - bottom)
    // convert the rootViewSafeAreaFrame in self coordinates
    let convertedFrame = rootView.convert(rootViewSafeAreaFrame, to: self)
    // find the portion of safe area that intersects with self.bounds
    let intersectionFrame = self.bounds.intersection(convertedFrame)
    top = intersectionFrame.minY
    bottom = self.bounds.maxY - intersectionFrame.maxY
    
    return UIEdgeInsets(
      top: top,
      left: 0,
      bottom: bottom,
      right: 0
    )
  }
}
