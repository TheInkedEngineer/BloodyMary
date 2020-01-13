//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import Foundation

/// A configuration provider for the `Router` that the dependencies manager in the app should conform to.
/// It requires the conformer to provide the screens and their respective view controller.
public protocol RoutingConfigurationProvider {
  var screensAndDestinations: [ScreenIdentifier: RoutableViewController.Type] { get }
}
