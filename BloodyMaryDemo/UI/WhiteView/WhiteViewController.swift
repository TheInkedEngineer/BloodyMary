//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import BloodyMary
import Foundation

class WhiteViewController: BMViewController<WhiteView>, Routable {
  static var screenIdentifier: ScreenIdentifier {
    Screen.white.rawValue
  }
  
  override func setupInteractions() {
    self.rootView.didTapButton = { identifier in
      let redRoutableObject = RoutableObject(
        screenIdentifier: identifier,
        viewModel: RedViewModel(),
        navigationStyle: .stack(),
        animated: true
      )
      
      let greenRoutableObject = RoutableObject(
        screenIdentifier: GreenViewController.screenIdentifier,
        viewModel: GreenViewModel(),
        navigationStyle: .modal(),
        animated: false
      )
      
      DependenciesContainer.shared.router.show(
        routableElements: [redRoutableObject, greenRoutableObject], completion: nil)
    }
  }
}
