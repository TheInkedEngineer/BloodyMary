//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import BloodyMary
import Foundation

class YellowViewController: BMViewController<YellowView>, Routable {
  var screenIdentifier: ScreenIdentifier {
    Screen.yellow.rawValue
  }
}
