//
//  BloodyMary
//
//  Copyright © TheInkedEngineer. All rights reserved.
// 

import UIKit
import PDFKit

/// A `PDFViewController` is `UIViewController` with an integrated `PDFView` inside of it.
/// It is assumed that this ViewController will always be inside a navigaiton controller and therefore the `dismissButtonItem` is set as the `leftBarButtonItem` of the `navigationItem`.
/// THe `dismissButtonItem` is customisable.
public class PDFViewController: UIViewController {
  
  // MARK: - Properties
  
  /// The back button to dismiss the `PDFView`.
  public var dismissButtonItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: nil, action: #selector(tappedDismissButton)) {
    didSet { navigationItem.leftBarButtonItem = dismissButtonItem }
  }
  
  /// The `PDF` `URL` to open.
  private var pdfURL: URL
  
  // MARK: - Init
  
  public init(url: URL) {
    pdfURL = url
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Overloads
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    guard #available(iOS 11.0, *) else { fatalError("You Should not be using the view controller for iOS < 11.0") }
    view.backgroundColor = .groupTableViewBackground
    configurePDFView()
    configureNavigationbar()
    navigationItem.leftBarButtonItem = dismissButtonItem
  }
  
  // MARK: - Helpers
  
  private func configureNavigationbar() {
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
    navigationController?.view.backgroundColor = .clear
  }
  
  private func configurePDFView() {
    guard #available(iOS 11.0, *) else {
      return
    }
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
