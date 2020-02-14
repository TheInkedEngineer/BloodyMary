//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import UIKit
import XCTest

@testable import BloodyMary
@testable import BloodyMaryDemo

class InspectableHierarchyUnitTests: XCTestCase {
  
  func testUIViewControllerFetchingNextViewController() {
    let firstViewController = UIViewController()
    let secondViewController = UIViewController()
    
    firstViewController.present(
      secondViewController,
      animated: false,
      completion: {XCTAssertNotNil(firstViewController.nextViewController)}
    )
  }
  
  func testNavigationControllerBasicHierarchy() {
    let firstViewController = UIViewController()
    let secondViewController = UIViewController()
    let thirdViewController = UIViewController()
    let fourthViewController = UIViewController()
    
    let expectation = self.expectation(description: "Finish Navigation")
    let expectedHierarchy = [firstViewController, secondViewController, thirdViewController, fourthViewController]
    
    let nav = UINavigationController(rootViewController: firstViewController)
    firstViewController.navigationController?.pushViewController(secondViewController, animated: false)
    secondViewController.navigationController?.pushViewController(thirdViewController, animated: false)
    thirdViewController.navigationController?.pushViewController(fourthViewController, animated: true, completion: { expectation.fulfill() })
    
    waitForExpectations(timeout: 2, handler: nil)
    
    XCTAssertEqual(nav.hierarchy, expectedHierarchy)
  }
}
