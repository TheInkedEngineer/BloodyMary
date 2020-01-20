//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import UIKit

/// The `Router` is the main point  that manages showing and hiding views.
/// When instantiated it requires a configuration that provides it with the various routes and destinations.
public struct Router {
  
  // MARK: - Properties
  
  /// Possibile errors while performing the routing operations.
  public enum RoutingError {
    /// ViewController missing from `screensAndDestinations`.
    case viewControllerNotFound
    /// Failed to properly cast the viewmodel.
    case failedToAssignViewModel
    
    /// The message to display associated to the error.
    var message: String {
      switch self {
      case .viewControllerNotFound:
        return "Identifier is not associated to a RoutableViewController. Update your `screensAndDestinations`."
        
      case .failedToAssignViewModel:
        return "Could not assign the viewModel properly to your vc."
      }
    }
  }
  
  /// The queue on which all navigation is done.
  private let routingQueue = DispatchQueue(label: "routing queue")
  
  /// The dictionary containing the routes and their destination view controllers.
  private let screensAndDestinations: [ScreenIdentifier: RoutableViewController.Type]
  
  /// Initiates a `Router` and returns it with the proper configuration.
  public init(with configuration: RoutingConfigurationProvider) {
    self.screensAndDestinations = configuration.screensAndDestinations
  }
  
  // MARK: - Public Methods
  
  /// Sets a new `rootViewController` for the `UIWindow`.
  /// - Parameters:
  ///   - routable: The routable object to install as root.
  ///   - window: The window in which to install the root.
  public func installRoot(using controller: UIViewController, in window: UIWindow) {
    window.rootViewController = controller
    window.makeKeyAndVisible()
  }
  
  /// Shows the routable elements in the same order they are passed in a synchronous way.
  /// - Parameters:
  ///   - routableElements: The screens to display with their configuration.
  ///   - completion: An optional completion to execute after presenting all elements. Defaults to nil.
  public func show(
    routableElements: [AnyRoutableObject],
    completion: RoutingCompletion? = nil
  ) {
    if routableElements.isEmpty {
      return
    }
    
    let navigationGroup = DispatchGroup()
    let semaphore = DispatchSemaphore(value: 1)
    
    for element in routableElements {
      navigationGroup.enter()
      let vc = configureVC(of: element)
      
      self.routingQueue.async {
        semaphore.wait()
        DispatchQueue.main.async {
          switch element.navigationStyle {
          case .stack(let navigationController, let presentationStyle):
            navigationController?.modalPresentationStyle = presentationStyle
            self.push(
              vc,
              to: navigationController,
              animated: element.animated,
              completion: {
                navigationGroup.leave();
                semaphore.signal()
            })
            
          case .modal(style: let style):
            self.present(
              vc,
              presentation: style,
              animated: element.animated,
              completion: {
                navigationGroup.leave();
                semaphore.signal()
            })
          }
        }
      }
    }
    
    navigationGroup.notify(queue: DispatchQueue.main) {
      completion?()
    }
  }
  
  /// Hides the top most view controller.
  /// - Parameters:
  ///   - animated: hiding is animated or not. Defaults to `true`.
  ///   - completion: completion to execute after hiding is completed. Defaults to `nil`
  public func hide(animated: Bool = true, completion: RoutingCompletion? = nil) {
    self.routingQueue.async {
      DispatchQueue.main.async {
        let topViewController = Router.topViewController()
        guard let stackViewControllers = topViewController.navigationController?.viewControllers, stackViewControllers.count > 1 else {
          topViewController.dismiss(animated: animated, completion: completion)
          return
        }
        topViewController.navigationController?.popViewController(animated: animated, completion: completion)
      }
    }
  }
}

// MARK: - Navigation Functions

private extension Router {
  /// Shows a `UIViewController` inside the parent's `UINavigationController` if present,
  /// otherwise it creates a `UINavigationController`, sets the destination as a `rootViewController`
  /// and presents it as a full screen, unanimated over the parent view controller.
  /// - Parameters:
  ///   - destination: The view controller to display.
  ///   - navigationController: The navigation controller to push to. If the top view controller already has a navigation controller, the later's navigation controller will be leveraged. Defaults
  ///   - animated: whether or not to animate the navigation.
  private func push(
    _ destination: UIViewController,
    to navigationController: UINavigationController? = nil,
    animated: Bool = true,
    completion: (() -> Void)? = nil
  ) {
    let topVC = Router.topViewController()
    
    guard topVC.hasNavigationController else {
      let navVC = navigationController ?? UINavigationController()
      navVC.viewControllers = [destination]
      navVC.modalPresentationStyle = destination.modalPresentationStyle
      topVC.present(navVC, animated: animated, completion: completion)
      return
    }
    
    topVC.navigationController?.pushViewController(destination, animated: animated, completion: completion)
  }
  
  /// Presents a `UIViewController` modally.
  /// - Parameters:
  ///   - destination: The viewController to present.
  ///   - viewController: The view controller presenting.
  ///   - style: UIModalPresentationStyle to use when presenting.
  ///   - animated: whether or not to animate the presentation of the viewController. Defaults to `true`.
  ///   - completion: An optional completion to execute after presenting viewController. Defaults to `nil`.
  private func present(
    _ destination: UIViewController,
    over viewController: UIViewController = Router.topViewController(),
    presentation style: UIModalPresentationStyle,
    animated: Bool = true,
    completion: (() -> Void)? = nil
  ) {
    destination.modalPresentationStyle = style
    viewController.present(destination, animated: animated, completion: completion)
  }
  
  /// Initializes the view controller from the passed object and assigns its view model.
  /// - Parameter object: The `RoutableObject` to configure.
  private func configureVC(of object: AnyRoutableObject) -> UIViewController {
    guard let vc = self.screensAndDestinations[object.screenIdentifier]?.init() else {
      fatalError(RoutingError.viewControllerNotFound.message)
    }
    
    let assigningViewModelWasSuccessful = vc.assign(model: object.anyViewModel as Any)
    guard assigningViewModelWasSuccessful else {
      fatalError(RoutingError.failedToAssignViewModel.message)
    }
    
    return vc
  }
}

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
  /// Iterates over the navigation stack and returns the top view controller of the stack.
  /// Should be called `ONLY` after keywindow is set and made visible.
  /// - Parameter viewController: The root view controller from which to start iterating.
  static func topViewController(
    root viewController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
  ) -> UIViewController {
    
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

private extension UIViewController {
  var hasNavigationController: Bool {
    self.navigationController != nil
  }
}

private extension UIApplication {
  /// Checks and returns the full hierarchy of all visible UIViewControllers in the stack.
  var allViewControllers: [UIViewController] {
    
    let hierarchyComposer: () -> [UIViewController] = {
      guard let rootVC = self.keyWindow?.rootViewController else {
        return []
      }
      
      var controllersToReturn: [UIViewController] = []
      var foundVCs = [rootVC]
      
      while !foundVCs.isEmpty {
        controllersToReturn.append(contentsOf: foundVCs)
        guard let lastFoundVC = foundVCs.last else {
          return controllersToReturn
        }
        
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
