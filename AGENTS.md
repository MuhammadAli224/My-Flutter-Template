# Project instructions

This is a Flutter project. Use Android Studio MCP file tools to read and edit
workspace files so unsaved editor changes are preserved.

## Canonical instructions

Read `codex_ai_system/rules/` before implementation. Those files are the single
source of architecture, UI, model/cache, state, and quality rules.
Read the matching prompt/template only when needed.

Precedence: explicit user instructions, this file, canonical rules, templates,
then historical examples. Root AI documents are navigation links, not separate rules.
When the user authorizes an architecture change, update the rules and generator
together. Do not spawn sub-agents unless the user explicitly requests delegation.

Use AppText for displayed text, with context.tr(key) for UI translations whenever
BuildContext is available. Keep user/API content as plain text.
Edit translations directly in assets/translations/ar.json and en.json.
Reuse the common object before adding text under a feature object such as auth.
Run `dart run easy_localization:generate -S assets/translations -s en.json -f keys -o app_strings.g.dart`
after dictionary changes. Only LocaleKeys is generated; the locale JSON files are
editable sources. See codex_ai_system/rules/07_localization_rules.md.

## Verification

Do not write or generate test cases, add test infrastructure, or run tests unless
the user explicitly requests them.
Run `flutter analyze --no-pub` for runtime changes.
Run `dart run tool/verify_generator.dart` for Mason/template changes; it builds and
analyzes cached and uncached output in disposable projects without running tests.
Check changed Dart files with `dart format --output=none --set-exit-if-changed`
after formatting them. Report pre-existing findings separately from new regressions.
Do not alter unrelated files or overwrite user changes.
