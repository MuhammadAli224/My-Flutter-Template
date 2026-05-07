# Flutter App

A Flutter application scaffold built around feature-first clean architecture, Cubit state management, centralized app bootstrapping, generated localization keys, GetIt dependency injection, Hive CE local storage, HydratedBloc app settings, Dio networking, Freezed models, and AutoMappr mapping.

The project is structured so app startup, shared infrastructure, feature logic, UI, storage, routing, and generated code each have a clear owner.

---

## Architecture Overview

The app follows a feature-first clean architecture.

```txt
UI
  -> Cubit
  -> UseCase
  -> Repository interface
  -> Repository implementation
  -> Datasource
  -> API / Cache
```

Core rules:

- UI does not call APIs, datasources, or repositories directly.
- Cubits call use cases, except small app-level cubits such as settings.
- Repository implementations coordinate remote data, local cache, network checks, and DTO to entity mapping.
- DTOs stay in the data layer.
- Entities are the safe models for domain, state, and UI.
- Shared infrastructure lives in `lib/core/`.
- Feature code lives in `lib/feature/`.

---

## Current Project Structure

```txt
lib/
  app.dart
  main.dart
  global_imports.dart

  core/
    bloc/observer/
      block_observer.dart
    bootstrap/
      app_initializer.dart
    constant/
      box_key.dart
      env_constant.dart
      routes.dart
    context/
      global.dart
    cubit/
      token/
    dependencies/
      dependencies_injection.dart
    errors/
    extension/
    function/
    localization/
      app_localization.dart
    logger/
    mixin/
    model/
    network/
    router/
      routes.dart
    services/
      hive.service.dart
      app.service.dart
      api.service.dart
      header_provider.service.dart
      notification/
      background/
    theme/
      app_theme.dart
      light_theme.dart
      dark_theme.dart
    utils/
      color.dart
      text_style.dart
    widget/

  feature/
    settings/
      settings_barrel.dart
      presentation/cubit/
        settings_cubit.dart
        settings_state.dart
    splash_screen/
      splash_screen.dart

  generated/
    app_strings.g.dart
    assets.dart
```

Mason feature templates are stored under `bricks/`. They are excluded from analyzer because they contain template placeholders before generation.

---

## App Startup Flow

`main.dart` is intentionally small. It only ensures Flutter is initialized, calls the app initializer, and runs the app wrapped with `EasyLocalization`.

Startup is centralized in:

```txt
lib/core/bootstrap/app_initializer.dart
```

Initialization order:

1. Environment variables via `EnvConstant.init()`
2. EasyLocalization
3. Hive CE through `HiveServices`
4. HydratedBloc storage
5. GetIt dependency registration
6. `AppBlocObserver`
7. Core app services
8. Debug-friendly error widget

This keeps `main.dart` from becoming a dumping place for service setup.

---

## App Widget

`lib/app.dart` owns the root widget.

It configures:

- `MultiBlocProvider`
- `ScreenUtilInit`
- `MaterialApp.router`
- App themes
- Theme mode from `SettingsCubit`
- EasyLocalization delegates, supported locales, and current locale
- GoRouter configuration
- Global scaffold messenger key

No service initialization should be added to `build`.

---

## Core Layer

`lib/core/` contains shared infrastructure used by multiple features.

Important areas:

- `bootstrap/`: app initialization flow
- `dependencies/`: GetIt registration
- `services/`: API, Hive, headers, app services, notifications
- `theme/`: light and dark `ThemeData`
- `utils/`: colors, text styles, borders, gradients
- `network/`: connection monitoring
- `errors/`: failures and Dio error mapping
- `router/`: GoRouter setup
- `localization/`: supported locales and translation path
- `bloc/observer/`: global Bloc observer logging

Keep business rules out of core unless they are genuinely shared.

---

## Dependency Injection

GetIt is configured in:

```txt
lib/core/dependencies/dependencies_injection.dart
```

Registration guidelines:

- Core services are registered first.
- Feature dependencies should be registered from each feature's `di/` module.
- Services, repositories, and datasources are usually `lazySingleton`.
- Cubits are usually `factory`, unless they represent app-level persisted state.
- Do not instantiate registered dependencies manually inside widgets.

Current app-level registrations include:

- `AppServices`
- `FlutterSecureStorage`
- `TokenCubit`
- `SettingsCubit`
- `HeadersProvider`
- `ApiServices`
- `NetworkInfo`
- `ConnectionCubit`

---

## Settings and Theme State

App settings live in:

```txt
lib/feature/settings/
```

`SettingsCubit` extends `HydratedCubit<AppSettingsState>`.

It currently owns:

- `ThemeMode`
- dark mode state
- theme toggling and updates

Because it uses HydratedBloc, theme preference is persisted automatically. Theme state should not be manually written to Hive from the cubit.

