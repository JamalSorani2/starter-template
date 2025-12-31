# Flutter Starter Template

A opinionated Flutter starter focused on clean architecture, routing with go_router, BLoC + Provider, localization, theming, and DX helpers. Use this as a base for production apps.

## Requirements
- Flutter (stable) 3.x
- Dart 3.x
- Android Studio / Xcode as needed

## Getting Started
1. Install dependencies
   - `flutter pub get`
2. Run (Android/iOS)
   - `flutter run`
3. Build release
   - Android APK: `flutter build apk --release`
   - Android AAB: `flutter build appbundle --release`

## Environment Flags
- Request inspect overlay (Alice-based):
  - Enable via dart-define: `--dart-define=ENABLE_REQUEST_INSPECT=true`
  - Example: `flutter run --dart-define=ENABLE_REQUEST_INSPECT=true`
- Device Preview is enabled only in debug by default.

## Routing
- go_router with named routes (`RoutesNames.*`).
- Configure routes in `lib/common/router/app_routes.dart`.
- Global redirect rules live in `lib/common/router/router_config.dart`.
- Navigate:
  - `context.goNamed(RoutesNames.login);`

## State Management
- Business logic: `flutter_bloc`
- UI-only state: `provider`
- App-level manager: `AppManagerBloc`

## Localization
- `easy_localization` with JSON assets in `assets/l10n`.
- Run-on-save tasks (optional) generate keys and sort pubspec if VS Code extensions installed.

## Project Structure (high level)
- `lib/app/*` feature modules (auth, onboarding, root)
- `lib/common/*` shared code (router, services, presentation utilities)
- `assets/l10n` localization files

## Useful Commands
- Codegen (if used): `dart run build_runner build --delete-conflicting-outputs`
- Analyze: `flutter analyze`
- Tests: `flutter test`
- Sort pubspec: `dart run sort_pubspec.dart`

## CI (optional)
- Add your workflow under `.github/workflows/`. Example steps:
  - `flutter pub get`
  - `dart run build_runner build --delete-conflicting-outputs`
  - `flutter analyze`
  - `flutter test --coverage`
  - `flutter build apk --release`

## Notes
- This template assumes modern null-safety and Dart 3.
- Update package versions as needed.
- For flavors and more flags, prefer `--dart-define` or `--dart-define-from-file`.
