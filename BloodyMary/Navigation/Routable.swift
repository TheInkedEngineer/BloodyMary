//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import UIKit

/// The Identifier to use for a `Routable`.
public typealias ScreenIdentifier = String
/// A navigation route.
public typealias Route = [ScreenIdentifier]
/// A view controller that is routable.
public typealias RoutableViewController = Routable & UIViewController
/// Closure called when a full navigation is completed.
public typealias RoutingCompletion = () -> ()

/// A `protocol` that all navigable `ViewControllers` should adhere to.
/// The `UINavigationController` and the `UITabBarController` should **NOT** adhere to this protocol.
public protocol Routable: AnyObject {
  /// The identifier associated to the routable element.
  /// ```swift
  ///    extension ProfileViewController: Routable {
  ///
  ///      var screenIdentifier: ScreenIdentifier {
  ///        "profile"
  ///      }
  ///    }
  /// ```
  static var screenIdentifier: ScreenIdentifier { get }
  
  /// Due to limitations with generics, and the inability to leverage `Type Erasure` in this specific case,
  /// It is impossible to automatically cast an extracted `RoutableViewController` to its right type,
  /// preventing the automatic assignment of the passed viewmodel to the view controller.
  /// To work around it, `assign(model: Any) -> Bool` is introduced and should be used as follow:
  /// ```swift
  /// func assign(model: Any) -> Bool {
  ///   guard let model = model as? DemoViewModel else {
  ///     return false
  ///   }
  ///   self.viewModel = model
  ///   return true
  /// }
  ///
  @discardableResult
  func assign(model: Any) -> Bool
}
