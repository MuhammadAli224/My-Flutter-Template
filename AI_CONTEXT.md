# Project overview

Flutter template using feature-first Clean Architecture, Cubit, Freezed, AutoMappr,
GetIt, Dio, and optional Hive caching.

Read [AGENTS.md](AGENTS.md) first. Canonical instructions live in
[codex_ai_system/rules](codex_ai_system/rules/); root documents do not duplicate them.

- [Architecture and module boundaries](codex_ai_system/rules/01_architecture_rules.md)
- [UI conventions](codex_ai_system/rules/02_ui_rules.md)
- [Models and cache policies](codex_ai_system/rules/03_model_cache_rules.md)
- [State and cancellation](codex_ai_system/rules/04_state_management_rules.md)
- [Verification](codex_ai_system/rules/05_code_quality_rules.md)
- [Session ownership](codex_ai_system/rules/06_session_rules.md)
- [Translation namespaces and generation](codex_ai_system/rules/07_localization_rules.md)
- [Generator usage](codex_ai_system/README.md)

Runtime features live under `lib/feature/`; shared infrastructure lives under
`lib/core/`. SessionManager owns the active in-memory session, backed by secure
storage. TokenCubit adapts that session for UI. Hive caches are optional and scoped
by session and locale.

Translations are edited directly in assets/translations/ar.json and en.json.
Both contain common, auth, app, and commerce objects. Add future feature objects
inside these same files; do not create separate feature translation files or a
merge workflow. Regenerate LocaleKeys with EasyLocalization's key generator after
editing dictionaries. Widgets use AppText(context.tr(LocaleKeys.common_save)) or
a feature key. See the localization rules for the command and examples.

The iOS project uses Swift Package Manager via project-level pubspec configuration.
Runner targets iOS 15.0+. The current Firebase SDK requires Xcode 26.2+ and Swift
6.2.3+; older toolchains fail package resolution. Keep the shared Runner scheme's
Flutter prepare pre-action and generated package reference. Do not edit generated
Flutter/ephemeral package files. See ios/README.md for setup and validation.
