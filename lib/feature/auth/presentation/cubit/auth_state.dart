part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;

  const factory AuthState.loading() = AuthLoading;

  const factory AuthState.loaded(AuthEntity user, String message) = AuthLoaded;

  const factory AuthState.error({required String message, String? title}) =
      AuthError;
}
