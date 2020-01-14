//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import UIKit
import XCTest

@testable import BloodyMary
@testable import BloodyMaryDemo

class RouterUnitTests: XCTestCase {
  
  enum Screen: ScreenIdentifier {
    case first
    case second
    case third
    case fourth
  }

  // MARK: First VC
  
  struct FirstViewModel: BMViewModel {}
  class FirstView: UIView, BMViewWithViewControllerAndViewModel {
    func configure() {}
    func style() {}
    func update(oldViewModel: FirstViewModel?) {}
    func layout() {}
  }
  class FirstRoutableVC: BMViewController<FirstView>, Routable {
    func assign(model: Any) -> Bool {
      guard let model = model as? FirstViewModel else {
        return false
      }
      self.viewModel = model
      return true
    }
    static var screenIdentifier: ScreenIdentifier { Screen.first.rawValue }
    override func viewDidLoad() {
      super.viewDidLoad()
      self.view.backgroundColor = .white
    }
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
    func assign(model: Any) -> Bool {
      guard let model = model as? SecondViewModel else {
        return false
      }
      self.viewModel = model
      return true
    }
    static var screenIdentifier: ScreenIdentifier { Screen.second.rawValue }
    override func viewDidLoad() {
      super.viewDidLoad()
      self.view.backgroundColor = .red
    }
  }
  
  // MARK: Third VC
  
  struct ThirdViewModel: BMViewModel {}
  class ThirdView: UIView, BMViewWithViewControllerAndViewModel {
    func configure() {}
    func style() {}
    func update(oldViewModel: ThirdViewModel?) {}
    func layout() {}
  }
  class ThirdRoutableVC: BMViewController<ThirdView>, Routable {
    func assign(model: Any) -> Bool {
      guard let model = model as? ThirdViewModel else {
        return false
      }
      self.viewModel = model
      return true
    }
    static var screenIdentifier: ScreenIdentifier { Screen.third.rawValue }
    override func viewDidLoad() {
      super.viewDidLoad()
      self.view.backgroundColor = .green
    }
  }
  
  // MARK: Fourth VC
  
  struct FourthViewModel: BMViewModel {}
  class FourthView: UIView, BMViewWithViewControllerAndViewModel {
    func configure() {}
    func style() {}
    func update(oldViewModel: FourthViewModel?) {}
    func layout() {}
  }
  class FourthRoutableVC: BMViewController<FourthView>, Routable {
    func assign(model: Any) -> Bool {
      guard let model = model as? FourthViewModel else {
        return false
      }
      self.viewModel = model
      return true
    }
    static var screenIdentifier: ScreenIdentifier { Screen.fourth.rawValue }
    override func viewDidLoad() {
      super.viewDidLoad()
      self.view.backgroundColor = .blue
    }
  }
  
  // MARK: Configuration
  
  struct ConfigProvider: RoutingConfigurationProvider {
    var screensAndDestinations: [ScreenIdentifier : RoutableViewController.Type] {
      [
        "first" : FirstRoutableVC.self,
        "second": SecondRoutableVC.self,
        "third" : ThirdRoutableVC.self,
        "fourth": FourthRoutableVC.self
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
             This test is not working since it is not being executed on the main thread. Forcing the main thread to blocking the execution.
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
  
  func testNavigationControllerBaseHierarchy() {
    let firstVC =  FirstRoutableVC()
    firstVC.viewModel = FirstViewModel()
    
    let secondRoubtaleObject = RoutableObject(screenIdentifier: Screen.second.rawValue, viewModel: SecondViewModel(), navigationStyle: .default, animated: false)
    let thirdRoubtaleObject = RoutableObject(screenIdentifier: Screen.third.rawValue, viewModel: ThirdViewModel(), navigationStyle: .default, animated: false)
    let fourthRoubtaleObject = RoutableObject(screenIdentifier: Screen.fourth.rawValue, viewModel: FourthViewModel(), navigationStyle: .default, animated: false)
    
    let expectation = self.expectation(description: "Finish Navigation")
    let nav = UINavigationController(rootViewController: firstVC)
    
    UIApplication.shared.keyWindow?.rootViewController = nav
    
    self.dependencyManager.router.show(
      routableElements: [secondRoubtaleObject, thirdRoubtaleObject, fourthRoubtaleObject],
      completion: {expectation.fulfill()}
    )
    
    waitForExpectations(timeout: 20, handler: nil)
    
    let fullStackVC = (UIApplication.shared.keyWindow?.rootViewController as! UINavigationController).viewControllers
    
    XCTAssertEqual(nav.hierarchy, fullStackVC)
  }
  
  func testNavigationControllerWithPresentedVC() {
    let firstVC =  FirstRoutableVC()
    firstVC.viewModel = FirstViewModel()
    
    let secondRoubtaleObject = RoutableObject(screenIdentifier: Screen.second.rawValue, viewModel: SecondViewModel(), navigationStyle: .default, animated: false)
    let thirdRoubtaleObject = RoutableObject(screenIdentifier: Screen.third.rawValue, viewModel: ThirdViewModel(), navigationStyle: .default, animated: false)
    let fourthRoubtaleObject = RoutableObject(screenIdentifier: Screen.fourth.rawValue, viewModel: FourthViewModel(), navigationStyle: .modal(), animated: false)
    
    let expectation = self.expectation(description: "Finish Navigation")
    let nav = UINavigationController(rootViewController: firstVC)
    
    UIApplication.shared.keyWindow?.rootViewController = nav
    
    self.dependencyManager.router.show(
      routableElements: [secondRoubtaleObject, thirdRoubtaleObject, fourthRoubtaleObject],
      completion: {expectation.fulfill()}
    )
    
    waitForExpectations(timeout: 20, handler: nil)
    
    let fullStackVC = (UIApplication.shared.keyWindow?.rootViewController as! UINavigationController).viewControllers
      + [UIApplication.shared.keyWindow!.rootViewController!.presentedViewController!]
    
    XCTAssertEqual(nav.hierarchy, fullStackVC)
  }
}
