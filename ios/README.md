# iOS setup

Swift Package Manager is enabled for this project through
flutter.config.enable-swift-package-manager in pubspec.yaml.

The Runner target links FlutterGeneratedPluginSwiftPackage at
Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage, and the shared
Runner scheme prepares Flutter frameworks in a build pre-action.

## Requirements

- iOS 15.0 or newer.
- Xcode 26.2 or newer with Swift 6.2.3 or newer.
- Flutter installed and available on PATH.

The current Firebase Flutter plugins require Firebase Apple SDK 13.1.1.
Its [package manifest](https://github.com/firebase/firebase-ios-sdk/blob/13.1.1/Package.swift)
explicitly rejects older Swift compilers. Xcode 26.0.1 / Swift 6.2.0 cannot resolve
this package.

## Configure and build

Open ios/Runner.xcworkspace in Xcode. After installing/selecting a supported Xcode:

```sh
flutter pub get
flutter build ios --config-only --no-codesign
flutter build ios --simulator --debug --no-codesign
```

Device/archive builds require the project's normal signing configuration.

Do not edit or commit generated files under Flutter/ephemeral. Flutter regenerates
the local package and plugin framework references. CocoaPods configuration remains
available as a fallback for plugins that do not support Swift Package Manager;
keep its deployment target consistent with Runner.

Dependency resolution is currently blocked on this machine by Xcode 26.0.1.
Project and scheme wiring can be validated independently, but a successful native
build must be confirmed after upgrading Xcode.
