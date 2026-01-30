# Tuist Migration Guide

This document explains how to migrate from CocoaPods to Tuist for the RBSOdometer project.

## Why Tuist?

Tuist is a modern alternative to CocoaPods that offers:

- **Fast project generation** - Generate Xcode projects on-demand
- **Better dependency management** - Integrates with Swift Package Manager
- **Improved CI/CD** - Faster builds with smart caching
- **Type-safe configuration** - Define projects in Swift
- **No more merge conflicts** - Project files are generated, not committed
- **Active development** - Unlike CocoaPods which has been discontinued

## Installation

Install Tuist:

```bash
curl -Ls https://install.tuist.io | bash
```

Verify installation:

```bash
tuist --version
```

## Project Structure

The project is now defined using Tuist's Swift-based DSL:

### `Project.swift`
Defines the main project structure, targets, and settings.

### `Tuist/Config.swift`
Contains Tuist-specific configuration like compatible Xcode versions.

### `Tuist/Dependencies.swift`
Declares external dependencies (RBSReuseQueue in our case).

## Common Commands

### Generate the project
```bash
tuist generate
```

### Install dependencies
```bash
tuist install
```

### Clean generated files
```bash
tuist clean
```

### Update dependencies
```bash
tuist install --update
```

## Building and Testing

After generating the project:

```bash
# Open in Xcode
open RBSOdometer.xcworkspace

# Or build from command line
xcodebuild build -scheme RBSOdometer -destination 'platform=iOS Simulator,name=iPhone 15,OS=latest'

# Run tests
xcodebuild test -scheme RBSOdometerTests -destination 'platform=iOS Simulator,name=iPhone 15,OS=latest'
```

## CI/CD Integration

The GitHub Actions workflows now use Tuist:

1. Install Tuist
2. Run `tuist install` to fetch dependencies
3. Run `tuist generate` to create Xcode project
4. Build and test using xcodebuild

See `.github/workflows/ci.yml` for the complete workflow.

## Migrating Your Own Project

If you're using RBSOdometer in your project and want to migrate to Tuist:

### Option 1: Add as SPM Dependency

In your `Tuist/Dependencies.swift`:

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

Then in your `Project.swift`:

```swift
.target(
    name: "YourApp",
    dependencies: [
        .external(name: "RBSOdometer")
    ]
)
```

### Option 2: Keep Using CocoaPods

If you prefer to stay with CocoaPods for now, the podspec is still maintained for compatibility, though we recommend migrating to Tuist for better long-term support.

## Troubleshooting

### "Command not found: tuist"

Make sure Tuist is properly installed and in your PATH:

```bash
curl -Ls https://install.tuist.io | bash
source ~/.zshrc  # or ~/.bash_profile
```

### "Cannot find RBSReuseQueue"

Run the dependency installation:

```bash
tuist install
```

### Build errors after generating

Try cleaning and regenerating:

```bash
tuist clean
tuist install
tuist generate
```

## Resources

- [Tuist Documentation](https://docs.tuist.io)
- [Tuist GitHub](https://github.com/tuist/tuist)
- [RBSOdometer Issues](https://github.com/RbBtSn0w/RBSOdometer/issues)

## Questions?

If you have questions about the migration, please open an issue on GitHub.
