## Installation

- Check if you are in the beta channel of flutter SDK and the version v2.0.1 or higher. [Instruction to change flutter channel](https://github.com/flutter/flutter/wiki/Flutter-build-release-channels#how-to-change-channels).
- Clone the repo
  ```sh
  git clone https://gitlab.com/a2188/flutter-mse-customer.git
  ```
- And then we can use the normal build and run procedure
  ```sh
  flutter pub get
  flutter run
  ```
- Some files like `*.freezed.dart`, `*.g.dart`, `*.iconfig.dart` are auto generated. If there is any issue from these files just run this command to regenerate them.
  ```sh
  flutter pub run build_runner watch --delete-conflicting-outputs
  ```
## IOS
 Locale Plist
 - https://flutter.dev/docs/development/accessibility-and-localization/internationalization#appendix-updating-the-ios-app-bundle
## Tracker
https://trello.com/b/P3mKIIDx/mse-steel-project

## Mock Screen
https://www.figma.com/file/KgzSKN4AMevgnyi1OcnA75/MSE?node-id=0%3A1

## Flutter Color code
https://api.flutter.dev/flutter/material/Colors-class.html

## Flutter Icon
https://fonts.google.com/icons?icon.query=location

## Firebase console
https://console.firebase.google.com/u/0/project/mse-steel/overview?pli=1

## Translate
 ```sh
 flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations"
 ```
 ```sh
 flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations" -o "locale_keys.g.dart" -f keys
 ```
## Generate Mode
Replace models.jsonc
VCODE Crtl+Alt+Shift +B
