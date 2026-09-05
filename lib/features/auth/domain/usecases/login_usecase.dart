import 'package:dartz/dartz.dart';
import 'package:service_hub/core/error/failures.dart';
import 'package:service_hub/features/auth/domain/entities/user_entity.dart';
import 'package:service_hub/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;
  LoginUsecase(this.repository);

  Future<Either<Failures,UserEntity>> call({required String email, required String password}) {
    return repository.login(email: email, password: password);
  }
}
