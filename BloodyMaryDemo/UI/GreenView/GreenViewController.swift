//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import BloodyMary
import Foundation

class GreenViewController: BMViewController<GreenView>, Routable {
  func assign(model: Any) -> Bool {
    guard let model = model as? GreenViewModel else {
      return false
    }
    self.viewModel = model
    return true
  }
  
  static var screenIdentifier: ScreenIdentifier {
    Screen.green.rawValue
  }
  
  override func setupInteractions() {
    super.setupInteractions()
    
    self.rootView.didTapButton = {
      DependenciesContainer.shared.router.hide()
    }
  }
}
