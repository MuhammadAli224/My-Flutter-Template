# Flutter project guide

Start with [AGENTS.md](../AGENTS.md). The files in `rules/` are canonical.
Prompts help describe tasks; they do not introduce additional architecture rules.

## Generate a feature

From the project root:

```sh
mason get
mason make feature --name products --with_cache false --on-conflict skip
# For offline-capable features:
mason make feature --name articles --with_cache true --on-conflict skip
dart run build_runner build --delete-conflicting-outputs
```

The brick expects a list endpoint shaped like `{data: [...], hasError: false}`.
Adapt DTO fields, endpoint, and parsing to the actual API contract before use.
Generated UI uses AppText(context.tr(...)) with existing app/empty-state keys; replace the page title
with a feature-specific translation key when implementing the screen.

Explicitly import and call `initProductsDI()` from the composition root after core
DI initializes, and register the page in GoRouter if needed. No global feature
exports are required.

The existing directory convention is `data/datasources/{feature}/` and
`presentation/{feature}/`. Both the brick and templates follow it.
With `with_cache: false`, no local datasource implementation is generated or
registered (the scaffold retains an empty local file).

## Verification

```sh
flutter pub get
flutter analyze --no-pub
dart run tool/verify_generator.dart
```

The generator verifier builds disposable copies of this project, generates both
variants, runs build_runner, and analyzes generated code without creating or
running tests.
It never adds example features to the working application's routes or DI.

## Translations

Edit assets/translations/ar.json and en.json directly. Reuse labels from the common
object; group feature text under objects such as auth. Keep app branding under app
and existing commerce wording under commerce. Do not create per-feature files.

```sh
dart run easy_localization:generate -S assets/translations -s en.json -f keys -o app_strings.g.dart
```

The command regenerates only LocaleKeys from the main locale dictionaries.
Use AppText(context.tr(LocaleKeys.common_save)) or
AppText(context.tr(LocaleKeys.auth_login)).
See [translation rules](rules/07_localization_rules.md).

## Session and cache

Use SessionReader for shared reads and SessionManager for sign-in/sign-out.
TokenCubit is a presentation adapter. Storage can be SecureSessionStore or
InMemorySessionStore. Cache entries carry creation time, session scope, and locale;
account changes invalidate shared feature caches.
