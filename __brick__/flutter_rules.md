## Architecture
Use **Clean Architecture** with three layers per feature. Dependencies point inward: presentation → domain ← infrastructure.
| Layer | Folder | Responsibility |
|-------|--------|----------------|
| **Domain** | `lib/app/<feature>/domain/` | Business rules, contracts, and types with no Flutter or I/O |
| **Infrastructure** | `lib/app/<feature>/data/` | API, storage, and repository implementations (named `data` in this template) |
| **Presentation** | `lib/app/<feature>/presentation/` | UI, navigation, and state (BLoC) |

## Flutter style guide
* **SOLID Principles:** Apply SOLID principles throughout the codebase.
* **Concise and Declarative:** Write concise, modern, technical Dart code.
  Prefer functional and declarative patterns.
* **Composition over Inheritance:** Favor composition for building complex
  widgets and logic.
* **Immutability:** Prefer immutable data structures. Widgets (especially
  `StatelessWidget`) should be immutable.
* **State Management:** Separate ephemeral state and app state. Use a state
  management solution for app state to handle the separation of concerns.
* **Widgets are for UI:** Everything in Flutter's UI is a widget. Compose
  complex UIs from smaller, reusable widgets.
* **Navigation:** Use a modern routing package @/lib/common/router/app_routes.dart .

## Code Quality
* **Code structure:** Adhere to maintainable code structure and separation of
  concerns (e.g., UI logic separate from business logic).
* **Naming conventions:** Avoid abbreviations and use meaningful, consistent,
  descriptive names for variables, functions, and classes.
* **Conciseness:** Write code that is as short as it can be while remaining
  clear.
* **Simplicity:** Write straightforward code. Code that is clever or
  obscure is difficult to maintain.
* **Error Handling:** Anticipate and handle potential errors. Don't let your
  code fail silently.
* **Styling:**
    * Line length: Lines should be 80 characters or fewer.
    * Use `PascalCase` for classes, `camelCase` for
      members/variables/functions/enums, and `snake_case` for files.
* **Functions:**
    * Keep functions short and with a single purpose.
      Strive for less than 20 lines.
* **Logging:** Use @/lib/common/helper/colored_print.dart  instead of `print`.

