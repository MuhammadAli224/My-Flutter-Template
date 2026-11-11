# Creating a feature

Provide a feature name, endpoint contract, cache requirement, and screen behavior.
Follow [the generator guide](codex_ai_system/README.md).

After generation, explicitly import its DI function into the composition root and
register its page in GoRouter when a screen is requested. Do not export data types
or entire features through `global_imports.dart`.
