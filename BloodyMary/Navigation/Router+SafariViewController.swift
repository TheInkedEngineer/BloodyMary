//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import Foundation
import SafariServices

public extension Router {
  /// Presents the `SFSafariViewController` on top of the stack.
  /// - Parameter url: The URL to pass the the `Safari ` controller.
  func showSafariViewController(url: URL, presentationStyle: UIModalPresentationStyle, animated: Bool = true) {
    self.routingQueue.async {
      self.semaphore.wait()
      DispatchQueue.main.async {
        let safariViewController = SFSafariViewController(url: url)
        self.present(
          safariViewController,
          presentationStyle: presentationStyle,
          transitionStyle: .coverVertical,
          animated: animated,
          completion: { self.semaphore.signal() }
        )
      }
    }
  }
}
