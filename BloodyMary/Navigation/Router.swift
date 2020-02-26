//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import UIKit

/// The `Router` is the main point  that manages showing and hiding views.
/// When instantiated it requires a configuration that provides it with the various routes and destinations.
public struct Router {
  
  /// A routing completion typealias..
  public typealias Completion = () -> Void
  
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
  internal let routingQueue = DispatchQueue(label: "routing queue")
  
  /// The dictionary containing the routes and their destination view controllers.
  internal let screensAndDestinations: [ScreenIdentifier: RoutableViewController.Type]
  /// The semaphore used to synchronise the various show and hide.
  internal let semaphore = DispatchSemaphore(value: 1)
  
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
    if routableElements.isEmpty { return }
    
    let navigationGroup = DispatchGroup()
    
    for element in routableElements {
      navigationGroup.enter()
      let vc = configureVC(of: element)
      
      self.routingQueue.async {
        self.semaphore.wait()
        DispatchQueue.main.async {
          switch element.navigationStyle {
          case .stack(let presentationStyle, let navigationController):
            navigationController?.modalPresentationStyle = presentationStyle
            self.push(
              vc,
              to: navigationController,
              animated: element.animated,
              completion: {
                navigationGroup.leave()
                self.semaphore.signal()
            })
            
          case .modal(let presentationStyle, let navigationController, let transitionStyle):
            let toPresent = navigationController == nil ? vc : UINavigationController(rootViewController: vc)
            self.present(
              toPresent,
              presentationStyle: presentationStyle,
              transitionStyle: transitionStyle,
              animated: element.animated,
              completion: {
                navigationGroup.leave()
                self.semaphore.signal()
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
  public func hideTopViewController(animated: Bool = true, completion: RoutingCompletion? = nil) {
    self.routingQueue.async {
      self.semaphore.wait()
      DispatchQueue.main.async {
        let topViewController = Router.topViewController()
        guard let stackViewControllers = topViewController.navigationController?.viewControllers, stackViewControllers.count > 1 else {
          topViewController.dismiss(
            animated: animated,
            completion: {
              self.semaphore.signal()
              completion?()
          })
          return
        }
        topViewController.navigationController?.popViewController(
          animated: animated,
          completion: {
            self.semaphore.signal()
            completion?()
        })
      }
    }
  }
}
