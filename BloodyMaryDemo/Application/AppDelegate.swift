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
    guard let window = self.window else {
      return false
    }
    
    let whiteVC = WhiteViewController()
    let whiteVM = WhiteViewModel(screenToNavigateTo: .red)
    let navVC = UINavigationController(rootViewController: whiteVC)
    whiteVC.viewModel = whiteVM
    navVC.tabBarItem = UITabBarItem(title: "white", image: nil, selectedImage: nil)
    
    let greenVC = GreenViewController()
    let greenVM = GreenViewModel()
    greenVC.viewModel = greenVM
    greenVC.tabBarItem = UITabBarItem(title: "green", image: nil, selectedImage: nil)
    
    let yellowVC = YellowViewController()
    let yellowVM = YellowViewModel()
    yellowVC.viewModel = yellowVM
    yellowVC.tabBarItem = UITabBarItem(title: "yellow", image: nil, selectedImage: nil)
    
    let redVC = RedViewController()
    let redVM = RedViewModel()
    redVC.viewModel = redVM
    redVC.tabBarItem = UITabBarItem(title: "red", image: nil, selectedImage: nil)
    
    let tabBarConroller = UITabBarController()
    tabBarConroller.setViewControllers([navVC, greenVC, yellowVC, redVC],animated: true)
    
    DependenciesContainer.shared.router.installRoot(using: tabBarConroller, in: window)

    return true
  }
}
