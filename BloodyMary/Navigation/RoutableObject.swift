//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import Foundation

/// `TypeErasure` for `RoutableObject<VM: BMViewModel>`
public protocol AnyRoutableObject {
  /// The unique identifier associated with the ViewController to load.
  var screenIdentifier: ScreenIdentifier { get }
  /// The view model to pass to the view controller once created.
  var anyViewModel: BMViewModel { get }
  /// The navigation style in which to present the view controller.
  var navigationStyle: NavigationStyle { get }
  /// Whether or not to animate the object when presenting it.
  var animated: Bool { get }
}

/// A Routable object is an element to be passed to the router for the latter to display.
public struct RoutableObject<VM: BMViewModel>: AnyRoutableObject {
  /// The unique identifier associated with the ViewController to load.
  public let screenIdentifier: ScreenIdentifier
  /// The view model to pass to the view controller once created.
  public let viewModel: VM
  /// The navigation style in which to present the view controller.
  public let navigationStyle: NavigationStyle
  /// Whether or not to animate the object when presenting it.
  public let animated: Bool
  
  /// Creates and returns and instance of
  public init(
    screenIdentifier: ScreenIdentifier,
    viewModel: VM,
    navigationStyle: NavigationStyle,
    animated: Bool = true
  ) {
    self.screenIdentifier = screenIdentifier
    self.viewModel = viewModel
    self.navigationStyle = navigationStyle
    self.animated = animated
  }
}

/// `TypeErasure` for `RoutableObject`'s view model.
public extension RoutableObject {
  var anyViewModel: BMViewModel {
    self.viewModel
  }
}