## Dart Best Practices
* **Effective Dart:** Follow the official Effective Dart guidelines
  (https://dart.dev/effective-dart)
* **Class Organization:** Define related classes within the same library file.
  For large libraries, export smaller, private libraries from a single top-level
  library.
* **Library Organization:** Group related libraries in the same folder.
* **API Documentation:** Add documentation comments to all public APIs,
  including classes, constructors, methods, and top-level functions.
* **Comments:** Write clear comments for complex or non-obvious code. Avoid
  over-commenting.
* **Trailing Comments:** Don't add trailing comments.
* **Async/Await:** Ensure proper use of `async`/`await` for asynchronous
  operations with robust error handling.
    * Use `Future`s, `async`, and `await` for asynchronous operations.
    * Use `Stream`s for sequences of asynchronous events.
* **Null Safety:** Write code that is soundly null-safe. Leverage Dart's null
  safety features. Avoid `!` unless the value is guaranteed to be non-null.
* **Pattern Matching:** Use pattern matching features where they simplify the
  code.
* **Records:** Use records to return multiple types in situations where defining
  an entire class is cumbersome.
* **Switch Statements:** Prefer using exhaustive `switch` statements or
  expressions, which don't require `break` statements.
* **Exception Handling:** Use `try-catch` blocks for handling exceptions, and
  use exceptions appropriate for the type of exception. Use custom exceptions
  for situations specific to your code.
* **Arrow Functions:** Use arrow syntax for simple one-line functions.

## Flutter Best Practices
* **Immutability:** Widgets (especially `StatelessWidget`) are immutable; when
  the UI needs to change, Flutter rebuilds the widget tree.
* **Composition:** Prefer composing smaller widgets over extending existing
  ones. Use this to avoid deep widget nesting.
* **Private Widgets:** Use small, private `Widget` classes instead of private
  helper methods that return a `Widget`.
* **Build Methods:** Break down large `build()` methods into smaller, reusable
  private Widget classes.
* **List Performance:** Use `ListView.builder` or `SliverList` for long lists to
  create lazy-loaded lists for performance.
* **Isolates:** Use `compute()` to run expensive calculations in a separate
  isolate to avoid blocking the UI thread, such as JSON parsing.
* **Const Constructors:** Use `const` constructors for widgets and in `build()`
  methods whenever possible to reduce rebuilds.
* **Build Method Performance:** Avoid performing expensive operations, like
  network calls or complex computations, directly within `build()` methods.

## State Management
Follow the BLoC pattern in @lib/app/auth/presentation/state/bloc/auth_bloc.dart. Use `Result<T>` from @lib/core/result_builder/result.dart for every async operation in bloc state.

### BLoC
* Extend `Bloc<MyEvent, MyState>`.
* Inject the **domain** repository in the constructor (`AuthBloc({required AuthRepository repository})`).
* Register handlers in the constructor: `on<LoginAuthEvent>(_loginAuth);`.
* Each handler is `async` and follows this flow:
  1. `emit(state.copyWith(...: const Result.loading()));`
  2. `await _repository.someMethod(...);` (returns `Either<Failure, T>`)
  3. `response.fold(...)` — on failure `Result.error(error: l)`, on success `Result.loaded(data: r)`

```dart
emit(state.copyWith(loginAuthState: const Result.loading()));
final response = await _repository.loginAuth(loginAuthParam: event.loginAuthParam);
response.fold(
  (l) => emit(state.copyWith(loginAuthState: Result.error(error: l))),
  (r) => emit(state.copyWith(loginAuthState: Result.loaded(data: r))),
);
```

### Events
* Abstract base class per bloc (`abstract class AuthEvent {}`).
* One class per user action; carry **domain** params/entities (e.g. `LoginAuthParam`), not raw maps or JSON.

### State
* Plain class (not `Equatable` required) with one `Result<T>` field per operation.
* Default each field to `const Result.init()`.
* Implement `copyWith` so only the changed `Result` is passed in.

### `Result<T>`
Defined in @/lib/core/result_builder/result.dart:

| Constructor | When to emit |
|-------------|--------------|
| `Result.init()` | Initial / idle (default in state) |
| `Result.loading()` | Before `await` repository call |
| `Result.loaded(data: r)` | `Either` right / success |
| `Result.error(error: failure)` | `Either` left / `Failure` |

Use helpers in UI and bloc: `isInit`, `isLoading`, `isLoaded`, `isError`, `dataOrNull`, `errorMessage`.

### UI
* Provide the bloc with `BlocProvider` / `getIt<MyBloc>()`.
* Prefer `BlocConsumer` — **listener** for side effects (navigation, snackbars) when `result.isLoaded` / `result.isError`; **builder** for layout.
* Bind loading to controls: `isLoading: state.loginAuthState.isLoading`.
* Dispatch work with `context.read<MyBloc>().add(MyEvent(...));`.
* For declarative loading/success/error bodies, use `ResultBuilder<T>` from `lib/core/result_builder/result_builder.dart` with the `Result` from state.

### DI
* Register blocs and repositories in `lib/common/injection/` (get_it). Blocs are typically lazy singletons; screens use `getIt<AuthBloc>()`.


## Visual Design & Theming
Do not hardcode colors, radii, shadows, or typography in widgets. Use the shared theme tokens under `lib/common/presentation/ui/theme/`:

| File | Class | Use for |
|------|-------|---------|
| @/lib/common/presentation/ui/theme/app_colors.dart | `AppColors` | Brand, surfaces, text, status (`success`, `warning`, `danger`, `info`), borders, overlays |
| @/lib/common/presentation/ui/theme/app_design.dart | `AppDesign` | Layout tokens: padding, `radius` / `radiusLarge`, heights, `icon` size, `designSize` (390×844) |
| @/lib/common/presentation/ui/theme/app_gradient.dart | `AppGradients` | `primary`, `secondary`, `background`, `overlay`, status gradients |
| @/lib/common/presentation/ui/theme/app_shadow.dart | `AppShadows` | `card`, `md`, `lg`, `soft`, and `glow(color)` for elevated / active UI |
| @/lib/common/presentation/ui/theme/app_style.dart | `AppStyles` | Button, chip, input, dialog, and card `ThemeData` fragments |
| @/lib/common/presentation/ui/theme/theme.dart | `AppTheme` | `AppTheme.theme(isEnglish, isLight)` and `AppTheme.textTheme(isEnglish)` |

### Rules
* **Colors:** Use `AppColors.primary`, `AppColors.surface`, `AppColors.textPrimary`, etc. Toggle light/dark with `AppColors.init(light)`; never use raw `Color(0x…)` in feature UI.
* **Spacing & size:** Use `AppDesign` with `flutter_screenutil` (`.w`, `.h`, `.r`, `.sp`) — e.g. `AppDesign.horizontalPadding`, `AppDesign.buttonHeight`, `AppDesign.radius`.
* **Shadows:** Apply `AppShadows.card` / `md` / `lg` / `soft` on `BoxDecoration`; use `AppShadows.glow(AppColors.primary)` for focused or primary actions.
* **Gradients:** Use `AppGradients` for branded backgrounds and highlights, not ad-hoc `LinearGradient` lists.
* **Material theme:** Wire the app through `AppTheme.theme(...)` in `MaterialApp` so buttons, inputs, cards, and dialogs pick up `AppStyles` automatically.
* **Typography:** Prefer `Theme.of(context).textTheme` or the `TextThemeExtension` on `BuildContext` (`context.titleMedium`, etc.) — scales come from `AppTheme.textTheme` (Inter / Cairo via `google_fonts`).
* **Icons:** Use **`flutter_tabler_icons`** only — `TablerIcons.*` (exported from `lib/common/imports/imports.dart`). Do not use `Icons.*` or other icon packs unless there is no Tabler equivalent.
* **Responsiveness:** `ScreenUtil` is initialized with `AppDesign.designSize`; keep layouts adaptive with `.w` / `.h` / `.sp` alongside `AppDesign` constants.

* **UI quality:** Build clear hierarchy (display → headline → title → body → label), consistent elevation via `AppShadows`, and meaningful icons for navigation and actions.

## Assets & Images

* **Generated paths:** Use @/lib/gen/assets.gen.dart (`Assets`, FlutterGen) for typed asset paths. Do not hardcode `'assets/…'` strings in widgets when a generated accessor exists.
* **Network images:** Use `CustomNetworkImage` from @/lib/common/presentation/ui/widget/custom_network_image.dart — not raw `Image.network` or `CachedNetworkImage` directly. It handles loading (`LoadingProgress`) and error placeholders.

* **SVG:** Use `CustomSvgPicture` from @/lib/common/presentation/ui/widget/custom_svg.dart — not `SvgPicture.asset` directly. Pass the asset path (prefer from `Assets`), with optional `height`, `width`, and `color`.

* **Raster assets:** Declare files under `assets/` in `pubspec.yaml`, run FlutterGen to refresh `assets.gen.dart`, then reference via `Assets`.

## Localization

All user-visible strings must go through @/lib/common/translate/app_string.dart — never hardcode English/Arabic text in UI, validators, or errors.

| Source | Role |
|--------|------|
| @/assets/l10n/en.json | English copy (source of truth for new keys) |
| @/assets/l10n/ar.json | Arabic copy (same keys as `en.json`) |
| `AppString` | Type-safe getters (`AppString.email`, `AppString.tryAgain`, …) |

### Rules

* Add or update strings in **both** `en.json` and `ar.json` using the same camelCase keys.
* Regenerate keys after JSON changes: `dart run generate_localization_keys.dart` (updates `app_string.dart`).
* Use `AppString.<key>` everywhere (screens, forms, snackbars, `ValidationMessage`, exceptions).
* Load translations at startup via `AppString.loadTranslations()` with `easy_localization` (`AppLocale.path`, locales `ar` / `en` in `app_local.dart`).
* Do not use `.tr('key')` or string literals in widgets when an `AppString` getter exists.

