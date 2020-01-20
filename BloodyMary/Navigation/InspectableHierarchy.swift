//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import UIKit

/// A protocol requiring its conformer to declare its `UIViewController` Hierarchy.
/// Any custom `UIViewController` other than `UINavigationController`, `UITabBarController`
/// containing a custom navigation should conform to this protocol.
public protocol InspectableHierarchy: AnyObject {
  /// The hierarchy of the visible stack.
  var hierarchy: [UIViewController] { get }
}

/// A protocol that only `UIViewController` should conform to in order to return the `presentedViewController` if present.
public protocol InspectablePresentedViewController: AnyObject {
  /// The next view controller in the hierarchy.
  var nextViewController: UIViewController? { get }
}

/// Conformance of `UINavigationController` to `InspectableHierarchy` protocol.
/// A UINavigation has an array of `UIViewControllers` and an optional `presentedViewController`.
extension UINavigationController: InspectableHierarchy {
 public var hierarchy: [UIViewController] {
  var controllers: [UIViewController] = self.viewControllers
   if let presentedVC = self.presentedViewController {
     controllers.append(presentedVC)
   }
   return controllers
  }
}

/// /// Conformance of `UITabBarController` to `InspectableHierarchy` protocol.
/// The`UITabBarController` consists of the `selectedViewController` and an optional  `presentedViewController`.
extension UITabBarController: InspectableHierarchy {
  public var hierarchy: [UIViewController] {
    [selectedViewController, presentedViewController].compactMap { $0 }
  }
}

/// Conformance of `UIViewController` to the `InspectablePresentedViewController` protocol.
/// The `UIViewController` can have an optional `presentedViewController`, otherwise it is the highest of the visible stack.
extension UIViewController: InspectablePresentedViewController {
  public var nextViewController: UIViewController? {
    self.presentedViewController
  }
}
