//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import UIKit

/// List of supported navigation styles.
public enum NavigationStyle {
  /// push to `UINavigationController`. Creates one if no already present.
  case stack
  /// presents the view controller in a modal way. `UIModalPresentationStyle` defaults to `.overCurrentContext`.
  case modal(style: UIModalPresentationStyle = .overCurrentContext)
  /// lets the system choose what is the best way to go about presenting the view controller.
  /// If a navigation bar is present, it is pushed on the stack, otherwise presented as a modal.
  case `default`
}
