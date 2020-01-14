//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import UIKit
import XCTest

@testable import BloodyMary

class RouterUnitTests: XCTestCase {
  
  // MARK: First VC
  
  struct FirstViewModel: BMViewModel {}
  class FirstView: UIView, BMViewWithViewControllerAndViewModel {
    func configure() {}
    func style() {}
    func update(oldViewModel: FirstViewModel?) {}
    func layout() {}
  }
  class FirstRoutableVC: BMViewController<FirstView>, Routable {
    static var screenIdentifier: ScreenIdentifier { "first" }
  }
  
  // MARK: Second VC
  
  struct SecondViewModel: BMViewModel {}
  class SecondView: UIView, BMViewWithViewControllerAndViewModel {
    func configure() {}
    func style() {}
    func update(oldViewModel: SecondViewModel?) {}
    func layout() {}
  }
  class SecondRoutableVC: BMViewController<SecondView>, Routable {
    static var screenIdentifier: ScreenIdentifier { "second" }
  }
  
  // MARK: Configuration
  
  struct ConfigProvider: RoutingConfigurationProvider {
    var screensAndDestinations: [ScreenIdentifier : RoutableViewController.Type] {
      [
        "first" : FirstRoutableVC.self,
        "second": SecondRoutableVC.self
      ]
    }
  }
  
  struct  DependencyManager {
    static var shared = DependencyManager()
    var router: Router = {
      Router(with: ConfigProvider())
    }()
  }
  
  var dependencyManager: DependencyManager!
  var window: UIWindow!
  
  override func setUp() {
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.dependencyManager = DependencyManager()
  }
  
  func testRouterStartFailsForMissingVC() {
    expectFatalError (message: Router.RoutingError.viewControllerNotFound.message) {
      self.dependencyManager.router.start(routable: RoutableObject(
        screenIdentifier: "First",
        viewModel: FirstViewModel(),
        navigationStyle: .default,
        animated: false
      ), in: self.window)
    }
  }
  
  func testRouterStartFailsForWrongVM() {
    #warning("""
             This test is not working since it is not being executed on the main thread. Forcing the main thread is blocking the execution.
             Needs further investigaton for the custom function `expectFatalError`.
             """)
//    expectFatalError (message: Router.RoutingError.failedToAssignViewModel.message) {
//      self.dependencyManager.router.start(routable: RoutableObject(
//        screenIdentifier: "first",
//        viewModel: SecondViewModel(),
//        navigationStyle: .default,
//        animated: false
//      ), in: self.window)
//    }
  }
}
