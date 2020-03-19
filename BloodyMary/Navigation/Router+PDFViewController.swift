//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import Foundation

public extension Router {
  /// Presents the `PDFViewController` on top of the stack.
  /// - Parameter url: The URL to pass the the `PDFView` inside controller.
  func showPDFViewController(url: URL) {
    self.routingQueue.async {
      self.semaphore.wait()
      DispatchQueue.main.async {
        let pdfViewController = PDFViewController(url: url)
        self.push(pdfViewController, completion: { self.semaphore.signal() })
      }
    }
  }
  
  /// Presents an instance of `PDFViewController` on top of the stack.
  /// - Parameter vc: The `PDFViewController` instance.
  func showPDFViewController(_ vc: PDFViewController) {
    self.routingQueue.async {
      self.semaphore.wait()
      DispatchQueue.main.async {
        self.push(vc, completion: { self.semaphore.signal() })
      }
    }
  }
}
