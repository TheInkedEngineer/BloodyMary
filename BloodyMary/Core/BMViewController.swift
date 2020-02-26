//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import UIKit

/// ## Overview
/// A `BMViewController` replaces the default `UIViewController`. It manages a single screen,
/// and listen to the users interactions with it.
///
/// Refer to **BMViewWithViewControllerAndViewModel** to understand the architecture of a view.
///
/// The `BMViewController` gives you access to a `rootView` which is the view properly casted.
open class BMViewController<View: BMViewWithViewControllerAndViewModel & UIView>: UIViewController {
  
  /// A flag used to check whether or not the first activation of constraints took place or not.
  /// This flag is needed since `viewWillLayoutSubviews` is called several times, but constriants should be added once.
  private var didActivateConstraints = false

  /// The rootView associated with the `BMViewController`.
  public var rootView: View {
    // swiftlint:disable:next force_cast
    return self.view as! View
  }

  /// The latest `ViewModel` received by this `BMViewController`
  /// This should not be directly set. Please use `update(to: View.VM)`.
  public var viewModel: View.VM? {
     willSet {
       self.willUpdate(new: newValue)
     }
     didSet {
       // the viewModel is changed: update the View (if loaded)
       if self.isViewLoaded {
        self.rootView.viewModel = self.viewModel
       }
       self.didUpdate(old: oldValue)
     }
   }

  /// An more convenient initializer.
  /// Since we are not not using the storyboard
  public init() {
    super.init(nibName: nil, bundle: nil)
  }

  /// Required init.
  required public init?(coder aDecoder: NSCoder) {
    return nil
  }

  /// Used to load the specific main view managed by this view controller.
  override public func loadView() {
    let view = View(frame: .zero)
    view.viewController = self
    view.configure()
    view.style()
    self.view = view
  }

  /// Called after the controller's view is loaded into memory.
  override open func viewDidLoad() {
    super.viewDidLoad()
    
    if let vm = self.viewModel {
      self.rootView.viewModel = vm
    }
    self.setupInteractions()
  }
  
  /// Called when view about to layout subviews.
  open override func viewWillLayoutSubviews() {
    guard !self.didActivateConstraints else {
      return
    }
    self.rootView.layout()
    self.didActivateConstraints = true
  }

  /// Called everytime the VM needs to be updated.
  /// Should be called on the main Thread.
  ///
  /// - Parameter newModel: The new `ViewModel`
  public func update(to newModel: View.VM) {
    self.viewModel = newModel
  }
  
  /// Called just before the update, override point for subclasses.
  open func willUpdate(new: View.VM?) {}
  
  /// Called right after the update, override point for subclasses.
  open func didUpdate(old: View.VM?) {}

  /// Asks to setup the interaction with the managed view, override point for subclasses.
  open func setupInteractions() {}
  
  deinit {
    print("Removed \(String(describing: Self.self)) from hierarchy.")
  }
}

// MARK: - Containement

public extension BMViewController {
  
  /// Adds a `BMViewController` and its root view to
  /// - Parameters:
  ///   - child: The child view controller to add to the hierarchy.
  ///   - container: The container in which the view of the child should go in.
  func add<V: BMViewWithViewControllerAndViewModel & UIView>(
    _ child: BMViewController<V>,
    to container: BMContainerView
  ) {
    self.addChild(child)
    container.addSubview(child.rootView)
    child.didMove(toParent: self)
  }
  
  /// Removes a `BMViewController` and its view from the parent view controller.
  func remove() {
    guard self.parent != nil else { return }
    self.willMove(toParent: nil)
    self.removeFromParent()
    self.rootView.removeFromSuperview()
    self.viewWillDisappear(false)
    self.viewDidDisappear(false)
  }
}

/// A View used to do  contain other viewcontrollers.
public class BMContainerView: UIView {
  /// Lays out subviews. Setting the frame of each element equal to the bounds of its parent.
  public override func layoutSubviews() {
    super.layoutSubviews()
    self.subviews.forEach {
      $0.frame = self.bounds
    }
  }
}

// MARK: - Base implementation for Routable's `assign`

extension BMViewController {
  open func assign(model: Any) -> Bool {
    viewModel = model as? View.VM
    return viewModel != nil
  }
}
