<p align="center">
<img src="logo.png" alt="BloodyMary logo" width="400">
</p>

# BloodyMary

`BloodyMary` is an one-directional MVVM framework.

[![Twitter](https://img.shields.io/twitter/url/https/theinkedgineer.svg?label=TheInkedgineer&style=social)](https://twitter.com/theinkedgineer)

# 1. Requirements and Compatibility
| Swift               | SwiftKnife     |  iOS     |
|-----------------|----------------|---------|
|       5.1            | 1.x                |  10+     |

# 2. Installation

## Cocoapods

Add the following line to your Podfile
` pod 'BloodyMary' ~> '1.0' `


# 3. Documentation
`BloodyMary` is fully documented. Checkout the documentation [**here**](https://theinkedengineer.github.io/BloodyMary/docs/1.x/index.html).

# 4. Contribution

**Working on your first Pull Request?** You can learn how from this *free* series [How to Contribute to an Open Source Project on GitHub](https://egghead.io/series/how-to-contribute-to-an-open-source-project-on-github)

## Generate the project
To generate this project locally, you need [xcodegen](https://github.com/yonaskolb/XcodeGen). It is a great tool to customize a project and generate it on the go.

You can either install it manually following their steps, or just run my `setup.sh` script. It automatically installs [Homebrew](https://brew.sh) if it is missing, installs `xcodegen`, removes existing (if present) `.xcodeproj`, run `xcodegen` and moves configuratiom files to their appropriate place.
