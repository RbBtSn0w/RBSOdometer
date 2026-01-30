# Contributing to RBSOdometer

Thank you for considering contributing to RBSOdometer! This document outlines the process for contributing to this project.

## Code of Conduct

By participating in this project, you agree to maintain a respectful and inclusive environment for all contributors.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When creating a bug report, include:

- **Clear title and description**
- **Steps to reproduce** the issue
- **Expected behavior** vs. **actual behavior**
- **Screenshots** if applicable
- **Environment details** (iOS version, Xcode version, etc.)

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, include:

- **Clear title and description**
- **Use case** - explain why this enhancement would be useful
- **Proposed solution** or implementation approach if you have one

### Pull Requests

1. **Fork** the repository
2. **Create a branch** from `develop` for your changes:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes** following our coding standards
4. **Test your changes** thoroughly
5. **Commit your changes** with clear, descriptive commit messages
6. **Push** to your fork
7. **Submit a Pull Request** to the `develop` branch

#### Pull Request Guidelines

- Follow the existing code style and conventions
- Update documentation if needed
- Add tests for new functionality
- Ensure all tests pass
- Keep pull requests focused on a single feature or fix
- Write clear commit messages

## Development Setup

### Prerequisites

- macOS with Xcode 15.0 or later
- Tuist installed via Mise (recommended):
  ```bash
  # Install Mise
  curl https://mise.run | sh
  
  # Install Tuist (will use version from .tool-versions)
  mise install
  ```
  Or via Homebrew: `brew install tuist`

### Setting Up the Project

1. Clone your fork:
   ```bash
   git clone https://github.com/YOUR-USERNAME/RBSOdometer.git
   cd RBSOdometer
   ```

2. Install dependencies and generate the project:
   ```bash
   tuist install
   tuist generate
   ```

3. Open the workspace:
   ```bash
   open RBSOdometer.xcworkspace
   ```

### Building and Testing

Build the framework:
```bash
xcodebuild build \
  -scheme RBSOdometer \
  -destination 'platform=iOS Simulator,name=iPhone 15,OS=latest'
```

Run tests:
```bash
xcodebuild test \
  -scheme RBSOdometerTests \
  -destination 'platform=iOS Simulator,name=iPhone 15,OS=latest'
```

Or use the GitHub Actions workflow locally with [act](https://github.com/nektos/act).

## Coding Standards

### Objective-C Style Guide

- Follow Apple's [Coding Guidelines for Cocoa](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CodingGuidelines/CodingGuidelines.html)
- Use descriptive variable and method names
- Add documentation comments for public APIs
- Keep methods focused and concise
- Use proper memory management (ARC)

### Code Organization

- Keep source files organized in appropriate directories
- Separate interface (.h) and implementation (.m) files
- Group related functionality together

### Documentation

- Document all public APIs with header comments
- Include usage examples for complex features
- Keep README.md up to date

## Project Structure

```
RBSOdometer/
├── Project.swift              # Tuist project definition
├── Tuist/
│   ├── Config.swift          # Tuist configuration
│   └── Dependencies.swift    # External dependencies
├── RBSOdometer/
│   └── Classes/              # Framework source code
├── Example/
│   ├── RBSOdometer/         # Example app source
│   └── Tests/               # Unit tests
└── .github/
    └── workflows/           # CI/CD workflows
```

## Continuous Integration

All pull requests must pass the CI checks:

- Build succeeds on iOS
- All tests pass
- No code signing issues

The CI runs automatically on every pull request.

## Release Process

Releases are managed by project maintainers:

1. Update version in `Project.swift` and `RBSOdometer.podspec`
2. Update `CHANGELOG.md`
3. Create a new tag: `git tag -a v0.x.x -m "Release v0.x.x"`
4. Push the tag: `git push origin v0.x.x`
5. GitHub Actions will automatically create a release with XCFramework

## Questions?

If you have questions, feel free to:
- Open an issue with the "question" label
- Contact the maintainer at hamiltonsnow@gmail.com

## License

By contributing to RBSOdometer, you agree that your contributions will be licensed under the MIT License.
