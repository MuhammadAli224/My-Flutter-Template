# Localization rules

## Editable dictionaries

Keep only two translation files in assets/translations/:

- ar.json: all Arabic translations.
- en.json: all English translations.

These JSON files are the source of truth and are edited directly. Do not create
per-feature files, source/bundle duplicates, translation merge scripts, or custom
loaders. The app uses EasyLocalization's default loader with the existing path.

Group keys under nested objects in both files:

- common: reusable actions, labels, validation, status, and generic errors.
- auth: authentication text.
- app: branding.
- commerce: existing commerce-specific wording.
- Add future feature objects inside these same two files.

For example, the English file may contain:

```json
{
  "common": {"save": "Save"},
  "auth": {"login": "Login"}
}
```

The Arabic file must contain the same paths with Arabic values.

## Usage

```dart
AppText(context.tr(LocaleKeys.common_save)) // common.save
AppText(context.tr(LocaleKeys.auth_login)) // auth.login
AppText(context.tr(LocaleKeys.common_saveItem, args: [itemName]))
AppText(context.tr(
  LocaleKeys.common_deleteConfirmation,
  namedArgs: {'item': itemName},
))
```

- Reuse common keys when meaning, arguments, and grammar match.
- Keep feature-specific text under its feature object.
- Keep app branding and business-specific currency outside common.
- Bare save/edit/add/delete/details labels take no arguments. The separate
  saveItem/editItem/addItem/deleteItem/itemDetails keys require one positional {}.
- Keep identical key paths and placeholder names/counts across both languages.
- Use camelCase keys. Nested feature sections are allowed; all leaves are strings.
- Use generated LocaleKeys instead of hardcoded paths in application code.
- Translate with context.tr when BuildContext exists and render with AppText.
  Helpers without context may use the context-free API.
- Do not translate user/API content as localization keys.

## Key generation

Only lib/generated/app_strings.g.dart is generated; never edit it manually.
After editing the main JSON files, run:

```sh
dart run easy_localization:generate -S assets/translations -s en.json -f keys -o app_strings.g.dart
flutter analyze --no-pub
```

Do not create or run test cases unless the user explicitly requests them.
