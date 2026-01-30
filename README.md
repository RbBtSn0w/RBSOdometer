# RBSOdometer

[![CI Status](https://github.com/RbBtSn0w/RBSOdometer/actions/workflows/ci.yml/badge.svg)](https://github.com/RbBtSn0w/RBSOdometer/actions/workflows/ci.yml)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-iOS%2011.0%2B-lightgrey.svg)](https://developer.apple.com/ios/)
[![Language](https://img.shields.io/badge/language-Objective--C-orange.svg)](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html)

RBSOdometer is an Objective-C library for smoothly animating number transitions with customizable effects, perfect for displaying changing numerical values with visual appeal.


## Features

- 🎯 Smooth number transition animations
- ⚡ Customizable animation duration and density
- 🎨 Configurable text color and font
- 📱 Auto Layout support
- 🔄 Efficient view reuse with RBSReuseQueue
- 🛠️ Easy to integrate and use

## Demo

<img src="https://github.com/RbBtSn0w/RBSOdometer/blob/master/RBSOdometerDemo.gif" width="300">

## Requirements

- iOS 11.0+
- Xcode 15.0+
- Tuist (for project generation)

## Installation

### Using Tuist (Recommended)

1. Install Tuist:
```bash
curl -Ls https://install.tuist.io | bash
```

2. Add RBSOdometer to your `Dependencies.swift`:
```swift
import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: SwiftPackageManagerDependencies([
        .remote(
            url: "https://github.com/RbBtSn0w/RBSOdometer.git",
            requirement: .upToNextMajor(from: "0.2.0")
        )
    ])
)
```

3. Add as a dependency in your `Project.swift`:
```swift
.target(
    name: "YourApp",
    dependencies: [
        .external(name: "RBSOdometer")
    ]
)
```

### Manual Installation

1. Clone the repository
2. Add `RBSOdometer/Classes/*.{h,m}` files to your project
3. Add the dependency: [RBSReuseQueue](https://github.com/RbBtSn0w/RBSReuseQueue)

## Usage

```objective-c
#import "RBSOdometerView.h"

// Create an odometer view
RBSOdometerView *odometerView = [[RBSOdometerView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];

// Configure appearance
odometerView.textColor = [UIColor blackColor];
odometerView.font = [UIFont systemFontOfSize:32];

// Set animation properties
odometerView.duration = 1.0; // Animation duration in seconds
odometerView.density = 5;     // Number density for animation

// Animate to a new value
[odometerView setNumber:@"12345"];

// Add to your view hierarchy
[self.view addSubview:odometerView];
```

## Running the Example

To run the example project:

```bash
git clone https://github.com/RbBtSn0w/RBSOdometer.git
cd RBSOdometer
tuist install
tuist generate
open RBSOdometer.xcworkspace
```

Then build and run the `RBSOdometerExample` scheme.

## Documentation

For detailed API documentation, see the header files:
- [RBSOdometerView.h](RBSOdometer/Classes/RBSOdometerView.h)

## Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

## Author

**RbBtSn0w**
- Email: hamiltonsnow@gmail.com
- Twitter: [@RbBtSn0w](https://twitter.com/RbBtSn0w)

## License

RBSOdometer is available under the MIT license. See the [LICENSE](LICENSE) file for more details.

## Acknowledgements

- Built with [Tuist](https://tuist.io) for modern Xcode project management
- Uses [RBSReuseQueue](https://github.com/RbBtSn0w/RBSReuseQueue) for efficient view reuse
