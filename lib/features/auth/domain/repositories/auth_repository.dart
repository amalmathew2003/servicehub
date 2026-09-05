import 'package:dartz/dartz.dart';
import 'package:service_hub/core/error/failures.dart';
import 'package:service_hub/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failures, UserEntity>> login({
    required String email,
    required String password,
  });
  Future<Either<Failures, UserEntity>> register({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failures, UserEntity>> createUSerprofile({
    required String uid,
    required String name,
    required String email,
  });

  Future<Either<Failures, UserEntity>> getUserProfile({required String uid});

  Future<void> logout();
  Stream<UserEntity?> get authStateChanges;
}
