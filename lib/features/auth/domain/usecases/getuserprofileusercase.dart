import 'package:dartz/dartz.dart';
import 'package:service_hub/core/error/failures.dart';
import 'package:service_hub/features/auth/domain/entities/user_entity.dart';
import 'package:service_hub/features/auth/domain/repositories/auth_repository.dart';

class Getuserprofileusercase {
  final AuthRepository repository;
  Getuserprofileusercase(this.repository);

  Future<Either<Failures, UserEntity>> call({required String uid}) {
    return repository.getUserProfile(uid: uid);
  }
}
