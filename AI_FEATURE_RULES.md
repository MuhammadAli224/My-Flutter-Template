# Additional Strict Rules (MUST FOLLOW)

These rules are mandatory for all AI-generated code.

---

## UI Rules

- NEVER create large widgets inside one file
- Each reusable widget MUST be in a separate file
- Widgets must be small, reusable, and clean

Example:
❌ Wrong: Page + all widgets in same file  
✅ Correct: Each widget in its own file

---

## Spacing Rules

- ALWAYS use gap extension for spacing
- DO NOT use SizedBox directly for spacing

Example:
❌ SizedBox(height: 10)
✅ 10.gap

---

## Text & Localization

- NEVER hardcode text in UI
- ALWAYS use localization

Example:
❌ Text("Hello")
✅ Text(LocaleKeys.hello.tr())

---

## Models Rules

- ALL models must use Freezed
- NEVER use Map<String, dynamic> directly in UI or state

---

## DTO & Local Cache Rules

- DTOs MUST support Hive for caching

Required:
- @HiveType
- @HiveField

- Local caching must be handled via:
  core/services/hive.service.dart

- DO NOT open Hive boxes randomly
- ALWAYS use centralized Hive service

---

## Architecture Rules

- UI → Cubit → UseCase → Repository ONLY
- NEVER skip layers
- NEVER call repository directly from UI
- NEVER call API inside Cubit

---

## Widget Design Rules

- Follow existing design system (AppColor, AppTextStyle)
- Reuse shared widgets from core/
- DO NOT duplicate UI components

---

## Performance Rules

- Avoid unnecessary rebuilds
- Use const constructors where possible
- Split widgets for better performance

---

## Code Cleanliness

- Remove unused imports
- Keep functions small
- Use meaningful names
- Follow existing naming conventions

---

## Feature Consistency

- Follow EXACT same structure as existing features
- DO NOT invent new architecture patterns
- ALWAYS match project style

---

## Important

If any rule conflicts:
→ Follow project rules over general Flutter practices