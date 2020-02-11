<p align="center">
<img src="logo.png" alt="BloodyMary logo" width="400">
</p>

[![Twitter](https://img.shields.io/twitter/url/https/theinkedgineer.svg?label=TheInkedgineer&style=social)](https://twitter.com/theinkedgineer)

# BloodyMary

`BloodyMary` is a stripped down version of [Tempura](https://github.com/BendingSpoons/tempura-swift). It is a one-directional [MVVM](https://en.wikipedia.org/wiki/Model–view–viewmodel) inspired framework that helps you write clean code and seperate the responsabilities properly.

`BloodyMary` has its own custom navigation system layer that works on top on Apple's native navigation system so none of the Apple magic is lost. `BloodyMary`'s navigation system can work next to Apple's way with no problem what so ever.

`BloodyMary`'s  navigation system aims to help you write the least code needed to get the most out of your app. You provide the SDK with the routes identifiers and their respective view controllers, and BloodyMary does the rest. From instantiating the correct VC to properly pushing it or presenting it etc..

Currently the stable version is `1.0.1` that lacks the navigation system.

The `1.1.0-beta.x` is the version containing the navigation system, currently being tested on different `WiseEmotions` libraries and `Telepass` iOS app.

### RoadMap

- [x] Custom Navigation System
- [ ] Integrate Combine

# 1. Requirements and Compatibility

| Swift               | BloodyMary     |  iOS     |
|-----------------|----------------|---------|
|       5.1+          | 1.0.x               |  10+     |
|       5.1+          | 1.1.x                |  10+     |

# 2. Installation

## Cocoapods

Add the following line to your Podfile
` pod 'BloodyMary' ~> '1.0.1' `


# 3. Documentation

`BloodyMary` is fully documented. Checkout the documentation [**here**](https://theinkedengineer.github.io/BloodyMary/docs/1.1.x/index.html).

# 4. Code Example
## The one directional MVVM

```swift
struct RemindersListViewModel: BMViewModel {
  var reminders: [Models.Reminders]
  
  func shouReloadData(oldModel model: RemindersListViewModel) -> Bool {
    model.reminders.count != self.reminders.count
  }
}

class RemindersListView: BMViewWithViewControllerAndViewModel {
  [...]
  
  func update(oldModel: RemindersListViewModel?) {
    guard let model = self.viewModel else { return }
    if model.shouReloadData(oldModel: oldModel) {
      self.tableView.reloadData()
    }
  }
  
  [...]
}

class RemindersListViewController: BMViewController {
  func setupInteractions() {
    self.rootView.didTapDeleteButton = { [weak self] index in
      guard let self = self, let model = self.viewModel else { return }
      let newReminders = model.reminders.remove(at: index)
      let newViewModel = RemindersListViewModel(reminders: newReminders)
      self.update(to: newViewModel)
    }
  }
}
```

## The Navigation System

### Providing the configuration for the router

```swift
import BloodyMary

struct DependenciesContainer: RoutingConfigurationProvider {
  // prevent it from being instantiated.
  private init() {}
  
  static var shared = DependenciesContainer()
  
  var screensAndDestinations: [ScreenIdentifier : RoutableViewController.Type] {
    [
      "green": GreenViewController.self,
      "red": RedViewController.self
    ]
  }
  
  lazy var router: Router = Router(with: self)
}

```

### Installing the root

```swift
import UIKit
import BloodyMary

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    self.window = self.window ?? UIWindow(frame: UIScreen.main.bounds)
    
    guard let window = self.window else {
      return false
    }
    
    let redVC = RedViewController()
    let redVM = RedViewModel()
    redVC.viewModel = whiteVM

    DependenciesContainer.shared.router.installRoot(using: greenViewController, in: window)

    return true
  }
}
```

### Navigating from a view to another

```swift
class RedViewController: BMViewController<RedView>, Routable {
  
  func assign(model: Any) -> Bool {
    guard let model = model as? RedViewModel else {
      return false
    }
    self.viewModel = model
    return true
  }
  
  static var screenIdentifier: ScreenIdentifier {
    "red"
  }
  
  override func setupInteractions() {
    super.setupInteractions()
    
    self.rootView.didTapButton = { _ in
      let greenRoutableObject = RoutableObject(
        screenIdentifier: GreenViewController.screenIdentifier,
        viewModel: GreenViewModel(),
        navigationStyle: .modal(),
        animated: false
      )
      
      DependenciesContainer.shared.router.show(
        routableElements: [greenRoutableObject], completion: nil)
    }
  }
}
```

# 5. Contribution

**Working on your first Pull Request?** You can learn how from this *free* series [How to Contribute to an Open Source Project on GitHub](https://egghead.io/series/how-to-contribute-to-an-open-source-project-on-github)

## Generate the project

To generate this project locally, you need [xcodegen](https://github.com/yonaskolb/XcodeGen). It is a great tool to customize a project and generate it on the go.

You can either install it manually following their steps, or just run my `setup.sh` script. It automatically installs [Homebrew](https://brew.sh) if it is missing, installs `xcodegen`, removes existing (if present) `.xcodeproj`, run `xcodegen` and moves configuratiom files to their appropriate place.
