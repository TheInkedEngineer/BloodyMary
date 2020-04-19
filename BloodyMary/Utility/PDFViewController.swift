//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import UIKit
import PDFKit

/// A `PDFViewController` is `UIViewController` with an integrated `PDFView` inside of it.
/// It is assumed that this ViewController will always be inside a navigation controller and therefore the `dismissButtonItem` is set as the `leftBarButtonItem` of the `navigationItem`.
/// The `dismissButtonItem` is customisable.
@available(iOS 11, *)
public class PDFViewController: UIViewController {
  
  // MARK: - Properties
  
  /// The back button to dismiss the `PDFView`.
  public var dismissButtonItem: UIBarButtonItem! { didSet { navigationItem.leftBarButtonItem = dismissButtonItem } }
  
  /// The `PDF` `URL` to open.
  private var pdfURL: URL
  
  // MARK: - Init
  
  /// Initializes the `PDFViewController` with a url that will be opened inside the view controller.
  public init(url: URL) {
    pdfURL = url
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Overloads
  
  /// overriding the default behaviour of `viewDidLoad` to startup internal functions.
  public override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .groupTableViewBackground
    configurePDFView()
    configureNavigationbar()
  }
  
  // MARK: - Helpers
  
  private func configureNavigationbar() {
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
    navigationController?.view.backgroundColor = .clear
    dismissButtonItem = {
      if #available(iOS 13.0, *) {
        return UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: #selector(tappedDismissButton))
      } else {
        return UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(tappedDismissButton))
      }
    }()
  }
  
  private func configurePDFView() {
    let pdfView: PDFView = {
      // the 100 is needed so the PDFView don't end up below the navigation bar. THe number itself is not relevant, apparently, as long as it's big.
      let pdfView = PDFView(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.height))
      pdfView.displayDirection = .vertical
      pdfView.usePageViewController(false)
      pdfView.autoScales = true
      return pdfView
    }()
    
    view.addSubview(pdfView)
    
    pdfView.translatesAutoresizingMaskIntoConstraints = false
    pdfView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1).isActive = true
    pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    
    pdfView.document = PDFDocument(url: pdfURL)
  }
  
  @objc private func tappedDismissButton() {
    guard let navigationController = navigationController, navigationController.viewControllers.count > 1 else {
      dismiss(animated: true, completion: nil)
      return
    }
    navigationController.popViewController(animated: true)
  }
}
