# CHANGELOG

All relative changes will be documented in this file. \
`BloodyMary` adheres to [Semantic Versioning](https://semver.org).

***

### 1.X Releases
- `1.3.x` Releases - [1.3.0](#120)
- `1.2.x` Releases - [1.2.0](#120)
- `1.1.x` Releases - [1.1.0](#110)
- `1.0.x` Releases - [1.0.0](#100)

***
## 1.3.0
### April 19, 2020
* Add availability >= iOS 11 for PDFViewController

### March 19, 2020

* Introduce `PDFViewController`.
* Add `showPDFViewController(url: URL)` and `showPDFViewController(_ vc: PDFViewController)`
* Add `showSafariViewController(url: URL, presentationStyle: UIModalPresentationStyle, animated: Bool)`
* Made `Router.topViewController()` public

## 1.2.0
### March 5, 2020

* `screenIdentifier` is no longer static.
* Add `show` without having to pass an array.
* Moved `layout()` to loadView.
* Add ability to pop to a certain view controller given its routable identifier.
* Add support to customiza the `modal transition style`
* Aligned the `show` and `hide` functions on the same `queue`
* Made `Routable`'s assign `open`

## 1.1.0
### Febryary 14, 2020

* Add navigation system

## 1.0.0
### December 08, 2019

* Fix UIKit import in `BMViewController`

### December 04, 2019

* Initial release
