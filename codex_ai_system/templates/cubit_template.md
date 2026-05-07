# Cubit Template

```dart
class {Name}Cubit extends Cubit<{Name}State> {
  {Name}Cubit(this._useCase) : super(const {Name}State.initial());

  final {Name}UseCase _useCase;

  Future<void> fetch() async {
    emit(const {Name}State.loading());

    final result = await _useCase();

    result.fold(
      (failure) => emit({Name}State.error(failure.message)),
      (response) => emit({Name}State.loaded(response.data)),
    );
  }
}
```

Rules:

- Cubit calls UseCase only.
- State contains Entity, not DTO.
- Use existing lifecycle/safeEmit mixins if available.
