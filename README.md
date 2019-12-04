<p align="center">
<img src="logo.png" alt="BloodyMary logo" width="400">
</p>

[![Twitter](https://img.shields.io/twitter/url/https/theinkedgineer.svg?label=TheInkedgineer&style=social)](https://twitter.com/theinkedgineer)

# BloodyMary

`BloodyMary` is a stripped down version of [Tempura](https://github.com/BendingSpoons/tempura-swift). It is a one-directional [MVVM](https://en.wikipedia.org/wiki/Model–view–viewmodel) inspired framework that helps you write clean code and seperate the responsabilities properly.

# 1. Requirements and Compatibility
| Swift               | SwiftKnife     |  iOS     |
|-----------------|----------------|---------|
|       5.1+          | 1.x                |  10+     |

# 2. Installation

## Cocoapods

Add the following line to your Podfile
` pod 'BloodyMary' ~> '1.0' `


# 3. Documentation
`BloodyMary` is fully documented. Checkout the documentation [**here**](https://theinkedengineer.github.io/BloodyMary/docs/1.x/index.html).

# 4. Code Example
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
# 5. Contribution

**Working on your first Pull Request?** You can learn how from this *free* series [How to Contribute to an Open Source Project on GitHub](https://egghead.io/series/how-to-contribute-to-an-open-source-project-on-github)

## Generate the project
To generate this project locally, you need [xcodegen](https://github.com/yonaskolb/XcodeGen). It is a great tool to customize a project and generate it on the go.

You can either install it manually following their steps, or just run my `setup.sh` script. It automatically installs [Homebrew](https://brew.sh) if it is missing, installs `xcodegen`, removes existing (if present) `.xcodeproj`, run `xcodegen` and moves configuratiom files to their appropriate place.
