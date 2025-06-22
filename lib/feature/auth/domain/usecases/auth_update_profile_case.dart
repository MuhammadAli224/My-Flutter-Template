import '../../../../global_imports.dart';

class AuthUpdateProfileCase {
  final AuthRepository repository;

  AuthUpdateProfileCase(this.repository);

  Future<Either<Failure, AuthEntity>> call(CancelToken cancelToken) {
    return repository.updateProfile(cancelToken);
  }
}
