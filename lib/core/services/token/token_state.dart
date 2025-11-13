part of 'token_cubit.dart';

@freezed
class TokenState with _$TokenState {
  const factory TokenState.initial() = _Initial;
  const factory TokenState.loaded(String token) = _Loaded;
}
