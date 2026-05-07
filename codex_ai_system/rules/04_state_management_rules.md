# State Management Rules

The project uses Cubit + Freezed states.

## Cubit rules

- Cubits must call UseCases only.
- Cubits must not call APIs directly.
- Cubits must not access datasources directly.
- Cubits must not contain business-heavy logic.
- Use safe emitting patterns already used in the project.
- Use lifecycle/cancellation mixins if existing feature uses them.

## State rules

- States must use Freezed union/sealed states.
- States should be simple and UI-friendly.
- State should expose Entities, not DTOs.
- Avoid storing raw maps in state.
