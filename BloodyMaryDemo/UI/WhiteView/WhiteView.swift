//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import BloodyMary
import UIKit

struct WhiteViewModel: BMViewModel {
  var screenToNavigateTo: Screen
}

class WhiteView: UIView, BMViewWithViewControllerAndViewModel {
  
  let button = UIButton()
  
  var didTapButton: ((String) -> Void)?
  
  func configure() {
    self.addSubview(self.button)
    self.button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
  }
  
  func style() {
    self.backgroundColor = .white
    
    self.button.backgroundColor = .black
    self.button.setTitleColor(.white, for: .normal)
    self.button.setTitle("Navigate", for: .normal)
  }
  
  func update(oldViewModel: WhiteViewModel?) {}
  
  func layout() {
    self.button.translatesAutoresizingMaskIntoConstraints = false
    self.button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    self.button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    self.button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    self.button.widthAnchor.constraint(equalToConstant: 200).isActive = true
  }
  
  @objc private func tappedButton() {
    guard let model = self.viewModel else {
      return
    }
    self.didTapButton?(model.screenToNavigateTo.rawValue)
  }
}
