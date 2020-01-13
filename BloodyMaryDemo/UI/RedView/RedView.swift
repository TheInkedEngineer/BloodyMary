//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import BloodyMary
import UIKit

struct RedViewModel: BMViewModel {}

class RedView: UIView, BMViewWithViewControllerAndViewModel {
  func configure() {}
  
  func style() {
    self.backgroundColor = .red
  }
  
  func update(oldViewModel: RedViewModel?) {}
  
  func layout() {}
}
