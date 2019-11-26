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
