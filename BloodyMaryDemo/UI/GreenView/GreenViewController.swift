//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import BloodyMary
import Foundation

class GreenViewController: BMViewController<GreenView>, Routable {
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
