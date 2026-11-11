# UI Screen Prompt

```md
Follow AGENTS.md and the canonical rules in codex_ai_system/rules/.

Task:
Build/update UI screen: [screen name]

Design requirements:
- [requirement 1]
- [requirement 2]

Rules:
- Page file should stay clean.
- Every widget must be a separate class in a separate file.
- Use gap extension for spacing.
- Use AppText(context.tr(LocaleKeys.common_save)) for shared labels.
- Reuse the common object first; add feature-specific text under a feature object
  in the main assets/translations/ar.json and en.json, then regenerate LocaleKeys.
- Follow codex_ai_system/rules/07_localization_rules.md.
- Use existing AppColor and AppTextStyle.
- Support dark mode if existing screens support it.
- Reuse shared widgets when possible.
- Do not put business logic in widgets.

Before finishing:
- List widgets created.
- List translation keys needed.
- Mention if any assets are needed.
```
