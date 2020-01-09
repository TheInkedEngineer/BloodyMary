//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import BloodyMary
import UIKit

struct WhiteViewModel: BMViewModel {}

class WhiteView: UIView, BMViewWithViewControllerAndViewModel {
  func configure() {}
  
  func style() {
    self.backgroundColor = .white
  }
  
  func update(oldViewModel: WhiteViewModel?) {}
  
  func layout() {}
}
