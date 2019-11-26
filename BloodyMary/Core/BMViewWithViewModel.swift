//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import Foundation

private var modelKey = "BMViewWithViewModel_model_key"

/// A BMViewWithViewModel takes the BMView and UIView a step further by introducing a view model.
/// The view model is an object containing a set of properties reflecting the state of the view.
/// A view model makes it easier to mock a view by passing the state from the outside and therefore test it in any desired state.
///
/// ## Example
/// ```swift
/// struct ProfileViewModel: BMViewModel {
///   let name: String
///   let age: Int
///
///   var isAdult: Bool {
///     age > 18
///   }
///
///   var badgeColor: UIColor {
///     isAdult ? .green : .red
///   }
/// }
/// ```
///
/// ```swift
/// class ProfileView: BMViewWithViewModel {
///   let badge = UIView()
///   let nameLabel = UILabel()
///
///   func configure() {
///     self.addSubview(self.badge)
///     self.addSubview(self.nameLabel)
///   }
///
///   func style() {
///     // style the elements
///   }
///
///   func update(oldViewModel: ProfileViewModel?) {
///     self.badge.backgroundColor = self.viewModel?.badgeColor
///     self.nameLabel.text = self.viewModel?.name
///   }
///
///   func layout() {
///     // layout the subviews
///   }
/// }
/// ```
/// By conformimng to `BMViewWithViewModel` in this previous example, we notice we do not explicetely need to specify the viewModel
/// since it is infered by swift through the `update(oldViewModel: VM?)` method.
///
/// By altering the view model, different states of the view can be tested in a fast efficient way.
///
public protocol BMViewWithViewModel: BMView {
  /// The type of the `ViewModel` associated with the view.
  associatedtype VM: BMViewModel
  
  /// The `ViewModel` of the view.
  /// Once set, `update(oldViewModel: VM?`) is called by leveraging an Objective-C runtime
  /// called [Associated Types](http://nshipster.com/associated-objects/).
  /// There is no need to explicitly set this value. By calling update with the proper `VM` value,
  /// the type of the `viewModel` is inferred thanks to `Swift`.
  var viewModel: VM? { get set }
  
  /// A function called everytime the `viewModel` is set.
  /// The "old" `viewModel`  is passed so a diffs based reasoning can be made.
  func update(oldViewModel: VM?)
}

public extension BMViewWithViewModel {
  /// The ViewModel of the View. Once changed, the `update(oldViewModel: VM?)` will be called.
  /// The model variable is automatically created when conforming to the ViewWithModel protocol.
  /// Swift is inferring the Type through the `oldModel` parameter of the `update(oldModel: BMViewModel?)` method
  var viewModel: VM? {
    get {
      return objc_getAssociatedObject(self, &modelKey) as? VM
    }

    set {
      let oldModel = self.viewModel
      objc_setAssociatedObject(
        self,
        &modelKey,
        newValue,
        .OBJC_ASSOCIATION_RETAIN_NONATOMIC
      )
      self.update(oldViewModel: oldModel)
    }
  }

  /// Will throw a fatalError. Use `update(oldMdel:)` instead.
  func update() {
    // swiftlint:disable:previous unavailable_function
    fatalError("You should not use \(#function) in a ModellableView. Change the model instead" )
  }
}
