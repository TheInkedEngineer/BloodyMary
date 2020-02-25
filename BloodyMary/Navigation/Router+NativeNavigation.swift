//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import UIKit

// MARK: - Navigation Functions

internal extension Router {
  /// Shows a `UIViewController` inside the parent's `UINavigationController` if present,
  /// otherwise it creates a `UINavigationController`, sets the destination as a `rootViewController`
  /// and presents it as a full screen, unanimated over the parent view controller.
  /// - Parameters:
  ///   - destination: The view controller to display.
  ///   - navigationController: The navigation controller to push to. If the top view controller already has a navigation controller, the later's navigation controller will be leveraged. Defaults
  ///   - animated: whether or not to animate the navigation.
  func push(
    _ destination: UIViewController,
    to navigationController: UINavigationController? = nil,
    animated: Bool = true,
    completion: Router.Completion? = nil
  ) {
    let topVC = Router.topViewController()
    
    guard topVC.hasNavigationController else {
      let navVC = navigationController ?? UINavigationController()
      navVC.viewControllers = [destination]
      navVC.modalPresentationStyle = destination.modalPresentationStyle
      topVC.present(navVC, animated: animated, completion: completion)
      return
    }
    
    topVC.navigationController?.pushViewController(destination, animated: animated, completion: completion)
  }
  
  /// Presents a `UIViewController` modally.
  /// - Parameters:
  ///   - destination: The viewController to present.
  ///   - viewController: The view controller presenting.
  ///   - style: UIModalPresentationStyle to use when presenting.
  ///   - animated: whether or not to animate the presentation of the viewController. Defaults to `true`.
  ///   - completion: An optional completion to execute after presenting viewController. Defaults to `nil`.
  func present(
    _ destination: UIViewController,
    over viewController: UIViewController = Router.topViewController(),
    presentation style: UIModalPresentationStyle,
    animated: Bool = true,
    completion: Router.Completion? = nil
  ) {
    destination.modalPresentationStyle = style
    viewController.present(destination, animated: animated, completion: completion)
  }
}
