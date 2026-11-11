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
- [Generator usage](codex_ai_system/README.md)

Runtime features live under `lib/feature/`; shared infrastructure lives under
`lib/core/`. SessionManager owns the active in-memory session, backed by secure
storage. TokenCubit adapts that session for UI. Hive caches are optional and scoped
by session and locale.
