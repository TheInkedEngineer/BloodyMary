//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import Foundation

extension Thread {
  /// Checks if thread is currently running an `XCTest`.
  var isRunningXCTest: Bool {
    for key in self.threadDictionary.allKeys {
      guard let keyAsString = key as? String else {
        continue
      }
      
      if keyAsString.split(separator: ".").contains("xctest") {
        return true
      }
    }
    return false
  }
}
