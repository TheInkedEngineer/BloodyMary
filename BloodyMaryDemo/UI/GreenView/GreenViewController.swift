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
      DependenciesContainer.shared.router.hideTopViewController()
      let routableObject = RoutableObject(screenIdentifier: "green", viewModel: GreenViewModel(), navigationStyle: .modal(presentationStyle: .currentContext, navigationController: nil))
      DependenciesContainer.shared.router.show(routableElements: [routableObject], completion: {print("1")})
      DependenciesContainer.shared.router.hideTopViewController(animated: true, completion: {print("5")})
      let routableObject2 = RoutableObject(screenIdentifier: "green", viewModel: GreenViewModel(), navigationStyle: .stack())
      DependenciesContainer.shared.router.show(routableElements: [routableObject2], completion: {print("3")})
    }
  }
}
