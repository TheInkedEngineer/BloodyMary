//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import Foundation

// MARK: - Helpers
#warning("""
Checkout how to manage iOS13
'keyWindow' was deprecated in iOS 13.0:
Should not be used for applications that support multiple scenes
as it returns a key window across all connected scenes

Currently it is not a major problem, since it only supports iOS (not iPad OS)
and therefore it is limited to one screen.
""")
internal extension Router {
  /// Initializes the view controller from the passed object and assigns its view model.
  /// - Parameter object: The `RoutableObject` to configure.
  func configureVC(of object: AnyRoutableObject) -> UIViewController {
    guard let vc = self.screensAndDestinations[object.screenIdentifier]?.init() else { fatalError(RoutingError.viewControllerNotFound.message) }
    let assigningViewModelWasSuccessful = vc.assign(model: object.anyViewModel as Any)
    guard assigningViewModelWasSuccessful else { fatalError(RoutingError.failedToAssignViewModel.message) }
    return vc
  }
  
  /// Iterates over the navigation stack and returns the top view controller of the stack.
  /// Should be called `ONLY` after keywindow is set and made visible.
  /// - Parameter viewController: The root view controller from which to start iterating.
  static func topViewController(root viewController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!) -> UIViewController {
    if
      let navigationController = viewController as? UINavigationController,
      let visibleViewController = navigationController.visibleViewController {
      return Router.topViewController(root: visibleViewController)
    }
    
    if
      let tabBarController = viewController as? UITabBarController,
      let selectedVC = tabBarController.selectedViewController {
      return Router.topViewController(root: selectedVC)
    }
    
    if let presentedController = viewController.presentedViewController {
       return Router.topViewController(root: presentedController)
    }
    
    return viewController
  }
}

internal extension UIViewController {
  var hasNavigationController: Bool { self.navigationController != nil }
}

internal extension UIApplication {
  /// Checks and returns the full hierarchy of all visible UIViewControllers in the stack.
  var allViewControllers: [UIViewController] {
    
    let hierarchyComposer: () -> [UIViewController] = {
      guard let rootVC = self.keyWindow?.rootViewController else { return []}
      
      var controllersToReturn: [UIViewController] = []
      var foundVCs = [rootVC]
      
      while !foundVCs.isEmpty {
        controllersToReturn.append(contentsOf: foundVCs)
        guard let lastFoundVC = foundVCs.last else { return controllersToReturn }
        
        if let inspectableHierarchy = lastFoundVC as? InspectableHierarchy {
          foundVCs = inspectableHierarchy.hierarchy
          continue
        }
        
        if let presentedVC = lastFoundVC.nextViewController {
          foundVCs.append(presentedVC)
          continue
        }
        
        foundVCs = []
      }
      return controllersToReturn
    }
    
    if !Thread.isMainThread {
      var vcs: [UIViewController] = []
      DispatchQueue.main.sync {
        vcs = hierarchyComposer()
      }
      return vcs
    } else {
      return hierarchyComposer()
    }
  }
}
