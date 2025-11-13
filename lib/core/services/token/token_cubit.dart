import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_cubit.freezed.dart';
part 'token_state.dart';

class TokenCubit extends Cubit<TokenState> {
  final FlutterSecureStorage _storage;
  static const _tokenKey = 'access_token';

  TokenCubit(this._storage) : super(const TokenState.initial()) {
    _loadToken();
  }

  Future<void> _loadToken() async {
    final token = await _storage.read(key: _tokenKey);
    if (token != null) emit(TokenState.loaded(token));
  }

  Future<void> saveToken(String token, {bool rememberMe = true}) async {
    if (rememberMe) {
      await _storage.write(key: _tokenKey, value: token);
    }
    emit(TokenState.loaded(token));
  }

  Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
    emit(const TokenState.initial());
  }

  String? get currentToken =>
      state.maybeWhen(loaded: (token) => token, orElse: () => null);
}
