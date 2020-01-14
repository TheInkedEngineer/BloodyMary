//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import UIKit
import BloodyMary

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    self.window = self.window ?? UIWindow(frame: UIScreen.main.bounds)
    DependenciesContainer.shared.router.start(
      routable: RoutableObject(
        screenIdentifier: WhiteViewController.screenIdentifier,
        viewModel: WhiteViewModel(screenToNavigateTo: .red),
        navigationStyle: .stack(),
        animated: true
      ),
      in: self.window!)

    return true
  }
}
