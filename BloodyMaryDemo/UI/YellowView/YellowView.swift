//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import Foundation

import BloodyMary
import UIKit

struct YellowViewModel: BMViewModel {}

class YellowView: UIView, BMViewWithViewControllerAndViewModel {
  func configure() {}
  
  func style() {
    self.backgroundColor = .yellow
  }
  
  func update(oldViewModel: YellowViewModel?) {}
  
  func layout() {}
}
