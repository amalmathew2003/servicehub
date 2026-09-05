import 'package:dartz/dartz.dart';
import 'package:service_hub/core/error/exceptions.dart';
import 'package:service_hub/core/error/failures.dart';
import 'package:service_hub/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:service_hub/features/auth/data/datasources/firebase_user_datasoure.dart';
import 'package:service_hub/features/auth/data/models/user_model.dart';
import 'package:service_hub/features/auth/domain/entities/user_entity.dart';
import 'package:service_hub/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDatasource datasource;
  final FirebaseUserDatasoure firestoreDatasource;
  AuthRepositoryImpl(this.datasource, this.firestoreDatasource);
  @override
  Future<Either<Failures, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await datasource.login(email: email, password: password);
      return Right(user);
    } on InvalidCredentialsException {
      return const Left(InvalidCredentialsFailure());
    }
  }

  @override
  Future<Either<Failures, UserEntity>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await datasource.register(
        name: name,
        email: email,
        password: password,
      );

      final result = await createUSerprofile(
        uid: user.id,
        name: user.name,
        email: user.email,
      );
      return result;
    } on WeekPasswordExecption {
      return const Left(WeakPasswordFailure());
    } on NetworkException {
      return const Left(NetworkFailure());
    } on ServerException {
      return const Left(ServerFailure());
    } on Exception {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<void> logout() {
    return datasource.logout();
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    return datasource.authStateChanges.map((user) {
      if (user == null) {
        return null;
      }
      return UserModel.fromFirebaseUser(
        id: user.uid,
        email: user.email ?? "",
        name: user.displayName,
      );
    });
  }

  @override
  Future<Either<Failures, UserEntity>> createUSerprofile({
    required String uid,
    required String name,
    required String email,
  }) async {
    try {
      await firestoreDatasource.createUserProfile(
        uid: uid,
        name: name,
        email: email,
      );
      return Right(UserModel(id: uid, name: name, email: email));
    } on FirestoreException catch (e) {
      return Left(FirestoreFailure(e.message));
    } on Exception {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failures, UserEntity>> getUserProfile({
    required String uid,
  }) async {
    try {
      final user = await firestoreDatasource.getUserProfile(uid: uid);
      return Right(user);
    } on FirestoreException catch (e) {
      return Left(FirestoreFailure(e.message));
    } on Exception {
      return const Left(UnknownFailure());
    }
  }
}
