# Architecture examples

The executable example is the [Mason brick](bricks/feature/__brick__/).
Generate it with and without caching using [the generator guide](codex_ai_system/README.md).

Generated UI uses AppText(context.tr(LocaleKeys.common_save)) for translated labels
and AppText(value) for user/API content. The generator verifier builds and analyzes
both cache variants without generating or running tests.
