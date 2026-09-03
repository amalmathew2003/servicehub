import 'package:service_hub/features/auth/domain/entities/user_entity.dart';
import 'package:service_hub/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository repository;
  RegisterUsecase(this.repository);
  Future<UserEntity> call({
    required String name,
    required String email,
    required String password,
  }) {
    return repository.register(name: name, email: email, password: password);
  }
}
