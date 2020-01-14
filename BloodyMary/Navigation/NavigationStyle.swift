//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import UIKit

/// List of supported navigation styles.
public enum NavigationStyle {
  /// Presents the view controller as a stack. If no `UINavigationController` is present, it creates one,
  /// sets the view controller as rootViewController of that navigation controller and presents it as a `.fullScreen` over the stack.
  /// An optional custom `UINavigationController` can be passed. However if a `UINavigationController` is already present
  /// on the top most view controller in the hierarchy, the value passed is discarded.
  case stack(_ navigationController: UINavigationController? = nil)
  /// Presents the view controller in a modal way. `UIModalPresentationStyle` defaults to `.overCurrentContext`.
  case modal(style: UIModalPresentationStyle = .overCurrentContext)
  /// lets the system choose what is the best way to go about presenting the view controller.
  /// If a navigation bar is present, it is pushed on the stack, otherwise presented as a modal.
  case `default`
}
