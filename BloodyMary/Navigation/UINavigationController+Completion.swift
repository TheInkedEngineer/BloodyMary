//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import Foundation

extension UINavigationController {
  
  /// Pushes a view controller onto the receiver’s stack, updates the display then executes a completion.
  /// - Parameters:
  ///   - viewController: The view controller to push onto the stack. This object cannot be a tab bar controller. If the view controller is already on the navigation stack, this method throws an exception.
  ///   - animated: Specify true to animate the transition or false if you do not want the transition to be animated. You might specify false if you are setting up the navigation controller at launch time.
  ///   - completion: The completion to execute once the view controller is pushed to the stack.
  public func pushViewController( _ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
    
    guard animated, let coordinator = self.transitionCoordinator else {
      self.pushViewController(viewController, animated: false)
      DispatchQueue.main.async { completion?() }
      return
    }
    
    self.pushViewController(viewController, animated: true)
    coordinator.animate(alongsideTransition: nil) { _ in completion?() }
  }
  
  /// Pops the top view controller from the navigation stack and updates the display.
  /// - Parameters:
  ///   - animated: Set this value to true to animate the transition. Pass false if you are setting up a navigation controller before its view is displayed.
  ///   - completion: The completion to execute once the view controller is poped.
  func popViewController( animated: Bool, completion: (() -> Void)?) {

    guard animated, let coordinator = self.transitionCoordinator else {
      self.popViewController(animated: false)
      DispatchQueue.main.async { completion?() }
      return
    }
    
    self.popViewController(animated: true)
    coordinator.animate(alongsideTransition: nil) { _ in completion?() }
  }
}
