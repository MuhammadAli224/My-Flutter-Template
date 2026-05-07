# New Feature Prompt

```md
Follow AI_CONTEXT.md and codex_ai_system rules strictly.

Task:
Create a new feature: [feature name]

Feature requirements:
- [requirement 1]
- [requirement 2]
- [requirement 3]

Architecture rules:
- Use Feature-First Clean Architecture.
- Use Cubit.
- Use Freezed for DTO, Entity, and State.
- Use AutoMappr for DTO ↔ Entity mapping.
- UI must use Entities only.
- Cubit must call UseCase only.
- RepositoryImpl handles mapping and cache logic.

UI rules:
- Create every new widget in a separate file.
- Use gap extension for spacing.
- Do not hardcode text; use localization keys.
- Use existing AppColor/AppTextStyle/shared widgets.

Cache rules:
- If local cache is needed, use Hive annotations in DTO.
- Register/open Hive boxes only in core/services/hive.service.dart.
- Do not open Hive boxes directly inside feature files.

Before finishing:
- List all files created/changed.
- List translation keys needed.
- List build_runner command if needed.
- Mention Hive typeId/adapter changes if added.
```
