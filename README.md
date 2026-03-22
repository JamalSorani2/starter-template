# Flutter Starter Template (Mason-friendly)
A pragmatic Flutter starter focused on clean architecture, go_router, Bloc + Provider, localization, theming, and good DX. This repository contains a Mason brick under `__brick__` you can use to scaffold new apps, and the brick itself can also be run directly.

## Requirements
- Flutter stable 3.x, Dart 3.x
- Android Studio (Android SDK) and/or Xcode (for iOS)
- A real device or emulator/simulator

## Quick Start
You have two ways to use this repository.

1) Install Mason
- `dart pub global activate mason_cli`
2) Initialize Mason (if not already)
- `mason init`
3) Option A: Use as a Mason brick from GitHub
- `mason add starter-template --git-url https://github.com/JamalSorani2/starter-template.git`
   Option B: Use as a Mason brick 
   - At repo root: `mason add flutter_starter --path .`
4) Get bricks
- `mason get`
5) Scaffold a new app
- `mason make starter-template`

## Key Features
- go_router with named routes and central redirect logic
- Bloc for business flows, Provider for UI-only state
- easy_localization with JSON assets
- ScreenUtil for responsive UI
- DevicePreview gated for debug only
- Useful VS Code settings (format on save, fix on save)

## Project Structure (high level)
- `__brick__/lib/app/*` Feature modules (auth, onboarding, root)
- `__brick__/lib/common/*` Shared code (router, services, presentation utils)
- `__brick__/assets/l10n/*` Localization JSON files
- `__brick__/sort_pubspec.dart` Helper script to keep dependencies sorted

The generated app will mirror a similar structure.

## Common Commands
- Analyze: `flutter analyze`
- Tests: `flutter test`
- Codegen (if used): `dart run build_runner build --delete-conflicting-outputs`
- Sort pubspec: `dart run sort_pubspec.dart`
- Run with network inspect overlay: `flutter run --dart-define=ENABLE_REQUEST_INSPECT=true`

## Routing
- Configure routes in `lib/common/router/app_routes.dart`
- Router config & redirects in `lib/common/router/router_config.dart`
- Navigate using names:
  - `context.goNamed(RoutesNames.login)`

## State Management
- Business logic: `flutter_bloc`
- UI-only state: `provider`

## Localization
- `easy_localization` with JSON under `assets/l10n` (e.g., `en.json`, `ar.json`)
- Ensure assets are declared in `pubspec.yaml`

## Environment Flags
- Request Inspect overlay (Alice-based):
  - Enable via `--dart-define=ENABLE_REQUEST_INSPECT=true`
- DevicePreview: enabled in debug builds by default

## Optional: Melos (monorepo)
If you plan to split into multiple packages (design system, core, features), add a `melos.yaml` at the repository root and place packages under `packages/*` and the app under `apps/*`. Then:
- `dart pub global activate melos`
- `melos bootstrap`
- `melos run analyze`, `melos run test`, `melos run build`


## Notes
- This template targets modern Flutter and Dart (null-safe).
- Update dependency versions to your needs.

---
Feel free to open issues or suggestions to improve the starter.
