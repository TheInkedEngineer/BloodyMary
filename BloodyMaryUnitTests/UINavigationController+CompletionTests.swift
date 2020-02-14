//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import UIKit
import XCTest

@testable import BloodyMary

class UINavigationControllerCompletionTests: XCTestCase {
  
  var firstViewController: UIViewController!
  var secondViewController: UIViewController!
  var count: Int!
  
  override func setUp() {
    super.setUp()
    
    self.firstViewController = UIViewController()
    self.secondViewController = UIViewController()
    self.count = 0
  }
  
  func testUINavigationControllerCompletionAfterPushWithAnimation() {
  
    let expectation = self.expectation(description: "Finish Navigation")
    
    let navigationController = UINavigationController(rootViewController: firstViewController)
    navigationController.pushViewController(secondViewController, animated: true, completion: { [weak self] in self?.count += 1; expectation.fulfill() })
    
    waitForExpectations(timeout: 2, handler: nil)
    
    XCTAssertEqual(count, 1)
  }
  
  func testUINavigationControllerCompletionAfterPushWithoutAnimation() {
    let expectation = self.expectation(description: "Finish Navigation")
    
    let navigationController = UINavigationController(rootViewController: firstViewController)
    navigationController.pushViewController(secondViewController, animated: false, completion: { [weak self] in self?.count += 1; expectation.fulfill() })
    
    waitForExpectations(timeout: 2, handler: nil)
    
    XCTAssertEqual(count, 1)
  }
  
  func testUINavigationControllerCompletionAfterPopWithAnimation() {
    let expectation = self.expectation(description: "Finish Navigation")
    
    let navigationController = UINavigationController(rootViewController: firstViewController)
    navigationController.pushViewController(secondViewController, animated: false)
    navigationController.popViewController(animated: true, completion: { [weak self] in self?.count += 1; expectation.fulfill() })
    
    waitForExpectations(timeout: 2, handler: nil)
    
    XCTAssertEqual(count, 1)
  }
  
  func testUINavigationControllerCompletionAfterPopWithoutAnimation() {
    let expectation = self.expectation(description: "Finish Navigation")
    
    let navigationController = UINavigationController(rootViewController: firstViewController)
    navigationController.pushViewController(secondViewController, animated: false)
    navigationController.popViewController(animated: false, completion: { [weak self] in self?.count += 1; expectation.fulfill() })
    
    waitForExpectations(timeout: 2, handler: nil)
    
    XCTAssertEqual(count, 1)
  }
}
