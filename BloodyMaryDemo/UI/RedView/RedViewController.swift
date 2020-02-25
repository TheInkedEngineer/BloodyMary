//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import BloodyMary
import Foundation

class RedViewController: BMViewController<RedView>, Routable {
  static var screenIdentifier: ScreenIdentifier {
    Screen.red.rawValue
  }
  
  override func setupInteractions() {
    super.setupInteractions()
    
    self.rootView.didTapButton = {
      DependenciesContainer.shared.router.hideTopViewController()
    }
  }
}
