//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import Foundation

/// An object, preferably a struct, containing a set of properties to be passed to a `BMViewWithViewModel`.
/// These properties should help the view render itself to reflect proper states.
/// ```swift
/// struct ProfileViewModel: BMViewModel {
///   let name: String
///   let age: Int = 27
/// }
/// ```
public protocol BMViewModel {}
