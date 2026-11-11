# New feature prompt

```md
Follow AGENTS.md and the canonical rules in codex_ai_system/rules/.

Create feature: [name]
Endpoint and response schema: [contract]
Offline caching: [yes/no]
Screen behavior: [requirements]

Use the Mason brick with the matching with_cache option. Adapt its placeholder DTO,
endpoint and UI to the actual requirements. Keep domain imports
pure and API envelopes in data code. Integrate DI/routes using explicit imports.
Use AppText(context.tr(LocaleKeys.someText)) for translated UI labels.
Add real translation keys for new labels. Do not create test cases.
Run code generation, analysis,
and generator verification if the brick changes. Report results and limitations.
```
