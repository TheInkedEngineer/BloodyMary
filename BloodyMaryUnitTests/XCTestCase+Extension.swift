//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import XCTest

@testable import BloodyMary

extension XCTestCase {
  func expectFatalError(message: String, testcase: @escaping () -> Void) {
    
    // arrange
    let expectation = self.expectation(description: "expectingFatalError")
    var assertionMessage: String? = nil
    
    // override fatalError. This will pause forever when fatalError is called.
    FatalErrorUtil.replaceFatalError { message, _, _ in
      assertionMessage = message
      expectation.fulfill()
      unreachable()
    }
    
    // act, perform on separate thead because a call to fatalError pauses forever
    DispatchQueue.global(qos: .userInteractive).async(execute: testcase)
    
    waitForExpectations(timeout: 2) { _ in
      // assert
      XCTAssertEqual(assertionMessage, message)
      
      // clean up
      FatalErrorUtil.restoreFatalError()
    }
  }
}
