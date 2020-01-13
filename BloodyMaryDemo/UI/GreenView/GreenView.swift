//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import BloodyMary
import UIKit

struct GreenViewModel: BMViewModel {}

class GreenView: UIView, BMViewWithViewControllerAndViewModel {
  let button = UIButton()
  
  var didTapButton: (() -> Void)?
  
  func configure() {
    self.addSubview(self.button)
    self.button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
  }
  
  func style() {
    self.backgroundColor = .green
    
    self.button.backgroundColor = .black
    self.button.setTitleColor(.white, for: .normal)
    self.button.setTitle("Navigate", for: .normal)
  }
  
  func update(oldViewModel: GreenViewModel?) {}
  
  func layout() {
    self.button.translatesAutoresizingMaskIntoConstraints = false
    self.button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    self.button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    self.button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    self.button.widthAnchor.constraint(equalToConstant: 200).isActive = true
  }
  
  @objc private func tappedButton() {
    self.didTapButton?()
  }
}
