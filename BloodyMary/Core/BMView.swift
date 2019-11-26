//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import Foundation

/// A protocol that views should conform to.
/// Its main goal is to help structure the code in a more clean, organized way.
/// -----------------------------
/// ## Example
/// ```swift
/// /// An image based checkbox.
/// open class SKCheckbox: UIControl, BMView {
///
///   // MARK: - Properties
///
///   /// The currently displayed checkbox Image.
///   private var checkboxImage = UIImageView()
///
///   /// Overriding the original method to update the icon based on state.
///   open override var isEnabled: Bool {
///     didSet { self.update() }
///   }
///
///   // MARK: - Interactions
///
///   public var valueDidChange: ((_ checkbox: SKCheckbox, _ oldValue: Bool) -> Void)?
///
///   // MARK: - init
///
///   /// `init` via code.
///   public override init(frame: CGRect) {
///     super.init(frame: frame)
///     self.configure()
///     self.update()
///     self.layout()
///   }
///
///   /// `init` via IB.
///   public required init?(coder aDecoder: NSCoder) {
///     super.init(coder: aDecoder)
///     self.configure()
///     self.update()
///     self.layout()
///   }
///
///   // MARK: - CSUL
///
///   public func configure() {
///     self.addSubview(self.checkboxImage)
///   }
///
///   public func style() {
///     // style the default looks of the view and its subviews.
///   }
///
///   public func update() {
///     // update UI when isEnabled changes status, among other things.
///   }
///
///   public func layout() {
///     // layout the `checkboxImage` and other potential subviews.
///   }
/// }
/// ```
/// The view exposes **properties** and **interactions** to the outside world.
/// The **properties** deal with the state of the element, whereas the **interactions** are callbacks to interact with changes inside the element.
/// The lifecycle of the view is composed of `configure`, `style`, `update and `layout`.

/// ## Configure
/// Executed once when the view is instatiated. It deals with configuring the view.
/// For instance, a typical usecase would be to add subviews, or setup interactions.
/// ```swift
/// func configure() {
///   self.addSubiew(sel.checkboxImage)
/// }
/// ```

/// ## Style
/// Executed once when the view is instatiated. It deals with applaying the basic static styling to the view.
/// In other words element properties that are independent of the state of the element are applied here.
/// If the background of the element always has the same color, the background color is set here.
/// ```swift
/// func style() {
///   self.backgroundColor = .white
/// }
/// ```

/// ## Update
/// Update is not directly called when the object is instantiated but rather when a state related value changes its state.
/// Inside of the update, changes should be made to the UI to reflect the new state.
/// ```swift
///   open override var isEnabled: Bool {
///     didSet { self.update() }
///   }
/// ```

/// ## Layout
/// Excecuted once when the view is instatiated. It layouts the subviews as intended.
/// ```swift
/// func layout() {
///  self.checkboxImage.frame = self.bounds
/// ```
public protocol BMView: AnyObject {
  /// The view is configured at this level.
  /// The configuration should be called once inside the `init`.
  /// Things like adding subview, and targets to buttons are done here.
  func configure()

  /// The styling of the view's static elements is done at this level.
  /// The styling should be called once inside the `init()`, after the `configure()` phase.
  /// Styling elements that depend on the `state` of the view should go into update.
  func style()
  
  /// `update()` should be called everytime the `state` of the view changes.
  func update()
  
  /// During this phase the layouting of the subviews takes place.
  func layout()
}
