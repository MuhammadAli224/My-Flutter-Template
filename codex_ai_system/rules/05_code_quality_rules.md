# Code Quality Rules

## General

- Follow existing naming conventions.
- Remove unused imports.
- Use `const` constructors where possible.
- Keep functions small.
- Keep files focused.
- Do not add unnecessary packages.
- Do not duplicate existing helpers.
- Do not change unrelated files.

## Before finishing

Codex must check:

- Generated files follow project folders.
- Imports are correct.
- Build runner files are mentioned if needed.
- Translation keys are added or listed.
- Hive adapters/typeIds are registered when cache is used.
- No DTO is exposed to UI/state.
- No hardcoded UI text exists.
- Widgets are split into separate files.
