//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import BloodyMary
import Foundation

class WhiteViewController: BMViewController<WhiteView>, Routable {
  
  func assign(model: Any) -> Bool {
    guard let model = model as? WhiteViewModel else {
      return false
    }
    self.viewModel = model
    return true
  }
  
  static var screenIdentifier: ScreenIdentifier {
    Screen.white.rawValue
  }
  
  override func setupInteractions() {
    self.rootView.didTapButton = { identifier in
      let redRoutableObject = RoutableObject(
        screenIdentifier: identifier,
        viewModel: RedViewModel(),
        navigationStyle: .default,
        animated: true
      )
      
      let greenRoutableObject = RoutableObject(
        screenIdentifier: GreenViewController.screenIdentifier,
        viewModel: GreenViewModel(),
        navigationStyle: .stack(),
        animated: false
      )
      
      let yellowRoutableObject = RoutableObject(
        screenIdentifier: YellowViewController.screenIdentifier,
        viewModel: YellowViewModel(),
        navigationStyle: .stack(),
        animated: true
      )
      
      DependenciesContainer.shared.router.show(
        routableElements: [redRoutableObject, greenRoutableObject, yellowRoutableObject], completion: nil)
    }
  }
}
