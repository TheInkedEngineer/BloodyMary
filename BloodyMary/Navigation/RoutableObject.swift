//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import Foundation

/// `TypeErasure` for `RoutableObject<VM: BMViewModel>`
public protocol AnyRoutableObject {
  var screenIdentifier: ScreenIdentifier { get }
  var anyViewModel: BMViewModel { get }
  var navigationStyle: NavigationStyle { get }
  var animated: Bool { get }
}

/// A Routable object is an element to be passed to the router for the latter to display.
public struct RoutableObject<VM: BMViewModel>: AnyRoutableObject {
  public let screenIdentifier: ScreenIdentifier
  public let viewModel: VM
  public let navigationStyle: NavigationStyle
  public let animated: Bool
  
  public init(
    screenIdentifier: ScreenIdentifier,
    viewModel: VM,
    navigationStyle: NavigationStyle,
    animated: Bool
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
