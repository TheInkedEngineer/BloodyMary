//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import BloodyMary

struct DependenciesContainer: RoutingConfigurationProvider {
  // prevent it from being instantiated.
  private init() {}
  
  static var shared = DependenciesContainer()
  
  var screensAndDestinations: [ScreenIdentifier : RoutableViewController.Type] {
    [
      Screen.green.rawValue: GreenViewController.self,
      Screen.red.rawValue: RedViewController.self,
      Screen.white.rawValue: WhiteViewController.self,
      Screen.yellow.rawValue: YellowViewController.self
    ]
  }
  
  lazy var router: Router = Router(with: self)
}
