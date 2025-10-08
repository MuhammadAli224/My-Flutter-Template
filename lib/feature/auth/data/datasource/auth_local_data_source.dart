
import '../../../../global_imports.dart';

abstract class AuthLocalDataSource {
  Future<String?> getToken();

  Future<void> saveToken(String token);

  Future<void> deleteToken();

  Future<AuthUserModel?> getUser();

  Future<void> saveUser(AuthUserModel user);

  Future<void> deleteUser();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final FlutterSecureStorage _secureStorage;
  final Box<AuthUserModel> _box;

  AuthLocalDataSourceImpl({
    required FlutterSecureStorage secureStorage,
    required Box<AuthUserModel> box,
  })  : _secureStorage = secureStorage,
        _box = box;

  @override
  Future<String?> getToken() async {
    final token = await _secureStorage.read(key: BoxKey.token);
    return token;
  }

  @override
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: BoxKey.token, value: token);
  }

  @override
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: BoxKey.token);
  }

  @override
  Future<void> deleteUser() async {
    await _box.delete(_box.keys.first);
  }

  @override
  Future<AuthUserModel?> getUser() async {
    final user = _box.get(_box.keys.first);
    return user;
  }

  @override
  Future<void> saveUser(AuthUserModel user) async {
    await _box.put(user.id, user);
  }
}