---

## Theme System

Theme files live in:

```txt
lib/core/theme/
```

Color and typography sources:

```txt
lib/core/utils/color.dart
lib/core/utils/text_style.dart
```

Rules:

- `AppColor` is the single source of truth for app colors.
- `AppTheme.light` and `AppTheme.dark` build the actual `ThemeData`.
- Do not hardcode repeated hex colors in screens.
- Use `AppTextStyle` for shared text styles.
- Keep theme logic out of cubits.

---

## Localization

The app uses EasyLocalization with JSON assets:

```txt
assets/translations/en.json
assets/translations/ar.json
```

Localization config lives in:

```txt
lib/core/localization/app_localization.dart
```

Generated keys live in:

```txt
lib/generated/app_strings.g.dart
```

Regenerate keys after changing translation JSON:

```bash
dart run easy_localization:generate -S assets/translations -f keys -o app_strings.g.dart
```

Usage:

```dart
Text(LocaleKeys.login.tr())
```

Do not create a manual `app_strings.dart` constants file.

---

## Hive and Local Storage

Hive CE initialization is centralized in:

```txt
lib/core/services/hive.service.dart
```

Rules:

- Initialize Hive in one place only.
- Register adapters in `HiveServices`.
- Open shared boxes in `HiveServices`.
- Do not open Hive boxes from widgets.
- Local datasources should receive boxes through DI.

HydratedBloc handles app settings persistence separately from feature cache boxes.

---

## Networking

Networking is built around:

```txt
lib/core/services/api.service.dart
lib/core/services/header_provider.service.dart
lib/core/errors/dio_interceptor.dart
lib/core/network/network_info.dart
```

Guidelines:

- Remote datasources use `ApiServices` or Dio abstractions.
- Repositories check network state when needed.
- Dio errors are converted into `Failure` objects.
- UI receives user-safe messages through Cubit state.

---

## Feature Structure

New features should be placed under:

```txt
lib/feature/{feature_name}/
```

Recommended structure:

```txt
feature_name/
  data/
    datasource/
    endpoint/
    model/
    repository/
  domain/
    entities/
    repository/
    usecases/
    mappers/
  di/
  presentation/
    cubit/
    pages/
    widget/
    shared/
  feature_name_barrel.dart
```

Layer responsibilities:

- `data/model`: DTOs, JSON, Hive annotations when cached
- `data/datasource`: remote and local data access
- `data/repository`: repository implementation
- `domain/entities`: pure app models
- `domain/repository`: repository contracts
- `domain/usecases`: business actions
- `domain/mappers`: AutoMappr DTO/entity mapping
- `presentation/cubit`: state management
- `presentation/pages`: route-level screens
- `presentation/widget`: feature-specific widgets
- `di`: feature dependency registration

---

## Code Generation

The project uses:

- Freezed
- JsonSerializable
- Hive CE generator
- AutoMappr
- EasyLocalization key generation

Run model and mapper generation:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Run localization key generation:

```bash
dart run easy_localization:generate -S assets/translations -f keys -o app_strings.g.dart
```

---

## Mason Feature Generation

Mason is used for feature scaffolding.

Install Mason if needed:

```bash
dart pub global activate mason_cli
```

Generate a feature:

```bash
mason make feature
```

After generation:

1. Review the generated names and folders.
2. Register the feature DI module in `initGetIt()`.
3. Add routes in `lib/core/router/routes.dart`.
4. Add translation keys if the feature has UI text.
5. Run build runner if DTOs, entities, mappers, or Hive adapters were generated.

---

## Common Commands

Install dependencies:

```bash
flutter pub get
```

Analyze:

```bash
flutter analyze
```

Generate Freezed, JSON, Hive, and AutoMappr code:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Generate localization keys:

```bash
dart run easy_localization:generate -S assets/translations -f keys -o app_strings.g.dart
```

Run tests:

```bash
flutter test
```

---

## Package Groups

Main dependencies are grouped in `pubspec.yaml` by purpose:

- Core utilities
- Networking
- State management
- Dependency injection
- Storage and security
- Model/code generation annotations
- Routing
- UI
- Files and images
- Localization
- Notifications
- Firebase
- Development code generation
- Flutter tooling

---

## Development Guidelines

- Keep `main.dart` short.
- Do not initialize services inside widget `build` methods.
- Do not hardcode user-facing text; use `LocaleKeys`.
- Do not duplicate colors; use `AppColor`.
- Do not expose DTOs to UI/state.
- Do not call repositories or datasources from widgets.
- Keep feature dependencies registered through DI.
- Keep Hive box opening centralized.
- Use HydratedBloc for small persisted app preferences such as theme mode.
- Run `flutter analyze` before finishing changes.
