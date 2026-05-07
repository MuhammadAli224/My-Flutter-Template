# Architecture Rules

Required flow:

```txt
UI → Cubit → UseCase → Repository Interface → RepositoryImpl → Datasource → API / Cache
```

## Mandatory rules

- Features must be created under `lib/feature/`.
- Follow the existing feature structure exactly.
- UI must never call APIs directly.
- UI must never call repositories directly.
- Cubits must call UseCases only.
- UseCases must call Repository interfaces only.
- RepositoryImpl handles datasource coordination and mapping.
- DTOs must never reach the UI layer.
- Entities are the only models allowed in UI/state.
- Shared logic belongs in `lib/core/`.
- Do not invent new architecture patterns.
