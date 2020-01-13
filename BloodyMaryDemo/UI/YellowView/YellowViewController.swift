//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import BloodyMary
import Foundation

class YellowViewController: BMViewController<YellowView>, Routable {
  
  func assign(model: Any) -> Bool {
    guard let model = model as? YellowViewModel else {
      return false
    }
    self.viewModel = model
    return true
  }
  
  static var screenIdentifier: ScreenIdentifier {
    Screen.yellow.rawValue
  }
}
