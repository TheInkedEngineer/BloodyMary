//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import BloodyMary
import Foundation

class RedViewController: BMViewController<RedView>, Routable {
  var screenIdentifier: ScreenIdentifier {
    Screen.red.rawValue
  }
  
  override func setupInteractions() {
    super.setupInteractions()
    
    self.rootView.didTapButton = {
      if #available(iOS 11, *) {
      DependenciesContainer.shared.router.showPDFViewController(url: URL(string: "http://www.africau.edu/images/default/sample.pdf")!)
      }
    }
  }
}
