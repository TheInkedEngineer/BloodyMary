//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import BloodyMary
import Foundation

class RedViewController: BMViewController<RedView>, Routable {
  
  func assign(model: Any) -> Bool {
    guard let model = model as? RedViewModel else {
      return false
    }
    self.viewModel = model
    return true
  }
  
  static var screenIdentifier: ScreenIdentifier {
    Screen.red.rawValue
  }
}
