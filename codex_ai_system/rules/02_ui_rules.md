# UI rules

## Widgets and text

- Keep pages focused on layout; put custom reusable widgets in separate files.
- Use core/widget/app_widget/app_text.dart for every displayed text widget.
- Use AppText(context.tr(LocaleKeys.someText)) for translated UI labels.
- Use context.tr(key, args: [...], namedArgs: {...}) whenever BuildContext is
  available. Do not use key.tr() inside widget builds or context-aware callbacks.
- Translate string-only framework properties such as hints, tooltips, and app titles
  with context.tr(...), even though those properties cannot accept a widget.
- Pass already translated labels and user/API content directly to AppText.
  Do not translate arbitrary names, descriptions, identifiers, or debug details.
- AppText is the only place that directly uses Text, Text.rich, or AutoSizeText.
- Use AppText(autoSize: true, ...) for shrinking text, preserving minFontSize,
  maxFontSize, and maxLines. Use AppText.rich(TextSpan(...)) for styled spans.
- In helpers without BuildContext, keep context-free translation; do not introduce
  global UI context dependencies just for localization.
- Never hardcode UI labels. Add keys and translations to both ar.json and en.json,
  then regenerate app_strings.g.dart.

Example:

```dart
AppText(
  context.tr(LocaleKeys.login),
  style: AppTextStyle.style16B,
)
```

## Spacing and design system

- Use the gap extension (10.gap) for normal gaps.
- Use existing AppColor, AppTextStyle, and shared widgets.
- Support existing dark-mode behavior and avoid duplicated components.
