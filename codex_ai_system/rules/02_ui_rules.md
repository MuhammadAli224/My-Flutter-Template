# UI Rules

## Widget structure

- Do not create large widgets inside one file.
- New UI widgets must be separate classes in separate files.
- Keep pages clean and only responsible for layout composition.
- Reusable UI must go under `presentation/widget/` or shared `core/widget/`.

## Spacing

- Always use the gap extension for spacing.
- Do not use `SizedBox(height: x)` or `SizedBox(width: x)` for normal gaps.

Correct:

```dart
10.gap
```

Wrong:

```dart
const SizedBox(height: 10)
```

## Localization

- Never hardcode text in UI.
- Always use translation keys.

Correct:

```dart
Text(LocaleKeys.someText.tr())
```

Wrong:

```dart
Text('Some text')
```

## Design system

- Use existing `AppColor`.
- Use existing `AppTextStyle`.
- Reuse shared widgets where possible.
- Support dark mode if existing screens support it.
- Avoid duplicated UI components.
