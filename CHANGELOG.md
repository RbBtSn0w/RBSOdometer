# 1.0.0 (2026-02-03)


### Bug Fixes

* add RBSOdometerExample scheme to Project.swift ([bfd2447](https://github.com/RbBtSn0w/RBSOdometer/commit/bfd24471d65a815c69528d38fce27012d17b6c22))
* **ci:** fix yaml indentation and revert codecov to v3 to skip token ([9abb58d](https://github.com/RbBtSn0w/RBSOdometer/commit/9abb58deeb2dfc5e195d352ddaf8a3ec1da03296))
* **ci:** remove failing swift test command from SPM validation ([fd930df](https://github.com/RbBtSn0w/RBSOdometer/commit/fd930df24289536143544e2a572eda5daebda12a))
* explicitly define RBSOdometerTests scheme in Project.swift ([5592045](https://github.com/RbBtSn0w/RBSOdometer/commit/5592045715f87039eab7de9d10bd33bba82a02be))
* expose public headers for RBSOdometer target to fix Example app build ([8655ebc](https://github.com/RbBtSn0w/RBSOdometer/commit/8655ebc82d84aa403586e6f79ea7ac4efa920c68))
* relax Tuist Xcode version compatibility to .all ([66be520](https://github.com/RbBtSn0w/RBSOdometer/commit/66be52088def2209175ad0c807dca1603d69961f))
* vendor RBSReuseQueue to resolve missing Package.swift and fix build ([77893c3](https://github.com/RbBtSn0w/RBSOdometer/commit/77893c3c7321e2e5c1aa49ecfa55854c57d165ab))


### Features

* **infra:** migrate to Tuist and SPM dual mode ([3ae36e5](https://github.com/RbBtSn0w/RBSOdometer/commit/3ae36e5d4f260075b27a88294b8bc0c2efecd211))
* introduce semantic release support ([653423a](https://github.com/RbBtSn0w/RBSOdometer/commit/653423aa5bee5759bbae17cc222892677872de35))
* introduce semantic release support ([f56b827](https://github.com/RbBtSn0w/RBSOdometer/commit/f56b827e217951bf5468c4a1427b47d3f806ebf2))
* introduce semantic release support ([a32b6eb](https://github.com/RbBtSn0w/RBSOdometer/commit/a32b6eb121e0ac132f867e1f98bb29fbd289a985))
* introduce semantic release support with separate CD workflow ([e360b58](https://github.com/RbBtSn0w/RBSOdometer/commit/e360b5810bec1524fa000328f0084fdc106dc0fa))
* migrate to Tuist and SPM dual mode, remove CocoaPods support ([4e7b5e6](https://github.com/RbBtSn0w/RBSOdometer/commit/4e7b5e659f7eb5531ae688085150ef2bae27011f))

# Changelog

All notable changes to RBSOdometer will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Migrated from CocoaPods to Tuist for modern project management
- GitHub Actions CI/CD workflows for automated building and testing
- Automated release workflow with XCFramework generation
- Comprehensive CONTRIBUTING.md guide
- CHANGELOG.md for tracking changes
- Enhanced README with detailed usage examples and Tuist setup instructions
- Code coverage reporting support

### Changed
- Updated minimum iOS deployment target from 7.0 to 11.0
- Migrated from Travis CI to GitHub Actions
- Updated project badges to reflect new CI system
- Improved documentation with better examples and API references

### Removed
- Deprecated Travis CI configuration
- CocoaPods-specific workflow files

## [0.2.0] - 2018

### Added
- Initial release of RBSOdometer
- Smooth number transition animations
- Customizable animation duration and density
- Support for custom text color and font
- Auto Layout support
- Integration with RBSReuseQueue for efficient view reuse
- Example project demonstrating usage
- MIT License
- Basic documentation

[Unreleased]: https://github.com/RbBtSn0w/RBSOdometer/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/RbBtSn0w/RBSOdometer/releases/tag/0.2.0
