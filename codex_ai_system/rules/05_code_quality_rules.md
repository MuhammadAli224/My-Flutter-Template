# Quality and verification

- Keep changes focused, functions small, imports explicit, and constructors const
  where possible. Reuse existing widgets and helpers.
- Preserve unrelated user edits. Regenerate Freezed/JSON/mapper/localization output
  instead of editing it manually.
- Do not create test cases, test directories, test dependencies, or generated tests
  unless the user explicitly requests them.
- Run flutter analyze --no-pub for runtime changes.
- Format changed Dart files, then check formatting without modifying them.
- Run dart run tool/verify_generator.dart for generator changes; it generates,
  builds, and analyzes both cache variants without creating or running tests.
- Check module boundaries, cancellation, cache policies, and localization in review.
- Use AppText with context.tr(...) for UI translation keys wherever context exists.
- Reuse common translation keys; edit feature objects in the main ar.json/en.json.
- Check locale key/placeholder parity and regenerate LocaleKeys after changes.
  Follow 07_localization_rules.md; do not create split-file translation sources.
- Report commands run, outcomes, and any pre-existing analyzer findings.
